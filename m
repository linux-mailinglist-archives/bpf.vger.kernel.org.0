Return-Path: <bpf+bounces-70162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF6BB1E0E
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2579E2A134A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E0311975;
	Wed,  1 Oct 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNqUQayk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062481373
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355613; cv=none; b=Q4cq1g+IQvm+oF7x+t5mfr4mO9E3tGVTUpj/zM7lvTt5jdQmGUXMDwrsym3S/LTLI4qj9zV7rtrci/Ryj+PdJvWoEkq0muJ/d3WxtwwQWbX8ZJ5srzdG0b7CcE7u/9kPGOBaMREmF1bgXGJCDhdRoIfi5ImqdyRuCrud3de6feA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355613; c=relaxed/simple;
	bh=MHizv+nv4WC17GJ/t1uBnIs+NeCyKucyJQ+O4aIiIgI=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ocnLHGlZmU9zVqF6lxNjQb+OpIKMa+bczcC+rYRXihVYRwz0IbxT8O7oJW6q9P3NVKZVm1rhVA8mZf9rp6y2ebgXgxaELbkUtYB07cO8VVhWMfGo2Iogmr5jN1WYKhSG8vLelmkAu9D6izHTSmsnIflOaHlG6KUgQ0tCixoHsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNqUQayk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so597830a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759355610; x=1759960410; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml4kBHOjQ+xyYSKX+R0JZNDaTcgTWAbcL2+LNcRCE/Y=;
        b=NNqUQayksV32Q1pmYOn2TBwwMV7VqPZxvXHTqGGxvWIiZR+EQT7GDZ4K2MHS5Qynn6
         WDrQyBUanmGy1BZT2nct2W2CSyMc30p7d3GUIDdyPSP+gK2nxqA9RIWZiOTOYsHFkQf7
         gAIj+9z28stwSAj2b7jB2P2wL14gxsm/jbpPnsIpmq2L3FtyS2TTQ5Q3DgsGjmPY+ZeW
         nDGm+CuuNr+ugqIrY1F1MaxzAcjhHZJfQqeACLFhv7kp7MGGde+291aznFuPlnhQB4nL
         20lZpFNN96A6N6jplJpKB6XJ8gmLiUj8TggfNBIZmder8zPwUvtEKxCtwTBMil2umiBR
         zhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759355610; x=1759960410;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml4kBHOjQ+xyYSKX+R0JZNDaTcgTWAbcL2+LNcRCE/Y=;
        b=sdfEA7IGi9+Opq4zPzs9KEEFHR3T5fQq3Svk94B+wbxutCLLGPO2EBOxHV3J9zaezq
         1gw72RDMjd95K67wV98nozOWRvxMaVdYBxQvqFk5rIKoYN8yD3sUjQYs/1I9Rf1apsp8
         NkJKK+rfUYG3wk4YWHBra5Uc86OFRMV6/DLLIUFxSElvPoPPVXpYvxv2hdC8i1uBiCsH
         T/lroh/0HMniA0yaGcFOzNMhzqStA6m8+keyKwzaZp74w3JTO29OKzosyqiOIsv2QJ8m
         q1px7Ey3NVTDZjnuFb6IJPFY9gX5R0wE10CCU4Aa8OcSdVZotzd/ywjPVz4lS8yrYGT5
         caNA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBlHHkW+PF53hFhZJkt/re01Vh9rqzBdy9s6MnJ/0OISXIzwKVE86Ny60kacltbW8c88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3DGcTDepy+R7XRwM0q6uGR7DL9T4VcFnFTmmJqJexvgy+kc6
	hgw0RuSQ3pUB1HhqXpLehcBJm39m2c2oujWGokRLrrMSyJ4uOv4/78sk
X-Gm-Gg: ASbGncu63xVUJnJL6zJ6jfy3riaTJlfnDYW7oXTjQi01cXFycX24r9hvLNOds+BFTpM
	HIHvlY62YgO4qdvXpjshqtX6+HByeodQsMGecqER6C6hDJlOI6skgclCq2gpQjVLW1kwhL8AiMD
	RYTAvTUeqs40KbIpEhDKMSnJhkVGEI4hQNxAGGoIvZBBqadF7padHvW7plqxOihE2q0thCX9HIN
	vzOvLVq9gQbUiYGOVzueu7C7WTGTECE56kRokDBuna0yKqyG4FT2DlztbVqNBZNhcZ7dgqlgcaC
	osBshjwdbLTHm68XmuRtRGzhesoxbTaP7I6k8txtoICPA7PoMOG10gwt7GHDaUsBmENUYgNfO4r
	iwzvzjwFrDEymgIIj4trtV1Pxr3yAr70W/uKBivptb7lORitFB5zXf62cTc4=
X-Google-Smtp-Source: AGHT+IHMO+PZTez9jZJuNgzO9fmjaUHO3lCFQRnMGtcRO+0RYABWJ5gmyW8BIJNVPuO2mXvIaa++Dw==
X-Received: by 2002:a17:907:a088:b0:b37:4f78:55b2 with SMTP id a640c23a62f3a-b46e88953b6mr545998266b.34.1759355610043;
        Wed, 01 Oct 2025 14:53:30 -0700 (PDT)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm50832266b.63.2025.10.01.14.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 14:53:29 -0700 (PDT)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/1] bpftool: Formatting defined by user:fmt: decl tag
