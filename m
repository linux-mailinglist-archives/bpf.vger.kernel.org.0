Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D53A353B
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJVAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 17:00:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:46502 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Jun 2021 17:00:06 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lrRke-000AVh-Os; Thu, 10 Jun 2021 22:58:08 +0200
Received: from [85.7.101.30] (helo=linux-3.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lrRke-000Ek6-KF; Thu, 10 Jun 2021 22:58:08 +0200
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
 <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
Date:   Thu, 10 Jun 2021 22:58:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26197/Thu Jun 10 13:10:09 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/21 8:52 PM, David Ahern wrote:
> On 6/10/21 11:41 AM, Rumen Telbizov wrote:
>>> that's the key point on performance - crossing a cacheline. I do not
>>> have performance data at hand, but it is a substantial hit. That is why
>>> the struct is so overloaded (and complicated for a uapi) with the input
>>> vs output setting.
>>
>> Makes perfect sense now. Thanks for clarifying David and Daniel.
>>
>>> Presumably you are parsing the packet to id a flow to find the mark that
>>> should be used with the FIB lookup. correct?
>>
>> Let me briefly present my high-level use case here to give more colour.
>> What I am building is an overlay network based on geneve. I have multiple
>> sites, each of which is going to be represented by a separate routing table.
>> The selection of the destination site (routing table) is based on firewall marks
> 
> To show my bias here - VRF is better than firewall marks for selecting
> routing tables. :-)
> 
>> and the original packet is preserved intact, encapsulated in geneve. I have a
>> TC/eBPF program running on the geneve interface which has to query the
>> appropriate routing table based on the firewall mark and use the
>> returned next hop
>> as the tunnel key in the skb. Also worth mentioning is that those routing tables
>> contain multiple (default) routes as I use ECMP to balance traffic/provide HA
>> between sites,
> 
> thanks for explaining the use case

+1

>>>> That said, given h_vlan_proto/h_vlan_TCI are both output parameters,
>>>> maybe we could just union the two fields with a __u32 mark extension
>>>> that we then transfer into the flowi{4,6}?
>>>
>>> That is one option.
>>>
>>> I would go for a union on sport and/or dport. It is a fair tradeoff to
>>> request users to pick one - policy routing based on L4 ports or fwmark.
>>> A bit harder to do with a straight up union at this point, but we could
>>> also limit the supported fwmark to 16-bits. Hard choices have to be made.
>>
>> A couple of comments on those two options: if the union is between the ports
>> and the mark then a user of the function would have to choose between
>> src+dst port or the mark in lookup, correct? If so wouldn't that
>> result in a loss
>> of the ability to use multipathing - since the hashing would be static? In my
>> case that would certainly be another significant drawback.
> 
> yes, good point.
> 
>> Having said that, what Daniel suggests looks very interesting to me.
>> If I understand
>> it correctly there are 32 bits in h_vlan_proto+h_vlan_TCI that are used only for
>> output today so if they are merged in a union with a 32 bit mark then we'd stay
>> at 64B structure and we can pass a full 32 bit mark.
>>
>> So something like this?
>> union {
>>      /* input */
>>      __u32 mark;
>>
>>      /* output */
>>      __be16 h_vlan_proto;
>>      __be16 h_vlan_TCI;
>> }
> 
> I think more like this:
> 
> 	union {
> 		/* input: fwmark to use in lookup */
> 		__u32 fwmark;
> 
> 		/* output: vlan information if egress is on a vlan */
> 		struct {
> 			__be16  h_vlan_proto;
> 			__be16  h_vlan_TCI;
> 		};
> 	};

Agree.

> But, I do not think the vlan data should be overloaded right now. We
> still have an open design issue around supporting vlans on ingress
> (XDP). One option is to allow the lookup to take the vlan as an input,
> have the the bpf helper lookup the vlan device that goes with the
> {device index, vlan} pair and use that as the input device. If we
> overload the vlan_TCI with fwmark that prohibits this option.

I guess it's not overly pretty, but if all things break down and there's no other
unused space, wouldn't it work if we opt into the vlan as input (instead of mark)
in future via flag?

>> Moreover, there are 12 extra bytes used only as output for the smac/dmac.
>> If the above works then maybe this opens up the opportunity to incorporate
>> even more input parameters that way?
> 
> I think that's going to be tricky since the macs are 6-byte arrays.

Thanks,
Daniel
