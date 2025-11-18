Return-Path: <bpf+bounces-74953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54157C696AE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E90E84EF4A0
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F01337B8A;
	Tue, 18 Nov 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkZdLIJv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE330FC11
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469412; cv=none; b=EqxT11JgpVc1M7H67pd5a22X+ADRwUd/buCu4i5d2tmlEgw9kE6nwD3DK7kH62Z7y1Xk+vQ1aZlM2K03RPoKIL9Q+rbw7pi6TH3wpjKs6UCgxiUPT4GoZlL9yU1ztv2bxm9XAAoVqsJ2D9wX8Za6I6czI17fXsjEDnFqf9nV2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469412; c=relaxed/simple;
	bh=7giUa1zm7WNduNPmlFlBni+p5300Qo8/anEWmLfFLhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dcce0I7FCSYmvfSMtPi9IcEAoi7RlONzNC6cAIJ0rNgwoTy28ppyL74TRDZDuBFcr6m23HZxZmZB6VfG7XVepk7rQTJoEo8u6BJrm92GNpW4PU31WWyrNLI/Wl90jXPjJ3rzwN/xT7+vr7Jd8o++OTloweXCTECqGJjpLMqgqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkZdLIJv; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4749242b3a.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469410; x=1764074210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LM23e0L0ml5CO7atXlhcS6iRDTOr1crRAlI1mbA3v8=;
        b=nkZdLIJvl2p7lRrMnzEL4b9/hX3LQl4E7Iz/f/32n+m7z9BHIwDw/oB/cQWkTfojvP
         MJUVumpniNPqraMcoVD2/9hiOVJlFoZZIDf03mcq8hx7bjVXWWHjFTyLBTAazCF7tk3+
         a/d2D/JgQ4C2oE8KfGQFM3x1MSCUSMKnkRFTBGwWAL7fKSuo+VrVzr56FVKjnj/7RmNW
         Wdp5nREiFUqs4i5/3DovfClDdiVPV5z0piYVedy+Pd/EZ8AWmzpJ3cEjgfcn61yn4mmE
         /c9BkaI3UsrJoxHZ60/9JvrzOa8EFrO90apNfr4S83ZdjwU830/G1wqVD8Ufc2D+D6n1
         7JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469410; x=1764074210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LM23e0L0ml5CO7atXlhcS6iRDTOr1crRAlI1mbA3v8=;
        b=Bxt8kcEwT9yZN8SLfN4rJv/2i592PKdcEgvOxCQBRQ4U5r6YnkrnrNj2dGDhJS1XWY
         Y8C7FEyxAU9vNm8oEWumOaEIQZn3ywdPHbFI6hkQz+DLfneW8ho1zR6C34InUAdsyW+4
         4xtDpmjK+2jDKrVuKUvftCJDDq05DTssf55uezMJGs5fENe9PZNJEDfnaApTV6nWLzjC
         cwGF835HseUya3j1QgyolSJSNjf1vW4LVKnT9mbzQKUvaQM293TVysf/BpWwOhBlPFrg
         abn7qiHCyfhlUhg6zPbcL6gR9080vRPesemfaDDhEQUwxEKHtgjrWreUPCH3ZiQcq0Xh
         eisg==
X-Forwarded-Encrypted: i=1; AJvYcCVqWUWTx0ijF6Zh/LU0dwXi7UdqAs6CYNIIzi43IPybNXvgn7avPX+LSqGaqbti4688oPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UCcRvArD8c0VHbu3KBPm8JZ2ukiKP9WgprdFQOXRPYLaaaey
	gAx0nIPi16t89YlWqqJB1dwclHR4X36Z6yG7vZ42C5oomOZWbXxn/Eoq
X-Gm-Gg: ASbGncv5esZVZmgNDuolTZALArg8ef39Od6vIVR+JkBlAEB3izzMuzNQOiRMc5swaAI
	1vIi8bHJIubOf+ankNRBOVdLvWHlGzTPlItlNLG7V48MMPV/hamzCa44pP9h9aP0Zzkg9n6q4E8
	eqRRtUsksgORsOZ5eqS9zLy/9H0VVvp4vRxtlf3EfVMge/As3MFBaXdjnTwTZEt3CrfldGKTP54
	LYoHN8Wb1CSgJ1gYXRQCta9iH4+2DzVDAuwNgLxRteaeZcYBsWLncBi1hCrRyJWp7c9ijGBHPDi
	wBJynfcH/j8A5kmkmi0vQ4IvjsDr0t2Jlmeo8w8krQJ6+lAUImSMAVxmcLCbd+5lTHUt/flNOku
	Deb5drynU4f2O5RkX2js4glDiC6BVHv9d+/JK/V343nRUrjgZzn5ljEiU3zT2o1E8Wd2UNM5qbd
	IOczSX9Qu2bbwl6XIIPLenkQ==
X-Google-Smtp-Source: AGHT+IETM5S8hWOszOBnIm3XxEqQG5D1jgh7M8aLGbxLIl4ecWp5cqe9a7kHieHLebE41E16oQqGlw==
X-Received: by 2002:a05:6a00:18a2:b0:7aa:ac12:2c2e with SMTP id d2e1a72fcca58-7ba3c6658admr20491229b3a.25.1763469409695;
        Tue, 18 Nov 2025 04:36:49 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:36:49 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] bpf trampoline support "jmp" mode
