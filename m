Return-Path: <bpf+bounces-48042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187D6A03515
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EBF3A2C7B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1413AA35;
	Tue,  7 Jan 2025 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghDRdQ3/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCE70810;
	Tue,  7 Jan 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216662; cv=none; b=CghmO4WAE4CHJHXgxJzBdQygCk1GguIyTqOsXkI6vV8+Gkk0Jlm+cx+HAE9bSe9/8sY7rVsYXIAbX0aIIwxaFF8+45cbFjPO/DqsaVjzRidcQP9c3juAYiBjbxQi9HAwruLepRIUWF3bSHGoEdJ1Uks1pgnl+F6GAFCPdh0aep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216662; c=relaxed/simple;
	bh=2rUo6c4R+HsjvqEa/dEuyH55nzIQz7mdn5ndl3NjVqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro/EeSJHFtUKp55cWSAONIK5yGAwvw8dGJAYmFwBKcm3EJCgglhzuPsA3x79M8Tg1MecXNlyjTrBs0n4IwmRbxBOuKZ4hI5ixyBHpPem2ASX11LUFBP1rd121ON3V2XsSXzQ1ceVY/Ipyc7WTIV8gK6mdfQ8FtP4VqNsqqpoKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghDRdQ3/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso12665033f8f.1;
        Mon, 06 Jan 2025 18:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736216656; x=1736821456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXkrP8t8gOHXzrDwPMWRkyABOLRzwu/N+e6UIfVcHsg=;
        b=ghDRdQ3/hxSUtVizAePtCBPDn2cWbz7jVt1D6uPdWJ7cAiJhPsGCvCwkD7pdk6cj9n
         EYafHzChO5xq0pcpGNN99K7S/bOEFPReroJ2Zqb9ikAvfV8IhcA7xBO0c3EMLOXgUzjL
         e+mw1aD8c/f4LQhVvg/RZM0JgytZvyGuw/zL1WJwiu6GBrUZZbZ7SWdB8s7ijausOmJI
         A9eGDt40LNWLkQQF2Am9LmuA/E53ZWH5TkdhpESwOVSTmDreZWk5L0oOf7omdgUA/XLC
         kru7wrtWg9RHoUqJP4QcjJ9LRA6h7rtYJBjiM457v+K0W7G3PIj3R2u3ZSomro/OZd7z
         4gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736216656; x=1736821456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXkrP8t8gOHXzrDwPMWRkyABOLRzwu/N+e6UIfVcHsg=;
        b=F9ady2YPrWu8ta/QvhC5wWI+HZ8kbf95s6dHSCy2EFjqD751brmEhoGFnyAGsCy6aE
         leF/2KqXjTvRhqzUjFtRZQw6M+nwa2Kn5O74QmyZjTze4MHGj3c2vHA+JNgREiweBtub
         FzDqyAYBm6I+VpMxMh39WtiKSpj3g8xQx96P1dMjiAxOZE+2eNYDzFIyYo6utk/Dnswf
         /Aj4cM+2d7ZfxGVvRUJUOd2N4VJoxijWx7gsDWbLJ82jmo4Hn3Ik5R6jKGbKvh3OxxrE
         X7LQ7baoqrCDiOZSeAmqvhSNmF7gS5az9/A7SDMMfb0JCxqM+Y58dRMxGwbxiUd8Criy
         /d4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0GnoSJZ9VnMaDJQQ5Dfh6QvFGMX6yke0C8pqmzeprAaJXw2vl9tZWtznNhDg6CWvFuG6ZibM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHdVlh9I6TPSJDpws+9eq/GV8GeNAUAnLnI81LrA6zxrQA7fP
	mDI7u49XQ0c9KAbcCOVmsAcNw4Z83feHmWUsFtYoyVnRwMODtx+r8ZfIi3ti3jV5I4nwn1PmVfI
	jbKlnItfmybojtj4osFg0hWWZ/sw=
