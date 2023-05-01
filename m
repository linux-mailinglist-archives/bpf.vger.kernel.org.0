Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFC6F3676
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjEATEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjEATEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:04:46 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [IPv6:2001:41d0:203:375::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0671708
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:04:43 -0700 (PDT)
Message-ID: <57221edc-a4b4-8125-86b5-a3cbbe5d36fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682967882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LajlkcF00gnT/PyrnGVyPCE6wTn+TxTarIPA3YXAtjU=;
        b=mZasrA19vpzKhO844RpIuTZIsS6ocuz1oeingoaqPRPTQ9qp83xpKDEpY6upUI1vloeU6x
        nlgX7DxRsH9AVUjHttDHxx48EhJZBQ9PfyAUYSrlK+t6HGZhqCzTrtoaO+BK+sEurfgo/U
        1S7gEoSFcCM7Cl694peam3WaiEWTn00=
Date:   Mon, 1 May 2023 12:04:37 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Update EFAULT
 {g,s}etsockopt selftests
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20230427200409.1785263-1-sdf@google.com>
 <20230427200409.1785263-3-sdf@google.com>
 <ac7c31cc-7f8f-1066-1aa1-ad4d734998c5@linux.dev>
 <CAKH8qBu=ehBZsusAaVwxO1DNK=NxFupR8RwtotsPSZmdiTw=Zw@mail.gmail.com>
 <CAKH8qBt-+GDxcfoQP6rmodQzRbZ-Lz11wUpVmP98zDm4qxJKAw@mail.gmail.com>
 <b87d7403-a64e-3678-19a0-1b0072ee4198@linux.dev>
 <CAKH8qBs2wB95dMr=1rEu-cgOBWrY+wmD5mC_R=gaVOLX18HVgQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBs2wB95dMr=1rEu-cgOBWrY+wmD5mC_R=gaVOLX18HVgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/23 10:22 AM, Stanislav Fomichev wrote:
> On Fri, Apr 28, 2023 at 5:44 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/28/23 5:32 PM, Stanislav Fomichev wrote:
>>> On Fri, Apr 28, 2023 at 4:59 PM Stanislav Fomichev <sdf@google.com> wrote:
>>>>
>>>> On Fri, Apr 28, 2023 at 4:57 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>
>>>>> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
>>>>>> Instead of assuming EFAULT, let's assume the BPF program's
>>>>>> output is ignored.
>>>>>>
>>>>>> Remove "getsockopt: deny arbitrary ctx->retval" because it
>>>>>> was actually testing optlen. We have separate set of tests
>>>>>> for retval.
>>>>>>
>>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>>>> ---
>>>>>>     .../selftests/bpf/prog_tests/sockopt.c        | 80 +++++++++++++++++--
>>>>>>     1 file changed, 74 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
>>>>>> index aa4debf62fc6..8dad30ce910e 100644
>>>>>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
>>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
>>>>>> @@ -273,10 +273,30 @@ static struct sockopt_test {
>>>>>>                 .error = EFAULT_GETSOCKOPT,
>>>>>>         },
>>>>>>         {
>>>>>> -             .descr = "getsockopt: deny arbitrary ctx->retval",
>>>>>> +             .descr = "getsockopt: ignore >PAGE_SIZE optlen",
>>>>>>                 .insns = {
>>>>>> -                     /* ctx->retval = 123 */
>>>>>> -                     BPF_MOV64_IMM(BPF_REG_0, 123),
>>>>>> +                     /* write 0xFF to the first optval byte */
>>>>>> +
>>>>>> +                     /* r6 = ctx->optval */
>>>>>> +                     BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
>>>>>> +                                 offsetof(struct bpf_sockopt, optval)),
>>>>>> +                     /* r2 = ctx->optval */
>>>>>> +                     BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
>>>>>> +                     /* r6 = ctx->optval + 1 */
>>>>>> +                     BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
>>>>>> +
>>>>>> +                     /* r7 = ctx->optval_end */
>>>>>> +                     BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
>>>>>> +                                 offsetof(struct bpf_sockopt, optval_end)),
>>>>>> +
>>>>>> +                     /* if (ctx->optval + 1 <= ctx->optval_end) { */
>>>>>> +                     BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
>>>>>> +                     /* ctx->optval[0] = 0xF0 */
>>>>>> +                     BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
>>>>>> +                     /* } */
>>>>>> +
>>>>>> +                     /* ctx->retval = 0 */
>>>>>> +                     BPF_MOV64_IMM(BPF_REG_0, 0),
>>>>>>                         BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
>>>>>>                                     offsetof(struct bpf_sockopt, retval)),
>>>>>>
>>>>>> @@ -287,9 +307,10 @@ static struct sockopt_test {
>>>>>>                 .attach_type = BPF_CGROUP_GETSOCKOPT,
>>>>>>                 .expected_attach_type = BPF_CGROUP_GETSOCKOPT,
>>>>>>
>>>>>> -             .get_optlen = 64,
>>>>>> -
>>>>>> -             .error = EFAULT_GETSOCKOPT,
>>>>>> +             .get_level = 1234,
>>>>>> +             .get_optname = 5678,
>>>>>> +             .get_optval = {}, /* the changes are ignored */
>>>>>> +             .get_optlen = 4096 + 1,
>>>>>
>>>>> The patchset looks good. Thanks for taking care of it.
>>>>>
>>>>> One question, is it safe to the assume 4096 page size for all platforms in the
>>>>> selftests?
>>>>
>>>> Good question; let me respin with sysconf() just to be safe..
>>>
>>> Argh, the compiler yells at me:
>>> error: initializer element is not a compile-time constant
>>>
>>> I guess I'm just gonna do #define PAGE_SIZE 4096 and if we do hit some
>>> problems on the other archs, I'll ifdef it in one place.
>>
>> or run_test() can reinit optlen to sysconf_page_size + 1 if optlen == 4097.
> 
> Maybe I can do something like the following?
> 
>                 if (test->set_optlen >= PAGE_SIZE) {
>                         int num_pages = test->set_optlen / PAGE_SIZE;
>                         int remainder = test->set_optlen % PAGE_SIZE;
> 
>                         test->set_optlen = num_pages *
> sysconf(_SC_PAGESIZE) + remainder;
>                 }
> 
> More verbose, but less magical than depending on 4097. 

LGTM.

> For the BPF side, I can probably pass proper value via bss..

Make sense also.

