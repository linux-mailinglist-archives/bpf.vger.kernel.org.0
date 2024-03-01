Return-Path: <bpf+bounces-23203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01086EB92
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F60B21B0D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357659153;
	Fri,  1 Mar 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="htlfc/rb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="htlfc/rb"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945514295
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330707; cv=none; b=ng5et+8WqjoYQJ1TCg1TLpkavfiMtjoabkvH9wt2eC0rqwMeA63jiJJu3kflMoDiToE73jlWCmCBlPjbYnit7FYs7xqoep6ZZ8aByWh+8Slm3eeA3fBWyf6NjVmqF7S4GvR/HPZ0bU4WjPnsKPaf78UU9qwn+8rXYecyiv/mnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330707; c=relaxed/simple;
	bh=SeZ2zpZcFWxppa7SrHOKaEF9qJ7s3Wi2z9N2OxzfGtI=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=UspY4vO9XN6disBCOeA9LZxkzSq9Bsih6BZcKZP9bQ5K/2Klc35fkr/Mc0KmTjUpOIug4r6UqqhnVA2V5Fysz1lDg1bg8vB4X46v7azC6cxrII4rbNOafLmZZJBG8jQr7iW6kKevHfbyS1B6W/aN+htDsnad9bvl+yCxLNACg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=htlfc/rb; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=htlfc/rb; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7B205C14F6BB
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709330705; bh=SeZ2zpZcFWxppa7SrHOKaEF9qJ7s3Wi2z9N2OxzfGtI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=htlfc/rbtUimaHfcIK/h/22i0q8msx8VfXUgWoQO3AIh+lX5WifcsFTo4mvrA8QET
	 1eJ1qVZ0igrTxRzqn2C32ssrzFk7yY0m8UjVFuRSZp+fCAq8vuqY21ADO7FgMNqDeo
	 byQZhxn0Dau6g9ufT/FrAgueNo45zFB7jsJOuPyU=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Mar  1 14:05:05 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DBAEEC14F616;
	Fri,  1 Mar 2024 14:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709330705; bh=SeZ2zpZcFWxppa7SrHOKaEF9qJ7s3Wi2z9N2OxzfGtI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=htlfc/rbtUimaHfcIK/h/22i0q8msx8VfXUgWoQO3AIh+lX5WifcsFTo4mvrA8QET
	 1eJ1qVZ0igrTxRzqn2C32ssrzFk7yY0m8UjVFuRSZp+fCAq8vuqY21ADO7FgMNqDeo
	 byQZhxn0Dau6g9ufT/FrAgueNo45zFB7jsJOuPyU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0208CC14F616
 for <bpf@ietfa.amsl.com>; Fri,  1 Mar 2024 14:05:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.409
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAi022_FNweD for <bpf@ietfa.amsl.com>;
 Fri,  1 Mar 2024 14:05:03 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7A69FC14F614
 for <bpf@ietf.org>; Fri,  1 Mar 2024 14:05:03 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-68f571be9ddso19993376d6.0
 for <bpf@ietf.org>; Fri, 01 Mar 2024 14:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709330702; x=1709935502;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSlI/TtzoUdkSg2iVSWhH6rf3DTlysvwHka0FGU92Po=;
 b=aW0SVv90pn3Ey501BxUop+xS3vYeJ6zTIvArdr+gEjtfrsHWgb8gwHGPvMKeWcTGde
 ZYeWuXJsbDmHHkdX9vNGosNz8CEOIGO/3vhZdfv3JGGqgCnvZyLOcbfHSkJs532RhNYC
 jwSchVV4bvQclSwx/rqkI+USUD/5ihzbIGXBTSVQZsIdAoH/DAYalMyzdTCIhK9I5x6s
 GRQeMaXslzuUW2DADVOaaJ9c8SZyWMTDomRQ7kKhgbqorH0Z0RMRlfI8GEoGuQhMEgPP
 nJf6iTZ/T2Uabn19IPorE9nFUs5ZBGRWvVg2GwGaoLqltlDFpAfmSA6roI0rG7qAmR3B
 kdwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz/qbVarh0bOtiW5c3IBhS0bgWo+Qnruw3MzDnKtsiAyOtKyyWZY76MFeUgyRPa6yHIs+h1DTApDWxV70=
