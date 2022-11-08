Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B605620808
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 05:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiKHEIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 23:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKHEIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 23:08:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D66CC3
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 20:08:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5vj03QcNz4f3smW
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 12:08:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgB3IK8x1mljHN+eAA--.43236S2;
        Tue, 08 Nov 2022 12:08:21 +0800 (CST)
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
To:     Hao Luo <haoluo@google.com>, Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com>
 <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
 <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com>
Date:   Tue, 8 Nov 2022 12:08:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgB3IK8x1mljHN+eAA--.43236S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUGrWUKw4rZryrCw4DJwb_yoW8Xr4Upa
        y0gay5tFn7Cr42vrsFk3y8ua4jyrWfJry3Xr4qyr4UuF90gFyxGryUKr45CFy3AF4I934U
        Z3ZY93WfGw1jy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/8/2022 10:11 AM, Hao Luo wrote:
> On Mon, Nov 7, 2022 at 1:59 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>> On 11/6/22 11:42 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> bpf_iter_attach_cgroup() has already acquired an extra reference for the
>>> start cgroup, but the reference will be released if the iterator link fd
>>> is closed after the creation of iterator fd, and it may lead to
>>> User-After-Free when reading the iterator fd.
>>>
>>> So fixing it by acquiring another reference for the start cgroup.
>>>
>>> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
> There is an alternative: does it make sense to have the iterator hold
> a ref of the link? When the link is closed, my assumption is that the
> program is already detached from the cgroup. After that, it makes no
> sense to still allow iterating the cgroup. IIUC, holding a ref to the
> link in the iterator also fixes for other types of objects.
Also considered the alternative solution when fixing the similar problem in bpf
map element iterator [0]. The problem is not all of bpf iterators need the
pinning (e.g., bpf map iterator). Because bpf prog is also pinned by iterator fd
in iter_open(), so closing the fd of iterator link doesn't release the bpf program.

[0]: https://lore.kernel.org/bpf/20220810080538.1845898-2-houtao@huaweicloud.com/
>
> Hao

