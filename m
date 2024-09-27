Return-Path: <bpf+bounces-40437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E0988B7B
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF120282A64
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2AD1C2DAE;
	Fri, 27 Sep 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJjPOsn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBD15B57C
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470184; cv=none; b=PRwaga/ieEvGynxGpbVQRNuer/AS0OKKdb36RVVvIOwYi5oUJNNpFRdPE85DbvhFS347+qkylKTrmyAyuslRSs5DnHf5B6IKthMaUCD/6my2bu1CRVPZchTpbI/i2yFhx5CJ8VE+OnsnYrf9/+hBem2u8ppYxmZx/LPq9EkUc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470184; c=relaxed/simple;
	bh=XXj3tIOerIhdGrJwIAM+qQzcIHbUZ7hrzVCOUi0GFX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM2HjOXBQx12xDMhgH4/vgrHgogHjWbJwAC5Nvw21lAjQZ0huq/9Rf9e2n9o5dbPYWvhQqdSORSSMri56iwh3khLAQMCVCCNmZ+QXar9+SBWOTZmg1LTN1f87TwUsx3+nRkdjIVaTf/Of4/gZjKReqzckuTdS5OSAWHwXxk7aDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJjPOsn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2059204f448so24520645ad.0
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470181; x=1728074981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0xMsMsx6EKevdxwC1MU9DhRUSPWum/+ZzoDQ+VlDPc=;
        b=DZJjPOsnE0bo58Iv9cGmpCubwMDovRxtj/oec367CL1kEsHEaQ5zRJ/PkOQkf+KQFD
         SEl8EJE4iYRjEBKZHOSAWxkn18D++J81GL3ifSYTonTLY23GiyScEpU0bw8GTvkqtCh5
         7+oAvdJvL9/4KpdYESekS9MfvbYB+2xq+BtgQV5HHD6GU78x9cuZKwobrvqS427xTO7u
         PU0cxyb9oEpvrmRmhjExKSaehlwAVJlMtkfJhMbAAybMiQQz7nPJ4zPSUs02GQF8CV7J
         NwxqvzvqqAn5soG0KRlRwLnRhU4R40Kn1lztcXQZJ29dS27a4sgARnFonKBDeFpAMXhk
         kKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470181; x=1728074981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0xMsMsx6EKevdxwC1MU9DhRUSPWum/+ZzoDQ+VlDPc=;
        b=ErA3D4RRiy8whnedct8pkOGaBk/7onT61g30ywY3pPjq0aKf7HN7mT4W530xNaU+LJ
         KvkYCsecE3Olkm3om/apkfhjYJUpmmBGlnhNEQ5tAYsB37KjhY0s4RNTmIH0rctNNOnM
         ofPIWWxW3Jbv/5u/bAgbJzOt2oB4oXHZClg1YPbabgxueKzHfUx717fZWRXwS5xFLaWc
         PW5V7WSql/nbdet4wMApoPid4PrcrCpRBHaRHY4uH9HuYl9+YbKrLa9nf+FUypF5YsCN
         XOdPmtbn00S9+X8OmG9I7Vk0MsvFnoKP5njJHmc6G31KnDZGoQM4K+EEZ9MbYhKfaZp3
         m9fA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIHrknvEXoyewyp9rA4+H8mlaW2GEksydpag4Nm3FuJvd8L1fXIn4laCBdZ6Apy8vGao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbW2h2jsmnXHtYAjDDXzZqK7N+qGu2wPpwGr2QTDF+pwBUkXV
	1L313Cwqm1puhvikZMxxdMFaQugwIUHcofGGv+raFPNSk1wYLjbY8a6sJcufDpPOlKlmNJVTOPB
	PXaX+IsUQrY40C6aGu/SgXKRsriI=
X-Google-Smtp-Source: AGHT+IGfIM/uMjh5Y0psJGLqzfqwjOkSAbtq78Dx/rmIpnWjQ8/qkoq4l7gFsIMXGqeFNfwHZ/3jmputq0n4a3qZT/Q=
X-Received: by 2002:a17:902:d2cd:b0:202:301f:36fd with SMTP id
 d9443c01a7336-20b367e2276mr71002965ad.18.1727470180930; Fri, 27 Sep 2024
 13:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240921011712.83355-1-inwardvessel@gmail.com> <CAADnVQ+MWYaVdY-hJcnyu_SBJdcoeLiD7qsTx2a0EdV3rqLikA@mail.gmail.com>
In-Reply-To: <CAADnVQ+MWYaVdY-hJcnyu_SBJdcoeLiD7qsTx2a0EdV3rqLikA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 13:49:27 -0700
Message-ID: <CAEf4BzYm6+_EQBmgC+R4tFkvqc37TriTmBDm6E3JC9mSTJs+JA@mail.gmail.com>
Subject: Re: [RFC bpf-next] libbpf: add resizable array helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Sep 21, 2024 at 3:17=E2=80=AFAM JP Kobryn <inwardvessel@gmail.com=
> wrote:
> >
> > Arrays in custom data sections can be resized via bpf_map__set_value().
> > While working with these types of arrays in some sched_ext programs, th=
ere
> > was some feedback that the manual operations involved could use helpers=
.
> > The macros in the potential patch are intended to make resizing bpf arr=
ays
> > easier.
> >
> > To illustrate, declaring an array that will be resized looks like this:
> > __u32 my_map[1] SEC(".data.my_map");
> >
> > Instead, using a macro to help with the declaration:
> > __u32 BPF_RESIZABLE_ARRAY(data, my_map);
>
> I don't like hiding things in a macro.
> SEC() isn't great, but that's what we got and users
> used to it.
>

