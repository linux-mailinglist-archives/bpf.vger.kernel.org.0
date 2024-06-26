Return-Path: <bpf+bounces-33204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D06919B6A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9489E285CF8
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0B1940AB;
	Wed, 26 Jun 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByaNF8Q5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976818E777
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445936; cv=none; b=EItRDaI7XpIQPBo75W3J9igXuq8jCHf3roTYQv1lvDgBzzNKHQoKF2vZTDjY/GX4+xp+MJnmCJa6CgFpaJUSGlHFhw5RwjrL2L4qsuni7ChCd1iPWh6cLifpX6YD1W9D5zxp2/wgxTEgdYmHCgRtvvPz0vAfVwSVNT7L6UaATsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445936; c=relaxed/simple;
	bh=VvdYANisgSHyhiGILyZ14emkCtPa9DAqcm8L8fO4Ae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvkd5+cFAYSdOnHjI8BRVslG/SxitIyVE9/lydP6Mo8ppN6nbqB3BJtA/SFSDUQHd9iatYvBLu+yGa5evEyMZYrhsjjvpJ/5xW5ncpTIrPx2bm5LeiIV/0GNuXPqcDEMekfWaxWi0JSNSj875BRwwcmBIFeb5OAbdBuztDAl0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByaNF8Q5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c84df0e2f4so882044a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719445934; x=1720050734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNodtnc12zBFrjEC6zZiq16X3SE4WIHyZgQT7HyqZYA=;
        b=ByaNF8Q5Wie2K7V3a4TfYbu7UiEowjI2+bf5j9bYOommfs2HkeV4P72zlnZ5E8WjxW
         yyhOMqhjgklgjvNnB1xXF/fqP9RzLWtW7PjTStlrE2LajDJx12yODTSCNdSKxRkVeT2r
         b+mx+iL+7vZjG8vSk42WxU0NhaQ4QrVJvOb7R+IXfYpVR34xHGI7cFoE0A3O+MReJa4n
         3vvP35mmAUxMchO1zKC3LJjzoGIQIiQyctnxKdIWGsTKjoqFrIHIif0nEv+8xNtYRBTO
         iWep04wgWbkqkrtVIWzxINU6UgYiHPGVe9OrhxRoVeirFdEAMcDFyp9fMBoP16bSWYAz
         Fqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445934; x=1720050734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNodtnc12zBFrjEC6zZiq16X3SE4WIHyZgQT7HyqZYA=;
        b=IfPMFTxYSHWMkLRgPfV1+EgGTelAw/enZrnTaHUXr6YAihHOnVB6G42DtSxv/lmFQs
         P9SuBmgxayTqnhSM/enzhtychl6EdSsTyV+MYEk6GIz+mp+lFaSNw9+dNRGLz9hVqXxq
         9e3DTE4w1d1GCf3Gc3nYRdXrbfqaxs4Rk7W/mxUYMloOH9aSTftP1LAp+g0i6hIAw5rW
         My8Ga365qjfkizOGEl/2ja+KMZsjdt4mLpG4VUymm5/Pgr6Z8sNiWr0N+pQ89Y1fLo2k
         IVSPEQMvJmEftFTJ7C/gE13Qb5FFbahJAiA7xEjJFAvmcoK204UqNUgf8v2g0VlR6cS/
         YDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWrJQEYcKKhFMoVt2riH7Zdf9xTmqJSy6rGY0R3KxqVdQR0lvgVBeUUIkbG7d4lQ7nRqGHHePC3TZ+oKVqQnQl8jzN6
X-Gm-Message-State: AOJu0YzhhBCE+CluPEds0nzbRheIHIfQdoNrp9FM/Wq1ELLhgCxuqn++
	jZzoocCjKopzDb7vREZR4mMwf8N7z0PvNY3jEuv0GA2Kr2mTawayEVhn+1aO/nJ46QuBsFWF0As
	7BRC0OjOvY25V/iU+q95FV4hgb+0=
