Return-Path: <bpf+bounces-50222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940A0A24341
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342B03A598D
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A461F37AD;
	Fri, 31 Jan 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQeCjnS1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6671F1316;
	Fri, 31 Jan 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351765; cv=none; b=HlkxfuX0a0vRtY6Ia9ZHe0irS0vAds2Kz8QSwSluSBRwqr+6qqa+kYC7j5OKm1g+TyEfwl3y0SeB6ZJ6XW16SC29EAJzWWvi7LkKi5WxAMA53vQLOQPpVsPlOr5xMLM7fbgQzhB4frBenG9QwyJugJxgTPg8mvuZoas4AoZ7ZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351765; c=relaxed/simple;
	bh=HHGh55qBNDJfyTtks9UxNN5CoO2OyTy41mW6UiHUHOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+8cs3TtObhDH1Yacp4aWsA0bfgfLu+MvyrYnPtY82A63efwKwLHXZiYxquKbDV+wiNQwNtD01KvCr9ofjiDQONCc2uv8DeOcRZ3VdfWUz+gCWSFiQ8BQuGTZTFV32CU8xOMRkb0e4Jw6oXU9gellT3/yKZ3YxJvrCmVPYD9K+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQeCjnS1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so3282626a91.3;
        Fri, 31 Jan 2025 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351763; x=1738956563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEPaZV1umqoPhyWbc+D1akpU5i5CCQxx/9lrNiXUvwY=;
        b=OQeCjnS1/CH2JFdd5zfolzDyyebb5ep6q3I+PSXUckWo2qWVl8BiB0H1q6Tw5ZNK5Y
         u1z8xxvEDI/IwxsKBYVFLiMhwqVb6pO8BRv1H8varkHKr8AKzHJkBk86KzNmfYnfWng6
         rtQStvRZxDpVkP/0EWIG/Uvjb2+O4J7SWdEdA87MWLCU/x6J4JyW+PNrtKmMRH7avDO1
         BLYWPCp442ihkxpfRLzFbJmkuN2mAtoj0gLOk9nyx2inqNc8Jica9Fkh3D/Ip49Q6s9c
         O/Ef5tomf/OcYYCQM491zrLc9Hl1ytlV4n1JSKzrHoxQ2sP7+u/RWdACfipPUhlgCLyg
         0vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351763; x=1738956563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEPaZV1umqoPhyWbc+D1akpU5i5CCQxx/9lrNiXUvwY=;
        b=ndE/8hi3ilYGl8e5JGWAOUINMKmdcEPr6+rTWuwNKxrVkd1tEN5XYiHDsH7ixRcPc+
         U/4mxbF3QdbSDXQUFS8QvOGrlvhdfWSI5h+mDxqBJccWxVvvqQqdCKXPHjdlMT+NIUyg
         s/RSkSxL+KeDMTxqc3VNWQOT47UGW8P2R8KNWdga1mCWY6dQLIw5yUal96kHxmy/J0DX
         sOVvRMuHN5Ukir03xXF8t4VhefSFWvV/y3Qm1fPe2QyV8IApYY54Soobje07s0VqvHQj
         aKkDi9YGSn8rJW8XRxj1nubshaTKIQkv8RMoPukSWVoKKgHxHUgCXW1rCiicmy930I8T
         yGOA==
X-Gm-Message-State: AOJu0YwNTRQOWG1zfby56UjDrMDa6PwykzndqbQp9vCkzFPkY9x/MGot
	4FlDH6fVYtYyfAPvJ97vyl0/T3IPuMuHLYfn+2CqdosXQizeTai8b12SfTY6hJM=
X-Gm-Gg: ASbGnctN5cVznRk5y0rFZiIw/OFh7PSnvC1bz6jtUfLtuoH4gM1UIV397/PJEwY4MIf
	6C1cEAxKFgfpnJTLsBlESGvUSs9S1sPZtmsD8ufGfTB/ajDmHP9QhmhRGM3Uey2r99XpDGfzbWm
	AM+Q5wo/liSKLQ+gpqpS1Gvk1mOOqLDq39BusQC6BtMSKgvbVM1TAG5mQQXHLCP9CR8hkzVl+YS
	Kq6A5Qg/qemKoy2bMt/Tdl44DxDnPFUeyh1A8m8fXF6DFhn2abat7w867cj1rIlM51X/bQQnvjb
	M1X4HY4+Gn60zmFKXwZT/vDz7CLvZC83us6Q7oF5t1EfW1vNzjEaReFNKyBTAWgZgA==
