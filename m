Return-Path: <bpf+bounces-74299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBA1C52BEE
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21D84A725A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D082C08BA;
	Wed, 12 Nov 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mZcww2C1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qYriiYqz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D32951B3
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957254; cv=none; b=XIJOhh0sOAgU8m3d9klsgCxtnN1ZIU3LlEBy5kP/NO8hIjyqSDDPPpurdcXA6NbaUseOGqVm9Ttt3dIpUEx7ymXMOcibqZstD0yADTrocyYKnDu0q9yi+II0EjWiO0JxRjDD6hET+EN4G081TomW3u+D8T4RnN7YXXtIAPsdnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957254; c=relaxed/simple;
	bh=PMLe2NtTfO8x7SDcutb9xCSuVGGAXm1wxNPsTX8IEsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClC/26V6JHl1PksUMd5+wJ8/eDw1KKl+xgDHT6XWgRLGVwwoZbR3KuPSzibnPbUHcLksVGOjUTBjvkkrkr7GicsCmS2M1PXCV3R3fcHFsdLK5iJ0PQRoLofoLQdxaWTFAh3k6MvkIkdwEoIdtWSmX67pHhrQlIz22mgrUpF+c8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mZcww2C1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qYriiYqz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 78D051F807;
	Wed, 12 Nov 2025 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfvF234vWKCKB1nLJCrpAZU8zDmOaaizZkH1U/ILFM0=;
	b=mZcww2C16TuWjdqIjkr/hhIXrVdisUWC3wT7I9hXmg97M7bp/Y2MzU5N0q+GLM/XimUci0
	Jxj6SwL0z1eca1n8hpjx8PjCSTIN/4ZMzfDlDcZ6Pk67sF79R0iBBXraAuR84kZ/RhCWme
	zo3a/zWDoQ5fRe9iP2pKbSQRM5C6iS4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfvF234vWKCKB1nLJCrpAZU8zDmOaaizZkH1U/ILFM0=;
	b=qYriiYqzeyLyODTQdOw1Ee1YbpQlGRW0dWpbG1E0mDkBxGh8ZA03iOuCH61+fgV/LISsWj
	1CUQEbN5eLbzksZS/4Rut8L0gw7JIIjSfGQjGPYZpOjadHyEbf/npKJv5jfjYs6z1tGSn/
	crLLfNIlK1JOErgPZlf6VSbNBBo/Azw=
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
Subject: [PATCH v2 2/7] kallsyms: Clean up modname and modbuildid initialization in kallsyms_lookup_buildid()
Date: Wed, 12 Nov 2025 15:19:58 +0100
Message-ID: <20251112142003.182062-3-pmladek@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLw9bydq1j5bti46rxed9sjz7y)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

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
2.51.1


