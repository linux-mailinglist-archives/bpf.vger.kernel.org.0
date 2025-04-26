Return-Path: <bpf+bounces-56775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953AA9DA2A
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B031BA62D9
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31E1F8ADD;
	Sat, 26 Apr 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBDpnN9B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301052F88
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664409; cv=none; b=mi2WqLZWadYuV8OHf4G/wZ6/NutILvYbeqtUkwAVM9LWbg0dVRkNfKNCUaJHEWIadt2z1uIFn7voEqWE6KpF/fc12IXwMsoyGp0Lge8w0F1sOOGVw5xyB/UTiHZgPw7Oh6cDPtetVn9+PLp3iZzqA+Lz+SbllqqWw3OTO6qm8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664409; c=relaxed/simple;
	bh=89bQUO/QxgZghvlw52eXl2s5ePM6kP9X/ErXf1lhk7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWfc56Cywhasic1PV4QWd8iayrqW5/z2i0bKjx8rBQPUu6ryvWLyOIrb/J44LvZ5E3+GH9jRf1hXy8+KQKvBjkeXHCV1w8nsLdhDJTV21TdJvNxmKJfLfMWDVxB4W9Bgp1XCkwhCSEiq5pSCioc1bQMLv2ZDAsRvzlNCZ92gCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBDpnN9B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2264aefc45dso49499835ad.0
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745664406; x=1746269206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4oDm4Dte7ShS7xEKu8YbLjLoHa3g7YL4gaQlIE3mipI=;
        b=nBDpnN9Bf2F6V66iX7XSj7YgSaMnBGIjz59DY2SAVAbpstQlGvvFJdQouJZf7Efgpc
         b3BUCO1aOhCi0USzV1W3ePOb3cKWCYo0XmijuFZa4+YhRQ3lsFFanGRWkVOoq0qhwWxW
         vVc2yt40lhhbiLCdQkA2I+P2iR3qXls5kv2BEOoXnOgylXeE5eebQwHgVlpQSp2v4odZ
         wMbveH4PtiM59v9h8Y/ufRQrDkAEKZpyxngXfdYvYwKCXdenujxog8W7u4H/3/ZFJlSg
         J5LujOfHa271EJyTV0PW3+TO6s+sBoU0Ih3ZlmrCwPnGGaFB8rKrJOvIfS5fbQuU2qxP
         ffHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745664406; x=1746269206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oDm4Dte7ShS7xEKu8YbLjLoHa3g7YL4gaQlIE3mipI=;
        b=S3I44WZf3+HPAm2axkIYn9i82XqQOTaFMQX8BVzR2PRHGYqitowMLJNlho1y1RJl3e
         /iTJ7Cb15bcqgKZC2u4hxxekI4yjdfLxyxwWFCFunzILXGkY+uDZK0TV3EwryfrbyuZ7
         7Wpf1w97Tptn/E1r/0M2AkZ36wyGAVRGyJXWxxBsJNgX07f2WQqNljyiExV1Tof2Och8
         TEY+g9Oa65yGZ+OirnL2p7dbxQ4eqX1IR2uuR3+Lk1JGkgEB8I8WNSLiK3rOcccQXli4
         xwmkoeDjYuk0gnkzqfpuIUbuE2PyNEI2Ac/VLIqwdZgQfIpwe/7yMcQiqu6d5QpJa+2W
         fiKg==
X-Gm-Message-State: AOJu0YyGtxVKoXdKRZRdvvJp+EAJbxMPn26Cp1q+WL8OXXEK4ImOSC5s
	kWQxZ8ulHlorO2HCvLdEUvLWWzFq6d1RD931kH/9EdX3X071DpJmEEoNvWcc
X-Gm-Gg: ASbGnct1LwJ8q6yVX8/2r5gq0FOXYfWHOoiCwW6MEj8k+cAU6dR2JcfgZLW3p1qWzSO
	lwt/3a1QcwnJ0C6B9uRKmofiNLLzB1iT2Ier7tiFfBGJGqaT3nPXdh17NzyZdYd7XKY0xBbtZ6t
	J2/HMNTth3FW7gLpnBam4dlpmV/SCtp/QtqdrPNt7s4TivsA4xRcQnfFPiwgsMjvT/2PxiaiIUF
	lTq3JoTHKSa0wf9P34np5GjPczA1q7rua16vlrqRJEzv9/lA3GQlfHXR6QC4MpsDqIzysGe+W5B
	AtW+97wKte71U01xLM68NB33C82Kt4tmYu38
X-Google-Smtp-Source: AGHT+IE/+UkTyVYETlKvXyYhO5gH7NqXd6pci8bpNpTxAHCaxRZ9sa6Wh8NCWTYKqp+ibowa6s7ppg==
X-Received: by 2002:a17:902:e404:b0:225:ac99:ae0f with SMTP id d9443c01a7336-22dbf5d8b00mr83420985ad.1.1745664406450;
        Sat, 26 Apr 2025 03:46:46 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm47094115ad.201.2025.04.26.03.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:46:46 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/4] bpf: compute SCC for BPF program control flow graph
Date: Sat, 26 Apr 2025 03:46:30 -0700
Message-ID: <20250426104634.744077-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change addresses the cases described in [1].
These cases can be illustrated with the following diagram:

 .-> A --.  Assume the states are visited in the order A, B, C.
 |   |   |  Assume that state B reaches a state equivalent to state A.
 |   v   v  At this point, state C is not processed yet, so state A has
 '-- B   C  not received read or precision marks from state C.
            As a result, these marks won't be propagated to B.

