Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0675F6D41
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 19:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJFRy5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJFRyz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:54:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B5D286C0
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 10:54:54 -0700 (PDT)
Received: from Vivis-MacBook-Air.local (unknown [177.33.235.223])
        by linux.microsoft.com (Postfix) with ESMTPSA id AAA7F20E97B6;
        Thu,  6 Oct 2022 10:54:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAA7F20E97B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1665078893;
        bh=5EGcWs5AM23Ca1pbUEmbE6DNt/l2Rvf82QiFC9PMNiY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jZUYyWTw39yUhlwHrE/y8HPJBdb/hauTmauAa4V/YV0WtMa5avp457pO8q0QezLJe
         JXp2B9oWBKgkMUz1teXq6gq+YLlYq+enhUS9hpLio95fnOBoUfjMlaH2CGDyFXh5eG
         7Af2hlDSyOoQBVPkcPIK3eqvybtNpTRaenEwJ/pk=
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch>
 <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
 <CAEf4BzZxU+YD5CtHEk7S7bXTDMMSsnV3eFYgRXCMft=fx9reMA@mail.gmail.com>
 <CAHC9VhSqHFRpfq1b6Ys+Ygaqr-6KFeziUxtOVpsoBb=TE2csoA@mail.gmail.com>
 <CAEf4BzZnLFgzaPWeaH2h3dqxS4thEHQUv6FtZbpffxs6iGcWKw@mail.gmail.com>
 <658ad9b2-9ee6-39ac-782d-23a1d7be8aba@linux.microsoft.com>
 <CAEf4BzYJpCKDvzF3Oy0dW4NJpf6UVOc_W2Mw+_ERA_hJSPxk6A@mail.gmail.com>
