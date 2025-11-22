Return-Path: <bpf+bounces-75294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1033C7C94A
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 08:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14C14354B32
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC52C026F;
	Sat, 22 Nov 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHJeUcB1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669936D4E3
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763796009; cv=none; b=gTz4qwbgv9fLzF2cE1rRyFnlDSNyfWb+eEfoZ5+DB0Eyjj0qypCXOKUtNyZ4tNBtrdlScHw24EkGM1Z+rqsR3zP9dQgxYYUJUYvl+HWKDw2zU39x1IRV3i9MlC0iVZhD1CjtCZgnOSUdirC575Ube0sONW2BxJxU6nDMf74ftYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763796009; c=relaxed/simple;
	bh=ojyVTE1JlxYwmuKlee1qXGkyRS6Sevi15lshX37yUoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1APgudnVDAQlx49d7MTQtVKTQV7zlTa+3J4qYcVrJITpmTXYz9e42ND1H/xu8YueS6qYLS4BaYBB8ONS2QRqwaWm84Gg/qIUSs6kpEvF3nbGIfNgt9A3GbPAy1n+ABTPoiHhs6Y8Hu6iHAp1TxP/zmsezVHLjap0EfN/WMKFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHJeUcB1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7633027cb2so482306566b.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763796005; x=1764400805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdOu6SdQiLkCAUB4kYi9hNOeuenADEakXoh/erTO6iw=;
        b=DHJeUcB19h6lgV4ouQQ6DBxht+I7iKIq4oQ5Fb0wfBZ6FWV9gcOp1qH9yk3obspWi1
         n9mebDwE1yG5e7oOAAmEPs6FKs4SInbmqYxLJHgDjlJNP892/bWcLEoI773ViQoFVgRa
         moKt2vRYP1JqVtWQJAcnOs5KgJW4qn7xdnsmaDur/PN7KqD/CD1GOr5xT9fUXejUd1Is
         fW++CcyzW/2iK08/SLseHaf4gaDNxiLPM7nrJyRDq2FPUgnN9i+snXZOSUMfSuFhgF7a
         ajI4zMOSOzFqGbnXzFodezLzfe4xPQFh74Ydg8foHer1dp5cwVXXb6ykFJz0NQoJmTus
         kAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763796005; x=1764400805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdOu6SdQiLkCAUB4kYi9hNOeuenADEakXoh/erTO6iw=;
        b=ELCHk4pXfoUvlVx0/+5WlVib7hRMaC5EPJeNlsEGHq0XA2vdTofW9fTs1SuHZROv2j
         qvmgcTyGl6Ydvp3w5gsOPSwt5cNkTo1em3028I867+q19LchAveEYc36C+QIzBQGEkTM
         5hmJt0AqqvtvNFPJpGAeLgxMYt5dRNkv4LUmymGqmnDhzgfO3P4fqD9dtwIiRsl461zB
         B6Omb6FjjT/ufLofxTQcIR+66BFiXFMDMc+mjHVNJFQ3xHaBPtUR0ySPAfaZcVh5K9Vk
         Viz5g+1vtSrYKiU1UxdsIUIQkn9x5nTYnt5TzQQWo5p1TB8YDqBMpseBx9+9iBLQrip6
         SPjw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8HCWH1TECA4IVlHByiIaQBZgkuzIv0jZ2CtVGV+Yg50Qo/PPmjfDDPRXJ2LBjfqaiCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrJYWiFkrcBrizd1sok9IkySbkhvqz1PN4NUjEYQo/lHNQdKn
	eCzJ+bGGfbbCkksHiFRIYo8vwASSH6q66C8Z3vzZ4SzdygnmduDX4z1CaDX8fa+NDyBYoAtbf3m
	GEXtXBmfBcIpEszYx4dY1IH+wIMpm+Sk=
X-Gm-Gg: ASbGncvvm9B/Xp8x32LwBW8PuUDk1S8oiaqyNA//1W4fT5VJzThM+F+7mYVOI3dyhm1
	BwiGxVsAnAXpN8OgL1inJX+7FrlFNzcCixdwRVRaNcAXx4k8jyNdduq0/0Y826iMXfUhQTnCaKm
	IwoQl19Ec6PveisHArWP7t8ZD5RYQHbEJ/IyBlDdk3K0Dq5nnQCs/0A8VMmZ2XRHf715o/OQrQE
	gCHi5jMe/blgZoXdxbvTSbG/KL95be3i8E+/v2R1i1Nkam4BeLAfQqqgvlkdC6B2nSg1Ua6SPHw
	PqHWRQw=
X-Google-Smtp-Source: AGHT+IGV+pVvPgk1FPDfm4LwotYPK5Gs6JE9vCWVTtoPVc7GTI85JyemfVORN/jHIulJuH8mnjgvrUzFm6KoUzQXNC4=
X-Received: by 2002:a17:907:6e9e:b0:b73:6d56:7459 with SMTP id
 a640c23a62f3a-b7671705640mr538231866b.38.1763796005043; Fri, 21 Nov 2025
 23:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com> <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
