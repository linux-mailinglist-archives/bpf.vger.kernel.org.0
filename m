Return-Path: <bpf+bounces-31004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C08D5E5E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2104F2876F4
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842181422C1;
	Fri, 31 May 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2C4S76QU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j0ilQ40F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b77OsGwl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5h1qKUz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137B7581D;
	Fri, 31 May 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148025; cv=none; b=oCpD+V9leDPP5fL2VW5+aRUPS9Rd4LthfGkF3Tk+MeXFXD0IX7ECEe/yYDNpNfTx9M/q46aprcpXmS1TitR8zIcEjbPQvRUZx4xiYjHuKvReL9NcnwTdQJci0461BcK6cC9mW9GigWrE8Dy4rHn0YTL4ywjjvRIQYRcbVRRmTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148025; c=relaxed/simple;
	bh=8gjoT+TE/4gg0f+5avpPGOGc8AONIb5ifzKpT6ZXcwE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezzMY7eMv86Ynj8JViXlFGh//+hsTa6xjHbm90eJqoanQrdQEa6YDY8ZBoLf1LlbBqOqQeGtT9+c+OiID4569UBzeZvqN1h9tMzM73nGWpKh82gsxFCF2gfxd/A5OoyYRWPaoWp5/9GRkAYnEQeNHHBVg3+9XCoQsfclZ+3DcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2C4S76QU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j0ilQ40F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b77OsGwl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5h1qKUz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E94B41F81C;
	Fri, 31 May 2024 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BpUFTa1dewe3YkhU5VOZFY9dIPMuL7ZfkALMLa25ypg=;
	b=2C4S76QUkLnMyJhMS3n1JXtMaEMxmhlKGrNi5oOY9Iei0ux4xJEpSwUDIBu4OWB4EVi8Fc
	KT4wFnFgNNGHhRkVI+mo8lSTtBBXrQQ5ya8oU1/lgkFSu6bE5lVs0svSF0VItvQnw8OhJ6
	FQR1uLE7AdOyJiAJH/KBUabWBYoZrW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BpUFTa1dewe3YkhU5VOZFY9dIPMuL7ZfkALMLa25ypg=;
	b=j0ilQ40FCdAHLD0Ckw+QFwmO1U9OInYDiCMybIXTpUjXlKuawOD4PdXzA9978BHaNCS+6O
	Tmok1FhxgWXD66Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BpUFTa1dewe3YkhU5VOZFY9dIPMuL7ZfkALMLa25ypg=;
	b=b77OsGwlvfpGYJeQdsEuU0i1rdrN3nA8p45wXqKUe9MhscqB0SpPIAUeNmEFQeELMLviGt
	UgWZ3c/l0CYrdOSI0u1L8F3W6khOwDcb+WVj29z2oNgjFhPK7DmklGqKU7m/PPHCQx1ro5
	mgJoeHolbmO+hbwTrBgidiFssRwaZuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BpUFTa1dewe3YkhU5VOZFY9dIPMuL7ZfkALMLa25ypg=;
	b=y5h1qKUzsPEuaYo9RplJOsl+dgFCZHqjV+0toux2jIT8eqsdle6VNfYgPwwtuI/Xcf98Wz
	q5/UAZ0tq0QLP5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3088132C2;
	Fri, 31 May 2024 09:33:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FZAJL3OZWWZKHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:33:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/4] static key support for error injection functions
Date: Fri, 31 May 2024 11:33:31 +0200
Message-Id: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGuZWWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU2MD3bTE0pwS3cy8rNTkEqBa3eKSxJLM5OzUymJdM7MkcyMjo1RLwyR
 zJaABBUWpaZkVYMOjlYLcnJVia2sB0kvgPXEAAAA=
To: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5nkphuxq5kxo98ppmuqoc8wo)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Incomplete, help needed from ftrace/kprobe and bpf folks.