X-Gm-Message-State: AOJu0Yy0/vjtKJL/GRduMMAM3sroyaz1stovchpwPZltTFZUKjtjqNbG
 WuG3EuhD1k4oxp4nm45lmUeMAcKrw31H+sVrWPOPqHu3i1ltN6vwuKFsXvxc
X-Google-Smtp-Source: AGHT+IEZfRAHIwXSxE3s1/cBCxuP4GRbSr2X8JngG1vqHJDaxMk5Nzupf0+XawsNBIh5ri7nvMMnjQ==
X-Received: by 2002:a0c:9c0f:0:b0:68f:62c8:39d3 with SMTP id
 v15-20020a0c9c0f000000b0068f62c839d3mr2741134qve.56.1709330702354; 
 Fri, 01 Mar 2024 14:05:02 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 oi4-20020a05621443c400b0068f11ceb309sm804621qvb.128.2024.03.01.14.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 14:05:00 -0800 (PST)
Date: Fri, 1 Mar 2024 16:04:58 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20240301220458.GC192865@maniforge>
References: <20240301192020.15644-1-dthaler1968@gmail.com>
 <20240301214929.GB192865@maniforge>
 <236501da6c23$30b03380$92109a80$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <236501da6c23$30b03380$92109a80$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/2P-9UyRDRy8LuLF5HzatVri7d0M>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Use IETF format for field definitions in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0478657805867491358=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============0478657805867491358==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h+bXX5nS0hEPOju2"
Content-Disposition: inline


--h+bXX5nS0hEPOju2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:55:34PM -0800, dthaler1968@googlemail.com wrote:
> David Vernet <void@manifault.com> wrote:
> [...]=20
> > Very glad that we were able to do this before sending to WG last call.
> Thank
> > you, Dave. I left a couple of comments below but here's my AB:
> >=20
> > Acked-by: David Vernet <void@manifault.com>
> [...]
> > > -``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > +``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> 'class'=3D``ALU``,
> > means::
> >=20
> > For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly w=
hen
> > built with sphinx. It looks like we need to do this:
> [...]=20
> > -``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> 'class'=3D``ALU``,
> > means::
> > +``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and '=
class'
> =3D
> > ``ALU``, means::
>=20
> Ack.  Do you want me to submit a v2 now with that change or hold off for a
> bit?  Keep in mind the deadline for submitting a draft before the meeting=
 is
> end-of-day Monday.

I think we can hold off until other people review.

>=20
> [...]
> > > -``BPF_XOR | BPF_K | BPF_ALU64`` means::
> > > +``{XOR, K, ALU64}`` means::
> >=20
> > I do certainly personally prefer the notation that was there before, but
> if this
> > more closely matches IETF norms then LGTM.
>=20
> The notation before assumed the values were full byte values so you could=
 OR
> them together.  When they're not full byte values (and they're not in IETF
> convention), OR'ing makes no sense.

Yep

> The proposed {} notation matches the C struct initialization convention a=
s a
> precedent.

Makes sense

Thanks,
David

--h+bXX5nS0hEPOju2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZeJRCgAKCRBZ5LhpZcTz
ZOTZAQC3/6y6QAd8sEHhGDc9qW1EeTQrEijx2MFR86SslQvzRQEA2fLLW7MrjTp3
L57SqdZ7KJ2qiS9flrlZ2BZKv6LrGgE=
=NPUf
-----END PGP SIGNATURE-----

--h+bXX5nS0hEPOju2--


--===============0478657805867491358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0478657805867491358==--


