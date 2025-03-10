Return-Path: <bpf+bounces-53769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F1A5A72F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F279A1712B6
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9B1EB5F9;
	Mon, 10 Mar 2025 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnNuzUV7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3991D5150
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645794; cv=none; b=JlEHBAucMLx61QGvEdiXj4d8SNQmca0aiPofYPR1w2bnJoQicPLn/jsBRfQs/Ih/DiMcN04hSREMPu2wj5qC/mbgHQHHP55/+Yhd1dRIj9rDmDcaOvskWXIvzUMEsVYNn0X0TtMqe3Ii37MIPQ7VLBZBcWGVAGPlRhejufoPabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645794; c=relaxed/simple;
	bh=S6dZKRDvk4ycBh4lQTb/260u8CBi/1VAPZFB45kS0CI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ojrc+MTF/1Zazm4Hm35qO/0he99mVO8ZT7/KrAEkrzCMoXFoZAGEfQP4IPLRb4RK2ntgaJpVbExDRAG1Yfkhv5mgFyWJzJsx2HQzUMJfvQbIHH5FtdY7nun+M/RciWigEkiGBorqQoLLGp9ErLE9dpPH2vb8JRINggzCZHkL4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnNuzUV7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242a6d5775so41346585ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741645792; x=1742250592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DVCKVVXkluT/sD5JcZAkD4DoB+y+dtTT3SJUvxk8QfA=;
        b=CnNuzUV7Uo461FlrAZKULcfaMeSsO2lufur75sx6ifEDsj3IchTgVxV7XAzLIUUd+n
         tfrP1JaSUOmgNWwMCacBnGkTP+O+V4GOrFMNtxcySd5XxSQ/GHS0wa/l9yayYodPkMbq
         LAjj3l/OEMpUYMBQ64lgfKwOCVs7oXzg8cz2WZr6tSXrIHgAxC/8bXFbhbbc+YlCWQs3
         Y6XMlZgHdr9spbXc81CTW9gcg7Ujd77gSWhDaXAt0d1AhcpTQ4K7gdbpu1djdlMzWoFT
         /xwjZ3zfAL6KLsbMFtxy+s1rFLkpu5/MMCbMWdndiDOJ0DfuKYfkFW/xjkuTCmsApr/8
         2gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645792; x=1742250592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVCKVVXkluT/sD5JcZAkD4DoB+y+dtTT3SJUvxk8QfA=;
        b=uFDoG2m8B2MHheG6ZJhJvON6aprgMEOzRn7Y3l0ptdnXT5L/oNcBVotFO8/TYl7Szl
         3PxaOYayp2Hg/xm0XmtgUSw0gGtr2wYaehSDNppUTIhbwluuhIDe1R/Ax6smqIEhwcxZ
         BZc+oXpLkyKXuo5aPVTqTNRWLwwTMrAfFNj0ikoQnRdbx+tVZI1v1NjFob2hF50AwstY
         blsMSMrqJjX7gUeIdU6OJ5FN2XNAkh1Dgn0sqWhRFCTfoL3x3yyJgLEQHI+4yHU4Ko1r
         KNqiMxsFxV2yHUYXR+LSsA+nNPbB+2MNIKz2w+Zoq+b6b9UEnG24KbNCv4VP6Od9CiOz
         cX+g==
X-Gm-Message-State: AOJu0Yw/kgwX3OCk8btKESVXP2z1op2nYE+koByme6rLPptt7tehPEV8
	Kj0qP6qcCmRrPoMzsIibzpfoe2tRv/Til6Q9skaA9wcJpX7HLwCoshfx9cKLFENfCrqM8ynJUGu
	baorll0GkFzmj79gsaqJv5TrPu7waomN4tqP5SYshbc+T18S/HujKzqivaiIPQydNI0jy6VfKSV
	JDuB+BR+ru3eXiTmsz+0XP8klc5DGGqJC4H5QrGAP+98BcVBskQ6ocyn24a6Z2
X-Google-Smtp-Source: AGHT+IErwZKMWcXlcDBPbOmTkTxlQqL7Li6tR8rQjLEAzGJVnzPjT3+n2cYiqVnL4XEpSZHvkglTqKeqQnP297PlqXI=
X-Received: from pgbdo7.prod.google.com ([2002:a05:6a02:e87:b0:af3:27c:5603])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a93:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-1f58cad4b2amr2359639637.6.1741645792028;
 Mon, 10 Mar 2025 15:29:52 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:29:43 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=samitolvanen@google.com;
 h=from:subject; bh=S6dZKRDvk4ycBh4lQTb/260u8CBi/1VAPZFB45kS0CI=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOnn06//e3Nm8RKf25ozkpa7lii+uqtbzHjVuTczcGrS8
 z7+57vXdZSyMIhxMMiKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJHFjE8M9yh9rzT9zHqoP1
 zYuqE4QVREuXr1m0/TLnzXtdBZPd+J8wMsz6oLa5I6iYTz+rJn7+EVexiREHGx+/3SZ87TGXqJ1 bIRMA
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250310222942.1988975-4-samitolvanen@google.com>
Subject: [PATCH bpf-next v8 0/2] Support kCFI + BPF on arm64
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Puranjay Mohan <puranjay12@gmail.com>, Maxwell Bland <mbland@motorola.com>, 
	Sami Tolvanen <samitolvanen@google.com>
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

v8:
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
 arch/x86/kernel/alternative.c   | 35 +++------------------------------
 include/linux/cfi_types.h       | 23 ++++++++++++++++++++++
 6 files changed, 96 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


