Return-Path: <bpf+bounces-53005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0BA4B79F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4702E3AC77A
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4FF1DFD8B;
	Mon,  3 Mar 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdG1V7Dg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6623BE
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980237; cv=none; b=dlM+dr2p4ztNT6ap3KFiBp6Q96MFkxUVpeF5nTpYZBpkR2UAPlkjCd1Kb7RRnBzt7oi846PrmapbQGec6lgelMMGuQZY8KJmd5tc/SB/G3IG31QgoyRfVNO2L1r8n2N+fzJNgUVRBRo1tCWUS01rHLJBU2Zn8jnT0bDuU5OlV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980237; c=relaxed/simple;
	bh=KeBcH1GjqJCNyObldrkYVJDwv79JdE7giTQ8iZ/gB7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZzs4/NH8RkNlRghd81bjR9jsnSK0W3V6VCBqjtm9Rgsxyx11sCPyZVnh0ue+mgsru+OeLQw+pTjioFpWf5WW1kvHJ3sYwMg8kdE4HSmBc21tcckG4RlwEqBgiLPIjaeHu8d+1G9fVubmFk6YJo6AsrSU+yc7h3CCeX9ucOKDA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdG1V7Dg; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c14aae048bso6165865fac.1
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980235; x=1741585035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11XVZ4zj75vGzfRxwzqc/xjgcajBZqFGyuNELSq3ePM=;
        b=KdG1V7DgDBJlRRjLlHWiM7gRvNQCHWFnuCB4dTui8Wz1IX6aqm4KTWznftIz2WrEKd
         JTr9OrWUgnyywkAKVrUJhc9YoxCOr9y1hrWqOICjeLhN/fUgC27MsviwjOCo3pD5pOmW
         SNp5OIXzCbFS3ZIMVxWgf5G8c/BILhnp4g6vzJJbatdFhcOchVEUM8jwGwNc0aVNKzWz
         GB4jwXnrqn1s+lbVk2bKAUaVKYjoEiaEn6aljuqHxyG5hsFy5AtKsnwXU2paLq8ieEEm
         MQACG8Eb/WTs5bflM1xH1iXcoOT1WO6ZuJgT12eVXQvmfdLg0vPLODgA8CdcU7r6Bs04
         zqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980235; x=1741585035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11XVZ4zj75vGzfRxwzqc/xjgcajBZqFGyuNELSq3ePM=;
        b=jkjEUG08hFen4+86Thvt6eCQkP+ZOrwKk1p03WNHXL8oj8vmTEA1UKpMxYz7JpF3fI
         ZmlGQpoWbEsD6LnxoMdbfkGfi/hWWyADyVTVXmXi6OCSJc349JhZFE86vaAcVOnKyVvn
         44iy0sCX2UlDalgbYjUIgUSVhk4tAhI4K2JjdKAm1D8RF5uGcABgldfEEaL3J78WThfF
         6FYnmD5uMQru7sYb1UJjUhaZx76b7Vqn6T/lsnI3amHC8nBi/JOJe/umjs1Wa7FHnaVV
         8Gj9c7/wtU8axdmx3fZtlm8rtUrwe95ucqp6J8JuuROVD32kJ097SmEmN7cO5J/pkbrR
         H1gg==
X-Gm-Message-State: AOJu0Yygck7Rdv5h61G0gMlnwqYn0ijgC9Jcb+rVE4HqowAjDxdDJq26
	xpcA4hUIuLvaKs1OF/SZja+BTwEF3fJpAg8wBJp2naKR5anTnZM3jk7dZPoEp6eSfjgh4TvKw0z
	PTVVYNbmhmZH7574O52Oi3qfLMSULv7ynXgSJXCjcE3Zz+zcBYsxGbUJQud4Gr72ksQLi7YeOeM
	+INYdlikkHsjIcVneEWg521remo0kot8zuT04g9B0=
X-Google-Smtp-Source: AGHT+IHCMcja7O5nHvC3arJ2BfVxXnE0ShNgQeyCXpt5rqYUWe3LnL8pz4yrPXjuWabnQEE7N86n3GCAwOPQKA==
X-Received: from oablh23.prod.google.com ([2002:a05:6870:b17:b0:2ba:487b:683e])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:332b:b0:2c1:7289:d62a with SMTP id 586e51a60fabf-2c1786d0bdamr7852051fac.36.1740980234887;
 Sun, 02 Mar 2025 21:37:14 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:07 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <e5ef8b3116f3fffce78117a14060ddce05eba52a.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 01/10] bpf/verifier: Factor out atomic_ptr_type_ok()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
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
index eb1624f6e743..66b19fa4be48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6195,6 +6195,26 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
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
@@ -7652,11 +7672,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
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
2.48.1.711.g2feabab25a-goog


