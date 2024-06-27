Return-Path: <bpf+bounces-33221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4F919DEE
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 05:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD66B1C21944
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6D17753;
	Thu, 27 Jun 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bILUthLu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2717C68
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459678; cv=none; b=jh+HUTRDQELvi48FZwknl5ggqOU7Paq4Ato29SBvU2C4QQMmH6eQN1Y7KZYpI4Kd23broZo0iYwynU1X9l4QpsFcrMlWZHkXCTp33dBLWIkVbTANAs+Qk5XJVg9O8UI2Wqy8A4RBwm07Ky8Bn9WRmoDUEjqlk8QSyc28BpdgqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459678; c=relaxed/simple;
	bh=xH1sRbvEZFoknDYHNxQgXAMEZckSDMEI59Vwwn9Y0GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkxKEvyqkjvn6Dzj20/DMZzQsLKefWWjLjU+6PUzCPzbzqvvgi3y/QOhXk2eMxTB4Zs3tBh+zZ0ox1ZHzFUyf4UG4XCtR/I7+AJJ5SfCvLg2P8V3xVouTIfMbwjT0Tn21ux8hkgy1E0i99ye5vt8dEaKXe8DnuaGdEOA4jL4uuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bILUthLu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-364a39824baso5225616f8f.1
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719459675; x=1720064475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRT+MG5MZyLUcm7cEY4E72fph/pT1szje4C69FOEh4M=;
        b=bILUthLuqb06qvXqk1RwKwiJ12bYNcEIAb2yO2mS2/HYYpFPRlhaxIMn3V3coCQRCr
         w8MO9ojA6AnyscaC/DIgfkW5M6uQTIzzXjAAAWmgSPUE4WICP4GWVEa/GHG2ejGdxiL9
         Sa7yLWncWwD904yvnEHdr+Z83HDZPsw7vboy+vaj+n6GjvXyw/QSZMA277onb2LKhN+n
         UOBCs40KVLL870KIybS0/w6EoaMgunV4Pc1vvwplmUpoClIF4+ntT0ppw1dmuMlCrVIc
         c+iOY9rGN6D+5nsEPzYq/4sTbwC6f21ypIGhR017a8u4KIAVRuEPt8xUpsJU/lI+6OVH
         Krfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719459675; x=1720064475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRT+MG5MZyLUcm7cEY4E72fph/pT1szje4C69FOEh4M=;
        b=CIMvhVA6EgTojjGmkfvjWVepWaLJwsZi9yLPz+2cBDXb6o+Cby/VrOwGEyP5GGJ8Jp
         +Pm44MQdMLqZbDuN6lYaMlh0lT4DoalHdKVtL0itGNO5aIx5FsASMhsLqEMOsLNFUgeH
         wIxIcj5Xvpl1+i8TZ3FANpscz2OESSkXfMHxxH5KOdlV92iX/OFw6CO6WTXVkjx/CLyo
         KPpuwk3NQjqYbXv+aUNbNXjT0uZxckRg+OSG0Xu1Jz5lzxSN+sxNiC53qTeGCdAkxmYi
         hPyVKNVOdHCOQegZv+He1C2hTbMYSoNTDcKgdXKXIDwMyitTfUdMfKe6JtocXk7OjA9Z
         z+oA==
X-Forwarded-Encrypted: i=1; AJvYcCWoqL6nPyxzwhaxpeUbAqfPUq825q0VAihqWBf4Q0x4g55yUTnZNXH2gxEYrnHhUVHw8atEB78XzDJs9awvlXvBJ9cM
X-Gm-Message-State: AOJu0Yz1fLTjswTQxwK38gm2b+J7bvy22cULi5gPMOJKGX5da4cPODSu
	wD7440kFHr7UiSM/hZjTnjoxcbz0PCZwLhGhAcWsxsCo7E6CCwgLvP8KeV0Du9et2G20j/YKb0c
	Lfm3vjbkwcXjAYgK55bEmzgxn988KNaA+
X-Google-Smtp-Source: AGHT+IF4VhhTY+m+T/e6Wxo/6PnP+N3ioLDyCxoa75Pe58MqPz36WP+Dqp8O7WGoPOY5OFXSJeogHq/2bc8qX0HzOVA=
X-Received: by 2002:a5d:64ca:0:b0:366:efab:2fb1 with SMTP id
 ffacd0b85a97d-366efab327cmr10119971f8f.38.1719459675169; Wed, 26 Jun 2024
 20:41:15 -0700 (PDT)
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
 <CAEf4BzbCL0=MwUbepa6Yk0GxsNtsF4JvHFcygBF_QOZCwtHj=A@mail.gmail.com>
