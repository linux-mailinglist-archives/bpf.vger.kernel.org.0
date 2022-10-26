Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC660E04D
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 14:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiJZMHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 08:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiJZMHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 08:07:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28488C895C;
        Wed, 26 Oct 2022 05:06:56 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My6sy3zJ4zJnG7;
        Wed, 26 Oct 2022 20:04:06 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 20:06:52 +0800
Message-ID: <1d5a490c-b3bd-a029-15b5-77b72e545b20@huawei.com>
Date:   Wed, 26 Oct 2022 20:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] bpf: Fix a typo in comment for DFS algorithm
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20221026025941.2621795-1-xukuohai@huaweicloud.com>
 <CAADnVQ+Pe73yjys+fjW1TBPscCmv6K9ur5bDPr2056ejwBBdZg@mail.gmail.com>
 <Y1jnVvcqVF8GanWZ@debian.me>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <Y1jnVvcqVF8GanWZ@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/2022 3:52 PM, Bagas Sanjaya wrote:
> On Tue, Oct 25, 2022 at 11:32:55PM -0700, Alexei Starovoitov wrote:
>> On Tue, Oct 25, 2022 at 7:42 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> There is a typo in comment for DFS algorithm in bpf/verifier.c. The top
>>> element should not be popped until all its neighbors have been checked.
>>> Fix it.
>>>
>>> Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>> ---
>>>   kernel/bpf/verifier.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index b83a8d420520..96ba5ea6d1a6 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -10662,7 +10662,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>>>    * 3      let S be a stack
>>>    * 4      S.push(v)
>>>    * 5      while S is not empty
>>> - * 6            t <- S.pop()
>>> + * 6            t <- S.top()
>>
>> Even with this fix the comment is not quite accurate.
>> I wonder whether we should keep it or delete it completely.
>> At least please use 'peek' instead of 'top'.
> 
> I think the comment should be in words (like other code comments in the
> kernel) instead.
> 

The beginning of the comment already says this is a piece of pseudo code. And
I don't think it's clearer to describe the algorithm in words than to describe
it in pseudo code.
