Return-Path: <bpf+bounces-71561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3F6BF6A1A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DC8488200
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846453385B3;
	Tue, 21 Oct 2025 12:59:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DF885337BA7
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051598; cv=none; b=K0By9R/XtU89X0po0sAiDuVNdsxVOVseQWcLSY9AJeUPDP/XUN1NjpYs2sdccuTtWZt+b1gqDtFYn1vf3PYGdspIrr+vxvU7x4kzY4Wk6Wjq+k+Yk75gpk+HYluTuxTaXaVZBlycQqDLXyCWjazp107ctqEKdsX1cyNpCmoflI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051598; c=relaxed/simple;
	bh=9TRZ8BeyZksNHXvisSypz+YV6OsWvhsONhFxmZbW3sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPv9AAmF6pIFqayJ3Lvl32XGJHsZ+4M/Taj9RpjIpNR7Vl/J3lWuM2FXH2CRTx40KbTWSZUNmS102teTtn84vKYTHeOe38vcmE4AHqpaEbDKDWCYLfUH7q3JKnruuxmCtANKJpuIaMMonZmkXaCJIyuUuk54LzvHrv+hmZie51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 2001:db8:8319::200:11ff:fe11:2222 (helo [IPV6:2001:db8:8319:0:200:11ff:fe11:2222])
    (reverse as null)
    by 2001:db8:1101::18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.21-cur)
    for kerneljasonxing@gmail.com fmancera@suse.de alekcejk@googlemail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Tue, 21 Oct 2025 14:59:48 +0200
Message-ID: <fbeb5832-0051-4f78-bfdf-f1087bc98510@nop.hu>
Date: Tue, 21 Oct 2025 14:59:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Jason Xing <kerneljasonxing@gmail.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>
Cc: alekcejk@googlemail.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
 <7e58078f-8355-4259-b929-c37abbc1f206@suse.de>
 <CAL+tcoDLr_soUTsZzFE+f-M0R83tvqx7tGjU+a5nBFSdtyP7Lw@mail.gmail.com>
Content-Language: en-US
From: mc36 <csmate@nop.hu>
In-Reply-To: <CAL+tcoDLr_soUTsZzFE+f-M0R83tvqx7tGjU+a5nBFSdtyP7Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi,

you both are crazy good, thank you so much for both of your effort! :)


if you're in a need for some more complicated xsk tests, just let me know, freertr

have a dataplane and a socat-alike tool with an xsk based packetio for a while....

br,

cs

On 10/21/25 14:25, Jason Xing wrote:
> On Tue, Oct 21, 2025 at 6:52   PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
>>
>>
>>
>> On 10/20/25 11:31 PM, mc36 wrote:
>>> hi,
>>>
>>> On 10/20/25 11:04, Jason Xing wrote:
>>>>
>>>> I followed your steps you attached in your code:
>>>> ////// gcc xskInt.c -lxdp
>>>> ////// sudo ip link add veth1 type veth
>>>> ////// sudo ip link set veth0 up
>>>> ////// sudo ip link set veth1 up
>>>
>>> ip link set dev veth1 address 3a:10:5c:53:b3:5c
>>>
>>>> ////// sudo ./a.out
>>>>
>>> that will do the trick on a recent kerlek....
>>>
>>> its the destination mac in the c code....
>>>
>>> ps: chaining in the original reporter from the fedora land.....
>>>
>>>
>>> have a nice day,
>>>
>>> cs
>>>
>>>
>>
>> hi, FWIW I have reproduced this and I bisected it, issue was introduced
>> at 30f241fcf52aaaef7ac16e66530faa11be78a865 - working on a patch.
> 
> Exactly. I simply reverted it and its dependencies and didn't see any
> crash then. It was newly introduced, hopefully it will not bring much
> trouble. As I replied before, I will take a look tomorrow morning.
> 
> Thanks,
> Jason


