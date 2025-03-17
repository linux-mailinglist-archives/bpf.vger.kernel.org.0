Return-Path: <bpf+bounces-54187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE185A64A10
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 11:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9494E188B391
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 10:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0479230274;
	Mon, 17 Mar 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/SNH52u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F41459F7;
	Mon, 17 Mar 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207398; cv=none; b=CByDiTfmshg7X2AXY5dsjRN3oIcMORLt8ESFEfAtJF2xGO+NXHn437x9o8QBTwbEF5pq/VWLllTFao81QJziWJv4MYDNDtpwXkeNw49W6ELlSAQztTS9ZhZHQNIej8n5srORvSt0FY4pYzV4F8zYfIeyuOpGt+qGfpsbLqcUdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207398; c=relaxed/simple;
	bh=xrD7KE1k+H1Nc/t93XgQlgKaIsN4lFSxsm+U0bjj+xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b2zNtEZoM9MIOZrIhGFPz4fmBqzN/q+dvrWTxAYN6WFXWSp/4sy0TIXvKyYjYSoU/FSa5UCUcu6J+PXi1ex1tRUiqewccszWz6+Q/obrvwoQRjUNnMn+bQoCqJHb99I4jurOh8Zx5sHTJfkqJtgTjt34w6Gw2IcOUy7E6wSe4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/SNH52u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5398BC4CEE3;
	Mon, 17 Mar 2025 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207397;
	bh=xrD7KE1k+H1Nc/t93XgQlgKaIsN4lFSxsm+U0bjj+xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h/SNH52u6OpVd5Vt54HwN0ScwOPm4VDjF35j0KHfLm27yOaGC1SSlhEKyESZESOoC
	 LJFJvwSdgv5a3nRJw8oUSileks/Vv0yZkiKz525ZSR1jH22bw/EPUWnwPsPGBI/ke3
	 G6leTGCBf0DT8vCkv0jr+w3XJfeOhZbXXSo4wOv8nCdeIgGrO8S5i0oYedaQsdYp3X
	 nj2WgCnYnpZZuN41owN/pFNXx2QHVg/zjLezlGcLS9cuqcve16iCLJXRfEr2AGVwN1
	 ZPz6ZnMj9f0wvf+px8QCiT6wcl8G9jfU++WSHaCXCrtHT9eEhP2aGN+fJOQhE4LsKM
	 sUlTpW81de8wQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9640F18FAE48; Mon, 17 Mar 2025 11:29:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Ricardo =?utf-8?Q?Ca?=
 =?utf-8?Q?=C3=B1uelo?= Navarro
 <rcn@igalia.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
In-Reply-To: <20250314172749.hsmtyM3N@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de> <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de> <871pv0rmr8.fsf@toke.dk>
 <20250314153041.9BKexZXH@linutronix.de> <875xkbha5k.fsf@toke.dk>
 <20250314172749.hsmtyM3N@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 11:29:43 +0100
Message-ID: <874izshrvs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-03-14 17:03:35 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > While at it, is there anything that ensures that only bpf_prog_run_xdp=
()
>> > can invoke the map_redirect callback? Mainline only assigns the task
>> > pointer in NAPI callback so any usage outside of bpf_prog_run_xdp() wi=
ll
>> > lead to a segfault and I haven't seen a report yet so=E2=80=A6
>>=20
>> Yes, the verifier restricts which program types can call the
>> map_redirect helper.
>
> Okay. So checks for the BPF_PROG_TYPE_XDP type for the map_redirect and
> that is the only one setting it. Okay. Now I remember Alexei mentioning
> something=E2=80=A6

Yeah, there's basically a mapping between BPF program types and the
available helpers. For XDP this is in xdp_func_proto() in net/core/filter.c.

>> > --- a/include/net/xdp.h
>> > +++ b/include/net/xdp.h
>> > @@ -486,7 +486,12 @@ static __always_inline u32 bpf_prog_run_xdp(const=
 struct bpf_prog *prog,
>> >  	 * under local_bh_disable(), which provides the needed RCU protection
>> >  	 * for accessing map entries.
>> >  	 */
>> > -	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
>> > +	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
>> > +	u32 act;
>> > +
>>=20
>> Add an if here like
>>=20
>> if (ri->map_id | ri->map_type) { /* single | to make it a single branch =
*/
>>=20
>> > +	ri->map_id =3D INT_MAX;
>> > +	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
>>=20
>> }
>>=20
>> Also, ri->map_id should be set to 0, not INT_MAX.
>
> The or variant does
>
> |         add %gs:this_cpu_off(%rip), %rax        # this_cpu_off, tcp_ptr=
__
> |         movl    32(%rax), %edx  # _51->map_id, _51->map_id
> |         orl     36(%rax), %edx  # _51->map_type, tmp311
> |         je      .L1546  #,
> |         movq    $0, 32(%rax)    #, MEM <vector(2) unsigned int> [(unsig=
ned int *)_51 + 32B]
> | .L1546:
>
> while the || does
>
> |         add %gs:this_cpu_off(%rip), %rax        # this_cpu_off, tcp_ptr=
__
> |         cmpq    $0, 32(%rax)    #, *_51
> |         je      .L1546  #,
> |         movq    $0, 32(%rax)    #, MEM <vector(2) unsigned int> [(unsig=
ned int *)_51 + 32B]
> | .L1546:
>
> gcc isn't bad at optimizing here ;)

Ohh, neat! Didn't consider that this is two U32s, so they can be loaded
in one go. That's what I get from trying to second-guess the compiler, I
suppose :)

Let's just go with the obvious one (||) instead of the OR thing, then.

> This is the or version as asked for. I don't mind doing any of the both.
> I everyone agrees then I would send it to Greg.

Sure, with the above, feel free to add my:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

