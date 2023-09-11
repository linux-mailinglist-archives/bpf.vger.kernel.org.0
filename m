Return-Path: <bpf+bounces-9679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41A79AAB7
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AAA2812F2
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86194156EE;
	Mon, 11 Sep 2023 18:10:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50345156E6
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 18:10:35 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E537106
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:10:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso638021266b.1
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694455831; x=1695060631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bidrNShRgf3Yu+RY3z45Pjn+5MP8dGaIVWtqgfsFtA=;
        b=nFSSJ2XVQsb5P4uhdeFcg5Ng2IEEz/BwUP8Emjba9u7kcldc22TTeI8QlIr21lUzUa
         WqPPddoiP5AdhgBH3mkqsSEKCyPpBuhFgGufoUKSuB7/VNB5oOeme2e5y//E8NIJCVwV
         11OrUpWauEv3ZN595rlTl4+6KUAFFCoFUVsi2nljU96FKk0euOO+7ajjyxqUhmV/uAOc
         NsFvHRoCYAR2h+YkzkpdYKR48H6dGjMPuycqj3vWOUHBjnpwabKEcisym/Sz36jVC2iR
         /VYThDcdleEZtWAyjfLxH/AzCJ3XWsQUJwVqw8zfKbGedj7+z07kdXmHnRcYCLfeYwUY
         dlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694455831; x=1695060631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bidrNShRgf3Yu+RY3z45Pjn+5MP8dGaIVWtqgfsFtA=;
        b=G+jKuwoOTwOv8zYLubAcCDjRr2d9E9GSGVK3C05TT+d6UPPJ5+tbZGtG9sorgW4vF/
         o1qJlmDu30ia8+czsBUWu6xMOEDoBU91r8J72Sqc9zfvzqI3FRd4IfhxZSGLLM74UXC4
         zEC30wfvHufJXbMBpArIENoK6sklT8beCsgM6KJMUluq3KwEuTuy8AA2KHNQQiU3+xPv
         BjHyJu+PTYeCP9sDuPvj84P6Tdfhy4WF0hljoiYikoQeDsOHTjxWcP1PTWie6kkkEaK0
         +GbYEqzupdPCKchTFsQWO9iYs5St8RRu2HrRShFjv0VfMTyGjzF/Mgc0PI1dp2nkdqvI
         J2jg==
X-Gm-Message-State: AOJu0YyjYEgugTe64gq+KC7/3PysZw00Dsl58ltuwpWKDIrNo7LDn3Yp
	gB5/zRfPgqKBgCLj3b9qec3p7PyBZo/mm5WkgCqlyYoI
X-Google-Smtp-Source: AGHT+IH+sNx8D1ppnGAei4VeGqe+kzWfKV/LBXf/VvVG+yQAdLUMg7u6GjDnWxOw6dsSGpwWJBe24PLMoYArd3dQ/KI=
X-Received: by 2002:a17:906:8a77:b0:9a5:f038:a4c1 with SMTP id
 hy23-20020a1709068a7700b009a5f038a4c1mr546699ejc.26.1694455831315; Mon, 11
 Sep 2023 11:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com> <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com> <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <3b6e3e7e-9d4f-7939-c8c0-edb266bc3758@huaweicloud.com> <CAEf4BzY1amO0NErRAFSDXou4HUqTuq+kphHfj-t4VMXv9qXgcg@mail.gmail.com>
 <31c832c6-546b-75e3-34e1-1dddde7c217f@huaweicloud.com>
In-Reply-To: <31c832c6-546b-75e3-34e1-1dddde7c217f@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Sep 2023 11:10:19 -0700
Message-ID: <CAEf4BzYg=DdPpVp9O5amNcQeK14CdMwktYcNia6PEioRuGQ_9Q@mail.gmail.com>
Subject: Re: Question: Is it OK to assume the address of bpf_dynptr_kern will
 be 8-bytes aligned and reuse the lowest bits to save extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 7:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 9/9/2023 6:34 AM, Andrii Nakryiko wrote:
