Return-Path: <bpf+bounces-77090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBECCE210
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9800D306A520
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB576221542;
	Fri, 19 Dec 2025 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AxLCqC6e"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02322A4E1
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107113; cv=none; b=ffYDjxGsIYn8MzVkuz0D2KPq72cMB3t+SUXxsl8wjz6uwNKS87bZfv4XH8P4KRJk5nfQS4CCsIpGYTVuyeMplVJm6231/4j5BWZOsq0nH5oBmDhoWoV+02p+gSOTo4a5WOJ+4LRHakf27aN0fptZAk+QrocZYcgL4IpJ7qrZ8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107113; c=relaxed/simple;
	bh=bX9xDE2uQAiOZUN07SIW8h6vUR0PV/BSYVpDFr6nVqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6W9EvbXaV0IbXgCqwNNX3XnQcc0u86psei1BA38bRSjbpMUEliay5d+dn6la2SVCSQ0wO4aioGJl2IuSUNHRtGy8FmdAHR/OiqXZd5fZoY3cTB8ZNKN4OamRtf+okx5e12Hajx/w2UUDSq+w8se1TGoDDTDgETMhxkHf4gEWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AxLCqC6e; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766107098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wX6EViJ13mRWXkqyRNy2dkPPLqUQ2YPrvTky8OaAqDI=;
	b=AxLCqC6epb7d00XQRkd+zR3gV08rLPJRfLUW0wvlMMSsHzTswA/hykO3exSMNYFecqRACO
	KbV67BwyvCkM8ziIrk/Es6tVYr01/PQJm+0U+y2HHg2CwGjueljowJfFGyzMEJNabcqPgP
	Se2zleM4S32zHIGmjSTHj0VhPfOCKpE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
Date: Fri, 19 Dec 2025 09:18:04 +0800
Message-ID: <1943128.tdWV9SEqCh@7940hx>
In-Reply-To:
 <CAEf4Bzb8oooWbxctuVhNPsziRBd1Fv9Y11-5TiEML8ckjrCt+g@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <CAEf4Bzb8oooWbxctuVhNPsziRBd1Fv9Y11-5TiEML8ckjrCt+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hi, all.
> >
> > In this version, I combined Alexei and Andrii's advice, which makes the
> > architecture specific code much simpler.
> >
> > Sometimes, we need to hook both the entry and exit of a function with
> > TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> > function, which is not convenient.
> >
> > Therefore, we add a tracing session support for TRACING. Generally
> > speaking, it's similar to kprobe session, which can hook both the entry
> > and exit of a function with a single BPF program. Session cookie is also
> > supported with the kfunc bpf_fsession_cookie(). In order to limit the
> > stack usage, we limit the maximum number of cookies to 4.
> >
> > The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are both
> > inlined in the verifier.
>=20
> We have generic bpf_session_is_return() and bpf_session_cookie() (that
> currently works for ksession), can't you just implement them for the
> newly added program type instead of adding type-specific kfuncs?

Hi, Andrii. I tried and found that it's a little hard to reuse them. The
bpf_session_is_return() and bpf_session_cookie() are defined as kfunc, which
makes we can't implement different functions for different attach type, like
what bpf helper does.

The way we store "is_return" and "cookie" in fsession is different with
ksession. For ksession, it store the "is_return" in struct bpf_session_run_=
ctx.
Even if we move the "nr_regs" from stack to struct bpf_tramp_run_ctx,
it's still hard to reuse the bpf_session_is_return() or bpf_session_cookie(=
),
as the way of storing the "is_return" and "cookie" in fsession and ksession
is different, and it's a little difficult and complex to unify them.

What's more, we will lose the advantage of inline bpf_fsession_is_return
and bpf_fsession_cookie in verifier.

I'll check more to see if there is a more simple way to reuse them.

Thanks!
Menglong Dong

>=20
> >
> > We allow the usage of bpf_get_func_ret() to get the return value in the
> > fentry of the tracing session, as it will always get "0", which is safe
> > enough and is OK. Maybe we can prohibit the usage of bpf_get_func_ret()
> > in the fentry in verifier, which can make the architecture specific code
> > simpler.
> >
> > The fsession stuff is arch related, so the -EOPNOTSUPP will be returned=
 if
> > it is not supported yet by the arch. In this series, we only support
> > x86_64. And later, other arch will be implemented.
> >
> > Changes since v3:
> > * instead of adding a new hlist to progs_hlist in trampoline, add the b=
pf
> >   program to both the fentry hlist and the fexit hlist.
> > * introduce the 2nd patch to reuse the nr_args field in the stack to
> >   store all the information we need(except the session cookies).
> > * limit the maximum number of cookies to 4.
> > * remove the logic to skip fexit if the fentry return non-zero.
> >
> > Changes since v2:
> > * squeeze some patches:
> >   - the 2 patches for the kfunc bpf_tracing_is_exit() and
> >     bpf_fsession_cookie() are merged into the second patch.
> >   - the testcases for fsession are also squeezed.
> >
> > * fix the CI error by move the testcase for bpf_get_func_ip to
> >   fsession_test.c
> >
> > Changes since v1:
> > * session cookie support.
> >   In this version, session cookie is implemented, and the kfunc
> >   bpf_fsession_cookie() is added.
> >
> > * restructure the layout of the stack.
> >   In this version, the session stuff that stored in the stack is change=
d,
> >   and we locate them after the return value to not break
> >   bpf_get_func_ip().
> >
> > * testcase enhancement.
> >   Some nits in the testcase that suggested by Jiri is fixed. Meanwhile,
> >   the testcase for get_func_ip and session cookie is added too.
> >
> > Menglong Dong (9):
> >   bpf: add tracing session support
> >   bpf: use last 8-bits for the nr_args in trampoline
> >   bpf: add the kfunc bpf_fsession_is_return
> >   bpf: add the kfunc bpf_fsession_cookie
> >   bpf,x86: introduce emit_st_r0_imm64() for trampoline
> >   bpf,x86: add tracing session supporting for x86_64
> >   libbpf: add support for tracing session
> >   selftests/bpf: add testcases for tracing session
> >   selftests/bpf: test fsession mixed with fentry and fexit
> >
> >  arch/x86/net/bpf_jit_comp.c                   |  47 +++-
> >  include/linux/bpf.h                           |  39 +++
> >  include/uapi/linux/bpf.h                      |   1 +
> >  kernel/bpf/btf.c                              |   2 +
> >  kernel/bpf/syscall.c                          |  18 +-
> >  kernel/bpf/trampoline.c                       |  50 +++-
> >  kernel/bpf/verifier.c                         |  75 ++++--
> >  kernel/trace/bpf_trace.c                      |  56 ++++-
> >  net/bpf/test_run.c                            |   1 +
> >  net/core/bpf_sk_storage.c                     |   1 +
> >  tools/bpf/bpftool/common.c                    |   1 +
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  tools/lib/bpf/bpf.c                           |   2 +
> >  tools/lib/bpf/libbpf.c                        |   3 +
> >  .../selftests/bpf/prog_tests/fsession_test.c  |  90 +++++++
> >  .../bpf/prog_tests/tracing_failure.c          |   2 +-
> >  .../selftests/bpf/progs/fsession_test.c       | 226 ++++++++++++++++++
> >  17 files changed, 571 insertions(+), 44 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_tes=
t.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> >
> > --
> > 2.52.0
> >
>=20





