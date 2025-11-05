Return-Path: <bpf+bounces-73694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64CC3775C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 20:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C753AC6A8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578832D431;
	Wed,  5 Nov 2025 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC+A+6ae"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF432367BA
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370636; cv=none; b=QynMcdNy4ifmIm+eogEh+ZrSQzP6TyErSM8dd+CcBqcFRpHZBHgFUSgpkXknbigNiz6p99FrxgM+8MH4iCbI/eVKwRxpvbinBlOLsob0cPXqDtTa4UxY9DfNUDj+19UYHwHU4rAfu958EJT5QgONCWEsZ0XEZrh2ooymuExBAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370636; c=relaxed/simple;
	bh=xumo1NJjI1tSArbHaxlVI/vTMt0zSW0N/aOr2WFfe5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWYOuxkVtHCegnw5Z12dwSFTcr8TrX1cn8Wd3TnDUVmX1GLoK8pFsQid3M+USz9OMmk2yPkhj2/Q+GVPSijWggLnYxJwoYDDzz3mdHeoXkNKjqBCg8j2/XTFKKDrJPmTnTaefnu+/fAlcmxcLeZaU6HtewxCXjcOPAAztW4ij2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC+A+6ae; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-782e93932ffso201659b3a.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370634; x=1762975434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RREx40hV5tyq0dYa5rX5oC5Z4Ah1UHImj4yHSS+0TPM=;
        b=XC+A+6aeXtaikgEIpbmvDPTvFpCq7olfeVKY6QWw6ZOD/x6WXKvWRCt8C3sOSf5RQN
         QWXairb9JaU7Gpgx93CCihV1/aW194smY2aRvujhTin+dTR8PORPiyOPM5hkk6D3FjZc
         QjAq5Ll1fNNwUJ8zQPADxTOouQ0yfELWUdzfuRFw0oNICrwl6VzINLOG020DNwd1nYo5
         RVylP6NGmRRXrYSOQphlJUoUYJ20ejY96ppEInqIvAmATOnzPIj9VT2JerdArG0oNJ2L
         juM5y86njPE7l6v5ZVvmve0Xmdzt+vZuYu60W+xRLpl5orDv5TTc0VPsMH31631U7mvM
         6XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370634; x=1762975434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RREx40hV5tyq0dYa5rX5oC5Z4Ah1UHImj4yHSS+0TPM=;
        b=M1/sHeIwnhlGSTXRZEahpKLjKVVAh0wUWduruuCVOk4xq780XDQVbVy1lvt5b9K1FK
         IsuQ4pinQ12I5kM/aILnx94hgjYo4UN5VaE7eze5GSKXLlYVImaOxvUGNQZvms36UxHi
         2/02zN3q4AOlSs0MFqQiznVXPp155ei/ch3FKrK+uvZ3lf1d96VapLq6uw/wjXWVg1oo
         OpwEgkqS7RC+TVcEKGSjCEod/Ckw4msQy7VsjBmi4MAIws8GJz1XI8J3Se+jA6kUT/9g
         rbBSTC0sa9WR5SVllFGx9nIqHdj4FCI8Oz8T2gVLDc7eqE1ZmL1YTPjQmCt3vwNu38s8
         d6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUig7jgM+YZKTburGnoFXHjefc3hLG+H+TN27KJqm/zcA///KNc+wtkqB4Y5pK1NMxcKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wXqkfha3e+ngEZDGz+0PMHDTfs7naewBwf6FosjLjJSKaD8j
	IG70VUaf9J0hJjhjBWZfpRT5YVUD3bYnSTUE64SWDPea01vW/kuVyLyc
X-Gm-Gg: ASbGncuzDMAuuztczsG8kHC2V4HAjpbqGCvnkUYGP2M8W5XrBo8NqF+D60IdmL9472f
	wbsY5qevB3+FTXxmFOzTigSFAjXDA8CCnlL1u18ejM0C47jVokBHnqqXbHmE4QFJQ8+Lm8aIWkW
	my1huEIHaWYoQeEB/JyUzOSxHqTPMqUxReJwsqcR7mllxsHLrCNpbWRjjwaLtyLemYTE77KWP4m
	JVZIFdW4TDesG88E2iud8zLZspKG71/8As/08YSYqXjlj74tZKU/5wudZHwuLF7DT/mrAKYR+Az
	eXd708ZzwL4LZXoZM565GJ9sx+2zM1M5Ho5RE8uO+6LIhcmXGLcPXvyQEIqT9tph6y6NeWRW184
	vEkgiJYG+fU9m118r19ZviljCNP0blf6gI2SeSB4/XEjrIJFjaEwkILo58veHeB9tTwtVSkAfrd
	7yAFrMoMRQoHAoqN3ngVQrXm9Cr8TAfB5NiyI=
