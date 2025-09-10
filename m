Return-Path: <bpf+bounces-68063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E06B5248E
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B4DA82792
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 23:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAB307482;
	Wed, 10 Sep 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDV75h1c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C6376F1
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545974; cv=none; b=fEmRZpzde4OYVkP2QyG0fLNs1WbRuEtCXKlPmnSbyxk1S1/UZa3cbaorLqNFZe4fZerF5zyVAc3eY+a3qAnuDhY4tKnbIyoObY1PLkWAdCx0EtpN640FZ7FWKqE4TI4eFMljdogIwkxZm7qdFfT3GRm1ztvBeqwa80Ik3D0w+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545974; c=relaxed/simple;
	bh=BxTGnVsNSzseRDrQm0ndCBhhFHchBSdsndBd/IV4H7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cx9j6utB3lA3ouyU/Cpd+Zqyw5Due2wog6wWdKm/99OC2e1AvA/A+PJkMoK9TUJSmzQJYEnN7t4Ov9/IL05rYG8XktfofVGzZbRr4+E4v5cC6k8HTrrQ6HuPbuGZy2hpEazBjZY/o6Nrmhj/E0hRTW1XAlOj9joV6korCsEZczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDV75h1c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24b164146baso458615ad.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757545972; x=1758150772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUWhuTmgT6EFbZhjn5M879aw3Xbdm+/h4OoBOjzUlfY=;
        b=EDV75h1c6dONwxNDv8D6AE4YNe+6hcCzuc7pkMkpvj2BJyXggRFr+kLvuoBUB+PRbv
         nHojfisRWJAVT2jYJC2ZdnjtPdr69w3HrM4cjCle2kVkG0ODExL8xi3JizaPbgm60zB4
         kobLJRMZSi1xG6nWEFrh1FKO5ZpaPa4YznQoYYKpEABNAimbBBFpLAyw76fw26cyCg85
         1SCR79bLLAhF8BaYTVDi1nlZkeerwGLAqQDT3RB8KsCjf1Mmu8kKij/9a+2sdSwiGKm7
         N0+djSx5eL/ZVLixnGMIAbVUcn5ur3iHNzq+JvaCtTh3A/2gZQHN4xi7YUKZ6l1o7P63
         JmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757545972; x=1758150772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUWhuTmgT6EFbZhjn5M879aw3Xbdm+/h4OoBOjzUlfY=;
        b=FENoiDjJCSI8PlP47iHVMLjOeUST27wrVB0R19//7fKGjBaOXSN8wuVBo0SQUrHNxH
         IayiXoV6RcSaGhWO8Qe6EOgTXMamRljX4TkOJP7xguCLyN9XiQUdPmt2NdQQ8CGAqdIs
         m9nh8BEgV7Dw9EWEbznVaUQjANtQT/xH9yoMG6GUHvE/f59F/04Qfi4NpEBbY/MovGA+
         v/1Es6dAhNtLL5vNxZwdFzfEck3nXWutYhaBWOyYdOxg72Rl+2vTxxccRBPGwyE4hMgh
         IRdIGi87FM4I2yzffp4TFoPkmL37EHqzadV1REr0e5wDyg+kzCNZc5X2lPyH8Fl+IUe1
         w71Q==
X-Gm-Message-State: AOJu0YwM44+gr0iChr7lHRpBi9CNmg25e3lPBKE1wGkx6SQQWCG7kCLy
	hftUE6ueSY+pXXXeyhQI9CHNt4m3roFv/s4FKDS94XaXRpONHdKKobZjY2la1w==
X-Gm-Gg: ASbGnct/OpXXMzAvKy7MuYDAZPIjVFM9Q5PPU8AiqrPCxDWogehNaPOrtQzSazjnc1Q
	OLJRAa3xe2dQsL5HuW7JebWYlE1HKlsUQ32mJa3kg6MdcBsmtQD14ayUGALQl1KPNTy3328Bx+f
	p2omTxaOgheP1VUnzjl4er/Cttd7tunFYGC+i82kCasmrpfnc8h7Ujg9uFHffZdiArnNNZ0Yunv
	maeMujvI6s81sXx+P6GinTVPoJhzW7CtMpdCoTEIVjHZ44szFcfnvG98EHZS+7MY/puBfNfx4QW
	G/g8R1cN5vqZfX1KWkyXCwrOvStdZ5RFy+X7eR1Qgiw74gAzOj8D/OzI+PWQvTlYlVVq383xju4
	/Jj763KdHA3qElI+Z4K6Flyv07QjzKSnmihbfhGrGNhA3bOaAfXKys/ay83Spi0ECHfJngj8NGA
	==
X-Google-Smtp-Source: AGHT+IFjtUEVT87+5VzGZFrXURAPd3Fsa3R+Wo+j6Dml4ovrylbqKihKQNpSNtoHkrSYcuzIlir9Zg==
X-Received: by 2002:a17:903:32ca:b0:24e:6362:8ca5 with SMTP id d9443c01a7336-2516e88795fmr214316275ad.17.1757545972339;
        Wed, 10 Sep 2025 16:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25be6fc0f23sm3850855ad.48.2025.09.10.16.12.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 16:12:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.17-rc6
