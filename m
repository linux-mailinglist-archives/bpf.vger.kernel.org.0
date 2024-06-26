Return-Path: <bpf+bounces-33206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D4919B83
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 02:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CCFB22CDF
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 00:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AB1946AC;
	Wed, 26 Jun 2024 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJtbRPDa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09671946AB
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719446398; cv=none; b=oQZZ7sGcn8uJcNowYZNCsPHMkHVAUAklbayHWOzy2y7u+kDfpk6H2NO9g45NxosSeBiTQAHUiCwxhp7PAlJpAhfHzHuv1Nfag6aPMREroOzhW+RIP7sG9L9/4Zl2ABrOHrD/ZITE2ciuhGPJHgtmdpE1tz7srsMIO2rC7k2nh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719446398; c=relaxed/simple;
	bh=NE0v73g2YBDzUpYVSZ9tLq+k2czDWkr7DgqhbR9QT+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOHxAnSfRn2xAoTwcLWSLnnDFjAeBiNFGED6aQu+GyjCw+V9LPuMcqsj9W6JI6zcy8NJ5ErkUoZiMTsXxnK/Avs6mwbA65iEqbG1sDhNoKwmbwDiNlkywR/7QYvV+dM4kJeOPx0m2cZtfodsOPW71J2CuuT2M2DHkTl9/fw+wrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJtbRPDa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7178727da84so3921267a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719446396; x=1720051196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMPZIFBFkVIZ9BKoterNBG5bapmy77fvz9pohnFLDUc=;
        b=RJtbRPDaUBR+Xqsqk4K1KRN2W3YYc9tu4JwxWDaiNRDQQFIz/nVsmJDmlna3IgZonp
         SvTSlnFKeVb0u8fueJmL3DQkyOQQp/dImMUbO2Nn84dvuK8kGXIV/83n1+XkQwWQ3A6G
         hD0ey2LRBUg6G8q9rBOEXENISIUOvlwWpRRPUdCTA5oSupXy6mHTP/itkLqwVrN9FAJn
         fPhSEYYcj0x68EjJtB3fQgt92r3Ttc7vDgbfDZJC505ZN15KfEsMfSoTQFvvRrjW7nzQ
         41cHq9znNfYmEUmO/icuZ/EdabOj8XQOPW9DHHVjMrnDCIG5XQxq029iXXv0fq57Wp29
         JYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719446396; x=1720051196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMPZIFBFkVIZ9BKoterNBG5bapmy77fvz9pohnFLDUc=;
        b=pQcz4SjeM6wBeX1QR/JCSyUbUeooyuX0V56zvjiktttd1cMYBgBgGmDDBA3i8XMPde
         oMAsV7cD4lsYQ8QEaf5E2D6lWjaRhd+ISEsWAG9Hjec3QEFDXDPQ5xZOCN0Bur9oTyLr
         jEvBKxooZ2kF1bW3WkApm/3mw6pahYRkI1XNje6L+h+rsbOVEOkLsdiHyYNcYMa5BHe1
         shvA6VLjKCjd/hiGfFMMvCaNXFYyIuqzx0uQRxJl+HCbXTToeuw8weRQPI68vMmpQWM0
         XlZ1F0RbK9KwwlM5tdk1ZkHwg9lU5gNGNnsTeCtlwNYyKyGtCjdNLEIZXOwBlEHg9tq9
         qzRw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZuFAXgfDHznuHmjNejD1l25TrWRHY1t+b/h+4PSotT3a/hDYarblVN6lJowWRLpTffZibvcrnh5+IVR89bB0wFBw
X-Gm-Message-State: AOJu0YyAZ/kkOffSynX1tX7Avg73y0rQFca+ODNVyUzX7q5HBCiJ2FIa
	y8gbac5YQ0CzE5NMGElQ2N62Rq5O15yW3xM8LLgijLhwiqHDvpMMxgXo24Au8DSTw47NC1Ekk6U
	7pUaubGqwQDtmr+XxXU7lo1Fbvys=
