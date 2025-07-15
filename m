Return-Path: <bpf+bounces-63382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD79B0697A
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F72567571
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EABF2D0C9E;
	Tue, 15 Jul 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykAuxHoz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D645945
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620265; cv=none; b=cwN3ZtdNfQsgBuLvaux4eLEFLQmAuNChw1IhFna9YXpkXXUtTL+ADXOqKDwpfSvQGh/O9DDk/nn52zqQCAkf3WgF2ezpAmml0An+NWnW9NKvae/zZ5i4H2MUz/XymuEkDhjI3HAmL/IU9/htQxxIWZmQ+lY0FYVg6sKT7v2wG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620265; c=relaxed/simple;
	bh=G1ncFmWqHiHwP7omxWzFU6wr0dg9BZPf3WQI0K2rUeM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VTuE66xPQAJKQbGonTnepUlOoDHRc6t6K9XJtx1nyCg72NfeyvyUm7cormTXlDbzJGm13vOryFNUyau1PeFOluQysutz4FUX3LuMGO5YB3zyXaRU5GtFP2WG82O3Gm1RIljS8MTR73LhTi9IHwGE/OE0vE9ZRBCsMS+G9bT0bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykAuxHoz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so5204679a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752620264; x=1753225064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02v14PG2SlJYKfKrfbG12osm5mwtOvoFMeYGogboA68=;
        b=ykAuxHozP6AdbLAH2fgdG/BIE42mvqrmgVWrjjCB3mMI1tnfJJrcDLRaFsCtggd9o9
         czPqwujiLSoBoWmEP0DW0k7zk7bg76l+tojNhea0/BVsngIwCiG070D/9uJJxVaZIi/e
         80TCjVarihp+2eASoCiZ6Ir5lJycDKj1JUmao0R3hzk3gie5VKDpUwMFtDOTgdNkX8pM
         6Gq5HnR9UfIz7u/AXWLGxyJ5GpV6BaI2Pln00W0nOMcUocnjLSa0T944Vp1Wg++VYmoe
         QiO/71PfzQGkFZODThrhlGmBlpt0fXehAKHjdu+YldbvxlE1MTw9UUfZ+mdCkeT5Vv0v
         2CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620264; x=1753225064;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02v14PG2SlJYKfKrfbG12osm5mwtOvoFMeYGogboA68=;
        b=oxw01MglZrVSuDATrSXmzkPmKchwEFtFZE3KH/BqkAyZfj1MY243G8rIeApnHsyEqI
         3R7yxztw8tn+g4sw8u8cnkanLUoVnzzvqlkFPlYtRl3GMdQ7BNc9L6LTsCzvzOZXyU9u
         yprKGROn1a0Rc8m2Nc48L2UpTzIMv3nqQJQAbiowz0maUCYod67nWybNfDDhgcWboije
         QYLrMwBzMlMyHDtlAYQRm6vY4OAWI8YuBES28OGiQR6rjE2I+dYcA5HjRYW+AC8PaCY5
         uSEH08FhfKiQM7NLSoMDBWkguRKqboDXLQksN64Rk7oNIVVS7GJfYLgp6wrLJwJ8gGuK
         NoBg==
X-Gm-Message-State: AOJu0YzRZajvb485D2OpTClO481LLQzneCL3ylZ7vvqEnNCVfo1YTjCY
	yJn8Ch5XlNc+wcb7iM9Ek7GUOCCInkkcacK0lnjm3QwQMGIpLE0uB+ysqkUFhqKQQoOcmZd4OBd
	eEmVMEOZlH9UcNj25wad0rajvAyIXXcdicpvDVP7nvPd2T5Hue3X0GBwDRHKhW3af2xbVZoGlbE
	BcqjoYT0bSiRpRQHErUnpPId+4Xt0g9rw9TJMY7MiA6a5PiF3u57IqbIl9xGx00fxm
X-Google-Smtp-Source: AGHT+IFmKJQBRdaQUFmCTWk9rJ+t8UKoGImBBOF3tHsLyMLW5hYcabvIQuRaVHMmT0fhN+zjD/JrNn7PN0vOapR7eAc=
X-Received: from pjq16.prod.google.com ([2002:a17:90b:5610:b0:311:485b:d057])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57c7:b0:311:eb85:96df with SMTP id 98e67ed59e1d1-31c9e75b966mr1351563a91.17.1752620263599;
 Tue, 15 Jul 2025 15:57:43 -0700 (PDT)
Date: Tue, 15 Jul 2025 22:57:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=samitolvanen@google.com;
 h=from:subject; bh=G1ncFmWqHiHwP7omxWzFU6wr0dg9BZPf3WQI0K2rUeM=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlld+59uP5AfIa1edjR3s1vD+T5vwsrP5j1IL9s+9WT4
 evlvafu7ChlYRDjYpAVU2Rp+bp66+7vTqmvPhdJwMxhZQIZwsDFKQAT0U1hZJi2ZtrNywfe7dZc
 +775SuDe+ROv3bz+v7Lij5f9v88RsZuPMjJ8zEndNHVF9Wudz1NKQx9Mrtt2busPpVmHBfJjIix qj/zkBgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715225733.3921432-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v10 0/3] Support kCFI + BPF on arm64
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

Note that in order to enable CFI for jitted code, we need to define
__bpfcall in a file included by include/linux/bpf.h. In v10, I'm still
adding an include/asm/cfi.h header file for consistency with other
architectures, even though the file no longer contains anything else.
If you'd prefer to move this to another header file, I'm certainly
open to suggestions.

Sami

---
v10:
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
 arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++--
 arch/riscv/include/asm/cfi.h  | 16 -----------
 arch/riscv/kernel/cfi.c       | 53 -----------------------------------
 arch/x86/include/asm/cfi.h    |  9 ------
 arch/x86/kernel/alternative.c | 37 ------------------------
 include/linux/cfi.h           | 37 ++++++++++++++++++------
 include/linux/cfi_types.h     | 23 +++++++++++++++
 kernel/cfi.c                  | 25 +++++++++++++++++
 9 files changed, 103 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: e860a98c8aebd8de82c0ee901acf5a759acd4570
-- 
2.50.0.727.gbf7dc18ff4-goog


