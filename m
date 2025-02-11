Return-Path: <bpf+bounces-51085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208AA2FF40
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A49163F4E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0165C13BACC;
	Tue, 11 Feb 2025 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmXkFbo8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3E524F;
	Tue, 11 Feb 2025 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234372; cv=none; b=a+K/pouvy+GRnInJhB3JLCkW/gE9FsQZ+2ZbXz1gab68UnH0U43iIaXjFhhcH7a1I+BwV1zvtb8dQf3+oY8WpS2w2IIAloavaF7hgdjJVGF5eCn7Zwg40R+IU8qeD0r+x1cRYAFvnBR9QMkvWZLMz4aISrRJInN58uDo2sPtBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234372; c=relaxed/simple;
	bh=iu6RlgM5lqhqZIMQe9OWBltF2U0noubs1DdGYd+sp0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2Qml94nW81MLeyPT7Hb3yFuaLS5H6d8QzdZsqxjlnAqwhYX8vJ3KPIWn+glgEwQ8E04IPhBkLG7OUZ4vQha9XX1c3BPV3w+H+DTdu+YbvwG83sOOzYkpmaSkEVUgq/fc4CbriykLkewX6fu/lhUZCwNESwzulJgMYy9T4qiyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmXkFbo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE5C4CEDF;
	Tue, 11 Feb 2025 00:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234371;
	bh=iu6RlgM5lqhqZIMQe9OWBltF2U0noubs1DdGYd+sp0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tmXkFbo8ivsVMLGghuJmLI63Urq2H8iujO9rpOl2B7YYeYWeSPnIKtNHnkmLlmgzm
	 hRY8xgtki3kiAk8lPg2oFkFpE42wbayhp4xvvkL/3eY6cgzT45oZA2cVriTLhlhNr5
	 WmP99sG6acN836yFGGDh7+XbSysI9iYNdHeMtR43L7cYN4RU7mEWrEhyKYyMhG8i6S
	 s49g12yp4QanPRy7Tripcz9tgHA+ozupup5a/srVrY+NaKjFvmTtyxlE+ZBHg3EBK7
	 UAS57M8dEiwb0GPhMM4Y0Iz/KD7nX0uz+xlmHJU4/zZINnObh5FEqBM9m9+423Pxkn
	 mZGaSsNC4Qhmg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso52092511fa.0;
        Mon, 10 Feb 2025 16:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv9kFE8btIzLYtWKu/kraxyZzR79fb7m2u98VFYDRYYBAsgLpqOvMq3U2NA+Z2XlIMn20EZlPDrOM2l8Br@vger.kernel.org, AJvYcCX9+F2rjJTccaykhw/JEqadkNGXN6Kr7B1U5TYxKcBmzxuov5FldItexnMypBGjxhEf27A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGA0LrTzDcP0lN9PK9DwodGPKcvuUqaLYuVcG3dn0hQSCB8xf
	c88r55YxqFzL40PV2+iB4brPNIFgfqHVsEiGW7Kqqvb+H9uzmtCj/O9rpFLcKdWyAcLRdjFyjNo
	VOGBY7s7/vGShKzorT/mZcyyGV5o=
X-Google-Smtp-Source: AGHT+IGphwN2ayAD3ridXVRX//ia6KN3prU9kVDRP0j4JAiblT+GJSMQSvWJQxCVidX2P4kCQgx18UX850HgHGi2Uuk=
X-Received: by 2002:a05:651c:a0b:b0:302:3356:35d7 with SMTP id
 38308e7fff4ca-308f9169ee6mr4062921fa.18.1739234370551; Mon, 10 Feb 2025
 16:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211002930.1865689-1-masahiroy@kernel.org>
In-Reply-To: <20250211002930.1865689-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 11 Feb 2025 09:38:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATOzTsrZ5O7-MxW=cr2SYXWKJ3ZG9zMHkv5jqYudVyuLg@mail.gmail.com>
X-Gm-Features: AWEUYZkesWLw1Wz8TTR3ith50vtk6878AXh0KeiOQUon5SddnMleTzkOMekyajg
Message-ID: <CAK7LNATOzTsrZ5O7-MxW=cr2SYXWKJ3ZG9zMHkv5jqYudVyuLg@mail.gmail.com>
Subject: Re: [PATCH] tools: fix annoying "mkdir -p ..." logs when building
 tools in parallel
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Borislav Petkov <bp@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Frank and Matt,
Please ignore this.
This is intended for kbuild ML.



On Tue, Feb 11, 2025 at 9:29=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> When CONFIG_OBJTOOL=3Dy or CONFIG_DEBUG_INFO_BTF=3Dy, parallel builds
> show awkward "mkdir -p ..." logs.
>
>   $ make -j16
>     [ snip ]
>   mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=3D/home/masah=
iro/ref/linux subdir=3Dtools/objtool --no-print-directory -C objtool
>   mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make O=3D=
/home/masahiro/ref/linux subdir=3Dtools/bpf/resolve_btfids --no-print-direc=
tory -C bpf/resolve_btfids
>
> Defining MAKEFLAGS=3D<value> on the command line wipes out command line
> switches from the resultant MAKEFLAGS definition, even though the command
> line switches are active. [1]
>
> The first word of $(MAKEFLAGS) is a possibly empty group of characters
> representing single-letter options that take no argument. However, this
> breaks if MAKEFLAGS=3D<value> is given on the command line.
>
> The tools/ and tools/% targets set MAKEFLAGS=3D<value> on the command
> line, which breaks the following code in tools/scripts/Makefile.include:
>
>     short-opts :=3D $(firstword -$(MAKEFLAGS))
>
> If MAKEFLAGS really needs modification, it should be done through the
> environment variable, as follows:
>
>     MAKEFLAGS=3D<value> $(MAKE) ...
>
> That said, I question whether modifying MAKEFLAGS is necessary here.
> The only flag we might want to exclude is --no-print-directory, as the
> tools build system changes the working directory. However, people might
> find the "Entering/Leaving directory" logs annoying.
>
> I simply removed the offending MAKEFLAGS=3D.
>
> [1]: https://savannah.gnu.org/bugs/?62469
>
> Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 89628e354ca7..52207bcb1a9d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1421,18 +1421,13 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
>         $(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=3D$(resolve=
_btfids_O) clean
>  endif
>
> -# Clear a bunch of variables before executing the submake
> -ifeq ($(quiet),silent_)
> -tools_silent=3Ds
> -endif
> -
>  tools/: FORCE
>         $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(tools_silent) $(filter --j%=
 -j,$(MAKEFLAGS))" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/t=
ools/
> +       $(Q)$(MAKE) LDFLAGS=3D O=3D$(abspath $(objtree)) subdir=3Dtools -=
C $(srctree)/tools/
>
>  tools/%: FORCE
>         $(Q)mkdir -p $(objtree)/tools
> -       $(Q)$(MAKE) LDFLAGS=3D MAKEFLAGS=3D"$(tools_silent) $(filter --j%=
 -j,$(MAKEFLAGS))" O=3D$(abspath $(objtree)) subdir=3Dtools -C $(srctree)/t=
ools/ $*
> +       $(Q)$(MAKE) LDFLAGS=3D O=3D$(abspath $(objtree)) subdir=3Dtools -=
C $(srctree)/tools/ $*
>
>  # ----------------------------------------------------------------------=
-----
>  # Kernel selftest
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

