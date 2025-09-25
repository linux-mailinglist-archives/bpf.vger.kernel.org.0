Return-Path: <bpf+bounces-69709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1137B9EDE8
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687B21B274D4
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F202EE60F;
	Thu, 25 Sep 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCZJ7YF3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0DC2F60CB
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798688; cv=none; b=VQqbINcACO1DRCe1VyuS2Ve30jn+QFZgA8/Q5fGaX7ZCQzt44L6U/3l9cri7GAv+CoRQt++DJ1B/gxz7PKj/2uc2byQHOjqub0H9t90yXQGEqwfyRa2sFj8vKBNjiEv15uwlXUHdPtleg2Il+tNMr+8G/VGwPMySIq56Jc6WFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798688; c=relaxed/simple;
	bh=aFS8/Z+4YfMdijSZ5GrdCI0jNYlHJMYb3wHEbERFPAU=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SVcx9WmFVWLs/ndzW+IO3xzXvuVO5uSQli1Lo6WaThIr0wx9T+NmmlJRe+yiuHgPyf3FOXJ2CQbLO9fCwlhxYcYIyGoirptMkv4TiHWBFJNtmvehHsP3Y0hZenbjphgZR1NzJmkCs+h/lYWOMJjiQ5JgWrzsol1AJM9VrFz06qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCZJ7YF3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b29ebf9478bso116379866b.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758798685; x=1759403485; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvQogmF7KDfaqKuZyAZb/az+I8jfHzFzp3VlhyK97YQ=;
        b=HCZJ7YF3Q909CDICAekGBg8Q0ndeSNJptwkftzTBHcPtM4RnEPdE0wj17CzUQ1u7sW
         ozj461GUwcvFblsLshqybv2Q2xzlXu1Pm3A93hsx9uqL9ZRB4EGNQ6mwDCkFnvBbf2Xj
         ffej7fr42xNWDp5i7MODVswjeNlaOqfRuyueoqFdeGuDpO9rUiW1eeo3+LEMWKqWluKK
         WupMecxBQsU//E8txJD66RlyBIrkXAFhLY2J5tjsWJVKaHiky+paSjuEgwbcC+BC5H+J
         5Z/mhZQsMdnWhOx+rGKOX/pUnYSU5AdVNygXNdFyBB9RtOngcveiKQyOBVUoGcnYRSxw
         gcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798685; x=1759403485;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvQogmF7KDfaqKuZyAZb/az+I8jfHzFzp3VlhyK97YQ=;
        b=b7CPDmnKi+/9RUmWZ6thm1RkeDgRIszJQ7OGZq3274a27+RdKU/5W63M6/p8aE0DlO
         Jhwcq2UJp3Fql1MJsNBmnD4AdnUz7URm3p9QwLo+3JPuE1kY+Xx8LXA+smcDjBiQD87z
         aeLuM7dfYpnYd2Qa68d1A1ShfzuUtPgZKucUvUYI6Gktf+V11589pEZ2NwqPAXSA63Tv
         9KoiL9cXBPNjE+FonzYP09Z/rxwgEMg2arOIdwTusR48XpznsXw4jgMbTjZ1rs+kDogI
         h8MjPe+39vdqWTfRmhaAtP3lDr3t9DQ3iXLYzGoygwKbsd7JXrBeeEnesNbZcK75J7RA
         ZhuQ==
X-Gm-Message-State: AOJu0Yx1NEIwZ9fVfcaji4DHFihT2OQfk5ENY19OH9W+/ThYCuiy9sdk
	3daZmQmVgYrcgLmULv4cqd/c6868qu+NSjFbu1qRboKfFr8NTKTtt64k
X-Gm-Gg: ASbGnctj/qwTuIbZvKjKle8NkUa+0DQDIhWhsGjVFMn7xpR6FAal4LYo6PCID0roq5+
	+B/vbUnBkDQ+f3hy8G9AftYuA44IKlWJvnIGr3SY30R31T4wBfy/tx7wPOoSlhWmBFgmEpnRBvN
	VZXqKkB2xYEJRjliwpG9Zd1FFdN7QZa2R2/FYfAktUFaGQRp3iX86cfajWtXL6gzDW0Mi/wHTII
	o9p/R83NRmLDlYaNTJfXMduonfV6m6AZHSCh9ML03LGlUqpnQbRjHpNi4OT0Erzt7M9hPxO0S0W
	/L6fqIRPGhi6IC6qF44SqvFZZZAe8Zaan45bLsJvDld4xGSb5vIV1+CMyDHPihkW3lp7ZC16fQo
	zDo4uXMAtnc+sxBXq3OMU4w9iYaIJ/Wm1LdI=