X-Gm-Gg: ASbGnctNhSYOGZnQ4KmHJu8GHGPtinvZAW7naHN2TlfZtWCmQHAnQRZHn98Od1moKbp
	Q3Kah7ny0ntXb6ePBucOgj3JjKNSWF2sYSgOprw==
X-Google-Smtp-Source: AGHT+IH36M140hpGyae1JU8H8yi3BJsV1dne/XfBiQ8IvfJbd31IJ/3/gn/aEShkIhPqCUtrrJwvC7A3fTvD6a+SnKI=
X-Received: by 2002:a05:6000:2ae:b0:385:ed16:c97 with SMTP id
 ffacd0b85a97d-38a224088aemr45748331f8f.49.1736216655650; Mon, 06 Jan 2025
 18:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
 <20250106081900.1665573-16-houtao@huaweicloud.com> <CAADnVQJzQ9ADqpCb7mcsQCU1enTdPH7XtZKkTHyY739sg62CzA@mail.gmail.com>
 <a467b9ac-3785-7c5d-577c-c2f4a43c6923@huaweicloud.com>
In-Reply-To: <a467b9ac-3785-7c5d-577c-c2f4a43c6923@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Jan 2025 18:24:04 -0800
X-Gm-Features: AbW1kvbqnH299QAv49Pfwcjsu-P7Vv5NlTIxIPVEeV0zuuXRcZhwlj8w4ldvvg0
Message-ID: <CAADnVQKQ6bCFVwaFUb0fpnhMyGDH9-HRDOFDkR3Mdjotk39jPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 15/19] bpf: Disable migration before calling ops->map_free()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:40=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 1/7/2025 6:24 AM, Alexei Starovoitov wrote:
> > On Mon, Jan 6, 2025 at 12:07=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Disabling migration before calling ops->map_free() to simplify the
> >> freeing of map values or special fields allocated from bpf memory
> >> allocator.
> >>
> >> After disabling migration in bpf_map_free(), there is no need for
> >> additional migration_{disable|enable} pairs in the ->map_free()
> >> callbacks. Remove these redundant invocations.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/arraymap.c          | 2 --
> >>  kernel/bpf/bpf_local_storage.c | 2 --
> >>  kernel/bpf/hashtab.c           | 2 --
> >>  kernel/bpf/range_tree.c        | 2 --
> >>  kernel/bpf/syscall.c           | 8 +++++++-
> >>  5 files changed, 7 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> >> index 451737493b17..eb28c0f219ee 100644
> >> --- a/kernel/bpf/arraymap.c
> >> +++ b/kernel/bpf/arraymap.c
> >> @@ -455,7 +455,6 @@ static void array_map_free(struct bpf_map *map)
> >>         struct bpf_array *array =3D container_of(map, struct bpf_array=
, map);
> >>         int i;
> >>
> >> -       migrate_disable();
> >>         if (!IS_ERR_OR_NULL(map->record)) {
> >>                 if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARR=
AY) {
> >>                         for (i =3D 0; i < array->map.max_entries; i++)=
 {
> >> @@ -472,7 +471,6 @@ static void array_map_free(struct bpf_map *map)
> >>                                 bpf_obj_free_fields(map->record, array=
_map_elem_ptr(array, i));
> >>                 }
> >>         }
> >> -       migrate_enable();
> >>
> >>         if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >>                 bpf_array_free_percpu(array);
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index b649cf736438..12cf6382175e 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -905,13 +905,11 @@ void bpf_local_storage_map_free(struct bpf_map *=
map,
> >>                 while ((selem =3D hlist_entry_safe(
> >>                                 rcu_dereference_raw(hlist_first_rcu(&b=
->list)),
> >>                                 struct bpf_local_storage_elem, map_nod=
e))) {
> >> -                       migrate_disable();
> >>                         if (busy_counter)
> >>                                 this_cpu_inc(*busy_counter);
> >>                         bpf_selem_unlink(selem, true);
> >>                         if (busy_counter)
> >>                                 this_cpu_dec(*busy_counter);
> >> -                       migrate_enable();
> >>                         cond_resched_rcu();
> >>                 }
> >>                 rcu_read_unlock();
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 8bf1ad326e02..6051f8a39fec 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -1570,14 +1570,12 @@ static void htab_map_free(struct bpf_map *map)
> >>          * underneath and is responsible for waiting for callbacks to =
finish
> >>          * during bpf_mem_alloc_destroy().
> >>          */
> >> -       migrate_disable();
> >>         if (!htab_is_prealloc(htab)) {
> >>                 delete_all_elements(htab);
> >>         } else {
> >>                 htab_free_prealloced_fields(htab);
> >>                 prealloc_destroy(htab);
> >>         }
> >> -       migrate_enable();
> >>
> >>         bpf_map_free_elem_count(map);
> >>         free_percpu(htab->extra_elems);
> >> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> >> index 5bdf9aadca3a..37b80a23ae1a 100644
> >> --- a/kernel/bpf/range_tree.c
> >> +++ b/kernel/bpf/range_tree.c
> >> @@ -259,9 +259,7 @@ void range_tree_destroy(struct range_tree *rt)
> >>
> >>         while ((rn =3D range_it_iter_first(rt, 0, -1U))) {
> >>                 range_it_remove(rn, rt);
> >> -               migrate_disable();
> >>                 bpf_mem_free(&bpf_global_ma, rn);
> >> -               migrate_enable();
> >>         }
> >>  }
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 0503ce1916b6..e7a41abe4809 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -835,8 +835,14 @@ static void bpf_map_free(struct bpf_map *map)
> >>         struct btf_record *rec =3D map->record;
> >>         struct btf *btf =3D map->btf;
> >>
> >> -       /* implementation dependent freeing */
> >> +       /* implementation dependent freeing. Disabling migration to si=
mplify
> >> +        * the free of values or special fields allocated from bpf mem=
ory
> >> +        * allocator.
> >> +        */
> >> +       migrate_disable();
> >>         map->ops->map_free(map);
> >> +       migrate_enable();
> >> +
> > I was about to comment on patches 10-13 that it's
> > better to do it in bpf_map_free(), but then I got to this patch.
> > All makes sense, but the patch breakdown is too fine grain.
> > Patches 10-13 introduce migrate pairs only to be deleted
> > in patch 15. Please squash them into one patch.
>
> OK. However I need to argue for the fine grained break down. The
> original though is that if disabling migration for ->map_free callback
> for all maps introduces some problems, we could revert the patch #15
> separately instead of reverting the squashed patch and moving the
> migrate_{disable|enable}() pair to maps which are OK with that change
> again.  What do you think ?

