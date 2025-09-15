Return-Path: <bpf+bounces-68426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D37B585EB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8D03A8F74
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311C928DB46;
	Mon, 15 Sep 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxwRNu/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0A27B356
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967508; cv=none; b=U7T3YDRepnrLD8O0Q7EduVsYyRLYkGQt7Yf9b3jOUcKBAosJr8NLvLe1YWbxDnpP33Crw93YViHS7ExH7aJfZQD83syFcNrHBMmqerH3XnIcd0OithvahG2AvJCrGgFPTmF8thfn5+bQxz77i0hz8BBEtMUUOzr2gjyo6tUsj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967508; c=relaxed/simple;
	bh=en3vjoQF3HuhQnIHKTkflxpOPiVzVG+49BejCqaDGFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oG4FFCfIzG/zG8/BowEkkw9qBDwkQJ6UaP1GIWT3aM1Ivg/teq1tlzR/pwAfjBSOaHktQ1xZ7zcQi7lUvqdbM6gd7pWLyM+MqKYS6Iywt8bP234kikcVQ5cTX28f1VUfD0CSwcKcxlPiwqS7qCN8zzJWXIbGplfRiVAECdBtdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxwRNu/u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45deccb2c1eso35083405e9.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967505; x=1758572305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1xfnxXof1Phc081+fPMqV6EVG+YjHjUc7G0Ra1W930=;
        b=AxwRNu/uKAEKnZfIEgE72W5DuI0cad3wmGdaJ71h968knzN06fiZBr8wN+aB7bMing
         dWFsjpkAbUzFnugSZh/giuIcxqBrQb6HKgtI5k57ULoZVTl/jYBVv55NUi6PXuX9TH0Q
         PbcfZcqiZfW6J9bgtvCwA0hsq8yzWeWKDIgDQ/1GFCQPjJc75OeCa+YjvR7oWzOBV6qI
         pVgV+XLLo7CO4vqZxEkQZU/yMkgJ1xGZrNB1YqW86hrno6kHcl+ea8HSYy41fpwWKaRh
         guzxnZXUMUpNaAFWIsT2SqxDPbThzOko5AmxTktxz3XNzNc+hnEGBXq3oYiNEwYy5PwY
         SOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967505; x=1758572305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1xfnxXof1Phc081+fPMqV6EVG+YjHjUc7G0Ra1W930=;
        b=kOL3JkXxR8pxFdkvRw+jNeQ2njdyxghTruCB+VK8HRQ94Uc0t3xm4KtzZbBBwdf1GM
         f5I/88cnnvF7Yu9A5U5jXBQbZHr3W1VfaOpZ/gaMu8bWGE6vm/4FjjvObWFDQ4YsPo50
         C3xOT/xZbtrqX3PlSDI8CgbfDp6dG37BBEhDmBF2afbd5K4qO90GrOPVU7BIaZ7tyQ+H
         SRx+5N5X+CJTPiQlb5zIMyJPovQFnmSMLJoLyuQjN2t+lmJDS8rGEMq16Y9Vb26etqOQ
         RgVXGRbkplHERk1DawcqrBJMwwsyFDh8FvSGk9eEj/75P+YLpipEtJKdCznsBfwIh2/i
         rwTg==
X-Gm-Message-State: AOJu0YxV7CE/pUfxpqg2FbR6Cjok5OQm7J2npZzGF0Ht7Su1e+shoVpG
	G1ExR9GMN+rkvqEhWmw+nZmytNtuexxAYvh5Th9hqhMybl10atyGz62T2OAwxg==
X-Gm-Gg: ASbGncsWiP7F2ZDCcKY3qiCBufA5RX0QE/gUgJjzCZO7h5We3obMroYqNO/+IhBW0XU
	ALFFHytIVkOhu/J/bb7c40bI+b+O6i7ZxWTJ8VbWtEZWNj20aGz+P7A7lTGWQ/u8foqGSnWzeAP
	AlusiapRFnZv17qh2HtH8vcJA2uexhsdUfyKo26vVOa0YkywN1lEKgorRKBZtizEcxp/Fgi4hWm
	jhNuSNLkEH8fxUaKnbE+/aZKj2PCpzPrfsCCu5op3Jw2/zYPPjRaWwy1xU8opCchHC1ZIV5L0wk
	XjQQG6GzRAvSqDCk72KlTGMEEpUH6qk27fSrHMteHiORTXsh52ikb2IPluNnL82T5w4q+ybmACo
	xTwtvzmRJM8DEqQ==
X-Google-Smtp-Source: AGHT+IGYnw8429CvMwEOolGq83qu/knffJF8g7YiWfQcfoDgZwkmlrnpIdZcFfDTgJZaCbU7FQ3gzg==
X-Received: by 2002:a05:600c:8a0c:20b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-45f2120600amr108827275e9.33.1757967504848;
        Mon, 15 Sep 2025 13:18:24 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm190513315e9.9.2025.09.15.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/8] bpf: Introduce deferred task context execution
Date: Mon, 15 Sep 2025 21:18:08 +0100
Message-ID: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c                         | 160 +++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 149 +++++++
 tools/testing/selftests/bpf/progs/task_work.c | 107 +++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++
 12 files changed, 941 insertions(+), 98 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.51.0


