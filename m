Return-Path: <bpf+bounces-54030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4307A60D12
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E636A3B354A
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DC1EA7C9;
	Fri, 14 Mar 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SevGF5Ro"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EA1DE4D3;
	Fri, 14 Mar 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944092; cv=none; b=c23pVXwygzMghqCjBNoMDv6ddA4CxvYA9WQgHI/4exP4Q4qiYAFTh//Jh/81zQ4+acVHOYuvnbTrVTph4Jm7awNy9xz13ATTYxBEz7Ly27ErEVTIpvAhauK1BH9chmrtCv/1jBLa9r22d7U7/3caJAI6HdwhW6Lc04RzWEPnKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944092; c=relaxed/simple;
	bh=yVTmoWKUtKbt1fVE1BEK0fAxrS8QT2Bm79VFzI781eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REe/iDNtX9iI3gUw3IOg03AcQIuBbh9DWEKC9OzcIiXHnSzZnz4uYbbfKdt0y8C7P6rx02zBmHRBrHxggCKwOwj4V7nb1P0HqSotlJ56QJ1oflIB0sailX6IOYCSQu3Mg3VWzN8rCHxsy2wiGmu7qEQ1LxjWY28ddhdJ1M+s7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SevGF5Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C49C4CEEB;
	Fri, 14 Mar 2025 09:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741944090;
	bh=yVTmoWKUtKbt1fVE1BEK0fAxrS8QT2Bm79VFzI781eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SevGF5RoJc/JKo26GvKlH2akKaBbRwvofWTRcpD7ng5JI83MW3hp0fovrusy+YdE+
	 NG+hUnGudanGDqa0IcfL9Gl0e5mdVAfvtOMOM1m2WeORqYKlFnoNwS4dmUP/1vLPZe
	 k7QPkYvCi5zR0G+GVPuIQnE6R++qJiUW1Y4+edbotQDHHdckAJjxjRl1fzbE52ywZJ
	 sbd6zR+tFs/Qqh7OMZD1iL0wo6hqN+xoD2PJsiJzzX4iWQBOgrxWlBAqN6QYkkzw4M
	 e5NbVZHTNMlCEGFt35pA9WmY1tsp+85eUwwOeiqhCuP23GWBHA8jwd9sZAMHRt3eB0
	 F5r/V0Fq6J9eg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31C0C18FA909; Fri, 14 Mar 2025 10:21:16 +0100 (CET)
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
In-Reply-To: <20250313203226.47_0q7b6@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de> <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 14 Mar 2025 10:21:15 +0100
Message-ID: <871pv0rmr8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-03-13 20:28:06 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>=20
>> > Hi,
>> >
>> > Ricardo reported a KASAN related use after free
>> > 	https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-fr=
ee-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/
>> >
>> > in v6.6 stable and suggest a backport of commits
>> > 	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on P=
REEMPT_RT.")
>> > 	fecef4cd42c68 ("tun: Assign missing bpf_net_context.")
>> > 	9da49aa80d686 ("tun: Add missing bpf_net_ctx_clear() in do_xdp_generi=
c()")
>> >
>> > as a fix. In the meantime I have the syz reproducer+config and was able
>> > to investigate.
>> > It looks as if the syzbot starts a BPF program via xdp_test_run_batch()
>> > which assigns ri->tgt_value via dev_hash_map_redirect() and the return=
 code
>> > isn't XDP_REDIRECT it looks like nonsense. So the print in
>> > bpf_warn_invalid_xdp_action() appears once. Everything goes as planned.
>> > Then the TUN driver runs another BPF program which returns XDP_REDIRECT
>> > without setting ri->tgt_value. This appears to be a trick because it
>> > invoked bpf_trace_printk() which printed four characters. Anyway, this
>> > is enough to get xdp_do_redirect() going.
>> >
>> > The commits in questions do fix it because the bpf_redirect_info becom=
es
>> > not only per-task but gets invalidated after the XDP context is left.
>> >
>> > Now that I understand it I would suggest something smaller instead as a
>> > stable fix, (instead the proposed patches). Any objections to the
>> > following:
>> >
>> > diff --git a/net/core/filter.c b/net/core/filter.c
>> > index be313928d272..1d906b7a541d 100644
>> > --- a/net/core/filter.c
>> > +++ b/net/core/filter.c
>> > @@ -9000,8 +9000,12 @@ static bool xdp_is_valid_access(int off, int si=
ze,
>> >=20=20
>> >  void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_p=
rog *prog, u32 act)
>> >  {
>> > +	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
>> >  	const u32 act_max =3D XDP_REDIRECT;
>> >=20=20
>> > +	ri->map_id =3D INT_MAX;
>> > +	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
>> > +
>> >  	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expe=
ct packet loss!\n",
>> >  		     act > act_max ? "Illegal" : "Driver unsupported",
>> >  		     act, prog->aux->name, prog->aux->id, dev ? dev->name : "N/A");
>>=20
>> From your description above, this will fix the particular error
>> encountered, but what happens if the initial return code is not in fact
>> nonsense (so the warn_invalid_action) is not triggered?
>>=20
>> I.e.,
>>=20
>> bpf_redirect_map(...);
>> return XDP_DROP;
>>=20
>> would still leave ri->map_id and ri->map_type set for the later tun
>> driver invocation, no?
>
> Right. So if it returns XDP_PASS or XDP_DROP instead of nonsense then
> the buffer remains set. And another driver could use it.
> But this would mean we would have to tackle each bpf_prog_run_xdp()
> invocation and reset it afterwards=E2=80=A6 So maybe the backport instead=
? We
> have
> | $ git grep bpf_prog_run_xdp | wc -l
> | 55
>
> call sites.

Hmm, how about putting the reset (essentially the changes you have
above) into bpf_prog_run_xdp() itself, before executing the BPF program?

-Toke

