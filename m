Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C13BE367
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhGGHMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 03:12:10 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:54202 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhGGHMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 03:12:09 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m11gW-0002zG-Gv; Wed, 07 Jul 2021 07:09:28 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1m11gU-0001xT-7t; Wed, 07 Jul 2021 08:09:28 +0100
Subject: Re: Access to a BPF map from a module
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <dc71d2f8-acd8-c88a-1ec6-1b733fa03440@kot-begemot.co.uk>
 <CAADnVQL177FHCroCZ_F5hwhgN6GRmoGFwbA4UZCPGVRMpqgEJg@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <a710b903-aaa5-8bd3-3cb0-14e08f9dbed3@kot-begemot.co.uk>
Date:   Wed, 7 Jul 2021 08:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQL177FHCroCZ_F5hwhgN6GRmoGFwbA4UZCPGVRMpqgEJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 07/07/2021 01:53, Alexei Starovoitov wrote:
> On Mon, Jul 5, 2021 at 9:00 AM Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> Hi List,
>>
>> I have the following problem.
>>
>> I want to perform some operations on a bpf map from a loadable module. The map is instantiated elsewhere and pinned.
>>
>> How do I go about to obtain the map inside the module?
>>
>> bpf_map_get* functions are not exported at present so they are not available. Is there another way besides them to fetch a bpf map "by fs name" in a kernel module?
>>
>> If the access limitation is intentional, may I ask what is the actual rationale behind this decision?
> BPF objects (like maps) and BPF infra are not extensible or accessible
> from modules.

Programs are.

You can grab a program using bpf_prog_get_type_path and use it. It is an exported symbol.

The only thing missing is an equivalent of bpf_prog_get_type_path for maps, let's say bpf_map_get_path

In fact, I already have a patch for that too. I wanted to understand the rationale behind the restriction before submitting it.

> That is intentional to make sure that BPF development stays on the public
> mailing list and within the kernel.
> If you could describe your use case we hopefully will be able to come
> up with upstreamable

Build a switchdev switch to be used in conjunction with the normal kernel bridge/routing infra which uses BPF "firmware"

Rationale:

1. So people can play with switchdev and smartnics in general without having esoteric hardware

2. So people can play with these both on the kernel side and on the "guts/internals" side.

> alternative to your proprietary module.
I intend to upstream it. In fact the WIP is already on github.
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

