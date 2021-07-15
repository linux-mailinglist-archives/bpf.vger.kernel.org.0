Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D133F3C9C5E
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhGOKHl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 06:07:41 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44529 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241116AbhGOKHk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Jul 2021 06:07:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 674183200989;
        Thu, 15 Jul 2021 06:04:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 15 Jul 2021 06:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=g2VA3jMO9HgRtkLbT/YGIryDzAVKPLHZaTLQTOHPS
        3s=; b=ZKt+oAe/LfWjX8vuzIui7HGMrSC0yEVuTe68Jj2/UBop5ZgjIJE8L+aFG
        yTmb7EaTVesMXtLw76m3mxsAAg51xvBTeGFAiblUy3co41ewgqxWgmKk4EO+t63a
        q3yikJi6AXFVAiwbaLhY2KKPA3PZR3I/2dj02Wwu8iPgXSvPLPuTw6j5VS4nPyZo
        vGWieU0qm4U3UDxImCOp2lpsA/FSxSBNVDyEOc5JQ0vKXTnQonaTHZzSkKhPD/Ys
        RQ1HxaHYF4sAGQ1UpVemDoJaXxXIcvcps4a8wtj7fhz+eASCa9/rDuFf8f2zjNOh
        jqEfQSTsKA/AWYV3KgWlSL9wZElEg==
X-ME-Sender: <xms:OwjwYAZNPBRqdIqsRA8eIYwzg5a4ssJxtY8eqra_56B7fRoMQFWheg>
    <xme:OwjwYLZLXkgqGZmY8m-daALVe-lYS2sURP555n3sYob3M_kdqYSX9ELzvFLQGlF2e
    ALc7FViYqixxHoJc5s>
X-ME-Received: <xmr:OwjwYK8YVB--JiGnvsg8_SGR6TrYCWt6uMqILFjt8W1ZC23CQ14jIAd0IU0uQ84C2rSddbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnhepvddukeekueetieffteeltedukeeuveeugfelfffhgfdvkeejkeekgffhleffkeel
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmsehlrghmsggurgdrlhht
X-ME-Proxy: <xmx:OwjwYKooM62xD0JaB9IPEzDjAEbiLIjGX-fwqQfA0hDaZStBl6jkbQ>
    <xmx:OwjwYLrQTNonw5iJa4J3CbsU5L3HoRHSOBH9piQKYw2T6UMOOQ45Qg>
    <xmx:OwjwYISXmi6Ecq8twT2JZtm7QSfJcg4QUUIUZf4a7JBh1Z4MFY_W6Q>
    <xmx:PQjwYC17N0cGEDXl5z8IczW7LTKvsmHrroc5Aeky2T6kdDI-01KwSg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 06:04:41 -0400 (EDT)
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
 <60ef818f81c18_5a0c120898@john-XPS-13-9370.notmuch>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <f3aff467-7dbb-5aed-d3f8-32af62bcc53f@lambda.lt>
Date:   Thu, 15 Jul 2021 12:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ef818f81c18_5a0c120898@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/21 2:30 AM, John Fastabend wrote:
> Martynas Pumputis wrote:
>> If creating an outer map of a BTF-defined map-in-map fails (via
>> bpf_object__create_map()), then the previously created its inner map
>> won't be destroyed.
>>
>> Fix this by ensuring that the destroy routines are not bypassed in the
>> case of a failure.
>>
>> Fixes: 646f02ffdd49c ("libbpf: Add BTF-defined map-in-map support")
>> Reported-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   tools/lib/bpf/libbpf.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6f5e2757bb3c..1a840e81ea0a 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -4479,6 +4479,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>   {
>>   	struct bpf_create_map_attr create_attr;
>>   	struct bpf_map_def *def = &map->def;
>> +	int ret = 0;
>>   
>>   	memset(&create_attr, 0, sizeof(create_attr));
>>   
>> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>   	}
>>   
>>   	if (map->fd < 0)
>> -		return -errno;
>> +		ret = -errno;
>>   
> 
> I'm trying to track this down, not being overly familiar with this bit of
> code.
> 
> We entered bpf_object__create_map with map->inner_map potentially set and
> then here we are going to zfree(&map->inner_map). I'm trying to track
> down if this is problematic, I guess not? But seems like we could
> also free a map here that we didn't create from this call in the above
> logic.
> 

Keep in mind that we free the inner map anyway if the creation of the 
outer map was successful. Also, we don't try to recreate the map if any 
of the steps has failed. So I think it should not be problematic.


>>   	if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
> 
>          if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
>                  if (obj->gen_loader)
>                          map->inner_map->fd = -1;
>                  bpf_map__destroy(map->inner_map);
>                  zfree(&map->inner_map);
>          }
> 
> 
> Also not sure here, sorry didn't have time to follow too thoroughly
> will check again later. But, the 'map->inner_map->fd = -1' is going to
> cause bpf_map__destroy to bypass the close(fd) as I understand it.
> So are we leaking an fd if the inner_map->fd is coming from above
> create? Or maybe never happens because obj->gen_loader is NULL?

I think in the case of obj->gen_loader, we don't need to close the FD of 
any map, as the creation of maps will happen at a later stage in the 
kernel: 
https://lore.kernel.org/bpf/20210514003623.28033-15-alexei.starovoitov@gmail.com/.

> 
> Thanks!
> 
> 
>>   		if (obj->gen_loader)
>> @@ -4570,7 +4571,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>   		zfree(&map->inner_map);
>>   	}
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
>> -- 
>> 2.32.0
>>
> 
> 
