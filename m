Return-Path: <bpf+bounces-36745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0294C7DE
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A555287187
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1E4C7D;
	Fri,  9 Aug 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbX9upcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863246B5
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165550; cv=none; b=SEunTjH5mE8fv2tOwY8x7nBgr2WQI43lDDWyINuOLOA39gMb34nfrF+QHE4B3sOATX+uYgEPJbirIdrlwTzyq5HRsywB2/VkaAZ7zvRx36n/9VsEp85OKOl5JBSUOWLCY2j9Ou/Ea7NpsNx3qFHcF8fMIiOtySICzWVwvRXrGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165550; c=relaxed/simple;
	bh=DUAMvdcdAivHNjwxDlD+85AB+rKWx1SDI3nXdFEUcAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBYGkejvuRGOFa6jO2F6QHviHDi8A867ebNXamTt/n58zruPJj5Ee/lWLisLJn0LGfx54nxYNhCeSygOD44p3dze1FlA4+IPlZNYKC2vlCerC0ApgUmdYt4X3EBGCI53M+b7Kcv7PNnEwOopyQ1BcAwRomPeka1j5br4f7TLmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbX9upcN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7107b16be12so1323155b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165548; x=1723770348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JmcB6Ms4nb1bjXXMYTv834l+uZ/Zhg6x3H4IMwTy64E=;
        b=HbX9upcNwsClaM0P5r1bnyxxZHlRY10S8gu8nz1R2NIWb64XSMVfnY1l33TRJfOgbM
         TbuAU68ieUQxvJ7oEs99AggkwnkS2ZI2gqtMo5LA1jmzY91ZOsxHrICXvEWY01GKam0C
         L8i1km7WOjeUML9gAiferKvqPEAac6/BBF7uM9Z04fAvHN6nLtJnk5HlYwtFqbetoTe3
         SIUtReHrlhX2HekLjWIm0tJjGxHjDXHSWyXsS+73oNTpvXgLXDJu1ION5WrmokT3GPw5
         Pw5W6ls59SOmjSjvrAW6FQ/xNvp0REC+rRWkHZFpYU7V9ieRPfnXKFVGwCOA063QF8Af
         y2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165548; x=1723770348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmcB6Ms4nb1bjXXMYTv834l+uZ/Zhg6x3H4IMwTy64E=;
        b=qhIOT3qUvr5EIyJo+ltrPRunreyCUOWG+lS9cOxOisMgCpSACReZRbZkDUffEge/rY
         G00hJocgCeLGP/KZGF9IQajjYFweCXu5KHhPctbZHSwGtV6GU2l+58tJ/IoMRvwBV0cY
         wObgxw/OGhqCa+Kz85UJ2ePCPly/Hz+I2RanWwQmkKBl6FmrlTU/VTs2jC7DtNr8+acO
         rKEbXUhxL+bI086pzS44WNfSlmMBYm2cVQGPxqntl2kaz1A28clTQ5PCimY6zH463Phy
         lgGSFeKnfgjHvdYoFkns4M0t7+cEw9XR0f57SxQMsH2HFo3nvQp1UIaVooA+3AdPYwdF
         JSxA==
X-Gm-Message-State: AOJu0YyPdHOhyVzp0tSO9wh214dtQg+L0SRMHfgkyhCmHA9LJ1tfYcFp
	XEzSPY2efCbmvqjUpuhwMnl+irXecZlPyAnbatIfnBUD75esUkND4F8Q6CfKVL8=
X-Google-Smtp-Source: AGHT+IHNM0Z/tEG4tDGVgYse6K/qPSZ93eKCi9+QNjlbBNBVEwc/8/0oqe9vuVgpObQPVAEFe2uGag==
X-Received: by 2002:a05:6a20:d494:b0:1c2:8eb7:19cd with SMTP id adf61e73a8af0-1c8a00e2ebemr114372637.42.1723165548305;
        Thu, 08 Aug 2024 18:05:48 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm1678626b3a.205.2024.08.08.18.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:05:47 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/4] __jited_x86 test tag to check x86 assembly after jit
Date: Thu,  8 Aug 2024 18:05:14 -0700
Message-ID: <20240809010518.1137758-1-eddyz87@gmail.com>
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

Eduard Zingerman (4):
  selftests/bpf: less spam in the log for message matching
  selftests/bpf: utility function to get program disassembly after jit
  selftests/bpf: __jited_x86 test tag to check x86 assembly after jit
  selftests/bpf: validate jit behaviour for tail calls

 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  51 +++-
 .../selftests/bpf/jit_disasm_helpers.c        | 228 ++++++++++++++++++
 .../selftests/bpf/jit_disasm_helpers.h        |  10 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   2 +
 .../bpf/progs/verifier_tailcall_jit.c         | 103 ++++++++
 tools/testing/selftests/bpf/test_loader.c     | 159 ++++++++----
 8 files changed, 507 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c

-- 
2.45.2


