Return-Path: <bpf+bounces-12479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA37CCCB9
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 21:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD580B212A6
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5A9CA74;
	Tue, 17 Oct 2023 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUlGL12+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E632EAE2;
	Tue, 17 Oct 2023 19:57:07 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C5C4;
	Tue, 17 Oct 2023 12:57:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so10451698a12.2;
        Tue, 17 Oct 2023 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697572624; x=1698177424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl//DC5ziIO68KUbpNSRqo4FW+IItW9RRn+Fwf7gHXM=;
        b=HUlGL12+FadNoXde4zwwNJr8nYACjm/xbZHn2KE0nxNlgIYJXAiTmPyZqdTZ3GoyBe
         rYZFasu5JOxqAvDpPcJWbO/0geyXyXl9PXvYV+lOm42QWVh40vlI7EOMcAA4GZZ1LlbY
         T4uuQ0NzZO8d7HtJSyp0CHN65eQgCzJywDhLpc7sydgncwEGaAcoJYgWfVoeIkxu6jdn
         A20x1ImV7BWpJl3R8RjB6dK9F3GjotDXVBTZ63PoKI8i0hP7kZAz3FO6TGXVOAgyyP0x
         zWExuLuM/GQWWeMoJ8Ij8fSTcdRoAd691/OK8NYRRjXSTKyToHERoj2fWQpMvTo0Vu3u
         iT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572624; x=1698177424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vl//DC5ziIO68KUbpNSRqo4FW+IItW9RRn+Fwf7gHXM=;
        b=jpWU71QUrH90NkgegaJh01FdbCag11C2S1bTktVubuMwARXfJypuAHCt+LaFNhzQW0
         jlqSfmBifMEhVQo1Z31+jKthZQYIanpwMFQggRjBnPNtc2V+0stdfGsx6Rz1RMV4YFKh
         7/oSu+iz8naCS0CvibuYK8PmaOz6XSx963k13VctR5amUBZsSyXEWw+BUf0H6wFF2Bs/
         eF0zvhfm49MB4RdqPP5SIym1K/fC0B7LXlV3J6nH6L2sJR0VzWqIzqjBbPaUdycOLQH4
         yeK81b4aurKTvXmyNwcbRYQhAwibA8LHzjl52TaU/d2sL/Xd388EFP5dauU2kq1DtLbW
         Uung==
X-Gm-Message-State: AOJu0YxOMgDe73lO4jArZGyptwPQ6ueZBbRAXBwSmv0lM1ZGIm/y0i1P
	8JlpTmgIUS1FEsEVJ02FLGJutPFJAxTCu3k+cTA=
X-Google-Smtp-Source: AGHT+IE54ubwzInt8pjf1xLQK23tkOkZVxxwRLgaha9BMuvwU1sZigJOg0asUrccflLugI6pDAN5DdOwz8kjoV7zkv8=
X-Received: by 2002:a05:6402:4315:b0:53d:fbf6:72c with SMTP id
 m21-20020a056402431500b0053dfbf6072cmr2852702edc.1.1697572623918; Tue, 17 Oct
 2023 12:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017103742.130927-1-masahiroy@kernel.org> <20231017103742.130927-2-masahiroy@kernel.org>
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Oct 2023 12:56:52 -0700
Message-ID: <CAEf4Bzaxb1npVtH_CnFNrOJQxQF5t82_nZxqbaFLiE-rpk_jBg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of scripts/pahole-flags.sh
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Gary Guo <gary@garyguo.net>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 3:38=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> scripts/pahole-flags.sh is executed so many times.
>
> You can check how many times it is invoked during the build, as follows:
>
>   $ cat <<EOF >> scripts/pahole-flags.sh
>   > echo "scripts/pahole-flags.sh was executed" >&2
>   > EOF
>
>   $ make -s
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>     [ lots of repeated lines suppressed... ]
>
> This scripts is exectuted more than 20 times during the kernel build
> because PAHOLE_FLAGS is a recursively expanded variable and exported
> to sub-processes.
>
> With the GNU Make >=3D 4.4, it is executed more than 60 times because
> exported variables are also passed to other $(shell ) invocations.
> Without careful coding, it is known to cause an exponential fork
> explosion. [1]
>
> The use of $(shell ) in an exported recursive variable is likely wrong
> because $(shell ) is always evaluated due to the 'export' keyword, and
> the evaluation can occur multiple times by the nature of recursive
> variables.
>
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=3Dy.
>
> [1]: https://savannah.gnu.org/bugs/index.php?64746
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile                |  4 +---
>  scripts/Makefile.btf    | 19 +++++++++++++++++++
>  scripts/pahole-flags.sh | 30 ------------------------------
>  3 files changed, 20 insertions(+), 33 deletions(-)
>  create mode 100644 scripts/Makefile.btf
>  delete mode 100755 scripts/pahole-flags.sh
>
> diff --git a/Makefile b/Makefile
> index fed9a6cc3665..eaddec67e5e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -513,8 +513,6 @@ LZ4         =3D lz4c
>  XZ             =3D xz
>  ZSTD           =3D zstd
>
> -PAHOLE_FLAGS   =3D $(shell PAHOLE=3D$(PAHOLE) $(srctree)/scripts/pahole-=
flags.sh)

