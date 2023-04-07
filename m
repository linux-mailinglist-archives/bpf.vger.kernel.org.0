Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1C6DA802
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 05:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjDGDez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 23:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDGDey (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 23:34:54 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A3F9ECB
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 20:34:51 -0700 (PDT)
X-QQ-mid: bizesmtp69t1680838484tkzkcago
Received: from localhost.localdomain ( [110.191.179.216])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Apr 2023 11:34:43 +0800 (CST)
X-QQ-SSF: 01400000000000H0X000000A0000000
X-QQ-FEAT: iDzLjIm7mlbckeejeb4AtnC8LRKmy5A1q+Ksy7J24PpBry6w8Xd/M+S9DQkuy
        0+4rSduA6qVtljE6lvbsYRDP23vmTikoV1Dux/aZbe99ZImL1EUgmWKVj0IUzYxNbi0g9mo
        21J1tK/PT+5QM+FGUKvQOEMl0HYGfmPANc/KqZ2l73IQwLippFo+56RIy0kxtN0LmsbY2mM
        xp6fzMuQ+AGinJqCDKn8PW9ry0gYpX9+Jy8B1RX2S9KZPOzXcW5K89L1SjVenEn3SRyLgBJ
        ty9KK9iEfEXyd1Ktb1k4X2fQTVfvPhqFy/6oF3u6aqBgE4z7sGSWPeHH/fP0uByTXUdIicY
        VXrcPrxmTxRCh1jyQSOCdzmsgwYHmYK3CPYKqNdv9qcWJUekUhDKY3uzIGdFEP8Cevp/pBy
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6385224584075172696
From:   zhongjun@uniontech.com
To:     bpf@vger.kernel.org
Cc:     zhongjun <zhongjun@uniontech.com>
Subject: [PATCH] BPF: replace low-entropy member with macro
Date:   Fri,  7 Apr 2023 11:34:18 +0800
Message-Id: <20230407033418.2295-1-zhongjun@uniontech.com>
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

The member orig_idx is a low-entropy once-init invariable data
member. It can be replace by a series of macros.
Replace this member by macros can save memory and cpu-time.

Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
base-commit: 919e659ed12568b5b8ba6c2ffdd82d8d31fc28af
---
 include/linux/bpf_verifier.h | 3 ++-
 kernel/bpf/verifier.c        | 6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cf1bb1cf4a7b..8783d90a21bb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -451,11 +451,12 @@ struct bpf_insn_aux_data {
 	u8 alu_state; /* used in combination with alu_limit */
 
 	/* below fields are initialized once */
-	unsigned int orig_idx; /* original instruction index */
 	bool prune_point;
 	bool jmp_point;
 };
 
+#define ORIG_IDX_BY_OFF(head, off)	(off)
+
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
 #define MAX_USED_BTFS 64 /* max number of BTFs accessed by one BPF program */
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..e2545cd128d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15428,7 +15428,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 		if (PTR_ERR(new_prog) == -ERANGE)
 			verbose(env,
 				"insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[off].orig_idx);
+				ORIG_IDX_BY_OFF(env->insn_aux_data, off));
 		vfree(new_data);
 		return NULL;
 	}
@@ -17652,7 +17652,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	struct bpf_verifier_log *log;
-	int i, len, ret = -EINVAL;
+	int len, ret = -EINVAL;
 	bool is_priv;
 
 	/* no program is valid */
@@ -17673,8 +17673,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto err_free_env;
-	for (i = 0; i < len; i++)
-		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
-- 
2.20.1

