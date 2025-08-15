Return-Path: <bpf+bounces-65784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7AB28648
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32791C804A4
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904B25486D;
	Fri, 15 Aug 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRRtJvhv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA7347DD
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285725; cv=none; b=A9eT8pd90/zOjqrx1TMQXrBNq0CyQtyeI7fhX97/m5Ak0pa12abwWj9JnsQkhqvbQn8cXdXBK9O0BsVKapjtV8GLSHSOIHfiyggiAE8n+UyM51zgdpBQjRvpNAxs27H3jXa9DzQ/BqV+r9bRnGW6SPwssg1ki+rOtIJDW9z9A98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285725; c=relaxed/simple;
	bh=YsNRCYhqR5fYL1ON4mc7Bp7C8jGWIpbOUq62GZRZHM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=junw+t2UXE+WCGO4LFNEdaMgnFPtEZRBghXZsoqRZpV18P/Ksu4XuxYVD5Uu1IkGwzCS4or10chbBpQti/zPibOMwa1OiPlGHfUNKhdg7tcZ2rJbuhNL9FGAJQKPQztWmuFvL893TaTXrma0iN7bazAsCMsbqrI40njty7gB42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRRtJvhv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so9750965e9.0
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755285722; x=1755890522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O6q5afonXLK6rFjHnZAk7V17LKD75/pAmoCCE46m7o=;
        b=jRRtJvhvApPXTD1LhzJuiYAEu2QEr8CrfKMFuR0tmhXFAu+YPTh/gaduFdoAdeKHM+
         dYtP1X+mGsbHgDiGRnclfiHDb9sg+QEERbh65w/jE4WBpXQWyD/CmFPEjy0dowFAX+Ar
         exCkfe/0I+ZDvY6pzP7/TgOCu5ReYD6sXR+TEWUG22bsU5NbkGjHM7/V/st4U+lQwB2n
         syGp+hamF5buBEqiD4u8JGPMzU0n/1lCdh8FZKLsA5zABz0Frs8N1+FxhHYaF+nSrJ5v
         WgraCYHNJcvxPlFsnkhLJW2ULBOQQuyVlrCgPj9wzDZYnRXtdzNnVDhHWRYlIOzJbs0M
         Flyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285722; x=1755890522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O6q5afonXLK6rFjHnZAk7V17LKD75/pAmoCCE46m7o=;
        b=BM4vkQRfR6CDht8xt6L83BWZ6bY734acy9tixRpMCqgZXOpHXmYpLgwJpIaKNjjhMJ
         IdKhTVgGY56IzJ03184F9Do7Xu5ZTue6Otgz/jR+7kPzxFi/2o2X27LR1nSOckcz/Mfx
         F1kjyonPI95bHuM9a3kJaIb4y//SuCa9wdhgH9TMmPh5nr8HeEhbeMAimmKMIUrftz2I
         gpDF2byuhycg+WvbgKolTUa3BrJBBxAcaMn9LbTOF4qFQgoJ0PWaIPf9ZK9OaWupddPt
         MDLAJk0CcqWlBCBI7zv/xexoNOHcjE/XvBOe6lDBev0TswK8fPGPlrYJE9NLg3HHzSIc
         whoA==
X-Gm-Message-State: AOJu0YwE08sgKsmDsDpSv9Vo+eHbIEAiO3v8Kghhf/jUqeZFfjgLuPTM
	TMlN2QwxOlurzNmsjavU+XEfRYoAM37a6N2AHAfY7YmNrHyokwOjMkrnNi6+GA==
X-Gm-Gg: ASbGncvpUdpcBPfgoIDLMenPaPF8jCguImh43mq1pU7TDMBKa2XNYgsFZjGLyS5m2kQ
	mBOeyQX/8vcxZMaBIJlyJcCNKyxwHBwRZZgU829XDV4hPXMybm9UtqqhTsb+tkWf3Casm7nOvza
	RSRIrYcYNf1vde23CuzOQFkiYT75WzPg54AboL5gTlbx9YqCi3e1Wu9/N/wfboLwHU6yzqnXOx5
	9iPjEW+iywtMi+qNgofrhc3AtjxAjt1LV2/f6T2PWyVM+fl7RYM/FhtZ/f0StpRy3zC8ngaMAiT
	0HIMqivv/RKBYzONvwf/I1CA3GRJb7mc65ywCma/ef0io60ZM4CJ1S0WG8DoNq+dRiCa5Khc33A
	4VZYuDQRtUlSn5PweCQo0
X-Google-Smtp-Source: AGHT+IGJmopO3lbdcR1D2Phz7ESDKCDBYhV4uulXT6s02UnyDlFhkXUpwP7hmrZk+voke0vjDStZGQ==
X-Received: by 2002:a05:600c:5493:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45a246c5ec4mr14895615e9.22.1755285721839;
        Fri, 15 Aug 2025 12:22:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a23e97c11sm22796435e9.1.2025.08.15.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:22:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/4] bpf: Introduce deferred task context execution
Date: Fri, 15 Aug 2025 20:21:52 +0100
Message-ID: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
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
to different modes used by task_work (TWA_SIGNAL or
TWA_RESUME/TWA_NMI_CURRENT).

The implementation manages scheduling state via metadata objects (struct
bpf_task_work_context). Pointers to bpf_task_work_context are stored
in BPF map values. State transitions are handled via an atomic
state machine (bpf_task_work_state) to ensure correctness under
concurrent usage and deletion.
Kfuncs call task_work_add() indirectly via irq_work to avoid locking in
potentially NMI context.

Mykyta Yatsenko (4):
  bpf: bpf task work plumbing
  bpf: extract map key pointer calculation
  bpf: task work scheduling kfuncs
  selftests/bpf: BPF task work scheduling tests

 include/linux/bpf.h                           |  11 +
 include/uapi/linux/bpf.h                      |   4 +
 kernel/bpf/arraymap.c                         |   8 +-
 kernel/bpf/btf.c                              |  15 +
 kernel/bpf/hashtab.c                          |  22 +-
 kernel/bpf/helpers.c                          | 325 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  23 +-
 kernel/bpf/verifier.c                         | 127 ++++++-
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_task_work.c | 149 ++++++++
 tools/testing/selftests/bpf/progs/task_work.c | 108 ++++++
 .../selftests/bpf/progs/task_work_fail.c      |  98 ++++++
 12 files changed, 863 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_fail.c

-- 
2.50.1


