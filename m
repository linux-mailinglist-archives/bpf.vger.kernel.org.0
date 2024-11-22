Return-Path: <bpf+bounces-45445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFDE9D58C2
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C20DB2294A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 03:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759D15B13C;
	Fri, 22 Nov 2024 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QteQ7s1o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D2A31;
	Fri, 22 Nov 2024 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247978; cv=none; b=WhXT226VyA2npeE7QAOkedpusWAiYX77sbnXw4MGQqbJpbiGHAmij/BZZV3Bl/5VjNgNRjk2hvB0v8b9929tnGnItxrpH3Y4FFw69UtKZ3YVMwlvnElw28XgDsgPlv3PXivCZtIM3es/JWhiMAEd4hbkf7eJ5o5q0o0RNdtEuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247978; c=relaxed/simple;
	bh=OLi4SqzR5SzIfTiMCGYx8+GjgOw02FBSpOAD4lu+xHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUINmdpRg1WmGtSHfPNRfsAMZDYCN95JqZOZInjYIaBUHrPUMvMsXuH/P0k6PRsoTbiw5g96Ex4iaxdRHASQFnS2lh5sNB6AzvcmlQJgC91pKIkHN2YfyzOYM/+412TzzzxhI+YqxrsnjJyhlSRcM2KnP7bVlFS5ttKGYCV2v6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QteQ7s1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D8AC4CECE;
	Fri, 22 Nov 2024 03:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732247977;
	bh=OLi4SqzR5SzIfTiMCGYx8+GjgOw02FBSpOAD4lu+xHM=;
	h=From:To:Cc:Subject:Date:From;
	b=QteQ7s1oRJNNSxaDT28yrtw6ZpTIDCC3Bnz7cwpKqEy47yp7lrHgGUVkrzUHFzTCf
	 yvRZEQlWkXcYX4SjdEzXWsvfM9JmXPGmFO4dn3GN2Rqg3fTQXH9qrFOVA4AytSD66q
	 4Vm/K7EEQRQl2ME75jZPp5q3P3CJaHXe1VoEz84SCRFPuU41rEwayAKmo4+TouIgA8
	 JZT6oPYb0ZQE4YJMMuyAtEjjUARRzrT3GsVNIaubiSm4LTjCZGy80V1xEaNlQZY5In
	 RFgqpA7CPI0ampH4G5c4cCAKOfZYjkG2i+sLwonjLAXvUMsFnnpZwA1wlVRexesHmP
	 NhdxKXkqo/d8w==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	mingo@kernel.org,
	torvalds@linux-foundation.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless VMA-to-uprobe lookup
Date: Thu, 21 Nov 2024 19:59:20 -0800
Message-ID: <20241122035922.3321100-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement speculative (lockless) resolution of VMA to inode to uprobe,
bypassing the need to take mmap_lock for reads, if possible. This series is
based on Suren's patch set [2], which adds mm_struct helpers that help detect
whether mm_struct was changed, which is used by uprobe logic to validate that
speculative results can be trusted after all the lookup logic results in
a valid uprobe instance.

Patch #1 is a simplification to uprobe VMA flag checking, suggested by Oleg.

Patch #2 is the speculative VMA-to-uprobe resolution logic itself, and is the
focal point of this patch set. It makes entry uprobes in common case scale
very well with number of CPUs, as we avoid any locking or cache line bouncing
between CPUs. See corresponding patch for details and benchmarking results.

Note, this patch set assumes that FMODE_BACKING files were switched to have
SLAB_TYPE_SAFE_BY_RCU semantics, which was recently done by Christian Brauner
in [0]. This change can be pulled into perf/core through stable
tags/vfs-6.13.for-bpf.file tag from [1].

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.13.for-bpf.file&id=8b1bc2590af61129b82a189e9dc7c2804c34400e
  [1] git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
  [2] https://lore.kernel.org/linux-mm/20241121162826.987947-1-surenb@google.com/

v4->v5:
- rebase on top of Suren's latest version of mm patches addressing Peter's
  comment and API renaming request;
v3->v4:
- rebased and dropped data_race(), given mm_struct uses real seqcount (Peter);
v2->v3:
- dropped kfree_rcu() patch (Christian);
- added data_race() annotations for fields of vma and vma->vm_file which could
  be modified during speculative lookup (Oleg);
- fixed int->long problem in stubs for mmap_lock_speculation_{start,end}(),
  caught by Kernel test robot;
v1->v2:
- adjusted vma_end_write_all() comment to point out it should never be called
  manually now, but I wasn't sure how ACQUIRE/RELEASE comments should be
  reworded (previously requested by Jann), so I'd appreciate some help there
  (Jann);
- int -> long change for mm_lock_seq, as agreed at LPC2024 (Jann, Suren, Liam);
- kfree_rcu_mightsleep() for FMODE_BACKING (Suren, Christian);
- vm_flags simplification in find_active_uprobe_rcu() and
  find_active_uprobe_speculative() (Oleg);
- guard(rcu)() simplified find_active_uprobe_speculative() implementation.

Andrii Nakryiko (2):
  uprobes: simplify find_active_uprobe_rcu() VMA checks
  uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

 kernel/events/uprobes.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
2.43.5


