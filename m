Return-Path: <bpf+bounces-33011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD6B915D85
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5019E1F22492
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5613C918;
	Tue, 25 Jun 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg5o8ziu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112574BF5
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287758; cv=none; b=jNR/EwS3sx8dD0HAsHa6LNCxkkoz01mKcOJpuUeRXkAGDpYKY9MFdBUG4LXty07bCvjOq6fe6eESm9e12rU8nXUmp9a6pTc9b4KzStl1mM/kCdrpr2Z1XWDF9WgFVadjc0158KUlCNIHV2I0cozPKJO1554zdDHrkQofqwBUZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287758; c=relaxed/simple;
	bh=zG4bKZUDeGvvF6xYLrWdbLTNx6HjQBPcsn8e/tb/zMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eInckxD4eLAaRZlyskVShJkaqIcLJCncqyn1Kf7MdaLXnUdrAllwgguExnQpqbD15IVM1g+LWcMlxL2lWLCPCFod56+/MznsNAHgWG0/Jq1Vb7zx8Wh/nVDL0g8hv4+mAao8zdSL1WWbx50v/ttvIvnidTUVMRvDZURDwWad7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg5o8ziu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706680d3a25so1846031b3a.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719287756; x=1719892556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbirYgwod+538q6M4lgBm9PAcfLerWpLMOOiCD+vVU0=;
        b=Xg5o8ziuOOwmGNGOxaNoBcRcavYoRhxoabUdDeR1/pYAggYBQglJ/xgEwGoRkRmq0T
         vLWPvVSE3F/jWpMgPhi3xGstKQ9ppjtqKHy4+BdnsT42h59MoixxHB7OLMEJhJ185T8a
         9A7lek6Tis493fcbYeWKOb6Lh9LFibKUD83xve0c1AhnU+AcVDcz8QvssbxMqk1ieYRm
         QIo9xXv3ai9RHVeluSn1IfkF7lXpJJba0Ya6zFwhtZtEHduPp4LMz5KExlvq89IisW+B
         NPaD4KrOokjfzj2jlSqskvlbkRFsiDUwtlfXw0+CTINv+/Vak/1nNoZGbkDkWjUj4jbc
         zshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719287756; x=1719892556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbirYgwod+538q6M4lgBm9PAcfLerWpLMOOiCD+vVU0=;
        b=wz8Vjy4VoYrjDr09U/FiInUJTc8J2mE+gOCMKdSFTUkRKySwMYwfrWMObZ8Aa0zj5K
         RlfSQRYBDnupbl7Kt/9N6uD1RpHKcwIaGDIJ+WGfL9rasooy6T5rY7zTkOQXTwhxaJUr
         VMm6VvXX8fwPT8ay4Q1KwmV2CNUrSW7wzZ0kR10zPqK+aJA5ChKI8z0V/u3V8RRQqOrq
         SaHce/rzweupQB5Qm2YGKnke+qRU2rtQc3Ip3MCFWXg/t8pkCKZlVd9z0d5p6qUOrK6S
         jOciGZd7crDpFZJWnx53xLq9uDmjCxNMHEHx9LEeu02+Fv6Uk+Itkm/3qtGsDZ8Dyodl
         mENA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Mat7wA4VcHxH5N+RQnRrq13q8bPp7bUvPMKf+ynYURzYzANX9troKrtzAYKXG0/AB4MWGlpVdPk/8458wB9KTJSO
X-Gm-Message-State: AOJu0Yyy7AOsodxlKae3lw1In10410yspig1M8927c3Ch7QolxM5wm0W
	1MyiWYzRUsAe0nTrgbOKlH3+w3djIf4semJ7g419vaDBxgB1XZ3GIll3XLQPn1jgdD+xj+h6mgA
	DwwpGMiUULnGPZYYCoic6QTNGmJM=
