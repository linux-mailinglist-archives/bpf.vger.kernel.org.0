Return-Path: <bpf+bounces-33382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29491C911
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE521C226E6
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20681AD7;
	Fri, 28 Jun 2024 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeX2p3sD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB18286A
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613456; cv=none; b=cq4jGkonYHEmzZ7H8wliWD1FnpY29W/R6jb9nhuyqh7WQeBfzDxhg5I9n/8UefkTetzuiJleI9AlzdmwsIjlh2jSwrX2ZUstYWNQREET/MWX9F4Kg0ZB+yHGWZKieLOGEgBcmiD9QSZ4+HJ1vduXGVY+T/wMymGfewNSqi7JFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613456; c=relaxed/simple;
	bh=l6JvM9U04VvGNIM242oGsPnJzpY1cADYujCUYpk0jY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9Wpez0iPZsDIlZzo/orTYJwJmflugqAH8BNN4RRiKx7ZZtwvI6BvgES1NKKCfj3VAWkslcAZvORtIIHiFtZcAkLw1ruowRcEHs1TD52BmJBr235sofLqtlflcNUm/s3iLfUC2TIMl+Aq0fVNnOSgQU+1vrBX6cjVVg78N5fIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeX2p3sD; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc66c649so613470b6e.1
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719613454; x=1720218254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da4Fp7oTEJFghKsx38ltWrOfj/XNNfGSccCKX7/q36Y=;
        b=jeX2p3sD0KASNuAC13ZAVEOceqnj6EPEFMlO0hCLUrhvqMSIWe+k8KbBD3cKH8Esw8
         b7To5D6fKOWiiJYQw3s9r/eFj4NDaT5wAtcWKt+iA1zFiLstpqLd1wdbkDak+pPgG/tM
         +Uy0RIkwx+utM06FkRNZ5VBij+JNtn7C5t+ImFxSsnrUgLM+ObJPJL8nj3JwwavCfX1F
         qNTen6dIaxjNffiM2FcyBxTsX/teKboWXPNeCaonJmrWCDLy1j/I6d9l8pEpibzd0y7h
         138VIbmwzY9DTfQMplEPT9VHKgftxctdgp+jGdBkPUAd1beXU0Y7QdrJseB8vbQijFSH
         Wx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719613454; x=1720218254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Da4Fp7oTEJFghKsx38ltWrOfj/XNNfGSccCKX7/q36Y=;
        b=g8cQBXO7wBcfE12ZUmKhBV4jOBdU6Jwuow6N6ZRn78fuVJoDlrCxvXyC7LdsbPxlOZ
         gagG5t/R2MAHIf3aBbYf0f9kkvGNluCSwqFry95P0FnKXHOKgHhzqnEZGQ0D7zDBugst
         DgLkRGxMVB4uXGJzHUGj5ZHh5hkhs4NJ7L6EVTZTwMQIV5MgoTC4UCefnzTFteAaODAL
         6eW8thHuh4HE+XLlvGwvyufLfGWUWAVETMwZTv46O53rCpEn3pOHC0F25n0RUHmL79PD
         ZKWsNExuyLmUQfxh89pV6f36+fMqHkf2Azcw3H3Xf45e781skHzEjQnsGGqPvdgagp7W
         QJHg==
X-Forwarded-Encrypted: i=1; AJvYcCXi0Ujv5AqKGv+s+R7ThxnILy937OKZVa8EAjjfyZ0fNLrIR6zNrM72qABp4XcWhxK1gIv6TXvBlAaDvEZ3tOZm1xDV
X-Gm-Message-State: AOJu0YxwAbbucaaad5SO/kF1/3I/3QtAhdRUv1BzcBWmHI6gakZRxSxi
	J1b/2m5BTpzrBNUAjKk8atLlb2YbGVv5IlB5Sv2wo9r1uSoiGmWL2YjzoebpON0OinL43r/iDnQ
	Hg0woBpv9WNtRSz5urrcSe3N1hwPaeg==
X-Google-Smtp-Source: AGHT+IH3Pmfz3D6yi1LLgqY6PgkntL8UaE7O6YXz3oD4gQBV9X7UfCzHy+djX9ev8L3rLMBMmtODnPUUK0PhW9yNwYM=
X-Received: by 2002:a05:6808:1a13:b0:3d6:38c2:fcd6 with SMTP id
 5614622812f47-3d638c30536mr587135b6e.1.1719613454216; Fri, 28 Jun 2024
 15:24:14 -0700 (PDT)
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
 <CAEf4BzbCL0=MwUbepa6Yk0GxsNtsF4JvHFcygBF_QOZCwtHj=A@mail.gmail.com> <CAADnVQJ=zAUVnU=CczsqpAyytKUigaAW6A62_SgEQUkF7GuDUQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ=zAUVnU=CczsqpAyytKUigaAW6A62_SgEQUkF7GuDUQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 15:24:02 -0700