In-Reply-To: <CAEf4BzbCL0=MwUbepa6Yk0GxsNtsF4JvHFcygBF_QOZCwtHj=A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 20:41:03 -0700
Message-ID: <CAADnVQJ=zAUVnU=CczsqpAyytKUigaAW6A62_SgEQUkF7GuDUQ@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 4:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 25, 2024 at 7:06=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> > >
> > > Hi,
> > >
> > > Sorry to resurrect the old thread to continue the discussion of APIs =
for
> > > qp-trie.
> > >
> > > On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > > > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud=
.com> wrote:
> > > >> Hi,
> > > >>
> > >
> > > SNIP
> > >
> > > >> updated to allow using dynptr as map key for qp-trie.
> > > >>> And that's the problem I just mentioned.
> > > >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to als=
o
> > > >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type)=
.
> > > >> Sorry for misunderstanding your reply. But before switch to the kf=
uncl
> > > >> way, could you please point me to some code or function which show=
s the
> > > >> specialty of PTR_MAP_KEY ?
> > > >>
> > > >>
> > > > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > > > logic assumes that there is associated struct bpf_map * pointer fro=
m
> > > > which we know fixed-sized key length.
> > > >
> > > > But getting back to the topic at hand. I vaguely remember discussio=
n
> > > > we had, but it would be good if you could summarize it again here t=
o
> > > > avoid talking past each other. What is the bpf_map_ops changes you
> > > > were thinking to do? How bpf_attr will look like? How BPF-side API =
for
> > > > lookup/delete/update will look like? And then let's go from there?
> > > > Thanks!
> > > >
> > > > .
> > >
> > > The APIs for qp-trie are composed of the followings 5 parts:
> > >
> > > (1) map definition for qp-trie
> > >
> > > The key is bpf_dynptr and map_extra specifies the max length of key.
> > >
> > > struct {
> > >     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> > >     __type(key, struct bpf_dynptr);
> > >     __type(value, unsigned int);
> > >     __uint(map_flags, BPF_F_NO_PREALLOC);
> > >     __uint(map_extra, 1024);
> > > } qp_trie SEC(".maps");
> > >
> > > (2) bpf_attr
> > >
> > > Add key_sz & next_key_sz into anonymous struct to support map with
> > > variable-size key. We could add value_sz if the map with variable-siz=
e
> > > value is supported in the future.
> > >
> > >         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands =
*/
> > >                 __u32           map_fd;
> > >                 __aligned_u64   key;
> > >                 union {
> > >                         __aligned_u64 value;
> > >                         __aligned_u64 next_key;
> > >                 };
> > >                 __u64           flags;
> > >                 __u32           key_sz;
> > >                 __u32           next_key_sz;
> > >         };
> > >
> > > (3) libbpf API
> > >
> > > Add bpf_map__get_next_sized_key() to high level APIs.
> > >
> > > LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
> > >                                            const void *cur_key,
> > >                                            size_t cur_key_sz,
> > >                                            void *next_key, size_t
> > > *next_key_sz);
> > >
> > > Add
> > > bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delet=
e_sized_elem()/bpf_map_get_next_sized_key()
> > > to low level APIs.
> > > These APIs have already considered the case in which map has
> > > variable-size value, so there will be no need to add other new APIs t=
o
> > > support such case.
> > >
> > > LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, siz=
e_t
> > > key_sz,
> > >                                          const void *value, size_t va=
lue_sz,
> > >                                          __u64 flags);
> > > LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, siz=
e_t
> > > key_sz,
> > >                                          void *value, size_t *value_s=
z,
> > >                                          __u64 flags);
> > > LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, siz=
e_t
> > > key_sz,
> > >                                          __u64 flags);
> > > LIBBPF_API int bpf_map_get_next_sized_key(int fd,
> > >                                           const void *key, size_t key=
_sz,
> > >                                           void *next_key, size_t
> > > *next_key_sz);
> >
> > I don't like this approach.
> > It looks messy to me and solving one specific case where
> > key/value is a blob of bytes.
> > In other words it's taking api to pre-BTF days when everything
> > was an opaque blob.
> > I think we need a new object dynptr-like that is composable with other =
types.
> > So that user can say that key is
> > struct map_key {
> >    long foo;
> >    dynptr_like array;
> >    int bar;
> > };
> >
> > I'm not sure whether the existing bpf_dynptr fits exactly, but it's
> > close enough.
> > Such dynptr_like object should be able to be used as a string.
> > And map should allow two such strings:
> > struct map_key {
> >    dynptr_like file_name;
> >    dynptr_like dir;
> > };
>
> "bpf_byte_slice" or something like that? Or you want that memory to
> also not be just bytes and instead be yet another type? I.e., how far
> is this dynamic variably-sized concept will go? Just one level or
> more?

Arrays of structs is imo overkill at this point.
So just one level and just bytes.
That will be enough to significantly improve bpftrace performance.

> And when an update is done for such a key, map implementation will do
> extra memory allocations to create a copy, is that the idea?

According to Hou's plan in qp-trie it will be one long binary key.
No extra allocs.
For hash map we can do similar.
Every key can be inline marshaled key without extra indirection.
Or each dynptr can map to exactly dynptr in a key.
Then extra alloc for data will be needed.
I suspect that will be slower and more complex code.
One marshaled key with all fields feels simpler.
I believe that's what Hou is proposing.

