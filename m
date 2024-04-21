Return-Path: <bpf+bounces-27328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D98AC026
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716932815C0
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8D1BC23;
	Sun, 21 Apr 2024 16:43:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B087E6
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713717826; cv=none; b=bBPkTa8/bP6ErDYawudspkb3iEUMdvEMpv+/aNXmTPQuWolpS4I5C1TxU5J6VplQpXh7wt93wKHkCK4Qa4yxvZfyS97O+64thhVzTewnzro9k9y7E0q+Hpui57oP8bq8nY/3cBy6mB6sY8FAUSh8EOfS8DbSMdw304V46W2BWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713717826; c=relaxed/simple;
	bh=OgB5Wt7dnb9h7Kf0i5PWU7WaIffMTEQFiHfzWrpNVFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4WW18lBKQEnieFw8wRmvqQNLT8AkqnWUEPE2OIefvpLMklWV4xplEsv9o7NVLqheIHkWU6x/cOtnD+kHGFZZ3l2QcysB9yz2SE6LyvN6JusABwp3FZx5S9L+ikJSUFsX7QpKNh1uosJJS7+qbbnhw8qxxMVAh1ccYxYMTO4wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so3930084276.0
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713717824; x=1714322624;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgB5Wt7dnb9h7Kf0i5PWU7WaIffMTEQFiHfzWrpNVFo=;
        b=sarcgsxtUDbav4KYWr6CMDLtlJuE5k6C6J8ZIPmrBCKlX1HeEBCGECkWFAuhPrTZwR
         vbXQJ4iTz7qi3TUQ+xqasvcY71BXsYX2RnEma6bGPvf/u6jMqIq6ViuzZSazqRzUj+cg
         XImI129aM5jibmIDQ68WBwCCk5Lv81U4RI69i1Nk8BkKVm8QzRQCWbgwZO41G962kiV6
         CCrrfKuM4XENRzPxWnrXEsBbmPYglnTkN3e+hNdcCtqskkrqQNPCRdNNr/+qL+skwFlM
         91r7EzDalpDyR47TkjYiRfnqy8OlxxIiD0MRcGKgDKmuI6WVi1rupT1NSsWq5Ii2PMQX
         ufUw==
X-Gm-Message-State: AOJu0Yyq0F1BLEX4Rc9OxfJEgoHbzIen27dykuckadRtsiAvEssrFHpm
	OUaibkbFrIt/VMUREoHqmK/GcL66Fmu0ulQVBhe93r72tSIUTn12
X-Google-Smtp-Source: AGHT+IGgPRisTdssxmdmqCdqpN2R9Jz61mbY1M5qsQBF5kDodr2inO/FMTJsCb4BMiXMKRlZmZdMuA==
X-Received: by 2002:a05:6902:1368:b0:dbd:be40:2191 with SMTP id bt8-20020a056902136800b00dbdbe402191mr6917129ybb.42.1713717824118;
        Sun, 21 Apr 2024 09:43:44 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id x3-20020a056902102300b00dcc0cbb0aeesm1623518ybt.27.2024.04.21.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 09:43:43 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:43:41 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Clarify helper ID and pointer
 terms in instruction-set.rst
Message-ID: <20240421164341.GB8626@maniforge>
References: <20240419203617.6850-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xehouMHa8hWunsgx"
Content-Disposition: inline
In-Reply-To: <20240419203617.6850-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--xehouMHa8hWunsgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:36:17PM -0700, Dave Thaler wrote:
> Per IETF 119 meeting discussion and mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/2JwWQwFdOeMGv0VTbD0CKWwAOEA/
> the following changes are made.
>=20
> First, say call by "static ID" rather than call by "address"
>=20
> Second, change "pointer" to "address"
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--xehouMHa8hWunsgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiVCPQAKCRBZ5LhpZcTz
ZHumAQDLmR7Pz/HATaYYxb8i4sUjO3AQQ7MHUYnaKi6KmV3VRQD9Gbamw80Stg+O
YzddgTurSchQDup9L234MMhfmknCMg0=
=LgNB
-----END PGP SIGNATURE-----

--xehouMHa8hWunsgx--

