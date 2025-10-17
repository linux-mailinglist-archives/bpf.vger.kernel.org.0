Return-Path: <bpf+bounces-71263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3054EBEBE47
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 00:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8509356AB5
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E22D5C6C;
	Fri, 17 Oct 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsfvA8so"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFB280328
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739131; cv=none; b=KV2a8q/zT01alQ9bBtLLZWB1WM4tKUQdytZLI5zBOkD5QCw7GWG0u1SWIkhM+YfmFu0GIoqej4H80W0CAyG1HxIt41oZTIK2PQ0WYwpE7l5UV6t83+mH5dI9M/5kBhJYWLDq3E/mC30rpVgrleSlxYMPEPZhriV6I3O7y2rmsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739131; c=relaxed/simple;
	bh=WLv4UbeV21G3VziaZoThvtV24+r7/0i+FxbQsKab4UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/IMZyi78NPV2kHiV2odGcPwDULpWjcp/pXBTBc2Vf/M7uKWockXh7p0Tnt8dYWSPhD/8b7/RagWAX8Q6Dslxq0JM9yjUG5ICavw1E83Xt6KBTMVvRyDAXcWJh986pZO1Ny0Zmm3xjbw1rJrYE14fInp9/0EqjJOhk0GlIieYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsfvA8so; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e19642764so1337398d50.1
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760739128; x=1761343928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+BxeI7Gi1yIOnv5IKG85yDuwPz4sVLCshDCTPjNwc=;
        b=ZsfvA8soKrQXqCwc3GGHT1UZ9oNuV7KwyxwA/bFrrmj+mddVhmWZHwxxROF4uw4IdG
         DBTixs3kxrd5+mxPxkNpx1j1uZgbt7ZHKS1ZpEx6rk4Ea6lMYwNjAJRV6slxh+A4lqsY
         3IUk3sC9VQg160JBZtzr0BdUOt0SA+oLeETw5FvWQT2/z4Y4QDaV+O789Kr3yw2+y7nu
         TUFic6c/fQJhp/Zx+a97K9kRPtiOEJIDgKj6DId3kcBOvuiOjvZtXBGyj/EiEKKZLfXd
         nPJZ5JZ380hnn4JJhLUlLn//oXYSa/kqvkM9foly6v3ev8lTPLMHYFAOgncNBHx94jpt
         6pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760739128; x=1761343928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ+BxeI7Gi1yIOnv5IKG85yDuwPz4sVLCshDCTPjNwc=;
        b=tXTSjYBseB+C9T0W6dnIgBFdj/uvlhihRCBa7eggfxHLgTHAcdbih0BZkpJpKBqT5m
         klsh00jpwyD4iwYSHjYa1QA0kLt8tuaQeRvC/C8vPduA2oZ+vfWPDuB7CkvK60Js02rN
         CWO/XD+tIf49duY29S5AhCHraBh2er3rU8vNJZW98NsMhPxbYVlZASxH355Pn0ZNoJa7
         8pH0oQguA0ju3Qo+77cjXcbynSflnPU1/e4qUGXcTkHPJBvCrjvbjYylYdE5basJY/KR
         ijrdlFxX95eOVil7qR9ZIreDhKJpdY8rM9CjrBBOq3VewmQmA7UQi/YU4MkBIiYgsN4L
         iwCw==
X-Gm-Message-State: AOJu0YwneBMKTmFujJUt/FHh0eMsE7ItFzExs0s4f7dnJWPjuE3w7mVa
	Cl/c2u1JoLQeAKfb9ULt2LjygW6QknI/tGt6VhaiW+dKjqrx3rxiqMCmns6xhi7S1P2Syb8x0ZX
	KrLjUyb2iioaw5wniTN5UIQmrfiXMbiY=
X-Gm-Gg: ASbGnct5HhFg2JeAMU+t4hmb10bGdPeHJWR6Y+Kb9y8gQ7ck2wINY4k+2PwJLWl80dh
	cD+dx8QiWbLRrlw11sbSBadcIHdp/LpVIrH3m6d9Xf4aHjllYtqFJL8H69VrGIhF2rM/cJCeFhT
	he9XZIDb4hOz+XF1hhSiaUCopgi3W7dDrUdW9i8BExsHkpFvIDfVqxssf2Cgd33ZFTKRtFgesjM
	BLyaxGc1jChxJo6xJXgdJjDX5oQw/QPxkwLoZYD0TwgX7w6ZYTtzfmR6vBef+ihbm5cfDg=
