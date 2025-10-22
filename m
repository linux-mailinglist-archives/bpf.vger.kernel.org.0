Return-Path: <bpf+bounces-71851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B217BFE391
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC0934F699E
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80287301014;
	Wed, 22 Oct 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV5qQxjG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313982FFDEB
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166212; cv=none; b=EjVN3vN9wJdJ4UYFWizZgAACzp87qHW/ErA+N0lhoIhrO9MspheH7YgMdqmg79QT4wGwceApiM32sLx1XYWSS4evZ4NCHB72kXo2XEQm6UbX3UQZRg8GZeq2OyZA0OAhcknPrDBEACP/TCP9YGwm5cTzr/ScokRAimo6N+r2eZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166212; c=relaxed/simple;
	bh=0JgR9WDTUHynjtqt1SVok1mWflkxdI3OpEFCJjXRJyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rlaiRIZ/yaC+2disMYrg+uAm3xHLWZJHuEwmTLdGzxTSdNeO1B8ujEYSYGd+2rla/jfBGQpVgrBTPSGkBZErtVUQmANFGM3MxpnzMCNBFZmUTpbecADM9YNLovws97RkbKmnDcI8aISgz+qd0CmyBjcvufD8Y9v0LMGUc/ru7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV5qQxjG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f67ba775aso83919b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761166210; x=1761771010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgUcpfhrvyt6eYMrfd8U4oPFhV6AvkhtxDSF2rQSVSI=;
        b=VV5qQxjGw2JFEZQCvGzS2/poqbV9qTsMs2kOpFchaAzpoN0v5pOGu9R/BP6RH0S08f
         wtQblirjAeAqt8gjjKkhOvF3F4rMHMiBi3yHdBGTTbljoI4o1i/hinzUIkwbNH2GkcRu
         wN2MduilJKpI2RhSMoWt6Rt5k0HVme+Lbj8cb5H848zQh1q8nHGdlKWYhq6x2t88q8qa
         a7yndMZxEuTfSoCuU8Scl2xKPHA85JJMUUKhZ4uh31Mue4MTUfV1lWgOLzcoZsufEst1
         8xUWpPIzvjUJsLmd+gVUpEBA3upvWgMNN1yZbKOevNzPbJ8h3zhl/tOtm8RrHC6EPsod
         am7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166210; x=1761771010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgUcpfhrvyt6eYMrfd8U4oPFhV6AvkhtxDSF2rQSVSI=;
        b=VcDxcmzmo8o52pCk5rJsyNmeJfoB+usdAE99l/yreO+N/GHS+Owfpim7YGRgz1xVcj
         fqDcL0OQlFTQj2o3W0eI/L8boaZlINAJ6vLFC+IUgSHzMgF2r1Oia2RkiuSOsG2Z8Ohy
         EfZuV5Iu+xoOLPyADuk6zmoIBJkOpLWsV+oj1F7z004G1QY3gnUA4t8VWfmSW8bqQYBQ
         LfTiWHFg74I+vwOGQJJwwkPHiJKklDHMmlYMDs1a5Jopxbqz8Fb1KW7Ehcbeq0Ba3g/R
         DpUbWyZtK+rhPFi1dHZlO8D4VTKCgVs4jOfUyH9jKSSYTbQqUWZRWB/w24phnmLrgYoD
         mqXw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFe9pWBHHUoZsRzUmogL1VuO3X4Wi+SVxP2YkI/W4FNMaivw6RgdWCv063SHwtzf4H8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ISLZc4WOpbyyz8XPaAFSqID0CmY0Qyq3aLTOC7zG87ofwMke
	sjLKXPhUL514ecb0Q/RV8hXLeFjWlnQVWsbT2IpR9hzkPHTSwl7/Zi5l
X-Gm-Gg: ASbGncvjz3j/rRmt2Lzg5R4HntpBj+tEk9CDD9fbJF5bJz2E/L+0+Qp3y/wgCKV0l3A
	2FNxjVhKuspiSmGfQuyhbmU8f7dpiFxHdC1ODkjMRRQCamex5CTGKMq4HruzIKVESHN78PXb7tm
	SCTUuEK3TscgmjPu9QiDuteHtAQodaGDztTvqKPyZQ2nei26jIcXJievupipJ8De0Af+ZTF6xvO
	/rpXmyQ7Kjc4TT+8r3cnLedP4zNH4XBgCpLcSpVOlEoXHq/Zu7MTuDYyc9dfy4bc73nAG1ov/YA
	SjPXhs1+wUl80F7hYMV6kYH2AJ4GkNi8cuGQqkVXfeZtgBPyjw4H47jOtWgqmCaf+hD7PHN6Wi+
	ysewvXp1D9yjDP2aOLnLFyBJzlMOAf5geDiw31t5hkVurWmNWptIWxSRoBlVdNfSR/ZCmj92f0M
	a5rjx12oTvSPem5gDmegTJXHu+lEotPsUAdB4=
