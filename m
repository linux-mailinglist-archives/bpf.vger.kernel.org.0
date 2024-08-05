Return-Path: <bpf+bounces-36357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299D94745C
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 06:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94B71F211C9
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 04:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D867345B;
	Mon,  5 Aug 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AofKYl/s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C24A3B
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832319; cv=none; b=oEKVEgbIR3kIXiQGFBU51CLKS+cNwvHSqb+DLGbaBA3jjtKGpQACrZvGefabK/NW2BH8DU0iiefcI256IU3u/g/03Q3CZJa5QHhi3r86CfRAA2VtiiLdD3jGko0BxczADiaGOT/TVOfA/ox8xOWyuILjF+v+BHrg5rvSBzvESbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832319; c=relaxed/simple;
	bh=FQhu575GdXFK3P/b3vyBffS9nsobPQIlT4mg0BJG8Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAgBdGGKPCSDGRuaPV1+GIg2EvRkHCKfdT4gQU+WnXSSqVjhDgrWlOfpoWx3WDHqc190dg8FbJaRpBuJ3mvDiYrIke+SfH+RBQJbjlPdCTGYeeCkFguHjXNuaJsSFazJ0C0s82yLdH/elAmDOco1xCpbj3xk5Doxm8yHvid9w9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AofKYl/s; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0bfc0ee203so1536624276.2
        for <bpf@vger.kernel.org>; Sun, 04 Aug 2024 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722832317; x=1723437117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL1UjMHYh9dgGYcjyjt1eYutVVs2B9XbyJ28RIDH/E4=;
        b=AofKYl/s/qVCPkrCXuoUkOSNMKpGR483D9KwzQEpEfRrzfQhRoo2IwjQL1+9yXO5dE
         UtVQ9voOaqD38VOHEZhElKg52cQl/n+bvshxoBmdUnG9W5PpPTd8FPr7mPElVxVgUcJy
         ul5c7sHU7dFOvBGUoCSuefr3lJ3xvSXEHWeZeeUtSzwNKU7/7wRg+/r5u9lLbZrAWRig
         zlC+RB7+jmhXHo/ZdkXMssRlpos5WfJ115/3Y97EA9PnmUnQlHLHIOmuXxUA62dAq+2m
         6MtHq/TPuBudB9Dei4sNy12LWKzPx4fyuofDkz8Etn2/LZZuUwIo2M/aKs7qMGIVqaV2
         ncXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722832317; x=1723437117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL1UjMHYh9dgGYcjyjt1eYutVVs2B9XbyJ28RIDH/E4=;
        b=SkFUKXsWNsIWEIq+gaVvhG9zjZklchVSFsnBA67JdWEI7cq3dV+GRtuQIu2cM6Aq4I
         lBaZjTWsxgktnPEtoviIMPtRrfhVLyYiYk6vfbfbBpXf5fSXBaYOWEXp8icCo2LjmfSc
         wGQV5Iy+YMiYFRp6uBVhzIiAE7xhpmfzYdQwIz1D0wQi7e9HN5X8UHaqbL8ooL7Q1rWs
         R/T7GiyXLjrh5WvOtL19QTkHPggYh12o0gNLFfaMphq9mRYSlAcOsTL+PE+RUS/Ig6C5
         +UMLmUktcWj1zM+JdwoLzljHDKzRI5+ESEhBs+haUAUtEZC1ULEVx/imMCFnp4sGLrBZ
         tgCg==
X-Gm-Message-State: AOJu0YzyKX0LHm93huePZ0KutEpVWPxtwCDvXD83cnNTRYxsX/dUbayz
	tuSB4OfPUgpHibcAqyIwKiLyVxLdniEwEnTUwrEFKGxzIaHZGhF/BRymyVMJSCqOJHiBTmMQok3
	9/j+VR6O/bqWTRsmStq118WwVE6U=
X-Google-Smtp-Source: AGHT+IEshDOeseRy5BTTkKHfgzMsdmH6KlSVdXdTRadiPYzq6nPvro0Ty47qH8FkK3YNuGAARXrS0wu1w6zbTzktyG4=
X-Received: by 2002:a25:7585:0:b0:e03:5f4e:3265 with SMTP id
 3f1490d57ef6-e0bde51e356mr11276802276.51.1722832316818; Sun, 04 Aug 2024
 21:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com> <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
In-Reply-To: <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 4 Aug 2024 21:31:46 -0700
Message-ID: <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 7:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 8/3/2024 8:11 AM, Amery Hung wrote:
> > From: Dave Marchevsky <davemarchevsky@fb.com>
> >
> > Currently btf_parse_fields is used in two places to create struct
> > btf_record's for structs: when looking at mapval type, and when looking
> > at any struct in program BTF. The former looks for kptr fields while th=
e
> > latter does not. This patch modifies the btf_parse_fields call made whe=
n
> > looking at prog BTF struct types to search for kptrs as well.
> >
>
> SNIP
> > On a side note, when building program BTF, the refcount of program BTF
> > is now initialized before btf_parse_struct_metas() to prevent a
> > refcount_inc() on zero warning. This happens when BPF_KPTR is present
> > in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
> > -> btf_parse_kptr() -> btf_get(). This should be okay as the program BT=
F
> > is not available yet outside btf_parse().
>
> If btf_parse_kptr() pins the passed btf, there will be memory leak for
> the btf after closing the btf fd, because the invocation of btf_put()
> for kptr record in btf->struct_meta_tab depends on the invocation of
> btf_free_struct_meta_tab() in btf_free(), but the invocation of
> btf_free() depends the final refcnt of the btf is released, so the btf
> will not be freed forever. The reason why map value doesn't have such
> problem is that the invocation of btf_put() for kptr record doesn't
> depends on the release of map value btf and it is accomplished by
> bpf_map_free_record().
>

Thanks for pointing this out. It makes sense to me.

> Maybe we should move the common btf used by kptr and graph_root into
> btf_record and let the callers of btf_parse_fields() and
> btf_record_free() to decide the life cycle of btf in btf_record.

Could you maybe explain if and why moving btf of btf_field_kptr and
btf_field_graph_root to btf_record is necessary? I think letting
callers of btf_parse_fields() and btf_record_free() decide whether or
not to change refcount should be enough. Besides, I personally would
like to keep individual btf in btf_field_kptr and
btf_field_graph_root, so that later we can have special fields
referencing different btf.

Thanks,
Amery

> > Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  kernel/bpf/btf.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 95426d5b634e..7b8275e3e500 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *l=
og, struct btf *btf)
> >               type =3D &tab->types[tab->cnt];
> >               type->btf_id =3D i;
> >               record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_L=
IST_HEAD | BPF_LIST_NODE |
> > -                                               BPF_RB_ROOT | BPF_RB_NO=
DE | BPF_REFCOUNT, t->size);
> > +                                               BPF_RB_ROOT | BPF_RB_NO=
DE | BPF_REFCOUNT |
> > +                                               BPF_KPTR, t->size);
> >               /* The record cannot be unset, treat it as an error if so=
 */
> >               if (IS_ERR_OR_NULL(record)) {
> >                       ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> > @@ -5737,6 +5738,8 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >       if (err)
> >               goto errout;
> >
> > +     refcount_set(&btf->refcnt, 1);
> > +
> >       struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
> >       if (IS_ERR(struct_meta_tab)) {
> >               err =3D PTR_ERR(struct_meta_tab);
> > @@ -5759,7 +5762,6 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >               goto errout_free;
> >
> >       btf_verifier_env_free(env);
> > -     refcount_set(&btf->refcnt, 1);
> >       return btf;
> >
> >  errout_meta:
>

