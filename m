Return-Path: <bpf+bounces-53741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF53A59A66
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221CB1888A60
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F522DF82;
	Mon, 10 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="kKLJRbVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hlnpnwaz"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CC22069E;
	Mon, 10 Mar 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621954; cv=none; b=TqC3gjtFLaQ8FRgcoF49ObDmKUYx8pFw5kGXzLgTUnKAnDI8r+uQSRWlr+gEGVfA6gYO8qZlQbl8f6cdAiZaMMYUrNW5Svyz2jbd3eX/OK5w5hKUSXRcs2N+sjRrG4n55419VNJMhsZQE5puoXubuUy7Y0fv0KyvkGsgO15EOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621954; c=relaxed/simple;
	bh=LLBgJHAWcK8fXF+7yKP/eBHoQ+O33J7NZF81s0WDjWY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KVgwcPkbGsvd1Ijstq1p7zzhsw7dk3bpWuBENCvz9UGtQf1jRg1PcRsg6dnYct5NhfZhJ9N73XyPLDmiXvdFD601rlPcwarcYK3j/e9sMr4Ss/jtcYbIQfUYrKE3W4nydmB+bpXQqll6UPZ2ovezdKpYJV4MuAFHWilV7PgKSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=kKLJRbVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hlnpnwaz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A529C1382D57;
	Mon, 10 Mar 2025 11:52:31 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 11:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741621951; x=1741708351; bh=qImRhIDqJuLJMiTBNz81AyZHV8Om9bqb
	nVSAsfrFHfs=; b=kKLJRbVI8zYE4w9sNgjwsGAtkR+Cz17jZoEkm8scnNSptGjx
	d480YFfIw/4Imf/pfyVP0nooVqtoaPuxoETohoghVh4EBG0zA2vk0U763TT1ot3P
	38ASoNdkVksHZfHAuPKfMUH1FHT4yfmvrrMYIBJ4f5rlp81abad0kH7/jrax1We4
	AoN47lZOs3rbP/KJdI9VgB9MgH2m6BtTNAG22HLL0PtUPsha9sd91zyDhd9AoT5a
	yBaGItACTv5UYFHTDn85qiUds43/gpCaGUX9pBaZuLvzkobIPjYqs9kS0WxOtN/m
	W93w7/ETrAvt8iAhfk0kybKL4Nl0G3CRo/yb9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741621951; x=
	1741708351; bh=qImRhIDqJuLJMiTBNz81AyZHV8Om9bqbnVSAsfrFHfs=; b=H
	lnpnwazEqaTWrLJP3HcFLnQvJ1PdlX+vxiwHN+7gi9DG1rAhttVtzTaZiXBJhyyX
	tXMp/rvIuMICHBQIZ33IBY02dboBJH+6p+TZsKYoYd0Pv0U5KJAoWqs3yjHu6wyh
	kZI0yYTmJpgqTliCfSMKV7P8Q6Y2j3Hy9IjHkDjioLCpuxPaIQk391c0vRYAMALH
	B4JYOUN+61k0TpFoS4kB1C0b5jBaTT09p0rewSgcWZds4UYe81Req0EkCmAAxh1h
	79zLsLxxX86oAHVeVuCmQ5DhUIwh3YHzvw6ifaGsAlQyNszTfslCAjs38QXTXeob
	+zeEtyYk2AOxbc2P1FpSA==
X-ME-Sender: <xms:vwrPZxQr2vr30Frr3Y0Mw5Din0YVhOlGr2Dg9MzqbpTs9ZiFxlDa1w>
    <xme:vwrPZ6xr_ifFxQAPhCXlAxW9gPhS7vj7JbAuhD_bE8oGExB72wVst97oGvEG_np44
    _ls_XBF4xcYsdRoQVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeehucetufdoteggodetrf
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
    ughflhgrrhgvrdgtohhmpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhho
    rhgvnhiiohdrsghirghntghonhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehthh
    hoihhlrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vwrPZ224AP5AS0tzHfSRE4PT2auaAxHWZBzgv2VwXajSrbWfh4LqrQ>
    <xmx:vwrPZ5DgX5u-vaH0Zy07th8iENDYRtFI1HnFi1jGPUGJV-rK132rFw>
    <xmx:vwrPZ6jBl2y2gChgVJNnmzBbfqmRMawGaIBEmfTSRjYukrNGzjQJPw>
    <xmx:vwrPZ9oAYUxleEM3EBJVHSWO58tjLkZQL4c66sXcytjBVmRqb4AvRQ>
    <xmx:vwrPZ1NFbhHwDImxarrfY4FFZlZhpdM2tVK0VxWdrVwIVqFd-W0q3ZTG>
