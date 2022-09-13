Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB85B66F4
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIME2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIME1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 00:27:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD254CBA;
        Mon, 12 Sep 2022 21:24:22 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRVbp6CV2zNmBj;
        Tue, 13 Sep 2022 12:19:34 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 12:24:08 +0800
Message-ID: <46b807bc-56ef-f0dd-3df4-bece4f8d4af4@huawei.com>
Date:   Tue, 13 Sep 2022 12:24:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [bpf-next] bpf: use kvmemdup_bpfptr helper
To:     <sdf@google.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <haoluo@google.com>, <jolsa@kernel.org>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
 <Yxt3fnUdzDTJzUTt@google.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <Yxt3fnUdzDTJzUTt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/9/10 1:27, sdf@google.com 写道:
> On 09/09, Wang Yufen wrote:
>> Use kvmemdup_bpfptr helper instead of open-coding to
>> simplify the code.
>
>> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
>> ---
>>   kernel/bpf/syscall.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 4e9d4622aef7..13ce28081982 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1413,20 +1413,14 @@ static int map_update_elem(union bpf_attr 
>> *attr, bpfptr_t uattr)
>>       }
>
>>       value_size = bpf_map_value_size(map);
>> -
>> -    err = -ENOMEM;
>> -    value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
>> -    if (!value)
>> +    value = kvmemdup_bpfptr(uvalue, value_size);
>> +    if (IS_ERR(value)) {
>> +        err = PTR_ERR(value);
>>           goto free_key;
>> -
>> -    err = -EFAULT;
>> -    if (copy_from_bpfptr(value, uvalue, value_size) != 0)
>> -        goto free_value;
>> +    }
>
>>       err = bpf_map_update_value(map, f, key, value, attr->flags);
>
>
> [..]
>
>> -free_value:
>> -    kvfree(value);
>
> And here you leak the value. We need to free it after update regardless
> of error/success. That's why it is coded like that.

Thanks for your comments.

It's my mistake.

Can I keep kvfree(value);    and send v2?

>
>>   free_key:
>>       kvfree(key);
>>   err_put:
>> -- 
>> 2.25.1
>
