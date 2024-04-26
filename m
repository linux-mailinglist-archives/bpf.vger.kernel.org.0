Return-Path: <bpf+bounces-27984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843EB8B40FC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2DF284E1D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB72C6B6;
	Fri, 26 Apr 2024 20:58:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419F1EEE9
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165116; cv=none; b=jqtvkeUkt9T9QACRelAc0mYaBDBxs3PYW43Fx6CqQllkTccf3jUQ9s0V3yQTkdJ1zpoXFnMhPmh+emsRmBCo02kuucLNO3W+kdKo8V49xwK6R/lqkagBlkyiCoTJ91aqLqNQjKZmysBNbuI4usugvv3BCYp1LdDFKL8SHleKcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165116; c=relaxed/simple;
	bh=Wlko5Gs6ed607ADMPrAEtlyzUeSFzi7NKsKxcxWhIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8aXWatyynKcElSHB9PdwCSqcGZOKNEMe64zjdsHnVCHdf6DeH6WBAutol2vK+yY0o5dKc5NI5jdJRG+fbCvx2ovs88FOfTWElsKvgW9aixk9DiGmq94iEINnRR0hhXUztvv28DGijDWbynVqpaHzuy9TVK0XlwYwOf1zCmNtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c3c5f7d0aso182815ab.2
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714165114; x=1714769914;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYwSlOs5D1E/5oGHU6TuvhldvjUiQWVdBukT+TzQUrA=;
        b=FfDhxgAIhsUeKAi6n08PUz0S0RfNUcM+LjD88qXDDqBxPYHr6T7U/p9qO61rlYJ4FT
         I2AS6HxcQJ8c30FolokrLD/3ZxVjKJohkEyuBOrZpb17snrFxxBdRKBcy9OhDYrg3bsh
         I9U7iZKPq2z/ifTiVl8Wl9MeXQ9Me6+L/RsOL6EDp4FvxblPHjZyjlDN1yfN8i5DFqzI
         nxM2e2+R49TPlGUBEjzcBa5HBsH7XJmpomVemudXbwmJD5JpMjsjHAX6TI3XdQEe8jkP
         rNTR9Zs9oULEVKfGu2qTZH9HuYLPR8wupIvE5+6VubaTqxTRzU/DSZUrG/SsYn7hYq+v
         ySYA==
X-Gm-Message-State: AOJu0YxPf8ulDlO61UoKAIKmCpKxAkV/0b7Xz9rQ/woWt7ytjDXSMFla
	NMMI6N7BlQabl5+8dJp6r/tXqbW5iagEgj/kpuueuWB5l7JOsKe+
X-Google-Smtp-Source: AGHT+IEs53Mu5VNRNFzZmI8Ysk5yA9QibVJwzcDHXNKlk8HHlBPPp/6Wgb3xLgtETFT9QEkqcM6ncw==
X-Received: by 2002:a05:6e02:1d19:b0:36a:63dd:7d49 with SMTP id i25-20020a056e021d1900b0036a63dd7d49mr1231018ila.20.1714165114052;
        Fri, 26 Apr 2024 13:58:34 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0220e400b0036a3986a47fsm4144091ilv.66.2024.04.26.13.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:58:33 -0700 (PDT)
Date: Fri, 26 Apr 2024 15:58:31 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Clarify PC use in
 instruction-set.rst
Message-ID: <20240426205831.GA21308@maniforge>
References: <20240426201828.4365-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yk8Jp1tlhYbPu4bg"
Content-Disposition: inline
In-Reply-To: <20240426201828.4365-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--Yk8Jp1tlhYbPu4bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 01:18:28PM -0700, Dave Thaler wrote:
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
>=20
> v1->v2: reword per feedback from Alexei
>=20
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index b44bdacd0..766f57636 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -469,6 +469,12 @@ JSLT      0xc    any      PC +=3D offset if dst < sr=
c          signed
>  JSLE      0xd    any      PC +=3D offset if dst <=3D src         signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +where 'PC' denotes the program counter, and the offset to increment by
> +is in units of 64-bit instructions relative to the instruction following
> +the jump instruction.  Thus 'PC +=3D 1' skips execution of the next
> +instruction if it's a basic instruction and fails verification if the
> +next instruction is a 128-bit wide instruction.

Should we say "results in undefined behavior" rather than "fails
verification"? I'm not sure if we should be dictating verifier semantics
in the ISA document.

> +
>  The BPF program needs to store the return value into register R0 before =
doing an
>  ``EXIT``.
> =20
> --=20
> 2.40.1
>=20
> --=20
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

--Yk8Jp1tlhYbPu4bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiwVdwAKCRBZ5LhpZcTz
ZMReAQDHZOWofi2uvndJVi6By3EvUrF3ETmn3hRaLloyARO8EwD+IvoDIOCY8wMD
jD8b4LzUQftwX3cjI+9a53NZThKpmgM=
=l4UO
-----END PGP SIGNATURE-----

--Yk8Jp1tlhYbPu4bg--

