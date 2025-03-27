Return-Path: <bpf+bounces-54824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D6A734F6
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC423AD3F9
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E182185BD;
	Thu, 27 Mar 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELSsyA9U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549D1392;
	Thu, 27 Mar 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086910; cv=none; b=g8IvPhvPjbkZBr/HzF0zP84SJaf9qeLBGNvwP2fk5mESZpeV/+ds9saDH7YJeuSCDd1Lj1iYv0o2hM+D8HikwZfCvL6kT3rGddLW0Gp/xxK9QjwtEREPhhbM07TTJJm6Z9pBAL9WOXlhEF97oEtOwG7KnJCnXpqIsUzbQ7j9XPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086910; c=relaxed/simple;
	bh=srbg5hU/kX9GEqR+4GxYh6W7OhpBwZ2zLL+OHMRWn/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ad92Wq5+A2SX4alaC1tZgGKpAFL4GRUqODraVWIRojPkV43/4ZcbUeOoTf8q8XS+E4Zc2IuEE6RvhbNTjVzortPRQ0xSpc6KJHFEkNaNwuzhLDaVx1soOLhImn+h3xcEzqHNdmNk/FHjRZzANtyWwk2+A+fWYPA263qZbjuzj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELSsyA9U; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so7791386d6.1;
        Thu, 27 Mar 2025 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743086908; x=1743691708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9og7QHW7yZ4FvbucctyT5rc0uqSsMWzyqs7LNH+w4zk=;
        b=ELSsyA9UCL4z+6lZDleZRpgubDb8T6/n51moSdSNd7kKwee/6h8IGhaiGN32Zz1cOV
         apluqLdgW3OcDGGqRKxiuKBRDnwdotVZq6R/sU+yBSEJiSec3feCV/E2TBp0Ng+8rPGC
         a8p0zfqRRPVCE+ye2jzS+D+ntQF1rC1W6qcrtPl7blT7+L3EfTfhudai6yPJH9i3tkUp
         9ufTzs9qOWjScongbSfBo92M3wDe9A41+DjGJ8n7McoDW4Oo5vNevwBl3KAwB1sJpR/p
         r3GzqMOWM7lQE7t+epiuG7qxgtMmPgYsRA2kpEveZKGcJuvzQZChEarlSItmfSAi+5ix
         3WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086908; x=1743691708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9og7QHW7yZ4FvbucctyT5rc0uqSsMWzyqs7LNH+w4zk=;
        b=YXk/ymb6oJjyOlFRyHgLXmICr2M7OJQOi/Zb4D0BGdE6iVLzP3dZ1r6+1uUL8oPO3Z
         m/roOcZY02dCTLVrJvYXiiartv1j+jsbPrkHU3mIhELVOSFJYrkE405WBJaIMDKOc9hH
         6ZqJGdROxSvNJs2dNQG+nIU/42SaGMw3xH9GqASfTm5tsXF5xxFh7wD1QCDtGG12ULRi
         aKqGQdi6pBmdlV6vqBh+BYcuyc9doy7lACsq/Tqvf+FEMAH2KjN2b8G7Jl9zRqRoHrC7
         FUduAhp8ncnS2dTkFr+zrYBoXBye8qItggg3+K70bchSLcLKv4uujiCA95gL2rAE63Qy
         hoGw==
X-Forwarded-Encrypted: i=1; AJvYcCXlb5yK+x/uyDjA4zepNCdAps7OLb8XfCm/qfJcrYQci9mLy7JEGbv4oShUPpF8Oo90v1zSznrg3xH1BR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvX2fonxhl0S0wMNDaNFUkAJ1dEqRne4+dVVBklnJzB0RQpiT
	VgUpo43h1irmTi6DnzjuZ9n0OxOkpaynzafYw48d4JthdgD9JQZ/
