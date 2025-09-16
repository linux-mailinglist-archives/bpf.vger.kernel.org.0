Return-Path: <bpf+bounces-68574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D306B7D75E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988B17B353E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568B2EFDB1;
	Tue, 16 Sep 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWo2iepB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF242D8375
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065826; cv=none; b=LxJvhjerti8KMciuo1aBbVw2XrnBfHBcdJlgV2fH8rgFKa3ez8bwb7ICyDm05Qg8vYhaZOXW3rkIxqXo1lPB1cjmpuwxU17Bj1b0qj3xQ/4ei0DI0heRzeLby27wksZCfq4JaNfer58kQfp3CKuAE5loLyr6uMKjr+HNBPReoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065826; c=relaxed/simple;
	bh=PSbkMtEjMffsJXJNwIpQ9hINosGHSQP+ErrFhPlS81s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eot/THOyhaikdj9bNGFliHrRmQ2gLV8zG3wLeCmHjK1xYr2hexMuRgTrAm1h+9ho27dRoZBub1Lzh9GctYfDXPUlFCn1WuqBy5bC8AJFqcIrastNnJAP20qej7r6n1agaiGiRbF1ehbFeIWsFst1stfExkS+6wvksysxtM4QcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWo2iepB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de56a042dso40989615e9.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065823; x=1758670623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNRhtYtXJD3t+LhOd3NGCq7N1yT8SMNKvWVQpcDMKWo=;
        b=WWo2iepBR+XbuRUDKkkQlDVv7Bi50aq6Dc1uXW809xDEbVLGzTDFvB4NiY4U7cBG0u
         r35BzOUeN0kUS9AJ30ojMYdP9lMbimZJoiRsNsGUUf7Rx6KMu4AtSEhFQfunqTGFQJvR
         ul5hbcGe7eezknZYTJcFEB0i5SNmJmrKbDHONTHsd3wfR+CFk672E0KvOtry7rTUroUI
         NUxnjYHsCv8HKvZypQTK4lfFXtQwPxfEnzi+ojKG58IwjxlbnIfORkr4oqjniNMnpjLX
         jphFqkllIPCkjDkeGdSMkF/l/tEv2YOE3AMF8OvbaW+8DfTtigKz323Ny5GFuDsu/bQc
         ocBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065823; x=1758670623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNRhtYtXJD3t+LhOd3NGCq7N1yT8SMNKvWVQpcDMKWo=;
        b=ZqXkReTY2ZZQ49tffCE3tCsJzHVRI8+gTT/DbaUgY2zHVua/xllDmlyC+KnvlnQRIu
         jPJ+mAFGVWxPeRjF4AjxUeVr5Vr4RsfkWygc9EQUsQUCaWVYlhg0slZjwdq+rUHqKSII
         dUc1Tx2Yxdv0KNt4uTsgyRbJFYgzEnxC+M9oxktHj9T2XJupdrjkGF76Edfui9YFIrdT
         rYKngk5Wnlj4+36j7k+UmWpu/rLo5u/79BatkEq6pFzO9uUkB3OS4UpbITC4QvN0DPKE
         /EWSvrcTCpHeNfpg5KXFn2AN57tmEbn7t0awreu3t0eG+277N0NEmIvoLRZad3/VoHc7
         IC9w==
X-Gm-Message-State: AOJu0Yyi6C9O4T302CUBzXdNoQcIqL5bhfjNAub433YEC/Nc0VeM4k0d
	KpdYhIon/zhJMuR5/w5RqrNcYrbXBpTHEFxbSg75hJQm1BNeMiuKKNyWQwtHcA==
X-Gm-Gg: ASbGncsjzlwiU3/8mzzI4XeHzsccC6dhHd2j5SmjnBoCj7njj/whvydqDwb17QUKyLq
	WkazdN4b9yOjjU1W+CkEgT0wmnNjdHGKlnqsLCM/s3HO8UnY8cwvOza4nypv9jjkJEstrILaxOf
	UPd4FFkBzbMsoHKIXwsxaVdynRDyFdSUdlt3EIwvUyts9E0OJ6DeqWTjqJrs0gY0B7lMBVc38YX
	XmnEmAbmeyPVYgAtZ7OJ1itGlZp/XbZy9ydh6ZWL4+926xsI2WkwQoKwW9OHPeGLEhOKMqWQ93j
	oe61LU9ayouvVwAoPC3LlpQF/CpSSHElD/wDFj62mSr6df+R8TjJx4yCqhw4zi+xZr9T8Y/WEJx
	OLbkGrgVaSiJMYgos3eHjRw==
X-Google-Smtp-Source: AGHT+IFGfwhET57JSSYCP2P8N1uHtbXbnHYzMJ6Lt4Zs3fiRHMXqdFMee+Vqs30UVXLStEGU9ELDuQ==
X-Received: by 2002:a05:600c:3b83:b0:45d:f7e4:7a9e with SMTP id 5b1f17b1804b1-46201f8a4e6mr774895e9.5.1758065822845;
        Tue, 16 Sep 2025 16:37:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613eb27f25sm12528395e9.23.2025.09.16.16.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context execution
Date: Wed, 17 Sep 2025 00:36:43 +0100
Message-ID: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
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

Mykyta Yatsenko (8):
  bpf: refactor special field-type detection
  bpf: extract generic helper from process_timer_func()
  bpf: htab: extract helper for freeing special structs
  bpf: verifier: permit non-zero returns from async callbacks
  bpf: bpf task work plumbing
  bpf: extract map key pointer calculation
  bpf: task work scheduling kfuncs
  selftests/bpf: BPF task work scheduling tests

 include/linux/bpf.h                           |  11 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/btf.c                              |  63 ++-
 kernel/bpf/hashtab.c                          |  43 +-
 kernel/bpf/helpers.c                          | 378 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  16 +-
 kernel/bpf/verifier.c                         | 162 +++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 150 +++++++
 tools/testing/selftests/bpf/progs/task_work.c | 107 +++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++
 12 files changed, 945 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.51.0


