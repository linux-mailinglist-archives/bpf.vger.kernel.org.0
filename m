Return-Path: <bpf+bounces-36435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661049486A0
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 02:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E651C21388
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49317C9;
	Tue,  6 Aug 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdSjuchE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9F625
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904320; cv=none; b=PgObV03geYGktxVL5qPLES0FWV6ZZhZhgT8Lysp4kDLDtZnQjGZ1jZv4iqu8el47VcXUj+qsNH7Qp8J2c1Y1ZKj7+g2pLECZYx+1wbRU8q1U/53XU08j8ZBOz260sL8NkterqHVdWYdDT2XUatohMQVOnCXt9jgRtG/XnevM4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904320; c=relaxed/simple;
	bh=q/Y8uFeQmxfT9haDitiEPmKZeap1Gx/nb3mL0N8jbQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnSD+o2srzkRTdX7R+/8oom5YU1v2JD81lws1khYrwimuzTO1i0KiYb1lR73K1D1QIEnW4sHlGxwU3z7adr0k5KtqcTkwKjHuPh6fq33Obdc1KPCizxLtMiiuQ438FO8KIKxYRpHabFX0wIrdP/2h6FRyFj5lUSPFdQLRjVd+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdSjuchE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso16965276.1
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 17:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904318; x=1723509118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcmkcDKUozXIUsH+mwxoGWYp/8mlTl/URbWNK8T3YK0=;
        b=RdSjuchE7r1ycsWXnIUjetxTgXqZezb6ToHF+U0/7G7T6fCH+76tV2/k+0JiARQMuE
         3OHIbc7SOf4KRwTW+nkW970qV6WjFJ6ewEwsDpNmY4hQNeunGyF2M/qb0IjrBfX7b8Wn
         DhuAeY6udEDgrOiyP2cxZAM2auNasRvk04V4nP1k/+qFqBSYLEmhB5k6j+rDw+MlcCp3
         QYpiZhl+RSSenk2KMr6J/VkLTcazEVlYsFyOkUrlvBuZz8I3YZ5QXalR1YR65LG/uwn0
         YGcsrd8Q9p3za7dj6neh0dj/5gMQJ3arKMe1bUfHHU1dRqRAj1SQHFw7w0/T1M6cyPZH
         dFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904318; x=1723509118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcmkcDKUozXIUsH+mwxoGWYp/8mlTl/URbWNK8T3YK0=;
        b=RtBFEACOR9Dh8xiO9zvRFN/897ngqdZ+6MaIPrGkGZdNyT8rDs3CCb2AasqHbricjG
         4pwDiSl35RU0rU9ZH9MTG2UrngV2VssMCGGvPyeQTA9cdZHyMBFIOHuT7E/hOrdEr9lg
         dunTK4xee6/Vj/LsTPJh0uSliqPNZxzXf0ggcu9Wkzs/KgY+jT6nrnv19+/KDud4vvre
         U/ThzXl4/7H7iB0qhbMAvh5komwGAcwhEM0EkQBSrrg2v6iW1uefbi66n5bIzMTQNFOR
         TYxf1A1Tozwp2CtYSQQaVL4c/ZaU3uhEwCR3IgLfTfP2p5UZ2s14e25MMDmDY7/KrnED
         I5kg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Aoi4y1eMHgtSKOmTBdNV5bAV55O2qlEcT0sx3dfRTA+O8Mz+S6HpwosALkTskp+SsR9VQ3lqIMf4SctWemepVrrn
X-Gm-Message-State: AOJu0Yz0MJvCpyOOZoIMqPa1ZipIDL7WL46mHs0Rh888HIkN3XIm7Mz1
	Toc9l/mxe30spPvYsM2pPBzzay8JT+FI2iHaZFT+g7pEPoNUagadveTczTTq3Ybkpq1wqlgGyWt
	wAp10nhBs53qIDx+gxeJA7haKm+I=
X-Google-Smtp-Source: AGHT+IGQpM08ZHBa822z+1c5Q5XPXPoNIjtMvIuigNGjdjPf6njZkHBLnnFCFz99dgxvaejW6aIYQiiFq95yYH5NxNo=
X-Received: by 2002:a05:6902:154e:b0:e03:5fee:66a with SMTP id
 3f1490d57ef6-e0bde4088d5mr16725242276.42.1722904318229; Mon, 05 Aug 2024
 17:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com> <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
 <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com> <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
 <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com> <fc6ba752-78c0-4514-900d-7bef6c1f447e@linux.dev>
