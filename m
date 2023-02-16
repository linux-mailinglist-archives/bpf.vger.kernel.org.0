Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B5698E7E
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBPITF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 03:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjBPITE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 03:19:04 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2233E26CC3;
        Thu, 16 Feb 2023 00:19:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHSX16hLQz4f3jZM;
        Thu, 16 Feb 2023 16:18:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAnGObw5u1jk4evDg--.12510S2;
        Thu, 16 Feb 2023 16:18:59 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
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
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
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
 <2b1ddc4c-9905-899a-a903-e66a6e8b4d58@linux.dev>
 <5f22c315-ed38-b677-f36b-496d89847467@huaweicloud.com>
 <1232a3da-a58f-8cfb-b881-c049abadc203@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <8d1d1952-e710-004d-dcda-1e8199260180@huaweicloud.com>
Date:   Thu, 16 Feb 2023 16:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1232a3da-a58f-8cfb-b881-c049abadc203@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAnGObw5u1jk4evDg--.12510S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW8Xry3uFyrKryfAr1rCrg_yoW8Gw18pa
        93t3W5Kr1kW3ySyrs7Zw4kZF1Fywn3G398J398tFW8Crn8Z3sYqryxKayUuFy5Aw4F9a10
        qFWqq34UG39rAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
        9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/16/2023 3:47 PM, Martin KaFai Lau wrote:
> On 2/15/23 6:11 PM, Hou Tao wrote:
>>>>> For local storage, when its owner (sk/task/inode/cgrp) is going away, the
>>>>> memory can be reused immediately. No rcu gp is needed.
>>>> Now it seems it will wait for RCU GP and i think it is still necessary,
>>>> because
>>>> when the process exits, other processes may still access the local storage
>>>> through pidfd or task_struct of the exited process.
>>> When its owner (sk/task/cgrp...) is going away, its owner has reached refcnt 0
>>> and will be kfree immediately next. eg. bpf_sk_storage_free is called just
>>> before the sk is about to be kfree. No bpf prog should have a hold on this sk.
>>> The same should go for the task.
>> A bpf syscall may have already found the task local storage through a pidfd,
>> then the target task exits and the local storage is free immediately, then bpf
>> syscall starts to copy the local storage and there will be a UAF, right ? Did I
>> missing something here ?
> bpf syscall like bpf_pid_task_storage_lookup_elem and you meant
> __put_task_struct() will be called while the syscall's bpf_map_copy_value() is
> still under rcu_read_lock()?
Yes, but I known it is impossible here. I missed that task_struct is released
through call_rcu(), so the calling of __put_task_struct() must happen after the
completion of bpf_map_copy_value() in bpf syscall. Thanks for the explanation.

