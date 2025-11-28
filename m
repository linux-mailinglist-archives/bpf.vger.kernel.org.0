Return-Path: <bpf+bounces-75719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951BC9232F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC35351338
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8432D422;
	Fri, 28 Nov 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lHga0k35";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ntHNc/jV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F22269D18
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338384; cv=none; b=qmuhYObWoTuKomBmPinynr8sqz+EQkDA+Evzaz8zk08aSbhaUvYBSg3J/xKDsm724WOF59D0k3CHrqWfxxHhExTVe/fIo0ntgsNcDsQgmElBROTF5Q7W1C9MC+UW6UFzmXlAwchBshwcDSW+l+0kMr0wtYEaw6LRA53Vxa7yW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338384; c=relaxed/simple;
	bh=yETNoQUjTy/o4hRd3JCjS3DSwBeAxogtUnskeoFG93U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP+cPT7RvsI3eLhj2Czne6KSgERPuE4Ll0WlpGxbgJuYubjQuYSedLIBySIeKjX9Q0r2lp2Q6OBO4+43Rtgz+373wP9z0+2drDNb32me7DKMuhkboW8cPTDIQGid2pSpIsbrPHlhMsrDCzpq1JPLmWKApkcEc564TITZLgf2Zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lHga0k35; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ntHNc/jV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id 23B8B5BDA8;
	Fri, 28 Nov 2025 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC80OjUEAAi7F/7wFyywwekDzm2PMhYQJkvZRfqjmCE=;
	b=lHga0k35Wzpi9TRyAVphoVKW5c+VRlQaewwDSQR0BdIwToav2GL2HTUyT3vPZ0ziPJdbvN
	XbEo7qdPzjCwyv7MTxN7ZAJrY9ER1YTQri1tWkxcKA11NZEPoZHDNH4iT8xTtDZHtJdKkx
	LygrdKVDXeW3FQK2Qiyf1IaaJoQofgs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="ntHNc/jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vC80OjUEAAi7F/7wFyywwekDzm2PMhYQJkvZRfqjmCE=;
	b=ntHNc/jVPqu1hZa0LMTVFfwWadaPPmMXmJrWID0eyNnvKUzWmYs7Q3VMxtIyYpkYz4qtpn
	Bq5AQ2SLZZl+hSS7oXOnFdyYZTDupwr7bYfRJLwMWivN72yTCucXYE+UQ75+alxQCNqjUN
	vNhYEcGGpsMImm5sr2gU7LFSi8Q6iv0=
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
Subject: [PATCH v3 1/7] kallsyms: Clean up @namebuf initialization in kallsyms_lookup_buildid()
Date: Fri, 28 Nov 2025 14:59:14 +0100
Message-ID: <20251128135920.217303-2-pmladek@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[pathway.suse.cz];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[pathway.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.06)[-0.321];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.52.0];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	DKIM_TRACE(0.00)[suse.com:+];
	R_RATELIMIT(0.00)[to_ip_from(RL6jpahug3dm5x93mmnjuwit91)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 23B8B5BDA8
X-Spam-Flag: YES
X-Spam-Score: 15.13
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

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
2.52.0


