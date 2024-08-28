Return-Path: <bpf+bounces-38305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068BA96300A
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C9E2819DE
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB71A76A2;
	Wed, 28 Aug 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg9l+C3m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E81C69C;
	Wed, 28 Aug 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869963; cv=none; b=HRYJbeukU3hwPFxH547O6ikn3Lbzh3drymZazauIMNjce/9tCje6B1zJtK5j0nLCJ4QLLV6b2/ebbsMUGMN+RkMD9lWh2UNSl5pUvBG8+ZQnCOgVv1hR9WLjLdFE+QrJKmJlqBleDLEQSwZx+nnogp/5bnNTlsS3CKYIDxlGQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869963; c=relaxed/simple;
	bh=vMGxzc5PSM5nD5jGS6EaxP7xELSSt4GgTt/MEDnsiaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZxiuu8zIV9Cys7/RaoDnuL2PnkZg5rKT8JedbZ4tLMPHDxaWXReJRjclNl75fX++Eaydus6sGVqOeyhDi07s93td+HSJZBKtoiD46qNOyzAsHcfg5RNugaqSf/Rnz4uzvLXUoVCuQca2yVPLJn6BIFXTzKjBplkR+ZrXNHtcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg9l+C3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D661FC4CEC0;
	Wed, 28 Aug 2024 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869962;
	bh=vMGxzc5PSM5nD5jGS6EaxP7xELSSt4GgTt/MEDnsiaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tg9l+C3mCfuWKTYYhIhedlNYQ1JkV82yMFfQ40/xdo+UROE3VKJC1Fj/5rYr0BFY1
	 tHT9gqxWpYbEoE33ccdRyr/qKU9DCOaB7ZcyVP12fQJY5E2rQ4XuMkugU/GWfW5i3f
	 GKcxRvfAYh3sUZZ+2c11zFboOoSfLrxUCm/01Dq5W6Pemku8c/W25HdpY5Vle+ml7G
	 iVkZ2Xw3JY/V8uSOlk+WZjPI04ify3XZ3+4SxZTa6xE4vwQt0lNu4zInQ8lrHgz+dR
	 8EHxXRpjkRC4ta2Xqh7Dk8Jqj7uQKVBLcEdTG0I2Y0RbUqbjJBBTWApi1Fk+tymXlX
	 HO5mTKydJeNYA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f401c20b56so8553211fa.0;
        Wed, 28 Aug 2024 11:32:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd1ubI/EBGZukC6agu9tBZuestgZdH6uOyV5M9+JSqWwGld48MiNv22T6+skgKXUoEFDwcm/St/C2e4d5c@vger.kernel.org, AJvYcCWeC5TtWNi0T5zSIYZDP6XVHjv6EjCYsgGlxCxidRcZSGylmalzPbxvYTsTbXetmuedUWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkl+DRm0m6xjEwrjQYxT6qZikz/proNRQDXfuOsvzc1kev2Q88
	ScxWZ2SQAD4pTdEp7e011CkYJmKZt6h4FzioRZyWUiD5MtH1F3dMgR+wxcq3MeYB6k6PNGZPKym
	UG7W98Qwgb87XVcZLRsbObV7BEaM=
X-Google-Smtp-Source: AGHT+IGCtSdi497UEot/m94AniVRUfQkmwPZ8M+oEDJxfPrHHMvANPjnxHjSNm5KbBfYPrpxeGNjrdCJtpk8lVOtYRw=
X-Received: by 2002:a2e:f01:0:b0:2f5:29f:43d5 with SMTP id 38308e7fff4ca-2f612a81b43mr137261fa.24.1724869961520;
 Wed, 28 Aug 2024 11:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNATb8dbhvdSgiNEMkdsgg93q4ZUGUxReZYNjOV3fDPnfyQ@mail.gmail.com>
 <20240828181028.4166334-1-legion@kernel.org>
In-Reply-To: <20240828181028.4166334-1-legion@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Aug 2024 03:32:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRDe7yLKj-EPewSirpnELmSXHFQRQyVaqRooEyY5qdyg@mail.gmail.com>
Message-ID: <CAK7LNAQRDe7yLKj-EPewSirpnELmSXHFQRQyVaqRooEyY5qdyg@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Remove custom build rule
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:11=E2=80=AFAM Alexey Gladkov <legion@kernel.org> =
wrote:
>
> According to the documentation, when building a kernel with the C=3D2
> parameter, all source files should be checked. But this does not happen
> for the kernel/bpf/ directory.
>
> $ touch kernel/bpf/core.c
> $ make C=3D2 CHECK=3Dtrue kernel/bpf/core.o
>
> Outputs:
>
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC      kernel/bpf/core.o
>
> As can be seen the compilation is done, but CHECK is not executed. This
> happens because kernel/bpf/Makefile has defined its own rule for
> compilation and forgotten the macro that does the check.
>
> There is no need to duplicate the build code, and this rule can be
> removed to use generic rules.
>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>


Acked-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>  kernel/bpf/Makefile       | 6 ------
>  kernel/bpf/btf_iter.c     | 2 ++
>  kernel/bpf/btf_relocate.c | 2 ++
>  kernel/bpf/relo_core.c    | 2 ++
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  create mode 100644 kernel/bpf/btf_iter.c
>  create mode 100644 kernel/bpf/btf_relocate.c
>  create mode 100644 kernel/bpf/relo_core.c
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 0291eef9ce92..9b9c151b5c82 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) +=3D preload/
>  obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> -
> -# Some source files are common to libbpf.
> -vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
> -
> -$(obj)/%.o: %.c FORCE
> -       $(call if_changed_rule,cc_o_c)
> diff --git a/kernel/bpf/btf_iter.c b/kernel/bpf/btf_iter.c
> new file mode 100644
> index 000000000000..eab8493a1669
> --- /dev/null
> +++ b/kernel/bpf/btf_iter.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/btf_iter.c"
> diff --git a/kernel/bpf/btf_relocate.c b/kernel/bpf/btf_relocate.c
> new file mode 100644
> index 000000000000..8c89c7b59ef8
> --- /dev/null
> +++ b/kernel/bpf/btf_relocate.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/btf_relocate.c"
> diff --git a/kernel/bpf/relo_core.c b/kernel/bpf/relo_core.c
> new file mode 100644
> index 000000000000..6a36fbc0e5ab
> --- /dev/null
> +++ b/kernel/bpf/relo_core.c
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include "../../tools/lib/bpf/relo_core.c"
> --
> 2.46.0
>


--=20
Best Regards
Masahiro Yamada

