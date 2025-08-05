Return-Path: <bpf+bounces-65067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A6B1B779
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62197184A99
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F327A10C;
	Tue,  5 Aug 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLnAGXR5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB5279327;
	Tue,  5 Aug 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407638; cv=none; b=TvKmaCfeN4r6Ay6WXKLQ0VVW/MQXRh7DaANNyQsyPc2eq9xuVr2ZAFCjtkU313qVBRXWz5iI9O6XmvdIDq5dNcyC7LFRyFrRZlAQD+2fsRoMHLWC3dm/Hc5yNZiaUmFHA/SlgcaLNeqx7tJCgNHjwWFDQGzVlBSUUH1WZY+lMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407638; c=relaxed/simple;
	bh=zDP0EMxPTzsvqvDDFHoOFFDYPolz013+X7tpnDJkiI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZCOU6Fu7QwtI+VBvM17r4DqiIE/XIjJMoX0msuM/YDw0bqge8l93m9Eee+UwLd40wI7cmu6IyU8XxwbM2VVtwdqFCP0JhAvKVWzlZ+WOuVSDLXt+KijBcCJ0Xek+B4+6m6y74Bu8NxfCYmjaEePBXBZJlgGJpnYO24vw4eV+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLnAGXR5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-712be7e034cso53535357b3.0;
        Tue, 05 Aug 2025 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754407635; x=1755012435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ03RrXWGlqETUSoJnPwT06x3qJGW7jZ2UkXPbzvzDY=;
        b=fLnAGXR5sBUIzhQPlN2KDKcVZO94Dor0ZaWhUWNxqRRFEVv2uO4jLPWRNUo7+l7FhM
         amgEzF/85ifEpknj1fZgnYas+3Nyz3ju+7VSFy05lY1yNlpSiXJj1mefnCdTnFyLSvdw
         lKNJE/tzpUQIFDUgd7LQ8Q4ciF35TsUywFZeA+ORSopjh+vWawCndF37FewYivIGEjXz
         Zy8FQPdWmXoGLhE43JSElIaqVdQwZ9//E8m6y4ZiCkLYGNAwNOVk0poXw82D8r44hXBq
         cPgiyS5n4LGiqBKt+p3o5bI3EBLg4/Di8iqkNDFLF8ijiN98sdx04yfzkbl2Jkkao1Mc
         l7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407635; x=1755012435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ03RrXWGlqETUSoJnPwT06x3qJGW7jZ2UkXPbzvzDY=;
        b=fB2dWeaAJpE6iKV8CJhXklqowmoeWGQQw+iBPztoFlrlZTeYRljPLGV4+tHpOLZiXs
         KWEp0hCqMMBTNzBqEGE2OkY/BtNm+rF6PnvAp0+HxWj3oQXGwuGjgEOKM9/9+MMSPsDo
         AOXIN9CsgbdiJlNDikWXHmb+D+Y+X4+O+hgJF0oSmo3eUc09YL/iSJmF2q9KbwnLBtft
         lstvo6b8RJzkPeJW5Bewe7Kb+NT85HIacS3/H7PuWYjz6vLPANVuoyVfg11Ht3ZkeWIn
         1OaJYBjDWILPaN+MrZielydSGrFHfJ8E0saneY/32iBGvdA3Cjvv7tUvU5PCJu0AsaoV
         WfwA==
X-Forwarded-Encrypted: i=1; AJvYcCUduC0D19+40TZfF0cg2EF71oUO3Db+mUdRCuvD8b8BLwLIfB/z1DchwKtS91bZHt3hrjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMK51VaeqtKoIE8gV+UHVtCRj8zC/WDiUuklzPmMBUdHuzrj3G
	rp8JuT83VLpIp9KHVjy0ikxL+wnKSWODjfyISIVE4yk3JzQx3mvlSBHqJEhw+xKUC8Xw6Mb0SWb
	f/c4LNW92UOO+aw9WVGVVrWBCs1wM0hE=
X-Gm-Gg: ASbGncuju6OImpTNQ37GknkhBxT84oWNqz5dP6Bk62ODSM0jazaHm0S91nqb4EGhb/I
	qZBnTsx71I6Cc6vTAWDjZ3E3wWNd5YbMUsVlZ9vKvJkK1fCz4hO5y69QlzYdp6eJ3MRmV6CFx+X
	gO/EVet/rnVeNQGyZEevXknqheGnHspBNEXaf3dN5fr1V6mfZWCA8s73LOO7NJaCbOTTqk7ZugB
	ouPjko9
