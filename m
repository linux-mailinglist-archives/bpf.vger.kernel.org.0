Return-Path: <bpf+bounces-22449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB085E51F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89C61C23120
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2294884FDB;
	Wed, 21 Feb 2024 18:03:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BF84FD7
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538596; cv=none; b=FdkZeh+TrwzavXy194/iHeVFYg05nnUh5EZuKMSbAAABgY8pcpOdDVwXSpmO+WwKCkqHD50/gRErGuTzTpm3AMqsO+LLU7/vz5704HbgZzvbtbEPPzn9VqrSlftnz6uhkkP/RspTrDOJJsS1UEL1gjnuIHLatA81954+WszZOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538596; c=relaxed/simple;
	bh=+qPNS3sjgJQdIbzyswwNwuZvQo5WRKVLmlNl6q6NphM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uznd0O8oEXMcEccFailYBfyKG7nRBg8cbNH6j3C6O7IIUYfvXq3Il6pqvyj0VUSpGVRFWGUHsMclzsdxhf9ReeZh+BvNwpeKxFSfbebGzYfAMeFlTKmMBEpSA6ptHupu1iGPghR68rd4Ua5xPg+EbEImyM8gy4H9V0ojbcvVICo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42c7c1cb2e9so40092471cf.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 10:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538593; x=1709143393;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5zOHo30ZABTIQWugBpCfU2/JqQeCkdcTj1Rd2b2xwQ=;
        b=BQwylxEZRz7mkatGY3vumF8vB89iLqSixtVfI7aJe3eZrk+SYoBvQdoWWx08IsyOZQ
         tSqp8/t7nNNls0wiYXdYb+HMuQ5xQ6Rf3ucZmnwBo4mCCXb1/wbiOgYJtgeZyZOh1yOU
         2mxPXxsgQftPiWWAJiV0aelHTkB+4DfB8zttRCgVs5f36oDuPX9+1zB1VRrKwXICq7OM
         DfNR4y3hDQc2NU8EmmxxR5zwYPqY8ZnZvZzo3oa4jR1F627Bhf5x9iChedVlpN2/IQiH
         nylZuDu56wPCFHFAn/r8W/ej19HNMZ0zzQQVcpKtTE/0/3tfIFQdsD05wCvp1R7h6+nf
         PBCQ==
X-Gm-Message-State: AOJu0YzcWBcLT3w1+ynapy4kgFpvEWlMe4hwTEHFxD0WjLHL3MWxRHWG
	mEg2fEiPrGmYNKP0UIjkHU7RjaW7IP9kadLs+eAn/JDz0WNKrTZl
X-Google-Smtp-Source: AGHT+IFfeP2LdMKuPixsokLo6A//yCGmedYS7sMF0CJ0+sDO3VSRD20VBcVlfX9fvsX/oizLSW93JA==
X-Received: by 2002:a05:622a:613:b0:42e:74b:c4da with SMTP id z19-20020a05622a061300b0042e074bc4damr11152640qta.5.1708538593529;
        Wed, 21 Feb 2024 10:03:13 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c21-20020ac853d5000000b0042e1950d591sm2496113qtq.70.2024.02.21.10.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:03:12 -0800 (PST)
Date: Wed, 21 Feb 2024 12:03:09 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: specify which BPF_ABS and BPF_IND
 fields were zero
Message-ID: <20240221180309.GB57258@maniforge>
References: <20240221175419.16843-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RAHwcC+l7ubUDf/s"
Content-Disposition: inline
In-Reply-To: <20240221175419.16843-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--RAHwcC+l7ubUDf/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 09:54:19AM -0800, Dave Thaler wrote:
> Specifying which fields were unused allows IANA to only list as deprecated
> instructions that were actually used, leaving the rest as unassigned and
> possibly available for future use for something else.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Seems reasonable -- guess there's no harm in leaving ourselves the
option of using them in the future.

Acked-by: David Vernet <void@manifault.com>

> ---
>  Documentation/bpf/standardization/instruction-set.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 868d9f617..597a086c8 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -658,6 +658,7 @@ Legacy BPF Packet access instructions
>  BPF previously introduced special instructions for access to packet data=
 that were
>  carried over from classic BPF. These instructions used an instruction
>  class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
> -mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
> +mode modifier of BPF_ABS or BPF_IND.  The 'dst_reg' and 'offset' fields =
were
> +set to zero, and 'src_reg' was set to zero for BPF_ABS.  However, these =
instructions are
>  deprecated and should no longer be used.  All legacy packet access
>  instructions belong to the "legacy" conformance group.
> --=20
> 2.40.1
>=20
>=20

--RAHwcC+l7ubUDf/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZdY63QAKCRBZ5LhpZcTz
ZFDhAQCi5aIgk/evr4NQLFZKDbPG2nrO2u8X8yZrNOt/M45mQgD9HL6SBG4NNkys
C2TaQtNkKFa0HUR4qS/2iHr0cmPl9w0=
=gDK5
-----END PGP SIGNATURE-----

--RAHwcC+l7ubUDf/s--