X-Google-Smtp-Source: AGHT+IF7e6v1oucsOSMv2oJagF2isfYqo1TpOa4sH3qFriZ86IF0GVua3IC15lrQKP5GEg8vTGrCTw==
X-Received: by 2002:a17:907:9405:b0:b10:1af1:dc2a with SMTP id a640c23a62f3a-b34bb9ea00bmr344466266b.38.1758798684375;
        Thu, 25 Sep 2025 04:11:24 -0700 (PDT)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d7351sm148481466b.7.2025.09.25.04.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:11:23 -0700 (PDT)
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
In-Reply-To: <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
Date: Thu, 25 Sep 2025 13:11:11 +0200
Cc: bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
References: <20250921132503.9384-1-mejedi@gmail.com>
 <20250921132503.9384-2-mejedi@gmail.com>
 <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)



> On 23. Sep 2025, at 13:22, Quentin Monnet <qmo@kernel.org> wrote:
>=20
> Note: For future submissions please make sure to add the maintainers =
in
> copy for your message, "./scripts/get_maintainer.pl =
tools/bpf/bpftool/"
> will give you the list.
>=20
>=20
> 2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
>> Certain data types get exceptionally unwieldy when formatted by =
bpftool,
>> e.g. IP6 addresses.
>>=20
>> Introduce custom formatting in bpftool driven by user:fmt: decl tag.
>> When a type is tagged user:fmt:ip, the value is formatted as IP4 or =
IP6
>> address depending on the value size.
>>=20
>> When a type is tagged user:fmt:be, the value is interpreted as a
>> big-endian integer (2, 4 or 8 bytes).
>=20
>=20
> Hi, thanks for this!
>=20
> I'm not sure I understand correctly. The 'user:fmt:*' tags are not =
used
> yet, correct? So you're proposing to add it to existing code to get a
> fancier bpftool output. Do you mean adding it to your own executables?
> Or to existing kernel structures/types?

I don=E2=80=99t intend to touch existing kernel types. This feature =
targets ebpf
projects that wish to make it easier for humans to process bpftool dumps
of their maps.

By having it in bpftool, we eliminate the need for custom post
processing. Bpftool can =E2=80=9Cmake it easier for humans=E2=80=9D more =
reliably since
it has access to BTF (and tags). It is hard to write a generic post
processor that improves the presentation of e.g. IP addresses.
Pattern-matching will work for IPv6 addresses. For ports and IPv4
addresses not so much, unless wrapper structures are introduced (e.g.
struct{__be32 ip4addr;}). Wrapper structures will make ebpf code using
them look funny.

How can this feature get discovered? Having annotated types declared in
bpftool headers will surely help.

>=20
>=20
>>=20
>> Example:
>>=20
>> typedef struct in6_addr bpf_in6_addr
>>    __attribute__((__btf_decl_tag__("user:fmt:ip")));
>> bpf_in6_addr in6;
>>=20
>> $ bpftool map dump name .data
>> [{
>>        "value": {
>>            ".data": [{
>>                    "in6": "2001:db8:130f::9c0:876a:130b"
>>                }
>>            ]
>>        }
>>    }
>> ]
>>=20
>> versus
>>=20
>> $ bpftool map dump name .data
>> [{
>>        "value": {
>>            ".data": [{
>>                    "in6": {
>>                        "in6_u": {
>>                            "u6_addr8": =
[32,1,13,184,19,15,0,0,0,0,9,192,135,106,19,11
>>                            ],
>>                            "u6_addr16": =
[288,47117,3859,0,0,49161,27271,2835
>>                            ],
>>                            "u6_addr32": =
[3087860000,3859,3221815296,185821831
>>                            ]
>>                        }
>>                    }
>>                }
>>            ]
>>        }
>>    }
>> ]
>=20
> My concern with the example above is that 1) this may be a breaking
> change for existing scripts parsing map dumps, and 2) we lose the
> structure and byte representation for in6 (in this example), which =
means
> less post-processing for humans, but potentially more for tooling.
>=20
> If you mean to use the BTF tags as opt-in in your own maps, then =
that's
> probably OK. If you mean to change it in existing structures, I don't
> know - maybe I'd add the custom representation _in addition_ to the
> existing one, rather than in place.
>=20
> Quentin



