Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4926A59BF4B
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiHVMJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiHVMJx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 08:09:53 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA23A494
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 05:09:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MBB2n56KGz6V4Mp
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 20:08:17 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgBXXPkLcgNjOyy1Ag--.5151S2;
        Mon, 22 Aug 2022 20:09:50 +0800 (CST)
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <YwM6l7MxTe47fzFZ@linutronix.de>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <28f33042-2c86-87e9-bfdb-5bc312f06f71@huaweicloud.com>
Date:   Mon, 22 Aug 2022 20:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YwM6l7MxTe47fzFZ@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgBXXPkLcgNjOyy1Ag--.5151S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFy5Cr47Kw1UGFyfuF18AFb_yoW8JF15pF
        WrGFW8Ka18XasYvFsxtr10yryYyw48WrWIyrW8KrWYvr1DJwna9ryIkan0qFy0vrnxGr93
        XF4vya15Zry5CFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUo0eHDUUUU
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

On 8/22/2022 4:13 PM, Sebastian Andrzej Siewior wrote:
> On 2022-08-21 11:32:21 [+0800], Hou Tao wrote:
>> process A                      process B
>>
>> htab_map_update_elem()
>>   htab_lock_bucket()
>>     migrate_disable()
>>     /* return 1 */
>>     __this_cpu_inc_return()
>>     /* preempted by B */
>>
>>                                htab_map_update_elem()
>>                                  /* the same bucket as A */
>>                                  htab_lock_bucket()
>>                                    migrate_disable()
>>                                    /* return 2, so lock fails */
>>                                    __this_cpu_inc_return()
>>                                    return -EBUSY
>>
>> A fix that seems feasible is using in_nmi() in htab_lock_bucket() and
>> only checking the value of map_locked for nmi context. But it will
>> re-introduce dead-lock on bucket lock if htab_lock_bucket() is re-entered
>> through non-tracing program (e.g. fentry program).
>>
>> So fixing it by using disable_preempt() instead of migrate_disable() when
>> increasing htab->map_locked. However when htab_use_raw_lock() is false,
>> bucket lock will be a sleepable spin-lock and it breaks disable_preempt(),
>> so still use migrate_disable() for spin-lock case.
> But isn't the RT case still affected by the very same problem?
As said in patch 0, the CONFIG_PREEMPT_RT && non-preallocated case is fixed in
patch 2.
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Sebastian
> .

