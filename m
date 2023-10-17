Return-Path: <bpf+bounces-12402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44D7CC2BD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1260C28184F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192C41E5B;
	Tue, 17 Oct 2023 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITpAt+AJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0741746;
	Tue, 17 Oct 2023 12:15:48 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52A6EAF;
	Tue, 17 Oct 2023 05:15:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so9525473a12.1;
        Tue, 17 Oct 2023 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697544944; x=1698149744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gz2J8/viNOWHCJxpoa1uLouYnvMF+ug9wHlLJn4++E0=;
        b=ITpAt+AJeEWfqNsLcBu3siWdj9LRqdj1XJ+s0ecp5OhkfxbpnH/GDh+X9LMvefy0Fk
         xXo6M/mj02SzJs1lDTzHktdozm8aHVPUbGYYRQ0TxASv6x69asbwJpIsABLRzj+Kepim
         EwPwc2ZOrMkfACRtw8M2iNuq/zmkznh9GVuNpxRQvff0stYFfieb+fW2BNXS5Xen4yQt
         F+Pb+nBtytpLpkIuwvBae10Vkba9cUvahb8gsGNFNtTmoA65Q6lVxnEamj+Z68m0CDBj
         B9iK0G1BzPev/CQOOjy9QR0cmVE0j5ufBk1FIDyK55+GfbS2Z9JA+4y7QoKW7s0vErWK
         K3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697544944; x=1698149744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz2J8/viNOWHCJxpoa1uLouYnvMF+ug9wHlLJn4++E0=;
        b=e+R3nnR33KFBoKhZN6TqqAmvVeuLz3J6eOGuDVEQokZZTCRQEoUoaPWdJhpZgR3+Ow
         ID03V4VT2vUP32JjSvSxIDzHZ737hNtjVSNh/Z9es2W/OblQ0XV4APr/W3quhvrvzi8G
         3/lEkhTaXFYLPSBvJIudoWicU3hsUKHlexHaC0WLSx+Jw/eY05oL15LR2FM6BnXZCTLU
         kDAsqNZ/WqxkeQgcicX/g5yJ7F9s8iDwjBsTNfKISfm15tzDq7BZPRNCdcq5Hx2eKym6
         nuvvhllF0WmSBNNKXwzvJmwo1GEbUT/cNEip0MsS3qwRv6Zl7MF2VxEI5G7VtIkIeIIi
         T+0Q==
X-Gm-Message-State: AOJu0YyINtuxlWcq8G7uEu+z2Qs98byklivQ2IAtCFvDaYvHlLBXl2jh
	rSoU2zdTlunWhSMHda3bJHg=
X-Google-Smtp-Source: AGHT+IHeTgAalkUR85YjdP6gbU+30Mf3B0a2wbI0ZavZKPX6VdX8e8bXVlK583OP74/vsoFzuWre9A==
X-Received: by 2002:a05:6402:510d:b0:53d:e8a7:57a6 with SMTP id m13-20020a056402510d00b0053de8a757a6mr1716689edd.34.1697544943477;
        Tue, 17 Oct 2023 05:15:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id i27-20020a50d75b000000b0053e3d8f1d9fsm1119801edj.67.2023.10.17.05.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 05:15:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Oct 2023 14:15:40 +0200
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>, Gary Guo <gary@garyguo.net>,
	Hao Luo <haoluo@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of
 scripts/pahole-flags.sh
Message-ID: <ZS567HeKDesxBYWh@krava>
References: <20231017103742.130927-1-masahiroy@kernel.org>
 <20231017103742.130927-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 07:37:40PM +0900, Masahiro Yamada wrote:
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
> With the GNU Make >= 4.4, it is executed more than 60 times because
> exported variables are also passed to other $(shell ) invocations.
> Without careful coding, it is known to cause an exponential fork
> explosion. [1]

nice :-\

> 
> The use of $(shell ) in an exported recursive variable is likely wrong
> because $(shell ) is always evaluated due to the 'export' keyword, and
> the evaluation can occur multiple times by the nature of recursive
> variables.
> 
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=y.

looks good.. could you please resend this patch with bpf-next in subject
so CI tests would trigger for it?

thanks,
jirka

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
> @@ -513,8 +513,6 @@ LZ4		= lz4c
>  XZ		= xz
>  ZSTD		= zstd
>  
> -PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh)
> -
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
>  		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS :=
> @@ -605,7 +603,6 @@ export KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MODULE
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
> -export PAHOLE_FLAGS
>  
>  # Files to ignore in find ... statements
>  
> @@ -1002,6 +999,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  # include additional Makefiles when needed
>  include-y			:= scripts/Makefile.extrawarn
>  include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
> +include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
>  include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
>  include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
>  include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> new file mode 100644
> index 000000000000..82377e470aed
> --- /dev/null
> +++ b/scripts/Makefile.btf
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +pahole-ver := $(CONFIG_PAHOLE_VERSION)
> +pahole-flags-y :=
> +
> +# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> +ifeq ($(call test-le, $(pahole-ver), 121),y)
> +pahole-flags-$(call test-ge, $(pahole-ver), 118)	+= --skip_encoding_btf_vars
> +endif
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> +
> +export PAHOLE_FLAGS := $(pahole-flags-y)
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> deleted file mode 100755
> index 728d55190d97..000000000000
> --- a/scripts/pahole-flags.sh
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -extra_paholeopt=
> -
> -if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -	exit 0
> -fi
> -
> -pahole_ver=$($(dirname $0)/pahole-version.sh ${PAHOLE})
> -
> -if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
> -	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> -	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
> -fi
> -if [ "${pahole_ver}" -ge "121" ]; then
> -	extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
> -fi
> -if [ "${pahole_ver}" -ge "122" ]; then
> -	extra_paholeopt="${extra_paholeopt} -j"
> -fi
> -if [ "${pahole_ver}" -ge "124" ]; then
> -	# see PAHOLE_HAS_LANG_EXCLUDE
> -	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> -fi
> -if [ "${pahole_ver}" -ge "125" ]; then
> -	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> -fi
> -
> -echo ${extra_paholeopt}
> -- 
> 2.40.1
> 

