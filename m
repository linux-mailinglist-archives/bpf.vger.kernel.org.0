Return-Path: <bpf+bounces-28248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D308B7438
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B831FB20DAE
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F39D17592;
	Tue, 30 Apr 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7fEDQ84"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83612BF32
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476515; cv=none; b=MhfvLncgs/gS5y8udP6cYe+aTNNksiYp/ugTJljJ2biKQ5Hw/0fowFO6XwUoV+IpRMBhWcVotvJ1FOvHZHRaM8wHQPg57c26DLlwEY1M7epWXrbfCKtWNOGjCJMP6lTYh1tL1sF/VuY8lMMI2SOAzT/nOEShMTJ3T1EHwIoe3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476515; c=relaxed/simple;
	bh=V/Mc0UulLs3qbNsCSxAoCa3QJCyZcvqWfCdcZsqrPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3eK2yDLRJeNK+j1XjgbvFp1D64/WJmWaTQI8ttPN4AjumoOAdp7a/RMJ7r9rkxqoLM063wRyGCwRNGmuiKWvdYvds9lJuGCsu1i1K3nnStL36mAnLiRgLuWnTADPP+CZk0b7iLS1WBC8ncCmVYSUOik1i5tkbWdyrAc/BvnESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7fEDQ84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A6AC4AF18;
	Tue, 30 Apr 2024 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476515;
	bh=V/Mc0UulLs3qbNsCSxAoCa3QJCyZcvqWfCdcZsqrPnA=;
	h=From:To:Cc:Subject:Date:From;
	b=Y7fEDQ843cJg1ExoAvX/lwMkBoz2vAo3SIhSD/+PJFZAHoed/4EioIZbmrWIgCyWr
	 FEKY0Ri0BWZtxrizMvS4ZVwDb4QMYgyzcIJtE4yPK9oHVDABC+Ls9YHWAbV9iY1VE9
	 jdw4zzKtpxU2lZqE9ScR0/lknkVfkJS8XqmzyizQq1I4CiXNvsMPhYXRSgB8OuOAQT
	 5ZqcgpNwdsmOQd64jvPPNqI12Agg5MGbcFF3CrwWQ7R162mUEWHNXYPuN3tPKLTicb
	 iLNaUt72AIt6vV1Qy0YWYxH259fnpZFUQubUQQGm6Pwye6aLramqSXh1P/RcBtyqkw
	 RPk0o+rCHKGcw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 0/7] bpf: Introduce kprobe_multi session attach
Date: Tue, 30 Apr 2024 13:28:23 +0200
Message-ID: <20240430112830.1184228-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
adding support to attach kprobe program through kprobe_multi link
in a session mode, which means:
  - program is attached to both function entry and return
  - entry program can decided if the return program gets executed
  - entry program can share u64 cookie value with return program

The initial RFC for this was posted in [0] and later discussed more
and which ended up with the session idea [1]

Having entry together with return probe for given function is common
use case for tetragon, bpftrace and most likely for others.

At the moment if we want both entry and return probe to execute bpf
program we need to create two (entry and return probe) links. The link
for return probe creates extra entry probe to setup the return probe.
The extra entry probe execution could be omitted if we had a way to
use just single link for both entry and exit probe.

In addition the possibility to control the return program execution
and sharing data within entry and return probe allows for other use
cases.

v2 changes:
  - renamed BPF_TRACE_KPROBE_MULTI_SESSION to BPF_TRACE_KPROBE_SESSION
    [Andrii]
  - use arrays for results in selftest [Andrii]
  - various small selftests and libbpf changes [Andrii]
  - moved the verifier cookie setup earlier in check_kfunc_call [Andrii]
  - added acks

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/session_data

thanks,
jirka


[0] https://lore.kernel.org/bpf/20240207153550.856536-1-jolsa@kernel.org/
[1] https://lore.kernel.org/bpf/20240228090242.4040210-1-jolsa@kernel.org/
---
Jiri Olsa (7):
      bpf: Add support for kprobe session attach
      bpf: Add support for kprobe session context
      bpf: Add support for kprobe session cookie
      libbpf: Add support for kprobe session attach
      libbpf: Add kprobe session attach type name to attach_type_name
      selftests/bpf: Add kprobe session test
      selftests/bpf: Add kprobe session cookie test

 include/uapi/linux/bpf.h                                        |   1 +
 kernel/bpf/btf.c                                                |   3 +++
 kernel/bpf/syscall.c                                            |   7 +++++-
 kernel/bpf/verifier.c                                           |   7 ++++++
 kernel/trace/bpf_trace.c                                        | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h                                  |   1 +
 tools/lib/bpf/bpf.c                                             |   1 +
 tools/lib/bpf/libbpf.c                                          |  40 +++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h                                          |   4 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h                        |   3 +++
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c      |  74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_session.c        |  78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c |  58 ++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 365 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c

