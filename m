Return-Path: <bpf+bounces-52171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF74A3F31E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 12:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB785189F413
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ACB209F24;
	Fri, 21 Feb 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="deOZsFKN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A720207DF8;
	Fri, 21 Feb 2025 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137977; cv=none; b=LmF0+eq1qNKRVBFuO5WVyR+DXkmYSaYfZEynwCb3/2zrewlDBkCEpBcLIOoQpwqs3XnchNNCRVXcHHVk8hEpv+iwaMg8r36uvZ+k/TvbEC6Dd8VvTtNPPM6hG0V0PtV0X2zctJt129q6qkVgIX44FTPt6x5jgOj1cb5uCazPweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137977; c=relaxed/simple;
	bh=Sml3o/HkUO8vLaWWXWZk2o3At1Jy/794DhB7GIldb6s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FanRKyu7Iw3SFIxYfNJFJwrxER4X442MQRy8gCB/2U7j3rZYv+xWJIUArfpVFyBERgWElyQZqIVaLrnS98MknBPtCnlEHcWSoBcbOoMCQXcx7kEOijrNwGvS+eTSyt0+KdZJRpok5R44feWBTiDJGJ9o+/yxIU2qtYzXiGPScMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=deOZsFKN; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59d4d.dip0.t-ipconnect.de [217.229.157.77])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 305C82FC0182;
	Fri, 21 Feb 2025 12:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1740137966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqXUo1FZ4TpebA15goo8baRIskVIN6WUi38uv9gPwFc=;
	b=deOZsFKNmuJi0lPeSPivrTX2+2wjtvvKLqs7wSbApPPMJx4ziaoUyUlgNkvW+JfIP1tVeh
	7e/mRwslMZtcjVNpm2dPNZABksf3cyyJYZwFCmc00DVTLG8/NOqGPhZOwxBn6/nU2bACwZ
	wdhXvtekzZvIu+hG/nglgxoVs3tvMok=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ea88c72e-a03f-4aac-9182-ece94fb99e54@tuxedocomputers.com>
Date: Fri, 21 Feb 2025 12:39:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] platform/x86/tuxedo: Add virtual LampArray for
 TUXEDO NB04 devices
From: Werner Sembach <wse@tuxedocomputers.com>
To: Pavel Machek <pavel@ucw.cz>, Armin Wolf <W_Armin@gmx.de>,
 Benjamin Tissoires <bentiss@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: ilpo.jarvinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 jelle@vdwaa.nl, jikos@kernel.org, lee@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 ojeda@kernel.org, onitake@gmail.com, cs@tuxedo.de,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org
References: <20250121225510.751444-1-wse@tuxedocomputers.com>
 <aa91e17f-0ea8-4645-a0f9-57c016e36a9e@gmx.de> <Z53f7VNIgUWWFn9l@duo.ucw.cz>
 <b69e2766-2238-4913-ae2d-21d8716f2eef@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <b69e2766-2238-4913-ae2d-21d8716f2eef@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 06.02.25 um 17:18 schrieb Werner Sembach:
> Hi,
>
> Am 01.02.25 um 09:48 schrieb Pavel Machek:
>> Hi!
>>
>>>> I now got my feet a little wet with hid-bpf regarding something else, and
>>>> with that knowledge I would leave the long arrays in the beginning in the
>>>> kernel code for the time being:
>>>>
>>>> sirius_16_ansii_kbl_mapping and sirius_16_iso_kbl_mapping are required
>>>> during initialization so they have to exist in the kernel code anyway.
>>>>
>>>> report_descriptor will most likly not change even for future models and
>>>> afaik having report_descriptors in kernel drivers is not unheard of.
>>>>
>>>> So the only things that could be meaningfully moved to a hid-bpf program
>>>> are the sirius_16_*_kbl_mapping_pos_* arrays. But for these is have to give
>>>> out some fallback value anyway for the case where a hid-bpf file is missing
>>>> or fails to load. So why not use real world values from my test device for
>>>> these values?
>>>>
>>>> As soon as there is a future device that can use the same driver with just
>>>> these pos arrays different, then I would implement that change via a bpf
>>>> program instead of a change to the kernel driver.
>>>>
>>>> Let me know if you too think this is a sensefull approach?
>>>>
>>>>
>>>> Another question: Would this patch need to wait for a userspace
>>>> implementation of lamp array before it can get accepted?
>>> It would be nice if you could test the LampArray implementation. But other 
>>> than that
>>> userspace can catch up later.
>>>
>>> Still, i am interested in the opinion of the LED maintainers
>>> regarding the fake HID interface.
>> Comments from previous review were not addressed.
>>
>> Most importantly, this is not a way to do kernel interface. We want
>> reasonable interface that can be documented and modified as needed. We
>> want to pass /dev/input to userspace, not raw HID. This is not ok.
>
> There are already 2 endless discussions about this:
>
> https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com/ 
>
>
> https://lore.kernel.org/all/73c36418-34d6-46cf-9f10-6ca5e569274f@tuxedocomputers.com/ 
>
>
> And a shorter one before that:
>
> https://lore.kernel.org/all/30cbbf20-08cf-a69b-4f58-359a9802e86f@tuxedocomputers.com/ 
>
>
> The brief:
>
> - LampArray is a standard that will hit the Linux world anyway.
>
> - The alternative proposal via a led matrix does not even really fit 
> keyboards, and does not at all fit all other device types.
>
> Hans and Benjamin already agree with me that LampArray is the way to go.
>
> So after over 2 years can I please have a final decision on how to implement 
> this?

Any update?

Best regards,

Werner Sembach

>
> Regards,
>
> Werner
>
>>
>> Best regards,
>>                                 Pavel

