Return-Path: <bpf+bounces-53732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBAA59805
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096D9167241
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B9D1AC88B;
	Mon, 10 Mar 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="HdZ9pC/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUEWQCLp"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFF79C4;
	Mon, 10 Mar 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617967; cv=none; b=BL4yqduBjz7MEx1AKC6szp+0E78evEIKSGmQxOatOMVxxtSq9qkWhig1rpIZaMub7xuDLgbYDa18NGpaqax6wcwuy+WonQVwYOPoJLGsXriNQfD2v7+eYMUtsLnnEd1SkhISVV4Fp6OgvUc2b8BPXyYgwqUVhUKRJP7DkANxNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617967; c=relaxed/simple;
	bh=ud12zF0lPQFRWRGOxK4ukmj4g4pdMpd6TeX+OmXAbag=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z/QPzUsBTL35vql3d6jYnIQZ68Od5u2euG02ubutnWB1bTLnfegZG7qndSPQ4F1Sqj5uWf2qYPgnCkDcI6OP8EuhtNbLraoTS+yHvkqF74RxlVo7i/grr3XnMQGU2RpQzOycyz32iuYY6h1MPT9RT8sqouHCl9YNpBAHF9kvDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=HdZ9pC/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FUEWQCLp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A23FD1140109;
	Mon, 10 Mar 2025 10:46:00 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 10:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741617960; x=1741704360; bh=MmWur/zQnOdfxWi8ehnrEc3bRLZ3l7wQ
	k9qKd7F0Yw4=; b=HdZ9pC/bt3WiDij7mhOI7OGHEDbwB2ROrTuZQt9pwHpxBUG8
	ZDCayq9n1iaASKeOIi3mkydPdY5fQSVBkSgDIx7K55CbsSGtVxYUSYFUayH8HdiT
	or7Cx6HcIlGPBThxrYBBnAhvewJXAcXA62kMK8fEiNYF7hrJ9keVSYVJ+mKgEA2l
	WRqGwJeX7LEEwspq1yo4dSPvvOMYtc8/XgzYY9JjWiXAMs3lebXfhFKTAC4SRwt2
	oGtjuD5lU3ps1BBidZQUZEpL/8Vnq7ywG0OEyfofLwSHOihBtO9Rf1UBb2XZ4ptA
	MUO3uiWQYs10w+bP/2cp55veENan2W9WbWvI7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741617960; x=
	1741704360; bh=MmWur/zQnOdfxWi8ehnrEc3bRLZ3l7wQk9qKd7F0Yw4=; b=F
	UEWQCLp6f/f5SUkg/DOX1XvQmtDD3cux8vOYsVYSismA+fLVikOQn335LrC1DIiv
	L0A7QIc2YRVZH4SI4u+RIOySC9glTPKRK0muVEcxQtICOgOxRyBAbXIkuV8mlEua
	ySpqWgza2aOgi89e9cad2t9XynfaBeZ3AdJu9YE2zGIDCvy2YCVmoyjGp/zpx5cb
	+CuFi8fetc94VykDL7pox/6kcDwGmHQWyHtV/kjW0bvkPSKeHYZ0fwyNyEyq7jWN
	g5/mJv/nMjuAQ2CQsHHDJ3gMILsV46junCJjFPqr2JflfRXzE9CDRQtsKpVbUuxB
	F0IYJ/vT8+xxJowS1koQw==
X-ME-Sender: <xms:KPvOZ7qt3X5FFn0BRmq5nVYZkM903z7WKb4ojhrPoMnOyEdxog2xVg>
    <xme:KPvOZ1ow5ul8Z2GVFD_8qrpRHgNNUghQxc_HYws85V7ntp0_g7CcbDC6GJrdQLJ0h
    MB-4GZTYfqC0WcegxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkvefuhffvofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpefhfeejgefhhffhveel
    teehhfffheffvdettdelgfeltefhteelveeuffetfffgjeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrfhgrsghrvgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohep
    jhgrkhhusgestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepjhgsrhgrnhguvg
    gsuhhrghestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohephigrnhestghlohhu
    ughflhgrrhgvrdgtohhmpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtoh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepth
    hhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphhfsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KPvOZ4PKy_yU_OoZFiExP1bDACfHz-av6DXax7me19r1oeqkLVnU4g>
    <xmx:KPvOZ-5XXkqglYeoxKalDzGytUgkqt51c9gws2va_ZCnhmUipZyXiA>
    <xmx:KPvOZ64I1xypGiMqNZSMlxeYShpzNC5O7TqCv71WKv1IC4RqO1jO4Q>
    <xmx:KPvOZ2iiqd44826Mb5lRgAtgDS1N0mgR17IQoEAGwKnJN_W6OwtHig>
    <xmx:KPvOZzFQkdMKHHiFXkCgD-bwdlr3ICoZWoywmmaRXpOx6VypWdYgxt9B>
