Return-Path: <bpf+bounces-13989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9E7DF85B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425C41F2229B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAF1DFC2;
	Thu,  2 Nov 2023 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2XszZzU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982951C2A3
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:09:40 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1686123
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 10:09:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso188606166b.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698944977; x=1699549777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLma4XbyH5frF0gB6JBr2iynMB57cgWiVUGmlemzqIc=;
        b=k2XszZzUoCkOfMGQbXF76QFeEQRXx13EHDevakP4RNHpmTjGWtRJDxC/B/Qy6eKGIY
         uwfgtOgcE9mFYSDzQz/1aQyJNpt7NXudm0VtIqZL1xVsKqjrnD7qLjnXOZZ71U48MFi/
         uhVVzYbEZT045z/JWdh2lGZqlPSanWhhzM2J0pL+2HKV2RImxh09DuBOvhmfQWcSJC8J
         nKU4b0t00C40Gyn4hSXljsde88Ue4vx7xGYQJ75E0LWPy7K96KKrq88ESeMf83Ys1aDR
         D7LwIKqDywP0r1XcG+6HekJ+34Dvn9PMzQEqP+9P0hPggUJ9h5F+4OB4PKn6KOk8ibMB
         1TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698944977; x=1699549777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLma4XbyH5frF0gB6JBr2iynMB57cgWiVUGmlemzqIc=;
        b=dIqk9JvsQmfM4LWU80+kVj5IsIHoOzR9ByGN0A7by5sERGzk3rkbFkpKPQBSpZspoN
         dhfa02QwoCcDALQzutvX1mJ1Zxq8uVJDAb9Hq4rDtaUyyGMHmy0ERRxV42QijbB3PznP
         N3U7QCjxQDFRXpmOs7vRWlWPOdoxsfTAkTRk/bEiPYkYc1UZTyTLnBXvVNbl6u6ugIZe
         fLYwxBbIedBX5aFGJCVsO9lh23PyKl63fGeUZ05bUiZsSKKcvmm6aLlXtUdX2iQ6Kg6N
         5GgH1+HRG/fElrkYb9Toyww4rkvR856qIaAuUymiPt5qRGxZmJfzTPVk1rFh6mZwKWVy
         sw+w==
X-Gm-Message-State: AOJu0YxTAzPbYMjXa18nhLHWhGTDU+mRvmYrHEQLcY4YXOKsIEZOoxrx
	/SSJ6qGhtX6V2kLfvM2ORIVvdZdWWrzm7qKv68w=
X-Google-Smtp-Source: AGHT+IE4IFU1ccSX3s2vS0J7AaA1f2GyvvO/ldP8wXadKTxVb+cv2Aj/lyv36ZEFPrS4LtWJghLTRp+Ijs2T5tEfJUs=
X-Received: by 2002:a17:906:dc91:b0:9c5:7f8b:bafc with SMTP id
 cs17-20020a170906dc9100b009c57f8bbafcmr5226811ejc.22.1698944976729; Thu, 02
 Nov 2023 10:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024235551.2769174-1-song@kernel.org> <20231024235551.2769174-2-song@kernel.org>
 <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzbr8dgksh2z+4nEkAFdV9gquhR+HROULKdTkWrUpSM9-Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 10:09:25 -0700
Message-ID: <CAEf4BzbDFDX30Y_Hcmd__hgDp+m6X+htr-wTeBtaoauEnrEdLw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/9] bpf: Expose bpf_dynptr_slice* kfuncs for
 in kernel use
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 9:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 24, 2023 at 4:56=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > kfuncs bpf_dynptr_slice and bpf_dynptr_slice_rdwr are used by BPF progr=
ams
> > to access the dynptr data. They are also useful for in kernel functions
> > that access dynptr data, for example, bpf_verify_pkcs7_signature.
> >
> > Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr to bpf.h so that kernel
> > functions can use them instead of accessing dynptr->data directly.
> >
> > Update bpf_verify_pkcs7_signature to use bpf_dynptr_slice instead of
> > dynptr->data.
> >
> > Also, update the comments for bpf_dynptr_slice and bpf_dynptr_slice_rdw=
r
> > that they may return error pointers for BPF_DYNPTR_TYPE_XDP.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  include/linux/bpf.h      |  4 ++++
> >  kernel/bpf/helpers.c     | 16 ++++++++--------
> >  kernel/trace/bpf_trace.c | 15 +++++++++++----
> >  3 files changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b4825d3cdb29..3ed3ae37cbdf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1222,6 +1222,10 @@ enum bpf_dynptr_type {
> >
> >  int bpf_dynptr_check_size(u32 size);
> >  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
> > +void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
> > +                      void *buffer__opt, u32 buffer__szk);
> > +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 off=
set,
> > +                           void *buffer__opt, u32 buffer__szk);
> >
> >  #ifdef CONFIG_BPF_JIT
> >  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_t=
rampoline *tr);
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e46ac288a108..af5059f11e83 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2270,10 +2270,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_p=
id(s32 pid)
> >   * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointer=
s in
> >   * the bpf program.
> >   *
> > - * Return: NULL if the call failed (eg invalid dynptr), pointer to a r=
ead-only
> > - * data slice (can be either direct pointer to the data or a pointer t=
o the user
> > - * provided buffer, with its contents containing the data, if unable t=
o obtain
> > - * direct pointer)
> > + * Return: NULL or error pointer if the call failed (eg invalid dynptr=
), pointer
>
> Hold on, nope, this one shouldn't return error pointer because it's
> used from BPF program side and BPF program is checking for NULL only.
> Does it actually return error pointer, though?

