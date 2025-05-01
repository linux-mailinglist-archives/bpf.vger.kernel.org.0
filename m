Return-Path: <bpf+bounces-57113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAFAA5B6F
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 09:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C559849C8
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EF25B1C2;
	Thu,  1 May 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="GDmScT7O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNSPIhTM"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E71C6FE0;
	Thu,  1 May 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746084642; cv=none; b=dhn/zrccCP3IOey2Rj0A3fJwawIuHT4GE8FWT6QF4x4qvtmtpAxaMi4Gvl7UNVQU8V50weoAZvCHRHx6wnjPGxDoe2lWbuT4q8EbB328YKW71AqzCyN6Nfjk90KToOlSoCbJ66efcReJ3BPl78gWbc1eendOEjbK+8RtQ+4K108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746084642; c=relaxed/simple;
	bh=JATCi4bN6VPJRBEP1Xow3xgEpojY4PSqBhQy7Z+3DII=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=WFdJlFsFkspJQmnCFibBH2SFkEQ1E3/N4r9W1VCNgn/2ZQaJ7I5HvEiFx+bmT2o8YDuQpJD+yYNorf1m5ECRqSSxCKZKgo+st/gQs2p31aFSCGaAE9CfbIoe1xLrAFZlH7jFmcAdZuMDntr2IDM30+LkrZPhqTqGs0FksYGCIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=GDmScT7O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNSPIhTM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58CC011401A4;
	Thu,  1 May 2025 03:30:38 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 03:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1746084638; x=1746171038; bh=OxHeUEtAiswWVkXNgQtC8XLvRBJsu356
	sWD3VGaagxM=; b=GDmScT7OjycFDjF+XufZ2aOx4y1//zcUdbsyBYbTTFNZS5w4
	/tytRQRorghTM70h14jzbENxoDvS4wt7gxhK9pQhf2ajeV49wGgK39jmGpfNyPTG
	6rX3D+3je2HFCQIW+xUWBmTulGjXN08pZ6S5czWtw2Epcx8q/LP+6ENWPP15gU01
	UMoq5ZuZLdWDCXjeEuAgdviwdzNgOGuIWnBmvjS5f18Bvsp5a7IxTypFBPEF6hwd
	jGSviWCGPzg1FavwvtW03q0fBiXvSwaF3VzLzMJX74QjRiyR3ZffXwS9xCJ+R5qb
	+mz1cAjLcIMYUx/IYrHv2rIwBb3a3xzVlA0exQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746084638; x=
	1746171038; bh=OxHeUEtAiswWVkXNgQtC8XLvRBJsu356sWD3VGaagxM=; b=R
	NSPIhTMbWaTEuze+6exna8qqyl1U8rrEkAB1jubRdYRvHAq8rh9iAQUcKhfHSVZG
	jAV5Uwv/T3xN2GUx4wUYhznixzmswKZHe5WbGywiHPyJKRDcoEd1GlvoRimJzDCl
	23zzct8tfiAH8dgAV1pF9QSZedKZ+i6PMC5QWgli8t5gzK3yhCMnYYBomtat2Wom
	eBepN5NtyFHKGmKu56ui3DQy50psUlGBg28CVWrTQL2XDdFMUUq49QWCjE1YV/fR
	weNDc7sHBaPyzL4rm8MT2iiK2YJw85YSm6Oij5yViIUS1MEyk58b3oU5iNTGLZao
	2V6t1dDqCDknrjzv0yecw==
