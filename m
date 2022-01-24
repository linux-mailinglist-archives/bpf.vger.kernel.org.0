Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0394984EA
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiAXQdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 11:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiAXQdz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 11:33:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E49C06173B
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:33:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u15so14647466wrt.3
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2UMvWn3XfzranFcJtVPI7E35B/OA2iET/jqM2N/ax90=;
        b=a8e7a0VwheonetM8stbw0qghTQFrS2pDMZqALenT5Dne6jNgkSx2GfI13B63rzLh7L
         /XB+AYAWoTQLqMgYWRbmcqGhu2v/ZjBT1DXR92p6V0E7QeSOtwlWPeiBlSzFfPBQZzep
         AIe8L+MK0takgmLYkF9/Y2WYnBJdlivud99q8OS8hEBpinUwDf7znoTP/EjLbxfs7xeK
         buA/hrAvpqzzxbIqQq0Bx9CLiExyLq5LmYqDZAK8ZlnCR6hhDC1qENtyYgD+Mrx4+4g0
         HE6ZeGyBbKyaMgYw01MHAoduVO6/8bbFKKul7qgP0lGrEPBSGF1VaOPdxUNhPDmMLcBg
         7z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2UMvWn3XfzranFcJtVPI7E35B/OA2iET/jqM2N/ax90=;
        b=hOzMii9Vzm/UG4K9VxYr77b2whJrWBewanPLoQbAqHk2UFrCd+2YYuHZviTSlnJV83
         s7xcNegjUzSAHOhU6+iIsDQLzum08b2nQZcKL7ZHinu3VdpaqOXK/Eru+mSKIJqYorJc
         kJPDIp6nZcik8hOZnxm5eQf1mZRsDKjRsavTOzI3P26VVDK7bcxZuLbz+ceksAJoQijx
         FTRqOii5GzgVs2QqO/txwoP/pKRrCDghRldvUTjSYSgL0ddpA+CfhgD2uKdOZPfubsZU
         geSO8YikSyVX2+5/S729jQXHp4DZEmcTEzcIaXxdwTS2NPlZCpuaCX58ch4N+VYoqb3t
         P3Qw==
X-Gm-Message-State: AOAM5339V7ZLm3lQEIhGA9PxfAtgB479aX2o9aeMZIKYyrn4HZLHTHau
        wXgqn0P0ICYfrCv4ZKlDTUYv9Q==
X-Google-Smtp-Source: ABdhPJzLOjKaBkNTQZZYrWjJzb8PUZXjK6qo6mKdXJLDFW6beNWpNY3H/OVEiYfY6MPC5+SMZB9oXA==
X-Received: by 2002:adf:9dc7:: with SMTP id q7mr14802951wre.148.1643042033300;
        Mon, 24 Jan 2022 08:33:53 -0800 (PST)
Received: from ?IPv6:2a02:6b6d:f804:0:ea1c:13a:34a2:3324? ([2a02:6b6d:f804:0:ea1c:13a:34a2:3324])
        by smtp.gmail.com with ESMTPSA id n10sm14392919wmr.25.2022.01.24.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 08:33:53 -0800 (PST)
Subject: Re: [External] Re: [RFC bpf-next 0/3] bpf: Introduce module helper
 functions
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
References: <20220121193956.198120-1-usama.arif@bytedance.com>
 <20220121224813.6necsmszanxg5p5e@ast-mbp.dhcp.thefacebook.com>
 <20220122040407.p5qbax5qtuywvyf3@thp>
