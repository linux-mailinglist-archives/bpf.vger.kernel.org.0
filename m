Return-Path: <bpf+bounces-33219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E116919DDD
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 05:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80451F24924
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E815E89;
	Thu, 27 Jun 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwVcjB7X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1E134A9
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459262; cv=none; b=Q6D1baSy/HqUgDSJA7h0kzvI2EdAEDf0H1h2wep/c4ZqwUqJHVCHcfJWV1x0JJa+H76lbhIMQlfQlTYrkk3YfAjiFEzK5DKwFdMqk7Hq0/PCDAlSyf1BXzALpow4bjgoRLv7SS32azjAoNqMBvPdwjCXuEBJVX7ZEjoMVjLoLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459262; c=relaxed/simple;
	bh=soXk0nH+HtehfiSC5p5dZth/tYZezvaRSl1LEefdnTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAVMgwCAUu9kfLAHYJAX2x1Fa1hEBleNH5N2RUa7BijRa4/Ycuu1WuKrL6iyYSEi+pSdlACtSGYis3tk5nUhOKfzSCn+WYm25AtbuQCd5oYGyb7cEZI/HR/ZBsbfG/WDdVmjhWv4Gxx7kSzH1RF9F9KuhynufUFUaXxQytVx9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwVcjB7X; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so5736063f8f.2
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719459259; x=1720064059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/knLw5b7Z2e5r7tNjLroyk+LHXyv47Uf7CemYH1WOPs=;
        b=VwVcjB7XO2YVKdujf1he9FyFdLdXiyJXpkvne8jzRcWdMcE+58JTD1yDUtcIgvaD3J
         ghOF/UCFroL+RGKXPNVAXx/ugigyIkTWZBurnHwXwMmWEc7gvsD1SdA5VARzUprAqRMn
         2B8dJJf37NomPC/EXnQJbwAoJDUM9tzoqjyb8jlxy97Ad+Saxx4AIeJ04mIH0/kJCLgP
         o07LIR1/KnVFAFvw+Wr+9klnK3NTn/3RVSrmXJ+v+jJ1Njp/fSI1VfaPF/tLr+/egHuR
         d1o/JzpLCSWFh/pKTVlrDzwio9n6ar5WMwZOeBN+z2tJm3vWJZgzZrI8gRC/cILg63fJ
         A4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719459259; x=1720064059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/knLw5b7Z2e5r7tNjLroyk+LHXyv47Uf7CemYH1WOPs=;
        b=Y+1v5uHQ8/xV7OOpKTrzee8EX45qyHHFt7S6RG1v1QUpfJxpO8TIOR/BMiMmPAEHT/
         NNUdixP44nEDIZEsa6beGMV0skCPihdM9amXVXfPS+8gMOVs8gmVhLjCpbiweh7Lvoqt
         qP66imodTX9StBcOiNdrTdQ2aiZBOLFXC0QEvXYGfiCtBXoIy+cJbblT6ao7meCMgw2O
         NJ4W3JTa82+bqxE0ZBBoGDAwfqJMKnKR1qwUo8Ok+YmQ6xN6Ke2qS5ifjPlyzo5dYa03
         Hs4r7/rA7k2A0x4w+mdR2VnbaxyLoBGRor+TlNu3GnNcFZPf1PJ9rK6+sr1M9rdI3vBT
         3WfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp7NaPmP1Lh1iYk5TjDhg0YpToHHoE/JN2GB3FRjPSM5WWSxKTseW0rMxEXAxRqkAmOHJ1WeQ3JIq93VYIiRLjyoBB
X-Gm-Message-State: AOJu0YyVuwDK84D2JyB3hb1WwJVecYczNJrFK/czPC/WhbCraHg813Xk
	BUtc4/CaGyI9ABktCP8Wn7LUqzacvi3SrbfAdf53ksKPfeXk26UFXy1MbOoTyJ9jS5vLHvVkgOY
	YIfJfAM8FqyWSgek7mOi9yRL5dP40X1NH
X-Google-Smtp-Source: AGHT+IEOYQGFqxx966Z1ayHGIJnf8UZA3TtSFS3RwVSGBkZEQnv/983KlKSrflU0hTrra4fqrct1A2PJZfd3hZhgPEY=
X-Received: by 2002:a05:6000:136c:b0:362:fa6c:5a2f with SMTP id
 ffacd0b85a97d-366e94cbd9fmr6863699f8f.35.1719459259092; Wed, 26 Jun 2024
 20:34:19 -0700 (PDT)
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
 <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com>
