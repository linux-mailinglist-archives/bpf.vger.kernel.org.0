Return-Path: <bpf+bounces-20458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16B83EB47
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 06:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B141D1C22319
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A21401F;
	Sat, 27 Jan 2024 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NAsjYOtK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="RxnfY7qP"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51211CBB
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706333392; cv=none; b=G7OxtYnaGbxCaLKIdBdtAu0BbUS0X43ImwnXLzr9bXhfS4gCqToQTY+eWQj8kvVVMcRscC9GkjhX6caIMcwDQViJtAPnjsEOmusDs3byCRs6Gg+WoYG+ryj2OYTnBEIOJQ8AyZ27Ve2+ZgDU55zfV5T+7PF3DeAM3jkDVT+am5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706333392; c=relaxed/simple;
	bh=bdiV7jl1rksXughcZKTGLIaELi1iBQ2FD/RfXgL5SuA=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=gIevSxWGIYLjZnukCp09ZZC3s2RP8ikaYVBoDEvGz/fBW0uuejcUB+zqJnAbNx1O6raMhjZCIAzsyMKyN/zLoAMr+Ev67y/sD9wCmCc5kw/Idm1SO3/ToviXkW6ruVLx3O+t+J6hTMvlKJnMDj7fZT0QOtR9qEh4zAk6sPd1SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NAsjYOtK; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=RxnfY7qP; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 09B63C18DB91
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 21:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706333390; bh=bdiV7jl1rksXughcZKTGLIaELi1iBQ2FD/RfXgL5SuA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=NAsjYOtKOCu/5vTw4GX3ZEfLJ0R5kYVI/0GyKYF/RD8DISGVWge4YDTF4OMnltqXp
	 ZQI9opQhzSYfQ2tOBhkipN9BPIP64du39ktiAO1GFNnP7KzthdqfvNdAyiVqfXYyFU
	 XKso10PeLY9KZomf/lVsLrbQXJr6+QbSai1JDGFQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Jan 26 21:29:49 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B743BC17C89D;
	Fri, 26 Jan 2024 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706333389; bh=bdiV7jl1rksXughcZKTGLIaELi1iBQ2FD/RfXgL5SuA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=RxnfY7qPmUXY8dF0821QGXyHIyisyqJF7HmcV9mgMR+3xVmfk14xF8pRbZGfxr0sA
	 nhod8euyyjK7Y5Set9gmY0+WjivNkD7y+v/Id+oexWLWcis/Of0k3jcgikWK/S1fk6
	 C3+h4xEFVkDVm9dtKEc/LOhWL/INDLp0UEvcElpU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 32BA0C17C89D
 for <bpf@ietfa.amsl.com>; Fri, 26 Jan 2024 21:29:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w22SF-b9tc3Z for <bpf@ietfa.amsl.com>;
 Fri, 26 Jan 2024 21:29:44 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id DC6AEC16A126
 for <bpf@ietf.org>; Fri, 26 Jan 2024 21:29:44 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-683cabd96ceso7522506d6.3
 for <bpf@ietf.org>; Fri, 26 Jan 2024 21:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706333384; x=1706938184;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+VCFkUCqirmE8gfHkK/NEL0ng3+N7UaUQ/1dKzpw2IE=;
 b=OZOxaz/BNlfimaluuNF2VbpyvGq5pXt4jrTciWWL2poddZgIZvZr9YcHZq7XnrxcNF
 4vJKfv84uTB3ktHUUvmGgDZAmj8F++WiLqM0q8RcQQ2guxuuzcaOC4/RDLbXdTMd96lN
 XJEfknX+/aEflJ/wOTLvA54ausmAvCokrR6gBW/XdWKhDMxKo8deJdVocyHamTsxX1bg
 v51pVsTHnHSNpxpHw9McXjTu7C68Q+8CJWGwSCD0MHaLkSeHnYnQO5fRPBKa/453FZuq
 YrULwtIJV5CBIW85iXdmSZeCZ5MXa0YhVO8qdPTcgqcqGS1nKaAmchCnSVPpLzbjDBN1
 7IKg==
