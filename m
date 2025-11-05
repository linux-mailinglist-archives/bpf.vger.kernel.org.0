Return-Path: <bpf+bounces-73648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8034DC360F7
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84CF566412
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90032D445;
	Wed,  5 Nov 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mVAGaCwc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mVAGaCwc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3432D0D1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352694; cv=none; b=BiKxkB96MHC4pCvLOx/C/9eRZ+zCbuzQ69i5anu7qWKmExLXNkw+8Nt+WWmZexovCF7xXWhImWBLLfvHwoAwLN3QHm40kwECDv09saVZX5Xqseui7o8CsWadnt7d1lEnWJlvigmMY1t4/bFiaPfrTpKCKU/1HuVKp8CWmNWbebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352694; c=relaxed/simple;
	bh=RP9/Pa7uZjadz5VS6K6Zhwhg0tGtMF7soZM7ynErla8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcG4iW5YqscM2qX4LzuqeT7p+woJNYu4R0+dcyGKtXI75A3GQxh3WYNGhjaCitmrtv3ss5Vnjj25LXTY0wLOGyJIV9DeAP0bWVXpWwDUkalV/Wy5JukatraHCYg44M6LnWzhcssnu5S3p7z0dC5i+T29cjVlzd6nJxFPdc+iKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mVAGaCwc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mVAGaCwc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.201.202])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2044B1F78C;
	Wed,  5 Nov 2025 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlN6ktgHSU/f8xH1FiBJde/pat8uEOiShatc5EeBNHs=;
	b=mVAGaCwcbsJpndDfUnlSuIcgdhIek4f/E7+V6Yc6PvrDAcnQ5eqSHbT2gjbR4qNcL7iJJd
	sExiflclqJoQRuQ96t6mQscJ0k2ySEwMCNw1Mv1lolANBTUTHKCXaTOnNgwYgcVtboqVD2
	iEgRYj0JjHme7pep4TteiPW4O/6wr7A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762352688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlN6ktgHSU/f8xH1FiBJde/pat8uEOiShatc5EeBNHs=;
	b=mVAGaCwcbsJpndDfUnlSuIcgdhIek4f/E7+V6Yc6PvrDAcnQ5eqSHbT2gjbR4qNcL7iJJd
	sExiflclqJoQRuQ96t6mQscJ0k2ySEwMCNw1Mv1lolANBTUTHKCXaTOnNgwYgcVtboqVD2
	iEgRYj0JjHme7pep4TteiPW4O/6wr7A=
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
Subject: [PATCH 6/6] kallsyms: Prevent module removal when printing module name and buildid
Date: Wed,  5 Nov 2025 15:23:18 +0100
Message-ID: <20251105142319.1139183-7-pmladek@suse.com>
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

kallsyms_lookup_buildid() copies the symbol name into the given buffer
so that it can be safely read anytime later. But it just copies pointers
to mod->name and mod->build_id which might get reused after the related
struct module gets removed.

The lifetime of struct module is synchronized using RCU. Take the rcu
read lock for the entire __sprint_symbol().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index ff7017337535..1fda06b6638c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	unsigned long offset, size;
 	int len;
 
+	/* Prevent module removal until modname and modbuildid are printed */
+	guard(rcu)();
+
 	address += symbol_offset;
 	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
-- 
2.51.1


