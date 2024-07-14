Return-Path: <bpf+bounces-34771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5C9309F1
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E17C281973
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6636BFCF;
	Sun, 14 Jul 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FchfDTlp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04721A0B
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960759; cv=none; b=b/8a1jy3+IMPZW24KAkUbbJVKi703ZTWeom31MucR7MCChNbuNqgbMOVrz9eOa199ZlUUWegmFBcNmi6s3bsgEvUP1cwrOAPa86FpCd0KKN50kcAPA9BHQw7ACLrvBTkNqq2L/pYra5TpBRDfCMorGFtpRThi116adFWR7X1XeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960759; c=relaxed/simple;
	bh=PciuoCOvIrFAg6o2M3Gyr/6uKqoRY0DwDB3s7Pl+JTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Af29wmUvqq9rX1TumoZ63I1XPWns6aG/2EC1Wv158SgQwptUz936IcarqGsrsnMNI0Mgrsae7mPpg1U342rzaBQLfQEIl17MkjO65EhcaU4M/yNj3yk9CIDHBxQhlNTCuDlIBO9qBaG3X+h3MpSE+Chs1wLHB80Zy02L7oCWris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FchfDTlp; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8076cee8607so140223939f.1
        for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960755; x=1721565555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg1fZP5wIm8ncw8pVIiBK86213OosXU9FwFg0HmdZK8=;
        b=FchfDTlpslbJu0P6z+LMIY4nSAjgn2qn2GqWejIxPmtkw3+f/i3DAnpbn0cVcgWsc/
         yHYzKeA1if9BCS6E+AiYUJ7fEBL9GBBo+cbMbAn8EtOjkQEEDivmxTcV1hQ8hwfsxuGT
         aJmqS8dEVOVP0Aznn31qj7FKGN/GqjpiNtOWrSNzMSPNchjhOXD0ak+BHmWHciuoL90k
         JqL2CwhBSLoJTH9sgQnwxXCKECBx/xnRez8kB+QMQDTd2GWv0/wG0RfwHI8vEivfIIdj
         hYmLQkgMxEd/42YevHAJYKFX2Y36DuRxvVgDRIIFnj4hXsD5QFqSg0Cg0mp+VGXgp3i1
         UZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960755; x=1721565555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg1fZP5wIm8ncw8pVIiBK86213OosXU9FwFg0HmdZK8=;
        b=cqzfHU2gbRtXvyETS3WLEWnUAPxj8h4IvJM2ZNTWCe7YlZrAE/iQRoITM7UXXJvIj4
         pa9DDmMK3GDTdM+MBXAaRNXKf6dkBKOkdHneUZxncExjgYr/WdbQOFQEfcZXZ3KGPvx6
         jgVoZ2wOqvvJg+si5jSNLIzA/sw5hYP0H26z7qbGXncaBPE53dA2dR4j5eUq4Kv9Eje2
         0dOsMgHgv9e0u8WOgpJdJdtlVech02fY56HBmC5bB0RoHWexXh4BWaR0jN8Yy70m+tWN
         ++Yup78V3QK6EpA2kSpx3Ej8Tyf2AiCR0HLDx8NP1diTF/m9lb3vGNjR8vvSqPTZIWbS
         ZVsQ==
X-Gm-Message-State: AOJu0YwnDN/rrjukk7rbjRtvs/7s6k05VbvZ13j9HVDZFKeIeeudufZf
	rinlybzbxUSy9UmPnpU7txfmSzrtpb3DTGetTS2SNkUTOWsuDrUzkL+8OQ==
X-Google-Smtp-Source: AGHT+IGL+o5eQuJhJDckstIYX+nZWrNWJNu8J66odu4eAhRr19sqcQfzwGcy7yZuDMh9fUqMW3Z+Ww==
X-Received: by 2002:a05:6e02:17c7:b0:375:b57b:877b with SMTP id e9e14a558f8ab-38a57bcd547mr219196245ab.10.1720960755520;
        Sun, 14 Jul 2024 05:39:15 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4e4edsm22994635ad.266.2024.07.14.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:39:15 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v6 bpf-next 0/3] bpf: Fix tailcall hierarchy
Date: Sun, 14 Jul 2024 20:38:59 +0800
Message-ID: <20240714123902.32305-1-hffilwlqm@gmail.com>
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

I provide a long commit message in the "bpf, x64: Fix tailcall hierarchy"
patch to describe how the issue happens and how this patchset resolves the
issue in details.

How does this patchset resolve the issue?

In short, it stores tail_call_cnt on the stack of main prog, and propagates
tail_call_cnt_ptr to its subprogs.

First, at the prologue of main prog, it initializes tail_call_cnt and
prepares tail_call_cnt_ptr. And at the prologue of subprog, it reuses
the tail_call_cnt_ptr from caller.

Then, when a tailcall happens, it increments tail_call_cnt by its pointer.

v5 -> v6:
  * Address comments from Eduard:
    * Add JITed dumping along annotating comments in "bpf, x64: Fix
      tailcall hierarchy".
    * Rewrite two selftests with RUN_TESTS macro.

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
[1] https://github.com/kernel-patches/bpf/pull/7350/checks
[2] https://lore.kernel.org/bpf/CAADnVQK1qF+uBjwom2s2W-yEmgd_3rGi5Nr+KiV3cW0T+UPPfA@mail.gmail.com/

Leon Hwang (3):
  bpf, x64: Fix tailcall hierarchy
  bpf, arm64: Fix tailcall hierarchy
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/arm64/net/bpf_jit_comp.c                 |  57 +++-
 arch/x86/net/bpf_jit_comp.c                   | 107 ++++--
 .../selftests/bpf/prog_tests/tailcalls.c      | 320 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  70 ++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  62 ++++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  35 ++
 tools/testing/selftests/bpf/progs/tc_dummy.c  |  12 +
 8 files changed, 653 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c

-- 
2.44.0


