Return-Path: <bpf+bounces-76632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF60CBFE24
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 22:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E93302A3A7
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2130E82E;
	Mon, 15 Dec 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXWCuKEB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0832939B;
	Mon, 15 Dec 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765833266; cv=none; b=AV+LWg7ZZnLVK/TlhFCEiIJAq5Y0mSfvnrEotrwPJWW97fFQ1u2skdfA05A5kvhFDlMvg71WoMRlcXCb0mo9N9UhUT6A8QutuQlcp5nnNG7UoqoSv7jx16PDDH+4TqfVHy7QlRkzPO26tsnETmsVL9X0hxXIbxTBvo+XqGfiM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765833266; c=relaxed/simple;
	bh=ex4gsm1cH3NpvQRTYPCxl+CnhL7/Pm9OyE43k+dDVsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUYIUm3X+NiTNK4MPw1zyhHt14VkpnA+7W3Kfxm3BW/fkkaPRcQ/2nHkqOoxRlQOrx7/o+Rol375EF1UsTWX0Olrd7Bu0WQui4LIjzaQ0MKsRnlOuzypLGEoeph2Wtin+/WqmT0UqsxniXiJFijNsS02UaVhA+O5l4ciNt0Usnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXWCuKEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2BCC16AAE;
	Mon, 15 Dec 2025 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765833265;
	bh=ex4gsm1cH3NpvQRTYPCxl+CnhL7/Pm9OyE43k+dDVsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXWCuKEBm4+A3+njEyudjL7Q+GPqD3quPFWxvZ/q5j5+6dXd9uk75pXdMDhqa63SL
	 VU/Hvp6D2/NG5BLXkZIwqTUa5J6C037m1v8btfuozyQ6fFQ7qcIUMTWktqctRP6YEd
	 aqP0cWSTzfdsazdt59lbuNH1T/skVyrWfjswiCTyV3BQOIKRGHtAdu7dl1pS/c+Ii+
	 3eB2d6x3jWx5EoVGXo3MgOJcF31BRktXDhOgPOVwW1VEiBv0rMwG3Q91j7w2fQwPg1
	 X7vbFaZW/6R2QdrOT3Ni8Kr0AgODeVh9+ZKpiYAIT0aErX0h/PzzHK4GDo8ZTeXFP3
	 SqrEm+eo7sAlA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: [PATCHv5 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
Date: Mon, 15 Dec 2025 22:13:54 +0100
Message-ID: <20251215211402.353056-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215211402.353056-1-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At the moment the we allow the jmp attach only for ftrace_ops that
has FTRACE_OPS_FL_JMP set. This conflicts with following changes
where we use single ftrace_ops object for all direct call sites,
so all could be be attached via just call or jmp.

We already limit the jmp attach support with config option and bit
(LSB) set on the trampoline address. It turns out that's actually
enough to limit the jmp attach for architecture and only for chosen
addresses (with LSB bit set).

Each user of register_ftrace_direct or modify_ftrace_direct can set
the trampoline bit (LSB) to indicate it has to be attached by jmp.

The bpf trampoline generation code uses trampoline flags to generate
jmp-attach specific code and ftrace inner code uses the trampoline
bit (LSB) to handle return from jmp attachment, so there's no harm
to remove the FTRACE_OPS_FL_JMP bit.

The fexit/fmodret performance stays the same (did not drop),
current code:

  fentry         :   77.904 ± 0.546M/s
  fexit          :   62.430 ± 0.554M/s
  fmodret        :   66.503 ± 0.902M/s

with this change:

  fentry         :   80.472 ± 0.061M/s
  fexit          :   63.995 ± 0.127M/s
  fmodret        :   67.362 ± 0.175M/s

Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h  |  1 -
 kernel/bpf/trampoline.c | 32 ++++++++++++++------------------
 kernel/trace/ftrace.c   | 14 --------------
 3 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 015dd1049bea..505b7d3f5641 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -359,7 +359,6 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 	FTRACE_OPS_FL_SUBOP			= BIT(18),
 	FTRACE_OPS_FL_GRAPH			= BIT(19),
-	FTRACE_OPS_FL_JMP			= BIT(20),
 };
 
 #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 976d89011b15..b9a358d7a78f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
 	int ret;
 
 	if (tr->func.ftrace_managed) {
+		unsigned long addr = (unsigned long) new_addr;
+
+		if (bpf_trampoline_use_jmp(tr->flags))
+			addr = ftrace_jmp_set(addr);
+
 		if (lock_direct_mutex)
-			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct(tr->fops, addr);
 		else
-			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct_nolock(tr->fops, addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
 						   new_addr);
@@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
+		unsigned long addr = (unsigned long) new_addr;
+
+		if (bpf_trampoline_use_jmp(tr->flags))
+			addr = ftrace_jmp_set(addr);
+
 		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
 		if (ret)
 			return ret;
-		ret = register_ftrace_direct(tr->fops, (long)new_addr);
+		ret = register_ftrace_direct(tr->fops, addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
@@ -499,13 +509,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
-	if (bpf_trampoline_use_jmp(tr->flags))
-		tr->fops->flags |= FTRACE_OPS_FL_JMP;
-	else
-		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
-#endif
-
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
@@ -533,15 +536,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->cur_image = im;
 out:
 	/* If any error happens, restore previous flags */
-	if (err) {
+	if (err)
 		tr->flags = orig_flags;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
-		if (bpf_trampoline_use_jmp(tr->flags))
-			tr->fops->flags |= FTRACE_OPS_FL_JMP;
-		else
-			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
-#endif
-	}
 	kfree(tlinks);
 	return err;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bbb37c0f8c6c..b0dc911411f1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6017,15 +6017,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	if (ftrace_hash_empty(hash))
 		return -EINVAL;
 
-	/* This is a "raw" address, and this should never happen. */
-	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
-		return -EINVAL;
-
 	mutex_lock(&direct_mutex);
 
-	if (ops->flags & FTRACE_OPS_FL_JMP)
-		addr = ftrace_jmp_set(addr);
-
 	/* Make sure requested entries are not already registered.. */
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6146,13 +6139,6 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	lockdep_assert_held_once(&direct_mutex);
 
-	/* This is a "raw" address, and this should never happen. */
-	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
-		return -EINVAL;
-
-	if (ops->flags & FTRACE_OPS_FL_JMP)
-		addr = ftrace_jmp_set(addr);
-
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
-- 
2.52.0


