Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503916EFEFD
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 03:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbjD0BlA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 21:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbjD0Bk7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 21:40:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481D3AA1;
        Wed, 26 Apr 2023 18:40:57 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q6JHx736nz18KQP;
        Thu, 27 Apr 2023 09:37:01 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 27 Apr
 2023 09:40:55 +0800
Message-ID: <be9efa60-14ec-ba46-91e1-9feb56c40fb8@huawei.com>
Date:   Thu, 27 Apr 2023 09:40:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] bpf: Unregister fentry when bpf_trampoline_unlink_prog
 fails to update image
To:     Yonghong Song <yhs@meta.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>
References: <20230426095548.176045-1-chenzhongjin@huawei.com>
 <b594a56f-5e1f-da7f-0ab1-71751bd0c5e2@meta.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <b594a56f-5e1f-da7f-0ab1-71751bd0c5e2@meta.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2023/4/27 2:17, Yonghong Song wrote:
> 
> 
> On 4/26/23 2:55 AM, Chen Zhongjin wrote:
>> In bpf_link_free, bpf trampoline will update the image and remove the
>> unlinked prog.
>>
>> bpf_trampoline_unlink_prog is committed as 'never fail', however it 
>> depends
>> on the result of image update. It is possible to fail if memory 
>> allocation
>> fail in bpf_trampoline_update.
> 
> Could you give more details which memory allocation fail here?
> bpf_tramp_image_alloc()? Are you using some error injection or
> this happens in your production workload?
> 
I guess it's an error injection because syzkaller reported this.

>>
>> The error result of bpf_trampoline_update can't be passed to 
>> bpf_link_free
>> because link release callback returns void. Then it will free the prog
>> whether image updating is successful or not.
>> If the old image tries to call a freed prog, it makes kernel panic.
>>
>>      BUG: unable to handle page fault for address: ffffffffc04a8d20
>>      #PF: supervisor instruction fetch in kernel mode
>>      #PF: error_code(0x0010) - not-present page
>>      RIP: 0010:0xffffffffc04a8d20
>>      Code: Unable to access opcode bytes at RIP 0xffffffffc04a8cf6.
>>      ...
>>      Call Trace:
>>      ? bpf_trampoline_78223_0
>>      bpf_traced_function
>>      ...
> 
> Could you explain how 'the old image tries to call a freed prog'?
> IIUC, the previous bpf_link_free() should not be available to
> call the bpf prog, right?
> 
What I mean here is, if failed to update the image, the image keeps 
unchanged but the unlinked prog will be freed later.
Next time when it enter the trampoline the image will call freed prog.

>>
>> Fix this when bpf_trampoline_update failed in bpf_trampoline_unlink_prog,
>> unregister fentry to disable the trampoline. Then other progs on the
>> trampoline can be unlinked safely and finally the trampoline will be
>> released.
> 
> Do we still leak tr->cur_image here?
> 
No, bpf_tramp_image_put() will free everything when all progs_cnt 
decline to zero in bpf_trampoline_update(). It is a release function, 
but called 'put'.

>>
>> Fixes: 88fd9e5352fe ("bpf: Refactor trampoline update code")
> 
> If the above is a refactoring patch, you should not use that
> as 'Fixes' patch, you should pick one truely introduced the issue.
> 
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   kernel/bpf/trampoline.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index d0ed7d6f5eec..6daa93b30e81 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -604,7 +604,10 @@ static int __bpf_trampoline_unlink_prog(struct 
>> bpf_tramp_link *link, struct bpf_
>>       }
>>       hlist_del_init(&link->tramp_hlist);
>>       tr->progs_cnt[kind]--;
>> -    return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>> +    err =  bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>> +    if (err && tr->cur_image)
>> +        unregister_fentry(tr, tr->cur_image->image);
> 
> If error happens for the all subsequent programs,
> unregister_fentry() will be called multiple times. Any side effect?
It will fail with no side effect. Actually if there is no error, 
modify_fentry() will fail in update() as well. The fentry is available 
until all progs are unlinked and the broken image is freed by 
bpf_tramp_image_put().

However with an extra state to record this happens, it's possible to 
re-register the fentry with new image when the next link/unlink calls 
update(). It will generate a new image and replace/free the error one.
> 
> Overall, I think this is an extreme corner case which happens
> when kernel memory is extreme tight. If this is the case, not
> sure whether it is worthwhile to fix it or not.
> 
Yes, it's a really rare case. I'm just not sure whether it needs some 
best-effort to avoid kernel panic at this point.

If you think it's not necessary. Just let it go.

Thanks for your time!

Best,
Chen
>> +    return err;
>>   }
>>   /* bpf_trampoline_unlink_prog() should never fail. */
