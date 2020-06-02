Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB91EBE9C
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFBPBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 11:01:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:37796 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgFBPBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 11:01:15 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jg8Pg-0007l5-LZ; Tue, 02 Jun 2020 17:01:12 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jg8Pg-000WjS-CY; Tue, 02 Jun 2020 17:01:12 +0200
Subject: Re: Checksum behaviour of bpf_redirected packets
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <CACAyw9-uU_52esMd1JjuA80fRPHJv5vsSg8GnfW3t_qDU4aVKQ@mail.gmail.com>
 <CAADnVQKZ63d5A+Jv8bbXzo2RKNCXFH78zos0AjpbJ3ii9OHW0g@mail.gmail.com>
 <CACAyw9_ygNV1J+PkBJ-i7ysU_Y=rN3Z5adKYExNXCic0gumaow@mail.gmail.com>
 <39d3bee2-dcfc-8240-4c78-2110d639d386@iogearbox.net>
 <CACAyw996Q9SdLz0tAn2jL9wg+m5h1FBsXHmUN0ZtP7D5ohY2pg@mail.gmail.com>
 <a4830bd4-d998-9e5c-afd5-c5ec5504f1f3@iogearbox.net>
 <CACAyw99_GkLrxEj13R1ZJpnw_eWxhZas=72rtR8Pgt_Vq3dbeg@mail.gmail.com>
 <ff8e3902-9385-11ee-3cc5-44dd3355c9fc@iogearbox.net>
 <CACAyw9_LPEOvHbmP8UrpwVkwYT57rKWRisai=Z7kbKxOPh5XNQ@mail.gmail.com>
 <alpine.LRH.2.21.2006011839430.623@localhost>
 <835af597-c346-e178-09c4-9f67c9480020@iogearbox.net>
 <alpine.LRH.2.21.2006012217530.15886@localhost>
 <CACAyw98FxUjxmr4ai5JiudV5p3pd4U6fxxULrkMWJtuBKtUDgA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <030555e5-e0ba-3b78-3de3-531eba96245e@iogearbox.net>
Date:   Tue, 2 Jun 2020 17:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACAyw98FxUjxmr4ai5JiudV5p3pd4U6fxxULrkMWJtuBKtUDgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25831/Tue Jun  2 14:41:03 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/2/20 12:13 PM, Lorenz Bauer wrote:
> On Mon, 1 Jun 2020 at 22:25, Alan Maguire <alan.maguire@oracle.com> wrote:
>> On Mon, 1 Jun 2020, Daniel Borkmann wrote:
>>> On 6/1/20 7:48 PM, Alan Maguire wrote:
>>>> On Wed, 13 May 2020, Lorenz Bauer wrote:
>>>>
>>>>>>> Option 1: always downgrade UNNECESSARY to NONE
>>>>>>> - Easiest to back port
>>>>>>> - The helper is safe by default
>>>>>>> - Performance impact unclear
>>>>>>> - No escape hatch for Cilium
>>>>>>>
>>>>>>> Option 2: add a flag to force CHECKSUM_NONE
>>>>>>> - New UAPI, can this be backported?
>>>>>>> - The helper isn't safe by default, needs documentation
>>>>>>> - Escape hatch for Cilium
>>>>>>>
>>>>>>> Option 3: downgrade to CHECKSUM_NONE, add flag to skip this
>>>>>>> - New UAPI, can this be backported?
>>>>>>> - The helper is safe by default
>>>>>>> - Escape hatch for Cilium (though you'd need to detect availability of
>>>>>>> the
>>>>>>>      flag somehow)
>>>>>>
>>>>>> This seems most reasonable to me; I can try and cook a proposal for
>>>>>> tomorrow as
>>>>>> potential fix. Even if we add a flag, this is still backportable to stable
>>>>>> (as
>>>>>> long as the overall patch doesn't get too complex and the backport itself
>>>>>> stays
>>>>>> compatible uapi-wise to latest kernels. We've done that before.). I happen
>>>>>> to
>>>>>> have two ixgbe NICs on some of my test machines which seem to be setting
>>>>>> the
>>>>>> CHECKSUM_UNNECESSARY, so I'll run some experiments from over here as well.
>>>>>
>>>>> Great! I'm happy to test, of course.
>>>>
>>>> I had a go at implementing option 3 as a few colleagues ran into this
>>>> problem. They confirmed the fix below resolved the issue.  Daniel is
>>>> this  roughly what you had in mind? I can submit a patch for the bpf
>>>> tree if that's acceptable with the new flag. Do we need a few
>>>> tests though?
>>>
>>> Coded this [0] up last week which Lorenz gave a spin as well. Originally
>>> wanted to
>>> get it out Friday night, but due to internal release stuff it got too late Fri
>>> night
>>> and didn't want to rush it at 3am anymore, so the series as fixes is going out
>>> tomorrow
>>> morning [today was public holiday in CH over here].
>>
>> Looks great! Although I've only seen this issue arise
>> for cases where csum_level == 0, should we also
>> add "skb->csum_level = 0;" when we reset the
>> ip_summed value?
> 
> FWIW I had the same reaction. Maybe it's worth adding after all, Daniel?

Although not needed, but yeah, fair enough. I've added a small skb helper for it.
Series is out here now, ptal [0].

Thanks,
Daniel

   [0] https://lore.kernel.org/bpf/cover.1591108731.git.daniel@iogearbox.net/
