Return-Path: <bpf+bounces-10985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539737B0BF4
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 286F8B20BFF
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3134CFB8;
	Wed, 27 Sep 2023 18:29:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D283C6B5
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 18:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B9FC433C8;
	Wed, 27 Sep 2023 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695839360;
	bh=SahC0vJPaR06EIyhl7bYAYq0o8AcWUi2oCgNtBjoOwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NMDs/DSv0VthIXSde4jsMbQZB8o6miXt1Xzttbrsozx3KSJkEmjxNiLXagBEYpjZg
	 ajB4Z7kBB0TzDE3hKWYPqNj1j+XAHC7NYzOKlsnf0AdZ7eKbMmglTKyZb7By/JdwKH
	 +flyM/tjzYqblwgJy2IGxMaY+Jlgz9/BwvRdLjvYc3c0oUz7HGyU6oqoW4NfZleA/M
	 UxumS8xGGXJOkOqR1y5/MNu/ssd1PZBlInIeCPdweZ2I336OOUFm8NdZNzln6mV4l1
	 vHntZYOWUNieDK9UhW5bPL2i3nZyAycGmHTOWblbUQRN8eCt03fntjJhbcNC645XKQ
	 SExgXWtPIMmcQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com, iii@linux.ibm.com, Song Liu
 <song@kernel.org>
Subject: Re: [PATCH v3 bpf-next 2/8] bpf: Let bpf_prog_pack_free handle any
 pointer
In-Reply-To: <20230926190020.1111575-3-song@kernel.org>
References: <20230926190020.1111575-1-song@kernel.org>
 <20230926190020.1111575-3-song@kernel.org>
Date: Wed, 27 Sep 2023 20:29:01 +0200
Message-ID: <87pm23cvwy.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> Currently, bpf_prog_pack_free only can only free pointer to struct
> bpf_binary_header, which is not flexible. Add a size argument to
> bpf_prog_pack_free so that it can handle any pointer.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
> ---
>  include/linux/filter.h  |  2 +-
>  kernel/bpf/core.c       | 21 ++++++++++-----------
>  kernel/bpf/dispatcher.c |  5 +----
>  3 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 27406aee2d40..eda9efe20026 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1073,7 +1073,7 @@ struct bpf_binary_header *
>  bpf_jit_binary_pack_hdr(const struct bpf_prog *fp);
>=20=20
>  void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_ins=
ns);
> -void bpf_prog_pack_free(struct bpf_binary_header *hdr);
> +void bpf_prog_pack_free(void *ptr, u32 size);
>=20=20
>  static inline bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *f=
p)
>  {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 08626b519ce2..fcdf710e6a32 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -928,20 +928,20 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_ho=
le_t bpf_fill_ill_insns)
>  	return ptr;
>  }
>=20=20
> -void bpf_prog_pack_free(struct bpf_binary_header *hdr)
> +void bpf_prog_pack_free(void *ptr, u32 size)
>  {
>  	struct bpf_prog_pack *pack =3D NULL, *tmp;
>  	unsigned int nbits;
>  	unsigned long pos;
>=20=20
>  	mutex_lock(&pack_mutex);
> -	if (hdr->size > BPF_PROG_PACK_SIZE) {
> -		bpf_jit_free_exec(hdr);
> +	if (size > BPF_PROG_PACK_SIZE) {
> +		bpf_jit_free_exec(ptr);
>  		goto out;
>  	}
>=20=20
>  	list_for_each_entry(tmp, &pack_list, list) {
> -		if ((void *)hdr >=3D tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > (vo=
id *)hdr) {
> +		if (ptr >=3D tmp->ptr && (tmp->ptr + BPF_PROG_PACK_SIZE) > ptr) {
>  			pack =3D tmp;
>  			break;
>  		}
> @@ -950,10 +950,10 @@ void bpf_prog_pack_free(struct bpf_binary_header *h=
dr)
>  	if (WARN_ONCE(!pack, "bpf_prog_pack bug\n"))
>  		goto out;
>=20=20
> -	nbits =3D BPF_PROG_SIZE_TO_NBITS(hdr->size);
> -	pos =3D ((unsigned long)hdr - (unsigned long)pack->ptr) >> BPF_PROG_CHU=
NK_SHIFT;
> +	nbits =3D BPF_PROG_SIZE_TO_NBITS(size);
> +	pos =3D ((unsigned long)ptr - (unsigned long)pack->ptr) >> BPF_PROG_CHU=
NK_SHIFT;
>=20=20
> -	WARN_ONCE(bpf_arch_text_invalidate(hdr, hdr->size),
> +	WARN_ONCE(bpf_arch_text_invalidate(ptr, size),
>  		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
>=20=20
>  	bitmap_clear(pack->bitmap, pos, nbits);
> @@ -1100,8 +1100,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 =
**image_ptr,
>=20=20
>  	*rw_header =3D kvmalloc(size, GFP_KERNEL);
>  	if (!*rw_header) {
> -		bpf_arch_text_copy(&ro_header->size, &size, sizeof(size));
> -		bpf_prog_pack_free(ro_header);
> +		bpf_prog_pack_free(ro_header, size);
>  		bpf_jit_uncharge_modmem(size);
>  		return NULL;
>  	}
> @@ -1132,7 +1131,7 @@ int bpf_jit_binary_pack_finalize(struct bpf_prog *p=
rog,
>  	kvfree(rw_header);
>=20=20
>  	if (IS_ERR(ptr)) {
> -		bpf_prog_pack_free(ro_header);
> +		bpf_prog_pack_free(ro_header, ro_header->size);
>  		return PTR_ERR(ptr);
>  	}
>  	return 0;
> @@ -1153,7 +1152,7 @@ void bpf_jit_binary_pack_free(struct bpf_binary_hea=
der *ro_header,
>  {
>  	u32 size =3D ro_header->size;
>=20=20
> -	bpf_prog_pack_free(ro_header);
> +	bpf_prog_pack_free(ro_header, size);
>  	kvfree(rw_header);
>  	bpf_jit_uncharge_modmem(size);
>  }
> diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
> index fa3e9225aedc..56760fc10e78 100644
> --- a/kernel/bpf/dispatcher.c
> +++ b/kernel/bpf/dispatcher.c
> @@ -150,10 +150,7 @@ void bpf_dispatcher_change_prog(struct bpf_dispatche=
r *d, struct bpf_prog *from,
>  			goto out;
>  		d->rw_image =3D bpf_jit_alloc_exec(PAGE_SIZE);
>  		if (!d->rw_image) {
> -			u32 size =3D PAGE_SIZE;
> -
> -			bpf_arch_text_copy(d->image, &size, sizeof(size));
> -			bpf_prog_pack_free((struct bpf_binary_header *)d->image);
> +			bpf_prog_pack_free(d->image, PAGE_SIZE);

Nice to get rid of that ugliness!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

