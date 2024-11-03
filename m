Return-Path: <bpf+bounces-43829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5B9BA4FB
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1F9281BD2
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28451632D4;
	Sun,  3 Nov 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLR5e8xO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35015444E;
	Sun,  3 Nov 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627272; cv=none; b=bqLa15AzUpaosGfuw/gtcpkZu6/SYh/Y2tWfEzODLRgGzhpcngR8Eh/2rBBKc9vnFFCFeLqChpR8RGseY7b84z1dD1XoZjUw/FIZ+xjMPpXwL4/kgCG35i4OIF61vHAFuxoa11BYLs5E+tzGlJh/g5x4nLIPPNCpULD8xZlTBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627272; c=relaxed/simple;
	bh=5wMdD4MvA4Aq14GVFIycl91to3NVJjqw3DBsbYcAvok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4BxWsF8d6TatO89Zv1Q2ZcKwsYgZjJEmttq9sgWtctOWc1+wgvTU3hfY7Ix2HqKKnY3vhxAFHaG3YRKcSILZAcZkaPBrsjiiJVXekQbqj6QJotdTIEAXetF4PLvPZB4LvAX4VB0ajgDKJA9a6/QCBeztcMYD+QzTagTj9Q3o9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLR5e8xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0035DC4AF09;
	Sun,  3 Nov 2024 09:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730627272;
	bh=5wMdD4MvA4Aq14GVFIycl91to3NVJjqw3DBsbYcAvok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YLR5e8xOFdlTJzc5jsdwXJGyxjusE6yDsgjUQibFhM9k6uIQB/rG7ZVWfmUDUWL5C
	 SlYZqaQ0crjlF2mjsg/s+Ag1HU+gr6EzXhI8OkFtKelek7Hpit/5OS7KfEQOLpNjtO
	 HmUzz0e3nnwXng+C+u18aoOzaf5BvmWUxlNz4MtvhUP5FcJhzq0kBqO0/Mau8xfO9Z
	 w4jBQp4zR3qAjr2KCJnsUyHa676Eai0s7R46nhIIE4hp9XOGPt91iRsoDFCh45O73h
	 L2mJA5hy6S9WzqINdycUML5pUY/YzbEhy/2Tt5evGWhBKQyQTu9v/2gK7Rvt9Y7u76
	 i3Q3AV7Hs3axw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb3110b964so27448581fa.1;
        Sun, 03 Nov 2024 01:47:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUWm9pT9Qv+kn2zcMVPz9OqahDT3CqljwzjZvwqqUZT/W1AKmbXnLGGtgdS2ZAZMIBiusUjXy20po1jUXE@vger.kernel.org, AJvYcCXXVZ3Eigez6F16YIP5pbhFC/WLcWs7erN5oN3eSlsL5Pcpd7pJTDCzDG7d73zBLE5J99OdIUwawDcsDDQf@vger.kernel.org, AJvYcCXha6GkRtU9HMZgTQCCoQDXCuD29SrZs2ft1bgyywToimP+BiOBCnb/vAU7yQUgBTAFSP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9dzRdvMDuYzm0fcfqC/5cO0JPWFWAOVhH7ms21uXxz9PAaPC
	dFXw3A+ygYorL8Hirsq1DtrMzv5MkFQhzVp17ooUYCZViFJa1z1mueSEo5ZmnpcPQX3SnEaSt+a
	XEtsTTjhHivRm+uotzt3sro+O1F0=
X-Google-Smtp-Source: AGHT+IG9uZmCTLrhDsEkTY+lW8Pzm7vZdbBNuA+2oPqAkB4FQHNEz9xsU5oB49958S710kwniTVIrwqVamRNmiOCp8I=
X-Received: by 2002:a2e:a586:0:b0:2fb:5ebe:ed40 with SMTP id
 38308e7fff4ca-2fedb781c43mr40604211fa.15.1730627270574; Sun, 03 Nov 2024
 01:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102120533.1592277-1-admin@ptr1337.dev>
In-Reply-To: <20241102120533.1592277-1-admin@ptr1337.dev>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 3 Nov 2024 18:47:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=sCsTXB_O58W=AH=k8Vqzoi+hh6-BKhEjZYh-+xCvBQ@mail.gmail.com>
Message-ID: <CAK7LNAQ=sCsTXB_O58W=AH=k8Vqzoi+hh6-BKhEjZYh-+xCvBQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add resolve_btfids to pacman PKGBUILD
To: Peter Jung <admin@ptr1337.dev>
Cc: jose.fernandez@linux.dev, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Christian Heusel <christian@heusel.eu>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 9:06=E2=80=AFPM Peter Jung <admin@ptr1337.dev> wrote=
:
>
> If the config is using DEBUG_INFO_BTF, it is required to,
> package resolve_btfids with.
> Compiling dkms modules will fail otherwise.
>
> Add a check, if resolve_btfids is present and then package it, if require=
d.
>
> Signed-off-by: Peter Jung <admin@ptr1337.dev>
> ---
>  scripts/package/PKGBUILD | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
> index f83493838cf9..4010899652b8 100644
> --- a/scripts/package/PKGBUILD
> +++ b/scripts/package/PKGBUILD
> @@ -91,6 +91,11 @@ _package-headers() {
>                 "${srctree}/scripts/package/install-extmod-build" "${buil=
ddir}"
>         fi
>
> +       # required when DEBUG_INFO_BTF_MODULES is enabled
> +       if [ -f tools/bpf/resolve_btfids/resolve_btfids ]; then
> +               install -Dt "$builddir/tools/bpf/resolve_btfids" tools/bp=
f/resolve_btfids/resolve_btfids
> +       fi
> +


This is not the right place.

scripts/package/install-extmod-build is a script to set up
the build environment to build external modules.
It is shared by rpm-pkg, deb-pkg, and pacman-pkg.


https://github.com/torvalds/linux/blob/v6.12-rc5/scripts/package/install-ex=
tmod-build#L34

You will see how objtool is copied.




(Anyway, it depends on your urgency.
My hope is to support objtool and resolve_btfids in more generic ways.)






--=20
Best Regards
Masahiro Yamada

