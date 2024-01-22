Return-Path: <bpf+bounces-19999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C77835DBC
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 10:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0818B288C0C
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B453984F;
	Mon, 22 Jan 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jFVeag6W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2739AC6
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914765; cv=none; b=Y30RVxGRjwMe+gESlbGEisHUHUbZwu+FzG9/qYqfvpBNvqMfpQYew/C3ibEjpUfi4kScJ0SOiyNWJ98q1qLWKH906pB7HAiH+gSrDlZ9dTbGmajUX0RuxS7VYfCmEYMkJISz+Pk7bnlqazhMWo+2hx1V7pys/OF07iEF5sYz/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914765; c=relaxed/simple;
	bh=+8NZkVAjHC96vpvuz759JVvziLYGwLvw1KXbIUU1Ifw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nk7/DP5xIxuw5jD5214cBmcUvVmqAUICYGKYHEcE98tiomCVYq57J7j576jlw1guqLBFPukwVqBcdklh4+3OloMjgXJEvScA+lZLR1kc2m8imfRxP/IkvhR8ZA5xd2f4sXkbU+u0KVQs1PnoqVZVusjdOu/7Eq95CDbgTf85slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jFVeag6W; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff84361ac3so48985337b3.1
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 01:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914763; x=1706519563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ea19sCEL6xgQZE8T1J3CxwQSa9lih2SSx5JLzIENUFI=;
        b=jFVeag6WsJchA4MzP1DBhVJiwzgomHr0Hp9HDFrkbCxBIVxhj3NAASBsuFZRLcaVAV
         F+mKiPtW2SeY1BQQqPIHzpJ0NpLW4tRnvXxbTj9s9d9yElL3BBY46tPeWNQz/RSK5+60
         GVbgfRTDKcLuZwAMbumtzXBnAw2p/ht2/nye2oxnh/uACLViOOXK/lviQzQSNaA23s7p
         CsfPnFB6f1ETLtBE7keIjrQFnEuAZd5BB24Kjit1tWGuXHqfhH/ecUYKUp7hRgqF0unn
         Klzi7qmizCFSIdWEIhAxza2OTLf5hItkuRrB/A7TY7/eSI7skbSR4FSZOujq0idjZikW
         YCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914763; x=1706519563;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ea19sCEL6xgQZE8T1J3CxwQSa9lih2SSx5JLzIENUFI=;
        b=Smf1v0GzOXiqwu679RAmDqTiYlfzUYhO2p3U9OwOStGXX0XzOijn9Fu5ZTJq7xy0m0
         jNRz9fs0bh7a84zf+UyQy6d8j9i6yqCHHrSk+0XHk82x6J3KqgXrOhJ20xVj16jjlAB7
         viDmFYNppzcV1s2EyOK36uzTico4BKO/HcSVJt9WbokQH9k1IC40toGF9Uz82kyv65/E
         IcN7Qp02DPKEqyVwXGraOKPc/3lLKXarmWh31gXMaLCyUANPE6KafkDaT3NfHFYQKA6o
         LAXH7htI2YSRt9BYqg17KvdQAYI/YEV9rbGzEBa2UnYuEjd4pwQlug45liZVXy3hTVM3
         G02g==
X-Gm-Message-State: AOJu0YzglikFwQUplevuRg2rbKsZZoLwvXC3ageK0XEOpQZNkYoPggS5
	NjseVS5n0fJAxJveAFzWJk8D4ov0mlwtWjjI0fgXDcNc6fijb9i+t67O+hTAEh2eD4C9Yg==
X-Google-Smtp-Source: AGHT+IHHVJRyNmbX+T5omGh+241N4QnApogLAF/dX0Xt/Hc3Ga51fWxEHjLNZeYMHvdJvCh7gpZ+lp/5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:d44d:0:b0:5f0:92a1:18b2 with SMTP id
 w74-20020a0dd44d000000b005f092a118b2mr2271140ywd.2.1705914763174; Mon, 22 Jan
 2024 01:12:43 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:52 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870; i=ardb@kernel.org;
 h=from:subject; bh=dFHNAEG19z4Lmd37LarwGh98lLslGrVHWSybun0HPdA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwZKzFvHyjLMzXTcxOf9ZUPMychWTzv+M+KSPnP131
 7yxvaXXUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACZyvYSR4eYL0zz7x87vfNaw
 f+w+cXLfliPyEWk/vFnt36oxnVW0N2VkeN4zN+K+/KQCFjtJ6zuLLede4GXmkap2UuxbIjO79n8 SGwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-7-ardb+git@google.com>
Subject: [RFC PATCH 0/5] x86: Build the core kernel using PIC codegen
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Originally, only arch/x86/kernel/head64.c had some code that required
special care because it executes very early from the 1:1 mapping of the
kernel rather than the ordinary kernel virtual mapping.

This is no longer the case, and there is a lot of SEV related code that
is reachable from the primary startup path, with no guarantees that the
toolchain will produce code that runs correctly. This is especially
problematic when it comes to things like string literals, which are
emitted by the compiler as data objects, and subsequently referenced via
an absolute address that is not mapped yet this early in the boot [0].

Kevin has been looking into failures resulting from the fact that Clang
behaves slightly differently from GCC in this regard, by selectively
applying PIC codegen to the objects in question. However, while this
fixes the observed issues, it does not offer any guarantees, given that
the set of reachable code from startup_64() does not appear to be
bounded when running on SEV hardware.

Instead of applying this change piecemeal to objects that happen to have
caused issues in the past, this series convert the core kernel to PIC
codegen entirely.

Note that this does not entirely solve the problem of the unbounded set
of reachable code from the early SEV entrypoint: there might be code
that attempts to access global objects via their kernel virtual address
(which is not mapped yet). But at least all implicit accesses will be
made via the same translation that the code is running from.
 
This does result in a slight increase in code size (see below) but it
also reduces the size of the KASLR relocation table (applied by the
decompressor) by roughly half.


Before

$ size -x vmlinux
   text	   data	    bss	    dec	    hex	filename
0x1b78ec1	0xdde145	0x381000	47022086	2cd8006	vmlinux

After

$ size -x vmlinux
   text	   data	    bss	    dec	    hex	filename
0x1b8371b	0xde0d1d	0x370000	47006776	2cd4438	vmlinux


[0] arch/x86/mm/mem_encrypt_identity.c has some nice examples of this,
    where RIP-relative references are emitted using inline asm.

[1] https://lkml.kernel.org/r/20240111223650.3502633-1-kevinloughlin%40google.com

Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev

Ard Biesheuvel (5):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references
  x86/head64: Replace pointer fixups with PIE codegen
  x86: Build the core kernel with position independent codegen

 arch/x86/Makefile                 |  18 ++-
 arch/x86/boot/compressed/Makefile |   2 +-
 arch/x86/entry/vdso/Makefile      |   2 +-
 arch/x86/include/asm/init.h       |   2 -
 arch/x86/include/asm/setup.h      |   2 +-
 arch/x86/kernel/head64.c          | 117 +++++++-------------
 arch/x86/realmode/rm/Makefile     |   1 +
 include/asm-generic/vmlinux.lds.h |  23 ++++
 kernel/bpf/btf.c                  |   4 +-
 kernel/kallsyms.c                 |   6 -
 kernel/kallsyms_internal.h        |  30 ++---
 kernel/ksysfs.c                   |   4 +-
 lib/buildid.c                     |   4 +-
 13 files changed, 104 insertions(+), 111 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog

