Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDDF498499
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 17:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiAXQXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiAXQXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 11:23:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0269DC06173D
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:23:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n8so23272411wmk.3
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zpmry2Sn0pHKp5bvBrVArUvwBO1BvlxkYl5rECTpXBc=;
        b=QRwA9DFQVUwc5AA6rzP20hY+Pb3ml4WCKC+4qz6iHppHxwQhqMFg6Z+p4E6gFdHxQd
         nEMoYDhYowRfW4WtGiHXchV43vCo1IWba3YI9dpz98qRhceNnoPGkCB1WDKQaq79rqiN
         fVD2yRz8wKYpuy/MhDDSM/eqO2KMx5m3jbwg1BYbwGAcopxkzLPnQVC84zbxpVbtT69/
         PcE9FYTd4qkflu1yWFxH6uCvYiq9YdG+we1I99HMwV/UJWI2RYIPXfExBa5NNWPtdhec
         USLkjm2piLQFUev4ri6gxQU12FYU6nH0cv+JR9n/6eDX3bi8dyUFJ5iqZs40LBB7YWC/
         +K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zpmry2Sn0pHKp5bvBrVArUvwBO1BvlxkYl5rECTpXBc=;
        b=pUv1TsqhOSiIdqSd96ElFJaktIhX952Tgoigh/2pUNJQFW0CXHfnSpluOkknHv7G0o
         XTx5sncaV5iGrMVPJxBpCDUNwKwXkBz+z+wfqMkhrKMDd+P8VVWhbdO4oGpeTdUCQSVO
         IFSx3wwThK+bWJn0UUlWoouscoFJWaFQw5nljENffkWpR4UbPWrUKxxUAx3u5WNBZri9
         ejYWK9Atyi3ifEIcz6riw9YSiHB6yEgwROskTdoLgwnpoeaGvDJwUMypjyvSCRM0XkbR
         4i62h1DLFtUu8P0lGCQ3xbRh5ejj9Zn9g+/SIBkNAmrOBBI+OjhtPvaHie2q/KYhwsCz
         s3Gw==
X-Gm-Message-State: AOAM532vHvIVhwh4SiaSCGiqaKWfBgn8h4Ct9yleuR7dcu46QRKyYbBo
        PbFY2VqEztQVIzm9tAP5T6ZXKA==
X-Google-Smtp-Source: ABdhPJwpOktfGkwExRQuwY49UqrbBNyMU0HJhDqJg1yXj4Hr+F9USER9YMdojbbx609yh/LftCU+9g==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr2434678wmb.73.1643041396565;
        Mon, 24 Jan 2022 08:23:16 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:ea1c:13a:34a2:3324? ([2a02:6b6d:f804:0:ea1c:13a:34a2:3324])
        by smtp.gmail.com with ESMTPSA id k16sm14363597wrc.35.2022.01.24.08.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 08:23:16 -0800 (PST)
Subject: Re: [RFC bpf-next 2/3] bpf: add support for module helpers in
 verifier
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121193956.198120-3-usama.arif@bytedance.com>
 <20220122033133.ph4wrxcorl5uvspy@thp> <20220122035642.7cax2eoz5xqaycq3@thp>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <b59c9e42-1246-c305-7033-f029c216dab6@bytedance.com>
