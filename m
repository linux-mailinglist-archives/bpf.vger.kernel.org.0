Return-Path: <bpf+bounces-9562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8920799254
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9EB281D12
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FD21C16;
	Fri,  8 Sep 2023 22:34:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945910EE
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:34:29 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C01FCA
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:34:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50079d148aeso4278412e87.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694212460; x=1694817260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voqg+wFM87F8Cb2HS2ubeBFaeURoQBwoWxBkinv7F2U=;
        b=GcLxr14g2zIo7x+QOPgvxa7zdTOPknQxK43fJVA7VzpbKiXDA5wzYD30n/Ox/JUYFH
         m1JQsUrlPNuetg9qGTO/HoyGVpIK8RYymumkaQomhTwb/4BzIOPlp596LLSxjuUuMMEl
         XbRSeLpqFOyGZ+rHuzhd4Pkt58DpG2pw77b8dxARz8s/3+GkyaalPhP2/0U9quV+dTpQ
         QHxIA+anHXvJNK2AOyyblsXTUL7mCWHzXAhvXKLAyk32vU65w/TiGMStz8FAUb5Mv14j
         avauXIMaEfMtP1fMG9vu1zWkJGAsl5if5K9dcDpJq75Hkwno7wj4YAoR4lCssohHHpW4
         QVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694212460; x=1694817260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voqg+wFM87F8Cb2HS2ubeBFaeURoQBwoWxBkinv7F2U=;
        b=iAxGpSjNzcReEH7G+pfoM3S68X2TDH88HJD9wZRE3Pd6rhjV0KIiIIJzpj4NF/qZTh
         +g0JIi2JDVUkDhmOuwSrmQ3Lx4fLdGFxsUs7DzFjlYeWgDm3gAaZH/QgGvVrxoKhZfOu
         IbULHNH+BuDJub1LR6FRqbvjgk5m/EeAA0IenPFkSCJ8ksWLQ9PSrozP1H8qDpEd2OAH
         mOXJz5DsSsMT8IcCTtxZ6ngQhWA9FtzXq7HfrPPGDsKQFjSbp3vceotyKyGMLts+h2hp
         VWcaGZ9ZsPzCZ/KuOlVwgc/HuEXdOpHLP+hRrzowaORZqhHtL5AbuPHIMWhQxk59zGNH
         RcRw==
X-Gm-Message-State: AOJu0Yyteqkj1Whvschen0GHsWTQ6YwwKKL2dglxypgAZUrMKyt4Vp0m
	0/q8UgsvnyZoKOokhzoXP2J8k9h8dOCg+0t/rsE=
X-Google-Smtp-Source: AGHT+IEFmSv1L341uyp9F6zgq/JeRtqXHRa0LVwQ3U6/gEgaV9vNbJWQbEHcuOwTdVE5qMM6dW+aNGf4bMck8UbjjGA=
X-Received: by 2002:a05:6512:5d0:b0:4ff:9a75:211e with SMTP id
 o16-20020a05651205d000b004ff9a75211emr2528944lfo.42.1694212460304; Fri, 08
 Sep 2023 15:34:20 -0700 (PDT)
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
 <3b6e3e7e-9d4f-7939-c8c0-edb266bc3758@huaweicloud.com>