Date: Tue, 18 Nov 2025 20:36:28 +0800
Message-ID: <20251118123639.688444-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, the bpf trampoline is called by the "call" instruction. However,
it break the RSB and introduce extra overhead in x86_64 arch.

For example, we hook the function "foo" with fexit, the call and return
logic will be like this:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, there are 3 call, but 2 return, which break the RSB
balance. We can pseudo a "return" here, but it's not the best choice,
as it will still cause once RSB miss:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return dummy -> return foo

The "return dummy" doesn't pair the "call trampoline", which can also
cause the RSB miss.

Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
Alexei in [1]. And the logic will become this:
  call foo -> jmp trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, the RSB is totally balanced after this series.

In this series, we introduce the FTRACE_OPS_FL_JMP for ftrace to make it
use the "jmp" instruction instead of "call".

And we also do some adjustment to bpf_arch_text_poke() to allow us specify
the old and new poke_type.

For the BPF_TRAMP_F_SHARE_IPMODIFY case, we will fallback to the "call"
mode, as it need to get the function address from the stack, which is not
supported in "jmp" mode.

Before this series, we have the following performance with the bpf
benchmark:

  $ cd tools/testing/selftests/bpf
  $ ./benchs/run_bench_trigger.sh
  usermode-count :  890.171 ± 1.522M/s
  kernel-count   :  409.184 ± 0.330M/s
  syscall-count  :   26.792 ± 0.010M/s
  fentry         :  171.242 ± 0.322M/s
  fexit          :   80.544 ± 0.045M/s
  fmodret        :   78.301 ± 0.065M/s
  rawtp          :  192.906 ± 0.900M/s
  tp             :   81.883 ± 0.209M/s
  kprobe         :   52.029 ± 0.113M/s
  kprobe-multi   :   62.237 ± 0.060M/s
  kprobe-multi-all:    4.761 ± 0.014M/s
  kretprobe      :   23.779 ± 0.046M/s
  kretprobe-multi:   29.134 ± 0.012M/s
  kretprobe-multi-all:    3.822 ± 0.003M/

And after this series, we have the following performance:

  usermode-count :  890.443 ± 0.307M/s
  kernel-count   :  416.139 ± 0.055M/s
  syscall-count  :   31.037 ± 0.813M/s
  fentry         :  169.549 ± 0.519M/s
  fexit          :  136.540 ± 0.518M/s
  fmodret        :  159.248 ± 0.188M/s
  rawtp          :  194.475 ± 0.144M/s
  tp             :   84.505 ± 0.041M/s
  kprobe         :   59.951 ± 0.071M/s
  kprobe-multi   :   63.153 ± 0.177M/s
  kprobe-multi-all:    4.699 ± 0.012M/s
  kretprobe      :   23.740 ± 0.015M/s
  kretprobe-multi:   29.301 ± 0.022M/s
  kretprobe-multi-all:    3.869 ± 0.005M/s

As we can see above, the performance of fexit increase from 80.544M/s to
136.540M/s, and the "fmodret" increase from 78.301M/s to 159.248M/s.

Link: https://lore.kernel.org/bpf/20251117034906.32036-1-dongml2@chinatelecom.cn/
Changes since v2:
* reject if the addr is already "jmp" in register_ftrace_direct() and
  __modify_ftrace_direct() in the 1st patch.
* fix compile error in powerpc in the 5th patch.
* changes in the 6th patch:
  - fix the compile error by wrapping the write to tr->fops->flags with
    CONFIG_DYNAMIC_FTRACE_WITH_JMP
  - reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
    bpf_trampoline_update()

Link: https://lore.kernel.org/bpf/20251114092450.172024-1-dongml2@chinatelecom.cn/
Changes since v1:
* change the bool parameter that we add to save_args() to "u32 flags"
* rename bpf_trampoline_need_jmp() to bpf_trampoline_use_jmp()
* add new function parameter to bpf_arch_text_poke instead of introduce
  bpf_arch_text_poke_type()
* rename bpf_text_poke to bpf_trampoline_update_fentry
* remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
  flags instead.

Link: https://lore.kernel.org/bpf/CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com/[1]
Menglong Dong (6):
  ftrace: introduce FTRACE_OPS_FL_JMP
  x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
  bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
  bpf,x86: adjust the "jmp" mode for bpf trampoline
  bpf: specify the old and new poke_type for bpf_arch_text_poke
  bpf: implement "jmp" mode for trampoline

 arch/arm64/net/bpf_jit_comp.c   | 14 +++---
 arch/loongarch/net/bpf_jit.c    |  9 ++--
 arch/powerpc/net/bpf_jit_comp.c | 10 +++--
 arch/riscv/net/bpf_jit_comp64.c | 11 +++--
 arch/s390/net/bpf_jit_comp.c    |  7 +--
 arch/x86/Kconfig                |  1 +
 arch/x86/kernel/ftrace.c        |  7 ++-
 arch/x86/kernel/ftrace_64.S     | 12 +++++-
 arch/x86/net/bpf_jit_comp.c     | 55 ++++++++++++++----------
 include/linux/bpf.h             | 18 +++++++-
 include/linux/ftrace.h          | 33 ++++++++++++++
 kernel/bpf/core.c               |  5 ++-
 kernel/bpf/trampoline.c         | 76 ++++++++++++++++++++++++++-------
 kernel/trace/Kconfig            | 12 ++++++
 kernel/trace/ftrace.c           | 14 +++++-
 15 files changed, 219 insertions(+), 65 deletions(-)

-- 
2.51.2


