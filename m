Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526136DA7BF
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 04:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjDGCia (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 22:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDGCia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 22:38:30 -0400
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C571FEC
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 19:38:23 -0700 (PDT)
X-QQ-mid: bizesmtp73t1680835028tru79yj9
Received: from localhost.localdomain ( [110.191.179.216])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Apr 2023 10:37:06 +0800 (CST)
X-QQ-SSF: 01400000000000H0X000000A0000000
X-QQ-FEAT: i75H2eCteEh7nZH4hSJ8T5c20B5ypGt08koS1WWWUShfUrYWvATI5yteFoT31
        h81rBu32AYjnwmFvnC+X3TwPKjKHyk9JRphN/TKO0H1NRf9UTyy9w+F3MQOCPymFkl/R95I
        D0MTshDinjqt4N6+0hSvISCnct7//sqG3SOHHkO6O9JGqC9/ZtQLqHXAh1orHuJXNTFNKjX
        ZAQqRysph3fmgywtASGMU3HAmEA8XivPD+IGpZY9axGU90iOp6r5ol1JbXOJtNaBfz+ql68
        viiFwRhI4SSbKxUUwmIl8BcRLk3kOL85D0hN42JECLc1SzzcgHVu4Ap3yVB8Uf3EK+7KriC
        bA7ApagD0ypdlnZ0ibsq6RSc3K0/7ErLPM+vUq9RjQuorlN4QSAKOTfA3aC6g==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14019627429615166144
From:   zhongjun@uniontech.com
To:     bpf@vger.kernel.org
Cc:     zhongjun <zhongjun@uniontech.com>
Subject: [PATCH] BPF: remove useless condition check
Date:   Fri,  7 Apr 2023 10:36:50 +0800
Message-Id: <20230407023650.10145-1-zhongjun@uniontech.com>
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

According to contents of 'linux/bpf_types.h', array size of
bpf_verifier_ops will never be ZERO.
Removing useless check to make code more straight and optimal.

Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
base-commit: 738a96c4a8c36950803fdd27e7c30aca92dccefd
---
 kernel/bpf/verifier.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..21047b26dae7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17655,10 +17655,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	int i, len, ret = -EINVAL;
 	bool is_priv;
 
-	/* no program is valid */
-	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
-		return -EINVAL;
-
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
-- 
2.20.1

