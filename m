Return-Path: <bpf+bounces-58754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C091AC1570
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC044A86DF
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5617A1E411C;
	Thu, 22 May 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsf8//TA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077218D;
	Thu, 22 May 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747945002; cv=none; b=inSkGvWkLrdfRBj4RBEduDEMGDHUhwogX1+Dq3l+2yhZAAyOUze2eG/MAulm2aO6f1wLhzwPnFlGqWY88Q/HA/tLpF1utUtXhSrUMgedzEiLZckvMuJQkNKA032KX1DJhp5AAFjqZJldNMc/J9/JFrqho51sIQ54U8hpLFVfWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747945002; c=relaxed/simple;
	bh=B80tMCBxjXZ8XfvtfjaUdKIOOPtclGzySOAeUBxHdmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6xc7hdfim9xxaCtZmC9sbpKlg7PAevUDFyHTJIZXa/dQsBpITlphcUI1svaSZ+nzbGMUVwY9S7EKvvWYgORufzaIRKjmxamE8MN18LsgzBQcmllu626sxWowD5Al2rD1XLralagDADZBsHkoeYNGpOg9ig8cv3FnoactX5G7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsf8//TA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231e21d3b63so85003635ad.3;
        Thu, 22 May 2025 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747945001; x=1748549801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sJ4ys6D3S0lIKiUh5hLVWx2yi7pJBhLy4rov+U+4gE=;
        b=gsf8//TANJaVRE2qiCBOCkkyj/eVyKJQwKHeUQAVUfz0OIUYfy/bJTbY2zvkWEekic
         kzhMLNqo9gIHVXwB7ZTcZ9Arh6ZttsJe584JaToHAyTKT8JoZKAFts4OXDEmIiD19PsG
         Fz6uHpBX+5tCQ9xhdnoPmlIypkQAW6HGXTeKAXUlYFjAa7LLUsiLBkk7IcOrzLZq4L5Z
         7H/nLlBI+ZMiBEx55EegVlm8ER7Zh3Yk+ZrYrPKsUkNFWRwiHLsypHEZez2RX78JzRZy
         /XNmf1nTwNITLPNQhSEfVf4or2TZQhpzeHkI/Szq5hfz9ucKZ4+fPH9zRJDj/71kre+9
         WspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747945001; x=1748549801;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sJ4ys6D3S0lIKiUh5hLVWx2yi7pJBhLy4rov+U+4gE=;
        b=AhjjtLcGr9rg2QMA/b+k9KycbiEfzC1y4kwgV8s57JopafUEhrzrAr7y5dTojA7J2l
         Yvjv/p4jVEdzw5BdROvGhsWiEZcDPS6ElfzJy+lXzg3G7S3ZtYSTFf0uukgeEVfEUSPZ
         /AY3C0fFujnEBAN9BSDpdOKdJEmtqHP6Ny/UOvEbrapCqWTYDVszjWoq3qCf7XMFhpe2
         tVPebDckZcB/4kakcCluzJaF10il7q6oA6uVRxQp0L4WWp33JMWtMTPZQT7vM0bVEfQl
         U+mwaubwESeVXWd5KGYAUOuNE09727TLbhKjY7k5jkW06hnia5yUE9eixXtKbF2k5Y/9
         Tadg==
X-Forwarded-Encrypted: i=1; AJvYcCULHbRgCcEt1USWzt3OlKm25CQmlP8yX2v64igoGduoFLUqU1ZlrQiNa81Uf7d0Cfl24ZTZB4tAyw==@vger.kernel.org, AJvYcCUzWImsARywv4B+bJLqjKF9Df6zoNRqSxtSgX9JdQdWNHE29Fb9nr6Ark1lWWnfro5eVK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcPB75NSyDd3nMKg31Pjt3N9uu/romC9R/pTcuFzo4WxWkCKO
	AuwX2Imanj3wWdn8vbkd2zKdUEgGP93if9JV7rJ2tOClX96cesmOEcXS
X-Gm-Gg: ASbGncvE17Dhviacs2DtQAIPIpORePG2inEPgYuUvIkUgZ07Ida9N1A1PVuK0qixHZC
	tKVUmaNh7+wzpXckAbqEnGYC5mgkpAJ4leM9A+z2DafJBGQY4v36XIa4WocZ792vrxSDVevw+Fx
	1KNDoVJDVQI5hzvZMV7dv2H3siMQZxkePAmW6/7d4ktwb+RsytO/Rh0qQOUBVcJSiEuXqTD660+
	xDVdU0QiGl6YydwXB6LtEo5LYq6hbG/XuPP0KxQAs+u4plQ1rZ0LJ0RjZAeTepQBGGaEZH+gkP6
	mg+vpjvcscwJSqiko+sPTBzLoGjLWGq2VikIS8w6a/OTNRc=
