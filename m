Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16015A5978
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 04:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiH3ChZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 22:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiH3ChY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 22:37:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D59E0FD
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 19:37:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGryh1vqnzl6RM
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 10:35:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgCH2HHddw1j2cB4AA--.1963S2;
        Tue, 30 Aug 2022 10:37:21 +0800 (CST)
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test concurrent updates on
 bpf_task_storage_busy
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220829142752.330094-1-houtao@huaweicloud.com>
 <20220829142752.330094-4-houtao@huaweicloud.com>
 <20220830011350.ig3djlqfume5wqz2@kafai-mbp.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <86429073-f29e-207d-9869-056c54a3ba04@huaweicloud.com>
Date:   Tue, 30 Aug 2022 10:37:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220830011350.ig3djlqfume5wqz2@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgCH2HHddw1j2cB4AA--.1963S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUAFy3WF4UXF43ur4kWFg_yoW8KrWrpF
        Wxta4fZr1v93W0v342yas7Zry5twn5Xw4UKrWrtF13Aw4DGF1Fgr1Iy3W5uF9xCr4rXa1r
        Zw1kXa1Uuw1kZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/30/2022 9:13 AM, Martin KaFai Lau wrote:
> On Mon, Aug 29, 2022 at 10:27:52PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When there are concurrent task local storage lookup operations,
>> if updates on per-cpu bpf_task_storage_busy is not preemption-safe,
>> some updates will be lost due to interleave, the final value of
>> bpf_task_storage_busy will not be zero and bpf_task_storage_trylock()
>> on specific cpu will fail forever.
>>
>> So add a test case to ensure the update of per-cpu bpf_task_storage_busy
>> is preemption-safe.
> This test took my setup 1.5 minute to run
> and cannot reproduce after running the test in a loop.
>
> Can it be reproduced in a much shorter time ?
> If not, test_maps is probably a better place to do the test.
I think the answer is No. I have think about adding the test in test_maps, but
the test case needs running a bpf program to check whether the value of
bpf_task_storage_busy is OK, so for simplicity I add it in test_progs.
If the running time is the problem, I can move it into test_maps.
> I assume it can be reproduced in arm with this test?  Or it can
> also be reproduced in other platforms with different kconfig.
> Please paste the test failure message and the platform/kconfig
> to reproduce it in the commit message.
On arm64 it can be reproduced probabilistically when CONFIG_PREEMPT is enabled
on 2-cpus VM as show below. You can try to increase the value of nr and loop if
it still can not be reproduced.

test_preemption:PASS:skel_open_and_load 0 nsec
test_preemption:PASS:no mem 0 nsec
test_preemption:PASS:skel_attach 0 nsec
test_preemption:FAIL:bpf_task_storage_get fails unexpected bpf_task_storage_get
fails: actual 0 != expected 1
#174/4   task_local_storage/preemption:FAIL
#174     task_local_storage:FAIL

All error logs:
test_preemption:PASS:skel_open_and_load 0 nsec
test_preemption:PASS:no mem 0 nsec
test_preemption:PASS:skel_attach 0 nsec
test_preemption:FAIL:bpf_task_storage_get fails unexpected bpf_task_storage_get
fails: actual 0 != expected 1
#174/4   task_local_storage/preemption:FAIL
#174     task_local_storage:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

On x86-64 __this_cpu_{inc|dec} are atomic, so it is not possible to reproduce
the problem.


