Return-Path: <bpf+bounces-19263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393B8289BD
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C37285CDF
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0B3A1AC;
	Tue,  9 Jan 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VChYLp0x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="qT8l080W"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE847374C5
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0DB41C151707
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704816658; bh=ro1hB8hsHFhnjQPspRrn2xODmYJZ/DH+/Hzd/ZvAcPk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=VChYLp0xf8VRJToC5hUZBf9CVqMY/HiwMGf9Bp5Q7qdNgvdcPDk7i9AqVN5+YsqHX
	 LREZ7ufmbEs663GrEsGJnQB9gI1Hl6kqCFMO2x7zWKWdHJFtbR3W7U659LuzJavbgX
	 FV9yJkrPiGFSuVTU2nzJGGVcJOnjt0aCTYJEt2O8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan  9 08:10:57 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C5D4DC151076;
	Tue,  9 Jan 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1704816657; bh=ro1hB8hsHFhnjQPspRrn2xODmYJZ/DH+/Hzd/ZvAcPk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=qT8l080WpUSxRFBSdtR9qAv0/i8QvrxJSUHIDyMOFxQR240mnmxk9KO2pg7Wo37VV
	 79M5To6gCJ9XE5BYIudwj/SpBoSSJoOBlePdbSZngFNhDNEgj2wX8B+d3sHpqY4cVt
	 H3qxmKyBZkNLNf1wAW7vk8TpvEkD7hsZQfpyIzG0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9E845C151076
 for <bpf@ietfa.amsl.com>; Tue,  9 Jan 2024 08:10:56 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.407
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-fWCa4IwyDV for <bpf@ietfa.amsl.com>;
 Tue,  9 Jan 2024 08:10:54 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 8AAAEC15106C
 for <bpf@ietf.org>; Tue,  9 Jan 2024 08:10:54 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-427c4bf6017so25059121cf.0
 for <bpf@ietf.org>; Tue, 09 Jan 2024 08:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704816653; x=1705421453;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjHBEaHdSWTXb4kkRiKmuiZT+NrTmZbIpDxetZWh61Q=;
 b=WFgG4QGd21Np4mzqf7fdblJwzkPTJ/UhgqsDY9VmKz7gUaulSaip73YytnuVMYdKUF
 TOwnqmUh4YdzIHN8j/MMurvbEsCMSXLVZ0YUJ1QKDFdYtmmKUcNBLQ1axw8CIxR+FqYQ
 kyfP450Jro03vQ1BSC4RNCYjPr1JnCn4WmmGtigkEq/f99Ok28gNfFY3Za5ZxCWCqc3H
 qikY0U2rgvl46hjhiJvopwBdwGookciyLpxsR/Uimtlj1PM37piKLMOzne063k5jbeDL
 LGcdo/HqW5lcuU+VUMg11AUCJ3YjC54C4o0GJWmj2VxluzXhtwCZtAz2q+wPwUjLQv19
 nG/w==
X-Gm-Message-State: AOJu0YwNwdHQe382lOT2MkPwObYl/G0p24HI7a+ttZ4HfmCecQ8KCOEP
 N43pQYYIjWkv6EOzRh4l9O8=
X-Google-Smtp-Source: AGHT+IGBqw1cmDw2DclhEzdS/UFv8UIi6ctTp3CrKjlzcyvgrEiB//yI4t6hxIL8RvF8CvT3nJ61Lw==
X-Received: by 2002:ac8:588a:0:b0:425:8a27:4bef with SMTP id
 t10-20020ac8588a000000b004258a274befmr8169503qta.34.1704816653533; 
 Tue, 09 Jan 2024 08:10:53 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 ch6-20020a05622a40c600b004299d5ee4f9sm984072qtb.13.2024.01.09.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 08:10:53 -0800 (PST)
Date: Tue, 9 Jan 2024 10:10:49 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240109161049.GA79024@maniforge>
References: <20240108214231.5280-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240108214231.5280-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Hm53g8MpTjA1xL2Z6MqtUxbyHhk>
Subject: Re: [Bpf] [PATCH bpf-next] Introduce concept of conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0242594030948904788=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============0242594030948904788==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y9U2/K0VhlYetP/p"
Content-Disposition: inline


--y9U2/K0VhlYetP/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 01:42:31PM -0800, Dave Thaler wrote:
> The discussion of what the actual conformance groups should be
> is still in progress, so this is just part 1 which only uses
> "legacy" for deprecated instructions and "basic" for everything
> else.  Subsequent patches will add more groups as discussion
> continues.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--y9U2/K0VhlYetP/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZZ1wCQAKCRBZ5LhpZcTz
ZNvkAP4k0oNAU9M55irsV/VVDiH+6Jk3IUpHNEA3MvR/N7yy4QD/XGn/Ezb0dxXK
OhwWh6U96BYhqEKNoC54oUxYATkVhAA=
=TSRE
-----END PGP SIGNATURE-----

--y9U2/K0VhlYetP/p--


--===============0242594030948904788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0242594030948904788==--


