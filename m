Return-Path: <bpf+bounces-54825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C9A734FE
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC6B7A735D
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3B21885D;
	Thu, 27 Mar 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbqqRtBG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957A217F34;
	Thu, 27 Mar 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087126; cv=none; b=mFu0giv7VphMghZS7vceHOBSleH8kh3adFb6VnAZSOW8k7I9lfYF15bPLo0obj0bbG5krlRpZwUoMvMRroBGqxkpIgleyNl5C6KJx2Y1X8ObqjPGxgP2qiWX/t2p3hTFmpb9ebgov0M1TtS8heq0QJQkfqmRC1JQhnFq2NYQRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087126; c=relaxed/simple;
	bh=ulbvVnd77hM9vOG8fiI1yJo51l2mFcG5ZH2o5D+8nyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cCneDAUDdDr/axfn/BuTqS3wxz4vK13GFg37KMQVdyPguQAQ+PhDEQvQ7Q2+lhF2LcUqRoqT1B3rgSNcB23sgCiJrbWnfvS3Bgg0kw+AnUCOcOpe5uZx98iQ1p8HFdxmjO7A79Xiaruwai+D6Os/mcJlypbhn+YxRjuNJR0E7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbqqRtBG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8f8657f29so8058766d6.3;
        Thu, 27 Mar 2025 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743087124; x=1743691924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6F0q/kxgMh4HTjwgKMB6A+5VY81dq/P/Rx36ntiQZRI=;
        b=SbqqRtBGoMkMQk6nJZVodpugEMKmk3ZaM4p7DrZt2GNxQIeV6JHuKXCltOwvisf4gU
         g9T6cemu0f0EHIF2X7fS81adn+gBK4FRuj1lrmCKFbMDyXiCxrJIEQXJmvbjnqqcmiC1
         /Zg/UgLffAMwx+sMh6aAkqbJ9SNI5U9K2WEMpAOxnZgK54Bh6h36K4Otdr9I2LjTcaZX
         HkZiGqfb86DPli/QXFUe/mLvivMQFm/EVGyt5aUxQggLpBZO1uUI+3MNZgQ2QsMQ8HCN
         YoQevocBjjgZqQAnqNvobBfJMjEy0H8s/tl3mgZ2lwTzlh69Ef3PWSwO6QVlfxadKp4i
         ZmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087124; x=1743691924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F0q/kxgMh4HTjwgKMB6A+5VY81dq/P/Rx36ntiQZRI=;
        b=QytrbIiUCZ2je3gkm1+pYnLsdeH547hZI/WA80G0xxpIM4oDMtNy/1cCnjAzXyNZc2
         5ZkH4k/0Ymy0s+wT5Lb+tD29vX7QMpi8Kf9SUzw8vN7RXbp3Pch6Q7MLHMB25IgaN2p0
         7LU/hZE5PhcSGID6qKmtRnwKbeTfL/IWd9ymtvXTncnHnkwuLx2PTcqnGiJlmnJ2EKnW
         5oOSiDsOVFfYJ7Rsl681zmGp559H3oQ9r0hrtQTMumyjh7vXN67aobCBqjaT2AFBybCC
         1hWEP8qq//eHVpQ3IFpl+5KoX8d8JRH0jIEXQPG7y4JF9/QlsSN6zTpHxsG5V+AqGpW+
         h81Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPxJr1ZFhQQvZ3+Z4hJSSwEhSdFOWnkuYVHIOpUMfDmkgi6spapEowLg+mpWInxRKUywJweqRqO/Y83AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUPMZwEtpve60YEsA+Y931hMZlqOlwk7ffBaauGmZpzkrAZgr
	RdFB+JZBPf4EM2ZrW+vHIIhMnz5thBH18SOBbVrVsgr/c1cz/SvH8H4mFlS7
X-Gm-Gg: ASbGncv6V9nt1mhbyHUPJ9LOaIxL+d4djziEo3p3AkSi7Nu39DpvUujffVoee5+rs5Q
	lQ9K8YJTmOnMaT6pivgKJfG8WPq89Vm2mLs7boFltPSEBiOHcRBevQX0z2lcboR8yMYtX0pvM4e
	1SVoOSC7zSJ2bkl/0ndG9DyEP/8zbO3uiFIpYth/ES9C1bvmv6wCg8jAhuv60FMvdxXKPJ7yl5x
	hsQlWua1+Q8FHtmcu4hyfjTU/r1htPWtm3/f8dhnB0egvNTEL88ZSTYfA1e1177YoqN3eGRnWJM
	VTWleY+SSFib668d7AHoaKYL8c/ZhT116riBpVlZAh4n8/p4cy8uMh7YLfLuWeY6nO23hgYSMwf
	7gDdmhtMpKZOtjcSy5pZprW4Yka+Jm2/TduI=
