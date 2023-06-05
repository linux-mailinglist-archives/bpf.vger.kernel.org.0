Return-Path: <bpf+bounces-1843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE460722CA6
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650D91C20CDC
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4788BF5;
	Mon,  5 Jun 2023 16:30:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63D22638
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 16:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A5CC433A8;
	Mon,  5 Jun 2023 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685982625;
	bh=t4IRdJhZSZ4fmGSJrKCIhBfZnp3squLwB/GdU/2Wlc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IC/Jnt4VvgM03de+BlFN47sxt0oMyUm4kXzMUuoEOp8ouwIFtlSuRxpSRYZsKvnXL
	 BOpw6izY+O42TAuK6Ip8xrMzjMhOn2DHYCE4NjySokLp8KzgDQ7G/YF7XfCPT9jU3R
	 8+IprYxH0GTIWGwmuquswkiTXeifhWq5WiP81qFeMM98BemWqX+2N9Rubbc1CWP09j
	 RhCVwKgswa3L3ng9ypTHmMrV0+VY/FcFNuPe4PWjoYkChLiOwyi8uhBw8D6Z5h3exL
	 jQTWAmNqqfI+dRvS+YWBNf3W7ZJinUMLFLgSXOEo0Fchb7Bocsh0JlbK0zNCl2RaFa
	 rWIklBdqpgUTQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b1a6a8e851so56789131fa.2;
        Mon, 05 Jun 2023 09:30:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDymu1eaYYPjuPmIdjIIb7pguijKeYB6wWUzD333ajSfrAQlJ41v
	CBzAtik8CouGdcJwz2YK6XsJacg/WC6xq+C8hw4=
X-Google-Smtp-Source: ACHHUZ6HXtb+me/VrGrWZPVbdaHJhrqHvnOuMvAl6Vnsp8Y3eZX9EhOYAyzeze1NgDnLhg//KTnUG6qnbezjBA/07EM=
X-Received: by 2002:a2e:9989:0:b0:2b1:bd11:a71a with SMTP id
 w9-20020a2e9989000000b002b1bd11a71amr3583654lji.17.1685982622939; Mon, 05 Jun
 2023 09:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com> <20230605074024.1055863-2-puranjay12@gmail.com>
In-Reply-To: <20230605074024.1055863-2-puranjay12@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Jun 2023 09:30:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5+ija4umxAhOMk5mVGGCGV=iPBNm-QbhkVz99WHzrmsQ@mail.gmail.com>
Message-ID: <CAPhsuW5+ija4umxAhOMk5mVGGCGV=iPBNm-QbhkVz99WHzrmsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: make bpf_prog_pack allocator portable
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, catalin.marinas@arm.com, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> The bpf_prog_pack allocator currently uses module_alloc() and
> module_memfree() to allocate and free memory. This is not portable
> because different architectures use different methods for allocating
> memory for BPF programs. Like ARM64 uses vmalloc()/vfree().
>
> Use bpf_jit_alloc_exec() and bpf_jit_free_exec() for memory management
> in bpf_prog_pack allocator. Other architectures can override these with
> their implementation and will be able to use bpf_prog_pack directly.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/bpf/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7421487422d4..2bc9092bf9be 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -860,7 +860,7 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_f=
ill_hole_t bpf_fill_ill_ins
>                        GFP_KERNEL);
>         if (!pack)
>                 return NULL;
> -       pack->ptr =3D module_alloc(BPF_PROG_PACK_SIZE);
> +       pack->ptr =3D bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
>         if (!pack->ptr) {
>                 kfree(pack);
>                 return NULL;
> @@ -884,7 +884,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>         mutex_lock(&pack_mutex);
>         if (size > BPF_PROG_PACK_SIZE) {
>                 size =3D round_up(size, PAGE_SIZE);
> -               ptr =3D module_alloc(size);
> +               ptr =3D bpf_jit_alloc_exec(size);
>                 if (ptr) {
>                         bpf_fill_ill_insns(ptr, size);
>                         set_vm_flush_reset_perms(ptr);
> @@ -922,7 +922,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr=
)
>
>         mutex_lock(&pack_mutex);
>         if (hdr->size > BPF_PROG_PACK_SIZE) {
> -               module_memfree(hdr);
> +               bpf_jit_free_exec(hdr);
>                 goto out;
>         }
>
> @@ -946,7 +946,7 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr=
)
>         if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT=
, 0,
>                                        BPF_PROG_CHUNK_COUNT, 0) =3D=3D 0)=
 {
>                 list_del(&pack->list);
> -               module_memfree(pack->ptr);
> +               bpf_jit_free_exec(pack->ptr);
>                 kfree(pack);
>         }
>  out:
> --
> 2.39.2
>

