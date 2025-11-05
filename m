Return-Path: <bpf+bounces-73647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8AC360DC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7898E1A22786
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EC32D0C5;
	Wed,  5 Nov 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZIhE1Iz8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZIhE1Iz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663E32D445
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352683; cv=none; b=J5nFUOvel855UW8fG4qOUWMV75hphLthdYHzxTONey1kNSmovP7vY2BH92HD8Ua3PYQFIEUfwaSpywTo8zO29nuLGG13mcclgS0yfJBAtSfq3kgOdeaolUTdlE/kHh+hAawVLqoCi9LZwoapPNNde6w8PMQdGdIOUl9gVjIhGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352683; c=relaxed/simple;
	bh=qPNXWEHipoavN9pVpXbfbNKpPRagLspNBeYsffAEsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCY4wzvjeSOO2HvgXvy9Xwiws4odnof5MHsk+g+WNuwQfKUe3RpdV6yKQKz6Q/QLLynmfF7f1VdyotLKvLnnYHPC3xxEz/YNHSI/z8uzdJeuyLsK2JMwew5w6WuuDsUOtsdKBI/SQ68mQU4O0THZA+Pz53E1kV4oWc+Hw9F85sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZIhE1Iz8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZIhE1Iz8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9746D1F394;
	Wed,  5 Nov 2025 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glw8CB41dEHHbXisbpnYd6qd/VUwdMvAcibSgKx99aY=;
	b=ZIhE1Iz8PPjn13xSGL+MmieL7h+9wcbaNO4DpHayfLdZqIiakc2buekR++Rda/RvMqhOYs
	mTGt6bbEk9x0j6GRqMg5wrrNZYJsSZPrB+kBe6FfLLvnQXL14JrJQdYoLhNO+VqlkZkJKm
	rXnCyM098qYnP+WbLNKMK4U3JguNNGA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glw8CB41dEHHbXisbpnYd6qd/VUwdMvAcibSgKx99aY=;
	b=ZIhE1Iz8PPjn13xSGL+MmieL7h+9wcbaNO4DpHayfLdZqIiakc2buekR++Rda/RvMqhOYs
	mTGt6bbEk9x0j6GRqMg5wrrNZYJsSZPrB+kBe6FfLLvnQXL14JrJQdYoLhNO+VqlkZkJKm
	rXnCyM098qYnP+WbLNKMK4U3JguNNGA=
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
Subject: [PATCH 5/6] kallsyms: Clean up @namebuf initialization in kallsyms_lookup_buildid()
Date: Wed,  5 Nov 2025 15:23:17 +0100
Message-ID: <20251105142319.1139183-6-pmladek@suse.com>
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

The function kallsyms_lookup_buildid() initializes the given @namebuf
by clearing the first and the last byte. It is not clear why.

The 1st byte makes sense because some callers ignore the return code
and expect that the buffer contains a valid string, for example:

  - function_stat_show()
    - kallsyms_lookup()
      - kallsyms_lookup_buildid()

The initialization of the last byte does not make much sense because it
can later be overwritten. Fortunately, it seems that all called
functions behave correctly:

  -  kallsyms_expand_symbol() explicitly adds the trailing '\0'
     at the end of the function.

  - All *__address_lookup() functions either use the safe strscpy()
    or they do not touch the buffer at all.

Document the reason for clearing the first byte. And remove the useless
initialization of the last byte.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 71868a76e9a1..ff7017337535 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -352,7 +352,12 @@ static int kallsyms_lookup_buildid(unsigned long addr,
 {
 	int ret;
 
-	namebuf[KSYM_NAME_LEN - 1] = 0;
+	/*
+	 * kallsyms_lookus() returns pointer to namebuf on success and
+	 * NULL on error. But some callers ignore the return value.
+	 * Instead they expect @namebuf filled either with valid
+	 * or empty string.
+	 */
 	namebuf[0] = 0;
 
 	if (is_ksym_addr(addr)) {
-- 
2.51.1


