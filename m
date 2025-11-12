Return-Path: <bpf+bounces-74297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5671C52AC2
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45B9D341C80
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA328B4E2;
	Wed, 12 Nov 2025 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lES8bcEp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lES8bcEp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F628A701
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957233; cv=none; b=acfFsTospGGtkql0jtoXeJpFI1HeBXSAp02O8kUiUk9T1aqs/swJNELRYcDOgiFW7EYRsd75hj9sZsAGwjK00oTYYcTLMepc2SUU+0QK43d1WRQIdmH8WqPDpDJp8hQ34+zKKqqFkfctAjloJAY7w71Mwc5inevtN9LOfCUSicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957233; c=relaxed/simple;
	bh=1qqDyrTlpYDcAvnMx/FE29JJGMAv3JNQmxC22TOy6+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVV3SoLiSCQ+AZhlCzMGQj0uGDMJxBkB/de/jIFg9OsAlnFaGMzE7r7H1jYyM2KIqWi12UUeNpwiWFgDJ0eZYfmap32flYEn5hpdR+Uy3hzXPq1Q/P2PRuxnrBomwssGWhQwLpoVF14Q08pfDks3K/7lt9M7sA+oRZjjbTDofxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lES8bcEp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lES8bcEp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id BA3BA1F7FA;
	Wed, 12 Nov 2025 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r4Iq2LGXG2cpf5OLzUafa6cxsLKtW2O0HZc3exA1+gI=;
	b=lES8bcEpgEegzUzPK3ih+zfC5mqj2Uf58X1Vs9JMNE3zs3j+xG62iz3EmQmpuQw8Zrd2ha
	zUJlDYsScOxGzbIBGl06vLNnTwglheCzOB9S9zhVR8ICi0PLFgBvjNq+J5x6XqojxAxje4
	BnjqktgcrG/YWGj6Fe/R7FenvRnYrSA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762957229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r4Iq2LGXG2cpf5OLzUafa6cxsLKtW2O0HZc3exA1+gI=;
	b=lES8bcEpgEegzUzPK3ih+zfC5mqj2Uf58X1Vs9JMNE3zs3j+xG62iz3EmQmpuQw8Zrd2ha
	zUJlDYsScOxGzbIBGl06vLNnTwglheCzOB9S9zhVR8ICi0PLFgBvjNq+J5x6XqojxAxje4
	BnjqktgcrG/YWGj6Fe/R7FenvRnYrSA=
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
Subject: [PATCH v2 0/7] kallsyms: Prevent invalid access when showing module buildid
Date: Wed, 12 Nov 2025 15:19:56 +0100
Message-ID: <20251112142003.182062-1-pmladek@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

This patchset is cleaning up kallsyms code related to module buildid.
It is fixing an invalid access when printing backtraces, see [v1] for
more details:

  + 1st..4th patches are preparatory.

  + 5th and 6th patches are fixing bpf and ftrace related APIs.

  + 7th patch prevents a potential race.


Changes against [v1]:

  + Added existing Reviewed-by tags.

  + Shuffled patches to update the kallsyms_lookup_buildid() initialization
    code 1st.

  + Initialized also *modname and *modbuildid in kallsyms_lookup_buildid().

  + Renamed __bpf_address_lookup() to bpf_address_lookup() and used it
    in kallsyms_lookup_buildid(). Did this instead of passing @modbuildid
    parameter just to clear it.


[v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com


Petr Mladek (7):
  kallsyms: Clean up @namebuf initialization in
    kallsyms_lookup_buildid()
  kallsyms: Clean up modname and modbuildid initialization in
    kallsyms_lookup_buildid()
  module: Add helper function for reading module_buildid()
  kallsyms: Cleanup code for appending the module buildid
  kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
  kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
  kallsyms: Prevent module removal when printing module name and buildid

 arch/arm64/net/bpf_jit_comp.c   |  2 +-
 arch/powerpc/net/bpf_jit_comp.c |  2 +-
 include/linux/filter.h          | 26 ++----------
 include/linux/ftrace.h          |  6 ++-
 include/linux/module.h          |  9 ++++
 kernel/bpf/core.c               |  4 +-
 kernel/kallsyms.c               | 73 ++++++++++++++++++++++++---------
 kernel/module/kallsyms.c        |  9 +---
 kernel/trace/ftrace.c           |  5 ++-
 9 files changed, 81 insertions(+), 55 deletions(-)

-- 
2.51.1


