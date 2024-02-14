Return-Path: <bpf+bounces-21971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092B854B60
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 15:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B7DB27C5F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9055E5E;
	Wed, 14 Feb 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DezL2h+g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/3qjuPD"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AD1A58B;
	Wed, 14 Feb 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920913; cv=none; b=WYdu4SNn8VvmBhDH/Y5eINDoZ2pvtpm05f4Y3ccygN3mMBk9j5nRDuYPcBpGcDo96DpdbTd2wB9Il2syeI5YkW+86CWSuhPZuIVqKkDU19e/JC69eZ8DYNnQwKH6xTSdp7PkspM7OpBhwQrRbmCPInLKJr7veM9Rng2LqUOVw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920913; c=relaxed/simple;
	bh=PgI/c4FednX6iHl32xVlK67vq3R0ovJubc9VLJ1LtH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPpS0xaSp3HcEXm64MiYAJzC9WvRIwjQ1UqAsdE3xB72H3aONNA1nccVDXlLS9ZJmge5yubhLxrxytqQyykxGvzI1kH+N090al8nvikcop30i7VtksYqr5EnN21hKMMH+GNGbhb1jQr1Wv9eq3b27iWcmLGSPNqevfc3thxZaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DezL2h+g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/3qjuPD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Feb 2024 15:28:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707920909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x6/b2Kbco5DooPMkROtK4kteG3DvWx4gBprcUEOg3s=;
	b=DezL2h+g2UvT5RZ9zs5cue/VtROzlcqvPPI4o4l1qhtltz/yvXjP+gusiBkO6Nu+e+nAgw
	ORF4kUDcC9V4CtnTUaRFb617A3MyV+Od3LPc5YX4QN+eXp6Wq8Snqdyd4oJYXaUQUxnOTJ
	JxyUdvW7htxDkL63+b20bsOlOqmGwGKrLn0iGEFYIPBXfPLF4fvlUqwuHHKB6pOvAklTSo
	FSbqLZPBpTv/Qpht+XS/vW+NJfj7rnYU/XDnPp31RSCXZ/Ut9xoWzkWNoNHy0+sDy0NSnV
	9tjHNAdAW3lKoNW3JmeXRMmYHiNJ4ipb9iLIaPt0A6lZeiMUJWHefgU1Uor5yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707920909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1x6/b2Kbco5DooPMkROtK4kteG3DvWx4gBprcUEOg3s=;
	b=N/3qjuPDckZz/kcVK1VSvUqNkpRtF38p5ZJWBPnkbftfVN6qhw02dTpxVPO9U2Ll1c+aVE
	7PnNdzAQIsx4gpBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240214142827.3vV2WhIA@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de>
 <87y1bndvsx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87y1bndvsx.fsf@toke.dk>

On 2024-02-14 14:23:10 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>=20
> > On 2024-02-13 21:50:51 [+0100], Jesper Dangaard Brouer wrote:
> >> I generally like the idea around bpf_xdp_storage.
> >>=20
> >> I only skimmed the code, but noticed some extra if-statements (for
> >> !NULL). I don't think they will make a difference, but I know Toke want
> >> me to test it...
> >
> > I've been looking at the assembly for the return value of
> > bpf_redirect_info() and there is a NULL pointer check. I hoped it was
> > obvious to be nun-NULL because it is a static struct.
> >
> > Should this become a problem I could add
> > "__attribute__((returns_nonnull))" to the declaration of the function
> > which will optimize the NULL check away.
>=20
> If we know the function will never return NULL (I was wondering about
> that, actually), why have the check in the C code at all? Couldn't we just
> omit it entirely instead of relying on the compiler to optimise it out?

The !RT version does:
| static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
| {
|         return this_cpu_ptr(&bpf_redirect_info);
| }

which is static and can't be NULL (unless by mysterious ways the per-CPU
offset + bpf_redirect_info offset is NULL). Maybe I can put this in
this_cpu_ptr()=E2=80=A6 Let me think about it.

For RT I have:
| static inline struct bpf_xdp_storage *xdp_storage_get(void)
| {
|         struct bpf_xdp_storage *xdp_store =3D current->bpf_xdp_storage;
|
|         WARN_ON_ONCE(!xdp_store);
|         return xdp_store;
| }
|
| static inline struct bpf_redirect_info *xdp_storage_get_ri(void)
| {
|         struct bpf_xdp_storage *xdp_store =3D xdp_storage_get();
|
|         if (!xdp_store)
|                 return NULL;
|         return &xdp_store->ri;
| }

so if current->bpf_xdp_storage is NULL then we get a warning and a NULL
pointer. This *should* not happen due to xdp_storage_set() which
assigns the pointer. However if I missed a spot then there is the check
which aborts further processing.

During testing I forgot a spot in egress and the test module. You could
argue that the warning is enough since it should pop up in testing and
not production because the code is always missed and not by chance (go
boom, send a report). I *think* I covered all spots, at least the test
suite didn't point anything out to me.
I was unsure if I need something around net_tx_action() due to
TC_ACT_REDIRECT (I think qdisc) but this seems to be handled by
sch_handle_egress().

> -Toke

Sebastian