Message-ID: <CAEf4BzbnKeZp7JUELFs6gwxt_ywEwu76avrv0Jg6-KmQsOVdPg@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 8:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 26, 2024 at 4:59=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 7:06=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sorry to resurrect the old thread to continue the discussion of API=
s for
> > > > qp-trie.
> > > >
> > > > On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > > > > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweiclo=
ud.com> wrote:
> > > > >> Hi,
> > > > >>
> > > >
> > > > SNIP
> > > >
> > > > >> updated to allow using dynptr as map key for qp-trie.
> > > > >>> And that's the problem I just mentioned.
> > > > >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to a=
lso
> > > > >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map typ=
e).
> > > > >> Sorry for misunderstanding your reply. But before switch to the =
kfuncl
> > > > >> way, could you please point me to some code or function which sh=
ows the
> > > > >> specialty of PTR_MAP_KEY ?
> > > > >>
> > > > >>
> > > > > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. Th=
e
> > > > > logic assumes that there is associated struct bpf_map * pointer f=
rom
> > > > > which we know fixed-sized key length.
> > > > >
> > > > > But getting back to the topic at hand. I vaguely remember discuss=
ion
> > > > > we had, but it would be good if you could summarize it again here=
 to
> > > > > avoid talking past each other. What is the bpf_map_ops changes yo=
u
> > > > > were thinking to do? How bpf_attr will look like? How BPF-side AP=
I for
> > > > > lookup/delete/update will look like? And then let's go from there=
?
> > > > > Thanks!
> > > > >
> > > > > .
> > > >
> > > > The APIs for qp-trie are composed of the followings 5 parts:
> > > >
> > > > (1) map definition for qp-trie
> > > >
> > > > The key is bpf_dynptr and map_extra specifies the max length of key=
.
> > > >
> > > > struct {
> > > >     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> > > >     __type(key, struct bpf_dynptr);
> > > >     __type(value, unsigned int);
> > > >     __uint(map_flags, BPF_F_NO_PREALLOC);
> > > >     __uint(map_extra, 1024);
> > > > } qp_trie SEC(".maps");
> > > >
> > > > (2) bpf_attr
> > > >
> > > > Add key_sz & next_key_sz into anonymous struct to support map with
> > > > variable-size key. We could add value_sz if the map with variable-s=
ize
> > > > value is supported in the future.
> > > >
> > > >         struct { /* anonymous struct used by BPF_MAP_*_ELEM command=
s */
> > > >                 __u32           map_fd;
> > > >                 __aligned_u64   key;
> > > >                 union {
> > > >                         __aligned_u64 value;
> > > >                         __aligned_u64 next_key;
> > > >                 };
> > > >                 __u64           flags;
> > > >                 __u32           key_sz;
> > > >                 __u32           next_key_sz;
> > > >         };
> > > >
> > > > (3) libbpf API
> > > >
> > > > Add bpf_map__get_next_sized_key() to high level APIs.
> > > >
> > > > LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *ma=
p,
> > > >                                            const void *cur_key,
> > > >                                            size_t cur_key_sz,
> > > >                                            void *next_key, size_t
> > > > *next_key_sz);
> > > >
> > > > Add
> > > > bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_del=
ete_sized_elem()/bpf_map_get_next_sized_key()
> > > > to low level APIs.
> > > > These APIs have already considered the case in which map has
> > > > variable-size value, so there will be no need to add other new APIs=
 to
> > > > support such case.
> > > >
> > > > LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, s=
ize_t
> > > > key_sz,
> > > >                                          const void *value, size_t =
value_sz,
> > > >                                          __u64 flags);
> > > > LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, s=
ize_t
> > > > key_sz,
> > > >                                          void *value, size_t *value=
_sz,
> > > >                                          __u64 flags);
> > > > LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, s=
ize_t
> > > > key_sz,
> > > >                                          __u64 flags);
> > > > LIBBPF_API int bpf_map_get_next_sized_key(int fd,
> > > >                                           const void *key, size_t k=
ey_sz,
> > > >                                           void *next_key, size_t
> > > > *next_key_sz);
> > >
> > > I don't like this approach.
> > > It looks messy to me and solving one specific case where
> > > key/value is a blob of bytes.
> > > In other words it's taking api to pre-BTF days when everything
> > > was an opaque blob.
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
> >
> > "bpf_byte_slice" or something like that? Or you want that memory to
> > also not be just bytes and instead be yet another type? I.e., how far
> > is this dynamic variably-sized concept will go? Just one level or
> > more?
>
> Arrays of structs is imo overkill at this point.
> So just one level and just bytes.

yep, agreed

> That will be enough to significantly improve bpftrace performance.
>
> > And when an update is done for such a key, map implementation will do
> > extra memory allocations to create a copy, is that the idea?
>
> According to Hou's plan in qp-trie it will be one long binary key.
> No extra allocs.

I see, I missed that part.

One part which made me say that this approach isn't compatible with
qp-trie is that trie generally supports "find lexicographically next
key" operation, but here it just won't work. But thinking about
qp-trie some more, I'm not sure it actually supports lexicographically
next key, so it's a moot point.

> For hash map we can do similar.
> Every key can be inline marshaled key without extra indirection.
> Or each dynptr can map to exactly dynptr in a key.
> Then extra alloc for data will be needed.
> I suspect that will be slower and more complex code.
> One marshaled key with all fields feels simpler.
> I believe that's what Hou is proposing.

