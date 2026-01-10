Return-Path: <bpf+bounces-78462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F05D0D6ED
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B8C3019BE9
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139A3469F3;
	Sat, 10 Jan 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQifLt9l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA00346797
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054294; cv=none; b=b7sSv7+u2KxZDKNDhk90Ob9dGHacWZpuf+Hoa2zJGe13qpR29Sfv9pJ1K5s3WyEXPM+D3Wgdsvp//avVYeGN+vglVIsYgFudmsvY9uft6Mcr1JKUeleza6la/mjYdVPiUyPwDNFAn1dyec1cSZjuxlSMPBL+m5d2GGfpsqWEvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054294; c=relaxed/simple;
	bh=HT3PZ6NWua8J19nOiijYCURqlz4st9dfdYPQbCS85ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqfNDa/WCcnTf43mJxfUkv0fnm4AgJCF2QeTnHDaSfdZJEESdipapKufuhpXa81uJ38EakVeAnzZ06u7V+RIye6jyxNHS4CvyPzoENhNSvryU+FVbRxj+HI1+VOtuOznfaZ+kmJJWqysPmJWbL7e/Szql9BVRPtH86ggfRYETnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQifLt9l; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3277552b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054291; x=1768659091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muLJ/bklG5ZA3Zs+JGbPBSIUe/zEHzZcoLpn4TOjRds=;
        b=eQifLt9lfF0k0TSq2gprUW/uuO7AT7Oqflm4ydHqBfBxSL+o5vwglVB5j9JzVhkS9a
         VRyeH7tXfkqsZLggNt1CoAiHD3YuSm0KrLglTUhZK5pQBuNRwwp/Dhiv5/aCl6JOBTJV
         Uv5Vstn1DJNpHRUdXBZy0zJJbb2aiIEjan2puPNZXi82DG5qL1mM9UNu+QLvCfSYuZPP
         zUp+Ifmt9Q0xGWARmxK+PeKOh0IWuqZQujahRqCUQG51NNZ1Qf4I0QyQlrpi5De8uwQ/
         LPOqiElnvuWMohQrk3gZWO1tDJfCvnB1CrAz1595T0gyBj0wgPoQ/fTVQrLdFVv9jIt6
         PCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054291; x=1768659091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muLJ/bklG5ZA3Zs+JGbPBSIUe/zEHzZcoLpn4TOjRds=;
        b=R5/6qR0W4Ras26Jy2GOaxwXgzOFppU2+mg6cADXoq22oOK5ph588GTmrl7JczwNUoG
         ktRHlgjyRPBe4F8PEQbUPXdBVK/u+N+l10b1WHBz2sOw3BnCjumaWLVLFWcOO0zA41xv
         JNNsSlSMp2u29HiXk+ukYgG8yfe6+0j2rqUxUDLmQSx1a6JgvDrrkhM2nEjhCswbDloP
         Y+MeZueSwFrDkGxIm36Ds4pSvWFTRYOQpe5TZCwAg7a8bGgSmByah1KDj/FVKIeKxGKJ
         pc6hfYLLqBhb6KS19cnQS9oJu34Ea3v3fw4VEkYsq0NyP8sL1UXThSf0mG7q6jciIjEd
         Vl/w==
X-Forwarded-Encrypted: i=1; AJvYcCV1SHlgMRipOvhc7vaqv888ryuYJH4/liTFIOQziKU6tidbnZSSWCnjIlkYUH393b9dun4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTogNRYHbFEo+NGZrKj7S64w++kL6a0PDhtS83JTWOE8+iLK53
	s5LUq+QF+CaUP118APiUe6OcghriHXpKYiCSVx20bjom1tydvFSS+D0F
X-Gm-Gg: AY/fxX68/v5wA7YxaeZ2tNZ6hcUxMn/5E97Xb6huuQTml3u02oS3WTRyGFPy88w90nm
	wyk8WSIrwZ87MpNWqtbjfEr2ims3IDuEx9+yWO6e1MIngqI4S/P1RJFGy68k3DAvgdKtAm2UGJH
	be8kJszbcdSeN866ScjVkVWaezvOdkUWFUrsBGvHeTZS39DIGniSQEDEWJDtJcgKagY9Y/+lT+X
	UG5tZ8FBQNxcebLWNjZ5aLtSJ1Qc1k8KmwSizhZg0F9OeRUnZAWvvQJloEV+s++nVdfnPezNqcF
	7OMUg2LBqhzfioZ5ORjVnBewHJFAtleUGPAKhIhYo7AaPDYaiL11tdeipT9Qp6FBig0i35xjXSk
	fhSWzWSeGCrGhbLH30xeZXZVwCcVHoISc87YwSCGrCMEVc9W/n7Yc0PLkLM1kHoUW2Lz4Zcy5YG
	LXP/UiEkk=
X-Google-Smtp-Source: AGHT+IE6x72OioB/0md71pHOAtWtLp2uMCfSTz2hSI9e2zLffQJ9PsiXDeMkdG5GDeWinXSwWalQkw==
X-Received: by 2002:a05:6a00:1c83:b0:81f:39ad:6c94 with SMTP id d2e1a72fcca58-81f39ad779amr1994651b3a.9.1768054291410;
        Sat, 10 Jan 2026 06:11:31 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:11:31 -0800 (PST)
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
Subject: [PATCH bpf-next v9 00/11] bpf: fsession support
Date: Sat, 10 Jan 2026 22:11:04 +0800
Message-ID: <20260110141115.537055-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I removed the definition of bpf_fsession_cookie and
bpf_fsession_is_return, as Alexei suggested.

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

Changes since v8:
* remove the definition of bpf_fsession_cookie and bpf_fsession_is_return
  in the 4th and 5th patch
* rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch

Changes since v7:
* use the last byte of nr_args for bpf_get_func_arg_cnt() in the 2nd patch

Changes since v6:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.

Changes since v5:
* No changes in this version, just a rebase to deal with conflicts.

Changes since v4:
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

Changes since v3:
* instead of adding a new hlist to progs_hlist in trampoline, add the bpf
  program to both the fentry hlist and the fexit hlist.
* introduce the 2nd patch to reuse the nr_args field in the stack to
  store all the information we need(except the session cookies).
* limit the maximum number of cookies to 4.
* remove the logic to skip fexit if the fentry return non-zero.

Changes since v2:
* squeeze some patches:
  - the 2 patches for the kfunc bpf_tracing_is_exit() and
    bpf_fsession_cookie() are merged into the second patch.
  - the testcases for fsession are also squeezed.

* fix the CI error by move the testcase for bpf_get_func_ip to
  fsession_test.c

Changes since v1:
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

Menglong Dong (11):
  bpf: add fsession support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: change prototype of bpf_session_{cookie,is_return}
  bpf: support fsession for bpf_session_is_return
  bpf: support fsession for bpf_session_cookie
  bpf,x86: introduce emit_store_stack_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  48 ++++-
 include/linux/bpf.h                           |  37 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 ++++-
 kernel/bpf/verifier.c                         |  82 ++++++--
 kernel/trace/bpf_trace.c                      |  38 ++--
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +-
 .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   |  12 +-
 .../bpf/progs/uprobe_multi_session.c          |   4 +-
 .../bpf/progs/uprobe_multi_session_cookie.c   |  12 +-
 .../progs/uprobe_multi_session_recursive.c    |   8 +-
 22 files changed, 570 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