In-Reply-To: <fc6ba752-78c0-4514-900d-7bef6c1f447e@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Aug 2024 17:31:47 -0700
Message-ID: <CAMB2axOt=TGrp53ZN8ocaO=d4E86Wb6gEzFewbT27iC_iK3+Zw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, davemarchevsky@fb.com, 
	Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:25=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/5/24 1:44 PM, Amery Hung wrote:
> >>>>> Maybe we should move the common btf used by kptr and graph_root int=
o
> >>>>> btf_record and let the callers of btf_parse_fields() and
> >>>>> btf_record_free() to decide the life cycle of btf in btf_record.
> >>>> Could you maybe explain if and why moving btf of btf_field_kptr and
> >>>> btf_field_graph_root to btf_record is necessary? I think letting
> >>>> callers of btf_parse_fields() and btf_record_free() decide whether o=
r
> >>>> not to change refcount should be enough. Besides, I personally would
> >>>> like to keep individual btf in btf_field_kptr and
> >>>> btf_field_graph_root, so that later we can have special fields
> >>>> referencing different btf.
> >>>
> >>> Sorry, I didn't express the rough idea clearly enough. I didn't mean =
to
> >>> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
> >>> because there are other btf-s which are different with the btf which
> >>> creates the struct_meta_tab. What I was trying to suggest is to save =
one
> >>> btf in btf_record and hope it will simplify the pin and the unpin of =
btf
> >>> in btf_record:
> >>>
> >>> 1) save the btf which owns the btf_record in btf_record.
> >>> 2) during btf_parse_kptr() or similar, if the used btf is the same as
> >>> the btf in btf_record, there is no need to pin the btf
> >>
> >> I assume the used btf is the one that btf_parse is working on.
> >>
> >>> 3) when freeing the btf_record, if the btf saved in btf_field is the
> >>> same as the btf in btf_record, there is no need to put it
> >>
> >> For btf_field_kptr.btf, is it the same as testing the btf_field_kptr.b=
tf is
> >> btf_is_kernel() or not? How about only does btf_get/put for btf_is_ker=
nel()?
> >>
> >
> > IIUC. It will not be the same. For a map referencing prog btf, I
> > suppose we should still do btf_get().
> >
> > I think the core idea is since a btf_record and the prog btf
> > containing it has the same life time, we don't need to
> > btf_get()/btf_put() in btf_parse_kptr()/btf_record_free() when a
> > btf_field_kptr.btf is referencing itself.
> >
> > However, since btf_parse_kptr() called from btf_parse() and
> > map_check_btf() all use prog btf, we need a way to differentiate the
> > two. Hence Hou suggested saving the owner's btf in btf_record, and
>
> map_check_btf() calls btf_parse_kptr(map->btf).
>
> I am missing how it is different from the
> btf_new_fd()=3D>btf_parse()=3D>btf_parse_kptr(new_btf).
>
> akaik, the map->record has no issue now because bpf_map_free_deferred() d=
oes
> btf_record_free(map->record) before btf_put(map->btf). In the map->record=
 case,
> does the map->record need to take a refcnt of the btf_field_kptr.btf if t=
he
> btf_field_kptr.btf is pointing back to itself (map->btf) which is not a k=
ernel btf?
>
> > then check if btf_record->btf is the same as the btf_field_kptr.btf in
> > btf_parse_kptr()/btf_record_free().
>
> I suspect it will have the same end result? The btf_field_kptr.btf is onl=
y the
> same as the owner's btf when btf_parse_kptr() cannot found the kptr type =
from a
> kernel's btf (the id =3D=3D -ENOENT case in btf_parse_kptr).

I added some code to better explain how I think it could work.

I am thinking about adding a struct btf* under struct btf_record, and
then adding an argument in btf_parse_fields:

btf_parse_fields(const struct btf *btf,..., bool btf_is_owner)
{
        ...
        /* Before the for loop that goes through info_arr */
        rec->btf =3D btf_is_owner ? btf : NULL;
        ...
}

The btf_is_owner indicates whether the btf_record returned by the
function will be part of the btf. So map_check_btf() will set it to
false while btf_parse() will set it to true. Maybe "owner" is what
makes it confusing? (btf_record for a map belongs to bpf_map but not
map->btf. On the other hand, btf_record for a prog btf is part of it.)

Then, in btf_record_free(), we can do:

case BPF_KPTR_XXX:
        ...
        if (rec->btf !=3D rec->fields[i].kptr.btf)
                btf_put(rec->fields[i].kptr.btf);

In btf_parse_kptr(), we also do similar things. We just need to pass
btf_record into it.

