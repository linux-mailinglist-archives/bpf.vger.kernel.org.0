Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F126F69774D
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjBOHXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 02:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBOHXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 02:23:09 -0500
Received: from out-73.mta0.migadu.com (out-73.mta0.migadu.com [IPv6:2001:41d0:1004:224b::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058229147
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 23:23:07 -0800 (PST)
Message-ID: <2b1ddc4c-9905-899a-a903-e66a6e8b4d58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676445784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFiqL85OMFiRUxyY50Wh6JnMy06nSoBtvKZlaWOzJak=;
        b=pTC20R3V5mXzsnvFhHTGaTwPyiELMUxm6Mfwm3iPy68yN/RrB9lJC0T0YY6r2v9x8ElQWP
        EufUsXqckHqPffgzaKEk75vD0XQvzBfuZZpIOgreayX00NYDnc6uF/kkX9r6xcJl26CTG+
        uyr6OB/smMlXzz6oqzKgNM9jRCE6ydU=
Date:   Tue, 14 Feb 2023 23:22:56 -0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
 <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
 <e5f502b5-ea71-8b96-3874-75e0e5a4932f@meta.com>
 <e96bc8c0-50fb-d6be-a86d-581c8a86232c@huaweicloud.com>
 <b9467cf4-38a7-9af6-0c1c-383f423b26eb@meta.com>
 <1d97a5c0-d1fb-a625-8e8d-25ef799ee9e2@huaweicloud.com>
 <e205d4a3-a885-93c7-5d02-2e9fd87348e8@meta.com>
 <CAADnVQLCWdN-Rw7BBxqErUdxBGOMNq39NkM3XJ=O=saG08yVgw@mail.gmail.com>
 <20230210163258.phekigglpquitq33@apollo>
 <CAADnVQLVi7CcW9ci62Dps4mxCEqHOYvYJ-Fant-0kSy0vPZ3AA@mail.gmail.com>
 <bf936f22-f8b7-c4a3-41a1-c3f2f115e67a@huaweicloud.com>
 <CAADnVQKecUqGF-gLFS5Wiz7_E-cHOkp7NPCUK0woHUmJG6hEuA@mail.gmail.com>
 <CAADnVQJzS9MQKS2EqrdxO7rVLyjUYD6OG-Yefak62-JRNcheZg@mail.gmail.com>
 <6d48c284-42eb-9688-4259-79b7f096e294@linux.dev>
 <7fef4ece-0982-cb43-ed39-e73791436355@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7fef4ece-0982-cb43-ed39-e73791436355@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/14/23 8:02 PM, Hou Tao wrote:
>> For local storage, when its owner (sk/task/inode/cgrp) is going away, the
>> memory can be reused immediately. No rcu gp is needed.
> Now it seems it will wait for RCU GP and i think it is still necessary, because
> when the process exits, other processes may still access the local storage
> through pidfd or task_struct of the exited process.

When its owner (sk/task/cgrp...) is going away, its owner has reached refcnt 0 
and will be kfree immediately next. eg. bpf_sk_storage_free is called just 
before the sk is about to be kfree. No bpf prog should have a hold on this sk. 
The same should go for the task.

The current rcu gp waiting during bpf_{sk,task,cgrp...}_storage_free is because 
the racing with the map destruction bpf_local_storage_map_free().

>>
>> The local storage delete case (eg. bpf_sk_storage_delete) is the only one that
>> needs to be freed by tasks_trace gp because another bpf prog (reader) may be
>> under the rcu_read_lock_trace(). I think the idea (BPF_REUSE_AFTER_RCU_GP) on
>> allowing reuse after vanilla rcu gp and free (if needed) after tasks_trace gp
>> can be extended to the local storage delete case. I think we can extend the
>> assumption that "sleepable progs (reader) can use explicit bpf_rcu_read_lock()
>> when they want to avoid uaf" to bpf_{sk,task,inode,cgrp}_storage_get() also.
>>
> It seems bpf_rcu_read_lock() & bpf_rcu_read_unlock() will be used to protect not
> only bpf_task_storage_get(), but also the dereferences of the returned local
> storage ptr, right ? I think qp-trie may also need this.

I think bpf_rcu_read_lock() is primarily for bpf prog.

The bpf_{sk,task,...}_storage_get() internal is easier to handle and probably 
will need to do its own rcu_read_lock() instead of depending on the bpf prog 
doing the bpf_rcu_read_lock() because the bpf prog may decide uaf is fine.

>> I also need the GFP_ZERO in bpf_mem_alloc, so will work on the GFP_ZERO and
>> the BPF_REUSE_AFTER_RCU_GP idea.  Probably will get the GFP_ZERO out first.
> I will continue work on this patchset for GFP_ZERO and reuse flag. Do you mean
> that you want to work together to implement BPF_REUSE_AFTER_RCU_GP ? How do we
> cooperate together to accomplish that ?
Please submit the GFP_ZERO patch first. Kumar and I can use it immediately.

I have been hacking to make bpf's memalloc safe for the 
bpf_{sk,task,cgrp..}_storage_delete() and this safe-on-reuse piece still need 
works. The whole thing is getting pretty long, so my current plan is to put the 
safe-on-reuse piece aside for now, focus back on the immediate goal and make the 
common case deadlock free first. Meaning the 
bpf_*_storage_get(BPF_*_STORAGE_GET_F_CREATE) and the bpf_*_storage_free() will 
use the bpf_mem_cache_{alloc,free}. The bpf_*_storage_delete() will stay as-is 
to go through the call_rcu_tasks_trace() for now since delete is not the common 
use case.

In parallel, if you can post the BPF_REUSE_AFTER_RCU_GP, we can discuss based on 
your work. That should speed up the progress. If I finished the immediate goal 
for local storage and this piece is still pending, I will ping you first.  Thoughts?

