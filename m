Return-Path: <bpf+bounces-13335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DE7D866C
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51E41C20EF6
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028DB381B2;
	Thu, 26 Oct 2023 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="uKhpo7/h"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3637C9B
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 16:03:00 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D226BA
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:02:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c515527310so15026371fa.2
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698336156; x=1698940956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hDB3AYXYSFBUZXAYwmv0x06auRx4wfC0QfetsP7Jqk=;
        b=uKhpo7/hcV3gKXC/nNeQ7G+DQwRoI9Uer4n/qPvgeNwavENcd0vyX3NcelM7qjPkf2
         7zmgfSGBYu6VTkFAQKNCSukx6sDkl9U2CZSKm21+cvnxmy6s9huUyKj+9YwUmaR6Adkm
         pdFimx9vENfBbATJ7wbs2fcy4p/h46cFSyrNoGdcOGswI5dWIGtgCF3DzpGjiJs1Wp/m
         pTE/26L4ayLVyzIRAwi5fpRTFxLzHux/MbXe3GJmHSH2vqcD/uKUrSRweFpp2Ew3j2+z
         TnVVb37i/a5efc8l+LJw1MHyzEpIBkmIGPUKmYlBmVMAS8OkN+JbYBBburilnNUp911H
         Tdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336156; x=1698940956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hDB3AYXYSFBUZXAYwmv0x06auRx4wfC0QfetsP7Jqk=;
        b=f3jgUesvx2IrqJtW0E56Km1HEYtUIi8f0EhAL8kXpaurew02PcePXwlETy5XMVXQYC
         gQdqQTUXp023dep4d3XdTspObCguZHz7ILC7RvguLkPXn4HsXYTVZqwVxUr5X/qwzLLm
         oPBJHlkD3eNqUCGfv5pnoMykFXR0fhTrjbUS9QAFTLtUjVBFkJgyJUwqUPkm9bfro5pG
         2Be8fDHln3douUo0IfeqfZ1lnN1vhVwSHQTh2BXi/Xupcy3aChpU1mzayFTsEGG+haEE
         KcmYlkCiB3GZGUQsQ/0zbawJ5aj7BP1B8TmXOKoPOJe59VqvBuddwDPdQ6qAMw0AAA2N
         ulIA==
X-Gm-Message-State: AOJu0Yyx1LQA2fyxzZd6Kf0eSHgp7sfmwvdNERT+3PmAZA89ODLyxlIZ
	lK2py0OO7N8obIq2DySQXtLsIs4L3ImmAokFavRq3g==
X-Google-Smtp-Source: AGHT+IGIJSBazYsLomUAvROoURyDqSpR4GWZ+Fk6K7xEApm8JjHTR0pIr/T4OT9QOmNI+ltL1OyHqw==
X-Received: by 2002:a2e:bb92:0:b0:2c0:21b6:e82e with SMTP id y18-20020a2ebb92000000b002c021b6e82emr27811lje.4.1698336155471;
        Thu, 26 Oct 2023 09:02:35 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id r8-20020adff108000000b0032db1d741a6sm14578055wro.99.2023.10.26.09.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 09:02:34 -0700 (PDT)
Message-ID: <3d0f4578-f6f4-0c31-cbae-989305ab70d9@blackwall.org>
Date: Thu, 26 Oct 2023 19:02:32 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2] netkit: use netlink policy for mode and
 policy attributes validation
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
 sdf@google.com, daniel@iogearbox.net, idosch@idosch.org
References: <20231026151659.1676037-1-razor@blackwall.org>
 <20231026084351.6bb4ba8a@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231026084351.6bb4ba8a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/23 18:43, Jakub Kicinski wrote:
> On Thu, 26 Oct 2023 18:16:59 +0300 Nikolay Aleksandrov wrote:
>>   static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>>   	[IFLA_NETKIT_PEER_INFO]		= { .len = sizeof(struct ifinfomsg) },
>> -	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_MODE]		= { .type = NLA_U32 },
>> -	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
>> +	[IFLA_NETKIT_POLICY]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_policy,
>> +								 sizeof(u32)),
>> +	[IFLA_NETKIT_MODE]		= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_mode,
>> +								 sizeof(u32)),
>> +	[IFLA_NETKIT_PEER_POLICY]	= NLA_POLICY_VALIDATE_FN(NLA_BINARY,
>> +								 netkit_check_policy,
>> +								 sizeof(u32)),
> 
> I vote to leave this code be. It's not perfect. But typing it as binary
> is not getting us closer to perfection.

TBH +1

