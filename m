Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A369B6CF1C2
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 20:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjC2SIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjC2SII (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 14:08:08 -0400
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBC4229
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:06 -0700 (PDT)
Received: by mail-ed1-x564.google.com with SMTP id w9so66832492edc.3
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680113285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4tucP9Q9FV6sU4BIjvtlK70WE+DVbPqhpqoYAULqHo=;
        b=X++xilXrfsolAEeAEWD8InjkTe+RrpkihRhi6UrAZ6Zwm/aL2viz+zwojEU9LnkYqq
         ryjfDqEM8u0cczzchazAh6dGcIe+AWz76Vpig6TK44rTT0IW7R0qMIHg7f/ZX+4Wj78i
         h6+P96MSSqcfY550wsQZ3fzJYgb2BwXJj86W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680113285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4tucP9Q9FV6sU4BIjvtlK70WE+DVbPqhpqoYAULqHo=;
        b=gfZQiSndnfXyG9mgK3jIwOEhseNIncv3cpa6kpNNsCwSZzBRVqc5TSnqu0dHTz10X5
         QKdFtQIoCYTOiNvKzUtNfW4y5y0tQs/WC4243R769WZmvt9CzjefQx9gsMPj7As2h7zf
         5uEN9BD09zEwncOq74bmxr/VJg+IoWR6k9Rv5FQnezZ4xOeDazFEqZQgOPvMz9SJjjgF
         Gi/BiVjefyivc2SS4punwoUs5eOO2uvtd2blPmhwAdhhvql7xeVbo9t+y6LoEDRe/4Ha
         UXgkOLGvDXdI4jQlJLUOmeSRj0nNQB/F193f5lgoDJx7HVqQZZaIwWLEBeWZUDVQis0l
         pRAA==
X-Gm-Message-State: AAQBX9eSd6cV6EfXdXKkE4P5NJSNjsq5uCQ+ElM0IPp2WmqXhB+oG7ka
        nvnRbL9rrXkbSmcNgPtxGgcdIfdHFBJOcgyT/aUIo+u0nERZ
X-Google-Smtp-Source: AKy350YdMPM2CK+luf9WqRlx44zCAom7BCSezfWowFXLrio8cNSqf7Xmc5ri2icJ3h+cMwrUzMTnJ+EAMZp/
X-Received: by 2002:a17:907:2175:b0:920:7a99:dcd4 with SMTP id rl21-20020a170907217500b009207a99dcd4mr21005414ejb.62.1680113284926;
        Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m10-20020a1709066d0a00b00920438f59b3sm12072998ejr.154.2023.03.29.11.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:08:04 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 03/10] selftests: xsk: Add test case for packets at end of UMEM
Date:   Wed, 29 Mar 2023 20:04:55 +0200
Message-Id: <20230329180502.1884307-4-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329180502.1884307-1-kal.conley@dectris.com>
References: <20230329180502.1884307-1-kal.conley@dectris.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test case to testapp_invalid_desc for valid packets at the end of
the UMEM.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 3956f5db84f3..34a1f32fe752 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -1662,6 +1662,8 @@ static void testapp_invalid_desc(struct test_spec *test)
 		{-2, PKT_SIZE, 0, false},
 		/* Packet too large */
 		{0x2000, XSK_UMEM__INVALID_FRAME_SIZE, 0, false},
+		/* Up to end of umem allowed */
+		{umem_size - PKT_SIZE, PKT_SIZE, 0, true},
 		/* After umem ends */
 		{umem_size, PKT_SIZE, 0, false},
 		/* Straddle the end of umem */
@@ -1675,16 +1677,17 @@ static void testapp_invalid_desc(struct test_spec *test)
 
 	if (test->ifobj_tx->umem->unaligned_mode) {
 		/* Crossing a page boundrary allowed */
-		pkts[6].valid = true;
+		pkts[7].valid = true;
 	}
 	if (test->ifobj_tx->umem->frame_size == XSK_UMEM__DEFAULT_FRAME_SIZE / 2) {
 		/* Crossing a 2K frame size boundrary not allowed */
-		pkts[7].valid = false;
+		pkts[8].valid = false;
 	}
 
 	if (test->ifobj_tx->shared_umem) {
 		pkts[4].addr += umem_size;
 		pkts[5].addr += umem_size;
+		pkts[6].addr += umem_size;
 	}
 
 	pkt_stream_generate_custom(test, pkts, ARRAY_SIZE(pkts));
-- 
2.39.2

