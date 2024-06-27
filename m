Return-Path: <bpf+bounces-33220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB6919DDE
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 05:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A7BB2177D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8345E171B6;
	Thu, 27 Jun 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxApQMcR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D2139DB
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459329; cv=none; b=QQzOhMrydnVhjGG6j9OcbQXVseQlgQhMsONIMinR6Z8KhWC/fdFrcd+/ncmIpLlUeL/ogy8V1cgrNhgH477IZ/+1zKpw9K+1mK7BmOdTzZbPNaAwilMVozTdU7WglACPIU8euoEZ0LxzubS7Kei2Mi/RzwRUrmZBM1GKpyreCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459329; c=relaxed/simple;
	bh=5GbHKo61BVgcDcAP/O8xmclt/oHol5xRv8/NkF4Q+VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMYht2WrUR8mgtcGprGArtmyEQLWg2NoR3RTkal1qxICsR7jp/W7HMeD3XewFOS1ykCCHTy0tmWoI5hjlzLRSD7D04UeHEbVNlzLQBY8jxhhzpCmE5pY0GI1TYB8tOur4gt3nZ+b88mQ/FfcToK/NxskZYtgCjU2IJXjh8ILXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxApQMcR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so58035375e9.3
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 20:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719459324; x=1720064124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9KTXrkb/QPVqp/goAf00bh5MxZGYvCooxZeUx4gkwI=;
        b=FxApQMcRbD4fjSh6winPHbac/zawQN+e4e9s8wyahZkZLv3FqIHDuhq2FGI6plF03L
         k88+P8bkIZjpuK6uIZSvaQWsjpv4DafbDm7EiQqmsAe6tNxLcRgBbOsMXAU+gxDcFrxc
         8W3mOOBpyXKONjJIGtY1W3oTbf73Ze2CjePZoPyBjL2vY/zfHg3Qa7F3aA1qgNqE8k5n
         q/43ps3EfQi59m2r/yTy7mWyYFttOYyKew7DL531lUaKgSAVylHVgSNLExGIac6OXIzW
         WUzyQa9qPnwmplVLbbsLX52zyzqLB3dus2ui9HUBfia2W/fW2Iaahrh6bs/e9s+1vJQi
         6lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719459324; x=1720064124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9KTXrkb/QPVqp/goAf00bh5MxZGYvCooxZeUx4gkwI=;
        b=rjALnAyv0gq8mZHB/jdEMDvSseDjYKwKM3PlPDcH81KO+/WFqSMa7EEe4pbkVkAoW/
         lb7O9VHwnPZj85geVWUYhR+fIg+GNTfBZFjTi5oEpmPJDoqb6w0SrnXb/4vnm4W/260/
         HsrGTWavAtgoktGfCeZCKYBDzcxlKry+Srhh5brBuqe7l3saSHHv0F1vTA6/6OKeTlOv
         vNcRKMpYJYHRmvIZDThsI6K5Jtv9sO5BDdAoURoL99lC+JGwkxUbN7jwv7Pv39FEl/th
         EwMfcEgnrFl9/0rMt0jNX4+BW6LcyVcu+O38/yJbITPJa/Isb5MEMQFLinqhQU4ZCOvb
         wxCA==
X-Forwarded-Encrypted: i=1; AJvYcCUbxqaMDkXo9+91kl8S+q9ysUaJdBu6rv/O17zeTCTmSGXRfMBpaf1xCCUoUgi6OGlznC/xecif5NMDxbLuGsTskePK
X-Gm-Message-State: AOJu0YwVg6q2bzKOVs8AqLyofuCxTDwf4ffWNmhkFbsN5FvfiwEbsZn9
	PkkO/ihvzcfwhpc5Jx+oN4qUzmj3RiWGoS/AkXKIR2Lkb6aQHZPvV9W6zUsIB33acp/GpkGgQdh
	dY0M+s+MBeV2WfvFk/1IsLw+ddPM=
