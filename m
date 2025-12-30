Return-Path: <bpf+bounces-77513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E5CE9F98
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1ED3026B33
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183E317700;
	Tue, 30 Dec 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgB5TIbj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598622253B0;
	Tue, 30 Dec 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767106231; cv=none; b=qs29377Ihf2bh7iBsFTO1bB4XDSGUQ5Tk0+EDMzGdZyWpU1edQPltPpVAlaZIe6dm8jZlQj7IETYhDhhIr0RjbiU0Yp5FV3b4DtTxiAXmkfVDm0DiUm+4JNF1aA/DNlVQ9HR1wBC3CuZc1LsJzGdb/rgxwxoGH5P8BQC5vXUoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767106231; c=relaxed/simple;
	bh=1PgfFQ0QPBJwuDSRx9cjHAtf7RHxjT8iELpalqbU8mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyynqbjsVMf9cL+5MDD9eVnO467uo9XcgKQI/cfjS23y+MQocwRH7gfkvpxim0aclew4y3RoGuqk8a5Z0g4g78D9zcTb++32RDn5Ffgbg6YXRy3R/vxpq4hQ6pa8WxCH737i0OiJTaMhSkv8JFuA4T7pmV/sh13SIEWE1PSUpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgB5TIbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB42FC4CEFB;
	Tue, 30 Dec 2025 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767106230;
	bh=1PgfFQ0QPBJwuDSRx9cjHAtf7RHxjT8iELpalqbU8mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgB5TIbjctDmru5Rfs7JzWSZdGSt3el+wwFWGvPDmC/+wgs14+jhgesuliQYRHqmy
	 Ud7aAJKzNUYj2jfk+LEhhxIPt67JaGZQB+SuHs/QAMH4KyLgEHdm9IaGKBhOxV01cV
	 eiqBvNmyEIB/i2GbOvlSd6nBrqGEOso72Cj9rpdO2b/cU1u4Isv4fzJ2dBl2djM6SC
	 F1oPyfNlD1cXV9VSwYnnIzf62XB+IWC87AKYf77NcHTcraXEPWGGFehVWa7hrKSZHA
	 6dfQ7lOYp8v+F9OSqUoZWeMoBpM/8Os9gngRq+fnV1BJr4onMcb9wrVdCUy8ig8tYJ
	 ZthaqSq2Ony7w==
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
Subject: [PATCHv6 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
Date: Tue, 30 Dec 2025 15:50:02 +0100
Message-ID: <20251230145010.103439-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
References: <20251230145010.103439-1-jolsa@kernel.org>
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
index 770f0dc993cc..41c9bb08d4e4 100644
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
index 2a125d063e62..789ff4e1f40b 100644
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
index 3ec2033c0774..f5f042ea079e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6043,15 +6043,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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
@@ -6172,13 +6165,6 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
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


