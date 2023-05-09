Return-Path: <bpf+bounces-258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C86FCCE5
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230941C20C45
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028E182C7;
	Tue,  9 May 2023 17:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802AE182B4
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26193C4339E
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683654073;
	bh=kzc+jC8JehqrgV+7VYIzpZW/3jJlBUyEugMcULXAh7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CsDsNfitD3y6znyWswFlpVbSuHm0inzo14TuvD2e/hVBbCVzAqk2SSEsyDno1PRMy
	 NnkAEl76jUYtKtsnQa35gmajJhDpd3ImRR8LjgJd3I3xT4DbUgJxUfcIk7k8Vb2yAV
	 8W97nXn+wwW7TG5LY8NzO0DD+d4ijOxZLhrvsTes5oxM3N+YjKXldAa1DMe3ZCIE6b
	 iRv2Q8PYqRWBntpY6kyx/yYcYxwJrxm4IbzHUGwrLcTN0ww6s3064fBYgflwa6/ZAK
	 b6eYMqdd6yaYbq/Ozt8qrB9CICdbnKBlvEm3EiWn8khrH7v14jbCjSmoRW9I3a2Fvm
	 9g8TLuJIWalRA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso67422641fa.1
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 10:41:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDwXDIcyoapwxhlUfTLNnz/t3PCEUc3PevkesiR88gnH5Kx21dKa
	AhmmS+Qdk4Ha2gdC8NlqgzSRc987fnWEjxu4K1k=
X-Google-Smtp-Source: ACHHUZ453fHx0GCcUBxN5hoOVMvJjEd1hcPpOnUwUiI2tknbkRb11YPB14O5F8Nl7hqFR36aVZ+zgIVVi8UuBA10pbw=
X-Received: by 2002:a05:6512:409:b0:4f2:5442:511d with SMTP id
 u9-20020a056512040900b004f25442511dmr932337lfk.29.1683654071121; Tue, 09 May
 2023 10:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-2-laoar.shao@gmail.com>
In-Reply-To: <20230509151511.3937-2-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 May 2023 10:40:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com>
Message-ID: <CAPhsuW6oAdLo1ErAQaaJSMhoyPWreuHZ_FZzftR=U0ptfZ8SdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix memleak due to fentry attach failure
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 8:15=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> If it fails to attach fentry, the allocated bpf trampoline image will be
> left in the system. That can be verified by checking /proc/kallsyms.
>
> This meamleak can be verified by a simple bpf program as follows,
>
>   SEC("fentry/trap_init")
>   int fentry_run()
>   {
>       return 0;
>   }

Nice trick! We can build some interesting tests with trap_init.

>
> It will fail to attach trap_init because this function is freed after
> kernel init, and then we can find the trampoline image is left in the
> system by checking /proc/kallsyms.
>   $ tail /proc/kallsyms
>   ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
>   ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
>
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init=
'"
>   [2522] FUNC 'trap_init' type_id=3D119 linkage=3Dstatic
>
>   $ echo $((6442453466 & 0x7fffffff))
>   2522
>
> Note that there are two left bpf trampoline images, that is because the
> libbpf will fallback to raw tracepoint if -EINVAL is returned.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I guess we need:

 Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")

> ---
>  kernel/bpf/trampoline.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index ac021bc..7067cdf 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -251,6 +251,15 @@ static int register_fentry(struct bpf_trampoline *tr=
, void *new_addr)
>         return tlinks;
>  }
>
> +static void bpf_tramp_image_free(struct bpf_tramp_image *im)
> +{
> +       bpf_image_ksym_del(&im->ksym);
> +       bpf_jit_free_exec(im->image);
> +       bpf_jit_uncharge_modmem(PAGE_SIZE);
> +       percpu_ref_exit(&im->pcref);
> +       kfree(im);
> +}

Can we share some of this function with __bpf_tramp_image_put_deferred?

Thanks,
Song
[...]

