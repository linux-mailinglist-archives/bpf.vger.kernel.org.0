Return-Path: <bpf+bounces-50266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F862A2470F
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 05:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD19166A9C
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 04:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB848762F7;
	Sat,  1 Feb 2025 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MQIh6QsA"
X-Original-To: bpf@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68217BCE;
	Sat,  1 Feb 2025 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738384816; cv=none; b=rgtaCBDTe9CaT0KIJZCYf2MWWotm1tPtsjtGxXtX0DpQ7Qx/ohjZtrwsDbHr70Kkc2gkCELAebd+Q8FQvDOkY/lRKZUBz63YF/lup2A9US6YPhWH5QFjgsPHhAyoPaM1vNhF/ZY2qASg2EP/P0Jclu+2e29WCe7tAaPgJcsLqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738384816; c=relaxed/simple;
	bh=xo7/q6vlZdNeRWEWkoAlNw1e0d6k7F8xJ30Ok5ww660=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1oF/TfvyQYcWuupYNpfUtQoMMJco5e9Y9BVefvrqo6rvV/qE14Dcyxy5QV7PCpdvY249lOqsZq1Jm7pku1PhSAwnjfotHU86Gk976O92Okw5a4Cut9jo9XlfcXWlJOZ2Fr68HV7o9Qu6HKcQ6Dto3ln+8Y/vB8pI/Bt/0Ub+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MQIh6QsA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738384794; x=1738989594; i=w_armin@gmx.de;
	bh=LT750kSE9bF5YLcER4OJ17oUOtS5kE1L/aK//c9KpYI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MQIh6QsAP4n0PL5GuCxKJSQGqExqVDlX8C3QweLaIBInAPuSUu5+alz23ie5iJZX
	 uh12nG66lz5URpJzwQoX/sOmnMRFDG4d+Nac8sQRbTA+b/kIEn0ea0Mam748kIxRZ
	 +pOHSkrqmvoZ5wLF7TYwJ/BMnnYAsRQXA5lNDAaq/+TyiHB7HIJldx2OVkJ3LEMYH
	 wCL8an077w8wRcAtbpGzMIcw/Q6l0rM/V9JnhMt9bwpFRi0ytl4F0ZmlTvn+321k1
	 Ffv2PYhxHQqrNZ0Yu6S6FYebwxjrncDj5mBpeO2f3BxrFHfM4ZLPDe/gauNkCtIK7
	 GuEfn1+/IAfFX0ks0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.246.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1tVSRe3BeV-00w1d9; Sat, 01
 Feb 2025 05:39:54 +0100
Message-ID: <aa91e17f-0ea8-4645-a0f9-57c016e36a9e@gmx.de>
Date: Sat, 1 Feb 2025 05:39:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] platform/x86/tuxedo: Add virtual LampArray for
 TUXEDO NB04 devices
To: Werner Sembach <wse@tuxedocomputers.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, bentiss@kernel.org
Cc: dri-devel@lists.freedesktop.org, jelle@vdwaa.nl, jikos@kernel.org,
 lee@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 ojeda@kernel.org, onitake@gmail.com, pavel@ucw.cz, cs@tuxedo.de,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
References: <20250121225510.751444-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250121225510.751444-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pALTMLKB7mMHQQycS43ma88A2gx+nB8dmXITJNjbom2JBMqBRwE
 yAREBGOKW1CJoi+K++E1AoG5I2TTJ3LGkOF+Q14cht0DRbV1t9GJ6+lHcIVg0oJWMYtkQLK
 BS+43+pJ+E5bHQHrjEidOHxT4AK7lzOO5Tjx7s8SGOOVZSPebrPUL9OVWSV1avdJcvo369N
 zkbXj4deyhIg2gyAkXBMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BBsPRm+lS0Q=;NcG0FE4KxwiBnnABDwi8c+B+uPO
 /vV9XuJGHiA78dys94k6fetrooym5vY5GtRjNXq7+TS0XITAK/pINMBIsB23SNsBb5eq+Kp2V
 XMJLniMCtaCwMYJCSgYw6sSQuj9u8bLy9BOrCbo424Z1WMGeO/xSGuO9udGBzdf7XA+Yjaos9
 JEM6oPZNSsGuASq976bBWWqzG6FQ+Zxv2VVfzuin5XMqunOplk4EfhwzPZ9BFBuP1LM40zfeV
 Zf512LtToicTjtomIcdbAOdQ03I7YZ4xOF1gwpMtmCZToST3QOeAJzkrifJXKFdujkd5DOS2o
 sK/APJi3ay1jpAkbGovg1DZpIcIWH4iSRpKDi2EaawzzLi2GrxMdnZRkjMdQ7lQeDI+XaLMmo
 uud8cMSNfmGFhntp4n0HDxnCnrJJ8bRvEF5v4V6iuvavxVFrYmBcZmckhEzSTNEMqft9yorUx
 U6vMjQptJLL7ObBhVmkibA9KQEmFo/svFIpy3Hoz64ByFKwGh2zt9E10epNVeMfcRPAG8Ph16
 44AJO1ma6eCpjIXFatkJqD9HUF0uvrZdfvLt07IXI1akqsPzQ3/CLXdZXeUdw79jsS4b80tLN
 tXL0O1rhSTiSskxiwygqmG7WRmLMkLOpnxFw03WzrlPWzE0kJWIVfSz6KGKls7InESvzVDJ+J
 X9CnCv+AUbT3M57HSAM6SxX3ipqXr5Wl6Ko+yoxcjqQ8blINi6vslVvXk+Jmy35dGDNu7nR5Y
 2ZHaBkf4gUsZ/YgKhkGuZ0lwVHBGPi34F9MQWUoQzhopA/OFJ+4VsljX9U9OSlvZKAtU3VQpl
 d5mkaFir9d4fl1CTI5mB9KBmvQ/uS8t9gBbte+MHFB9KOfSi/xjIhh95BeiwthI9Wb6MFBgB2
 Z7C+uHaJe1G0maH1tWwIy9LniKQgjHujVlAejxnGtR6g0qEb+btqtxDEJmq4ozXMrn283ItoL
 Jyio6sANk8uhN2OcgJ1rhIvhoGdMC2DHNlPFCtO7ep8MhPzDl230tmrlyV7wdEP9kPLXmI81V
 ramRIko9M9455Vaf1gJshjEtbDj/jVNJ0UoHKNDAV+AnTY3q1Hq4cB+CFDRtjBa/Kg+4KXSRx
 s0VzBEeY6JSfR6r/HIbiSW5KYX512B4qSKG9vkpidJcWNyMdD1KL+AMmrQf3kSGp3aWydsTRQ
 /Z14IGlLtRhqw3BAuxj4kRF6tpW3xmjx1lPt/zqVZPzh2NfIRWABTseRJ5k9i5TBbkM3kVBZb
 4e7kDj/3jBJDR7wRMRM3TUVWnCbQ8hSATAd6YTVQNCPYwXWNx2LwIamI/toVCsFZ2bMJHSqJn
 DYTRVR3puZcIR6HBKmtacjDq1RvwmTjOCrw9Zhak+9Ejn8=

