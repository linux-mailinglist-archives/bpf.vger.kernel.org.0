Return-Path: <bpf+bounces-78110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA87CFF3C9
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C23A931E8125
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D334DB62;
	Wed,  7 Jan 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cu9Wm0NW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F334D934
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796108; cv=none; b=JMcYTcmWnHW7rhQL4ccJVxAIuuhOwh25gMOEBSs6rbjVejdTjtaA6lJ60QdK5KU4FukQxSulZVNgiy7UsutMayqVJKpNwqTiXj2QABPPwuuY0OJAnN61M6Gx/NukbtjI9vXdhNT0TmBfZQ6DxxnxkZj0G+MfXXsvzZudB82LVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796108; c=relaxed/simple;
	bh=8jLr28mW81eduMxBFuApS+s46LC8vRu6Bb9EcO76rSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBY9UtnBaSz72RKzNEIJ3Zj7yG5EzUIlGqeBVD2h+AX7B1Kd68iUmXz8lpf48TMFuRaAHLdYjZsHXN4b/NrrLC/rDmY55a0vLCD4dgSqHfexi5motmHCkGpnNYxYOHytdKbBsNBz3Cu0WOxb9wq8iIgh7PmE4fpGQiR6YsuEgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cu9Wm0NW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8010b8f078so342107766b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796105; x=1768400905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnUfnIj04dl8vJCU6yzAA6cUF3QesPm7omyrc0MrfyY=;
        b=cu9Wm0NWgndJQiaqCeVHZg0BFJRcymdSIf4xT1eOen3dzICfipk+1dm1f8KgpND85L
         A1FOMTLgiq12pse7Z5StlHZbK9OO78OznJE/AFz+a2mg2oGyBB26/tq6tdNFHH0ATwhG
         /7s08x37oD3HRy9AzsPvf6y55N+W+JfreZEH8FJl/lx0zSG8NnHYjDrIxjpjZNP+xw/y
         GEC6yi8HbevA55cZ7L1pT7BvZEsEgyvtPNMhVkycP4itdhxEPYyIfcrDhY9JXdx9rG/O
         2xuuVyFP+qL5W8j0ze2MQriFNAq7lpNJDYwN1N1cPBk9YE7dN+QDh1s8ZCw1YSgSWV/7
         h9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796105; x=1768400905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OnUfnIj04dl8vJCU6yzAA6cUF3QesPm7omyrc0MrfyY=;
        b=qW2K7DWAQtbwv/Obc6O/xWncrXGPt7hEoF2jjmDHuL2PFkP4eOOpDn7PRMEXb2yaeB
         wRDVtrD76LssdZMQUJ3TcR6yVEYv3mDZlf0lZ5iRAUhZEOduQe1yHJxQ1Xti96CznXl7
         MPa9KBuztuaNB93D/M+5x3sP7qhfdVvjztz9r5iF96bDLbV8VRI+pPgUlzzrnRHAyPzF
         6K6gf6+V0IhYGwSaPIBxgH45m/VSinIvYt/4k4JD9V/0hDVcXOyAAy5Iqvt3bjLcK67b
         /C9BynF1MrDbsNfMIltil10AAJJC37hWuW/U5b6YVwK80x3UDrc3abM8AJZ1gNUmyVvR
         VJpA==
X-Gm-Message-State: AOJu0YzoxVQ4rZ+HRdczL24d38uQ/1eM/SBa+nlNH47vjZzvt7oqQJaJ
	isBffUMR8bG9hteVNPoiLxghpTqecWqzbLwSxu6K9d/fW5xwk3kD7kp1vhX9av43MoA=
X-Gm-Gg: AY/fxX4q4NlW2IMB6hFdMMYX+8tq/7bqo5PZhRujXEjIK8YvPPTyzoUz99yKobTg/SP
	RIWBI7MwwTreladCCCACn8Noyofti0bXIgCmWUXvs3gZowE/XIuZmgTKgJPUd98i0yZ0X39GxNq
	5/dnSm5bg/RzORYGZ4467Q7CjKFiY5QctH/IDz98L3CAbxjUjfnPlVkqmXXkFvyKOEE0GIW/Hwt
	T1mc+iaUTNCxN1pruDGerADPB1brLbPq6ImE+Ehj1mNP4msfSxC4tL4F3QA94TqfHjkRbWUQNHR
	Wx2/ViWMZylhkdC0Ynr4CPZbJUMSR01AXaLHu7ELupEIg5MaL1mJW2tsXo0RouLtefxPxw/2pTv
	Y/cKulQNy2yGdNnbS4s+1NZbvK1QRXpWvhwbQ3YRAupf9uy2swAnAOrXjuCBJ1MT463wR8QM0R2
	PXhx0VAYjYUjhdJhBiQ95VvakeIQ5sVvLP1HnKP6zzKeM0xvEXtLIRf7L+jVam8FxdF7SjgQ==
X-Google-Smtp-Source: AGHT+IHgJciRdiJPwgbplIo/WsLvITLOK994V0iWy2ana2lAoSMuf7LoIUzExQoWhRApa1hovqKvGQ==
X-Received: by 2002:a17:907:6d20:b0:b73:845f:4432 with SMTP id a640c23a62f3a-b8445179d7fmr275661866b.32.1767796105143;
        Wed, 07 Jan 2026 06:28:25 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d51basm4865128a12.12.2026.01.07.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:24 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:13 +0100
