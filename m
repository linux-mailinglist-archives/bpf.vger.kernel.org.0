Return-Path: <bpf+bounces-20618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4284116F
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CD8B217D3
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22813F9E3;
	Mon, 29 Jan 2024 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN9f5VGw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252033F9CE;
	Mon, 29 Jan 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551094; cv=none; b=e8dW/BSyWzXiDMb0n6TPVm9Nrbo65MLRvIobUrdCk0VxsbT2eU8oBOAA3TmLZRL4Wnu5YpH3RrNoygopsN+nNHz7uD6JpVexcZpQJ4tNUfBDv0fkAGGFuqVYLIZSdOLqsOdMX1C+OYFMpXQViJ36+vUlP2d2EZ31oKaiis2hFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551094; c=relaxed/simple;
	bh=6DH4cAVVB5IcyXxT68rpRBwUIyW1lmrOSidCGZgTXeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAvcWcA5ZFvykeTIQA3PLZr2ySI1Mb1VZGghkgIK1uD8xw0VAVlvtsNdS/cV+OFHlR+RnDISbmiRmESUgnRxeRD7dMXcunZB5ddIvdGpNQ26vPkgwR0Q4I0eiiUH0E6dYiVgHGPjTm/ujX0BfYCZjTgV3oVPQjVzu4xPTN/I4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN9f5VGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBD9C433C7;
	Mon, 29 Jan 2024 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706551093;
	bh=6DH4cAVVB5IcyXxT68rpRBwUIyW1lmrOSidCGZgTXeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tN9f5VGwGgojQP6IzYYRXYugWHQwG78L4hEUcTUhpoilWnsUKCxiFkP0+ypaB6m5y
	 6oX+4SEwBtP9ZMs7qwnlTFqS8G+97GIDjDJmq1og3W6X922gic3QO9hCYdP83NkjaM
	 FJfmIgPqOhs+jDrvktT7s+EpjvqfIOpPFc7WmdK18CAO3Aq/58ed9KvNQufLQopgsk
	 X7vKbWX+/NFrq5ez5XyKIxVrdUqlezQHb2OGwF9qg4T0aVe8jXpm1WQcY82QHNzQeO
	 yQsEbA22uVkF85AbBRrUyfkBOWQ7ORjNpjKId7CXSjX2gwvozuQJ/tlJwhj7pPZrEV
	 JRtYViUiM5kRw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-510218c4a0eso3699737e87.1;
        Mon, 29 Jan 2024 09:58:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8TE6MpneNCD3PnF7j5L3eMUY5C0TQJ3fLSp2DY/maF5w/E/Vs
	1mmgwB1NbkQC32oJ4nt9gyqXUxYZWnOLv7RT5ztnYbKpdCuEvWhNvf95ZFGakxfoI6YVgCiEvPD
	asMb+KHwIkUV/fv4q78CZLTp8/Yo=
X-Google-Smtp-Source: AGHT+IF+SMAtsL8GekK8AArEA+PlT6pcaQajQuzdNtzKFztkBVunkhn84LwsBdVN1dgRWBtHedf519s3rYYkb+uEYbQ=
X-Received: by 2002:a19:6414:0:b0:510:16ef:14cf with SMTP id
 y20-20020a196414000000b0051016ef14cfmr2319781lfb.31.1706551091851; Mon, 29
 Jan 2024 09:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123103241.2282122-1-pulehui@huaweicloud.com> <20240123103241.2282122-3-pulehui@huaweicloud.com>
In-Reply-To: <20240123103241.2282122-3-pulehui@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 29 Jan 2024 09:58:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW67c8NYxBhwrq8JK8HP95P1Wwq1zHEDqooAOgP+aru13g@mail.gmail.com>
Message-ID: <CAPhsuW67c8NYxBhwrq8JK8HP95P1Wwq1zHEDqooAOgP+aru13g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Keep im address consistent between dry
 run and real patching
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> In __arch_prepare_bpf_trampoline, we emit instructions to store the
> address of im to register and then pass it to __bpf_tramp_enter and
> __bpf_tramp_exit functions. Currently we use fake im in
> arch_bpf_trampoline_size for the dry run, and then allocate new im for
> the real patching. This is fine for architectures that use fixed
> instructions to generate addresses. However, for architectures that use
> dynamic instructions to generate addresses, this may make the front and
> rear images inconsistent, leading to patching overflow. We can extract
> the im allocation ahead of the dry run and pass the allocated im to
> arch_bpf_trampoline_size, so that we can ensure that im is consistent in
> dry run and real patching.

IIUC, this is required because emit_imm() for riscv may generate variable
size instructions (depends on the value of im). I wonder we can fix this by
simply set a special value for fake im in arch_bpf_trampoline_size() to
so that emit_imm() always gives biggest value for the fake im.

>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
[...]
>
>  static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_di=
rect_mutex)
> @@ -432,23 +425,27 @@ static int bpf_trampoline_update(struct bpf_trampol=
ine *tr, bool lock_direct_mut
>                 tr->flags |=3D BPF_TRAMP_F_ORIG_STACK;
>  #endif
>
> -       size =3D arch_bpf_trampoline_size(&tr->func.model, tr->flags,
> +       im =3D kzalloc(sizeof(*im), GFP_KERNEL);
> +       if (!im) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       size =3D arch_bpf_trampoline_size(im, &tr->func.model, tr->flags,
>                                         tlinks, tr->func.addr);
>         if (size < 0) {
>                 err =3D size;
> -               goto out;
> +               goto out_free_im;
>         }
>
>         if (size > PAGE_SIZE) {
>                 err =3D -E2BIG;
> -               goto out;
> +               goto out_free_im;
>         }
>
> -       im =3D bpf_tramp_image_alloc(tr->key, size);
> -       if (IS_ERR(im)) {
> -               err =3D PTR_ERR(im);
> -               goto out;
> -       }
> +       err =3D bpf_tramp_image_alloc(im, tr->key, size);
> +       if (err < 0)
> +               goto out_free_im;

I feel this change just makes bpf_trampoline_update() even
more confusing.

>
>         err =3D arch_prepare_bpf_trampoline(im, im->image, im->image + si=
ze,
>                                           &tr->func.model, tr->flags, tli=
nks,
> @@ -496,6 +493,8 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
>
>  out_free:
>         bpf_tramp_image_free(im);
> +out_free_im:
> +       kfree_rcu(im, rcu);

If we goto out_free above, we will call kfree_rcu(im, rcu)
twice, right? Once in bpf_tramp_image_free(), and again
here.

Thanks,
Song

[...]

