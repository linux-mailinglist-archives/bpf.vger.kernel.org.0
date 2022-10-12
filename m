Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974065FCEDB
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 01:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJLXUk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 19:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJLXUg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 19:20:36 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A2412C8AD;
        Wed, 12 Oct 2022 16:20:33 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id de14so277956qvb.5;
        Wed, 12 Oct 2022 16:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RI+uFM46qF/V3OLGAUZkNuVPUk2lR5v43Hgy7iN+90=;
        b=DUwkiUstHOFr1bFFLSdFHoz4CCOxIKKu/kpOklCyBCwSjNgYPwQhCfX3RpxzCIJSpi
         WBpLZBdKqLWKcQNkI5ePxT2n1rw9oF+xTVohGwIfHB7p0iBx5+ws9BvcrIGn7fW8Jc2g
         k5HVZpN3G7VjPAXtJELpGe/NJieGFjHevdzZMh4gUr+GjOJaI9lp4XNCT94DZRi/7yNN
         yNj56v5+sM3EE33zvhM+nwukv/mLhwRJmKNmdSmn2knaMMaT2fMRTTwkr4XqnoAUtmvz
         M/3Drkw/imh57TFYjy7FZxD4uMudnBLD/QFrlp9rwgrhgcUZfa1hUrr4EFyNVS1OHoUM
         tFjA==
X-Gm-Message-State: ACrzQf32znjon7w2Ll8BSmMZdgyUo95KFSBwG30jX9nbUpARWdayDTEH
        kk+mZbnEUxqzmjLP2XlgeszglpZmid0UpA==
X-Google-Smtp-Source: AMsMyM7TRUZ7Cy1Fykzqh6Qox21zRu2D42eDG4tegWq+D6ercUhHdQDQbXIUA7DDKLnOetqsyMIv8A==
X-Received: by 2002:a05:6214:2a8e:b0:4b1:c79e:d58 with SMTP id jr14-20020a0562142a8e00b004b1c79e0d58mr25392643qvb.113.1665616832574;
        Wed, 12 Oct 2022 16:20:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1a0b])
        by smtp.gmail.com with ESMTPSA id t12-20020a37aa0c000000b006eeb25369e9sm894730qke.25.2022.10.12.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 16:20:32 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] selftests/bpf: Make bpf_user_ringbuf_drain() selftest callback return 1
Date:   Wed, 12 Oct 2022 18:20:15 -0500
Message-Id: <20221012232015.1510043-3-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221012232015.1510043-1-void@manifault.com>
References: <20221012232015.1510043-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 1bfe26fb0827 ("bpf: Add verifier support for custom callback
return range"), the verifier was updated to require callbacks to BPF
helpers to explicitly specify the range of values that can be returned.
bpf_user_ringbuf_drain() was merged after this in commit 205715673844
("bpf: Add bpf_user_ringbuf_drain() helper"), and this change in default
behavior was missed. This patch updates the BPF_MAP_TYPE_USER_RINGBUF
selftests to also return 1 from a bpf_user_ringbuf_drain() callback so
as to properly test this going forward.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/progs/user_ringbuf_success.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
index 099c23d9aa21..b39093dd5715 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
@@ -47,14 +47,14 @@ record_sample(struct bpf_dynptr *dynptr, void *context)
 		if (status) {
 			bpf_printk("bpf_dynptr_read() failed: %d\n", status);
 			err = 1;
-			return 0;
+			return 1;
 		}
 	} else {
 		sample = bpf_dynptr_data(dynptr, 0, sizeof(*sample));
 		if (!sample) {
 			bpf_printk("Unexpectedly failed to get sample\n");
 			err = 2;
-			return 0;
+			return 1;
 		}
 		stack_sample = *sample;
 	}
-- 
2.38.0

