Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9033E525944
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbiEMBKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiEMBKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:10:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB52128E4C3
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:10:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i17so6489454pla.10
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMAVuBWEI5+paDRFtjVKtK4hsTH0OtcK4lrB4hxsV9g=;
        b=bEm6VlQi3MRPDtploQ/o6weeH3kLkRK9tWjtec84R6Q0d+KuoXh4aP/yuapdB7SUJt
         j7nrZnUqyAj+XZrFrzrohn1RohKz0pvDXg+VRr94qgtDWUtwnhVWiwBtbhecetzvT+Kv
         X6YrgklOioxwcOEu5YN4nEOdssVIWyEcGnwXj1YPl1zjW3i57NXrcVD7ckhA9y4JxNMO
         g1FRxVc/vLWLauakOOlLxBkmIJftXmc5dpCPiXXo4VL7Mwd8O/XKJlNVxtueJUjInhrU
         VMW7CBl9sBCpG9fFWnPvQq7two0vrLsuKTUVsKdYP25kivMBYI2zAF+qASZpoitRlMrw
         oX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMAVuBWEI5+paDRFtjVKtK4hsTH0OtcK4lrB4hxsV9g=;
        b=bl1JM+hZrwG+cG290luKHeT0GyUhx/JX+6abnFEdshGWQoy3MWmg+X+HIRBT0tHkcy
         GiLwKF1tr97/YtF6viM/QWF383p0QbRX37rDh6L12dvNajkZ0tgeKDonrlbPIuovUn/C
         m3+jQv76x95dJ2WUqrl8SuyGcUcNL8otXgrkW5+Qe+TfL5kLsudjYPW3lh/Ofsd76YFX
         VbPo4NABO6ippqIz5d3Mo2Fiad+JwaRIXuyNg9RvyGCCbK9Hw7yLXPYrdYS8wQqiB2QJ
         UnWo071f0dZ8InCkWSeHV9kb018bvLz65HMOtwYGlFYefngs+h/qguralypIg/U5qyKd
         wSHA==
X-Gm-Message-State: AOAM5334OouZmgLdZqzmg45kF+BVimZBRQ2GykA2TK5/aVHeJ+t4qkrw
        jdROFbjIL1wMZHEeJYzyzl3Hj6UKo84=
X-Google-Smtp-Source: ABdhPJysQ7pvz4Mnq6N2prhB2UsKrxCcFe3KQjnsYu/mYekhuCU/Mt0OzDMv5ZpLl+oOkP+3KnmyuA==
X-Received: by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id j8-20020a170903024800b00155ecb7dfafmr2442859plh.84.1652404231391;
        Thu, 12 May 2022 18:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0015e9d4a5d27sm545392pla.23.2022.05.12.18.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 May 2022 18:10:31 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check combination of jit blinding and pointers to bpf subprogs.
Date:   Thu, 12 May 2022 18:10:25 -0700
Message-Id: <20220513011025.13344-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
References: <20220513011025.13344-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Check that ld_imm64 with src_reg=1 (aka BPF_PSEUDO_FUNC) works
with jit_blinding.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_subprogs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_subprogs.c b/tools/testing/selftests/bpf/progs/test_subprogs.c
index b7c37ca09544..f8e9256cf18d 100644
--- a/tools/testing/selftests/bpf/progs/test_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/test_subprogs.c
@@ -89,6 +89,11 @@ int prog2(void *ctx)
 	return 0;
 }
 
+static int empty_callback(__u32 index, void *data)
+{
+	return 0;
+}
+
 /* prog3 has the same section name as prog1 */
 SEC("raw_tp/sys_enter")
 int prog3(void *ctx)
@@ -98,6 +103,9 @@ int prog3(void *ctx)
 	if (!BPF_CORE_READ(t, pid) || !get_task_tgid((uintptr_t)t))
 		return 1;
 
+	/* test that ld_imm64 with BPF_PSEUDO_FUNC doesn't get blinded */
+	bpf_loop(1, empty_callback, NULL, 0);
+
 	res3 = sub3(5) + 6; /* (5 + 3 + (4 + 1)) + 6 = 19 */
 	return 0;
 }
-- 
2.30.2

