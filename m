Return-Path: <bpf+bounces-19081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24E824BD5
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 00:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F223E1C22A76
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D282D049;
	Thu,  4 Jan 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA9ylVh2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9D2D041
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so12801111fa.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 15:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704410950; x=1705015750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AheLjQXyYQVCBEjj3DMAzYmPG2rTZaq5mRhTn+yw+E0=;
        b=UA9ylVh2aZGJad39GROhGqzcG0QCHmz71bZaB47aE1eDrIByDn7YGBLNxKEBzFttc/
         XRGBtdaJ1crO/TT5bYnv2Cd/ircV4YolZ8qAWKQOzXJBKlBzfH2OhtzAmJNE8YB4phxW
         Hf3j5DL3t+yaLEFGQYop9LvdkAOLWwB5f+DNrxAIAm2F6ZNZgE63hS4VLa9YAEo2hU1X
         1G49wmO6kAmjsSBeOdtkyyoiQKDpNqdib5XTS065Yj1uwTBktHWyCNg2gz5oSad1Vb4t
         OTJmWcviKb/37ETxBFDzSnzEcHe60oruS841zJgCXykWy01TSl6v6nPUzwlJuTA8KSBk
         X90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410950; x=1705015750;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AheLjQXyYQVCBEjj3DMAzYmPG2rTZaq5mRhTn+yw+E0=;
        b=Nb/rQMPdvw/xiMZ2lsso0xl1YMFWpsA/vANVbGnN0iSgLQBSMzZvrW0kYEcJEA0+dI
         h9sz4WGfuWO4c7PDCzTwS5PBVJ5l/8nJgx5/euMJ9In60tr6njpAf9YV89ZFYqr/ji2Z
         m1ayTViDZkWURmxygta+zfmpkffqK29Zn1zArr+tIVUk/OGqgQ1rcbig4WNHvvnNHArd
         bFNWkNKrE8J16tty9iqSNsKkZCQOVGjqf4uhUzFenOstSkyPCwVaAeNnyUb4pld6PzSG
         +yVddRgepSQoeTIysXeHSObh3iSnAZdr9wMGvqKNH8zCBDJW7eCvMNcw1DD3CmwN2cCP
         KcaA==
X-Gm-Message-State: AOJu0YzoUd9vjHxejP/sIk5mbc4ECF9xjr6NYQaXIIafI5fykEzkJFdg
	GJhOu3Vq5A6HKcbhLrzARZ8=
X-Google-Smtp-Source: AGHT+IG+A/q0u4LWweeWqB2uYmxotoNskDbU8/LdqYKFrpadfxwKe8Hs/fFOm3ZJunisHzeEEjliaA==
X-Received: by 2002:a2e:990b:0:b0:2cc:eb47:225b with SMTP id v11-20020a2e990b000000b002cceb47225bmr728849lji.100.1704410950270;
        Thu, 04 Jan 2024 15:29:10 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7c6d7000000b00555a0fa2211sm252576eds.31.2024.01.04.15.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:29:09 -0800 (PST)
Message-ID: <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Martin
 KaFai Lau <kafai@fb.com>
Date: Fri, 05 Jan 2024 01:29:08 +0200
In-Reply-To: <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
	 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
	 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-04 at 15:09 -0800, Andrii Nakryiko wrote:
[...]
> > This seemed logical at the time of discussion, however, I can't figure
> > a counter example at the moment. It appears that whatever are
> > assumptions in check_stack_write_var_off() if spill is used in the
> > precise context it would be marked eventually.
> > E.g. the following is correctly rejected:
> >=20
> > SEC("raw_tp")
> > __log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
> > __failure
> > __naked void var_stack_1(void)
> > {
> >         asm volatile (
> >                 "call %[bpf_get_prandom_u32];"
> >                 "r9 =3D 100500;"
> >                 "if r0 > 42 goto +1;"
> >                 "r9 =3D 0;"
> >                 "*(u64 *)(r10 - 16) =3D r9;"
> >                 "call %[bpf_get_prandom_u32];"
> >                 "r0 &=3D 0xf;"
> >                 "r1 =3D -1;"
> >                 "r1 -=3D r0;"
> >                 "r2 =3D r10;"
> >                 "r2 +=3D r1;"
> >                 "r0 =3D 0;"
> >                 "*(u8 *)(r2 + 0) =3D r0;"
> >                 "r1 =3D %[two_byte_buf];"
> >                 "r2 =3D *(u32 *)(r10 -16);"
> >                 "r1 +=3D r2;"
> >                 "*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine */
> >                 "exit;"
> >         :
> >         : __imm_ptr(two_byte_buf),
> >           __imm(bpf_get_prandom_u32)
> >         : __clobber_common);
> > }
> >=20
> > So now I'm not sure :(
> > Sorry for too much noise.
>=20
>=20
> hm... does that test have to do so many things and do all these u64 vs
> u32 vs u8 conversions?

The test is actually quite minimal, the longest part is conjuring of
varying offset pointer in r2, here it is with additional comments:

    /* Write 0 or 100500 to fp-16, 0 is on the first verification pass */
    "call %[bpf_get_prandom_u32];"
    "r9 =3D 100500;"
    "if r0 > 42 goto +1;"
    "r9 =3D 0;"
    "*(u64 *)(r10 - 16) =3D r9;"
    /* prepare a variable length access */
    "call %[bpf_get_prandom_u32];"
    "r0 &=3D 0xf;" /* r0 range is [0; 15] */
    "r1 =3D -1;"
    "r1 -=3D r0;"  /* r1 range is [-16; -1] */
    "r2 =3D r10;"
    "r2 +=3D r1;"  /* r2 range is [fp-16; fp-1] */
    /* do a variable length write of constant 0 */
    "r0 =3D 0;"
    "*(u8 *)(r2 + 0) =3D r0;"
    /* use fp-16 to access an array of length 2 */
    "r1 =3D %[two_byte_buf];"
    "r2 =3D *(u32 *)(r10 -16);"
    "r1 +=3D r2;"
    "*(u8 *)(r1 + 0) =3D r2;" /* this should not be fine */
    "exit;"

> Can we try a simple test were we spill u64
> SCALAR (imprecise) zero register to fp-8 or fp-16, and then use those
> fp-8|fp-16 slot as an index into an array in precise context. Then
> have a separate delayed branch that will write non-zero to fp-8|fp-16.
> States shouldn't converge and this should be rejected.

That is what test above does but it also includes varying offset access.

[...]

