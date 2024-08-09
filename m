Return-Path: <bpf+bounces-36763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA994CC2D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F368FB241A2
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8F18E04B;
	Fri,  9 Aug 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGHtZ14w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A48175D2C
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192114; cv=none; b=TTRb8OjKftBCZKzHvFgpskEpiVcBoNCWT0ebXryH9P6gu+9axyA4ndRv7BU5YLrWetwePdAR0H0V2Ds6MWrImosGGNE59pC09cH6pspufCHuq5XK8SlnDIBGcxiTKYakVuC+U3LYkoxpVgvPA7p23aZswnHfd3QgNtyhpFU/AN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192114; c=relaxed/simple;
	bh=Ox1PZhF/ZUuaKu5dOZogoqrFXDGpoqC8IONHd/y48K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWDNwLVgZLbXSB5kgX+tW8K7e3UVymZcjruEGgmpRjTk8BQek1u74BB6JkFYWBLbltk1hNAHuUwj88E0NIXEAMYk1oEcdAWsi5NWph17uO69xpnuJjdY+J2xBsdqRpZpn59oLzKh9zuvjn1f1PUmDdxoEUtwcT8b660nUfFeoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGHtZ14w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d19d768c2so1416641b3a.3
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723192112; x=1723796912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2iONYl1r5TmddEURaKTPBTOx2nzJRyuwZKFUxL9vyi4=;
        b=iGHtZ14wa4me9x+/BXbpE+1GCPvdBwPwAfUEcZvm1zXr1TVpyjNHvpFEz9TtnP+rij
         je+vZ0uU6zQjj2cwOA8V/selNyXGmMUBDBRSy1zNtuyIm9UKhRXDIEz6nTo9p1Urzfa7
         vsjleZOHrotmYbbaBcJs3xsu3iG4dVCbfublY9x6llCf+GAKAzxOI7WlyqTCFzB7D/cK
         yU73bTVHa/nIuhUsuFNCyeq6E8oeScqZpcsEtWXY6u39OsWmfp4vlRQp+QqfvTR2fjc+
         qT/1U/vsHHcKfpwjTQt9rlrgOEtkYH/5NiSfUR4xQXNSacBVUGL6Yvk9qHuBevmrPPv4
         wFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192112; x=1723796912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iONYl1r5TmddEURaKTPBTOx2nzJRyuwZKFUxL9vyi4=;
        b=HqI41LWE5ll3vhNo0sWkG8TYJ/BBs0VNmgp4u2qFXYqJtf95977KO8diNXIXqK3/R7
         g1jNlYLdAD/5FNkG+LNnrMM5YFzXxguJFVSJAdT0xSwDIgZtpCiNsiPkm1iw96AOv3Xx
         oZN64GKl0iCIXtAHrnU5SOOKPVBZ4Ei36iYwc97ftwSwABXvkywB8cHGeas0szx5gs3e
         LgGy4h2Sr/mn8N+yoVO5N5DnPJUh1p0HONci1yOES7torVkj6ZA+epfGm2ypF4h0n/xK
         Dl1pVI003LbEkaZJv521bOYbHpYpldueH9JB7Z6H0jdCl0ZRkdlMZBjdodj5sEizzW15
         6mvw==
X-Forwarded-Encrypted: i=1; AJvYcCUFVEx3cvQ0M6orzM2etto6Yk5ZdPjBfs/vIHoBaSgJeOQ8rocYRNkAkuWZkwsazadP1vnZVInNvUtan8NwYbwRzE53
X-Gm-Message-State: AOJu0YxLUTzBhhryD12QnzKCwxzht9W+6Pl1ZRc0L7ow+Smbd3oRx6Wb
	NCVrNt67TNifKfvVR+XcHcXjsgbgTc9+q4joZHBZMlTUpHyf72D4
X-Google-Smtp-Source: AGHT+IH2MdA7Kca6oSGDblLm93+GZCeKdf4jj2KxiSP3g5s0kEITPyjfisAXv2nPdqkT9eEIpw5euA==
X-Received: by 2002:a05:6a00:1381:b0:70d:2693:d208 with SMTP id d2e1a72fcca58-710dc75f77fmr836792b3a.15.1723192111857;
        Fri, 09 Aug 2024 01:28:31 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f83bsm10947641a12.7.2024.08.09.01.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:28:31 -0700 (PDT)
Message-ID: <cbdf9051a35e8aa16478a2adc821403f53b4f4c0.camel@gmail.com>
Subject: Re: [PATCH] bpf: Fix percpu address space issues
From: Eduard Zingerman <eddyz87@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Date: Fri, 09 Aug 2024 01:28:26 -0700
In-Reply-To: <20240804185604.54770-1-ubizjak@gmail.com>
References: <20240804185604.54770-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-04 at 20:55 +0200, Uros Bizjak wrote:

[...]

> Found by GCC's named address space checks.