Feedback-ID: i25f1493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 647751F00080; Mon, 10 Mar 2025 10:46:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 15:45:59 +0100
Message-Id: <D8CO1HBNQNKR.3TLRR5FV98POU@arthurfabre.com>
Cc: "Network Development" <netdev@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "Yan Zhai" <yan@cloudflare.com>,
 <jbrandeburg@cloudflare.com>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, <lbiancon@redhat.com>, "Arthur Fabre"
 <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 01/20] trait: limited KV store for packet
 metadata
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.17.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com> <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com> <CAADnVQ+OShaA37-=B4-GWTQQ8p4yPw3TgYLPTkbHMJLYhr48kg@mail.gmail.com> <D89ZNSJCPNUA.20V16A9FXJ54J@arthurfabre.com> <CAADnVQ+_O+kwTV-qhXqA9jc-L3w6uwn9FShG_859qx30NPkzsw@mail.gmail.com>
In-Reply-To: <CAADnVQ+_O+kwTV-qhXqA9jc-L3w6uwn9FShG_859qx30NPkzsw@mail.gmail.com>

On Fri Mar 7, 2025 at 6:29 PM CET, Alexei Starovoitov wrote:
> On Fri, Mar 7, 2025 at 3:14=E2=80=AFAM Arthur Fabre <arthur@arthurfabre.c=
om> wrote:
> >
> > On Fri Mar 7, 2025 at 7:36 AM CET, Alexei Starovoitov wrote:
> > > On Wed, Mar 5, 2025 at 6:33=E2=80=AFAM <arthur@arthurfabre.com> wrote=
:
> > > >
> > > > +struct __trait_hdr {
> > > > +       /* Values are stored ordered by key, immediately after the =
header.
> > > > +        *
> > > > +        * The size of each value set is stored in the header as tw=
o bits:
> > > > +        *  - 00: Not set.
> > > > +        *  - 01: 2 bytes.
> > > > +        *  - 10: 4 bytes.
> > > > +        *  - 11: 8 bytes.
> > >
> > > ...
> > >
> > > > +        *  - hweight(low) + hweight(high)<<1 is offset.
> > >
> > > the comment doesn't match the code
> > >
> > > > +        */
> > > > +       u64 high;
> > > > +       u64 low;
> > >
> > > ...
> > >
> > > > +static __always_inline int __trait_total_length(struct __trait_hdr=
 h)
> > > > +{
> > > > +       return (hweight64(h.low) << 1) + (hweight64(h.high) << 2)
> > > > +               // For size 8, we only get 4+2=3D6. Add another 2 i=
n.
> > > > +               + (hweight64(h.high & h.low) << 1);
> > > > +}
> > >
> > > This is really cool idea, but 2 byte size doesn't feel that useful.
> > > How about:
> > > - 00: Not set.
> > > - 01: 4 bytes.
> > > - 10: 8 bytes.
> > > - 11: 16 bytes.
> > >
> > > 4 byte may be useful for ipv4, 16 for ipv6, and 8 is just a good numb=
er.
> > > And compute the same way with 3 popcount with extra +1 to shifts.
> >
> > I chose the sizes arbitrarily, happy to change them.
> >
> > 16 is also useful for UUIDs, for tracing.
> >
> > Size 0 could store bools / flags. Keys could be set without a value,
> > and users could check if the key is set or not.
> > That replaces single bits of the mark today, for example a
> > "route locally" key.
>
> I don't understand how that would work.
> If I'm reading the code correctly 00 means that key is not present.
> How one would differentiate key present/not with zero size in value?

It isn't implemented right now, 0 could just be one of the three sizes.
Eg:

- 00: key not set
- 01: key set, no value
- 10: key set, 4 bytes
- 11: key set, 16 bytes

We wouldn't popcnt the low bit, just the high bit, and high & low.

>
> >
> > That only leaves one other size, maybe 4 for smaller values?
> >
> > If we want more sizes, we could also:
> >
> > - Add another u64 word to the header, so we have 3 bits per key. It
> >   uses more room, and we need more popcnts, but most modern x86 CPUs ca=
n
> >   do 3 popcnts in parallel so it could be ok.
>
> Two u64s already need 3 pop counts, so it's a good compromise as-is.
>
> > - Let users set consecutive keys to one big value. Instead of supportin=
g
> >   size 16, we let them set two 8 byte KVs in one trait_set() call and
> >   provide a 16 byte value. Eg:
> >
> >         trait_set_batch(u64 key_from, u64_key_to, size, ...);
> >
> >   It's easy to implement, but it makes the API more complicated.
>
> I don't think it complicates the api.
> With max size 16 the user can put two consecutive keys of, say, 16 and 8
> to make 24 bytes of info,
> or use 4 keys of 16 byte each to form 64-bytes of info.
> The bit manipulations are too tricky for compilers to optimize.
> So even with full inlining the two trait_set() of consecutive keys
> will still be largely separate blobs of code.
> So trait_[gs]et_batch() makes sense to me.

Ok! I'll respin this with a batch API too.

>
> Also let's not over focus on networking use cases.
> This mini KV will be useful in all bpf maps including local storage.
> For example the user process can add information about itself into
> task local storage while sched-ext can use that to make scheduling decisi=
ons.

Good point, we've been focusing on networking only. Are you thinking
of the value sizes, or is there something else that would help for other
use cases?

