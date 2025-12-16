Return-Path: <bpf+bounces-76771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC91CC533A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD9B3016CFD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614C313541;
	Tue, 16 Dec 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTcO7/30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBB23A562
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920307; cv=none; b=GFlC/UKD+32nPCke/WzDZzCzar5DdXa6/pAwxzzBt+j56mDE08nNvp7/JSgAuPEylO00vYaqNEHwBTgH2/19igeihL46oqq4zxcp2p86S7OKOvRctlTVkU3YNQpUAW6Z3BWuA8nJDCMKxOneAKkBNpjd8LY6IyQNxIzV3aI+hCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920307; c=relaxed/simple;
	bh=KJkB6gBSdbXyjv9CnMBG0ujfKQGyrkxxiVE0wJCrlaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0XuSXc9poY5aBp/lXl3JlFVIByAb2XGOTrN/1+NFtSsIcAT4YXQ1l0Y7jT5irCmatFpevF1UU3sOsDPUpTzg7jhUAq4ZFeSo4/IxjdIMNdfeDXrQTyh+/mh7taLmhi1OTeF0SjluNBgpIAeHi/YlxmNv+owcwzhR2h3zI2/a3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTcO7/30; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so4203894b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920305; x=1766525105; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+fgU8yAOKDodlvbOzyL0bNanv5w+dN6b9YogBsB4DM=;
        b=ZTcO7/30RnP2aON+s9ex20ed4BTbd7AbE4sWyVfh3xOrStdtdayiYGxiHVwATAiSP8
         BU5JEmlX64r/zCjoapARDJkZHoSUehmpwGb8B+ia5lw7a82WVmbwbtaVJRu8Zka81DCM
         OV/Xfyy3cKJvQsVCL612GiAxsN8o4LwOI7398kbgt4iJdBuV8FHYNHRouj3qv8bPx+In
         Dt11PjIM28JY0Y0XPz4FEpzh0h6Nn03ljNV+2eRUFkJ4GDMzPi5//tKQdnI5zTnv0xl5
         pFgFQxgoucfqFL6ERk1BQ8nZf2SaaM4hDAwLUuIQl4UiNdOC23VGB+lxYO9qyHp93OLx
         3fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920305; x=1766525105;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+fgU8yAOKDodlvbOzyL0bNanv5w+dN6b9YogBsB4DM=;
        b=iugnxaEYZIZdzH/SqE5GEJdBKjapWT4c/l6q7QCJix4DYOEjJGagXyNyDaNCphV38i
         tfYwoa8/O4RhuKSGbE/oKKFklRq8TdXcUQkS4cGhDGkOypLuH+Z7og0N3zQFiN7+IbOq
         UHOCI86UTktxoNUw1ooz32HsX8UhHbXTomwlWJ4L7+Wi4Jc/QkywFK8ni1mpsQylxa6O
         8whGNs97jyk4Bt491iSh1cejWd+Cyc4d4NWN88lDFsRSflNz8k21svr6h5Sj28MMuRk2
         SHLTkUIf1aZwxZrgygjCjSRYSpv6j0GwOMS5lwrJg6P72Dh2MepdI5k2CQm9UdHpqMfz
         4VkA==
X-Forwarded-Encrypted: i=1; AJvYcCVJBhZgKqLhc9v3A40yywONg70uYrqCcSUiBuXMZLzS9rKapdWLddqHJ4vfpFcwn1EYM84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkrUIikppZSuZI5HzUsXQpEgF2LF95rpdLIbEXqTZnEnxUDCo
	fBDhA2M3Chg+3whWtg6TE0T+i1ZdI35E4yisT0qGDJSMsyfndFBp+iVz
X-Gm-Gg: AY/fxX6eoZP5kPMOyYR8PUZrvVw739ATk3Qz0X6tE7VO220sOGb3xEeh+WqUFVU2EU1
	wqNwAdh2hP3bBhILdv3o3R3SdAytihJzEbUHKt5Mw7Ikdnx+iTS+J/mqQ5q15Vt8SLTHTRon6m1
	aGZecIRiEMK3iWvXzQqrztq6E9EFyZf7EWKoCOHDTUpi0qflux5FH7wjJnppQxC7t362h1aULQM
	HRDacFNfUCHnSsnavCCQyGbSN0qIkhYE01gRTIS5Pz3HH4Byoq4uCUTHHuCnYw7qRS8BTFqLjb2
	xHzgcaDX3HkEaXz9uvJICJT5NmfjA+xx+eLKeU69CNzim25EZ/DD22igPIanGkXQSir/mHRk+2r
	o3OvIAOarM1x+xJBC4xlaqXMCktghZKNsdEzNO2BDWMdrv8RJgvQkWNT/jVH8vkQ3J4JMUuOvJT
	PMVVl4Mpge
