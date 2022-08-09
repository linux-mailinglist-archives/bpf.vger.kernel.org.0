Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11358D1A4
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 03:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiHIBHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 21:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHIBHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 21:07:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2C1D332
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 18:07:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M1vyK5HqZzKs2Q
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 09:05:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgD3_Pk3s_FiYlhrAA--.32461S2;
        Tue, 09 Aug 2022 09:07:07 +0800 (CST)
Subject: Re: [PATCH bpf 1/9] bpf: Acquire map uref in .init_seq_private for
 array map iterator
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-2-houtao@huaweicloud.com>
 <7e82bc88-d42c-98de-79a7-eda5d48c2b3c@fb.com>
From:   houtao <houtao@huaweicloud.com>
Message-ID: <b7edc598-9d0c-3eb6-4ff2-ecf14bbc3226@huaweicloud.com>
Date:   Tue, 9 Aug 2022 09:07:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7e82bc88-d42c-98de-79a7-eda5d48c2b3c@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgD3_Pk3s_FiYlhrAA--.32461S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DGr4fKw43KF4fXrWxXrb_yoW8Kr4xpF
        WktFWjk3y8Zrs29Fn5ta4Uuay0v345Wa45Jrn5ta4YvFW5Xr129r18WF1a9F4YyF48Jr18
        tw1j939ruFyUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/8/2022 10:53 PM, Yonghong Song wrote:
>
>
> On 8/6/22 12:40 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> During bpf(BPF_LINK_CREATE) for BPF_TRACE_ITER, bpf_iter_attach_map()
>> has already acquired a map uref, but the uref may be released by
>> bpf_link_release() during th reading of map iterator.
>
> some wording issue:
> bpf_iter_attach_map() acquires a map uref, and the uref may be released
> before or in the middle of iterating map elements. For example, the uref
> could be released in bpf_iter_detach_map() as part of
> bpf_link_release(), or could be released in bpf_map_put_with_uref()
> as part of bpf_map_release().
Thanks, it is much better than the original commit message. Will update in v2.

Regards
Tao
>
>>
>> Alternative fix is acquiring an extra bpf_link reference just like
>> a pinned map iterator does, but it introduces unnecessary dependency
>> on bpf_link instead of bpf_map.
>>
>> So choose another fix: acquiring an extra map uref in .init_seq_private
>> for array map iterator.
>>
>> Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
>> ---
>>   kernel/bpf/arraymap.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index d3e734bf8056..bf6898bb7cb8 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -649,6 +649,12 @@ static int bpf_iter_init_array_map(void *priv_data,
>>           seq_info->percpu_value_buf = value_buf;
>>       }
>>   +    /*
>> +     * During bpf(BPF_LINK_CREATE), bpf_iter_attach_map() has already
>> +     * acquired a map uref, but the uref may be released by
>> +     * bpf_link_release(), so acquire an extra map uref for iterator.
>> +     */
>> +    bpf_map_inc_with_uref(map);
>>       seq_info->map = map;
>>       return 0;
>>   }
>> @@ -657,6 +663,7 @@ static void bpf_iter_fini_array_map(void *priv_data)
>>   {
>>       struct bpf_iter_seq_array_map_info *seq_info = priv_data;
>>   +    bpf_map_put_with_uref(seq_info->map);
>>       kfree(seq_info->percpu_value_buf);
>>   }
>>   