In-Reply-To: <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 20:34:07 -0700
Message-ID: <CAADnVQJ0gLSNNCnKeWMrHeoGG8DRG8kBoWxo3y0ubat-PgBcMg@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/26/2024 10:06 AM, Alexei Starovoitov wrote:
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
> >> (3) libbpf API
> >>
> >> Add bpf_map__get_next_sized_key() to high level APIs.
> >>
> >> LIBBPF_API int bpf_map__get_next_sized_key(const struct bpf_map *map,
> >>                                            const void *cur_key,
> >>                                            size_t cur_key_sz,
> >>                                            void *next_key, size_t
> >> *next_key_sz);
> >>
> >> Add
> >> bpf_map_update_sized_elem()/bpf_map_lookup_sized_elem()/bpf_map_delete=
_sized_elem()/bpf_map_get_next_sized_key()
> >> to low level APIs.
> >> These APIs have already considered the case in which map has
> >> variable-size value, so there will be no need to add other new APIs to
> >> support such case.
> >>
> >> LIBBPF_API int bpf_map_update_sized_elem(int fd, const void *key, size=
_t
> >> key_sz,
> >>                                          const void *value, size_t val=
ue_sz,
> >>                                          __u64 flags);
> >> LIBBPF_API int bpf_map_lookup_sized_elem(int fd, const void *key, size=
_t
> >> key_sz,
> >>                                          void *value, size_t *value_sz=
,
> >>                                          __u64 flags);
> >> LIBBPF_API int bpf_map_delete_sized_elem(int fd, const void *key, size=
_t
> >> key_sz,
> >>                                          __u64 flags);
> >> LIBBPF_API int bpf_map_get_next_sized_key(int fd,
> >>                                           const void *key, size_t key_=
sz,
> >>                                           void *next_key, size_t
> >> *next_key_sz);
> > I don't like this approach.
> > It looks messy to me and solving one specific case where
> > key/value is a blob of bytes.
> > In other words it's taking api to pre-BTF days when everything
> > was an opaque blob.
>
> I see.
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
> >
> > and BTF for such map should see distinguish it as two strings
> > and not as a single blob of bytes.
> > The observability of bpf maps with bpftool should be able to print it.
> >
> > The use of such api will look the same from bpf prog and from user spac=
e.
> > bpf prog can do:
> >
> >  struct map_key key;
> >  bpf_dynptr_from_whatever(&key.file_name, ...);
> >  bpf_dynptr_from_whatever(&key.dir, ...);
> >  bpf_map_lookup_elem(map, &key);
> >
> > and similar from user space.
> > bpf_dynptr_user will be a struct with size and a pointer.
> > The existing sys_bpf commands will stay as-is.
> > The user space will do:
> >
> > struct map_key {
> >    bpf_dynptr_user file_name;
> >    bpf_dynptr_user dir;
> > } key;
> >
> > key.dir.size =3D 1000;
> > key.dir.ptr =3D malloc(1000);
> > ...
> > bpf_map_lookup_elem( &key); // existing syscall cmd
> >
> > In this case sizeof(struct map_key) =3D=3D sizeof(bpf_dynptr_user) * 2 =
=3D=3D 32
> >
> > Both for bpf prog and for user space.
>
> It seems the idea could be implemented through both hash-table and qp-tri=
e.

yes. I think so.

> For hash-table, firstly we need to keep each offset of these dynptr_like
> objects. During update operation, we need to calculate the hash for each
> dynptr_like object and combine these hashes into a new hash. During
> lookup, we need to compare each dynptr_like object alone to check
> whether or not it is the same as the target element.

yep.
We already have btf_field/btf_record infra that describe map value.
They can be used to describe map key just as well.
The tricky part would be to make the whole hash of dynptr-s and compare
quick enough without hurting common use case of traditional hash map.

> For qp-trie, we also need to keep the offset for each dynptr_like
> object. During update operation, we should marshal the passed key into a
> plain blob and save the plain blob in qp-trie. During lookup, we don't
> marshal the input key, instead we lookup up the qp-trie by using each
> field in the map key step-wise.

yes. exactly.

> However for get_next_key operation, we
> need to unmarshal the plain blob into a dynptr_like object.

hmm. I haven't thought about get_next_key for qp-trie.
A bit tricky indeed.

> For the two hypothetical implementations above, I think the lookup
> performance may be better than qp-trie and its memory usage will not be
> bad, so I prefer to support dynptr_like object in hash map key first. WDY=
T ?

I'd actually do it with qp-trie first.
bpftrace is using strings as keys a lot and some scripts use "multi key" to=
o
(like string plus int)
Currently bpftrace sizes up hash key_size to max and it's not efficient.
I think qp-trie with multi-key support would work very well for that use ca=
se.

iirc early version of qp-trie was limited to nul-terminated strings
as a key, but I believe it's possible to tweak the algorithm to support
binary key. Then what you describing above how lookup/update of a key
will work nicely.
I also suspect that lookup will be much faster in qp-trie compared
to hash table, hence that's what I would implement first.

