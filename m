Return-Path: <bpf+bounces-73645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E0C360B5
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A78C1A2302D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383432D0CB;
	Wed,  5 Nov 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gaD9jYeP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gaD9jYeP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F531329D
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352660; cv=none; b=U808dX9nz4q0I5+9Oloh3qwPlo+JXD1JvrZwsgwN5XDYSK6gKgHev1d/ZnDgBSJ5K80deKY6yHuJxGGCxcgdhi2khQbSZbV80SsMWeqabbRLg8GtxxydA9cvko6CcmPWmvANTCgXFEDn3fPmU0x7ZKvtvR0gcEPgj2hViSgtE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352660; c=relaxed/simple;
	bh=iVvhfthMHgv6Ky9reoayAG5dJCvY83w7hgPdp5+zxi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s83t0yhDPFlXfWat5NXmvoiBNm4y9nPk0gCjxmKEUEgltJVThtxS2v6kpsDccu34wrrMcNCn9uskzpsZ+o3GAYvo4DnFVKA9d3+f0dm5l9Xn9TFd9n/wAe0dS5aLumG6FrbB4N50R2i94Ls70ew7sk0xtO6ofnpIQZciuoszM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gaD9jYeP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gaD9jYeP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id A0B5A1F786;
	Wed,  5 Nov 2025 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOOXTYXv+eBG4xSRNWEn59nVQMXXNYCyWy3sgD99MRI=;
	b=gaD9jYePB2G/EMkjTa54b1mhFFjVNhRJq57ojBYITtke2nziNJGXuvAxRY+JzQdYRbx5lf
	+B0KuHdKycyheH8We54v9wSsVzlFrqDYQtsJ0TYLOGXoj7tmmb0kpieY1yAXewSo/H8Um2
	DjOqfE1oSDJM4UY5mDhm9n+Snv/u8cU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOOXTYXv+eBG4xSRNWEn59nVQMXXNYCyWy3sgD99MRI=;
	b=gaD9jYePB2G/EMkjTa54b1mhFFjVNhRJq57ojBYITtke2nziNJGXuvAxRY+JzQdYRbx5lf
	+B0KuHdKycyheH8We54v9wSsVzlFrqDYQtsJ0TYLOGXoj7tmmb0kpieY1yAXewSo/H8Um2
	DjOqfE1oSDJM4UY5mDhm9n+Snv/u8cU=
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH 3/6] kallsyms/bpf: Set module buildid in bpf_address_lookup()
Date: Wed,  5 Nov 2025 15:23:15 +0100
Message-ID: <20251105142319.1139183-4-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105142319.1139183-1-pmladek@suse.com>
References: <20251105142319.1139183-1-pmladek@suse.com>
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLh88t7rzwwfj8wh1imqozhtme)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

Make bpf_address_lookup() compatible with module_address_lookup()
and clear the pointer to @modbuildid together with @modname.

It is not strictly needed because __sprint_symbol() reads @modbuildid
only when @modname is set. But better be on the safe side and make
the API more safe.

Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/filter.h | 15 +++++++++++----
 kernel/kallsyms.c      |  4 ++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..b7b95840250a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
 static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname,
+		   const unsigned char **modbuildid, char *sym)
 {
 	int ret = __bpf_address_lookup(addr, size, off, sym);
 
-	if (ret && modname)
-		*modname = NULL;
+	if (ret) {
+		if (modname)
+			*modname = NULL;
+		if (modbuildid)
+			*modbuildid = NULL;
+	}
+
 	return ret;
 }
 
@@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 
 static inline int
 bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+		   unsigned long *off, char **modname,
+		   const unsigned char **modbuildid, char *sym)
 {
 	return 0;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 9455e3bb07fc..efb12b077220 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 	ret = module_address_lookup(addr, symbolsize, offset,
 				    modname, modbuildid, namebuf);
 	if (!ret)
-		ret = bpf_address_lookup(addr, symbolsize,
-					 offset, modname, namebuf);
+		ret = bpf_address_lookup(addr, symbolsize, offset,
+					 modname, modbuildid, namebuf);
 
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
-- 
2.51.1


