Return-Path: <bpf+bounces-78176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94973D00A65
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D693015011
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0026E16C;
	Thu,  8 Jan 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvUfN5aa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84F239E80
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839109; cv=none; b=N1h+ilpIwLIvRn3dPwPSGpgNKV8PGLk5MsNzEzrzva+J94Yd+7hk9MQPtEBOc62BRECjuY1AtGCN3zuIZj/HMS/JyPVmi7KLdDabDn40xXhtM5NP3PWbRaMqR6KnCb3gYPsSn8fYkFehZwlLb+YqoQ1sXrtEj4pUTMtBO8z45z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839109; c=relaxed/simple;
	bh=xfdNQ2XA68GlBRZpCq8tdYnWYNvGWUgpb8PtyiF52zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFqYoeFsGV5OcMbnCxbLM37ix2X1GJOJvUblp2AGDn+9gpqZUpzlkTCYUpcroG30V6i5VEi7GK/gFQgAGSeUfTDXQgV/8h04VTnFrwF7pshv0Y2j74B6jToMNMf2asyZDQXnhUlF8rK/zFfPhuoSy8KcaAuRFqMXbsjlzMRAH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvUfN5aa; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78fd6189c88so34365597b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839106; x=1768443906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDmPh0kcLh99Yodm8W+qP3GmDAc+OuMsfP+N1S3aEqA=;
        b=OvUfN5aawwd3/fa0hXW9mr5jw/ym9eXKNdl1usGqEwgDLngAt0E0MsJpfxcm2+pWx6
         0z9RyBRyipsiiyKtc95kmu+mAKJikh5I6cta2qNSCLOCc3MiAI6mdRSM5jbNMl6ERJ5K
         nVdAsxnc+OROnuZBy15DlcwcN6ATYN2X4v15KvZ37KrwAtfA+UUCAVtEsBtyA1c/gU/+
         vVsk+pXk0Est1KNCvOY8APJ4tRxgn+gpMc3+uda27zhDmRVFsp4G/5qj3I45Zi+7oLsP
         b/oDPwPRByDlIZnU2cet9ubeZmS6sFwVr9ejfFd+4/OW40AThOE9gl6yC57J18Cyt10H
         +Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839106; x=1768443906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDmPh0kcLh99Yodm8W+qP3GmDAc+OuMsfP+N1S3aEqA=;
        b=Hcb0wlploG7+HrlcBm0vEuORsc9U+d8si0gMO/vdMZNI1kyyvDiOSW1MUtIEgEOAq3
         Xh6mGchqkn9z4ElI3TCc6yq+bd5Gg2cw9abg2UsjfwlYOdmbanYsi65GxZ8rRPMLb934
         0NYLPlAnEf1buMGyvxTDTSokRyq3EiUBT0ELhdpANITmmR8p6dn8UXtMzU9gMLKwnwi5
         3rvrkEJSpBhXEIG0fizFdr5MAwNNNZvfKfD8CtA2Jajs7e4emx9pvBxlC2/72ldo9AVP
         zPQ3oJuaNJZDhkLh9gedF3fS6cUyMi/ustzr0T+sFpF+dMWpbB0mC/dzRh84T/L1WpoU
         0hdg==
X-Forwarded-Encrypted: i=1; AJvYcCUmuIq+BKVZNoarKQmiC9Hn0StkdVDNkhcwVzLFPb/LecS4ll8532R14x1kkShFxhwBDkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtB0WiowtDXmPGcinTQy617Prho9vRsHycnBnyzTlLVX8F0JRN
	YwXzvZxHtfM8lULeJBYUbZJf0iB+K8fOAFIqBfUWlgE82evZ8d/03/u9
X-Gm-Gg: AY/fxX7vPP/k5Q8U/XH4aFzbD4bkZKOEyg4lxmGscfjv5nKFHKKRc1Fr04PZP222iTN
	lSywisoPgJqL+Zf16urDNMSzZ98GA+cw8rNvsuONXZVNekiOHD4/4szG11Qby+SfHU9U99MxV0X
	l1qR578/Nhu+/HIjeFld9YDwyrWX8oTEQ/lNNz1KebBf9Z1Nb7oFS4AXhDBjaeZFp4auDJ95Jim
	4QYQSKAdPr+7JaMFRInLOlLULhjJ8rvPR3KCCrOTYYRR2PQ7mNTkkRrM2kfCMVCgsqR+gJ81F00
	USF5No3G/zDZiqEtUp5Mf3BCONsoRp+UnDboTSlI/NL9d8mRq04lGFtzLD6jUWtgAmx68qk4Qf+
	21zuz+V38UsHOWq3CF9glRVwozD/aaMJs1toreP25kNgSvVh920jn9IhC1Y0Hpw0D8ME/WGXAJ4
	491yrE84c=
X-Google-Smtp-Source: AGHT+IHo3jIMxjvEUUtYQi7Cc32nik6Lt6iHBlx54LQGsXeHWV7cN1w7JXfSzMvO65F2LWWOIaRXvQ==
X-Received: by 2002:a05:690e:128f:b0:644:6f03:b3be with SMTP id 956f58d0204a3-64716b36237mr3758858d50.1.1767839106253;
        Wed, 07 Jan 2026 18:25:06 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:05 -0800 (PST)
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
Subject: [PATCH bpf-next v8 00/11] bpf: fsession support
Date: Thu,  8 Jan 2026 10:24:39 +0800
Message-ID: <20260108022450.88086-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

In this version, I fixed the exception that didn't use the last byte of
nr_args for bpf_get_func_arg_cnt() in the 2nd patch.

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

We introduce the function bpf_fsession_is_return() and
bpf_fsession_cookie(), and change the calling to bpf_session_cookie() and
bpf_session_is_return() to them in verifier for fsession.

architecture
------------
The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
it is not supported yet by the arch. In this series, we only support
x86_64. And later, other arch will be implemented.

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
  bpf,x86: introduce emit_st_r0_imm64() for trampoline
  bpf,x86: add fsession support for x86_64
  libbpf: add fsession support
  selftests/bpf: add testcases for fsession
  selftests/bpf: add testcases for fsession cookie
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/x86/net/bpf_jit_comp.c                   |  48 ++++-
 include/linux/bpf.h                           |  40 ++++
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |  18 +-
 kernel/bpf/trampoline.c                       |  53 ++++-
 kernel/bpf/verifier.c                         |  79 +++++--
 kernel/trace/bpf_trace.c                      |  52 +++--
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
 22 files changed, 584 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


