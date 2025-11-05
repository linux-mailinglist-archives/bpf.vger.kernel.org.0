Return-Path: <bpf+bounces-73644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A73C360A3
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581DF1A2297E
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511232C925;
	Wed,  5 Nov 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f8meYpkO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f8meYpkO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFE3203AA
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352650; cv=none; b=YgSBH650YJYaXSuEkN8MP7s8nCHiSKs8hPpQ5AagG9WOWgKzM14uds+NyLjc6cNGoHozKDx5R+Uxj9q5IRhhNMYBYMBHhdlFSJg4o/AIxr2tV3BFALaFzARbVQmmRcFm3cIZqpO7VXD4Wbc0E4kXY7TJ9mH1BA+by+0HWilO//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352650; c=relaxed/simple;
	bh=cSGx72iuICR9S7hAusURL71fdNu92ubO1TwC2YZY4Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYgPHgodNkcBwgfq2d8U9joUZAg1nQywbsd6Nd/cnSDY3hLRLxoXMlRAP3RLpwzdOZSEoABp1xWsRzKLm+/YDSzf/n10o5O2rjWsHZWj7IDQYn+lNxcaQtizpi96w/AIKJNq0xMO84jxeCIHeYXu1wMVoJTYe6n8Myf1Pj02L4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f8meYpkO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f8meYpkO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2CB6D1F7BB;
	Wed,  5 Nov 2025 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dt0eIpX7FIrJrn0++mqWAMUraUXlev9Ytv1ifgKyWWk=;
	b=f8meYpkOVT1PwrdYLJBti8cU3CpuNlTH1kN9WtxNGkELsU9Tim/hzv5Gyk3rihQZy0T9sj
	GLq2yJnG6St7tASrkuqKWSNrim8LUNIJTC39fjjKkHR/vcUcyuL80s7kcVYJpWZzzMPxsN
	if+EorsOgwfUN8bpE4Xx5xWpfGvj+9I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dt0eIpX7FIrJrn0++mqWAMUraUXlev9Ytv1ifgKyWWk=;
	b=f8meYpkOVT1PwrdYLJBti8cU3CpuNlTH1kN9WtxNGkELsU9Tim/hzv5Gyk3rihQZy0T9sj
	GLq2yJnG6St7tASrkuqKWSNrim8LUNIJTC39fjjKkHR/vcUcyuL80s7kcVYJpWZzzMPxsN
	if+EorsOgwfUN8bpE4Xx5xWpfGvj+9I=
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
Subject: [PATCH 2/6] kallsyms: Cleanup code for appending the module buildid
Date: Wed,  5 Nov 2025 15:23:14 +0100
Message-ID: <20251105142319.1139183-3-pmladek@suse.com>
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

Put the code for appending the optional "buildid" into a helper
function, It makes __sprint_symbol() better readable.

Also print a warning when the "modname" is set and the "buildid" isn't.
It might catch a situation when some lookup function in
kallsyms_lookup_buildid() does not handle the "buildid".

Use pr_*_once() to avoid an infinite recursion when the function
is called from printk(). The recursion is rather theoretical but
better be on the safe side.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..9455e3bb07fc 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
 	return lookup_module_symbol_name(addr, symname);
 }
 
+#ifdef CONFIG_STACKTRACE_BUILD_ID
+
+static int append_buildid(char *buffer,  const char *modname,
+			  const unsigned char *buildid)
+{
+	if (!modname)
+		return 0;
+
+	if (!buildid) {
+		pr_warn_once("Undefined buildid for the module %s\n", modname);
+		return 0;
+	}
+
+	/* build ID should match length of sprintf */
+#ifdef CONFIG_MODULES
+	static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
+#endif
+
+	return sprintf(buffer, " %20phN", buildid);
+}
+
+#else /* CONFIG_STACKTRACE_BUILD_ID */
+
+static int append_buildid(char *buffer,   const char *modname,
+			  const unsigned char *buildid)
+{
+	return 0;
+}
+
+#endif /* CONFIG_STACKTRACE_BUILD_ID */
+
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
 			   int symbol_offset, int add_offset, int add_buildid)
@@ -445,15 +476,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 
 	if (modname) {
 		len += sprintf(buffer + len, " [%s", modname);
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-		if (add_buildid && buildid) {
-			/* build ID should match length of sprintf */
-#if IS_ENABLED(CONFIG_MODULES)
-			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
-#endif
-			len += sprintf(buffer + len, " %20phN", buildid);
-		}
-#endif
+		if (add_buildid)
+			len += append_buildid(buffer + len, modname, buildid);
 		len += sprintf(buffer + len, "]");
 	}
 
-- 
2.51.1


