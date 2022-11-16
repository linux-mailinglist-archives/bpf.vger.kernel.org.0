Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFC62B16C
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKPCjv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKPCju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:39:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C06B851
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:39:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBnM20cJQz4f3jM4
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:39:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDn_LdtTXRj93JgAg--.28886S2;
        Wed, 16 Nov 2022 10:39:45 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
 <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <263a0664-3d8c-7ef3-48b0-f41475534e43@huaweicloud.com>
Date:   Wed, 16 Nov 2022 10:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDn_LdtTXRj93JgAg--.28886S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF18tw4fKrW5ur43uryrXrb_yoW8WFyxpF
        WFga98Kr1kZrZFyF12k3sruayY9FyfGr17Ar4Sgw1fCF15AFWxK3yxtw4fKFyYyFZ7Zw1j
        qay0k3Z3ZasFyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
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

On 11/16/2022 3:16 AM, Martin KaFai Lau wrote:
> On 11/10/22 10:34 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
>> the reference of iteration target in .attach_target(), but iterator link
>> may be closed before or in the middle of iteration, so iterator will
>> need to acquire the reference of iteration target as well to prevent
>> potential use-after-free. To avoid doing the acquisition in
>> .init_seq_private() for each iterator type, just pin iterator link in
>> iterator.
>
> iiuc, a link currently will go away when all its fds closed and pinned file
> removed.  After this change, the link will stay until the last iter is
> closed().  Before then, the user space can still "bpftool link show" and even
> get the link back by bpf_link_get_fd_by_id().  If this is the case, it would
> be useful to explain it in the commit message.
Yes, the iterator link is still reachable from "bpftool link show" and
bpf_link_get_fd_by_id().
>
> and does this new behavior make sense when comparing with other link types?
Have not considered about that. It seems that other link type will not be used
as an input for the creation of a bpf object (e.g., iterator). But if the fd of
other link type is closed, the link will be released. So after the fix in v2,
the behavior of iterator link will be different with other link types.
>
>>
>> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   kernel/bpf/bpf_iter.c | 21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
.

