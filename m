Return-Path: <bpf+bounces-53605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF8A57209
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF871899528
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72910256C75;
	Fri,  7 Mar 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JpM4cAI/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0A6241691;
	Fri,  7 Mar 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376225; cv=none; b=uTrnD7dcj8jkxrKoaV/uGt1OuoxBJpzaEiLGweYnHNJfxiaEwvUW6ybFRwBQC/G0CI/wm0E7eTTgqQ41IU9A7nB8eltq5NvANdce2TsKb7SY+H8kYhvM51JFi/OIN8qW37abRFWXIqTGMllMkuQOI1KU4/FNYBuuItc9KUpMabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376225; c=relaxed/simple;
	bh=lGOlEUKYMEj4dil0Op2XWbTDHNW0cDTVOQuuf8NM8P8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JleE7uEo4JlabypfKvFneOyyudRt/Tt6SG7R63UXwhPwWu50x9faOYJPMcRQpdHrL/uh31cxwL9X7gDDlfZEMBR9SigEtCR56ZIUHJdid4cHIxELG943VzYN5/iyV62Us9tnImW2H6wafNb1opGqIZrSBMvGkOZ8HSFNIn3Rq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JpM4cAI/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527JXgtA396336
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 11:33:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527JXgtA396336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741376026;
	bh=Rba/iYpx+v1WUJY9TbQtNNXz3bzAixuum4cy0AAzIQ8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JpM4cAI/6OO4nOvQdC38mdUbpbB1lWPHBSF4ljFw2qA3FLC4pjNg+SSz3ep6OIzF7
	 WYl+0db+AhekbzgxwomC3ymIRs5j71mlLZtD2iw8tO5cOhAoYMQ4MbYIxxObh+RsB1
	 GUcEWcPFEboLGkCpDZbKwA820RTWL1qGA26P0tk+SNSZddRBNxaRNIo9I6OO/l2PS1
	 suoEHlGlNSslZA0RrcNHi/ZRxh3u7yF1UBB/uL9NLK/IuoZSDmbFqv5gKyuDiKqw3E
	 CP62OwczhWCynLtrpzDYfzi+I/IgCMQrBEruwEEHJe0dh0Owv8tBZshia4KmpgLZct
	 MdGqjzEQfz58Q==
Date: Fri, 07 Mar 2025 11:33:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Kuan-Wei Chiu <visitorckw@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, jk@ozlabs.org, joel@jms.id.au, eajames@linux.ibm.com,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
        hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
        johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, alistair@popple.id.au,
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
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
User-Agent: K-9 Mail for Android
In-Reply-To: <Z8tJNt83uVBca0cj@thinkpad>
References: <20250306162541.2633025-1-visitorckw@gmail.com> <20250306162541.2633025-2-visitorckw@gmail.com> <9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org> <Z8ra0s9uRoS35brb@gmail.com> <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org> <Z8ri5h-nvNXNp6NB@gmail.com> <04AA7852-2D68-4B3F-9AA7-51AA57E3D23D@zytor.com> <Z8tJNt83uVBca0cj@thinkpad>
Message-ID: <783456A8-67F9-47DD-AB15-914622A921CD@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 11:30:08 AM PST, Yury Norov <yury=2Enorov@gmail=2Ecom> wro=
te:
>On Fri, Mar 07, 2025 at 04:14:34AM -0800, H=2E Peter Anvin wrote:
>> On March 7, 2025 4:13:26 AM PST, Ingo Molnar <mingo@kernel=2Eorg> wrote=
:
>> >
>> >* Jiri Slaby <jirislaby@kernel=2Eorg> wrote:
>> >
>> >> On 07=2E 03=2E 25, 12:38, Ingo Molnar wrote:
>> >> >=20
>> >> > * Jiri Slaby <jirislaby@kernel=2Eorg> wrote:
>> >> >=20
>> >> > > On 06=2E 03=2E 25, 17:25, Kuan-Wei Chiu wrote:
>> >> > > > Change return type to bool for better clarity=2E Update the ke=
rnel doc
>> >> > > > comment accordingly, including fixing "@value" to "@val" and a=
djusting
>> >> > > > examples=2E Also mark the function with __attribute_const__ to=
 allow
>> >> > > > potential compiler optimizations=2E
>> >> > > >=20
>> >> > > > Co-developed-by: Yu-Chun Lin <eleanor15x@gmail=2Ecom>
>> >> > > > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail=2Ecom>
>> >> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail=2Ecom>
>> >> > > > ---
>> >> > > >    include/linux/bitops=2Eh | 10 +++++-----
>> >> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
>> >> > > >=20
>> >> > > > diff --git a/include/linux/bitops=2Eh b/include/linux/bitops=
=2Eh
>> >> > > > index c1cb53cf2f0f=2E=2E44e5765b8bec 100644
>> >> > > > --- a/include/linux/bitops=2Eh
>> >> > > > +++ b/include/linux/bitops=2Eh
>> >> > > > @@ -231,26 +231,26 @@ static inline int get_count_order_long(u=
nsigned long l)
>> >> > > >    /**
>> >> > > >     * parity8 - get the parity of an u8 value
>> >> > > > - * @value: the value to be examined
>> >> > > > + * @val: the value to be examined
>> >> > > >     *
>> >> > > >     * Determine the parity of the u8 argument=2E
>> >> > > >     *
>> >> > > >     * Returns:
>> >> > > > - * 0 for even parity, 1 for odd parity
>> >> > > > + * false for even parity, true for odd parity
>> >> > >=20
>> >> > > This occurs somehow inverted to me=2E When something is in parit=
y means that
>> >> > > it has equal number of 1s and 0s=2E I=2Ee=2E return true for eve=
n distribution=2E
>> >> > > Dunno what others think? Or perhaps this should be dubbed odd_pa=
rity() when
>> >> > > bool is returned? Then you'd return true for odd=2E
>> >> >=20
>> >> > OTOH:
>> >> >=20
>> >> >   - '0' is an even number and is returned for even parity,
>> >> >   - '1' is an odd  number and is returned for odd  parity=2E
>> >>=20
>> >> Yes, that used to make sense for me=2E For bool/true/false, it no lo=
nger does=2E
>> >> But as I wrote, it might be only me=2E=2E=2E
>> >
>> >No strong opinion on this from me either, I'd guess existing practice=
=20
>> >with other parity functions should probably control=2E (If a coherent=
=20
>> >praxis exists=2E)=2E
>> >
>> >Thanks,
>> >
>> >	Ingo
>>=20
>> Instead of "bool" think of it as "bit" and it makes more sense
>
>So, to help people thinking that way we can introduce a corresponding
>type:
>        typedef unsigned _BitInt(1) u1;
>
>It already works for clang, and GCC is going to adopt it with std=3Dc23=
=2E
>We can make u1 an alias to bool for GCC for a while=2E If you guys like
>it, I can send a patch=2E
>
>For clang it prints quite a nice overflow warning:
>
>tst=2Ec:59:9: warning: implicit conversion from 'int' to 'u1' (aka 'unsig=
ned _BitInt(1)') changes value from 2 to 0 [-Wconstant-conversion]
>   59 |         u1 r =3D 2;
>      |            ~   ^
>
>Thanks,
>Yury

No, for a whole bunch of reasons=2E

