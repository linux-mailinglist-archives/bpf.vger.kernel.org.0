Return-Path: <bpf+bounces-32540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEF90F95F
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0C01F23756
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D215B56D;
	Wed, 19 Jun 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kuMb1IX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="leW4/abu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0kuMb1IX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="leW4/abu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818C763EE;
	Wed, 19 Jun 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837386; cv=none; b=BUtKH6AfPFol5RrjnTuVC01SmXzFJMrxFfo/IOYgBis7g1D1cQPb9k8lF98agsMNVRmRKusUP2AVqXw/JVcaf6b0EpfyIytHG88GHuZEqfggCKZjH/y3FVT70uX3aaaXhhyF9jJR64I0B8D/Wa7Le3WjOHTJKgf+0u7Tpaxvm0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837386; c=relaxed/simple;
	bh=4IjoxBVzZJmS8JiLoh/wn1D8YQJR860b55ByDowIOwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lEXlBSU8K1cdcz5RJMV5tL5uWm28cR5QSEk5Y3B1WrK/ABuo0UQpvHL2rzuXbWvGeeJlm19MjxHfAiNo1RqCZhVxEaHJK0XmCHow48B1qLIGTKBTVIXtcJICR/kDojgwWlPaecnCUOGNr0majz+Fxm1YeDymU54tXikio4MRqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kuMb1IX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=leW4/abu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0kuMb1IX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=leW4/abu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 040621F7F4;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXpB9I+5sIqz/8cfuARZ+z0gS3Du0Q3fl0hF/OPBYr0=;
	b=0kuMb1IX53YoWWG6NQwAmpBBbCoWfiCcSkSoYNdt4Y2tVGUVtMqReM6P7WVMWLje5afdzL
	gTBk1LPZyVwOoaJ/4ATLqYnUVi/ZBUbnvcjtB5W9fxRHXtTLhZc0zllHNvhudft4INWBq4
	6cUEdFccxJQnRs1jizOPpXpbuVYXAG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXpB9I+5sIqz/8cfuARZ+z0gS3Du0Q3fl0hF/OPBYr0=;
	b=leW4/abuAMbJZKXYA5FC7Rvtk2vqI7C3h8HvkIOIlhDf5bUH4VtNPnzdHGU6dXIMBSqMFY
	DAc6UaYA3fpghBBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXpB9I+5sIqz/8cfuARZ+z0gS3Du0Q3fl0hF/OPBYr0=;
	b=0kuMb1IX53YoWWG6NQwAmpBBbCoWfiCcSkSoYNdt4Y2tVGUVtMqReM6P7WVMWLje5afdzL
	gTBk1LPZyVwOoaJ/4ATLqYnUVi/ZBUbnvcjtB5W9fxRHXtTLhZc0zllHNvhudft4INWBq4
	6cUEdFccxJQnRs1jizOPpXpbuVYXAG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXpB9I+5sIqz/8cfuARZ+z0gS3Du0Q3fl0hF/OPBYr0=;
	b=leW4/abuAMbJZKXYA5FC7Rvtk2vqI7C3h8HvkIOIlhDf5bUH4VtNPnzdHGU6dXIMBSqMFY
	DAc6UaYA3fpghBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D755613AAA;
	Wed, 19 Jun 2024 22:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLA9NIZgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/7] static key support for error injection functions
Date: Thu, 20 Jun 2024 00:48:54 +0200
Message-Id: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFZgc2YC/33NTQ6CMBCG4auQWTumLX/BlfcwLEoZZNSA6RQiE
 u5uJXHr8v0yeWYFIc8kcEpW8DSz8DjEMIcEXG+HKyG3scEok6k8VdjZ6RGQhxu5EG9Rgg3s7rQ
 IFkVTGmOo0k0JEXh66vi145c6ds8SRr/sv2b9XX+s/sfOGhXaXKddq2xV6Owsk9DRvaHetu0DW
 GvZg8IAAAA=
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7736; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=4IjoxBVzZJmS8JiLoh/wn1D8YQJR860b55ByDowIOwo=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2BvLfdBJBx+By0E8GucZ2g3HKfEDKvwS2a6W
 RrMarTnnZWJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNgbwAKCRC74LB10kWI
 mubbB/9ggQg7IyMs277d/YJixrb73JU0tGXDmVRKqN5ZEoUbPbePJxRWpbPFf6kbPd7fuDr9YMF
 i0P2Pa+51BmvSuUnapmvQvviFUuHp8Ki7ccalMCOPz+XgGUwxe4NJWSJNOHPilzIVv+mjl4RFj2
 b05718jRByStx4iVIrz36mrp4sQNXOL2ZcP7cHGAlXoEAIiKN5SCL5NFlDyoRGh8wGPRT6f1aBm
 /gAuKeIznJTeLN+gmDk9PCV87cWQDR0Kq0pTFM4dW1sSWBu/iwxjs4sK5rzJuRUG1xAShRNeFQz
 6OF0xI1VH4lRkSl4LUDR2hczd85Nw+nzw2r5m/DI4tgxtQsK
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]

This should now be complete, but perf_events attached bpf programs are
untested (Patch 3).
This is spread accross several subsystems but the easiest way would be
to go through a single tree, such as the mm tree.

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
respective static key. I have added that support to hopefully all of
them that can be used today.

- the legacy fault injection, i.e. CONFIG_FAILSLAB and
  CONFIG_FAIL_PAGE_ALLOC is handled in Patch 1, and can be passed the
  address of the static key if it exists. The key will be activated if the
  fault injection probability becomes non-zero, and deactivated in the
  opposite transition. This also removes the overhead of the evaluation
  (on top of the noninline function call) when these mechanisms are
  configured in the kernel but unused at the moment.

