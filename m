Return-Path: <bpf+bounces-48663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8FA0AEB4
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 06:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BC0188733D
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2710230D2E;
	Mon, 13 Jan 2025 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdU/+kih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2B1865E5
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 05:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745747; cv=none; b=BPRvkN1bzUjrK2tRdKyngaf3hetk8Owg4F+jA3NWDic2qEuJWAc3GElE6NkzbkZPL6XDHx6VoZiwJ+xoTdP1YlbmM+n0zEMzzSxcGnzuATI9PzrE8zqPsLnlfoCwDFCYhAFxSk6VTll+IFzGF8Zf6KmU1pzZmoBSmjH5FqtP0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745747; c=relaxed/simple;
	bh=r9N0xK3Vmhlars0O2eO30dwlxQQcuWOaWELHbi43MvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qC9d+wds+o5MxJDrSFZBMM8iiZ+r/sHGDyJesCgI/dYQwiuzr8Ry8Q5rgC1NL0qCuUUK1OlyUgxqFY6QaljhX2L80a8O3PjxPfqQt42ElFs7TSrTeSfGRmAx1onX+kxoFXHQP5Ly8LhlegFNRZQBporvMGZQOLs/TYkfl/d+8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdU/+kih; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21650d4612eso105367935ad.2
        for <bpf@vger.kernel.org>; Sun, 12 Jan 2025 21:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736745745; x=1737350545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2SODDUU/4by30C8cH2MnStzrDco9M/M3NU9sKNQSG6A=;
        b=TdU/+kih/A1itaS/IC0T3mwuRGgU/yapUQMvFVe4qRMv30/jF4JBD6LKREqRSgCxhH
         COjEguOUUBlNT96ncKQ8RsCwyxrdXsewhszIIDnwLdFIa97t/nhMhf1j1BIbE92lfT8l
         OuiinhECwL2GjF4Dqssj2eZh3yYEI12iTZm1c4eqkx9JdkhrQNH0ptWyEPiCC8edzqzv
         yylJQUDsbPqL185lQ8kxQfvYqqza0xpTudDTVKjfmgnJEZj7kBlp3QlJVOKIlayTQz7m
         vanicFdnfgy+w0AGr20lzYyNdDsaTwK73GBKTv74XdVaeUHSEG20qzUJN0ZoP1g4mXhH
         1b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745745; x=1737350545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SODDUU/4by30C8cH2MnStzrDco9M/M3NU9sKNQSG6A=;
        b=Q69SwDtOpnsnVEK4q/ljYe7KtHRlCAGY/EWsoRzHnnc9m0FzTYuUtrft2Uhc97yz80
         MNs32PGckmYPPyGqOHPAev4/yfhOIDzT+AroPuXnCsW1eIeUyMT+ljC+AAlMnkn4ccdw
         IVxLTlPJBGSqIV5BOF95T4eJ+/UTvL6yvqRfioKTOUm98KAGpjfn95k1dBP94r8Aphl8
         rZX7mumltYa2qXXVFSoPLmWUu1DjwIxt2yJlHk0shwtjz9Ib7+LN0Qffqku/NPi1O7oH
         /WUJnDK/OppKcPCQwY7pOD4RLnIJ20gT5TbR0TRuqDpzpBsXf/c6CnhxIUXKyKQuENyF
         5TBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLdnNnmyFklPmNVyQJRvdmpTbiYb7fpW+kVm6ZbyfnugSeWblDKm6gW4DKTvfg3EgRwwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+ANtnCo67YGnhsuMf0lVN7O8C7EVt4rLpxMq0tx3pO+0Serp
	Igc58bI1LMLMSsZMGi+k7G7F9eGATVoXaWrYaViEEL6Al8ThVi1YJrKCl4tXwa7HISApjSTzkkV
	XkQ==
X-Google-Smtp-Source: AGHT+IGzKx5p7Rir4jhTnwW5HLnSafYS5KkR9v5qyIi4os9QTsqm3PJ9CrGVU2u+/4KcctucmJydyBAqMPs=
X-Received: from plbkx4.prod.google.com ([2002:a17:902:f944:b0:21a:8a37:37db])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:215:8f2e:eeda
 with SMTP id d9443c01a7336-21a84012c27mr284934195ad.52.1736745745490; Sun, 12
 Jan 2025 21:22:25 -0800 (PST)
Date: Sun, 12 Jan 2025 21:20:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250113052220.2105645-1-ctshao@google.com>
Subject: [PATCH v2 0/4] Tracing contention lock owner call stack
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
  $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex-spin -E16 perf bench sched pipe
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

v2: Fix logic deficit in patch 2/4.
Chun-Tse Shao (4):
  perf lock: Add bpf maps for owner stack tracing
  perf lock: Retrieve owner callstack in bpf program
  perf lock: Make rb_tree helper functions generic
  perf lock: Report owner stack in usermode

 tools/perf/builtin-lock.c                     |  54 +++--
 tools/perf/util/bpf_lock_contention.c         |  58 +++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 192 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   6 +
 tools/perf/util/lock-contention.h             |   2 +
 5 files changed, 292 insertions(+), 20 deletions(-)

--
2.47.1.688.g23fc6f90ad-goog