Date:   Mon, 24 Jan 2022 16:23:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220122035642.7cax2eoz5xqaycq3@thp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 22/01/2022 03:56, Kumar Kartikeya Dwivedi wrote:
> On Sat, Jan 22, 2022 at 09:01:33AM IST, Kumar Kartikeya Dwivedi wrote:
>> On Sat, Jan 22, 2022 at 01:09:55AM IST, Usama Arif wrote:
>>> After the kernel module registers the helper, its BTF id
>>> and func_proto are available during verification. During
>>> verification, it is checked to see if insn->imm is available
>>> in the list of module helper btf ids. If it is,
>>> check_helper_call is called, otherwise check_kfunc_call.
>>> The module helper function proto is obtained in check_helper_call
>>> via get_mod_helper_proto function.
>>>
>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>> ---
>>>   kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++----------
>>>   1 file changed, 39 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 8c5a46d41f28..bf7605664b95 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -6532,19 +6532,39 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>>   	int insn_idx = *insn_idx_p;
>>>   	bool changes_data;
>>>   	int i, err, func_id;
>>> +	const struct btf_type *func;
>>> +	const char *func_name;
>>> +	struct btf *desc_btf;
>>>
>>>   	/* find function prototype */
>>>   	func_id = insn->imm;
>>> -	if (func_id < 0 || func_id >= __BPF_FUNC_MAX_ID) {
>>> -		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
>>> -			func_id);
>>> -		return -EINVAL;
>>> -	}
>>>
>>>   	if (env->ops->get_func_proto)
>>>   		fn = env->ops->get_func_proto(func_id, env->prog);
>>> -	if (!fn) {
>>> -		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
>>> +
>>> +	if (func_id >= __BPF_FUNC_MAX_ID) {
>>> +		desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
>>
>> I am not sure this is right, even if we reached this point. add_kfunc_call would
>> not be called for a helper call, which means the kfunc_btf_tab will not be
>> populated. I think this code is not reachable from your test, which is why you
>> didn't see this. More below.
>>
>>> +		if (IS_ERR(desc_btf))
>>> +			return PTR_ERR(desc_btf);
>>> +
>>> +		fn = get_mod_helper_proto(desc_btf, func_id);
>>> +		if (!fn) {
>>> +			func = btf_type_by_id(desc_btf, func_id);
>>> +			func_name = btf_name_by_offset(desc_btf, func->name_off);
>>> +			verbose(env, "unknown module helper func %s#%d\n", func_name,
>>> +				func_id);
>>> +			return -EACCES;
>>> +		}
>>> +	} else if (func_id >= 0) {
>>> +		if (env->ops->get_func_proto)
>>> +			fn = env->ops->get_func_proto(func_id, env->prog);
>>> +		if (!fn) {
>>> +			verbose(env, "unknown in-kernel helper func %s#%d\n", func_id_name(func_id),
>>> +				func_id);
>>> +			return -EINVAL;
>>> +		}
>>> +	} else {
>>> +		verbose(env, "invalid func %s#%d\n", func_id_name(func_id),
>>>   			func_id);
>>>   		return -EINVAL;
>>>   	}
>>> @@ -11351,6 +11371,7 @@ static int do_check(struct bpf_verifier_env *env)
>>>   	int insn_cnt = env->prog->len;
>>>   	bool do_print_state = false;
>>>   	int prev_insn_idx = -1;
>>> +	struct btf *desc_btf;
>>>
>>>   	for (;;) {
>>>   		struct bpf_insn *insn;
>>> @@ -11579,10 +11600,17 @@ static int do_check(struct bpf_verifier_env *env)
>>>   				}
>>>   				if (insn->src_reg == BPF_PSEUDO_CALL)
>>>   					err = check_func_call(env, insn, &env->insn_idx);
>>> -				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
>>> -					err = check_kfunc_call(env, insn, &env->insn_idx);
>>> -				else
>>> -					err = check_helper_call(env, insn, &env->insn_idx);
>>> +				else {
>>> +					desc_btf = find_kfunc_desc_btf(env, insn->imm, insn->off);
>>> +					if (IS_ERR(desc_btf))
>>> +						return PTR_ERR(desc_btf);
>>> +
>>
>> I didn't get this part at all.
>>
>> At this point src_reg can be BPF_PSEUDO_KFUNC_CALL, or 0 (for helper call). If
>> it is a helper call, then find_kfunc_desc_btf using insn->imm and insn->off
>> would be a bug.
>>
>>> +					if (insn->src_reg == BPF_K ||
>>
>> [...]
>>
> 
> Ah, I think I see what you are doing: BPF_K is zero, so either when it is a
> helper call or it is a module helper (which will be a kfunc), you call
> check_helper_call. get_mod_helper_proto would return true in that case.
> 
> But if it is an in-kernel helper, calling find_kfunc_desc_btf would still be a
> bug, since imm encodes func_id.
> 
> It's also a bit confusing that check_helper_call is called for a kfunc.
> 

Hi, Thanks for the reviews!

The patchset does require refractoring in relation to kfunc to make it 
mergable as mentioned in cover letter, but it is a working prototype for 
all situations in-kernel/module helper/kfunc.

There are 3 situations:
- if its an in-kernel helper call, insn->src_reg is BPF_K and 
check_helper_call will be called. get_mod_helper_proto will return NULL 
in this case but that doesnt matter as its an OR statement.
- if its a "module helper call" (essentially a kfunc with 
bpf_func_proto) and it has been registered, get_mod_helper_proto will 
return the function proto and check_helper_call will be called. 
insn->src_reg will be BPF_PSEUDO_KFUNC_CALL (requires refractoring) but 
that wont matter as its an OR statement.
- if its a kfunc call, insn->src_reg is BPF_PSEUDO_KFUNC_CALL and 
get_mod_helper_proto will return NULL, so check_kfunc_call will be called.

So all the cases will be covered. I didnt include the refractor as its 
quite big and just wanted to check if something like this will be 
considered by the bpf community before progressing further.

>>> +					   get_mod_helper_proto(desc_btf, insn->imm))
>>> +						err = check_helper_call(env, insn, &env->insn_idx);
>>> +					else
>>> +						err = check_kfunc_call(env, insn, &env->insn_idx);
>>> +				}
>>>   				if (err)
>>>   					return err;
>>>   			} else if (opcode == BPF_JA) {
>>> --
>>> 2.25.1
>>>
