Return-Path: <bpf+bounces-74300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 206EEC52AE0
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F18534E292
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418B3164AF;
	Wed, 12 Nov 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wqi7Mo3z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wqi7Mo3z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E32F0698
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957265; cv=none; b=EeoWNdGnHLQIlqc1Atr3GovUL7SxiWHE1JyNN/OeHKivPOrY/Kf2BZ4drrYVSXs13QeX1/zcMXvGtF3OvQZ1/OuYUAfVoAlY1xvS9t+jzzo3KH2PEthBNjd4CGdmC9NuFiiezMZCFFS6ZY8qzkkZutHjYQUXT05aaw+BlZOPPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957265; c=relaxed/simple;
	bh=L+21FgGFxbyB5fQzwZtH9DyvGokcavDoCgJHID86toM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVa6iXxlKsfqY8WPiKj+vHacCcs3IikGS3KSDkDQfVhWYefmAUTWjEtDHOPG/v0v9kG/0nZIyWMSn0eSiWawyi4DY8xOhNWgjh8PVm5EkxLLdUMZF+mgM4B7gZrEgt/YkJC14nrVXM+GF2sztl+RXIZb6OFTNohIFYjahVLAIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wqi7Mo3z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wqi7Mo3z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7150D1F7FA;
	Wed, 12 Nov 2025 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qP8QlUZ0s55z6qhmwDjXxh+SigCtbX/rn988arBW42k=;
	b=Wqi7Mo3zGsGLvSllNuqtLSGEerqMg0dFrOc8arOJkp6Mp1szhET9FA1NnE5hQ18huN7E/Z
	OCBez5MFND42NVTDoCVCABqIenD5wayT4R3n6kgZ4qhUh4mdT8XdVuGcvrq4yrfYd6gUiI
	XSwbDavq/IHDsL6rKaetwY2oPGt5IKs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qP8QlUZ0s55z6qhmwDjXxh+SigCtbX/rn988arBW42k=;
	b=Wqi7Mo3zGsGLvSllNuqtLSGEerqMg0dFrOc8arOJkp6Mp1szhET9FA1NnE5hQ18huN7E/Z
	OCBez5MFND42NVTDoCVCABqIenD5wayT4R3n6kgZ4qhUh4mdT8XdVuGcvrq4yrfYd6gUiI
	XSwbDavq/IHDsL6rKaetwY2oPGt5IKs=
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
	Petr Mladek <pmladek@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH v2 3/7] module: Add helper function for reading module_buildid()
Date: Wed, 12 Nov 2025 15:19:59 +0100
Message-ID: <20251112142003.182062-4-pmladek@suse.com>
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

Add a helper function for reading the optional "build_id" member
of struct module. It is going to be used also in
ftrace_mod_address_lookup().

Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
of the optional field in struct module.

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
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


