Return-Path: <bpf+bounces-53689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D6A585BF
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BB7188E5F3
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBB1DF973;
	Sun,  9 Mar 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AM2/bmW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8B1C1ADB;
	Sun,  9 Mar 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536708; cv=none; b=mwwxwWMEcexdIOjuNc0whUnjLUeUh4AGSFnUCVxfPp7FixaMLGXCoNphN4+X7q3Uirq2WPEkVpkzgD22n52C1clwX/OoH/iDRXFjzPh844+pP2ZCwiUUWAcOXepbujCC2wq+XuhCNqHxnsPS3pVDorzc/fllKqtcgyadpqng8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536708; c=relaxed/simple;
	bh=cYAeS9+iVeuoEKPY0soxgWjQHLxWo/CJqXIGMP5cXTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LJXxCe+0ePbImRN8BYYIxIpJJEsKz9MAGA9TYTB42dr/CgULJAzTEQdM3Ekey9OZEe6M2AX3so+3Pm2IJE+FcZCwbQDlOiifzXwRCNYFLRxrb/yCOBu/65cyIVvdDIy30HsiFQ5fgYohahjTpTijuOyZ8kpEMUJEwEzV4O8+PfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AM2/bmW6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 529G7ORJ1263742
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 9 Mar 2025 09:07:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 529G7ORJ1263742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741536453;
	bh=seT44xgoWZ5mbi6YMs1X0xb2oeGYrNPZX+/U1qdQGTg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AM2/bmW6qzoT4YywJnfg+kFnRXlll5tS36arYnqSjApIypQlKimmdfCt9YyV+hD5i
	 dwEfkCUr9AtGwtNwd8jvLKVyhS9+DVOhMt0UxbaU8XLll4G1zqhZUN5wna9XCG0iyW
	 78qL6sdm7Dmrl0dpbYygV8vUvwurgNltciei2+BotvHSOlc5nLcyRz7FcLa20sqElN
	 aaLYBYPsfdON+oOvyxzkWw0OSqmFW0xR+GLH1tZOAogct9w6ii64Fkp372iR+MOFjL
	 L/PbfQo7+FF9HFkiZXRXnx5Nau5yXjNHZfL42nnEtecfgu8tqCoFLf4g4XN6869eDo
	 eXA4gSO7d9tjA==
Date: Sun, 09 Mar 2025 09:00:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
CC: David Laight <david.laight.linux@gmail.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
        akpm@linux-foundation.org, alistair@popple.id.au,
        andrew+netdev@lunn.ch, andrzej.hajda@intel.com,
        arend.vanspriel@broadcom.com, awalls@md.metrocast.net, bp@alien8.de,
        bpf@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211@lists.linux.dev, dave.hansen@linux.intel.com,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
        edumazet@google.com, eleanor15x@gmail.com, gregkh@linuxfoundation.org,
        hverkuil@xs4all.nl, jernej.skrabec@gmail.com, jirislaby@kernel.org,
        jk@ozlabs.org, joel@jms.id.au, johannes@sipsolutions.net,
        jonas@kwiboo.se, jserv@ccns.ncku.edu.tw, kuba@kernel.org,
        linux-fsi@lists.ozlabs.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux@rasmusvillemoes.dk,
        louis.peens@corigine.com, maarten.lankhorst@linux.intel.com,
        mchehab@kernel.org, mingo@redhat.com, miquel.raynal@bootlin.com,
        mripard@kernel.org, neil.armstrong@linaro.org, netdev@vger.kernel.org,
        oss-drivers@corigine.com, pabeni@redhat.com,
        parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
        simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de,
        vigneshr@ti.com, x86@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
User-Agent: K-9 Mail for Android
In-Reply-To: <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
References: <4732F6F6-1D41-4E3F-BE24-E54489BC699C@zytor.com> <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com> <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com> <20250307195310.58abff8c@pumpkin> <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com> <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name>
Message-ID: <EF4335E0-F8EB-4642-BD09-B16BCCF23F95@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 9, 2025 8:48:26 AM PDT, Kuan-Wei Chiu <visitorckw@gmail=2Ecom> wro=
te:
>On Fri, Mar 07, 2025 at 12:07:02PM -0800, H=2E Peter Anvin wrote:
>> On March 7, 2025 11:53:10 AM PST, David Laight <david=2Elaight=2Elinux@=
gmail=2Ecom> wrote:
>> >On Fri, 07 Mar 2025 11:30:35 -0800
>> >"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>> >
>> >> On March 7, 2025 10:49:56 AM PST, Andrew Cooper <andrew=2Ecooper3@ci=
trix=2Ecom> wrote:
>> >> >> (int)true most definitely is guaranteed to be 1=2E =20
>> >> >
>> >> >That's not technically correct any more=2E
>> >> >
>> >> >GCC has introduced hardened bools that intentionally have bit patte=
rns
>> >> >other than 0 and 1=2E
>> >> >
>> >> >https://gcc=2Egnu=2Eorg/gcc-14/changes=2Ehtml
>> >> >
>> >> >~Andrew =20
>> >>=20
>> >> Bit patterns in memory maybe (not that I can see the Linux kernel us=
ing them) but
>> >> for compiler-generated conversations that's still a given, or the ma=
nager isn't C
>> >> or anything even remotely like it=2E
>> >>=20
>> >
>> >The whole idea of 'bool' is pretty much broken by design=2E
>> >The underlying problem is that values other than 'true' and 'false' ca=
n
>> >always get into 'bool' variables=2E
>> >
>> >Once that has happened it is all fubar=2E
>> >
>> >Trying to sanitise a value with (say):
>> >int f(bool v)
>> >{
>> >	return (int)v & 1;
>> >}   =20
>> >just doesn't work (see https://www=2Egodbolt=2Eorg/z/MEndP3q9j)
>> >
>> >I really don't see how using (say) 0xaa and 0x55 helps=2E
>> >What happens if the value is wrong? a trap or exception?, good luck re=
covering
>> >from that=2E
>> >
>> >	David
>>=20
>> Did you just discover GIGO?
>
>Thanks for all the suggestions=2E
>
>I don't have a strong opinion on the naming or return type=2E I'm still a
>bit confused about whether I can assume that casting bool to int always
>results in 0 or 1=2E
>
>If that's the case, since most people prefer bool over int as the
>return type and some are against introducing u1, my current plan is to
>use the following in the next version:
>
>bool parity_odd(u64 val);
>
>This keeps the bool return type, renames the function for better
>clarity, and avoids extra maintenance burden by having just one
>function=2E
>
>If I can't assume that casting bool to int always results in 0 or 1,
>would it be acceptable to keep the return type as int?
>
>Would this work for everyone?
>
>Regards,
>Kuan-Wei

You *CAN* safely assume that bool is an integer type which always has the =
value 0 or 1=2E

