Return-Path: <bpf+bounces-53447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A71A54173
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 04:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07899169328
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5919AD48;
	Thu,  6 Mar 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDAzpbOJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50A7EF09
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233280; cv=none; b=pIhUf8Z5HRTmB1wCfrMJH47GKxGLBvl+aT9/9s+39uMlkof5x5hC/BjRKijPWs7fDEk/UZOwd6qr1iuw4mMGwHgFr8gmaS5wGtagm8a1Q1UXaZjS7nj1YHgVrhsZJ7Hx9f1p1lW8ceFYy5MBMLOqFERrw9pyZO5IvecIHWvqcuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233280; c=relaxed/simple;
	bh=S/L1u6rgYY/wPcVzICt64fFIxraYar89g81ldyD6OU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIpB0F7KJwgJ6h1vVhJYlXmTI4OzpDLlRtW/vbNYVQ7EDFnp4s/LIZ0AuBf94RMycmRPdy7ZNDS4ROpAC9LrvP7SIC+Cvs4VTRgmls75GPgvccft2QC/CdscmBpuqhdl40ndGUGA4A3ruZk4TX8aeFUPPfrpsHPGzqmvkF7py34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDAzpbOJ; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-390e6ac844fso156696f8f.3
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 19:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741233276; x=1741838076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKO6uZO3v2L16rNk7yQsWydnvGW/YTCEmnBZMrMka3I=;
        b=MDAzpbOJIV1reMpbroj9BISU2Kh1TFSZUuYlUq8Nzbw3YBwZo2n6pVnpVst4VPxd2E
         U7y1yAIdtpbwZhw9JROT2/aJ20/jMEGB4v6wnN4IG9TN5PtI0sDskfq9QsI2VKkA11sP
         THc+GEl3IvJnnZafK152QcQFvp/AkERYzUZYmTM2rKD1r2e8SHB3UpwhL3wYm+jLy/PD
         0ahMOP2lF7DRPs3L6IS/Brl+Y/dBoWHOCCNK6yA+LGEAWA4TyzPPBWt6s9aGprgiujRT
         nMwvgsHsm7MbUKycZ/vHaYa+pGG6Ug57LsU6qOM+xDanRwiuyGr2pV+2SSiXzJ+GhavN
         0SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741233276; x=1741838076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKO6uZO3v2L16rNk7yQsWydnvGW/YTCEmnBZMrMka3I=;
        b=gRmDhC0iLsct6VWvTFOPao2VYVPH5Cny9b5JPQ4d1IiTwf6l5VkZPFPu8NeajeL80Q
         aHnZlnStMH1YwZizEUF7J+Swxbt6kFlC3Xzx3nnRCZ7kd7iQ5VMR+2QVNvafvhIAWFIr
         58a/LLD2xU038xEyyV7mkupLlaB7IvSzNfUHpvcwAB9azXXqT16Z7K6uF3SRHQUH8tZk
         B2FsO0t6vZv+8wZIqjahjHE+idbXaCZ7RK1iPzc7vHxJl6uIhl58u0IKzWTPrkgrgejU
         Is2BKYRiVjqA4VnyeHVJNdyZ3CqG0Q5wXet4jxJcKi6aWlDAeqrk5k84qjENACnoSX6v
         btvQ==
X-Gm-Message-State: AOJu0Yw6B/iZC/9HEqohDjC1Q398ee4q5CFUpMvZ6ik6q5ccCZaNuZvw
	2w4OyXuzAHulvkn2T1F4b0pPZgprXWQD7ZGhF1wCpouZbUYBor8V83RjC7qE4k0=
X-Gm-Gg: ASbGncu+0LH4lYb/NtFXTExaTlAAj7MEGPP2gC5TUQWvevQNrzzpCSanMaZ2nzgjEC4
	G3PmVsLeUeX0pbbkXl5h27j8dM5eyuNWB08D1SnS7Q/grKypRhvR7Onc1HZOesxFsdnx9Wl8EL5
	PUpkUq3d1YKl0BJH3anAtRfLnSnHpGxfNecdOxJM2nF7kUlbCcWm1OKhCUqI67NZD28TkcUUnU4
	PT9qU/pdxKB24q1y55UEv8poI7C1OtuETXtP3wQ9FtsULZWUjysA44XW6nwULQeWtXyuWMcTRd0
	EbbmkItlIqUubvMsp3iIbvFVkQrTTK4OeJ8=
X-Google-Smtp-Source: AGHT+IEKvKdZwlXJwVj7K+g8nTbiOm5lkwesJH+tii6kZY9iemQGEslBlsR3XAbUw5/hJSlkJXBCXQ==
X-Received: by 2002:a5d:6da2:0:b0:390:ff25:79c8 with SMTP id ffacd0b85a97d-3911f7359cdmr4435168f8f.20.1741233275850;
        Wed, 05 Mar 2025 19:54:35 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c3d3esm6024085e9.16.2025.03.05.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:54:35 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 0/3] Arena Spin Lock
