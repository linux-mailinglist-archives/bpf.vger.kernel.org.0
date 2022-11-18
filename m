Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7D62EB58
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKRBwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRBwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:52:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730C1ADB4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:52:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ND0CL3VL8z4f3m6c
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 09:52:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCXutdN5XZjNyzaAg--.33147S2;
        Fri, 18 Nov 2022 09:52:17 +0800 (CST)
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
 <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
 <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
 <43bcd243-eea0-6cbe-b24b-640311fa1a83@linux.dev>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <6159bf91-21c7-3fb0-e211-a40e85fd5bdc@huaweicloud.com>
Date:   Fri, 18 Nov 2022 09:52:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <43bcd243-eea0-6cbe-b24b-640311fa1a83@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCXutdN5XZjNyzaAg--.33147S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWrZFW7Aw18GFy8Gw4xCrg_yoW8uw1xpF
        WFgay5K3WkArZFvF12yws7Za40yF9xGr1UZrn5Gr1fCF90yry3KrWxKrsIkFy5AF1DZw12
        vF4jkas7ZanIyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/17/2022 2:48 PM, Martin KaFai Lau wrote:
> On 11/15/22 6:48 PM, Hao Luo wrote:
>> On Tue, Nov 15, 2022 at 5:37 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 11/10/22 10:34 PM, Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
>>>>> the reference of iteration target in .attach_target(), but iterator link
>>>>> may be closed before or in the middle of iteration, so iterator will
>>>>> need to acquire the reference of iteration target as well to prevent
>>>>> potential use-after-free. To avoid doing the acquisition in
>>>>> .init_seq_private() for each iterator type, just pin iterator link in
>>>>> iterator.
>>>>
>>>> iiuc, a link currently will go away when all its fds closed and pinned file
>>>> removed.  After this change, the link will stay until the last iter is
>>>> closed().
>>>>    Before then, the user space can still "bpftool link show" and even get the
>>>> link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
>>>> to explain it in the commit message.
>>>>
>>>> and does this new behavior make sense when comparing with other link types?
>>
>> I think this is a unique problem in iter link. Because iter link is
>> the only link type that can generate another object.
>
> Should a similar solution as in the current map iter be used then?
>
> I am thinking, after all link fds are closed and its pinned files are removed,
> if it cannot stop the already created iter, it should at least stop new iter
> from being created?
Rather than adding the above logic for iterator link, just pinning the start
cgroup in .init_seq_private() will be much simpler.

And Hao worried about the close of iterator link fd will release the attached
program and cause use-after-free problem, but it is not true, because
prepare_seq_file() has already acquired an extra reference of the currently
attached program, so it is OK to read the iterator after the close of iterator
link fd. So what do you think ?
>
>
>
> .