In-Reply-To: <3b6e3e7e-9d4f-7939-c8c0-edb266bc3758@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 15:34:08 -0700
Message-ID: <CAEf4BzY1amO0NErRAFSDXou4HUqTuq+kphHfj-t4VMXv9qXgcg@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 11:29=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi Andrii,
>
> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> SNIP
> >>>> Yes. bpf prog will use dynptr as the map key. The bpf program will u=
se
> >>>> the same map helpers as hash map to operate on qp-trie and the verif=
ier
> >>>> will be updated to allow using dynptr as map key for qp-trie.
> >>> And that's the problem I just mentioned.
> >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> >> Sorry for misunderstanding your reply. But before switch to the kfunc
> >> way, could you please point me to some code or function which shows th=
e
> >> specialty of PTR_MAP_KEY ?
> >>
> >>
> > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > logic assumes that there is associated struct bpf_map * pointer from
> > which we know fixed-sized key length.
>
> Thanks for the information. Will check that.
> >
> > But getting back to the topic at hand. I vaguely remember discussion
> > we had, but it would be good if you could summarize it again here to
> > avoid talking past each other. What is the bpf_map_ops changes you
> > were thinking to do? How bpf_attr will look like? How BPF-side API for
> > lookup/delete/update will look like? And then let's go from there?
> > Thanks!
>
> Sorry for the late reply. I am a bit distracted by other work this week.
>
> For bpf_attr, a new field 'dynkey_size' is added to support
> BPF_MAP_{LOOKUP/UPDATE/DELETE}_ELEM and BPF_MAP_GET_NEXT_KEY on qp-trie
> as shown below:
>
> struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>         __u32           map_fd;
>         __aligned_u64   key;
>         union {
>                 __aligned_u64 value;
>                 __aligned_u64 next_key;
>         };
>         __u64           flags;
>         __u32           dynkey_size;    /* input/output for
>                                          * BPF_MAP_GET_NEXT_KEY. input
>                                          * only for other commands.
>                                          */

hm.. I wonder if it would be more elegant to add `key_size` and
`value_size`, and allow to specify it (optionally) even for maps that
have fixed-size keys and values. Return error if expected key/value
size doesn't match map definition. From libbpf side, libbpf can be
smart to not set it on older kernels (or if user didn't provide this
information). But for bpf_map__lookup_elem() and other higher-level
APIs, we should have all this information available.


> };
>
> And 4 new APIs are added in libbpf to support basic operations on qp-trie=
:
>
> LIBBPF_API int bpf_map_update_dynkey_elem(int fd, const void *key,
> unsigned int key_size, const void *value, __u64 flags);
> LIBBPF_API int bpf_map_lookup_dynkey_elem(int fd, const void *key,
> unsigned int key_size, void *value);
> LIBBPF_API int bpf_map_delete_dynkey_elem(int fd, const void *key,
> unsigned int key_size);
> LIBBPF_API int bpf_map_get_next_dynkey(int fd, const void *key, void
> *next_key, unsigned int *key_size);
>
> About 3 weeks again, I have used the lowest bit of key pointer in
> .map_lookup_elem/.map_update_elem/.map_delete_elem to distinguish
> between bpf_user_dynkey-typed key from syscall and bpf_dynptr_kern-typed
> key from bpf program. The definition of bpf_user_dynkey and its
> allocation method are shown below. bpf syscall uses it to allocate
> variable-sized key and passes it to qp-trie.
>
> /* Allocate bpf_user_dynkey and its data together */
> struct bpf_user_dynkey {
>         unsigned int size;
>         void *data;
> };
>
> static void *bpf_new_user_dynkey(unsigned int size)
> {
>         struct bpf_user_dynkey *dynkey;
>         size_t total;
>
>         total =3D round_up(sizeof(*dynkey) + size, 2);
>         dynkey =3D kvmalloc(total, GFP_USER | __GFP_NOWARN);
>         if (!dynkey)
>                 return ERR_PTR(-ENOMEM);
>
>         dynkey->size =3D size;
>         dynkey->data =3D &dynkey[1];
>         return (void *)((long)dynkey | BPF_USER_DYNKEY_MARK);
> }
>
>
> After Alexei suggested that bit hack is only OK for memory or
> performance reason, I'm planning to add 2 new callbacks in bpf_map_ops
> to support update/delete operations in bpf syscall as shown below, but I
> have tried it yet.
>
> /* map is generic key/value storage optionally accessible by eBPF
> programs */
> struct bpf_map_ops {
>         /* funcs callable from userspace (via syscall) */
>         /* ...... */
>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key)=
;

a bit confused, did you mean to also have key_size as a third argument here=
?

>         long (*map_update_elem_sys_only)(struct bpf_map *map, void *key,
> void *value, u64 flags);
>         long (*map_delete_elem_sys_only)(struct bpf_map *map, void *key);
>         /* ...... */
> };
>
>
>
>
>
>
>

