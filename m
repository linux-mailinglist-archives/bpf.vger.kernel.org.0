Return-Path: <bpf+bounces-21231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDDD849DE5
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595FD2874F8
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDF2D607;
	Mon,  5 Feb 2024 15:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2D2D043
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146583; cv=none; b=ZKbZGvbCXq53g2nVL2d9tEnKJlLdgV3ARMH2hxVZ9c2mbSfS02yb9MlowZmsKzUYF0TDT1lCGBMh8m0IWkUGhg5N0Lhu2LPyOvhgx1A8uwVXCVKi31ika0qUzydHWM5QkhgJbr/t0HhUIFR5qChrNsQfia4OTmqRGZgKz+VAnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146583; c=relaxed/simple;
	bh=KrCXP5k0f0YJXwHtMBxQAcZQ7Iimi0LgJG0vCFq8+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWx1o6rQ1VqqWnKA2HMdvgO4X8RtgszFvPIgYp4BYAPRLWfZlL7PbZ8om3ubV+sOxjBOZjj0jmdaptcO/Uz8WPj/yUAdC3263hwgmRS9lL1wMEOpR8IJl3NPrsHpf+Zsb7eji0SZ2WAKcqYBH5sgzqaoYfj5g3banQuOax+IzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bfdb84c0ebso572061b6e.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 07:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146581; x=1707751381;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3+dls/bzKewWIrGbJpibIVsaZdK1iKYO/C+lKISuzs=;
        b=VpHVDj8jirdws5jinPKIAeqjZtryRlzCYB85UPwnhxSic3BSTI8aZZbmkJj57AXDLX
         U+bl4ml0+9B/LIcij/rTNRVOdnv4RcqvkFIfxYx58xgquM4evELtqXI1EJ0upHb3Y79G
         Wqh+KRVpk57I3/V3xc2P/vzcy/QTo0D30WETU0eunwrbkFhzIDRCom/f6zz9gARvF1uD
         mgfdxNdQJV5rs3aXaDFGnZGNt98P+K3DLBmnSRRb89+y6JdMv7s9ezcctmaQm1wDRQGk
         mIZ/zP6KTfo5L7Udps5jnfKHW0gEcyL6qIiqudPowhD2YM6X3rxcfhl/bttwBNkPjdis
         IUUg==
X-Gm-Message-State: AOJu0YzrRgT2cITUvvMTPdY+9XfqEnlWklCoc/To8E1MtEDzN3Hs1aJn
	u95LE/CmvxcxH+qzwZk7HT37ztKUKwWEKKpW+awLv+38lQMTu08k
X-Google-Smtp-Source: AGHT+IEKGBtEj8MreTL4qOJQyUHRGIerDOT7LnpJGW+IyUyWbPvQnl6vDKAwru+1glUcet/kMCTWHg==
X-Received: by 2002:a05:6359:4598:b0:176:9bfd:d092 with SMTP id no24-20020a056359459800b001769bfdd092mr120077rwb.18.1707146580707;
        Mon, 05 Feb 2024 07:23:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbfTYQo13makG7kMuHNSbLOjmTH/dSot1/y9LGiv7gyeRzzU9EH+9Lp9kXZxV/43osNeRii9pD+FNq9Mx+Yk6v71TF
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id w9-20020ae9e509000000b007856ed8ff83sm28853qkf.45.2024.02.05.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:23:00 -0800 (PST)
Date: Mon, 5 Feb 2024 09:22:57 -0600
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Subject: Re: [Bpf] ISA: do individual instructions still need their own IANA
 status?
Message-ID: <20240205152257.GG120243@maniforge>
References: <00f801da565a$7e999250$7bccb6f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m+H6bO6gQwMkhEk8"
Content-Disposition: inline
In-Reply-To: <00f801da565a$7e999250$7bccb6f0$@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--m+H6bO6gQwMkhEk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 08:36:02PM -0800, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> Previously (draft -00) we said that each instruction would have a
> status of Permanent, Provisional, or Historical in the IANA registry.
>
> However, we now have conformance groups about to be merged into the
> ISA doc, and at IETF 118 we discussed having each conformance group
> have a status of Permanent, Provisional, or Historical.  That is, it
> makes sense for the status to be at the granularity of conformance
> group since one should implement all instructions in a conformance
> group together.
>
> As a result I now believe that each individual instruction no longer
> needs its own status since it can be derived from the status of the
> conformance group(s) it belongs to.  So in the IANA Considerations
> section, I plan to remove "status"
>
> from the list of fields in the instruction sub-registry and ONLY have
> "status" in the list of fields for the conformance group
> sub-registry).
>=20
> Let me know if anyone has a good reason to keep it per-instruction.

No objection from me. AFAICT this matches what RISC-V does, which again
seems reasonable to emulate.

Thanks,
David

--m+H6bO6gQwMkhEk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcD9UQAKCRBZ5LhpZcTz
ZPrzAPwMBv0Cb9WrqIecLSKWg9mhx4jH7gApoA69JoxovlKxxgD+PqrTleFtAu7T
oKv71pm6aEF2cOG6NjY20GpoI5R8vgU=
=H6gV
-----END PGP SIGNATURE-----

--m+H6bO6gQwMkhEk8--