X-Google-Smtp-Source: AGHT+IFX2Null8PzgEBu/TSlKmyEyCjnn1mTumZLMqjaHn+EGSQPKkOXdyypVkk7cwvv5V+Tl9w8EO7dtgy6RlSaq9c=
X-Received: by 2002:a05:6a20:b91e:b0:1bc:f2f7:cf73 with SMTP id
 adf61e73a8af0-1bcf464560amr5214377637.55.1719287755576; Mon, 24 Jun 2024
 20:55:55 -0700 (PDT)
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
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
In-Reply-To: <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 20:55:43 -0700
Message-ID: <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> Sorry to resurrect the old thread to continue the discussion of APIs for
> qp-trie.
>
> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
>
> SNIP
>
> >> updated to allow using dynptr as map key for qp-trie.
> >>> And that's the problem I just mentioned.
> >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> >> Sorry for misunderstanding your reply. But before switch to the kfuncl
> >> way, could you please point me to some code or function which shows th=
e
> >> specialty of PTR_MAP_KEY ?
> >>
> >>
> > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > logic assumes that there is associated struct bpf_map * pointer from
> > which we know fixed-sized key length.
> >
> > But getting back to the topic at hand. I vaguely remember discussion
> > we had, but it would be good if you could summarize it again here to
> > avoid talking past each other. What is the bpf_map_ops changes you
> > were thinking to do? How bpf_attr will look like? How BPF-side API for
> > lookup/delete/update will look like? And then let's go from there?
> > Thanks!
> >
> > .
>
> The APIs for qp-trie are composed of the followings 5 parts:
>
> (1) map definition for qp-trie
>
> The key is bpf_dynptr and map_extra specifies the max length of key.
>
> struct {
>     __uint(type, BPF_MAP_TYPE_QP_TRIE);
>     __type(key, struct bpf_dynptr);

I'm not sure we need `struct bpf_dynptr` as the key type. We can just
say that key_size has to be zero, and actual keys are variable-sized.

Alternatively, we can treat key_size as "maximum key size", any
attempt to use longer keys will be rejected.

But in either case "struct bpf_dynptr" as key type seems wrong to me.


>     __type(value, unsigned int);
>     __uint(map_flags, BPF_F_NO_PREALLOC);
>     __uint(map_extra, 1024);
> } qp_trie SEC(".maps");
>
> (2) bpf_attr
>
> Add key_sz & next_key_sz into anonymous struct to support map with
> variable-size key. We could add value_sz if the map with variable-size
> value is supported in the future.
>
>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>                 __u32           map_fd;
>                 __aligned_u64   key;
>                 union {
>                         __aligned_u64 value;
>                         __aligned_u64 next_key;
>                 };
>                 __u64           flags;
>                 __u32           key_sz;
>                 __u32           next_key_sz;
>         };
>

Yep, this seems inevitable. And yes, value_sz seems like a reasonable
thing to have. It might be an option/flag whether QP-trie has
fixed-sized or variable-sized value, I guess. But we can get there
after all the other things are figured out.

> (3) libbpf API
>
> Add bpf_map__get_next_sized_key() to high level APIs.

All the *_sized_* names are... unfortunate, tbh. I'm not sure what's
the right naming, but "sized" in the middle doesn't seem that. I think
it should be a uniform suffix. Maybe something like "_varsz",
"_varlen", or at least "_sized" (but as a suffix)?...

>
> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
>                                            const void *cur_key,
>                                            size_t cur_key_sz,
>                                            void *next_key, size_t
> *next_key_sz);
>
> Add
> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete_si=
zed_elem()/bpf_map_get_next_sized_key()
> to low level APIs.
> These APIs have already considered the case in which map has
> variable-size value, so there will be no need to add other new APIs to
> support such case.
>
> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          const void *value, size_t value_=
sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          void *value, size_t *value_sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size_t
> key_sz,
>                                          __u64 flags);
> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
>                                           const void *key, size_t key_sz,
>                                           void *next_key, size_t
> *next_key_sz);
>
> (4) bpf_map_ops
>
> Update the arguments for map_get_next_key()/map_lookup_elem_sys_only().
> Add map_update_elem_sys_only()/map_delete_elem_sys_only() into bpf_map_op=
s.
>
> Updating map_update_elem()/map_delete_elem() is also fine, but it may
> introduce too much churn and need to pass map->key_size to these APIs
> for existing callers.
>

We can have a protocol that key_size and value_size might be zero for
fixed-sized maps, in which case key/value size is not
checked/enforced, right?

I think it's much better to keep one universal interface that works
for both fixed- and variable-sized map (especially that we can
technically have maps where fixed-sized or variable-sized is a matter
of choice and some map_flag value).

> struct bpf_map_ops {
>         int (*map_get_next_key)(struct bpf_map *map, void *key, u32
> key_size, void *next_key, u32 *next_key_size);
>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void
> *key, u32 key_size);
>
>         int (*map_update_elem_sys_only)(struct bpf_map *map, void *key,
> u32 key_size, void *value, u64 flags);
>         int (*map_delete_elem_sys_only)(struct bpf_map *map, void *key,
> u32 key_size);
> };
>
> (5) API for bpf program
>
> Instead of supporting bpf_dynptr as ARG_PTR_TO_MAP_KEY, will add three
> new kfuncs to support lookup/update/deletion operation on qp-trie.
>

hopefully those won't be qp-trie specific? Also, are you planning to
have only key variable-sized or value as well?

>