Feedback-ID: i25f1493c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5BDC51F00080; Mon, 10 Mar 2025 11:52:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 16:52:30 +0100
Message-Id: <D8CPGEGQ4630.2MKAQH44PFCCO@arthurfabre.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <jakub@cloudflare.com>,
 <hawk@kernel.org>, <yan@cloudflare.com>, <jbrandeburg@cloudflare.com>,
 <thoiland@redhat.com>, <lbiancon@redhat.com>, "Arthur Fabre"
 <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 05/20] trait: Replace memcpy calls with
 inline copies
From: "Arthur Fabre" <arthur@arthurfabre.com>
To: "Lorenzo Bianconi" <lorenzo.bianconi@redhat.com>
X-Mailer: aerc 0.17.0
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com> <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com> <Z87D9GblwWBZjwE-@lore-desk>
In-Reply-To: <Z87D9GblwWBZjwE-@lore-desk>

On Mon Mar 10, 2025 at 11:50 AM CET, Lorenzo Bianconi wrote:
> > From: Arthur Fabre <afabre@cloudflare.com>
> >=20
> > When copying trait values to or from the caller, the size isn't a
> > constant so memcpy() ends up being a function call.
> >=20
> > Replace it with an inline implementation that only handles the sizes we
> > support.
> >=20
> > We store values "packed", so they won't necessarily be 4 or 8 byte
> > aligned.
> >=20
> > Setting and getting traits is roughly ~40% faster.
>
> Nice! I guess in a formal series this patch can be squashed with patch 1/=
20
> (adding some comments).

Happy to squash and add comments instead if that's better :)

>
> Regards,
> Lorenzo
>
> >=20
> > Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> > ---
> >  include/net/trait.h | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/net/trait.h b/include/net/trait.h
> > index 536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a..d4581a877bd57a32e2ad032=
147c906764d6d37f8 100644
> > --- a/include/net/trait.h
> > +++ b/include/net/trait.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/string.h>
> >  #include <linux/bitops.h>
> > +#include <linux/unaligned.h>
> > =20
> >  /* Traits are a very limited KV store, with:
> >   * - 64 keys (0-63).
> > @@ -145,23 +146,23 @@ int trait_set(void *traits, void *hard_end, u64 k=
ey, const void *val, u64 len, u
> >  			memmove(traits + off + len, traits + off, traits_size(traits) - off=
);
> >  	}
> > =20
> > -	/* Set our value. */
> > -	memcpy(traits + off, val, len);
> > -
> > -	/* Store our length in header. */
> >  	u64 encode_len =3D 0;
> > -
> >  	switch (len) {
> >  	case 2:
> > +		/* Values are least two bytes, so they'll be two byte aligned */
> > +		*(u16 *)(traits + off) =3D *(u16 *)val;
> >  		encode_len =3D 1;
> >  		break;
> >  	case 4:
> > +		put_unaligned(*(u32 *)val, (u32 *)(traits + off));
> >  		encode_len =3D 2;
> >  		break;
> >  	case 8:
> > +		put_unaligned(*(u64 *)val, (u64 *)(traits + off));
> >  		encode_len =3D 3;
> >  		break;
> >  	}
> > +
> >  	h->high |=3D (encode_len >> 1) << key;
> >  	h->low |=3D (encode_len & 1) << key;
> >  	return 0;
> > @@ -201,7 +202,19 @@ int trait_get(void *traits, u64 key, void *val, u6=
4 val_len)
> >  	if (real_len > val_len)
> >  		return -ENOSPC;
> > =20
> > -	memcpy(val, traits + off, real_len);
> > +	switch (real_len) {
> > +	case 2:
> > +		/* Values are least two bytes, so they'll be two byte aligned */
> > +		*(u16 *)val =3D *(u16 *)(traits + off);
> > +		break;
> > +	case 4:
> > +		*(u32 *)val =3D get_unaligned((u32 *)(traits + off));
> > +		break;
> > +	case 8:
> > +		*(u64 *)val =3D get_unaligned((u64 *)(traits + off));
> > +		break;
> > +	}
> > +
> >  	return real_len;
> >  }
> > =20
> >=20
> > --=20
> > 2.43.0
> >=20
> >=20


