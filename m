Return-Path: <bpf+bounces-21145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27288848AE5
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 04:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01CB284119
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 03:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349817F7;
	Sun,  4 Feb 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw4VuokB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9510F1
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017540; cv=none; b=u3I7E4llXRuxGJEmLRffPYBWGiFGjXmC/Vn9zTu1CZjeTGYsqKOYASGqhBqXUlNF9LCoaH9gSaS795g3V4hRgke0AqTl88KYYr2Y6HKBnOcip/deiZxFHtwDr8Do1EVDDh9xgO6nHajJ3t4mclYY91DbWc93XGEMv9EZDrAXfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017540; c=relaxed/simple;
	bh=jz2+74PvlnGl/QtqpQAspkvc43wlCGei4+lNRv5aPRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKr2sf8CVtejZgiN4UHUlKqPV3SJ/T4sNPeBa+79p4xKfELWBNLQwTIsgn/2CYIzBiZgjKf23Bi15VqhA+OL5yefgOPlTEVgyxNFkPWaIPGGe6J4hC1VQQUIykb38k32CzZRDOLBCcu2beplwQG5yR3kRyFTul2r5Ky9leQICKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw4VuokB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6818a9fe380so19629756d6.2
        for <bpf@vger.kernel.org>; Sat, 03 Feb 2024 19:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707017537; x=1707622337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkg277kaMPtb+eAjxXD/k90y0fvDMpv2xaZBU2lG57Y=;
        b=Yw4VuokBciobo9uLaWM4qOkmis6SPrA84imRwf3NoLJ5AKF8rqsrt9ZVoiuzZ0v3IC
         cWGbsJYoCJrsnOxH8wJTl9k3bjPegAvHaqhME4GUIS0bFS3PWCApjRmHQwjnB8yDgPko
         zOU16uQlAZXiAxhMqZPqlh4yOzySRq2JqQd78PqO7tnbkHkpHRXL1NdMSy0A5OQ5BAGO
         eku+NCOmQWaGGOhxzBMSrUaHHxivFLI4LCFd/KO+38MQ+YuI/mh5+86/l2ylsX/12SIZ
         UO043QN25SEv1ZITU3wjOIR1XBGa0Cdj16BHbQtfDz4SjEPy4WT377It15WN/pqIfgTg
         gbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707017537; x=1707622337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkg277kaMPtb+eAjxXD/k90y0fvDMpv2xaZBU2lG57Y=;
        b=iXxBw7eugIYO0m/Y3PcUJKbyurVFshG7NL+V+7geUNdkXSSKC6YDth3j390q9XE037
         QX72kPaHQk2xYAXK9XaSSplxu87dI1SnL7l7pN+VOnx6N+2NIgO1YUhhLx8EGkk8eMhy
         hpykqFFMqKVAyiBB5MLrXpUdLrIFk1rUSYnAr4X94zyhJFYhgSvtaMni1feT6wcH2Ik3
         /6c2UrCfqWIiNYe2d4AMhA3ohG6ePu1CgqtDEOTE4PeN4+AKHH631aPcMVSA8n+r/ALj
         NRvuhguIgy1P80c5B+0BHz10esdJVd4O07TtLndy0CLMLy/PwkQpHG40RtEDiux4BS9G
         j5cA==
X-Gm-Message-State: AOJu0Yz5lyW8f4ESZ93HABzWPamElHUXOEsh75ZO7at5BHqIqCzwEPAY
	dTBnUn6/5C1qLb2n9d8L9SA7mvx3f3AwO9dGJxZ9OzNLJ+0tX/IlZm+JtRDFDmVJxQHwA66O0RX
	InA9hEr7em9ppfHmcFRYzecvyF6I=
X-Google-Smtp-Source: AGHT+IEvGfLENE2YAAiUtMaC+kaLlt+uo3hmGvzbdUsw0jMsd9nDmmcXqvDl4ENw53mjQVRB7m3X0LijbN2coFgLqAo=
X-Received: by 2002:a0c:e082:0:b0:686:9de1:7015 with SMTP id
 l2-20020a0ce082000000b006869de17015mr2602460qvk.61.1707017537135; Sat, 03 Feb
 2024 19:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-2-laoar.shao@gmail.com>
 <CAEf4BzYwyFyydjNie4OfEUF0epV=ejcUCtuR6bZBJgk=8BX0wQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYwyFyydjNie4OfEUF0epV=ejcUCtuR6bZBJgk=8BX0wQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 4 Feb 2024 11:31:41 +0800