X-Gm-Message-State: AOJu0YxkwzsEEiy4vhq79SnLqhECq1HjKnCEy0O5V5QBXa9TAvE2HmvL
 r/p3/hVC3g0qUl5tRMhuHCIq5mftSby8is0S23YU7gqIMiPaaFzN
X-Google-Smtp-Source: AGHT+IHLh277QTPMCtk4ZgUeHQc5n5vYt0o3Ky4Pkvc5GR3HwoU/2OvVslZsYKHT9HAgTInuEA3f0w==
X-Received: by 2002:a05:620a:4609:b0:783:9079:93a6 with SMTP id
 br9-20020a05620a460900b00783907993a6mr1247537qkb.4.1706333383785; 
 Fri, 26 Jan 2024 21:29:43 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a05620a023a00b0078353332599sm1166351qkm.21.2024.01.26.21.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 21:29:43 -0800 (PST)
Date: Fri, 26 Jan 2024 23:29:39 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Message-ID: <20240127052939.GA31099@maniforge>
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
 <20240123215214.GC221862@maniforge>
 <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/lEznI78kPfKRV9Y4UCaVdcB3nJE>
Subject: Re: [Bpf] Standardizing BPF assembly language?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8782146101698066375=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8782146101698066375==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ytvqyf7RainnNXoI"
Content-Disposition: inline


--ytvqyf7RainnNXoI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 06:51:16PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 23, 2024 at 1:52=E2=80=AFPM David Vernet <void@manifault.com>=
 wrote:
> > > > > A second question would be, which dialect(s) to standardize.  Jos=
e's
> > > > > link above argues that the second dialect should be the one
> > > > > standardized (tools are free to support multiple dialects for
> > > > > backwards compat if they want).  See the link for rationale.
> > > >
> > > > My recollection was that the outcome of that discussion is that we =
were
> > > going
> > > > to continue to support both. If we wanted to standardize, I have a =
hard
> > > time
> > > > seeing any other way other than to standardize both dialects unless
> > > there's
> > > > been a significant change in sentiment since LSFMM.
> > >
> > > If "standardize both", does that mean neither is mandatory and each t=
ool
> > > is free to pick one or the other?  And would the IANA registry requir=
e a
> > > document
> > > adding any new instructions to specify the assembly in both dialects?
> >
> > Well, if we're standardizing on both, then yes I think it would be
> > mandatory for a tool to support both, and I think instructions would
> > require assembly for both dialects.
>=20
> I think it's obvious that there is no way we will add gcc's flavor
> of asm to kernel and llvm.

Well, it will depend on how widely it's used. Or if it's used widely :-)

> > Practically speaking that's already
> > what's happening, no? Both dialects are already pervasive,
>=20
> They are not. There are thousands of lines of asm written in pseudo-c
> used in production applications and probably only ubpf/tests and gcc/tests
> in that other asm, since gcc bpf support is not yet in the released gcc v=
ersion.
>=20
> There is also this asm flavor:
> https://github.com/Xilinx-CNS/ebpf_asm
>=20
> Which is different from pseudo-c and ubpf asm.
>=20
> I don't think asm syntax should be an IETF draft.

Ok, fair enough. Another thought that occurred to me after thinking
about this more -- even if we want source code compatibility (which is
still an open question), that doesn't necessarily imply or require
assembly dialect compatibility. Let's table this for now, and revisit
another day, should we ever find that it makes sense to do so.

Thanks,
David

--ytvqyf7RainnNXoI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbSUwwAKCRBZ5LhpZcTz
ZAQ3AP9ZTZAyVhF8bpmqquUV+p+3kvzMtuHgnFb5Og1HUh71HwD/cCuIb0jeVWNV
hj3wDsvyC93w6rz2Gx6DN1JvVIDzKQk=
=w4PK
-----END PGP SIGNATURE-----

--ytvqyf7RainnNXoI--


--===============8782146101698066375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8782146101698066375==--


