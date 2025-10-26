Return-Path: <bpf+bounces-72204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B0C0A1ED
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8913A678D
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4F1EF36E;
	Sun, 26 Oct 2025 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9hchCjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4661FECAB
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447714; cv=none; b=r//ZQbPE8MqzUCxSbKxGFRaVBe3PcSR2FGU+zu8MtbLIhqjpgJKuivY2brp7GCzK2fj5Zen6r1nryg1RAAK3nWz3gzXPC8ahrQWOYFAxEyn/2+pY1DMRxskJcsOPR/mNdwlz4DFaaSuiFFWoyTyI4LiiUmSQGXEfaHXWE56A0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447714; c=relaxed/simple;
	bh=iaHwTrGVnGciWMjn8Nzd0xPOsyU6baCadBkXvKT19gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFSlPAPwgDMslJQkKj/aHn9XjUV0LswwAjKcSo6G6EQ2SyTu+MrpcpfgSuM90fPNp+kT50zYBYEA5wJrI8VwYtd/t7NL2yPR8nwIXhhe1ZEf07C2ijZ92JqFaolU59wzXnK8+XN2QrxetI7EEvanGjcELpCQ5uUAgbKRp/Kao78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9hchCjd; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-290ab379d48so31999115ad.2
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447712; x=1762052512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXYl16vyCySzBmLxYb9g7KSK62mtaFrc8XpoELCZfXk=;
        b=V9hchCjdSXZroxO9QQm0ge8ByGM2dQfmTRtwS8O3HnBMlq9a4JFulmj1FE8iGwc+9+
         /d+FtdzsEybf03hpdE8hPpcfcqGfxB65fK1hsyFdBYuJG4b53pnWsO/byu+Bs2oKQ7A7
         ybBEJ9p59CcfeNQdBW5axrOw/Qsw3c/PkzQ6Rzd9HMzhzzi5Pbt3lYTowA43735s8Rhp
         cYN/yTuuBlx7nj1y/jie6ScRErkuc98frXXAAfA12BjfnittRfmTz9YRXPnrtUv/LIHt
         w/tmjRTdloyFI26KcybjLLT+SGHaqxPB+FlcEUyJmwEY+6VXhPdwFU4AUZcPQ0ntj+st
         XlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447712; x=1762052512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXYl16vyCySzBmLxYb9g7KSK62mtaFrc8XpoELCZfXk=;
        b=OaG7vwklA5rne5fh1DgZGxtTKswkTzQFk+E7TUGpCwJ482Oaxxu31ohrFMl51LrbWS
         VWhUyhVTBUP5KaO9bu6hPH7nQ9l5EcFCpT8U2wjXWerwPJoOqrS8AsnDm3LFeoiwEhn/
         Ra5owWZsIn1YwAV3Fk39my+ioI6Sq5pcvqHrB8BA0Nb2iBblIMJvTHkFQ4zzVgFiLkPV
         qDvEK5bLZwDjDGN1kfVtkgvUVosmxJJbBRfbepHQ9MDKoaGm4KQBGDe4rOLaL9xX3kAb
         bmi9u/2XrhXizyiRfPDkCl0yhwRm5qUAo0G4OYxAw8hmyaqLp1xuxMcik6wQ+WX6/Ioz
         VKug==
X-Forwarded-Encrypted: i=1; AJvYcCXfZuKWOYGViH++U6/hoeNvCt65cAz+OX2S3GlX7pDd3qlE4rBKS6dwK8T00FFGxgkkXUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYO1zQzrqPmee+rbe8jL38FFFERryqbBAMSV/rEE7Xb1wKM0ND
	0JvOEedNOnDmOrcrWhf00ct06dwtzbjLwGFbcl2SLoxi0vbSFaUrrhkI
X-Gm-Gg: ASbGncsIdnKZI40Bol3aPTYHEnlcwLU3ynn+cevO3ZJYjaonowqJRFs+EhkKG2NkSPs
	ShBiaBOSJWc8lgiZ/OazDo5SF9Ne7ywn2EzU5EsEXCO8nCWHo/SMNR9WFGXPkCFl8gIoOeL0fFh
	fpwxjyuXPTmXqHfu+cGfGJrrwVl58cQ6pT3OAeTXG4F81wN3EyJnpSsiuwaKurmywttPney6Kae
	AQjBsy9S5eSgRjdoa93QXe2qw970y2Bqxz4QTYQsEdA4r7PhQBM34JX0EfVaGCBQQk7gdj7W1/X
	H/n94nq2kxIDdduB2qx9RT4I0nbdOQcBsoPSUpy0Gjrp98FMObKPPGw/P2Ju4SLXEFn/ejAvhvg
	U40lvdSjxPDmDMqrHGLi+A71bULA4Ly5PYWsvDqPEsKLf0ArYmJdB1pSw0y3zS/cLl3eo7zQJnt
	8rBVviiXWJd8re1kulThTZLg==
X-Google-Smtp-Source: AGHT+IFMC2yoTBCqvafrh22kIpK/2+2o4SnwzUWnGo0yvXCL9Nkdv+DMpuwly7n7AdRPexdpVAitYQ==
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id d9443c01a7336-290ca1219e1mr406570025ad.36.1761447712161;
        Sat, 25 Oct 2025 20:01:52 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:01:51 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/7] bpf: tracing session supporting
Date: Sun, 26 Oct 2025 11:01:36 +0800
Message-ID: <20251026030143.23807-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Meanwhile, it can also
control the execution of the fexit with the return value of the fentry.
Session cookie is also supported with the kfunc bpf_fsession_cookie().

The kfunc bpf_tracing_is_exit() and bpf_fsession_cookie() are both inlined
in the verifier.

We allow the usage of bpf_get_func_ret() to get the return value in the
fentry of the tracing session, as it will always get "0", which is safe
enough and is OK.

The while fsession stuff is arch related, so the -EOPNOTSUPP will be
returned if it is not supported yet by the arch. In this series, we only
support x86_64. And later, other arch will be implemented.

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

Menglong Dong (7):
  bpf: add tracing session support
  bpf: add two kfunc for TRACE_SESSION
  bpf,x86: add ret_off to invoke_bpf()
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: add testcases for tracing session
  selftests/bpf: test fsession mixed with fentry and fexit

 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/x86/net/bpf_jit_comp.c                   | 221 +++++++++++++--
 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |  45 ++-
 kernel/trace/bpf_trace.c                      |  59 +++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 +++++++
 .../bpf/prog_tests/tracing_failure.c          |   2 +-
 .../selftests/bpf/progs/fsession_test.c       | 264 ++++++++++++++++++
 22 files changed, 694 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.51.1