X-Google-Smtp-Source: AGHT+IEV7pugFPydmKhRrO5R/SjYxtWqVbY5mI6z6oTdXgS9HtSf1+AY271CZOh4AWxrX2zJPvrYFQ==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr27481912b3a.14.1761166210420;
        Wed, 22 Oct 2025 13:50:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9e912sm161398b3a.22.2025.10.22.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:50:10 -0700 (PDT)
Message-ID: <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu	 <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Wed, 22 Oct 2025 13:50:08 -0700
In-Reply-To: <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
	 <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
	 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > This patch implements sorting of BTF types by their kind and name,
> > > enabling the use of binary search for type lookups.
> > >=20
> > > To share logic between kernel and libbpf, a new btf_sort.c file is
> > > introduced containing common sorting functionality.
> > >=20
> > > The sorting is performed during btf__dedup() when the new
> > > sort_by_kind_name option in btf_dedup_opts is enabled.
> >=20
> > Do we really need this option?  Dedup is free to rearrange btf types
> > anyway, so why not sort always?  Is execution time a concern?
>=20
> The issue is that sorting changes the layout of BTF. Many existing selfte=
sts
> rely on the current, non-sorted order for their validation checks. Introd=
ucing
> this as an optional feature first allows us to run it without immediately
> breaking the tests, giving us time to fix them incrementally.

How many tests are we talking about?
The option is an API and it stays with us forever.
If the only justification for its existence is to avoid tests
modification, I don't think that's enough.

> >=20
> > > For vmlinux and kernel module BTF, btf_check_sorted() verifies
> > > whether the types are sorted and binary search can be used.
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index c414cf37e1bd..11b05f4eb07d 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c

[...]

> > > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u=
8 kind)
> > > +{
> > > +     return find_btf_by_name_kind(btf, 1, name, kind);
> >                                          ^^^
> >                 nit: this will make it impossible to find "void" w/o a =
special case
> >                      in the find_btf_by_name_kind(), why not start from=
 0?
>=20
> Thanks. I referred to btf__find_by_name_kind in libbpf. In
> btf_find_by_name_kind,
> there is a special check for "void". Consequently, I've added a
> similar special check
> for "void" in find_btf_by_name_kind as well.

Yes, I see the special case in the find_btf_by_name_kind.
But wouldn't starting from 0 here avoid the need for special case?

[...]

> > > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > > new file mode 100644
> > > index 000000000000..2ad4a56f1c08
> > > --- /dev/null
> > > +++ b/tools/lib/bpf/btf_sort.c
> >=20
> > [...]
> >=20
> > > +/*
> > > + * Sort BTF types by kind and name in ascending order, placing named=
 types
> > > + * before anonymous ones.
> > > + */
> > > +int btf_compare_type_kinds_names(const void *a, const void *b, void =
*priv)
> > > +{
> > > +     struct btf *btf =3D (struct btf *)priv;
> > > +     struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > > +     struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > > +     const char *na, *nb;
> > > +     int ka, kb;
> > > +
> > > +     /* ta w/o name is greater than tb */
> > > +     if (!ta->name_off && tb->name_off)
> > > +             return 1;
> > > +     /* tb w/o name is smaller than ta */
> > > +     if (ta->name_off && !tb->name_off)
> > > +             return -1;
> > > +
> > > +     ka =3D btf_kind(ta);
> > > +     kb =3D btf_kind(tb);
> > > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > > +
> > > +     return cmp_btf_kind_name(ka, na, kb, nb);
> >=20
> > If both types are anonymous and have the same kind, this will lead to
> > strcmp(NULL, NULL). On kernel side that would lead to null pointer
> > dereference.
>=20
> Thanks, I've confirmed that for anonymous types, name_off is 0,
> so btf__str_by_offset returns a pointer to btf->strs_data (which
> contains a '\0' at index 0) rather than NULL. However, when name_off
> is invalid, btf__str_by_offset does return NULL. Using str_is_empty
> will correctly handle both scenarios. Unnamed types of the same kind
> shall be considered equal. I will fix it in the next version.

I see, thank you for explaining.
Checking the usage of kernel/bpf/btf.c:btf_name_valid_identifier(),
it looks like kernel validates name_off for all types.
So, your implementation should be fine.

[...]

