Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBB6F0FDF
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 03:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjD1BGR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 21:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjD1BGQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:06:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EDC2684;
        Thu, 27 Apr 2023 18:06:14 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6vWK0LgWzsRF9;
        Fri, 28 Apr 2023 09:03:57 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 28 Apr
 2023 09:05:36 +0800
Message-ID: <7e023c28-abe5-25a6-150d-ff8a782992de@huawei.com>
Date:   Fri, 28 Apr 2023 09:05:32 +0800
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
 <be9efa60-14ec-ba46-91e1-9feb56c40fb8@huawei.com>
 <9e36407a-22fb-0fc1-b147-ebdc12ea0823@meta.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <9e36407a-22fb-0fc1-b147-ebdc12ea0823@meta.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/4/28 2:54, Yonghong Song wrote:
> 
> ...
> 
>>
>>>>
>>>> Fix this when bpf_trampoline_update failed in 
>>>> bpf_trampoline_unlink_prog,
>>>> unregister fentry to disable the trampoline. Then other progs on the
>>>> trampoline can be unlinked safely and finally the trampoline will be
>>>> released.
>>>
>>> Do we still leak tr->cur_image here?
>>>
>> No, bpf_tramp_image_put() will free everything when all progs_cnt 
>> decline to zero in bpf_trampoline_update(). It is a release function, 
>> but called 'put'.
> 
> Okay, I see. But it depends on where memory allocation failure
> happens. For example, see below:
> 
>      static int bpf_trampoline_update(struct bpf_trampoline *tr,
>      bool lock_direct_mutex)
>      {
>          struct bpf_tramp_image *im;
>          struct bpf_tramp_links *tlinks;
>          u32 orig_flags = tr->flags;
>          bool ip_arg = false;
>          int err, total;
> 
>          tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
>          if (IS_ERR(tlinks))
>                  return PTR_ERR(tlinks);
> 
>          if (total == 0) {
>                  err = unregister_fentry(tr, tr->cur_image->image);
>                  bpf_tramp_image_put(tr->cur_image);
>                  tr->cur_image = NULL;
>                  tr->selector = 0;
>                  goto out;
>          }
> 
>          im = bpf_tramp_image_alloc(tr->key, tr->selector);
>          if (IS_ERR(im)) {
>                  err = PTR_ERR(im);
>                  goto out;
>          }
> 
>      ...
> 
> In bpf_trampoline_get_progs(),
> 
>      static struct bpf_tramp_links *
>      bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int 
> *total, bool *ip_arg)
>      {
>          struct bpf_tramp_link *link;
>          struct bpf_tramp_links *tlinks;
>          struct bpf_tramp_link **links;
>          int kind;
> 
>          *total = 0;
>          tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
> 
> If we have memory allocation failure, PTR_ERR(tlinks) will be returned
> and there is no chance to reach 'total == 0' so tr->cur_image will not
> be freed.
> 
> But if the memory allocation failure happens in 
> bpf_tramp_image_alloc(...), yes, it is possible eventually when
> all progs are unlinked, 'total' could be 0, unregister_fentry()
> will be called again (hopefully no side effect) and the image
> will be freed.
> 
>>
>>>>
>>>> Fixes: 88fd9e5352fe ("bpf: Refactor trampoline update code")
>>>
>>> If the above is a refactoring patch, you should not use that
>>> as 'Fixes' patch, you should pick one truely introduced the issue.
>>>
>>>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>>>> ---
>>>>   kernel/bpf/trampoline.c | 5 ++++-
>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>>> index d0ed7d6f5eec..6daa93b30e81 100644
>>>> --- a/kernel/bpf/trampoline.c
>>>> +++ b/kernel/bpf/trampoline.c
>>>> @@ -604,7 +604,10 @@ static int __bpf_trampoline_unlink_prog(struct 
>>>> bpf_tramp_link *link, struct bpf_
>>>>       }
>>>>       hlist_del_init(&link->tramp_hlist);
>>>>       tr->progs_cnt[kind]--;
>>>> -    return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>>>> +    err =  bpf_trampoline_update(tr, true /* lock_direct_mutex */);
>>>> +    if (err && tr->cur_image)
>>>> +        unregister_fentry(tr, tr->cur_image->image);
>>>
>>> If error happens for the all subsequent programs,
>>> unregister_fentry() will be called multiple times. Any side effect?
>> It will fail with no side effect. Actually if there is no error, 
>> modify_fentry() will fail in update() as well. The fentry is available 
>> until all progs are unlinked and the broken image is freed by 
>> bpf_tramp_image_put().
> 
> This will cause a sudden behavior change if there are other active
> programs. For example, prog1 and prog2, prog1 unlink triggered
> memory allocation failure and caused unregister_fentry which restored
> the original ip. Then prog2 even does not have a chance to run any
> more even if memory suddenly not an issue any more.
> 
>>
>> However with an extra state to record this happens, it's possible to 
>> re-register the fentry with new image when the next link/unlink calls 
>> update(). It will generate a new image and replace/free the error one.
>>>
>>> Overall, I think this is an extreme corner case which happens
>>> when kernel memory is extreme tight. If this is the case, not
>>> sure whether it is worthwhile to fix it or not.
>>>
>> Yes, it's a really rare case. I'm just not sure whether it needs some 
>> best-effort to avoid kernel panic at this point.
>>
>> If you think it's not necessary. Just let it go.
> 
> At least with current patch, even we could avoid kernel panic, the
> user expected behavior might change. To handle all error conditions
> in bpf_trampoline_update() might be a big task. So I suggest to just
> let it go.
> 
You are right. It's difficult to handle all errors, especially when
problem occurs inside the ftrace process.
So just keep it as is until there is better solution.

>>
>> Thanks for your time!
>>
>> Best,
>> Chen
>>>> +    return err;
>>>>   }
>>>>   /* bpf_trampoline_unlink_prog() should never fail. */
