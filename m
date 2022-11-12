Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29F6268DA
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiKLKZO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKLKZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 05:25:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D672F652;
        Sat, 12 Nov 2022 02:25:12 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8WpP72nkzJndw;
        Sat, 12 Nov 2022 18:22:05 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:25:09 +0800
Message-ID: <1ca2e4e8-ed7e-9174-01f6-c14539b8b8b2@huawei.com>
Date:   Sat, 12 Nov 2022 18:25:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf: Fix offset calculation error in __copy_map_value
 and zero_map_value
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, <sdf@google.com>
CC:     Xu Kuohai <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20221111125620.754855-1-xukuohai@huaweicloud.com>
 <Y26f4H7buQXKqQFd@google.com> <20221111204547.lyeim477afgfgkhh@apollo>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20221111204547.lyeim477afgfgkhh@apollo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12/2022 4:45 AM, Kumar Kartikeya Dwivedi wrote:
> On Sat, Nov 12, 2022 at 12:47:52AM IST, sdf@google.com wrote:
>> On 11/11, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>>> Function __copy_map_value and zero_map_value miscalculated copy offset,
>>> resulting in possible copy of unwanted data to user or kernel.
>>
>>> Fix it.
>>
>>> Fixes: cc48755808c6 ("bpf: Add zero_map_value to zero map value with
>>> special fields")
>>> Fixes: 4d7d7f69f4b1 ("bpf: Adapt copy_map_value for multiple offset case")
>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>> ---
>>>    include/linux/bpf.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 74c6f449d81e..c1bd1bd10506 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -315,7 +315,7 @@ static inline void __copy_map_value(struct bpf_map
>>> *map, void *dst, void *src, b
>>>    		u32 next_off = map->off_arr->field_off[i];
>>
>>>    		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
>>> -		curr_off += map->off_arr->field_sz[i];
>>> +		curr_off = next_off + map->off_arr->field_sz[i];
>>>    	}
>>>    	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
>>>    }
>>> @@ -344,7 +344,7 @@ static inline void zero_map_value(struct bpf_map
>>> *map, void *dst)
>>>    		u32 next_off = map->off_arr->field_off[i];
>>
>>>    		memset(dst + curr_off, 0, next_off - curr_off);
>>> -		curr_off += map->off_arr->field_sz[i];
>>> +		curr_off = next_off + map->off_arr->field_sz[i];
>>>    	}
>>>    	memset(dst + curr_off, 0, map->value_size - curr_off);
>>>    }
>>
>> Hmm, does it mean that it currently works only for the cases where
>> these special fields are first/last?
>>
>> Also, what about bpf-next? The same problem seem to exist there?
>>
> 
> Replied with the patch in the other email.
> 
>> Might be a good idea to have some selftest to exercise this?
>>
> 
> I agree, there was another bug in the same code before this, so I think we
> should add tests for this (I should have done that with the commit being
> fixed...).
> 
> Xu, if you have cycles, can you work on testing a few edge cases and make sure
> we don't regress in the future? Otherwise I will take a look next week.
> .

Ok, I'll add a few cases to test_sk_storage_map to capture this
