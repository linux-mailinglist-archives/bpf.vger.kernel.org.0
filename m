Return-Path: <bpf+bounces-75045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108EC6CC3A
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 05:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 812D42C575
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111AC307AF3;
	Wed, 19 Nov 2025 04:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffRcRBBf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643B3064A6
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 04:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527435; cv=none; b=SaUVJGFQQzW7cJh6XgtEmhChAIyOU0mmaQiHrnnki9m04qUI+a2yddLEZlTirvCPeho500nMOgaL3vUdgsCpTBPFtN5dzD0VKXBI8PstKWI743FnP0aQYUv8UVWmDt2/a0wdP5qgSHAC5Slo0h3wXNsw3tEINhnwXUrH7OeqRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527435; c=relaxed/simple;
	bh=zM+cdk3n/6K1TiFxzxdztRHHEX9zrAymE6s1CS6bbm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWkgvuHUST0Ex0RKRZMRddtG3g/KOboZEI5zORVLHKZM/OobB6DgCPQ1hdTMnn18uy5HeutpH6bD2tGgi8AVM9K7zC6r3RNMJxU8DhhVtQOmqsbd+wXxiXBvCJ8Swm+4Rx1NWFOfS6HePUSW9jmex4qPCnDyQXJ0gkR3c2CyVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffRcRBBf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73545723ebso1135415566b.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 20:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763527432; x=1764132232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3lw/VU5vgsHVx9RGn3oxBLnan8JZlu7OGwERgz9KPs=;
        b=ffRcRBBfozt8PEq+rNXxbPQGVy/SwgzNZ0yCfeP8d8ezaHidPNbZM+GB8r5PBgM2P4
         7USjE6PZKeqaT71c3SxBlqUmmc0wVny4cctSll7nnlZL0PgpHk/HtaBFRJks1euGupKt
         NwIST96W7UDz9TtICgqa+Y8Tt9XV2MdcubGwgWClfkbkGCREwruDuEZVbPGIERxlMUT1
         io+l4gqtkXVxP/E8kI6sNd0DuMasOFHHwqMkVh/hcU97uVzGn2Xi21yoOeMTgCJ12Lq0
         OSNt5a3+9oR6OnsIvoUZ4Ui7tU3HBzWybiUc2d9y5Gkp/WiBvs8J9HDEymXUDx8U8yNL
         v22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763527432; x=1764132232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3lw/VU5vgsHVx9RGn3oxBLnan8JZlu7OGwERgz9KPs=;
        b=iEOJQJJuxFunrEbkoNH1SM6R6w0+C/QW6LHos4Vg9YSLGpQXMcQ3XOjWnQlvTk5ruu
         2RRqex+r4lg5TZS8BTp+Gw49LsuLYY2KLlnDf4nhQw/nYm7MpQ7soDstOmXJ+sbeXp9Y
         fl8QKsyrzBHz0GzvCO0ILBXH0XHofXRRoTsM1caww7gMlNuyZTBP/4F/WjvTxkm2RAvJ
         Ip6pmpFZnQMTSbW1Pd3K6iIaohgTJAWlO6Nrv6IupWtY6QUsiptBaAkQSizGityUhQsv
         6TYcU4cPn4pCNOs1ykFCDPiEFf+HnrpMPyQWTPun1Iv1oQKLfworPAcM2dmhHoLKmt1j
         Azxw==
X-Forwarded-Encrypted: i=1; AJvYcCWehIBFnkMrGoAp6bFxgHEDjsdw7PJXP+oDsef8ZnFWPi8zEX+IGGnHdi3SN4mzqM/W238=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0k1kGPy1xsFphoGO0FUiOUWtNoh9CJ2wUbkr0nWByM3ZiI22l
	/X3kUsmPVIq3nLhCmvapNlbs0u7UGRBn/Mkpn5dUkt9N/Fx2GD/ohZ5z5Tvtd9gLI86OZM8Pwav
	1joKGMOwFmCNg1GfUR70DLgINebj/NKQ=
X-Gm-Gg: ASbGncs0bfCPKWhnj1R2jL8w7cd2ipYGNgQNHVLnbU2pDg4/xsLbQM0vL+LozI05syr
	wtC3mxaCej3IIT0FF2yk1NcbzsYoAIWay+cA2C86otZ3Rat1NtAYEFmbAGNgH7soQyGfrpbKC2t
	PzCogYA5/SPAHcmUmkoVlsZ/9d/9KTV6NIFEjFJN6istOwiLTfGP7VfKfzrlflbSX74el/DbHAx
	j66X5kxt9L6WNHs8PAWAhVikqvoC1v8ab3fA3kUlpEvHogYcNwRj33yqmnwiL1ZjQK2nHykXj7m
	wXxDW7o=
