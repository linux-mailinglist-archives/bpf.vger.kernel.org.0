Return-Path: <bpf+bounces-20864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899A78447B6
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3960B28490C
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09FC36AEF;
	Wed, 31 Jan 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Jrg0ppwd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="AH0ZcVsc"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6037143
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727737; cv=none; b=LHdZkh1zuo6D4rH96DpAVXyOTXfQwccwza52e7C6dKduolA7YoOB//zr3SmJ17WSswHZ/wipQo77N5pV2P1jK5U6TUSaLogVIj2zwA6IbgOTdCmYZMvBJWBEBUZJ50SqJEpr3wKvt9UuVu+G/C3KYaXPB3JJVYJs10mFRKKpC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727737; c=relaxed/simple;
	bh=hYAd+dIyvO0iv9s0m2ZQoM6L842HL0kf8WmxccdK/hc=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=W0tD7NxwIPl1jgBA1qGOiayOMCHgaNFYYkWo1+mQO9fSmnCIPJLpPrKcZ1f4kwYkIsYMtwsfSFexKOEmlyCVThnIQfm3EZ26liv9kobhIjKSJynQM/ynYdbhSBdt/n4GsvwgbXMezIMc7845sY7VExMJyE7GIqDVkjZWv4+waO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Jrg0ppwd; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=AH0ZcVsc; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 12B8FC151552
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706727735; bh=hYAd+dIyvO0iv9s0m2ZQoM6L842HL0kf8WmxccdK/hc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Jrg0ppwdEz2rzS9VDpeEeb4g7HncWXjeeosMUNDyTIvlSzSuME5k1bVyjt4Gy5+DQ
	 aGnDHRz4zJoGLb28BI7Grdrhte09I1HCFdDA2YvfDv0kO5Di0b7IXXt2mqnWCEfMkQ
	 XfHOFKSmtllAtJuzD7Y/ce5E1wOxAyPFNo8monnc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 31 11:02:14 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A6D4BC14F694;
	Wed, 31 Jan 2024 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706727734; bh=hYAd+dIyvO0iv9s0m2ZQoM6L842HL0kf8WmxccdK/hc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AH0ZcVscPqO4z4K1XPIWf7T5kHjP6MApjIaCjQJZLy7smATQXGkC+cRsYlkngJ8jF
	 zYai+Avcb9uHHwrdQna9ICteZ1n0NXTUCO/kX0yznOcym5F7z/DV2syHo7uuz4kl3x
	 3OW9T3NLYe/tu3IcLYD9g7mvl7pZ0WHgGkXCKXO4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B56F6C14F694
 for <bpf@ietfa.amsl.com>; Wed, 31 Jan 2024 11:02:13 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.408
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zUOSoJF1NShO for <bpf@ietfa.amsl.com>;
 Wed, 31 Jan 2024 11:02:09 -0800 (PST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 50B2CC14F690
 for <bpf@ietf.org>; Wed, 31 Jan 2024 11:02:09 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-68c444f9272so665576d6.3
 for <bpf@ietf.org>; Wed, 31 Jan 2024 11:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706727728; x=1707332528;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5bdkigbuy7N+F/Uijz9a8VNffb/p+LEpN18kynpP2M=;
 b=YhWKW/DDpqxCqwCV3Qxf02M+rGZk3Xrlj3KH5GlRkkdRfLU91FDfVWhmHOVSp25iv5
 yj9aHH6RLhONEIHSIg0N0ulRXImYDu8asnXgOtJKZ4NuswzU/67H3od4dFdbFxVOELNT
 xtoSmgs1R348nS5ZmWquX8swrcNG8OZwqzSCHbw9Wck71zBgq2NE0sRSltIwXKPy9LMJ
 k2GgN/UiTqxF8ViiEw1a0kbYcngEFyN5W9hAlgYBi20Pq3VBQG+n97ZoGSieJE35FJam
 +fpurZcjEpR6ZGdKGt8iB1g1UNSOB/R02MeykOiY7hvOciG4WURg2nM+0H+cDyBn8LBH
 E0Vg==
X-Gm-Message-State: AOJu0Yw2rsuuH1R7Lozqv3xchp+YmVAdox1xC5OXDPqdV4dPhhP+M5CW
 fIH5rejLyAdz1HAlGEFvn9kONE12Di73paUnHZ+YqKnWeif03/3F
X-Google-Smtp-Source: AGHT+IEeP5S/pkX5AQxhNAbmTLSh/uhIxaH/MnJFLyUprEkLc0ypmUIIR5S3tL5ski0P/LL+e7RXEg==
X-Received: by 2002:ad4:5962:0:b0:68c:60d6:a937 with SMTP id
 eq2-20020ad45962000000b0068c60d6a937mr230191qvb.36.1706727728141; 
 Wed, 31 Jan 2024 11:02:08 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 pc19-20020a056214489300b0068c6e9fa24asm738125qvb.10.2024.01.31.11.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 11:02:07 -0800 (PST)
Date: Wed, 31 Jan 2024 13:02:05 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240131190205.GA1051028@maniforge>
References: <20240131033759.3634-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240131033759.3634-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/TTNQ6PH4IrfeIVrzHDS9o9enNqU>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify which legacy packet instructions existed
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8977976739319502278=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============8977976739319502278==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RVDUcJLDIDs2OQxF"
Content-Disposition: inline


--RVDUcJLDIDs2OQxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 07:37:59PM -0800, Dave Thaler wrote:
> As discussed in mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/5LnnKm093cGpOmDI9TnLQLBXyys/
> this patch updates the "Legacy BPF Packet access instructions"
> section to clarify which instructions are deprecated (vs which
> were never defined and so are not deprecated).
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index af43227b6..cf08337bf 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -635,7 +635,9 @@ Legacy BPF Packet access instructions
>  -------------------------------------
> =20
>  BPF previously introduced special instructions for access to packet data=
 that were
> -carried over from classic BPF. However, these instructions are
> +carried over from classic BPF. These instructions used an instruction
> +class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
> +mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
>  deprecated and should no longer be used.  All legacy packet access
>  instructions belong to the "legacy" conformance group instead of the "ba=
sic"
>  conformance group.
> --=20
> 2.40.1
>=20
>=20

--RVDUcJLDIDs2OQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbqZLQAKCRBZ5LhpZcTz
ZP4XAP9ajU67OpR72qyWAYboNvT837yFd0QSmrVt2ts+FwehQQEAov2OkfQQ/FZ7
qi2RY81j38xzo7m3rRCE3e+Ds8KdGQY=
=874j
-----END PGP SIGNATURE-----

--RVDUcJLDIDs2OQxF--


--===============8977976739319502278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8977976739319502278==--


