Return-Path: <bpf+bounces-56286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE1A94786
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6813AF0FD
	for <lists+bpf@lfdr.de>; Sun, 20 Apr 2025 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29F91E7660;
	Sun, 20 Apr 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP4wqzWZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B81BF37
	for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146570; cv=none; b=AbJtsQE+zjKpPLMRU+aWg9QfKEru+z1Bv4STYfG5CbMtVPkaS/Y4Dm0iTfL/1KgndwybpJz0KEiMCCbtrX7BnxJsQX+FrGtyfn/NAreFWz28CBbwzYalpoZNVL7BsALOot1JUAyPiDbHp80Z+z6DPbegI/KxRnZJEalXbx+Ox/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146570; c=relaxed/simple;
	bh=CVIM+J48JOvFxRxl7BPgm+hc0jqn1XqW3sukKx/li8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1bbb25E/EnL9cCgTE97shaWS1Z9C2DNpE9QK4icjneGK2dEKPetSPo7JQNJ/StTle5NA+aNw6Q5Iw83fsHiu+L71MwYqYA0p8J8y8rkBRBblOlsHfsHh+EF/BVEbLlWvv9phfAwrZDd0p6xswbcYraCHtG/rOUA2AyDxM+0rKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP4wqzWZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4767e969b94so63522861cf.2
        for <bpf@vger.kernel.org>; Sun, 20 Apr 2025 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146564; x=1745751364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27UgTJUcWiMfi72dgeqyCqvJ403extTtOFVvXmtj3bM=;
        b=GP4wqzWZaMehT8xuNAWTVM1+SQdNH9edeEcxcL23EpQYIqnvyndWn3vPWtzV9m+svT
         2p6Km6VnjHMd4OY8orc22rYly2C+eKPd4iQcQPRo41B+5qXeXxk3vslIxDDhYfbl0f1s
         D4dhmPkBBh9nfoGULepBIyBs1Qo9DY0LiT5xAhukOIx5geQu54KGktgac3r0KTOu+/XK
         7evlOWgTM2KmUZ6lMRnKhgTZKlxea+4+QgphCTIQib4g60lTqz8+oJX0DgKOzsta/NEA
         lDBxYPtTVwhQ3CTnRzfcQVMu1XJjVmVlklbEpvOepCLEkwNVbvECwSKYS4shN0/M2hGL
         p8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146564; x=1745751364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27UgTJUcWiMfi72dgeqyCqvJ403extTtOFVvXmtj3bM=;
        b=wh1bV5RAdNw7dWiA8Nk140HYjA3iWArBQ48NSmhZwcPNWYaslR/ZzmOXCIjWI5Im/8
         W+SulXlzONkLAf6tOAOiGc8QDp/AcyJctjvPPQgZv3JkSGd64cPYnI84Md0CzA4ZFwdb
         ceiNl7p7tAq7+VF/QzE6O4px1+IH3Gs5FPpTT0h/g+q/Yfld8YuH+YBCXDu9l8UkWfWV
         4pS8iHmxrNMVAMayfrxPJCLmnyXYXB22hC39SdT3vf49Cjx1cOx2DXHs2cPqj5XKMSi4
         rDyLAY/tnQwxxeIY66Q3mZ2pr65JgA+gUvrR+LDgDlvfsdPeKhyhLcWnmtXJZtKINl+L
         Z4xA==
X-Gm-Message-State: AOJu0Yw7KRYE5e0TW6HEmRy2qMQ1PX4OQnEBW3OPh9AXV8Mgsba03gMs
	tl9lmxz64r55q0J34TNgpN4j5SiXqmgtwrNjQ8IlUDcPwEskklsIm/wFWw22
X-Gm-Gg: ASbGncuTpBQOP+VktIMqTAlLG3E+21nOKL/a4Rh24h0Fh/CyOPo132/FpXGK1dIkmE6
	4MMQ2LgzSw1k4t8J4cPwhTD9abug0i+d9nz+CIBBim+gZOr1HvqNxOpxk0PjhDQjc/smFtiFfMY
	9jDauo2DmRP+sHfS/pJNqUFIeiQWzzRMgnDIgxteE/p4Av1Xa2YHzMJG+50gMlbpSXo5/TPK+lz
	BK3bXGq6vCwU7mRpwlCioPuliwlWGwl9l9cFKqnhKPFIVJfwmFoGr7o1JXd5CRfnvpjaxPB/Y07
	338uYR5uX8e3NOh9xgzCks0xTl9f8onA16t0TrvswqRaM6Oq
X-Google-Smtp-Source: AGHT+IELLGe5TnOcYYT7TbE92mcQkzSoTJ/7ByE8vI2AeTG2OJofvyFpaGLjtkuGJOs7sKuNLdcBcg==
X-Received: by 2002:a05:622a:1356:b0:477:e07:4c5d with SMTP id d75a77b69052e-47aec393d27mr164794951cf.19.1745146564060;
        Sun, 20 Apr 2025 03:56:04 -0700 (PDT)
