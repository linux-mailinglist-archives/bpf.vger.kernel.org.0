Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6DB69A358
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 02:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBQBTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 20:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBQBTk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 20:19:40 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042755036A;
        Thu, 16 Feb 2023 17:19:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHv9c4qQTz4f3wQh;
        Fri, 17 Feb 2023 09:19:32 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6si1u5jniEQDw--.23368S2;
        Fri, 17 Feb 2023 09:19:34 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
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
 <e16811cc-2d44-73a0-6430-d247605bc836@huaweicloud.com>
 <CAADnVQ+w9h4T6k+F5cLGVVx1jkHvKCF7=ki_Fb1oCp1SF1ZDNA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <2a58c4a8-781f-6d84-e72a-f8b7117762b4@huaweicloud.com>
Date:   Fri, 17 Feb 2023 09:19:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+w9h4T6k+F5cLGVVx1jkHvKCF7=ki_Fb1oCp1SF1ZDNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgBnF6si1u5jniEQDw--.23368S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5XF1kWw48tryUCr4xtFb_yoW8ur1UpF
        WfZ34UKrykCwnrArykZwn2q3W0vws5Gry2grW8Jr4UCwn5WrZ7Jr1Ivw4avF1rZrs7A3WY
        vrZ8twnxXa4rZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2/17/2023 12:35 AM, Alexei Starovoitov wrote:
> On Thu, Feb 16, 2023 at 5:55 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Beside BPF_REUSE_AFTER_RCU_GP, is BPF_FREE_AFTER_RCU_GP a feasible solution ?
> The idea is for bpf_mem_free to wait normal RCU GP before adding
> the elements back to the free list and free the elem to global kernel memory
> only after both rcu and rcu_tasks_trace GPs as it's doing now.
>
>> Its downside is that it will enforce sleep-able program to use
>> bpf_rcu_read_{lock,unlock}() to access these returned pointers ?
> sleepable can access elems without kptrs/spin_locks
> even when not using rcu_read_lock, since it's safe, but there is uaf.
> Some progs might be fine with it.
> When sleepable needs to avoid uaf they will use bpf_rcu_read_lock.
Thanks for the explanation for BPF_REUSE_AFTER_RCU_GP. It seems that
BPF_REUSE_AFTER_RCU_GP may incur OOM easily, because before the expiration of
one RCU GP, these freed elements will not available to both bpf ma or slab
subsystem and after the expiration of RCU GP, these freed elements are only
available for one bpf ma but the number of these freed elements maybe too many
for one bpf ma, so part of these freed elements will be freed through
call_rcu_tasks_trace() and these freed-again elements will not be available for
slab subsystem untill the expiration of tasks trace RCU. In brief, after one RCU
GP, part of these freed elements will be reused, but the majority of these
elements will still be freed through call_rcu_tasks_trace(). Due to the doubt
above, I proposed BPF_FREE_AFTER_RCU to directly free these elements after one
RCU GP and enforce sleepable program to use bpf_rcu_read_lock() to access these
elements, but the enforcement will break the existing sleepable programs, so
BPF_FREE_AFTER_GP is still not a good idea. I will check whether or not these is
still OOM risk for BPF_REUSE_AFTER_RCU_GP and try to mitigate if it is possible
(e.g., share these freed elements between all bpf ma instead of one bpf ma which
free it).

