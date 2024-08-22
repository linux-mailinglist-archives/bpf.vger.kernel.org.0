Return-Path: <bpf+bounces-37885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4E95BD3B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390A5B22AA0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D61CEACE;
	Thu, 22 Aug 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkzDKz5j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB41CB33A;
	Thu, 22 Aug 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347747; cv=none; b=uVA8iW8eMEfrHI0gWpoSpVinmhC226vrkOA4uh6Zwo0ddE4Y3BMOxFWYfcW3Gb2jDXlqppcxg7ruxyevxVA0QCdAu9EW2G9uFc7HvzwH4fZScKzVGubduSN2+Gh0/v5em2cMQqSe/npLGic7bHpz6FTgFuGibmk85kPZkNGy/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347747; c=relaxed/simple;
	bh=LosmQ5CFfk4ZSl07libS442s831E7IGKHDzu0I+GDVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mlh0IJj3OoJyR3EfOuevMHKlahYC15uhunfPVuwroWWn5hDF5CHyIrT5PQetl6nK8+Y4yxBf/5BWINYZTAs8N2WGTjQWfHTBMevTUcxz1tKpAHA79P7p1t2jJsr9hvfmdi864Ex9TP07puDsBp/2qnstYLBF0lwnImeG7/ANhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkzDKz5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC3C4AF10;
	Thu, 22 Aug 2024 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724347746;
	bh=LosmQ5CFfk4ZSl07libS442s831E7IGKHDzu0I+GDVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pkzDKz5j9YHd8BTg0uNtCayiNQfPO8HvG1DsNcsYSm+U3/Dl2A2D6g9JO9os8n3Un
	 CWkPbq6KHjVWo1xQ6pXC3vCWpujHN5dIiDjQPDsVtO7CNuAiK7WMEyi4/dst0kHD5n
	 ZFcQjV9jQSfDNNL871rEL04Quno/fMGpqX5Vd5u688kvyP/ksdYlcS9StJbU5gChTJ
	 bSUneC8DO8QJv73O2c4LlEDgw4BPrTH1rGpm7JKiMKbiBA0Mw+EeX2I0CtFpR6adGw
	 w6INT3Y3t4HHtbOu+4rnJ/d0XR5vyAVP/J2nUpqtDU7BTMYiB/XklAIDOLDSUGDRzJ
	 c/vZi9uslz4wQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso8939331fa.0;
        Thu, 22 Aug 2024 10:29:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMlEGefYO2aJaiKlJ/++dZ8bYfYutv3+0+aitsKms23NSGEG32e+ye/ERNRk1ecsYBsMY=@vger.kernel.org, AJvYcCXYVk53Zx3Y/L6XkEc/ZrRolWWZ3SG+LkJB1aMT42Ucd3YCh1j62HPL+9W+FrdCHKWbYHKkL2ht/e7lUEVQ@vger.kernel.org, AJvYcCXie8deig3QWEki6IIaNbHXLAutqWxfxQb5Z4vn6d4zchtY3tvDyfi+rqVK2ccia23KfID7V0ZamCZ4Qz9Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyg3p7PXNnb1Dq3tTgUowsqX417HRcdCF0qhYv7p7yrflwi+m
	liZmjBzrQNkpk+xlOd7rGytPx3KYiBV1MBQ3Aq1mcypYUYcVawdnXeZsF/7u62J96cvM0MGikDF
	/O2eqhpm87qwFyPMYzmfhUiOS7QE=
X-Google-Smtp-Source: AGHT+IGpQKVh0KQRfZFJ0kdZ0Dj0uOI1Gb6IdETt2hGsnGFhlQKeOGf05rmfaiedh3z0YdGAzQxeV0BTmS4bkmR29yk=
X-Received: by 2002:a05:651c:1542:b0:2f3:e814:a90d with SMTP id
 38308e7fff4ca-2f3f8918a01mr52074951fa.28.1724347745518; Thu, 22 Aug 2024
 10:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728125527.690726-1-ojeda@kernel.org>
In-Reply-To: <20240728125527.690726-1-ojeda@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 23 Aug 2024 02:28:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
Message-ID: <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 9:55=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Like patch "rust: suppress error messages from
> CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT" [1], do not assume the file existing
> and being executable implies executing it will succeed. Instead, bail
> out if executing it fails for any reason.
>
> For instance, `pahole` may be built for another architecture, may be a
> program we do not expect or may be completely broken:
>
>     $ echo 'bad' > bad-pahole
>     $ chmod u+x bad-pahole
>     $ make PAHOLE=3D./bad-pahole defconfig
>     ...
>     ./bad-pahole: 1: bad: not found
>     init/Kconfig:112: syntax error
>     init/Kconfig:112: invalid statement



Even with this patch applied, a syntax error can happen.

$ git log --oneline -1
dd1c54d77f11 kbuild: pahole-version: avoid errors if executing fails
$ echo 'echo' > bad-pahole
$ chmod u+x bad-pahole
$ make PAHOLE=3D./bad-pahole defconfig
*** Default configuration is based on 'x86_64_defconfig'
init/Kconfig:114: syntax error
init/Kconfig:114: invalid statement
make[2]: *** [scripts/kconfig/Makefile:95: defconfig] Error 1
make[1]: *** [/home/masahiro/workspace/linux-kbuild/Makefile:680:
defconfig] Error 2
make: *** [Makefile:224: __sub-make] Error 2















> Link: https://lore.kernel.org/rust-for-linux/20240727140302.1806011-1-mas=
ahiroy@kernel.org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/pahole-version.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/pahole-version.sh b/scripts/pahole-version.sh
> index f8a32ab93ad1..a35b557f1901 100755
> --- a/scripts/pahole-version.sh
> +++ b/scripts/pahole-version.sh
> @@ -5,9 +5,9 @@
>  #
>  # Prints pahole's version in a 3-digit form, such as 119 for v1.19.
>
> -if [ ! -x "$(command -v "$@")" ]; then
> +if output=3D$("$@" --version 2>/dev/null); then
> +       echo "$output" | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
> +else
>         echo 0
>         exit 1
>  fi
> -
> -"$@" --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
>
> base-commit: 256abd8e550ce977b728be79a74e1729438b4948
> --
> 2.45.2
>


--
Best Regards
Masahiro Yamada

