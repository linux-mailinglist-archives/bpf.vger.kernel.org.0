Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688233C16A2
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhGHPxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 11:53:38 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53281 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhGHPxg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Jul 2021 11:53:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 259AC32007BE;
        Thu,  8 Jul 2021 11:50:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Jul 2021 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=XXCkZyy7HGSM7zUplyxB1yjtzMWqr7DZgNPuTd8r3
        uc=; b=e9pirr1z7rqj3BnfLc5fK1VaQUrsY8YNW05rJGXK/IW79rXMdp/VvheDP
        b/LZb7Koh5KliwpTpo7c61I/HsoJtd8kQxNr/Gp82hIuLw9/BE2bCV8pTwdci40E
        N/eVYQLPZ+q2QPoo1br67fpWVxC/OPsBv6HGGNGJLxVmZQ+bcd9xxt9jA5RFPWMX
        zUMzr9Ya04HY+ue86zXZ/I3MO1wSgcinO3bMFnx9vTjFmrz4v3YEOYruaGpwvNVr
        ekqj9BHLVGBT2zYSMWUiPHWnjBcp7IKRpOAglF8flFHqntREhwwaEGAY7zuwlnIQ
        1HiH4jAKNCUCDcUaR//WHgVB0dqFQ==
X-ME-Sender: <xms:2h7nYHexmzx0KwyY6cG4vGYL9qL7L2k8DsjRMQs8tDHhi9bJJajrGg>
    <xme:2h7nYNOVZcOrcyI84v8nGjtBOK3VPTt2-0eIZAnQU8h4cKC9Ayl_3pvgInSLb0X1b
    gFbipRINm6j29KQCIc>
X-ME-Received: <xmr:2h7nYAi1wIY8qjDT0bCOiZZoHR6zAgdJGrw-cO6xPbWGBBnTPAyNO1lh7Xemwek9otEA3GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnheptdffkeelgeegheduieeiffefudefgfduuefhjefftddtteehveeludduteduffdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:2x7nYI-w9ZpFgKfInBIKDAVSiAuq1UxfiLIqZmSi8iiWFtj6SycNwQ>
    <xmx:2x7nYDtrVLlCAEm-t02-efof-WmnrqfLnQ6GFpeTY8X7VrAQtqtBVw>
    <xmx:2x7nYHFGk0bIm2KbruhE6q-_ux7PkUYcZRaxtYeTvAtzlS-URqkFSQ>
    <xmx:3B7nYDKpudQEyK55tsDhnp-Kgs05rqwm41FJvJL4PhPRdke5o67wDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jul 2021 11:50:49 -0400 (EDT)
Subject: Re: [PATCH bpf] libbpf: fix race when pinning maps in parallel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Joe Stringer <joe@wand.net.nz>
References: <20210705190926.222119-1-m@lambda.lt>
 <CAEf4BzaHCgNSfoEVXkBweycHtVj2MKBBH45aZy+FM-BTjSJ3kA@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <4f2a546f-8d78-df2e-69eb-75055ff4137d@lambda.lt>
Date:   Thu, 8 Jul 2021 17:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaHCgNSfoEVXkBweycHtVj2MKBBH45aZy+FM-BTjSJ3kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/8/21 12:38 AM, Andrii Nakryiko wrote:
> On Mon, Jul 5, 2021 at 12:08 PM Martynas Pumputis <m@lambda.lt> wrote:
>>
>> When loading in parallel multiple programs which use the same to-be
>> pinned map, it is possible that two instances of the loader will call
>> bpf_object__create_maps() at the same time. If the map doesn't exist
>> when both instances call bpf_object__reuse_map(), then one of the
>> instances will fail with EEXIST when calling bpf_map__pin().
>>
>> Fix the race by retrying creating a map if bpf_map__pin() returns
>> EEXIST. The fix is similar to the one in iproute2: e4c4685fd6e4 ("bpf:
>> Fix race condition with map pinning").
>>
>> Cc: Joe Stringer <joe@wand.net.nz>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   tools/lib/bpf/libbpf.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 1e04ce724240..7a31c7c3cd21 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -4616,10 +4616,12 @@ bpf_object__create_maps(struct bpf_object *obj)
>>          char *cp, errmsg[STRERR_BUFSIZE];
>>          unsigned int i, j;
>>          int err;
>> +       bool retried = false;
> 
> retried has to be reset for each map, so just move it inside the for
> loop? you can also generalize it to retry_cnt (> 1 attempts) to allow
> for more extreme cases of multiple loaders fighting very heavily

If we move "retried = false" to inside the loop, then there is no need 
for retry_cnt. Single retry for each map should be enough to resolve the 
race. In any case, I'm going to move "retried = false", as you suggested.

> 
>>
>>          for (i = 0; i < obj->nr_maps; i++) {
>>                  map = &obj->maps[i];
>>
>> +retry:
>>                  if (map->pin_path) {
>>                          err = bpf_object__reuse_map(map);
>>                          if (err) {
>> @@ -4660,9 +4662,13 @@ bpf_object__create_maps(struct bpf_object *obj)
>>                  if (map->pin_path && !map->pinned) {
>>                          err = bpf_map__pin(map, NULL);
>>                          if (err) {
>> +                               zclose(map->fd);
>> +                               if (!retried && err == EEXIST) {
> 
> so I'm also wondering... should we commit at this point to trying to
> pin and not attempt to re-create the map? I'm worried that
> bpf_object__create_map() is not designed and tested to be called
> multiple times for the same bpf_map, but it's technically possible for
> it to be called multiple times in this scenario. Check the inner map

Good call. I'm going to add "if (retried && map->fd < 0) { return 
-ENOENT; }" after the "if (map->pinned) { err = bpf_object__reuse_map() 
... }" statement. This should prevent from invoking 
bpf_object__create_map() multiple times.

> creation scenario, for example (btw, I think there is a bug in
> bpf_object__create_map clean up for inner map, care to take a look at
> that as well?).

In the case of the inner map, it should be destroyed inside 
bpf_object__create_map() after a successful BPF_MAP_CREATE. So AFAIU, 
there should be no need for the cleanup. Or do I miss something?

> 
> So unless we want to allow map re-creation if (in a highly unlikely
> scenario) someone already unpinned the other instance, I'd say we
> should just bpf_map__pin() here directly, maybe in a short loop to
> allow for a few attempts.
> 
>> +                                       retried = true;
>> +                                       goto retry;
>> +                               }
>>                                  pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
>>                                          map->name, map->pin_path, err);
>> -                               zclose(map->fd);
>>                                  goto err_out;
>>                          }
>>                  }
>> --
>> 2.32.0
>>