Please provide some additional details.
I assume that the definition of __percpu was changed from
__attribute__((btf_type_tag(percpu))) to
__attribute__((address_space(??)), is that correct?

What is the motivation for this patch?
Currently __percpu is defined as a type tag and is used only by BPF verifie=
r,
where it seems to be relevant only for structure fields and function parame=
ters.
This patch only changes local variables.

> There were no changes in the resulting object files.
>=20
> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-spa=
ce-name
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/arraymap.c |  8 ++++----
>  kernel/bpf/hashtab.c  |  8 ++++----
>  kernel/bpf/helpers.c  |  4 ++--
>  kernel/bpf/memalloc.c | 12 ++++++------
>  4 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 188e3c2effb2..544ca433275e 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq_file =
*seq, loff_t *pos)
>  	array =3D container_of(map, struct bpf_array, map);
>  	index =3D info->index & array->index_mask;
>  	if (info->percpu_value_buf)
> -	       return array->pptrs[index];
> +	       return array->ptrs[index];

I disagree with this change.
One might say that indeed the address space is cast away here,
however, value returned by this function is only used in functions
bpf_array_map_seq_{next,show,stop}(), where it is guarded by the same
'if (info->percpu_value_buf)' condition to identify if per_cpu_ptr()
is necessary.

>  	return array_map_elem_ptr(array, index);
>  }
> =20
> @@ -619,7 +619,7 @@ static void *bpf_array_map_seq_next(struct seq_file *=
seq, void *v, loff_t *pos)
>  	array =3D container_of(map, struct bpf_array, map);
>  	index =3D info->index & array->index_mask;
>  	if (info->percpu_value_buf)
> -	       return array->pptrs[index];
> +	       return array->ptrs[index];

Same as above.

>  	return array_map_elem_ptr(array, index);
>  }
> =20
> @@ -632,7 +632,7 @@ static int __bpf_array_map_seq_show(struct seq_file *=
seq, void *v)
>  	struct bpf_iter_meta meta;
>  	struct bpf_prog *prog;
>  	int off =3D 0, cpu =3D 0;
> -	void __percpu **pptr;
> +	void * __percpu *pptr;

Should this be 'void __percpu *pptr;?
The value comes from array->pptrs[*] field,
which has the above type for elements.

>  	u32 size;
> =20
>  	meta.seq =3D seq;
> @@ -648,7 +648,7 @@ static int __bpf_array_map_seq_show(struct seq_file *=
seq, void *v)
>  		if (!info->percpu_value_buf) {
>  			ctx.value =3D v;
>  		} else {
> -			pptr =3D v;
> +			pptr =3D (void __percpu *)(uintptr_t)v;
>  			size =3D array->elem_size;
>  			for_each_possible_cpu(cpu) {
>  				copy_map_value_long(map, info->percpu_value_buf + off,
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index be1f64c20125..a49212bbda09 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1049,14 +1049,14 @@ static struct htab_elem *alloc_htab_elem(struct b=
pf_htab *htab, void *key,
>  			pptr =3D htab_elem_get_ptr(l_new, key_size);
>  		} else {
>  			/* alloc_percpu zero-fills */
> -			pptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma);
> -			if (!pptr) {
> +			void *ptr =3D bpf_mem_cache_alloc(&htab->pcpu_ma);
> +			if (!ptr) {

Why adding an intermediate variable here?
Is casting bpf_mem_cache_alloc() result to percpu not sufficient?
It looks like bpf_mem_cache_alloc() returns a percpu pointer,
should it be declared as such?

>  				bpf_mem_cache_free(&htab->ma, l_new);
>  				l_new =3D ERR_PTR(-ENOMEM);
>  				goto dec_count;
>  			}
> -			l_new->ptr_to_pptr =3D pptr;
> -			pptr =3D *(void **)pptr;
> +			l_new->ptr_to_pptr =3D ptr;
> +			pptr =3D *(void __percpu **)ptr;
>  		}
> =20
>  		pcpu_init_value(htab, pptr, value, onallcpus);

[...]

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index dec892ded031..b3858a76e0b3 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -138,8 +138,8 @@ static struct llist_node notrace *__llist_del_first(s=
truct llist_head *head)
>  static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
>  {
>  	if (c->percpu_size) {
> -		void **obj =3D kmalloc_node(c->percpu_size, flags, node);
> -		void *pptr =3D __alloc_percpu_gfp(c->unit_size, 8, flags);
> +		void __percpu **obj =3D kmalloc_node(c->percpu_size, flags, node);

Why __percpu is needed for obj?
kmalloc_node is defined as 'alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))',
alloc_hooks(X) is a macro and it produces result of type typeof(X),
kmalloc_node_noprof() returns void*, not __percpu void*.
Do I miss something?

> +		void __percpu *pptr =3D __alloc_percpu_gfp(c->unit_size, 8, flags);
> =20
>  		if (!obj || !pptr) {
>  			free_percpu(pptr);

[...]


