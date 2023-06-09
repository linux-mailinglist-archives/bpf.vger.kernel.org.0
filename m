Return-Path: <bpf+bounces-2236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A25729FFA
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365B31C2107F
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC763200AB;
	Fri,  9 Jun 2023 16:18:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DC1F170
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9FFC433D2
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686327520;
	bh=y/NLPStdjHXOY9tLILE9ZTascDRnEQIVVeYfYgY8l9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WmdC6rB9cMbgglFNrsXSpYkHwqtdOh7qaRBq3UgeLYuMi35e+MFliVLP2QtEfdSAR
	 9w6mcTL6S1j1JybmomWbnohZ0fOlYEyAguVS+xe41JfggHevGY6/EZ82dCeO5ebrvT
	 Jm1zOp1KhEYkYaVvevj2n8mYkYkU3+yLX1bheMr6UeotP8n8ltqW1WQJtqAkdIJqHp
	 wbYgkAIwEePoKLbm3adCXc0ytjYo50JwZBR5Z441c/OFCs1oFe54GF1DW39iRkwqUH
	 gCVKNBV3sGfiPm/rsGuFS5c1rJFnM9xffT93+AYWKuDWe3P6CEKYuSWOayURUiowr4
	 xxP3rn3SODtlQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so22128821fa.2
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 09:18:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDyC47F77rXmeq6/zBENPUur0o2J69AmBQ+YrHhXrmqf/AToINUY
	uxD3usT0rjL9utNAkeScytyYOuAGIFN9UfWbYm0=
X-Google-Smtp-Source: ACHHUZ5eERdFQNcqeXGt+pKGs5hiAu/baiJPP3EC7r7sfdZsWV1TjUb4XUbAplEq91UZtwlKklBQAtEwTT2/YXCjpHw=
X-Received: by 2002:a2e:9b11:0:b0:2b0:5a04:a5bd with SMTP id
 u17-20020a2e9b11000000b002b05a04a5bdmr1401660lji.42.1686327518851; Fri, 09
 Jun 2023 09:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609005439.3173569-1-yhs@fb.com>
In-Reply-To: <20230609005439.3173569-1-yhs@fb.com>
From: Song Liu <song@kernel.org>
Date: Fri, 9 Jun 2023 09:18:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6n4h3GHC1Hz_enEj4jLQrYJb_kYBKLN0qy3Cnu4G5W5w@mail.gmail.com>
Message-ID: <CAPhsuW6n4h3GHC1Hz_enEj4jLQrYJb_kYBKLN0qy3Cnu4G5W5w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.
To: Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 8, 2023 at 5:54=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> The sysctl net/core/bpf_jit_enable does not work now due to Commit
> 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc").
> The commit saved the jitted insns into 'rw_image' instead of 'image'
> which caused bpf_jit_dump not dumping proper content.
>
> With 'echo 2 > /proc/sys/net/core/bpf_jit_enable', run
> './test_progs -t fentry_test'. Without this patch, one of jitted
> image for one particular prog is:
>   flen=3D17 proglen=3D92 pass=3D4 image=3D0000000014c64883 from=3Dtest_pr=
ogs pid=3D1807
>   00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   00000030: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   00000040: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>   00000050: cc cc cc cc cc cc cc cc cc cc cc cc
>
> With this patch, the jitte image for the same prog is:
>   flen=3D17 proglen=3D92 pass=3D4 image=3D00000000b90254b7 from=3Dtest_pr=
ogs pid=3D1809
>   00000000: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3
>   00000010: 0f 1e fa 31 f6 48 8b 57 00 48 83 fa 07 75 2b 48
>   00000020: 8b 57 10 83 fa 09 75 22 48 8b 57 08 48 81 e2 ff
>   00000030: 00 00 00 48 83 fa 08 75 11 48 8b 7f 18 be 01 00
>   00000040: 00 00 48 83 ff 0a 74 02 31 f6 48 bf 18 d0 14 00
>   00000050: 00 c9 ff ff 48 89 77 00 31 c0 c9 c3
>
> Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!
Song

> ---
>  arch/x86/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 1056bbf55b17..438adb695daa 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2570,7 +2570,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
>         }
>
>         if (bpf_jit_enable > 1)
> -               bpf_jit_dump(prog->len, proglen, pass + 1, image);
> +               bpf_jit_dump(prog->len, proglen, pass + 1, rw_image);
>
>         if (image) {
>                 if (!prog->is_func || extra_pass) {
> --
> 2.34.1
>
>

