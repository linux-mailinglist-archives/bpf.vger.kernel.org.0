Return-Path: <bpf+bounces-79267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D7D32CB7
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FA233072EFD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C1393DFB;
	Fri, 16 Jan 2026 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2cXZQcE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQqovt8b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W2cXZQcE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQqovt8b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3863933E3
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574443; cv=none; b=BtXhzzOxfkjnOVBeA/I2HLDXpDVEubacay3H9bfbwcBimQPU1wrOZjadsK2757NLi6BL9BZBdj//kMMMDNVJa1SujY75ohi0ZN3R6jjyoXqYMW9maioayQE7HtdjFgk7lVqa7nkNrl3vKHHuKt/iBicKVvNKiGhMYydwEeE0qLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574443; c=relaxed/simple;
	bh=JZcEFwJ6RAjn5Bni337pJYN+ViD4/3sb2QCcQVYuJWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uBG7Uy8hMJD2GslWIWiwtJXnkDnOVMjqLOZjUw8pQ2sgRw9F/5dNvE5Q2D9ChWnFptwvGiCWp0WqjC9POhpFjzV4+IAJ/bz791CpYW727JrRiFQ89E0pHeOKW4SaHa5sam+o0UmnKISrGku45D1NyM0NXey5vfm8RqBlAt7ROtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2cXZQcE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQqovt8b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W2cXZQcE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQqovt8b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C65233789;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D8kSMH2gta+Yma3QMnDCuvguK/0toKW9byQx/lVBXFU=;
	b=W2cXZQcEu58tSojqQz9KrhUQuTTHIf2SZB58nYl5bifW0498hXY2R8FUkgVcUCV3D4aHSc
	7Vp96ID2AwEdP+Oq8p6TTHOsU6eNo2KQ9+IKdfqboaDiIF+T37UWYQvfa+Fw7ZGNPduSSj
	wppsJ6GqSXVZEsXbtfGkwnbrK81hX34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D8kSMH2gta+Yma3QMnDCuvguK/0toKW9byQx/lVBXFU=;
	b=mQqovt8blj77FthhSHtvbjI5Mo4ea5I324sOFniBk/DkDhDDHK0u7NoVURt7NmD9/e1Ur1
	KiJ38IwZcc3cRBDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W2cXZQcE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mQqovt8b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D8kSMH2gta+Yma3QMnDCuvguK/0toKW9byQx/lVBXFU=;
	b=W2cXZQcEu58tSojqQz9KrhUQuTTHIf2SZB58nYl5bifW0498hXY2R8FUkgVcUCV3D4aHSc
	7Vp96ID2AwEdP+Oq8p6TTHOsU6eNo2KQ9+IKdfqboaDiIF+T37UWYQvfa+Fw7ZGNPduSSj
	wppsJ6GqSXVZEsXbtfGkwnbrK81hX34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D8kSMH2gta+Yma3QMnDCuvguK/0toKW9byQx/lVBXFU=;
	b=mQqovt8blj77FthhSHtvbjI5Mo4ea5I324sOFniBk/DkDhDDHK0u7NoVURt7NmD9/e1Ur1
	KiJ38IwZcc3cRBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A2D3EA63;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sj7VEORNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 00/21] slab: replace cpu (partial) slabs with sheaves
Date: Fri, 16 Jan 2026 15:40:20 +0100
Message-Id: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVNamkC/2WOQQ6CMBBFr0K6tqYdKIIr72Fc1GEqTQiQjjYq4
 e4WonHB8k3y3p9JMAVPLI7ZJAJFz37oE+S7TGBr+xtJ3yQWoMBopUBySzYSSzcEabtOVqVFnTd
 YHKwRyRoDOf9ci+dL4tbzfQivdSDq5fptQb5pRS2VLJ2zgHVdaFQnfjDt8S2WUoSfXSqtt59ES
 HZdARh0V6PQ/e15nj//IYhq6gAAAA==
X-Change-ID: 20251002-sheaves-for-all-86ac13dc47a5
To: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz,intel.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C65233789
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Percpu sheaves caching was introduced as opt-in but the goal was to
eventually move all caches to them. This is the next step, enabling
sheaves for all caches (except the two bootstrap ones) and then removing
the per cpu (partial) slabs and lots of associated code.

