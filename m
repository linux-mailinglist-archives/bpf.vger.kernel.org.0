Return-Path: <bpf+bounces-73480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB1C32829
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED1F4EA8CA
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DDA33E340;
	Tue,  4 Nov 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqn3YCgQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562433DED0
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279443; cv=none; b=EWNxzF9vXsrQ7EjDPPFTLClXmdXeOAWi9MhC2qdB/xJG1ii83B6mLg2viAqBl/msz8/Lz8LT3tTuiunLX039GoI46voLLQ9A8MCz2bdg96ByitjFZiBe2L+qOj6/MpxWPNKNnO8K6fI9luOzlQC2LNyELhr4h2Utv3q8X2qhz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279443; c=relaxed/simple;
	bh=yXSHAkAaFCC5x73vwswZ6CTo4/EiFFGD8vR2kR0hm0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/0iSVXzhXrEZs3MLLfasvnx7fVWTP5yOIepZfpqH8zY28e1ozrv2grRQ7Uwcn4eLaO1yYxqYLlbcYNCVD2GBKJ/kx/02wj6Hz4/mKiHbtiHOY//OdQ6fbsdawb99VdKVrgu5FpuGLDmnsX1YGkg+vQjKVZpPB8tne5oc865LSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqn3YCgQ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e393c49f1so5351578d50.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279439; x=1762884239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AFNPU/1wrMTKp4c1lZwT9/Mc95138ORXuWemPSnGfA=;
        b=iqn3YCgQiUWlcwa/8uwl4/wT41HYRiNPasYlEtWVD5qLsWFTfDGfEqjrDpo7vtYm4v
         Lb5ll/FLZVaWAeLwxe5okqG9K4K4/Ft8KYv4ZXptm7UybicQ8YvFSAhcEr69ceCeEOQk
         BUvRrcC4F07p6BPcLWj9NJMKooHyDC9l04ZWPq1QrVi6NblLXaVPSPfbRSzWWDylkJ2m
         XzrpkAWI6ufDXpmVp5kokNtLMpjB/Z9a4f2z777J3LQBNCgFwPAuuG2mzwl2SE7vf8cO
         KWXP4iAI07CLlYMwSjxyujnYbCDiI3/QX4F8ZJh9docWgX45nbiIZ9BdpxWEYcuKwJWB
         Ytkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279439; x=1762884239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AFNPU/1wrMTKp4c1lZwT9/Mc95138ORXuWemPSnGfA=;
        b=ZXoN9xz2sRsvkUHtMoX1nDuNt1MM0qSII9Q1NmcPsClR9lj6U7Wdkqu0kC6Xa8ULgO
         xYBwB9EetwvCDXl9mnt7rYIpNZWN5cCDhHnwxW/iSobt3kapa0mYdWEJkKWGElpcOdQi
         QfDszLeuIadfxODtyXucUGJmQpxZ4XoHPEAtZTnvSWL4Gg8lGTWyC6ES8TSBFTQu17Pc
         h6lr7bt94IR6J4z6l/IGhx7KJaayoT/iAGPH4AbLagXf2Cfa0TsfTSMocJHjYl8GYn3S
         yypLJqsPbEbBIt+0KtxKS/r+Q/m5fV4OLUba9sWAgxHLA2+7EYcvZ18V+N0W+wMWzLvO
         gdFw==
X-Gm-Message-State: AOJu0YyNzhH7SNLl3D0IfCF8QoLhvDeHxXe8lDorUZa3dU5FxtW/6LRu
	fcfWtNKmRoShvtWGlPx0BgCYdvEqtMd/NtHN/AD6H81aotu9/3k7n3EXik9VkhAMAVktNCm8zaB
	9Sq3RV33YQ41Y3y1lZqFP2U4LeH/+EfI=
X-Gm-Gg: ASbGnct0KfWml3czxDuOKDtCSJS/x3HysPAAYyVJzATbPQLYkb+DHKpinph7Tk6g+he
	JOU03WXj82VXsvNoEs7htf6kbUuBZ4fdnOHSa5uz4sM59H0AZfKpadZ3QSkLDmyoz300jn1vCxB
	02KlLf5lH0pkBPF9Og8iTHnHo0dieN+eTXkp5Ql9guNSk5JmfHU2ir1X4+PovIXWrPp0/8iWONm
	HplxfaSTTkIIJVwowh/aItw47xZvgFYq3XyyiCyDndEoy29i6jfl6m/o6RmQ6YnnxOhx+70LgxU
	OF4NhR9Ento=
X-Google-Smtp-Source: AGHT+IGjQhEYKGOLIYHhbHakhgp7lUlW8J8MOz2grZPju7AN1NvbSSB2geQgdZskJiAb6oBB/Lu6ljbSlrZCZPw0KG4=
X-Received: by 2002:a05:690e:429a:10b0:63f:c359:10dc with SMTP id
 956f58d0204a3-63fd358205amr326604d50.56.1762279438881; Tue, 04 Nov 2025
 10:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-3-ameryhung@gmail.com> <e9468bb9f2cc62c69d9364a4ce2ab5ee08fafa6576d6be6a121b04a80a379094@mail.kernel.org>