As previously mentioned by myself [1] and others [2] the functions
designed for error injection can bring visible overhead in fastpaths
such as slab or page allocation, because even if nothing hooks into them
at a given moment, they are noninline function calls regardless of
CONFIG_ options since commits 4f6923fbb352 ("mm: make should_failslab
always available for fault injection") and af3b854492f3
("mm/page_alloc.c: allow error injection").

Live patching their callsites has been also suggested in both [1] and
[2] threads, and this is an attempt to do that with static keys that
guard the call sites. When disabled, the error injection functions still
exist and are noinline, but are not being called. Any of the existing
mechanisms that can inject errors should make sure to enable the
respective static key. I have added that support to some of them but
need help with the others.

- the legacy fault injection, i.e. CONFIG_FAILSLAB and
  CONFIG_FAIL_PAGE_ALLOC is handled in Patch 1, and can be passed the
  address of the static key if it exists. The key will be activated if the
  fault injection probability becomes non-zero, and deactivated in the
  opposite transition. This also removes the overhead of the evaluation
  (on top of the noninline function call) when these mechanisms are
  configured in the kernel but unused at the moment.

- the generic error injection using kretprobes with
  override_function_with_return is handled in patch 2. The
  ALLOW_ERROR_INJECTION() annotation is extended so that static key
  address can be passed, and the framework controls it when error
  injection is enabled or disabled in debugfs for the function.

There are two more users I know of but am not familiar enough to fix up
myself. I hope people that are more familiar can help me here.

- ftrace seems to be using override_function_with_return from
  #define ftrace_override_function_with_return but I found no place
  where the latter is used. I assume it might be hidden behind more
  macro magic? But the point is if ftrace can be instructed to act like
  an error injection, it would also have to use some form of metadata
  (from patch 2 presumably?) to get to the static key and control it.

  If ftrace can only observe the function being called, maybe it
  wouldn't be wrong to just observe nothing if the static key isn't
  enabled because nobody is doing the fault injection?

- bpftrace, as can be seen from the example in commit 4f6923fbb352
  description. I suppose bpf is already aware what functions the
  currently loaded bpf programs hook into, so that it could look up the
  static key and control it. Maybe using again the metadata from patch 2,
  or extending its own, as I've noticed there's e.g. BTF_ID(func,
  should_failslab)

Now I realize maybe handling this at the k(ret)probe level would be
sufficient for all cases except the legacy fault injection from Patch 1?
Also wanted to note that by AFAIU by using the static_key_slow_dec/inc
API (as done in patches 1/2) should allow all mechanisms to coexist
naturally without fighting each other on the static key state, and also
handle the reference count for e.g. active probes or bpf programs if
there's no similar internal mechanism.

Patches 3 and 4 implement the static keys for the two mm fault injection
sites in slab and page allocators. For a quick demonstration I've run a
VM and the simple test from [1] that stresses the slab allocator and got
this time before the series:

real    0m8.349s
user    0m0.694s
sys     0m7.648s

with perf showing

   0.61%  nonexistent  [kernel.kallsyms]  [k] should_failslab.constprop.0
   0.00%  nonexistent  [kernel.kallsyms]  [k] should_fail_alloc_page                                                                                                                                                                                        ▒

And after the series

real    0m7.924s
user    0m0.727s
sys     0m7.191s

and the functions gone from perf report.

There might be other such fault injection callsites in hotpaths of other
subsystems but I didn't search for them at this point.

[1] https://lore.kernel.org/all/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
[2] https://lore.kernel.org/all/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (4):
      fault-inject: add support for static keys around fault injection sites
      error-injection: support static keys around injectable functions
      mm, slab: add static key for should_failslab()
      mm, page_alloc: add static key for should_fail_alloc_page()

 include/asm-generic/error-injection.h | 13 ++++++++++-
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/error-injection.h       |  9 +++++---
 include/linux/fault-inject.h          |  7 +++++-
 kernel/fail_function.c                | 22 +++++++++++++++---
 lib/error-inject.c                    |  6 ++++-
 lib/fault-inject.c                    | 43 ++++++++++++++++++++++++++++++++++-
 mm/fail_page_alloc.c                  |  3 ++-
 mm/failslab.c                         |  2 +-
 mm/internal.h                         |  2 ++
 mm/page_alloc.c                       | 11 ++++++---
 mm/slab.h                             |  3 +++
 mm/slub.c                             | 10 +++++---
 13 files changed, 114 insertions(+), 19 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240530-fault-injection-statickeys-66b7222e91b7

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


