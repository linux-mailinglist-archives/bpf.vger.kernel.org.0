Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE93C9C7C
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhGOKR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 06:17:59 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41455 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhGOKR7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Jul 2021 06:17:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A29073200975;
        Thu, 15 Jul 2021 06:15:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Jul 2021 06:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=PBwikTtPtQp3Q1SJgia8ov61KYOrQzB7p5bFm7cbs
        iw=; b=Sr0ejUl3U2AkMPrrwtaXg5r/dLKEQpJ6sfiJTX86CTxmzMlQ8cYzKLpPj
        Atye7MeBsEUlh+ROFmKpoiykuzwSVEH+Susd/Gsxga3DJXgHSerlmdj9pUneNpNx
        DgIjA7bnYYkjK882jf4zcXW27QtkPuTvsfdl8QZ1HkXt6u3reH1dVKmFK2R0gBKo
        eHRP2JpR0z/Pxe0sSMaB9xERJquSazopD2ur62LJwKPclHYVsnesNJBs0I6NKxad
        wrj6MuMlI0DZACK+4h1jGkhyONlxiguI+YW3QmziHZKyWe/HzYBF+4qnoNkHTrCi
        03jxZ9pyC66fdCGnjaKxcEP432K5g==
X-ME-Sender: <xms:pwrwYLb23-lDC8cZs7tRyI8cHJWjI0XmX-Q2uONJzFvJD6yxMlghZw>
    <xme:pwrwYKarwVdHNmilw8GM-DE6h7lnpDPpElf9ZxjOBQ1YQfghu7XdQu_00E1tPX09S
    0eFAlhLrOZuz5GUG5M>
X-ME-Received: <xmr:pwrwYN-RFYZNJeMbbpeTj_sVsKd5zRcQThMcRN2GIhYBmfolyeHoBz84Ahyj-8v6WSwx1Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnheptdffkeelgeegheduieeiffefudefgfduuefhjefftddtteehveeludduteduffdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:pwrwYBritJjwlP6q-_DFbK7qpGPrEjCZIByB_3opb8oCpe6hhnyi7A>
    <xmx:pwrwYGplY8CqPD-fd0TIt8vrhSwFjHYdaqvXxgVyuAeacx-eBHzMyg>
    <xmx:pwrwYHQGDiIKnIQWQHWGp7LzbGTgyB163w7IjQGDuwq4yl7jVwQDwA>
    <xmx:qQrwYJVGPfq5F3611GwA5zWzMWSgG7YlWn4pnrPgpdSDKAGryIQvgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 06:15:02 -0400 (EDT)
Subject: Re: [PATCH bpf] libbpf: fix race when pinning maps in parallel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Joe Stringer <joe@wand.net.nz>
References: <20210705190926.222119-1-m@lambda.lt>
 <CAEf4BzaHCgNSfoEVXkBweycHtVj2MKBBH45aZy+FM-BTjSJ3kA@mail.gmail.com>
 <4f2a546f-8d78-df2e-69eb-75055ff4137d@lambda.lt>
 <CAEf4BzYaQsD6NaEUij6ttDeKYP7oEB0=c0D9_xdAKw6FYb7h1g@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <b716a52c-0a94-9de1-b3fe-51e00540e964@lambda.lt>
