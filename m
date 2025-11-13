Return-Path: <bpf+bounces-74379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC37C57531
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12339342F11
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E834DB45;
	Thu, 13 Nov 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpikwPG2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADF34D3AF
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035203; cv=none; b=m/YKbbelAUoGl96HPi7TMK21bA7s/mAK6/6CtFBpJQ8s/qYKxYqxruF9xQnLZoXR7RFh9TqcYq7kAedyoN4OCBnrhhW5LgYlvZoJSz7Viepd2g+C+4JXsviOPzW1ZUY56rnQW6Lob+53SB5Qk1+TkZXOrmh39eL+hBaaQRlI840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035203; c=relaxed/simple;
	bh=wcKTYXi29mV+1guw8YDUU6A+NRswQPhohuo+sYDrdok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldxT7rshqI2SQUcx6ifWTaWezeCRNv8b3Cj6SAwFkN2F8g4CiCBKnouc8cl/EVz4mywPHcmJVopb3hWAD9xuan9uV9tGvF1Vnk6SMUGh4vO2HDvj84uYt/bPMIYCOtZpTRaRsZf9DuvJnuhaS7m7mZA2i85CDRbZpwji2tnC0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpikwPG2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b312a08a2so599882f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035200; x=1763640000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7VGo/dqF/EVEUttF4Aca30ks+x8ZXpPyJklr1zfWJM=;
        b=VpikwPG2V77pw+3jYvKRnQbm7AlIt7suTsyEwI0xKJdcFek+1nAUusoyrxqAEvG4kh
         MgyLbKHQuT342WBM+dfF9mC/KXejkLIxtBTssoEe9m3qYEdWz0SdTo2rQbGc7RaqC1b2
         LIL2nam5XtRUcGzV5vk32Ft8PfQVaR+urS5fSgxzCWMIPci/SGHbpJQ/f5Pf8Hvyao68
         +yyvf3vgA+oOyVnKfz7ovMD7qdIdRJ+HY/3zn8+7wkkJOUA/nOwV0D/vOIHMevARcjm4
         4elmIqJqa78OwId9aWHsrPpAwLjf8Vrz4b765U8yAzl8AuKC1C9OXDIjObrxj6fDdj+t
         xpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035200; x=1763640000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7VGo/dqF/EVEUttF4Aca30ks+x8ZXpPyJklr1zfWJM=;
        b=HVmQGlCqPNmkCIvC5Gf8LZKvKjaMj8afA0H2Shxduj2Xek9omt8Ue/f3PDkHdW2uhX
         eYN4Q0OLdUb8i4yXMwElu3FgBVkBZpQsc4mrI4eO4vSk3gzMcThVoIb6Kj4Ox3tSV7qF
         3jOH+3wch5drz/+s4LdvZoVI5ZLHLayQJLOCv2O6P691E59c9RX5OXbjf/d9JxfvIncq
         C9KdkGwlSZInQW2egU7wuoKOJBcNafxOJbYvz0ByITj7m1tLCmunDr2Tpv54pVAiHs3O
         4qL/q9uFPyKdBBlyuL00PV2QWp5P9uNVp47aA2V+VhYqyoG6vulYyilmTVswFT5NZCOy
         ci/g==
X-Forwarded-Encrypted: i=1; AJvYcCWu4hRFpzxxuAk1XgRmLWdCahp+uhEgs0QgEpFOObWtv8jMDbz98+/eK1QRI7UfABBO5A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMalmldtTDuE4pHjtpTWMJQAi7Gx2bhkKJh71Wh1Nyuklt0ZmF
	G0izwcoQ9A4x8/Pqt510xB363WvxngGHDaZ4uF1ucKcoV8/HHW6ZCdU9
X-Gm-Gg: ASbGncsQcPyVMYZHJmUl2/4LmnqZvWr6+SYFVkVfkSaCUyR29yrGR6ODO4w8UGXGeSr
	EGLbrR1EOw2QVtm4SKdsLa1gpdxuf+/mBzkEa988rcU20PEqVvk4v2QCwKZ9axiWz4bZL6oj3Xc
	v5jBsR+akl0ERJjHdF9ytIjNjNDES9uKWbmg5iRjVr0S99UTe47YiIyaWeHHLNqwwUSrd8M0m6V
	1a1FxVJ9O/nc5s2WR/KYnmeLe+dAefcuEpHKHGW8bm6nzpqdhlEbCjv3tzbq1IMGwLLzcMESAI3
	9rOHaBnD9KVwBDly6wbVQSw/yQX8KwqKTNC3CmW6oeaaCGtIXXZVo0NiSEg5688FEML3+loqvZ1
	EFxnwih3vlVMhmedeFCnfZ+K9f/Q/wmNBKUMIdUWLfBPuEmUKHZUT+5uNawA=
