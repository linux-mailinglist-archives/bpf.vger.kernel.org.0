Return-Path: <bpf+bounces-18807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98DE82227F
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595C1C22AD0
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B516402;
	Tue,  2 Jan 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhcj0DAF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFE16406
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F31C433C8
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704227047;
	bh=FZWUYErUJyB3Eu2XTiki9Bx++2IWyXFZE37lJ44cyKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hhcj0DAFcbIeWlqrbNMMU++jE7gqOABCa36ZHeioM0riRdlNPQ0VNzcwefkY43Kdx
	 Fs3PJu7g6iZ8C8yAZvq8q1OqTCQY2iGttESi9awKtZeS5HOgiUsdyjryFtwVZj5lm1
	 lzDspMv3hxWTc8hL/6Z2yyEyrwYWi8hpvaH4Ml136XBHg1m7k4RC8/1Ws7yqGuhinI
	 Q2HlEDUm8jSpHaPcK/E2lHspgFBVwVOh4NutHfwIYBgBsS7J+zOTYG37fcZqK8MT0d
	 l7u7NG9YJS/PT/qh2J5x8azo+yZClPfQeHqNW9frZ41r7Jc4I8fwIecd3ekmlbLIKN
	 +uEzDdaBHSXGg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7dff3e9fso6941432e87.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 12:24:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzCxTfUIpNDBRDC0Jiab3N+QvUijOe8bvIRdk6kq2v1oT2c0Xiv
	RGSUOzC+fV7eFMKY/sD8u8fNlbCjCfTRc4C3eC8=
X-Google-Smtp-Source: AGHT+IHXVco3ZELqyaphQg52r5A98+OeSMMZZTeL0fXskJyAxj1BBzvGyPi8fANjZbG4TYq505gV15Q4uSQq9QR8EgY=
X-Received: by 2002:a05:6512:3747:b0:50b:d764:87ff with SMTP id
 a7-20020a056512374700b0050bd76487ffmr6241615lfs.75.1704227045272; Tue, 02 Jan
 2024 12:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222151153.31291-1-9erthalion6@gmail.com> <20231222151153.31291-4-9erthalion6@gmail.com>
In-Reply-To: <20231222151153.31291-4-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 12:23:54 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5ZcyUCpeoNLCSw9ggPev6NTR2p+6--f6YLyhQT3of-QQ@mail.gmail.com>
Message-ID: <CAPhsuW5ZcyUCpeoNLCSw9ggPev6NTR2p+6--f6YLyhQT3of-QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 3/4] bpf: Fix re-attachment branch in bpf_tracing_prog_attach
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:12=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> From: Jiri Olsa <olsajiri@gmail.com>
>
> The following case can cause a crash due to missing attach_btf:
>
> 1) load rawtp program
> 2) load fentry program with rawtp as target_fd
> 3) create tracing link for fentry program with target_fd =3D 0
> 4) repeat 3
>
> In the end we have:
>
> - prog->aux->dst_trampoline =3D=3D NULL
> - tgt_prog =3D=3D NULL (because we did not provide target_fd to link_crea=
te)
> - prog->aux->attach_btf =3D=3D NULL (the program was loaded with attach_p=
rog_fd=3DX)
> - the program was loaded for tgt_prog but we have no way to find out whic=
h one
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000058
>     Call Trace:
>      <TASK>
>      ? __die+0x20/0x70
>      ? page_fault_oops+0x15b/0x430
>      ? fixup_exception+0x22/0x330
>      ? exc_page_fault+0x6f/0x170
>      ? asm_exc_page_fault+0x22/0x30
>      ? bpf_tracing_prog_attach+0x279/0x560
>      ? btf_obj_id+0x5/0x10
>      bpf_tracing_prog_attach+0x439/0x560
>      __sys_bpf+0x1cf4/0x2de0
>      __x64_sys_bpf+0x1c/0x30
>      do_syscall_64+0x41/0xf0
>      entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Return -EINVAL in this situation.
>
> Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Acked-by: Song Liu <song@kernel.org>

I guess we also need:

Fixes: f3a95075549e0 ("bpf: Allow trampoline re-attach for tracing and
lsm programs")
Cc: stable@vger.kernel.org

> ---
>  kernel/bpf/syscall.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c40cad8886e9..5096ddfbe426 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3201,6 +3201,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>          *
>          * - if prog->aux->dst_trampoline and tgt_prog is NULL, the progr=
am
>          *   was detached and is going for re-attachment.
> +        *
> +        * - if prog->aux->dst_trampoline is NULL and tgt_prog and prog->=
aux->attach_btf
> +        *   are NULL, then program was already attached and user did not=
 provide
> +        *   tgt_prog_fd so we have no way to find out or create trampoli=
ne
>          */
>         if (!prog->aux->dst_trampoline && !tgt_prog) {
>                 /*
> @@ -3214,6 +3218,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>                         err =3D -EINVAL;
>                         goto out_unlock;
>                 }
> +               /* We can allow re-attach only if we have valid attach_bt=
f. */
> +               if (!prog->aux->attach_btf) {
> +                       err =3D -EINVAL;
> +                       goto out_unlock;
> +               }
>                 btf_id =3D prog->aux->attach_btf_id;
>                 key =3D bpf_trampoline_compute_key(NULL, prog->aux->attac=
h_btf, btf_id);
>         }
> --
> 2.41.0
>

