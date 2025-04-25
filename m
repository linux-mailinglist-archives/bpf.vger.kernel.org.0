Return-Path: <bpf+bounces-56684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA1A9C206
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E9E17407F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301FD21D5B3;
	Fri, 25 Apr 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="C05ahXwG"
X-Original-To: bpf@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC01202C26
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571072; cv=none; b=W1HCMIseH5RhfDuQx7nmH8Dj2P4O3XijLwst6c601i7BqTD8C1bbHyAsj7lJi1I1Ct/rLS9o8tzS492EmfbwKxeIHiPyWByIXzHYhjxqhJYr00zPGvCOvbV6NGmFliitsxjfyUMKBzg+AtjCNz+a5tS1gZtwLr+XJwnSgNw81bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571072; c=relaxed/simple;
	bh=QKM81Z5OKSv3auXVAY478OddXt6QHpbIxR9wosP5Auo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T98RQ5n+5sEbv25hhIwHYFCaX9pJkGQjO2mDN2yMfo/yEsT7pvwI5/f6XgTeOWdypoSljhYzo1tIWhoiwWmw/pElR5ds246l38NkzIRle79h8dkfPCBeihu1TLflWtZrA9U/gFLBW3RnjLwMkmoZ061tC6uAeY8k/nKpy83PVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=C05ahXwG; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 93f16712-21b2-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 93f16712-21b2-11f0-b9a0-005056abbe64;
	Fri, 25 Apr 2025 10:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=ZUUJHctHfNsWNu1EuQFACb2hrUYidSMtniMgESDbRMU=;
	b=C05ahXwGA4fFgl5pI9IJHaOIC76m8R/+Es89bI5CvWoa6HqeHuMK1mldeMHIPdQDi2kLlgzYGuFDe
	 D6MuwZeTwD9wDa1XBMVKPiXUdLXcq+GTqnyBHWJmMljRXk48AhzZTUw4w3JcILCX9BZqxzGIjcGt45
	 rVpMjojPveoEKJh8q2SHsNUin5NrH2hHy2UM/ToU41fRmD9iRhfZFZVHgj6RTwNoFsLryLF3BsJztF
	 gaTSBezUZK3uueMs3FZ29rF3MDkksrwOCGH4rjzRi2+4egWucO06G46ulnDHCSBicLhtJMzaffZPP7
	 sV5V8wKP1no2OVYkOrkoy9/F8HuD5EA==
X-KPN-MID: 33|AF0t4UVO0ldgi6YmnFhYJXqAPxHkuBjosJGcKGQA7S6P7Abi1YftYhe8yCepFKM
 Um9AVCIhpwBzaPi+MzlrzvCTD1SHpo9+IS4F4rFr5JFU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nqQMCrwmB3CHOeiz1JE1vwIQX38ApX4EwzMJX9cEX5ZmT/5GDgIxRdtlrbvDrcJ
 3U9+ukECS2iUUeZHN8Kv+nQ==
Received: from [192.168.1.10] (80-60-128-215.fixed.kpn.net [80.60.128.215])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 6c670738-21b2-11f0-95a4-005056abf0db;
	Fri, 25 Apr 2025 10:51:06 +0200 (CEST)
Message-ID: <7d0096ad-a290-4fbc-8c06-dba49e8db8af@xs4all.nl>
Date: Fri, 25 Apr 2025 10:51:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] media: pci: cx18-av-vbi: Replace open-coded
 parity calculation with parity_odd()
To: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
 eajames@linux.ibm.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, johannes@sipsolutions.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, yury.norov@gmail.com,
 akpm@linux-foundation.org, jdelvare@suse.com, linux@roeck-us.net,
 alexandre.belloni@bootlin.com, pgaj@cadence.com, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Frank.Li@nxp.com, linux-hwmon@vger.kernel.org,
 linux-i3c@lists.infradead.org, david.laight.linux@gmail.com,
 andrew.cooper3@citrix.com, Yu-Chun Lin <eleanor15x@gmail.com>
References: <20250409154356.423512-1-visitorckw@gmail.com>
 <20250409154356.423512-4-visitorckw@gmail.com>
 <25b7888d-f704-493b-a2d7-c5e8fff9cfb4@broadcom.com>
 <Z/bDnLzcajzIxey3@visitorckw-System-Product-Name>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <Z/bDnLzcajzIxey3@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2025 20:59, Kuan-Wei Chiu wrote:
> On Wed, Apr 09, 2025 at 08:43:09PM +0200, Arend van Spriel wrote:
>> On 4/9/2025 5:43 PM, Kuan-Wei Chiu wrote:
>>> Refactor parity calculations to use the standard parity_odd() helper.
>>> This change eliminates redundant implementations.
>>>
>>> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
>>> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>> ---
>>>   drivers/media/pci/cx18/cx18-av-vbi.c | 12 ++----------
>>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/media/pci/cx18/cx18-av-vbi.c b/drivers/media/pci/cx18/cx18-av-vbi.c
>>> index 65281d40c681..15b515b95956 100644
>>> --- a/drivers/media/pci/cx18/cx18-av-vbi.c
>>> +++ b/drivers/media/pci/cx18/cx18-av-vbi.c
>>
>> [...]
>>
>>> @@ -278,7 +270,7 @@ int cx18_av_decode_vbi_line(struct v4l2_subdev *sd,
>>>   		break;
>>>   	case 6:
>>>   		sdid = V4L2_SLICED_CAPTION_525;
>>> -		err = !odd_parity(p[0]) || !odd_parity(p[1]);
>>> +		err = !parity_odd(p[0]) || !parity_odd(p[1]);
>>
>> No need to call parity_odd() twice here. Instead you could do:
>>
>> 		err = !parity_odd(p[0] ^ p[1]);

I prefer the original approach, it is easier to understand. Performance
is not an issue here, clarity of the code is more important.

So for this patch (i.e. this v4 version):

Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>

>>
>> This is orthogonal to the change to parity_odd() though. More specific to
>> the new parity_odd() you can now do following as parity_odd() argument is
>> u64:
>>
>> 		err = !parity_odd(*(u16 *)p);
>>
>>
> Thanks for the feedback!
> Would you prefer this change to be part of the parity() conversion
> patch, or in a separate one?

Just leave it as-is, as mentioned above.

Regards,

	Hans

> 
> Regards,
> Kuan-Wei