X-ME-Sender: <xms:HSMTaKqRuCmPvmoTqcFpJaeamEPxFf-edKoXANJ-hmdDSv9W5mWrvw>
    <xme:HSMTaIrdIpN5yubg2ws1CFVzoTtfHpcAJ0Y6wFP4yLYio1zML-mgLeo4nV2kvgXae
    YieBKsiimdgNpnkSjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkhffvvefuofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpeetuedtveetfeejffeg
    tddtgfekvdejgeevvdffuddvjefhhfefgfejhefhlefftdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehj
    sghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopeihrg
    hnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegrlhgvgigvihdrshhtrghr
    ohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhgsihgrnhgtohhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:HiMTaPOneteT_23pqtwWOX7lBaf8vabC1DC4GvyNvoJ5H-0WrbRZ6A>
    <xmx:HiMTaJ5ABcVKxiZVyjtLLrYjaZWc-6cHAmcTyxMxU8sk5kF096E9lA>
    <xmx:HiMTaJ47Nm0vvgIQVfK-3k0sdaqNnWzrm3dw5otTFFDpG-z9JlKn3A>
    <xmx:HiMTaJjyNbSOAWiOIb86QhthXZMwMLCrWQXiK14lLwf3rhj2Hk17UQ>
    <xmx:HiMTaCV7RGOwMSumtEUyYMVoBXOU0WPrRNb_b_zLsudjcqHNgu7_0Wu3>
Feedback-ID: i9179493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E2C821F00072; Thu,  1 May 2025 03:30:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 May 2025 09:30:36 +0200
Message-Id: <D9KNCG5YG8DF.284WM1C7ABNNX@arthurfabre.com>
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Network Development" <netdev@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "Yan Zhai" <yan@cloudflare.com>,
 <jbrandeburg@cloudflare.com>, <lbiancon@redhat.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Eric Dumazet"
 <edumazet@google.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
X-Mailer: aerc 0.17.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com> <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com> <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com> <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com> <CAADnVQKe3Jfd+pVt868P32-m2a-moP4H7ms_kdZnrYALCxx53Q@mail.gmail.com> <87frhqnh0e.fsf@toke.dk> <CAADnVQ+V3Tp1zgFb6yfZQgC8m9WhdQOZmmrAFetDb5sZNxXLQQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+V3Tp1zgFb6yfZQgC8m9WhdQOZmmrAFetDb5sZNxXLQQ@mail.gmail.com>

On Wed Apr 30, 2025 at 6:29 PM CEST, Alexei Starovoitov wrote:
> On Wed, Apr 30, 2025 at 2:19=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > On Fri, Apr 25, 2025 at 12:27=E2=80=AFPM Arthur Fabre <arthur@arthurf=
abre.com> wrote:
> > >>
> > >> On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
> > >> > On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthu=
rfabre.com> wrote:
> > >> > >
> > >> > > +/**
> > >> > > + * trait_set() - Set a trait key.
> > >> > > + * @traits: Start of trait store area.
> > >> > > + * @hard_end: Hard limit the trait store can currently grow up =
against.
> > >> > > + * @key: The key to set.
> > >> > > + * @val: The value to set.
> > >> > > + * @len: The length of the value.
> > >> > > + * @flags: Unused for now. Should be 0.
> > >> > > + *
> > >> > > + * Return:
> > >> > > + * * %0       - Success.
> > >> > > + * * %-EINVAL - Key or length invalid.
> > >> > > + * * %-EBUSY  - Key previously set with different length.
> > >> > > + * * %-ENOSPC - Not enough room left to store value.
> > >> > > + */
> > >> > > +static __always_inline
> > >> > > +int trait_set(void *traits, void *hard_end, u64 key, const void=
 *val, u64 len, u64 flags)
