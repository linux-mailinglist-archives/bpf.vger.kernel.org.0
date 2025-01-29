Return-Path: <bpf+bounces-49999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A77A21592
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999DB1888664
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F57166F1A;
	Wed, 29 Jan 2025 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsGmjapE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A22155316
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110280; cv=none; b=X7LXCfwlzj2dlpIoEvzN5AYDJgvWUGmyl/bpXAaCnrWOkcTpawVRNCISNTKkwco4aDeTTmpez2Hhf3ABj43/9QZF6VZfFSMtcbo5jCATp4WGwr2qeFWNuQawCsVCV42EwdORNu1WeDb7jKtD7FOyhrLaQpHYJXO3nG39MITYTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110280; c=relaxed/simple;
	bh=Tye1ZieSPZQmo1mo8HoGA/TZnzVuj35yU1agRawQNig=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VKmCwmRupLE6bok6UaF5M9nNNpHaI9/XstfzAmvE1G5laO5p4pf6rIthsVFEtEhqYdXquDFmvLBBWZylpHFaKGGId7QSGEL2zL5U+ePZtH0yRZ81W0NhQZRgT0T8ES/igNAQ2I0j+B2OpS/bH7IcW3J9BZrQJ9a15BBZKo+mNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsGmjapE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2166e907b5eso114970535ad.3
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 16:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738110277; x=1738715077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ss8IRXPQuROgaPFI2n/Tn6B8Bw+CUwUeulj0ny/+twg=;
        b=GsGmjapEEJ/0wGZtTJxA+D1u9QFOr1MF34ClDsqzNCV0X6lsB6sY3j8m8p60OWDK6R
         9u4SY+WKn6d+OilWjmXBPsP7xDZfZcXCOmCsz1uE3RkgjKK/YpSXVIoe7DqPp4D7hGgQ
         rqQ5s0rqeIkVeRvjk8JnQmrI6/acMBTBx4UWJNWsPiMk4w/1RmL+6WyaXLIZyjf6e05O
         fJ047JFb7n7W4B9ys9K38Z2wRGinzt+UVqoLc9+sArv4XrnZO8vL8SWUPWvBhqHrOqq2
         OB/vS22OmNhzIRgLGHTQ3iuwFWQ9mF+y4g/nbcKq8zJq8/bSrODIMiLGmU7vcUCcy1Ol
         feLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738110277; x=1738715077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ss8IRXPQuROgaPFI2n/Tn6B8Bw+CUwUeulj0ny/+twg=;
        b=h1Tmkb/2eOJ6LuUlW/BWvT4nKpZ689hP2SnoTEJEqdTEkJGMj1G0GzmXYLAJGk89Wo
         bt/TF2evb0ExjbOJ1zOVkq/zDsKByqJegHN9Lc7UNv+6t+JGQzGjp4iu9aUTh2QsH5aR
         mqKQqLi63ssP2zzMwZTYsyzkNE56Oo046scH86jnSSIPNw/XMMZxjvyyu/p0KC/6wEmK
         M+tK+RuenyKLTIDdsP7Dy4XJ1HGC8508qezFEsWJDQ72pgBPfqaYR//AGeXdp+eUmqhR
         ieyaxM4VXEzwHVQhpSDhiWBxN8uQvB/yC/cj8J0iQA15vPVVqrbX1oe2wY41Li9rbTX6
         f6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrE9A6GcdQr9AfJ/Odk3zLkuIzPv6lL7JW5YozU0FjzT/FB/r2FSDglQk1w814zmYa1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJv2lUH2ck+ssF8hJlvHPCIN3vP6Q/rI8Irxcago6gMON+BdHB
	B8nwpLOafXqG41rxn0huFzWvheQLS2Z+Ppuf4F5DKCQQVG+zvBgm1cvEUz9GpoKEfVZqTQtxrwE
	Ddw==
X-Google-Smtp-Source: AGHT+IECz3VTxLM4O986OseoNSxZB/C8h78XB8HxPSOGl8b2+z2HK2SySwPs7DImzJI+zObNWYsOE+c8sYo=
X-Received: from pgbcl4.prod.google.com ([2002:a05:6a02:984:b0:a88:3e2b:cada])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a0e:b0:1e2:2e4:689a
 with SMTP id adf61e73a8af0-1ed7a6e183bmr1992091637.41.1738110277341; Tue, 28
 Jan 2025 16:24:37 -0800 (PST)
Date: Tue, 28 Jan 2025 16:14:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129001905.619859-1-ctshao@google.com>
Subject: [PATCH v3 0/5] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

For perf lock contention, the current owner tracking (-o option) only
works with per-thread mode (-t option). Enabling call stack mode for
owner can be useful for diagnosing why a system running slow in
lock contention.

Example output:
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench sched pipe
   ...
   contended   total wait     max wait     avg wait         type   caller

         171      1.55 ms     20.26 us      9.06 us        mutex   pipe_read+0x57
                          0xffffffffac6318e7  pipe_read+0x57
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
          36    193.71 us     15.27 us      5.38 us        mutex   pipe_write+0x50
                          0xffffffffac631ee0  pipe_write+0x50
                          0xffffffffac6241db  vfs_write+0x3bb
                          0xffffffffac6244ab  ksys_write+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           4     51.22 us     16.47 us     12.80 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac69249b  do_epoll_pwait.part.0+0xb
                          0xffffffffac693ba5  __x64_sys_epoll_pwait+0x95
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           2     20.88 us     11.95 us     10.44 us        mutex   do_epoll_wait+0x24d
                          0xffffffffac691f0d  do_epoll_wait+0x24d
                          0xffffffffac693943  __x64_sys_epoll_wait+0x73
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      7.33 us      7.33 us      7.33 us        mutex   do_epoll_ctl+0x6c1
                          0xffffffffac692e01  do_epoll_ctl+0x6c1
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
           1      6.64 us      6.64 us      6.64 us        mutex   do_epoll_ctl+0x3d4
                          0xffffffffac692b14  do_epoll_ctl+0x3d4
                          0xffffffffac6937e0  __x64_sys_epoll_ctl+0x70
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76

  === owner stack trace ===

           3     31.24 us     15.27 us     10.41 us        mutex   pipe_read+0x348
                          0xffffffffac631bd8  pipe_read+0x348
                          0xffffffffac623862  vfs_read+0x332
                          0xffffffffac62434b  ksys_read+0xbb
                          0xfffffffface604b2  do_syscall_64+0x82
                          0xffffffffad00012f  entry_SYSCALL_64_after_hwframe+0x76
  ...

v3: Edit based on Namhyung's review.

v2: Fix logic deficit in patch 2/4.
Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
Chun-Tse Shao (5):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
  perf lock: Update documentation for -o option in contention mode

 tools/perf/builtin-lock.c                     |  60 +++-
 tools/perf/util/bpf_lock_contention.c         |  70 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 277 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 5 files changed, 398 insertions(+), 23 deletions(-)

--
2.48.1.262.g85cc9f2d1e-goog


