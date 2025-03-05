Return-Path: <bpf+bounces-53288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF713A4F630
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140093AA5C9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F071A4F09;
	Wed,  5 Mar 2025 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOr/Qq6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13F13C3F6
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150306; cv=none; b=VV7ItPPcxLnOtNjHeEt27oQyFk0W747ThqN63bgc78gq6RE4paTbW3xUUsXZHJ+hzPWls8UEYnAw75ycDCUObobpVhTMR1E2QYs62beycMvenIg9S/VnzyeYU5nsb+4ZmEmkBCue25zFOuDMwEerNWwPqrebkd4zl3ZOVkwEwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150306; c=relaxed/simple;
	bh=vr+VKWEmftiTx2FX8cd1i5DPryFE8T99DSgKkxB1fnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX3cN+nFjUZCPBz+BC9CBmg4V1IHuSTDVvgcGSq+rti4dT+7N+JgSo0hRUfspTw4pf/ExlHJHUVgJUhvfu/jSxquCiMZfsrpbudOJPJkzpfKw2nqW6SLKdsDk+JpcYyiHxw+zMO8Iqxf0gVcrk7mUNRJA0AaDuGgs9pJkTzBXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOr/Qq6m; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so700775e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 20:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741150302; x=1741755102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5ye/5AOE1VGkZRAHXY5Soe6Y59TlwJzqKfLA7jrpl8=;
        b=YOr/Qq6mJmPqiXS7PHgF7E2aMIUSOXG7GnHTUNLInBqOt5PyZ6RR2qXDsa+kHXJEAG
         bCaqfziWz6mhtS+VqKmVTZT8iVgyf3LobRARPjtdc9xQLYeKYVU7RqTZVo8DCN60sqsw
         eedOl/RCDMh3Wvh4r3GW3iUHqeWIOUXkQgE+GKNvcsSeT4ATP+wvT1b2Ci0GNTsVUJA/
         z4jQgpINyI3aanid0JoDPVscM6E6VaawShz1A7d3rnM0RP3XWFB6GCRMG6fp6c3JgmJt
         u0xkgMWFIHfduEDwlkhDm3FuXuhRmABM06ZcuL4kxI/YVtiP17XOF/RsNTNaOm5XqF6M
         /zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741150302; x=1741755102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5ye/5AOE1VGkZRAHXY5Soe6Y59TlwJzqKfLA7jrpl8=;
        b=AmXqCTeV7bNdAAy3q7vSZmyi2JqtWYyJyLu45wy0U144RhfvDYl1W8klFjBNqRmfZC
         Jjh31X0+2y52ZR5q0+mMrXQoS9MzeIOUp1wsvrX9YeKIgL9GSTDj77WQt+Ed7qXiYfDP
         i09HSspbDi9iVUNYbCKb5kjrtjI6qIStG6WHEdtAlMWHwWtVDXynf7L1S6v1dK74kQQw
         2HwC3nOQ6fhC9T3lM8/JjPBsrcuHUXi6lr8hPgCoyKL/4GKZguaM+OeSOdr05qulr+73
         iEx6Xk+hmEe4RPeVXy7l+NU3lNpwH3l4f0eTOPDvDAJtGzXafMoafcBlsdrTZShejItY
         4CCQ==
X-Gm-Message-State: AOJu0YyVamFsALCcq/Xq+MtpnC6m3stfcDOeW5xsHY3DiOWk6abWk0C3
	9dhR7MLqqKsbxbWeyjBsXx2mq/rDcVc5bxSBioWp4lAO0Afar2w62AianfKTj40=
X-Gm-Gg: ASbGncsfb3VOp2UUQa20lNp2HsEFC0igtJf6Z0MjeZRUSs7MSdcNeWr/hRmLeaZKGO/
	8G/QG9WTc+mfo8TXwoXkzioEjEDPSrUeITeaxbXxpA1Coxcl9rwbLUq+wV4nojUhGuRTCAzj5pG
	6pCakCA7QaHqR3piIF+koudG1bINC4VX72uqMK9aFvFV35iVywvEaWwXvgu/bqLvLxn6E8vmOOW
	xKwWUMLqPw4uVpx5BgXKEqxzXG+ioPHzd9ynec0EHWg9nqj7bv2F2DVFGiS1ialnvKvO8HqYyxn
	JNtJOGLgbo1EGB3oULsUKLzeJ78mgprBtAs=
X-Google-Smtp-Source: AGHT+IGGfW/61DkKQ2i7rEe3DAlpJWK0wwCchEEIsjQNUORlRhLjjT9KsrEpsK1xOTlzinoVLpZhmQ==
X-Received: by 2002:a05:600c:54c2:b0:439:9536:fa6b with SMTP id 5b1f17b1804b1-43bcb04ef6fmr51480275e9.13.1741150302376;
        Tue, 04 Mar 2025 20:51:42 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4293250sm5612085e9.16.2025.03.04.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:51:41 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/3] Arena Spin Lock
Date: Tue,  4 Mar 2025 20:51:33 -0800
Message-ID: <20250305045136.2614132-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2870; h=from:subject; bh=vr+VKWEmftiTx2FX8cd1i5DPryFE8T99DSgKkxB1fnE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnx9WfSS2hTSTvv4KAEJLm/RjBCWwSUrajzOTZMI4+ 8xUEWcaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8fVnwAKCRBM4MiGSL8RyuHoEA CxpXi8QBbfhgDkl0jbqk3B0NNDiD0g9VUAEAKo7YLtB6B+T5CriW1OS/ffmIUwBSCPV9pDDmWNkO// 5StUP7C/A516DirfqOG39NZHSSGA8/LXnHIr4Sv3cIlR5KDqpRipYh1wesvO+N0eujgqCilVY7/l0o S4nZ2Lg2+POl74hHJU0lId8ElV/sMgxVO4Hfq1E1a6hXd+MMioj+mZyrsK3JoIwX71/wB0QkQGdc3K pKuKIOB8vk1iy4F3Jc7xQRZoiS3H4RDt3eM0zqiYAdPz7MEhcKIq33olCoEOX8SGc/Z4ehu7dHhCCr YYgRz/9xqXmrfcwfKMzfuqH9ZpOugN5UGlfxEqtd6U9UA8rGtx70sOx3YITyG7VE22+sB8fBYu2LdQ 0ll8p99rX0B8NssOf8yeXIAKXzvGPAvyW9jrIO2+rMml0Oh4x+R6FU5r0g1rsZ8q8/czmJA9HdtmVj xFN+3kY2RGsuaoGTEYUoiUGcUGouYkWVwec+1eER28CIa+Ru7gDmf+uOa0KmdCfAfc7dbV9vYdRJiw 5MumSuIeT18ApY2OEv7/EGCedW9455e8p05BDqjkEWmHUCnkvTjdnCHkBJKiTLNCD3/MJi1QpVSfnj lr4mPq7u4WIRF91z4Pf6rspTUILIn37b2WS4+gskKGxKl7VqAHuwxPTKWDUQ==
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

 .../selftests/bpf/bpf_arena_spin_lock.h       | 495 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 133 +++++
 .../testing/selftests/bpf/bpf_experimental.h  |  15 +-
 .../bpf/prog_tests/arena_spin_lock.c          | 106 ++++
 .../selftests/bpf/progs/arena_spin_lock.c     |  49 ++
 5 files changed, 792 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_spin_lock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c


base-commit: 42ba8a49d085e0c2ad50fb9a8ec954c9762b6e01
-- 
2.47.1


