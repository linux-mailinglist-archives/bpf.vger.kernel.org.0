Return-Path: <bpf+bounces-36444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8D948832
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 06:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27D1B21DFB
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 04:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3141BA880;
	Tue,  6 Aug 2024 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdCImkBI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2050A59
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 04:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917248; cv=none; b=g7SGXQgEzgDR+qe5DK0cDm327zVMg/hIiG8XbG1Ys1wg3DHmZ/AUa0m0FesuKmaKRJONNyvsxPDuR0nXJ82Ez8v+0Avg/JBb+z3usiaNb8PgWb038JFDFiW99capIC4SNp69vaycxAWvfD0US4V8l1aaCWoOHalEXPTjREXaWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917248; c=relaxed/simple;
	bh=bo00UchvNvFPitOXvc7/DjvHGzpTvcBEDZt9cwmUZzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1Zp/u4wrHDx85FNdNu3BHuTFgtEGOkpCF8qJK6e2rxdo675PXRPNGcX/R0CTGwbqWYdh0TiWeS726MJ8A9cr83xlwjqjiBuhgQwdBsrlUtqD1e3nUCLvk0gUkwvVCw819SgbvPHb6CS9Snu6QskGgRrLMcb4xcvGss1rI8wQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdCImkBI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b8a400854so111893276.2
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722917246; x=1723522046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAt+S2QpzrUb17fYVRWhiImfnbUwOZxOXfDSGwrKuBU=;
        b=XdCImkBIsJ3aCbijFyTsjfuwU7DiM3c1RZ2AVKRxJRs65TESnI+idfmAtpZ8KERPhC
         7tgAR2lC2YDy7wSLvqOJrVYwA534t9pZAw5+TXBTka5RXS9d322kmARjneigHGriDYS6
         lQLcs9TYhf5IiinNnGYixuZ/+Yee1eF8XCVTkEqFlABN7W8Pvwo2KMYoX/74g2prHsHv
         xKzpymFDeTcBzXuluVu73OA8N014KoUMSIGduB7Ws04KAXbZ5iRUl0anuf7Ho2GRsl7q
         7QOWjCkhkwQnU9bmMGhKJ+FoXJMROcoTq7bQmYgcXSu7uwLDVtqMasP22GWsMxMNL/x0
         SfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722917246; x=1723522046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAt+S2QpzrUb17fYVRWhiImfnbUwOZxOXfDSGwrKuBU=;
        b=tZsMiEG/RhhaYswLzLhzz9y4yp70SeWGWMdzCUt4ubxB70KCYyyMiBgV7t4zqpWGkI
         Z6ngX11Tav2/3DxvqxZ47iYrM/c2zo46sO0Tone/+h/XknAIdJZwzwEHy+45ARaFIyPv
         mCIIWdYcbYkeuXa106mtUeP/kXHhJET9e+MZ1Vh5hvUixjYHRXlFpmfnc9moOHFUK8vR
         YdUgQmrjjrC02EmEPrtA8xEqbXFOSbQlRidiBWv9EXG+MMqZcJuOuiH28H2QM67BagJi
         P7B+i+lSrug9GVaufhWS5sjYd/igxi0HUSX0t4NZ9U+7qTMu9X+wL9N46DAEiARwpqq7
         HP2g==
X-Forwarded-Encrypted: i=1; AJvYcCXjNaeT7QI9CoyEqYILNeDMvjAOXOoRTf3ttXvfjtHjgA6Mc96FZtLXznWAgNZ6ltiy+q1QWF7m2ub84PweC0UB4yFZ
X-Gm-Message-State: AOJu0Yynt5Vy3uTgVgBaQJlm/wTeBYEwyxJtd14X34qXWTuPMWLkpJdP
	vfzD/RQRDnKAoKn0aeUmcylckcUnoGLG0qUByFt3jod0jzx2rH3z2a90lfuD3uoQNBINQJKlT4g
	gG9zk6K76ycy8hz/li89IAInx9VI=
X-Google-Smtp-Source: AGHT+IFnwX11bxh//WS9PGcX3xHQx6QSJNvTlWrtH+jWlqjeogSWZsb775EKjd4GyDwJYseXDGA3m3FOi5JoDkcK5k8=
X-Received: by 2002:a05:6902:1006:b0:e02:4d55:1e6f with SMTP id
 3f1490d57ef6-e0bde260ed6mr17779308276.21.1722917245721; Mon, 05 Aug 2024
 21:07:25 -0700 (PDT)
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
 <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com>
 <fc6ba752-78c0-4514-900d-7bef6c1f447e@linux.dev> <CAMB2axOt=TGrp53ZN8ocaO=d4E86Wb6gEzFewbT27iC_iK3+Zw@mail.gmail.com>
 <7ade8465-4c9e-3d8b-7373-3207c453d41e@huaweicloud.com>
In-Reply-To: <7ade8465-4c9e-3d8b-7373-3207c453d41e@huaweicloud.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Aug 2024 21:07:14 -0700
Message-ID: <CAMB2axOtr73KVjwJiPsHMXjs5+t-J=Y2HBuUdvQnZZAAUVM9iQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Hou Tao <houtao@huaweicloud.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, davemarchevsky@fb.com, 
	Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:57=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 8/6/2024 8:31 AM, Amery Hung wrote:
