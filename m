Return-Path: <bpf+bounces-64104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625BB0E518
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84489547D10
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09AA2857D2;
	Tue, 22 Jul 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQbZkFur"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DB280CF1
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217644; cv=none; b=gEvHpFRdU67X1Xkzk6vb7TIjuZEGb2CUeUe6VsQk3JXp+4IJi/Pew6G0RuosmMjgitPz0wF8K4SRHT8BYvKhTJKWfUvOiQE5/qttbjU3ikWq54jWPZ2V0E916FbeFo/PqM7i/ffwIE5d3C8hlcW3VTExLaIautFpHnRcoY15ECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217644; c=relaxed/simple;
	bh=5Dvr+mkJ4k7PSevkjl+IB77Y7u0FpfL30Sag474FKDI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vbi1h+8s55jAfo0WlKZhMN9aj8qnyk+TXtDexZgnpr0D2UDCoPGKHjPqq4WbcFezkiQX8XcIhT1zzo3O/810MXmMUBu/ztGsTRf4jdbid0il+2/HXAiR6QIhJERYyM9wmVzkX58veXTe7bhbWZPp4u0LTwHiTtTK4Ip3c5V+2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQbZkFur; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so8720643a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753217642; x=1753822442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8x/kzgTk+8DzGIKGmGa1JqKZrjt1XWtPjZQyfMfNiGI=;
        b=lQbZkFurP+xB96GKFQDwa/+OEwe0GXGs2aj0LCNsLR/1YvbT+Ty9dXWU4iuPCFIVEw
         b6jkPqSXh+/xJOoijxOFdrHUrxribGGh58g8x7oIaDYHyXuQBBD7k/809CJB2FOsbYeW
         LqmmDIr7U/Edru43e8h7rd69GwJSwkjzvSqQRrDsTE4rz3NfFjiAnTSLgSQw+670wtSV
         MQMXpT4acX6DAF+3e42MS7MlqCsdyrCszjuJ0XoheAwF67bK0YtC0wwMwHJhM5SHPS57
         /+UeWCrjS6frCw9LDj6C8Qy8SN422OZVmnRy+KOrvU7EdrOyFs8Hge2FiWzaH49+tMpH
         vCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217642; x=1753822442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8x/kzgTk+8DzGIKGmGa1JqKZrjt1XWtPjZQyfMfNiGI=;
        b=Lw2VyYiX6QgVqrFLmOwfoQrF7WSbmrDZaOxW6/8ZXiHnXpNabTR8npuaIrEF1Cxm5t
         pLmEik+K0NyzZi7XfC6pQYlLe1PjpHwEor0nROWnbDUoucShjaPvduVK6Ru6kBFsmwgN
         InXMH8MOdZ+OWV/3yvNxIKYL8l9Q2nA6svFuj60mBHaZ0YFnNlEVtPI5fHncWwMwF44d
         prWPFho9h6K2kp6RfCFNeJ3Dut/Gr9I9lzLB8aNCDQi+QFVPz0wtpCvLTLQOLZ/I5zgo
         drO8eKobUsqPis58aKi3ltaAMdnDiAxBDsIc9wCeKwefdfP1lVcx/jQ3t9FZE7YPo1YH
         E5Qw==
X-Gm-Message-State: AOJu0YwaICuu+MsQBv5hhpJyJ5Gm6YQEzesYS7688BqsJpxdGb17BU0p
	Z03EVMMk6dr2vUg2ZEnFvVthj5XGz7lp2umSapgnD8MdA3nrqnLzwiapbgzSJadevOEW1evYdU2
	ejJNKn8vjnoz28ywQWPB9dAAYugHGwXV1dxD6HniUVfVyNJv+2KWtKec76b2yrWiuWdOBP42EUZ
	eAyBIp++s1doExeMC0BAnJMpePLHDIv4SsWJWmNfetIfcxwoxUz+Xi5mwNBXfANBmS
X-Google-Smtp-Source: AGHT+IEA36zCZ86cFQkBE3kDoLnAXUEBieGHJbD5cffQVjI9tw969NMMDrNV/SY31uUNJthT7fLe3QbpMCrOneU2NZ4=
X-Received: from pjbrs12.prod.google.com ([2002:a17:90b:2b8c:b0:312:187d:382d])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:184d:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-31e50735c36mr1026969a91.8.1753217642378;
 Tue, 22 Jul 2025 13:54:02 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:53:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687; i=samitolvanen@google.com;
 h=from:subject; bh=5Dvr+mkJ4k7PSevkjl+IB77Y7u0FpfL30Sag474FKDI=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBn1v1JvsRQVPPt5ouBge/yx0q7yQ30cnW7503807qxXm
 iN7R6aho5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEwkrJXhn/6Fx6lsFyZc1umc
 NF/BVTWh592nJ5+3ObZK7QzzMJ7O1cfIcN04pPLhBQ/jxFkzjKuCLOXO38/YoO74ws/mjEVimsN BLgA=
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722205357.3347626-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v13 0/3] Support kCFI + BPF on arm64
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
v13:
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


base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
-- 
2.50.0.727.gbf7dc18ff4-goog


