Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684BB589650
	for <lists+bpf@lfdr.de>; Thu,  4 Aug 2022 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiHDCzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 22:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiHDCzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 22:55:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F371009
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 19:55:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 130so10347406pfv.13
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 19:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnBrhTD/9+F6uSaHAiOyLvcykArUbtnM77SwXNPOOwI=;
        b=OUxmBJ8iXta2JV6KXMSf6vXZggE/Ulxlb17cCdrcx1FsZxENjzmmi81U4WfHCBSuHJ
         jadaCRlzPEgnTEVO2umvDRJWHlscMF9U6TY7I2d9LnaFdZmVypqk0vUomgoeuKT4i97s
         DFSeDTpK6Uhgsw53JTpU4thA30B/le08i7sTx617zk+dcxHoct0k50BFCwmwV4njqNp8
         F3/WTeLrbrYJsFsif5hV9szSkR2SWcCn004G7pxyWfC/wL/JWnfjz3QAz0I9zR92lN78
         QcxwATG05jIsPSNwKKcog6vwZXGcSSSg48inc8KGyV7GhqCDbVgYScMpGC1f++RLi5YI
         hMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnBrhTD/9+F6uSaHAiOyLvcykArUbtnM77SwXNPOOwI=;
        b=HfBbPPZCf69CmmfEze1v83CX/VqB1uYIhx6O246efaXoKvYRKULL0N/VQ10dnh1FHv
         ri94wMzJ3m1rSHfV6bcPyNtz3wBo9bd8phQxpMRZfNSVvRP3S+lKu8dtDYncyNk46rEF
         cRkJ336XMZxkVgSM1fQd8s+XOysgEMCJyoJnGAQWmAD1vdmM5JJqIcL2TFEZ6s9oEtcP
         n5eAoOjAhXF9fbMFFMjHm1cXu90koFIGKj4h+9VFaW9IRAolK6zbb8agd+oaFkek08+8
         s/bQ3aPtycY9K2Wr4sN9IvfDEbDRgZ4XL4SbODOO7j88cM1sltMxR3mNsxlTmWr9KN49
         7LEw==
X-Gm-Message-State: ACgBeo3ZbFHoP89JwK0WF4QNABWzMANe59410IE6MgD8hLFD6MOH230s
        Xc/OEqGaLecY4t8NbaLWgDV5C1WdQVfFIVta
X-Google-Smtp-Source: AA6agR7fgEBYSefDyFI3QpFAj2gEXTkHKfLzx2TEWHFqOTqq05XjaQBQpo4OsxGNVFtlOWDe0AETqg==
X-Received: by 2002:a63:e343:0:b0:41c:d5cd:a39 with SMTP id o3-20020a63e343000000b0041cd5cd0a39mr273928pgj.512.1659581715140;
        Wed, 03 Aug 2022 19:55:15 -0700 (PDT)
Received: from localhost.localdomain ([185.192.68.48])
        by smtp.gmail.com with ESMTPSA id 126-20020a620684000000b0052e6aaed207sm395554pfg.120.2022.08.03.19.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:55:14 -0700 (PDT)
From:   Aijun Sun <aijun.sprd@gmail.com>
X-Google-Original-From: Aijun Sun <aijun.sun@unisoc.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        zlim.lnx@gmail.com
Cc:     bpf@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        Aijun Sun <aijun.sun@unisoc.com>
Subject: [PATCH bpf] bpf, arm64: allocate program buffer using kvcalloc instead of kcalloc
Date:   Thu,  4 Aug 2022 10:54:42 +0800
Message-Id: <20220804025442.22524-1-aijun.sun@unisoc.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is not necessary to allocate contiguous physical memory for BPF
program buffer using kcalloc. When the BPF program is large more than
memory page size, kcalloc allocates multiple memory pages from buddy
system. If the device can not provide sufficient memory, for example
in low-end android devices[1], memory allocation for BPF program is likely
failed.

Test cases in lib/test_bpf.c all pass on ARM64 QEMU.

[1]
AndroidTestSuit: page allocation failure: order:4,
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=foreground,mems_allowed=0
Call trace:
 dump_stack+0xa4/0x114
 warn_alloc+0xf8/0x14c
 __alloc_pages_slowpath+0xac8/0xb14
 __alloc_pages_nodemask+0x194/0x3d0
 kmalloc_order_trace+0x44/0x1e8
 __kmalloc+0x29c/0x66c
 bpf_int_jit_compile+0x17c/0x568
 bpf_prog_select_runtime+0x4c/0x1b0
 bpf_prepare_filter+0x5fc/0x6bc
 bpf_prog_create_from_user+0x118/0x1c0
 seccomp_set_mode_filter+0x1c4/0x7cc
 __do_sys_prctl+0x380/0x1424
 __arm64_sys_prctl+0x20/0x2c
 el0_svc_common+0xc8/0x22c
 el0_svc_handler+0x1c/0x28
 el0_svc+0x8/0x100

Signed-off-by: Aijun Sun <aijun.sun@unisoc.com>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 42f2e9a8616c..80918e60387b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1399,7 +1399,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.prog = prog;
 
-	ctx.offset = kcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
+	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
 	if (ctx.offset == NULL) {
 		prog = orig_prog;
 		goto out_off;
@@ -1499,7 +1499,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			ctx.offset[i] *= AARCH64_INSN_SIZE;
 		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
 out_off:
-		kfree(ctx.offset);
+		kvfree(ctx.offset);
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
-- 
2.29.0