From:   Usama Arif <usama.arif@bytedance.com>
Message-ID: <45114508-bca3-b165-dbab-37d7b83d3c8b@bytedance.com>
Date:   Mon, 24 Jan 2022 16:33:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220122040407.p5qbax5qtuywvyf3@thp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 22/01/2022 04:04, Kumar Kartikeya Dwivedi wrote:
> On Sat, Jan 22, 2022 at 04:18:13AM IST, Alexei Starovoitov wrote:
>> On Fri, Jan 21, 2022 at 07:39:53PM +0000, Usama Arif wrote:
>>> This patchset is a working prototype that adds support for calling helper
>>> functions in eBPF applications that have been defined in a kernel module.
>>>
>>> It would require further work including code refractoring (not included in
>>> the patchset) to rename functions, data structures and variables that are
>>> used for kfunc as well to be appropriately renamed for module helper usage.
>>> If the idea of module helper functions and the approach used in this patchset
>>> is acceptable to the bpf community, I can send a follow up patchset with the
>>> code refractoring included to make it ready for review.
>>>
>>> Module helpers are useful as:
>>> - They support more argument and return types when compared to module
>>> kfunc.
>>
>> What exactly is missing?
>>
> 
> I looked at the set. I think the only difference between existing support and
> this series is that you are using bpf_func_proto for argument checks, right? Is
> there anything else it is adding?
> 
> We discussed whether to use bpf_func_proto for kfunc in [0], the conclusion was
> that BTF has enough info that we don't have to use it. The only thing missing
> is making the verifier assume type of argument from kernel BTF rather than
> passed in argument register.
> 
> e.g. same argument can currently work with PTR_TO_BTF_ID and PTR_TO_MEM. On
> Alexei's suggestion, we disabled the bad cases by limiting PTR_TO_MEM support
> to struct with scalars. For current usecase that works fine.
> 
> I think once BTF tags are supported, we will be able to tag the function
> argument as __arg_mem or __arg_btf_id and make the verifier more strict.
> Same can be done for the return value (instead of ret_null_set as it is now).
> 
>    [0]: https://lore.kernel.org/bpf/20211105204908.4cqxk2nbkas6bduw@ast-mbp.dhcp.thefacebook.com/
>

Hi,

Thanks for the replies and the reviews!

Yes, as Kumar said, using bpf_func_proto for argument checking and 
return register setting. In check_helper_call, the argument registers 
are checked (for e.g. at 
https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L5324) 
and return registers are setup (for e.g. at 
https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L6551) 
according to the arg_type and ret_type in bpf_func_proto. But i don't 
see the checks and setups done in check_kfunc_call for *all* 
bpf_return_type and bpf_reg_type.

I do see now that PTR_TO_BTF_ID ret_type was added to kfunc last week, 
but in addition to Kumars answer I think there are also more types that 
might not be handled.
For e.g. the return register types for RET_PTR_TO_SOCKET vs 
RET_PTR_TO_TCP_SOCK are set to different values depending on ret_type in 
bpf_func_proto. Similarly in check_func_arg called by check_helper_call 
only, the checks are different whether its ARG_PTR_TO_MAP_VALUE or 
ARG_PTR_TO_UNINIT_MAP_VALUE or other argument type. These aren't done in 
check_kfunc_call as there is no bpf_func_proto to distinguish between 
them. But maybe i am missing something over here?

I guess the other way to support the additional types above is as Kumar 
said by using BTF tags (I guess they they are being worked on as I didnt 
see any mention of it in code?) with kfunc. But wouldn't it be better to 
have consistency between the kfunc and helper functions in how different 
arguments and return types are handled? Dealing with many btf tags which 
will give same information about argument and return types as 
bpf_func_proto will likely just result in repeated code in 
check_helper_call and check_kfunc_call and further code to handle the tags?


>>> - This adds a way to have helper functions that would be too specialized
>>> for a specific usecase to merge upstream, but are functions that can have
>>> a constant API and can be maintained in-kernel modules.
>>
>> Could you give an example of something that would be "too specialized" that
>> it's worth maintaining in a module, but not worth maintaining in the kernel?
>>
>> Also see:
>> https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html#q-new-functionality-via-kernel-modules
>>
>> Why do you think we made that rule years ago?

I guess the rule was made (I might be missing something over here!) as 
by moving functionality to kernel modules it will determine whether the 
eBPF application will work or not depending on the module, which makes 
the application less compatible across different systems, which is 
definitely not good. But i believe the above point does not remain since 
module kfuncs were introduced. I think that helpers on a very high level 
are similar to kfuncs with function protos for argument and return 
checking (ignoring implementation details of using helper id in 
bpf_helper_defs.h vs using ksysm section with BTF id in kfunc). So i 
think module helpers have the same affect from a compatibility 
perspective when compared to module kfunc, with the advantages of having 
bpf_func_proto.


Thanks again for the replies! I guess only worth addressing the comments 
and sending further patchsets with refractor for kfunc, if the idea is 
acceptable to the community and maintainers.

Thanks,
Usama