In-Reply-To: <CAADnVQKi4oSvF9VQn1enU4=Ew6r_SiSSFJ8QLSFitPR==mPnjg@mail.gmail.com>
Date: Wed, 1 Oct 2025 23:53:15 +0200
Cc: Quentin Monnet <qmo@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AC6162B-13A1-4022-A335-75E721CED92A@gmail.com>
References: <20250921132503.9384-1-mejedi@gmail.com>
 <20250921132503.9384-2-mejedi@gmail.com>
 <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
 <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
 <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
 <CAADnVQKi4oSvF9VQn1enU4=Ew6r_SiSSFJ8QLSFitPR==mPnjg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

> On 29. Sep 2025, at 12:20, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Mon, Sep 29, 2025 at 10:49=E2=80=AFAM Quentin Monnet =
<qmo@kernel.org> wrote:
>>=20
>> 2025-09-25 13:11 UTC+0200 ~ Nick Zavaritsky <mejedi@gmail.com>
>>>=20
>>>=20
>>>> On 23. Sep 2025, at 13:22, Quentin Monnet <qmo@kernel.org> wrote:
>>>>=20
>>>> Note: For future submissions please make sure to add the =
maintainers in
>>>> copy for your message, "./scripts/get_maintainer.pl =
tools/bpf/bpftool/"
>>>> will give you the list.
>>>>=20
>>>>=20
>>>> 2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
>>>>> Certain data types get exceptionally unwieldy when formatted by =
bpftool,
>>>>> e.g. IP6 addresses.
>>>>>=20
>>>>> Introduce custom formatting in bpftool driven by user:fmt: decl =
tag.
>>>>> When a type is tagged user:fmt:ip, the value is formatted as IP4 =
or IP6
>>>>> address depending on the value size.
>>>>>=20
>>>>> When a type is tagged user:fmt:be, the value is interpreted as a
>>>>> big-endian integer (2, 4 or 8 bytes).
>>>>=20
>>>>=20
>>>> Hi, thanks for this!
>>>>=20
>>>> I'm not sure I understand correctly. The 'user:fmt:*' tags are not =
used
>>>> yet, correct? So you're proposing to add it to existing code to get =
a
>>>> fancier bpftool output. Do you mean adding it to your own =
executables?
>>>> Or to existing kernel structures/types?
>>>=20
>>> I don=E2=80=99t intend to touch existing kernel types. This feature =
targets ebpf
>>> projects that wish to make it easier for humans to process bpftool =
dumps
>>> of their maps.
>>>=20
>>> By having it in bpftool, we eliminate the need for custom post
>>> processing. Bpftool can =E2=80=9Cmake it easier for humans=E2=80=9D =
more reliably since
>>> it has access to BTF (and tags). It is hard to write a generic post
>>> processor that improves the presentation of e.g. IP addresses.
>>> Pattern-matching will work for IPv6 addresses. For ports and IPv4
>>> addresses not so much, unless wrapper structures are introduced =
(e.g.
>>> struct{__be32 ip4addr;}). Wrapper structures will make ebpf code =
using
>>> them look funny.
>>>=20
>>> How can this feature get discovered? Having annotated types declared =
in
>>> bpftool headers will surely help.
>>=20
>>=20
>> Yes, discoverability is one of my main concerns here. I'm not =
convinced
>> it's a good idea to introduce a new convention for tags just for
>> bpftool. If this gets adopted, this should be documented at a larger
>> scale for other tooling to pick it up, too; and the defined formats
>> should probably not be proper to bpftool. What "bpftool headers" are =
you
>> talking about, exactly?
>>=20
>> (My other concern would be security and the risk of obfuscating map
>> contents from bpftool dumps, but given that formatting strings are
>> defined in bpftool - not in user programs - and you have checks on
>> lengths to associate format strings to pieces of data, I think we're
>> good and I don't see a way for users to exploit this and hide some =
bytes
>> from the formatted output.)
>=20
> I share these concerns.
>=20
> Instead of introducing a new tag convention can we teach bpftool
> to pretty print fields when their type is uapi struct?
> Like, instead of adding:
> typedef struct in6_addr bpf_in6_addr
>    __attribute__((__btf_decl_tag__("user:fmt:ip")));
> bpf_in6_addr in6;
>=20
> just use "typedef struct in6_addr foo; foo in6;" or "struct in6_addr =
in6;"
> to define a field in a map and bpftool can print it as an ipv6 =
address?
> in6_addr semantics is fixed.

Thank you for having a look! There are some challenges to consider with
printing uapi structs.

There=E2=80=99s no uapi struct for IPv4 address, __be16 and friends =
aren=E2=80=99t
structures either.

I understand the appeal of making formatting work without decl tags. A
similar approach was taken with bpf_spinlock (special casing a structure
type), but it is somewhat different. Spinlock is opaque. No one has
a need to come up with their own definition to provide a convenient view
into the data.

It is expected that BPF_spinlock might have special semantics since it
is clearly a bpf-specific thing. Personally, I feel that special-casing
common types such as IP addresses is very unexpected.

Lastly, in theory, people can target bpf with non-C languages. They
might have their own idiomatic types named differently already.

> So we can pretty print it and similar structs.
> Probably with an additional command line flag
> to keep backward compat by default.

Imagine bpftool learns about another type later. Do we have to add
another flag for backward compat?=

