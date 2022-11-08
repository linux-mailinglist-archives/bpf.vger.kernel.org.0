Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF526204B9
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKHAju (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHAjt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:39:49 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6F13F6F
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:39:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5q4G2yVWz4f3mVW
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:39:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAni7ZNpWljejKgAA--.4543S2;
        Tue, 08 Nov 2022 08:39:45 +0800 (CST)
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Add test for cgroup iterator on a
 dead cgroup
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
 <20221107074222.1323017-4-houtao@huaweicloud.com>
 <d081c2ea-cdd4-d09b-4553-93ceafca80be@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <facf093f-6f20-672a-4605-16d23e45d4a8@huaweicloud.com>
Date:   Tue, 8 Nov 2022 08:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d081c2ea-cdd4-d09b-4553-93ceafca80be@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAni7ZNpWljejKgAA--.4543S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Xw4UGr4ktw13Gr4DArb_yoW8Zw43pF
        s5tFW5ta4rArnY9r1Ut34jvFyFyr48Aa1DXr18XFWUAFsrAr10gw1jvrnY9F1DAFs7Jr17
        Zr4Y9w4fur17trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
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

On 11/8/2022 6:44 AM, Yonghong Song wrote:
>
>
> On 11/6/22 11:42 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The test closes both iterator link fd and cgroup fd, and removes the
>> cgroup file to make a dead cgroup before reading cgroup iterator fd. It
>> also uses kern_sync_rcu() and usleep() to wait for the release of
>> start cgroup. If the start cgroup is not pinned by cgroup iterator,
>> reading iterator fd will trigger use-after-free.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> LGTM with a few nits below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
SNIP
>
>> +    cgrp_fd = create_and_get_cgroup(cgrp_name);
>> +    if (!ASSERT_GE(cgrp_fd, 0, "create cgrp"))
>> +        return;
>> +
>> +    /* The cgroup is already dead during iteration, so it only has epilogue
>> +     * in the output.
>> +     */
>
> Let us reword the comment like
>     The cgroup will be dead during read() iteration, and it only has
>     epilogue in the output.
Will do in v2.
>
>> +    snprintf(expected_output, sizeof(expected_output), EPILOGUE);
>> +
>> +    memset(&linfo, 0, sizeof(linfo));
>> +    linfo.cgroup.cgroup_fd = cgrp_fd;
>> +    linfo.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY;
>> +    opts.link_info = &linfo;
>> +    opts.link_info_len = sizeof(linfo);
>> +
SNIP
>>   void test_cgroup_iter(void)
>>   {
>>       struct cgroup_iter *skel = NULL;
>> @@ -217,6 +293,8 @@ void test_cgroup_iter(void)
>>           test_early_termination(skel);
>>       if (test__start_subtest("cgroup_iter__self_only"))
>>           test_walk_self_only(skel);
>> +    if (test__start_subtest("cgroup_iter_dead_self_only"))
>
> Let us follow the convention in this file with
>     cgroup_iter__dead_self_only
My bad. Will fixes in v2.
>
>> +        test_walk_dead_self_only(skel);
>>   out:
>>       cgroup_iter__destroy(skel);
>>       cleanup_cgroups();

