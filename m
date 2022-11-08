Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355226206B1
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 03:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiKHCWc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 21:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiKHCWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 21:22:32 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2DBB15
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 18:22:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5sLm53fQz4f3snD
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:22:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDnSrZfvWljlyakAA--.9756S2;
        Tue, 08 Nov 2022 10:22:27 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
 <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com>
 <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
 <b20aa49f-61ee-6275-3f8b-aa2b5e950874@huaweicloud.com>
 <CAADnVQJXdFsPXSQBhD9WD_66bWaGyq1x_=SY5UiFGzUqm=34Dg@mail.gmail.com>
 <de1173bb-3adf-a04c-7999-44e7e7103ff9@huaweicloud.com>
 <CAADnVQ+_xJzdLpJMucRA7wXRBUr7msDktEjYfcinfzrRGLfVTg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <6b73a103-e8db-d7e8-e7e5-88b9be6bc8e2@huaweicloud.com>
Date:   Tue, 8 Nov 2022 10:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+_xJzdLpJMucRA7wXRBUr7msDktEjYfcinfzrRGLfVTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDnSrZfvWljlyakAA--.9756S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw13GFyUWw43tFWxXr1UJrb_yoWfAFb_Cr
        Wktry8Wr9xAa1rGw45KFWktFZ0kayUG3Z5urykJr9rtryrZas0vayq9ws5uF47GF4Iv3s0
        gFn8JF13ZrZaqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 10/21/2022 12:22 PM, Alexei Starovoitov wrote:
> On Thu, Oct 20, 2022 at 7:26 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> How about reject the NUMA node setting for non-preallocated hash table in
>> hashtab.c ?
> It's easy to ask the question, but please answer it yourself.
> Analyze the code and describe what you think is happening now
> and what should or should not be the behavior.
> .
I found it is a bad idea to reject the numa node setting for non-preallocated
hash table. The reason is that now hash buckets are still allocated according to
the numa node setting. If the numa node setting is rejected, the use case below
won't work normally, so I will keep it as-is:

1. a non-preallocated hash table is created on numa node 2 (buckets are
allocated from node 2)
2. bpf program is running on numa node 2 (elements are also allocated from node 2)
3. all used memories are allocated from node 2.