X-Google-Smtp-Source: AGHT+IEoG/2aSIZRRI3VLRjKxgjxIVKISbF3fSEXZY9id3JPyrhW2IqRCw1GyMaQcZXfUYjfPwUUVA==
X-Received: by 2002:a05:6214:1d02:b0:6e8:f4e2:26ef with SMTP id 6a1803df08f44-6ed23904822mr59197876d6.31.1743087123789;
        Thu, 27 Mar 2025 07:52:03 -0700 (PDT)
Received: from localhost.localdomain (219.sub-174-198-10.myvzw.com. [174.198.10.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec965a40bsm181656d6.61.2025.03.27.07.52.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Mar 2025 07:52:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	mhocko@suse.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Introduce try_alloc_pages for 6.15
Date: Thu, 27 Mar 2025 10:51:59 -0400
Message-Id: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/bpf_try_alloc_pages

for you to fetch changes up to f90b474a35744b5d43009e4fab232e74a3024cae:

  mm: Fix the flipped condition in gfpflags_allow_spinning() (2025-03-15 11:18:19 -0700)

----------------------------------------------------------------
Please pull after main MM changes.

The pull includes work from Sebastian, Vlastimil and myself
with a lot of help from Michal and Shakeel.
This is a first step towards making kmalloc reentrant to get rid
of slab wrappers: bpf_mem_alloc, kretprobe's objpool, etc.
These patches make page allocator safe from any context.

Vlastimil kicked off this effort at LSFMM 2024:
https://lwn.net/Articles/974138/
and we continued at LSFMM 2025:
https://lore.kernel.org/all/CAADnVQKfkGxudNUkcPJgwe3nTZ=xohnRshx9kLZBTmR_E1DFEg@mail.gmail.com/

Why:
SLAB wrappers bind memory to a particular subsystem
making it unavailable to the rest of the kernel.
Some BPF maps in production consume Gbytes of preallocated
memory. Top 5 in Meta: 1.5G, 1.2G, 1.1G, 300M, 200M.
Once we have kmalloc that works in any context BPF map
preallocation won't be necessary.

How:
Synchronous kmalloc/page alloc stack has multiple
stages going from fast to slow:
cmpxchg16 -> slab_alloc -> new_slab -> alloc_pages ->
rmqueue_pcplist -> __rmqueue.
rmqueue_pcplist was already relying on trylock.
This set changes rmqueue_bulk/rmqueue_buddy to attempt
a trylock and return ENOMEM if alloc_flags & ALLOC_TRYLOCK.
Then it wraps this functionality into try_alloc_pages() helper.
We make sure that the logic is sane in PREEMPT_RT.
End result: try_alloc_pages()/free_pages_nolock() are
safe to call from any context.
try_kmalloc() for any context with similar trylock
approach will follow. It will use try_alloc_pages()
when slab needs a new page.
Though such try_kmalloc/page_alloc() is an opportunistic
allocator, this design ensures that the probability of
successful allocation of small objects (up to one
page in size) is high.

Even before we have try_kmalloc(), we already use
try_alloc_pages() in BPF arena implementation and it's
going to be used more extensively in BPF.

Once the set was applied to bpf-next we ran into two
two small conflicts with MM tree as reported by Stephen:
https://lore.kernel.org/bpf/20250311120422.1d9a8f80@canb.auug.org.au/
https://lore.kernel.org/bpf/20250312145247.380c2aa5@canb.auug.org.au/

So Andrew suggested to keep thing as-is instead of moving
patchset between the trees before merge window:
https://lore.kernel.org/all/20250317132710.fbcde1c8bb66f91f36e78c89@linux-foundation.org/

Note "locking/local_lock: Introduce localtry_lock_t" patch is
later used in Vlastimil's sheaves and in Shakeel's changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (6):
      mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
      mm, bpf: Introduce free_pages_nolock()
      memcg: Use trylock to access memcg stock_lock.
      mm, bpf: Use memcg in try_alloc_pages().
      bpf: Use try_alloc_pages() to allocate pages for bpf needs.
      Merge branch 'bpf-mm-introduce-try_alloc_pages'

Sebastian Andrzej Siewior (1):
      locking/local_lock: Introduce localtry_lock_t

Vlastimil Babka (1):
      mm: Fix the flipped condition in gfpflags_allow_spinning()

 include/linux/bpf.h                 |   2 +-
 include/linux/gfp.h                 |  23 ++++
 include/linux/local_lock.h          |  70 +++++++++++++
 include/linux/local_lock_internal.h | 146 ++++++++++++++++++++++++++
 include/linux/mm_types.h            |   4 +
 include/linux/mmzone.h              |   3 +
 kernel/bpf/arena.c                  |   5 +-
 kernel/bpf/syscall.c                |  23 +++-
 lib/stackdepot.c                    |  10 +-
 mm/internal.h                       |   1 +
 mm/memcontrol.c                     |  53 +++++++---
 mm/page_alloc.c                     | 203 +++++++++++++++++++++++++++++++++---
 mm/page_owner.c                     |   8 +-
 13 files changed, 509 insertions(+), 42 deletions(-)

