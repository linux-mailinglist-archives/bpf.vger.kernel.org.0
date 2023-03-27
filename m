Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106346C999F
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 04:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjC0Cjn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0Cjm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 22:39:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5E44AD
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 19:39:40 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PlH7z5BK1zKxnw;
        Mon, 27 Mar 2023 10:39:11 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 10:39:38 +0800
Message-ID: <3a57911f-101f-d6aa-2d69-29a877a47830@huawei.com>
Date:   Mon, 27 Mar 2023 10:39:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check when bounds are not
 in the 32-bit range
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20230322213056.2470-1-daniel@iogearbox.net>
 <20230322213056.2470-2-daniel@iogearbox.net>
 <CAADnVQJQ_Kptpa5w=E+Z_PKo7jOxQv+bm6oTDF0cdQ0+avHWcA@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAADnVQJQ_Kptpa5w=E+Z_PKo7jOxQv+bm6oTDF0cdQ0+avHWcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/26/2023 9:10 AM, Alexei Starovoitov wrote:
> On Wed, Mar 22, 2023 at 2:38 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add cases to check if bound is updated correctly when 64-bit value is
>> not in the 32-bit range.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/verifier/bounds.c | 121 ++++++++++++++++++
>>   1 file changed, 121 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
>> index 33125d5f6772..74b1917d4208 100644
>> --- a/tools/testing/selftests/bpf/verifier/bounds.c
>> +++ b/tools/testing/selftests/bpf/verifier/bounds.c
> ...
>> +       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
>> +       BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
>> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
>> +
>> +       BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
>> +       BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
>> +       /* r1 signed range is [S64_MIN, S64_MAX] */
>> +       BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
> ...
>> +       BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
>> +       BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
>> +       /* r1 signed range is [S32_MIN, S32_MAX] */
>> +       BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
>> +
>> +       BPF_MOV64_IMM(BPF_REG_0, 0),
>> +       BPF_EXIT_INSN(),
>> +       },
>> +       .errstr = "BPF program is too large",
> 
> These infinite loops take a very long time to execute.
> The test_verifier got a lot slower because of these tests.
> These infinite loops don't add much value to the actual test.
> Please rewrite them without infinite loops.
> .

Sorry for that. I've sent a patch to remove these two cases.
