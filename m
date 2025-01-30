Return-Path: <bpf+bounces-50102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8AA22881
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 06:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52EB1886379
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 05:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939EA224F0;
	Thu, 30 Jan 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05NxjDFx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1672CAB
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214794; cv=none; b=NrJ5bC69TAEuEaW0C4i8lGrNUiMauLp1kkAti01C2DHwrx11bR6fqriUtiAkrEnMl+Z5Shh7pM3wc4MGAlIVeQyrnZ1HTAXqr9KSu1/9ybHB0bzlsPmhmn3de70fFDMLfk0+Wk//wbT1dTRgcA5HLbgah4uSdpH7+6u+UN1lWxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214794; c=relaxed/simple;
	bh=fnB0OXJzrVhcKcmuMcUudZz3hVsqa177SyrjUHv52ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nqEsLHTsNyomISyOehk2/NWgcgb9R0u8K2AV5+pOOt/SLhxuPSDA3hQw4GFc7satWcCIHZty1FSuWHUJtG1Er+Yv1VHy1h2X5b0XZkeEIeWe6LrrAtRrye58d1FcVuAzZxd+oJPTKMWQWKg3KkSbB2Xa7rPRXESgU8IqCCC/cJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05NxjDFx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso899081a91.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 21:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738214792; x=1738819592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BX9Mmm13inXfDgCaRgVWZY0V6IvGNH0YR3hkgrdz5UY=;
        b=05NxjDFxE0cb+xoctUV1ZoA3lLRhlrv2fLOFLde3SV9NGHQAo1NFOdWnPeMlHxi8j5
         0zZ40H1FKqiYEkDrRN3j5h67umcxDJyzFfIGwyeumjHnodC9safwad4AdgxevdoZFTxe
         OTcqn4YJIeSbL0X1xJqZ1Gk8O4fsAGROna54xlSSk1dOl/I9Y3lFasmmxdUK0+HzMmn1
         CsPdlbAQbqQX/7fpfRGO4qM6ZlGetnY6dOPSAnosP4dycjiYe4Iq4KlFdEj0+GML/I57
         DnIW3oLiB43BNGJ2I86utZEEK+T037p+eFn0cNh9w9k9i45D23zLpJEb10/USJYM9+Hj
         +P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214792; x=1738819592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX9Mmm13inXfDgCaRgVWZY0V6IvGNH0YR3hkgrdz5UY=;
        b=p0gNU0wjokVgu7rYxpX41AQxpS6ps2jNDBV71vjkAXv+8FBxbMOt7hTK8JjUrdXy0F
         IRRrjxXPJ8bdnXCTGQNXoHdbzWMX/TvUE0lwKnR5I3aBMOQvllgr8agCOq39thK8REW0
         H1EIKYDMs8dT64cszpIc8ENmqgtKFwzb7rj21Jzo4aWcH0gpG/ZIqg+1aLuVx21CVpEk
         kBmaUSgGAvGKhCo0p3WRMTVH8sXjy3V81IO9mMZoC2yi2H8/3pw6ZQGFcz3ocadkkUGI
         1+sU5P7FvyKVVcIX8RjN05KEENwXwr/JQ99Zgp8YbjOxTcB3vNt/HRWPIHGrjGGkjQzf
         VDEw==
X-Forwarded-Encrypted: i=1; AJvYcCVzEG1XF9WQCuFhELajxnjrogoa0C5ZObuYCRIE2JA9dfzJE4R2xsvtLvO+orf2nf3NiTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uKn+Je7yLsNvNJxhJG8NKa7WZzB8VkMUavcht4iKBac8BYDd
	L3ulqUmr56kYOxw1Zwaqaas2q6+aj97xmJzvJgCPDkVT2tETB93L1IIQl/Jp4STc2skdXLejByX
	Qsw==
X-Google-Smtp-Source: AGHT+IEm2NoDhWbtffh7BTE3NgDgJc3QoL9BeX42o6nZnNb2OOBZpu04ELcuDyr9PSBf0M4B204NPwiy5gg=
X-Received: from pfbds9.prod.google.com ([2002:a05:6a00:4ac9:b0:728:2357:646a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:670d:b0:1e1:ca91:b0e3
 with SMTP id adf61e73a8af0-1ed7a610993mr10741598637.36.1738214791955; Wed, 29
 Jan 2025 21:26:31 -0800 (PST)
Date: Wed, 29 Jan 2025 21:21:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250130052510.860318-1-ctshao@google.com>
Subject: [PATCH v4 0/5] Tracing contention lock owner call stack
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
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

v4: Edit based on Namhyung's review.

v3: Edit based on Namhyung's review.

v2: Fix logic deficit in patch 2/4.

Chun-Tse Shao (5):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode
  perf lock: Update documentation for -o option in contention mode

 tools/perf/builtin-lock.c                     |  59 +++-
 tools/perf/util/bpf_lock_contention.c         |  68 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 281 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 5 files changed, 405 insertions(+), 17 deletions(-)

--
2.48.1.362.g079036d154-goog


