Return-Path: <bpf+bounces-74686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5AC62456
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 808BB358B78
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DADD2F12D6;
	Mon, 17 Nov 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4U3Kapu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B51459FA
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351358; cv=none; b=u74EG0JVck3GjB6EzDcGlwHlU6pjHiUkJjdq76LEVXEOYNXsXwDmAQFnBzCTpI9UBXjtfK98X4RYDHhnTI6+m5+pDtrcesCB3RiwciyF7JdhUOKV5mBwu2svDWyRZsnaL9XGUQboQNm1IGkoaBUHp0LrwDmIrC8UFojwQeQZYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351358; c=relaxed/simple;
	bh=wzkMdzWqe/QbEj0kbqF/efWik7kK8fowoX9Zn5zvBuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u59CbulQIEIrTTwZRGfDbyKo/pUVc341+mCuh8Xmfd2uS4u8S9TtMkRER/AMNP6G4EZAaDVT9suV77Nr3Kp3i/5UPOyWITJBk2VP37icWB+LxBAyzH3sIfddmYD2VUBwbE7TeP0qMs3bHHxAxKnJmVLSBFZA+zFMZHDlsxyNwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4U3Kapu; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-298144fb9bcso40296255ad.0
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351356; x=1763956156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrsl2QUnRA4eQIDTLbci7vBfGOL9k8Hb4CoDxty6TJM=;
        b=Y4U3Kapu1J1pbEO752kdf4o0+CHp1tZDe8VWyFyzyagDgU64f3rPqnUhAlMLwlmjqN
         6AR22K7GJjE7Xmdvni1BZMR3CWNkRAHhelH8PhzcipkvO/vhf+jtjDg62dyHu7BQQHeZ
         aGNUnWsPoqRxR8vKJPyotRMAfsg4/9/DHqykuZM33JRi3OV0HgxkAWacMWJ9eA3FQiJ4
         NoR3r9xp1CJWngK13iYJir2kSUvNBDoNA8VKxMLkoYGf1ahkK55Zq8nRRIEhkeHEZAf0
         6rLs7vlwUk/nMOFPsYwmdsXCk37PxL+LCG6K9YYxq9pxM2D3uRhb8FPUBv7KdRMCkPLx
         9hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351356; x=1763956156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrsl2QUnRA4eQIDTLbci7vBfGOL9k8Hb4CoDxty6TJM=;
        b=vx/sCLXd71mbniW9SKlf9wte38HDGYfdxwmUbbL8ouJ8kKwk/VsQjBFDloJLUc02DT
         y9PVqPFVkQMSKi6aNwm98AAx62blsFFvoESX5RR/v350Sh8IO8lwo6JX7mJUZT6Z3lfE
         DPIdQJdhOq6TSFIauL7Ljb1Qm5J1j0Nl5JSgU2V5iIXkNi8fpG8+0/i/t+OLe88DSMA/
         zcBWzBgL5YAuy/UeR0sq3dGQlrLrDFChBUVXJpWB2FgPUsksp3h/7mQFirv+q/MzGvNd
         bvg1SaPkQm7wrDbPgN7t/0CWZJseM8N+S4kbprz/G8t6d4W0z5DrCuGg5a1D2q2QVTGr
         ElJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXhnDyieNKQeJOSkqSdAFZPuLpGldejI9Aosgssf+C19P8A+N+ZXgV0FSNx5Obgr5R2PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Zta0UcKPprRxWKcNw4ivkNI/sqKIBS0JN9RMEFw+tI0jmzcY
	a+aBDR1nqGWd8jU+QIe3aiKSxFLYy+l+8Xx4tR5b77Sc4Ob+AY7FnoXF
X-Gm-Gg: ASbGncvzxJr0Hhzcy9qVmb2gONBM5PWWkEAqqv8DqNdPJVfa91dG2qVEUkjGRnalh3r
	DjLoDTqKYXU7SRzm/9BH2vy3Yzs1vELmu6UvMrWX3u5/cFvcihvblLSJ0KsuQgBj8K3E3V8fIVX
	x5+nY+g0ZUT3bKpHfYSZf2e7iWGe/4wYYP2P17jPaqG7PYesZUE2i3Tnm6MzMPARwOpODKty65D
	I8iabkKJZxk9ZCToeIaA2AIuAA9NwQBNoxHYCzHLHVOnSO4Rb4mY2aov8FNh54wnoJML1i7psUQ
	ZHg6VDjRcQZJIvKbVeBLi48cUUGrtgexTxylvFkv/gMsa+rEmHRqoSaAHUjkOFOt3oy/f7zckDM
	RMug16zos+EqC9/dPgHZqX4+WJrqX/uFm5A2sNxRpfP8YJreIYIbSR7d+XlGzBxKONpOoEDuho8
	dm
X-Google-Smtp-Source: AGHT+IGX0Dn3w/bAUsACERD5wUAbP/ts7Lqa9O9MQCz//whasbUhnsbyWxdbWNOR8RXsrhBQYoGmUg==
X-Received: by 2002:a17:902:f607:b0:295:9b9a:6a7f with SMTP id d9443c01a7336-2986a74b1eemr134289945ad.49.1763351355577;
        Sun, 16 Nov 2025 19:49:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:15 -0800 (PST)
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
Subject: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
Date: Mon, 17 Nov 2025 11:49:00 +0800
Message-ID: <20251117034906.32036-1-dongml2@chinatelecom.cn>
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

And we also do some adjustment to bpf_arch_text_poke() to allow us specify
the old and new poke_type.

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
 arch/powerpc/net/bpf_jit_comp.c |  8 ++--
 arch/riscv/net/bpf_jit_comp64.c | 11 +++--
 arch/s390/net/bpf_jit_comp.c    |  7 +--
 arch/x86/Kconfig                |  1 +
 arch/x86/kernel/ftrace.c        |  7 ++-
 arch/x86/kernel/ftrace_64.S     | 12 ++++-
 arch/x86/net/bpf_jit_comp.c     | 55 +++++++++++++----------
 include/linux/bpf.h             | 18 +++++++-
 include/linux/ftrace.h          | 33 ++++++++++++++
 kernel/bpf/core.c               |  5 ++-
 kernel/bpf/trampoline.c         | 78 +++++++++++++++++++++++++--------
 kernel/trace/Kconfig            | 12 +++++
 kernel/trace/ftrace.c           |  9 +++-
 15 files changed, 212 insertions(+), 67 deletions(-)

-- 
2.51.2


