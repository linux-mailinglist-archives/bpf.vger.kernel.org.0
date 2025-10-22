Return-Path: <bpf+bounces-71695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35AFBFADA8
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294991A04C93
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF3308F1A;
	Wed, 22 Oct 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bCkXj4FC"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDA308F33
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121199; cv=none; b=VhhxqqNMda011jriW/F5RCFKPG0DgvEmeLAJ4KEVY3QXqhwQqVGX5gxyBUlBBCPVoXXsxFQSdIEHptAQ+Cu9xDVK7JNwUCDq0ELJ5+auO04cGtLuyDJpXaDzi76Z57TpeLvZBbuUWKi22Y2fYfiSoOg5k/vQB0HC/omcwiDFL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121199; c=relaxed/simple;
	bh=AeBSiBDgwpOGCGWPswfsYos7CpkvHnSPMpBTKMI3s6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNNiyyHHyWSEaMPioS+W6OcSS/9RUTT/QQZj1NR8+S55asfie1SLIM2SVIpScd1QRhvjuQ5voNof7XqihAvldj8Xo8Y55Zd7e9pEtfkk8dT66nPsDOZ3bAjEdCKS5EGjTus20Krszbz1gNm2fHrytxAozrD+aW9JW++CuMYJqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bCkXj4FC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761121185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpy//4A7k0mbi8peB9EHLJq9FXO+mcernBj+cHoysX4=;
	b=bCkXj4FCRTsFuSWTdzCO9l/y1V8g6EkIWkSW7RkPA5aA6w8xS6+THX9b97DHypTYKGsiHY
	Z9+CHBFANqs5y/DhbCsbNFTbTU+z0Py4KfK4kXnMUhemF8gDdSt0uCbVpLcgie8kinKCQk
	vtLfHpuOQuDgxCwfvELMNRwPsQ6jHGw=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, jolsa@kernel.org, Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
 jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 00/10] bpf: tracing session supporting
Date: Wed, 22 Oct 2025 16:19:27 +0800
Message-ID: <5931958.DvuYhMxLoT@7950hx>
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/22 16:01, Menglong Dong wrote:
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Meanwhile, it can also
> control the execution of the fexit with the return value of the fentry.
> Session cookie is also supported with the kfunc bpf_fsession_cookie().
> 
> The kfunc bpf_tracing_is_exit() and bpf_fsession_cookie() are both inlined
> in the verifier.

Hmm......the gmail broken after it sent the 7th patch. So I sent
the remained 3 patches again. However, they are not recognized
together as a series. So awkward :/

Should I resend it?

Thanks!
Menglong Dong

> 
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
> 
> The while fsession stuff is arch related, so the -EOPNOTSUPP will be
> returned if it is not supported yet by the arch. In this series, we only
> support x86_64. And later, other arch will be implemented.
> 
> Changes since v1:
> * session cookie support.
>   In this version, session cookie is implemented, and the kfunc
>   bpf_fsession_cookie() is added.
> 
> * restructure the layout of the stack.
>   In this version, the session stuff that stored in the stack is changed,
>   and we locate them after the return value to not break
>   bpf_get_func_ip().
> 
> * testcase enhancement.
>   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
>   the testcase for get_func_ip and session cookie is added too.
> 
> Menglong Dong (10):
>   bpf: add tracing session support
>   bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
>   bpf: add kfunc bpf_fsession_cookie for TRACING SESSION
>   bpf,x86: add ret_off to invoke_bpf()
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: test get_func_ip for fsession
>   selftests/bpf: add testcases for tracing session
>   selftests/bpf: add session cookie testcase for fsession
>   selftests/bpf: add testcase for mixing fsession, fentry and fexit
> 
>  arch/arm64/net/bpf_jit_comp.c                 |   3 +
>  arch/loongarch/net/bpf_jit.c                  |   3 +
>  arch/powerpc/net/bpf_jit_comp.c               |   3 +
>  arch/riscv/net/bpf_jit_comp64.c               |   3 +
>  arch/s390/net/bpf_jit_comp.c                  |   3 +
>  arch/x86/net/bpf_jit_comp.c                   | 214 ++++++++++++++++--
>  include/linux/bpf.h                           |   2 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |   2 +
>  kernel/bpf/trampoline.c                       |   5 +-
>  kernel/bpf/verifier.c                         |  45 +++-
>  kernel/trace/bpf_trace.c                      |  59 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  | 161 +++++++++++++
>  .../bpf/prog_tests/get_func_ip_test.c         |   2 +
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_cookie.c     |  49 ++++
>  .../selftests/bpf/progs/fsession_mixed.c      |  45 ++++
>  .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++
>  .../selftests/bpf/progs/get_func_ip_test.c    |  14 ++
>  26 files changed, 776 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_cookie.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_mixed.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> 
> 





