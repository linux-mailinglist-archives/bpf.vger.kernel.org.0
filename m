Return-Path: <bpf+bounces-74303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F4C52C48
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371A2501C65
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5033C533;
	Wed, 12 Nov 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V9COuMCa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V9COuMCa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67D31DD87
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957299; cv=none; b=P8/XjQoZQRJSPoo4K8Uh21BYupAB0yA8wx1kAxEJES4nxzHBAsDuIhZZ+NZxXuD6YB1rEuLMx4ncJZuykpRotiI1J7AKGl1HsyUmTvMsr5+8hFvXjFEBQaSGskioppSDlcw2KP6ki8W4f2gjT7s7WsDG581p01T1MogRiQGFtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957299; c=relaxed/simple;
	bh=3xFcdFAVAiwnQ0KWwv6CMVR/NIuvlwz20m6uT6E4qXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS1BxMm41jEhjObb6TuAc4f8wYX4SlgzHOWgm8//p1KyxY2u4GlBXeVo3s/TlwVOEU61G9Ou6jFWwBAw4d4WjB15eUQRlmLsX8HpPklAokJhRmZYpmo+kw3IecSIyJxSHXDyx03Jo/wv8ic7IW5VzPs6KzzueabRgloAgPdRUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V9COuMCa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V9COuMCa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 080D21F7FA;
	Wed, 12 Nov 2025 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evFpjNqjpWccBL5Ev7CM+eCXGSGu/p7G0azbkShutlQ=;
	b=V9COuMCaBHrWIOMgLYUC3PF+NF0h4Z5iLTqOaajMT+gSdDRSrI+eSKLAtiM813jT7QWOd2
	2JrLd3C5h9C82Cvg9HA6jVgqgwV4ZQIBjEcOzFmQBSIh56PJ9eIi/oiv8WhiUxLBuc9L0p
	UA+UorVr3QH9Sox2wFsUjyskynJIssY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evFpjNqjpWccBL5Ev7CM+eCXGSGu/p7G0azbkShutlQ=;
	b=V9COuMCaBHrWIOMgLYUC3PF+NF0h4Z5iLTqOaajMT+gSdDRSrI+eSKLAtiM813jT7QWOd2
	2JrLd3C5h9C82Cvg9HA6jVgqgwV4ZQIBjEcOzFmQBSIh56PJ9eIi/oiv8WhiUxLBuc9L0p
	UA+UorVr3QH9Sox2wFsUjyskynJIssY=
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
Subject: [PATCH v2 6/7] kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
Date: Wed, 12 Nov 2025 15:20:02 +0100
Message-ID: <20251112142003.182062-7-pmladek@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,atomlin.com:email,pathway.suse.cz:helo,suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

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


