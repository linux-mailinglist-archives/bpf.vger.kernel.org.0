Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE6652AEE
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 02:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiLUBWS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 20:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLUBWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 20:22:17 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903241EED3
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:22:15 -0800 (PST)
Message-ID: <1d04bc36-38f8-cda7-1ed9-ef0be31197e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671585734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymJyc/UBqKzR3dT/5GvSIPNBG1uC3OMmBS23Z32ShQs=;
        b=gTDs2I+CLWJdtWhlOKU3NK5ur+RqsDKsIxYX2RmnjwjJ1fuRzHl0mf/QUoVLmNS6sAXNi0
        RbyFIfoT+6Q8K6BgPyimgImXZFrBByGBuhaOihpRseFXJ+igtjBGLnrDNVXpwAlQEIPVd1
        TxPuozY97bfEyKY+pirJ00rZ+XxzeDU=
Date:   Tue, 20 Dec 2022 17:22:11 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] bpf: Reduce smap->elem_size
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Yonghong Song <yhs@fb.com>
References: <20221221011538.3263935-1-martin.lau@linux.dev>
 <CAEf4BzZq5cHGP=e+F1vue4L1kgUwz3Hw_bZ9GMtr9gA75rvT1A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzZq5cHGP=e+F1vue4L1kgUwz3Hw_bZ9GMtr9gA75rvT1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/22 5:17 PM, Andrii Nakryiko wrote:
> On Tue, Dec 20, 2022 at 5:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> 'struct bpf_local_storage_elem' has an unused 56 byte padding at the
>> end due to struct's cache-line alignment requirement. This padding
>> space is overlapped by storage value contents, so if we use sizeof()
>> to calculate the total size, we overinflate it by 56 bytes. Use
>> offsetofend() instead to calculate more exact memory use.
>>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>> v2:
>>    Rephrase the commit message (Andrii and Yonghong)
>>    Use offsetofend instead of offsetof (Andrii)
>>
>>   kernel/bpf/bpf_local_storage.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index b39a46e8fb08..e73fc70071b0 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -580,8 +580,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
>>                  raw_spin_lock_init(&smap->buckets[i].lock);
>>          }
>>
>> -       smap->elem_size =
>> -               sizeof(struct bpf_local_storage_elem) + attr->value_size;
>> +       smap->elem_size = offsetofend(struct bpf_local_storage_elem, sdata) +
>> +               attr->value_size;
> 
> Heh, we raced down to a minute. Copy/pasting my latest reply from
> original thread.

lol.  email is more parallel than most people thought :)

> 
> it just occurred to me
> that your change can be written equivalently (but now I do think it's
> cleaner) as:
> 
> smap->elem_size = offsetof(struct bpf_local_storage_elem,
> sdata.data[attr->value_size]);

Sure. will post v3.

> 
> 
> sdata is embedded struct, no pointer dereference, so single offsetof()
> should be enough to peer inside it
> 
> 
> Whichever you prefer, both versions work for me:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the review.

