Return-Path: <bpf+bounces-52410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA1A42BF2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF5217A099
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF01266564;
	Mon, 24 Feb 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeVZs6hk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2426139E
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422948; cv=none; b=oTMKUdzQeQ3rj8WrKKZq1wA+QQ6hAMgyVWAZEbsyoApVaRi0tk/DVOfDwjs1K7nzc/0N30lN8oYhPnURJvgoWLlinovQJ/0HvaWGk5iXgaT/UZ8fTos7uz8NJ63aF8w9cP5mAhLRPRrW+xbIaGHZJFqXlfVpBFEOuDCtclichrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422948; c=relaxed/simple;
	bh=74JojcKdHl/EpDCHf6Xu0uuEZWIvtDlOXXKO2IldiT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e5gWhpFxCIdB4MEmzsLvXiH2dWO2vmx9RCmpOVY9XTTpLqFqFFIdYsYtBenp1V42dJcrEo2TGyGHTTUqpKUTk+K3d+APbNm+JgHVm2RJSHNMfUQj3S2k0hHupPcbgyChKrcyaSl6CEFJgxQ50m+Nz5b34QD4yvT9JfnQ1P+yzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeVZs6hk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1a70935fso9866975a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740422946; x=1741027746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CnndUuEB756xO1Q16p27boNl6XOa0JiJyfWgT2SGCx4=;
        b=SeVZs6hkNvTXAvL2hTosWkHjG+xGaQ4Pa7ncQjLNeyPR1EhIQzyxq+cArn9yLbjBEl
         XKsAUBjaN/7r48VjFkRAjaHqHv5Wc9tq3kDh+QoS0pJN31vJAqvDX9C5UScsQTngvI2g
         8D2VbzVXFiGq0bwV/BMnyComlCaY/+Qk0MM8v8P3vsVtZT+1owBwiYR9GBEqWNRZK2//
         2TL3IuIfRACSlvT29SdE7bebFEde/t7VsNaLeOGlzDzPtM7UhmxFCE1girV32k/hhEql
         hzREFVER9rcqysK7mZUoURTgj4M61qWk1gjnPWRHnZEPCqQEphzAnaNfRV+5oSgG4s8U
         kC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422946; x=1741027746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnndUuEB756xO1Q16p27boNl6XOa0JiJyfWgT2SGCx4=;
        b=QwIInTdY1tSZDsvS3QTuvvNarhjPbUtuRlcKtspbiA723qCAkMQQQvqy/w/1eGCkr7
         6Fld3ynk63MB1T7xKC7h63x/XpDnfTDUttUAnpF14U7MQQoe06jZmZrqaooLHFptYoIa
         +ce1UR4sarj8GsVANmEvbPcmSkA++8iyOvtuklJuiPHzDRRH3nFbp2nCCzHTLSOzIuUq
         CIKO8QY+XUrZ4YShHOwg05bZa3cmqAAkfJKKHK2zwpHgMo3IhV+jG1jPJTomrpvhSpTJ
         3D/tP+UTxW7o4HeV8LQDXYuEOIOiKNuco7YYGRR/nTj6nhlIjuLU6gia2vWEjxPoarXg
         aiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCwyDYYlZ+3jofRgFe/fGce8Yz8Nd9BJ0GimOLcKg67KO7pcBpbgLYSVst6JTbTmANvlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyTlPlaznBtQQQgoyPePnOS3x/6aEVOsBr1GBD22XU9BTR4KRa
	EwfjWP4HnDb7HXvbdHYPy+HQiLGo4U8upVaT80+9SNFXUgZQSA5YbItkSEzmvWQFxRfMWSrTvTp
	yFw==
X-Google-Smtp-Source: AGHT+IHidTbqQGszkaQeLrt6isD19oKxaBJglHjyeZLSObSL4hEpX/goqPsS0DROoMvOTwsNky25bcu2qHs=
X-Received: from pjbpv2.prod.google.com ([2002:a17:90b:3c82:b0:2f8:49ad:406c])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc4:b0:2ee:f80c:6884
 with SMTP id 98e67ed59e1d1-2fe68d066a5mr347766a91.33.1740422946130; Mon, 24
 Feb 2025 10:49:06 -0800 (PST)
Date: Mon, 24 Feb 2025 10:42:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250224184742.4144931-1-ctshao@google.com>
Subject: [PATCH v7 0/4] Tracing contention lock owner call stack
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
v7:
  Remove duplicate contention records.

v6: lore.kernel.org/20250219214400.3317548-1-ctshao@google.com
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

 tools/perf/Documentation/perf-lock.txt        |   5 +-
 tools/perf/builtin-lock.c                     |  56 +++-
 tools/perf/util/bpf_lock_contention.c         |  71 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 245 +++++++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |   7 +
 tools/perf/util/lock-contention.h             |   7 +
 6 files changed, 365 insertions(+), 26 deletions(-)

--
2.48.1.658.g4767266eb4-goog


