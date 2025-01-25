Return-Path: <bpf+bounces-49745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78040A1C067
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BFC3ADF83
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273161EEA43;
	Sat, 25 Jan 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITNF6/ac"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B31FA14E
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771489; cv=none; b=cpFzJuKSH5+wDjthnJ1TyZgwk6ktQJ7umlyjnQAP9Y2Uw7E+nomOLLhG8A0RBYRTcVZd18nKKWnMgAVMivRzJzgl69FBqnw7uDmXm/Mdo3YtLVxvptobUyvnbKYS1+7QO3zyc+fcNkPctV9eyvegpP8wKLhrmblGZcuBWsAlNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771489; c=relaxed/simple;
	bh=AtSgQqGcoKI6lPQ7U6NaPo/GE657YtZ+2oXd3eGvrYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsdb8XewBLRQ3a6biHL23Og2JxoWXeVX7fbgJc5wJN3UdwFg74SBZ9KxvLZDsqNGcR4xf4xt9a0A8yN5hAputA8/0XDfJJdB9LZSq1k26HzXS/T2TFMowrC9wdQcbUmtkTDKlU+I5natk0sDYQj/rSvGXUUPgYJ5AM/mzNl0Ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITNF6/ac; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so5017196a91.2
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771488; x=1738376288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAhOVvwp95DURlQLkWceP8oOZonYxW56RQWdJ+tqdYo=;
        b=ITNF6/acgN217IA6Ojth1MnMKSIvRiETzqfaBy7PEN3bjpH4O9Wg/0oe8Y7BzHLVqN
         /KneLxXYXKFTgqAOz/lvNRYgXyZv/55gVbL/Yd+SeaqCHnfsjtXti6vkNGHDc+GeAIFx
         g1kLjIcdScMTojnE9XsijZeEW4xOFJzCCj1Lyz0qeMJQaUgU3/DH5/lwPbXDOPk0J3yb
         /X9lwgKY2Nl2qINFeFDGxyF9R6xP+F9KD4yVcGvkynFEtAgHBJFf4SgWxSNSQuPA1VVo
         F7tmK9Ci35mNAec5Z+rzMWzdCcSkpRR1Qw8F66+FBy2EXvkbooMGLY2WgDOWFZ2fnYVS
         jvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771488; x=1738376288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAhOVvwp95DURlQLkWceP8oOZonYxW56RQWdJ+tqdYo=;
        b=EG3Mq/5HSpTnEWEU/jS9KtGO5zdAy7Gt2z2zfO98cvNfce+dNYRKVC6wTlE6zgTOg2
         8RCyI75yKegDrcgko193xL+LJhLECh/tXWV/uoCBECqK/tMRMDjDP1nV/EzjLwhYI6C8
         WE5pHOthhlFJrIh9jHPOf7ruBjd6mWJ0fQ26csEHO48p/cGQOeXfT8z7794CRMdePB5N
         tUH18qQjcgMoDP2i6O4+GpIXIUH5EnED6hkMWavSY/HqAtw6fMq2FLuJooNgg9qmwtq/
         FHsV7Bpt+fmDbnAt8Sxqs513tdeD+JKZ8ivDkyYqTZQAErLO/cI47glGs5js8kYDo1ym
         QKjA==
X-Gm-Message-State: AOJu0YykjKL1sgBT4rdA9bS+BSYjKZlmiFXpCYsEzWqkNVArmW0/s8Oy
	jrlWNovnz/GJdzBowbVK9Kr0BebqZloT57Y37cUrPyscZXoHTg4BjObki6EtQwP4NHmvdgB3HUg
	Wi2HGekXvhUC1Z1uD68XnPsNKPWFtQiLtsUVt3XMQHRbCUeI5C3ULm4/R0fsNa6d85gEV4Ai5uj
	OrglNLvbJjY4Mjm/Ap93hB625p5X3VUZxtB/ZLnv0=
X-Google-Smtp-Source: AGHT+IH+1cbrPKWyykDgl/vF7cElMEjsc9SSUcFXj1Np6Z8pLDvoFHDe47yUm55K1xK5bhBJYeqphCuyAJpw0w==
X-Received: from pfbbx20.prod.google.com ([2002:a05:6a00:4294:b0:729:14f9:2f50])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e24:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72daf948568mr52769436b3a.8.1737771487369;
 Fri, 24 Jan 2025 18:18:07 -0800 (PST)
Date: Sat, 25 Jan 2025 02:17:50 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <a47770869cfb984a148d6ded8ed8f4e43b8359e3.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 1/8] bpf/verifier: Factor out atomic_ptr_type_ok()
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
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
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
2.48.1.262.g85cc9f2d1e-goog


