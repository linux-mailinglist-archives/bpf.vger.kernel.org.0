Return-Path: <bpf+bounces-259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3766FCCF6
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C162812AF
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909A182D4;
	Tue,  9 May 2023 17:43:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F618019
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0856C433D2
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683654191;
	bh=o8vFoL97YE4HOnp7ussF25AUpcgng/STSBnSbhcPgNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hZWeQUZ4T7CEp2Wj98MF+KDqIZR4VwHfglIO41STkBU70CKXjQq9kPe2XI5FSSll+
	 5h+bdsFOnxVX/C8aTCxZhThN4PBwXXLVFmP3AJTylPu3tAItG5LXtirJiKfVJH9G9x
	 jGs6pMBuXGkiWgsy42cnU5uXnMPs9gj83NRr3o3a3XrM31g4spWSzK4N70SPthRS98
	 E+ClaLUtS5K27q1gHpWaQ+Sx2yb0S7/1jkgRi/UpoZGidvpQChdVX9AMT3Lb68zKK+
	 jpYPbIlTm5CBGquLzh3HQf9WZTSKNZ81qcHXUuxDinkkIMHJjowthNXR1HP0O0jBYB
	 +QaZ10Nf+DlRg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4eed764a10cso6851779e87.0
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 10:43:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDwOD7OR72cOQzZJMg/MsLdK2jCKJoPPVradJJh8s18+tEE4c4zH
	8SJeLf1Al20o6LEpZoLQiD78snwTvSVjcwb4nww=
X-Google-Smtp-Source: ACHHUZ7J5UUiTOkZqYusgHzZCThjuNNJTpxZ3xOiAzE0B2hLJrbH/lXP71RQR6TCj+Z1w/9VRpjds/sbBbjCOym870I=
X-Received: by 2002:ac2:53ae:0:b0:4f1:44c0:a921 with SMTP id
 j14-20020ac253ae000000b004f144c0a921mr1088344lfh.55.1683654189666; Tue, 09
 May 2023 10:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-3-laoar.shao@gmail.com>
In-Reply-To: <20230509151511.3937-3-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 May 2023 10:42:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
Message-ID: <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of
 selector in trampoline ksym
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
> After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
> is only used to indicate how many times the bpf trampoline image are
> updated and been displayed in the trampoline ksym name. After the
> trampoline is freed, the count will start from 0 again.
> So the count is a useless value to the user, we'd better
> show a more meaningful value like how many progs are linked to this
> trampoline. After that change, the selector can be removed eventally.
> If the user want to check whether the bpf trampoline image has been updat=
ed
> or not, the user can also compare the address. Each time the trampoline
> image is updated, the address will change consequently.

I wonder whether this will cause confusion to some users. Maybe the saving
doesn't worth the churn.

Song

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/bpf.h     | 1 -
>  kernel/bpf/trampoline.c | 7 ++-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 456f33b..36e4b2d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1125,7 +1125,6 @@ struct bpf_trampoline {
>         int progs_cnt[BPF_TRAMP_MAX];
>         /* Executable image of trampoline */
>         struct bpf_tramp_image *cur_image;
> -       u64 selector;
>         struct module *mod;
>  };
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 7067cdf..be37d87 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -410,11 +410,10 @@ static int bpf_trampoline_update(struct bpf_trampol=
ine *tr, bool lock_direct_mut
>                 err =3D unregister_fentry(tr, tr->cur_image->image);
>                 bpf_tramp_image_put(tr->cur_image);
>                 tr->cur_image =3D NULL;
> -               tr->selector =3D 0;
>                 goto out;
>         }
>
> -       im =3D bpf_tramp_image_alloc(tr->key, tr->selector);
> +       im =3D bpf_tramp_image_alloc(tr->key, total);
>         if (IS_ERR(im)) {
>                 err =3D PTR_ERR(im);
>                 goto out;
> @@ -451,8 +450,7 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
>
>         set_memory_rox((long)im->image, 1);
>
> -       WARN_ON(tr->cur_image && tr->selector =3D=3D 0);
> -       WARN_ON(!tr->cur_image && tr->selector);
> +       WARN_ON(tr->cur_image && total =3D=3D 0);
>         if (tr->cur_image)
>                 /* progs already running at this address */
>                 err =3D modify_fentry(tr, tr->cur_image->image, im->image=
, lock_direct_mutex);
> @@ -482,7 +480,6 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
>         if (tr->cur_image)
>                 bpf_tramp_image_put(tr->cur_image);
>         tr->cur_image =3D im;
> -       tr->selector++;
>  out:
>         /* If any error happens, restore previous flags */
>         if (err)
> --
> 1.8.3.1
>
>

