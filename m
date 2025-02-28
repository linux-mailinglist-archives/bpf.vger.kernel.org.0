Return-Path: <bpf+bounces-52835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51558A48E39
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C8A16DB89
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4D2140E5F;
	Fri, 28 Feb 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hc1Wnley"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C33596A;
	Fri, 28 Feb 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707694; cv=none; b=MVcY+OUHKRQoVYGJ4Iuw/Li+wYHu5Pn93ey6V1Dbw8PN20fwPSsL+yYcNATTdFxA53VDYGLV8nmKU0hKZI5+yFHeeueUewSqIdX3KFhyc6WzLnN7JzY/YiuIseQuJS/EyHv65p8TY4wFUWUJqQ1oPRlAf+VGHJiMhe7rfomnao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707694; c=relaxed/simple;
	bh=Lp1jbP3VtIoZJb7DDjRQCPnuT/WqIWZRzxbJAQE3YnA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sUhwxFtUg5sQeFToy9qKPq/jAjjiANiSkNnECv0FVDxh0NPznBVx4EMQS1swHyYlkcYKmef1Mt+RTowM2DbKTpS6KCGYGbZbHyBy6o5vMpZHTpspSVQwTI58XBQsxIGnLVXdVPD9aSQN+UsTBCo1PdGkmnEYx65O7YoqTCNweeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hc1Wnley; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51S1ouig2394050
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Feb 2025 17:50:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51S1ouig2394050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740707463;
	bh=zdxlCZN7qRmiM8/WMWaSChORmP5U1+mg9Dd2GNfsbGA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hc1WnleyPiNvmeMgkj0Fbb3sTWrGCmnnaxiRXiZvVvO6Is3ZJKu6mp+YJv2Dbs05X
	 aVxT1zsm98Egcx7g7dDapGUM1ppk6QkyAa2wZSKXLVi8I4OeDG/xzxwpW4dEA2MBFx
	 T1ntM64Z768sGTrScS8Wa6oiWHo2Bu8akRlkAIPTgcwVRV0sgRtvWguE9SobXFYNdw
	 ClhsdUIvwPyfzfAd+XeT/JQ5MtCRtjegffTL4YeiMAwTwSfCb9k77v5gFOVLmhUpKy
	 VYHzzZXLAdv9xzXZj/lrKYrLB5diO6XmkXYCixEjE5jI7GVtxQxUpXMNKybtxiJAEr
	 DXDmmmDy5eD+w==
Date: Thu, 27 Feb 2025 17:50:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, akpm@linux-foundation.org, alistair@popple.id.au,
        linux@rasmusvillemoes.dk, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-serial@vger.kernel.org,
        bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
