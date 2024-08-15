Return-Path: <bpf+bounces-37295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5B953C35
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E521F22547
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9FB149C6F;
	Thu, 15 Aug 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPwrMHzJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0038DC7
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755393; cv=none; b=rMpmjQ8nBo/W9Z5P3p3G5v2XcPX+THdXT9c5J+iJnGng5VLobKNO5dgNTZsstlVYGqpWH3IwPZGpU7aK+NtCpCiT0WREp6S13sGhGnWXoFCEswLwCcuHV/ages0UgqxkXzmJz3pMFzD6+wPi2uFR13MBwfMWT595Os0j9p9ajqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755393; c=relaxed/simple;
	bh=3gmlQJ8c2NvDkR2Kd4r6Hay6/lf3oODV/K/4fxn57dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otgYFV6FtYMmBrcJekqikU4kkLhHNdy6AKjQNfLD83mOUDYpYTjY7RulgJ7BfvKAcAwdwOREGOi+WxjmSIhzhr8j6B4WrRdDaCGm5dnTnouciGaFDKZ4szLQ6dg+xMvGqT3T0Qpu0AEHNPh/tAgpBH7qlWEFFaB2bq1tucRZDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPwrMHzJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1074283a12.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755391; x=1724360191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs4dvCfikekz6EvVxE2+ZY7a100jeeimJyJ7Gsnsxik=;
        b=jPwrMHzJeoIRuMi6iwSC5Qe4Zjj305VBVzGpSv8l3hqmJohYqmtL8o49xprnj6l7yJ
         czLnrx0qCe9HqptiixNrOWyziMIig6C5empC57hhCNiO61ropk05vd+fhCoINMohmUvn
         SMySxHQgyZsKdPKIJzCRLUrBTXt+CaNH+6ek8tlVdGxNKoZFwB9luSKwgMDj6Q6h2Wyw
         sCDthbyGfhRwK41gJaCi4DDz8w87ed1ZCuxnH6YhyCAE7vHKeNVC/h+iNsiF6XT2fQom
         QI0ndrb5JwgUIklHiOjjxNzNpPIXNYQe8EZJJ/iqTcToHMixLElmPYfB+4fRsuhDSY+k
         lTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755391; x=1724360191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs4dvCfikekz6EvVxE2+ZY7a100jeeimJyJ7Gsnsxik=;
        b=pw+HinzqcAayIWlfcOGt3KjQhmNEFfYTIO1ESzC8QKbBA7XcC8Vk9+iELR+WIt3RjV
         XkaEb3xnBOZYrZ0Gpx6Fv3Iedpi+PolHx08A9KT00MFwUeAlahUl5uGm0G/hUWVh5wxV
         PpQQQ0JEDwdC/y/weUlGDEoyUKO1nA/5fpDgc3CScJ7wR7C3afFzJP1nu8JtSosPX5Iz
         wv/HOigd0Ag333LHw944Ge7pOHkfm40GtLy44YrRsXjUuaie5UipRgiGKUSFW66E5fVs
         VhsUndF2J+X9mPRhqvcOGRFAs0/BXX/hGCUXONoVBCkKNk+ZjG9vQbxIs1FHJe/ueeBw
         Enzw==
X-Gm-Message-State: AOJu0YydK/pP7B/XBupj+FUHXp3bQ9mwRyBF9/8dzbFpGFM03p0tddg4
	eWJdLUa4fvQ2CpxuTjqiZvpA492VjDjX1twSdwNILQTO1ZwI6K+MM16HSzCAVII=
X-Google-Smtp-Source: AGHT+IG7gJESNNw/qU1/6b7qmckD2Kr/z8nqgvWrdZCOxF8phpfczfM22L414KISny3VwnkLqVhymA==
X-Received: by 2002:a17:90a:ea95:b0:2d3:d687:74c1 with SMTP id 98e67ed59e1d1-2d3e04081ccmr908760a91.43.1723755390506;
        Thu, 15 Aug 2024 13:56:30 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2eb2sm4024364a91.26.2024.08.15.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:56:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/4] __jited_x86 test tag to check x86 assembly after jit
Date: Thu, 15 Aug 2024 13:54:45 -0700
Message-ID: <20240815205449.242556-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the logic in the BPF jits might be non-trivial.
It might be useful to allow testing this logic by comparing
generated native code with expected code template.
This patch set adds a macro __jit_x86() that could be used for
test_loader based tests in a following manner:

    __success
    __jit_x86("endbr64")
    __jit_x86("nopl	(%rax,%rax)")
    __jit_x86("xorq	%rax, %rax")
    __jit_x86("pushq %rbp")
    ...
    SEC("tc")
    __naked int main(void) { ... }

The last patch in a set adds a test for jit code generated for tail
calls handling to demonstrate the feature.

The feature uses LLVM libraries to do the disassembly.
At selftests compilation time Makefile detects if these libraries are
available. When libraries are not available tests using __jit_x86()
are skipped. 
Current CI environment does not include llvm development libraries,
but changes to add these are trivial.

This was previously discussed here:
https://lore.kernel.org/bpf/20240718205158.3651529-1-yonghong.song@linux.dev/

Changes v1->v2:
- stylistic changes suggested by Yonghong;
- fix for -Wformat-truncation related warning when compiled with
  llvm15 (Yonghong).

v1: https://lore.kernel.org/bpf/20240809010518.1137758-1-eddyz87@gmail.com/

Eduard Zingerman (4):
  selftests/bpf: less spam in the log for message matching
  selftests/bpf: utility function to get program disassembly after jit
  selftests/bpf: __jited_x86 test tag to check x86 assembly after jit
  selftests/bpf: validate jit behaviour for tail calls

 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  51 +++-
 .../selftests/bpf/jit_disasm_helpers.c        | 234 ++++++++++++++++++
 .../selftests/bpf/jit_disasm_helpers.h        |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   2 +
 .../bpf/progs/verifier_tailcall_jit.c         | 103 ++++++++
 tools/testing/selftests/bpf/test_loader.c     | 159 ++++++++----
 8 files changed, 513 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c

-- 
2.45.2


