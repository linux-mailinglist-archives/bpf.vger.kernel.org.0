Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B135865589D
	for <lists+bpf@lfdr.de>; Sat, 24 Dec 2022 07:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLXGXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Dec 2022 01:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXGXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Dec 2022 01:23:06 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5958164BC;
        Fri, 23 Dec 2022 22:23:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NfDW62ZMgz4f3k6G;
        Sat, 24 Dec 2022 14:22:58 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP2 (Coremail) with SMTP id Syh0CgC3XevBmqZjip+oAQ--.41973S2;
        Sat, 24 Dec 2022 14:22:59 +0800 (CST)
Message-ID: <b3fb772a-db85-05ca-a1bf-4781526fae1d@huaweicloud.com>
Date:   Sat, 24 Dec 2022 14:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH RESEND bpf-next 0/4] Support bpf trampoline for RV64
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <87ili3a8zy.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87ili3a8zy.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3XevBmqZjip+oAQ--.41973S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW3Jr4fCF1kGFyUZw1rCrg_yoWfZrgEkr
        ZxtrySvr45ta1Dtw1Ygw43urZxXr40qFyvyrWUXFZ2k395ZF1kXFn8u39xArWfZ3ySqFnx
        tF98AFyxAasFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/12/22 21:00, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> BPF trampoline is the critical infrastructure of the bpf
>> subsystem, acting as a mediator between kernel functions
>> and BPF programs. Numerous important features, such as
>> using ebpf program for zero overhead kernel introspection,
>> rely on this key component. We can't wait to support bpf
>> trampoline on RV64. The implementation of bpf trampoline
>> was closely to x86 and arm64 for future development.
> 
> Thank you for working on this! BPF trampoline is the "missing piece"
> from getting proper kfunc support.
> 
> Unfortunately, I wont be able to do a proper review until next week.
> 

Take your time, it might take several rounds of optimization. Yep, riscv 
bpf will look more complete when bpf trampoline and kfunc are supported.

Anyway, have a nice christmas holidays.😄

Lehui

> 
> Happy holidays,
> Björn

