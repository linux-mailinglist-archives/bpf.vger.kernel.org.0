Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA9629737
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKOLUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiKOLTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 06:19:03 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B5DF6
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 03:18:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBNw32psbz4f3k5k
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 19:18:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgBndqKCdXNjKSURAg--.52352S2;
        Tue, 15 Nov 2022 19:18:30 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] bpf: Pass map file to .map_update_batch
 directly
To:     Daniel Bokmann <darkstar@linux.home>, sdf@google.com
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
References: <20221111080757.2224969-1-houtao@huaweicloud.com>
 <Y26JtknJKjnD+dsu@google.com> <20221114174944.GA29631@linux.home>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <4317f99a-f466-23e1-366e-890f34624c65@huaweicloud.com>
Date:   Tue, 15 Nov 2022 19:18:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221114174944.GA29631@linux.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgBndqKCdXNjKSURAg--.52352S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF17ury3Xr45JFy8WFW3Jrb_yoW8Zw47pF
        WrKay3KFWkXryUXrsIqwn8Zay3Zr47Gry5Xr1Ygw4q9r1DXa4Skr10qa1DCFZ8Xr45Kr1j
        g39rta48Zr4ayFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 11/15/2022 1:49 AM, Daniel Bokmann wrote:
> On Fri, Nov 11, 2022 at 09:43:18AM -0800, sdf@google.com wrote:
>> On 11/11, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>> Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
>>> the target map file, then it invokes generic_map_update_batch() to do
>>> batch update. generic_map_update_batch() will get the target map file
>>> by using fdget(batch.map_fd) again and pass it to
>>> bpf_map_update_value().
>>> The problem is map file returned by the second fdget() may be NULL or a
>>> totally different file compared by map file in bpf_map_do_batch(). The
>>> reason is that the first fdget() only guarantees the liveness of struct
>>> file instead of file descriptor and the file description may be released
>>> by concurrent close() through pick_file().
>>> It doesn't incur any problem as for now, because maps with batch update
>>> support don't use map file in .map_fd_get_ptr() ops. But it is better to
>>> fix the access of a potentially invalid map file.
> Right, that's mainly for the perf RB map ...
Yes. BPF_MAP_TYPE_PERF_EVENT_ARRAY will use the passed map file, but it doesn't
support batch update.
>
>>> using __bpf_map_get() again in generic_map_update_batch() can not fix
>>> the problem, because batch.map_fd may be closed and reopened, and the
>>> returned map file may be different with map file got in
>>> bpf_map_do_batch(), so just passing the map file directly to
>>> .map_update_batch() in bpf_map_do_batch().
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> [..]
>>
>>> +#define BPF_DO_BATCH_WITH_FILE(fn)			\
>>> +	do {						\
>>> +		if (!fn) {				\
>>> +			err = -ENOTSUPP;		\
>>> +			goto err_put;			\
>>> +		}					\
>>> +		err = fn(map, f.file, attr, uattr);	\
>>> +	} while (0)
>>> +
>> nit: probably not worth defining this for a single user? but not sure
>> it matters..
> Yeah, just the BPF_DO_BATCH could be used but extended via __VA_ARGS__.
Good idea. Will do in v3.
>
> Thanks,
> Daniel

