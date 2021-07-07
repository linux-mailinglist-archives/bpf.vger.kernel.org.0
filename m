Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C23BEAB4
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGGPeK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 11:34:10 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:54824 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhGGPeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 11:34:10 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m19WK-0004Yt-OJ; Wed, 07 Jul 2021 15:31:28 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m19WI-0001RE-Cx; Wed, 07 Jul 2021 16:31:28 +0100
Subject: Re: Access to a BPF map from a module
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
 <CAADnVQL177FHCroCZ_F5hwhgN6GRmoGFwbA4UZCPGVRMpqgEJg@mail.gmail.com>
 <a710b903-aaa5-8bd3-3cb0-14e08f9dbed3@kot-begemot.co.uk>
 <8960fc66-dd4b-7191-d123-2536468fa406@iogearbox.net>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3355b5e4-c355-a5d6-4314-aac8352e6c5a@kot-begemot.co.uk>
Date:   Wed, 7 Jul 2021 16:31:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8960fc66-dd4b-7191-d123-2536468fa406@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 07/07/2021 16:21, Daniel Borkmann wrote:
> On 7/7/21 9:09 AM, Anton Ivanov wrote:
>> On 07/07/2021 01:53, Alexei Starovoitov wrote:
>>> On Mon, Jul 5, 2021 at 9:00 AM Anton Ivanov
>>> <anton.ivanov@kot-begemot.co.uk> wrote:
>>>> Hi List,
>>>>
>>>> I have the following problem.
>>>>
>>>> I want to perform some operations on a bpf map from a loadable module. The map is instantiated elsewhere and pinned.
>>>>
>>>> How do I go about to obtain the map inside the module?
>>>>
>>>> bpf_map_get* functions are not exported at present so they are not available. Is there another way besides them to fetch a bpf map "by fs name" in a kernel module?
>>>>
>>>> If the access limitation is intentional, may I ask what is the actual rationale behind this decision?
>>> BPF objects (like maps) and BPF infra are not extensible or accessible
>>> from modules.
>>
>> Programs are.
>>
>> You can grab a program using bpf_prog_get_type_path and use it. It is an exported symbol.
>
> Right, sadly for the netfilter xt_bpf hack as the only user. :/ The typical way to
> retrieve would be to get the program via bpf_prog_get_type() from modules.
>
>> The only thing missing is an equivalent of bpf_prog_get_type_path for maps, let's say bpf_map_get_path
>>
>> In fact, I already have a patch for that too. I wanted to understand the rationale behind the restriction before submitting it.
>
> There is a bpf_map_get(), out of curiosity, why do you need a path variant specifically?

IIRC, I tried to use that, but ran into another not exported symbol.

In any case, I want to load the switchdev "code" as well as any supporting infra via bpftool and pin it.

The actual module is given paths to the code and maps via sysfs. This allows changing the bpf code on the fly as well as using different versions of the bpf code on a per switch interface basis.


>
>>> That is intentional to make sure that BPF development stays on the public
>>> mailing list and within the kernel.
>>> If you could describe your use case we hopefully will be able to come
>>> up with upstreamable
>>
>> Build a switchdev switch to be used in conjunction with the normal kernel bridge/routing infra which uses BPF "firmware"
>>
>> Rationale:
>>
>> 1. So people can play with switchdev and smartnics in general without having esoteric hardware
>>
>> 2. So people can play with these both on the kernel side and on the "guts/internals" side.
>
> Wouldn't it be enough to load the BPF "firmware" for that switchdev in kernel via regular
> prog fd, meaning similar to what we do with tc BPF case today? From a higher level it
> sounds like the same use case as tc BPF just that its 'internal' to the switchdev.

It is somewhat similar.

The difference is that in order to implement a working "switch" for the switchdev, you end up with multiple instances of the same program having to use common data structures as an IPC. That means loading maps, pinning them and using the pinned maps for the different instances.

>
>>> alternative to your proprietary module.
>> I intend to upstream it. In fact the WIP is already on github.
>
> Thanks,
> Daniel
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