X-Google-Smtp-Source: AGHT+IG8Inb3OmqNrcHK8lgOP4wMiBBZwrsfRA+H4d9IQHuT7cWFxv1yVl7M67MEicblnt+buXNCnQ==
X-Received: by 2002:a17:902:d2cf:b0:22d:b305:e082 with SMTP id d9443c01a7336-231de3bb2d0mr333566155ad.47.1747945000589;
        Thu, 22 May 2025 13:16:40 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9530sm112933965ad.48.2025.05.22.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 13:16:40 -0700 (PDT)
Message-ID: <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Thierry Treyer
	 <ttreyer@meta.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, "dwarves@vger.kernel.org"	
 <dwarves@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "acme@kernel.org"	 <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 Yonghong Song <yhs@meta.com>,  "andrii@kernel.org"	 <andrii@kernel.org>,
 "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,  Song Liu
 <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>, Daniel Xu
 <dlxu@meta.com>
Date: Thu, 22 May 2025 13:16:38 -0700
In-Reply-To: <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
	 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
	 <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
	 <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-22 at 13:03 -0700, Andrii Nakryiko wrote:
> On Thu, May 22, 2025 at 10:56=E2=80=AFAM Thierry Treyer <ttreyer@meta.com=
> wrote:
> >=20
> > Hello everyone,
> >=20
> > Here are the estimates for the different encoding schemes we discussed:
> > - parameters' location takes ~1MB without de-duplication,
> > - parameters' location shrinks to ~14kB when de-duplicated,
> > - instead of de-duplicating the individual locations,
> >   de-duplicating functions' parameter lists yields 187kB of locations d=
ata.
> >=20
> > We also need to take into account the size of the corresponding funcsec
> > table, which starts at 3.6MB. The full details follows:
> >=20
> >   1) // params_offset points to the first parameter's location
> >      struct fn_info { u32 type_id, offset, params_offset; };
> >   2) // param_offsets point to each parameters' location
> >      struct fn_info { u32 type_id, offset; u16 param_offsets[proto.argl=
en]; };
> >   3) // locations are stored inline, in the funcsec table
> >      struct fn_info { u32 type_id, offset; loc inline_locs[proto.arglen=
]; };
> >=20
> >   Params encoding             Locations Size   Funcsec Size   Total Siz=
e
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   (1) param list, no dedup         1,017,654      5,467,824    6,485,47=
8
> >   (1) param list, w/ dedup           187,379      5,467,824    5,655,20=
3
> >   (2) param offsets, w/ dedup         14,526      4,808,838    4,823,36=
4
>=20
> This one is almost as good as (3) below, but fits better into the
> existing kind+vlen model where there is a variable number of fixed
> sized elements (but locations can still be variable-sized and keep
> evolving much more easily). I'd go with this one, unless I'm missing
> some important benefit of other representations.

Thierry, could you please provide some details for the representation
of both fn_info and parameters for this case?
I'm curious how far this version is from exhausting u16 limit.

>=20
> >   (3) param list inline            1,017,654      3,645,216    4,662,87=
0
> >=20
> >   Estimated size in bytes of the new .BTF.func_aux section, from a
> >   production kernel v6.9. It includes both partially and fully inlined
> >   functions in the funcsec tables, with all their parameters, either in=
line
> >   or in their own sub-section. It does not include type information tha=
t
> >   would be required to handle fully inlined functions, functions with
> >   conflicting name, and functions with conflicting prototypes.
> >=20
> >   The deduplicated locations in 2) are small enough to be indexed by a =
u16.
> >=20
> > Storing the locations inline uses the least amount of space. Followed b=
y
> > storing inline a list of offsets to the locations. Neither of these
> > approaches have fixed size records in funcsec. "param list, w/ dedup" i=
s
> > ~1MB larger than inlined locations, but has fixed size records.
> >=20
> > In all cases, the funcsec table uses the most space, compared to the
> > locations. The size of the `type` sub-section will also grow when we ad=
d
> > the missing type information for fully inlined functions, functions wit=
h
> > conflicting name, and functions with conflicting prototypes.
> >=20
> > With fixed size records in the funcsec table, we'd get faster lookup by
> > sorting by `type_id` or `offset`.  bpftrace could efficiently search th=
e
> > lower bound of a `type_id` to instrument all its inline instances.
> > Symbolication tools could efficiently search for inline functions at a
> > given offset.
> >=20
> > However, it would rule out the most efficient encoding.
> > How do we want to approach this tradeoff?

[...]


