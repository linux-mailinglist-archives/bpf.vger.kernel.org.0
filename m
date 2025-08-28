Return-Path: <bpf+bounces-66807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0CB3982F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7335E8451
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED62DF6F4;
	Thu, 28 Aug 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu00wy5c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE816253F12
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373209; cv=none; b=D6Y/HE0D1Wb5bHSXLpp/pPexhgTg5jakOZil6cjUElPhvggng1rHtpJQNI2u2El2JEegGTXA1esU0k6VCU5BBMYwdGLKbTydF/IvFGTjD1rSJiPqa/RAsOkU6mCp40m7fNQxFnlhM4ZqZq41kQGjb3WHFYdNQzuCMDuggHZkwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373209; c=relaxed/simple;
	bh=snT81cutXnKAiftpW/DQUIB335yflaJxMphmU8w21Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeWeefmMz0eV24bwyc7rhaf1KqBEgiMnsieFKN+fjHcHw9BPdVUmu3JM/uFtECrBEjykABsSDAYBy6dWcjOh3LG1gobbM5lVbg3llSFRWr2/LHKNR9kHdxltlC90O5K/yEibONOQEBcE8WYu96tj8lI6dj0q4MBgHb+ZnQXHmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu00wy5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54056C4AF09
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756373209;
	bh=snT81cutXnKAiftpW/DQUIB335yflaJxMphmU8w21Gk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pu00wy5cderMEQ7qdS0ueLVyo+2kEFhBGFnh63A62Wh9w60RsBMNUULng/Fx9ul1W
	 4ST8bZzTFu7Vp2lYJsfBbXJc6G0X8+T4kBr7TmzhLCwctgYgqnsRAfbsxLEVdbREFJ
	 Xtf4Rm9jzXWL8vEncpW0uQkIFPQUfQboAqHaRgJVMCKi2tZ5NmXOclNhENN9CtCXtj
	 1beQjiUayAPiM7NfkcZ1HuR7HRkWyXx4d+CXHJeP0BCWY4O4C9maAe/6JyNFbOn1wU
	 6J5vRNAZb8hE/RE+qojW8B0s7Fvu1Qfk1WD6SkMQAppTt7mhvCzdXyDF7FJoC0pkOT
	 Zyml/Z/VpCnyg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78f5df4so113829266b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 02:26:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKmlNJdp3otH145O+G9MeWltkx7LdlyT1AdEOR+NcplBqX6hiVvRPBnXMsQuSdQe4lNT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddqipIjVOVsvtY/3/1aSR4/hr5T3w8oNriI3ObhG6izCMFpFy
	cg+WOCGZDcs0Yaz0j4/AuBoSpb8LTZfiF6b+mXJ9/bY/Ktich45jRooXpifvN6z5VTJlKN7GpBb
	NCItY1yLxbEFOmQ3nZZSpB6I1V3HvH34=
X-Google-Smtp-Source: AGHT+IFqcXoHtTbkCaL7Y0XQS+AuxhLLcyTPvJLS7GziQvbtvAv1gHtvwqwErgLC6XqMqiXor3MQp8jXO76Cd6WU6Hk=
X-Received: by 2002:a17:906:ecb5:b0:afe:7c3b:bc7d with SMTP id
 a640c23a62f3a-afe7c3bbe94mr1046517266b.41.1756373207894; Thu, 28 Aug 2025
 02:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827094733.426839-1-hengqi.chen@gmail.com> <20250827094733.426839-4-hengqi.chen@gmail.com>