Date:   Thu, 15 Jul 2021 12:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYaQsD6NaEUij6ttDeKYP7oEB0=c0D9_xdAKw6FYb7h1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/8/21 10:33 PM, Andrii Nakryiko wrote:
> On Thu, Jul 8, 2021 at 8:50 AM Martynas Pumputis <m@lambda.lt> wrote:
>>
>>
>>
>> On 7/8/21 12:38 AM, Andrii Nakryiko wrote:
>>> On Mon, Jul 5, 2021 at 12:08 PM Martynas Pumputis <m@lambda.lt> wrote:
>>>>
>>>> When loading in parallel multiple programs which use the same to-be
>>>> pinned map, it is possible that two instances of the loader will call
>>>> bpf_object__create_maps() at the same time. If the map doesn't exist
>>>> when both instances call bpf_object__reuse_map(), then one of the
>>>> instances will fail with EEXIST when calling bpf_map__pin().
>>>>
>>>> Fix the race by retrying creating a map if bpf_map__pin() returns
>>>> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
>>>> Fix race condition with map pinning").
>>>>
>>>> Cc: Joe Stringer <joe@wand.net.nz>
>>>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 1e04ce724240..7a31c7c3cd21 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -4616,10 +4616,12 @@ bpf_object__create_maps(struct bpf_object *obj)
>>>>           char *cp, errmsg[STRERR_BUFSIZE];
>>>>           unsigned int i, j;
>>>>           int err;
>>>> +       bool retried = false;
>>>
>>> retried has to be reset for each map, so just move it inside the for
>>> loop? you can also generalize it to retry_cnt (> 1 attempts) to allow
>>> for more extreme cases of multiple loaders fighting very heavily
>>
>> If we move "retried = false" to inside the loop, then there is no need
>> for retry_cnt. Single retry for each map should be enough to resolve the
>> race. In any case, I'm going to move "retried = false", as you suggested.
> 
> Right, I was originally thinking about the case where already pinned
> map might get unpinned. But then subsequently rejected the idea of
> re-creating the map :) So single retry should do.
> 
>>
>>>
>>>>
>>>>           for (i = 0; i < obj->nr_maps; i++) {
>>>>                   map = &obj->maps[i];
>>>>
>>>> +retry:
>>>>                   if (map->pin_path) {
>>>>                           err = bpf_object__reuse_map(map);
>>>>                           if (err) {
>>>> @@ -4660,9 +4662,13 @@ bpf_object__create_maps(struct bpf_object *obj)
>>>>                   if (map->pin_path && !map->pinned) {
>>>>                           err = bpf_map__pin(map, NULL);
>>>>                           if (err) {
>>>> +                               zclose(map->fd);
>>>> +                               if (!retried && err == EEXIST) {
>>>
>>> so I'm also wondering... should we commit at this point to trying to
>>> pin and not attempt to re-create the map? I'm worried that
>>> bpf_object__create_map() is not designed and tested to be called
>>> multiple times for the same bpf_map, but it's technically possible for
>>> it to be called multiple times in this scenario. Check the inner map
>>
>> Good call. I'm going to add "if (retried && map->fd < 0) { return
>> -ENOENT; }" after the "if (map->pinned) { err = bpf_object__reuse_map()
>> ... }" statement. This should prevent from invoking
>> bpf_object__create_map() multiple times.
>>
>>> creation scenario, for example (btw, I think there is a bug in
>>> bpf_object__create_map clean up for inner map, care to take a look at
>>> that as well?).
>>
>> In the case of the inner map, it should be destroyed inside
>> bpf_object__create_map() after a successful BPF_MAP_CREATE. So AFAIU,
>> there should be no need for the cleanup. Or do I miss something?
> 
> But if outer map creation fails, we won't do
> bpf_map__destroy(map->inner_map);, which is one bug. And then with
> your retry logic we also don't clean up the internal state of the
> bpf_map, which is another one. It would be good to add a self-test
> simulating such situations (e.g., by specifying wrong key_size for
> outer_map, but correct inner_map definition). Not sure how to reliably
> simulate this pinning race, though.
> 
> Can you please add at least the first test case?

Yep, I've sent the patch with a test case for the first bug. Thanks for 
explaining.

Anyway, regarding the proposed retry, I think the safest approach is to 
bail before invoking bpf_object__create_map() for the second time (when 
we retry). This would avoid any issues with idempotence of 
bpf_object__create_map() and should solve most of the cases (except when 
a map gets unpinned before the retry, but I expect this to be a very 
unusual and rare situation).

> 
>>
>>>
>>> So unless we want to allow map re-creation if (in a highly unlikely
>>> scenario) someone already unpinned the other instance, I'd say we
>>> should just bpf_map__pin() here directly, maybe in a short loop to
>>> allow for a few attempts.
>>>
>>>> +                                       retried = true;
>>>> +                                       goto retry;
>>>> +                               }
>>>>                                   pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
>>>>                                           map->name, map->pin_path, err);
>>>> -                               zclose(map->fd);
>>>>                                   goto err_out;
>>>>                           }
>>>>                   }
>>>> --
>>>> 2.32.0
>>>>
