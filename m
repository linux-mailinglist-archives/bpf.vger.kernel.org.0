Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4662123C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiKHNXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 08:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiKHNXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 08:23:50 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F292647
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 05:23:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N681p5yJDz4f3wtZ
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 21:23:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXOrZaWGpjf9a8AA--.44113S2;
        Tue, 08 Nov 2022 21:23:42 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Pass map file to .map_update_batch directly
To:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>, houtao1@huawei.com
References: <20221107075537.1445644-1-houtao@huaweicloud.com>
 <ef14ccf1-fc17-57df-fba7-162845be4722@meta.com>
 <7d81cf6f-9881-32cf-d981-9360e33b5f4d@huaweicloud.com>
 <d520f61e-e19b-c094-028d-72d481945ffb@meta.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7df16f89-726e-a94d-399d-f3e546accaf5@huaweicloud.com>
Date:   Tue, 8 Nov 2022 21:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d520f61e-e19b-c094-028d-72d481945ffb@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXOrZaWGpjf9a8AA--.44113S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1xKF13JFW7Gr48Ww4rXwb_yoW5CrWxpF
        WftFWUKrWDWF18Xw17tw1UWryYvr4Ut345Xrn8Ga4UAw4qqryFgr1jqa1q9a4UJr48Gr4U
        tr4UtFyxZrsrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/8/2022 2:34 PM, Yonghong Song wrote:
>
>
> On 11/7/22 4:53 PM, Hou Tao wrote:
>> Hi,
>>
>> On 11/8/2022 8:08 AM, Yonghong Song wrote:
>>>
>>>
>>> On 11/6/22 11:55 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> Currently generic_map_update_batch() will get map file from
>>>> attr->batch.map_fd and pass it to bpf_map_update_value(). The problem is
>>>> map_fd may have been closed or reopened as a different file type and
>>>> generic_map_update_batch() doesn't check the validity of map_fd.
>>>>
>>>> It doesn't incur any problem as for now, because only
>>>> BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map file and it doesn't
>>>> support batch update operation. But it is better to fix the potential
>>>> use of an invalid map file.
>>>
>>> I think we don't have problem here. The reason is in bpf_map_do_batch()
>>> we have
>>>      f = fdget(ufd);
>>>      ...
>>>      BPF_DO_BATCH(map->ops->map_update_batch);
>>>      fdput(f)
>>>
>>> So the original ufd is still valid during map->ops->map_update_batch
>>> which eventually may call generic_map_update_batch() which tries to
>>> do fdget(ufd) again.
>> The previous fdget() only guarantees the liveness of struct file. If the map fd
>> is closed by another thread concurrently, the fd will released by pick_file() as
>> show below:
>>
>> static struct file *pick_file(struct files_struct *files, unsigned fd)
>> {
>>          struct fdtable *fdt = files_fdtable(files);
>>          struct file *file;
>>
>>          file = fdt->fd[fd];
>>          if (file) {
>>                  rcu_assign_pointer(fdt->fd[fd], NULL);
>>                  __put_unused_fd(files, fd);
>>          }
>>          return file;
>> }
>>
>> So the second fdget(udf) may return a NULL file or a different file.
>
> Okay. Thanks for explanation. It would be great if you can describe
> the above reasoning clearly in the commit message since this is
> where the bug exists.
Will do in v2.
>
> Not sure why BPF_MAP_TYPE_PERF_EVENT_ARRAY matters here. Or you just
> show BPF_MAP_TYPE_PERF_EVENT_ARRAY does not have a problem. If this
> is the case, there is no need to mention it in the commit message.
I am trying to say that BPF_MAP_TYPE_PERF_EVENT_ARRAY  doesn't have a problem
now, but if we add batch update to it, it will have the problem, because only
BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map_file in .map_fd_get_ptr(). I
will remove the words from the commit message.
>
>>
>>>
>>> Did I miss anything here?
>>>
>>>>
>>>> Checking the validity of map file returned from fdget() in
>>>> generic_map_update_batch() can not fix the problem, because the returned
>>>> map file may be different with map file got in bpf_map_do_batch() due to
>>>> the reopening of fd, so just passing the map file directly to
>>>> .map_update_batch() in bpf_map_do_batch().
>>>>
>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> [...]