Date: Wed,  5 Mar 2025 19:54:28 -0800
Message-ID: <20250306035431.2186189-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189; h=from:subject; bh=S/L1u6rgYY/wPcVzICt64fFIxraYar89g81ldyD6OU8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnyRK8L4POuq3fe+WgVPEK14HOH2D5POlQpjsuTemQ AC/dkAWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8kSvAAKCRBM4MiGSL8RypBcEA CmPgXmt3AXUvZQG2tOm0xmqC2Sx8v3xMnGx5KqYb5oi7KipQf121mOwCo+NUV9JRTDsUvnQrHD3MTw Inw2P6c0dyk6rxjnmTUzJdf+n/pSJC9xLL2cdAiNG/BayLR9lXRhyIaxBXTdOT38NLK7cRsrtxFJuE t3h5AmTi3AkKYFz2uqgnTa5Hz009BZEym8kym2Th8YWHjYJh75YZmHuD52d56qQVC0Pw6JYnNfH8DZ 0NGftVV47hW0hN8qr2/DH+yAAQJD2L2uNcUTIGJ9HfV7hlTmKk2eUH4W38Gly8L7Uje/i0ygol1KVe xwyLp/jKSwXUG0WrVnx3pIQchy8ziQZ8h5Qz3WRp9kvITkp6uLfHQm/sIXY+R9EGhyg5LbPXR989Or 5nHVo0wbf8Vwajgov6gbOXybGXuqezkU5dEV1HDb2kfwOulhowaTueO0EKNCvjrA0pZAmUemwliJdY vaVxhat/aJOMixtcwS8oKLpGr78+rwMRZhXGStmwy7pPtGLX9guCgrxp7AZtnbqdc7xM27OVuGfFv/ rXSD75OlcZ3rJwBuBJ5pSHBfxzFCtO7NnURjpDuvtZVa0XQw7ueDeFpPbfqYaw34D+ZIWxqXiXPyvV /TBgVwjNAfrffGCXlS6HC9+klzfiX0Yz6taCrsOpSQ1kmC1nugzKRC/Dw5Ww==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set provides an implementation of queued spin lock for arena.
There is no support for resiliency and recovering from deadlocks yet.
We will wait for the rqspinlock patch set to land before incorporating
support.

One minor change compared to the qspinlock algorithm in the kernel is
that we don't have the trylock fallback when nesting count exceeds 4.
The maximum number of supported CPUs is 1024, but this can be increased
in the future if necessary.

The API supports returning an error, so resiliency support can be added
in the future. Callers are still expected to check for and handle any
potential errors.

Errors are returned when the spin loops time out, when the number of
CPUs is greater than 1024, or when the extreme edge case of NMI
interrupting NMI interrupting HardIRQ interrupting SoftIRQ interrupting
task, all of them simultaneously in slow path, occurs, which is
unsupported.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20250305045136.2614132-1-memxor@gmail.com

 * Add better comment and document LLVM bug for __unqual_typeof.
 * Switch to precise counting in the selftest and simplify test.
 * Add comment about return value handling.
 * Reduce size for 100k to 50k to cap test runtime.

v3 -> v4
v3: https://lore.kernel.org/bpf/20250305011849.1168917-1-memxor@gmail.com

 * Drop extra corruption handling case in decode_tail.
 * Stick to 1, 1k, 100k critical section sizes.
 * Fix unqual_typeof to not cast away arena tag for pointers.
 * Remove hack to skip first qnode.
 * Choose 100 as repeat count, 1000 is too much for 100k size.
 * Use pthread_barrier in test.

v2 -> v3
v2: https://lore.kernel.org/bpf/20250118162238.2621311-1-memxor@gmail.com

 * Rename to arena_spin_lock
 * Introduce cond_break_label macro to jump to label from cond_break.
 * Drop trylock fallback when nesting count exceeds 4.
 * Fix bug in try_cmpxchg implementation.
 * Add tests with critical sections of varying lengths.
 * Add comments for _Generic trick to drop __arena tag.
 * Fix bug due to qnodes being placed on first page, leading to CPU 0's
   node being indistinguishable from NULL.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250117223754.1020174-1-memxor@gmail.com

 * Fix definition of lock in selftest

Kumar Kartikeya Dwivedi (3):
  selftests/bpf: Introduce cond_break_label
  selftests/bpf: Introduce arena spin lock
  selftests/bpf: Add tests for arena spin lock

 .../selftests/bpf/bpf_arena_spin_lock.h       | 512 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 140 +++++
 .../testing/selftests/bpf/bpf_experimental.h  |  15 +-
 .../bpf/prog_tests/arena_spin_lock.c          | 108 ++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  51 ++
 5 files changed, 820 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c


base-commit: 7781fd0ddeb43d078b750ff27a54dd3f85a26481
-- 
2.47.1


