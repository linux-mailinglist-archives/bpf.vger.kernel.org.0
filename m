Return-Path: <bpf+bounces-78060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABBCFC435
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C2263003489
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50465254B19;
	Wed,  7 Jan 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qy4B+2QW"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63D18C008
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769184; cv=none; b=JA+hUHiAqsc2PWIkT7Im7oefpYTyteLQsVE3qyVt6gOZ79eExB46P/BFAVBfNClP9vcl4UrAdvQQtBe319g33aLRUjZZIJ4+mbUPe5Pbdlzn4S1uapJlsdP3aFmuDeg35r4MdUzHybLGciBTELT3jGduwh8gZHXGTHvHdUlNXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769184; c=relaxed/simple;
	bh=haXUM8NiZ+OKjrpNIs/REj7ESu9ButIA4SUKcQMQlDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTqPTAW09dE7OxXJXu20NECpC2L+hSDkOlTFQiNx1azySBdrlBJuW7wwq93JUFoucavwq/BbL1L2SNNMAUNKQgH7BBhUAXMkPtC5ipwyl3LqFRIWLPhGUxCz96QcepoDJMvM4hABZAijq7vhmzxVjK/emRpUF/F3/VJ4mFIKqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qy4B+2QW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767769179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/UUn689YoV4jOLODHTjr2eRQnXX+WILjGReLI+8SkE=;
	b=qy4B+2QWFvLMG+PY8oDqF4linJkP+zxFmWwrTdI/9UVote+4XCqTVC7ogcZepF2ilYC2f2
	ZK1j6scDsoxx12vxwyuLQmiqgL1VZ36UpzyJ6t7s8kWZjVLvDSWczsSmWHkaMz2ubQ4h4y
	0fq2cs4nNVQvErd3P/Xh1ljlyW8ToXM=
From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org, andrii@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 00/11] bpf: fsession support
Date: Wed, 07 Jan 2026 14:59:23 +0800
Message-ID: <2815019.mvXUDI8C0e@7940hx>
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/7 14:43 Menglong Dong <menglong8.dong@gmail.com> write:
> Hi, all.
> 
> No changes in this version, just a rebase to deal with conflicts.

Ah, this message is not correct. Pls see the change log part for
the changes of this version, which is:

Changes since v6:
* change the prototype of bpf_session_cookie() and bpf_session_is_return(),
  and reuse them instead of introduce new kfunc for fsession.

> 
> overall
> -------
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program.
> 
> We allow the usage of bpf_get_func_ret() to get the return value in the
> fentry of the tracing session, as it will always get "0", which is safe
> enough and is OK.
> 
> Session cookie is also supported with the kfunc bpf_session_cookie().
> In order to limit the stack usage, we limit the maximum number of cookies
> to 4.
> 
> kfunc design
> ------------
> In order to keep consistency with existing kfunc, we don't introduce new
> kfunc for fsession. Instead, we reuse the existing kfunc
> bpf_session_cookie() and bpf_session_is_return().
> 
> The prototype of bpf_session_cookie() and bpf_session_is_return() don't
> satisfy our needs, so we change their prototype by adding the argument
> "void *ctx" to them.
> 
> We introduce the function bpf_fsession_is_return() and
> bpf_fsession_cookie(), and change the calling to bpf_session_cookie() and
> bpf_session_is_return() to them in verifier for fsession.
> 
> architecture
> ------------
> The fsession stuff is arch related, so the -EOPNOTSUPP will be returned if
> it is not supported yet by the arch. In this series, we only support
> x86_64. And later, other arch will be implemented.
> 
> Changes since v6:
> * change the prototype of bpf_session_cookie() and bpf_session_is_return(),
>   and reuse them instead of introduce new kfunc for fsession.
> 
> Changes since v5:
> * No changes in this version, just a rebase to deal with conflicts.
> 
> Changes since v4:
> * use fsession terminology consistently in all patches
> * 1st patch:
>   - use more explicit way in __bpf_trampoline_link_prog()
> * 4th patch:
>   - remove "cookie_cnt" in struct bpf_trampoline
> * 6th patch:
>   - rename nr_regs to func_md
>   - define cookie_off in a new line
> * 7th patch:
>   - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
>     BPF_RAW_TRACEPOINT_OPEN
> 
> Changes since v3:
> * instead of adding a new hlist to progs_hlist in trampoline, add the bpf
>   program to both the fentry hlist and the fexit hlist.
> * introduce the 2nd patch to reuse the nr_args field in the stack to
>   store all the information we need(except the session cookies).
> * limit the maximum number of cookies to 4.
> * remove the logic to skip fexit if the fentry return non-zero.
> 
> Changes since v2:
> * squeeze some patches:
>   - the 2 patches for the kfunc bpf_tracing_is_exit() and
>     bpf_fsession_cookie() are merged into the second patch.
>   - the testcases for fsession are also squeezed.
> 
> * fix the CI error by move the testcase for bpf_get_func_ip to
>   fsession_test.c
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
> Menglong Dong (11):
>   bpf: add fsession support
>   bpf: use last 8-bits for the nr_args in trampoline
>   bpf: change prototype of bpf_session_{cookie,is_return}
>   bpf: support fsession for bpf_session_is_return
>   bpf: support fsession for bpf_session_cookie
>   bpf,x86: introduce emit_st_r0_imm64() for trampoline
>   bpf,x86: add fsession support for x86_64
>   libbpf: add fsession support
>   selftests/bpf: add testcases for fsession
>   selftests/bpf: add testcases for fsession cookie
>   selftests/bpf: test fsession mixed with fentry and fexit
> 
>  arch/x86/net/bpf_jit_comp.c                   |  48 ++++-
>  include/linux/bpf.h                           |  40 ++++
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |  18 +-
>  kernel/bpf/trampoline.c                       |  53 ++++-
>  kernel/bpf/verifier.c                         |  79 +++++--
>  kernel/trace/bpf_trace.c                      |  50 +++--
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +-
>  .../selftests/bpf/prog_tests/fsession_test.c  | 115 ++++++++++
>  .../bpf/prog_tests/tracing_failure.c          |   2 +-
>  .../selftests/bpf/progs/fsession_test.c       | 198 ++++++++++++++++++
>  .../bpf/progs/kprobe_multi_session_cookie.c   |  12 +-
>  .../bpf/progs/uprobe_multi_session.c          |   4 +-
>  .../bpf/progs/uprobe_multi_session_cookie.c   |  12 +-
>  .../progs/uprobe_multi_session_recursive.c    |   8 +-
>  22 files changed, 583 insertions(+), 71 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> 
> -- 
> 2.52.0
> 
> 
> 





