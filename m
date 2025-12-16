Return-Path: <bpf+bounces-76777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF9CC54ED
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99537300CE1E
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38861326946;
	Tue, 16 Dec 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjjtwmn3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1B279907
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923000; cv=none; b=fUFJvbkePGjtD8gGhRt3GqFvTSM9dMgDHWcby7WKH7cUy10WRX0aaMDT4sFm4FyErOCyaRONpanbuLgOLrnAg4VStTgfoYmR/ii/nPMp2nTEBFsYgpxejg/lXhDKqM81RZTQGOA5QJ75JyeQ/w9qSMrFDaqltkRwXOCXi8I+Y1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923000; c=relaxed/simple;
	bh=VnD05L81E7UPJUQIXZqI8i7Y0uB5J3FzlEQYTU4586U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9IC1XvyFeExbAxndhU4nY/eoHhdE5acdTWi/rHYNtZHm9kyCmyMAx4ywVxsVZawQXosv0juXUe7v54xoLE3CcY1YmA/J8Z3L1787l+AcGuGFgyGyVlQXPdLqK2cUlH5f8hBtt/pmrDw+M4NuX0HBdG6Exeopc9DI5xkrjYwGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fjjtwmn3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a12ed4d205so16050845ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765922998; x=1766527798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z66AwqDtODxBjHY9XlX+LsynBwtoVi3CGvh3SOUtMY=;
        b=Fjjtwmn3KIl3s3LsPel/ChraowpGMr2PcxaZcjAJMAsgRScJPKS89kzW6ipRnNgJFD
         3SiMUb9jiJgpepgH7NkJHQxDpvacVEcrCe8oivhByemd87jxV2Z/LJ3bmyvCbL4026B6
         rUTU42cb+6+wADoipvAIag9WAeVtJsLGC/b8JPqXSuOT+MFAZaIedFXWP1ri7CUzR9kP
         /jhitgJtDaDt2gtOWJtnRbFQb74G1W8bIFR8PeZ26Cz5UmKo1PnRK+BQQAanjXvwLzb1
         0mLrXPoVyaWwRqD4iJz/BMyFcBFSgx1V1WGDtCUcECuhcgsja1iY3Ou2C/zn40JPVteu
         pmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765922998; x=1766527798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Z66AwqDtODxBjHY9XlX+LsynBwtoVi3CGvh3SOUtMY=;
        b=eswJ4WMUeNHM7ZJnGIqcKXPeN5wb4jRBoBJjvesWrcQ/blgPNtlYWomcISCsIFAxdm
         8uDkAo9aDlSLZVAHqpiO3hRPZZLPtAA+YyQhHMhiU9r4htQgBRh0e4VIXzfZnr9oUFB9
         0HSAO7q/Mvy3G83wCKj9ZkVjHCjqUb2nAz8pzUnKUv47HLzG/lue1Ii31+XrAxe+AMS/
         Rb5v0KGaeA7Ytwb38KbsPK5zVXp74jp5qd8wEXjdQu0GwNCn4avxSi7pzAKLX5DjBCOx
         OO3Of467PrBvxCuzAJReZ1s+ZWc+HM3q6E3VU3DETuuM6pr/D/LAimZrWz0epT7iV1q4
         TMMg==
X-Forwarded-Encrypted: i=1; AJvYcCUIU7HwZSi/vU0TxWoU6Bts8m37APuFU8s/28MTo5JFksmTPIFeBsNC6Gni/Zms0z0o+wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysI6mBo4TQkCMj1vKeq07SyaBORUxjAYwJxth2e6eAdNh4g+oR
	cltlBICIr2NecEiA7w7qUCyLdI6ySdi6bS/CgD4I5iuwyFOsuEllwsQu2m1ND/TUR9wRdT/59SR
	ulwWhtH2MEzznC9rcKx6w38idBehYc/Y=
X-Gm-Gg: AY/fxX7HdJb9lBqJ736T4tGXMj0b7QOWfw2zbJYun+tzfvkmplbU5zoBOwuKdOt15pA
	FRgOiTXIYPJqdMbvasi2KP1T1UN4/aGg16eYjTRBk/sx7bOWSf7FcDIgJjmKNYUhCkHcBt3o4z5
	XGh+CjY6u5zo77PAFeeI8E570O5ljU/IoZkRZiv69WrsSYRcqh+UqpmOniYfPb23uUxrZDbvkZy
	z+wVmrUK+qO0VdyrB2NYBFI+KoWJwHgtQSKS9KanPuAFj39hLtcMoJV5bUnmWaiChwXJnReHWPm
	fjbb+Wyk234=
