Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2748755A
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbiAGKUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 05:20:05 -0500
Received: from www62.your-server.de ([213.133.104.62]:41958 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiAGKUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 05:20:05 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mLp-000CWp-Jl; Fri, 07 Jan 2022 11:20:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mLp-000HOu-9F; Fri, 07 Jan 2022 11:20:01 +0100
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        johan.almbladh@anyfinetworks.com, Jiri Olsa <jolsa@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, song@kernel.org, ykaliuta@redhat.com
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
 <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4893ddd3-f0ef-003b-3445-57ce5dc1b065@iogearbox.net>
Date:   Fri, 7 Jan 2022 11:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1641540707.ewk8tpqmvl.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26415/Fri Jan  7 10:26:59 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/7/22 8:36 AM, Naveen N. Rao wrote:
> Daniel Borkmann wrote:
>> On 1/6/22 12:45 PM, Naveen N. Rao wrote:
>>> A set of fixes and updates to powerpc BPF JIT:
>>> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>>>    for -stable.
>>> - Patch 4 fixes a build issue with bpf selftests on powerpc.
>>> - Patches 5-9 handle some corner cases and make some small improvements.
>>> - Patches 10-13 optimize how function calls are handled in ppc64.
>>>
>>> Patches 7 and 8 were previously posted, and while patch 7 has no
>>> changes, patch 8 has been reworked to handle BPF_EXIT differently.
>>
>> Is the plan to route these via ppc trees? Fwiw, patch 1 and 4 look generic
>> and in general good to me, we could also take these two via bpf-next tree
>> given outside of arch/powerpc/? Whichever works best.
> 
> Yes, I would like to route this through the powerpc tree. Though patches 1 and 4 are generic, they primarily affect powerpc and I do not see conflicting changes in bpf-next. Request you to please ack those patches so that Michael can take it through the powerpc tree.

Ok, works for me. I presume this will end up in the upcoming merge window
anyway, so not too long time until we can sync these back to bpf/bpf-next
trees then.

Thanks!
Daniel
