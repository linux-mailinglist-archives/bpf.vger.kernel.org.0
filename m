Return-Path: <bpf+bounces-79018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A4D24230
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47D53300F9CA
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B4376BDC;
	Thu, 15 Jan 2026 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIRQuZWD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D185374162
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476185; cv=none; b=g9Oe81cm7xtZoRV7Jwtf3MJZtvoB9UsLeuORp4bSC0D7rH2pHZvji3ciRANbCZqKw4N+z46/6q3D9yjGlxetfED1k3TaAWeu23AyOhe7ah/NrusHemgRFBiRBFf5u757OFQdNLd5CJph4Ff0bXvPI0YywXgNrNbMeK1Du1DC5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476185; c=relaxed/simple;
	bh=FIwHESQVYuuZxc5uoVG/+Wr/XmXfglSjp8N8KZh0HG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+CWdbwMs+RPLOF1dco5g03BPQcm2Gbu6uj4+Z0T1XnocGMPXYGdRbSAiYB4JcnI/Eu46H+lPwWVXVsQklvOgbRm9p38MY/fkA3ocfFmp443qfgY1C3s7M9nLQZug8oD1mKeFBbsp2mPHQy1FGBOnqXmLyLPGFA+aBkBePnbdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIRQuZWD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0c09bb78cso5219785ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476183; x=1769080983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vt3QKUVCCxglq0avEJJmb3HplxqAgTVpWZ+HnoWeEpI=;
        b=AIRQuZWDOAr/xMbRd4J5uNHasYRWWCx4+9yRe+fU0zwHiPidvmnfkumAnmvO6+Axn4
         uLnY1wgLQyZDyRTTiTRzqKbgDEGTl2NE2jFj/ZqDOm9z4lIv3BjJieZFP7aqIKp4mdMj
         hYPmy64EAU3IM+Ez/yL+iDFvjl2pTc4az4Eaeokd/hMimCC8JT5yrINWEREsbvS3o41l
         vkcM1abEbjHajxxjahnWbbLUzR/wsqfwvT75qmIHNxE0d7Zx72FLCwLZ7rfHcyFXwihp
         +0Uuk+q56Gx3hCoNqe0qhND2wyXbM/9Mp9BG/3xIu+E6rQspjq27LnJg9MvBiBRgnOdV
         3VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476183; x=1769080983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt3QKUVCCxglq0avEJJmb3HplxqAgTVpWZ+HnoWeEpI=;
        b=MmNgq4lY1Af5f1zM1sVB9jNAjvbVUbFSItE7BCLKiGNm3BDy+iHrm+iufi4itk7F/Q
         K7PeeK2+nk2ym2PHPvquJWwMVniG1Oy+ILBoctds0OxiajAei9geXY4JnsX/2GCq84dO
         JCGQKOuQqN418HBbfbvXVJ5+ZX4R9zmjEu9x1J2jhUJohTSPPckzjVgK2RyblLLPylb9
         2SD6EsHJ6HtCOn+piuJ5cG5RXINzu+Wxth6l9YGuUokL2sfhVEqGh7XWvVBohPZ3QUvv
         iBXPNz0NJuU57d+3SNMMdGPm4gyZ9oHwDI982o9EEGdZm+tPcINKKnhI7kJQGXzjvAEQ
         IcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYXyWyCfNHMvjjXkA1OIxZwecqF0aR11blwS0uS6bP4atx33ZgwwMgJJ6Yo93HmBv7CNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5GaYkEWJmbi9q+Nr9xuteY+//qPteXGYWl5yJJQGsti/vOWW
	amKpIlvbu1rC4QYeIHX5TNXD1EmXhcjNQ9OylPCWTnCyXD/CTqqIUPuq
X-Gm-Gg: AY/fxX6/3Az3B5BOkGKPFqz+TzV9UjR4RmPMzA5vp/nBucf1R6BDdDxvgVrTQNSqfse
	plQPwHZuxI3LGzLoWc8cQvqO+cJwoDosGKD7UPIivXRTOJ/Nk3KI8fzHg52kxy6nkJ+sseDHQg2
	XYju9fu0rt5u79QC/j2DPyzU0GC67Mv7nuM0nF5mrTNIzGzHkBy3EBXWnNZK2r9LrIvyyZ5qCp5
	DFgdQnzdwMKznKxWvBeEuSt+kCJPZ4CDxkCfQFSMrhOp9fovo78hbZF3jMweONcpqJyDSj64l5q
	7hwarU0uqx5J0OHDaScRGFYRZfImA+xucU46Ud6i566FogGLGhCmqNBCaFST+Q8cYaBmexDzc0A
	qO5nx0s3faHqRZCgpWjHv0go22EMujxNfHaNlxF7WisHxdOHiTeQh1wLkxUvkOvzU7CbFsUgGn9
	AnD2bZUgY=
