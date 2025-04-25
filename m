Return-Path: <bpf+bounces-56720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D52A9D184
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58BF1C00ED1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 19:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D180E21ADA6;
	Fri, 25 Apr 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="d00b44Bf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiBiVfJC"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256712D78A;
	Fri, 25 Apr 2025 19:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609226; cv=none; b=T729V4m4k+Rcvyc55Tg/FQ5L+Rgu/EVgXjtmn0BCq85TylT+BZuxo0HBoXGBxE2uc7MMDFj+Rn/PqeXzr1GNhJfFGLVSVNQ3egvqbo/aV0yGMm5nMoFL1RiS0gsSZOqTEksttro4VmQBTkxrabfBAZiujgfleL9l+86vt5sCvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609226; c=relaxed/simple;
	bh=RvD5mC4sHD3jGSm/9Cbrj96ZlAKNLWHG1osWOR3rIO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hFaD41ZukTL/SbcwU5oyNKLuqT/BZ7Z/+WhDN720nXOqwFCuR1icKAlQ5QtV+AeCEajYJcDX1LGE1YlmmsZKOvDLaaJk3SPF4YX2QxSZOEO4EAUyME0r9rW/AJaPyhXuJ6wGVxXuHYDTyMrt9A3N/zaPql++Ovt7VySk787MtbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=d00b44Bf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiBiVfJC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A453811401A5;
	Fri, 25 Apr 2025 15:27:00 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 15:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745609220; x=1745695620; bh=zQLMxe8QsqJK1fYcw7ILxK9codnxO47h
	QzxDx+TrHqA=; b=d00b44BfliSIETbJKugb6MlG3MAOWeFHi2Yl6Aymgr1v5H2l
	l9ID6PkyrHgxJ9VmvkKgcL5auW5SGKV7RTZ7+gp0bQFtjamjFvFzpTkKiDvstswW
	oWTBt0fUduLwM2EAGOdX47Ems8iYnpR8iuOyhZsyHCokkV1Ef7QHEjhE8zRXtw07
	GWYX5VvfcDB9chyeStmR0von84KC3HGklf7MhSe9SoZgsFrRjI5VT6tkMxAeSTpu
	cOYfCndpMatp20ag1vStkvC07Tjac+AqPdRsP5VYkCsaRqqDJERwAoKcHKY+jfCA
	K6ZJrIVV/Wbq1TxwRV6dtyOO4w7wEUYZxDfIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745609220; x=
	1745695620; bh=zQLMxe8QsqJK1fYcw7ILxK9codnxO47hQzxDx+TrHqA=; b=A
	iBiVfJC1hOq3PO4sHUvypNjjP7dnBZM0JWlh98Elm7ZbCIHKM+yi/tj7AiywtPuk
	U0j6HGc0XDp47XHwSwfu+80Fb81taYnvTxrf5kPxpp1tcjUfOA8NNOGiuHa23nSI
	U7LVf9vYXMINyBkHaTOgRxVAJ0gtQHtHVLEBWOnixwYniYW5OXGnBNBxjBNOuZ3Y
	O+t61RDIGxXNlJ/fUoB/FsdquLMxiqWFu1hoTG0gPzgQ3rrYsXiD74dANjzgTep7
	jGL2d6BikqT/XEZHy/ysn35Wd6MUu1yH4hTiL5roVWPyXEjhp31XWo9d3pHtrsq9
	RIxTIvHej/zAJXsYbdGOA==
X-ME-Sender: <xms:BOILaKjnItOguChcis_NH9sdjmjG0IRPJbLAoZKZ8w5Meo4tPaR2IA>
    <xme:BOILaLCu08h-rpAfHvIqIAi7-J9akmLvnWWpeeZvKnCR6r9OuBhqr5jFFU34kq8Tj
    ZrF1js8KaN0uw7mzdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofgggfgtfffkuffhvfevofhfjgesthhqredt
    redtjeenucfhrhhomhepfdetrhhthhhurhcuhfgrsghrvgdfuceorghrthhhuhhrsegrrh
    hthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtthgvrhhnpeejfeeiudeijeehtddt
    leejffetudeuvddvvdeludfhvddtgeefgefhtedtheelueenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgr
    sghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehj
    sghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopeihrg
    hnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegrlhgvgigvihdrshhtrghr
    ohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhgsihgrnhgtohhnsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:BOILaCHZs1KaiUO3lVvxpyfnWLUhv5MQXtbYEd5k9YQALBibOW6tVA>
    <xmx:BOILaDSF9tik_O7EoX3nszlksHE-Tc9kYLHHBEezsd74YTAHTuZd3A>
    <xmx:BOILaHwz1_wmmJvpJqUzlTVmu1GtSGx7EskFPVZtOv3s2e3SttxdFQ>
    <xmx:BOILaB7wGH--88AN6G63iVtBoHVIJPDrNX9fuX0SFwyqm1MYyMdTxg>
    <xmx:BOILaAu3LAg4pUoQmMzsIRdPwlN1pQ8DXahEMVjwLtZPHSG3MmjUFTiM>