X-Gm-Gg: ASbGnctIEY4vx4oKBMiJ2AC5I9RS7CqvJcjG73k5UGWLcuaxPR4ab4uvyBVyySpmHDO
	3VMLMByJLUyr4krcVx2gBHWHF7DX4lXDa9pRCE1xrzYIH3ORHN7jrq3XwaWCjUIENsbMrnImeYt
	tOSslgrUD5v799fz3fIquEYgs2201JMzjDodH/TtrWvpqkjayoSn83ZCSCtYrpF20b8pHFr1YQk
	c1j1Aq6uFFDvTAUrJX08PaZsqc8LS0ZeUNzTlCg9kq1rYZX2KD4+tPJpE4iClYlRKVDZwVtjSO6
	9J6GZuBi74NIWXHgfcr6BuB40joPIIfyDcNcX6NGZktF+RBBSOtIqUnSpw6/7pd8J238ieuoVuF
	SYjAIWpJg65w80FMvYRXQlcm/yGhzloE7vYQHY4tzTsgq0w==
X-Google-Smtp-Source: AGHT+IFZ0iTeup043Uaqa4k8vNniJp3yD6375e4R3nCqSubhPSwoSDkhZWAnx74Ht6mOe6vI5TarXg==
X-Received: by 2002:a05:6214:2483:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6ed2399af9emr61996706d6.42.1743086907453;
        Thu, 27 Mar 2025 07:48:27 -0700 (PDT)