In-Reply-To: <e9468bb9f2cc62c69d9364a4ce2ab5ee08fafa6576d6be6a121b04a80a379094@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 10:03:47 -0800
X-Gm-Features: AWmQ_bl7M8pnh_tkmQsKcI0afbDQVTes5Qw-Q4x4SOwQ8tW808Oei-2iXvstjTY
Message-ID: <CAMB2axMsX6g2ByUtM31yqVvsTO9gGgDUKsMstpZtJLcv_90qVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a47d67db3..0f71030c0 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
>
> [ ... ]
>
> > @@ -2026,6 +2028,9 @@ static inline void bpf_module_put(const void *dat=
a, struct module *owner)
> >               module_put(owner);
> >  }
> >  int bpf_struct_ops_link_create(union bpf_attr *attr);
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap);
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
> > +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
> >  u32 bpf_struct_ops_id(const void *kdata);
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index a41e6730e..0a19842da 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
>
> [ ... ]
>
> > @@ -1394,6 +1413,77 @@ int bpf_struct_ops_link_create(union bpf_attr *a=
ttr)
> >       return err;
> >  }
> >
> > +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *m=
ap)
> > +{
> > +     struct bpf_map *st_ops_assoc;
> > +
> > +     guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +     st_ops_assoc =3D prog->aux->st_ops_assoc;
> > +
> > +     if (st_ops_assoc && st_ops_assoc =3D=3D map)
> > +             return 0;
> > +
> > +     if (st_ops_assoc) {
> > +             if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     return -EBUSY;
> > +
> > +             WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
> > +     } else {
> > +             if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     bpf_map_inc(map);
> > +
> > +             WRITE_ONCE(prog->aux->st_ops_assoc, map);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> > +{
> > +     struct bpf_map *st_ops_assoc;
> > +
> > +     guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> > +
> > +     st_ops_assoc =3D prog->aux->st_ops_assoc;
> > +
> > +     if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +             return;
> > +
> > +     if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +             bpf_map_put(st_ops_assoc);
> > +
> > +     WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
> > +}
> > +
> > +/*
> > + * Get a reference to the struct_ops struct (i.e., kdata) associated w=
ith a
> > + * program.
> > + *
> > + * If the returned pointer is not NULL, it must points to a valid and
> > + * initialized struct_ops. The struct_ops may or may not be attached.
> > + * Kernel struct_ops implementers are responsible for tracking and che=
cking
> > + * the state of the struct_ops if the use case requires an attached st=
ruct_ops.
> > + */
> > +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> > +{
> > +     struct bpf_map *st_ops_assoc =3D READ_ONCE(aux->st_ops_assoc);
> > +     struct bpf_struct_ops_map *st_map;
> > +
> > +     if (!st_ops_assoc || st_ops_assoc =3D=3D BPF_PTR_POISON)
> > +             return NULL;
> > +
> > +     st_map =3D (struct bpf_struct_ops_map *)st_ops_assoc;
> > +
> > +     if (smp_load_acquire(&st_map->kvalue.common.state) =3D=3D BPF_STR=
UCT_OPS_STATE_INIT) {
> > +             bpf_map_put(st_ops_assoc);
>                 ^^^^
>
> Does bpf_prog_get_assoc_struct_ops() need to call bpf_map_put() here?
>

Right. bpf_map_put() is not needed here. It was some artifact in v4.
Will respin and fix it.

> The function comment says "Get a reference to the struct_ops struct"
> but the function never calls bpf_map_get/inc() to acquire a reference.
> It only reads aux->st_ops_assoc via READ_ONCE().
>
> When the state check fails (INIT state), the function calls bpf_map_put()
> which drops the reference that was acquired in bpf_prog_assoc_struct_ops(=
).
> But on the success path below, it returns kdata without any refcount
> operation.
>
> This creates an imbalance:
> - INIT state path: drops a reference, returns NULL
> - Non-INIT path: no refcount change, returns kdata
>
> The caller has no way to know whether the reference count was modified.
> Also, the function is EXPORTED but doesn't document the reference countin=
g
> semantics clearly.
>
> > +             return NULL;
> > +     }
> > +
> > +     return &st_map->kvalue.data;
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
>
> Can this function race with bpf_prog_disassoc_struct_ops()?
>
> Since bpf_prog_get_assoc_struct_ops() reads aux->st_ops_assoc via
> READ_ONCE() without holding the mutex or acquiring a reference, there's
> a window where:
>
> Thread A: reads st_ops_assoc pointer
> Thread B: calls bpf_prog_disassoc_struct_ops()->bpf_map_put() (drops last=
 ref)
> Thread A: dereferences st_map->kvalue.common.state (use-after-free)
>
> For non-struct_ops programs, bpf_prog_assoc_struct_ops() holds a
> reference via bpf_map_inc(). This reference is dropped in
> bpf_prog_disassoc_struct_ops() when the program is freed. Without
> acquiring a new reference in bpf_prog_get_assoc_struct_ops(), the map
> can be freed during the race window above.

This is fine. bpf_prog_get_assoc_struct_ops() should only be called by
kfunc (i.e., when a BPF program is still alive). Refcount has been
bumped during the BPF_PROG_ASSOC_STRUCT_OPS command or during async
callback registration.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/190776=
79684

