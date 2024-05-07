Return-Path: <bpf+bounces-28874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D98BE609
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A03F1F23190
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DA615FA80;
	Tue,  7 May 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dD/2g+G8"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3A15DBC1;
	Tue,  7 May 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092473; cv=none; b=FzVWi4Xigq5apxaFRKQmorIITZ8titCk0W5q988te8lVJXm012UFsPDlItLJXAH+xIvZRMr4Rw6ySqsRnN0BvxAKJuGMCcMW1xa3eEABdi8hv+DR8GXy3wpcI9nzaYWwRlniNoaIldpSraf+Oemxcq3TfYLXwNfHNhP0ti61hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092473; c=relaxed/simple;
	bh=Rn98kkZoCRyzEDUHujvEdeSt3a+LcvSTBCAGe29A2To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKyutH8wGubMf2A8EkNfTdfDZmI8/7lhPMhBj1kfuQssxarF+Nz5eAraaRuQ2739NS7DT+0LleuTvPOHDIDJS6r+XGuQdDCWtQQi9PMr0Wsg4dc1ev5f2rCdSHQAvSnE0UN4132HsyA2MTu7D0YzrjmvGczLnWDYOnlJkdSfjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dD/2g+G8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715092463; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o6bWFqpzN6Wrt8MSD5ofMjZort1RodcrLsBtj4xyd/s=;
	b=dD/2g+G8AcBnrB61lNFhlUquRhuOdpa4VZwRIBd6gdWgM0ONU3jakQRnCAYgJoUUKsxdkgTtJv49y9LnIFJWF3F8Kk6F6maLJkztb3LmD2+aZ5kht0R3mz7Tgn+FX8sQ0t8oZxXofJ8qp73gcZAd/VOeA4WHAj4FX/8Bn21Xlfc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W60RrX4_1715092449;
Received: from 30.221.130.197(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W60RrX4_1715092449)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 22:34:22 +0800
Message-ID: <2e34e4ea-b198-487e-be5b-ba854965dbeb@linux.alibaba.com>
Date: Tue, 7 May 2024 22:34:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
 <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/28 23:49, Cong Wang wrote:
> On Sun, Apr 28, 2024 at 02:07:27PM +0800, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
>>
>> - Background
>>
>> SMC-D is now used in IBM z with ISM function to optimize network interconnect
>> for intra-CPC communications. Inspired by this, we try to make SMC-D available
>> on the non-s390 architecture through a software-implemented Emulated-ISM device,
>> that is the loopback-ism device here, to accelerate inter-process or
>> inter-containers communication within the same OS instance.
> 
> Just FYI:
> 
> Cilium has implemented this kind of shortcut with sockmap and sockops.
> In fact, for intra-OS case, it is _very_ simple. The core code is less
> than 50 lines. Please take a look here:
> https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c
> 
> Like I mentioned in my LSF/MM/BPF proposal, we plan to implement
> similiar eBPF things for inter-OS (aka VM) case.
> 
> More importantly, even LD_PRELOAD is not needed for this eBPF approach.
> :)
> 
> Thanks.

Hi, Cong. Thank you very much for the information. I learned about sockmap
before and from my perspective smcd loopback and sockmap each have their own
pros and cons.

The pros of smcd loopback is that it uses a standard process that defined
by RFC-7609 for negotiation, this CLC handshake helps smc correctly determine
whether the tcp connection should be upgraded no matter what middleware the
connection passes, e.g. through NAT. So we don't need to pay extra effort to
check whether the connection should be shortcut, unlike checking various policy
by bpf_sock_ops_ipv4() in sockmap. And since the handshake automatically select
different underlay devices for different scenarios (loopback-ism in intra-OS,
ISM in inter-VM of IBM z and RDMA in inter-VM of different hosts), various
scenarios can be covered through one smc protocol stack.

The cons of smcd loopback is also related to the CLC handshake, one more round
handshake may cause smc to perform worse than TCP in short-lived connection
scenarios. So we basically use smc upgrade in long-lived connection scenarios
and are exploring IPPROTO_SMC[1] to provide lossless fallback under adverse cases.

And we are also working on other upgrade ways than LD_PRELOAD, e.g. using eBPF
hook[2] with IPPROTO_SMC, to enhance the usability.

[1] https://lore.kernel.org/netdev/1708412505-34470-1-git-send-email-alibuda@linux.alibaba.com/
[2] https://lore.kernel.org/all/ac84be00f97072a46f8a72b4e2be46cbb7fa5053.1692147782.git.geliang.tang@suse.com/

Thanks!

