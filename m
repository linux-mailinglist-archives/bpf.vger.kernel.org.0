Return-Path: <bpf+bounces-73554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FAC33A00
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268604646A9
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7EE253F05;
	Wed,  5 Nov 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMB418Xi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EE24EAB1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305647; cv=none; b=r45POmkx0/hUnvwJT+oOs2adawXPMdwi39giG7qySZJ9MC0nK3EU/0afyuUtA9UL1T1BF2KRaaHiUi6gap9fBNF+y2mNY02x8RIDslgzfqKP40JGsX9aVEBvQmVcKdTitwyUbqjGN3QNSvHerPMxMnnmXf79wAdNpVZ1QWbk7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305647; c=relaxed/simple;
	bh=biFCJDxIdAd4WXpWTz+/Y0uPv9zYrIYaHXJTaILgjuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRts4ggKqNs4Ek5CZs1jiTr5cATfAkYnr2oMFvb+xp75B429Ei5UXZWoHR1ly2LiDxqJV4wvIMr9x9PJTZDFwDALB5VpmpO2cOYaFyP1/Wrrew1z6RpD7jMcF9pqP8zbF9zorgh9D67kNDmdu2qNml2UholeuDjR5+a7BZf7yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMB418Xi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340564186e0so5196773a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305645; x=1762910445; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JR8XKWhW477K3AI9gzmTWA1Kwr0yWwWDT9BoEQlqtU=;
        b=TMB418Xi83u7Fbi0k2JZzlLdYnDum4PxB2wwdYWh/d+Q7+PsvPsd6OgOiTKScY7P+n
         Fbx36f43zTRblHtAsUw32hyLKoP70RefJdZ2sbRrFU/8qn0GxS2Rp07Tshf9t5ND2SxX
         Vrpb5vqKV6iDsM/GYMaLVye9Ps+jPdJTthWwtoDM2JJPqqQoZrQhYll5zYGa1vriWF8p
         PAFUmGm+wl3CEhL+3zg83Wb72u+hKgR1zaom+9WJBmvG8USdX0FKpEHjrnZXo8plWyRY
         XyYHauDFtAEu/lz/pinF6Vd1C1GUdPQUmkRje/foeQwuyF595YHPS03JZmmUd1lZ4W/K
         1H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305645; x=1762910445;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JR8XKWhW477K3AI9gzmTWA1Kwr0yWwWDT9BoEQlqtU=;
        b=QgV6xL1OmFioiJCKZmodfYDPxba45uZ3gOwY54xWSuBVYsxcDDZSPscz54R6MzlNMQ
         pCWWsy+aWfl0yAAHtsWJqvCKboWnWuNhIlqy6s2FbzUgAKIoE2Q4Jnl/kwtnSq5JILCg
         aojcBp2aMVzk9KJzVw5J8kDBRNLEtgRRe1pX7BfnFwXzWoabkqJENggn3TKoQY2Uwr1/
         kqkEauaxUwjpPSHcruVQNZI1vUHdkWnQsfG6XM+1GmvENlQ40AgaN9pd3X6L9lnuCSlC
         wk3DSqn5vTv0q+vDX5qg3XN56+LVGEgyWH65XNHO+m1QvopFfkk9YpTBBo9RxeR8JMHi
         /yDw==
X-Forwarded-Encrypted: i=1; AJvYcCXVlCz7Y7ozHPJWbTiLKWOV2HI6FzH0ym2u0lYoXqxGRd8P0PBWXZ8pp0us11Q6csQ1GZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPw5QdYh0xcmM4w+ky2SHDQROUDDs6eCgDo9FnS0QhBo2p6dy5
	qSIkltah6xAsZ1jFzhu4ZQPTsMYgy/FZJK6miebDcbuJX4tQTG2Z9ra8uBDp8TCD
X-Gm-Gg: ASbGncuk38E2AXSob9Mfr1DnagapijHFUFfvy5arpZ+kL4J5/QlzN+n+1vWIMDPOnYu
	0EbQ54IM6Rvb0gFehOH9JVSTkSmv8gTV52JUzplivXMNIZUZev0CBrnKI+ykw7BVnYMr8RXaAxH
	cfyfnpOTxuREkdHkxsEC6SXE84RUNwFao5t4QOi6TCm2GuhJiHVX6ceci6O2k/oTcgxvFTpL4U8
	12iT3ZzJlHke2G/MAqy+3UgCZbooaM6CL3w1sobC5J3u6TwqPyMrHPZ3I98iBIRD7mpzy6A83B/
	dzmdITApaYO+PtWdWXOF51L6h4RV8/YTTHxC2ycyTbt4ajDTmlENsvVp50RNJo8iC64w/xP2gsx
	enYbUheHmbDG8eXtXPYD3C0d3QVWU1WS7L2eb0I4BmFm1fLb1bCL0UHXnWKFibwxe/1lmB5ohNz
	DLvHZUkVwiAsUDVA5/ERxKOVffEtQ6viXzKg==
X-Google-Smtp-Source: AGHT+IH0m50vGwNZtlIsU7+6gjOAdEgisNImw39xZv07pH5kUwP4jHroqy3Dqxx03MVfE2Kes3KKmg==
X-Received: by 2002:a17:90a:c107:b0:340:a5b2:c30b with SMTP id 98e67ed59e1d1-341a6c48550mr1406749a91.9.1762305644760;
        Tue, 04 Nov 2025 17:20:44 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm3722054a12.31.2025.11.04.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:20:44 -0800 (PST)
Message-ID: <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 17:20:42 -0800
In-Reply-To: <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-3-dolinux.peng@gmail.com>
	 <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
	 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
	 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > > > +{
> > > > +       struct btf_permute *p =3D ctx;
> > > > +       __u32 new_type_id =3D *type_id;
> > > > +
> > > > +       /* skip references that point into the base BTF */
> > > > +       if (new_type_id < p->btf->start_id)
> > > > +               return 0;
> > > > +
> > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > >=20
> > > I'm actually confused, I thought p->ids would be the mapping from
> > > original type ID (minus start_id, of course) to a new desired ID, but
> > > it looks to be the other way? ids is a desired resulting *sequence* o=
f
> > > types identified by their original ID. I find it quite confusing. I
> > > think about permutation as a mapping from original type ID to a new
> > > type ID, am I confused?
> >=20
> > Yes, it is a desired sequence, not mapping.
> > I guess its a bit simpler to use for sorting use-case, as you can just
> > swap ids while sorting.
>=20
> The question is really what makes most sense as an interface. Because
> for sorting cases it's just the matter of a two-line for() loop to
> create ID mapping once types are sorted.
>=20
> I have slight preference for id_map approach because it is easy to
> extend to the case of selectively dropping some types. We can just
> define that such IDs should be mapped to zero. This will work as a
> natural extension. With the desired end sequence of IDs, it's less
> natural and will require more work to determine which IDs are missing
> from the sequence.
>=20
> So unless there is some really good and strong reason, shall we go
> with the ID mapping approach?

If the interface is extended with types_cnt, as you suggest, deleting
types is trivial with sequence interface as well. At-least the way it
is implemented by this patch, you just copy elements from 'ids' one by
one.