Besides (hopefully) improved performance, this removes the rather
complicated code related to the lockless fastpaths (using
this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
kmalloc_nolock().

The lockless slab freelist+counters update operation using
try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
without repeating the "alien" array flushing of SLUB, and to allow
flushing objects from sheaves to slabs mostly without the node
list_lock.

This v3 is the first non-RFC (for real). I plan to expose the series to
linux-next at this point. Because of the ongoing troubles with
kmalloc_nolock() that are solved with sheaves, I think it's worth aiming
for 7.0 if it passes linux-next testing.

Git branch for the v3
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=sheaves-for-all-v3

Which is a snapshot of:
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/sheaves-for-all

Based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-7.0/sheaves
  - includes a sheaves optimization that seemed minor but there was lkp
    test robot result with significant improvements:
    https://lore.kernel.org/all/202512291555.56ce2e53-lkp@intel.com/
    (could be an uncommon corner case workload though)
  - includes the kmalloc_nolock() fix commit a4ae75d1b6a2 that is undone
    as part of this series

Significant (but not critical) remaining TODOs:
- Integration of rcu sheaves handling with kfree_rcu batching.
  - Currently the kfree_rcu batching is almost completely bypassed. I'm
    thinking it could be adjusted to handle rcu sheaves in addition to
    individual objects, to get the best of both.
- Performance evaluation. Petr Tesarik has been doing that on the RFC
  with some promising results (thanks!) and also found a memory leak.

Note that as many things, this caching scheme change is a tradeoff, as
summarized by Christoph:

  https://lore.kernel.org/all/f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org/

- Objects allocated from sheaves should have better temporal locality
  (likely recently freed, thus cache hot) but worse spatial locality
  (likely from many different slabs, increasing memory usage and
  possibly TLB pressure on kernel's direct map).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v3:
- Rebase to current slab/for-7.0/sheaves which itself is rebased to
  slab/for-next-fixes to include commit a4ae75d1b6a2 ("slab: fix
  kmalloc_nolock() context check for PREEMPT_RT")
- Revert a4ae75d1b6a2 as part of "slab: simplify kmalloc_nolock()" as
  it's no longer necessary.
- Add cache_has_sheaves() helper to test for s->sheaf_capacity, use it
  in more places instead of s->cpu_sheaves tests that were missed
  (Hao Li)
- Fix a bug where kmalloc_nolock() could end up trying to allocate empty
  sheaf (not compatible with !allow_spin) in __pcs_replace_full_main()
  (Hao Li)
- Fix missing inc_slabs_node() in ___slab_alloc() ->
  alloc_from_new_slab() path. (Hao Li)
  - Also a bug where refill_objects() -> alloc_from_new_slab ->
    free_new_slab_nolock() (previously defer_deactivate_slab()) would
    do inc_slabs_node() without matching dec_slabs_node()
- Make __free_slab call free_frozen_pages_nolock() when !allow_spin.
  This was correct in the first RFC. (Hao Li)
- Add patch to make SLAB_CONSISTENCY_CHECKS prevent merging.
- Add tags from sveral people (thanks!)
- Fix checkpatch warnings.
- Link to v2: https://patch.msgid.link/20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz

Changes in v2:
- Rebased to v6.19-rc1+slab.git slab/for-7.0/sheaves
  - Some of the preliminary patches from the RFC went in there.
- Incorporate feedback/reports from many people (thanks!), including:
  - Make caches with sheaves mergeable.
  - Fix a major memory leak.
- Cleanup of stat items.
- Link to v1: https://patch.msgid.link/20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz

---
Vlastimil Babka (21):
      mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
      slab: add SLAB_CONSISTENCY_CHECKS to SLAB_NEVER_MERGE
      mm/slab: move and refactor __kmem_cache_alias()
      mm/slab: make caches with sheaves mergeable
      slab: add sheaves to most caches
      slab: introduce percpu sheaves bootstrap
      slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
      slab: handle kmalloc sheaves bootstrap
      slab: add optimized sheaf refill from partial list
      slab: remove cpu (partial) slabs usage from allocation paths
      slab: remove SLUB_CPU_PARTIAL
      slab: remove the do_slab_free() fastpath
      slab: remove defer_deactivate_slab()
      slab: simplify kmalloc_nolock()
      slab: remove struct kmem_cache_cpu
      slab: remove unused PREEMPT_RT specific macros
      slab: refill sheaves from all nodes
      slab: update overview comments
      slab: remove frozen slab checks from __slab_free()
      mm/slub: remove DEACTIVATE_TO_* stat items
      mm/slub: cleanup and repurpose some stat items

 include/linux/slab.h |    6 -
 mm/Kconfig           |   11 -
 mm/internal.h        |    1 +
 mm/page_alloc.c      |    5 +
 mm/slab.h            |   53 +-
 mm/slab_common.c     |   61 +-
 mm/slub.c            | 2631 +++++++++++++++++---------------------------------
 7 files changed, 972 insertions(+), 1796 deletions(-)
---
base-commit: aa2ab7f1e8dc9d27b9130054e48b0c6accddfcba
change-id: 20251002-sheaves-for-all-86ac13dc47a5

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