In-Reply-To: <20250827094733.426839-4-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 28 Aug 2025 17:26:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5sBUjPhuPgpsMV-ywiKJX2-C3D1Re60FGiD9b207NddQ@mail.gmail.com>
X-Gm-Features: Ac12FXxpuOLwdb5wHwVGJeyOhsVW9p_DUzOkZT2bVBJC7AkQc3uJqN3sJTnAQZc
Message-ID: <CAAhV-H5sBUjPhuPgpsMV-ywiKJX2-C3D1Re60FGiD9b207NddQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] LoongArch: BPF: No support of struct argument in
 trampoline programs
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, duanchenghao@kylinos.cn, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	vincent.mc.li@gmail.com, bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:19=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> The current implementation does not support struct argument.
> This cause a oops when running bpf selftest:
>
>     $ ./test_progs -a tracing_struct
>     CPU -1 Unable to handle kernel paging request at virtual address 0000=
000000000018, era =3D=3D 90000000845659f4, ra =3D=3D 90000000845659e8
>     Oops[#1]:
>     CPU -1 Unable to handle kernel paging request at virtual address 0000=
000000000018, era =3D=3D 9000000085bef268, ra =3D=3D 90000000844f3938
>     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>     rcu:     1-...0: (19 ticks this GP) idle=3D1094/1/0x4000000000000000 =
softirq=3D1380/1382 fqs=3D801
>     rcu:     (detected by 0, t=3D5252 jiffies, g=3D1197, q=3D52 ncpus=3D4=
)
>     Sending NMI from CPU 0 to CPUs 1:
>     rcu: rcu_preempt kthread starved for 2495 jiffies! g1197 f0x0 RCU_GP_=
DOING_FQS(6) ->state=3D0x0 ->cpu=3D2
>     rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is =
now expected behavior.
>     rcu: RCU grace-period kthread stack dump:
>     task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2 =
     task_flags:0x208040 flags:0x00000800
>     Stack : 9000000100423e80 0000000000000402 0000000000000010 9000000100=
3b0680
>             9000000085d88000 0000000000000000 0000000000000040 9000000087=
159350
>             9000000085c2b9b0 0000000000000001 900000008704a000 0000000000=
000005
>             00000000ffff355b 00000000ffff355b 0000000000000000 0000000000=
000004
>             9000000085d90510 0000000000000000 0000000000000002 7b5d998f82=
81e86e
>             00000000ffff355c 7b5d998f8281e86e 000000000000003f 9000000087=
159350
>             900000008715bf98 0000000000000005 9000000087036000 9000000087=
04a000
>             9000000100407c98 90000001003aff80 900000008715c4c0 9000000085=
c2b9b0
>             00000000ffff355b 9000000085c33d3c 00000000000000b4 0000000000=
000000
>             9000000007002150 00000000ffff355b 9000000084615480 0000000007=
000002
>             ...
>     Call Trace:
>     [<9000000085c2a868>] __schedule+0x410/0x1520
>     [<9000000085c2b9ac>] schedule+0x34/0x190
>     [<9000000085c33d38>] schedule_timeout+0x98/0x140
>     [<90000000845e9120>] rcu_gp_fqs_loop+0x5f8/0x868
>     [<90000000845ed538>] rcu_gp_kthread+0x260/0x2e0
>     [<900000008454e8a4>] kthread+0x144/0x238
>     [<9000000085c26b60>] ret_from_kernel_thread+0x28/0xc8
>     [<90000000844f20e4>] ret_from_kernel_thread_asm+0xc/0x88
>
>     rcu: Stack dump where RCU GP kthread last ran:
>     Sending NMI from CPU 0 to CPUs 2:
>     NMI backtrace for cpu 2 skipped: idling at idle_exit+0x0/0x4
>
> Reject it for now.
Drop this patch or pick Tiezhu's patches as a single series?
https://lore.kernel.org/loongarch/20250821144302.14010-1-yangtiezhu@loongso=
n.cn/T/#t

Huacai

>
> Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
> Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c239e5ed0c92..66b102ed9874 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1514,6 +1514,12 @@ static int __arch_prepare_bpf_trampoline(struct ji=
t_ctx *ctx, struct bpf_tramp_i
>         if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
>                 return -ENOTSUPP;
>
> +       /* don't support struct argument */
> +       for (i =3D 0; i < m->nr_args; i++) {
> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> +                       return -ENOTSUPP;
> +       }
> +
>         if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)=
)
>                 return -ENOTSUPP;
>
> --
> 2.43.5
>
>
>