X-Google-Smtp-Source: AGHT+IEF1f46SRcectCdqICEP1eNEqVAI9FbwInYUxhpGA0Pisokd6E6G3WgcwMjG2n50Dr7nHIlyg==
X-Received: by 2002:a05:6a00:2e11:b0:7a2:73a9:97e with SMTP id d2e1a72fcca58-7ae1f5937c6mr4969623b3a.26.1762370634009;
        Wed, 05 Nov 2025 11:23:54 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82204713sm187026b3a.36.2025.11.05.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:23:53 -0800 (PST)
Message-ID: <2ba0561a653254254a0fa1709bffb3704488f33b.camel@gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type
 reordering
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Wed, 05 Nov 2025 11:23:52 -0800
In-Reply-To: <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-3-dolinux.peng@gmail.com>
	 <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
	 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
	 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
	 <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
	 <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:23 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx=
)
> > > > > > +{
> > > > > > +       struct btf_permute *p =3D ctx;
> > > > > > +       __u32 new_type_id =3D *type_id;
> > > > > > +
> > > > > > +       /* skip references that point into the base BTF */
> > > > > > +       if (new_type_id < p->btf->start_id)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > > >=20
> > > > > I'm actually confused, I thought p->ids would be the mapping from
> > > > > original type ID (minus start_id, of course) to a new desired ID,=
 but
> > > > > it looks to be the other way? ids is a desired resulting *sequenc=
e* of
> > > > > types identified by their original ID. I find it quite confusing.=
 I
> > > > > think about permutation as a mapping from original type ID to a n=
ew
> > > > > type ID, am I confused?
> > > >=20
> > > > Yes, it is a desired sequence, not mapping.
> > > > I guess its a bit simpler to use for sorting use-case, as you can j=
ust
> > > > swap ids while sorting.
> > >=20
> > > The question is really what makes most sense as an interface. Because
> > > for sorting cases it's just the matter of a two-line for() loop to
> > > create ID mapping once types are sorted.
> > >=20
> > > I have slight preference for id_map approach because it is easy to
> > > extend to the case of selectively dropping some types. We can just
> > > define that such IDs should be mapped to zero. This will work as a
> > > natural extension. With the desired end sequence of IDs, it's less
> > > natural and will require more work to determine which IDs are missing
> > > from the sequence.
> > >=20
> > > So unless there is some really good and strong reason, shall we go
> > > with the ID mapping approach?
> >=20
> > If the interface is extended with types_cnt, as you suggest, deleting
> > types is trivial with sequence interface as well. At-least the way it
> > is implemented by this patch, you just copy elements from 'ids' one by
> > one.
>=20
> But it is way less explicit and obvious way to delete element. With ID
> map it is obvious, that type will be mapped to zero. With list of IDs,
> you effectively search for elements that are missing, which IMO is way
> less optimal an interface.
>=20
> So I still favor the ID map approach.

You don't need to search for deleted elements with current
implementation (assuming the ids_cnt parameter is added).
Suppose there are 4 types + void in BTF and the 'ids' sequence looks
as follows: {1, 3, 4}, current implementation will:
- iterate over 'ids':
  - copy 1 to new_types, remember to remap 1 to 1
  - copy 3 to new_types, remember to remap 3 to 2
  - copy 4 to new_types, remember to remap 4 to 3
- do the remapping.

Consider the sorting use-case:
- If 'ids' is the desired final order of types, libbpf needs to
  allocate the mapping from old id to new id, as described above.
- If 'ids' is a map from old id to new id:
  - libbpf will have to allocate a temporary array to hold the desired
    id sequence, to know in which order to copy the types;
  - user will have to allocate the array for mapping.

So, for id map approach it is one more allocation for no benefit.

