Return-Path: <bpf+bounces-51993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A1A3CBB4
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C233B5ADD
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AB20F082;
	Wed, 19 Feb 2025 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uELtFqH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE901C5F35
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001455; cv=none; b=KlcIE5FfNSpRqkVn68OQPAmPwYG9oyqI250aGKimcNNUPKgz2FEi8rFQHRrh0NsPBwlampMTpUOSjcm/PgGnzMpbffpAlFtNDi3t/uJ85RYcpKc2UAqQw1oCUv1R4StvvK/8WMil7GzAXKA4nvvLF2URDJdK+GA99kJivOzh+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001455; c=relaxed/simple;
	bh=CTguHI9ra+AVpeiViEJMVcn8TOZbCheJ7ifbmczf1sE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AQUZh1AGSwzG4zvCafO1o2PNhEfxoE4tHCe5wYpgRDIzp7V6zE4u2h4o5O8zOgohJuH+oBH2hlCQZLnc7derlMlIHbvvUZQ7wUIin5yi92BCAULmPbNVeUteU3c2PBzrCroqhg8gN9Yoz4A0LmoeyWAyyIrmfGieTUwZ3JfqBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uELtFqH5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc5a9f18afso492375a91.1
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740001453; x=1740606253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9Jer7zFjUDPh822Asgplz1kcj6Jbt7KPnFYJhaZSsc=;
        b=uELtFqH5rsfvYm+Z2wP2T8HgNE6Q69PByZq2CYeK26CDh3VbrdnN9Ux5iEsM3NXO+d
         kmckFXETUmmz4Vh42Hf+StnJQxHit/EGGDvtC5lGOfPDXWeaL/csyniUv+vuo5urVE6/
         AAjlztOUz7z5SdZqvQ1aiz6WjC6n+V6QUyJDRbb+OUYDHGJ/kNnRknsmfbV9cmk+hzov
         ihm6G8O7kg0gn6poJvRmVF0AjB1d+cZ2+f0R/976gyXkTN469FYAi0WgM4SwI6vmpFJ5
         kNK8Zz/wKB2q0c9xiTdqP/6tWkRgtfJf86cDXkvw5Eg0pURWZkNbx/mTEfM84DktkEpi
         R0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740001453; x=1740606253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9Jer7zFjUDPh822Asgplz1kcj6Jbt7KPnFYJhaZSsc=;
        b=OAjQVpJx9NsNf/DqHEZfJsnHGFVl4vki2RSdGBaB1uQgAZmMWScWq10u/o/dnjomZF
         r/vRGq8NsagzTvavEIVl1qm6bKR2xMEO3BteARtg9S8M4t/9crEtsgzTTkrLd/I+UinC
         0PJMj6wMho+ce07JFPKMFaUFDyoyROAqvojwTVVuXFQXTHG/A6PXcSvflw8xiCBRYyFG
         r0sQIEPfqu4UVIyTWMM+FBDpKOCKhYi/7GOOJ+WQ9f1SH2wJZwJS8oZhCUe7RSj586b2
         To/wjSuxTKOIgaP925I9c5i3JIeGx438qMOd9oY1M0X2PmpdJ3MHbVSRgJe1H16eMyZI
         T7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWZzWWW3t/3TWlHV1CqvLmCI1djfzE1lJWYjvjdU0oZxiTBDGlNRR9+QQzL4S7c3Jv5ZEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIy8w6tgmCfwuWNSxgIcEoN959SCG4352Pz0r14y019y5CSFpj
	pVEAACkODOg7BZTIfILo/xqc9jDY1AAMhsR3GtlMwErr+1PF7jpfO0fCMYfj97IKbdOd/cNNcS/
	Uqg==
X-Google-Smtp-Source: AGHT+IHX5qUfJaeakQrn3oXg8HX3xosiOB+02t7Xb8qpc65w1pTX+0PNjU+WzpQgPNL3xlQlXCZYy1OCKTA=
X-Received: from pfay10.prod.google.com ([2002:a05:6a00:180a:b0:730:7bad:2008])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acb:b0:72a:bcc2:eefb
 with SMTP id d2e1a72fcca58-7329de4ee2bmr7801608b3a.2.1740001453578; Wed, 19
 Feb 2025 13:44:13 -0800 (PST)
Date: Wed, 19 Feb 2025 13:39:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219214400.3317548-1-ctshao@google.com>
Subject: [PATCH v6 0/4] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

v6:
  Free allocated memory in error patch.
  Add description in man page.

v5: lore.kernel.org/20250212222859.2086080-1-ctshao@google.com
  Move duplicated code into function.
  Remove code to retrieve undesired callstack at the end of `contention_end()`.
  Other minor fix based on Namhyung's review.

v4: lore.kernel.org/20250130052510.860318-1-ctshao@google.com
  Use `__sync_fetch_and_add()` to generate owner stackid automatically.
  Use `__sync_fetch_and_add(..., -1)` to workaround compiler error from
    `__sync_fetch_and_sub()`
  Remove unnecessary include headers.
  Dedicate on C-style comment.
  Other minor fix based on Namhyung's review.

v3: lore.kernel.org/20250129001905.619859-1-ctshao@google.com
  Rename/shorten multiple variables.
  Implement owner stackid.
  Add description for lock function return code in `contention_end()`.
  Other minor fix based on Namhyung's review.

v2: lore.kernel.org/20250113052220.2105645-1-ctshao@google.com
  Fix logic deficit in v1 patch 2/4.

v1: lore.kernel.org/20250110051346.1507178-1-ctshao@google.com

Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/Documentation/perf-lock.txt        |   6 +-
 tools/perf/builtin-lock.c                     |  56 +++-
 tools/perf/util/bpf_lock_contention.c         |  72 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 251 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 6 files changed, 372 insertions(+), 27 deletions(-)

--
2.48.1.601.g30ceb7b040-goog