> > On Mon, Aug 5, 2024 at 3:25=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >> On 8/5/24 1:44 PM, Amery Hung wrote:
> >>>>>>> Maybe we should move the common btf used by kptr and graph_root i=
nto
> >>>>>>> btf_record and let the callers of btf_parse_fields() and
> >>>>>>> btf_record_free() to decide the life cycle of btf in btf_record.
> >>>>>> Could you maybe explain if and why moving btf of btf_field_kptr an=
d
> >>>>>> btf_field_graph_root to btf_record is necessary? I think letting
> >>>>>> callers of btf_parse_fields() and btf_record_free() decide whether=
 or
> >>>>>> not to change refcount should be enough. Besides, I personally wou=
ld
> >>>>>> like to keep individual btf in btf_field_kptr and
> >>>>>> btf_field_graph_root, so that later we can have special fields
> >>>>>> referencing different btf.
> >>>>> Sorry, I didn't express the rough idea clearly enough. I didn't mea=
n to
> >>>>> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
> >>>>> because there are other btf-s which are different with the btf whic=
h
> >>>>> creates the struct_meta_tab. What I was trying to suggest is to sav=
e one
> >>>>> btf in btf_record and hope it will simplify the pin and the unpin o=
f btf
> >>>>> in btf_record:
> >>>>>
> >>>>> 1) save the btf which owns the btf_record in btf_record.
> >>>>> 2) during btf_parse_kptr() or similar, if the used btf is the same =
as
> >>>>> the btf in btf_record, there is no need to pin the btf
> >>>> I assume the used btf is the one that btf_parse is working on.
> >>>>
> >>>>> 3) when freeing the btf_record, if the btf saved in btf_field is th=
e
> >>>>> same as the btf in btf_record, there is no need to put it
> >>>> For btf_field_kptr.btf, is it the same as testing the btf_field_kptr=
.btf is
> >>>> btf_is_kernel() or not? How about only does btf_get/put for btf_is_k=
ernel()?
> >>>>
> >>> IIUC. It will not be the same. For a map referencing prog btf, I
> >>> suppose we should still do btf_get().
> >>>
> >>> I think the core idea is since a btf_record and the prog btf
> >>> containing it has the same life time, we don't need to
> >>> btf_get()/btf_put() in btf_parse_kptr()/btf_record_free() when a
> >>> btf_field_kptr.btf is referencing itself.
> >>>
> >>> However, since btf_parse_kptr() called from btf_parse() and
> >>> map_check_btf() all use prog btf, we need a way to differentiate the
> >>> two. Hence Hou suggested saving the owner's btf in btf_record, and
> >> map_check_btf() calls btf_parse_kptr(map->btf).
> >>
> >> I am missing how it is different from the
> >> btf_new_fd()=3D>btf_parse()=3D>btf_parse_kptr(new_btf).
> >>
> >> akaik, the map->record has no issue now because bpf_map_free_deferred(=
) does
> >> btf_record_free(map->record) before btf_put(map->btf). In the map->rec=
ord case,
> >> does the map->record need to take a refcnt of the btf_field_kptr.btf i=
f the
> >> btf_field_kptr.btf is pointing back to itself (map->btf) which is not =
a kernel btf?
>
> I think you are right. For both callees of btf_parse_kptr() when the btf
> saved in btf_field_kptr.btf is the same as the passed btf, there is no
> need to call btf_get(). For bpf map case, just as you remained, map->btf
> has already pin the btf passed to btf_parse_kptr() in map_create().
> >>> then check if btf_record->btf is the same as the btf_field_kptr.btf i=
n
> >>> btf_parse_kptr()/btf_record_free().
> >> I suspect it will have the same end result? The btf_field_kptr.btf is =
only the
> >> same as the owner's btf when btf_parse_kptr() cannot found the kptr ty=
pe from a
> >> kernel's btf (the id =3D=3D -ENOENT case in btf_parse_kptr).
>
> It seems your suggestion of using btf_is_kernel() is much simpler:
>
> (1) btf_parse_kptr():  doesn't invoke btf_get() when bpf_find_btf_id()
> returns -ENOENT and let the caller ensure the life cycle of the passed bt=
f.
> (2) btf_record_free(): only invoke btf_put() if the saved btf is a
> kernel btf.
> (3) btf_record_dup(): only invoke btf_get() if the saved btf is a kernel
> btf.

I see. It is much simpler. I will send a new version using this approach.

Thank you,
Amery

> > I added some code to better explain how I think it could work.
> >
> > I am thinking about adding a struct btf* under struct btf_record, and
> > then adding an argument in btf_parse_fields:
> >
> > btf_parse_fields(const struct btf *btf,..., bool btf_is_owner)
> > {
> >         ...
> >         /* Before the for loop that goes through info_arr */
> >         rec->btf =3D btf_is_owner ? btf : NULL;
> >         ...
> > }
> >
> > The btf_is_owner indicates whether the btf_record returned by the
> > function will be part of the btf. So map_check_btf() will set it to
> > false while btf_parse() will set it to true. Maybe "owner" is what
> > makes it confusing? (btf_record for a map belongs to bpf_map but not
> > map->btf. On the other hand, btf_record for a prog btf is part of it.)
> >
> > Then, in btf_record_free(), we can do:
> >
> > case BPF_KPTR_XXX:
> >         ...
> >         if (rec->btf !=3D rec->fields[i].kptr.btf)
> >                 btf_put(rec->fields[i].kptr.btf);
> >
> > In btf_parse_kptr(), we also do similar things. We just need to pass
> > btf_record into it.
>

