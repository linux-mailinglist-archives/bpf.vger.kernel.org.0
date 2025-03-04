Return-Path: <bpf+bounces-53228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B058A4EDDF
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90DB171F5E
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033E2641DB;
	Tue,  4 Mar 2025 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BieWNGR+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06768201110
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117846; cv=none; b=Lblnj3y60h55/mywiwO/nTn8t3ra5mKswgzr6tq1BfOmHQWj/5Why0tDFozKp0HkOPZ3uE6QIaRCyXuuH66YhA/wbYysG3+uXJ+ZAKcEUkThi/85Rk3iGz7tBMTELRRCvMs9x0fF61cczDOuzPcIeiSCQJoo5y4EAU8EI9WiBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117846; c=relaxed/simple;
	bh=TVT1lqL8J7hZWfMtidtm7XGqghyJb7P/3F3W5nXdbZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPZDbEYS34OsLw67bdoCp7UI03xILQxktdyqpVc8fvKsea1SWoKWAvAqrURGZmLbsYbEDmtR6pBGF22P3j528R++pj41o6Etn8qgAVbgy218Mw9+8VOmX/EgRssuz5KpOHT189gWOqXPFXZp7oFbtjujJBjPWmemcGP5qVfKRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BieWNGR+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2233622fdffso114164995ad.2
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117844; x=1741722644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHj6TICblrY+e35v33qpCehvvzfHDtQ43Utfft6K4u4=;
        b=BieWNGR+uKgFLW6tIvjd1rh+1w+vd2PjjBGSzx6zLXdUkMsKGLMcbLJNFrz3sOKNls
         XeK92Mdg8Y/TS0u6GW9b2HhSOazghnHyuQa3AO9DRwHojK9pmT7NtLBAkgzfQlHbz88t
         NFGFI60LKNTi9f0OihlqEUdr2i3sI4o1s+lYzVzMQCQzZteYxDwFrxueZ6ZKa18sEEQD
         dZFShiwkR7YXb2GJpFrIgS6VFEDSTZhnYtI9MrYh0ejRwXzisR5HFtUWKbpN9Nqyb7lO
         /nIyeQhHHr5cIINjoF1pd/2D6FqhQWDVj4z73Iz3/FztcNPc+3BTnHl1YTTf/n9AldbO
         K6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117844; x=1741722644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHj6TICblrY+e35v33qpCehvvzfHDtQ43Utfft6K4u4=;
        b=lJcUSqx2OziyeKt98bsYqTJLOeMaThmWQq9idajsYUEctKkYJKFdMvNm2oyIErDACH
         kM7e0ZOTSGiD3WHPDta8PMHp1tPMjoUiU1k6b49+M9BbB7c6vrHIGLQMqNGxDDKYFdnm
         Rt8pufyVF9Ivp3czR4MPlpHjzz5lpIzqIXPfJz3Pj7/5hbvrQjLpIeI7EnIUtOLbfFld
         wO5vJNYOpWk5t9nPdRZ/tT3nsmeDmHx45xgh23pqnpkF8QGycJ5LZ8x7czYmOH95TnvP
         Sw/Bnaz4LhSSjR6LkFfz5P3Ul7SAZUCFXH5iMSlBKcdoicwJVmfTFro0EwcTpCfhNCCS
         c73A==
X-Gm-Message-State: AOJu0Yy0uASFERAY1JBmslMVO9HUbdWXUzEMFitmon5dpwsImr7a+i77
	WhL+98+puc3Wd0HNiBmOgPi7noqjZ8GJFzHa+6uAHEEr6tlKxOIX5STbng==
X-Gm-Gg: ASbGnct1lXxX/R2NriX070YDHw1MZ7BNBVH0XsAue91JCAO0HD+ov5RB6C/E4JrHqra
	tZ4bgNVZKvgwNWJgWi8x1SGXGm1SmMcRH2019CnNcdKAwSlYInlC7s+vPtAnDCIJpzeocj4XdoF
	oUHoMLoYHuUaMvnJ1FpjOiuzDyXl1T1e+doxEalha/UVYcBmZKiNzPfqJZjfiTo9KkEso+LmvWQ
	nsgj5pB6w4YueU0HJooWxOU/XGZhYkADDFCH0tTyLbf6dZoYTMJJMKOhmxWW+bUMUf5jTa3es5E
	b8O5mXeoVstldMtQf3qrECdAkn06fhvqZoXmiSkX
X-Google-Smtp-Source: AGHT+IFE18DZHI7bHQnROffqqwslczs2wdtDs53ljTL5hIVIdZMlYk1+3ZKHncLuoF/PjwnLLlJpOA==
X-Received: by 2002:a17:903:f83:b0:220:c86d:d7eb with SMTP id d9443c01a7336-223f1d26114mr6387315ad.36.1741117843920;
        Tue, 04 Mar 2025 11:50:43 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm98560925ad.126.2025.03.04.11.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:50:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/5] bpf: simple DFA-based live registers analysis
Date: Tue,  4 Mar 2025 11:50:19 -0800
Message-ID: <20250304195024.2478889-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set introduces a simple live registers DFA analysis.
Analysis is done as a separate step before main verification pass.
Results are stored in the env->insn_aux_data for each instruction.

The change helps with iterator/callback based loops handling,
as regular register liveness marks are not finalized while
loops are processed. See veristat results in patch #2.

Note: for regular subprogram calls analysis conservatively assumes
that r1-r5 are used, and r0 is used at each 'exit' instruction.
Experiments show that adding logic handling these cases precisely has
no impact on verification performance.

The patch set was tested by disabling the current register parentage
chain liveness computation, using DFA-based liveness for registers
while assuming all stack slots as live. See discussion in [1].

Changes v2 -> v3:
- added support for BPF_LOAD_ACQ, BPF_STORE_REL atomics (Alexei);
- correct use marks for r0 for BPF_CMPXCHG.

Changes v1 -> v2:
- added a refactoring commit extracting utility functions:
  jmp_offset(), verbose_insn() (Alexei);
- added a refactoring commit extracting utility function
  get_call_summary() in order to share helper/kfunc related code with
  mark_fastcall_pattern_for_call() (Alexei);
- comment in the compute_insn_live_regs() extended (Alexei).

Changes RFC -> v1:
- parameter count for helpers and kfuncs is taken into account;
- copy_verifier_state() bugfix had been merged as a separate
  patch-set and is no longer a part of this patch set.

RFC: https://lore.kernel.org/bpf/20250122120442.3536298-1-eddyz87@gmail.com/
v1:  https://lore.kernel.org/bpf/20250228060032.1425870-1-eddyz87@gmail.com/
v2:  https://lore.kernel.org/bpf/20250304074239.2328752-1-eddyz87@gmail.com/
[1]  https://lore.kernel.org/bpf/cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com/

Eduard Zingerman (5):
  bpf: jmp_offset() and verbose_insn() utility functions
  bpf: get_call_summary() utility function
  bpf: simple DFA-based live registers analysis
  bpf: use register liveness information for func_states_equal
  selftests/bpf: test cases for compute_live_registers()

 include/linux/bpf_verifier.h                  |   6 +
 kernel/bpf/verifier.c                         | 495 ++++++++++++++----
 .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
 .../bpf/prog_tests/compute_live_registers.c   |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  17 +
 .../bpf/progs/compute_live_registers.c        | 424 +++++++++++++++
 .../selftests/bpf/progs/verifier_gotol.c      |   6 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 .../bpf/progs/verifier_load_acquire.c         |   7 +-
 9 files changed, 875 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c

-- 
2.48.1


