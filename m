Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06E73AE358
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFUGor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 02:44:47 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:60765 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUGoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 02:44:46 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 2FD4CC0415
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 06:34:29 +0000 (UTC)
Received: (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 360E3C0003;
        Mon, 21 Jun 2021 06:34:06 +0000 (UTC)
Subject: Re: BPF calls to modules?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
 <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <30629163-4a65-43f6-c620-9611e45815c4@ghiti.fr>
Date:   Mon, 21 Jun 2021 08:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Le 18/06/2021 à 19:32, Andrii Nakryiko a écrit :
> On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi guys,
>>
>> First, pardon my ignorance regarding BPF, the following might be silly.
>>
>> We were wondering here
>> https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.2d27d2ac@xhacker/
>> if BPF programs that now have the capability to call kernel functions
>> (https://lwn.net/Articles/856005/) can also call modules function or
>> vice-versa?
> 
> Not yet, but it was an explicit design consideration and there was
> public interest just recently. So I'd say this is going to happen
> sooner rather than later.
> 
>>
>> The underlying important fact is that in riscv, we are limited to 2GB
>> offset to call functions and that restricts where we can place modules
>> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
>> the current possibly wrong layout).
>>
>> So should we make sure that modules and BPF lie in the same 2GB region?
> 
> Based on the above and what you are explaining about 2GB limits, I'd
> say yes?.. Or alternatively those 2GB restrictions might perhaps be
> lifted somehow?


Actually we have this limit when we have PC-relative branch which is our 
current code model. To better understand what happened, I took a look at 
our JIT implementation and noticed that BPF_CALL are implemented using 
absolute addressing so for this pseudo-instruction, the limit I evoked 
does not apply. How are the kernel (and modules) symbol addresses 
resolved? Is it relative or absolute? Is there then any guarantee that a 
kernel or module call will always emit a BPF_CALL?

Thanks Alexei and Andrii for your answers,

Alex

> 
>>
>> Thanks,
>>
>> Alex
