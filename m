Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399F3132D8
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 14:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBHM7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:59:16 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37051 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhBHM7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:59:09 -0500
X-Originating-IP: 78.45.89.65
Received: from [192.168.1.23] (ip-78-45-89-65.net.upcbroadband.cz [78.45.89.65])
        (Authenticated sender: i.maximets@ovn.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F3873E0004;
        Mon,  8 Feb 2021 12:58:24 +0000 (UTC)
Cc:     ovs-dev <ovs-dev@openvswitch.org>, i.maximets@ovn.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        William Tu <u9012063@gmail.com>,
        Gregory Rose <gvrose8192@gmail.com>
References: <1612387304-68681-1-git-send-email-u9012063@gmail.com>
 <d8f4d928-2ee1-234b-c4fe-1d8896b0f338@gmail.com>
 <CALDO+Sa=ohgXUzpY1E2E9CPoYEDZK9AVOTSznZ0WvUD54zEQXA@mail.gmail.com>
 <e3914ec6-ccb5-8d8f-2915-343030e5c7db@gmail.com>
 <CALDO+SabDwkLb85dxAV8R=iRgUyOAy9Q1JKDGXPTVJ+4bCTR9A@mail.gmail.com>
 <ec98f84e-6120-00fc-1a9b-d86e9d371fcc@gmail.com>
From:   Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [PATCH] netdev-afxdp: Add start qid support.
Message-ID: <602f7207-23b4-a237-7651-ad8bdb02ed0e@ovn.org>
Date:   Mon, 8 Feb 2021 13:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec98f84e-6120-00fc-1a9b-d86e9d371fcc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/7/21 5:05 PM, Toshiaki Makita wrote:
> On 2021/02/07 2:00, William Tu wrote:
>> On Fri, Feb 5, 2021 at 1:08 PM Gregory Rose <gvrose8192@gmail.com> wrote:
>>> On 2/4/2021 7:08 PM, William Tu wrote:
>>>> On Thu, Feb 4, 2021 at 3:17 PM Gregory Rose <gvrose8192@gmail.com> wrote:
>>>>> On 2/3/2021 1:21 PM, William Tu wrote:
>>>>>> Mellanox card has different XSK design. It requires users to create
>>>>>> dedicated queues for XSK. Unlike Intel's NIC which loads XDP program
>>>>>> to all queues, Mellanox only loads XDP program to a subset of its queue.
>>>>>>
>>>>>> When OVS uses AF_XDP with mlx5, it doesn't replace the existing RX and TX
>>>>>> queues in the channel with XSK RX and XSK TX queues, but it creates an
>>>>>> additional pair of queues for XSK in that channel. To distinguish
>>>>>> regular and XSK queues, mlx5 uses a different range of qids.
>>>>>> That means, if the card has 24 queues, queues 0..11 correspond to
>>>>>> regular queues, and queues 12..23 are XSK queues.
>>>>>> In this case, we should attach the netdev-afxdp with 'start-qid=12'.
>>>>>>
>>>>>> I tested using Mellanox Connect-X 6Dx, by setting 'start-qid=1', and:
>>>>>>      $ ethtool -L enp2s0f0np0 combined 1
>>>>>>      # queue 0 is for non-XDP traffic, queue 1 is for XSK
>>>>>>      $ ethtool -N enp2s0f0np0 flow-type udp4 action 1
>>>>>> note: we need additionally add flow-redirect rule to queue 1
>>>>>
>>>>> Seems awfully hardware dependent.  Is this just for Mellanox or does
>>>>> it have general usefulness?
>>>>>
>>>> It is just Mellanox's design which requires pre-configure the flow-director.
>>>> I only have cards from Intel and Mellanox so I don't know about other vendors.
>>>>
>>>> Thanks,
>>>> William
>>>>
>>>
>>> I think we need to abstract the HW layer a little bit.  This start-qid
>>> option is specific to a single piece of HW, at least at this point.
>>> We should expect that further HW  specific requirements for
>>> different NIC vendors will come up in the future.  I suggest
>>> adding a hw_options:mellanox:start-qid type hierarchy  so that
>>> as new HW requirements come up we can easily scale.  It will
>>> also make adding new vendors easier in the future.
>>>
>>> Even with NIC vendors you can't always count on each new generation
>>> design to always keep old requirements and methods for feature
>>> enablement.
>>>
>>> What do you think?
>>>
>> Thanks for the feedback.
>> So far I don't know whether other vendors will need this option or not.
> 
> FWIU, this api "The lower half of the available amount of RX queues are regular queues, and the upper half are XSK RX queues." is the result of long discussion to support dedicated/isolated XSK rings, which is not meant for a mellanox-specific feature.
> 
> https://patchwork.ozlabs.org/project/netdev/cover/20190524093431.20887-1-maximmi@mellanox.com/
> https://patchwork.ozlabs.org/project/netdev/cover/20190612155605.22450-1-maximmi@mellanox.com/
> 
> Toshiaki Makita

Thanks for the links.  Very helpful.

From what I understand lower half of queues should still work, i.e.
it should still be possible to attach AF_XDP socket to them.  But
they will not work in zero-copy mode ("generic" only?).
William, could you check that?  Does it work and with which mode
"best-effort" ends up with?  And what kind of errors libbpf returns
if we're trying to enable zero-copy?

There are still few unanswered questions in those discussions and
a clear lack of documentation.  It seems that it's a work-in-progress,
intermediate step towards some better user API.  However it's unclear
how this API will look like and when it will be implemented.


For BPF list and maintainers:

Is it possible to have some of this behavior documented?
How can application determine which netdevs are using this upper/bottom
half schema for their regular and xsk channels/queues?  How users
should do that without digging into the kernel code or spending
few hours googling for presentations from some conferences?

And I actually failed to find any written reference to the fact that
I have to manually configure redirection of the traffic in order to
receive it on XSK queues/channels and not on regular ones.  This is
very confusing and hard to understand, especially for a regular OVS
user who is not familiar with XDP and kernel internals and just wants
to utilize faster userspace networking.

> 
>> I think adding another "hw_options" is a little confusing because this
>> is already an option on the device.
>> Looking at AF_XDP driver at DPDK, it also has similar option:
>> see start_queue
>> https://doc.dpdk.org/guides/nics/af_xdp.html

This option for DPDK mainly positioned as a way to utilize multi-queue
and a way to create different DPDK ports from different ranges of
queues of the same device, so it's not exactly the same thing.  But
I see that it likely had a double purpose that wasn't mentioned in a
commit message or documentation.

I think, for now we can have this option in OVS in a same way, i.e.
as a way to partition the device or as a way to use particular
range of queues from the device instead of using it as a whole.
This way we will not need to have any vendor-specific knobs while
allowing to use generic knob to utilize vendor-specific restrictions
at the same time.

BTW, I didn't look at the patch itself yet, will get back with
the actual review later.

Best regards, Ilya Maximets.
