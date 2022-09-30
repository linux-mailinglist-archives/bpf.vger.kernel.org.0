Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA25F0C1A
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiI3NA1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI3NAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 09:00:25 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B59A32EE9
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 06:00:21 -0700 (PDT)
Received: from Vivis-MacBook-Air.local (unknown [177.33.235.223])
        by linux.microsoft.com (Postfix) with ESMTPSA id 85CF220E0BE5;
        Fri, 30 Sep 2022 06:00:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85CF220E0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664542820;
        bh=zhDzvT80xqqr2nN+8B0WPKYRnr+HgzAcX3LVtY0Zx58=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NhFelTjtml9+xRJ+h4Gr1iPDydbq3DqrMVCHov8VVuaB534e7556stiP/2oTpA0Ok
         +nrEc0XOI5H9vGxAihZA5Ne3gvzaRgD9UwjyFsMFWng7Q9NGzFyC7IobbNnsO0gsNS
         8rM2cPHRj3S2APbRwO9ayeiwGpxEwMgSmW6AteLQ=
Subject: Re: [PATCH] libbpf: add validation to BTF's variable type ID
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Paul Moore <paul@paul-moore.com>
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
 <63365532d416f_233df20899@john.notmuch>
From:   Anne Macedo <annemacedo@linux.microsoft.com>
Message-ID: <92157e05-e383-ed4b-8b01-2981dbf5afd3@linux.microsoft.com>
Date:   Fri, 30 Sep 2022 10:00:14 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <63365532d416f_233df20899@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29/09/22 23:32, John Fastabend wrote:
> Anne Macedo wrote:
>> If BTF is corrupted, a SEGV may occur due to a null pointer dereference on
>> bpf_object__init_user_btf_map.
>>
>> This patch adds a validation that checks whether the DATASEC's variable
>> type ID is null. If so, it raises a warning.
>>
>> Reported by oss-fuzz project [1].
>>
>> A similar patch for the same issue exists on [2]. However, the code is
>> unreachable when using oss-fuzz data.
>>
>> [1] https://github.com/libbpf/libbpf/issues/484
>> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20211103173213.1376990-3-andrii@kernel.org/
>>
>> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
>> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 184ce1684dcd..0c88612ab7c4 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
>>   
>>   	vi = btf_var_secinfos(sec) + var_idx;
>>   	var = btf__type_by_id(obj->btf, vi->type);
>> +	if (!var || !btf_is_var(var)) {
>> +		pr_warn("map #%d: non-VAR type seen", var_idx);
>> +		return -EINVAL;
>> +	}
>>   	var_extra = btf_var(var);
>>   	map_name = btf__name_by_offset(obj->btf, var->name_off);
>>   
>> -- 
>> 2.30.2
>>
> 
> 
> I don't know abouut this. A quick scan looks like this type_by_id is
> used lots of places. And seems corrupted BTF could cause faults
> and confusiuon in other spots as well. I'm not sure its worth making
> libbpf survive corrupted BTF. OTOH this specific patch looks ok.
> 

I was planning on creating a function to validate BTF for these kinds of 
corruptions, but decided to keep this patch simple. This could be a good 
idea for some future work – moving all of the validations to 
bpf_object__init_btf() or to a helper function.

> How did it get corrupted in the first place? Curious to see if
> others want to harden libbpf like this.
> 

There's a test case by oss-fuzz [1] that generated this corrupted BTF. 
There's also some C code for replicating this bug [2] using the oss-fuzz 
data.

On a side note, fixing this bug would help oss-fuzz find other, more 
relevant, bugs.

Found the original oss-fuzz report at [3].

[1] https://oss-fuzz.com/download?testcase_id=5041748798210048
[2] https://github.com/libbpf/libbpf/issues/484#issuecomment-1250020929
[3] https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=42345