From:   Anne Macedo <annemacedo@linux.microsoft.com>
Message-ID: <b6438ef1-7733-75a5-bd41-927dda059b4b@linux.microsoft.com>
Date:   Thu, 6 Oct 2022 14:54:47 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYJpCKDvzF3Oy0dW4NJpf6UVOc_W2Mw+_ERA_hJSPxk6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 06/10/22 14:07, Andrii Nakryiko wrote:
> On Thu, Oct 6, 2022 at 10:02 AM Anne Macedo
> <annemacedo@linux.microsoft.com> wrote:
>>
>>
>>
>> On 05/10/22 19:42, Andrii Nakryiko wrote:
>>> On Mon, Oct 3, 2022 at 2:26 PM Paul Moore <paul@paul-moore.com> wrote:
>>>>
>>>> On Fri, Sep 30, 2022 at 6:39 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>> On Fri, Sep 30, 2022 at 6:00 AM Anne Macedo
>>>>> <annemacedo@linux.microsoft.com> wrote:
>>>>>>
>>>>>> On 29/09/22 23:32, John Fastabend wrote:
>>>>>>> Anne Macedo wrote:
>>>>>>>> If BTF is corrupted, a SEGV may occur due to a null pointer dereference on
>>>>>>>> bpf_object__init_user_btf_map.
>>>>>>>>
>>>>>>>> This patch adds a validation that checks whether the DATASEC's variable
>>>>>>>> type ID is null. If so, it raises a warning.
>>>>>>>>
>>>>>>>> Reported by oss-fuzz project [1].
>>>>>>>>
>>>>>>>> A similar patch for the same issue exists on [2]. However, the code is
>>>>>>>> unreachable when using oss-fuzz data.
>>>>>>>>
>>>>>>>> [1] https://github.com/libbpf/libbpf/issues/484
>>>>>>>> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20211103173213.1376990-3-andrii@kernel.org/
>>>>>>>>
>>>>>>>> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
>>>>>>>> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
>>>>>>>> ---
>>>>>>>>     tools/lib/bpf/libbpf.c | 4 ++++
>>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>>>>>> index 184ce1684dcd..0c88612ab7c4 100644
>>>>>>>> --- a/tools/lib/bpf/libbpf.c
>>>>>>>> +++ b/tools/lib/bpf/libbpf.c
>>>>>>>> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
>>>>>>>>
>>>>>>>>        vi = btf_var_secinfos(sec) + var_idx;
>>>>>>>>        var = btf__type_by_id(obj->btf, vi->type);
>>>>>>>> +    if (!var || !btf_is_var(var)) {
>>>>>>>> +            pr_warn("map #%d: non-VAR type seen", var_idx);
>>>>>>>> +            return -EINVAL;
>>>>>>>> +    }
>>>>>>>>        var_extra = btf_var(var);
>>>>>>>>        map_name = btf__name_by_offset(obj->btf, var->name_off);
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.30.2
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I don't know abouut this. A quick scan looks like this type_by_id is
>>>>>>> used lots of places. And seems corrupted BTF could cause faults
>>>>>>> and confusiuon in other spots as well. I'm not sure its worth making
>>>>>>> libbpf survive corrupted BTF. OTOH this specific patch looks ok.
>>>>>>>
>>>>>>
>>>>>> I was planning on creating a function to validate BTF for these kinds of
>>>>>> corruptions, but decided to keep this patch simple. This could be a good
>>>>>> idea for some future work – moving all of the validations to
>>>>>> bpf_object__init_btf() or to a helper function.
>>>>>
>>>>> This whack-a-mole game of fixing up BTF checks to avoid one specific
>>>>> corruption case is too burdensome. There is plenty of BTF usage before
>>>>> the point which you are fixing, so with some other specific corruption
>>>>> to BTF you can trigger even sooner corruption.
>>>>>
>>>>> As I mentioned on Github. I'm not too worried about ossfuzz generating
>>>>> corrupted BTF because that's not a very realistic scenario. But it
>>>>> would be nice to add some reasonable validation logic for BTF in
>>>>> general, so let's better concentrate on that instead of adding these
>>>>> extra checks.
>>>>
>>>> Reading the comments here and on the associated GH issue, it sounds
>>>> like you would be supportive of this check so long as it was placed in
>>>> bpf_object__init_btf(), is that correct?  Or do you feel this
>>>> particular check falls outside the scope of "reasonable validation
>>>> logic"?  I'm trying to understand what the best next step would be for
>>>> this patch ...
>>>
>>> I think we should bite the bullet and do BTF validation in libbpf. It
>>> doesn't have to be as thorough as what kernel does, but validating
>>> general "structural integrity" of BTF as a first step would make all
>>> these one-off checks throughout entire libbpf source code unnecessary.
>>> I.e., we'll need to check things like: no out of range type IDs, no
>>> out-of-range string offsets, FUNC -> FUNC_PROTO references, DATASEC ->
>>> VAR | FUNC references, etc, etc. Probably make sure we don't have a
>>> loop of struct referencing to itself not through pointer, etc. It's a
>>> bit more upfront work, but it's will make the rest of the code simpler
>>> and will eliminate a bunch of those fuzzer crashes as well.
>>>
>>
>> Thanks for the feedback, I think that sounds like a good plan. I will
>> work on another patch and I wanted to summarize what I should do.
>>
>> So basically, I should place the BTF validation on
>> bpf_object__init_btf(), that should contain validations for:
>>
>> - out of range type IDs;
>> - out of range string offsets;
>> - FUNC -> FUNC_PROTO references;
>> - DATASEC -> VAR | FUNC references;
>> - structs referencing themselves;
>>
> 
> This is just specific things that I could recall immediately. Please
> look at what kernel is validating in kernel/bpf/btf.c. I don't think
> libbpf should be as strict as kernel (e.g., I would reject BTF because
> it has unexpected kflag and stuff like that), we should validate stuff
> that libbpf relies on, but not be overzealous overall (e.g., rejecting
> BTF because kflag is unexpectedly set might be an overkill for libbpf,
> while it makes sense for kernel to be stricter).
> 

Acked. Will start working on that.

>>>>
>>>> --
>>>> paul-moore.com