Feels overkill.
If migrate disable for the duration of map_free callback causes issues
we can introduce individual migrate pairs per map type
or revert the whole thing,
but imo it's all too theoretical at this point.

> >
> > Also you mention in the cover letter:
> >
> >> Considering the bpf-next CI is broken
> > What is this about?
>
> Er, I said it wrong. It is my local bpf-next setup. A few days ago, when
> I tried to verify the patch by using bpf_next/for-next treee, the
> running of test_maps and test_progs failed. Will check today that
> whether it is OK.

I see. /for-next maybe having issues. That needs to be investigated
separately.
Make sure /master is working well.

> >
> > The cant_migrate() additions throughout looks
> > a bit out of place. All that code doesn't care about migrations.
> > Only bpf_ma code does. Let's add it there instead?
> > The stack trace will tell us the caller anyway,
> > so no information lost.
>
> OK. However bpf_ma is not the only one which needs disabled migration.
> The reason that bpf_ma needs migrate_disable() is the use of
> this_cpu_ptr(). However, there are many places in bpf which use
> this_cpu_ptr() (e.g., bpf_for_each_array_elem) and this_cpu_{in|del}
> pair (e.g., bpf_cgrp_storage_lock).  I will check the cant_migrate which
> can be removed in v2.

Well, maybe not all cant_migrate() hunks across all patches.
But patches 16, 17, 18, 19 don't look like the right places
for cant_migrate().

