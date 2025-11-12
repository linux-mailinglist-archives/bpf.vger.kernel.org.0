Return-Path: <bpf+bounces-74304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF054C52B16
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CD50343339
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64D263F28;
	Wed, 12 Nov 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fwm4E1Ut";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ek/OUc1L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533330AD1E
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957311; cv=none; b=AcwF2GAD/tOS6OeIy+9Lz8DuiJIcbNaCwJcRiK64OKKzMPXo6Aj9g9n72oSezxvjJIczsMsb+8N0wS0kjk70Tvz1xc3rsJT0+fKIHSQZoT29EDir1qNCV1rIeL62CycDTkNrG8fSrg7c3NOB2TeXY/J9nOjRlIyidg2dgP4U9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957311; c=relaxed/simple;
	bh=DErfb1yw71TjXX1m2fEvBmVvRDvk5oiZa5z6kIuTRKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHAtmmA55FYibab3nLmqaKKm3F/6iMLy9M/Wsre5kF/Ny+Z2PE8G/DLMwngYD9Amz/dsbTdbSjbslnOXJmVRcZ/rPpaiAf+4MHl4YOoi28R2szVgKTUnISfLhTFxriKufWUrOreJkfVYelNdg5XTs5xMTYZd0amuF0bKo2bamaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fwm4E1Ut; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ek/OUc1L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id E2A561F807;
	Wed, 12 Nov 2025 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97I/A52s9/abeslkIlgFB5lHhNmcwVQr9GlDloyKxh0=;
	b=Fwm4E1Utf5nc5WoVAJu8cPbGqYJ663EAiMUr/dgD+haLJtJDSIcHPLVCstP0e3WjSOyVfL
	39XTW3sBJh9rrJpBYxUGdJ/vEbrIGUF1xbftuqISTH9XzIGuFllUp4K1p6cRVP8z78xg9G
	Lx9r2Hkyv/iU1gSYpAnO1AI1iHmlcxs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97I/A52s9/abeslkIlgFB5lHhNmcwVQr9GlDloyKxh0=;
	b=ek/OUc1L8yezFuEAGDJzTqJ+8mCV7yLr5PfXO+bwcp0xVnqW4RJjJ6UsOksg2or/65hKKb
	GF94DTt31+xP9WOXSka14/oe6F8IQ9cgWvXrVP3QKtCUe6Ax86F4RO8qb3QVsNLhyD24xm
	8u8FIpZ5z2VqK5lcE6vsJa0kgttZ0Go=
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
Subject: [PATCH v2 7/7] kallsyms: Prevent module removal when printing module name and buildid
Date: Wed, 12 Nov 2025 15:20:03 +0100
Message-ID: <20251112142003.182062-8-pmladek@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[atomlin.com:email,pathway.suse.cz:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 

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
2.51.1


