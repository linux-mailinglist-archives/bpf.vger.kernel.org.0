Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140DF3CB9A5
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhGPPY7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 11:24:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40739 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbhGPPY6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Jul 2021 11:24:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AF5065C010C;
        Fri, 16 Jul 2021 11:22:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 16 Jul 2021 11:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=EnQnVNaYAbWAfONTqxilzZm3cLax0YiVucCGLrJIZ
        Mc=; b=hDfLTRNiLOY7tdaJjyUBsOjWyZ0gLCj+CkDnMhLeX+eayijdde/4L5CDA
        qgb8XMH2Od8RRhQ0opCAVj8qJOzYjzzUybvP6MTyYHBvTZRWp/soAYnOhWW7PAtM
        x+3BUB6kcq9AjqfpKNGxB8EKO3OX+ifVi1l/uA5AXfJRkZHKWd4LKQD3RCYGWFh+
        9bNiPC14YFzj73Smno3NianbqUQVYVAhwMKCUMNETKO0ddzXuahLMTH6DUqVrx/M
        XGJW+rD7V3z/xxdOdS56+s/0LgqiLYU+r0D5I72H7V5N62gZXfIvcYz7eKNBpMuX
        Dr38x1/UNguGTswLy+NRCvd68PdbA==
X-ME-Sender: <xms:GqTxYP2gPsZwcRqo6vrnh0A_rSNecYR6FbBl7E-_t5_lkLucN-tT-Q>
    <xme:GqTxYOH1f8RZ22XLXNVl6wVhIfZdCbBPuZJpgqvSZag6aCtj6Or-OToikhLnrE2z_
    _-WzAC7kU7APBh9wb0>
X-ME-Received: <xmr:GqTxYP4uMGL6Hodqja0e-UADn3NA7ju73vXFNLMy2BvbFWz-6yPDGJGdE8E66dsBJFJT6xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnheptdffkeelgeegheduieeiffefudefgfduuefhjefftddtteehveeludduteduffdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:GqTxYE2ix_Pwysg5xWqCdhOP2C4Dd1AiZJmt9MxamcH1ZWQ-6c7Wmw>
    <xmx:GqTxYCENEcljxxBdNWxfN0TdODCJTWPR2NSZ36mNBDjSUnD12w1bnw>
    <xmx:GqTxYF_ZYCe483FRatvOzPVEzHsdVXiB8o0Fv16z91Qc0RlosYKQwQ>
    <xmx:G6TxYHQ96qMlsSTNcTtdKJ8hbFnJXaSj_idB473wjCMkkDV0oPKYgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 11:22:01 -0400 (EDT)
Subject: Re: [PATCH bpf 1/2] libbpf: fix removal of inner map in
 bpf_object__create_map
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-2-m@lambda.lt>
 <CAEf4BzbNpqkDGfprj_hH-=3zZNxZ7SkEsCRZnb5==6vfAoXt8w@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <ca789cd7-b8c9-08f9-fca0-d25549967d0d@lambda.lt>
Date:   Fri, 16 Jul 2021 17:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbNpqkDGfprj_hH-=3zZNxZ7SkEsCRZnb5==6vfAoXt8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/16/21 7:27 AM, Andrii Nakryiko wrote:
> On Wed, Jul 14, 2021 at 9:52 AM Martynas Pumputis <m@lambda.lt> wrote:
>>
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
>>          struct bpf_create_map_attr create_attr;
>>          struct bpf_map_def *def = &map->def;
>> +       int ret = 0;
>>
>>          memset(&create_attr, 0, sizeof(create_attr));
>>
>> @@ -4561,7 +4562,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>          }
>>
>>          if (map->fd < 0)
>> -               return -errno;
>> +               ret = -errno;
> 
> Oh, isn't this a complicated function, eh? I stared at the code for a
> while until I understood the whole idea with map->inner_map handling
> there.
> 
> I think your change is correct, I'd just love you to consolidate all
> those "int err" definitions, and use just one throughout this
> function. It will clean up two other if() blocks, and in this case
> "err" name is more appropriate, because it always is <= 0.

Good idea. I will send v2 once we have agreed on the selftesting issue.

> 
>>
>>          if (bpf_map_type__is_map_in_map(def->type) && map->inner_map) {
>>                  if (obj->gen_loader)
>> @@ -4570,7 +4571,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>>                  zfree(&map->inner_map);
>>          }
>>
>> -       return 0;
>> +       return ret;
>>   }
>>
>>   static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
>> --
>> 2.32.0
>>
