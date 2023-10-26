Return-Path: <bpf+bounces-13326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BA7D849F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558F81C20F10
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6C2EAF0;
	Thu, 26 Oct 2023 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WLNoQBcL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D02E41F;
	Thu, 26 Oct 2023 14:25:39 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CA49C;
	Thu, 26 Oct 2023 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uIGlwfdMBsmp/4z8QYpLO2wdpNnM5FD6mLIDGow3Gn4=; b=WLNoQBcL1b4DVFYX6Iw3ZuuHG3
	QEUxZCjMc/omDtfyVrkui8yhW390B9ion871Dhsx6M+Ba2u2NQpn9w1CCk2I/MRInU4aoLrRBur+3
	onbb1dqWIlS+hVuS6Ti8Fu9HUuhbBYWowdIqqaM0tM60gH21AN2QU+8d97kQawR7vcHEePB0zZTgz
	l7o7uXxyUcT4m0CIBtNVMHtl/SpZhOj4SM/ljhXE8mcCeUaVADyoRl3nRBl2gm5MbnxdNIY5VMGHs
	hnhF0/g4tXs+maKC9UlQajPRs5Ad3JsfnrpVuD4QhxdyZ/QLf5VsZI7rTKJ25RzuH55drc4lnwjDx
	O/ZZiVMQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw1Ik-000G8Q-5k; Thu, 26 Oct 2023 16:25:34 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qw1Ij-000QCz-Jg; Thu, 26 Oct 2023 16:25:33 +0200
Subject: Re: [PATCH bpf-next 2/2] netkit: use netlink policy for mode and
 policy attributes validation
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@idosch.org>
Cc: bpf@vger.kernel.org, jiri@resnulli.us, netdev@vger.kernel.org,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, kuba@kernel.org, andrew@lunn.ch, toke@kernel.org,
 toke@redhat.com, sdf@google.com
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-3-razor@blackwall.org> <ZTpzfckQ5n4o2F7D@shredder>
 <36072f45-0d42-7284-d0dc-295f543fe40f@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8533255d-9b73-cdbe-fbbd-28a275313229@iogearbox.net>
Date: Thu, 26 Oct 2023 16:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <36072f45-0d42-7284-d0dc-295f543fe40f@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 4:23 PM, Nikolay Aleksandrov wrote:
> On 10/26/23 17:11, Ido Schimmel wrote:
>> On Thu, Oct 26, 2023 at 12:41:06PM +0300, Nikolay Aleksandrov wrote:
>>>   static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>>>       [IFLA_NETKIT_PEER_INFO]        = { .len = sizeof(struct ifinfomsg) },
>>> -    [IFLA_NETKIT_POLICY]        = { .type = NLA_U32 },
>>> -    [IFLA_NETKIT_MODE]        = { .type = NLA_U32 },
>>> -    [IFLA_NETKIT_PEER_POLICY]    = { .type = NLA_U32 },
>>> +    [IFLA_NETKIT_POLICY]        = NLA_POLICY_VALIDATE_FN(NLA_U32,
>>> +                                 netkit_check_policy),
>>
>> Nik, it's problematic to use NLA_POLICY_VALIDATE_FN() with anything
>> other than NLA_BINARY. See commit 9e17f99220d1 ("net/sched: act_mpls:
>> Fix warning during failed attribute validation").
> 
> But how is that code called at all? The validation type is NLA_VALIDATE_FUNCTION(), not NLA_VALIDATE_MIN/MAX/RANGE/RANGE_WARN...
> nla_validate_int_range() is called only on:
>          case NLA_VALIDATE_RANGE_PTR:
>          case NLA_VALIDATE_RANGE:
>          case NLA_VALIDATE_RANGE_WARN_TOO_LONG:
>          case NLA_VALIDATE_MIN:
>          case NLA_VALIDATE_MAX:
> 
> Anyway, I'll switch to NLA_BINARY in a bit to make sure it's ok. Thanks for the pointer.

Sg, I took in the NULL removal one for now.

Thanks,
Daniel

