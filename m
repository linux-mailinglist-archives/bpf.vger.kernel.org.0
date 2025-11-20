Return-Path: <bpf+bounces-75142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272EC72984
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 08:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB414E9DCA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F4305066;
	Thu, 20 Nov 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfwajYnG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31443043BC
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623525; cv=none; b=iC0XuWPHKaCd18LfI2Tqvq7hoG2v5DLvt3Iraks/eU+C9W65NIMgW2SCThp91fm3dJCBp2b32Lrp90KWJToZ/Ahbed+S4YwXfc8vMy2pRx/WNx7OAaLziq1+pGZ7WeuqNL3vlqPPAC6RTA2SlfnyD6FMdm3B17p17WbLlyQjYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623525; c=relaxed/simple;
	bh=MaRCIF5YBKAQMw1gPnSn8ozRFGCePBOqjWpcz33+Guw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSytYt+PjUFe7C5yrDeKG7X8RbyjWzOVPoH3a7xv5a3sY6CYAA/IIla3H1HkAmGES9LHBH7tm1sl+VUKQqfrGJuZvB/D97WZtmLiYpjFFBCFHj7Y53U2+Mf/rVWvcgwLPYuOGINWBNDak8J0F0qazmM0LmPRRgFHcwP55jfvvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfwajYnG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso693958a12.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 23:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763623522; x=1764228322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/8XixJ6UVx+zVV4IHOMydRRMurlP5Z4cftG8mS99eg=;
        b=TfwajYnGDmq7O2gVuvZNyT0kAxeMK2/T9/rjF3/7/2/O2s7p3qPDdrHEfquP9yUEDG
         Gx2dvz2yxZUnPrtnPzxwYhFxFmnJZhU3nbgpmefZ9G+ZlxPCTk3zmISdS+CPc5J0Eca2
         bmgCt15kRGdvfKtsBMJBPTrJ6vfNQwRPdinp4nUm6cCZ0RZBL8ZSHZvnpNcc2vB9lL6T
         IHhtSRUKPnAC1P5ZfKT0nk7EGBF9x4yUdJ7twDAzJKAaVRD1MW5vUifOKnGUiSrfoyLQ
         0KOyBBa2lxAO88Fc2C+eM9YY0dmDtg70Af4Q7UbmBmq9RW7MfaPv/Y1py6QKC6x9t3fj
         sWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763623522; x=1764228322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/8XixJ6UVx+zVV4IHOMydRRMurlP5Z4cftG8mS99eg=;
        b=Y6OM+ntkENomHgZNY+vVtREHN2pILJJTvJy9qeod2/BAz4Rb4O1jrZRY/z+mxQyzRZ
         1x3nWAAUzxpVdDhVVNYtLEn7yqhSxaKIgjRhcq3pPiBuvMYGUrJ1GGmyUQ77VRZHSF1z
         Dac6hhX8ZXdGn3HkGuoouXknVhHMQibodmn3EiAzDybRZK5fe/4VYr7PQPc8h/foiSCB
         9z1wkZ0h8hnV/94GyYyHEuHS29ZYczc9J/CEYHhej7+XYfz+hQb8Dar1ZkwMfZU0lF3O
         Ye/nw7fFlfGhswAzgiCzGEtsy4470kJBMNoHcq/M/wTAYH7v33Q2L1qxpR/qPCzDOKMZ
         rH9g==
X-Forwarded-Encrypted: i=1; AJvYcCVp8ralo7XUzDegELQSVcsleg/vkT7GVg3g1dc/hfJElJDbeC8quwx9Jb5+JUgI5AP0RiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzumgjdp1TAkHT9ntCkPGrJOTDphm8Sp9HWlAQ/FNe5EH5L8Jhh
	q+NpNGu/Uca5DYm1ojoyWcMDHOQZXjK2tqwooc6HIkY3ZvQZdkY+HbBc3Aw4Ysj+QQ+rpyfnj9q
	Fsz86KfD+Lv6UOoR9AZFE1mqghJEGHw8=
X-Gm-Gg: ASbGncuWoZCi4ythHBzmvkh27eNKAugnku3hoZLd0/5Dz3uf4eaL7EpgedqjmYLmp2h
	9Ij0ZGuqu4LAw4se5nkJppidiBBN6tmd4WoPA0W7Fb6x1p3c5TTd0NdKfW4VTJbXMBGjIwZR8t4
	t8AInudPGxVus9+KRlyU8YvnpFBJXCrE+veDN3Evk6acA1DG5eHo3t2IPJAAh0/U40CHCC3IN8N
	LeIWCKgrlPd0VDMGRsx/Ek4k3NvAAWiYhxjSU3klyVS8bDUnA8eTfpnGiwQ9uwLqSfZpsAW
X-Google-Smtp-Source: AGHT+IGUzauL6hC7hU+6X1AMlcPhQENASpRpnl0UlBqk66b8+n3mkXUZ2VSwuCsUQNgxpbnONqo90YdpHyPhg2Vl634=
X-Received: by 2002:a17:907:7f94:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b76588b1fecmr130899066b.36.1763623521848; Wed, 19 Nov 2025
 23:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
In-Reply-To: <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 20 Nov 2025 15:25:10 +0800
X-Gm-Features: AWmQ_bnctnPndqpN8pPZ1I65U4wn-5Zar1laTAMB_QN8Ka7zEzVzDhMwqY3OWrE
Message-ID: <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:50=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 18, 2025 at 7:21=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This patch adds validation to verify BTF type name sorting, enabling
> > binary search optimization for lookups.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 1d19d95da1d0..d872abff42e1 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -903,6 +903,64 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
> >         return type_id;
> >  }
> >
> > +/* Anonymous types (with empty names) are considered greater than name=
d types
> > + * and are sorted after them. Two anonymous types are considered equal=
. Named
> > + * types are compared lexicographically.
> > + */
> > +static int btf_compare_type_names(const void *a, const void *b, void *=
priv)
> > +{
> > +       struct btf *btf =3D (struct btf *)priv;
> > +       struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > +       struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > +       const char *na, *nb;
> > +       bool anon_a, anon_b;
> > +
> > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > +       anon_a =3D str_is_empty(na);
> > +       anon_b =3D str_is_empty(nb);
> > +
> > +       if (anon_a && !anon_b)
> > +               return 1;
> > +       if (!anon_a && anon_b)
> > +               return -1;
> > +       if (anon_a && anon_b)
> > +               return 0;
>
> any reason to hard-code that anonymous types should come *after* named
> ones? That requires custom comparison logic here and resolve_btfids,
> instead of just relying on btf__str_by_offset() returning valid empty
> string for name_off =3D=3D 0 and then sorting anon types before named
> ones, following normal lexicographical sorting rules?

Thanks. I found that some kernel functions like btf_find_next_decl_tag,
bpf_core_add_cands, find_bpffs_btf_enums, and find_btf_percpu_datasec
still use linear search. Putting named types first would also help here, as
it allows anonymous types to be skipped naturally during the search.
Some of them could be refactored to use btf_find_by_name_kind, but some
would not be appropriate, such as btf_find_next_decl_tag,
bpf_core_add_cands,find_btf_percpu_datasec.

Additionally, in the linear search branch, I saw there is a NULL check for
the name returned by btf__name_by_offset. This suggests that checking
name_off =3D=3D 0 alone may not be sufficient to identify an anonymous type=
,
which is why I used str_is_empty for a more robust check.

>
> [...]

