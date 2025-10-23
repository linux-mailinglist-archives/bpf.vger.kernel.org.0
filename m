Return-Path: <bpf+bounces-71909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8327C0193C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC013B20DF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69EB31AF0E;
	Thu, 23 Oct 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijZFYtF7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O22eaDaE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zQ/9KIKM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVJOpUcu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC593164B7
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227585; cv=none; b=X74f1So7abQqPF4j2RjQbpIqax+HwDIRVvh5k0HuIRfl6l8Z3r397Yk3Qe04nZBUC3D1niv8PJ0dr/HUdBlRwtPsj8zYh1KsOyf9x+BgbyQHqezjQiHXLXJdvdHc/dQcPVlGc2k5Z/xU2zkCvvZekrpw7w0AUU13H3Pg7lIW40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227585; c=relaxed/simple;
	bh=dx7opFrLd1Mk3cu35sSZfp7B/OPv3yCTNKqWxGApXeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqqPHQHFlkFZ/bmJ9UGxeRoDzuSU8eXsLxSKjHHqOuVGvMmVgPy7qfO4UB5iaLvAOt9e1SajM7wn/86byOcXe171EatVsf3c11Ze0Yf2uUdYfgTV7D38hKvhUEmjS0NgSgduBDmXbkKEWTzggcoNcwZcjblLFJO053mCsgXljl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijZFYtF7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O22eaDaE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zQ/9KIKM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVJOpUcu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1401F211FA;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCq3wXn+tApmnVAfVNMGfQ1nbGBWrxbHUQ3MPoNIz/8=;
	b=ijZFYtF7h+Iw1klSJS7j+3zbM/IKAi2CPcIdhf6Ml7RaEhpT266VVb7Sm8HlMGIxa/6r+1
	gfQK+X8UYIBPbcT/9qF/6aiKIt44WIHG8kkGLcEziV4+BjO7oH6jQAG2hSlAt9+LkqrzaF
	FjdHMTulpuIw5aoa3qLhdd2ZwkzH4i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCq3wXn+tApmnVAfVNMGfQ1nbGBWrxbHUQ3MPoNIz/8=;
	b=O22eaDaE/e+xEw7r7E1LJzbqNZZsv1PSAhQCT2RDde9fzrun2lwr23v3vZwyyXOEj8/L5C
	/X5/5N8vTHn+9OAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCq3wXn+tApmnVAfVNMGfQ1nbGBWrxbHUQ3MPoNIz/8=;
	b=zQ/9KIKMawQebDjiH64guED/G61cvKvNBLfmQf1Cotiq3OsvSMA2EmNKoexFXqKAvzDldV
	D20vKQGrVutkBvsaeSdf10o187497/fnjdDdTj57iX7hHX0vsPW+0d8Vajc5xYddcc+Gjb
	o1j1QBKI4im1TQCQgILy/L5vTqp1qJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCq3wXn+tApmnVAfVNMGfQ1nbGBWrxbHUQ3MPoNIz/8=;
	b=GVJOpUcubdpiA+LZKWSyAdCmdUEP7uKm0KLKhKPX8bes/KQveEZzpGVnv3P0VKUx1Po/bW
	cZjggb93ufBHD3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7217136CF;
	Thu, 23 Oct 2025 13:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANIIODQz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:52 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 00/19] slab: replace cpu (partial) slabs with sheaves
Date: Thu, 23 Oct 2025 15:52:22 +0200
Message-Id: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYz+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3eKM1MSy1GLdtPwi3cScHF0Ls8RkQ+OUZBPzRFMloK6CotS0zAq
 widFKQW7OSrG1tQCIPxapZgAAAA==
X-Change-ID: 20251002-sheaves-for-all-86ac13dc47a5
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, Alexander Potapenko <glider@google.com>, 
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

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

This is the first RFC to get feedback. Biggest TODOs are:

- cleanup of stat counters to fit the new scheme
- integration of rcu sheaves handling with kfree_rcu batching
- performance evaluation

Git branch: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=b4/sheaves-for-all

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (19):
      slab: move kfence_alloc() out of internal bulk alloc
      slab: handle pfmemalloc slabs properly with sheaves
      slub: remove CONFIG_SLUB_TINY specific code paths
      slab: prevent recursive kmalloc() in alloc_empty_sheaf()
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

 include/linux/gfp_types.h |    6 -
 include/linux/slab.h      |    6 -
 mm/Kconfig                |   11 -
 mm/internal.h             |    1 +
 mm/page_alloc.c           |    5 +
 mm/slab.h                 |   47 +-
 mm/slub.c                 | 2601 ++++++++++++++++-----------------------------
 7 files changed, 915 insertions(+), 1762 deletions(-)
---
base-commit: 7b34bb10d15c412cdce0a1ea3b5701888b885673
change-id: 20251002-sheaves-for-all-86ac13dc47a5

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


