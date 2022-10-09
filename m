Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF55F8ABA
	for <lists+bpf@lfdr.de>; Sun,  9 Oct 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJIKpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Oct 2022 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiJIKpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Oct 2022 06:45:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCD28715
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 03:45:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MldtT3x2czKDd4
        for <bpf@vger.kernel.org>; Sun,  9 Oct 2022 18:43:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDntipCpkJjhxjaBw--.54929S2;
        Sun, 09 Oct 2022 18:45:25 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     paulmck@kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
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
        Hou Tao <houtao1@huawei.com>
References: <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com>
 <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
 <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com>
 <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
 <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
 <CAADnVQLuo+aJ0ke5M3Oz6+B=VtFfD2Qr_9c6KDjfEwHUMsx58w@mail.gmail.com>
 <20221008201142.GN4196@paulmck-ThinkPad-P17-Gen-1>
 <1186f2f8-5d2a-fe3f-2f11-27d269143e2b@huaweicloud.com>
 <20221009090535.GO4196@paulmck-ThinkPad-P17-Gen-1>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <f2cb88f2-63b0-cf62-7453-d2783abc9790@huaweicloud.com>
Date:   Sun, 9 Oct 2022 18:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221009090535.GO4196@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDntipCpkJjhxjaBw--.54929S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW7tw4fKFWrGrWrJw13urg_yoWrAF47pF
        WSgay2kw4DtryakrnFvw48WF4Ykw4fJF43Wr15Jr4UZrn0grnavryUta15CF98CFWfCw1j
        qryjv39xZFyDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/9/2022 5:05 PM, Paul E. McKenney wrote:
> On Sun, Oct 09, 2022 at 09:09:44AM +0800, Hou Tao wrote:
>> Hi Paul,
>>
>> On 10/9/2022 4:11 AM, Paul E. McKenney wrote:
>>> On Sat, Oct 08, 2022 at 09:40:04AM -0700, Alexei Starovoitov wrote:
>>>> On Sat, Oct 8, 2022 at 6:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>> On Fri, Oct 07, 2022 at 06:59:08PM -0700, Alexei Starovoitov wrote:
>> SNIP
>>>>>>> Understand. I was just trying to understand the exact performance overhead of
>>>>>>> call_rcu(). If the overhead of map operations are much greater than the overhead
>>>>>>> of call_rcu(), I think calling call_rcu() one millions a second will be not a
>>>>>>> problem and  it also makes the implementation of qp-trie being much simpler. The
>>>>>>> OOM problem is indeed a problem, although it is also possible for the current
>>>>>>> implementation, so I will try to implement the lookup procedure which handles
>>>>>>> the reuse problem.
>>>>>> call_rcu is not just that particular function.
>>>>>> It's all the work rcu subsystem needs to do to observe gp
>>>>>> and execute that callback. Just see how many kthreads it will
>>>>>> start when overloaded like this.
>>>>> The kthreads to watch include rcu_preempt, rcu_sched, ksoftirqd*, rcuc*,
>>>>> and rcuo*.  There is also the back-of-interrupt softirq context, which
>>>>> requires some care to measure accurately.
>>>>>
>>>>> The possibility of SLAB_TYPESAFE_BY_RCU has been discussed.  I take it
>>>>> that the per-element locking overhead for exact iterations was a problem?
>>>>> If so, what exactly are the consistency rules for iteration?  Presumably
>>>>> stronger than "if the element existed throughout, it is included in the
>>>>> iteration; if it did not exist throughout, it is not included; otherwise
>>>>> it might or might not be included" given that you get that for free.
>>>>>
>>>>> Either way, could you please tell me the exact iteration rules?
>>>> The rules are the way we make them to be.
>>>> iteration will be under lock.
>>>> lookup needs to be correct. It can retry if necessary (like htab is doing).
>>>> Randomly returning 'noexist' is, of course, not acceptable.
>>> OK, so then it is important that updates to this data structure be
>>> carried out in such a way as to avoid discombobulating lockless readers.
>>> Do the updates have that property?
>> Yes. The update procedure will copy the old pointer array to a new array first,
>> then update the new array and replace the pointer of old array by the pointer of
>> new array.
> Very good.  But then why is there a problem?  Is the iteration using
> multiple RCU read-side critical sections or something?
The problem is that although the objects are RCU-freed, but these object also
can be reused immediately in bpf memory allocator. The reason for reuse is for
performance and is to reduce the possibility of OOM. Because the object can be
reused during RCU-protected lookup and the possibility of reuse is low, the
lookup procedure needs to check whether reuse is happening during lookup. And I
was arguing with Alexei about whether or no it is reasonable to provide an
optional flag to remove the immediate reuse in bpf memory allocator.
>
>>> The usual way to get that property is to leave the old search structure
>>> around, replacing it with the new one, and RCU-freeing the old one.
>>> In case it helps, Kung and Lehman describe how to do that for search trees:
>>>
>>> http://www.eecs.harvard.edu/~htk/publication/1980-tods-kung-lehman.pdf
>> Thanks for the paper. Just skimming through it, it seems that it uses
>> reference-counting and garbage collection to solve the safe memory reclamation
>> problem. It may be too heavy for qp-trie and we plan to use seqcount-like way to
>> check whether or not the branch and the leaf node is reused during lookup, and
>> retry the lookup if it happened. Now just checking the feasibility of the
>> solution and it seems a little complicated than expected.
> The main thing in that paper is the handling of rotations in the
> search-tree update.  But if you are not using a tree, that won't be all
> that relevant.
I see. Thanks for the explanation.
>
> 								Thanx, Paul

