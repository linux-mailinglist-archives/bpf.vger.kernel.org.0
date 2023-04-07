Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BA6DA915
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 08:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDGGsx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGGsw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 02:48:52 -0400
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E496E94
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 23:48:49 -0700 (PDT)
X-QQ-mid: bizesmtp82t1680850123tana6u2i
Received: from localhost.localdomain ( [110.191.179.216])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Apr 2023 14:48:42 +0800 (CST)
X-QQ-SSF: 01400000002000H0X000B00A0000000
X-QQ-FEAT: xwvWJGGFd7NKMoWG4tdGr1TguurVTmCIXtMbLOMmnxTVO0nEITuhns6QDve1O
        5cJ1u3jzEK/2sx6Y7fRyoeuOLjjGl8ZYNVB0BO86luas2x8w+YXDytigSVM63Ek2NRlhlae
        nbiLRorKUtrjKBe9YABnLkpz/KwjfKYU1isbn2poCjfBHgE0I+T88epTQnvQL87Gd9TyjAj
        pZUVAU4aUswZJp0dTt8NZUO3bwr6L7KCAmX2Ut5xQ9cRwyj4MzpVv6R6A2nJ2tcab97UAGj
        kFakuGwvdlob5gkQJzri3au1MbNyQ5HXTKetGMiXkhARj4ra4ztLlXK5rtGSlFQ/t1m+eM9
        zEr3OJ8cktjDzFNysnTVVf+WDMWqKWpcBuHa7FHcEdYxvL1wBRy9ttA1zplPF6nd8Hc4GpB
        Q/diWhntWZg=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1290158706277088579
From:   zhongjun@uniontech.com
To:     bpf@vger.kernel.org
Cc:     zhongjun <zhongjun@uniontech.com>
Subject: [PATCH] BPF: replace no-need function call with saved value
Date:   Fri,  7 Apr 2023 14:48:37 +0800
Message-Id: <20230407064837.32015-1-zhongjun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: zhongjun <zhongjun@uniontech.com>

The var 'is_priv' is already there, needn't call bpf_capable()
again.
Applying this patch, to refine the codes making it robust and optimal.

Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
base-commit: 919e659ed12568b5b8ba6c2ffdd82d8d31fc28af
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..bee9f29155b0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17720,7 +17720,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	env->allow_uninit_stack = bpf_allow_uninit_stack();
 	env->bypass_spec_v1 = bpf_bypass_spec_v1();
 	env->bypass_spec_v4 = bpf_bypass_spec_v4();
-	env->bpf_capable = bpf_capable();
+	env->bpf_capable = is_priv;
 	env->rcu_tag_supported = btf_vmlinux &&
 		btf_find_by_name_kind(btf_vmlinux, "rcu", BTF_KIND_TYPE_TAG) > 0;
 
-- 
2.20.1

