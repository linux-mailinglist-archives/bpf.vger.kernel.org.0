Return-Path: <bpf+bounces-54723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379C9A70AB2
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2313B0458
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7401F1818;
	Tue, 25 Mar 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kdM3Nj1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0B19ABD4;
	Tue, 25 Mar 2025 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932066; cv=none; b=SPBCxHYGTFJDsJuxke/a+nhPLdzzw0O2K0qB2VPErv6T1LVKvU05yVpSeeDs4k88mmGKkwVTrgs3D2FjPm2vwb8fWUSTWgsuEnK+erQk5iiy4MefiNwy5eKqDqdOod03NnIIDFGgjZnHDPULQ+nDVrvpQ5lMYvYIXV/pLbcST8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932066; c=relaxed/simple;
	bh=FQrF/wafsCwtQ5RHtBLJtng6uuJETqkLf6oOWt6uk9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOmKyxxzZDc4fAJ6QMrrVbwN+K/r5xeSJcn5yxbIwfqgHrqvSPqbZCPSksg+bGpCNP777kOfa20WFjq3GsYXrhpV+Ia5BiBfhn/m7a5Qp7xWx0MvlbR+/jcgj2IPv6Fyy+yB0SSq1MvrbFa6T4ZAwo4qD0WW1R3Vm0d3Hfyu1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kdM3Nj1M; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8083:1982:248d:9102:5b8a:6e6c] ([IPv6:2601:646:8083:1982:248d:9102:5b8a:6e6c])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52PJhUIl603946
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Mar 2025 12:43:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52PJhUIl603946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1742931824;
	bh=UJj21FC15p3nVLzkicX5dgxkBEi54nR03XqBTpnd5V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kdM3Nj1MybR90X09rU1nRONRJ2jg1AtjqKoXLnxsg2cojdKgyvQq1sB0dmO1P9B7e
	 Oh0GOCPxLEaRXZFe7o1Sfjp8n54w75H5iN/HAzeysNqCT9wYOr7jEP2Dae4W47cuTE
	 IJENwVV1LUrY+RUTP8SIu8IuTBsqVtESVxKjQe2igsVqYUE9/vC+W48eqqzXH+7yPQ
	 lLYCfriDAqV0glFFkq5y8djhKy78jC5zQ7rOCh2GQVPUddqvu2o3Kp1cuthMCi7rCc
	 T1rY4JTt0lRSRGlEjcanOa/VKXXmOhoSIUQpV16G1iV32q6fHAz8KlUXWCNdcW9vny
	 jM4Umn7OoVMWA==
Message-ID: <eec0dfd7-5e4f-4a08-928c-b7714dbc4a17@zytor.com>
Date: Tue, 25 Mar 2025 12:43:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] Introduce and use generic parity16/32/64 helper
To: Kuan-Wei Chiu <visitorckw@gmail.com>, Yury Norov <yury.norov@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
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
        vigneshr@ti.com, x86@kernel.org
References: <efc2ee9d-5382-457f-b471-f3c44b81a190@citrix.com>
 <5A790652-1B22-4D13-AAC5-5D9931E90903@zytor.com>
 <20250307195310.58abff8c@pumpkin>
 <EB85C3C1-8A0D-4CB9-B501-BFEABDF3E977@zytor.com>
 <Z824SgB9Dt5zdWYc@visitorckw-System-Product-Name> <Z9CyuowYsZyez36c@thinkpad>
 <80771542-476C-493E-858A-D2AF6A355CC1@zytor.com> <Z9GtcNJie8TRKywZ@thinkpad>
 <Z9G2Tyypb3iLoBjn@visitorckw-System-Product-Name>
 <Z9KMKwnZXA2mkD2s@visitorckw-System-Product-Name>
 <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Z+AlyB461xwMxMtG@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/25 08:16, Kuan-Wei Chiu wrote:
> 
> Interface 3: Multiple Functions
> Description: bool parity_odd8/16/32/64()
> Pros: No need for explicit casting; easy to integrate
>        architecture-specific optimizations; except for parity8(), all
>        functions are one-liners with no significant code duplication
> Cons: More functions may increase maintenance burden
> Opinions: Only I support this approach
> 

OK, so I responded to this but I can't find my reply or any of the 
followups, so let me go again:

I prefer this option, because:

a. Virtually all uses of parity is done in contexts where the sizes of 
the items for which parity is to be taken are well-defined, but it is 
*really* easy for integer promotion to cause a value to be extended to 
32 bits unnecessarily (sign or zero extend, although for parity it 
doesn't make any difference -- if the compiler realizes it.)

b. It makes it easier to add arch-specific implementations, notably 
using __builtin_parity on architectures where that is known to generate 
good code.

c. For architectures where only *some* parity implementations are 
fast/practical, the generic fallbacks will either naturally synthesize 
them from components via shift-xor, or they can be defined to use a 
larger version; the function prototype acts like a cast.

d. If there is a reason in the future to add a generic version, it is 
really easy to do using the size-specific functions as components; this 
is something we do literally all over the place, using a pattern so 
common that it, itself, probably should be macroized:

#define parity(x) 				\
({						\
	typeof(x) __x = (x);			\
	bool __y;				\
	switch (sizeof(__x)) {			\
		case 1:				\
			__y = parity8(__x);	\
			break;			\
		case 2:				\
			__y = parity16(__x);	\
			break;			\
		case 4:				\
			__y = parity32(__x);	\
			break;			\
		case 8:				\
			__y = parity64(__x);	\
			break;			\
		default:			\
			BUILD_BUG();		\
			break;			\
	}					\
	__y;					\
})
				

