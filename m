Return-Path: <bpf+bounces-69278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D2B93922
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372817B0C9E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49222F5315;
	Mon, 22 Sep 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luL5IQXr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1D2DEA68
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583582; cv=none; b=rRIl2oAdh5bp0SIEqRJePy2UAW3bMK9GIXukL3bI/XQGbClxbB5/WdoG2jpzoMGNJ4Gei5dLJPgGy8ccwlx9fnFX2Yk/OQ0VNZSQE4fmS+RiwB0XMPjIfsr1QbTiJvz07b5XF8nZ6MEAz7isWDJTBDIj47OU8ikpcH5xiDpF+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583582; c=relaxed/simple;
	bh=7uM4QyIbV0LPdV3nTKrd44Iq/FKKiRT97oaKojb1OFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtLJZe3hBscF9f2UlksznO1TALpLq2YtQ1d5JNRp7D/T4t5yw6lFBSa4NRFp0Ckv0Z19qOx6NEkTF7Ce9yu/6MHiq6oDRMLVzUD/F5nz26HmuqmoBfXjkzxlfcgWtD5SBbzEginB+6zfGmXCNWjzLL65I+9J1kqMerTlFN0ikqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luL5IQXr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07d4d24d09so841560266b.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583579; x=1759188379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zH51/jeARspJUwsrFCNitwW2KZyfAXJ+TGk65HdC5W4=;
        b=luL5IQXrJ3aaeSvUp78HzImnHB51XSIN6SjHoYYUiw72LaAzFTIvJsi3F8sNxmRy0D
         RvJ1gKw22Nt3ZqG/rt3bCZPOERKWPXS1lqhuiAmXHbbk1x0MDiHHKZ/PI1JhDndSZYvU
         +zSESHjXxi3rHXVWUwOQIOMBx1+aSmA7i3/ObsbSuFlZe3k/qDvkv114SAMvRNGx5lC0
         AuQK3OAhmOJdgffEaShb7Hpcx+VHeuyipZPYNb4djhXrWXBn9Hu98y0rtNI9k8Q6mCQE
         9nIGbzHD/DK5WYKxmRnGBxuhPwUeTNGZx9aNzu8mc5bpJ3Se/pj5s78sjfXilUFPWSVJ
         QEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583579; x=1759188379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zH51/jeARspJUwsrFCNitwW2KZyfAXJ+TGk65HdC5W4=;
        b=B3wJCmAngu7PHg0sIAy+5GGZXxQhKDkKW/oKUIQuGFytbDOIXTIJsfGfjSPfwgMIPz
         OnMpGfmPVVsrpnne/wHq9taiml5hqBJ03/g/fTLaRGTEWsiYr2uvmihnq5o/DWnnUM8M
         WoVAFPc5QDXoGtXXHKkPGKxDJlN+nzlj4X+FSIBVJusbusm3ODyYyicJ9ahtF3l9CnSN
         2p1nYAuqRrQMtITk6GCZnnNmcz3JBXFKcOFCVl1JHjJHf9PfwAWyk75SaSzS+lwXRgh9
         T96PzzZytl2Uj4v07FWxFQqD8QHfq0fP4t9PQ/pvYL+IHZlwHIo2TYSuzzEb7yJg/AY2
         KWbg==
X-Gm-Message-State: AOJu0YzKrg0N5DHDur1qM0DIzpRcE+P36ua3mboztQfEXrdQBO6pKP+8
	kPyUiCxEWenheAWYZ9bCqAOtZI1/1vvjOfbsQLyhg9tMK5ImJhxRk+srIiexTw==
X-Gm-Gg: ASbGncsgsZaTw7HOwFCZbhMR87gMWpxN2N/ZSaLxuADKaWdIltTzwrwCyVqNexan4eX
	DiT74VBcj8hTCVTrEQfb/acNPzXbEGwY85fk5DjnVo/0FYS+pVE8TsRJj+5Upac57v42Qe9OgMf
	RxtsamIXbhOi4RLkGoCpjJxTUImHtCt0r6fZXw4veww9nbY/AIz626JomuMFLPMSD4xyhX2Gjdx
	PJhMcybpVi6L1mseII4aBgHsCnmBmC99xPz0/Pex1wWVa/s2k/rZIrUx7N2o66wYjMGprmDYiVg
	2dgLTVUFVRLsEz9KsH2yrGDDUCclsHLoZW2M8pDpPCtRMtJORDOPqVIOZqIv1i9++u+yqVZikkX
	WiRvo+0yqcXD2nLQE+K16vEeE16KLFJE=
