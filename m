Return-Path: <bpf+bounces-77407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346FCDC51A
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 984DB304A7CA
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E533891F;
	Wed, 24 Dec 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePLu+a0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967073370E3
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581676; cv=none; b=J9SVprXwMOphUhG4q+ZSznTO4j0pQufoAjEMATGFVz82W7AIqUeXb1fmPAM00MJ4STvNyAg9ZhqF7F26GgNKlyUG1DJvenfmJ11VPbG87K3lepD+SAWMzpBpr+aXbzYAY6uuHW2j/GmSJtfY1M70DTe1OYlyAc4dHSwxcvhV2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581676; c=relaxed/simple;
	bh=ijgRwIZ2WyS5O3fxKXnj2S+dvc+/SEjeaUYwefCiYS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU3jce8RN7yUDzN0L1feAQ93X6lqadjgJCGHA2/XH1qKK2MCVmn1dgpuCy8I9OMmojVg00IZfHnSxNPdwvLo4XHLmkhLtZv+w6SHAcktbW1mf3j/7cGTe0tl4sn5SwfZveSnYwYyA/dQJiok2699bvjxzsBhQgfQsdDUqLoHh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePLu+a0s; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so4695645b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581674; x=1767186474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CitBfUePYs5GCUDI2dLSn/KA/gCZ6X/S0VxjxwaQ4so=;
        b=ePLu+a0spyGFV+NqqmAuUs2jAFLjPmU0h4ASaKpNyx1mUVh3rX6s4kyzyIf8Rl00HK
         b9mEi2hGOw9UeJO00nsZUakKSDvzKirD9fHgOk8stWjRv+eZlaok3yieFHf5wav3CXCD
         Obylw3viEzvNi+QNc77lUA8HBLaIU68CDBGeDgwFd6bmsTqMObv7y6r9JBkSdnnUR1Sx
         n+xYWfYg0gZ5451gvcD39gQdPBucmIBtfQ71xK1ylxh2gU0okoEQ4eOGqi3CI2K6TbF1
         1TWNBHMjn3hYOWdacc1hLPZ776WfwiLudejxbfG+2pD+zIIrJnGxzU/X350s3n6tVY6X
         GCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581674; x=1767186474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CitBfUePYs5GCUDI2dLSn/KA/gCZ6X/S0VxjxwaQ4so=;
        b=pdigeYXmsH1g5GppILVTZ7ynjYGnTYdU32yQbC2oGBGoP8TZ+8ZXucLWSGdI/c5Faa
         7bWLOeosQ4Mt8pueYZMBOv060TdeKd3u+1ZY3e7mE5TqlbRO2L8eZJsbR2imihLPyDAI
         YwSSEORuZ6xisYGM96p/y19q1rfto8APlpM5MYUiDEs2MrONZH46FiwJzXCSiPWfyELZ
         lsWwIwSR7/DUapMThIN5WDsoSBejpJfJ2YgRbiOS1T3qpdux1ekMtdqwo78zrtGSxGtO
         XV30tFUCD9nC+FiRWpmNqHh9EW+1yl1RFbkgipBNfyTXPiSQ6kY2qh0VJIwuJWrx0RGU
         BjXA==
X-Forwarded-Encrypted: i=1; AJvYcCVYXmFz5z+W8a5Tpbm1+ZyPe9Pvu8DkQF2PKZNMywDBTLP+JeLtrrXUv09Zk1RNQammx+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzirBHDKFGXW1pSwTCA8Bgv5CFUWjrm6W3kXC97v5NaiWXn/8Kr
	P1lBA1flRFHUW6XqG/GPBIO/sppfeeSDy5Yyqtph9IEBGHgQsNE6gPX0
X-Gm-Gg: AY/fxX6aO1wrMKWYJSiu9bj5Waf+tnmJgLrP6S4qHnF30LVwJrjvGWWJpbhSvBtGlhl
	nQWz+R/aPuztllqEDfrp7yLoBwj8UwHNWmnAzJd/JZfgqfaQb/B7CGXVwxFhjrxNDyuUH785lKp
	nsXRq8ZVqRRvbDGc3xZ0pHtGJ2ltToi7DQBI72iCESInLkH7YWMyO0kjuRqp8V2Xspzmz0nigbK
	csHwwX+EsQWQT9vlasEoszGUaa0q1G3leHx/XyIxv7KIMfB+Ftq9kFC0oJK9Mf6T0gV75S6CmsZ
	OcANYjDXlIYEuhb0JyhThn/UD/oJnF86Fzpys+82Xm4azbFZWoIGRUAyFpnZabyeEeH2nUv0geF
	W6QMBPgHzeHrHnQ5svBWkmIPmMrPoCrc9L+ZV0MBDjr64kj8QBd2BOCtdH1HD0fJKvJSJH6G849
	MoiXJFQyo=
X-Google-Smtp-Source: AGHT+IH0TjP897Ge7QpOC3WEt49VubNg6uR3s1cx4POJalLNzTQKlMQxT9fotL1q6NcA610DGZPlmA==
X-Received: by 2002:a05:6a00:4105:b0:7f0:d758:3143 with SMTP id d2e1a72fcca58-7ff654b8108mr15239388b3a.20.1766581673851;
        Wed, 24 Dec 2025 05:07:53 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:07:53 -0800 (PST)
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
Subject: [PATCH bpf-next v5 00/10] bpf: fsession support
Date: Wed, 24 Dec 2025 21:07:25 +0800
Message-ID: <20251224130735.201422-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I did some modifications according to Andrii's
suggestion.

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

Session cookie is also supported with the kfunc bpf_fsession_cookie().
In order to limit the stack usage, we limit the maximum number of cookies
to 4.

kfunc design
------------
The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are
introduced, and they are both inlined in the verifier.

In current solution, we can't reuse the existing bpf_session_cookie() and
bpf_session_is_return(), as their prototype is different from
bpf_fsession_is_return() and bpf_fsession_cookie(). In
bpf_fsession_cookie(), we need the function argument "void *ctx" to get
the cookie. However, the prototype of bpf_session_cookie() is "void".

Maybe it's possible to reuse the existing bpf_session_cookie() and
bpf_session_is_return(). First, we move the nr_regs from stack to struct
bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the session
cookies as flexible array in bpf_tramp_run_ctx like this:
    struct bpf_tramp_run_ctx {
    	struct bpf_run_ctx run_ctx;
    	u64 bpf_cookie;
    	struct bpf_run_ctx *saved_run_ctx;
    	u64 func_meta; /* nr_args, cookie_index, etc */
    	u64 fsession_cookies[];
    };

The problem of this approach is that we can't inlined the bpf helper
anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
we can't use the "current" in BPF assembly.

So maybe it's better to use the new kfunc for now? And I'm analyzing that
if it is possible to inline "current" in verifier. Maybe we can convert to
the solution above if it success.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

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

Menglong Dong (10):
  bpf: add tracing session support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: add the kfunc bpf_fsession_is_return
  bpf: add the kfunc bpf_fsession_cookie
  bpf,x86: introduce emit_st_r0_imm64() for trampoline
  bpf,x86: add tracing session support for x86_64
  libbpf: add support for tracing session
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  47 ++++-
 include/linux/bpf.h                           |  38 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  54 ++++-
 kernel/bpf/verifier.c                         |  76 +++++--
 kernel/trace/bpf_trace.c                      |  56 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
 17 files changed, 573 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


