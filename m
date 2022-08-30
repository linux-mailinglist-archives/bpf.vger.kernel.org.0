Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE11E5A58F6
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3BsG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH3BsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:48:05 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE197C778
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:48:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MGqsW1Qtlz6R4NM
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:46:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBn7C9ObA1jIM9xAA--.15608S2;
        Tue, 30 Aug 2022 09:48:02 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test cases for htab
 update
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hao Sun <sunhao.th@gmail.com>, Hao Luo <haoluo@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220829023709.1958204-1-houtao@huaweicloud.com>
 <20220829023709.1958204-4-houtao@huaweicloud.com>
 <0d87fd92-3654-6185-e50e-664c1e35c7b2@iogearbox.net>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <a7ac4849-e763-12ec-d8de-58b4ff9e3ce0@huaweicloud.com>
Date:   Tue, 30 Aug 2022 09:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0d87fd92-3654-6185-e50e-664c1e35c7b2@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBn7C9ObA1jIM9xAA--.15608S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw47WF4fKFyrZry3XFyrJFb_yoW8Jr15pr
        WkCF97KryUK3Z7ZwnxKr1q9FWjvrs5Kr1jvrs5tr1UAr4q9r40gw4SqayFgr4fJrs3Jw1a
        yrWUXayUZ3WkZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
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

On 8/29/2022 11:51 PM, Daniel Borkmann wrote:
> On 8/29/22 4:37 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> One test demonstrates the reentrancy of hash map update on the same
>> bucket should fail, and another one shows concureently updates of
>> the same hash map bucket should succeed and not fail due to
>> the reentrancy checking for bucket lock.
SNIP
> The test fails the CI on s390x, link:
>
> https://github.com/kernel-patches/bpf/runs/8062792183?check_suite_focus=true
>
>   All error logs:
>   test_reenter_update:PASS:htab_update__open 0 nsec
>   test_reenter_update:PASS:htab_update__load 0 nsec
>   libbpf: prog 'lookup_elem_raw': failed to attach: ERROR: strerror_r(-524)=22
>   libbpf: prog 'lookup_elem_raw': failed to auto-attach: -524
>   test_reenter_update:FAIL:htab_update__attach unexpected error: -524 (errno 524)
>   #83/1    htab_update/reenter_update:FAIL
>   #83      htab_update:FAIL
>   Summary: 189/973 PASSED, 27 SKIPPED, 1 FAILED
>
> You'd have to add this to the s390 denylist, see also
> tools/testing/selftests/bpf/DENYLIST.s390x .
> .
Should I post it in a single patch, or send v4 to include it ?



