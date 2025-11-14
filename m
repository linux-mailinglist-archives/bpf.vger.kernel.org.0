Return-Path: <bpf+bounces-74486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1AC5C4D5
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD0EA36285A
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB31306495;
	Fri, 14 Nov 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+my3Y+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09F2FDC26
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112300; cv=none; b=izq7gPSgCfR5FRkNg/FYDxgfNjaqN/YMTpKCEjHZMnWHjodorFs7Mlucjt5uvgiFjYzXJADSNG5GXaXT3WHDqZTkElvL2ZBBkPGW0ZqjjNn2bulw8vlTOmT9BnVtMuLg4lE/PFI0YXEPF2j/AHHJDwzHN0l/OBED9JyWkEc2ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112300; c=relaxed/simple;
	bh=+9RQ5SYWcNd1cbzkAGMGzwz/84lSrZPPq5qPr6vkn4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC8HHvi5iXW6YXumZbJeQY7G3QeIPV7USMZODPT/xefhK8u4dnMXzf+Ma9TwJMhXKSBh4ordUbEeP7nxaqCvCTuG+kXZYwbWjHou5Y21UwCj7ZpMvfQxMTNE4bhR5Ozpn11XHSG3hWRSBVAfvIloEplHSZfOyWlKGK5+6b1oJSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+my3Y+n; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29555b384acso19248515ad.1
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112299; x=1763717099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9SsUCl/7bEhicMcDwyeLe+NHqi3g02wXIdTa14uJ8Y=;
        b=W+my3Y+n5olYkTaDnXUuhnD01ZXhZqudCA+hZ53hbOf70wgTGCCsJeDlT4oIBp8d8J
         VXRbthXIjxV7QTs5zkKdtQBSAChYZVM8mfNmV94DfqxgQvuBGKBeCuzkNA8JhwYRpQYj
         +LQ9LIybK6KkIG7EMmWgSyaqapjX+5RJPthRe+dzno9S8eUoyNKNbtp9LzbbWRD3K7lm
         v9Bwrm7F+SyrUv7/5J4gun8mRzRJ2AENicnTI9J7znmaMmhbm9tC/ulp39z21N5Xage7
         nRzZsw/xt3aUqRvoH077FiFNFqgeLStdcfuIkkAQ9zq4oBau8uA5XpgkdR6XOQRe3g3n
         hE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112299; x=1763717099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9SsUCl/7bEhicMcDwyeLe+NHqi3g02wXIdTa14uJ8Y=;
        b=B29KwBsMPMIYLGKXCJ6NdzR84qIg+rlb7j4WHK8LehRF5VTsuLuWn3vyHExsxo5hPn
         UVgiELgsGaIXV3Qgbv0IpSRzWIKzebGsXY8Of+AoP/PLI4mKF0qWQxg1IWHxUUEHNMQz
         TLjoEqAKPejhDRYzR3YHCx8iw76mUqo7YEjQmV6ub+aSlOn+5LLlf/P8BcOh/lkbl2vo
         2DIyb+pqayu7psb8dQ6Y1wkokAAWv6AZhgOfXWUdOLd58iRFX+UQYf8MexSFImgz6Qfe
         azydXuQwA8GRw7JdROlrBf4K6kvc03Bi5CM+snS5OcGQFhj/EI5D++lSR+w/zDwqkHEG
         Qw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi05uFsJcUrcC/h1tCSVcOAp7soxpLpeBpYSz5smPT/llUH9hqiZVKmb/zX7UwxHqLPPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmD1IFqC0BQbGVp4ezohn61dDfK+6QWo97ou/pPBp9kNncaeo/
	EY6JKOVTzjMAPrx2au2Jvr+dgt+nOvzQ6s62LLc5RabdkCmOZABHP2vR
X-Gm-Gg: ASbGncuFe39t8YPteEgRNlvKhRXUlzmQ79T+zz3GdP9C6ZTj843pZQ3zB7iYYHExoIf
	SR7BosLVsaqim/jKseItMAhwrjJde0/tQ7xgGZkQwk62/x8uOfWVwnwqasOhzY5NMu6tKObHFIv
	9+u3da4aX5WJRkSJXIUDeJG/g9p5FX5f1OmmxFcyoDy1tIhqBG5yzkr2uVboHCA1AubfJXT8Yk8
	KJAKzVGvAQMrkrjqYRHKG9ehYlzseCGu2vOVgR4jKMqx0X22KOc7J9qmCfTogg7L2XUzdVfU2yT
	Vr1fNlUSR+11FHQXUDg9HpG8JfOwCxe3uaqWxUFcRfjhk1trlWYU9kKjBWdy4c3GbevQYzobv4k
	06SPbdqGgCoX1SYaV3+WzAsiVr5AqRcRD3WjnGugvSGgfzSwZt8Wbr6O0FY0fRgldkRsUeguu1D
	PYY4ttKc962y4=
X-Google-Smtp-Source: AGHT+IGGH96fiP4Mtc9aNQbmVe0Ea4kytDhImVoRCMVSUzVPcH6o18mB6xdLlzUY/ylcw8DGmsc9sQ==
X-Received: by 2002:a17:903:1b08:b0:295:20c5:5453 with SMTP id d9443c01a7336-2986a73b26bmr26556915ad.29.1763112298644;
        Fri, 14 Nov 2025 01:24:58 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:24:58 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 0/7] bpf trampoline support "jmp" mode
Date: Fri, 14 Nov 2025 17:24:43 +0800
Message-ID: <20251114092450.172024-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

As we can see above, the RSB is totally balanced. After the modification,
the performance of fexit increases from 76M/s to 130M/s.

In this series, we introduce the FTRACE_OPS_FL_JMP for ftrace to make it
use the "jmp" instruction instead of "call".

And we introduce the bpf_arch_text_poke_type(), which is able to specify
both the current and new opcode.

Not sure if I should split the first 2 patches into a separate series and
send to the ftrace tree.

Link: https://lore.kernel.org/bpf/CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com/[1]
Menglong Dong (7):
  ftrace: introduce FTRACE_OPS_FL_JMP
  x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
  bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
  bpf,x86: adjust the "jmp" mode for bpf trampoline
  bpf: introduce bpf_arch_text_poke_type
  bpf,x86: implement bpf_arch_text_poke_type for x86_64
  bpf: implement "jmp" mode for trampoline

 arch/riscv/net/bpf_jit_comp64.c |  2 +-
 arch/x86/Kconfig                |  1 +
 arch/x86/kernel/ftrace.c        |  7 ++++-
 arch/x86/kernel/ftrace_64.S     | 12 +++++++-
 arch/x86/net/bpf_jit_comp.c     | 45 ++++++++++++++++++++--------
 include/linux/bpf.h             | 22 ++++++++++++++
 include/linux/ftrace.h          | 48 +++++++++++++++++++++++++++++
 kernel/bpf/core.c               | 10 +++++++
 kernel/bpf/trampoline.c         | 53 +++++++++++++++++++++++++++------
 kernel/trace/Kconfig            | 12 ++++++++
 kernel/trace/ftrace.c           |  9 +++++-
 11 files changed, 195 insertions(+), 26 deletions(-)

-- 
2.51.2