Received: from rajGilbertMachine.. ([2607:b400:30:a100:a5e9:b904:d3d9:b816])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c4c608sm30851771cf.41.2025.04.20.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 03:56:03 -0700 (PDT)
From: Raj Sahu <rjsu26@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	djwillia@vt.edu,
	miloc@vt.edu,
	ericts@vt.edu,
	rahult@vt.edu,
	doniaghazy@vt.edu,
	quanzhif@vt.edu,
	jinghao7@illinois.edu,
	sidchintamaneni@gmail.com,
	memxor@gmail.com,
	Raj <rjsu26@gmail.com>
Subject: [RFC bpf-next 0/4] bpf: Fast-Path approach for BPF program Termination
Date: Sun, 20 Apr 2025 06:55:18 -0400
Message-ID: <20250420105524.2115690-1-rjsu26@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Raj <rjsu26@gmail.com>

Motivation:
We propose an enhancement to the BPF infrastructure to address the
critical issue of long-running BPF programs [1,2,3,4]. While the verifier
ensures termination by restricting instruction count and backward edges, the
total execution time of BPF programs is not bounded. Certain helper functions
and iterators can result in extended runtimes, affecting system performance.

The existing BPF infrastructure verifies that programs will not indefinitely
loop or leak resources. However, helper functions such as `bpf_loop`,
`bpf_for_each_map_elem`, and other iterative or expensive kernel interactions
can cause runtimes that significantly degrade system performance [6]. Current
detaching mechanisms do not immediately terminate running instances,
monopolizing CPU. Therefore, a termination solution is necessary to swiftly
terminate execution while safely releasing resources.

Existing termination approach like the BPF Exception or Runtime hooks [5] have
the issue of either lack of dynamism or having runtime overheads: BPF
Exceptions: Introduces bpf_throw() and exception callbacks, requiring stack
unwinding and exception state management. Cleanup can only be done for
pre-defined cancellation points.  Runtime Hooks: Proposes watchdog timers, which
requires resource tracking, though minimal but non-zero runtime overheads.

Design:
We introduce the Fast-Path termination mechanism, leveraging the
verifier's guarantees regarding control flow and resource management. The
approach dynamically patches running BPF programs with a stripped-down version
that accelerates termination. This can be used to terminate any given instance
of a BPF execution. Key elements include:

- Implicit Lifetime Management: Utilizing the verifier’s inherent control flow
  and resource cleanup paths encoded within the BPF program structure,
  eliminating the need for explicit garbage collection or unwinding tables.

- Dynamic Program Patching: At runtime, BPF programs are atomically patched,
  replacing expensive helper calls with stubbed versions (fast fall-through
  implementations). This ensures swift termination without compromising safety
  or leaking resources.

- Helper Function Adjustments: Certain helper functions (e.g., `bpf_loop`,
  `bpf_for_each_map_elem`) include  mechanisms to facilitate early exits through
  modified return values.

TODOs:
- Termination support for nested BPF programs.
- Policy enforcements to control runtime of BPF programs in a system:
- Timer based termination (watchdog)
	- Userspace management to detect low-performing BPF program and
	  terminated them

We haven’t added any selftests in the POC as this mail is mainly to get
feedback on the design. Attaching link to sample BPF programs to
validate the POC [7].  Styling will be taken care in next iteration. 

References:
1. https://lpc.events/event/17/contributions/1610/attachments/1229/2505/LPC_BPF_termination_Raj_Sahu.pdf
2. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/f0749daa-4560-41c9-9f36-6aa618161665/content
3. https://lore.kernel.org/bpf/AM6PR03MB508011599420DB53480E8BF799F72@AM6PR03MB5080.eurprd03.prod.outlook.com/T/
4. https://vtechworks.lib.vt.edu/server/api/core/bitstreams/7fb70c04-0736-4e2d-b48b-2d8d012bacfc/content
5. https://lwn.net/ml/all/AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com/#t
6. https://people.cs.vt.edu/djwillia/papers/ebpf23-runtime.pdf
7. https://github.com/sidchintamaneni/os-dev-env/tree/main/bpf-programs-catalog/research/termination/patch_gen_testing

 arch/x86/kernel/smp.c          |   4 +-
 include/linux/bpf.h            |  18 ++
 include/linux/filter.h         |  16 ++
 include/linux/smp.h            |   2 +-
 include/uapi/linux/bpf.h       |  13 ++
 kernel/bpf/bpf_iter.c          |  65 ++++++
 kernel/bpf/core.c              |  45 ++++
 kernel/bpf/helpers.c           |   8 +
 kernel/bpf/syscall.c           | 375 +++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  16 +-
 kernel/smp.c                   |  22 +-
 tools/bpf/bpftool/prog.c       |  40 ++++
 tools/include/uapi/linux/bpf.h |   5 +
 tools/lib/bpf/bpf.c            |  15 ++
 tools/lib/bpf/bpf.h            |  10 +
 tools/lib/bpf/libbpf.map       |   1 +
 16 files changed, 643 insertions(+), 12 deletions(-)

-- 
2.43.0


