Return-Path: <bpf+bounces-33605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6091F0A5
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F12E1F22E8A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4754814D44E;
	Tue,  2 Jul 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaHUFIh4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020C14BF97;
	Tue,  2 Jul 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907169; cv=none; b=opSkfofaqyDGngL57/Zy88lFPeQ0fWIHGigyjUXFpCbf6eAyQwXUIgDIWj/e41KtFq6ywt2hnRq+OBls+61+uohBLH1GaZcSSNnHkVejKAIL2C0+lC05WTLGhcolAmWl1RDyNpVkcvA5tmUVxtrZ2T3xkzPBTnoJsf/zm7tO8l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907169; c=relaxed/simple;
	bh=mjQvlJBN8yHEWRFav3WW2ktt0+oeWVegxbEB9kZlxfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1N+yAc6m5c5SRaiGU4lIb3N9ett/RAxHAEbD7mmupe3HcrmkC+OdW/7TQyl+mNWeHmUuNw3aqjCWoWqCHZN8HG1SeGzqxy/qQA9Mn9bzteM+EgUHbjRNY2seZXJc9v0Ag4GBj/0ofwGdKjs347fLIxcLHpZPi8y02qS7HMoaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaHUFIh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECC5C4AF0A;
	Tue,  2 Jul 2024 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719907169;
	bh=mjQvlJBN8yHEWRFav3WW2ktt0+oeWVegxbEB9kZlxfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RaHUFIh40kEU5kXvqrC9MO8Uxp/JCLsUD+hw0jbBz8tqOaTUTJbCV/ivX8l/EfQf4
	 fbWEul/z2gySvmr7bC9aAZqGcaEMdYwbYJ1zH/G/ZnkqMT8Dt3mPzlyVc8bvw+L1GL
	 mokHRNqoejl3KwmRdub9wDnojFCME+pf2reWUQNrsRRQwurOuPDqI41t0LALzsv/zV
	 qc1JkmhtGN1Qxi8sCxkPd4PKR2vOY6Hw9xoxRyrrh7yU/ZjTKIp8eg72GlTA5YMLcR
	 nHieC5NlTtnLX72iWaOmdD1SDHkbX2jo3AGeI4nRz22H94HgxQQWEiXzyBfD64a/Uk
	 e7QWvIsuOamZA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e829086f3so3749506e87.3;
        Tue, 02 Jul 2024 00:59:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe4nJ6wTKiB0KJdngoGTOumephFLWYtVUvMDREp690AXV4tjPUcSU0H1A6HOUH0OnlhAmZGTK0d9suwJUq7dmuqpHqZ3GYc8EL5A4OmKGQrN3JuXV5vf86nIpn79CIGvd3
X-Gm-Message-State: AOJu0YwILQiNM8oxw1BzPFt29iGKM2KAn9VWbZL5llkbOr0rvconFEX3
	5Qxpilau2NzhPYuTwNZosI6VQLSXFeERDz1nqyYjaOvMM4kyynbo7Cq0c2eO5GnxTyibmhMOZZJ
	xeudI7xhHA5TFWs+JgKyuFozVM1U=
X-Google-Smtp-Source: AGHT+IFQIO7P+0f/xwRO7CqbKfJQrjn6ZWG+0WnHt9AuSEIjhE2LvrTaCFizoo5fZkT0+Lv9dlaqLRx72RYTVpfsiFk=
X-Received: by 2002:a05:6512:3190:b0:52c:8a39:83d7 with SMTP id
 2adb3069b0e04-52e826fb0b7mr5727169e87.52.1719907167653; Tue, 02 Jul 2024
 00:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
In-Reply-To: <20240701173133.3283312-1-alan.maguire@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 2 Jul 2024 16:58:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
Message-ID: <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, nathan@kernel.org, 
	nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> Reproducible builds [1] require that the same source code with
> the same set of tools can build identical objects each time,
> but pahole in parallel mode was non-deterministic in
> BTF generation prior to
>
> dba7b5e ("pahole: Encode BTF serially in a reproducible build")
>
> This was a problem since said BTF is baked into kernels and modules in
> .BTF sections, so parallel pahole was causing non-reproducible binary
> generation.  Now with the above commit we have support for parallel
> reproducible BTF generation in pahole.
>
> KBUILD_BUILD_TIMESTAMP is set for reproducible builds, so if it
> is set, add reproducible_build to --btf_features.
>
> [1] Documentation/kbuild/reproducible-builds.rst
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>




Does not make sense.



KBUILD_BUILD_TIMESTAMP is not a switch for
"please enable the reproducible build".


KBUILD_BUILD_TIMESTAMP requires the build code
to use the given time in the output where timestamps are used.

Your patch does not use the timestamp at all.


If --btf_features=3Dreproducible_build has no downside,
please add it whenever supported.







> ---
>  scripts/Makefile.btf | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..40bb72662967 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -21,6 +21,10 @@ else
>  # Switch to using --btf_features for v1.26 and later.
>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  =3D -j --btf_features=
=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consisten=
t_func,decl_tag_kfuncs
>
> +ifneq ($(KBUILD_BUILD_TIMESTAMP),)
> +pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_features=3Dr=
eproducible_build
> +endif
> +
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D --btf_featu=
res=3Ddistilled_base
>  endif
> --
> 2.31.1
>


--=20
Best Regards
Masahiro Yamada

