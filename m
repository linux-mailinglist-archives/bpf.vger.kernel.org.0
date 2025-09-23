Return-Path: <bpf+bounces-69449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D39B96AFB
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846874A05D9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668A2741DA;
	Tue, 23 Sep 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gIbNOtGm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135F26B2C8
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643135; cv=none; b=qbl+Wi+ghE06HSD6uXFlyt2m6/IvM2FNGFQ2LvPWuZpfIxyzO+jsPp6kVuEvatpaaIkmm4s2FpEYmKOihK0yIYta7DQ73S8yGk2DUKREHdYhPeRtbAk0Fl+gtdr2Yup4efDE9bq0+8vKFQo+pSRgSFYblR4bpKIitfgCuJZd2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643135; c=relaxed/simple;
	bh=gcdrUkEE7k8h3bL5EJjiXIehhukiVZtEsgd/zcv4Nxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu4vgUIfYq9kc7ugID97n2LSXlTYJ9BcneY1c4MtEinrzqLf0QHooyMyAvSLZT7TFQH3oxdba28ZNxCAXT+IlhUFoiMQFKd6cjvBeZrMsiP8gZrAJWTA37FAp14xH9ew3darrmZCeOtQcLZxLTb1dK0wpRhSJ6LIzPZzq/l8WTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gIbNOtGm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so2508272b3a.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643133; x=1759247933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNQhOf7kY2F8TCqI/O1nW/ycDnR2r4OrVFQr57e8EJs=;
        b=gIbNOtGmomRbmruZM7FVk9qYoSl0f0mfBchtP00Tp9jy9Mi9YU31pbUtQrzOcMstcI
         J0wTBdNOKzYe318cAUgEsbx2sgIh6pDfpNmh7INPq42fK0gS9WT+zLBlJMkbTA9qamg1
         O9bBvAHqgLC4r8GBT9wJRS2G+ol/1SqhyxQU8p/lhucNcqXxg+1occo+YX4l+3ZSRN1K
         kf1FoCmsoFGwpUHNHWI3n5UhAESIrobgj4D0CuMZz75uIeUmi8og+Wo5aPctmZjTY3i9
         zv/k3SyOFgG9LugN2opdCWJDsFypOfzM7mCUZbe2Iv1DjkluJF057v4D9vpFAmeKJ07a
         2tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643133; x=1759247933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNQhOf7kY2F8TCqI/O1nW/ycDnR2r4OrVFQr57e8EJs=;
        b=He7gTL5qJI1N/BtZYLyxnl0zS7eqVWUhjhrmB930v/q2LtJs79XwgLeEvTkC7mBvze
         gwR+OfP434ZgsJub7sbInu/qhLU48vdk8DvdgI1zVJsXQKJmB/SH6DUQvTObCY2qtrmv
         aKdaOgfYhYEcs1kV9bG2LY/A5qk9FehoPp/wVnEYVflvhw+tcAu/BE2BeNDNyPogyyTB
         lUvcu9djFi31rMiYmQ1+glmNBnMeDaJD/BLkrT5nUxURuQzKWyD3fjhQIMrqTeELdded
         HUeniKzuIKi7gQfinK3eerwietAdKS477P7alyReRHmtkBsBjfRsFe7QrOik2rVJIwql
         0ePw==
X-Forwarded-Encrypted: i=1; AJvYcCWoCF5eueYSMEL585S+vIwMAGikfnd60tjd2p1lmSpYo5ZKV0cv3onKhT73xlQ6RM9WBtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbk0hm5n7Hf8zZgsYVi8ZYcZ3P48685/LVQuXmUurcp2663bF
	dG/ghMCTGJJJta1UzhyTGJEulfPnpDxImzEvCMc97sjy7bQQrRwKIMYajur3kTYNQ1k=
X-Gm-Gg: ASbGncuqDX7D6Y3IzK2ra9RUP8iIl61ynnFiXZaO0q7H22oI/0KFnL/4iuy4sxlePIF
	ZKxU2+EQf5vJlhDOBSoj/Og4OQAF39v8qxSh6HyLeHjFb5ui5a5HUHNpYzQf7Rx84fP8WiSEZaX
	bKkC+RZtACrQnolzfTXKal5j8n7Zg6oFC/sswKa3bE+n6hr3e0HFxh7Flzt5eMIjxAyulPdmulY
	PxqXZrqpuSjgoCTJR+oEFSJgZpwZksl3Uaxcy2uoyptxDkkEetL2kZRzOkLOYWct/NgWlfladLJ
	C0yN/YnQE0LrVcvCw9NutcJ1DAUiV0fOGs29yERUI8+c8omHFkvAdq84hmJS8kS6ox3yKMlo2Nm
	CtGlPJlw509zvDoKUEa4Sr5oTZvAadqHaeoBAgCS07K0zsX7nyboPuDTKDHc=
X-Google-Smtp-Source: AGHT+IHaWWQsxNkqF1/Ox1XypUQNX2Lmei4T4nsZ50MiDDU2VB8sz/+STs+7VGJfCSePr8jpdwU4wQ==
X-Received: by 2002:a05:6a00:8c2:b0:77f:33c5:e271 with SMTP id d2e1a72fcca58-77f53ba52bdmr4279406b3a.32.1758643133009;
        Tue, 23 Sep 2025 08:58:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f188dd4a8sm10312819b3a.39.2025.09.23.08.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:58:52 -0700 (PDT)
Message-ID: <a3c19679-a229-49ab-97b0-8a702b714bbc@davidwei.uk>
Date: Tue, 23 Sep 2025 08:58:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net>
 <20250922182231.197635c1@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182231.197635c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:22, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:36 +0200 Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
>> rxq specifically for mapping to a real rxq. The intent is for only
>> virtual netdevs i.e. netkit and veth to implement this ndo. This will
>> be called from ynl netdev fam bind-queue op to atomically create a
>> mapped rxq and bind it to a real rxq.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/netdev_queues.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
>> index cd00e0406cf4..6b0d2416728d 100644
>> --- a/include/net/netdev_queues.h
>> +++ b/include/net/netdev_queues.h
>> @@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
>>   						  int idx);
>>   	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>>   							 int idx);
>> +	int			(*ndo_queue_create)(struct net_device *dev);
>>   };
>>   
>>   bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> 
> This patch is meaningless, please squash it into something that matters.

(Y)

