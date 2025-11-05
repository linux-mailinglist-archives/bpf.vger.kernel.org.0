Return-Path: <bpf+bounces-73646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91AC360EB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3305C465984
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2132D0FF;
	Wed,  5 Nov 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhANJ+aB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhANJ+aB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241C32C950
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352671; cv=none; b=nzVJIwVr0yEd+WSWaumO0zczYkOelw8pJVbiEAhmd9dPpBRJX79YlkcjvJGXn8wakivDOuXwP/qgOxUpObt9k/n5SuIAj0n/lgadJ1To0in88npbdp4JUFUeLeWrB+izA3dxTKOeCUMPXgSKnZE4VE9dvSdv7PTWUJXalnS8vVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352671; c=relaxed/simple;
	bh=A5IXcVQ5fawZdmTwRPtACTA4pV2MrdTzD4I4MHabeDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxa6h3MUMYOdn6MMu/duB77hwB+3brpltU8HBDulWfugZ3C7g1fTAg2WRojS4tb12P5pM3qJ3H1/m4uWha+MpeH3T6KytsME4Y3PyeHCtHh1WAr2XTVdD6IKbYpUo2ojwbYPE4p7BQdfllS7TC9rnHJxIGI/J5GpuP+j8jSKYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhANJ+aB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhANJ+aB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id 211611F45F;
	Wed,  5 Nov 2025 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9jdZSA1Uy7m92gbnURla++n6HXEsbaGCgd+TUK6szM=;
	b=OhANJ+aBCMmDTLZHlShyqsgrTyKXY0Bder0XFQUQwcrxiyvCLKwXx8rTcK/oSpBPW6ECC+
	FYWtXG1ugBhCrdkBT133UHBYsYAizcQ2cUL6YkcoYgvtm7tbOrvF/GPg+OhDAmdfR8Yjuz
	xx+AYVWh55JrDq8dkuHSrEjMu5XxW+w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9jdZSA1Uy7m92gbnURla++n6HXEsbaGCgd+TUK6szM=;
	b=OhANJ+aBCMmDTLZHlShyqsgrTyKXY0Bder0XFQUQwcrxiyvCLKwXx8rTcK/oSpBPW6ECC+
	FYWtXG1ugBhCrdkBT133UHBYsYAizcQ2cUL6YkcoYgvtm7tbOrvF/GPg+OhDAmdfR8Yjuz
	xx+AYVWh55JrDq8dkuHSrEjMu5XxW+w=
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
Subject: [PATCH 4/6] kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
Date: Wed,  5 Nov 2025 15:23:16 +0100
Message-ID: <20251105142319.1139183-5-pmladek@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	R_RATELIMIT(0.00)[to_ip_from(RLh88t7rzwwfj8wh1imqozhtme)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

__sprint_symbol() might access an invalid pointer when
kallsyms_lookup_buildid() returns a symbol found by
ftrace_mod_address_lookup().

The ftrace lookup function must set both @modname and @modbuildid
the same way as module_address_lookup().

Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/ftrace.h | 6 ++++--
 kernel/kallsyms.c      | 4 ++--
 kernel/trace/ftrace.c  | 5 ++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 7ded7df6e9b5..a003cf1b32d0 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -87,11 +87,13 @@ struct ftrace_hash;
 	defined(CONFIG_DYNAMIC_FTRACE)
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym);
+			  unsigned long *off, char **modname,
+			  const unsigned char **modbuildid, char *sym);
 #else
 static inline int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+			  unsigned long *off, char **modname,
+			  const unsigned char **modbuildid, char *sym)
 {
 	return 0;
 }
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index efb12b077220..71868a76e9a1 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -378,8 +378,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 					 modname, modbuildid, namebuf);
 
 	if (!ret)
-		ret = ftrace_mod_address_lookup(addr, symbolsize,
-						offset, modname, namebuf);
+		ret = ftrace_mod_address_lookup(addr, symbolsize, offset,
+						modname, modbuildid, namebuf);
 
 	return ret;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..11f5096fb60c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7678,7 +7678,8 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+			  unsigned long *off, char **modname,
+			  const unsigned char **modbuildid, char *sym)
 {
 	struct ftrace_mod_map *mod_map;
 	int ret = 0;
@@ -7690,6 +7691,8 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		if (ret) {
 			if (modname)
 				*modname = mod_map->mod->name;
+			if (modbuildid)
+				*modbuildid = module_buildid(mod_map->mod);
 			break;
 		}
 	}
-- 
2.51.1


