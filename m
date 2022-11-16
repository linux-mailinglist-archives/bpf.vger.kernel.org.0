Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAD62B16D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKPCkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKPCke (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:40:34 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD716B851
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:40:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NBnMv65Vgz4f3l2Y
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:40:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgAXJqKcTXRj+V4zAg--.65391S2;
        Wed, 16 Nov 2022 10:40:30 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <71933d25-b160-3e19-c544-1e12b934f07f@huaweicloud.com>
Date:   Wed, 16 Nov 2022 10:40:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgAXJqKcTXRj+V4zAg--.65391S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kCw48KF4rZrW7Ww1Utrb_yoW8KF15pr
        Z0qa98tr1kArWjvF12ka1jq3WF9FWfGr4UAr4fJr17C3Z8ZryfKFWIyr4SkFyUCFsrJw12
        qF4Fk34fWrZFyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUOyCJDUUUU
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

On 11/16/2022 9:37 AM, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 11/10/22 10:34 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
>>> the reference of iteration target in .attach_target(), but iterator link
>>> may be closed before or in the middle of iteration, so iterator will
>>> need to acquire the reference of iteration target as well to prevent
>>> potential use-after-free. To avoid doing the acquisition in
>>> .init_seq_private() for each iterator type, just pin iterator link in
>>> iterator.
>> iiuc, a link currently will go away when all its fds closed and pinned file
>> removed.  After this change, the link will stay until the last iter is closed().
>>   Before then, the user space can still "bpftool link show" and even get the
>> link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
>> to explain it in the commit message.
>>
>> and does this new behavior make sense when comparing with other link types?
> One more question to the above...
>
> Does this change mean that pinned cgroup iterator in bpffs
> would prevent cgroup removal?
> So that cgroup cannot even become a dying cgroup ?
No. The pinned cgroup still can be removed by rmdir and it is demonstrated in
the added test case. Getting an extra reference of cgroup just delays the
freeing of cgroup. And the change doesn't effect the pinned iterator in bpffs,
because when pinning the iterator in bpffs, it has already pinned the iterator link.
> If so we can do that and an approach similar to init_seq_private
> taken for map iterators is necessary here as well.
Do you mean pinning the cgroup in .init_seq_private() instead of pinning the
iterator link just like v1 does ?
>
> Also pls target this kind of change to bpf-next especially
> when there is a consideration to revert other fixes.
> This kind of questionable fixes are not suitable for bpf tree
> regardless of how long the "bug" was present.
The reason to post the fix to bpf tree instead bpf-next is that cgroup iterator
is merged in v6.1 and I think it is better to merge the fix into v6.1 instead of
v6.2. And patchset v1 is not a questionable fixes, because iterator link has
already acquired the reference of the start cgroup.

