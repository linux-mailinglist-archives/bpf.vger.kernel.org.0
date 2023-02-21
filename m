Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535F69D820
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 02:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjBUBrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 20:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBUBrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 20:47:10 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4F23130;
        Mon, 20 Feb 2023 17:47:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLMbW57JZz4f3kpw;
        Tue, 21 Feb 2023 09:47:03 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP3 (Coremail) with SMTP id _Ch0CgDXzBqXIvRjpZ2tDg--.32789S2;
        Tue, 21 Feb 2023 09:47:04 +0800 (CST)
Message-ID: <80e69e73-b873-6717-fe45-a854dbdd5476@huaweicloud.com>
Date:   Tue, 21 Feb 2023 09:47:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2] riscv, bpf: Add kfunc support for RV64
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20230220083203.2988238-1-pulehui@huaweicloud.com>
 <874jrg76dc.fsf@all.your.base.are.belong.to.us>
From:   Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <874jrg76dc.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDXzBqXIvRjpZ2tDg--.32789S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW3Jr45Kw47Zr1DtF1fWFg_yoWktFcEkr
        s7tF92q34rJ3W7J3W2kwsIkrWDGws7XFy0q3yjgr4Skr95Xa9rWasYkr9aqw4xXFyfZrsI
        qrW5X3ZxA347ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
        XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUrR6zUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2023/2/20 22:34, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> As another important missing piece of RV64 JIT, kfunc allow bpf programs
>> call kernel functions. For now, RV64 is sufficient to enable it.
> 
> Thanks Lehui!
> 
> Maybe we can reword/massage the commit message a bit? What do you think
> about something like:
> 
> "Now that the BPF trampoline is supported by RISC-V, it is possible to
> use BPF programs with kfunc calls.
> 

kfunc and bpf trampoline are functionally independent. kfunc [1], like 
bpf helper functions, allows bpf programs to call exported kernel 
functions, while bpf trampoline provides a more efficient way than 
kprobe to act as a mediator between kernel functions and bpf programs, 
and between bpf programs.

In fact, it was already supported before the bpf trampoline 
implementation, I just turned it on. As for RV32 kfunc, it needs to do 
some registers parsing.

[1] https://lore.kernel.org/bpf/20210325015124.1543397-1-kafai@fb.com/

> Note that the trampoline functionality is only supported by RV64.
> 
> Add bpf_jit_supports_kfunc_call() to the 64-bit JIT."
> 
> 
> Björn