Feedback-ID: i9179493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 140D21F00073; Fri, 25 Apr 2025 15:27:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 21:26:59 +0200
Message-Id: <D9FYTORERFI7.36F4WG8G3NHGX@arthurfabre.com>
Subject: Re: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for
 packet metadata
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Network Development" <netdev@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "Yan Zhai" <yan@cloudflare.com>,
 <jbrandeburg@cloudflare.com>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, <lbiancon@redhat.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Eric Dumazet"
 <edumazet@google.com>
X-Mailer: aerc 0.17.0
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com> <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com> <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>
In-Reply-To: <CAADnVQJeCC5j4_ss2+G2zjMbAcn=G3JLeAJCBZRC8uzfsVAjMA@mail.gmail.com>

On Thu Apr 24, 2025 at 6:22 PM CEST, Alexei Starovoitov wrote:
> On Tue, Apr 22, 2025 at 6:23=E2=80=AFAM Arthur Fabre <arthur@arthurfabre.=
com> wrote:
> >
> > +/**
> > + * trait_set() - Set a trait key.
> > + * @traits: Start of trait store area.
> > + * @hard_end: Hard limit the trait store can currently grow up against=
.
> > + * @key: The key to set.
> > + * @val: The value to set.
> > + * @len: The length of the value.
> > + * @flags: Unused for now. Should be 0.
> > + *
> > + * Return:
> > + * * %0       - Success.
> > + * * %-EINVAL - Key or length invalid.
> > + * * %-EBUSY  - Key previously set with different length.
> > + * * %-ENOSPC - Not enough room left to store value.
> > + */
> > +static __always_inline
> > +int trait_set(void *traits, void *hard_end, u64 key, const void *val, =
u64 len, u64 flags)
> > +{
> > +       if (!__trait_valid_key(key) || !__trait_valid_len(len))
> > +               return -EINVAL;
> > +
> > +       struct __trait_hdr *h =3D (struct __trait_hdr *)traits;
> > +
> > +       /* Offset of value of this key. */
> > +       int off =3D __trait_offset(*h, key);
> > +
> > +       if ((h->high & (1ull << key)) || (h->low & (1ull << key))) {
> > +               /* Key is already set, but with a different length */
> > +               if (__trait_total_length(__trait_and(*h, (1ull << key))=
) !=3D len)
> > +                       return -EBUSY;
> > +       } else {
> > +               /* Figure out if we have enough room left: total length=
 of everything now. */
> > +               if (traits + sizeof(struct __trait_hdr) + __trait_total=
_length(*h) + len > hard_end)
> > +                       return -ENOSPC;
>
> I'm still not excited about having two metadata-s
> in front of the packet.
> Why cannot traits use the same metadata space ?
>
> For trait_set() you already pass hard_end and have to check it
> at run-time.
> If you add the same hard_end to trait_get/del the kfuncs will deal
> with possible corruption of metadata by the program.
> Transition from xdp to skb will be automatic. The code won't care that tr=
aits
> are there. It will just copy all metadata from xdp to skb. Corrupted or n=
ot.
> bpf progs in xdp and skb might even use the same kfuncs
> (or two different sets if the verifier is not smart enough right now).

Good idea, that would solve the corruption problem.

But I think storing metadata at the "end" of the headroom (ie where=20
XDP metadata is today) makes it harder to persist in the SKB layer.
Functions like __skb_push() assume that skb_headroom() bytes are
available just before skb->data.

They can be updated to move XDP metadata out of the way, but this
assumption seems pretty pervasive.

By using the "front" of the headroom, we can hide that from the rest of
the SKB code. We could even update skb->head to completely hide the
space used at the front of the headroom.
It also avoids the cost of moving the metadata around (but maybe that
would be insignificant).

XDP metadata also doesn't work well with GRO (see below).

> Ideally we add hweight64 as new bpf instructions then maybe
> we won't need any kernel changes at all.
> bpf side will do:
> bpf_xdp_adjust_meta(xdp, -max_offset_for_largest_key);
> and then
> trait_set(xdp->data_meta /* pointer to trait header */, xdp->data /*
> hard end */, ...);
> can be implemented as bpf prog.
>
> Same thing for skb progs.
> netfilter/iptable can use another bpf prog to make decisions.

There are (at least) two reasons for wanting the kernel to understand the
format:

* GRO: With an opaque binary blob, the kernel can either forbid GRO when
  the metadata differs (like XDP metadata today), or keep the entire blob
  of one of the packets.
  But maybe some users will want to keep a KV of the first packet, or
  the last packet, eg for receive timestamps.
  With a KV store we can have a sane default option for merging the
  different KV stores, and even add a per KV policy in the future if
  needed.

* Hardware metadata: metadata exposed from NICs (like the receive
  timestamp, 4 tuple hash...) is currently only exposed to XDP programs
  (via kfuncs).
  But that doesn't expose them to the rest of the stack.
  Storing them in traits would allow XDP, other BPF programs, and the
  kernel to access and modify them (for example to into account
  decapsulating a packet).