X-Google-Smtp-Source: AGHT+IHO1DqjLVXZrJJDnSWKUq2JGgdylBzO9DFBvH8ZhKXAASWo/xBZVzMQ7XDI2tAg4n7pxg7YqB/6JcDtR5J0YEo=
X-Received: by 2002:a17:906:ee87:b0:b6d:7e01:cbc5 with SMTP id
 a640c23a62f3a-b7367b9ccfcmr1977986066b.53.1763527431970; Tue, 18 Nov 2025
 20:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-5-dolinux.peng@gmail.com> <fac834d1e096215cef3e1211d329e92b2e5eb1efe2c3f06881fc051ecafd743d@mail.kernel.org>
In-Reply-To: <fac834d1e096215cef3e1211d329e92b2e5eb1efe2c3f06881fc051ecafd743d@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 19 Nov 2025 12:43:40 +0800
X-Gm-Features: AWmQ_bkLigqbWiri-FOtiVV_U5yIwFW1L5QSBc6yhbE4a7IuY1mfxGZgZNPo9CA
Message-ID: <CAErzpmssZXDx_beSbxVpNnJBM+uQEx0HMUxMLi=DUy-RkM8oAg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 4/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin@xiaomi.com, alan.maguire@oracle.com, song@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:11=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 71d464690..555703b37 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > @@ -897,44 +903,93 @@ int btf__resolve_type(const struct btf *btf, __u3=
2 type_id)
> >       return type_id;
> >  }
> >
> > -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, cons=
t char *name,
> > +                                             __s32 start_id, __s32 end=
_id)
> >  {
> > -     __u32 i, nr_types =3D btf__type_cnt(btf);
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     __s32 l, r, m;
> > +
> > +     l =3D start_id;
> > +     r =3D end_id;
> > +     while (l <=3D r) {
> > +             m =3D l + (r - l) / 2;
> > +             t =3D btf_type_by_id(btf, m);
> > +             tname =3D btf__str_by_offset(btf, t->name_off);
> > +             if (strcmp(tname, name) >=3D 0) {
>                     ^^^^^^
> Can strcmp() handle a NULL tname here? The btf__str_by_offset()
> function returns NULL when offset is out of range (line 1674 returns
> "errno =3D EINVAL, NULL"), but strcmp() requires non-NULL arguments.
>
> The original linear search code at line 971 checks "if (tname &&
> !strcmp(tname, type_name))" before calling strcmp(). Should the binary
> search path also check for NULL?

Thank you. It is unnecessary to check for a NULL type name in this context
because the btf_check_sorted function introduced in the subsequent patch
ensures that all types accessed via binary search have non-NULL names.

Furthermore, in the current patch, nr_sorted_types is always zero, meaning
the binary search path is never exercised.

>
> > +                     if (l =3D=3D r)
> > +                             return r;
> > +                     r =3D m;
> > +             } else {
> > +                     l =3D m + 1;
> > +             }
> > +     }
> > +
> > +     return btf__type_cnt(btf);
> > +}
> > +
> > +static __s32 btf_find_type_by_name_kind(const struct btf *btf, int sta=
rt_id,
> > +                                const char *type_name, __u32 kind)
> > +{
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     int err =3D -ENOENT;
> > +
> > +     if (start_id < btf->start_id) {
> > +             err =3D btf_find_type_by_name_kind(btf->base_btf, start_i=
d,
> > +                     type_name, kind);
> > +             if (err > 0)
> > +                     goto out;
> > +             start_id =3D btf->start_id;
> > +     }
> > +
> > +     if (btf->nr_sorted_types > 0) {
> > +             /* binary search */
> > +             __s32 end_id;
> > +             int idx;
> > +
> > +             end_id =3D btf->start_id + btf->nr_sorted_types - 1;
> > +             idx =3D btf_find_type_by_name_bsearch(btf, type_name, sta=
rt_id, end_id);
> > +             for (; idx <=3D end_id; idx++) {
> > +                     t =3D btf__type_by_id(btf, idx);
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (strcmp(tname, type_name))
>                             ^^^^^^
> Same question here - can tname be NULL at this point?

Ditto.

>
> > +                             goto out;
> > +                     if (kind =3D=3D -1 || btf_kind(t) =3D=3D kind)
> > +                             return idx;
> > +             }
> > +     } else {
> > +             /* linear search */
> > +             __u32 i, total;
> > +
> > +             total =3D btf__type_cnt(btf);
> > +             for (i =3D start_id; i < total; i++) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > +                             continue;
> > +                     tname =3D btf__str_by_offset(btf, t->name_off);
> > +                     if (tname && !strcmp(tname, type_name))
> > +                             return i;
> > +             }
> > +     }
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/194887=
81158

