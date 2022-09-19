Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9A5BCD48
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiISNcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 09:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISNcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 09:32:11 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78901BEBF;
        Mon, 19 Sep 2022 06:32:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWQXL19S5z6S2nV;
        Mon, 19 Sep 2022 21:30:10 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
        by APP2 (Coremail) with SMTP id Syh0CgDHYWtSbyhjnodSBA--.50647S2;
        Mon, 19 Sep 2022 21:32:06 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 1/2] bpf, cgroup: Don't populate
 prog_attach_flags array when effective query
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
References: <20220914161742.3180731-1-pulehui@huaweicloud.com>
 <20220914161742.3180731-2-pulehui@huaweicloud.com>
 <9b66564e-2582-03b2-56f1-8037f8aca886@linux.dev>
From:   Pu Lehui <pulehui@huaweicloud.com>
Message-ID: <037a6a32-5143-ddad-4a43-bd815280a0ef@huaweicloud.com>
Date:   Mon, 19 Sep 2022 21:32:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9b66564e-2582-03b2-56f1-8037f8aca886@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHYWtSbyhjnodSBA--.50647S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfJFykJry5Jr4xCr43GFg_yoW8ury7pF
        WxZFy7GF1DX3y2gas2v3s5XayIqan5JF45Cr93Jry5uFWqgr109r4xAayF9F15XFWjyw10
        vw4Yvr1DWF9ruFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/9/17 8:03, Martin KaFai Lau wrote:
> On 9/14/22 9:17 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Attach flags is only valid for attached progs of this layer cgroup,
>> but not for effective progs. For querying with EFFECTIVE flags,
>> exporting attach flags does not make sense. so we don't need to
>> populate prog_attach_flags array when effective query.
> 
> prog_attach_flags has been added to 6.0 which is in rc5.  It is still 
> doable (and cleaner) to reject prog_attach_flags when it is an 
> effective_query.  This should be done regardless of 'type == 
> BPF_LSM_CGROUP' or not.  Something like:
> 
> if (effective_query && prog_attach_flags)
>      return -EINVAL;
> 
> Otherwise, the whole prog_attach_flags needs to be set to 0 during 
> effective_query.  Please target the change to the bpf tree instead of 
> bpf-next such that this uapi bit can be fixed before 6.0.
> 

Okay, will handle in next version.

> Also, the effective_query issue is not limited to the prog_attach_flags? 
> For the older uattr->query.attach_flags, it should be set to 0 also when 
> it is an effective_query, right?

For output uattr->query.attach_flags, we certainly don't need to copy it 
to userspace when effective query. Since we do not utilize 
uattr->query.attach_flags in the cgroup query function, should we need 
to take it as input and reject when it is non-zero in effective query? 
Something like:
if (effective_query && (prog_attach_flags || attr->query.attach_flags))

For both output and input scenarios, we are faced with the problem that 
there is a ambiguity in attach_flags being 0. When we do not copy to the 
userspace, libbpf will set it to 0 by default, and 0 can mean NONE flag 
attach, or no attach prog. The same is true for input scenarios.

So should we need to define NONE attach flag and redefine the others? 
Such as follow:
#define BPF_F_ALLOW_NONE    	(1U << 0)
#define BPF_F_ALLOW_OVERRIDE    (1U << 1)
#define BPF_F_ALLOW_MULTI       (1U << 2)
#define BPF_F_REPLACE           (1U << 3)

And then attach flags being 0 certainly means no attach any prog.

