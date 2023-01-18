Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0435C671A97
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 12:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjARLaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 06:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjARL34 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 06:29:56 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB67C45BC
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:49:09 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pI604-0008Nq-Vo; Wed, 18 Jan 2023 11:49:01 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pI604-0000I1-Dd; Wed, 18 Jan 2023 11:49:00 +0100
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
To:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
 <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
Date:   Wed, 18 Jan 2023 11:48:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26785/Wed Jan 18 09:42:40 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/18/23 3:00 AM, Stanislav Fomichev wrote:
> On Tue, Jan 17, 2023 at 3:19 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Tue, Jan 17, 2023 at 2:20 PM Stanislav Fomichev <sdf@google.com> wrote:
>>> On Tue, Jan 17, 2023 at 2:04 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>> Stanislav Fomichev <sdf@google.com> writes:
>>>>> On Tue, Jan 17, 2023 at 1:27 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>
>>>>>> Following up on the discussion at the BPF office hours, this patch adds a
>>>>>> description of the (new) concept of "stable kfuncs", which are kfuncs that
>>>>>> offer a "more stable" interface than what we have now, but is still not
>>>>>> part of UAPI.
>>>>>>
>>>>>> This is mostly meant as a straw man proposal to focus discussions around
>>>>>> stability guarantees. From the discussion, it seemed clear that there were
>>>>>> at least some people (myself included) who felt that there needs to be some
>>>>>> way to export functionality that we consider "stable" (in the sense of
>>>>>> "applications can rely on its continuing existence").
>>>>>>
>>>>>> One option is to keep BPF helpers as the stable interface and implement
>>>>>> some technical solution for moving functionality from kfuncs to helpers
>>>>>> once it has stood the test of time and we're comfortable committing to it
>>>>>> as a stable API. Another is to freeze the helper definitions, and instead
>>>>>> use kfuncs for this purpose as well, by marking a subset of them as
>>>>>> "stable" in some way. Or we can do both and have multiple levels of
>>>>>> "stable", I suppose.
>>>>>>
>>>>>> This patch is an attempt to describe what the "stable kfuncs" idea might
>>>>>> look like, as well as to formulate some criteria for what we mean by
>>>>>> "stable", and describe an explicit deprecation procedure. Feel free to
>>>>>> critique any part of this (including rejecting the notion entirely).
>>>>>>
>>>>>> Some people mentioned (in the office hours) that should we decide to go in
>>>>>> this direction, there's some work that needs to be done in libbpf (and
>>>>>> probably the kernel too?) to bring the kfunc developer experience up to par
>>>>>> with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
>>>>>> them discoverable), and having CO-RE support for using them, etc. I kinda
>>>>>> consider that orthogonal to what's described here, but I do think we should
>>>>>> fix those issues before implementing the procedures described here.
>>>>>>
>>>>>> v2:
>>>>>> - Incorporate Daniel's changes
>>>>>>
>>>>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>>>> ---
>>>>>>   Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
>>>>>>   1 file changed, 81 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>>>>>> index 9fd7fb539f85..dd40a4ee35f2 100644
>>>>>> --- a/Documentation/bpf/kfuncs.rst
>>>>>> +++ b/Documentation/bpf/kfuncs.rst
>>>>>> @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
>>>>>>
>>>>>>   BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
>>>>>>   kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
>>>>>> -kfuncs do not have a stable interface and can change from one kernel release to
>>>>>> -another. Hence, BPF programs need to be updated in response to changes in the
>>>>>> -kernel.
>>>>>> +kfuncs by default do not have a stable interface and can change from one kernel
>>>>>> +release to another. Hence, BPF programs may need to be updated in response to
>>>>>> +changes in the kernel. See :ref:`BPF_kfunc_stability`.
>>>>>>
>>>>>>   2. Defining a kfunc
>>>>>>   ===================
>>>>>> @@ -223,14 +223,89 @@ type. An example is shown below::
>>>>>>           }
>>>>>>           late_initcall(init_subsystem);
>>>>>>
>>>>>> -3. Core kfuncs
>>>>>> +
>>>>>> +.. _BPF_kfunc_stability:

small nit: please also link from Documentation/bpf/bpf_design_QA.rst, so these sections
here are easier to find.

>>>>>> +3. API (in)stability of kfuncs
>>>>>> +==============================
>>>>>> +
>>>>>> +By default, kfuncs exported to BPF programs are considered a kernel-internal
>>>>>> +interface that can change between kernel versions. This means that BPF programs
>>>>>> +using kfuncs may need to adapt to changes between kernel versions. In the
>>>>>> +extreme case that could also include removal of a kfunc. In other words, kfuncs
>>>>>> +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought of as
>>>>>> +being similar to internal kernel API functions exported using the
>>>>>
>>>>> [..]
>>>>>
>>>>>> +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
>>>>>> +initially start out as kfuncs.
>>>>>
>>>>> To clarify, as part of this proposal, are we making a decision here
>>>>> that we ban new helpers going forward?
>>>>
>>>> Good question! That is one of the things I'm hoping we can clear up by
>>>> this discussing. I don't have a strong opinion on the matter myself, as
>>>> long as there is *some* way to mark a subset of helpers/kfuncs as
>>>> "stable"...
>>>
>>> Might be worth it to capitalize in this case to indicate that it's a
>>> MUST from the RFC world? (or go with SHOULD otherwise).
>>> I'm fine either way. The only thing that stops me from fully embracing
>>> MUST is the kfunc requirement on the explicit jit support; I'm not
>>> sure why it exists and at this point I'm too afraid to ask. But having
>>> MUST here might give us motivation to address the shortcomings...
>>
>> Did you do:
>> git grep bpf_jit_supports_kfunc_call
>> and didn't find your favorite architecture there and
>> didn't find it in the upcoming patches for riscv and arm32?
>> If you care about kfuncs on arm32 please help reviewing posted patches.
> 
> Exactly why I'm going to support whatever decision is being made here.
> Just trying to clarify what that decision is.

My $0.02 is that I don't think we need to make a hard-cut ban as part of this.
The 'All new BPF kernel helper-like functionality must initially start out as
kfuncs.' is pretty clear where things would need to start out with, and we could
leave the option on the table if really needed to go BPF helper route when
promoting kfunc to stable at the same time. I had that in the text suggestion
earlier, it's more corner case and maybe we'll never need it but we also don't
drive ourselves into a corner where we close the door on it. Lets let the infra
around kfuncs evolve further first.

Thanks,
Daniel
