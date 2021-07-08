Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAB3BF946
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhGHLqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 07:46:12 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55753 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231675AbhGHLqL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Jul 2021 07:46:11 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 317623200805;
        Thu,  8 Jul 2021 07:43:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Jul 2021 07:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JUw1JsfRBrjaToRjX9X3aoMvT/SRoL277ys6OSnnZ
        CQ=; b=Z7d9mVO0J3+DVVOx/3niwYnU9vuBRDCyGnRAlXnJJocohGjDMt21xHS6n
        5IiyGagQUrzxuhFPvMEu7RNvaQnh8JRCPp+RD/0hBOA+ajBg+XpRPaDVjwi+qXjK
        ALxwZK+HoGzdGkSlXIB1/X2lZD4B9Km36HBN2Xg9OcvbftUZAcCqaBdVgSSv5nJu
        LIlywmcSdevQc+l6adqSz4MBKVocMQTuTaUIFdjIZACOLHLpIhc7rM5QKAUNZ94T
        o/MiTBRLVpfQSUPRdRzjoidUvPG0Ks4UUf0eDqfJ908x3cwwRDicbAE6M2kFlboH
        /j1h8x48ddeFkChSLBppH2KX+GIKQ==
X-ME-Sender: <xms:3uTmYFtWn_56Ta-I53eH6cooA1Guvf_ig7HYc7xSKVIM9N07cXpqyQ>
    <xme:3uTmYOeiR1-1uRG8pRmbKTAHuK9x_USqhg-l7Mj_Vga4a_piIY0F-vwgEJb3b0pqS
    Z8XprV_l9XFrxQ7MBk>
X-ME-Received: <xmr:3uTmYIw-MGTv3B-JWe5kKX4NAyEfVL8fo2nYHxgRnBv76DdPHUzMRLegPNeGdDSWvV3aabc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepteetkeduteehkeelhfelueefhedtjeelteefheelvdegueegiefhleeuffffgfel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:3uTmYMPVr1bCIXTYfVR3XhOUL3rMLaVEw34rsJV_MChIBSUFkjG2JQ>
    <xmx:3uTmYF_68kilrlm1og_d9qJzfwiXgaUkSs3LdXrZc9PPokCdkNJR1w>
    <xmx:3uTmYMWQ4A56aQ-chD7pY3pDFfUqtEvtCXX-Php1WJLi5KxAakRBkQ>
    <xmx:3-TmYHJUWT5J-MUaNz3elI6eqx5O5-sM5cModr1JS01lFDHnQDOwWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 07:43:24 -0400 (EDT)
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210706172619.579001-1-m@lambda.lt>
 <CAEf4BzbCAO=hjA=hSh9QXN3C79xOmM0=Cc0H1gZnhm6LdDz9Sw@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <41795594-5d66-e17e-095c-cc4cdc84a017@lambda.lt>
Date:   Thu, 8 Jul 2021 13:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbCAO=hjA=hSh9QXN3C79xOmM0=Cc0H1gZnhm6LdDz9Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/8/21 12:58 AM, Andrii Nakryiko wrote:
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
>> ---
>>   tools/lib/bpf/libbpf.c | 103 +++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 92 insertions(+), 11 deletions(-)
>>
> 
> [...]
> 
>> @@ -4406,10 +4478,19 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>>
>>          map_info_len = sizeof(map_info);
>>
>> -       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
>> -               pr_warn("failed to get map info for map FD %d: %s\n",
>> -                       map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
>> -               return false;
>> +       if (kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD)) {
> 
> why not just try bpf_obj_get_info_by_fd() first, and if it fails
> always fallback to bpf_get_map_info_from_fdinfo(). No need to do
> feature detection. This will cut down on the amount of code without
> any regression in behavior. More so, it will actually now be
> consistent and good behavior in case of bpf_map__reuse_fd() where we
> don't have obj. WDYT?

I was thinking about it, but then decided to use the kernel probing 
instead. The reasoning was the following:

1) For programs with many pinned maps we would issue many failing 
BPF_OBJ_GET_INFO_BY_FD calls (instead of a single one) which might 
hinder the performance.
2) A canonical way in libbpf to detect features is via kernel_supports() 
and friends, so I didn't want to diverge there.

Re bpf_map__reuse_fd(), if we are OK to break the API before libbpf 
v1.0, then we could extend bpf_map__reuse_fd() to accept the obj. 
However, this would break some consumers of the lib, e.g., iproute2 [1].

Anyway, if you think that we can ignore 1) and 2), then I'm happy to 
change. Also, I'm going to submit to bpf-next.

[1]: 
https://github.com/shemminger/iproute2/blob/v5.11.0/lib/bpf_libbpf.c#L98

> 
> 
>> +               if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
>> +                       pr_warn("failed to get map info for map FD %d: %s\n",
>> +                               map_fd,
>> +                               libbpf_strerror_r(errno, msg, sizeof(msg)));
>> +                       return false;
>> +               }
> 
> [...]
> 
