Return-Path: <bpf+bounces-64850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C1B17A59
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5495859EE
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DD2594;
	Fri,  1 Aug 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKZSeltV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EB17E4
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007011; cv=none; b=YmGAPVcackVsfsHRWzAdP7y+Y+ApGtNTWMYLkYSXEYuGEAU98VBejGT9TGGfLJSclb3RtK4e2QylT8P7lNzB6+Q+RGnO3z7/xigaWwSBQkCKPDYWpGwXiGefe0k+dgf9HMS3vPtSBnW3yzBx/BZc8zyxAS0YYZ1MwRzMYIYu0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007011; c=relaxed/simple;
	bh=006CAAC+mAF/qo0GrHQSZ5TaiLtT/c9suFkKvoupvmE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=soDKWqPE9kyIj6Gx/LBUKMgVUFM2F3KE4fH6Fb7U45OIfCkdczosCXaQ9N71NUdwLVsLO0vkEhnG+VRPMle2MyKyDxmo5vpXsk22GDd3itOz1XQKuypwDGCBW9ALp/5ZnaiLjxNiZep6mdBQ4tp9ziHC6d/YFcKFlhsEq/w5Omo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKZSeltV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so1516097a91.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754007009; x=1754611809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDQCK2/EquRg/k7XYFN0Oigmy4lwGMoivZWG2vYqpbY=;
        b=pKZSeltVGQq3jQT6Fb+dO7HJxh295N23c/HOkDNpRMLdjck6esLu4MFa+HRwNI+IAc
         qD/WAKhaarihawSuBE4ZNMwyiY9MJPi51Nw39e9IeHV0adF2x4bx5wU4QpU0BTICvevA
         6Phc5Rj4Xq0ZI/F8u/OqTvdbVx8Dwt8sP9PADfTow0WJjAkdbfZ2Vj71pt1NMfRWPCLt
         JJ3wjSzvlEXHEQnzda0D9dORbd984Ay4eCQpDJv59XLWnGS0op2+Y42EcsZqyhSzx5/s
         69wg+VJ/XrPolOuCIXs4YgOdkb/f59YkPTqvKUxqE/pWlP+PszkuHsta1uFTYSVlG2VI
         0Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007009; x=1754611809;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDQCK2/EquRg/k7XYFN0Oigmy4lwGMoivZWG2vYqpbY=;
        b=wfFyB7K3jsku2g68PqJZqzm5jfDWH+95myQ41Aq4zAdKV2K6s5cv50BeeNtMbHdu2N
         nezKRnvncW2eyEMTCDG/IKsABWqS5b+ks6OE1Y5oicnUzGiyKIiiwjtAcCbS8sJGEn3K
         Vzvr4w39JlAtKyCpwlAcwQ51gZQsy4q9pcOB+3v8s8ZXFshTf5F8AN0RAIWN60nQkHIs
         93PThPruTORbr7hLWX/yRC4E7v5SQlRq0R98m6IQB/I4QjTOCK+JBWjDocQQJBy8pB+p
         Tcg0aDmIDn7WvCl7PiSMyTtSeF5o3GzkZ3BPYTTTBtLj9LjloWd1qa1sgT5PbJA35A6T
         Ap1w==
X-Gm-Message-State: AOJu0YyO/lxVVnYMD3QmCrvaDOWTy4FgrRej0swghTyrbJWkQ37zUSGN
	ZclVVnM5p5Ld1qSjM08kOz2EAXDoOUS+C+WCTZ1ByYuZEjuhmRY1Epx+RFEOrTBnkKpLZcPy3nn
	XPfG5ErXnvaGPvOV93RfUUWhFmG8ADvznPIezFIkqq9Pjb7tUhFc8bbWbeTBVXCNv+UZqWKKG8m
	xlgCjngleE1oGctA6N2S4p6dvk0DdynREZIE2c0QMzQNcS80AidP3cgVjFw3zTR+c5
X-Google-Smtp-Source: AGHT+IHZZ7EEAh9HKj83dC9nIQhBmQgVN1LOsyaTmp6Z0Vt/ThwRwYQj0yd0sOx+f1j3SKHolQSEJSvbzgkV8bXIpdk=
X-Received: from pjbqx4.prod.google.com ([2002:a17:90b:3e44:b0:31f:1dad:d0a4])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2cc6:b0:311:d670:a0e9 with SMTP id 98e67ed59e1d1-31f5de34fedmr12380677a91.21.1754007009400;
 Thu, 31 Jul 2025 17:10:09 -0700 (PDT)
