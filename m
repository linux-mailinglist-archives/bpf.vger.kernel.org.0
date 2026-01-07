Return-Path: <bpf+bounces-78048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A82CFC348
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE38730519F7
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740A279334;
	Wed,  7 Jan 2026 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxP7X+W0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2026E6F4
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768252; cv=none; b=thG4xizfWEB1gb+P6fiC5p0zYOwkn6YrF3mxdAXNEpqAsFRhhidTAKGMx/covoyNpqS8kcvaEkmdVmKax88yd76XK9lz2CgugJh+Es08Hr/nLTnXl9QXFeWolBwhK3aBAzE6ud9B6XRjj9n2WFBRx5lp3PnHtEW3xLzgEfj7q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768252; c=relaxed/simple;
	bh=9gy/ixQGGTG3ec3T1KjcigVwdzyN8R0jhqw3GqeqAH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3QqkKVrvKL/hx5hGr2HsA11XIHUCCyd2u9fquw/3iLGca9TAGkby0wxqs7zE2zaMN+cti3kyAQYWgT4ONCLqMLSnKC7ggaPlpAueLNJZwkn4ZGs0EaBXIMZQ8XBRRXJ3/CDZVPjjz02NfgtmobdSelbu0HBr+nIcPnSvphoHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxP7X+W0; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79088484065so20395007b3.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768248; x=1768373048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4xKVDlMDT5KTbpiffDI1wT4+UFxNi3Yn19G0UDCh8M=;
        b=ZxP7X+W0CAZScy+gfmWTCJuI1mjzfGDNBiYBKMyZKV++7M50Hhkmz1jkGDVPp6gZR8
         eEusrV8AwuHYIyS9dGi0f54AihsmSan5Y+SzhhG7auIiAX+OcBVzNBG4toBtL0xmminZ
         8D32+I9nRtk01d/PlBX4BvUYXSEZKEq7JuYoXv1xKranZgoBdVGaeD6SY9sygYgOK153
         eXekTyRn+d+avbUWa4JDY38Lu6SQvNSRFfW6s/k6Wsxc1o1ym9WHH8N7dRQiL/Sd7Qcv
         PC1d1we9SMKscGnD5uRj83+QP4qpRDWm6gES6yMyXFgTH7oI7dNgquyWwc1F6LsN02Oc
         sAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768248; x=1768373048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4xKVDlMDT5KTbpiffDI1wT4+UFxNi3Yn19G0UDCh8M=;
        b=f5SEXFCqk8jCMNMHlzaZVNFFBBkfVffj0AlQUlk+q4/ocL3ZzaT1GT2Lv6ZmDyE/H4
         8sT3frpJ8T/kBTmCmYLecUWbNnIHdgF3btbnWNGkgkVOKOlOZDNTOtKLX1ST0FgUet22
         5aPka3rfXNkbGwFcPyRhrg8XYof4aYY7UK2nBHocbQGRNk+BHdjArBQMAWp6EoTnmC78
         MBaKDS6vQU3ReMXMp8Brci1zNr3Mlfatw6uYnvvZKxIh5r2UXloTQZN64wsw55yUM1We
         WJTR04XXruDduXbISjtzK/Rj/uuR/FQV21++ACGSk65c5oqf4Ozl+N+IE8ms286bnE5V
         bGxw==
X-Forwarded-Encrypted: i=1; AJvYcCWRj7WoV1Tcgl0O+okImV+weQHb1LZYcdF1gh3ZwfDOlOh3nB0qTpQXheGZ0w/oPwAS7L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlsoylLkS7tYHLZQ+dAUMpup0AKUADWlGPx+POYesprCCWORT
	mVGEeTAFiUAxkJLgbPlSUAg1F/Cb5E14p8LORFcPe7X9qE9UOTBXtHc1
X-Gm-Gg: AY/fxX5y8AOOVgTi7HcJhWYzk1X1dAdFezw9V26ZKaIdsSxBl83PT7ZwV0vsXoyoI6B
	bscC9sdAtnycFfHOK43wJ0UjZiaMF9J0D3Co+cgh2KoS/DnU/8b7JGqMwLC9sZxBIzV3U46hRfg
	D2G0yeciSMpmjiyiTMKoLUcmMLZRrn4csabxJVGH3bouLByB8JbTAPzDYuftWJVe98z2nscIeQ+
	Qvgvvwxk1de8+NybVtVwITx+iuaxAjLmAdI7QBTeX+cNh5Qe8M/HE7bp5uYd1ROTo+sKw41crDp
	+GyYYTUPyPcG76QpQM9998XrePCrEQnzupZyHNiGa+dHVWaWFw/QkqFHgXUW2fKHL/9QMjv4OUO
	VP4cPB9iyvPJtpUp9HILfk3H7zMKBPnLOAIIZuowtwEKSt4ExvBTmq0xv9kT53M/VX6PfvCNDhq
	aaspRS2os=
X-Google-Smtp-Source: AGHT+IGvmTFjLbD48Z9+kavs9ZjAbnZnjPvuXHejAJ9QhYT/i+BLOrNbo73UOWrqZujpn8h618cytA==
X-Received: by 2002:a05:690c:730a:b0:787:f043:1f10 with SMTP id 00721157ae682-790b584a5ffmr34795207b3.66.1767768248409;
        Tue, 06 Jan 2026 22:44:08 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:08 -0800 (PST)
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
Subject: [PATCH bpf-next v7 00/11] bpf: fsession support
Date: Wed,  7 Jan 2026 14:43:41 +0800
Message-ID: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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
 kernel/trace/bpf_trace.c                      |  50 +++--
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
 22 files changed, 583 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.52.0