In-Reply-To: <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 22 Nov 2025 15:19:53 +0800
X-Gm-Features: AWmQ_bmLdOGlthGsGScauVNz0jUorRKop5GU4fCZd2IJS1eLqypETJnbYPkRBVo
Message-ID: <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 3:07=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
> > On Thu, Nov 20, 2025 at 3:50=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > From: Donglin Peng <pengdonglin@xiaomi.com>
> > > >
> > > > This patch adds validation to verify BTF type name sorting, enablin=
g
> > > > binary search optimization for lookups.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Song Liu <song@kernel.org>
> > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c | 59 +++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 59 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index 1d19d95da1d0..d872abff42e1 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, _=
_u32 type_id)
> > > >         return type_id;
> > > >  }
> > > >
> > > > +/* Anonymous types (with empty names) are considered greater than =
named types
> > > > + * and are sorted after them. Two anonymous types are considered e=
qual. Named
> > > > + * types are compared lexicographically.
> > > > + */
> > > > +static int btf_compare_type_names(const void *a, const void *b, vo=
id *priv)
> > > > +{
> > > > +       struct btf *btf =3D (struct btf *)priv;
> > > > +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > > > +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > > > +       const char *na, *nb;
> > > > +       bool anon_a, anon_b;
> > > > +
> > > > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > > > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > > > +       anon_a =3D str_is_empty(na);
> > > > +       anon_b =3D str_is_empty(nb);
> > > > +
> > > > +       if (anon_a && !anon_b)
> > > > +               return 1;
> > > > +       if (!anon_a && anon_b)
> > > > +               return -1;
> > > > +       if (anon_a && anon_b)
> > > > +               return 0;
> > >
> > > any reason to hard-code that anonymous types should come *after* name=
d
> > > ones? That requires custom comparison logic here and resolve_btfids,
> > > instead of just relying on btf__str_by_offset() returning valid empty
> > > string for name_off =3D=3D 0 and then sorting anon types before named
> > > ones, following normal lexicographical sorting rules?
> >
> > Thanks. I found that some kernel functions like btf_find_next_decl_tag,
> > bpf_core_add_cands, find_bpffs_btf_enums, and find_btf_percpu_datasec
> > still use linear search.
>
> - btf_find_next_decl_tag() - this function is called from:
>   - btf_find_decl_tag_value(), here whole scan over all BTF types is
>     guaranteed to happen (because btf_find_next_decl_tag() is called
>     twice);
>   - btf_prepare_func_args(), here again whole scan is guaranteed to
>     happen, because of the while loop starting from id =3D=3D 0.

Right.

> - bpf_core_add_cands() this function is called from
>   bpf_core_find_cands(), where it does a linear scan over all types in
>   kernel BTF and then a linear scan over all types in module BTFs.
>   (Because of how targ_start_id parameter is passed).

Right.

> - find_bpffs_btf_enums() - this function does a linear scan over all
>   types in module BTFs.

I think putting names ahead is helpful here, because there is a check
(info->cmd_t && info->map_t && info->prog_t && info->attach_t) to
return early. but I think it can be converted to use btf_find_by_name_kind.

> - find_btf_percpu_datasec() - this function looks for a DATASEC with
>   name ".data..percpu" and returns as soon as the match is found.
>
> Of the 4 functions above only find_btf_percpu_datasec() will return
> early if BTF type with specified name is found. And it can be
> converted to use btf_find_by_name_kind().

Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=E2=80=
=99t use
btf_find_by_name_kind here because the search scope differs. For
a module BTF, find_btf_percpu_datasec only searches within the
module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
searching the base BTF first. Thus, placing named types ahead is
more effective here. Besides, I found that the '.data..percpu' named
type will be placed at [1] for vmlinux BTF because the prefix '.' is
smaller than any letter, so the linear search only requires one loop to
locate it. However, if we put named types at the end, it will need more
than 60,000 loops..

>
> So, it appears that there should not be any performance penalty
> (compared to current state of affairs) if anonymous types are put in
> front. Wdyt?
>
> > Putting named types first would also help here, as
> > it allows anonymous types to be skipped naturally during the search.
> > Some of them could be refactored to use btf_find_by_name_kind, but some
> > would not be appropriate, such as btf_find_next_decl_tag,
> > bpf_core_add_cands,find_btf_percpu_datasec.
>
> Did you observe any performance issue if anonymous types are put in
> the front?

No, I have not done such a test, but based on the above analysis, the
improvement
mainly comes from find_bpffs_btf_enums and find_btf_percpu_datasec.

>
> > Additionally, in the linear search branch, I saw there is a NULL check =
for
> > the name returned by btf__name_by_offset. This suggests that checking
> > name_off =3D=3D 0 alone may not be sufficient to identify an anonymous =
type,
> > which is why I used str_is_empty for a more robust check.
> >
> > >
> > > [...]

