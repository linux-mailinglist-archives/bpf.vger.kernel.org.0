Return-Path: <bpf+bounces-32849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A232913CA8
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3191F22876
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5EF1822E5;
	Sun, 23 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrWvMgEx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF59181D04
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159358; cv=none; b=Hk5fduZ8Wjon61v9X5ZknofUTxbY0YDb1aULN3EO73dD4+P4K80ZLWwtZKxqBI+9lAt1B0YuNJyzKQ7bkZ7j5QzbS3AdbU7qlMEobawaLNSxzGC/os/K4lAE2cBqLq1a/0FsLz9EJCtCQKqmhFCxD6/dCiQtkPnztDcukGa6Aqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159358; c=relaxed/simple;
	bh=TdRJLcqJKLouKx9263teQLfolOwHZDZur7hVXAIcNcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3cLtdZq6EkBeYd48IsWcWnE+J+jHIrhnjxtSI1NYNkuSAWYK9AZnPDn/vmd3LbSv6JSTc2OrVbmwAFyG+7gmWZ7aQIYyaLxf4+2hstuSvz1OrOaZzOuPgdkzh9j2KcuJNQ+rlRd1pwObixa6r4yoPDBTBK3OQSywz1B1+6ouOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrWvMgEx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706680d3a25so710827b3a.0
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719159356; x=1719764156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSlIWdqkGWBSwXXC+4qNvOnUuLJf6BchOv7BEtVzPB4=;
        b=hrWvMgExKtx3pwyUL34i0vg+ZyY1bjCJXPrWwe3Tr/ohzTl05KCzxH47fImbbmhohr
         jeDxwq+t7uBR88q3PlNN8XNknWGd/JJDPbPOdHFdcGdSrU+7dme6GuYBr8/qDyTMy2cC
         SMyWW+1Ss2RZ/cNO4zCRdHMm97BugJGV4pbPXDNWZso13Kndbg1OHIz14R+vxv9RFKFS
         GHyHh5szDtLiAunATHa5xCZIyMM9dPJ+zKHVATXC9C9GF/hZmBqEt+3akeaZUJRunsDZ
         7vynB0oaXm35wFcVQpZYMcFizjzyk/aP6NLozuXnbwgBs1kdCsysZIY7ZqxBcPPIDAZg
         ghHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719159356; x=1719764156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSlIWdqkGWBSwXXC+4qNvOnUuLJf6BchOv7BEtVzPB4=;
        b=nCKmS7bDgD71pZYRndXlKbswJgsfT7mv2X0pClTt07DP0yOpIkY2SNVY2K8lREdQil
         X4cWWHvxiTLSYdRVbTGOvQOwjgaDykL75J5ZGYKl/1X8Tavg5GJMPyOtVgd5sM3QYbyE
         7+rjfGCVQqNU96oxhm9RnxSH+Ng3aqbsMpgpSEVNI8Q0sOvCZuT9r1Yxqd6zgkFhuYuk
         fYy+hKGdv4wv5WKDvcpwHEUzDJyU/LJ5RGpzlLgBGgZOmLhxJNlmC2P3GwZvPsdMWCZn
         DaQWRv5beIlYj/7ycQe5AQCQMRbIvI+KIB5YZg268sgO5DrOjfU1ASCmwDELVUQtp/qW
         9WAg==
X-Gm-Message-State: AOJu0YyVvkS3YiVDgZ/sjL7hSxDFJBOBpemJI4R0pxP7/9Uq2jUVd1FH
	GRFs+EHRTpmixXLjksxlkFk9T8iX4H1VRKGX6Vhghg1YGEdoKG2kJLsrTw==
X-Google-Smtp-Source: AGHT+IFJy4B1CM5D2ps7MWAl0PkfPmuKnQZGFodRsRMVVjD6bRrfmThtt1CelKkmGrU2b4NLXt2slQ==
X-Received: by 2002:a05:6a00:18a5:b0:706:58a8:f686 with SMTP id d2e1a72fcca58-7067105b523mr3470960b3a.32.1719159355545;
        Sun, 23 Jun 2024 09:15:55 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651309bdbsm4621255b3a.210.2024.06.23.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 09:15:55 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v5 bpf-next 0/3] bpf: Fix tailcall hierarchy
Date: Mon, 24 Jun 2024 00:15:25 +0800
Message-ID: <20240623161528.68946-1-hffilwlqm@gmail.com>
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

I provide a long commit message in the second patch to describe how the issue
happens and how this patchset resolves the issue in details.

How does this patchset resolve the issue?

In short, it stores tail_call_cnt and tail_call_cnt_ptr on the stack of main
prog.

First, at the prologue of main prog, it initializes tail_call_cnt and
prepares tail_call_cnt_ptr. And at the prologue of subprog, it reuse
the tail_call_cnt_ptr from caller.

Then, when a tailcall happens, it increments tail_call_cnt by its pointer.

v4 -> v5:
  * Solution changes from tailcall run ctx to tail_call_cnt and its pointer.
    It's because v4 solution is unable to handle the case that there is no
    tailcall in subprog but there is tailcall in EXT prog which attaches to
    the subprog.

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
[1] https://github.com/kernel-patches/bpf/pull/7244/checks
[2] https://lore.kernel.org/bpf/CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com/

Leon Hwang (3):
  bpf, x64: Fix tailcall hierarchy
  bpf, arm64: Fix tailcall hierarchy
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/arm64/net/bpf_jit_comp.c                 |  57 ++-
 arch/x86/net/bpf_jit_comp.c                   | 107 +++-
 .../selftests/bpf/prog_tests/tailcalls.c      | 479 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  35 ++
 tools/testing/selftests/bpf/progs/tc_dummy.c  |  12 +
 8 files changed, 781 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c

-- 
2.44.0


