Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D15FAA07
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJKBZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJKBZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:25:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255813F87
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:24:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 129so11606980pgc.5
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=115SOrbikWzJeLlZTUfuUdcePTGC7XtJ5cWTNi4Xkzo=;
        b=frM4WDi3XW/robwxn+2hTsDG/bavxq8rBNbP4geP3D6O2OyF+kamne9bW4bumQTDLp
         O8QSTwgS5uW7rINowbLiR0OxuLD1OTDw5GR4EBo9UPPYXRdylc61wkoQsqxp3qBeDXv8
         y0HtvJ6uP88J1Bxe/G6aqBI17aRnACjkRBpdxLmOrhjhsMKIPRE3C1iiItegaSlA8tlZ
         c1TG1aHOPd9DqQK/Z+FYsAJHqIY2bkLXj1i90ODlOwJfjoziMDF4jLiGgNtcWDE5kj9t
         8b+8ZcPMQhcIwJGauJbNs5RbhBTz7Y2TbU8ypUCorMmbBUJq/7sO1u4BxI/EQpwjAgt1
         0pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=115SOrbikWzJeLlZTUfuUdcePTGC7XtJ5cWTNi4Xkzo=;
        b=Dr5Gc2ODVGflzBfGV5Nw3dpQiJLLeMN/w7dM97D//6muOPlZxyeBOCCOs7QwqzPXWG
         a0T0aSZOFMkQtS0fSAWqj6kxoh+BtMgITDuxPls/JDJ2uvWVHLEqYUMZPa1VmyXY12KL
         RRrdB7IKImGAEwA2KNU63zZeCNp+WmQKpdfvwSz+dfzyHerfRi5u0zz4qSvlCCUSoOkG
         6D0u0RaKd6RKoSWlBzRS1BpmRzZM3jtulW7s91Q50goyRxaTnpLUPI72ZB4IuOJkNeof
         OE80gq2bhTUTSQ7NO8Qj1hC5egf1i9z7IwYJNI2tL2Iooha5vOZrWxLWDY5F+BffCC7i
         ganA==
X-Gm-Message-State: ACrzQf3mFe7oFN20l8OdSopkCPmQzsUKfoN8cTbZOo50swIduLAx8pGM
        air6idQrTZxev1N5cl9dmixaZzdYjfqRxg==
X-Google-Smtp-Source: AMsMyM43hbJMxYy4DYf5QK5oxRJLJfu5bUcgLJxosZgpbeB299PsXgRSnnuLAnzDgzEJge64+RNbCg==
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id e132-20020a63698a000000b0041c8dfb29cbmr18804149pgc.170.1665451492735;
        Mon, 10 Oct 2022 18:24:52 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id c1-20020a056a00008100b00562657a7b11sm7579253pfj.8.2022.10.10.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:24:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 10/25] bpf: Introduce local kptrs
Date:   Tue, 11 Oct 2022 06:52:25 +0530
Message-Id: <20221011012240.3149-11-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11352; i=memxor@gmail.com; h=from:subject; bh=70MUjIf6wzGa8C9dOIn/vOI9JaVYNB++pe3k461rplw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUaRBJGvwaOdXIKWmkZHcNzsB3jzaM3lt3dUeAW sWkQTlaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8RyrfID/ 4+l5oDXKFm5HZgsjbZHDXy1SrWG1KAR0jY7xT/tC4q19f2fXUQtekco2aPKcwCagVbPxnJ5AYdmV8M oSlSHLFu013e4lNa2G7KLv1hEYMqQQZ9QFUrPVM4DMlcvCwcr8js4Cv2Fa9TUQxftRnmRVQmtOQ5j/ S3WqBP//IIk8203F1xXziiAol8aSkqoB2yRuuxHY1bvWVriEGHwn2jqeStoLUmBUutUQBfOfbzOi5N 49zFh8AyZwDa8tpEa5lxEXrXydjDLoHQ8GdmbgUnKMCvO3Ke3Rg1TRzMM042ToQhEDaoAFEr5xaFQ6 jjhZ+brtpBSuEbuLg3rPdb4dhTQkm5h5UVrKOITuhiRkg1SQm0GX6gcgL+CNDLhRUOSTfhr3SegBvN zxobrNC4QrEy7BnKPeTwuubaX7/0b6ZHObhPpZS6OU9gmy6HLMiiXxAMWMNGFVNz9FIdOUhQKqnZmq KIj8OHNqp/ZBzr1u6NfVir7ZAdJ9OZqDGnrRzzcLUaR6RySw2em2I72JTp/31cSO/KG6klNNFAlUzo 4w1OFBHyU4nLVQKFVPnl6dxgzRkiBVabo0FMsve5tHoix4h8stkVsHQpEbFurFIKxnjwPmLwDuNkRJ 8Zdx20HuGawoQSaSnqHcEc7ZqwaykNAxyvo9kA0UGV8MoA6LLQmCnUa7DXTw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
type tag in reg->type to avoid having to check btf_is_kernel when trying
to match argument types in helpers.

For now, these local kptrs will always be referenced in verifier
context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
to such objects, as long fields that are special are not touched
(support for which will be added in subsequent patches).

