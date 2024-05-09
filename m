Return-Path: <bpf+bounces-29188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78B8C11A2
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422B21F221B4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554815278F;
	Thu,  9 May 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUUfsWls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09412FF9B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267157; cv=none; b=quyN21GWoVieoqjfeuzqD0sYg+jNKboGC3vu9xQHsyvkmXFBzKzfDDGrZC7yQov1Yui3y2OJBNmZIXzNg6gHamWIUODO1p2n+tlrDAJo48T2jhRBsJFE83PoMxUHvr2w/C2fjxwAF5pXCoVkQFSyvBdgVK/iWP+DWI6vJO1BeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267157; c=relaxed/simple;
	bh=d2hZcRBvvlwgQ8+pJOYsvdW6uDHxOY8wav9uK7vqTOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZxuneLd/cNA4kVa5jAkcmk87IayJwVnSgYho41zRlr8HPaenLbrFSQjC8q3PKOi7t+5tdAtmK9AuGwg01M4JMKMfPsemfgSNYCZwuq0TGPTjyxRoliQ+kuFmnIs72Z6v0gl24PWUSjSikt87qyv5HSW4d2OeCSX+XfX6qxVjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUUfsWls; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso5485485ad.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715267155; x=1715871955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv+lWgansv2cttVYA7E75st8qh8gu0VNksbK568UqtE=;
        b=kUUfsWlsi03wymbxHBhQq4PVccdgG6cYeRYSmkbP9KdsC2odUPUlL4u258y/K8V4S/
         CEXu5bwAptDAdMKvC1YO/pOcxNIFPOO+/VBxQnmTpfrXCRQ/RkZOKxaX8Vuwb5Nrp1OU
         CQnwXROajEiOa5gXILWiaLLBMWbXSCREMHqT2rpUgTp/DZafMqSOnyu7AbQiQWF+AMJt
         JQTxNcBhFbB/loga9/ckzzzscn/xx0uZ8IeATbqff+orufBYBekbwEa03soPQc/Z9Rpd
         409NpPhqH6N5RpKe6/Pl+zRJCq1UjN6l4V5P6pEjiges6222MvRy7lqJunFI++mkj6iW
         cyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267155; x=1715871955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv+lWgansv2cttVYA7E75st8qh8gu0VNksbK568UqtE=;
        b=lEb5iq6l9XxPE/BYGpjO/1IhtL5/ZB8/GzDd2ykWl9c1Di71UC+BgE6EQepaX1WwBK
         OdKGs02c4Gp4pYzU9le93o5K73GaZx8MPFmVIzUCaE4rsuEzhhBV8BxoCUHBJicyMk0H
         sSjTwviktTwvD9JSQHYWSduwrzpkgjS/7irxjfMxeskuPcG0cECpifCU76mpBXQB113P
         g+HJ0X08C80aAR2EwGQrVqwlitDCK/7vTIFWDxBAMPAxwPOINnjQXHEhsvw0cvCzKR/d
         Jk0PapN5J6rxd2ySOTOmFjH0uNUql6N30oqfhDQo9Qm7XqGQrB3Aby/Zkv5xdbWR1Frt
         F4Mw==
X-Gm-Message-State: AOJu0YzW4IzY/cmH93NzxUY93AlNYmbJ21Ry47X/ac1KdfinAqVYtCmC
	+lL1dedwa+RX26FtDF6ZTtgw5aeQZcb2Eqd2Hh6d3suLwLNNA3BzcZpMYA==
X-Google-Smtp-Source: AGHT+IGajJ5M7SlaB5GOQymPLywEfok7KQiTS54+nvL7HujRPDHPMVhCMTJnHJzhlG0zQmSQOOYRWA==
X-Received: by 2002:a17:902:d511:b0:1e8:37ea:d10 with SMTP id d9443c01a7336-1eeb0bad4c9mr68396755ad.56.1715267154863;
        Thu, 09 May 2024 08:05:54 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm15376135ad.31.2024.05.09.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:05:54 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/5] bpf: Fix tailcall hierarchy
Date: Thu,  9 May 2024 23:05:36 +0800
Message-ID: <20240509150541.81799-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes a tailcall hierarchy issue.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall
infinite loop"[0].

The issue has been resolved on both x86_64 and arm64[1].

I provide a long commit message in the third patch to describe how the issue
happens and how this patchset resolves the issue in details.

How does this patchset resolve the issue?

In short, it stores tail_call_cnt on the stack of bpf prog's caller.

First, bpf prog's caller has to zeros tail_call_cnt on stack, and then to
prepare tail call run ctx by wrapping the original ctx and the pointer that
points to tail_call_cnt. Next, it uses tail call run ctx as first arg to call
bpf prog.

Then, at the prologue of bpf prog, it has to cache tail_call_cnt pointer, and
to restore the original ctx as the first arg meanwhile.

Furthermore, when trampoline is the caller of bpf prog, it has to prepare
tail_call_cnt and tail call run ctx on its stack.

v3 -> v4:
  * Solution changes from per-task tail_call_cnt to tailcall run ctx.
    As for per-cpu/per-task solution, there is a case it is unable to handle[2].

v2 -> v3:
  * Solution changes from percpu tail_call_cnt to tail_call_cnt at task_struct.

v1 -> v2:
  * Solution changes from extra run-time call insn to percpu tail_call_cnt.
  * Address comments from Alexei:
    * Use percpu tail_call_cnt.
    * Use asm to make sure no callee saved registers are touched.

RFC v2 -> v1:
  * Solution changes from propagating tail_call_cnt with its pointer to extra
    run-time call insn.
  * Address comments from Maciej:
    * Replace all memcpy(prog, x86_nops[5], X86_PATCH_SIZE) with
        emit_nops(&prog, X86_PATCH_SIZE)

RFC v1 -> RFC v2:
  * Address comments from Stanislav:
    * Separate moving emit_nops() as first patch.

Links:
[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/
[1] https://github.com/kernel-patches/bpf/pull/6999/checks
[2] https://lore.kernel.org/bpf/CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com/

Leon Hwang (5):
  bpf, verifier: Correct tail_call_reachable when no tailcall in subprog
  bpf: Introduce bpf_jit_supports_tail_call_cnt_ptr()
  bpf, x64: Fix tailcall hierarchy
  bpf, arm64: Fix tailcall hierarchy
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/arm64/net/bpf_jit_comp.c                 |  63 ++-
 arch/x86/net/bpf_jit_comp.c                   | 101 ++--
 include/linux/bpf.h                           |   8 +
 include/linux/filter.h                        |  13 +-
 kernel/bpf/core.c                             |  19 +
 kernel/bpf/verifier.c                         |   2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 479 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  35 ++
 tools/testing/selftests/bpf/progs/tc_dummy.c  |  12 +
 12 files changed, 817 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c


base-commit: 2a4c29ba6900228ed7029eb7dedf833e47338644
-- 
2.44.0


