Return-Path: <bpf+bounces-75725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E6C92371
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 413A735314F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA8244687;
	Fri, 28 Nov 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KB7iHEr7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="idDsK9Ht"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228D3043A9
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338456; cv=none; b=ZQBvDiS9synT6dO/p+fTWhSnXI3RC8qGwYht8JS0XyW1JCM5CYnOXhu0wgZKbwE/WrrPelGIGLMvDnbqIFGlMLnlbSRvsF7VnRPKs8mQPiaLMswAUtzEN1wcki37IHL53P4YmB594n4tWzPNk1eCoaSMjIYLPllZ8oNlNM4UhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338456; c=relaxed/simple;
	bh=/b6oiUSdkAC7r0PXy4PCn7idBfGLvrD/tieVHb+t+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjVnVTJWHVwnQoYHYUouWa0KAv7ZoonUT33BAVfBQ5IN56LG5lHhJrNf37eP1AqO1A5t7Z0/Qg3qXFBEAZZsUEvLE77Bmso9Kr6eqop3dRFMRbrkCKgpsN+09QYkwlWeRg7+ZrxQLAzL3JJBpFv0qWXgv/BA9b6xzOcFDKvvXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KB7iHEr7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=idDsK9Ht; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id EDE045BED2;
	Fri, 28 Nov 2025 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah68JRZAkYtiOi50cXOHf5n/v9ykgtc02Rb05ZD2x3A=;
	b=KB7iHEr7n8o/0Eo5B6UezaVaVEdc+TxWLJyN74y/tiTQhTWGwRT19PlQzpYM1d+51DWQb6
	HsasaTjnf4YTWzQ4YvqXegdkt7dzWFOKDQEob4aRz+LiLeTakRQ4GQH4K0ZdP2Hx02voSh
	Lx4KGAH+DPHJBccEM9JKvWqcr39PXUk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=idDsK9Ht
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ah68JRZAkYtiOi50cXOHf5n/v9ykgtc02Rb05ZD2x3A=;
	b=idDsK9HtLL0GmmiLlXxzQyHibz/wSeTyNLqqFDSMFbL+JNxAKIMrkj4NkV21HB1xsIpVQU
	+66AxwQttp5jazE0I8d6nIGYQq0vGXsZGI35X8WfSs/w/ExkpDKID6XGOM6wlibldDhhJx
	n7pToOnHv++hyVkBT1RevXmA5j/53TM=
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
Subject: [PATCH v3 7/7] kallsyms: Prevent module removal when printing module name and buildid
Date: Fri, 28 Nov 2025 14:59:20 +0100
Message-ID: <20251128135920.217303-8-pmladek@suse.com>
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
X-Spamd-Result: default: False [15.13 / 50.00];
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
	NEURAL_HAM_SHORT(-0.06)[-0.318];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,suse.com:mid,suse.com:dkim,suse.com:email,pathway.suse.cz:helo];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1b::12bd:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: EDE045BED2
X-Spam-Flag: YES
X-Spam-Score: 15.13
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

kallsyms_lookup_buildid() copies the symbol name into the given buffer
so that it can be safely read anytime later. But it just copies pointers
to mod->name and mod->build_id which might get reused after the related
struct module gets removed.

The lifetime of struct module is synchronized using RCU. Take the rcu
read lock for the entire __sprint_symbol().

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5bc1646f8639..202d39f5493a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -471,6 +471,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	unsigned long offset, size;
 	int len;
 
+	/* Prevent module removal until modname and modbuildid are printed */
+	guard(rcu)();
+
 	address += symbol_offset;
 	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
-- 
2.52.0