Am 21.01.25 um 23:31 schrieb Werner Sembach:

> Hi,
> after some other work, picked this up again.
> Only coding style changes vs v4.
>
>
> I now got my feet a little wet with hid-bpf regarding something else, and
> with that knowledge I would leave the long arrays in the beginning in the
> kernel code for the time being:
>
> sirius_16_ansii_kbl_mapping and sirius_16_iso_kbl_mapping are required
> during initialization so they have to exist in the kernel code anyway.
>
> report_descriptor will most likly not change even for future models and
> afaik having report_descriptors in kernel drivers is not unheard of.
>
> So the only things that could be meaningfully moved to a hid-bpf program
> are the sirius_16_*_kbl_mapping_pos_* arrays. But for these is have to give
> out some fallback value anyway for the case where a hid-bpf file is missing
> or fails to load. So why not use real world values from my test device for
> these values?
>
> As soon as there is a future device that can use the same driver with just
> these pos arrays different, then I would implement that change via a bpf
> program instead of a change to the kernel driver.
>
> Let me know if you too think this is a sensefull approach?
>
>
> Another question: Would this patch need to wait for a userspace
> implementation of lamp array before it can get accepted?

It would be nice if you could test the LampArray implementation. But other than that
userspace can catch up later.

Still, i am interested in the opinion of the LED maintainers regarding the fake HID interface.

Thanks,
Armin Wolf

>
> The folder structure and naming scheme with nb04 is im preparation for
> other parts of tuxedo-drivers to be upstreamed. NB04 is one of the
> board_vendor dmi strings on TUXEDO devices that aligns with which part of
> tuxedo-drivers implements the features of that device. They are independent
> of each other so I plan to put them in different subfolders to reflect
> that.
>
> Best regards,
> Werner Sembach
>
> Werner Sembach (1):
>    platform/x86/tuxedo: Add virtual LampArray for TUXEDO NB04 devices
>
>   MAINTAINERS                                   |   6 +
>   drivers/platform/x86/Kconfig                  |   2 +
>   drivers/platform/x86/Makefile                 |   3 +
>   drivers/platform/x86/tuxedo/Kbuild            |   6 +
>   drivers/platform/x86/tuxedo/Kconfig           |   6 +
>   drivers/platform/x86/tuxedo/nb04/Kbuild       |   9 +
>   drivers/platform/x86/tuxedo/nb04/Kconfig      |  14 +
>   .../platform/x86/tuxedo/nb04/wmi_ab_init.c    | 103 +++
>   .../platform/x86/tuxedo/nb04/wmi_ab_init.h    |  18 +
>   .../x86/tuxedo/nb04/wmi_ab_virt_lamparray.c   | 772 ++++++++++++++++++
>   .../x86/tuxedo/nb04/wmi_ab_virt_lamparray.h   |  18 +
>   .../platform/x86/tuxedo/nb04/wmi_xx_util.c    |  97 +++
>   .../platform/x86/tuxedo/nb04/wmi_xx_util.h    | 112 +++
>   13 files changed, 1166 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_init.c
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_init.h
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_virt_lamparray.c
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_ab_virt_lamparray.h
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_xx_util.c
>   create mode 100644 drivers/platform/x86/tuxedo/nb04/wmi_xx_util.h
>

