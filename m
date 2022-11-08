Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9B6204E0
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKHAqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiKHAqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:46:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631262E3
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:46:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5qDB407gz4f42rf
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:46:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDHvazqpmljz42XAA--.17600S2;
        Tue, 08 Nov 2022 08:46:37 +0800 (CST)
Subject: Re: [PATCH bpf 0/3] Pin the start cgroup for cgroup iterator
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <ddf788e1-ba97-4b5c-4cf2-5c79fc91b17e@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <d6c09d17-d837-ec8a-bad5-0aae32500bf0@huaweicloud.com>
Date:   Tue, 8 Nov 2022 08:46:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ddf788e1-ba97-4b5c-4cf2-5c79fc91b17e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDHvazqpmljz42XAA--.17600S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3XFyfuF1DArWDtw43ZFb_yoW8ArW5pF
        93GFW5K34fCrs7Xr1Iy3y2ga4SyrWrJw4UX3WfXFy5Cr1DJrySqryIqr1a9Fy3GFWxWrnx
        A3W09Fn5uF1UA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UQzVbUUUUU=
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

On 11/8/2022 6:51 AM, Yonghong Song wrote:
>
>
> On 11/6/22 11:42 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Hi,
>>
>> The patchset tries to fix the potential use-after-free problem in cgroup
>> iterator. The problem is similar with the UAF problem fixed in map
>> iterator and the fixes is also similar: pinning the iterated resource
>> in .init_seq_private() and unpinning in .fini_seq_private(). Also adding
>> a test to demonstrate the problem.
>>
>> Not sure whether or not it will be helpful to add some comments for
>> .init_seq_private() to state that the implementation of
>> .init_seq_private() should not depend on iterator link to guarantee
>> the liveness of iterated object. Comments are always welcome.
>
> You added some comments in cgroup_iter init_seq_private(). Hopefully
> that can serve as an example so for future iterators we can search
> the code and remember to hold necessary references in init_seq_private()
> function....
Another way to prevent such problem is to pin iterator link in iterator fd, but
it introduce unnecessary dependency as said before, so hope the comments will be
helpful.
>
>>
>> Hou Tao (3):
>>    bpf: Pin the start cgroup in cgroup_iter_seq_init()
>>    selftests/bpf: Add cgroup helper remove_cgroup()
>>    selftests/bpf: Add test for cgroup iterator on a dead cgroup
>>
>>   kernel/bpf/cgroup_iter.c                      | 14 ++++
>>   tools/testing/selftests/bpf/cgroup_helpers.c  | 19 +++++
>>   tools/testing/selftests/bpf/cgroup_helpers.h  |  1 +
>>   .../selftests/bpf/prog_tests/cgroup_iter.c    | 78 +++++++++++++++++++
>>   4 files changed, 112 insertions(+)
>>
>
> .

