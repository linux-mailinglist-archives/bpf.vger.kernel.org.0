Return-Path: <bpf+bounces-75724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A42C9236E
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22903AF25D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BC1C68F;
	Fri, 28 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dpzdk+/O";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OQG9WMMK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974E23C50A
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338439; cv=none; b=M59J/3mCQ7bGiucvelmYNGSmG/lQbNeE7UzrveRJsQ4xg0TKYpJArrOxIhyL1dkHw8/GciB2IQh2JQcZd8fYakggBuDIMl1w5QDuw3OzgbbBDLIVV79QHsxmf+e1bD4pRN3kAZK7CWTX8o/ui1WHQ3CDJe35LY0zd5d2mIvgX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338439; c=relaxed/simple;
	bh=8+22zrEZbmRi2hZ0IxfCnN+FjDUhaZxI/uAGmgwFPqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQVXbZZ14KEj+KAHKWW36oB/mCcdtBhzM6kKUFP0S+QE5D2BY2t/QaDveurhbkc/hgxGvSBbacVtam8P5RfaBVIEGqWOkEKLe/6ACDTzLFAEvBv4+Tw4+r+E5KnMEVfAG91OJiUhIXdGMd9MFLgK2UMozQ7AO+uMyb+6c2Dk+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dpzdk+/O; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OQG9WMMK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id 970C25BE7B;
	Fri, 28 Nov 2025 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpZ66NsDo6oRbcdThq5SnZKXC4wNbdElMjhexsMICjA=;
	b=Dpzdk+/O54oSQ9dMN/KDzMEbXsseH88A2fBkQCeDvzS7x2Ofrsin3lCLMLNlThw/c9Rkw4
	XZ3PEMfgz1seJBPGhlzp4Ul09eR1V7JR2onETDwf+E6ITQPOfPnp6FBLkVbLXVebVaKpBv
	Srd4VzNTVmKkx1N4Kj6A0ubDYo75J+w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OQG9WMMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpZ66NsDo6oRbcdThq5SnZKXC4wNbdElMjhexsMICjA=;
	b=OQG9WMMKXUPh2j0SoCAWkFp3kPyM+ck+Mba6KP5sMyclKfhKTrmFQ1C2A4YhwGSGeMW94Z
	AsBDc1pz1kXdoXmmPd99BK63IpU1obyUDMFCG+CwlllfUdt21FC/jAs/oKAMaLRv2nGNmP
	JvGtnGQiPSpEEj3xRiK4TYuiycSu7pI=
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
Subject: [PATCH v3 6/7] kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
Date: Fri, 28 Nov 2025 14:59:19 +0100
Message-ID: <20251128135920.217303-7-pmladek@suse.com>
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
X-Spamd-Result: default: False [15.11 / 50.00];
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
	NEURAL_HAM_SHORT(-0.08)[-0.381];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,suse.com:mid,suse.com:dkim,suse.com:email,pathway.suse.cz:helo,atomlin.com:email];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12bd:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 970C25BE7B
X-Spam-Flag: YES
X-Spam-Score: 15.11
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

__sprint_symbol() might access an invalid pointer when
kallsyms_lookup_buildid() returns a symbol found by
ftrace_mod_address_lookup().

The ftrace lookup function must set both @modname and @modbuildid
the same way as module_address_lookup().

Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/ftrace.h | 6 ++++--
 kernel/kallsyms.c      | 4 ++--
 kernel/trace/ftrace.c  | 5 ++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 07f8c309e432..9cc60e2506af 100644
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
index 97b92fc8871d..5bc1646f8639 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -386,8 +386,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 		ret = bpf_address_lookup(addr, symbolsize, offset, namebuf);
 
 	if (!ret)
-		ret = ftrace_mod_address_lookup(addr, symbolsize,
-						offset, modname, namebuf);
+		ret = ftrace_mod_address_lookup(addr, symbolsize, offset,
+						modname, modbuildid, namebuf);
 
 	return ret;
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 59cfacb8a5bb..d0001dffd98a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7708,7 +7708,8 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
 
 int
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
+			  unsigned long *off, char **modname,
+			  const unsigned char **modbuildid, char *sym)
 {
 	struct ftrace_mod_map *mod_map;
 	int ret = 0;
@@ -7720,6 +7721,8 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		if (ret) {
 			if (modname)
 				*modname = mod_map->mod->name;
+			if (modbuildid)
+				*modbuildid = module_buildid(mod_map->mod);
 			break;
 		}
 	}
-- 
2.52.0


