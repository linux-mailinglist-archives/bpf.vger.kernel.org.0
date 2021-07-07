Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A181B3BEA9D
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhGGPXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 11:23:49 -0400
Received: from www62.your-server.de ([213.133.104.62]:44726 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGPXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 11:23:49 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1m19MJ-000AKZ-RT; Wed, 07 Jul 2021 17:21:07 +0200
Received: from [85.5.47.65] (helo=linux-3.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1m19MJ-000QHo-Mw; Wed, 07 Jul 2021 17:21:07 +0200
Subject: Re: Access to a BPF map from a module
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
 <CAADnVQL177FHCroCZ_F5hwhgN6GRmoGFwbA4UZCPGVRMpqgEJg@mail.gmail.com>
 <a710b903-aaa5-8bd3-3cb0-14e08f9dbed3@kot-begemot.co.uk>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8960fc66-dd4b-7191-d123-2536468fa406@iogearbox.net>
Date:   Wed, 7 Jul 2021 17:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a710b903-aaa5-8bd3-3cb0-14e08f9dbed3@kot-begemot.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26224/Wed Jul  7 13:08:29 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/7/21 9:09 AM, Anton Ivanov wrote:
> On 07/07/2021 01:53, Alexei Starovoitov wrote:
>> On Mon, Jul 5, 2021 at 9:00 AM Anton Ivanov
>> <anton.ivanov@kot-begemot.co.uk> wrote:
>>> Hi List,
>>>
>>> I have the following problem.
>>>
>>> I want to perform some operations on a bpf map from a loadable module. The map is instantiated elsewhere and pinned.
>>>
>>> How do I go about to obtain the map inside the module?
>>>
>>> bpf_map_get* functions are not exported at present so they are not available. Is there another way besides them to fetch a bpf map "by fs name" in a kernel module?
>>>
>>> If the access limitation is intentional, may I ask what is the actual rationale behind this decision?
>> BPF objects (like maps) and BPF infra are not extensible or accessible
>> from modules.
> 
> Programs are.
> 
> You can grab a program using bpf_prog_get_type_path and use it. It is an exported symbol.

Right, sadly for the netfilter xt_bpf hack as the only user. :/ The typical way to
retrieve would be to get the program via bpf_prog_get_type() from modules.

> The only thing missing is an equivalent of bpf_prog_get_type_path for maps, let's say bpf_map_get_path
> 
> In fact, I already have a patch for that too. I wanted to understand the rationale behind the restriction before submitting it.

There is a bpf_map_get(), out of curiosity, why do you need a path variant specifically?

>> That is intentional to make sure that BPF development stays on the public
>> mailing list and within the kernel.
>> If you could describe your use case we hopefully will be able to come
>> up with upstreamable
> 
> Build a switchdev switch to be used in conjunction with the normal kernel bridge/routing infra which uses BPF "firmware"
> 
> Rationale:
> 
> 1. So people can play with switchdev and smartnics in general without having esoteric hardware
> 
> 2. So people can play with these both on the kernel side and on the "guts/internals" side.

Wouldn't it be enough to load the BPF "firmware" for that switchdev in kernel via regular
prog fd, meaning similar to what we do with tc BPF case today? From a higher level it
sounds like the same use case as tc BPF just that its 'internal' to the switchdev.

>> alternative to your proprietary module.
> I intend to upstream it. In fact the WIP is already on github.

Thanks,
Daniel
