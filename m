Return-Path: <bpf+bounces-72663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139FC1793F
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8980D3B7E5B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7B2D0636;
	Wed, 29 Oct 2025 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qjrR4fQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A12D028A
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698290; cv=none; b=MKJ3JR/MzXwl5rwPT6CCFPGuQineayTyEtpmtPMOlyKSYetdqE8d1h28JqG1vdCuC9BvzRk5TAziEbBlsMvRAldWQLRzMfQ1xAjl3aKnfnjes8uoybmYHomS/Cp6mKkQpI5Oc0RH44E4q+t1/eEjamTFy3LKpppgQdRqWwSoJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698290; c=relaxed/simple;
	bh=VIMrZiv4ejWkRi8xSL7EbRSIeg7PtD0SWhypxJc8+I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtnqaFJD2lS7s458+gDI05J+QAbSkfpZNazwD/EBgVBmgbhM+P9nWDA2bKkScIMO3svd0/5+hnd2aVFVM4uHDHrpAUkbPyHzGtEn4ubonOm0e7RZIUG+AqylxO52DqzV3tMlce9NQxZNDJU1rRHdJ46xlOog5Bx8XGysuUTcjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=qjrR4fQh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so8721921b3a.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761698288; x=1762303088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hME+DIA0YpjKItlvze/YcoyGS3xZ7WFNsQRNJEZFagk=;
        b=qjrR4fQhigvWZnmeEoSOdOclbZvdzWPE3HcP38F4eRDgt+WlfrMP+PaSnUPaWVUMCs
         3GQ08Em2FGB5j8dhVrwlUo1VPZGFG6uMqQj5mwQ9vCN21cdFTbvH8Xilx4hQfgwJwjP2
         mxDRZfHRFq6aJtCdH+5Kt24jGbNkBP0VnUyoXb5K8AaeAGss8xKgdaoh/32ZWotELmW6
         wToFclmwjZlvLEG0DNdCj7wh2byrs2EFCJXwJesxupIyQY/Nw8hSa6QdMhZQLrHTqUoH
         43Jvt5lvcoNQNv2KMkm3M7mlous9fAt2c4j9XAXYHxXRUhy8m3prA9vVzVyFptzdAvqC
         9LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698288; x=1762303088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hME+DIA0YpjKItlvze/YcoyGS3xZ7WFNsQRNJEZFagk=;
        b=EZJLwfg1WowzlhYuVfn9OVYA8SHtKftSCgAeuOqRIqafuufAE5MdOLx9xb7iVln30K
         uXXDCNF4nFI1AhvIwH6dIu6opPvyKSW+0C89oucoMOvyLkPCXfny2QuUi9cJBvOAbY6t
         kWoAB/bvS73GdfBv4p6X3R0e8xAavIxo8aS1xwhgoFNOW2JA5e6LZzpLp63QRk8lj7qD
         ayrh84lnM/v15q2UV6T+s07UO2+o6oYczBHoDqsXXkddgWVtRwEOO9rJEv3IxS5iongR
         /PMC+KZcKMwjG1UshfbMEo/H7/1y7etjVXZ/yL7okoX7YGxJo2f7DQ57o0M3ybDLfQb3
         aptw==
X-Forwarded-Encrypted: i=1; AJvYcCWMM9dq6AoBVHuqn+9Ir/zdWBTalfd8f+Bm2UHgutLAPIFyZ7AroLqv8GNCqm3pKDvMNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdbYbJLNkGrx4KirtGdDEt4x/3xfwXj2YH3wPnx+jjvh8YURp
	b9gYasi6nsA5LTA/PcQHQjYbwS70wRgGK6ZRPGOjS903Ii0/9RTd8MuLpS3OOlFiHeo=
X-Gm-Gg: ASbGncu26za0GADuE1Tjwt9DJbVv98x8FgxM6Aep7vRq0uvtcfqijiU1oqUp4kwqYAs
	Pg4n6TZSSjowu8rKCob34e86jq3wlGlJE/gbNFxNlxfjlHjjeMFjo0wUC62PLj9cQV1Ft249Z6w
	QHus1Jfe8T89BXgEN924CTQltRMi0bPL8qOE8xS2hKaU0+rXWOOBBDO/4bVR+OCVEPvFb8X2Oyz
	9RoReOj1cDKcThPZdjcsEllJMwPNfDyOK+IA9Oy3aWWGaEatie0jSPpFjxukWVm0vjsJ6cP99JD
	wwgS0RDCAY74mLWDORZY+EYgLv87EWeFTU0NJ0T/HGURJrHceMMkROij7y8TEiFXmkPxdVEOc9f
	rYtoYIYa+cFaH0PWT9Eivp7oMknNXh+2/QGVC7IGo3XThN1iMx1pxTw1Zy0wrEllZswOy3VOU4u
	8dazzeMMjr9s/kBvi0c5mfvDxR6IQjO1G7DIvV89g=
X-Google-Smtp-Source: AGHT+IEM15nOtkA/XI7cUGuzR8dp/FaYdp8QK5e4+iWiSK93DjwlDI/m0dwXKG0gve5IPKapDZJ98Q==
X-Received: by 2002:a05:6a00:2e18:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7a4e4c1cb4emr1117970b3a.19.1761698288274;
        Tue, 28 Oct 2025 17:38:08 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414083a7fsm12790811b3a.56.2025.10.28.17.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 17:38:07 -0700 (PDT)
Message-ID: <4fbd4eed-9b39-4432-9ab2-96dee3bbf070@davidwei.uk>
Date: Tue, 28 Oct 2025 17:38:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
 <412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
 <34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
 <20251023190851.435e2afa@kernel.org>
 <77a3eb52-b0e0-440e-80a0-6e89322e33e9@davidwei.uk>
 <20251028164437.20b48513@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251028164437.20b48513@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 16:44, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 14:59:05 -0700 David Wei wrote:
>> On 2025-10-23 19:08, Jakub Kicinski wrote:
>>> On Thu, 23 Oct 2025 14:48:15 +0200 Daniel Borkmann wrote:
>>>> It is needed given we need to always ensure lock ordering for the two devices,
>>>> that is, the order is always from the virtual to the physical device.
>>>
>>> You do seem to be taking the lock before you check if the device was
>>> the type you expected tho.
>>
>> I believe this is okay. Let's say we have two netdevs, A that is real
>> and B that is virtual.
> 
> Now imagine they are both virtual.

:facepalm: Yes, you're right, I hadn't considered this case. I'll check
if it's safe to access netdev->dev without holding the instance lock,
and if not, go back to locking both netdevs in a deterministic order.

