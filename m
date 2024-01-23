Return-Path: <bpf+bounces-20128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C074E839B41
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81911C20D83
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6AE3A8C1;
	Tue, 23 Jan 2024 21:39:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149C3FB0F
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045994; cv=none; b=Kdk6vbpW96ac7lI3zT1mH762lbVtqf8ZHyAJjbz0LmrWqdQl2hoBaPFr+XD8bXKMvqca2gwZIg6aeGX6/U08j9Ku/phc7l5in9O8aPKyBrWce3nue9F3q8qRectIwUiW7Y8jGYHmGWarZKyO1Tx0Phr3GPAXsgkuwleTY0hIouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045994; c=relaxed/simple;
	bh=8i+5r8Mip2v+5tX7mXvgrvcu9LDVLdvZ9ZiBlK7YuLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo7oj5CqYitf41K2D0S2d/3Xi1LrLk3T/idDnRq56lbVJBSAW8yXfR90iwQ/nZbMSB+OkfbfPcynEJiOgm179EKryE8UZgc9rit+2ZMwenSE5IZoL3Ez37/lQZ8pSffAzLMdzGOWy2rTXG83MomCJsDEcRd4NH9vQUsZvKT+zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429bec01aa9so44136911cf.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045991; x=1706650791;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7m7Ww8d39wI3CHdff1mrU0U07u4CcC+sMUOKEwLLRc=;
        b=Apg3gbpblXvTK9IwUp0bepu1XIIsHVY3Ktk7xe+N6X5ssusadU75WD9IlJBPFRFzUi
         qLT1WnJuB4j3YDRGpWQ0xuiji7bWzyEVA12t18Y3eAtw1tKnpmP6w5wwkzmA8GCZKnKf
         tQY/TjUHBARzD79oKozELif6/QhNBC7WuZtD9SudqvulHeajCfzJ0xzC6o2HVpvA7GVS
         20RMvIjiEQ/ZPChbZgNsPBB7IpEbnJZmde54X+J+Lo5o6j9ChyoLEEHkHASSjsA1IakP
         ANwtQVBdET+OcJwxP4RIjalLyaYsWNNxqiOPc1Ah+FPI9X72sRJDkXyFnnmqB6IjHXy6
         Lnsw==
X-Gm-Message-State: AOJu0Yx0vlTZEhURgS9/GcyErmnrSO/ZhqFY6k/e7uzzOx1ZznRJVcep
	5ZY43QXeCA/VJTqGVxFFHJU26SxzK0OjIrvTuGRSO96Qhqc3nnHm
X-Google-Smtp-Source: AGHT+IFcuDnuQKZ7LbM7w2rwcuEvoL12+XwKD7R1qUhwRcDCGeX+FAqBaPM4Ht2idmpsJT24yxg6Mw==
X-Received: by 2002:a05:6214:27c9:b0:681:99e3:ea65 with SMTP id ge9-20020a05621427c900b0068199e3ea65mr330190qvb.53.1706045991457;
        Tue, 23 Jan 2024 13:39:51 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id y8-20020ad445a8000000b00685191beaa9sm3825612qvu.3.2024.01.23.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:39:50 -0800 (PST)
Date: Tue, 23 Jan 2024 15:39:48 -0600
From: David Vernet <void@manifault.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
	bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	david.faust@oracle.com
Subject: Re: [Bpf] BPF ISA conformance groups
Message-ID: <20240123213948.GA221862@maniforge>
References: <20231214174437.GA2853@maniforge>
 <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org>
 <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 <874jfm68ok.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UcdM0TBuMakHB0GL"
Content-Disposition: inline
In-Reply-To: <874jfm68ok.fsf@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--UcdM0TBuMakHB0GL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 12:35:39PM +0100, Jose E. Marchesi wrote:
>=20
> > On Mon, Jan 8, 2024 at 8:00=E2=80=AFAM Christoph Hellwig <hch@infradead=
=2Eorg> wrote:
> >>
> >> On Fri, Jan 05, 2024 at 04:07:11PM -0600, David Vernet wrote:
> >> >
> >> > So how do we want to move forward here? It sounds like we're leaning
> >> > toward's Alexei's proposal of having:
> >> >
> >> > - Base Integer Instruction Set, 32-bit
> >> > - Base Integer Instruction Set, 64-bit
> >> > - Integer Multiplication and Division
> >> > - Atomic Instructions
> >>
> >> As in the 64-bit integer set would be an add-on to the first one which
> >> is the core set?  In that case that's fine with me, but the above
> >> wording is a bit suboptimal.
> >
> > yes.
> > Here is how I was thinking about the grouping:
> > 32-bit set: all 32-bit instructions those with BPF_ALU and BPF_JMP32
> > and load/store.
> >
> > 64-bit set: above plus BPF_ALU64 and BPF_JMP.
> >
> > The idea is to allow for clean 32-bit HW offloads.
> > We can introduce a compiler flag that will only use such instructions
> > and will error when 64-bit math is needed.
> > Details need to be thought through, of course.
> > Right now I'm not sure whether we need to reduce sizeof(void*) to 4
> > in such a case or normal 8 will still work, but from ISA perspective
> > everything is ready. 32-bit subregisters fit well.
> > The compiler work plus additional verifier smartness is needed,
> > but the end result should be very nice.
> > Offload of bpf programs into 32-bit embedded devices will be possible.
>=20
> This is very interesting.
>=20
> Sounds like, on one hand, introducing ilp32 and lp64 C data models for
> BPF:
>=20
> ilp32
>=20
>   int, long, pointers -> 32 bit
>   short -> 16 bit
>   char -> 8 bit
>=20
> lp64
>=20
>   long, pointers -> 64 bit
>   int -> 32 bit
>   short -> 16 bit
>   char -> 8 bit
>=20
> On the other hand, compiler flags -m32 and -m64 could determine what
> instruction groups are generated and what C data model is used:
>=20
> -m32
>=20
>   Use ilp32 data model for C.
>   Use 32-bit instruction set.
>=20
> -m64
>=20
>   Use lp64 data model for C.
>   Use both 32-bit (if/when alu32) and 64-bit instruction sets.

This all seems reasonable to me.

> And perhaps introducing a bit in the ELF flags section identifying a
> 32-bit binary.  Something like EF_BPF_32.
>=20
> Would 64-bit ELF be used also in cases where BPF is offloaded to 32-bit
> devices?

I expect it would be preferable to not use ELF-64 here, but I also don't
think this is necessarily something we need to figure out now. Hopefully
this is all stuff we can iron out once we start to really sink our teeth
into the ABI doc.

--UcdM0TBuMakHB0GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAyJAAKCRBZ5LhpZcTz
ZBNpAP9G/9AKTDgYt3KyV1rGCirSxYUl7wMaYg9CUhEcIMHLJAD/fMQVKNIp7T4p
yU2w2oKx6jwggm5v6BH9D9pYhHvv6Ac=
=Ng4w
-----END PGP SIGNATURE-----

--UcdM0TBuMakHB0GL--