No PROBE_MEM handling is hence done since they can never be in an
undefined state, and their lifetime will always be valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h              | 14 +++++++++++---
 include/linux/filter.h           |  4 +++-
 kernel/bpf/btf.c                 |  9 ++++++++-
 kernel/bpf/verifier.c            | 15 ++++++++++-----
 net/bpf/bpf_dummy_struct_ops.c   |  3 ++-
 net/core/filter.c                | 13 ++++++++-----
 net/ipv4/bpf_tcp_ca.c            |  3 ++-
 net/netfilter/nf_conntrack_bpf.c |  1 +
 8 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 46330d871d4e..a2f4d3356cc8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -526,6 +526,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of a type from program BTF, not kernel BTF. This is used to
+	 * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
+	 */
+	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -774,6 +779,7 @@ struct bpf_prog_ops {
 			union bpf_attr __user *uattr);
 };
 
+struct bpf_reg_state;
 struct bpf_verifier_ops {
 	/* return eBPF function prototype for verification */
 	const struct bpf_func_proto *
@@ -795,6 +801,7 @@ struct bpf_verifier_ops {
 				  struct bpf_insn *dst,
 				  struct bpf_prog *prog, u32 *target_size);
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
+				 const struct bpf_reg_state *reg,
 				 const struct btf *btf,
 				 const struct btf_type *t, int off, int size,
 				 enum bpf_access_type atype,
@@ -2076,10 +2083,11 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg, const struct btf *btf,
 		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype,
-		      u32 *next_btf_id, enum bpf_type_flag *flag);
+		      enum bpf_access_type atype, u32 *next_btf_id,
+		      enum bpf_type_flag *flag);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
 			  const struct btf *need_btf, u32 need_type_id,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6e3aed..9b94e24f90b9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -568,7 +568,9 @@ struct sk_filter {
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 extern struct mutex nf_conn_btf_access_lock;
-extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
+extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+				     const struct bpf_reg_state *reg,
+				     const struct btf *btf,
 				     const struct btf_type *t, int off, int size,
 				     enum bpf_access_type atype, u32 *next_btf_id,
 				     enum bpf_type_flag *flag);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dae2182e9c40..526702a264b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6019,11 +6019,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	return -EINVAL;
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg, const struct btf *btf,
 		      const struct btf_type *t, int off, int size,
 		      enum bpf_access_type atype __maybe_unused,
 		      u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	bool local_type = reg && (type_flag(reg->type) & MEM_TYPE_LOCAL);
 	enum bpf_type_flag tmp_flag = 0;
 	int err;
 	u32 id;
@@ -6033,6 +6035,11 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 
 		switch (err) {
 		case WALK_PTR:
+			/* For local types, the destination register cannot
+			 * become a pointer again.
+			 */
+			if (local_type)
+				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c47cecda302..6ee8c06c2080 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4522,16 +4522,20 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access) {
-		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
+	if (env->ops->btf_struct_access && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
+		WARN_ON_ONCE(!btf_is_kernel(reg->btf));
+		ret = env->ops->btf_struct_access(&env->log, reg, reg->btf, t,
 						  off, size, atype, &btf_id, &flag);
 	} else {
-		if (atype != BPF_READ) {
+		if (atype != BPF_READ && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
-		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
+		if (reg->type & MEM_TYPE_LOCAL)
+			WARN_ON_ONCE(!reg->ref_obj_id);
+
+		ret = btf_struct_access(&env->log, reg, reg->btf, t, off, size,
 					atype, &btf_id, &flag);
 	}
 
@@ -4596,7 +4600,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
+	ret = btf_struct_access(&env->log, NULL, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -5816,6 +5820,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadfc5829..d7aa636d90ce 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -156,6 +156,7 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
 }
 
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
+					   const struct bpf_reg_state *reg,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
@@ -177,7 +178,7 @@ static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
 		return -EACCES;
 	}
 
-	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+	err = btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
 				flag);
 	if (err < 0)
 		return err;
diff --git a/net/core/filter.c b/net/core/filter.c
index bb0136e7a8e4..cc7af7be91d9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8647,13 +8647,15 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 DEFINE_MUTEX(nf_conn_btf_access_lock);
 EXPORT_SYMBOL_GPL(nf_conn_btf_access_lock);
 
-int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
+int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+			      const struct bpf_reg_state *reg, const struct btf *btf,
 			      const struct btf_type *t, int off, int size,
 			      enum bpf_access_type atype, u32 *next_btf_id,
 			      enum bpf_type_flag *flag);
 EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
 
 static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
@@ -8663,12 +8665,12 @@ static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
 					 flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
@@ -8734,6 +8736,7 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
 static int xdp_btf_struct_access(struct bpf_verifier_log *log,
+				 const struct bpf_reg_state *reg,
 				 const struct btf *btf,
 				 const struct btf_type *t, int off,
 				 int size, enum bpf_access_type atype,
@@ -8743,12 +8746,12 @@ static int xdp_btf_struct_access(struct bpf_verifier_log *log,
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
 					 flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6da16ae6a962..1fe3935c4260 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -69,6 +69,7 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
 }
 
 static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
 					const struct btf *btf,
 					const struct btf_type *t, int off,
 					int size, enum bpf_access_type atype,
@@ -78,7 +79,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
+		return btf_struct_access(log, reg, btf, t, off, size, atype, next_btf_id,
 					 flag);
 
 	if (t != tcp_sock_type) {
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 8639e7efd0e2..f6036a84484b 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -191,6 +191,7 @@ BTF_ID(struct, nf_conn___init)
 
 /* Check writes into `struct nf_conn` */
 static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
+					   const struct bpf_reg_state *reg,
 					   const struct btf *btf,
 					   const struct btf_type *t, int off,
 					   int size, enum bpf_access_type atype,
-- 
2.34.1