Date: Wed, 10 Sep 2025 16:12:50 -0700
Message-Id: <20250910231250.3511-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 91f34aaae06e425e4644afde92ddff949b6abb54:

  Merge branch 'bpf-reject-bpf_timer-for-preempt_rt' (2025-09-10 12:34:09 -0700)

----------------------------------------------------------------
A number of fixes accumulated due to summer vacations

- Fix out-of-bounds dynptr write in bpf_crypto_crypt() kfunc
  which was misidentified as a security issue (Daniel Borkmann)

- Update the list of BPF selftests maintainers (Eduard Zingerman)

- Fix selftests warnings with icecc compiler (Ilya Leoshkevich)

- Disable XDP/cpumap direct return optimization (Jesper Dangaard Brouer)

- Fix unexpected get_helper_proto() result in unusual configuration
  BPF_SYSCALL=y and BPF_EVENTS=n (Jiri Olsa)

- Allow fallback to interpreter when JIT support is limited
  (KaFai Wan)

- Fix rqspinlock and choose trylock fallback for NMI waiters.
  Pick the simplest fix. More involved fix is targeted bpf-next.
  (Kumar Kartikeya Dwivedi)

- Fix cleanup when tcp_bpf_send_verdict() fails to allocate psock->cork
  (Kuniyuki Iwashima)

- Disallow bpf_timer in PREEMPT_RT for now. Proper solution
  is being discussed for bpf-next. (Leon Hwang)

- Fix XSK cq descriptor production (Maciej Fijalkowski)

- Tell memcg to use allow_spinning=false path in bpf_timer_init()
  to avoid lockup in cgroup_file_notify() (Peilin Ye)

- Fix bpf_strnstr() to handle suffix match cases (Rong Tao)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'selftests-bpf-fix-expression-result-unused-warnings-with-icecc'
      Merge branch 'bpf-reject-bpf_timer-for-preempt_rt'

Andrii Nakryiko (1):
      Merge branch 'fix-bpf_strnstr-len-error'

Daniel Borkmann (2):
      bpf: Fix out-of-bounds dynptr write in bpf_crypto_crypt
      selftests/bpf: Extend crypto_sanity selftest with invalid dst buffer

Eduard Zingerman (1):
      bpf: Update the list of BPF selftests maintainers

Ilya Leoshkevich (1):
      selftests/bpf: Fix "expression result unused" warnings with icecc

Jesper Dangaard Brouer (1):
      bpf, cpumap: Disable page_pool direct xdp_return need larger scope

Jiri Olsa (1):
      bpf: Check the helper function is valid in get_helper_proto

KaFai Wan (1):
      bpf: Allow fall back to interpreter for programs with stack size <= 512

Kumar Kartikeya Dwivedi (1):
      rqspinlock: Choose trylock fallback for NMI waiters

Kuniyuki Iwashima (1):
      tcp_bpf: Call sk_msg_free() when tcp_bpf_send_verdict() fails to allocate psock->cork.

Leon Hwang (2):
      bpf: Reject bpf_timer for PREEMPT_RT
      selftests/bpf: Skip timer cases when bpf_timer is not supported

Maciej Fijalkowski (1):
      xsk: Fix immature cq descriptor production

Peilin Ye (1):
      bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()

Rong Tao (2):
      bpf: Fix bpf_strnstr() to handle suffix match cases better
      selftests/bpf: Add tests for bpf_strnstr

 MAINTAINERS                                        |   1 -
 kernel/bpf/Makefile                                |   1 +
 kernel/bpf/core.c                                  |  21 ++--
 kernel/bpf/cpumap.c                                |   4 +-
 kernel/bpf/crypto.c                                |   2 +-
 kernel/bpf/helpers.c                               |  16 ++-
 kernel/bpf/rqspinlock.c                            |   2 +-
 kernel/bpf/verifier.c                              |   6 +-
 net/ipv4/tcp_bpf.c                                 |   5 +-
 net/xdp/xsk.c                                      | 113 ++++++++++++++++++---
 net/xdp/xsk_queue.h                                |  12 +++
 .../testing/selftests/bpf/prog_tests/free_timer.c  |   4 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |   4 +
 .../testing/selftests/bpf/prog_tests/timer_crash.c |   4 +
 .../selftests/bpf/prog_tests/timer_lockup.c        |   4 +
 tools/testing/selftests/bpf/prog_tests/timer_mim.c |   4 +
 .../selftests/bpf/progs/bpf_arena_spin_lock.h      |   4 +-
 tools/testing/selftests/bpf/progs/crypto_sanity.c  |  46 ++++++---
 .../testing/selftests/bpf/progs/linked_list_fail.c |   5 +-
 .../selftests/bpf/progs/string_kfuncs_success.c    |   8 +-
 20 files changed, 213 insertions(+), 53 deletions(-)

