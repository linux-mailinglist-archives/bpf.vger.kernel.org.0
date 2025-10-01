Return-Path: <bpf+bounces-70150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D71BB1CD2
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A408C4E27B0
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074F31195A;
	Wed,  1 Oct 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJXe7TDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF341C5F13
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353889; cv=none; b=pPga6z//HkqlNy9kh87i/dACIg2P705lvu/7Fbd7R8MwQfQ8EFZkV37W2z5jbN6H/Fmkt8DGf/UdoA32qoV4hdn69cNZCCrEM7jCmB6c/eOaVEjSS+9W2tInxTEHMjyLCs5pCrwdX7DQzGFz6kJCeBBSkiJ/fqBcOo4qFhrSzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353889; c=relaxed/simple;
	bh=uGBvyQRSzEqR16Q8o1jFoD2llwMC8OLHHLaGoa3YE+Y=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=crA1s6A9e/mo71R4NlWRkm52AfarTs0QmRAMDxjlsz04CdRGQJ09rZveJSm0fCjvd5ixgJ3qmlYKkyiO5vBDkcLDSE0liGh+uQr47WKf5H38oElZT8GHSPNr5kXksiX7CI6gDEsvkZlrDalRv/iWZ2re60fWzIxDAYTOFhxMYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJXe7TDP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4736e043f9so71897166b.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759353886; x=1759958686; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpGQyLKZQhlhUuuD5aeXtYlpUTAOI6wys65LbQFngY=;
        b=aJXe7TDPvhlGJp13UIDYGbjINP+rq9OxA7Tey33Ca0vdpi/voa7Z2uZHw0xnUaS8yA
         JuxLow9fX9NukcSVJABwUEB1c6xR6Y+htrRxpXPrafYjHjLeaG9Rg9/gEIZHcfHt3m4R
         KUqPJ3AUkyRF46wsyiHHMTUpV43nRf4vPKYVUnNqzPaXaOe3WrwJLSPWO6MeZJLqafzr
         P65XpUUsPCnfnLf+o4HW1IbwbsTtksfFF6beEbrQPOminQeZjXWPI0GxXx7Q1bqobrzw
         wZgAAFTj7tA/DNR1HAToy7LI+6XkPBGsuMdQ7oTZCaMlnmVlreoE+ILqiD8n9U/oxZOJ
         NE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759353886; x=1759958686;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxpGQyLKZQhlhUuuD5aeXtYlpUTAOI6wys65LbQFngY=;
        b=sZEDD3IvqmIiuZRtrlI7Md8yO4edF998Lv++6HB1HIpK2JUX7Kkte7E/6jS2zk6Vpm
         UMuBEiwVExwnc9JUrLYjKH7N31R+289S7kxwqcVYTFgw/HceBHB44Drhq81sUBQmSy0q
         adEouRASBTPMWrO2AnUG+aOEmvqAHSmm0jFkxgb1xclWhiWPqQVToSumpnx9deFNpPzp
         /KeEC++Tp68Y9s5F1J6hIeLcBNUbTsoh/U0/9xw8c3g/zB2E21fj1uEk9MrKBo+xCY8X
         nPj/Z7m4K4qS5mC1y45hEq2LxQbWROY74nKLDFJ0O24Jg62Yl/Uh7hh0MAnNIt39ToAN
         czGA==
X-Gm-Message-State: AOJu0Yxdt7A8r9g0S431G4SBcJp4D6D+mlUwxvbAWv0tdWI+sA3wPGqO
	wdJK7evESzUZj0Fp1SOe0AkFgj8LMIndIm5SWWyhkSBUUgM9juEx0OJ6
X-Gm-Gg: ASbGnct3Zp1/RlEvpZSTWIHDFPGMfh8WN6x2I91nVFLVs63gP/ocZlmx13ndKnnCcq3
	OX0aIATvWB996BuUvHplgbP4qzAjFia6RBCoK9Ujno4Fx3gcMj7EHYVDgHZCzCrqXLod54UVoPO
	ADRW/FwTIo2BA5YRyJ6ORPbPT0JL9nDU3C8k+U6LfvcZlmZPmJ/QRH1bmNIViCAv1b+6+x6eX+x
	scud33cE9h0Fe6dmTEOzTbkqOHIr8NTgciLkweOnTZCUSvkIhZQ/E+ntkSMSx3yM2DnIHVhnwrk
	TXBhXTDCFrWtNOdy7h6sp6B8bL+i0BI7aDw63KQMzz0YCi0JfbbyNbe+7Wd8ZNAiaMgvRGsNxxE
	2W2N5GMg7zUPBTxDuzVmV7YpKpMk/v8PTSUjYeoGypvVs3e2pAIH0ZTB/OJU=
