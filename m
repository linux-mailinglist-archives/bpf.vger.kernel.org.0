Return-Path: <bpf+bounces-4568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F75E74CC70
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 07:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A991C2090F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201E3C25;
	Mon, 10 Jul 2023 05:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AD23CE
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 05:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF2C433D9;
	Mon, 10 Jul 2023 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688968491;
	bh=5bo3Dd1S/+UX7zKX7SU1eVf31BEHvcpAG9FLa5nnBkc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hPn6f7tiRIl6O3bjLxUjlDrP1U+Q6T7MR6V5pMw0hfvhRAi66DsEgFcyqOoxNzFfM
	 g/9jYTDvUt7NXkIyaZNjXRe+T5UCHmqAIAoWEFBLNSYMSdys8Jkro6KAGcqBkkDgcg
	 wy/jO9Two/zAxxTTX2QA3OHQBvDyrUY+tFwVB4lw6X6zgzQ45+m4ya4qlz6MR6OQCl
	 Uj8bWAwt8Z2vuiiLf8Fzat5byW1XQen+nY04iwqGj6XcqffdfSkq7cVBLQfWlKGTZw
	 wmvbqPFEU3NcOosIW954LwhBYNqe1Xzoi7XFfruxfjJTTWaYBokrJKE+LfECOQ4AaZ
	 IffHKgEbJ5IzQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so48579511fa.2;
        Sun, 09 Jul 2023 22:54:51 -0700 (PDT)
X-Gm-Message-State: ABy/qLahdTJoExJGtCIgblLrU654TmZunkI/2VQIY1Mf55WwC7sns/wL
	GxT0bQwGD4XQKJMhUGeJticC8yEPEJAuqV7aNxY=
X-Google-Smtp-Source: APBJJlFAeRupkRBF6nv00OnjiXB1Q4Wb23ZbuARfTFW1WElFD40u6AjhzB2s7kDTNHYx/CIFbLiRYKNSdHdoJSZDha0=
X-Received: by 2002:a05:6512:110e:b0:4fb:7665:9b0d with SMTP id
 l14-20020a056512110e00b004fb76659b0dmr10569131lfg.12.1688968489141; Sun, 09
 Jul 2023 22:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
 <20230710052750.259595-1-jianghaoran@kylinos.cn>
In-Reply-To: <20230710052750.259595-1-jianghaoran@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Jul 2023 13:54:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
Message-ID: <CAAhV-H7orsUHDZuwcTUeWYbizcWRG4k_BPy53W7PT_MQ_2SXgw@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Fix compilation failure for samples/bpf
 on LoongArch Fedora
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kernel@xen0n.name, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, loongarch@lists.linux.dev, 
	martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	sdf@google.com, song@kernel.org, trix@redhat.com, yangtiezhu@loongson.cn, 
	yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Mon, Jul 10, 2023 at 1:34=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.c=
n> wrote:
>
> When building the latest samples/bpf on LoongArch Fedora
>
>      make M=3Dsamples/bpf
>
> There are compilation errors as follows:
>
> In file included from ./linux/samples/bpf/sockex2_kern.c:2:
> In file included from ./include/uapi/linux/in.h:25:
> In file included from ./include/linux/socket.h:8:
> In file included from ./include/linux/uio.h:9:
> In file included from ./include/linux/thread_info.h:60:
> In file included from ./arch/loongarch/include/asm/thread_info.h:15:
> In file included from ./arch/loongarch/include/asm/processor.h:13:
> In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
> ./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin=
.h' file not found
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>
> larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
> and the header file location is specified at compile time.
>
> Test on LoongArch Fedora:
> https://github.com/fedora-remix-loongarch/releases-info
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>
> ---
> v2:
> use LoongArch instead of Loongarch in the title and commit message.
> ---
>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 615f24ebc49c..b301796a3862 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
>         @echo "  CLANG-bpf " $@
>         $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS=
) \
>                 -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
> -               -I$(LIBBPF_INCLUDE) \
> +               -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>                 -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-poi=
nter-sign \
>                 -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-=
types \
>                 -Wno-gnu-variable-sized-type-not-at-end \
> --
> 2.27.0
>
>

