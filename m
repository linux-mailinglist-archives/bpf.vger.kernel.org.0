Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B162B38F
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 07:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKPG4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 01:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKPG4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 01:56:23 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641DCBF45
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 22:56:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NBv342zGFz4f3l1v
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 14:56:16 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgDX+9iPiXRjguVyAg--.11705S2;
        Wed, 16 Nov 2022 14:56:19 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
 <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
 <71933d25-b160-3e19-c544-1e12b934f07f@huaweicloud.com>
 <CAADnVQLdJVUsM-ZsOjsCS1aQZkzDQD-iBr_hDLG_OAs5xrmBFg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <c35e4748-24bb-d221-f0f2-51b210066815@huaweicloud.com>
Date:   Wed, 16 Nov 2022 14:56:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQLdJVUsM-ZsOjsCS1aQZkzDQD-iBr_hDLG_OAs5xrmBFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDX+9iPiXRjguVyAg--.11705S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wry5tw4fWF15Aw4Uur1Utrb_yoWfuFc_uF
        yqg34DWa1UCwsayF4akr1aqF9rCFWkX347Jr4Ut3W0vFy5Zas3Aa12k3yrZ34UAFyvqFy8
        Wr9rX39Fg3y2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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

On 11/16/2022 1:43 PM, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 6:40 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Also pls target this kind of change to bpf-next especially
>>> when there is a consideration to revert other fixes.
>>> This kind of questionable fixes are not suitable for bpf tree
>>> regardless of how long the "bug" was present.
>> The reason to post the fix to bpf tree instead bpf-next is that cgroup iterator
>> is merged in v6.1 and I think it is better to merge the fix into v6.1 instead of
>> v6.2. And patchset v1 is not a questionable fixes, because iterator link has
>> already acquired the reference of the start cgroup.
> These "fixes are not suitable for bpf tree regardless of how long the
> "bug" was present".
I see. Should I include the revert patches in v3 and resend it to bpf-next tree
? Or the patchset will be merged to bpf-next and I just need to send a follow-up
revert patchset to bpf-next ?
> .

