Return-Path: <bpf+bounces-75722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86169C9235C
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E978E3AD6AC
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3232F74A;
	Fri, 28 Nov 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UZbypL4L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V7F7arhp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6F32ED40
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338417; cv=none; b=DnGIoFusLBROXKli7MB57JXuqsQChrPlVzx1qnaOScJeyOD4aL2mMybwoRhHK/WJ5tzoT4jiIe9YwdZmLqugJAdSsCojrGuCVuF9iaTieYm/7kRfi5KpgKcgqiNUlStk+aBtJPSmqvlF9xGEXpigzSY2yfH/bD6j4zbE4EHwSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338417; c=relaxed/simple;
	bh=F5Pds+N66g7N4Rp9cXgOCPs4SkAfIpn1OJikkLIjusw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODZdRgiinb8PtH0GTcNB029zyLBi9uv6bLeu9mxYiJqSdi4Pin+SFXiBc3Go0ZBo4gHLg/IP5H8Pt02li+dnS4/lGqRhCOzsgyCcaRB0znNkf8p5OJyzqeH6xwCeMpT9/v38txQnAuqExCQ/FHK8xNVvdA85gNITmhGXMLODGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UZbypL4L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V7F7arhp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2DF4C5BD55;
	Fri, 28 Nov 2025 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXn+Ao4LsiEC7RPdi4UpjDJUsDXpi2W8dXd3l42r+bc=;
	b=UZbypL4LYIp4k6eMcqMe4er9+UlMHErwQFHcUIFqhBXuUgenTzY4x4P1alvvrVkIdbumSm
	YsXYmUbFYYsVq6o2sjozDkPlgr3m7sSsIj/ouDdyEH4zyPd1GWeAy2NT71CzrbgTuLDRQS
	XfjDZJh16qGq92Tl7Hj9qz1FwAOUTxY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=V7F7arhp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXn+Ao4LsiEC7RPdi4UpjDJUsDXpi2W8dXd3l42r+bc=;
	b=V7F7arhp2cFCDaR3InsTvE0sul7AtKzLHzsU4LN9ZWLYsYJ5UI9lnEVqpKzxZ00UgRXJYP
	8PGZC4jxarETqUVyhtMIoEzpx7uE9oCpmOWm27n/KTePaLrrYOZ31YncbAWfZLbCUYqVCo
	7vZ9IP3WAfHQ9qDstBC7sNTAxDbrCT0=
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
Subject: [PATCH v3 4/7] kallsyms: Cleanup code for appending the module buildid
Date: Fri, 28 Nov 2025 14:59:17 +0100
Message-ID: <20251128135920.217303-5-pmladek@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128135920.217303-1-pmladek@suse.com>
References: <20251128135920.217303-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [15.12 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[pathway.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[pathway.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.07)[-0.366];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.52.0];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RL6jpahug3dm5x93mmnjuwit91)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,pathway.suse.cz:helo];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12bd:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 2DF4C5BD55
X-Spam-Flag: YES
X-Spam-Score: 15.12
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

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
2.52.0