Subject: [PATCH bpf-next v3 13/17] bpf, verifier: Propagate packet access
 flags to gen_prologue
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-13-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Change gen_prologue() to accept the packet access flags bitmap. This allows
gen_prologue() to inspect multiple access patterns when needed.

No functional change.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h                                  |  2 +-
 kernel/bpf/cgroup.c                                  |  2 +-
 kernel/bpf/verifier.c                                |  6 ++----
 net/core/filter.c                                    | 15 ++++++++-------
 net/sched/bpf_qdisc.c                                |  3 ++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5936f8e2996f..1dba2caee09c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1106,7 +1106,7 @@ struct bpf_verifier_ops {
 	bool (*is_valid_access)(int off, int size, enum bpf_access_type type,
 				const struct bpf_prog *prog,
 				struct bpf_insn_access_aux *info);
-	int (*gen_prologue)(struct bpf_insn *insn, bool direct_write,
+	int (*gen_prologue)(struct bpf_insn *insn, u32 pkt_access_flags,
 			    const struct bpf_prog *prog);
 	int (*gen_epilogue)(struct bpf_insn *insn, const struct bpf_prog *prog,
 			    s16 ctx_stack_off);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 69988af44b37..d96465cd7d43 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2694,7 +2694,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 }
 
 static int cg_sockopt_get_prologue(struct bpf_insn *insn_buf,
-				   bool direct_write,
+				   u32 pkt_access_flags,
 				   const struct bpf_prog *prog)
 {
 	/* Nothing to do for sockopt argument. The data is kzalloc'ated.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 95818a7eedff..daa90c81d802 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21768,7 +21768,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
-	bool seen_direct_write;
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
@@ -21796,13 +21795,12 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
-	seen_direct_write = env->seen_packet_access & PA_F_DIRECT_WRITE;
-	if (ops->gen_prologue || seen_direct_write) {
+	if (ops->gen_prologue || (env->seen_packet_access & PA_F_DIRECT_WRITE)) {
 		if (!ops->gen_prologue) {
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
-		cnt = ops->gen_prologue(insn_buf, seen_direct_write, env->prog);
+		cnt = ops->gen_prologue(insn_buf, env->seen_packet_access, env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index d43df98e1ded..07af2a94cc9a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9052,7 +9052,7 @@ static bool sock_filter_is_valid_access(int off, int size,
 					       prog->expected_attach_type);
 }
 
-static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_noop_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			     const struct bpf_prog *prog)
 {
 	/* Neither direct read nor direct write requires any preliminary
@@ -9061,12 +9061,12 @@ static int bpf_noop_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return 0;
 }
 
-static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_unclone_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 				const struct bpf_prog *prog, int drop_verdict)
 {
 	struct bpf_insn *insn = insn_buf;
 
-	if (!direct_write)
+	if (!(pkt_access_flags & PA_F_DIRECT_WRITE))
 		return 0;
 
 	/* if (!skb->cloned)
@@ -9135,10 +9135,11 @@ static int bpf_gen_ld_abs(const struct bpf_insn *orig,
 	return insn - insn_buf;
 }
 
-static int tc_cls_act_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int tc_cls_act_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, TC_ACT_SHOT);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog,
+				    TC_ACT_SHOT);
 }
 
 static bool tc_cls_act_is_valid_access(int off, int size,
@@ -9476,10 +9477,10 @@ static bool sock_ops_is_valid_access(int off, int size,
 	return true;
 }
 
-static int sk_skb_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int sk_skb_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			   const struct bpf_prog *prog)
 {
-	return bpf_unclone_prologue(insn_buf, direct_write, prog, SK_DROP);
+	return bpf_unclone_prologue(insn_buf, pkt_access_flags, prog, SK_DROP);
 }
 
 static bool sk_skb_is_valid_access(int off, int size,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b9771788b9b3..dc7b9db7e785 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -132,7 +132,8 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 
 BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
 
-static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf,
+				  u32 direct_access_flags,
 				  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1c41d03bd5a1..d698e45783e3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1397,7 +1397,7 @@ static int bpf_test_mod_st_ops__test_pro_epilogue(struct st_ops_args *args)
 static int bpf_cgroup_from_id_id;
 static int bpf_cgroup_release_id;
 
-static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf,
 					  const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1473,7 +1473,7 @@ static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struc
 }
 
 #define KFUNC_PRO_EPI_PREFIX "test_kfunc_"
-static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+static int st_ops_gen_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 			       const struct bpf_prog *prog)
 {
 	struct bpf_insn *insn = insn_buf;
@@ -1483,7 +1483,7 @@ static int st_ops_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 		return 0;
 
 	if (!strncmp(prog->aux->name, KFUNC_PRO_EPI_PREFIX, strlen(KFUNC_PRO_EPI_PREFIX)))
-		return st_ops_gen_prologue_with_kfunc(insn_buf, direct_write, prog);
+		return st_ops_gen_prologue_with_kfunc(insn_buf, prog);
 
 	/* r6 = r1[0]; // r6 will be "struct st_ops *args". r1 is "u64 *ctx".
 	 * r7 = r6->a;

-- 
2.43.0