What if we just used :=3D here? Wouldn't it avoid unnecessary multiple exec=
utions?

I don't make Makefile.btf approach, just curious why :=3D doesn't work,
if it doesn't.

> -
>  CHECKFLAGS     :=3D -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
>                   -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS :=3D
> @@ -605,7 +603,6 @@ export KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MO=
DULE
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE=
 KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
> -export PAHOLE_FLAGS
>
>  # Files to ignore in find ... statements
>
> @@ -1002,6 +999,7 @@ KBUILD_CPPFLAGS +=3D $(call cc-option,-fmacro-prefix=
-map=3D$(srctree)/=3D)
>  # include additional Makefiles when needed
>  include-y                      :=3D scripts/Makefile.extrawarn
>  include-$(CONFIG_DEBUG_INFO)   +=3D scripts/Makefile.debug
> +include-$(CONFIG_DEBUG_INFO_BTF)+=3D scripts/Makefile.btf
>  include-$(CONFIG_KASAN)                +=3D scripts/Makefile.kasan
>  include-$(CONFIG_KCSAN)                +=3D scripts/Makefile.kcsan
>  include-$(CONFIG_KMSAN)                +=3D scripts/Makefile.kmsan
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> new file mode 100644
> index 000000000000..82377e470aed
> --- /dev/null
> +++ b/scripts/Makefile.btf
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> +pahole-flags-y :=3D
> +
> +# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> +ifeq ($(call test-le, $(pahole-ver), 121),y)
> +pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --skip_encod=
ing_btf_vars
> +endif
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 121)       +=3D --btf_gen_fl=
oats
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized
> +
> +export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> deleted file mode 100755
> index 728d55190d97..000000000000
> --- a/scripts/pahole-flags.sh
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -extra_paholeopt=3D
> -
> -if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -       exit 0
> -fi
> -
> -pahole_ver=3D$($(dirname $0)/pahole-version.sh ${PAHOLE})
> -
> -if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
> -       # pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> -       extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_vars"
> -fi
> -if [ "${pahole_ver}" -ge "121" ]; then
> -       extra_paholeopt=3D"${extra_paholeopt} --btf_gen_floats"
> -fi
> -if [ "${pahole_ver}" -ge "122" ]; then
> -       extra_paholeopt=3D"${extra_paholeopt} -j"
> -fi
> -if [ "${pahole_ver}" -ge "124" ]; then
> -       # see PAHOLE_HAS_LANG_EXCLUDE
> -       extra_paholeopt=3D"${extra_paholeopt} --lang_exclude=3Drust"
> -fi
> -if [ "${pahole_ver}" -ge "125" ]; then
> -       extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_inconsi=
stent_proto --btf_gen_optimized"
> -fi
> -
> -echo ${extra_paholeopt}
> --
> 2.40.1
>

