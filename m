Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055D5BD93B
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 03:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiITBNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 21:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiITBND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 21:13:03 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94D543C3
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 18:12:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWk4F63Wbz6R53F
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:10:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgAn9ShvEyljJlQ0BA--.51532S2;
        Tue, 20 Sep 2022 09:12:18 +0800 (CST)
Subject: Re: [PATCH bpf-next] selftests/bpf: Add test result messages for
 test_task_storage_map_stress_lookup
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com,
        bpf@vger.kernel.org
References: <20220919035714.2195144-1-houtao@huaweicloud.com>
 <3797ccec-6fe1-acc9-02f0-2f5ee0e8b7d8@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <321e7d98-3e2d-9671-fad3-9ad8d280a8cb@huaweicloud.com>
Date:   Tue, 20 Sep 2022 09:12:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3797ccec-6fe1-acc9-02f0-2f5ee0e8b7d8@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgAn9ShvEyljJlQ0BA--.51532S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DXFyfZFy8uryUWr17ZFb_yoW8uF13pa
        yxtayYkryFy3WrXr4UW3ZFvryFq3WkJw1UWr4rtF4Yyr4DJF92gr1IgF1jgr9xWr4Fqan8
        Zwnaqr1ruFyUJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/20/2022 2:25 AM, Martin KaFai Lau wrote:
> On 9/18/22 8:57 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Add test result message when test_task_storage_map_stress_lookup()
>> succeeds or is skipped. The test case can be skipped due to the choose
>> of preemption model in kernel config, so export skips in test_maps.c and
>> increase it when needed.
>>
>> The following is the output of test_maps when the test case succeeds or
>> is skipped:
>>
>>    test_task_storage_map_stress_lookup:PASS
>>    test_maps: OK, 0 SKIPPED
>>
>>    test_task_storage_map_stress_lookup SKIP (no CONFIG_PREEMPT)
>>    test_maps: OK, 1 SKIPPED
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Applied with a Fixes tag,
> Fixes: 73b97bc78b32 ("selftests/bpf: ......
>
> Please remember to add it next time for fixes.
>
> Also, ...
>
>
>> ---
>>   tools/testing/selftests/bpf/map_tests/task_storage_map.c | 6 +++++-
>>   tools/testing/selftests/bpf/test_maps.c                  | 2 +-
>>   tools/testing/selftests/bpf/test_maps.h                  | 2 ++
>>   3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
>> b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
>> index 1adc9c292eb2..aac08c85240b 100644
>> --- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
>> +++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
>> @@ -77,8 +77,11 @@ void test_task_storage_map_stress_lookup(void)
>>       CHECK(err, "open_and_load", "error %d\n", err);
>>         /* Only for a fully preemptible kernel */
>> -    if (!skel->kconfig->CONFIG_PREEMPT)
>> +    if (!skel->kconfig->CONFIG_PREEMPT) {
>> +        printf("%s SKIP (no CONFIG_PREEMPT)\n", __func__);
>> +        skips++;
>
> I noticed it is missing a read_bpf_task_storage_busy__destroy() here. Please fix.
Oops. Sorry for missing that. Will send a v2.
>
> .

