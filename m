Return-Path: <bpf+bounces-57406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC5AAA6AD
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1D23A8FA3
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082303278CC;
	Mon,  5 May 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLSHZBcy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B63272B8
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484484; cv=none; b=gWbdgYmGbUGlGkJD79tB17UPcpd3f7SrwHaAy7H6QsKJ90qXHQNbBh4CJZIakmo//mZBJQL5m4FoHK6hy5co4iU70R78BN8MSH3eieGufMo9ooT0h0zuVce3V9HsZzGEpbmW0DmmDrzPwaMldRp/vRjeIEksvfRomBoIQxtCQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484484; c=relaxed/simple;
	bh=SH63EAa398WjH+FSvuZB2bNoYzHYsiDI+PFpR/dXC1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NXv/giOdgeP8AOyF1IIpG7dj0DOf2O1A3F2WGEZJjfkpJ8Xdd3BdxduaiPKAAiMmHLcZ9R0TzwQa3NA5z+GWZ6jHScGHd5CAg3J8zSEOM+lSSm/nyTrwAyVWrqcSYxI22NtmFE+xHnCc4+RuBrOX14EVKF7h5tSHlr/1xUtRsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLSHZBcy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b5f9279cso4096609b3a.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746484482; x=1747089282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWzvhiiRA4L8aIs/fr3zNj0LxktuObjcNO5N+h/kMdw=;
        b=yLSHZBcy35mLUiSTJn5Eg8JzFyAtYwoOtRHWb+LopRyYAJIVc77WJor/t++tW8jzqW
         bMGV8rZB6pk2kDXtdrUiTC/UrooYnKkybJ6pgUiL865iWpM6EYAVpTRmcUIXIufzq4+u
         2Gpe56pIXGGU/F+S9bsEcRmXIQAmXCZybyGQ1wD3LWYT2uGXILUpdAdQcOFVDu3CT7Dd
         VUb4sdKx7lgIi7HjVV/nm/kUKwF335FvjeohrKfUCCfucb0Mlwiazv/OBEk/O3K+mgPY
         HzUMJxLKNzU3XafZjWmL3xh+2qSET0Ry35oLUofY4X057vMXt6+mDDhAM1ZRaLRynRJz
         RVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746484482; x=1747089282;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWzvhiiRA4L8aIs/fr3zNj0LxktuObjcNO5N+h/kMdw=;
        b=TweoCwJEa+kwc1MeIfM4xlUk+D3XKh9UlvJ1PTZMpy9cWfpPa1URX0Z6aFNcUxg1Vf
         YSf7X70KDAgqOK3dqQtYGgcuc5h/pP6Bj11OdrFq2ZTAKqE6RrZk6p9ssLQRXTpSs/hH
         /ZmL0FvjWdBWWDHE+ndcJwZew2ixw35gDc3yL273p8MXyJ9iiRjEzoHMIccMYvOfjMH9
         Scjhrn63sAMl4ovOhSfKU0sDrMZesWGtgg1y7p6UDhFiaB1HQko390/c99UQXU58vCXL
         XYqUrXWWeQspXaeef51pAZKNiqoSufoTpOvmZNF0tSmJdJgJ/DZv0T2i5BxrxgO7MX8+
         rdhA==
X-Gm-Message-State: AOJu0YylXJ9itw4ibjMZpxfNrpF/IzFF0QqZEmrPd/FvsO4o/NOwdZtb
	2PQcve84nip1RTITCG/3FI7ZpsFihr9uW2tUVoR9Nz8vghrQ4o1AtgO11tJEOP2Ccz9vJW3rPlc
	ilE0/5mywUkvuoBogZZ+vH7cJQwh80h9BTJBZaK/nxfQvbLt+Xw9t6aWKhsAdGy5GnxXGsVXkGP
	r2QiFyIqly2UapUblEcQe9RHVKfRjtY3ZSLf/tbxnMjAB0PalzpGMlUy+XZkaX
X-Google-Smtp-Source: AGHT+IF642o9ekk45BRGQU/RuojIgo/uuLEnnJ/ZVuZMKZbhEi9jlrvemL1lZnmFTIKLhzOuR4KmlcPhROtNl3ltMho=
X-Received: from pfmu20.prod.google.com ([2002:aa7:8394:0:b0:739:4820:6f18])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2906:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-74091a47893mr1047655b3a.15.1746484482097;
 Mon, 05 May 2025 15:34:42 -0700 (PDT)
Date: Mon,  5 May 2025 22:34:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=samitolvanen@google.com;
 h=from:subject; bh=SH63EAa398WjH+FSvuZB2bNoYzHYsiDI+PFpR/dXC1c=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDBmSNv8OMix4ciD98wGLeXOKxGQ35ixR7L/OY6TF5Hxxz
 /71mT4WHaUsDGIcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAivY8ZGVZ5T0zpspOTr7DY
 PNdEoPa4zO1/oods3sisD7jfw9ZmuZvhn9mJ5Yd9L5w+eazwzY6GvyYyJfMPflvoFFxRv+z3vif STPwA
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505223437.3722164-4-samitolvanen@google.com>
Subject: [PATCH bpf-next v9 0/2] Support kCFI + BPF on arm64
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
CFI failures when running BPF self-tests on arm64.

[1] https://lore.kernel.org/linux-arm-kernel/ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq/

Sami

---

v9:
- Rebased to bpf-next/master to fix x86 merge conflicts.
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

 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++++++++++
 arch/arm64/kernel/alternative.c | 25 +++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 22 ++++++++++++++++++---
 arch/riscv/kernel/cfi.c         | 35 +++------------------------------
 arch/x86/kernel/alternative.c   | 31 +++--------------------------
 include/linux/cfi_types.h       | 23 ++++++++++++++++++++++
 6 files changed, 96 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: f263336a41da287c5aebd35be8f1e0422e49bc5c
-- 
2.49.0.967.g6a0df3ecc3-goog


