Return-Path: <bpf+bounces-77917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D6CF68CD
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 04:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A8CF3008CB0
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 03:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A71DF256;
	Tue,  6 Jan 2026 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZX8hYSP"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39847D27E;
	Tue,  6 Jan 2026 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668720; cv=none; b=EsD4vRbK6aL39jPwOATL0//CuZafVfODv3KJMDeFyn78KtDclSDQCf4Qc+I8tmVWn2OxkpZ63oCStsBLJOyUfEVyATRdIn2jR3WBGI03HcA5X/Rj2M38frZ6vka4bt7avNO+jWLCrzuY8gxG4mIBM0jCq6ThmIqhP+3JjiNiKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668720; c=relaxed/simple;
	bh=zxrz2lbJbmIsduvUiQCtmTi2f5ZF/2WlT5NgRfCZPwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyO6xkTsoe1LeTwZXjQ4zbV407q1ifQUwa0Nw4STniIlO22mveAb+JuhyRqxELsICRrAszCBX4S32sQKh4ke2kJJCrB+++3tjDqf9kdJ+nNpXM7cCP2ARiC+6jTTUdG4YTe+P14++VMF3gLKCf0mLcEF8Sxv56LroBK+CrKk6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZX8hYSP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767668704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNt1Of0i9x64BslwslxqHsf9KuidTP+1Zvtct7Ztk+o=;
	b=xZX8hYSPJDU3aSn7s7JeDOBqOlhwq1BVRqrnm1BSAewy7yeOs77IE1bFZ+ZjdmBNxqOdFb
	RpjaAlty6u8jnN7r48ZsB2r7kVTPnLItUqy02+FrU+bLjotmzsBRMnZTbuAm79CCYC4/yG
	FNR4dYJkDxFxD9rkxo4LHqPM0fkZe44=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 00/10] bpf: fsession support
Date: Tue, 06 Jan 2026 11:04:47 +0800
Message-ID: <3389151.aeNJFYEL58@7940hx>
In-Reply-To:
 <CAEf4BzbCyMWr5tq5i45SB3jPvUFd4zOAYwJG3KBBeaoWmEq8kw@mail.gmail.com>
References:
 <20260104122814.183732-1-dongml2@chinatelecom.cn>
 <CAEf4BzbCyMWr5tq5i45SB3jPvUFd4zOAYwJG3KBBeaoWmEq8kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/6 05:20 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sun, Jan 4, 2026 at 4:28=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > Hi, all.
> >
[......]
> > Maybe it's possible to reuse the existing bpf_session_cookie() and
> > bpf_session_is_return(). First, we move the nr_regs from stack to struct
> > bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the sess=
ion
> > cookies as flexible array in bpf_tramp_run_ctx like this:
> >     struct bpf_tramp_run_ctx {
> >         struct bpf_run_ctx run_ctx;
> >         u64 bpf_cookie;
> >         struct bpf_run_ctx *saved_run_ctx;
> >         u64 func_meta; /* nr_args, cookie_index, etc */
> >         u64 fsession_cookies[];
> >     };
> >
> > The problem of this approach is that we can't inlined the bpf helper
> > anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
> > we can't use the "current" in BPF assembly.
> >
>=20
> We can, as Alexei suggested on your other patch set. Is this still a
> valid concern?

Yeah, with the support of BPF_MOV64_PERCPU_REG, it's much easier
now.

So what approach should I use now? Change the prototype of
bpf_session_is_return/bpf_session_cookie, as Alexei suggested, or
use the approach here? I think both works, and I'm a little torn
now. Any suggestions?

Thanks!
Menglong Dong

>=20
> I think having separate duplicated ksession and fsession specific
> bpf_[f]session_{is_return,session_cookie}() APIs is really bad and
> confusing long-term.
>=20
> > So maybe it's better to use the new kfunc for now? And I'm analyzing th=
at
>=20
> there is no "for now", this decision will be with us for a really long ti=
me...
>=20
> > if it is possible to inline "current" in verifier. Maybe we can convert=
 to
> > the solu
[......]
> >
>=20