I agree, macros are sometimes a necessary evil, but they do obscure
things and shouldn't be proliferated unnecessarily.

JP, instead of these patches, I'd suggest adding a new file under
Documentation/bpf/libbpf to describe common libbpf coding patterns,
and this resizable array use case would be a perfect starter for this.

> > To allow access to the post-resized array in the bpf program, this help=
er
> > can be used which maintains verifier safety:
> > u32 *val =3D (u32 *)ARRAY_ELEM_PTR(my_map, ctx->cpu, nr_cpus);
>
> I don't like this one either.
> We have bpf_cmp_likely/unlikely that can be used
> to guard array access against the limit.
>
> > Meanwhile in the userspace program, instead of doing:
> > size_t sz =3D bpf_map__set_value_size(skel->maps.data_my_map, sizeof(sk=
el->data_my_map->my_map[0]) * nr_cpus);
> > skel->data_my_map =3D bpf_map__initial_value(skel->maps.data_my_map, &s=
z);
> >
> > The resizing macro can be used:
> > BPF_RESIZE_ARRAY(data, my_map, nr_cpus);
>
> Open code of libbpf api is much more readable. Macros are not.
>
>
>
> >
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h    | 23 ++++++++++++++++++
> >  tools/lib/bpf/bpf_helpers.h | 48 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 71 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e05b39e39c3f..92e93c9fc056 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7513,4 +7513,27 @@ struct bpf_iter_num {
> >         __u64 __opaque[1];
> >  } __attribute__((aligned(8)));
> >
> > +/*
> > + * BPF_RESIZE_ARRAY - Convenience macro for resizing a BPF array
> > + * @elfsec: the data section of the BPF program in which to the array =
exists
> > + * @arr: the name of the array
> > + * @n: the desired array element count
> > + *
> > + * For BPF arrays declared with RESIZABLE_ARRAY(), this macro performs=
 two
> > + * operations. It resizes the map which corresponds to the custom data
> > + * section that contains the target array. As a side effect, the BTF i=
nfo for
> > + * the array is adjusted so that the array length is sized to cover th=
e new
> > + * data section size. The second operation is reassigning the skeleton=
 pointer
> > + * for that custom data section so that it points to the newly memory =
mapped
> > + * region.
> > + */
> > +#define BPF_RESIZE_ARRAY(elfsec, arr, n)                              =
           \
> > +       do {                                                           =
           \
> > +               size_t __sz;                                           =
           \
> > +               bpf_map__set_value_size(skel->maps.elfsec##_##arr,     =
           \
> > +                               sizeof(skel->elfsec##_##arr->arr[0]) * =
(n));      \
> > +               skel->elfsec##_##arr =3D                               =
             \
> > +                       bpf_map__initial_value(skel->maps.elfsec##_##ar=
r, &__sz); \
> > +       } while (0)
> > +
> >  #endif /* _UAPI__LINUX_BPF_H__ */
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index 305c62817dd3..b0d496b0f0d6 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -420,4 +420,52 @@ extern void bpf_iter_num_destroy(struct bpf_iter_n=
um *it) __weak __ksym;
> >  )
> >  #endif /* bpf_repeat */
> >
> > +/**
> > + * RESIZABLE_ARRAY - Generates annotations for an array that may be re=
sized
> > + * @elfsec: the data section of the BPF program in which to place the =
array
> > + * @arr: the name of the array
> > + *
> > + * libbpf has an API for setting map value sizes. Since data sections =
(i.e.
> > + * bss, data, rodata) themselves are maps, a data section can be resiz=
ed. If
> > + * a data section has an array as its last element, the BTF info for t=
hat
> > + * array will be adjusted so that length of the array is extended to m=
eet the
> > + * new length of the data section. This macro annotates an array to ha=
ve an
> > + * element count of one with the assumption that this array can be res=
ized
> > + * within the userspace program. It also annotates the section specifi=
er so
> > + * this array exists in a custom sub data section which can be resized
> > + * independently.
> > + *
> > + * See BPF_RESIZE_ARRAY() for the userspace convenience macro for resi=
zing an
> > + * array declared with BPF_RESIZABLE_ARRAY().
> > + */
> > +#define BPF_RESIZABLE_ARRAY(elfsec, arr) arr[1] SEC("."#elfsec"."#arr)
> > +
> > +/*
> > + * BPF_ARRAY_ELEM_PTR - Obtain the verified pointer to an array elemen=
t
> > + * @arr: array to index into
> > + * @i: array index
> > + * @n: number of elements in array
> > + *
> > + * Similar to MEMBER_VPTR() but is intended for use with arrays where =
the
> > + * element count needs to be explicit.
> > + * It can be used in cases where a global array is defined with an ini=
tial
> > + * size but is intended to be be resized before loading the BPF progra=
m.
> > + * Without this version of the macro, MEMBER_VPTR() will use the compi=
le time
> > + * size of the array to compute the max, which will result in rejectio=
n by
> > + * the verifier.
> > + */
> > +#define BPF_ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)({       \
> > +       u64 __base =3D (u64)arr;                                    \
> > +       u64 __addr =3D (u64)&(arr[i]) - __base;                     \
> > +       asm volatile (                                            \
> > +               "if %0 <=3D %[max] goto +2\n"                       \
> > +               "%0 =3D 0\n"                                        \
> > +               "goto +1\n"                                       \
> > +               "%0 +=3D %1\n"                                      \
> > +               : "+r"(__addr)                                    \
> > +               : "r"(__base),                                    \
> > +                 [max]"r"(sizeof(arr[0]) * ((n) - 1)));  \
> > +       __addr;                                           \
> > +})
> > +
> >  #endif
> > --
> > 2.46.0
> >

