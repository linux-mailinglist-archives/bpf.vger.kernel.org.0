Return-Path: <bpf+bounces-73579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BD1C34590
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 08:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F6C1887A23
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E22D3739;
	Wed,  5 Nov 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W1de71Bz"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D228D830
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328824; cv=none; b=h80VLeJyCQ05DYc+RjhfX6BmUAvfslW5MQJN8d1mbGxVzN4AMZzFfgEeoGda9yMhtYSJGsDVgcoo6cSGutuTGM/NDdZGPCYcKqyPOmJMI9NIsd7CgN2kS1+Lstma1WOgLKjF7nKxZE8YWIQu+jiWYQqd1Hp/jAqxVlh6IE98TWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328824; c=relaxed/simple;
	bh=veipUYVxRtTXsinc0QPd03nkK+7sJKmNn8tmCUKG17U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSJ1sooHCHxY+2yWDJcfFmfsFTfsq64tu8OJplyye3MChTX1/3PZT9HjUoB1tebLqcJywPOrcWDynXmPn5etjyRN3FlSAUCe4EkejYkuG56JAMudttPMfEaOMxEZu4HQjQZPVQtHljk9cqZm7yBOQc5+WQYrf0snQFEX4nR3Q/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W1de71Bz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762328820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH/Z4czBasBtE4pQuylaFhi4G581F8JDtrlt08hwbuk=;
	b=W1de71BzP2x8bRMPInQKaijgZM27NzjGhnHI2Y5A2N2Q2kb1pwoAX+j12oQPqcCn8SlIYI
	GyS+bAppC8NGysX7rQxjbfcl9E/ZeAC1hdQ79phmoUyDHhDNKF1qhxg3PWDb44IdaRXORk
	kQ1H7+SwPmzxKsWh49zuLI1Bqc8gmsg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, peterz@infradead.org
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Wed, 05 Nov 2025 15:46:47 +0800
Message-ID: <1986305.taCxCBeP46@7950hx>
In-Reply-To: <4465519.ejJDZkT8p0@7950hx>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <CAADnVQKQXcUxjJ2uYNu1nvhFYt=KhN8QYAiGXrt_YwUsjMFOuA@mail.gmail.com>
 <4465519.ejJDZkT8p0@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/5 15:13, Menglong Dong wrote:
> On 2025/11/5 10:12, Alexei Starovoitov wrote:
> > On Tue, Nov 4, 2025 at 5:30=E2=80=AFPM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2025/11/5 02:56, Alexei Starovoitov wrote:
> > > > On Tue, Nov 4, 2025 at 2:49=E2=80=AFAM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > > >
> > > > > In origin call case, we skip the "rip" directly before we return,=
 which
> > > > > break the RSB, as we have twice "call", but only once "ret".
> > > >
> > > > RSB meaning return stack buffer?
> > > >
> > > > and by "breaks RSB" you mean it makes the cpu less efficient?
> > >
> > > Yeah, I mean it makes the cpu less efficient. The RSB is used
> > > for the branch predicting, and it will push the "rip" to its hardware
> > > stack on "call", and pop it from the stack on "ret". In the origin
> > > call case, there are twice "call" but once "ret", will break its
> > > balance.
> >=20
> > Yes. I'm aware, but your "mov [rbp + 8], rax" screws it up as well,
> > since RSB has to be updated/invalidated by this store.
> > The behavior depends on the microarchitecture, of course.
> > I think:
> > add rsp, 8
> > ret
> > will only screw up the return prediction, but won't invalidate RSB.
> >=20
> > > Similar things happen in "return_to_handler" in ftrace_64.S,
> > > which has once "call", but twice "ret". And it pretend a "call"
> > > to make it balance.
> >=20
> > This makes more sense to me. Let's try that approach instead
> > of messing with the return address on stack?
>=20
> The way here is similar to the "return_to_handler". For the ftrace,
> the origin stack before the "ret" of the traced function is:
>=20
>     POS:
>     rip   ---> return_to_handler
>=20
> And the exit of the traced function will jump to return_to_handler.
> In return_to_handler, it will query the real "rip" of the traced function
> and the it call a internal function:
>=20
>     call .Ldo_rop
>=20
> And the stack now is:
>=20
>     POS:
>     rip   ----> the address after "call .Ldo_rop", which is a "int3"
>=20
> in the .Ldo_rop, it will modify the rip to the real rip to make
> it like this:
>=20
>     POS:
>     rip   ---> real rip
>=20
> And it return. Take the target function "foo" for example, the logic
> of it is:
>=20
>     call foo -> call ftrace_caller -> return ftrace_caller ->
>     return return_to_handler -> call Ldo_rop -> return foo
>=20
> As you can see, the call and return address for ".Ldo_rop" is
> also messed up. So I think it works here too. Compared with
> a messed "return address", a missed return maybe have
> better influence?
>=20
> And the whole logic for us is:
>=20
>     call foo -> call trampoline -> call origin ->
>     return origin -> return POS -> return foo

The "return POS" will miss the RSB, but the later return
will hit it.

The origin logic is:

     call foo -> call trampoline -> call origin ->
     return origin -> return foo

The "return foo" and all the later return will miss the RBS.

Hmm......Not sure if I understand it correctly.

>=20





