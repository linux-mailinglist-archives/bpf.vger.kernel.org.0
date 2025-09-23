Return-Path: <bpf+bounces-69447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA9B96AD7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA72E161B98
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEED26B2C8;
	Tue, 23 Sep 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gfzEc6Sz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27926057A
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642986; cv=none; b=FKzEqFZswso9Av314yBsdiwjuibFsUF6vanrEsU4l8lkhNh7M5kyjX3Qkn2Tso3+FUDc0ljhHht0gxCul6MqDL5z5Vv4/0rV8Gxos7gby2rlfnnhpV2DAR97x+yLrT8Bmgio3tQUsWIi8/ZY2sQqhnmbr0Mjz/i8geAjmEGHd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642986; c=relaxed/simple;
	bh=24dum0ijhJnu6ePvSmObRqgFJHuL0BLgVAjytG32+7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJHGBXfsdCFxS3NdoZUPa0p40drDpSoF+KM1ebt+fovYorHyCTWSVu3kQyMjgxtXUUjnHBENxZcoNSz9c/tXioXnIcPJdWkBfQ6tRKAjHcLvQ9dREMZkY2pTGlLK7GXx+4cbSdJLMByFJ0soS1rAiJFDqJgKZJRJ2E7QDWn6by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gfzEc6Sz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25669596921so61956565ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758642985; x=1759247785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nwSrTvN2VNXYHNmWzJtwrK6x+LOTPWaZZ6+ulddIfs=;
        b=gfzEc6SzY9UnlrONyrMESsg6uUhnhFAPDSY0lH3B2BNQQTwhHtshKR59Ar0J8dq74I
         E22wFJIvk2qOIe37v61+Gr4XEzR5sh/ZRBkMgjAgHrUAmoNuKd5h1NFz1YLBl8nAwaxM
         wT4ZiM0FqAOaa8I2Vd/RX5OOTJN0PFUIyW3IkMltZsHpDBilhN+JNw5mY5nrIUqV+0MI
         jazbt9bzKGk0v9nNnxbnZrVn6odbgwK8GXHVhboDbUwrSN1fOmnJBQbgQxicjvBst1c0
         X1SF0IARBGv7EqbzBL0nqmAmvDihgNplS5JJbscxxlpJTJ7/OzqWWJx8FtOhBdXCJui/
         86lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642985; x=1759247785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nwSrTvN2VNXYHNmWzJtwrK6x+LOTPWaZZ6+ulddIfs=;
        b=neFg7R30YFpCcxYAiVkkMTL86enMbx6Q7QZ4OYK0J7fghnpHaOczyryuDevldjYo7Q
         348oowcsG8fZ7W9gTka8u9nqbFjGGgQl+4JkFOUm3/qSDxXOomV5S+IbWYhxl80KEhXN
         BoJN6/mqLNA8vBoCCFEgYwX2XG8blGOpaESrUSAyRG5wk2BocJaMU+ySa8ANshkYws1M
         mBdv4IuRkh7rHz5il/fuZv//NuhAaIyg1dat8ggOIyLdbPqEz02OdLOUjCdN0Vfb4d2D
         mPprfR+Y7mKcXBmqv5IsQRDxlU9+A+FITPnTdzT5PL/b7hQ2qaFyrrYlSpDVpnfTTA5n
         ZiZw==
X-Forwarded-Encrypted: i=1; AJvYcCXnpmmNtrFG4he5PIWtIAfUqLY37arCaSfHl21BjIJT5Z2a3B5NE9E1WjBqzwm7TU4Rie0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD06ocm/BwPZUxXiBSYp7ctIFuMV15ZR/tUy9QBHph65GOhUNE
	YUkr7gHm3tOnAIUeb4H80haqFI15GUA/NQQYXtNyMqTO4/YcIQig57L1tGqY3OuFycFKg5GeNap
	LPks6Lp8=
X-Gm-Gg: ASbGncsg7wq+4K2qWbIotd59eWa2BbY52bDzlKjZQD1bS+XBYOy9kQ69U2jI/Z41H+6
	S4dGnOJRpPXsRZiL5p7Vkzdnu7uFojmt5KQdvw6RMOpxWIeruBDTUXa6fpVlXN5QTYxVAao8hd6
	6LZ0w9zXTYOIraavyY2Vs4ef16a1Xk/0xJ+3iB7K/G85HAflrTTDAUeKVi52wzujUd1DSaY0659
	SwF5XFcHHbYIy0wWKEzw7AA+NqHjM7MCddo9J6O/9a13B+HB2pr7WeT78qk1kwoNNjZiWODBPzW
	6qDv1uh4PBqmf5zkpvPcNfqEJrgzIIvW9bDNsTK0UPQsg0AZztwLiWusSBu0ScARYR/6A7u+FVa
	AXb00dX/DRSMsOrxw1raVrrq3R/2m3UMLVfHuGhauCRHZ7V7yoOX0DmXD9h+RXvVbaXPklA==
X-Google-Smtp-Source: AGHT+IFt/lLckbXIk4AhQ3RI6D1iZSj4v6/TAAq2BXRQ0ewdQQB8SsyJRKxkDgxe+L8RmLxPzQkRyw==
X-Received: by 2002:a17:902:f541:b0:264:f714:8dce with SMTP id d9443c01a7336-27cc48a091fmr44137135ad.36.1758642984930;
        Tue, 23 Sep 2025 08:56:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm166660495ad.127.2025.09.23.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:56:24 -0700 (PDT)
Message-ID: <edc230c2-1079-4439-8bb8-ac73135c8f7e@davidwei.uk>
Date: Tue, 23 Sep 2025 08:56:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/20] net: Add peer to netdev_rx_queue
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-3-daniel@iogearbox.net>
 <20250922182207.1121556a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250922182207.1121556a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 18:22, Jakub Kicinski wrote:
> On Fri, 19 Sep 2025 23:31:35 +0200 Daniel Borkmann wrote:
>> +static inline void netdev_rx_queue_peer(struct net_device *src_dev,
>> +					struct netdev_rx_queue *src_rxq,
>> +					struct netdev_rx_queue *dst_rxq)
>> +{
>> +	dev_hold(src_dev);
> 
> netdev_hold() is required for all new code

Got it, will update.

> 
>> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
> 
> Also please avoid static inlines if you need to call a func from
> another header. It complicates header dependencies.

Didn't know this, thanks, will fix.

