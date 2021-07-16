Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAD3CB96A
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbhGPPK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 11:10:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37533 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbhGPPK3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Jul 2021 11:10:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C1EDB5C00EE;
        Fri, 16 Jul 2021 11:07:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 16 Jul 2021 11:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=QIWhicg4KLm9hsWnFub6w2Rx5QJTMR2gTN02819Kz
        ZU=; b=jdPBFRPKglgYglw6Ajs+1sbcA+T6DXZyiyyGzyolM4FrJx64otwv95DT5
        uOC3Hc2+1i7kRSf81w513I9Hly0Dfryb1gQ+0daSDoJ0USec3RYaqLm8d3is1eip
        vfT0ltEYfgtNCXFzZ6OuVrErltGHY+02w3noBug5shhUPqefvwTtvc7EfgAunRim
        Atwi3Sq3CFjls9To4vzhM3vhyJiDZl2V8466OCx01L/JG0eTdrnLNZsS2MyNGAUk
        8CueYoz2xS0WqMso8O32X842UUIH0dEoT36w36RSzKCJ6sjvQ6Rf2EvNtDu3JMwt
        IjLsoofJisM79y2njmQUfgmmLRAJQ==
X-ME-Sender: <xms:tKDxYMfsdBONyVo-mjk9MrW7wVIQ3ot0sQ4TyNyfnPVoMUozdimNNw>
    <xme:tKDxYOO27XbKkn-CHctOChlWVaiB3Z1lxSm1B7M_X3ZUikGn1_zHuLcIcYpjAJPrJ
    2Oepbns5BQcp9z_n5I>
X-ME-Received: <xmr:tKDxYNgoK6CGblV2dr5_1sVdCcYGB7zRXuOKNXoF5JoUy5C0Af82AJhIjPed1ZiRjrXjJ58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeforghrthih
    nhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggrrdhltheqnecuggftrfgrthhtvg
    hrnheptdffkeelgeegheduieeiffefudefgfduuefhjefftddtteehveeludduteduffdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmheslh
    grmhgsuggrrdhlth
X-ME-Proxy: <xmx:tKDxYB_gFTWau1UjKSxMxjMh5dT58adduu2qGvLFcfyP_4jVbwLRUw>
    <xmx:tKDxYIsLhPwo3H6yU6WE-wcwsJDdfY3AGVHNTmVR0BeorcKwPSFcyQ>
    <xmx:tKDxYIFootWjh9xPEcboZLF54baleDiCu7QYGkRhZTCNuieEZDqWzw>
    <xmx:taDxYB7fEk2e48pg7FgjVOLH5aByoi16_fSEnL_EHnhKLmWzvhRNjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jul 2021 11:07:31 -0400 (EDT)
Subject: Re: [PATCH bpf 2/2] selftests/bpf: check inner map deletion
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210714165440.472566-1-m@lambda.lt>
 <20210714165440.472566-3-m@lambda.lt>
 <CAEf4BzbP6Dr0GWavhV-MUqdFe1rB_A_criwHB_=yS_yGuoc1oQ@mail.gmail.com>
From:   Martynas Pumputis <m@lambda.lt>
Message-ID: <4b29412c-b8f2-39a2-4d96-4c1fa0360927@lambda.lt>
Date:   Fri, 16 Jul 2021 17:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbP6Dr0GWavhV-MUqdFe1rB_A_criwHB_=yS_yGuoc1oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/16/21 7:35 AM, Andrii Nakryiko wrote:
> On Wed, Jul 14, 2021 at 9:52 AM Martynas Pumputis <m@lambda.lt> wrote:
>>
>> Add a test case to check whether an unsuccessful creation of an outer
>> map of a BTF-defined map-in-map destroys the inner map.
>>
>> As bpf_object__create_map() is a static function, we cannot just call it
>> from the test case and then check whether a map accessible via
>> map->inner_map_fd has been removed. Instead, we iterate over all maps
>> and check whether the map "$MAP_NAME.inner" does not exist.
>>
>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>> ---
>>   .../bpf/progs/test_map_in_map_invalid.c       | 27 +++++++++
>>   tools/testing/selftests/bpf/test_maps.c       | 58 ++++++++++++++++++-
>>   2 files changed, 84 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>> new file mode 100644
>> index 000000000000..03601779e4ed
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map_invalid.c
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Isovalent, Inc. */
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +struct inner {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __type(key, __u32);
>> +       __type(value, int);
>> +       __uint(max_entries, 4);
>> +};
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __uint(max_entries, 0); /* This will make map creation to fail */
>> +       __uint(key_size, sizeof(__u32));
>> +       __array(values, struct inner);
>> +} mim SEC(".maps");
>> +
>> +SEC("xdp_noop")
>> +int xdp_noop0(struct xdp_md *ctx)
>> +{
>> +       return XDP_PASS;
>> +}
>> +
>> +int _version SEC("version") = 1;
> 
> please don't add new uses of version, it's completely unnecessary on
> modern kernels

Sure.

> 
>> +char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
>> index 30cbf5d98f7d..48f6c6dfd188 100644
>> --- a/tools/testing/selftests/bpf/test_maps.c
>> +++ b/tools/testing/selftests/bpf/test_maps.c
>> @@ -1153,12 +1153,16 @@ static void test_sockmap(unsigned int tasks, void *data)
>>   }
>>
>>   #define MAPINMAP_PROG "./test_map_in_map.o"
>> +#define MAPINMAP_INVALID_PROG "./test_map_in_map_invalid.o"
>>   static void test_map_in_map(void)
>>   {
>>          struct bpf_object *obj;
>>          struct bpf_map *map;
>>          int mim_fd, fd, err;
>>          int pos = 0;
>> +       struct bpf_map_info info = {};
>> +       __u32 len = sizeof(info);
>> +       __u32 id = 0;
>>
>>          obj = bpf_object__open(MAPINMAP_PROG);
>>
>> @@ -1229,10 +1233,62 @@ static void test_map_in_map(void)
>>
>>          close(fd);
>>          bpf_object__close(obj);
>> +
>> +
>> +       /* Test that failing bpf_object__create_map() destroys the inner map */
>> +
>> +       obj = bpf_object__open(MAPINMAP_INVALID_PROG);
> 
> you didn't check bpf_object__open() succeeded here...

For the sake of brevity, I didn't add the check. If the opening fails, 
then we will catch it anyway with the bpf_object__find_map_by_name() 
invocation below: it will log "libbpf: elf: failed to open $PROG_NAME: 
No such file or directory" and then segfault.

> 
>> +
>> +       map = bpf_object__find_map_by_name(obj, "mim");
> 
> ... and crash will happen here on error
> 
>> +       if (!map) {
>> +               printf("Failed to load array of maps from test prog\n");
>> +               goto out_map_in_map;
>> +       }
>> +
> 
> [...]
> 
