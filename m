Return-Path: <bpf+bounces-21775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07D851F79
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C37284D20
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD1487B0;
	Mon, 12 Feb 2024 21:21:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FA1DDC5
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772910; cv=none; b=B5qCnUrENo5muHzw7j533jS+dG4/bUcvyFoNIdXZJAzOaaea4OIx26DMdf81dRP9IJdBl5Fi7Z47NIKjGwT1KX3G6jU5Uc9hgKk8W2NiHQBiaLGXLuFDdPCtNPav8WnqxNkAOcqdQm5ZvY1xZhRdigFDkifRmt7Vf1CUXDkq5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772910; c=relaxed/simple;
	bh=tNB3SQuksL8GKK7oL64HSbL5xMP+rewd7Plzq88tqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUEkvkBkQeeY7Vfa9SZfoI5+PnALbrxT7/oNsADfb+4hAk97AvhC8Dx7AV5kmmgaZ7hORQP77XsCENvts0fsShG46xiVjSslYYwQH4xRVkM6BFv23Anth6H3apSG+36Jp9fo3bTlKzcjUvHnmtmXA5fWxaRaNf49n7AjVBQr1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-680b1335af6so40332716d6.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 13:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772908; x=1708377708;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyOmD5MRLJiE99owVfs0cfaVHBcrrwfJePTj+xZRfkM=;
        b=uOj3+K7iHAoSeLD9EuW39lk1e2Wa1euuwBAYyAtYcM+EfdtQcaae1zRhrVP7AI5cCa
         2GwhnpQOobUX12OiPqNSAsM5uFkA2FMariS78p2tQwzYY5KeMTy9adHCn3do2cG091OF
         xwcIG8QTj0ZQRA8DfLU8CvRTJsel/283pCoWyYy5dzkD6piaalIJjHF68MGfJS9cG0BC
         HW6w78S8I+MLqNbICuIOYNH5EuMYeZos6r+nxIQIhVp/aNKDOsE74wKDtgj4SXEAWu7H
         SmjliJSOzdcaZTwqdQknDl1JdWMJQx5iNT//NAsFagLD3vUf0PLGLBDh8tyXvPJfcqhW
         Ynaw==
X-Gm-Message-State: AOJu0YwpdDwjqtJUaOFFqYu8LYngcTtCOWvphUm/+/dUSCZ56kP2wDIF
	vPUrpQM+qMPOENooWOSdoj2nr+nyRXdvelfXeakhNIIfMChi8bW6
X-Google-Smtp-Source: AGHT+IGkuFKPq01mbOkW4904RVvSqdqXT08moZFhSB0VWx//X3N4wwvF9IT1RVvjsceCiUvIHREgbA==
X-Received: by 2002:a05:6214:5903:b0:68c:7946:2cb8 with SMTP id qo3-20020a056214590300b0068c79462cb8mr1605356qvb.7.1707772908003;
        Mon, 12 Feb 2024 13:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaBa6jSpvRAq1UqnJeCG+/Su0cIKLXG1tuK9eztDRnvnGi7dAO9uajGx8yUn/klQzX1xm6QJgLG7N2sG8KZvSY5GgYZjI3EfG6hrzWTl+jZTu2DQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id nw2-20020a0562143a0200b0068c89d8eb53sm564968qvb.81.2024.02.12.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:21:47 -0800 (PST)
Date: Mon, 12 Feb 2024 15:21:45 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in
 new conformance group
Message-ID: <20240212212145.GA2260582@maniforge.lan>
References: <20240212211310.8282-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPY8TMn2oz/tjieD"
Content-Disposition: inline
In-Reply-To: <20240212211310.8282-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--GPY8TMn2oz/tjieD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 01:13:10PM -0800, Dave Thaler wrote:
> * Add a "callx" conformance group
> * Add callx rows to table
> * Update helper function to section to be agnostic between BPF_K vs
>   BPF_X
> * Rename "legacy" conformance group to "packet"
>=20
> Based on mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/
>=20
> v1->v2: Incorporated feedback from Will Hawkins
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--GPY8TMn2oz/tjieD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcqL6QAKCRBZ5LhpZcTz
ZGGFAP9+v64+4ya0JpcJnPiNwIDo3+VV+oW4+5lSsXyGpXwWaAD+OZ67RECVlD0h
0NfGm+5rHi0Ym/vwSzX5piaeOVuBaQE=
=rmwZ
-----END PGP SIGNATURE-----

--GPY8TMn2oz/tjieD--

