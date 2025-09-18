Return-Path: <bpf+bounces-68783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3A2B84CCA
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09917B42B5
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3B30C348;
	Thu, 18 Sep 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auoj25AL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E09309EF0
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201993; cv=none; b=SAyAcIK+3+J2Y11rwZf7Tk1KlllLhGEpgkD7WI4/FHwXEgxWImjH6jlqQoDL1cBxGeyLV8iI3B9Oja17umz+JGrqMf66p8+PydgZ1O27Bp8mH3tIhUxcpvgFl4tbhzs5zzbD8RD9fTikRXbe5ikewxZm6f7mNSwp1B4AXkIBQ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201993; c=relaxed/simple;
	bh=P76zJJ9u6hMjbuJIp2WzHa9NRpOExJHlnRTfQA4J1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WlZ5UqSU8AWGXs3dlkICnX69AADyy2IKJFKbxyGNPrgmJRCqI+XcLP6WIdi7pJ5BT0hOE/9mTr8nJJnojl0KFqlNvtWoGokFnpnItlkhv3D/dYfZcULdKRs9c1vgM6EMChe44RDiJhlnMbELoCMcOfBbyorVXwfSyD4VQHndiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Auoj25AL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so326727f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201990; x=1758806790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lcounAhHjLSYerZs3226Im5GNG8/rR6SpT7/J+rQ25s=;
        b=Auoj25AL1VIAUSikq9wlaZ5jBnuO8KY4uesMFguCwEbsb1RI1ozxa3z+WTvqBUER4b
         H9hkUjwVOE2s72RxuMuQY0qethd3Sz5/PpH05pK1rPiATHKBLhiwhH/oRH9hHX4tQgZe
         b6YsWUjsT2DcmSAWi0RBVTuSZ9bWgWBRLyZ0nAHfN8lgPXu4ccMkyTxWn0qN8YQ4c7x+
         XFfSlHEySB9SU/Ik1m0CF/yrGs9OXkM9f51pBKUvb8xITv/tDPGXCMpQGP/mXgLyQm5M
         BxCfkKLNYRnsrW+wp5Oy79gBEG5axHKYB73iLSu3tv9eoPSOG8LF/6t/TsciJrAKgKhQ
         JUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201990; x=1758806790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcounAhHjLSYerZs3226Im5GNG8/rR6SpT7/J+rQ25s=;
        b=gd0gtL3Bo6T9HHKL72HqydDm+4SwGLd63s8QKvLLPIIey3/0QOvuPsae9EsbN8RZ3k
         QIk3FNmuGH2kMqxKjFESL3F3R+MqUjxg/k6SM5oJ87of+oAXPkRLkEnYUy5qvI0toUxA
         CZTqpyNNWQNsoqxyS4jZ80cBWaQWAiGWmpp6QzISOoU5WiLTnQ+sAQaKFpuLAk+7lyzy
         K4qyRHo7OydsvjEAnkhTx2QvEPYJk7R/V0UrnzVVw5XlLLcQPiaDkl5pH+55CGPK6GDu
         7i6JPTGEJCwXwW3wOONXf4BlWeCZAD5OfC7/HMEC3KkEsMuNTffwMQslAn5Xqh0vsKZV
         2aXA==
X-Gm-Message-State: AOJu0YwZgTZir6aywWmNxkqcOg0mxZ/JwYBWIBSRgRC1rCpZ2+qXTq1I
	wZ7MT6FkCREZaA2E4ovBIRq+EjnMRUTuCB2lDT7k2NA4pIIkrG3B27kDFexQo/6z
X-Gm-Gg: ASbGnctsc+A52I6nECQEFCO5ZSlNKLULfRuOnxlXXrJKpLt8psGaeXsj6GukTVuEPnm
	f9OOpml+cq04UPtfsL6LP5EzmUUwpWgNsxoBhSHTci0gSUfxMZmNWy842uIZMARkNgMneo3NJ3E
	SY768DXAzCOMflMGA6JJCuBKqSEV9GxhBO120gOLhHmwiRMa9ZzM3QkASe6qDL6dck4+CGdvVzk
	1peN7gBa/zKjCb5zdc51qQs4BUkQYkHlQXJtV4K0KK2kj/tqmb5uGRRYJo/QYpEvwsO1r9QWFGG
	OLlh9ChxiVkr9Sq9JMOdeYD2ryVKfeFSriGPEzb7EBr5+JLBCJ+NNX2an3mjxwihuqbEtM7WT5G
	HBicVJBNDD6ioRpRvWKD7
X-Google-Smtp-Source: AGHT+IHjh7xld1IULadNVMD5xpOeB0pyknOqC9/8nHAa48VG7qAkvLq03LsgCQygfXmDeZDQlzrcNw==
X-Received: by 2002:a05:6000:2313:b0:3e7:42ba:7e66 with SMTP id ffacd0b85a97d-3ecdf9f4477mr5767633f8f.3.1758201989420;
        Thu, 18 Sep 2025 06:26:29 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407ccasm3703319f8f.15.2025.09.18.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/8] bpf: Introduce deferred task context execution
Date: Thu, 18 Sep 2025 14:26:07 +0100
Message-ID: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/helpers.c                          | 377 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  16 +-
 kernel/bpf/verifier.c                         | 168 +++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 150 +++++++
 tools/testing/selftests/bpf/progs/task_work.c | 107 +++++
 .../selftests/bpf/progs/task_work_fail.c      |  96 +++++
 12 files changed, 950 insertions(+), 97 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.51.0


