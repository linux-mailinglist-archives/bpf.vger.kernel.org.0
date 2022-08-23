Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D827D59CEE0
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 04:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiHWC5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiHWC5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 22:57:22 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B05A824
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 19:57:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MBYkp1HXHz6T6XG
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 10:55:46 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDn0b0MQgRjK97lAg--.59798S2;
        Tue, 23 Aug 2022 10:57:19 +0800 (CST)
Subject: Re: [PATCH 1/3] bpf: Disable preemption when increasing per-cpu
 map_locked
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, Hou Tao <houtao1@huawei.com>
References: <20220821033223.2598791-1-houtao@huaweicloud.com>
 <20220821033223.2598791-2-houtao@huaweicloud.com>
 <CA+khW7jv6J9FSqNvaHNzYNpEBoQX6wPEEdoD4OwkPQt844Wwmw@mail.gmail.com>
 <3287b95c-30e1-5647-fe2c-1feff673291d@huaweicloud.com>
 <CA+khW7h1OK2oqGyCipGfySV_kcHW4=SHo6123nk2WTTXMOMUxQ@mail.gmail.com>
 <387c851f-03ae-9b34-4ec0-9667fb26ec18@huaweicloud.com>
 <CA+khW7jgvZR8azSE3gEJvhT_psgEeHCdU3uWAQUkkKFLgh0a4Q@mail.gmail.com>
 <CA+khW7iv+zX0XzC++i-F7QZju9QGufh6+SVN3JWp9WyJe2qhMg@mail.gmail.com>
 <CAADnVQ+udaAy5OZ-BXpfeQZdPRHD6F+FUD7KxJfxcjiyvh2Dsg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <67c5da0b-e5af-0934-6e17-1c43d0f96165@huaweicloud.com>
Date:   Tue, 23 Aug 2022 10:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+udaAy5OZ-BXpfeQZdPRHD6F+FUD7KxJfxcjiyvh2Dsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDn0b0MQgRjK97lAg--.59798S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4xGw4UJrykCF17Cw18Grg_yoW8JF43pa
        98Ww4vyF4kXFnFy3ZrWw18W34vva1rKryftrW5GrWDAry5Xr9a9ws2q3W5uFykJFyrKFZa
        qF4DXF95ZF10va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUbG2NtUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/23/2022 9:29 AM, Alexei Starovoitov wrote:
> On Mon, Aug 22, 2022 at 5:56 PM Hao Luo <haoluo@google.com> wrote:
>>
SNIP
>> Tao, thanks very much for the test. I played it a bit and I can
>> confirm that map_update failures are seen under CONFIG_PREEMPT. The
>> failures are not present under CONFIG_PREEMPT_NONE or
>> CONFIG_PREEMPT_VOLUNTARY. I experimented with a few alternatives I was
>> thinking of and they didn't work. It looks like Hou Tao's idea,
>> promoting migrate_disable to preempt_disable, is probably the best we
>> can do for the non-RT case. So
> preempt_disable is also faster than migrate_disable,
> so patch 1 will not only fix this issue, but will improve performance.
>
> Patch 2 is too hacky though.
> I think it's better to wait until my bpf_mem_alloc patches land.
> RT case won't be special anymore. We will be able to remove
> htab_use_raw_lock() helper and unconditionally use raw_spin_lock.
> With bpf_mem_alloc there is no inline memory allocation anymore.
OK. Look forwards to the landing of BPF specific memory allocator.
>
> So please address Hao's comments, add a test and
> resubmit patches 1 and 3.
> Also please use [PATCH bpf-next] in the subject to help BPF CI
> and patchwork scripts.
Will do. And to bpf-next instead of bpf ?
> .