X-Google-Smtp-Source: AGHT+IGAZBDEyjQaD8uVdDHFMXsAhScJHEZIwq1B2Mu1CDAzrJbyYZkXztmfsNeGG8SfwLzynfeoJQ==
X-Received: by 2002:a17:906:d54d:b0:b04:5e64:d7cd with SMTP id a640c23a62f3a-b46e8e78476mr614950466b.46.1759353885542;
        Wed, 01 Oct 2025 14:24:45 -0700 (PDT)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a1785f2sm45386466b.94.2025.10.01.14.24.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 14:24:44 -0700 (PDT)
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
In-Reply-To: <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
Date: Wed, 1 Oct 2025 23:24:33 +0200
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B04CB335-C8DF-45B6-B0A3-768A786E508A@gmail.com>
References: <20250921132503.9384-1-mejedi@gmail.com>
 <20250921132503.9384-2-mejedi@gmail.com>
 <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
 <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
 <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)



> On 29. Sep 2025, at 11:49, Quentin Monnet <qmo@kernel.org> wrote:
>=20
> 2025-09-25 13:11 UTC+0200 ~ Nick Zavaritsky <mejedi@gmail.com>
>>=20
>>=20
>>> On 23. Sep 2025, at 13:22, Quentin Monnet <qmo@kernel.org> wrote:
>>>=20
>>> Note: For future submissions please make sure to add the maintainers =
in
>>> copy for your message, "./scripts/get_maintainer.pl =
tools/bpf/bpftool/"
>>> will give you the list.
>>>=20
>>>=20
>>> 2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
>>>> Certain data types get exceptionally unwieldy when formatted by =
bpftool,
>>>> e.g. IP6 addresses.
>>>>=20
>>>> Introduce custom formatting in bpftool driven by user:fmt: decl =
tag.
>>>> When a type is tagged user:fmt:ip, the value is formatted as IP4 or =
IP6
>>>> address depending on the value size.
>>>>=20
>>>> When a type is tagged user:fmt:be, the value is interpreted as a
>>>> big-endian integer (2, 4 or 8 bytes).
>>>=20
>>>=20
>>> Hi, thanks for this!
>>>=20
>>> I'm not sure I understand correctly. The 'user:fmt:*' tags are not =
used
>>> yet, correct? So you're proposing to add it to existing code to get =
a
>>> fancier bpftool output. Do you mean adding it to your own =
executables?
>>> Or to existing kernel structures/types?
>>=20
>> I don=E2=80=99t intend to touch existing kernel types. This feature =
targets ebpf
>> projects that wish to make it easier for humans to process bpftool =
dumps
>> of their maps.
>>=20
>> By having it in bpftool, we eliminate the need for custom post
>> processing. Bpftool can =E2=80=9Cmake it easier for humans=E2=80=9D =
more reliably since
>> it has access to BTF (and tags). It is hard to write a generic post
>> processor that improves the presentation of e.g. IP addresses.
>> Pattern-matching will work for IPv6 addresses. For ports and IPv4
>> addresses not so much, unless wrapper structures are introduced (e.g.
>> struct{__be32 ip4addr;}). Wrapper structures will make ebpf code =
using
>> them look funny.
>>=20
>> How can this feature get discovered? Having annotated types declared =
in
>> bpftool headers will surely help.
>=20
>=20
> Yes, discoverability is one of my main concerns here. I'm not =
convinced
> it's a good idea to introduce a new convention for tags just for
> bpftool. If this gets adopted, this should be documented at a larger
> scale for other tooling to pick it up, too; and the defined formats
> should probably not be proper to bpftool. What "bpftool headers" are =
you
> talking about, exactly?

I actually meant =E2=80=9Clibbpf header=E2=80=9D, sorry for a confusing =
typo. So
probably bpf_helpers.h. My idea was declaring bpf_be16, bpf_be32,
bpf_be32, bpf_inaddr, and bpf_in6_addr typedefs, the last
one via forward structure declaration.

This way the feature is somewhat discoverable (how do people find out
about __arg_nonnull, etc?)

One can use the provided types as-is, or use the underlying mechanism to
define a custom type, should someone be unhappy with bpf_inet_addr being
an alias of __be32. People using non C languages with their own =
idiomatic
types can leverage the proposed decl tags too.

>=20
> (My other concern would be security and the risk of obfuscating map
> contents from bpftool dumps, but given that formatting strings are
> defined in bpftool - not in user programs - and you have checks on
> lengths to associate format strings to pieces of data, I think we're
> good and I don't see a way for users to exploit this and hide some =
bytes
> from the formatted output.)

It is not that hard to hide some bytes from bpftool.

struct __attribute__((aligned(128))) hide_some_bytes{
  char c;
};

>=20
> Quentin



