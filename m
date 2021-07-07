Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AAC3BE669
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhGGKi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 06:38:57 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56017 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbhGGKi5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 06:38:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 885B43200319;
        Wed,  7 Jul 2021 06:36:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 07 Jul 2021 06:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=VL36DON+IZ1aWBLYLCDZKYnQeItphrkWUpGhAvTy7
        AI=; b=P/JT+yeK2lrR7WBQ9vC2bg9JN/dOQxmhGkivZSbCC+OTTUa4aQrbdFPHA
        MtJRkPXh0pU70sbE+hFa5QERBdRFQ940NHK+kgYxO3YULC1sy5C2VyJkGEYJo/nq
        LbCPP4JBB7Z0J6VikWEYJXGRnnvZk+cQh9lP6gdULFJ+REDBVV57EoUFHBnKPMaU
        RgBjmP5MXok7KK2IkS/dqEreBeeJoxAmCi1D3wrW9JbcxPi9Ikth2VvGTsd2Xba/
        0j5LvM1dJEQQhAw2Wrb+OUsP6dI2TkGRduRE24OE0e7wocYbgrrpWrmJ8V2XI87V
        mfFHlc/x/rxaUDpWfTmKEst9cBeuQ==
X-ME-Sender: <xms:n4PlYJcGvZzJK4bvCiazX6845nJqKiidZxPpYlDZtOk61cHejgqDRw>
    <xme:n4PlYHOUkd3pMFX8bILFPqz5Amh1C464GBrWrYHLc5YNHx2NNVFmK9BjzFIKcnNyw
    xcU2df9gEJrGrVULEc>
X-ME-Received: <xmr:n4PlYCjfv61o4ql6dkBKQDme9RQDxLZezDlgGMm2SW52q5nj6PpOAAmXQVrSDTf7rP9WPxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnheptdffkeelgeegheduieeiffefudefgfduuefhjefftddtteehveeludduteduffdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:n4PlYC9g8wqJxdmqJyPfJrOfD_QkvHIG4rPXEXyLX8PY86bUjq79Bg>
    <xmx:n4PlYFvyofv5XoB-UnAY53YX7M7z2O_qedLWGxIdIfapVFfFPo47fA>
    <xmx:n4PlYBGPfHpB-wf1JXVwVawXh1n8gRCNrcCmBntrlkQDQo6tPomepg>
    <xmx:oIPlYO7PWE6CWHQwG0yyMrwmuoRogKzDJqbq32E4oyglJQNJH5tt2A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 06:36:14 -0400 (EDT)
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210706172619.579001-1-m@lambda.lt>
 <CAPhsuW5nyaM5MNg=Q0ojLVQVsnyDrJNukB3WTQ+sk8t4etZiGA@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <1e96972a-c080-5f11-ab81-3680d594676d@lambda.lt>
Date:   Wed, 7 Jul 2021 12:38:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5nyaM5MNg=Q0ojLVQVsnyDrJNukB3WTQ+sk8t4etZiGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/7/21 1:32 AM, Song Liu wrote:
> On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
>>
>> When loading a BPF program with a pinned map, the loader checks whether
>> the pinned map can be reused, i.e. their properties match. To derive
>> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
>> then does the comparison.
>>
>> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
>> available, so loading the program fails with the following error:
>>
>>          libbpf: failed to get map info for map FD 5: Invalid argument
>>          libbpf: couldn't reuse pinned map at
>>                  '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
>>                  mismatch"
>>          libbpf: map 'cilium_call_policy': error reusing pinned map
>>          libbpf: map 'cilium_call_policy': failed to create:
>>                  Invalid argument(-22)
>>          libbpf: failed to load object 'bpf_overlay.o'
>>
>> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
>> doesn't support, then fallback to derivation of the map properties via
>> /proc/$PID/fdinfo/$MAP_FD.
>>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> 
> The code looks good to me. Except a checkpatch CHECK:
> 
> CHECK: Comparison to NULL could be written "!obj"
> #96: FILE: tools/lib/bpf/libbpf.c:3943:
> + if (obj == NULL || kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD))

Thanks for the review. I will send v2 with the fix.

> 
> Also, I think this should target bpf-next tree?

Considering that libbpf is supported on older kernels, w/o this patch it 
is impossible to use it on < 4.12 kernels for programs with pinned maps. 
Therefore, I think that this is a fix and thus it should target the bpf 
tree instead.

> 
> Thanks,
> Song
> 