X-Google-Smtp-Source: AGHT+IFC9bPaABmOeXpUu3j2VMwvuM0m1SE+O/sV+PFYeoECZ8V2P3jnG2xei0NH69fe9TsU0rHflIN+VMDt6ZqODg0=
X-Received: by 2002:a05:690c:eca:b0:71a:3312:b918 with SMTP id
 00721157ae682-71b7f8b480dmr167324517b3.33.1754407635108; Tue, 05 Aug 2025
 08:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731210950.3927649-1-ameryhung@gmail.com> <20250731210950.3927649-3-ameryhung@gmail.com>
 <573da832-260f-4fc5-8e8c-38f185e09249@linux.dev>
In-Reply-To: <573da832-260f-4fc5-8e8c-38f185e09249@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 5 Aug 2025 08:27:03 -0700
X-Gm-Features: Ac12FXzXFPie24oic0tQ8LvKMJ4FjNRY1MMYaT6NEjc5ZQxCMGvgzNGSlFf8uEs
Message-ID: <CAMB2axNQ3kXp-LbRsqc_ob61-a_YArgt-LSZMuMke_O0B=-exw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add multi_st_ops that
 supports multiple instances
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 4:43=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 7/31/25 2:09 PM, Amery Hung wrote:
> > +static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_testmod_multi_st_ops *st_ops =3D
> > +             (struct bpf_testmod_multi_st_ops *)kdata;
> > +     struct bpf_map *map;
> > +     unsigned long flags;
> > +     int err =3D 0;
> > +
> > +     map =3D bpf_struct_ops_get(kdata);
>
> The bpf_struct_ops_get returns a map pointer and also inc_not_zero() the =
map
> which we know it won't fail at this point, so no check is needed.
>
> > +
> > +     spin_lock_irqsave(&multi_st_ops_lock, flags);
> > +     if (multi_st_ops_find_nolock(map->id)) {
> > +             pr_err("multi_st_ops(id:%d) has already been registered\n=
", map->id);
> > +             err =3D -EEXIST;
> > +             goto unlock;
> > +     }
> > +
> > +     st_ops->id =3D map->id;
> > +     hlist_add_head(&st_ops->node, &multi_st_ops_list);
> > +unlock:
> > +     bpf_struct_ops_put(kdata);
>
> To get an id, it needs a get and an immediate put. No concern on the perf=
ormance
>   but just feels not easy to use. e.g. For the subsystem supporting link_=
update,
> it will need to do this get/put twice. One on the old kdata and another o=
n the
> new kdata. Take a look at the bpf_struct_ops_map_link_update().
>
> To create a id->struct_ops mapping, the subsystem needs neither the map p=
ointer
> nor incrementing the map refcnt. How about create a new helper to only re=
turn
> the id of the kdata?
>

Make sense. I will create a new helper as you suggested. I was
thinking about repurposing existing helpers. There is indeed no need
to increase the refcount as kdata is protected under lock during
map_update, link_create and link_update.

Thanks,
Amery

> Uncompiled code:
>
> u32 bpf_struct_ops_id(const void *kdata)
> {
>         struct bpf_struct_ops_value *kvalue;
>         struct bpf_struct_ops_map *st_map;
>
>         kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data)=
;
>         st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue=
);
>
>         return st_map->map.id;
> }
>
> > +     spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> > +
> > +     return err;
> > +}
> > +
> > +static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_testmod_multi_st_ops *st_ops;
> > +     struct bpf_map *map;
> > +     unsigned long flags;
> > +
> > +     map =3D bpf_struct_ops_get(kdata);
> > +
> > +     spin_lock_irqsave(&multi_st_ops_lock, flags);
> > +     st_ops =3D multi_st_ops_find_nolock(map->id);
> > +     if (st_ops)
> > +             hlist_del(&st_ops->node);
> > +     spin_unlock_irqrestore(&multi_st_ops_lock, flags);
> > +
> > +     bpf_struct_ops_put(kdata);
> > +}
>

