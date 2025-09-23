Return-Path: <bpf+bounces-69386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5FB959F1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B98519C29A6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E13218BE;
	Tue, 23 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw6BWmar"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD72798FE
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626653; cv=none; b=VjUAe/y9oDs8VWkWbSFzWgfaYrd9G8+1BMJr1FUkVG+Csevn80jWw7c/E59BVX1reG/rcH7qNfuxEbkSxzjhmKUyZmeoACvmAweegkB6TpxJE+VgEmjFk0I3xbJWdyvEZRY6GzuyfIxFzX4Vciah2ELNWMQpz29vtZaTMWS0cGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626653; c=relaxed/simple;
	bh=WMHmjK/iUOJKPdYL+XvfRWlFLj3dV99KZOn2YYeRqZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cFwwpfGoRguduQQuTr0YxH8FGTCK5cOP6JQfTd1SIq/JNFJrjZ7d6kXYve0dePb9YPgDhOEgB8AjyZjiTgg0aVGF6AR5fRqdv+56ekVpbngTfjKHhxsrOAXy/N/hnqWmsfuKC8wAb0SH0EBR+OIq4/+RKqjhVTUAK4+THlix/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw6BWmar; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so9225829a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626649; x=1759231449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gJUSwc11PGF5OqslBvKc2N8K6YRI4hS9iT03GzC7Ww=;
        b=Lw6BWmarG29aQCwTcY8zaH6H1hY3gNLa1b0HOJR0od1NRhLzFxmHIBLCOvHL6wydnv
         b8msc6splaZUPdDqadP90iZtXPyxn/F5i6WyuMQp6YzYM5kfZdQKMYBxf8kW3fp7t4KK
         fBk/dSeoJSVrAqlHT2yB0KwrAVej/DQssdUhmVgSKVfD0ts8SYLMDKZKKd6+TXLlHlhA
         cwobcV0ttEwjjv+vhDnW1MMBFh5frm1Od1ixMBw4LtyRYM8Q6PUIs3xJvM1L7ToqplaT
         iIFu7IjMEw6oSNV31Fl/RNy15uZUZ8tiQBPDQPJOKfzC/zKPY7dXwax29mOE0K/3cghw
         anKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626649; x=1759231449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/gJUSwc11PGF5OqslBvKc2N8K6YRI4hS9iT03GzC7Ww=;
        b=kFMkNmPH7oxLe6ZU2qTvfjrIxmBOLnVg5aBYMZOHQPvunT2v/ViDm5HeMqW0rbscSR
         O25whA2SzkLOSHj2DYNVpu9LRkhuk+CCheu9OHlliSxa0xuRmB1bit0lsFLda5QA+Bj1
         3LlqW9WnqGEneCze0r6VpqYfMEGD20JjmEHuGdO2hq9BnuvmrCKjIMyDP6wv5wknf1Ks
         AEfWXSsQV/YdgTHuHoYwM+327eP0Doi7WmzWC/EsTL1LbOtgFpQIKm+qDifbIbItsjWV
         EJ/mW2fqpUyK86y5bOrokVcVLn4/LrI8tY2lt06WX/pZ6qhCbyyAwtjSA+RzlURPZ4Xz
         p6wA==
X-Gm-Message-State: AOJu0YynfE7VTKws9eNWJSjm6f8TZERWuM2x4XSAvcpfYXhPUg49c/jW
	ku0dGcOMgyMxPs4wejXxVJM+5lfDdHcViuMT9Ff2i3Ti1Jif7ns9JJfRrQKvjg==
X-Gm-Gg: ASbGnct08PdTPrGL9GDejJrEJ0Y1cw4u+Ajp8F0vufR6tMA+NUe+h4rWUXPH1LluH6L
	1xKmvLfuwVGNTFMbk11bVI7/mR7KHzFSMWjkI6WVYMWEAZSy4ZQcXrYmgTTFnKi05CCJaQTf/P5
	TbhJyNEXgzfBbpaO9YNwkMsf87dFlvHHZhbtrkMiOe5K+JnBpMz3pQfRgLnHXNcor3LCi2A4bMJ
	lMfJP3o3G124APyqBCgKwAOM9Erv8P0ErKk4pUv1exPujGK6Q7ndhYpUAsGTtVey1JAlk5qiKlM
	FyHBYIRki/vG0EiRmfJfY9ypiD1zMY3r11MA0GzE9x5zREKU503yoBXEs0hClfg2MEd2yZZNd3T
	HzxkiEQ7OOQ6abbDGAs9caavVPgZQ2A0=
X-Google-Smtp-Source: AGHT+IGULKL1UzTuHQKR2mwR6nGZsd7wM5GblRffYxNm68Isdl3JKSq0dGyS9e1M5x9r0hpRWOL9aQ==
X-Received: by 2002:a17:907:2dac:b0:b04:37b2:c184 with SMTP id a640c23a62f3a-b3027b54ffemr250974266b.25.1758626649304;
        Tue, 23 Sep 2025 04:24:09 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b28a990f6e1sm750159366b.37.2025.09.23.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 0/9] bpf: Introduce deferred task context execution
Date: Tue, 23 Sep 2025 12:23:55 +0100
Message-ID: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
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
v7 -> v8
v7: https://lore.kernel.org/bpf/20250922232611.614512-1-mykyta.yatsenko5@gmail.com/
 * Fix unused variable warning in patch 1
 * Decrease stress test time from 2 to 1 second
 * Went through CI warnings, other than unused variable, there are just
 2 new in kernel/bpf/helpers.c related to newly introduced kfuncs, these
 look expected.

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