X-Google-Smtp-Source: AGHT+IEP8UU8waMw3CKJ2hVSN/tBslOW0POqBpsKbp/I4Izi7WC62Eh2Fbv1uweSYBI/Bc8IzHwxEGXK1ddf5Vzo3eM=
X-Received: by 2002:a05:6a20:1e5e:b0:1be:c88f:c60d with SMTP id
 adf61e73a8af0-1bec88fcd54mr1281837637.56.1719446395814; Wed, 26 Jun 2024
 16:59:55 -0700 (PDT)
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
In-Reply-To: <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 16:59:43 -0700
Message-ID: <CAEf4BzbCL0=MwUbepa6Yk0GxsNtsF4JvHFcygBF_QOZCwtHj=A@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > Hi,
> >
> > Sorry to resurrect the old thread to continue the discussion of APIs fo=
r
> > qp-trie.
> >
> > On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > >> Hi,
> > >>
> >
> > SNIP
> >
> > >> updated to allow using dynptr as map key for qp-trie.
> > >>> And that's the problem I just mentioned.
> > >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> > >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> > >> Sorry for misunderstanding your reply. But before switch to the kfun=
cl
> > >> way, could you please point me to some code or function which shows =
the
> > >> specialty of PTR_MAP_KEY ?
> > >>
> > >>
> > > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > > logic assumes that there is associated struct bpf_map * pointer from
> > > which we know fixed-sized key length.
> > >
> > > But getting back to the topic at hand. I vaguely remember discussion
> > > we had, but it would be good if you could summarize it again here to
> > > avoid talking past each other. What is the bpf_map_ops changes you
> > > were thinking to do? How bpf_attr will look like? How BPF-side API fo=
r
> > > lookup/delete/update will look like? And then let's go from there?
> > > Thanks!
> > >
> > > .
> >
> > The APIs for qp-trie are composed of the followings 5 parts:
> >
> > (1) map definition for qp-trie
> >
> > The key is bpf_dynptr and map_extra specifies the max length of key.
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> >     __type(key, struct bpf_dynptr);
> >     __type(value, unsigned int);
> >     __uint(map_flags, BPF_F_NO_PREALLOC);
> >     __uint(map_extra, 1024);
> > } qp_trie SEC(".maps");
> >
> > (2) bpf_attr
> >
> > Add key_sz & next_key_sz into anonymous struct to support map with
> > variable-size key. We could add value_sz if the map with variable-size
> > value is supported in the future.
> >
> >         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> >                 __u32           map_fd;
> >                 __aligned_u64   key;
> >                 union {
> >                         __aligned_u64 value;
> >                         __aligned_u64 next_key;
> >                 };
> >                 __u64           flags;
> >                 __u32           key_sz;
> >                 __u32           next_key_sz;
> >         };
> >
> > (3) libbpf API
> >
> > Add bpf_map__get_next_sized_key() to high level APIs.
> >
> > LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
> >                                            const void *cur_key,
> >                                            size_t cur_key_sz,
> >                                            void *next_key, size_t
> > *next_key_sz);
> >
> > Add
> > bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_=
sized_elem()/bpf_map_get_next_sized_key()
> > to low level APIs.
> > These APIs have already considered the case in which map has
> > variable-size value, so there will be no need to add other new APIs to
> > support such case.
> >
> > LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_=
t
> > key_sz,
> >                                          const void *value, size_t valu=
e_sz,
> >                                          __u64 flags);
> > LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_=
t
> > key_sz,
> >                                          void *value, size_t *value_sz,
> >                                          __u64 flags);
> > LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_=
t
> > key_sz,
> >                                          __u64 flags);
> > LIBBPF_API int bpf_map_get_next_sized_key(int fd,
> >                                           const void *key, size_t key_s=
z,
> >                                           void *next_key, size_t
> > *next_key_sz);
>
> I don't like this approach.
> It looks messy to me and solving one specific case where
> key/value is a blob of bytes.
> In other words it's taking api to pre-BTF days when everything
> was an opaque blob.
> I think we need a new object dynptr-like that is composable with other ty=
pes.
> So that user can say that key is
> struct map_key {
>    long foo;
>    dynptr_like array;
>    int bar;
> };
>
> I'm not sure whether the existing bpf_dynptr fits exactly, but it's
> close enough.
> Such dynptr_like object should be able to be used as a string.
> And map should allow two such strings:
> struct map_key {
>    dynptr_like file_name;
>    dynptr_like dir;
> };

"bpf_byte_slice" or something like that? Or you want that memory to
also not be just bytes and instead be yet another type? I.e., how far
is this dynamic variably-sized concept will go? Just one level or
more?

And when an update is done for such a key, map implementation will do
extra memory allocations to create a copy, is that the idea?

>
> and BTF for such map should see distinguish it as two strings
> and not as a single blob of bytes.
> The observability of bpf maps with bpftool should be able to print it.
>
> The use of such api will look the same from bpf prog and from user space.
> bpf prog can do:
>
>  struct map_key key;
>  bpf_dynptr_from_whatever(&key.file_name, ...);
>  bpf_dynptr_from_whatever(&key.dir, ...);
>  bpf_map_lookup_elem(map, &key);
>
> and similar from user space.
> bpf_dynptr_user will be a struct with size and a pointer.
> The existing sys_bpf commands will stay as-is.
> The user space will do:
>
> struct map_key {
>    bpf_dynptr_user file_name;
>    bpf_dynptr_user dir;
> } key;
>
> key.dir.size =3D 1000;
> key.dir.ptr =3D malloc(1000);
> ...
> bpf_map_lookup_elem( &key); // existing syscall cmd
>
> In this case sizeof(struct map_key) =3D=3D sizeof(bpf_dynptr_user) * 2 =
=3D=3D 32
>
> Both for bpf prog and for user space.

