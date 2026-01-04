Return-Path: <bpf+bounces-77768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC24CF0EAE
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61CBE302515D
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707692C235E;
	Sun,  4 Jan 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI+a281B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389682C1580
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529717; cv=none; b=pm4elNZkz1VSb+/KBePU/cx1VJs118CjYuN7Chtvgdvk8NNde3nAQhfA+yWl2WWkT67nk7fU3OhDoIVm+RC4Ak/3lyOq/WvNVuD2i2mTDKnWI80iUPO/uUsIVB5kRV+sdIS1HL9BvAMNXgsL9fqd7KPYK6PCzokBp6T48dI0An0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529717; c=relaxed/simple;
	bh=37NoOwmbEFbtysE2DlDpNUYsBOiTWnWUsCk/VqY80jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkiPLAOKqHpUAn95/keGXU/SOXBx6mAuok8ZE8qATMfTdYL+LQ4lYn5oez8caY00S7SmN+gjltmfLVNaLA0m5GqyYZmyUweGxs+0yauf1A2H1CcP8tRWxrDUgOJ+vkXoAtPJQpJEqWUQuuPs6OxqqxFfX+RNOJnklXI2kXv60Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI+a281B; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79018a412edso57307397b3.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529714; x=1768134514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2G7eadH5MMBxz7yZ0+iAQgcawTRkgGwCWOA1VR9NfFs=;
        b=AI+a281BWbTzdwHK/chIp2I6YIAdOzSlvMlJLXaq2YPGSPDRO9oviqzUpTgtXVqBHk
         AC5R4Oq5Kikj+ZpjGoHHoLd5J4GYHJIlk2LMW4DlWSU4e0FS0Q8eCbJISm4aahYEKGSW
         cCWi7krOxRGpQimMtpVv+dEwGOzFSclM1p3UpWDU9QBAe5uOZW7oFz8NCfp6fLe54VCa
         YTzZdI2kXBJC3Q/WEM4wQrf9OcEKIGWJl7VbyGJ9lyOgGmMLsg0+JEX4nGA2e2cwHD4k
         E5aIffzJjxnZ2fqOm+gYNHllYHyMq9frk0g1+jO+4TiWt61bHy5H3g+OPvEHwZ7gkCrh
         2KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529714; x=1768134514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G7eadH5MMBxz7yZ0+iAQgcawTRkgGwCWOA1VR9NfFs=;
        b=p6pwxO2AnTcizoi03l/63yDXKIiWP3HwmYz26X/ViPLEr9L99YJM1N/b46reIg9hk4
         WOV7Yct332rrjmUfpgqcgSek2Ql01w65Ou46QZ8AzxJXKB/ivga7ECVhIxVBrjOvuEy2
         tah/gFXRF42usrdjmBebvth+82a+tQd/lGkRtV+qb38eY/7oMvbDBjRygc974t6hVrg9
         o+mrIm+idQk16Ul8xwiEY2puns8q0fIg4/5T6uwqi+Wm1V/8bMUU2pgUqimNiFv/5zej
         JSi62uyyH/ZW3GCyhCnhQz4E0YqMCzW+lP1j/D1ONJB/lpsYcKDYt8aOwjabROjnzngF
         PyZg==
X-Forwarded-Encrypted: i=1; AJvYcCXSoK096ZyHgMeesIcnaJ3j40Lxk1MU2jWKiLETSQrj2XI1ogE1dQ23HcWbhYFqd5zrTPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KGLVsiMhf54r03379QfhZt/9Pi3y2Pd9vP2qGy0yGXOMoR5l
	OHNno1lTI1ckaSwJK/De4R2eCx6QNPP7l4QJ5mJ0d7JKkq6TvHSgQ47YaFpvuzP7seo=
X-Gm-Gg: AY/fxX5hGc1CCLdoE+D7chmNgb2VK7MqGqRwdVO5eScL2ar0+aqDQ2XgT6pS5ruiiSu
	GsSFIxOuGXNJIjQdTxm2EVRuab8hG33RGC9HAIW280U4UQI3fri2hOoannLisATPjry3eN2YwIF
	Upb4b1TCiLbEnouPlxyiNWwlcaPRW9U1SAkqdDvk30ya/pTqQO/1iahGfQ+fQgeWJhAhpFNTLoY
	+K7sI8thrqVumk5Od+O/iq7h9YX5WruU5j6jG+PEn1NtAyjc3wImtXq4AFUz2vDsSRgfNgl9DJW
	9uqxcaLJFZt7v+LHMneZBz4IHUtPK2XBAKOsQ2alFmmwiIDziIu6xSVLz1UEiV9JaaDtW5ShRYt
	qQ5RoJZ6QrcJyCtQji/zQVOp8kPDCWyeNRvFnGO/Oe98dE+/Zk38E5E+lqxRuzig188LMc7CWqk
	3mGYb3LmNC/96W9SFoGw==
X-Google-Smtp-Source: AGHT+IHS9a4jImQKSg/PReudg9XbT91OW2y1MNoQqzFfjATamNzIW8aA0ESgRzh5mH2OJJYRUevbPg==
X-Received: by 2002:a05:690e:144c:b0:646:82e4:8539 with SMTP id 956f58d0204a3-64682e486camr33149822d50.43.1767529714160;
        Sun, 04 Jan 2026 04:28:34 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:28:33 -0800 (PST)
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
Subject: [PATCH bpf-next v6 00/10] bpf: fsession support
Date: Sun,  4 Jan 2026 20:28:04 +0800
Message-ID: <20260104122814.183732-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

No changes in this version, just a rebase to deal with conflicts.

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

Menglong Dong (10):
  bpf: add fsession support
  bpf: use last 8-bits for the nr_args in trampoline
  bpf: add the kfunc bpf_fsession_is_return
  bpf: add the kfunc bpf_fsession_cookie
  bpf,x86: introduce emit_st_r0_imm64() for trampoline
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
 17 files changed, 572 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