X-Google-Smtp-Source: AGHT+IFOWqvau9vZz3Hm2wXUe960FBE5sMhFwFmskl3jz+ZNzA1xihYMGdcj4bnF/bG5zPgcX5BpPpzjSpGK9of07Gk=
X-Received: by 2002:a05:690e:14c6:b0:63e:22b1:21aa with SMTP id
 956f58d0204a3-63e22b143c8mr1958691d50.59.1760739128292; Fri, 17 Oct 2025
 15:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017215627.722338-1-ameryhung@gmail.com> <20251017215627.722338-3-ameryhung@gmail.com>
 <CAEf4BzaRxpR5XLJmFopwq-asBUv0vJ2RZtcx2f=+XbfcCgBeFA@mail.gmail.com>
In-Reply-To: <CAEf4BzaRxpR5XLJmFopwq-asBUv0vJ2RZtcx2f=+XbfcCgBeFA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 17 Oct 2025 15:11:57 -0700
X-Gm-Features: AS18NWBvEBpyW0PskJEiJOCVMyuQq3w6BJX01FFzw62oGvNRm8G54PYe0XNMKtA
Message-ID: <CAMB2axPZaXvqvJx8qTFVe61q8-tmSdb4udyHW4PQ-iL4Am1wSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Support associating BPF program with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 3:05=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 17, 2025 at 2:56=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
> > a BPF program with a struct_ops map. This command takes a file
> > descriptor of a struct_ops map and a BPF program and set
> > prog->aux->st_ops_assoc to the kdata of the struct_ops map.
> >
> > The command does not accept a struct_ops program or a non-struct_ops
> > map. Programs of a struct_ops map is automatically associated with the
> > map during map update. If a program is shared between two struct_ops
> > maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
> > associated struct_ops is ambiguous. The pointer, once poisoned, cannot
> > be reset since we have lost track of associated struct_ops. For other
> > program types, the associated struct_ops map, once set, cannot be
> > changed later. This restriction may be lifted in the future if there is
> > a use case.
> >
> > A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
> > the associated struct_ops pointer. The pointer returned, if not NULL, i=
s
> > guaranteed to be valid and point to a fully updated struct_ops struct.
> > This is done by increasing the refcount of the map for every associated
> > non-struct_ops programs. For struct_ops program reused in multiple
> > struct_ops map, the return will be NULL. struct_ops implementers should
> > note that the struct_ops returned may or may not be attached. The
> > struct_ops implementer will be responsible for tracking and checking th=
e
> > state of the associated struct_ops map if the use case requires an
> > attached struct_ops.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h            | 16 ++++++++
> >  include/uapi/linux/bpf.h       | 17 +++++++++
> >  kernel/bpf/bpf_struct_ops.c    | 70 ++++++++++++++++++++++++++++++++++
> >  kernel/bpf/core.c              |  3 ++
> >  kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 17 +++++++++
> >  6 files changed, 169 insertions(+)
> >
>
> [...]
>
> > @@ -1394,6 +1401,69 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >         return err;
> >  }
> >
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap)
> > +{
> > +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +       if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc !=3D map=
) {
> > +               if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> > +                       WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POI=
SON);
> > +                       return 0;
> > +               }
> > +
> > +               return -EBUSY;
> > +       }
> > +
> > +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +               bpf_map_inc(map);
>
> if st_ops_assoc was already set to map before, we will bump refcount
> one more time here, but we'll bpf_map_put() only once in
> bpf_prog_disassoc_struct_ops(), no?

Right. It's a bug. I will fix it in the next respin. Thanks for catching it=
.

>
> > +
> > +       WRITE_ONCE(prog->aux->st_ops_assoc, map);
> > +       return 0;
> > +}
> > +
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> > +{
> > +       struct bpf_map *map;
> > +
> > +       guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +       map =3D READ_ONCE(prog->aux->st_ops_assoc);
> > +       if (!map || map =3D=3D BPF_PTR_POISON)
> > +               return;
> > +
> > +       if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +               bpf_map_put(map);
> > +
> > +       WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
> > +}
> > +
>
> [...]