X-Google-Smtp-Source: AGHT+IF/cwJzVV1vwjuLCear8yLnIbyFqPEjJJomKDJ5inO23OX3ECwArgTavCiBjWN7v+84C6B+9g==
X-Received: by 2002:a17:907:3f21:b0:b09:2331:f14d with SMTP id a640c23a62f3a-b302dc63619mr26522066b.64.1758583578510;
        Mon, 22 Sep 2025 16:26:18 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd1102d7asm1208918666b.76.2025.09.22.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:18 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v7 0/9] bpf: Introduce deferred task context execution
Date: Tue, 23 Sep 2025 00:26:01 +0100
Message-ID: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch introduces a new mechanism for BPF programs to schedule
deferred execution in the context of a specific task using the kernel’s
task_work infrastructure.

The new bpf_task_work interface enables BPF use cases that
require sleepable subprogram execution within task context, for example,
scheduling sleepable function from the context that does not
allow sleepable, such as NMI.

Introduced kfuncs bpf_task_work_schedule_signal() and
bpf_task_work_schedule_resume() for scheduling BPF callbacks correspond
to different modes used by task_work (TWA_SIGNAL or TWA_RESUME).

The implementation manages scheduling state via metadata objects (struct
bpf_task_work_context). Pointers to bpf_task_work_context are stored
in BPF map values. State transitions are handled via an atomic
state machine (bpf_task_work_state) to ensure correctness under
concurrent usage and deletion, lifetime is guarded by refcounting and
RCU Tasks Trace.
Kfuncs call task_work_add() indirectly via irq_work to avoid locking in
potentially NMI context.

Changelog:
---
v6 -> v7
v6: https://lore.kernel.org/bpf/20250918132615.193388-1-mykyta.yatsenko5@gmail.com/
 * Added stress test
 * Extending refactoring in patch 1
 * Changing comment and removing one check for map->usercnt in patch 7

v5 -> v6
v5: https://lore.kernel.org/bpf/20250916233651.258458-1-mykyta.yatsenko5@gmail.com/
 * Fixing readability in verifier.c:check_map_field_pointer()
 * Removing BUG_ON from helpers.c

v4 -> v5
v4:
https://lore.kernel.org/all/20250915201820.248977-1-mykyta.yatsenko5@gmail.com/
 * Fix invalid/null pointer dereference bug, reported by syzbot
 * Nits in selftests

v3 -> v4
v3: https://lore.kernel.org/all/20250905164508.1489482-1-mykyta.yatsenko5@gmail.com/
 * Modify async callback return value processing in verifier, to allow
non-zero return values.
 * Change return type of the callback from void to int, as verifier
expects scalar value.
 * Switched to void* for bpf_map API kfunc arguments to avoid casts.
 * Addressing numerous nits and small improvements.

v2 -> v3
v2: https://lore.kernel.org/all/20250815192156.272445-1-mykyta.yatsenko5@gmail.com/
 * Introduce ref counting
 * Add patches with minor verifier and btf.c refactorings to avoid code
duplication
 * Rework initiation of the task work scheduling to handle race with map
usercnt dropping to zero

Mykyta Yatsenko (9):
  bpf: refactor special field-type detection
  bpf: extract generic helper from process_timer_func()
  bpf: htab: extract helper for freeing special structs
  bpf: verifier: permit non-zero returns from async callbacks
  bpf: bpf task work plumbing
  bpf: extract map key pointer calculation
  bpf: task work scheduling kfuncs
  selftests/bpf: BPF task work scheduling tests
  selftests/bpf: add bpf task work stress tests

 include/linux/bpf.h                           |  11 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/btf.c                              |  91 ++---
 kernel/bpf/hashtab.c                          |  43 ++-
 kernel/bpf/helpers.c                          | 358 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  16 +-
 kernel/bpf/verifier.c                         | 169 ++++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../bpf/prog_tests/task_work_stress.c         | 130 +++++++
 .../selftests/bpf/prog_tests/test_task_work.c | 150 ++++++++
 tools/testing/selftests/bpf/progs/task_work.c | 107 ++++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++
 .../selftests/bpf/progs/task_work_stress.c    |  73 ++++
 14 files changed, 1148 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_work_stress.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_stress.c

-- 
2.51.0


