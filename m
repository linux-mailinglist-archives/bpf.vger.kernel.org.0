Return-Path: <bpf+bounces-75720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBCC92335
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 024D74E44DA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC97242D9D;
	Fri, 28 Nov 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f/3PZybt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f/3PZybt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0C329E48
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338394; cv=none; b=BvcMxauspsiUdQ/PXpOcZSuqOGU8Ak8NMMXLAigQAmZBVQTYxxI6Hc+aGiMsvXUx0e8nuB7kkzdPu5HjrxvKfcpapEfK6TNQ1R08y/qCyCiohEaVnxue2t+2Qh6E4nODJSGtMaFzUXPX4nZ55o4lt7GqTB0JJrhQhlyM/6qF3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338394; c=relaxed/simple;
	bh=egRmFN/mqkdCL+RNx/ncaQMejM8Y4t01FIBSpu97yyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2+XQr7R78nLKG+LLH0yehaTtdVbZQzVWP4OvwOS66+ON/xG1hLDRJaktLKiVT5OT8TDevH2KXMDBwi56rx7/qFiyP9dwELSb2GRMxChXI2ii5p7ZDsjRQPrD4RpOBS0OIzTab1yBeboy7CnYQjZRP9SVjimFSvMS3dhtOYYui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f/3PZybt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f/3PZybt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id F3DAE5BDB0;
	Fri, 28 Nov 2025 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiodvAhzYIk9+zlQJsEhcdKaOUEce1EkMu5DWzSTrSg=;
	b=f/3PZybtlZqdQgEx6Sh3Ekra8GRzqA+pzu5CupQcd7pk/sBDAfQOA2hrKwNi/A3IBoprna
	u93ubP711myK7eQA2UoDgnlRPR7Fy7jZc7eLgCKWa7Tae/Tqr8I8c6JNGv6aOrqSG5JBSZ
	QL60aBh5XagNSKLn2v+mnPDZW4GcYoc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="f/3PZybt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiodvAhzYIk9+zlQJsEhcdKaOUEce1EkMu5DWzSTrSg=;
	b=f/3PZybtlZqdQgEx6Sh3Ekra8GRzqA+pzu5CupQcd7pk/sBDAfQOA2hrKwNi/A3IBoprna
	u93ubP711myK7eQA2UoDgnlRPR7Fy7jZc7eLgCKWa7Tae/Tqr8I8c6JNGv6aOrqSG5JBSZ
	QL60aBh5XagNSKLn2v+mnPDZW4GcYoc=
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
Subject: [PATCH v3 2/7] kallsyms: Clean up modname and modbuildid initialization in kallsyms_lookup_buildid()
Date: Fri, 28 Nov 2025 14:59:15 +0100
Message-ID: <20251128135920.217303-3-pmladek@suse.com>
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
X-Spam-Flag: YES
X-Spam-Score: 15.12
X-Spam-Level: ***************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: F3DAE5BDB0
X-Rspamd-Action: add header
X-Spamd-Result: default: False [15.12 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[99.99%];
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
	NEURAL_HAM_SHORT(-0.07)[-0.332];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DIRECT_TO_MX(0.00)[git-send-email 2.52.0];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RL6jpahug3dm5x93mmnjuwit91)];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam: Yes

The @modname and @modbuildid optional return parameters are set only
when the symbol is in a module.

Always initialize them so that they do not need to be cleared when
the module is not in a module. It simplifies the logic and makes
the code even slightly more safe.

Note that bpf_address_lookup() function will get updated in a separate
patch.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e08c1e57fc0d..ffb64eaa0505 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -359,6 +359,14 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 	 * or empty string.
 	 */
 	namebuf[0] = 0;
+	/*
+	 * Initialize the module-related return values. They are not set
+	 * when the symbol is in vmlinux or it is a bpf address.
+	 */
+	if (modname)
+		*modname = NULL;
+	if (modbuildid)
+		*modbuildid = NULL;
 
 	if (is_ksym_addr(addr)) {
 		unsigned long pos;
@@ -367,10 +375,6 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 		/* Grab name */
 		kallsyms_expand_symbol(get_symbol_offset(pos),
 				       namebuf, KSYM_NAME_LEN);
-		if (modname)
-			*modname = NULL;
-		if (modbuildid)
-			*modbuildid = NULL;
 
 		return strlen(namebuf);
 	}
-- 
2.52.0


