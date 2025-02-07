Return-Path: <bpf+bounces-50715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC9A2B896
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE071889288
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EF154439;
	Fri,  7 Feb 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCD9JC71"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73067537E9
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893919; cv=none; b=ojTul9PAN1W+6oQowZAeLB9Chb6neUg8D2DnpbHRg5s0fo3pIMKTkCcaX9RppEqNYjFaf5pd1n8AViS0yhvMPoijQXjNtIfLMLnWdCHUxq3O27x5DlPyGsMmK2PzosR0kKbG6+UTkkhWF4qz3RuY3+v3yfwFFRE2lQHmP30eow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893919; c=relaxed/simple;
	bh=TIfBRiH6F4YKJqYlgZA1bOplpqfPiE9Bs2JBr1LCue8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QfFnUnCZ6YdBHUDgz44bezr5JtlHuLnHkpU+lelMw51UQRmjB5kCsxOR/0Vnrv5Sg3SvdbMA0xAVMyl8V5w0v49/Ek8n0S2idyRbaILP5MNhV1PEoILNYtxOh+MEClKJYkXOcncv4pU+yX1zJ8NmC7eU5eClIxisPyGwDboBbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCD9JC71; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f9f42d98e3so3284709a91.0
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738893916; x=1739498716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQntqM+rLZWQ3ApAwlHMCjvEA5GNUgj+7EI4yYRHGrA=;
        b=jCD9JC71bY3Ad5YCcq7cvV59RG+8xOaKuPXo8/ZEIvcWZa+dbxM6r3wWxpKLIpwEtU
         9bHA5BLkJJvsw8NlRJGB/LDV0uHFkSl9RDVLVUCfVdLZa0/htzFyc3p/0OKwMfwwOZl5
         KXFs/9iwsEG9fGSnGaO4DPJJSZ1NW7avsUAgHG/m22mrRDwvZsRjearzvWZy1NCCc6SI
         Nyx3jR/Hf5McGpGkkXmqijndJmLzv6cePly5rzMdnOWNAz7nm6dz6YstP5ePsRsDQoOf
         e3TNB+7uUs3bijloxOziOF+6t9Q7nTTqWSJQVITpm1NgKWq8X2XD/kyI90xvlrRb6dpl
         VLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893916; x=1739498716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQntqM+rLZWQ3ApAwlHMCjvEA5GNUgj+7EI4yYRHGrA=;
        b=Y+7PCNrnvpVC1fs552xENoVEBqYwx4aGIrgr08CWcHA5K3xW7Vg4t0mJ+jIy1gfclV
         1H1MyWigXxtzOueBsFekCyzmQ8uWrZKyQ/2t49mDZBvJNSVTUUymiUj5hemjiuYT5+3Q
         BZjVpS8Mc6bgcMGmuv9xHQUCkR2NpwW/2+YPgp7TuQbXc7z3aB628+P40HRJLXvNXs7Q
         8KCmrTlyuy5hpmyFUEJl3mp93CbcdHHFuhMw5MUwUt9fVOtXUh9EC0Ojke70Q9vcPjgI
         7fe9wSUiahxvJ6edGgeLKQSrtyrzJtACLD7m99CDDj4PkHoQYhUKRQs8QEHLx60Nq75e
         bCbQ==
X-Gm-Message-State: AOJu0YxI+mD2eTD1yLdzbtvWxqU4TcKKANxpwRoKm8nHdmgjA+QO5n5u
	pEav/QVXh4d5sr9EWJ1drJJV3TU0WZg/BLheI8PKHz/Su8anmbX/juFAz+cM1gCml9RbaW50ydn
	ORGy3OHC7sbPOKEXU+j4dQTh1ZAYFAC0SEQKDIiPmT16kCWDp2oJV05DsdvGZVxL5SCyrNng/YV
	IL2JwDyEVorzr20LWACBDeuX7Jf+gj25MkzOI98pY=
X-Google-Smtp-Source: AGHT+IG8RnoKYzqmdlNq/GNWt0Bfp60toUuFc3O205+7HMgGDaEyEjHnEEWL3iMa82zSQ8qscCoeONeApNS1Lw==
X-Received: from pjg15.prod.google.com ([2002:a17:90b:3f4f:b0:2fa:1fac:2695])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4cd1:b0:2fa:157e:c78e with SMTP id 98e67ed59e1d1-2fa23f5ebb1mr2348726a91.7.1738893916574;
 Thu, 06 Feb 2025 18:05:16 -0800 (PST)
Date: Fri,  7 Feb 2025 02:05:13 +0000
In-Reply-To: <cover.1738888641.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <56a8a44753b6e12abcb61163ba97159615ca8114.1738888641.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 1/9] bpf/verifier: Factor out atomic_ptr_type_ok()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor out atomic_ptr_type_ok() as a helper function to be used later.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..0935b72fe716 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6116,6 +6116,26 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+/* Return false if @regno contains a pointer whose type isn't supported for
+ * atomic instruction @insn.
+ */
+static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
+			       struct bpf_insn *insn)
+{
+	if (is_ctx_reg(env, regno))
+		return false;
+	if (is_pkt_reg(env, regno))
+		return false;
+	if (is_flow_key_reg(env, regno))
+		return false;
+	if (is_sk_reg(env, regno))
+		return false;
+	if (is_arena_reg(env, regno))
+		return bpf_jit_supports_insn(insn, true);
+
+	return true;
+}
+
 static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 #ifdef CONFIG_NET
 	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
@@ -7572,11 +7592,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}
 
-	if (is_ctx_reg(env, insn->dst_reg) ||
-	    is_pkt_reg(env, insn->dst_reg) ||
-	    is_flow_key_reg(env, insn->dst_reg) ||
-	    is_sk_reg(env, insn->dst_reg) ||
-	    (is_arena_reg(env, insn->dst_reg) && !bpf_jit_supports_insn(insn, true))) {
+	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
 			reg_type_str(env, reg_state(env, insn->dst_reg)->type));
-- 
2.48.1.502.g6dc24dfdaf-goog


