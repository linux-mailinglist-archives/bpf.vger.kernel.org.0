Return-Path: <bpf+bounces-77239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81DCD2AA2
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2264C3007CAF
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93992F7ACA;
	Sat, 20 Dec 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3YP6JFh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612012F7445
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219959; cv=none; b=TZ1CP0xf1uHJmQNQoprQCzvKZPwkJg0AmjhxermUCHXvfXT1Y+JYnXI30ZzDx9vyW25S8YwJ4cWUsrcu91HSH5Dx2UA0ihzpj4HUrxFJ5R3a/HYhOq8RdxxJ/E386p7AbWh+mRi4STVVT0Qn/FYlBCmJ2xwX8yhF6ibabcqoC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219959; c=relaxed/simple;
	bh=wVwml/7Lck5b1OVCvhAmad9P0uR7lWGIP+xFg4bl0H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpFyPIT+Jv+LD/GKfNqbKKcvFLbRJglbHf2gSp+egJF/wVoTuDe9cRttPPKiwnWp3NnV4wkOobQHXFQYor69bW79TDNeQWH6a+/lWLSzNXoeTKtBLAuBB54S+QNTH00GmU8MC/tPSSYcCR/CzUCDqy5GYIsDeVtulFckwfqMZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3YP6JFh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so308745066b.0
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 00:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766219956; x=1766824756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/MOeYBPqZNM02PyUwyI25lYnH+BSCAbVcJt93yssm0=;
        b=V3YP6JFh11LbaCCdtCbE4CYDvOjPpApuz086GLjbPsPB+zgJCb5DQEunqu45oaUSsH
         YG1pdW3R1nSKwAk7/WzdFQjHcFag6x6+91iWyBZMfIDOg00oxy5G84w7oaQ8VmbDA9li
         mQiAxzehlj1ASrykG9MsmK+48+KLSmfEy5vJ2klOehAk7t7/p1oBYKHiTHAlausEC1AV
         kaBYMu6UR+Vu6fXrlFeWatQPWJd/Gad0EwF6kPtXOeLgWpushZ0yuC2eA5wGuYYM5d1p
         bbwdvNu/NmH4r4LLHdal9Db2IFKmlfCzhJZRk9IT0NBzUFDRb9y5EJlpkVjFcBbwImcW
         ScxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766219956; x=1766824756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/MOeYBPqZNM02PyUwyI25lYnH+BSCAbVcJt93yssm0=;
        b=q+YRm9PrRcm/RWTmwBEBbCp1NAG00BNdwretYepnzerS5H3tKk3CkF2XvrJQ6SMJiu
         Hvr8HuOyT93U1Q8FVSNcQ4iEZGkA4mFSk2s+Z08wfXdH8G0ElIVi3RRPd5/SR48J9Ynt
         Nnvu0vlBf9m1Igktam4pa6QXj1WqibpJRm6wKWSdon/MUwxb7UUXDJCXiPI71Xy1nycC
         mHaz3uHZKem52ThP68ziO9QmKw6EZmR3PuiZgKb9Ju9PI/v+zYZcp+/foMzAe0LCzbcG
         XYnt0cPqUO4Rwwg4EC9E5LI9nbm+y3HVWrQRexieyeR8NlOGbTs9i2tFf+YmyRSvi6Sh
         utpw==
X-Forwarded-Encrypted: i=1; AJvYcCUjODfVyAeY/g5FTUi+6VRNTl9Chl42bcAfs6krLCKQncntC8kjINNBGnzTjg4yPdfjxSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtFKimaxRkrsoQV5EpyH46Y6lFx6kOIfsURhxGGmSlVc5J4tB
	nM2C4v0WAhsgB09b3ALN9ZW5l1gQKbd/dGC+cPkk5bq0SxgkGyzE83iLUPizOO+7FhG0C0SJY2t
	GLcFYlyKJRsLQyd28hjI6gUR+OJqBNHU=
