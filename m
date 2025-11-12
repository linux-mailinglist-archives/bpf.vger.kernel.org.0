Return-Path: <bpf+bounces-74301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E783C52BC1
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7952B50007C
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023631AF33;
	Wed, 12 Nov 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BnLRB4F5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nfE6lf8+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381472F1FC7
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957278; cv=none; b=cgGIWeWq+4Dt+Qr+jWmB+3ZcMFrWGVdywfj/IYKctu3oNThDdivMYVD2qCjU+rUI+CuNpDVaq7fdXXVbrScRo/j+1kDnsCzZrV5vekWbuHUhflIdPiN1QqO0I8jU4mP2UXCM6kUvxrAVCcbSusJ6IudEc+C7EhP8MDbK9+PA91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957278; c=relaxed/simple;
	bh=u3JhEMeaHqCCm3K2TgktQ2sf6pbkWpeo3IYBAWNLKUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NziwphW2gv1EGW90XufBmZDyL3FMQEcK9L58zruT8UZ4FDKA2/zstgFk4u1TrMSq1Q2a2s7OCWE1NnuAxpof6wX4Cy9caSAuPzp2mc/PQDGfh7JWVdCHS4F8nvflfFvhD3T0Fo0ssQVue5EDkYYz4XAfx+itOMKjuuoBXKNLThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BnLRB4F5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nfE6lf8+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id E55921F807;
	Wed, 12 Nov 2025 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqiSBpirJiJgacOo4S6qpog2Igj/FxV7fepY1Ud1yj0=;
	b=BnLRB4F5kJvWwq0uNFeHowmv1KnJLRD/SadwOgmpAPdbqJwMwnI2r67nMU7639gySQO1fw
	JaE3y0NsrSLvGGxVw9iHHz7i8Z+lbkGWc/CDpNdA3Gh0MkYEUAQPXr76+w/l+22E8RAm8m
	7M67Qyji0EBagdLVxL6cWqvJYII5ebM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqiSBpirJiJgacOo4S6qpog2Igj/FxV7fepY1Ud1yj0=;
	b=nfE6lf8+xSB8X6uMB6MAvfX9g5LM0PTktLSW/TjYc8aWLCrkOH2loOODKkGAZ7ffflRX/g
	7JGH4bmjSV1stI5Nvw5xWQD+yt0coyQ5lnK9Q4yzEhFYwkTC8fOw+OPXGP7/DtyrDJG0+E
	ynBOFl4UpXHJAr2iReFapL95pgRSQZY=
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
Subject: [PATCH v2 4/7] kallsyms: Cleanup code for appending the module buildid
Date: Wed, 12 Nov 2025 15:20:00 +0100
Message-ID: <20251112142003.182062-5-pmladek@suse.com>
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
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
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
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,pathway.suse.cz:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

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
index ffb64eaa0505..f25b122397ce 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -432,6 +432,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
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
@@ -454,15 +485,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 
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


