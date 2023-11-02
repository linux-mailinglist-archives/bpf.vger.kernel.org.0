Return-Path: <bpf+bounces-13984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB97DF807
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FD0B212B3
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DE21DA3B;
	Thu,  2 Nov 2023 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKpRa4px"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6D1D54B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:56:18 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F413A
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 09:56:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so173212466b.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944175; x=1699548975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAok9UmZEssJYk2T0a1ynw4R8uobF4KBAfxj8PyiTLQ=;
        b=AKpRa4pxqcvsy/RqDurE3qw9rMVI683L4Yd/kuGNc+hUFdaAIOCg9scGhlra8e5TDr
         8TnbW8+gfWXzLiRqRAYjN0bXPFBKESLZjhWn9GM6XzOB/LV2NKT6Ia4AaZGx1hwu+xO2
         dLRsgkskU3v8OVUQiDymyexKaTeE180xAZT5AE8Yq/iGSSBGlkqDUWTlFbAFygURXpvY
         29kEpj648FrcnjYPDNMlQ7dZbLwgu9FkkKGnuzMPX2IbPGRSwOR9lKaSAitk/pwF8OK0
         Hsvb5AMkCdoRP6ac5kYMqs/bL6gFa5kwdH/1uEqL3MOSI60N3Xy+acprPc7e84HV66W5
         C16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944175; x=1699548975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAok9UmZEssJYk2T0a1ynw4R8uobF4KBAfxj8PyiTLQ=;
        b=nY/iw1tBx67GmiWZjRD6A0Ie0MKzQk2EdoCylbxCBKv7Z/MxT5zacK0Bx6a9u/xDrQ
         n+YMDmgIZWKQlyMhTZNttwRcjN+RxBc6Hg4rf7aSTrxFKs7Ha8Ko0xsOPQj4D5fL6vet
         +C3ARbYn9HLpX8Sw/xx8m87mpagyVFkzSj0AaaLfUjNti4T5wUXe6s0Hx+7OA66DjBP5
         7bNOSrqhhjSlHoehamQcZaSYA5hClacf8Xf0kc67kZuh1hJsOP1HWprV8bCL9mMvvOTR
         blPqpkNTLo3CUJHn2Xtzho8AESVj7A0NNJP7vZkyA16aWtWH20hxWyrfJqkjHmGzJBoW
         p0tg==
X-Gm-Message-State: AOJu0Yw+/ha9F07QPeqo0W66sCq3pEaF1wEKn8SB5E22gwZRaC2ib3F7
	LGpc7jtNXSWl9FSKAYNLLg8mAYiH57s288Q6arA=
X-Google-Smtp-Source: AGHT+IEbcmCXNJTJqudaMXApeY9rOovFyZUpcqYePFhLFW8kyv5DpZFZ/Yy+pCteAmr2fwS9ZXP5t5x5vKyd5pdCTbg=
X-Received: by 2002:a17:907:a08a:b0:9d2:7f29:2baf with SMTP id
 hu10-20020a170907a08a00b009d27f292bafmr4047085ejc.75.1698944174286; Thu, 02
 Nov 2023 09:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-2-song@kernel.org>
In-Reply-To: <20231024235551.2769174-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 09:56:02 -0700
Message-ID: <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF program=
s
> to access the dynptr data. They are also useful for in kernel functions
> that access dynptr data, for example, bpf_verify_pkcs7_signature.
>
> Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kernel
> functions can use them instead of accessing dynptr->data directly.
>
> Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
> dynptr->data.
>
> Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_rdwr
> that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/bpf.h      |  4 ++++
>  kernel/bpf/helpers.c     | 16 ++++++++--------
>  kernel/trace/bpf_trace.c | 15 +++++++++++----
>  3 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4825d3cdb29..3ed3ae37cbdf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
>
>  int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
> +                      void *buffer__opt, u32 buffer__szk);
> +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offse=
t,
> +                           void *buffer__opt, u32 buffer__szk);
>
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tra=
mpoline *tr);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e46ac288a108..af5059f11e83 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid=
(s32 pid)
>   * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers =
in
>   * the bpf program.
>   *
> - * Return: NULL if the call failed (eg invalid dynptr), pointer to a rea=
d-only
> - * data slice (can be either direct pointer to the data or a pointer to =
the user
> - * provided buffer, with its contents containing the data, if unable to =
obtain
> - * direct pointer)
> + * Return: NULL or error pointer if the call failed (eg invalid dynptr),=
 pointer

Hold on, nope, this one shouldn't return error pointer because it's
used from BPF program side and BPF program is checking for NULL only.
Does it actually return error pointer, though?

I'm generally skeptical of allowing to call kfuncs directly from
internal kernel code, tbh, and concerns like this are one reason why.
BPF verifier sets up various conditions that kfuncs have to follow,
and it seems error-prone to mix this up with internal kernel usage.

> + * to a read-only data slice (can be either direct pointer to the data o=
r a
> + * pointer to the user provided buffer, with its contents containing the=
 data,
> + * if unable to obtain direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u3=
2 offset,
>                                    void *buffer__opt, u32 buffer__szk)
> @@ -2354,10 +2354,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct b=
pf_dynptr_kern *ptr, u32 offset
>   * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end poin=
ters in
>   * the bpf program.
>   *
> - * Return: NULL if the call failed (eg invalid dynptr), pointer to a
> - * data slice (can be either direct pointer to the data or a pointer to =
the user
> - * provided buffer, with its contents containing the data, if unable to =
obtain
> - * direct pointer)
> + * Return: NULL or error pointer if the call failed (eg invalid dynptr),=
 pointer
> + * to a data slice (can be either direct pointer to the data or a pointe=
r to the
> + * user provided buffer, with its contents containing the data, if unabl=
e to
> + * obtain direct pointer)
>   */
>  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *pt=
r, u32 offset,
>                                         void *buffer__opt, u32 buffer__sz=
k)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index df697c74d519..2626706b6387 100644
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
> @@ -1394,10 +1395,16 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
>                         return ret;
>         }
>
> -       return verify_pkcs7_signature(data_ptr->data,
> -                                     __bpf_dynptr_size(data_ptr),
> -                                     sig_ptr->data,
> -                                     __bpf_dynptr_size(sig_ptr),
> +       data =3D bpf_dynptr_slice(data_ptr, 0, NULL, 0);
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       sig =3D bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
> +       if (IS_ERR(sig))
> +               return PTR_ERR(sig);
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
>