X-Gm-Gg: AY/fxX60stRf+Vi3fX8tpOdV+9y1N7sqMrnMIKgrCbqMAX/bqPGSlx0oOdhOQ9QmDC6
	lXGBVvFvxy0lPNSszfhu3eyTzHi77b9cwDN5MwBPLd6C0lRE8ju+IxUqfzKGvkJhey7Tt8X1Q8E
	8klTkFHuMkQpcWEG5inqKdrvo5gd8xqM6kLG1nwrNEsoqzkP/h+geoTBJgGONqsiYX8I8t+74dC
	SPcuvnZjIjygQUETcrmnSKmB/UuovQeB+oDVT/hJ4VaTb6rK6SUxF+XlIu6GRb7U3C6tTv5
X-Google-Smtp-Source: AGHT+IGLmEq2dWHKWzNIz5v+6tWaCAmbpfJ3rWEnH6YmSreQOw47/imxMe7cZW2POIXuPH01gblVyVWlfXetfhkshxk=
X-Received: by 2002:a17:907:6e9f:b0:b7c:e4e9:b13f with SMTP id
 a640c23a62f3a-b803717d9b0mr573522966b.39.1766219955422; Sat, 20 Dec 2025
 00:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-2-dolinux.peng@gmail.com> <CAEf4BzYJpw+yEv=g9P1z0NS8Qw8PdFf7039MT0PSv30DwkjBzw@mail.gmail.com>
 <CAErzpmu4K3rF3JLycEYNqzNcBkSgBxijj1RAYBPuprvBU6LHmQ@mail.gmail.com> <CAEf4BzYN5NwSJO1QDXu6Mq_pZXQO9-5iyJm0vZeJSmyrQBNJ3A@mail.gmail.com>
In-Reply-To: <CAEf4BzYN5NwSJO1QDXu6Mq_pZXQO9-5iyJm0vZeJSmyrQBNJ3A@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 16:39:03 +0800
X-Gm-Features: AQt7F2pchl35KZQx5fWidARgXxfx-Qjn4Ru0inhzTlwjoO5j5rvmbYjW_jcL67Y
Message-ID: <CAErzpmuCQUTZTnCkNoL0ZcHsvXmu_m0sp7X+Lt8K4tYwQ7BiMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 01/13] libbpf: Add BTF permutation support
 for type reordering
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 1:07=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 7:15=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Fri, Dec 19, 2025 at 7:02=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > >
> > > > Introduce btf__permute() API to allow in-place rearrangement of BTF=
 types.