X-Google-Smtp-Source: AGHT+IEpWg7yNPvyj30E/Kr/ueDF1YrXlqf+wsqamSsT7jCEGBokncPH/BdDic5/vNTEITz0OLA/VA==
X-Received: by 2002:a05:6a21:99a7:b0:35f:4e9d:d28b with SMTP id adf61e73a8af0-369adebe02fmr17497087637.18.1765920304866;
        Tue, 16 Dec 2025 13:25:04 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcbc0c0acbsm475048b3a.60.2025.12.16.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 13:25:04 -0800 (PST)
Message-ID: <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF
 with kind layout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 13:25:01 -0800
In-Reply-To: <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-7-alan.maguire@oracle.com>
	 <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
	 <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 13:21 -0800, Andrii Nakryiko wrote:
> On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> >=20
> > If strict kind layout checks are the goal, would it make sense to
> > check sizes declared in kind_layout for known types?
> >=20
> > [...]
> >=20
> > > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier=
_env *env,
> > >               return -EINVAL;
> > >       }
> > >=20
> > > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > +                              env->log_type_id, t->name_off);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> > >                                env->log_type_id, BTF_INFO_KIND(t->inf=
o));
> > >               return -EINVAL;
> > >       }
> > >=20
> > > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > > -                              env->log_type_id, t->name_off);
> > > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_lay=
out &&
> > > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_layo=
ut)) <
> > > +          env->btf->hdr.kind_layout_len) {
> > > +             btf_verifier_log(env, "[%u] unknown but required kind %=
u",
> > > +                              env->log_type_id,
> > > +                              BTF_INFO_KIND(t->info));
> > >               return -EINVAL;
> > > +     } else {
> > > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > > +                     btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > +                                      env->log_type_id, BTF_INFO_KIN=
D(t->info));
> > > +                     return -EINVAL;
> > > +             }
> > > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, t, m=
eta_left);
> > > +             if (var_meta_size < 0)
> > > +                     return var_meta_size;
> > >       }
> > >=20
> > > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left=
);
> > > -     if (var_meta_size < 0)
> > > -             return var_meta_size;
> > > -
> > >       meta_left -=3D var_meta_size;
> >=20
> > It appears that a smaller change here would achieve same results:
> >=20
> >     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> >     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / si=
zeof(struct btf_kind_layout);
> >     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
> >                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> >                      btf_verifier_log(env, "[%u] Invalid kind:%u",
> >                                       env->log_type_id, BTF_INFO_KIND(t=
->info));
> >                      return -EINVAL;
> >              }
> >=20
> >     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> >     +                btf_verifier_log(env, "[%u] unknown but required k=
ind %u",
> >     +                                 env->log_type_id,
> >     +                                 BTF_INFO_KIND(t->info));
> >     +        }
> >     +
> >              if (!btf_name_offset_valid(env->btf, t->name_off)) {
> >                      btf_verifier_log(env, "[%u] Invalid name_offset:%u=
",
> >                                       env->log_type_id, t->name_off);
> >=20
> > wdyt?
> >=20
> > But tbh, the "unknown but required kind" message seems unnecessary,
> >=20
>=20
> Hm.. Do I understand that this patch will actually allow uploading BTF
> with some kinds that are unknown to the kernel? I don't think we
> should allow this. If the kernel sees a kind that it knows nothing
> about, it should reject the BTF. libbpf will sanitize such BTF so that
> the host kernel never sees unknown/unsupported BTF kind.
>=20
> I think doing layout info validation is a good thing, I'd keep it, but
> having layout information is not a substitute for kernel knowing full
> semantics of the kind. Let's not relax kernel-side validation for BTF.

I don't think this patch relaxes anything.
It just generates a different error message for kinds that are unknown
to kernel and:
- described in the layout info
- not described in the layout info.
(Personally, I don't think that this differentiation is necessary).

Otherwise the patch does basic sanity checks for layout section itself.

