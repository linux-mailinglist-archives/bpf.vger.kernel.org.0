Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40D837EF2F
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhELW7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbhELVnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D8C08C5C9
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s22so19260390pgk.6
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WEvYCZOF1nX7y9m6STbMJyJmIcy4ihnjA6JW+Bg91zM=;
        b=gqx3dHdnFINzkJgK3IZAxl/2Y68Trw50dMSFIk4wMhnNsyTdCCZRVjLv2ipjo/x/BG
         eK08GDh9Y7gHSCunPU4HF6U/sgP9B/usBbBIOw8Fl5m3rl+/P55p8sOWPKGFVxC9HnBQ
         wA9d5HVoZQCN3m8H9Ngt+mqJlE/uQGT2p/aWLZM/oCNgCYdT4bHNgdiofh2cGdKOPEAK
         xkkHC0A1jotl6BYy+1dYpi9zoEg8C2uGtTdBkxNEiRX02Nrgr0g2KrwiFo32PN5K/2R7
         tqhfWLEhDzd2NnaZjsZfUlVlJjn0tLM0m3xTtoYZyaBdvTdJMQdOwht5TMWnP556uHmE
         0v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WEvYCZOF1nX7y9m6STbMJyJmIcy4ihnjA6JW+Bg91zM=;
        b=an22o9GGb3v4iIrgHSUTgow0W0AE6PjJemwWhy/3I0I+wrGfqt6IXK/kLjO8kQ/21R
         BFOj/h+Y9IiiMpkHwgpg3FQ3p19+OpcG+SlcyDOOIponr4up2qR0IdFkmTO4KQDNc73U
         j7FPeGzsH8S4XJNQWYbjxU383hORi/oH9PjPi2PURayfPV0sLXgKffinrRfw7Yg2UviD
         R+mOzA9iWiYR3sBsePKooMMTQd1LBelu3t07gJBaLhCfO4EqxOO0vhelPLaccHyxI/g/
         njXHBs5KkT8UyX6kb6xcPFSGMHgrGZOFnxrIOxwQsSwwZQA/ul4y8HS+dyEAhR6quOOn
         2gzA==
X-Gm-Message-State: AOAM532FETILcbsORc0c78n93BrTjqrjteXuO4cp5aVFxOtX7yWTHpYQ
        BGcmPkY8xy/HSP/MtOUaEqs=
X-Google-Smtp-Source: ABdhPJyhUzv0dKQxffHrZJwXbLUqLnLP/CQwgUgo+xCeS/YPc7XPJH6IGIy2WCFqqOu0V3egpBTKpQ==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr534930pjb.11.1620855195360;
        Wed, 12 May 2021 14:33:15 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:14 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 08/21] bpf: Introduce fd_idx