Date: Fri,  1 Aug 2025 00:10:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2809; i=samitolvanen@google.com;
 h=from:subject; bh=006CAAC+mAF/qo0GrHQSZ5TaiLtT/c9suFkKvoupvmE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBk9rHcMgw+bOMbyRG2ad4t1jcwJdSs1bRPrHRcUWWJkV
 xyXN1zSUcrCIMbFICumyNLydfXW3d+dUl99LpKAmcPKBDKEgYtTACbymZ/hf2L8Nre7TY3Zyrbn
 JPwThYoPrQhrqL/m9fXv0tu7D5tyVDH8lS0T4/r8mnlxx7K9m5R/ecyIWLK99JHOS9+/hW53uLw COQA=
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801001004.1859976-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v14 0/3] Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxwell Bland <mbland@motorola.com>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

These patches add KCFI types to arm64 BPF JIT output. Puranjay and
Maxwell have been working on this for some time now, but I haven't
seen any progress since June 2024, so I decided to pick up the latest
version[1] posted by Maxwell and fix the few remaining issues I
noticed. I confirmed that with these patches applied, I no longer see
CFI failures in jitted code when running BPF self-tests on arm64.

[1] https://lore.kernel.org/linux-arm-kernel/ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq/

Sami

---
v14:
- Rebased to fix a merge conflict.

v13: https://lore.kernel.org/bpf/20250722205357.3347626-5-samitolvanen@google.com/
- Added emit_u32_data to fix type hashes on big-endian systems based
  on Xu's suggestion.

v12: https://lore.kernel.org/bpf/20250721202015.3530876-5-samitolvanen@google.com/
- Fixed sparse warnings and 32-bit ARM build errors.

v11: https://lore.kernel.org/bpf/20250718223345.1075521-5-samitolvanen@google.com/
- Moved cfi_get_func_hash to a static inline with an ifdef guard.
- Picked by Will's Acked-by tags.

v10: https://lore.kernel.org/bpf/20250715225733.3921432-5-samitolvanen@google.com/
- Rebased to bpf-next/master again.
- Added a patch to moved duplicate type hash variables and helper
  functions to common CFI code.

v9: https://lore.kernel.org/bpf/20250505223437.3722164-4-samitolvanen@google.com/
- Rebased to bpf-next/master to fix merge x86 merge conflicts.
- Fixed checkpatch warnings about Co-developed-by tags and including
  <asm/cfi.h>.
- Picked up Tested-by tags.

v8: https://lore.kernel.org/bpf/20250310222942.1988975-4-samitolvanen@google.com/
- Changed DEFINE_CFI_TYPE to use .4byte to match __CFI_TYPE.
- Changed cfi_get_func_hash() to again use get_kernel_nofault().
- Fixed a panic in bpf_jit_free() by resetting prog->bpf_func before
  calling bpf_jit_binary_pack_hdr().

---
Mark Rutland (1):
  cfi: add C CFI type macro

Puranjay Mohan (1):
  arm64/cfi,bpf: Support kCFI + BPF on arm64

Sami Tolvanen (1):
  cfi: Move BPF CFI types and helpers to generic code

 arch/arm64/include/asm/cfi.h  |  7 +++++
 arch/arm64/net/bpf_jit_comp.c | 30 ++++++++++++++++++--
 arch/riscv/include/asm/cfi.h  | 16 -----------
 arch/riscv/kernel/cfi.c       | 53 -----------------------------------
 arch/x86/include/asm/cfi.h    | 10 ++-----
 arch/x86/kernel/alternative.c | 37 ------------------------
 include/linux/cfi.h           | 47 +++++++++++++++++++++++++------
 include/linux/cfi_types.h     | 23 +++++++++++++++
 kernel/cfi.c                  | 15 ++++++++++
 9 files changed, 113 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: e8d780dcd957d80725ad5dd00bab53b856429bc0
-- 
2.50.1.565.gc32cd1483b-goog