If B has incomplete marks, it is unsafe to use it in states_equal()
checks.

Patch #1 introduces the function compute_scc(), which uses a slightly
modified version of Tarjan's algorithm to identify loops in the
program's control flow graph. The function was tested by generating
random graphs and comparing its outputs with results of a simple,
slower algorithm. See [2] for details.

Patch #3 leverages computed SCC information to replace
bpf_verifier_state->loop_entry based logic. Instead, for states within
an iterator-based loop, all registers are marked as read and precise.

Patch #4 provides examples of unsafe programs that would be accepted
without this patch-set.

The change has significant negative performance impact on a number of
tests and sched_ext programs:

========= selftests: master vs patch =========

File                                Program                       Insns (A)  Insns (B)  Insns        (DIFF)
----------------------------------  ----------------------------  ---------  ---------  -------------------
arena_list.bpf.o                    arena_list_add                      374        406         +32 (+8.56%)
iters.bpf.o                         checkpoint_states_deletion         1211       1216          +5 (+0.41%)
iters.bpf.o                         clean_live_states                   588        620         +32 (+5.44%)
iters.bpf.o                         iter_subprog_check_stacksafe        128        112        -16 (-12.50%)
iters.bpf.o                         iter_subprog_iters                  664        571        -93 (-14.01%)
pyperf600_iter.bpf.o                on_event                           2591       5929     +3338 (+128.83%)
test_usdt.bpf.o                     usdt12                             1803       1860         +57 (+3.16%)
verifier_iterating_callbacks.bpf.o  cond_break1                         100      86633  +86533 (+86533.00%)
verifier_iterating_callbacks.bpf.o  cond_break2                          90        110        +20 (+22.22%)

Total progs: 3587
Old success: 2070
New success: 2070
States diff min:  -15.38%
States diff max: 78660.00%
 -20 .. -10  %: 1
 -10 .. 0    %: 1
   0 .. 5    %: 3581
   5 .. 15   %: 1
  30 .. 40   %: 1
 120 .. 130  %: 1
78660 .. 78665 %: 1

========= scx: master vs patch =========

File            Program                Insns (A)  Insns (B)  Insns     (DIFF)
--------------  ---------------------  ---------  ---------  ----------------
bpf.bpf.o       bpfland_init                 975       1012      +37 (+3.79%)
bpf.bpf.o       chaos_dispatch             27025      27054      +29 (+0.11%)
bpf.bpf.o       chaos_init                  6024       6180     +156 (+2.59%)
bpf.bpf.o       lavd_cpu_offline            1419       1627    +208 (+14.66%)
bpf.bpf.o       lavd_cpu_online             1419       1627    +208 (+14.66%)
bpf.bpf.o       lavd_dispatch              59090      96710  +37620 (+63.67%)
bpf.bpf.o       lavd_init                   3066       3276     +210 (+6.85%)
bpf.bpf.o       layered_dispatch            9040      12450   +3410 (+37.72%)
bpf.bpf.o       layered_dump                1890       1615    -275 (-14.55%)
bpf.bpf.o       layered_enqueue             6443       6400      -43 (-0.67%)
bpf.bpf.o       layered_init                3874       4255     +381 (+9.83%)
bpf.bpf.o       layered_runnable            1706       1674      -32 (-1.88%)
bpf.bpf.o       p2dq_dispatch               1068       1102      +34 (+3.18%)
bpf.bpf.o       p2dq_init                   5080       5371     +291 (+5.73%)
bpf.bpf.o       rusty_init                 35707      35758      +51 (+0.14%)
bpf.bpf.o       tp_cgroup_attach_task        149        203     +54 (+36.24%)
scx_pair.bpf.o  pair_dispatch                891        659    -232 (-26.04%)
scx_qmap.bpf.o  qmap_dispatch               1703       3934  +2231 (+131.00%)
scx_qmap.bpf.o  qmap_dump                    230        316     +86 (+37.39%)
scx_qmap.bpf.o  qmap_init                  18548      23063   +4515 (+24.34%)

Total progs: 247
Old success: 217
New success: 217
States diff min:  -25.88%
States diff max:  132.62%
 -30 .. -20  %: 1
 -20 .. -10  %: 1
  -5 .. 0    %: 2
   0 .. 5    %: 232
   5 .. 15   %: 3
  15 .. 25   %: 3
  25 .. 35   %: 2
  35 .. 45   %: 1
  50 .. 60   %: 1
 130 .. 135  %: 1

[1] https://lore.kernel.org/bpf/3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com/
[2] https://github.com/eddyz87/scc-test

Eduard Zingerman (4):
  bpf: compute SCCs in program control flow graph
  bpf: frame_insn_idx() utility function
  bpf: use SCC info instead of loop_entry
  selftests/bpf: tests with a loop state missing read/precision mark

 include/linux/bpf_verifier.h              |  46 +-
 kernel/bpf/verifier.c                     | 630 ++++++++++++++--------
 tools/testing/selftests/bpf/progs/iters.c | 141 +++++
 3 files changed, 581 insertions(+), 236 deletions(-)

-- 
2.48.1