Message-ID: <CALOAHbBBtX2Oy+O47pzORQqsH9mhSUca2z1j8_rcoX_9=u=HEw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Add bpf_iter_cpumask kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 6:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add three new kfuncs for bpf_iter_cpumask.
> > - bpf_iter_cpumask_new
> >   KF_RCU is defined because the cpumask must be a RCU trusted pointer
> >   such as task->cpus_ptr.
> > - bpf_iter_cpumask_next
> > - bpf_iter_cpumask_destroy
> >
> > These new kfuncs facilitate the iteration of percpu data, such as
> > runqueues, psi_cgroup_cpu, and more.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index 2e73533a3811..c6019368d6b1 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cp=
umask *cpumask)
> >         return cpumask_weight(cpumask);
> >  }
> >
> > +struct bpf_iter_cpumask {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_cpumask_kern {
> > +       struct cpumask *mask;
> > +       int cpu;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specif=
ied cpumask
>
> I'd say "Initialize a new CPU mask iterator for a given CPU mask"?
> "new bpf_iter_cpumask" is both confusing and misleading (we don't
> create it, we fill provided struct)

will change it.

>
> > + * @it: The new bpf_iter_cpumask to be created.
> > + * @mask: The cpumask to be iterated over.
> > + *
> > + * This function initializes a new bpf_iter_cpumask structure for iter=
ating over
> > + * the specified CPU mask. It assigns the provided cpumask to the newl=
y created
> > + * bpf_iter_cpumask @it for subsequent iteration operations.
>
> The description lgtm.
>
> > + *
> > + * On success, 0 is returen. On failure, ERR is returned.
>
> typo: returned

will fix it.

>
> > + */
> > +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, cons=
t struct cpumask *mask)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(stru=
ct bpf_iter_cpumask));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> > +                    __alignof__(struct bpf_iter_cpumask));
> > +
> > +       kit->mask =3D bpf_mem_alloc(&bpf_global_ma, cpumask_size());
> > +       if (!kit->mask)
> > +               return -ENOMEM;
> > +
> > +       cpumask_copy(kit->mask, mask);
> > +       kit->cpu =3D -1;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
> > + * @it: The bpf_iter_cpumask
> > + *
> > + * This function retrieves a pointer to the number of the next CPU wit=
hin the
>
> "function returns a pointer to a number representing the ID of the
> next CPU in CPU mask" ?

will change it.

>
> > + * specified bpf_iter_cpumask. It allows sequential access to CPUs wit=
hin the
> > + * cpumask. If there are no further CPUs available, it returns NULL.
> > + *
> > + * Returns a pointer to the number of the next CPU in the cpumask or N=
ULL if no
> > + * further CPUs.
>
> this and last sentence before this basically repeat the same twice,
> let's keep just one?

will change it.

>
>
> > + */
> > +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +       const struct cpumask *mask =3D kit->mask;
> > +       int cpu;
> > +
> > +       if (!mask)
> > +               return NULL;
> > +       cpu =3D cpumask_next(kit->cpu, mask);
> > +       if (cpu >=3D nr_cpu_ids)
> > +               return NULL;
> > +
> > +       kit->cpu =3D cpu;
> > +       return &kit->cpu;
> > +}
> > +
> > +/**
> > + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
> > + * @it: The bpf_iter_cpumask to be destroyed.
> > + *
> > + * Destroy the resource assiciated with the bpf_iter_cpumask.
>
> typo: associated

will fix it.

>
> > + */
> > +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +       if (!kit->mask)
> > +               return;
> > +       bpf_mem_free(&bpf_global_ma, kit->mask);
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_SET8_START(cpumask_kfunc_btf_ids)
> > @@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
> >  BTF_SET8_END(cpumask_kfunc_btf_ids)
>
> Seems like you'll have to rebase, there is a merge conflict with
> recently landed changes.

will do it.

>
>
> >
> >  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> > --
> > 2.39.1
> >



--=20
Regards
Yafang

