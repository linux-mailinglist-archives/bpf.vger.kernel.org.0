Return-Path: <bpf+bounces-8527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6795787AB8
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 23:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575AE2816D0
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81DA94A;
	Thu, 24 Aug 2023 21:57:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBA8832
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 21:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A3C43395;
	Thu, 24 Aug 2023 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692914267;
	bh=e+pZg3YWlkmDjnHujmmDX7rt4Bs00zVl5lffsKGqixE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RO6AyNNvqwZ+P080BIF/6nYsI41LvCuKLA1coiIsm51N5UDfZV7DEIiBaIAcvGN4w
	 7dJWZ/nrQ/9yEm/B+oT+S8dx4egAM6UaGo0NorCryjcPZDus8iGGa/ZlWnzIM+9ccV
	 8x+Vjc1gUKDfKwgd9clNZlHvwh2XE4v54nmgGnCSS//+kW18QiiK+87+Rfn55C5aD5
	 jFiHWTV8+s9YkNReWz1NIf627Z6vmYHczgmVVtA1gh3G6gGGKYMQLdAM6gif2+gN/o
	 epCl9hmIe/FQ+f5qnBv0/jR9HUf9Jjisc5hqlueo0uavb9q9Ud+38zvDDMdx0iN6fl
	 NixvlW0KOVYxg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4ff88239785so425606e87.0;
        Thu, 24 Aug 2023 14:57:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YyREw5dnpT0ChnBGBQ2n115tDGY2sSWztTWHty0TMamzC4Rvi0Y
	34uH+KVxdV0u0yXsaOCvMQ+iDQxjcGSqzxMl0Xw=
X-Google-Smtp-Source: AGHT+IHUeqKrf7kvSRY1DSALjp7e8C7fW1mUoYIBbnPTxuhFD3DIzgE8FiXJUxiEjA2LaHmF06aq7QlPyQZAVjmOQno=
X-Received: by 2002:a05:6512:b03:b0:500:8fc1:8aba with SMTP id
 w3-20020a0565120b0300b005008fc18abamr7377893lfu.26.1692914265000; Thu, 24 Aug
 2023 14:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com> <20230824133135.1176709-2-puranjay12@gmail.com>
In-Reply-To: <20230824133135.1176709-2-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 24 Aug 2023 14:57:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5mMQbZ729W_5fhX0iYaNxG5JA1L7Sck-h0jQZQzEH8+Q@mail.gmail.com>
Message-ID: <CAPhsuW5mMQbZ729W_5fhX0iYaNxG5JA1L7Sck-h0jQZQzEH8+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] riscv: extend patch_text_nosync() for
 multiple pages
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, yhs@fb.com, 
	kpsingh@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 6:31=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> The patch_insn_write() function currently doesn't work for multiple
> pages of instructions, therefore patch_text_nosync() will fail with a
> page fault if called with lengths spanning multiple pages.
>
> This commit extends the patch_insn_write() function to support multiple
> pages by copying at max 2 pages at a time in a loop. This implementation
> is similar to text_poke_copy() function of x86.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/kernel/patch.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 575e71d6c8ae..465b2eebbc37 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -53,12 +53,18 @@ static void patch_unmap(int fixmap)
>  }
>  NOKPROBE_SYMBOL(patch_unmap);
>
> -static int patch_insn_write(void *addr, const void *insn, size_t len)
> +static int __patch_insn_write(void *addr, const void *insn, size_t len)
>  {
>         void *waddr =3D addr;
>         bool across_pages =3D (((uintptr_t) addr & ~PAGE_MASK) + len) > P=
AGE_SIZE;
>         int ret;
>
> +       /*
> +        * Only two pages can be mapped at a time for writing.
> +        */
> +       if (len > 2 * PAGE_SIZE)
> +               return -EINVAL;

This check cannot guarantee __patch_insn_write touch at most two pages.
Maybe use

    if (len + offset_in_page(addr) > 2 * PAGE_SIZE)
        return -EINVAL;
?

Thanks,
Song

>         /*
>          * Before reaching here, it was expected to lock the text_mutex
>          * already, so we don't need to give another lock here and could
> @@ -74,7 +80,7 @@ static int patch_insn_write(void *addr, const void *ins=
n, size_t len)
>                 lockdep_assert_held(&text_mutex);
>
>         if (across_pages)
> -               patch_map(addr + len, FIX_TEXT_POKE1);
> +               patch_map(addr + PAGE_SIZE, FIX_TEXT_POKE1);
>
>         waddr =3D patch_map(addr, FIX_TEXT_POKE0);
>
> @@ -87,15 +93,38 @@ static int patch_insn_write(void *addr, const void *i=
nsn, size_t len)
>
>         return ret;
>  }
> -NOKPROBE_SYMBOL(patch_insn_write);
> +NOKPROBE_SYMBOL(__patch_insn_write);
>  #else
> -static int patch_insn_write(void *addr, const void *insn, size_t len)
> +static int __patch_insn_write(void *addr, const void *insn, size_t len)
>  {
>         return copy_to_kernel_nofault(addr, insn, len);
>  }
> -NOKPROBE_SYMBOL(patch_insn_write);
> +NOKPROBE_SYMBOL(__patch_insn_write);
>  #endif /* CONFIG_MMU */
>
> +static int patch_insn_write(void *addr, const void *insn, size_t len)
> +{
> +       size_t patched =3D 0;
> +       size_t size;
> +       int ret =3D 0;
> +
> +       /*
> +        * Copy the instructions to the destination address, two pages at=
 a time
> +        * because __patch_insn_write() can only handle len <=3D 2 * PAGE=
_SIZE.
> +        */
> +       while (patched < len && !ret) {
> +               size =3D min_t(size_t,
> +                            PAGE_SIZE * 2 - offset_in_page(addr + patche=
d),
> +                            len - patched);
> +               ret =3D __patch_insn_write(addr + patched, insn + patched=
, size);
> +
> +               patched +=3D size;
> +       }
> +
> +       return ret;
> +}
> +NOKPROBE_SYMBOL(patch_insn_write);
> +
>  int patch_text_nosync(void *addr, const void *insns, size_t len)
>  {
>         u32 *tp =3D addr;
> --
> 2.39.2
>

