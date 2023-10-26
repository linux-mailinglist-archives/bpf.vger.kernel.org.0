Return-Path: <bpf+bounces-13325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3F7D848C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057921C20F50
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEB2EAE7;
	Thu, 26 Oct 2023 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NtAkdaWq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAB62EAE0
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:23:33 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71771AC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 07:23:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso7666545e9.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698330210; x=1698935010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxlqeeGhLxH3bBosPGsgL7UrOvK0R3l9N7ltrUjHUTI=;
        b=NtAkdaWqpZrs/2N+MDIhRLSyzv9queavnsKjAYpuPGpu1CnkfT5OdITqJ7ulsIwcJ+
         i15z009Ntsrpuj+/YRzaWhGDOjI3DBbMicIzs276KViP1xXagyUXjsjw2RNZ6QOUfGbx
         WvWIigi3/k+sFwH6CDQr8rH2H9AFyZblrQo2PVrOotyZZk+tbFlkV7lhkffPHvyrro+c
         n/TsX6ew1xVcIsntgOfAeNXf9Pu/KNMr8V2zo4haxKu53ISQIUbGv6EhchIXG3p9jZGT
         Ax2Kfn6Tod3AD6lZNZGhJY2l1IPeHVhZ7sCKKzUcK1qMVwJ6Hx3izHZbaG/DHSSgDQqS
         1WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330210; x=1698935010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxlqeeGhLxH3bBosPGsgL7UrOvK0R3l9N7ltrUjHUTI=;
        b=ETmieqQJx8oCUgnFVMf+7NtxZOZf4zypiHFjavxB9fO2IZ1AXAKrsPQkvOja0Ti6hD
         d+sFrK/+qNbf9CYV7ViCIUzf4UfcbZOE7f/hJfpaWUj1Gieve+2vR2F5mMSjIM6aQ0BX
         9+V1chfjZndT8lVd5No7iRd8iCr2XOXmv97CPRrhf4On2xNLdM3hwm2Uv+c7lTUzQsgr
         JcD39uIHPTIREZ0hg/9D3Ie/9h818tYDpn6wkSfFA5e92TcMK3xxtXFc9m5y+nf6QXB0
         ixydzquGp8jPhLX2qymKyyAPhs4uRS5qpBq2CIRjN9QkLoXMOeWMSWiCKC5Kf5yagkVF
         g+kg==
X-Gm-Message-State: AOJu0YxwlmZx0OCpQniKwRik6KrsFkBQqkn14oBY955mCG4TWahGXlIz
	9/8VEpXYOziQwMooBb7+r462bw==
X-Google-Smtp-Source: AGHT+IEvp/CvedOPudNCax8pMN9Yuhw4zKOmCZRETz/ki0rZ59V73uN5wYIumBk2qPIm9nZ2PeCqpg==
X-Received: by 2002:a05:600c:1f8d:b0:407:8ee2:9986 with SMTP id je13-20020a05600c1f8d00b004078ee29986mr13448716wmb.26.1698330210013;
        Thu, 26 Oct 2023 07:23:30 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id y20-20020a1c4b14000000b0040588d85b3asm2633773wma.15.2023.10.26.07.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 07:23:29 -0700 (PDT)
Message-ID: <36072f45-0d42-7284-d0dc-295f543fe40f@blackwall.org>
Date: Thu, 26 Oct 2023 17:23:27 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
To: Ido Schimmel <idosch@idosch.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, andrew@lunn.ch, toke@kernel.org,
 toke@redhat.com, sdf@google.com, daniel@iogearbox.net
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org> <ZTpzfckQ5n4o2F7D@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZTpzfckQ5n4o2F7D@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/23 17:11, Ido Schimmel wrote:
> On Thu, Oct 26, 2023 at 12:41:06PM +0300, Nikolay Aleksandrov wrote:
>>   static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>>   	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
>> -	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
>> +	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
>> +								 netkit_check_policy),
> 
> Nik, it's problematic to use NLA_POLICY_VALIDATE_FN() with anything
> other than NLA_BINARY. See commit 9e17f99220d1 ("net/sched: act_mpls:
> Fix warning during failed attribute validation").
> 

But how is that code called at all? The validation type is 
NLA_VALIDATE_FUNCTION(), not NLA_VALIDATE_MIN/MAX/RANGE/RANGE_WARN...
nla_validate_int_range() is called only on:
         case NLA_VALIDATE_RANGE_PTR:
         case NLA_VALIDATE_RANGE:
         case NLA_VALIDATE_RANGE_WARN_TOO_LONG:
         case NLA_VALIDATE_MIN:
         case NLA_VALIDATE_MAX:

Anyway, I'll switch to NLA_BINARY in a bit to make sure it's ok. Thanks 
for the pointer.

>> +	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_U32,
>> +								 netkit_check_mode),
>> +	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_U32,
>> +								 netkit_check_policy),
>>   	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
>>   					    .reject_message = "Primary attribute is read-only" },
>>   };
>> -- 
>> 2.38.1
>>
>>