Received: from localhost.localdomain (219.sub-174-198-10.myvzw.com. [174.198.10.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9645d1esm115796d6.35.2025.03.27.07.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Mar 2025 07:48:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	peterz@infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] BPF resilient spin_lock for 6.15
Date: Thu, 27 Mar 2025 10:48:23 -0400
Message-Id: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit ae0a457f5d33c336f3c4259a258f8b537531a04b:

  bpf: Make perf_event_read_output accessible in all program types. (2025-03-18 10:21:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_res_spin_lock

for you to fetch changes up to 6ffb9017e9329168b3b4216d15def8e78e1b1fac:

  Merge branch 'resilient-queued-spin-lock' (2025-03-19 08:03:06 -0700)

----------------------------------------------------------------
Please merge this pull request after main BPF changes.

This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
res_spin_lock() and res_spin_unlock() APIs).

This is a qspinlock variant which recovers the kernel from a stalled
state when the lock acquisition path cannot make forward progress. This
can occur when a lock acquisition attempt enters a deadlock situation
(e.g. AA, or ABBA), or more generally, when the owner of the lock (which
we’re trying to acquire) isn’t making forward progress.
Deadlock detection is the main mechanism used to provide instant recovery,
with the timeout mechanism acting as a final line of defense. Detection is
triggered immediately when beginning the waiting loop of a lock slow path.

Additionally, BPF programs attached to different parts of the kernel
can introduce new control flow into the kernel, which increases the
likelihood of deadlocks in code not written to handle reentrancy. There
have been multiple syzbot reports surfacing deadlocks in internal kernel
code due to the diverse ways in which BPF programs can be attached to
different parts of the kernel.  By switching the BPF subsystem’s lock
usage to rqspinlock, all of these issues are mitigated at runtime.

This spin lock implementation allows BPF maps to become safer and remove
mechanisms that have fallen short in assuring safety when nesting
programs in arbitrary ways in the same context or across different
contexts.

We run benchmarks that stress locking scalability and perform comparison
against the baseline (qspinlock). For the rqspinlock case, we replace
the default qspinlock with it in the kernel, such that all spin locks in
the kernel use the rqspinlock slow path. As such, benchmarks that stress
kernel spin locks end up exercising rqspinlock.

More details in the merge commit cover letter.

In this patchset we convert BPF hashtab, LPM, and percpu_freelist
to res_spin_lock:
  kernel/bpf/hashtab.c         | 102 ++++++++++++++++++++++++-----------
  kernel/bpf/lpm_trie.c        |  25 ++++++++++-----------
  kernel/bpf/percpu_freelist.c | 113 +++++++++++++++++------------------
  kernel/bpf/percpu_freelist.h |   4 ++--
  4 files changed, 73 insertions(+), 171 deletions(-)

Other BPF mechansims: queue_stack, local storage, ringbuf
will be converted in the follow-ups.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'resilient-queued-spin-lock'

Kumar Kartikeya Dwivedi (24):
      locking: Move MCS struct definition to public header
      locking: Move common qspinlock helpers to a private header
      locking: Allow obtaining result of arch_mcs_spin_lock_contended
      locking: Copy out qspinlock.c to kernel/bpf/rqspinlock.c
      rqspinlock: Add rqspinlock.h header
      rqspinlock: Drop PV and virtualization support
      rqspinlock: Add support for timeouts
      rqspinlock: Hardcode cond_acquire loops for arm64
      rqspinlock: Protect pending bit owners from stalls
      rqspinlock: Protect waiters in queue from stalls
      rqspinlock: Protect waiters in trylock fallback from stalls
      rqspinlock: Add deadlock detection and recovery
      rqspinlock: Add a test-and-set fallback
      rqspinlock: Add basic support for CONFIG_PARAVIRT
      rqspinlock: Add macros for rqspinlock usage
      rqspinlock: Add entry to Makefile, MAINTAINERS
      rqspinlock: Add locktorture support
      bpf: Convert hashtab.c to rqspinlock
      bpf: Convert percpu_freelist.c to rqspinlock
      bpf: Convert lpm_trie.c to rqspinlock
      bpf: Introduce rqspinlock kfuncs
      bpf: Implement verifier support for rqspinlock
      bpf: Maintain FIFO property for rqspinlock unlock
      selftests/bpf: Add tests for rqspinlock

 MAINTAINERS                                        |   2 +
 arch/arm64/include/asm/rqspinlock.h                |  93 +++
 arch/x86/include/asm/rqspinlock.h                  |  33 +
 include/asm-generic/Kbuild                         |   1 +
 include/asm-generic/mcs_spinlock.h                 |   6 +
 include/asm-generic/rqspinlock.h                   | 250 +++++++
 include/linux/bpf.h                                |  10 +
 include/linux/bpf_verifier.h                       |  19 +-
 kernel/bpf/Makefile                                |   2 +-
 kernel/bpf/btf.c                                   |  26 +-
 kernel/bpf/hashtab.c                               | 102 +--
 kernel/bpf/lpm_trie.c                              |  25 +-
 kernel/bpf/percpu_freelist.c                       | 113 +---
 kernel/bpf/percpu_freelist.h                       |   4 +-
 kernel/bpf/rqspinlock.c                            | 737 +++++++++++++++++++++
 kernel/bpf/rqspinlock.h                            |  48 ++
 kernel/bpf/syscall.c                               |   6 +-
 kernel/bpf/verifier.c                              | 248 +++++--
 kernel/locking/lock_events_list.h                  |   5 +
 kernel/locking/locktorture.c                       |  57 ++
 kernel/locking/mcs_spinlock.h                      |  10 +-
 kernel/locking/qspinlock.c                         | 193 +-----
 kernel/locking/qspinlock.h                         | 201 ++++++
 .../selftests/bpf/prog_tests/res_spin_lock.c       |  98 +++
 tools/testing/selftests/bpf/progs/irq.c            |  53 ++
 tools/testing/selftests/bpf/progs/res_spin_lock.c  | 143 ++++
 .../selftests/bpf/progs/res_spin_lock_fail.c       | 244 +++++++
 27 files changed, 2312 insertions(+), 417 deletions(-)
 create mode 100644 arch/arm64/include/asm/rqspinlock.h
 create mode 100644 arch/x86/include/asm/rqspinlock.h
 create mode 100644 include/asm-generic/rqspinlock.h
 create mode 100644 kernel/bpf/rqspinlock.c
 create mode 100644 kernel/bpf/rqspinlock.h
 create mode 100644 kernel/locking/qspinlock.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/res_spin_lock_fail.c