- the generic error injection using kretprobes with
  override_function_with_return is handled in Patch 2. The
  ALLOW_ERROR_INJECTION() annotation is extended so that static key
  address can be passed, and the framework controls it when error
  injection is enabled or disabled in debugfs for the function.

- bpf programs can override return values of probed functions with
  CONFIG_BPF_KPROBE_OVERRIDE=y and have prog->kprobe_override=1. They
  can be attached to perf_event, which is handled in Patch 3, or via
  multi_link_attach, which is handled in Patch 4. I have tested the
  latter using a modified bcc program from commit 4f6923fbb352
  description, but not Patch 3 using a perf_event - testing is welcome.

- ftrace seems to be using override_function_with_return from
  #define ftrace_override_function_with_return but there appear to be
  no users, which was confirmed by Mark Rutland in the RFC thread.

If anyone was crazy enough to use multiple of mechanisms above
simultaneously, the usage of static_key_slow_inc/dec will do the right
thing and the key will be enabled iff at least one mechanism is active.

Additionally to the static key support, Patch 5 makes it possible to
stop making the fault injection functions noninline with
CONFIG_FUNCTION_ERROR_INJECTION=n by compiling out the BTF_ID()
references for bpf_non_sleepable_error_inject which are unnecessary in
that case.

Patches 6 and 7 implement the static keys for the two mm fault injection
sites in slab and page allocators. I have measured the improvement for
the slab case, as described in Patch 6:

    To demonstrate the reduced overhead of calling an empty
    should_failslab() function, a kernel build with
    CONFIG_FUNCTION_ERROR_INJECTION enabled but CONFIG_FAILSLAB disabled,
    and CPU mitigations enabled, was used in a qemu-kvm (virtme-ng) on AMD
    Ryzen 7 2700 machine, and execution of a program trying to open() a
    non-existent file was measured 3 times:

        for (int i = 0; i < 10000000; i++) {
            open("non_existent", O_RDONLY);
        }

    After this patch, the measured real time was 4.3% smaller. Using perf
    profiling it was verified that should_failslab was gone from the
    profile.

    With CONFIG_FAILSLAB also enabled, the patched kernel performace was
    unaffected, as expected, while unpatched kernel's performance was worse,
    resulting in the relative speedup being 10.5%. This means it no longer
    needs to be an option suitable only for debug kernel builds.

There might be other such fault injection callsites in hotpaths of other
subsystems but I didn't search for them at this point. With all the
preparations in place, it should be simple to improve them now.

FAQ:

Q: Does this improve only config options nobody uses in production
anyway?

A: No, the error injection hooks are unconditionally noninline functions
even if they are empty. CONFIG_FUNCTION_ERROR_INJECTION=y is probably
rather common, and overrides done via bpf. The goal was to eliminate
this unnecessary overhead. But as a secondary benefit now the legacy
fault injection options can be also enabled in production kernels
without extra overhead.

Q: Should we remove the legacy fault injection framework?

A: Maybe? I didn't want to wait for that to happen, so it's just handled
as well (Patch 1). The generic error injection handling and bpf needed
the most effort anyway.

Q: Should there be a unified way to register the kprobes that override
return values, that would also handle the static key control?

A: Possibly, but I'm not familiar with the area enough to do that. I
found every case handled by patches 2-4 to be so different, I just
modified them all. If a unification comes later, it should not change
most of what's done by this patchset.

[1] https://lore.kernel.org/6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz/
[2] https://lore.kernel.org/3j5d3p22ssv7xoaghzraa7crcfih3h2qqjlhmjppbp6f42pg2t@kg7qoicog5ye/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
- Add error injection static key control for bpf programs with
  kprobe_override.
- Add separate get_injection_key() for querying (Masami Hiramatsu)
- Compile everything out with CONFIG_FUNCTION_ERROR_INJECTION=n
- Link to v1: https://lore.kernel.org/r/20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz

---
Vlastimil Babka (7):
      fault-inject: add support for static keys around fault injection sites
      error-injection: support static keys around injectable functions
      bpf: support error injection static keys for perf_event attached progs
      bpf: support error injection static keys for multi_link attached progs
      bpf: do not create bpf_non_sleepable_error_inject list when unnecessary
      mm, slab: add static key for should_failslab()
      mm, page_alloc: add static key for should_fail_alloc_page()

 include/asm-generic/error-injection.h | 13 ++++++-
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/error-injection.h       | 12 +++++--
 include/linux/fault-inject.h          | 14 ++++++--
 kernel/bpf/verifier.c                 | 15 ++++++++
 kernel/fail_function.c                | 10 ++++++
 kernel/trace/bpf_trace.c              | 65 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_kprobe.c           | 30 ++++++++++++++--
 kernel/trace/trace_probe.h            |  5 +++
 lib/error-inject.c                    | 19 ++++++++++
 lib/fault-inject.c                    | 43 ++++++++++++++++++++++-
 mm/fail_page_alloc.c                  |  3 +-
 mm/failslab.c                         |  2 +-
 mm/internal.h                         |  2 ++
 mm/page_alloc.c                       | 30 ++++++++++++++--
 mm/slab.h                             |  3 ++
 mm/slub.c                             | 30 ++++++++++++++--
 17 files changed, 274 insertions(+), 24 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240530-fault-injection-statickeys-66b7222e91b7

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