X-Google-Smtp-Source: AGHT+IF3prMOuXFMbERK52zYKFGYvhJil5TUxudgzKM4zr0CvUrFvmM8XnomyUD/ToxZRjlTfh5V4+MtDibQppITdNo=
X-Received: by 2002:a05:600c:5699:b0:423:b672:9d64 with SMTP id
 5b1f17b1804b1-4248b980068mr96334395e9.18.1719459324400; Wed, 26 Jun 2024
 20:35:24 -0700 (PDT)
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
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com> <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
 <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com> <CAEf4BzaPV9aB8ndkHWiQDYEsu8MpLQYJ6-irY7VsOgQPA6rULQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaPV9aB8ndkHWiQDYEsu8MpLQYJ6-irY7VsOgQPA6rULQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 20:35:13 -0700
Message-ID: <CAADnVQLTQDnFUd3WUue_8t1g0CjU=BwQfLxFQ-y=26aEyfEGSQ@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 25, 2024 at 9:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > Hi,
> >
> > On 6/26/2024 10:06 AM, Alexei Starovoitov wrote:
> > > On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > >> Hi,
> > >>
> > >> Sorry to resurrect the old thread to continue the discussion of APIs=
 for
> > >> qp-trie.
> > >>
> > >> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > >>> On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud=
.com> wrote:
> > >>>> Hi,
> > >>>>
> > >> SNIP
> > >>
> > >>>> updated to allow using dynptr as map key for qp-trie.
> > >>>>> And that's the problem I just mentioned.
> > >>>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to als=
o
> > >>>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type)=
.
> > >>>> Sorry for misunderstanding your reply. But before switch to the kf=
uncl
> > >>>> way, could you please point me to some code or function which show=
s the
> > >>>> specialty of PTR_MAP_KEY ?
> > >>>>
> > >>>>
> > >>> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > >>> logic assumes that there is associated struct bpf_map * pointer fro=
m
> > >>> which we know fixed-sized key length.
> > >>>
> > >>> But getting back to the topic at hand. I vaguely remember discussio=
n
> > >>> we had, but it would be good if you could summarize it again here t=
o
> > >>> avoid talking past each other. What is the bpf_map_ops changes you
> > >>> were thinking to do? How bpf_attr will look like? How BPF-side API =
for
> > >>> lookup/delete/update will look like? And then let's go from there?
> > >>> Thanks!
> > >>>
> > >>> .
> > >> The APIs for qp-trie are composed of the followings 5 parts:
> > >>
> > >> (1) map definition for qp-trie
> > >>
> > >> The key is bpf_dynptr and map_extra specifies the max length of key.
> > >>
> > >> struct {
> > >>     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> > >>     __type(key, struct bpf_dynptr);
> > >>     __type(value, unsigned int);
> > >>     __uint(map_flags, BPF_F_NO_PREALLOC);
> > >>     __uint(map_extra, 1024);
> > >> } qp_trie SEC(".maps");
> > >>
> > >> (2) bpf_attr
> > >>
> > >> Add key_sz & next_key_sz into anonymous struct to support map with
> > >> variable-size key. We could add value_sz if the map with variable-si=
ze
> > >> value is supported in the future.
> > >>
> > >>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands=
 */
