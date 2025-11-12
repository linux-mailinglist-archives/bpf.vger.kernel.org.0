Return-Path: <bpf+bounces-74302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3071DC52CA8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7934281F1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415633B6E2;
	Wed, 12 Nov 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XUzFd6mO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XUzFd6mO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A433ADB7
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957289; cv=none; b=HQ1f728GN4YKCQoJTUPD6x5eZxvujKLCntc5AXUVuNQ9R8IwONtZL4pf3Z3npC6Kzq/SCbIUbKPOqat4V3wHmQ6da3GCDz9joLuZ3iek2KT043myJx7JUF5EXhfHYA9GqtAIPF2XvjllwvT+4W1tXJdedOV4M0w0mb4xiNOzyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957289; c=relaxed/simple;
	bh=mxHWdzO4dwX+BObrGKYvMuAa72kgBGhtSbLImU0cGIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9PpqVojGb0JwpMilHPnpLTVo/wvJMoUxfXeJJmSYVF0iKE6liEsDkXvd8wAUd8pCjSw4gmP4MORhQuvPunsJBue+pFfNiXFCYnlr3Xshml0KaNEkiHXFP4YPkX+2qyVxaDooMtFLOyUTfpb3y2IgIS+9oT2YRO6fzHH0b3n5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XUzFd6mO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XUzFd6mO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3ADC41F812;
	Wed, 12 Nov 2025 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpcxTfUXgq7Ejo6e4rnogFpcy04cmMoesux2qzsq6m8=;
	b=XUzFd6mOSUyS/QfRDzwqvkLYxFAEjSAkGruMQGKXG9+8H/dNuE8lVBC5GilvysKE5auiar
	cWOm9KUI/PhGxuyFvlRlmnMMV5rm7YZXsbZ1ydJHKsSQGlFb4tk6KejgVBg09X4qeXcSbO
	u9WmMYJjVZBhSEa8GAyJzlCJPGvlcY4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpcxTfUXgq7Ejo6e4rnogFpcy04cmMoesux2qzsq6m8=;
	b=XUzFd6mOSUyS/QfRDzwqvkLYxFAEjSAkGruMQGKXG9+8H/dNuE8lVBC5GilvysKE5auiar
	cWOm9KUI/PhGxuyFvlRlmnMMV5rm7YZXsbZ1ydJHKsSQGlFb4tk6KejgVBg09X4qeXcSbO
	u9WmMYJjVZBhSEa8GAyJzlCJPGvlcY4=
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 5/7] kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
Date: Wed, 12 Nov 2025 15:20:01 +0100
Message-ID: <20251112142003.182062-6-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112142003.182062-1-pmladek@suse.com>
References: <20251112142003.182062-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pathway.suse.cz:helo,suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

bpf_address_lookup() has been used only in kallsyms_lookup_buildid().
It was supposed to set @modname and @modbuildid when the symbol was
in a module.

But it always just cleared @modname because BPF symbols were never in
a module. And it did not clear @modbuildid because the pointer was
not passed.

The wrapper is not longer needed. Both @modname and @modbuildid
are newly always initialized to NULL in kallsyms_lookup_buildid().

Remove the wrapper and rename __bpf_address_lookup() to
bpf_address_lookup() because this variant is used everywhere.

Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/arm64/net/bpf_jit_comp.c   |  2 +-
 arch/powerpc/net/bpf_jit_comp.c |  2 +-
 include/linux/filter.h          | 26 ++++----------------------
 kernel/bpf/core.c               |  4 ++--
 kernel/kallsyms.c               |  5 ++---
 5 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c9a50a1e73e..17e6a041ea4d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2939,7 +2939,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	u64 plt_target = 0ULL;
 	bool poking_bpf_entry;
 
-	if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
+	if (!bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
 		/* Only poking bpf text is supported. Since kernel function
 		 * entry is set up by ftrace, we reply on ftrace to poke kernel
 		 * functions.
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 88ad5ba7b87f..21f7f26a5e2f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -1122,7 +1122,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
 	branch_flags = poke_type == BPF_MOD_CALL ? BRANCH_SET_LINK : 0;
 
 	/* We currently only support poking bpf programs */
-	if (!__bpf_address_lookup(bpf_func, &size, &offset, name)) {
+	if (!bpf_address_lookup(bpf_func, &size, &offset, name)) {
 		pr_err("%s (0x%lx): kernel/modules are not supported\n", __func__, bpf_func);
 		return -EOPNOTSUPP;
 	}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..d500338af6e0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1353,24 +1353,13 @@ static inline bool bpf_jit_kallsyms_enabled(void)
 	return false;
 }
 
-int __bpf_address_lookup(unsigned long addr, unsigned long *size,
-				 unsigned long *off, char *sym);
+int bpf_address_lookup(unsigned long addr, unsigned long *size,
+		       unsigned long *off, char *sym);
 bool is_bpf_text_address(unsigned long addr);
 int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym);
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
-static inline int
-bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
-{
-	int ret = __bpf_address_lookup(addr, size, off, sym);
-
-	if (ret && modname)
-		*modname = NULL;
-	return ret;
-}
-
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
 
@@ -1409,8 +1398,8 @@ static inline bool bpf_jit_kallsyms_enabled(void)
 }
 
 static inline int
-__bpf_address_lookup(unsigned long addr, unsigned long *size,
-		     unsigned long *off, char *sym)
+bpf_address_lookup(unsigned long addr, unsigned long *size,
+		   unsigned long *off, char *sym)
 {
 	return 0;
 }
@@ -1431,13 +1420,6 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 	return NULL;
 }
 
-static inline int
-bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
-{
-	return 0;
-}
-
 static inline void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..c2278f392e93 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -713,8 +713,8 @@ static struct bpf_ksym *bpf_ksym_find(unsigned long addr)
 	return n ? container_of(n, struct bpf_ksym, tnode) : NULL;
 }
 
-int __bpf_address_lookup(unsigned long addr, unsigned long *size,
-				 unsigned long *off, char *sym)
+int bpf_address_lookup(unsigned long addr, unsigned long *size,
+		       unsigned long *off, char *sym)
 {
 	struct bpf_ksym *ksym;
 	int ret = 0;
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index f25b122397ce..97b92fc8871d 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -342,7 +342,7 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 		return 1;
 	}
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, NULL, namebuf) ||
-	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
+	       !!bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
 static int kallsyms_lookup_buildid(unsigned long addr,
@@ -383,8 +383,7 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 	ret = module_address_lookup(addr, symbolsize, offset,
 				    modname, modbuildid, namebuf);
 	if (!ret)
-		ret = bpf_address_lookup(addr, symbolsize,
-					 offset, modname, namebuf);
+		ret = bpf_address_lookup(addr, symbolsize, offset, namebuf);
 
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
-- 
2.51.1