User-Agent: K-9 Mail for Android
In-Reply-To: <20250227215741.1c2e382f@pumpkin>
References: <20250223164217.2139331-1-visitorckw@gmail.com> <20250223164217.2139331-3-visitorckw@gmail.com> <Z7zIBwH4aUA7G9MY@thinkpad> <20250226222911.22cb0c18@pumpkin> <Z8CpaaHv0ahHFVuK@thinkpad> <20250227215741.1c2e382f@pumpkin>
Message-ID: <EF874FA4-2719-44EA-B0DB-93A0980142BE@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2025 1:57:41 PM PST, David Laight <david=2Elaight=2Elinux@g=
mail=2Ecom> wrote:
>On Thu, 27 Feb 2025 13:05:29 -0500
>Yury Norov <yury=2Enorov@gmail=2Ecom> wrote:
>
>> On Wed, Feb 26, 2025 at 10:29:11PM +0000, David Laight wrote:
>> > On Mon, 24 Feb 2025 14:27:03 -0500
>> > Yury Norov <yury=2Enorov@gmail=2Ecom> wrote:
>> > =2E=2E=2E=2E =20
>> > > +#define parity(val)					\
>> > > +({							\
>> > > +	u64 __v =3D (val);				\
>> > > +	int __ret;					\
>> > > +	switch (BITS_PER_TYPE(val)) {			\
>> > > +	case 64:					\
>> > > +		__v ^=3D __v >> 32;			\
>> > > +		fallthrough;				\
>> > > +	case 32:					\
>> > > +		__v ^=3D __v >> 16;			\
>> > > +		fallthrough;				\
>> > > +	case 16:					\
>> > > +		__v ^=3D __v >> 8;			\
>> > > +		fallthrough;				\
>> > > +	case 8:						\
>> > > +		__v ^=3D __v >> 4;			\
>> > > +		__ret =3D  (0x6996 >> (__v & 0xf)) & 1;	\
>> > > +		break;					\
>> > > +	default:					\
>> > > +		BUILD_BUG();				\
>> > > +	}						\
>> > > +	__ret;						\
>> > > +})
>> > > + =20
>> >=20
>> > You really don't want to do that!
>> > gcc makes a right hash of it for x86 (32bit)=2E
>> > See https://www=2Egodbolt=2Eorg/z/jG8dv3cvs =20
>>=20
>> GCC fails to even understand this=2E Of course, the __v should be an
>> __auto_type=2E But that way GCC fails to understand that case 64 is
>> a dead code for all smaller type and throws a false-positive=20
>> Wshift-count-overflow=2E This is a known issue, unfixed for 25 years!
>
>Just do __v ^=3D __v >> 16 >> 16
>
>>=20
>> https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D4210
>> =20
>> > You do better using a __v32 after the 64bit xor=2E =20
>>=20
>> It should be an __auto_type=2E I already mentioned=2E So because of tha=
t,
>> we can either do something like this:
>>=20
>>   #define parity(val)					\
>>   ({							\
>>   #ifdef CLANG                                          \
>>   	__auto_type __v =3D (val);			\
>>   #else /* GCC; because of this and that */             \
>>   	u64 __v =3D (val);			        \
>>   #endif                                                \
>>   	int __ret;					\
>>=20
>> Or simply disable Wshift-count-overflow for GCC=2E
>
>For 64bit values on 32bit it is probably better to do:
>int p32(unsigned long long x)
>{
>    unsigned int lo =3D x;
>    lo ^=3D x >> 32;
>    lo ^=3D lo >> 16;
>    lo ^=3D lo >> 8;
>    lo ^=3D lo >> 4;
>    return (0x6996 >> (lo & 0xf)) & 1;
>}
>That stops the compiler doing 64bit shifts (ok on x86, but probably not e=
lsewhere)=2E
>It is likely to be reasonably optimal for most 64bit cpu as well=2E
>(For x86-64 it probably removes a load of REX prefix=2E)
>(It adds an extra instruction to arm because if its barrel shifter=2E)
>
>
>>=20
>> > Even the 64bit version is probably sub-optimal (both gcc and clang)=
=2E
>> > The whole lot ends up being a bit single register dependency chain=2E
>> > You want to do: =20
>>=20
>> No, I don't=2E I want to have a sane compiler that does it for me=2E
>>=20
>> > 	mov %eax, %edx
>> > 	shrl $n, %eax
>> > 	xor %edx, %eax
>> > so that the 'mov' and 'shrl' can happen in the same clock
>> > (without relying on the register-register move being optimised out)=
=2E
>> >=20
>> > I dropped in the arm64 for an example of where the magic shift of 699=
6
>> > just adds an extra instruction=2E =20
>>=20
>> It's still unclear to me that this parity thing is used in hot paths=2E
>> If that holds, it's unclear that your hand-made version is better than
>> what's generated by GCC=2E
>
>I wasn't seriously considering doing that optimisation=2E
>Perhaps just hoping is might make a compiler person think :-)
>
>	David
>
>>=20
>> Do you have any perf test?
>>=20
>> Thanks,
>> Yury
>

What the compiler people need to do is to not make __builtin_parity*() gen=
erate crap=2E