X-Google-Smtp-Source: AGHT+IHk9/VYv/sdDhW2qzX0iEWN6upUJyUWKgytAV9sZ+8oQ/3t7aPgONPSmsiqmHfRGh5SUwJvMg==
X-Received: by 2002:a17:90b:4ec8:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2f83abea7c9mr18137238a91.13.1738351763030;
        Fri, 31 Jan 2025 11:29:23 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:22 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/18] bpf: Make every prog keep a copy of ctx_arg_info
Date: Fri, 31 Jan 2025 11:28:40 -0800
Message-ID: <20250131192912.133796-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ctx_arg_info is read-only in the view of the verifier since
it is shared among programs of the same attach type. Make each program
have their own copy of ctx_arg_info so that we can use it to store
program specific information.

In the next patch where we support acquiring a referenced kptr through a
struct_ops argument tagged with "__ref", ctx_arg_info->ref_obj_id will
be used to store the unique reference object id of the argument. This
avoids creating a requirement in the verifier that "__ref" tagged
arguments must be the first set of references acquired [0].

[0] https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.com/

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/bpf_iter.c | 13 ++++++-------
 kernel/bpf/verifier.c | 25 +++++++++++++++----------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..f4df39e8c735 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1507,7 +1507,7 @@ struct bpf_prog_aux {
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
 	struct btf *attach_btf;
-	const struct bpf_ctx_arg_aux *ctx_arg_info;
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
@@ -1945,6 +1945,9 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt);
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 				    int cgroup_atype);
@@ -2546,7 +2549,7 @@ struct bpf_iter__bpf_map_elem {
 
 int bpf_iter_reg_target(const struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const struct bpf_iter_reg *reg_info);
-bool bpf_iter_prog_supported(struct bpf_prog *prog);
+int bpf_iter_prog_supported(struct bpf_prog *prog);
 const struct bpf_func_proto *
 bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 106735145948..380e9a7cac75 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -335,7 +335,7 @@ static void cache_btf_id(struct bpf_iter_target_info *tinfo,
 	tinfo->btf_id = prog->aux->attach_btf_id;
 }
 
-bool bpf_iter_prog_supported(struct bpf_prog *prog)
+int bpf_iter_prog_supported(struct bpf_prog *prog)
 {
 	const char *attach_fname = prog->aux->attach_func_name;
 	struct bpf_iter_target_info *tinfo = NULL, *iter;
@@ -344,7 +344,7 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	int prefix_len = strlen(prefix);
 
 	if (strncmp(attach_fname, prefix, prefix_len))
-		return false;
+		return -EINVAL;
 
 	mutex_lock(&targets_mutex);
 	list_for_each_entry(iter, &targets, list) {
@@ -360,12 +360,11 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	}
 	mutex_unlock(&targets_mutex);
 
-	if (tinfo) {
-		prog->aux->ctx_arg_info_size = tinfo->reg_info->ctx_arg_info_size;
-		prog->aux->ctx_arg_info = tinfo->reg_info->ctx_arg_info;
-	}
+	if (!tinfo)
+		return -EINVAL;
 
-	return tinfo != NULL;
+	return bpf_prog_ctx_arg_info_init(prog, tinfo->reg_info->ctx_arg_info,
+					  tinfo->reg_info->ctx_arg_info_size);
 }
 
 const struct bpf_func_proto *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..a41ba019780f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22377,6 +22377,18 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt)
+{
+	prog->aux->ctx_arg_info = kcalloc(cnt, sizeof(*info), GFP_KERNEL);
+	if (!prog->aux->ctx_arg_info)
+		return -ENOMEM;
+
+	memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);
+	prog->aux->ctx_arg_info_size = cnt;
+	return 0;
+}
+
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
@@ -22457,17 +22469,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
-	/* btf_ctx_access() used this to provide argument type info */
-	prog->aux->ctx_arg_info =
-		st_ops_desc->arg_info[member_idx].info;
-	prog->aux->ctx_arg_info_size =
-		st_ops_desc->arg_info[member_idx].cnt;
-
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return 0;
+	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
+					  st_ops_desc->arg_info[member_idx].cnt);
 }
 #define SECURITY_PREFIX "security_"
 
@@ -22917,9 +22924,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		prog->aux->attach_btf_trace = true;
 		return 0;
 	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
-		if (!bpf_iter_prog_supported(prog))
-			return -EINVAL;
-		return 0;
+		return bpf_iter_prog_supported(prog);
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
-- 
2.47.1