> > > > This function reorganizes BTF type order according to a provided ar=
ray of
> > > > type IDs, updating all type references to maintain consistency.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c      | 119 +++++++++++++++++++++++++++++++++++=
++++
> > > >  tools/lib/bpf/btf.h      |  36 ++++++++++++
> > > >  tools/lib/bpf/libbpf.map |   1 +
> > > >  3 files changed, 156 insertions(+)
> > > >
>
> [...]
>
> > > > +/**
> > > > + * @brief **btf__permute()** performs in-place BTF type rearrangem=
ent
> > > > + * @param btf BTF object to permute
> > > > + * @param id_map Array mapping original type IDs to new IDs
> > > > + * @param id_map_cnt Number of elements in @id_map
> > > > + * @param opts Optional parameters for BTF extension updates
> > > > + * @return 0 on success, negative error code on failure
> > > > + *
> > > > + * **btf__permute()** rearranges BTF types according to the specif=
ied ID mapping.
> > > > + * The @id_map array defines the new type ID for each original typ=
e ID.
> > > > + *
> > > > + * @id_map must include all types from ID `start_id` to `btf__type=
_cnt(btf) - 1`.
> > > > + * @id_map_cnt should be `btf__type_cnt(btf) - start_id`
> > > > + * The mapping is defined as: `id_map[original_id - start_id] =3D =
new_id`
> > >
> > > Would you mind paying attention to the feedback I left in [0]? Thank =
you.
> >
> > Apologies for the delayed response, I would like to hear if someone has=
 a
> > different idea.
>
> Delayed response?.. You ignored my feedback and never even replied to
> it. And then posted a new revision two days later, while still not
> taking the feedback into account. This is not a delayed response, it's
> ignoring the feedback. You don't have to agree with all the feedback,
> but you have to respond to the feedback you disagree with and provide
> your arguments, not just silently disregard it.

Thank you for the reminder, and I sincerely apologize for
my mistake in handling the feedback. You are absolutely right.
I should not have posted a new revision without first replying
to your comments on the previous version. The correct process,
as outlined in the kernel development documentation and community
norms, is to address all feedback=E2=80=94either by implementing the
suggested changes or by providing a clear explanation if I
disagree.

I appreciate you taking the time to review my work and for
holding me to the community standard. I will ensure this
does not happen again.

>
> >
> > >
> > > The contract should be id_map[original_id] =3D new_id for base BTF an=
d
> > > id_map[original_id - btf__type_cnt(base_btf)] =3D new_id for split BT=
F.
> > > Special BTF type #0 (VOID) is considered to be part of base BTF,
> > > having id_map[0] =3D 0 is easy to check and enforce. And then it leav=
es
> > > us with a simple and logical rule for id_map. For split BTF we make
> > > necessary type ID shifts to avoid tons of wasted memory. But for base
> > > BTF there is no need to shift anything. So mapping the original type
> > > #X to #Y is id_map[X] =3D Y. Literally, "map X to Y", as simple as th=
at.
> > >
> > >   [0] https://lore.kernel.org/bpf/CAEf4BzY_k721TBfRSUeq5mB-7fgJhVKCeX=
VKO-W2EjQ0aS9AgA@mail.gmail.com/
> >
> > Thanks. I implemented the approach in v6, but it had inconsistent inter=
nal
> > details for base and split BTF. It seems we prioritize external contrac=
t
> > consistency over internal inconsistencies, so I=E2=80=99ll revert to th=
e v6 approach
> > and refine it for clarity.
>
> Yes, we always prioritize external contract consistency, of course!
> You are overpivoting on *internal implementation detail* of base BTF's
> start_id being set to 1, which is convenient in some other places due
> to type_offs shifted by one mapping due to &btf_void special handling.
> We can always change that, if we wanted, but this shouldn't spill into
> public API though. But conceptually BTF types start at type #0, which
> is defined to be VOID and is not user controlled.

Thanks,  I understood.

>
>
> This is not much of a complication or inconsistency:
>
> type_shift =3D base_btf ? btf__type_cnt(base_btf) : 0;
> id_map[type_id - type_shift] =3D ...

Thank you,  I agree and will do it in the next version.

>
>
> >
> > >
> > > > + *
> > > > + * For base BTF, its `start_id` is fixed to 1, i.e. the VOID type =
can
> > > > + * not be redefined or remapped and its ID is fixed to 0.
> > > > + *
> > > > + * For split BTF, its `start_id` can be retrieved by calling
> > > > + * `btf__type_cnt(btf__base_btf(btf))`.
> > > > + *
> > > > + * On error, returns negative error code and sets errno:
> > > > + *   - `-EINVAL`: Invalid parameters or ID mapping (duplicates, ou=
t-of-range)
> > > > + *   - `-ENOMEM`: Memory allocation failure
> > > > + */
> > > > +LIBBPF_API int btf__permute(struct btf *btf, __u32 *id_map, __u32 =
id_map_cnt,
> > > > +                           const struct btf_permute_opts *opts);
> > > > +
> > > >  struct btf_dump;
> > > >
> > > >  struct btf_dump_opts {
> > > > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > > > index 84fb90a016c9..d18fbcea7578 100644
> > > > --- a/tools/lib/bpf/libbpf.map
> > > > +++ b/tools/lib/bpf/libbpf.map
> > > > @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
> > > >                 bpf_map__exclusive_program;
> > > >                 bpf_prog_assoc_struct_ops;
> > > >                 bpf_program__assoc_struct_ops;
> > > > +               btf__permute;
> > > >  } LIBBPF_1.6.0;
> > > > --
> > > > 2.34.1
> > > >

