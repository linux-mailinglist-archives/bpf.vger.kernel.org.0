Return-Path: <bpf+bounces-14141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7357E0AE8
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BBD1C21084
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098F24205;
	Fri,  3 Nov 2023 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnmz/SNo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459D24200
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:02:46 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071DD55
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:02:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c3aec5f326so719834866b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699048963; x=1699653763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwXK2Ku5mg07oqBxmL7vopL9zNXKP4ViJ6fhbdSxB9w=;
        b=dnmz/SNo8+7z7Ta4KfiWQORcNLvzoJQGW8u77p1i4DC47j+OhtYBh2SR5XYPDzR2dF
         i+Uq+K/oxxY7NAud8mkpKmk/0Sj2dmf0uMrcvhiGxs5pvJ1zfsaLkJm0LALgLiYR3oev
         fPQG5INfacrHK2qmZAs/YtU+SpijYSsxpNVbnuoxT0pOwztrtLXVlPf1RSSTJadsWkQi
         ssVjidwTHBJNsPEeBQtSyd+ioxa1I9u+DwG68I2ZXIeSKs4G+XwQwf0ToOfoerdHY1Dn
         V4ThMGCyVJC5MRvgayTiX26tUtnsYa4QsEdkVxeIrCJRst3GmjXhDrYxZDBJ4HcszuLm
         /URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048963; x=1699653763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwXK2Ku5mg07oqBxmL7vopL9zNXKP4ViJ6fhbdSxB9w=;
        b=XQ+4WgKjWi46U/2mq14XUMdw5PCDQrHD4u88V9Jo8zcRQgLollCgcmRR5EFoyjkKed
         Xa3eIy69YS1X//fIS5z10QmccSnB+BkP8KZRQRaEbhNS0JWDpNbWoGXuXktKubiv3e6d
         nq0mKKJEJmR2balFtwLJy4Puvfvn9yTKbHZvulRmZTO0FuI4Gt3dn83QUO82Aux2z4J0
         f70KqbuipN4s4950sl6jqwyVQQbb3uolXTbWH6KnLpDIx+MUbGMm8CQrzqou2FPLojoW
         Wx29AsJlqqdQti1nWOyEqIOGLOf2PH2M+fu9Edefbf8e3dKPo6domIrhFIaWKvM6M/2i
         3VyQ==
X-Gm-Message-State: AOJu0YymwZsYbsoeoBO3Y7QzHvJvLorEazqSFVSV3w7Kl2GmYQp6W66g
	S3cMQgXSJofNAMMGZXKAQ7oACFIgyvszWfiMdDg=
X-Google-Smtp-Source: AGHT+IErQTxDVIQqbnr6xdhsklcucX7t4pWlg6/7+dMd9QrSHCbUQhB0m/kd8Y8LfmDe04wippLnSQEyqYeYs3UEIfQ=
X-Received: by 2002:a17:906:454:b0:9a4:11a3:c32b with SMTP id
 e20-20020a170906045400b009a411a3c32bmr3818313eja.29.1699048963430; Fri, 03
 Nov 2023 15:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-2-song@kernel.org>
In-Reply-To: <20231103214535.2674059-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:02:31 -0700
Message-ID: <CAEf4Bzbzc9jTWgSxs4qN95rhx_M=tJifR+P1Eitixdub+Bhz6w@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 1/9] bpf: Add __bpf_dynptr_data* for in
 kernel use
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Different types of bpf dynptr have different internal data storage.
> Specifically, SKB and XDP type of dynptr may have non-continuous data.
> Therefore, it is not always safe to directly access dynptr->data.
>
> Add __bpf_dynptr_data and __bpf_dynptr_data_rw to replace direct access t=
o
> dynptr->data.
>
> Update bpf_verify_pkcs7_signature to use __bpf_dynptr_data instead of
> dynptr->data.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/bpf.h      |  2 ++
>  kernel/bpf/helpers.c     | 47 ++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 10 +++++----
>  3 files changed, 55 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..129c5a7c5982 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
>
>  int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> +void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
> +void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
>
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e46ac288a108..ddd1a5a81652 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2611,3 +2611,50 @@ static int __init kfunc_init(void)
>  }
>
>  late_initcall(kfunc_init);
> +
> +/* Get a pointer to dynptr data up to len bytes for read only access. If
> + * the dynptr doesn't have continuous data up to len bytes, return NULL.
> + */
> +void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len)

If it's read-only, then this should return `const void *`?

> +{
> +       enum bpf_dynptr_type type;
> +       int err;
> +
> +       if (!ptr->data)
> +               return NULL;
> +
> +       err =3D bpf_dynptr_check_off_len(ptr, 0, len);
> +       if (err)
> +               return NULL;
> +       type =3D bpf_dynptr_get_type(ptr);
> +
> +       switch (type) {
> +       case BPF_DYNPTR_TYPE_LOCAL:
> +       case BPF_DYNPTR_TYPE_RINGBUF:
> +               return ptr->data + ptr->offset;
> +       case BPF_DYNPTR_TYPE_SKB:
> +               return skb_pointer_if_linear(ptr->data, ptr->offset, len)=
;
> +       case BPF_DYNPTR_TYPE_XDP:
> +       {
> +               void *xdp_ptr =3D bpf_xdp_pointer(ptr->data, ptr->offset,=
 len);
> +
> +               if (IS_ERR_OR_NULL(xdp_ptr))
> +                       return NULL;
> +               return xdp_ptr;
> +       }
> +       default:
> +               WARN_ONCE(true, "unknown dynptr type %d\n", type);
> +               return NULL;
> +       }
> +}
> +
> +/* Get a pointer to dynptr data up to len bytes for read write access. I=
f
> + * the dynptr doesn't have continuous data up to len bytes, or the dynpt=
r
> + * is read only, return NULL.
> + */
> +void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)
> +{
> +       if (__bpf_dynptr_is_rdonly(ptr))
> +               return NULL;
> +       return __bpf_dynptr_data(ptr, len);

and then here we can cast to (void *) because we checked is_rdonly
above, I think it would be ok to do that

> +}
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..bfe6fb83e8d0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct b=
pf_dynptr_kern *data_ptr,
>                                struct bpf_dynptr_kern *sig_ptr,
>                                struct bpf_key *trusted_keyring)
>  {
> +       void *data, *sig;
>         int ret;
>
>         if (trusted_keyring->has_ref) {
> @@ -1394,10 +1395,11 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
>                         return ret;
>         }
>
> -       return verify_pkcs7_signature(data_ptr->data,
> -                                     __bpf_dynptr_size(data_ptr),
> -                                     sig_ptr->data,
> -                                     __bpf_dynptr_size(sig_ptr),
> +       data =3D __bpf_dynptr_data(data_ptr, __bpf_dynptr_size(data_ptr))=
;
> +       sig =3D __bpf_dynptr_data(sig_ptr, __bpf_dynptr_size(sig_ptr));
> +
> +       return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr),
> +                                     sig, __bpf_dynptr_size(sig_ptr),
>                                       trusted_keyring->key,
>                                       VERIFYING_UNSPECIFIED_SIGNATURE, NU=
LL,
>                                       NULL);
> --
> 2.34.1
>

