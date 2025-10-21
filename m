Return-Path: <bpf+bounces-71574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42947BF6DA3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED64505F73
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936EF337B8B;
	Tue, 21 Oct 2025 13:43:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www.nop.hu (www.nop.hu [80.211.201.218])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1EF322F693C
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.211.201.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054193; cv=none; b=Agv22N80F2fAH5QoKsdUDA27QxmKDa+8fvmQ5zIWvIn414ajoLJ50jvh03ojJipLj0E5/I1u1XTebJg6B9RvKsJYHwjHN7xJnD54t8aLeGG7SXMqJX9Q+m/dl2vsP/lG75JsYTv74Hzj2wmxbaSt3MmVsre10Qpx4yHV8/8bXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054193; c=relaxed/simple;
	bh=3vfOP4cRQmDcREeD+QJJrzzgEoDi6gHpS7CUO305J6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6VMa1TO0cPkrMqz9kcNyLmaOaPqpgU873FEvmEnKlGZJe5gC87ks5AXGz9WCYmaao/vIO1xG4Wcmy/I7wsLPCRkAlvF+Kcv0LG9STewYDgd9sZQxmK7a+pLdYdQcSnVxt4r1xN8T0o5RzInNJOfpeMSMqjz5oBQBpGZgjjBA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu; spf=pass smtp.mailfrom=nop.hu; arc=none smtp.client-ip=80.211.201.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nop.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nop.hu
Received: from 2001:db8:8319::200:11ff:fe11:2222 (helo [IPV6:2001:db8:8319:0:200:11ff:fe11:2222])
    (reverse as null)
    by 2001:db8:1101::18 (helo www.nop.hu)
    (envelope-from csmate@nop.hu) with smtp (freeRouter v25.10.21-cur)
    for kerneljasonxing@gmail.com fmancera@suse.de alekcejk@googlemail.com jonathan.lemon@gmail.com sdf@fomichev.me maciej.fijalkowski@intel.com magnus.karlsson@intel.com bjorn@kernel.org 1118437@bugs.debian.org netdev@vger.kernel.org bpf@vger.kernel.org ; Tue, 21 Oct 2025 15:43:09 +0200
Message-ID: <1c523c77-7eb7-453b-ba15-d4616edc18fb@nop.hu>
Date: Tue, 21 Oct 2025 15:43:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, alekcejk@googlemail.com,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
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
 <fbeb5832-0051-4f78-bfdf-f1087bc98510@nop.hu>
 <CAL+tcoBVLi6sRJv4ZTA-O3FcACq0dOsUdKO92MuCCC0CZgLs-Q@mail.gmail.com>
Content-Language: en-US
From: mc36 <csmate@nop.hu>
In-Reply-To: <CAL+tcoBVLi6sRJv4ZTA-O3FcACq0dOsUdKO92MuCCC0CZgLs-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,

On 10/21/25 15:02, Jason Xing wrote:
>> if you're in a need for some more complicated xsk tests, just let me know, freertr
>>
>> have a dataplane and a socat-alike tool with an xsk based packetio for a while....
> 
> Could you provide a link that points to what you just mentioned? I
> believe more tests on veth are necessary.
> 

sure, but be warned, it's a huge rabbit-hole that you're jumping into.... :)

so the homepage is freertr.org, it provides a daily vm builds...

if you grab the qcow2, convert to raw and mount -o offset=1048576

you can update the kernel and initrd, and you need to put the xdp

bpf and elf libs as they're not part of that image... then umount it,

and after the first boot (look at the serial console!), do the following:

conf t
int eth1
  vrf forwarding host
  ipv4 addr 10.0.2.222 255.255.255.0
  exit
ipv4 route host 0.0.0.0 0.0.0.0 10.0.2.2
end
write
test hwext path /rtr/rtr- dataplane p4xsk
reload cold
y

your xdp dataplath is activated, the vm kernel itself will be behind

a veth pair, the dataplane will play with the qemu virtio-pci and the veth,

and there will be an other veth for the dataplane-controlplane communication

full of random non-ip frames, then

ping 10.255.255.1 vrf host

ping 10.0.2.2 vrf host

will test for the fresh kernel and the outside word...

you can exercise the above with a raw socket on the original image if you do "p4raw"

instead of "p4xsk", and as we're on the bpf, it have an in-kernel forwarder called "p4xdp"....:)



the source is at https://github.com/mc36/freeRtr , the misc/native folder

contains the dataplane, and the socat-alike tools.... just ./c.sh to build them...


afterwards you can create topologies with then like

(1.1.1.1/30)ns1-----<veth1>------host-----<veth2>------ns2(1.1.1.2/30)

to cross connect 2 interfaces on the host, just run 2 processes like

xskInt.bin veth1 skb 1234 127.0.0.1 4321 127.0.0.1

pcapInt.bin veth2 4321 127.0.0.1 1234 127.0.0.1

there are other tools with uring, raw socket, mmaped raw socket

and some others that are uninterested in the current topic imho....


have a nice day,

csaba