> > >> > > +{
> > >> > > +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
> > >> > > +               return -EINVAL;
> > >> > > +
> > >> > > +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
> > >> > > +
> > >> > > +       /* Offset of value of this key. */
> > >> > > +       int off =3D __trait_offset(*h, key);
> > >> > > +
> > >> > > +       if ((h->high & (1ull << key)) || (h->low & (1ull << key)=
)) {
> > >> > > +               /* Key is already set, but with a different leng=
th */
> > >> > > +               if (__trait_total_length(__trait_and(*h, (1ull <=
< key))) !=3D len)
> > >> > > +                       return -EBUSY;
> > >> > > +       } else {
> > >> > > +               /* Figure out if we have enough room left: total=
 length of everything now. */
> > >> > > +               if (traits + sizeof(struct __trait_hdr) + __trai=
t_total_length(*h) + len > hard_end)
> > >> > > +                       return -ENOSPC;
> > >> >
> > >> > I'm still not excited about having two metadata-s
> > >> > in front of the packet.
> > >> > Why cannot traits use the same metadata space ?
> > >> >
> > >> > For trait_set() you already pass hard_end and have to check it
> > >> > at run-time.
> > >> > If you add the same hard_end to trait_get/del the kfuncs will deal
> > >> > with possible corruption of metadata by the program.
> > >> > Transition from xdp to skb will be automatic. The code won't care =
that traits
> > >> > are there. It will just copy all metadata from xdp to skb. Corrupt=
ed or not.
> > >> > bpf progs in xdp and skb might even use the same kfuncs
> > >> > (or two different sets if the verifier is not smart enough right n=
ow).
> > >>
> > >> Good idea, that would solve the corruption problem.
> > >>
> > >> But I think storing metadata at the "end" of the headroom (ie where
> > >> XDP metadata is today) makes it harder to persist in the SKB layer.
> > >> Functions like __skb_push() assume that skb_headroom() bytes are
> > >> available just before skb->data.
> > >>
> > >> They can be updated to move XDP metadata out of the way, but this
> > >> assumption seems pretty pervasive.
> > >
> > > The same argument can be flipped.
> > > Why does the skb layer need to push?
> > > If it needs to encapsulate it will forward to tunnel device
> > > to go on the wire. At this point any kind of metadata is going
> > > to be lost on the wire. bpf prog would need to convert
> > > metadata into actual on the wire format or stash it
> > > or send to user space.
> > > I don't see a use case where skb layer would move medadata by N
> > > bytes, populate these N bytes with "???" and pass to next skb layer.
> > > skb layers strip (pop) the header when it goes from ip to tcp to user=
 space.
> > > No need to move metadata.
> > >
> > >> By using the "front" of the headroom, we can hide that from the rest=
 of
> > >> the SKB code. We could even update skb->head to completely hide the
> > >> space used at the front of the headroom.
> > >> It also avoids the cost of moving the metadata around (but maybe tha=
t
> > >> would be insignificant).
> > >
> > > That's a theory. Do you actually have skb layers pushing things
> > > while metadata is there?
> >
> > Erm, any encapsulation? UDP tunnels, wireguard, WiFi, etc. There are
> > almost 1000 calls to skb_push() all over the kernel. One of the primary
> > use cases for traits is to tag a packet with an ID to follow it
> > throughout its lifetime inside the kernel. This absolutely includes
> > encapsulation; in fact, having the tracing ID survive these kinds of
> > transformations is one of the primary motivators for this work.
>
> and the assumption here is that placing traits in the front will
> be enough for all possible encaps that the stack can do?
> Hopefully not. Moving traits due to skb_push() is mandatory anyway.

The network stack seems to assume there is at least 32 bytes of headroom
available, that's guaranteed by NET_SKB_PAD.

Callers that need more seem to check if there's enough headroom
available first, and pskb_expand_head() if not.

Placing traits at the front lets most of this work naturally if we leave
NET_SKB_PAD headroom.

But I haven't looked at every single __skb_push() call, maybe there are
cases I don't know about.

>
> The other point you're arguing is that the current metadata approach
> is broken, since it doesn't work for encap?
> pskb_expand_head() does skb_metadata_clear().
> Though I don't remember anyone complaining of that behavior,

No one can complain yet, because metadata isn't accessible after TC
today. It's limited to just XDP and TC, which avoids most of the SKB
processing and these trickier cases.

> let's assume it's a problem indeed.
> With traits in front the pskb_expand_head() should either fail or move
> traits when it runs out of room.
> Let's be consistent and do the same for regular metadata.
>
> My main point is we should not introduce a second kind of metadata.
> If the current metadata doesn't quite work, fix it instead of adding
> a new one.

I'll think about this more. It's tempting to just move the current
metadata area to the front of the headroom, but that breaks things like
AF_XDP that expect the metadata to be right before the packet data.

