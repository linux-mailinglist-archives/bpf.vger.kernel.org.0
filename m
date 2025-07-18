Return-Path: <bpf+bounces-63773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A820B0AC2D
	for <lists+bpf@lfdr.de>; Sat, 19 Jul 2025 00:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB185A5B62
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2E7221737;
	Fri, 18 Jul 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJklchXx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4951E5705
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878033; cv=none; b=pcPyZN7T4tOE06D26sbwICmwNFn+l9EwJlqj/O0BEdENEelAuN+bLj3HAbmkXAcQm6+OSbnN/3axzNd/ukB825UnkUHMg1jxTRD9V94M5s/biidfB3zITy4SKzd2SmyJqm1lL88v1mEs0wfn8DfN09nAfOvfWEbHbXLlvijf+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878033; c=relaxed/simple;
	bh=Zkabl1n/hoOFs8GvSG+qj0P539pNqpMrXSATdXERG+M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LyX+7k1ds1zBl1JuY4IibzzgdcshU5pUEpgsYTT+sYp2gqc1/BLu8mg+isjIlOJL3a10wo3o03IkLcEyqwjCuwNGJdcJe4GPpgWjJNE9zWRkzz1/jzPBWvqaqBvXZ6GdyUBj2MRFqq0R+t29mAEESIoYGJph5j7bkH0IxoXbOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJklchXx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74913a4f606so1894128b3a.1
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752878031; x=1753482831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mD+HVqN3WPJLojBzYXQzuQgwE2qXKv+6zoEogWdZmKs=;
        b=kJklchXxb9pLO9d4RGp55DzlNvygnZLZADmxgGMb3RoTNyNrjLFQnkQjVYtWqxyFcG
         WaUuXYeKZM5H66rm7WOWWeeyubr9pjVRXGcDa0oIKbh1CGok2wpxebhO6Ny+S9eTnhql
         wtN4yodHW8Ydxrxej+Iz7Kwk4nu1LKvL9I3B5DHq9IbqCRlvqXmF3tebhhjUcQRDdMa6
         SNgWwR2El7vQt2GtEaIK8jPdeQyGj1lksQal+8QQPa7SV+PaIEABQ8L8NOlzvu45A6Qh
         ZuWwTT/qIWQtX0AUOE0rMNau8St2Dtkw8KOV8QnaWaGK/j+zFzvAM1iUAc0SeBzIQI7T
         g81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878031; x=1753482831;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD+HVqN3WPJLojBzYXQzuQgwE2qXKv+6zoEogWdZmKs=;
        b=Hc3C0SrWwUOupQ/j8aSFFpzXrFlMUpI4Xv3r5amGYxmJKesT2dCS3Rn+jebMwQdibM
         VYMkfDrB9KXZRUMT91f52okSaLV6Grp/Yt2T0C2tx8khEsbJ7/tR73FazlGzLIEh4gHW
         WuTeh0MiQbZgwKsj/c0dO9lzSLmicX5UvMS1DkHznwhbSD5XpdQFAfZy/QVLwwfr5h46
         AtASiprouD+JpAz332WT/fPAwGUfEFdVve+994b9GbtXQpaqkm17VPbEXuZVFoJpRqgi
         E9dJXvUJWVTRRm6v71OQMywMHq8P+AA0cwJzafBhZK59/lpHh/eHHo0biVS+mmsX3Dsv
         Levg==
X-Gm-Message-State: AOJu0Yy/9Ks/oqEbuindD27cO2GKG4iniGGyfXRTvzxdhI7cZRcGswLj
	KnDAelafwQ0ETSQ8Eh+Gryl0Xl4JoYloX4jzErkE0AYyyo9zPT5Ti92ZVFOFxjqB7oY0ACfxWEH
	dvZZZGHd2bIXO2UznqWy/eJnnwRB95fYy2IGSsms4gmWoNxKpquiixY3Mn1gLmi1PDYwrJhK2ks
	EOq9xLVDCyefXcCRFl1v4LVsewPcAzPNBij9QPLWWwPe7ihxjkAD8Ric5Tcj54BG8u
X-Google-Smtp-Source: AGHT+IF76ZDCYrFCXNd39CP+g3cbr5cmPiGoyqrtsyE1XyymU0tC7E1N3q1xzAmrH00ZwIvhlGH4+Q5SK9tcWWLFN7c=
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:749:937:54c8])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a11:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-7572427c40amr16482133b3a.14.1752878031332;
 Fri, 18 Jul 2025 15:33:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:33:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=samitolvanen@google.com;
 h=from:subject; bh=Zkabl1n/hoOFs8GvSG+qj0P539pNqpMrXSATdXERG+M=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlVp09yb99yReHUEnnh9XXLP+yOFPoX9ZFl7fVN93Oas
 25w/+C40lHKwiDGxSArpsjS8nX11t3fnVJffS6SgJnDygQyhIGLUwAmkjuL4Tdbvx/Lqtf85UsW
 m7ad2MB27gB7QyinO+/h5U/rVs+cn5vH8L+u5VH6sawg+3u2QVetYneeCzyt/3pKcGWHfNDyz+o MfUwA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718223345.1075521-5-samitolvanen@google.com>
Subject: [PATCH bpf-next v11 0/3] Support kCFI + BPF on arm64
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
v11:
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
 arch/arm64/net/bpf_jit_comp.c | 22 +++++++++++++--
 arch/riscv/include/asm/cfi.h  | 16 -----------
 arch/riscv/kernel/cfi.c       | 53 -----------------------------------
 arch/x86/include/asm/cfi.h    | 10 ++-----
 arch/x86/kernel/alternative.c | 37 ------------------------
 include/linux/cfi.h           | 47 +++++++++++++++++++++++++------
 include/linux/cfi_types.h     | 23 +++++++++++++++
 kernel/cfi.c                  | 15 ++++++++++
 9 files changed, 105 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: 0ee30d937c147fc14c4b49535181d437cd2fde7a
-- 
2.50.0.727.gbf7dc18ff4-goog


