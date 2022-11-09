Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334636226F7
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 10:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiKIJaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKIJaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 04:30:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5813CC7
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 01:30:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N6fnq731Tz4f41Sw
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 17:30:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCnytcdc2tjB5PuAA--.61696S2;
        Wed, 09 Nov 2022 17:30:07 +0800 (CST)
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
To:     Yonghong Song <yhs@meta.com>, Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com>
 <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
 <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
 <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com>
 <a85181da-99dc-d3a3-53c7-96584dbad8bf@meta.com>
 <0ad23bcc-b4dd-307f-f188-1181efaa3e53@huaweicloud.com>
 <497caf8c-a3a5-dd3b-2b89-25cc12e3b34c@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <9e4cbef4-696e-aac3-371c-90b8d4270e7c@huaweicloud.com>
Date:   Wed, 9 Nov 2022 17:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <497caf8c-a3a5-dd3b-2b89-25cc12e3b34c@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCnytcdc2tjB5PuAA--.61696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1fArW8ZrWUCryfAw1UWrg_yoW5Gr18pF
        WrWayUKrs7Ar4jvr4Dt348uF10yrWftr13Xr1qyr1UCF90vry3Gry7Kr45CFyUCF4xAr12
        vF409a4fWryjy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/9/2022 12:19 AM, Yonghong Song wrote:
>
>
> On 11/8/22 5:28 AM, Hou Tao wrote:
>> Hi,
>>
>> On 11/8/2022 3:03 PM, Yonghong Song wrote:
>>>
>>>
>>> On 11/7/22 8:08 PM, Hou Tao wrote:
>>>> Hi,
>>>>
>>>> On 11/8/2022 10:11 AM, Hao Luo wrote:
>>>>> On Mon, Nov 7, 2022 at 1:59 PM Yonghong Song <yhs@meta.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/6/22 11:42 PM, Hou Tao wrote:
>>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>>
>>>>>>> bpf_iter_attach_cgroup() has already acquired an extra reference for the
>>>>>>> start cgroup, but the reference will be released if the iterator link fd
>>>>>>> is closed after the creation of iterator fd, and it may lead to
>>>>>>> User-After-Free when reading the iterator fd.
>>>>>>>
>>>>>>> So fixing it by acquiring another reference for the start cgroup.
>>>>>>>
>>>>>>> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
>>>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>>> There is an alternative: does it make sense to have the iterator hold
>>>>> a ref of the link? When the link is closed, my assumption is that the
>>>>> program is already detached from the cgroup. After that, it makes no
>>>>> sense to still allow iterating the cgroup. IIUC, holding a ref to the
>>>>> link in the iterator also fixes for other types of objects.
>>>> Also considered the alternative solution when fixing the similar problem in
>>>> bpf
>>>> map element iterator [0]. The problem is not all of bpf iterators need the
>>>> pinning (e.g., bpf map iterator). Because bpf prog is also pinned by
>>>> iterator fd
>>>> in iter_open(), so closing the fd of iterator link doesn't release the bpf
>>>> program.
>>>>
>>>> [0]:
>>>> https://lore.kernel.org/bpf/20220810080538.1845898-2-houtao@huaweicloud.com/
>>>
>>> Okay, let us do the solution to hold a reference to the link for the iterator.
>>> For cgroup_iter, that means, both prog and cgroup will be present so we should
>>> be okay then.
>> The reason I did not use the solution is that it will create unnecessary
>> dependency between iterator fd and iterator link and many bpf iterators also
>> don't need that. If we use the solution, should I revert the fixes to bpf map
>> iterator done before or keep it as-is ?
>
> Let us do it separately. This is a bug fix (targeting bpf tree). map iterator
> issue has been fixed and we can leave it there or change to hold a reference
> to the link. Personally I think we can leave it as is
> since it is working.
OK. I will keep it as is.
>
>>>
>>>>>
>>>>> Hao
>>>>
>>