Date:   Wed, 12 May 2021 14:32:43 -0700
Message-Id: <20210512213256.31203-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Typical program loading sequence involves creating bpf maps and applying
map FDs into bpf instructions in various places in the bpf program.
This job is done by libbpf that is using compiler generated ELF relocations
to patch certain instruction after maps are created and BTFs are loaded.
The goal of fd_idx is to allow bpf instructions to stay immutable
after compilation. At load time the libbpf would still create maps as usual,
but it wouldn't need to patch instructions. It would store map_fds into
__u32 fd_array[] and would pass that pointer to sys_bpf(BPF_PROG_LOAD).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h   |  1 +
 include/uapi/linux/bpf.h       | 16 ++++++++----
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          | 47 ++++++++++++++++++++++++++--------
 tools/include/uapi/linux/bpf.h | 16 ++++++++----
 5 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4632aa3ca50..e774ecc1cd1f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -450,6 +450,7 @@ struct bpf_verifier_env {
 	u32 peak_states;
 	/* longest register parentage chain walked for liveness marking */
 	u32 longest_mark_read_walk;
+	bpfptr_t fd_array;
 };
 
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c92648f38144..de58a714ed36 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1098,8 +1098,8 @@ enum bpf_link_type {
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
- * insn[0].src_reg:  BPF_PSEUDO_MAP_FD
- * insn[0].imm:      map fd
+ * insn[0].src_reg:  BPF_PSEUDO_MAP_[FD|IDX]
+ * insn[0].imm:      map fd or fd_idx
  * insn[1].imm:      0
  * insn[0].off:      0
  * insn[1].off:      0
@@ -1107,15 +1107,19 @@ enum bpf_link_type {
  * verifier type:    CONST_PTR_TO_MAP
  */
 #define BPF_PSEUDO_MAP_FD	1
-/* insn[0].src_reg:  BPF_PSEUDO_MAP_VALUE
- * insn[0].imm:      map fd
+#define BPF_PSEUDO_MAP_IDX	5
+
+/* insn[0].src_reg:  BPF_PSEUDO_MAP_[IDX_]VALUE
+ * insn[0].imm:      map fd or fd_idx
  * insn[1].imm:      offset into value
  * insn[0].off:      0
  * insn[1].off:      0
  * ldimm64 rewrite:  address of map[0]+offset
  * verifier type:    PTR_TO_MAP_VALUE
  */
-#define BPF_PSEUDO_MAP_VALUE	2
+#define BPF_PSEUDO_MAP_VALUE		2
+#define BPF_PSEUDO_MAP_IDX_VALUE	6
+
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
  * insn[1].imm:      0
@@ -1315,6 +1319,8 @@ union bpf_attr {
 			/* or valid module BTF object fd or 0 to attach to vmlinux */
 			__u32		attach_btf_obj_fd;
 		};
+		__u32		:32;		/* pad */
+		__aligned_u64	fd_array;	/* array of FDs */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 415865c49dd4..da7dc2406470 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2089,7 +2089,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD attach_prog_fd
+#define	BPF_PROG_LOAD_LAST_FIELD fd_array
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e63c7d60e00d..9189eecb26dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8915,12 +8915,14 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	mark_reg_known_zero(env, regs, insn->dst_reg);
 	dst_reg->map_ptr = map;
 
-	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE) {
+	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
 		if (map_value_has_spin_lock(map))
 			dst_reg->id = ++env->id_gen;
-	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD) {
+	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
+		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
 		dst_reg->type = CONST_PTR_TO_MAP;
 	} else {
 		verbose(env, "bpf verifier is misconfigured\n");
@@ -11173,6 +11175,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			struct bpf_map *map;
 			struct fd f;
 			u64 addr;
+			u32 fd;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -11202,16 +11205,38 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			/* In final convert_pseudo_ld_imm64() step, this is
 			 * converted into regular 64-bit imm load insn.
 			 */
-			if ((insn[0].src_reg != BPF_PSEUDO_MAP_FD &&
-			     insn[0].src_reg != BPF_PSEUDO_MAP_VALUE) ||
-			    (insn[0].src_reg == BPF_PSEUDO_MAP_FD &&
-			     insn[1].imm != 0)) {
-				verbose(env,
-					"unrecognized bpf_ld_imm64 insn\n");
+			switch (insn[0].src_reg) {
+			case BPF_PSEUDO_MAP_VALUE:
+			case BPF_PSEUDO_MAP_IDX_VALUE:
+				break;
+			case BPF_PSEUDO_MAP_FD:
+			case BPF_PSEUDO_MAP_IDX:
+				if (insn[1].imm == 0)
+					break;
+				fallthrough;
+			default:
+				verbose(env, "unrecognized bpf_ld_imm64 insn\n");
 				return -EINVAL;
 			}
 
-			f = fdget(insn[0].imm);
+			switch (insn[0].src_reg) {
+			case BPF_PSEUDO_MAP_IDX_VALUE:
+			case BPF_PSEUDO_MAP_IDX:
+				if (bpfptr_is_null(env->fd_array)) {
+					verbose(env, "fd_idx without fd_array is invalid\n");
+					return -EPROTO;
+				}
+				if (copy_from_bpfptr_offset(&fd, env->fd_array,
+							    insn[0].imm * sizeof(fd),
+							    sizeof(fd)))
+					return -EFAULT;
+				break;
+			default:
+				fd = insn[0].imm;
+				break;
+			}
+
+			f = fdget(fd);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
 				verbose(env, "fd %d is not pointing to valid bpf_map\n",
@@ -11226,7 +11251,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			}
 
 			aux = &env->insn_aux_data[i];
-			if (insn->src_reg == BPF_PSEUDO_MAP_FD) {
+			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
+			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
 				addr = (unsigned long)map;
 			} else {
 				u32 off = insn[1].imm;
@@ -13308,6 +13334,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
+	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
 	is_priv = bpf_capable();
 
 	bpf_get_btf_vmlinux();
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c92648f38144..de58a714ed36 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1098,8 +1098,8 @@ enum bpf_link_type {
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
- * insn[0].src_reg:  BPF_PSEUDO_MAP_FD
- * insn[0].imm:      map fd
+ * insn[0].src_reg:  BPF_PSEUDO_MAP_[FD|IDX]
+ * insn[0].imm:      map fd or fd_idx
  * insn[1].imm:      0
  * insn[0].off:      0
  * insn[1].off:      0
@@ -1107,15 +1107,19 @@ enum bpf_link_type {
  * verifier type:    CONST_PTR_TO_MAP
  */
 #define BPF_PSEUDO_MAP_FD	1
-/* insn[0].src_reg:  BPF_PSEUDO_MAP_VALUE
- * insn[0].imm:      map fd
+#define BPF_PSEUDO_MAP_IDX	5
+
+/* insn[0].src_reg:  BPF_PSEUDO_MAP_[IDX_]VALUE
+ * insn[0].imm:      map fd or fd_idx
  * insn[1].imm:      offset into value
  * insn[0].off:      0
  * insn[1].off:      0
  * ldimm64 rewrite:  address of map[0]+offset
  * verifier type:    PTR_TO_MAP_VALUE
  */
-#define BPF_PSEUDO_MAP_VALUE	2
+#define BPF_PSEUDO_MAP_VALUE		2
+#define BPF_PSEUDO_MAP_IDX_VALUE	6
+
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
  * insn[1].imm:      0
@@ -1315,6 +1319,8 @@ union bpf_attr {
 			/* or valid module BTF object fd or 0 to attach to vmlinux */
 			__u32		attach_btf_obj_fd;
 		};
+		__u32		:32;		/* pad */
+		__aligned_u64	fd_array;	/* array of FDs */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.30.2

