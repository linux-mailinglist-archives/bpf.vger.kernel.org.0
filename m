Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8607B58E48B
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiHJBfA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 21:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiHJBe7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 21:34:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A470E6D
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 18:34:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M2XWw6KkhzKPxp
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 09:33:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDX3us7C_NiBzmTAA--.2076S2;
        Wed, 10 Aug 2022 09:34:55 +0800 (CST)
Subject: Re: [PATCH bpf 5/9] bpf: Check the validity of max_rdwr_access for sk
 storage map iterator
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-6-houtao@huaweicloud.com>
 <20220809184602.equlp2thcs2j4774@kafai-mbp>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <60c922fa-24cc-a108-696e-64c0fb75f2c2@huaweicloud.com>
Date:   Wed, 10 Aug 2022 09:34:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220809184602.equlp2thcs2j4774@kafai-mbp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDX3us7C_NiBzmTAA--.2076S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryrWrWrtr4fJw43ZFyUAwb_yoWkGrc_uF
        4UZ3Wxur4agrn2kw4qkasxZry7Kw1kZF18GrZxJrW3G3ZxXay0q3W0yrWkZa4fWrn5XF47
        Jwn5ZrZ2gF43ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/10/2022 2:46 AM, Martin KaFai Lau wrote:
> On Sat, Aug 06, 2022 at 03:40:15PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The value of sock map is writable in map iterator, so check
> Not a sock map.  It is a sk local storage map.
Will update in v2. Thanks.
>
>> max_rdwr_access instead of max_rdonly_access.
>>
>> Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  net/core/bpf_sk_storage.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
>> index 83b89ba824d7..1b7f385643b4 100644
>> --- a/net/core/bpf_sk_storage.c
>> +++ b/net/core/bpf_sk_storage.c
>> @@ -904,7 +904,7 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>>  	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
>>  		goto put_map;
>>  
>> -	if (prog->aux->max_rdonly_access > map->value_size) {
>> +	if (prog->aux->max_rdwr_access > map->value_size) {
>>  		err = -EACCES;
>>  		goto put_map;
>>  	}
>> -- 
>> 2.29.2
>>

