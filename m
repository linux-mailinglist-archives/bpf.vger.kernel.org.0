Return-Path: <bpf+bounces-15799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1F7F6CE3
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837D01C20E67
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A05249;
	Fri, 24 Nov 2023 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXL1CaCl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D54420
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F02C433CB
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700810688;
	bh=xCbgDYZqN0pSPclWKxhSGGY43y7v590LI0hZp9BtOys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JXL1CaClHmR98ElsDWgNDQTTMXpMzOwuIj8SPdY5cs5Gn3+0gynjexfdnTW0miNJx
	 4NlYtEDO7M76ut4TBANE+i4gtvW1PIx0Dg5mALtitj8hbarUkA6k/RFvTTVeUDPFER
	 akaiE07zuNzP3Ny2dYhHJDRCGsLQ7WRa18naVXriD6IrkToGxtZ1aOdo26shABcjvZ
	 6GN2EgHMMMtKnfXFjfjwuTXb0DhVjnQfbNANcQnATbgM9AIritnrugvsu/fp4W5O1t
	 RUNsml5B7YstVAoKWYTALNG4tzH3rqSU8wDvluMNrUPvQENxC5rjChl2oVzuJRJFkD
	 Par6gNcVDIokw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507a5f2193bso1651054e87.1
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 23:24:47 -0800 (PST)
X-Gm-Message-State: AOJu0YyRweMXUsRX7jK4mRsy7AV5kr50Cl7tMYubO6IR/6CaBEBOjlCz
	s1b/UiIHvLCsq53NGw20BnZPGE2RtV0dgfx8lXs=
X-Google-Smtp-Source: AGHT+IHwKjWFErda4FH4nd2utWTTBs57aUO0/O0wwLLBHsDJWZOUF3Koy4FnZ9DWz8XPxIhaZjQhMsQwGT0Qg8yZZfY=
X-Received: by 2002:a05:6512:2243:b0:50a:a327:4ade with SMTP id
 i3-20020a056512224300b0050aa3274ademr1937554lfu.8.1700810686189; Thu, 23 Nov
 2023 23:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122191816.5572-1-9erthalion6@gmail.com>
In-Reply-To: <20231122191816.5572-1-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 23 Nov 2023 23:24:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
Message-ID: <CAPhsuW6Zj4-CuBeQmsp9j-CjAE3j1bMF_RUUQM85m60yFT0nxg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:22=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.=
com> wrote:
>
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
>
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed. To

If prog B attached to prog A, and prog C attached to prog B, then we
detach B. At this point, can we re-attach B to A?

> implement, add a new field into bpf_prog_aux to track the fact of
> attachment in the target prog.
>
[...]

>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3235,6 +3238,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>         if (err)
>                 goto out_unlock;
>
> +       if (tgt_prog) {
> +               /* Bookkeeping for managing the prog attachment chain. */
> +               tgt_prog->aux->follower_cnt++;
> +               prog->aux->attach_depth =3D tgt_prog->aux->attach_depth +=
 1;
> +       }
> +

attach_depth is calculated at attach time, so...

>         err =3D bpf_trampoline_link_prog(&link->link, tr);
>         if (err) {
>                 bpf_link_cleanup(&link_primer);
> @@ -4509,6 +4518,7 @@ static int bpf_prog_get_info_by_fd(struct file *fil=
e,
>         if (prog->aux->btf)
>                 info.btf_id =3D btf_obj_id(prog->aux->btf);
>         info.attach_btf_id =3D prog->aux->attach_btf_id;
> +       info.attach_depth =3D prog->aux->attach_depth;
>         if (attach_btf)
>                 info.attach_btf_obj_id =3D btf_obj_id(attach_btf);
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9ae6eae13471..de058a83d769 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20329,6 +20329,12 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>         if (tgt_prog) {
>                 struct bpf_prog_aux *aux =3D tgt_prog->aux;
>
> +               if (aux->attach_depth >=3D 32) {
> +                       bpf_log(log, "Target program attach depth is %d. =
Too large\n",
> +                                       aux->attach_depth);
> +                       return -EINVAL;
> +               }
> +

(continue from above) attach_depth is always 0 at program load time, no?

Thanks,
Song

>                 if (bpf_prog_is_dev_bound(prog->aux) &&
>                     !bpf_prog_dev_bound_match(prog, tgt_prog)) {
>                         bpf_log(log, "Target program bound device mismatc=
h");
> @@ -20367,9 +20373,16 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>                         bpf_log(log, "Can attach to only JITed progs\n");
>                         return -EINVAL;
>                 }
[...]