> > On Wed, Aug 30, 2023 at 11:29=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >> Hi Andrii,
> >>
> >> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> >>> On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >> SNIP
> >>>>>> Yes. bpf prog will use dynptr as the map key. The bpf program will=
 use
> >>>>>> the same map helpers as hash map to operate on qp-trie and the ver=
ifier
> >>>>>> will be updated to allow using dynptr as map key for qp-trie.
> >>>>> And that's the problem I just mentioned.
> >>>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> >>>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> >>>> Sorry for misunderstanding your reply. But before switch to the kfun=
c
> >>>> way, could you please point me to some code or function which shows =
the
> >>>> specialty of PTR_MAP_KEY ?
> >>>>
> >>>>
> >>> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> >>> logic assumes that there is associated struct bpf_map * pointer from
> >>> which we know fixed-sized key length.
> >> Thanks for the information. Will check that.
> >>> But getting back to the topic at hand. I vaguely remember discussion
> >>> we had, but it would be good if you could summarize it again here to
> >>> avoid talking past each other. What is the bpf_map_ops changes you
> >>> were thinking to do? How bpf_attr will look like? How BPF-side API fo=
r
> >>> lookup/delete/update will look like? And then let's go from there?
> >>> Thanks!
> >> Sorry for the late reply. I am a bit distracted by other work this wee=
k.
> >>
> >> For bpf_attr, a new field 'dynkey_size' is added to support
> >> BPF_MAP_{LOOKUP/UPDATE/DELETE}_ELEM and BPF_MAP_GET_NEXT_KEY on qp-tri=
e
> >> as shown below:
> >>
> >> struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> >>         __u32           map_fd;
> >>         __aligned_u64   key;
> >>         union {
> >>                 __aligned_u64 value;
> >>                 __aligned_u64 next_key;
> >>         };
> >>         __u64           flags;
> >>         __u32           dynkey_size;    /* input/output for
> >>                                          * BPF_MAP_GET_NEXT_KEY. input
> >>                                          * only for other commands.
> >>                                          */
> > hm.. I wonder if it would be more elegant to add `key_size` and
> > `value_size`, and allow to specify it (optionally) even for maps that
> > have fixed-size keys and values. Return error if expected key/value
> > size doesn't match map definition. From libbpf side, libbpf can be
> > smart to not set it on older kernels (or if user didn't provide this
> > information). But for bpf_map__lookup_elem() and other higher-level
> > APIs, we should have all this information available.
>
> I am OK with the addition of key_size and value_size in bpf_attr and I
> will try to do that. After the addition, bpf syscall will also need to
> check these two size for fixed-size map, but I am a bit worried about
> the compatibility of libbpf and kernel for fixed-size map. There are
> three possible cases:
> 1) new libbpf and older kernel. key_size and value_size will be ignored
> by older kernel, because the definition of bpf_attr in older kernel is
> shorter. It will be OK.

Not ignored. Libbpf will have to zero out unknown fields. But yes, it
will be OK.

> 2) old libbpf and new kernel.  key_size and value_size will be zero for
> kernel, because libbpf doesn't pass these values. We can use 0 as an
> unspecified size, but for some map (e.g., bloom-filter) zero key_size is
> also valid, so do we need to introduce a feature bit to tell both
> key_size and value_size are valid ?

I wouldn't bother. Zero is "not provided". It will still be a valid
size for zero-sized key/value cases.

> 3) matched libbpf and kernel. Same problem as 2): use zero as an
> unspecified size or an extra flag is needed.

Again, I don't see a problem. Valid case (zero expected, zero
provided) will work correctly. The only case where we could have
caught an error would be expected non-zero size, but provided zero
size (which we treat as not specified size). Kernel won't reject it
outright, but that's backwards compatible behavior anyway, so I think
it's fine.

tl;dr I wouldn't bother with the new flag, it seems unnecessary.