X-Google-Smtp-Source: AGHT+IHi97YN5wLpUNbCwo9EoKx/q7L6WfwzQ0F705p18iUPsSCcPfkk/AzYKbDG7XVtdlbf/RhatBt4wl5l0U0dYZ4=
X-Received: by 2002:a17:902:db08:b0:2a0:da38:96d8 with SMTP id
 d9443c01a7336-2a0da3897afmr104177705ad.25.1765922998504; Tue, 16 Dec 2025
 14:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-7-alan.maguire@oracle.com> <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
 <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com> <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
In-Reply-To: <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 14:09:45 -0800
X-Gm-Features: AQt7F2roT4Lkplu1fE_gn3gnMwMoz9b3-EETCt9iEER0_bmqiKFM8FKDObcp37U
Message-ID: <CAEf4Bza6=yBpM0QNrFt4MaBHNTCVxvMrE1Sj+eqHGbKh0CcBJQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF with
 kind layout
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-12-16 at 13:21 -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > >
> > > If strict kind layout checks are the goal, would it make sense to
> > > check sizes declared in kind_layout for known types?
> > >
> > > [...]
> > >
> > > > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifi=
er_env *env,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > > > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > > +                              env->log_type_id, t->name_off);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > >                                env->log_type_id, BTF_INFO_KIND(t->i=
nfo));
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > > -                              env->log_type_id, t->name_off);
> > > > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_l=
ayout &&
> > > > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_la=
yout)) <
> > > > +          env->btf->hdr.kind_layout_len) {
> > > > +             btf_verifier_log(env, "[%u] unknown but required kind=
 %u",
> > > > +                              env->log_type_id,
> > > > +                              BTF_INFO_KIND(t->info));
> > > >               return -EINVAL;
> > > > +     } else {
> > > > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > > > +                     btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > > +                                      env->log_type_id, BTF_INFO_K=
IND(t->info));
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, t,=
 meta_left);
> > > > +             if (var_meta_size < 0)
> > > > +                     return var_meta_size;
> > > >       }
> > > >
> > > > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_le=
ft);
> > > > -     if (var_meta_size < 0)
> > > > -             return var_meta_size;
> > > > -
> > > >       meta_left -=3D var_meta_size;
> > >
> > > It appears that a smaller change here would achieve same results:
> > >
> > >     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > >     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / =
sizeof(struct btf_kind_layout);
> > >     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
> > >                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > >                      btf_verifier_log(env, "[%u] Invalid kind:%u",
> > >                                       env->log_type_id, BTF_INFO_KIND=
(t->info));
> > >                      return -EINVAL;
> > >              }
> > >
> > >     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > >     +                btf_verifier_log(env, "[%u] unknown but required=
 kind %u",
> > >     +                                 env->log_type_id,
> > >     +                                 BTF_INFO_KIND(t->info));

hm... did you mean to have return -EINVAL here? Then it wouldn't let
through anything that's not known to verifier.

> > >     +        }
> > >     +
> > >              if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > >                      btf_verifier_log(env, "[%u] Invalid name_offset:=
%u",
> > >                                       env->log_type_id, t->name_off);
> > >
> > > wdyt?
> > >
> > > But tbh, the "unknown but required kind" message seems unnecessary,
> > >
> >
> > Hm.. Do I understand that this patch will actually allow uploading BTF
> > with some kinds that are unknown to the kernel? I don't think we
> > should allow this. If the kernel sees a kind that it knows nothing
> > about, it should reject the BTF. libbpf will sanitize such BTF so that
> > the host kernel never sees unknown/unsupported BTF kind.
> >
> > I think doing layout info validation is a good thing, I'd keep it, but
> > having layout information is not a substitute for kernel knowing full
> > semantics of the kind. Let's not relax kernel-side validation for BTF.
>
> I don't think this patch relaxes anything.

See above, I got confused by your proposed refactoring that does
change the behavior (probably missed that return -EINVAL, though).

> It just generates a different error message for kinds that are unknown
> to kernel and:
> - described in the layout info
> - not described in the layout info.
> (Personally, I don't think that this differentiation is necessary).

agreed, there is little point. It's just an unknown kind to the kernel

>
> Otherwise the patch does basic sanity checks for layout section itself.