> > >>                 __u32           map_fd;
> > >>                 __aligned_u64   key;
> > >>                 union {
> > >>                         __aligned_u64 value;
> > >>                         __aligned_u64 next_key;
> > >>                 };
> > >>                 __u64           flags;
> > >>                 __u32           key_sz;
> > >>                 __u32           next_key_sz;
> > >>         };
> > >>
> > >> (3) libbpf API
> > >>
> > >> Add bpf_map__get_next_sized_key() to high level APIs.
> > >>
> > >> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map=
,
> > >>                                            const void *cur_key,
> > >>                                            size_t cur_key_sz,
> > >>                                            void *next_key, size_t
> > >> *next_key_sz);
> > >>
> > >> Add
> > >> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_dele=
te_sized_elem()/bpf_map_get_next_sized_key()
> > >> to low level APIs.
> > >> These APIs have already considered the case in which map has
> > >> variable-size value, so there will be no need to add other new APIs =
to
> > >> support such case.
> > >>
> > >> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, si=
ze_t
> > >> key_sz,
> > >>                                          const void *value, size_t v=
alue_sz,
> > >>                                          __u64 flags);
> > >> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, si=
ze_t
> > >> key_sz,
> > >>                                          void *value, size_t *value_=
sz,
> > >>                                          __u64 flags);
> > >> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, si=
ze_t
> > >> key_sz,
> > >>                                          __u64 flags);
> > >> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
> > >>                                           const void *key, size_t ke=
y_sz,
> > >>                                           void *next_key, size_t
> > >> *next_key_sz);
> > > I don't like this approach.
> > > It looks messy to me and solving one specific case where
> > > key/value is a blob of bytes.
> > > In other words it's taking api to pre-BTF days when everything
> > > was an opaque blob.
> >
> > I see.
> > > I think we need a new object dynptr-like that is composable with othe=
r types.
> > > So that user can say that key is
> > > struct map_key {
> > >    long foo;
> > >    dynptr_like array;
> > >    int bar;
> > > };
> > >
> > > I'm not sure whether the existing bpf_dynptr fits exactly, but it's
> > > close enough.
> > > Such dynptr_like object should be able to be used as a string.
> > > And map should allow two such strings:
> > > struct map_key {
> > >    dynptr_like file_name;
> > >    dynptr_like dir;
> > > };
> > >
> > > and BTF for such map should see distinguish it as two strings
> > > and not as a single blob of bytes.
> > > The observability of bpf maps with bpftool should be able to print it=
.
> > >
> > > The use of such api will look the same from bpf prog and from user sp=
ace.
> > > bpf prog can do:
> > >
> > >  struct map_key key;
> > >  bpf_dynptr_from_whatever(&key.file_name, ...);
> > >  bpf_dynptr_from_whatever(&key.dir, ...);
> > >  bpf_map_lookup_elem(map, &key);
> > >
> > > and similar from user space.
> > > bpf_dynptr_user will be a struct with size and a pointer.
> > > The existing sys_bpf commands will stay as-is.
> > > The user space will do:
> > >
> > > struct map_key {
> > >    bpf_dynptr_user file_name;
> > >    bpf_dynptr_user dir;
> > > } key;
> > >
> > > key.dir.size =3D 1000;
> > > key.dir.ptr =3D malloc(1000);
> > > ...
> > > bpf_map_lookup_elem( &key); // existing syscall cmd
> > >
> > > In this case sizeof(struct map_key) =3D=3D sizeof(bpf_dynptr_user) * =
2 =3D=3D 32
> > >
> > > Both for bpf prog and for user space.
> >
> > It seems the idea could be implemented through both hash-table and qp-t=
rie.
> >
> > For hash-table, firstly we need to keep each offset of these dynptr_lik=
e
> > objects. During update operation, we need to calculate the hash for eac=
h
> > dynptr_like object and combine these hashes into a new hash. During
> > lookup, we need to compare each dynptr_like object alone to check
> > whether or not it is the same as the target element.
> >
> > For qp-trie, we also need to keep the offset for each dynptr_like
> > object. During update operation, we should marshal the passed key into =
a
> > plain blob and save the plain blob in qp-trie. During lookup, we don't
> > marshal the input key, instead we lookup up the qp-trie by using each
> > field in the map key step-wise. However for get_next_key operation, we
> > need to unmarshal the plain blob into a dynptr_like object.
> >
> > For the two hypothetical implementations above, I think the lookup
> > performance may be better than qp-trie and its memory usage will not be
> > bad, so I prefer to support dynptr_like object in hash map key first. W=
DYT ?
> >
>
> These nested variable-sized array fields are not really compatible
> with qp-trie (or any trie data structure) to begin with. I think this
> would be compatible only with hash-based implementations.

I don't see why not. qp-trie can support binary key and Hou approach
sounds very doable.