X-Google-Smtp-Source: AGHT+IES3z+W/7xz1Gonubs81dy8UUI7eOtQZrDCt+Sc2YOCRyv0vpbxwR2o5NPTBONm5QgiNBUuCdkFwY78IeX3Cas=
X-Received: by 2002:a17:90a:f495:b0:2c8:7ef4:f502 with SMTP id
 98e67ed59e1d1-2c8a23a36a6mr11031947a91.19.1719445933882; Wed, 26 Jun 2024
 16:52:13 -0700 (PDT)
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
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com> <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>
 <5d835551-9124-4fcc-bdb7-74828c55273d@huaweicloud.com>
In-Reply-To: <5d835551-9124-4fcc-bdb7-74828c55273d@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 16:52:01 -0700
Message-ID: <CAEf4BzYrZOGtwCoi_MK2gbkGUJN4uaLqtEt3N4=4sbTa=xiCJg@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Andrii,
>
> On 6/25/2024 11:55 AM, Andrii Nakryiko wrote:
> > On Mon, Jun 24, 2024 at 7:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> Sorry to resurrect the old thread to continue the discussion of APIs f=
or
> >> qp-trie.
> >>
> >> On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> >>> On Tue, Aug 22, 2023 at 6:12=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>>> Hi,
> >>>>
> >> SNIP
> >>
> >>>> updated to allow using dynptr as map key for qp-trie.
> >>>>> And that's the problem I just mentioned.
> >>>>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> >>>>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> >>>> Sorry for misunderstanding your reply. But before switch to the kfun=
cl
> >>>> way, could you please point me to some code or function which shows =
the
> >>>> specialty of PTR_MAP_KEY ?
> >>>>
> >>>>
> >>> Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> >>> logic assumes that there is associated struct bpf_map * pointer from
> >>> which we know fixed-sized key length.
> >>>
> >>> But getting back to the topic at hand. I vaguely remember discussion
> >>> we had, but it would be good if you could summarize it again here to
> >>> avoid talking past each other. What is the bpf_map_ops changes you
> >>> were thinking to do? How bpf_attr will look like? How BPF-side API fo=
r
> >>> lookup/delete/update will look like? And then let's go from there?
> >>> Thanks!
> >>>
> >>> .
> >> The APIs for qp-trie are composed of the followings 5 parts:
> >>
> >> (1) map definition for qp-trie
> >>
> >> The key is bpf_dynptr and map_extra specifies the max length of key.
> >>
> >> struct {
> >>     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> >>     __type(key, struct bpf_dynptr);
> > I'm not sure we need `struct bpf_dynptr` as the key type. We can just
> > say that key_size has to be zero, and actual keys are variable-sized.
> >
> > Alternatively, we can treat key_size as "maximum key size", any
> > attempt to use longer keys will be rejected.
> >
> > But in either case "struct bpf_dynptr" as key type seems wrong to me.
>
> The use of bpf_dynptr services two purposes:
> (1) tell bpf subsystem that qp-trie is a map with variable-size key.
> If don't use bpf_dynptr, the purpose can be accomplished by checking the
> map_type.
>
> (2) facilitate the dump of key in bpftool when btf is available
> when dump the key & value tuple through btf dump, a btf_type is needed
> for the key. Because the key is variable-size, so neither using void
> type (key_size =3D0 case)  nor using the type with the maximal key size
> are appropriate. But the use of bpf_dynptr can also be avoided, if we
> add a special case for qp-trie when dumping its key.
>

both of those purposes are served just as well with something like
map_flags =3D BPF_F_VARLEN_KEY (naming made up for illustration purposes
only)

> Setting key_size as zero seems weird, because qp-trie has key. I prefer
> to set key_size as the maximal key size and set the btf_key_id as 0.

ok, I don't think either way is better/worse than the other

> >>     __type(value, unsigned int);
> >>     __uint(map_flags, BPF_F_NO_PREALLOC);
> >>     __uint(map_extra, 1024);
> >> } qp_trie SEC(".maps");
> >>
> >> (2) bpf_attr
> >>
> >> Add key_sz & next_key_sz into anonymous struct to support map with
> >> variable-size key. We could add value_sz if the map with variable-size
> >> value is supported in the future.
> >>
> >>         struct { /* anonymous struct used by BPF_MAP_*_ELEM commands *=
/
> >>                 __u32           map_fd;
> >>                 __aligned_u64   key;
> >>                 union {
> >>                         __aligned_u64 value;
> >>                         __aligned_u64 next_key;
> >>                 };
> >>                 __u64           flags;
> >>                 __u32           key_sz;
> >>                 __u32           next_key_sz;
> >>         };
> >>
> > Yep, this seems inevitable. And yes, value_sz seems like a reasonable
> > thing to have. It might be an option/flag whether QP-trie has
> > fixed-sized or variable-sized value, I guess. But we can get there
> > after all the other things are figured out.
>
> Do we need to add value_sz with the qp-trie patch-set or later ? I
> prefer to leave it as the future work.
> >

future work is probably fine, but we need to design with this
possibility in mind, that's all

> >> (3) libbpf API
> >>
> >> Add bpf_map__get_next_sized_key() to high level APIs.
> > All the *_sized_* names are... unfortunate, tbh. I'm not sure what's
> > the right naming, but "sized" in the middle doesn't seem that. I think
> > it should be a uniform suffix. Maybe something like "_varsz",
> > "_varlen", or at least "_sized" (but as a suffix)?...
>
> I see. I have considered bpf_map_update_vs_key_elem() or similar, but I
> changed it to _sized later. Because bpf_map_update_sized_elem() not only
> supports variable-sized key, but also supports fixed-size key,  so I
> think it is a bit weird that the high level API bpf_map__update_elem()
> invokes bpf_map__update_elem_varlen() in turn to update element for map
> with fixed-size key. I will try to add _sized as a suffix in the formal
> patch set.
> >
> >> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
> >>                                            const void *cur_key,
> >>                                            size_t cur_key_sz,
> >>                                            void *next_key, size_t
> >> *next_key_sz);
>
> SNIP
> >>
> >>
> >>
> >> (4) bpf_map_ops
> >>
> >> Update the arguments for map_get_next_key()/map_lookup_elem_sys_only()=
.
> >> Add map_update_elem_sys_only()/map_delete_elem_sys_only() into bpf_map=
_ops.
> >>
> >> Updating map_update_elem()/map_delete_elem() is also fine, but it may
> >> introduce too much churn and need to pass map->key_size to these APIs
> >> for existing callers.
> >>
> > We can have a protocol that key_size and value_size might be zero for
> > fixed-sized maps, in which case key/value size is not
> > checked/enforced, right?
>
> Yes. We could pass 0 as key_size for the existing callers of
> ->map_update_elem()/->map_delete_elem()
> >
> > I think it's much better to keep one universal interface that works
> > for both fixed- and variable-sized map (especially that we can
> > technically have maps where fixed-sized or variable-sized is a matter
> > of choice and some map_flag value).
>
> I see your point. Will update
> map_update_elem()/map_delete_elem()/map_lookup_elem() instead.
> >
> >> struct bpf_map_ops {
> >>         int (*map_get_next_key)(struct bpf_map *map, void *key, u32
> >> key_size, void *next_key, u32 *next_key_size);
> >>         void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void
> >> *key, u32 key_size);
> >>
> >>         int (*map_update_elem_sys_only)(struct bpf_map *map, void *key=
,
> >> u32 key_size, void *value, u64 flags);
> >>         int (*map_delete_elem_sys_only)(struct bpf_map *map, void *key=
,
> >> u32 key_size);
> >> };
> >>
> >> (5) API for bpf program
> >>
> >> Instead of supporting bpf_dynptr as ARG_PTR_TO_MAP_KEY, will add three
> >> new kfuncs to support lookup/update/deletion operation on qp-trie.
> >>
> > hopefully those won't be qp-trie specific? Also, are you planning to
> > have only key variable-sized or value as well?
>
> Will make these kfuncs be available for all maps with variable-size key
> support. I think it is better to have both variable-sized key and value
> in these kfuncs. WDYT ?

yep

> >
>
>

