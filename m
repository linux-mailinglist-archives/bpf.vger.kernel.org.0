Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5F3D24E5
	for <lists+bpf@lfdr.de>; Thu, 22 Jul 2021 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhGVNNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 09:13:19 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40139 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231925AbhGVNNT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Jul 2021 09:13:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 85A465C00C8;
        Thu, 22 Jul 2021 09:53:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Jul 2021 09:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=vGXdf02shvAw6KrjYJEpiTQeeEXeTzWC1DC0yls+Z
        Mk=; b=BCAujHUf20HnQ4Tt8XYakF8rIfJawQTvoCu+OmJEfpwG54mObPO6q4sEb
        B7YvuYxnXSEoSgQ7Htd4EgodMG58V25nxB3aNpk3QAOMa1ILu5eb6B4DJk7uyaZR
        NG+CHKRe7ht+m95gqzaRa6uBFmyI8nXpQZeCHP6DoubSdl/88XLUxpF4O2iINGAU
        FjP9Y5y8/iBfebceP/5hlrN7ijrbY5mxjusG2+WaWipBCaQDbDOrZwqEyg07KmKi
        R4zPmySTUzv/heBfoYvqH16MqTVhuRi1JyCuXxfTMNm8jFOtNjd4xV0dEE8aa/5I
        nfTzVbO6bAaKg7VBICLjnO0A/QtwA==
X-ME-Sender: <xms:b3j5YLjpfAWjVHiudxwQVJFb2B9O_-zsKRqOZOW7LwQhJayo0ibB9w>
    <xme:b3j5YIDvwN1yhvbufb4ZxhjMw3-cQ1ZJxp5kgqceJEb5cLk0zexLofCkVArBdi0Pg
    xpwr_82MU0GZ46fAdk>
X-ME-Received: <xmr:b3j5YLFRs4NH1_uQc0rneyv-NAesWDY5GK2_-EpXT8dQz5deE8Fg2MH9wgFQRHAOnpgvHnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepteetkeduteehkeelhfelueefhedtjeelteefheelvdegueegiefhleeuffffgfel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:b3j5YIQ6zkAAfprj0yCGk3g_bbMKDPSYvN6GZa0vwXlJ8rS23yu6BQ>
    <xmx:b3j5YIxGVYaYEjDuT5FEVEUKOAqEU7rDUcD3OCUTuOx0V19X1d0Kag>
    <xmx:b3j5YO5tp8G78PNuwtSb_j6-pTQXHKlZ7TktK0nTIUwb4SKPm4GNVA>
    <xmx:cXj5YE9j6o6LJRekg-RRfk5a7w6bvA2A7PYQSiLFo5-OQr7m4Cl3-w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 09:53:50 -0400 (EDT)
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
Message-ID: <ec9e63d5-70d3-819e-5107-f2ecaa8f8b54@lambda.lt>
Date:   Thu, 22 Jul 2021 15:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
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

Regarding the second case (i.e., not cleaning up the internal state), I 
think no additional cleanup is needed with this patch [1] (main diff 
from prev vsn is that we call bpf_object__map_create() only once).

The relevant calls are the following:

- bpf_object__create_map(): map->inner_map is destroyed anyway after a 
successful call, map->fd is closed if pinning fails.
- bpf_object__populate_internal_map(): created map elements will be 
destroyed upon close(map->fd).
- init_map_slots(): slots are freed after their initialization.

[1]: https://gist.github.com/brb/fff66e47586373fdc1fe39b88175036c

> 
> Can you please add at least the first test case?
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
