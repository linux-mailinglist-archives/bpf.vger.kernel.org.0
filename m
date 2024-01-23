Return-Path: <bpf+bounces-20118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D824839A45
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF82B2AB51
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE785C56;
	Tue, 23 Jan 2024 20:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2D60EE4
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041693; cv=none; b=mOrU9u/BsZe2Fa7BOrMbvid1rsWISSWBsGret5Bz/5CJ0Ut1nyqiHnXAAyDFoYiMnpX09KyoVvZt5ohKa0R5kObpnTNSULmfzwRDwUu9JcuQ4A4hb7Ec0hn852ILEOYDCkWuQB3Wys5m4S8LboKqGKSZjY3Sh0Nz1+Hmu/VT4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041693; c=relaxed/simple;
	bh=vAJOxihCP2Rii8zM8dZnqXeIx00iw8vDWmJ+vvU73EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMBUAmmDVqMyGEc/aIipe97B4Y0sG7dyHIRmn+edXPt9HtvIbKvw7+lwUovtGvm8CXkcXgcyN77wL9eX0p3kitOZKJNflSzjkhcuU+x/dDpfTqIY69GEylHtG+3HPZyR7o7lhgzQwL3JDM6aADJwpc/5tGddP8MX+Hi/7yolbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a4516ec5dso11621941cf.3
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 12:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041691; x=1706646491;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7arqjtvvH8xHP4nHGpMYkYAJAsMb+iysamayK9tBReg=;
        b=dP5TxM5dsS4ihFipbgi5CjlFGyW0xQP3oAGiAwljo/0HcBE5ILrXypm21hFI7FQUs6
         LUU7LHkD3FpeIgdzSQjeFl+ueG7ur1ZvdHpwrmBxG1RHZlC3z8oGaMmkb8/d0VnAaQwC
         rjUW34s/sW8Gd12vAoq9TlzPdF6UgfmtuRT+tqNOk8gGhCsg0Qa4SQ8MyjAgdfPCjaJH
         mCwB76utS1ZBwuSFp5NungFqALpMqAxsKZnj0be2aKXxoJDLQkMlLWnChYTGyav0S4W7
         yMtclmz59WghdbosrICdYpDWcI2y1XjwEBfGG11cERY7e4PZDxyLw4/drd8l2SfOrbyY
         awHA==
X-Gm-Message-State: AOJu0YwITYzfxfJWblQV7NL+anWRpfxmn7uA4BGC2HfrvNDPkO+3C4yB
	oOAGFwTSZgGhzguvcT7Qc4xsmCJn+m66zKOxgasFwh69CwHhMF0c
X-Google-Smtp-Source: AGHT+IEkdCgx6jrmlNBIvWfFqECoYDnf3vtC7DDKRaBEMemCk0oLgOz4bzf/1b7KLX/EHit7+AxSTg==
X-Received: by 2002:ac8:5fd6:0:b0:42a:2a01:a7bd with SMTP id k22-20020ac85fd6000000b0042a2a01a7bdmr1389494qta.93.1706041690952;
        Tue, 23 Jan 2024 12:28:10 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id gd21-20020a05622a5c1500b00429cfdac07fsm3771503qtb.18.2024.01.23.12.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:28:10 -0800 (PST)
Date: Tue, 23 Jan 2024 14:28:07 -0600
From: David Vernet <void@manifault.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 2/3] bpf, doc: Add document for cpumask iter
Message-ID: <20240123202807.GB30071@maniforge>
References: <20240123152716.5975-1-laoar.shao@gmail.com>
 <20240123152716.5975-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JyHWdTVyYB6SoEMW"
Content-Disposition: inline
In-Reply-To: <20240123152716.5975-3-laoar.shao@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--JyHWdTVyYB6SoEMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:27:15PM +0800, Yafang Shao wrote:
> This patch adds the document for the newly added cpumask iterator
> kfuncs.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  Documentation/bpf/cpumasks.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.=
rst
> index b5d47a04da5d..523f377afc6e 100644
> --- a/Documentation/bpf/cpumasks.rst
> +++ b/Documentation/bpf/cpumasks.rst
> @@ -372,6 +372,23 @@ used.
>  .. _tools/testing/selftests/bpf/progs/cpumask_success.c:
>     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/tools/testing/selftests/bpf/progs/cpumask_success.c
> =20
> +3.3 cpumask iterator
> +--------------------
> +
> +The cpumask iterator enables the iteration of percpu data, such as runqu=
eues,
> +system_group_pcpu, and more.
> +
> +.. kernel-doc:: kernel/bpf/cpumask.c
> +   :identifiers: bpf_iter_cpumask_new bpf_iter_cpumask_next
> +                 bpf_iter_cpumask_destroy

Practically speaking I don't think documenting these kfuncs is going to
be super useful to most users. I expect we'd wrap this in a macro, just
like we do for bpf_for(), and I think it would be much more useful to a
reader to show how they can use such a macro with a full, self-contained
example rather than just embedding the doxygen comment here.

> +
> +----
> +
> +Some example usages of the cpumask iterator can be found in
> +`tools/testing/selftests/bpf/progs/test_cpumask_iter.c`_.
> +
> +.. _tools/testing/selftests/bpf/progs/test_cpumask_iter.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/tools/testing/selftests/bpf/progs/test_cpumask_iter.c

I know it's typical for BPF to link to selftests like this, but I
personally strongly prefer actual examples in the documentation. We have
examples elsewhere in this file, so can we please do the same here?

> =20
>  4. Adding BPF cpumask kfuncs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> --=20
> 2.39.1
>=20
>=20

--JyHWdTVyYB6SoEMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZbAhVwAKCRBZ5LhpZcTz
ZOyZAQDtj7dIwU/v2ax/IUmOh6+S17GzpzSsdXte1bVIISZBlAD+PSQt+a77WfFn
ECdHI/CHPAqs+JyhGlP7vg/E8S5AxA0=
=CVw6
-----END PGP SIGNATURE-----

--JyHWdTVyYB6SoEMW--

