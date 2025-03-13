Return-Path: <bpf+bounces-53997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F264AA60129
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEDC3B0374
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5211F192E;
	Thu, 13 Mar 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUtSe4my"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D711EBFE4;
	Thu, 13 Mar 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894101; cv=none; b=WywuQ2V99GPmhQNb6wW38u8cs6zIo6mG4wn146Y8xinIqI16l4J/UJe96Ow9JciVpOenjwIJPLkverR+M28ebgVTZoIeENOGoJtam2QvRWIFZ1c2K6t0SkWz20UVleaUEKe5ba7BMxbOrE4Z942/QRgAu/xnicKan0VMpYhzbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894101; c=relaxed/simple;
	bh=wzIoQJtHCqxE4qs11KQvAnWfL5PmdENT7fo1OQLfH4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tuOqP6ZjKw+hW7PSq69mNNGsjUR0/kDA0aJ67Uskl0OFFebgF+507sZTlAmWBHJglTBIslGG6uNdkxoiqoHqJbK+3anlIhZvaK7aNSyzAA71GcrHVD60dj244BJqWdjxtAE6d1ylLXM4Q6s9+4IcMG+wRehkZ8iR0r75BzLziOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUtSe4my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98A9C4CEDD;
	Thu, 13 Mar 2025 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741894100;
	bh=wzIoQJtHCqxE4qs11KQvAnWfL5PmdENT7fo1OQLfH4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iUtSe4my3gvYGNNc+KrebP1DPw+7ew2PB5ujx0hqNkyD2606hnFc5JVqsHNpJZB2F
	 ve/yj7r9fJoZdb/99nuuirii1Vzi1a+w4erTRj0X1CS6pQ4gt3zRekx52VWKfZ2AzI
	 bHRPJB82KU6f8H4C9713Q5x60qB7Lxc0/WMK9jXvNiL4b+K/C0pWckwXokqlm31aLp
	 Ly3RqYr9Zwb0nYnXcVqy5ST2/35fTlI/YIVUHjrqjlu8fPQcO9E3QMMxzqdQaEDXEd
	 fgYbirpA+9FUt4StdAOmqu9cPip/zNtGgpUfW7sWzad8srqEH6ofS7IlT3KDb0QXQm
	 0oupul/R4DNVQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A093E18FA889; Thu, 13 Mar 2025 20:28:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>, Alexei
 Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
In-Reply-To: <20250313183911.SPAmGLyw@linutronix.de>
References: <20250313183911.SPAmGLyw@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 13 Mar 2025 20:28:06 +0100
Message-ID: <87ecz0u3w9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Hi,
>
> Ricardo reported a KASAN related use after free
> 	https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/
>
> in v6.6 stable and suggest a backport of commits
> 	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> 	fecef4cd42c68 ("tun: Assign missing bpf_net_context.")
> 	9da49aa80d686 ("tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()")
>
> as a fix. In the meantime I have the syz reproducer+config and was able
> to investigate.
> It looks as if the syzbot starts a BPF program via xdp_test_run_batch()
> which assigns ri->tgt_value via dev_hash_map_redirect() and the return code
> isn't XDP_REDIRECT it looks like nonsense. So the print in
> bpf_warn_invalid_xdp_action() appears once. Everything goes as planned.
> Then the TUN driver runs another BPF program which returns XDP_REDIRECT
> without setting ri->tgt_value. This appears to be a trick because it
> invoked bpf_trace_printk() which printed four characters. Anyway, this
> is enough to get xdp_do_redirect() going.
>
> The commits in questions do fix it because the bpf_redirect_info becomes
> not only per-task but gets invalidated after the XDP context is left.
>
> Now that I understand it I would suggest something smaller instead as a
> stable fix, (instead the proposed patches). Any objections to the
> following:
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index be313928d272..1d906b7a541d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9000,8 +9000,12 @@ static bool xdp_is_valid_access(int off, int size,
>  
>  void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
>  {
> +	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
>  	const u32 act_max = XDP_REDIRECT;
>  
> +	ri->map_id = INT_MAX;
> +	ri->map_type = BPF_MAP_TYPE_UNSPEC;
> +
>  	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expect packet loss!\n",
>  		     act > act_max ? "Illegal" : "Driver unsupported",
>  		     act, prog->aux->name, prog->aux->id, dev ? dev->name : "N/A");

From your description above, this will fix the particular error
encountered, but what happens if the initial return code is not in fact
nonsense (so the warn_invalid_action) is not triggered?

I.e.,

bpf_redirect_map(...);
return XDP_DROP;

would still leave ri->map_id and ri->map_type set for the later tun
driver invocation, no?

-Toke