>
> I totally missed these higher-level APIs with both key_sz and value_sz.
> It seems these high-level also need updates to support qp-trie (e.g.,
> bpf_map__get_next_key, because the size of current key and next key are
> different).
> >
> >

yep, we probably will have to add more generic bpf_map__next_key(map,
cur_key, cur_key_size, *next_key, *next_key_sz)


Keep in mind that for next_key operation the user should provide the
maximum next key size it expects, otherwise this kernel API will be
hard to use: very easy for the kernel to overrun a user-provided
buffer. So the next key size will be an in/out param. On input, it's
maximum expected size, on output -- actual filled out size.


> >> };
> >>
> >> And 4 new APIs are added in libbpf to support basic operations on qp-t=
rie:
> >>
> >> LIBBPF_API int bpf_map_update_dynkey_elem(int fd, const void *key,
> >> unsigned int key_size, const void *value, __u64 flags);
> >> LIBBPF_API int bpf_map_lookup_dynkey_elem(int fd, const void *key,
> >> unsigned int key_size, void *value);
> >> LIBBPF_API int bpf_map_delete_dynkey_elem(int fd, const void *key,
> >> unsigned int key_size);
> >> LIBBPF_API int bpf_map_get_next_dynkey(int fd, const void *key, void
> >> *next_key, unsigned int *key_size);
> >>
> >> About 3 weeks again, I have used the lowest bit of key pointer in
> >> .map_lookup_elem/.map_update_elem/.map_delete_elem to distinguish
> >> between bpf_user_dynkey-typed key from syscall and bpf_dynptr_kern-typ=
ed
> >> key from bpf program. The definition of bpf_user_dynkey and its
> >> allocation method are shown below. bpf syscall uses it to allocate
> >> variable-sized key and passes it to qp-trie.
> >>
> >> /* Allocate bpf_user_dynkey and its data together */
> >> struct bpf_user_dynkey {
> >>         unsigned int size;
> >>         void *data;
> >> };
> >>
> >> static void *bpf_new_user_dynkey(unsigned int size)
> >> {
> >>         struct bpf_user_dynkey *dynkey;
> >>         size_t total;
> >>
> >>         total =3D round_up(sizeof(*dynkey) + size, 2);
> >>         dynkey =3D kvmalloc(total, GFP_USER | __GFP_NOWARN);
> >>         if (!dynkey)
> >>                 return ERR_PTR(-ENOMEM);
> >>
> >>         dynkey->size =3D size;
> >>         dynkey->data =3D &dynkey[1];
> >>         return (void *)((long)dynkey | BPF_USER_DYNKEY_MARK);
> >> }
> >>
> >>
> >> After Alexei suggested that bit hack is only OK for memory or
> >> performance reason, I'm planning to add 2 new callbacks in bpf_map_ops
> >> to support update/delete operations in bpf syscall as shown below, but=
 I
> >> have tried it yet.
> >>
> >> /* map is generic key/value storage optionally accessible by eBPF
> >> programs */
> >> struct bpf_map_ops {
> >>         /* funcs callable from userspace (via syscall) */
> >>         /* ...... */
> >>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *k=
ey);
> > a bit confused, did you mean to also have key_size as a third argument =
here?
>
> Ah, I am planning to pass bpf_user_dynkey to these newly-added APIs and
> bpf_user_dynke::size is the size of the key. Passing a plain pointer and
> key size is also fine.

Wait, you want to pass bpf_user_dynkey from user-space side? Why?
pointer + size as part of bpf_attr seems like a more straightforward
syscall-side interface, IMO.

> >
> >>         long (*map_update_elem_sys_only)(struct bpf_map *map, void *ke=
y,
> >> void *value, u64 flags);
> >>         long (*map_delete_elem_sys_only)(struct bpf_map *map, void *ke=
y);
> >>         /* ...... */
> >> };
> >>
> >>
> >>
> >>
> >>
> >>
> >>
>

