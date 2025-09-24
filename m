Return-Path: <bpf+bounces-69501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE93B980A6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 04:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B14C2641
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E5218596;
	Wed, 24 Sep 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jByfdNiV"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0401E51EE
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679434; cv=none; b=UcPf5+i6S8eYemE1+IiBcleLEQ3oQIJ2zL3GS+PAET4Zkr4/ciR/y2TYXcmOALjnJ8NkdycoxPsHLTkqY19eubVrPNFlJWERMaNg3t0/ZR/MjLJ2YW3zkYcdKARSIw7qfJ68al/YiVafQgnvcMP11XqE4rUYdliZ/S6ZBA9f1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679434; c=relaxed/simple;
	bh=zunHHmiOODu02RRapiPXUM2Jwgkc6zX4zmO4qpdg0/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpLiqNbq07Scd9WUo1dMKStsDevJIOx2zFVeMy70LV8iC6VioM6d7BqRa0+3BycOJP6FwAMFA9ccZB9rl79BKzyivSl3YZAzoKT1Jz890QiccUkyi7kQ0HGxtZLO5iIkW5BndZ219rcuchOZW+c3JAZCEu0you522Nfi28qQNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jByfdNiV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758679429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zunHHmiOODu02RRapiPXUM2Jwgkc6zX4zmO4qpdg0/c=;
	b=jByfdNiV2QMZ2xpMzLP5OisX1dHPJCsh5LNbFxctD5b94eFOSNuf/4wDelYpJP/NMcyoaR
	87H9AhCcsq7H0/nGb4qxYRa4iiD3lo1nd399JFujSecfOFaDL7+foIVrbIZu2EpNPROuUA
	ePWLTWg3JTR7sGmf++18ZLeane7GWm4=
From: menglong.dong@linux.dev
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
Date: Wed, 24 Sep 2025 10:03:41 +0800
Message-ID: <7855639.EvYhyI6sBW@7940hx>
In-Reply-To:
 <CAADnVQLZMwNUF0PwoCyLUC6tWVuyx80qJF692VgnGoJVm_M=eQ@mail.gmail.com>
References:
 <20250922095705.252519-1-dongml2@chinatelecom.cn>
 <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
 <CAADnVQLZMwNUF0PwoCyLUC6tWVuyx80qJF692VgnGoJVm_M=eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/24 03:23 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Mon, Sep 22, 2025 at 7:11=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wro=
te:
> > >
> > > On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > >
> > > > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > > > Therefore, we can store the "is_return" to the last bit of the "dat=
a",
> > > > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
> > >
> > > Does this really save anything? AFAICT, bpf_session_run_ctx is
> > > only allocated on the stack. Therefore, we don't save any memory
> > > unless there is potential risk of stack overflow.
> >
> > Hi, Song. My original intention is to save the usage of the
> > stack to prevent potential stack overflow,
>=20
> 8 bytes won't matter, but wasting 8 bytes for 1 bit is indeed annoying.
>=20
> > especially when we
> > trace all the kernel functions with kprobe-multi.
>=20
> What do you mean? kprobe-multi won't recurse,
> so tracing all or a few functions is the same concern
> from stack overflow pov, no ?

You are right, I made something wrong. I mixed it with origin
call case of the bpf trampoline, which will store all the things
in the stack for every function call.

>=20
> > The most thing for me is that the unaligned field in the struct
> > looks very awkward, and it consumes 8-bytes only for a bit.
>=20
> let's keep it as-is. If stack overflow is indeed an issue we need
> a generic way to detect it and prevent it.
> We've been thinking whether vmap stack guard pages
> can become JIT's extable-like things, so when stack overflow

Interesting

> happens we unwind stack and stop bpf prog instead of panicing.

Yeah, I think it's OK to keep it still.

Thanks!
Menglong Dong

>=20
>=20





