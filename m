Return-Path: <bpf+bounces-37616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0095845A
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26281F26D91
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188118E76A;
	Tue, 20 Aug 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLYu1mSl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA418DF66
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149454; cv=none; b=TatHKJPC3VW2TPq6x4uEN3PFqGX5KZ0RDzhq5cwlzNXKIvG4yXZvVlPnC/a7/tSONABPv0Dmw+bONXzALO0UEX+1Y7Nbl+E67J3t59lbntaLozMZfSOqIcjYTtIFejZfrZ81oBSJArCRQh1Z3xJgZmphLikfNdwMhQEWH9j3dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149454; c=relaxed/simple;
	bh=dobEUqp8lcfEJD4HRWlqBt+710CakNhR8cx97jpz6jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3cZr3PR4s3P4lzUDgnVtClNn4fGobLmZ/i1spXv+7dHXGEZ2+uYl/T175DHZN7xgV8lKl440PK0RWN0WXvNLFE1XzTtfBjH6SCg+exeGfx0qoDS2hRgzgt+ya30+wTYezOoqKDQi2ndKwkOqAKRPCJ0GK/ZSFvXDLIuBsvh4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLYu1mSl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so4766160b3a.2
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149452; x=1724754252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRU3frt64gJjfxCgo+e+sUbnNe57UC7Fh/tz5nbK0wk=;
        b=iLYu1mSlW5iCqV3q1VFAzw08x1M/1FPza87U7BWaVMGSLnmqUF4MMfuOHmAJZLNeEh
         y83swnduf6JWb2UIan1ZOIhBv9Rk3/Um5Tjr6E+HybwEbdpzJKYUhYRkb3x19We7Ys+C
         mnHtOb+CmtcDnRhF2mEop7/UPLi4vQnKgxb45TlVZ4Oqtv6Z4h3F6OZzyTq6UiiRFxUR
         bF+r+2DSzPWWOLcabSjStPUsH8a2Rb2MPF3KzGpwouw/ePnjaiLs/mZVk9dqn4ukSJHh
         th/R7w8tDBAlXSL2SzwbDKffnUk97GS/oM2U0Yfz6pSOgs1r4T7xw1JJcKMWp4FZYpkz
         cV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149452; x=1724754252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRU3frt64gJjfxCgo+e+sUbnNe57UC7Fh/tz5nbK0wk=;
        b=C1mM5tn38RGvWHw5PkU4cLlsHsEKPdFhuz8oI4FQ4Edhd/hyuifXqqg7jATycLYp2v
         21OjoWZiEyBoaFhMS70YKDatFNxCBuU0TRPsvqXZO+A4lxPKd/XVRpltHuHjM12ENIKO
         spcBippIvMV8l9GodDutr71X5JiKxsqTPx0E+dnKTYeVCnpBTpnS8Z5ONvTMi5ITG7B/
         NXwpo/i7WO8ndVpnSpy9Ao6wr00rKC8agafbwvEsBm4BgAt51WWyWs4Pje3wxPLSgtvy
         vtBrzBYnuC8E5fnIr0hyY+2j55R9su8St0oGN199iMRHLgs6XQa57888UaJeCBjZur3j
         IFkA==
X-Gm-Message-State: AOJu0YxvFkXz9oBnlcOw8d4Wtf7vZEp4HxK1rvJ87LkWxJ22rax/Ng/w
	ffhb4INF/X3bk8kLm2U5i9VKvXhdHla5qmRjhuhoILE31nzQfSPP9RL/cHsm
X-Google-Smtp-Source: AGHT+IHyN2X57gOHvyeA5cYVk1ir5KjqAY80ST6FZIw0AHffzAnysaM9UBcEzHMgpvrDtENDJE8aLw==
X-Received: by 2002:a05:6300:668b:b0:1c0:f1cb:c4b2 with SMTP id adf61e73a8af0-1c904f6d703mr16449681637.4.1724149451520;
        Tue, 20 Aug 2024 03:24:11 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/8] __jited test tag to check disassembly after jit
Date: Tue, 20 Aug 2024 03:23:48 -0700
Message-ID: <20240820102357.3372779-1-eddyz87@gmail.com>
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
This patch set adds a macro __jited() that could be used for
test_loader based tests in a following manner:

    SEC("tp")
    __arch_x86_64
    __jited("   endbr64")
    __jited("   nopl    (%rax,%rax)")
    __jited("   xorq    %rax, %rax")
    ...
    __naked void some_test(void) { ... }

Also add a test for jit code generated for tail calls handling to
demonstrate the feature.

The feature uses LLVM libraries to do the disassembly.
At selftests compilation time Makefile detects if these libraries are
available. When libraries are not available tests using __jit_x86()
are skipped. 
Current CI environment does not include llvm development libraries,
but changes to add these are trivial.

This was previously discussed here:
https://lore.kernel.org/bpf/20240718205158.3651529-1-yonghong.song@linux.dev/

Patch-set includes a few auxiliary steps:
- patches #2 and #3 fix a few bugs in test_loader behaviour;
- patch #4 replaces __regex macro with ability to specify regular
  expressions in __msg and __xlated using "{{" "}}" escapes;
- patch #8 updates __xlated to match disassembly lines consequently,
  same way as __jited does.

Changes v2->v3:
- changed macro name from __jit_x86 to __jited with __arch_* to
  specify disassembly arch (Yonghong);
- __jited matches disassembly lines consequently with "..."
  allowing to skip some number of lines (Andrii);
- __xlated matches disassembly lines consequently, same as __jited;
- "{{...}}" regex brackets instead of __regex macro;
- bug fixes for old commits.

Changes v1->v2:
- stylistic changes suggested by Yonghong;
- fix for -Wformat-truncation related warning when compiled with
  llvm15 (Yonghong).

v1: https://lore.kernel.org/bpf/20240809010518.1137758-1-eddyz87@gmail.com/
v2: https://lore.kernel.org/bpf/20240815205449.242556-1-eddyz87@gmail.com/

Eduard Zingerman (8):
  selftests/bpf: less spam in the log for message matching
  selftests/bpf: correctly move 'log' upon successful match
  selftests/bpf: fix to avoid __msg tag de-duplication by clang
  selftests/bpf: replace __regex macro with "{{...}}" patterns
  selftests/bpf: utility function to get program disassembly after jit
  selftests/bpf: __jited test tag to check disassembly after jit
  selftests/bpf: validate jit behaviour for tail calls
  selftests/bpf: validate __xlated same way as __jited

 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  48 ++-
 .../selftests/bpf/jit_disasm_helpers.c        | 234 ++++++++++++
 .../selftests/bpf/jit_disasm_helpers.h        |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  55 ++-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/verifier_nocsr.c      |  53 ++-
 .../selftests/bpf/progs/verifier_spill_fill.c |   8 +-
 .../bpf/progs/verifier_tailcall_jit.c         | 105 ++++++
 tools/testing/selftests/bpf/test_loader.c     | 357 +++++++++++++-----
 13 files changed, 772 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c

-- 
2.45.2


