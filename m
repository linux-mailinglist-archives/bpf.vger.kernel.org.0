Return-Path: <bpf+bounces-75718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34563C92323
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155834E29CB
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FAF3090F7;
	Fri, 28 Nov 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J71V3TZo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J71V3TZo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF91C701F
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338378; cv=none; b=SBKil+Ch4X8E/oTkxHX8ajwGAqgUtPLaawWkkec4io8Q8+EgXWqenaRVyLoae936FqgvRssOSBumo0vwfvgwvf5tGyR2UYmutwxkHa0dn1pJrRDQQ35jVS8bRWwaFVboOg/44ePSkKPFZWM8AgicfjQL6pR4NUi+AEqcS06qzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338378; c=relaxed/simple;
	bh=y7MGR3TiuYXzQGOBsWXv2gEUuADCNMhyD/vJITxbwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzYZjRDFAs781o2ZKV6EMZBndEE3Ubik8ZGrerJJPo2JRECMY+u65gsgIP5475XW3URtTIH39oltYwd53ScjdG6lwmhyOtWJXtJKVcSHUQ5zuJ4XM0x9WF/HsmRLUPEpGJOH44a2DC4yWSnHwPOt4I0OO7kgaQUOqe1wIRU1tRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J71V3TZo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J71V3TZo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1C22B5BDC1;
	Fri, 28 Nov 2025 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HOcG+jrPa6OGfVHEEKDIojvHtUAzk3DbcK43E7DAYo8=;
	b=J71V3TZoTu1Zisce46aIKy0DFNQhNFxLK+SsbhJDT3wgAVQ6HLA7J5UVhzS5dLBNDYKd5Q
	+SKtwRpUYX1QuuQZtM/aOamHwbKkn1yjtaZ5TJBDoIvHEfZiQApr13WJnYyhwGHGtAHTw1
	P+ibyDAKNK0SujnrYeRO1LqU0MQatjs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=J71V3TZo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764338367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HOcG+jrPa6OGfVHEEKDIojvHtUAzk3DbcK43E7DAYo8=;
	b=J71V3TZoTu1Zisce46aIKy0DFNQhNFxLK+SsbhJDT3wgAVQ6HLA7J5UVhzS5dLBNDYKd5Q
	+SKtwRpUYX1QuuQZtM/aOamHwbKkn1yjtaZ5TJBDoIvHEfZiQApr13WJnYyhwGHGtAHTw1
	P+ibyDAKNK0SujnrYeRO1LqU0MQatjs=
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
Subject: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing module buildid
Date: Fri, 28 Nov 2025 14:59:13 +0100
Message-ID: <20251128135920.217303-1-pmladek@suse.com>
X-Mailer: git-send-email 2.52.0
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
	NEURAL_HAM_SHORT(-0.06)[-0.285];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.52.0];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TAGGED_RCPT(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,iogearbox.net,gmail.com,kernel.org,arm.com,google.com,vger.kernel.org,suse.com];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12bd:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 1C22B5BDC1
X-Spam-Flag: YES
X-Spam-Score: 15.13
X-Spam-Level: ***************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Spam: Yes

This patchset is cleaning up kallsyms code related to module buildid.
It is fixing an invalid access when printing backtraces, see [v1] for
more details:

  + 1st..4th patches are preparatory.

  + 5th and 6th patches are fixing bpf and ftrace related APIs.

  + 7th patch prevents a potential race.


Changes against [v2]:

  + Fixed typos in commit message [Alexei]

  + Added Acks [Alexei]


Changes against [v1]:

  + Added existing Reviewed-by tags.

  + Shuffled patches to update the kallsyms_lookup_buildid() initialization
    code 1st.

  + Initialized also *modname and *modbuildid in kallsyms_lookup_buildid().

  + Renamed __bpf_address_lookup() to bpf_address_lookup() and used it
    in kallsyms_lookup_buildid(). Did this instead of passing @modbuildid
    parameter just to clear it.


[v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
[v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com


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
2.52.0