So I just checked the code (should have done it before replying,
sorry). It is a bug that slipped through when adding bpf_xdp_pointer()
usage. We should always return NULL from this kfunc on error
conditions. Let's fix it separately, but please don't change the
comments.

>
> I'm generally skeptical of allowing to call kfuncs directly from
> internal kernel code, tbh, and concerns like this are one reason why.
> BPF verifier sets up various conditions that kfuncs have to follow,
> and it seems error-prone to mix this up with internal kernel usage.
>

Reading bpf_dynptr_slice_rdwr code, it does look exactly like what you
want, despite the confusingly-looking 0, NULL, 0 arguments. So I guess
I'm fine exposing it directly, but it still feels like it will bite us
at some point later.


> > + * to a read-only data slice (can be either direct pointer to the data=
 or a
> > + * pointer to the user provided buffer, with its contents containing t=
he data,
> > + * if unable to obtain direct pointer)
> >   */
> >  __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, =
u32 offset,
> >                                    void *buffer__opt, u32 buffer__szk)
> > @@ -2354,10 +2354,10 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct=
 bpf_dynptr_kern *ptr, u32 offset
> >   * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end po=
inters in
> >   * the bpf program.
> >   *
> > - * Return: NULL if the call failed (eg invalid dynptr), pointer to a
> > - * data slice (can be either direct pointer to the data or a pointer t=
o the user
> > - * provided buffer, with its contents containing the data, if unable t=
o obtain
> > - * direct pointer)
> > + * Return: NULL or error pointer if the call failed (eg invalid dynptr=
), pointer
> > + * to a data slice (can be either direct pointer to the data or a poin=
ter to the
> > + * user provided buffer, with its contents containing the data, if una=
ble to
> > + * obtain direct pointer)
> >   */
> >  __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *=
ptr, u32 offset,
> >                                         void *buffer__opt, u32 buffer__=
szk)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index df697c74d519..2626706b6387 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1378,6 +1378,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct=
 bpf_dynptr_kern *data_ptr,
> >                                struct bpf_dynptr_kern *sig_ptr,
> >                                struct bpf_key *trusted_keyring)
> >  {
> > +       void *data, *sig;
> >         int ret;
> >
> >         if (trusted_keyring->has_ref) {
> > @@ -1394,10 +1395,16 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(stru=
ct bpf_dynptr_kern *data_ptr,
> >                         return ret;
> >         }
> >
> > -       return verify_pkcs7_signature(data_ptr->data,
> > -                                     __bpf_dynptr_size(data_ptr),
> > -                                     sig_ptr->data,
> > -                                     __bpf_dynptr_size(sig_ptr),
> > +       data =3D bpf_dynptr_slice(data_ptr, 0, NULL, 0);
> > +       if (IS_ERR(data))
> > +               return PTR_ERR(data);
> > +
> > +       sig =3D bpf_dynptr_slice(sig_ptr, 0, NULL, 0);
> > +       if (IS_ERR(sig))
> > +               return PTR_ERR(sig);
> > +
> > +       return verify_pkcs7_signature(data, __bpf_dynptr_size(data_ptr)=
,
> > +                                     sig, __bpf_dynptr_size(sig_ptr),
> >                                       trusted_keyring->key,
> >                                       VERIFYING_UNSPECIFIED_SIGNATURE, =
NULL,
> >                                       NULL);
> > --
> > 2.34.1
> >
> >

