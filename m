Return-Path: <bpf+bounces-45623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F419D9BED
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263D0B2BB20
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D311D9595;
	Tue, 26 Nov 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H97K3Dck"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3F1D90A2;
	Tue, 26 Nov 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640005; cv=none; b=jM/ACrWpKxTpv7Rx2rgLtL5eCOfQPGjvb5J1FecEPhvCJkAokaNzdOpr/b3RDl0i0LDVcvSLY5SsAmzoljn0BahlvcSE0mtqlcvxqbIU7N68zzZT+leCj/x8BI99etcOwEYbe17sJjSMWxL4tAb04QAwf/0tCbi7yKV2C1/10vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640005; c=relaxed/simple;
	bh=TProXUc2cef7s+Tfv01wc8JY97dEecVWI7am/mjvVdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW9J2PQs1LfR0KTLP4wnokQMQkwPCFygcl/VnqqOU7hJxp6cIUrLIfFKVmZ546/5zan/4YER28zLlI8M9CwBrnHfhLJjmt4TJEiRBpDBtLAvXBMn9Z9WjraRi8RP+on7FKXU7caQXi7Lv+ujYOrmCqkx/TwtRb1N0McjzkcI55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H97K3Dck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B2DC4CED2;
	Tue, 26 Nov 2024 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732640004;
	bh=TProXUc2cef7s+Tfv01wc8JY97dEecVWI7am/mjvVdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H97K3Dckppujj6dQOMKJT/RgaFa2DIJTfCR5xAgNpRNF/KIv3chi/HoQP4MgpRGJS
	 dFPklHAlZ6UbBb6/lgjA9/86zwSkr/QwLssDNuekow/6/3OvPgi2K4SUiUtBxD5YUj
	 tTa/1pk4Ku/mHqrfCTQNbo/XOlw1yemLhkdymIwMFoQDgdtZBB7EaAmprsnmIATUe7
	 oL5WwlQuwNXamRbGBPSqyWbAWPtrgJrJ8r/ESh28EbBKTYIdf4j9+Ttw86ceErqVcc
	 PfEqe1ol43nGu74+l8zUN9EA1K2Oc5CGHUcS/bceVOvEI8AhEPGQk+KO8tNtRzoAmn
	 DVmcb5Ix+lp8A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so45524681fa.3;
        Tue, 26 Nov 2024 08:53:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+xu6RkBca3Zl09fEa3Jpm0LoCaC5k56yU1CEqeevGOwVpuAaeXBaJnSRjdBW3iSCFw7E=@vger.kernel.org, AJvYcCXixtAcBCAxsB5uuW6Q/zgiYVvuCmyHz3W6+hgXKhEIcouG/9LnmTMWTYDHAiUabVcL5VeE/4XILykrUVyW@vger.kernel.org, AJvYcCXvolcWim6hFXQWtDfp7xqISWzloTavDf9V630fheXfu5G46iNKrcMKUBkMRF8n+w1jai2aptL7t3qTDAg+@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZEgECqkjE6L6XAKGl0pmXat/0TWsxoXSkI+6TxqnH347BIZW
	OY9dJkDR8ZY9Vo2eRuHkLtF78NK1frjKdHXEY4LPm9nJ9F0QLLhZI8OcTlG0cxHn45rOs465yKp
	7CKkX7+MotB/nqaJ1xHAdI3x91AE=
X-Google-Smtp-Source: AGHT+IEGiLHjHaiotTfC+APlGxKx5+rpU2lFE0q+DgXzHbHHwBkHGTqVERol2MBqDsj6bFUcXkaPovoRWfuOPiHgvW0=
X-Received: by 2002:ac2:510d:0:b0:53d:d58a:cb67 with SMTP id
 2adb3069b0e04-53dd58acb96mr7543101e87.35.1732640003625; Tue, 26 Nov 2024
 08:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net> <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
In-Reply-To: <20241123-resolve_btfids-v1-1-927700b641d1@weissschuh.net>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 27 Nov 2024 01:52:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARy_EFaAFC__LH2W6eZPOtF6WVg7osNe1i+o5aauENcHw@mail.gmail.com>
Message-ID: <CAK7LNARy_EFaAFC__LH2W6eZPOtF6WVg7osNe1i+o5aauENcHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add dependency from vmlinux to resolve_btfids
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 10:33=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> resolve_btfids is used by link-vmlinux.sh.
> In contrast to other configuration options and targets no transitive
> dependency between resolve_btfids and vmlinux.
> Add an explicit one.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---

1/3, applied to linux-kbuild.
Thanks.



>  scripts/Makefile.vmlinux | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 1284f05555b97f726c6d167a09f6b92f20e120a2..599b486adb31cfb653e54707b=
7d77052d372b7c1 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -32,6 +32,9 @@ cmd_link_vmlinux =3D                                   =
                 \
>  targets +=3D vmlinux
>  vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
>         +$(call if_changed_dep,link_vmlinux)
> +ifdef CONFIG_DEBUG_INFO_BTF
> +vmlinux: $(RESOLVE_BTFIDS)
> +endif
>
>  # module.builtin.ranges
>  # ----------------------------------------------------------------------=
-----
>
> --
> 2.47.0
>


--=20
Best Regards
Masahiro Yamada

