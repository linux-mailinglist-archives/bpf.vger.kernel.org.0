Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B16DA895
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 07:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjDGFoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Apr 2023 01:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGFog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Apr 2023 01:44:36 -0400
X-Greylist: delayed 11233 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 22:44:31 PDT
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388386A6
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 22:44:30 -0700 (PDT)
X-QQ-mid: bizesmtp80t1680846169teip9h3s
Received: from localhost.localdomain ( [110.191.179.216])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Apr 2023 13:42:48 +0800 (CST)
X-QQ-SSF: 01400000002000H0X000B00A0000000
X-QQ-FEAT: C1K00KuhMxVgnlV6DxxmstO7373kIoVwoZBkAWEzLbfCA+gpKOb0lzm1gfSas
        uW4c4i1yigLH6WD8GRDssEjVDcbItXdyCmEuMY/tb1d5gAc3Is8VLgQ3xXXeCfyNc43wX3s
        Byc9s/B9hnQ+rnyyxZqz5xP8ki3QP6AsTnsqBfXvHDrxZ0lg2vivexElywp/bJXTgftfbug
        y64uIrp1oyWeceT9VjUC31QHt+98azER3rF2yxU5Aepy8QbxKPFXMp3MbxUG4d0TVeX7J9n
        38LdS6ChuZ9VI3WvzJ/zICCDNKuQdc3d05LaCKGBxLiBYj+1EtYlaR6HQHD9VNnim4Wq+Rg
        15b/3WMAECWfS6XQIADoKhSVPJ0kcl4auJUg3MMqMpyFghhf14LL9iKam2gjmCDKNEnsUKF
        V7fBCjp3ifI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1554328695493652309
From:   zhongjun@uniontech.com
To:     bpf@vger.kernel.org
Cc:     zhongjun <zhongjun@uniontech.com>
Subject: [PATCH] BPF: properly precedence of exclusive attr flags
Date:   Fri,  7 Apr 2023 13:42:35 +0800
Message-Id: <20230407054235.31726-1-zhongjun@uniontech.com>
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

BPF_F_STRICT_ALIGNMENT and BPF_F_ANY_ALIGNMENT are exclusive
flags. Intuitively the strict one should take higher precedence.
Applying this patch, make semantics of flags more properly.

Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
base-commit: 919e659ed12568b5b8ba6c2ffdd82d8d31fc28af
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..ed912c0cedee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17710,11 +17710,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 		goto skip_full_check;
 	}
 
-	env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
-	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
-		env->strict_alignment = true;
+	env->strict_alignment = !IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS);
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment = false;
+	env->strict_alignment |= !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks();
 	env->allow_uninit_stack = bpf_allow_uninit_stack();
-- 
2.20.1

