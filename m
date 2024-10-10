Return-Path: <bpf+bounces-41641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9679993FC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9450F1F242BF
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EDF1E230A;
	Thu, 10 Oct 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwEBw6JN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD261CF5C5;
	Thu, 10 Oct 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593807; cv=none; b=Ej62bq6h9wah1ED1xDIDElWI+zD6cbIahBL5E5lBidkLwpiX0DZn6SuZdBRDA/sNBYpVmKizGba35T6tNGwEfByKiJeA1iGe/q2bxqKxCKX+ns7LYsOwZ7uLD2bRNXzWV1Bx7K3VDxSBdll8S6wfVAWLbvLVkj2ckJ9Sa6Ao8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593807; c=relaxed/simple;
	bh=tH2HcY6rQCU/6gQa+L+AuOeDayO0u2RWtUN85rJcHWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=si7DD8OmpBQ07BKfAfvcfHOrMuMyIcMShRON24NwNF43UE9v6RNyI7pmqJnHJY/XhGPStEUbvVMmcWQ7vjFeA6fMsBKG7UnvNHsRFq0XjpKuZ0c40Eiga07QU7RJEvOVq2xL9AfAXl/uUKj1C0QNMVWqHY5xUPMrsb/lHOrGjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwEBw6JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E578C4CEC5;
	Thu, 10 Oct 2024 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728593807;
	bh=tH2HcY6rQCU/6gQa+L+AuOeDayO0u2RWtUN85rJcHWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jwEBw6JNnDAvo+Nn7aTkh4T4g/t7dFkecxwENqt8tBspsVmoIQTPH3Rj5ZaGeD2ot
	 4lAzUUe+VjltpHrOZU71opy9pNO5sNyn+b0u3HoQwz/RQfipK/pTVW6tfk5Jqns/Kx
	 ZdJFic+C1Nk0/Mr+xyWEeeHVC9M5Rt7PnkxRsl2ISKWs12ze4cbX4UuzP7XQsz9LJ+
	 dXIpCOMOmFendm65S9btudipga7Azw1ppGlX8zAjhS8SDwBV2wy8PLGlQoIGraiFQZ
	 o5Sqovdcm72UElzAyvgM7DaE2c3Nc/YOi2LyTGNLI8NzKCTc4YdsbDQr1rOkYnf/Bl
	 IDN3rQK9H5Ogg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterz@infradead.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 tip/perf/core 0/4] uprobes,mm: speculative lockless VMA-to-uprobe lookup
Date: Thu, 10 Oct 2024 13:56:40 -0700
Message-ID: <20241010205644.3831427-1-andrii@kernel.org>
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
bypassing the need to take mmap_lock for reads, if possible. Patch #1 by Suren
adds mm_struct helpers that help detect whether mm_struct was changed, which
is used by uprobe logic to validate that speculative results can be trusted
after all the lookup logic results in a valid uprobe instance. Patch #2
follows to make mm_lock_seq into 64-bit counter (on 64-bit architectures), as
requested by Jann Horn.

Patch #3 is a simplification to uprobe VMA flag checking, suggested by Oleg.

And, finally, patch #4 is the speculative VMA-to-uprobe resolution logic
itself, and is the focal point of this patch set. It makes entry uprobes in
common case scale very well with number of CPUs, as we avoid any locking or
cache line bouncing between CPUs. See corresponding patch for details and
benchmarking results.

Note, this patch set assumes that FMODE_BACKING files were switched to have
SLAB_TYPE_SAFE_BY_RCU semantics, which was recently done by Christian Brauner
in [0]. This change can be pulled into perf/core through stable
tags/vfs-6.13.for-bpf.file tag from [1].

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.13.for-bpf.file&id=8b1bc2590af61129b82a189e9dc7c2804c34400e
  [1] git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

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

Andrii Nakryiko (3):
  mm: switch to 64-bit mm_lock_seq/vm_lock_seq on 64-bit architectures
  uprobes: simplify find_active_uprobe_rcu() VMA checks
  uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

Suren Baghdasaryan (1):
  mm: introduce mmap_lock_speculation_{start|end}

 include/linux/mm.h        |  6 ++--
 include/linux/mm_types.h  |  7 ++--
 include/linux/mmap_lock.h | 72 ++++++++++++++++++++++++++++++++-------
 kernel/events/uprobes.c   | 52 +++++++++++++++++++++++++++-
 kernel/fork.c             |  3 --
 5 files changed, 119 insertions(+), 21 deletions(-)

-- 
2.43.5


