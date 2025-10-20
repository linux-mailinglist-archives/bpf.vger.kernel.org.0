Return-Path: <bpf+bounces-71461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BABF3C20
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 277594FE549
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46082E7F11;
	Mon, 20 Oct 2025 21:31:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 987C1274B5F
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995901; cv=none; b=s35tSyDNMTkj3Mvl57WaJ5MY9yODRp3ws/Mb3NoVa9XaKsv6HmtSG72jcxGt5h6u8/EJBmyBMQtVG8EpN9wex0yUsYxOMh+clM0v7B36JcCM9hADrt7gZiR6p0obZzWicrRPOariSLUklwUhU17FQk5PBAZX6nGFVsVb4mOzK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995901; c=relaxed/simple;
	bh=VDj0O6rdW6j2j1l/EFV+jKOr5tWdxLisolXoFJWH7Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8sZnR5Q9+mjyukH5wJtAsEhAJJz6RjlI5J9/A2+Nv4f9ZOO9LqZOHFxIH+VoFx/Juk/1ccoM9YGS7VirasGytUaoDqCBPW6hlUowYSn6lofncXg7PHBaLE354fPMRHRQcBPLmKRmli/N6iR2S1I63c76UBggsTijxS3GuHd3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 2001:db8:8319::200:11ff:fe11:2222 (helo [IPV6:2001:db8:8319:0:200:11ff:fe11:2222])
    (reverse as null)
    by 2001:db8:1101::18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.20-cur)
    for kerneljasonxing@gmail.com alekcejk@googlemail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Mon, 20 Oct 2025 23:31:38 +0200
Message-ID: <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
Date: Mon, 20 Oct 2025 23:31:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Jason Xing <kerneljasonxing@gmail.com>, alekcejk@googlemail.com
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
Content-Language: en-US
From: mc36 <csmate@nop.hu>
In-Reply-To: <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 10/20/25 11:04, Jason Xing wrote:
> 
> I followed your steps you attached in your code:
> ////// gcc xskInt.c -lxdp
> ////// sudo ip link add veth1 type veth
> ////// sudo ip link set veth0 up
> ////// sudo ip link set veth1 up

ip link set dev veth1 address 3a:10:5c:53:b3:5c

> ////// sudo ./a.out
> 
that will do the trick on a recent kerlek....

its the destination mac in the c code....

ps: chaining in the original reporter from the fedora land.....


have a nice day,

cs


