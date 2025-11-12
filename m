Return-Path: <bpf+bounces-74298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C72C52BB5
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79104A6CE7
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F533343F;
	Wed, 12 Nov 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrfHGZSV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TrfHGZSV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6A31DD87
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957244; cv=none; b=LFdwKQsaAqEGfxJmg5m4OPr1A6lBdV7mh6g4RpbdPvxkWACMcBMqlf474iUIzJt1aDkLnkJ1WQiSlr6kiyy9Y00Y7U8ctl5/r0UV6tvkDtIkKi1/mM0ARC8nSgxEdJRq4pcsNotBYPt6vufT1IRWWhF3wISOCc4jKb3lhkRrmr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957244; c=relaxed/simple;
	bh=NPULls7NkZK7K8UN1fMarpplKLfCVpzfoJgnXnPgubc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvNBIZ8XJv6H8rFOKgm4mBBI2XYzRwVP423F/mrCQp76w0ElyVSoTUpvAao6UYKl171YwG+j7Xr06ol7I4jsJeBojCYtLzXLFPvo1pemCDmRW4NiFf7t/IBYKtjdIa8Qx3pRjvin2OUz1XgoCb9jCDP5e4IENGgH1sdTGZYNTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrfHGZSV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TrfHGZSV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 79C641F811;
	Wed, 12 Nov 2025 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCOyARWGSi/xRdC07nt6pnjrsJIRTjWjs9bqoN8osVM=;
	b=TrfHGZSVK23k5MKwRs1KajqP/vUjGuEmN67vyNHectie79yXG77mc/IHmx2uNraCUpwJ6w
	To49NkA9SgRoINCE++e0NW34So/Ajsf7+gcaDPMFZyGKgLNprZV4L2SG0B41CuHDEg7iDb
	mKJXx+r9VBra9lJjdygDTKEVKxzfzYI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCOyARWGSi/xRdC07nt6pnjrsJIRTjWjs9bqoN8osVM=;
	b=TrfHGZSVK23k5MKwRs1KajqP/vUjGuEmN67vyNHectie79yXG77mc/IHmx2uNraCUpwJ6w
	To49NkA9SgRoINCE++e0NW34So/Ajsf7+gcaDPMFZyGKgLNprZV4L2SG0B41CuHDEg7iDb
	mKJXx+r9VBra9lJjdygDTKEVKxzfzYI=
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
Subject: [PATCH v2 1/7] kallsyms: Clean up @namebuf initialization in kallsyms_lookup_buildid()
Date: Wed, 12 Nov 2025 15:19:57 +0100
Message-ID: <20251112142003.182062-2-pmladek@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,atomlin.com:email];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
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

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kallsyms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 1e7635864124..e08c1e57fc0d 100644
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