X-Google-Smtp-Source: AGHT+IFyLEdiNrHMdJDbYTrSq9KNet+uR1QczyeQlVOP7Oj8VVE0HtFyU6yjFTH1x7kaaIfUM9dlEA==
X-Received: by 2002:a05:6000:651:b0:400:7e60:7ee0 with SMTP id ffacd0b85a97d-42b4baecb4dmr5341056f8f.0.1763035199583;
        Thu, 13 Nov 2025 03:59:59 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm3686816f8f.18.2025.11.13.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:59:59 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	ming.lei@redhat.com
Subject: [PATCH v3 00/10] BPF controlled io_uring
Date: Thu, 13 Nov 2025 11:59:37 +0000
Message-ID: <cover.1763031077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds a hook into the io_uring waiting loop and
allows to attach a BPF program to it, which is implemented as
io_uring specific struct_ops. It allows event processing and
request submission as well as waiting tuning.

There is a bunch of cases collected over time it's designed to cover:

- Syscall avoidance. Instead of returning to the userspace for
  CQE processing, a part of the logic can be moved into BPF to
  avoid excessive number of syscalls.

- Smarter request ordering and linking. Request links are pretty
  limited and inflexible as they can't pass information from one
  request to another. With BPF we can peek at CQEs and memory and
  compile a subsequent request.

- Eventual deprecation of links. Linked request kernel logic is
  a large liability. It introduces a lot of complexity to core
  io_uring, and also leaking into other areas, e.g. affecting
  decisions on what and when is initialised. It'll be a big win
  if it can be moved into the new hook as a kernel function or
  even better BPF.

- Access to in-kernel io_uring resources. For example, there are
  registered buffers that can't be directly accessed by the userspace,
  however we can give BPF the ability to peek at them. It can be used
  to take a look at in-buffer app level headers to decide what to do
  with data next and issuing IO using it.

- Finer control over waiting algorithms. io_uring has min-wait support,
  however it's still limited by uapi, and elaborate parametrisation
  for more complex algorithms won't be feasible.

- Optimised waiting. On the same note, mixing requests of different
  types and combining submissions with waiting into a single syscall
  proved to be troublesome because of different ways requests are
  executed. BPF and CQE parsing will help with that.

- Smarter polling. Napi polling is performed only once per syscall
  and then it switches to waiting. We can do smarter and intermix
  polling with waiting using the hook.

It might need more specialised kfuncs in the future, but the core
functionality is implemented with just two simple functions. One
returns region memory, which gives BPF access to CQ/SQ/etc. And
the second is for submitting requests. It's also given a structure
as an argument, which is used to pass waiting information.

Previously, a test sequentially executing N nop request in BPF
showed a 50% performance edge over 2-nop links, and 80% with no
linking at all on a mitigated kernel.

since v2: https://lore.kernel.org/io-uring/cover.1749214572.git.asml.silence@gmail.com/
  - Removed most of utility kfuncs and replaced it with a single
    helper returning the ring memory.
  - Added KF_TRUSTED_ARGS to kfuncs
  - Fix ifdef guarding
  - Added a selftest
  - Adjusted the waiting loop
  - Reused the bpf lock section for task_work execution

Pavel Begunkov (10):
  io_uring: rename the wait queue entry field
  io_uring: simplify io_cqring_wait_schedule results
  io_uring: export __io_run_local_work
  io_uring: extract waiting parameters into a struct
  io_uring/bpf: add stubs for bpf struct_ops
  io_uring/bpf: add handle events callback
  io_uring/bpf: implement struct_ops registration
  io_uring/bpf: add basic kfunc helpers
  selftests/io_uring: update mini liburing
  selftests/io_uring: add bpf io_uring selftests

 include/linux/io_uring_types.h               |   6 +
 io_uring/Kconfig                             |   5 +
 io_uring/Makefile                            |   1 +
 io_uring/bpf.c                               | 277 +++++++++++++++++++
 io_uring/bpf.h                               |  47 ++++
 io_uring/io_uring.c                          |  63 +++--
 io_uring/io_uring.h                          |  18 +-
 io_uring/napi.c                              |   4 +-
 tools/include/io_uring/mini_liburing.h       |  57 +++-
 tools/testing/selftests/Makefile             |   3 +-
 tools/testing/selftests/io_uring/Makefile    | 164 +++++++++++
 tools/testing/selftests/io_uring/basic.bpf.c |  81 ++++++
 tools/testing/selftests/io_uring/common.h    |   2 +
 tools/testing/selftests/io_uring/runner.c    |  80 ++++++
 tools/testing/selftests/io_uring/types.bpf.h | 136 +++++++++
 15 files changed, 900 insertions(+), 44 deletions(-)
 create mode 100644 io_uring/bpf.c
 create mode 100644 io_uring/bpf.h
 create mode 100644 tools/testing/selftests/io_uring/Makefile
 create mode 100644 tools/testing/selftests/io_uring/basic.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/common.h
 create mode 100644 tools/testing/selftests/io_uring/runner.c
 create mode 100644 tools/testing/selftests/io_uring/types.bpf.h

-- 
2.49.0


