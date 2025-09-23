Return-Path: <bpf+bounces-69448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA0B96AEF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB7019C6068
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B9279335;
	Tue, 23 Sep 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="n7hCF2Xt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D526A0DD
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643087; cv=none; b=Jqs6Z1Jf0Mnq98HG6RQnDSi+HhvgIBk4zv4cnpQIL3UQuFTJrRNn9WitFnxU8+NsTZutj55QIyf4940fGAzKDwv+OGllAEQ3AuCO1SG8sXPJIw5/rtBy2jFAie5MbMz42kvxh53Y7HWA2wOEtJWe6UtEPevhz76m8W+UqW3DJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643087; c=relaxed/simple;
	bh=rPlEGrL2pSsOp2Ur1sQTwPfwBtQuV96uTVhhnTcOo34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6FoSZt6r1PMequxxWodDXEmrXXNU+W5kt2haPk+Wel2E+ExUNFXugDuJgrbr/8Fec/69HP+g+1ELfTPecoq1KTsom0I9DYi+tv1T4aNCcWQMhtvflzMF11155LdkcbxFfanlM4VCPvhU1oILQG2yD7kw15MkCPK6CAwkiibcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=n7hCF2Xt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so1930411b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1758643086; x=1759247886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8/JqpgYOrCxMsYzwby8uwVZtPIWnLh7RtxpA1RDm/gA=;
        b=n7hCF2XtSslpOewvTcBasezpcKsQfHWLTBXGygnxA0JTJV3fjO14jhMBusJl0RabDT
         EgCZem37hXv7hqkjoeykfgudItEE6w8DjBwM4hjlsPk8uCAeYUSEaEsmrRK96kQR57vJ
         cC5k0cEbhmVRs8myeC7abPwmDDrlrOS3BAZTUXn0Wp9uQQOtRhP0p2xqBYE3RmQ3OhN+
         UE5fBgGknXIYDRZ8dKjkhIoLXw9MPVNYc4TH6RewJKWIjwvigwwTsMQTpJIZErpee3uG
         Kn8ZR4TD0O1Xua65a4+sxkPextw+hbxIIKrMM/3hvHWJ7ehNhyZp7psqA8HOXjPMGt3Z
         mpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643086; x=1759247886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/JqpgYOrCxMsYzwby8uwVZtPIWnLh7RtxpA1RDm/gA=;
        b=Z7lucL/sLAzGgvMj43DgMyvOCDP3R1mBr0LW/ydQI32QmB6EAWTDlVxVvwAID0jUfT
         jWiN1QdXZMa3LcMjH+DmrDX2IqLABhdNrZH6l5c4I/JKmT2XK/vivwiojhnJ/qRuLBqG
         81OiNm1HijOhI5sqqN+MMTFxZwNHBeHtd7kstS6nccKVd5yoALxdXqyaj8fmkYTt+BE/
         q+eGPzRwL1nNgWxrXvdnkzJmSFNX6IqYf86z5/S4UGi1OJjQaICS08efGeGWm8bEJPRn
         vP13UnKzk6Sq/WGy2NpqfH6r2qfnuuiT21bOirePORw2uNeiqxQdlwGjzAJYwEMKI7GO
         TtBg==
X-Forwarded-Encrypted: i=1; AJvYcCUSVV24tuZoNNApT05SCvuIokIrSbJg8ERGG9ryuHcfjrZ6zgXHjxiyfsNbr7hHMkt+6C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0jVlCam6p/jtMPam3mdY44O1Y794/odnB3Whb8DBZrQ/anK1
	VvZruBTzZ/k+vvzdbVt8LueBkRr2MnkFieam6/Usfq2d0MDDyV42vFkkJCn1qlmgIrk=
X-Gm-Gg: ASbGncuo9/4nu0TKB81FBMrn3yPFbl4oTsmwLeBwJhHKo5a7un9PM/KKwOi78TnLXP1
	hmA/F7jUNHdy8QjVz596I8snDjwIkYJSUpPJtyyZPLkrtk7I3frwJUTzvrc/85Z/RQesgPSDLmN
	+JVOD2dEapAZ3eKo1Pee3cJI0umJmPiRquArUdG2av2ZDUREv5Kp+e/oop1wRH4+hdNfoMpAmxE
	c3Z7BnOoPFEU0cj1fq0B508r4llwrMFAbuOCEe3fcdds03uDMpg9oHk2QNK/y83z3E5CjKdtoMt
	JDagdcXVfVfkrWhtMfQ7vLXygurlfBcVhwFfeXD/Jub0nf9Q6afWlOUmzoZC4IkXKxWn3zJ8Vsb
	QzYa5IUejithUp1ukND4NVJt4RydXBPePCsFu8JWcuYoLgsmNlubG8MCX64uta+MULlsjcw==
X-Google-Smtp-Source: AGHT+IFCcRtj0+HKM0frArQ32BTYMbiJqh2ZgWGCXPfVCoshw0GKNKHvIU5ZFdNPv+sMiGIxtX/iJQ==
X-Received: by 2002:a05:6a00:391b:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-77f537f4668mr3580539b3a.5.1758643085558;
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:ce1:3e76:c55d:88cf? ([2620:10d:c090:500::7:1c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f23d92ef0sm8780103b3a.102.2025.09.23.08.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
Message-ID: <32b82a8f-2c81-41ee-804d-83ee847a27f0@davidwei.uk>
Date: Tue, 23 Sep 2025 08:58:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/20] net: Add ndo_queue_create callback
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-4-daniel@iogearbox.net> <aNFzlHafjUFOvkG3@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aNFzlHafjUFOvkG3@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 09:04, Stanislav Fomichev wrote:
> On 09/19, Daniel Borkmann wrote:
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
> 
> kdoc is missing

Will add. This was meant to be an RFC so I didn't write one - then it
became a proper patchset.

