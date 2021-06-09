Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791A33A1FD0
	for <lists+bpf@lfdr.de>; Thu, 10 Jun 2021 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFIWKs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 18:10:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:57046 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFIWKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 18:10:48 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lr6NX-000DK5-8J; Thu, 10 Jun 2021 00:08:51 +0200
Received: from [85.7.101.30] (helo=linux-3.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lr6NX-000Kaw-4F; Thu, 10 Jun 2021 00:08:51 +0200
Subject: Re: bpf_fib_lookup support for firewall mark
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
        David Ahern <dsahern@gmail.com>
Cc:     bpf@vger.kernel.org
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com>
 <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
 <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
Date:   Thu, 10 Jun 2021 00:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26196/Wed Jun  9 13:11:28 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Rumen, hi David,

(please avoid top-posting)

On 6/9/21 11:56 PM, Rumen Telbizov wrote:
> List,
> 
> For what it's worth I patched the structure locally by introducing a
> new __u32 mark field
> to the structure and adding the proper assignment of the field in
> filter.c. Recompiled without any issues.
> With that patch a bpf lookup matches ip rule that contains fwmark.
> 
> Still interested to know how much of a performance penalty adding an 4
> bytes to the
> structure brings. I'd certainly vote for adding at least the firewall
> mark to the set of fields used in the lookup.

I agree with David here that performance of the helper is paramount.
As a side-note, we should probably add a build_bug_on() to ensure that
the size of struct bpf_fib_lookup will stay at 64b / one cacheline.

That said, given h_vlan_proto/h_vlan_TCI are both output parameters,
maybe we could just union the two fields with a __u32 mark extension
that we then transfer into the flowi{4,6}?

Thanks,
Daniel

> On Wed, Jun 9, 2021 at 11:30 AM Rumen Telbizov
> <rumen.telbizov@menlosecurity.com> wrote:
>>
>> Hi David,
>>
>> Thanks for the quick response. I appreciate it.
>> A couple of quick follow up questions:
>> 1. Do you have any performance data that would indicate how much of a
>> performance drop adding an extra 4 or 8 bytes to the structure would
>> cause?
>> 2. If I patch locally the structure in libc and the kernel by adding
>> an extra _u32 mark member is there anything that such a modification
>> would break?
>>
>> Regards,
>> Rumen Telbizov
>>
>>
>> On Tue, Jun 8, 2021 at 6:21 PM David Ahern <dsahern@gmail.com> wrote:
>>>
>>> On 6/8/21 4:59 PM, Rumen Telbizov wrote:
>>>> Dear BPF list,
>>>>
>>>> I am new to eBPF so go easy on me.
>>>> It seems to me that currently eBPF has no support for route table
>>>> lookups including firewall marks. The bpf_fib_lookup structure itself
>>>> has no mark field as per
>>>> https://elixir.bootlin.com/linux/v5.10.28/source/include/uapi/linux/bpf.h#L4864
>>>>
>>>> Additionally bpf_fib_lookup() function does not incorporate the
>>>> firewall mark in its route lookup. It explicitly sets it to 0 as per
>>>> https://elixir.bootlin.com/linux/v5.10.28/source/net/core/filter.c#L5329
>>>> along with other fields which are used during the regular routing
>>>> policy database lookup.
>>>>
>>>> Thus lookups from within eBPF and outside of it result in different
>>>> outcomes if there are rules directing traffic based on fwmark.
>>>> Can you please advise what the rationale for this is or if there
>>>> anything that I might be missing.
>>>>
>>>> Let me know if I can provide any further information.
>>>>
>>>
>>> The API (struct bpf_fib_lookup) is constrained to 64B for performance.
>>> It is not possible to support all of the policy routing options that
>>> Linux has in 64B. Choices had to be made.

