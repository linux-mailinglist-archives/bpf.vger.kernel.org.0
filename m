Return-Path: <bpf+bounces-73643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAB3C360C7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9E894F817B
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373732C950;
	Wed,  5 Nov 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PNHsckCY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PNHsckCY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34B326D61
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352638; cv=none; b=efioYnthRXzNAOq3ImVJyBs05doKEo5/NlefIH/JEZlA5vyPhrtGBSrar/2A6NfB0QmXypl8VsMQmHL6DOFlh1Wb45dp4K0ZgV4jFfLHrDq5h7YLIZI/M40OLbKcdviFWYAX4VfRqoERKU+cizwSqC2rGcolZ/o+5uMxo9AJesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352638; c=relaxed/simple;
	bh=knbHwNAMhf5BDPiCrGkzkztUWSNv32MtWtx9UXuL3Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEO9GlVBcAcoYhPQdMQirZoCxqNGojACGzQhBAXbgiK3pY6k6XII/DU/BakaOxC/M7/SLJaHlUTcPgZuP091u4J3VWh22aD0QJmO65feyGMrqYaH/HlQ8r5r35CqUBhZjEFA6LuaNwge+azmZ/lpvFPdzn5wUAj0+UjrtCtNb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PNHsckCY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PNHsckCY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9B3B71F7B1;
	Wed,  5 Nov 2025 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jqzc3Ysbn3twcDZBQYQeJ4DlapTdPG0nTF1IKTtw0U=;
	b=PNHsckCY9Svw2nSlBok1Pi+BW8UkpFwAWXhJoKas3vkErCAIdVfnpLfdQb4rvQM19CnDHW
	1DS9cswvrK2BghhqCrDFULKfZt5iN5zegtTwK9MKHJkzGbdt+sxkT6T5hFFlSOSR05uCUW
	Ee6x2prI+pkp1g3zEfISr+xzYKbOelk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jqzc3Ysbn3twcDZBQYQeJ4DlapTdPG0nTF1IKTtw0U=;
	b=PNHsckCY9Svw2nSlBok1Pi+BW8UkpFwAWXhJoKas3vkErCAIdVfnpLfdQb4rvQM19CnDHW
	1DS9cswvrK2BghhqCrDFULKfZt5iN5zegtTwK9MKHJkzGbdt+sxkT6T5hFFlSOSR05uCUW
	Ee6x2prI+pkp1g3zEfISr+xzYKbOelk=
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
Subject: [PATCH 1/6] module: Add helper function for reading module_buildid()
Date: Wed,  5 Nov 2025 15:23:13 +0100
Message-ID: <20251105142319.1139183-2-pmladek@suse.com>
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

Add a helper function for reading the optional "build_id" member
of struct module. It is going to be used also in
ftrace_mod_address_lookup().

Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
of the optional field in struct module.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/module.h   | 9 +++++++++
 kernel/module/kallsyms.c | 9 ++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..4decae2b1675 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -747,6 +747,15 @@ static inline void __module_get(struct module *module)
 	__mod ? __mod->name : "kernel";		\
 })
 
+static inline const unsigned char *module_buildid(struct module *mod)
+{
+#ifdef CONFIG_STACKTRACE_BUILD_ID
+	return mod->build_id;
+#else
+	return NULL;
+#endif
+}
+
 /* Dereference module function descriptor */
 void *dereference_module_function_descriptor(struct module *mod, void *ptr);
 
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 00a60796327c..0fc11e45df9b 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -334,13 +334,8 @@ int module_address_lookup(unsigned long addr,
 	if (mod) {
 		if (modname)
 			*modname = mod->name;
-		if (modbuildid) {
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-			*modbuildid = mod->build_id;
-#else
-			*modbuildid = NULL;
-#endif
-		}
+		if (modbuildid)
+			*modbuildid = module_buildid(mod);
 
 		sym = find_kallsyms_symbol(mod, addr, size, offset);
 
-- 
2.51.1


