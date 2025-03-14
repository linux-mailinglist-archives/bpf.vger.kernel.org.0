Return-Path: <bpf+bounces-54057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1509A615B3
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402BB3A7D2C
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B71FF1B7;
	Fri, 14 Mar 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkJQw267"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CBF510;
	Fri, 14 Mar 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968230; cv=none; b=A2vVKG7vFIkOQq7EvQuFGeWetTh9g1plTBlO1/8BqNfWhCMMjlR1RjDQ70bSzs2BcXtnZcFdaNUbxJjgVS7NzNupyevO3gsRbJeBMoDNhDrfRQC/jdt/uYVDjpcSdxsdpTt+yjCjad9qwLOpmb4JCFql2BFbwp+tFfyjo+Po0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968230; c=relaxed/simple;
	bh=ys7fpnj+43Ho8CcV7s+QOyWtmq9kNa8/t9fbXBA4f4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enRqZQV7XQRqlOwsh80VmShYyfl43xtFZd16UGp14hocp5nUiuWou8uToXzvTzq99bf1F9SdTyffPPoR42mYs+Df2fbKh5r+X9fgjTkPMJVKuPezi0FNSrbgErfOz11sSE2WHT+woJCnWmYclYOgKHFWYceVKUgRAY3ZJ+hpr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkJQw267; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73639C4CEE9;
	Fri, 14 Mar 2025 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968229;
	bh=ys7fpnj+43Ho8CcV7s+QOyWtmq9kNa8/t9fbXBA4f4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nkJQw267AqVnQ+sPuO27hXPe/T/4cI5R/Ud0AyV9aV4dGKGrDiiBVjS4HpqwzYYJL
	 dlCo3XOwbCUVUFt+Cx8v9R23EVkCnxDJFL5CkZPKAo+dz2hZ6bfIzXDzF5edV81voe
	 AKupOYKrOhthnGtf+RKSV8fcZSgpNlgV6jqAQamDPRjTeNezrVYfssAzPVn08SUTnm
	 DKFdIbQRm9jHfJvUnVEosji5EenA893Sy6Ou35gQLLDbwVpyWTdP+JJfqunbrMRamg
	 rc/UmqcGaNHyPAfPJWLSapSLaaMQ89uVfeGYwi0gE9bip5b1/+QnjBUePSlEJ30ssF
	 QuwCtLpA02L7g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D465E18FAAA1; Fri, 14 Mar 2025 17:03:35 +0100 (CET)
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
In-Reply-To: <20250314153041.9BKexZXH@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de> <87ecz0u3w9.fsf@toke.dk>
 <20250313203226.47_0q7b6@linutronix.de> <871pv0rmr8.fsf@toke.dk>
 <20250314153041.9BKexZXH@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 14 Mar 2025 17:03:35 +0100
Message-ID: <875xkbha5k.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-03-14 10:21:15 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, how about putting the reset (essentially the changes you have
>> above) into bpf_prog_run_xdp() itself, before executing the BPF program?
>
> That would be the snippet below. It does work as far as the testcase
> goes. It is just and unconditional write which might look like a waste
> but given the circumstances=E2=80=A6

Hmm, yeah, it would slow down applications that never redirect, I
suppose. Hmm, we could avoid the write by checking the values first? See
below.

> While at it, is there anything that ensures that only bpf_prog_run_xdp()
> can invoke the map_redirect callback? Mainline only assigns the task
> pointer in NAPI callback so any usage outside of bpf_prog_run_xdp() will
> lead to a segfault and I haven't seen a report yet so=E2=80=A6

Yes, the verifier restricts which program types can call the
map_redirect helper.


> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -486,7 +486,12 @@ static __always_inline u32 bpf_prog_run_xdp(const st=
ruct bpf_prog *prog,
>  	 * under local_bh_disable(), which provides the needed RCU protection
>  	 * for accessing map entries.
>  	 */
> -	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
> +	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
> +	u32 act;
> +

Add an if here like

if (ri->map_id | ri->map_type) { /* single | to make it a single branch */

> +	ri->map_id =3D INT_MAX;
> +	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;

}

Also, ri->map_id should be set to 0, not INT_MAX.

-Toke