X-Received: by 2002:a17:902:dac5:b0:2a0:9047:a738 with SMTP id d9443c01a7336-2a700a1c294mr23718005ad.19.1768476182752;
        Thu, 15 Jan 2026 03:23:02 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:02 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 00/12] bpf: fsession support
Date: Thu, 15 Jan 2026 19:22:34 +0800
Message-ID: <20260115112246.221082-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I followed Andrii's suggestions in v9, and did many
adjustment.

overall
-------
Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

Session cookie is also supported with the kfunc bpf_session_cookie().
In order to limit the stack usage, we limit the maximum number of cookies
to 4.

kfunc design
------------
In order to keep consistency with existing kfunc, we don't introduce new
kfunc for fsession. Instead, we reuse the existing kfunc
bpf_session_cookie() and bpf_session_is_return().

The prototype of bpf_session_cookie() and bpf_session_is_return() don't
satisfy our needs, so we change their prototype by adding the argument
"void *ctx" to them.

We inline bpf_session_cookie() and bpf_session_is_return() for fsession
in the verifier directly. Therefore, we don't need to introduce new
functions for them.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

Changes v9 -> v10:
* 1st patch: some small adjustment, such as use switch in
  bpf_prog_has_trampoline()
* 2nd patch: some adjustment to the commit log and comment
* 3rd patch:
  - drop the declaration of bpf_session_is_return() and
    bpf_session_cookie()
  - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
    kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
* 4th patch:
  - some adjustment to the comment and commit log
  - rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_
  - remove the definition of BPF_TRAMP_M_NR_ARGS
  - check the program type in bpf_session_filter()
* 5th patch: some adjustment to the commit log
* 6th patch:
  - add the "reg" to the function arguments of emit_store_stack_imm64()
  - use the positive offset in emit_store_stack_imm64()
* 7th patch:
  - use "|" for func_meta instead of "+"
  - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
    computing it with "stack_size + 8"
  - pass the "cookie_off" to invoke_bpf() instead of computing the current
    cookie index with "func_meta"
* 8th patch:
  - split the modification to bpftool to a separate patch
* v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@chinatelecom.cn/

Changes v8 -> v9:
* remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
  in the 4th and 5th patch
* rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
* v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinatelecom.cn/

Changes v7 -> v8:
* use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patch
* v7: https://lore.kernel.org/bpf/20260107064352.291069-1-dongml2@chinatelecom.cn/

Changes v6 -> v7:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.
* v6: https://lore.kernel.org/bpf/20260104122814.183732-1-dongml2@chinatelecom.cn/

Changes v5 -> v6:
* No changes in this version, just a rebase to deal with conflicts.
* v5: https://lore.kernel.org/bpf/20251224130735.201422-1-dongml2@chinatelecom.cn/

Changes v4 -> v5:
* use fsession terminology consistently in all patches
* 1st patch:
  - use more explicit way in __bpf_trampoline_link_prog()
* 4th patch:
  - remove "cookie_cnt" in struct bpf_trampoline
* 6th patch:
  - rename nr_regs to func_md
  - define cookie_off in a new line
* 7th patch:
  - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
    BPF_RAW_TRACEPOINT_OPEN
* v4: https://lore.kernel.org/bpf/20251217095445.218428-1-dongml2@chinatelecom.cn/

Changes v3 -> v4:
* instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
* introduce the 2nd patch to reuse the nr_args field in the stack to
  store all the information we need(except the session cookies).
* limit the maximum number of cookies to 4.
* remove the logic to skip fexit if the fentry return non-zero.
* v3: https://lore.kernel.org/bpf/20251026030143.23807-1-dongml2@chinatelecom.cn/

Changes v2 -> v3:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.
* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c
* v2: https://lore.kernel.org/bpf/20251022080159.553805-1-dongml2@chinatelecom.cn/

Changes v1 -> v2:
* session cookie support.
  In this version, session cookie is implemented, and the kfunc
  bpf_fsession_cookie() is added.
* restructure the layout of the stack.
  In this version, the session stuff that stored in the stack is changed,
  and we locate them after the return value to not break
  bpf_get_func_ip().
* testcase enhancement.
  Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
  the testcase for get_func_ip and session cookie is added too.
* v1: https://lore.kernel.org/bpf/20251018142124.783206-1-dongml2@chinatelecom.cn/

Menglong Dong (12):
  bpf: add fsession support
  bpf: use the least significant byte for the nr_args in trampoline
  bpf: change prototype of bpf_session_{cookie,is_return}
  bpf: support fsession for bpf_session_is_return
  bpf: support fsession for bpf_session_cookie
  bpf,x86: introduce emit_store_stack_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  bpftool: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  71 +++++--
 include/linux/bpf.h                           |  36 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 +++++-
 kernel/bpf/verifier.c                         |  86 +++++++--
 kernel/trace/bpf_trace.c                      |  49 +++--
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   3 -
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 179 ++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  15 +-
 .../bpf/progs/uprobe_multi_session.c          |   7 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  15 +-
 .../progs/uprobe_multi_session_recursive.c    |  11 +-
 22 files changed, 550 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


