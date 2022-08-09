Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CE58D1B4
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 03:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiHIBXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHIBXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 21:23:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3EC6B
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 18:23:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M1wKT5jm1zKK60
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 09:22:21 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgDXwb0ct_Fi5BNuAA--.10017S2;
        Tue, 09 Aug 2022 09:23:43 +0800 (CST)
Subject: Re: [PATCH bpf 7/9] selftests/bpf: Add tests for reading a dangling
 map iter fd
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
        Lorenz Bauer <oss@lmb.io>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-8-houtao@huaweicloud.com>
 <32e803c8-4042-2d01-0249-b6358c0fb627@fb.com>
From:   houtao <houtao@huaweicloud.com>
Message-ID: <695edb91-dabf-2bff-9cba-12eb64162b1e@huaweicloud.com>
Date:   Tue, 9 Aug 2022 09:23:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <32e803c8-4042-2d01-0249-b6358c0fb627@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgDXwb0ct_Fi5BNuAA--.10017S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxZry3tFWrtry5Aw1kZrb_yoW5JF4DpF
        1kJFWUCry8Ars3Ar1DJa15CFyYyFy8J3WDJF1rXFy5AF4DurnYgr17WFs0gF1rGrW0yr12
        vr1jv393uFyDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/8/2022 11:15 PM, Yonghong Song wrote:
>
>
> On 8/6/22 12:40 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> After closing both related link fd and map fd, reading the map
>> iterator fd to ensure it is OK to do so.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   .../selftests/bpf/prog_tests/bpf_iter.c       | 90 +++++++++++++++++++
>>   1 file changed, 90 insertions(+)
SNIP
>> +    /* Close link and map fd prematurely */
>> +    bpf_link__destroy(link);
>> +    bpf_object__destroy_skeleton(*skel);
>> +    *skel = NULL;
>> +
>> +    /* Let kworker to run first */
>
> Which kworker?
Now bpf map is freed through bpf_map_free_deferred() and it is running in the
kworker context. Will be more specific in v2.
>
>> +    usleep(100);
>> +    /* Sock map is freed after two synchronize_rcu() calls, so wait */
>> +    kern_sync_rcu();
>> +    kern_sync_rcu();
>
> In btf_map_in_map.c, the comment mentions two kern_sync_rcu()
> is needed for 5.8 and earlier kernel. Other cases in prog_tests/
> directory only has one kern_sync_rcu(). Why we need two
> kern_sync_rcu() for the current kernel?
As tried to explain in the comment,  for both sock map and sock storage map, the
used memory is freed two synchronize_rcu(), so if there are not two
kern_sync_rcu() in the test prog, reading the iterator fd will not be able to
trigger the Use-After-Free problem and it will end normally.
>
>> +
>> +    /* Read after both map fd and link fd are closed */
>> +    while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
>> +        ;
>> +    ASSERT_GE(len, 0, "read_iterator");
>> +
>> +    close(iter_fd);
>> +}
>> +
>>   static int read_fd_into_buffer(int fd, char *buf, int size)
>>   {
>>       int bufleft = size;
>> @@ -827,6 +870,20 @@ static void test_bpf_array_map(void)
>>       bpf_iter_bpf_array_map__destroy(skel);
>>   }
>>   +static void test_bpf_array_map_iter_fd(void)
>> +{
>> +    struct bpf_iter_bpf_array_map *skel;
>> +
>> +    skel = bpf_iter_bpf_array_map__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open_and_load"))
>> +        return;
>> +
>> +    do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_array_map,
>> +                skel->maps.arraymap1);
>> +
>> +    bpf_iter_bpf_array_map__destroy(skel);
>> +}
>> +
> [...]

