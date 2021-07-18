Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039C3CC8BC
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhGRLUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhGRLUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Jul 2021 07:20:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A841C061762
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 04:17:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m83so13604582pfd.0
        for <bpf@vger.kernel.org>; Sun, 18 Jul 2021 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5gJprJS9tz1N1WNSkZShrZesDlian+uuw7WJnpw4Mg=;
        b=Dh87DzrRw6bIYBSazf1PYEQuEG631uTuj5z5T1vQ1pBPyZ+7DIxCNTs+l3TtSjdz9e
         spCsIshxgoRQKx/V3qG/QSf2FZFesaswZIGUSd1fH4NCqBeLXV6paa/TB5H2Jyr1C0yA
         p0ZaK60uo9ocvvgsY/31x/QuSTrxv5cJrg5SKn53cd2N6LKkEVQxprak/kXYaXiVeYW2
         puYmekzZveB6Ks0hIP0JgQocbtyiT1/KpN9vAxkLF7SeJzitpBth+2gaG4ZSltjcxeuy
         5GzbAw4PrZcHEMBbnTkLQhAgiZdXZuZ73xa43sL3iC4qgw6vlEhWHoSnvSZkYtpQx0FS
         yckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5gJprJS9tz1N1WNSkZShrZesDlian+uuw7WJnpw4Mg=;
        b=N3tmA2nhZZ81vJMKdrOr++mX83CTbGbYl9D99b0QjCtd6eKOtWvIgv5yB3nuMgA0c6
         PN+tyPA2/3q8PRdEDRdjj7ekhavxrFrZFqVu1TM6HP8S7CGFA0gbcdXnV07fe5AewCfI
         DYJNOlgcSFihLzD5zHOT4pC0+EcW8e+sebj7riDzVBtvjU9WmUG5jNGpoxnc/z1VLC8m
         menItc02PfSC4Ip6V0kPtxVvIMy7mJsAhcvdgCKDmkeP3RyZeD55aU0LMJbLjrICWqFJ
         5k+t4eZW+6PdEEAahT0Crt0CA/tJ07PX7qcMJhN7nktCW8jeyDDANFmwDv4OP0MghRnD
         j9ag==
X-Gm-Message-State: AOAM533SKYfWEUIW1h/0xmZLTNTgGoyssORvSLyPeikP2dpEivaSRXkg
        r1UjLW/LoAh0G95gEBC7/hQ=
X-Google-Smtp-Source: ABdhPJxNNPQN31zhHEZwMRwTxyJYkWprPfo30zXEz7rgq5sYpjGSwe7HMGxcGYg/B5pDATv0ObtWbA==
X-Received: by 2002:a62:880c:0:b029:327:8e12:853a with SMTP id l12-20020a62880c0000b02903278e12853amr20482230pfd.74.1626607025323;
        Sun, 18 Jul 2021 04:17:05 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id w145sm5247672pfc.39.2021.07.18.04.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jul 2021 04:17:04 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpf: Expose bpf_d_path helper to
 vfs_read/vfs_write
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210712162424.2034006-1-hengqi.chen@gmail.com>
 <60ec94013acd1_50e1d2081@john-XPS-13-9370.notmuch>
 <6f42985e-063e-205b-820e-6bad600caf54@fb.com>
 <CAADnVQL9X7xrLKa5_tfgzAnEjPckz0jaWozAH+oNKz3=tZ6r=Q@mail.gmail.com>
 <a4faf9ec-ba94-13d1-d2e1-7710902450d7@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <0e31606e-7f7e-f29d-3905-086dfd487726@gmail.com>
Date:   Sun, 18 Jul 2021 19:17:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a4faf9ec-ba94-13d1-d2e1-7710902450d7@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/18/21 12:43 AM, Yonghong Song wrote:
> 
> 
> On 7/15/21 6:44 PM, Alexei Starovoitov wrote:
>> On Wed, Jul 14, 2021 at 5:55 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>>
>>>
>>> On 7/12/21 12:12 PM, John Fastabend wrote:
>>>> Hengqi Chen wrote:
>>>>> Add vfs_read and vfs_write to bpf_d_path allowlist.
>>>>> This will help tools like IOVisor's filetop to get
>>>>> full file path.
>>>>>
>>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>>> ---
>>>>
>>>> As I understand it dpath helper is allowed as long as we
>>>> are not in NMI/interrupt context, so these should be fine
>>>> to add.
>>>>
>>>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>>>
>>> The corresponding bcc discussion thread is here:
>>>     https://github.com/iovisor/bcc/issues/3527
>>>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>
>>>>
>>>>>    kernel/trace/bpf_trace.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>>> index 64bd2d84367f..6d3f951f38c5 100644
>>>>> --- a/kernel/trace/bpf_trace.c
>>>>> +++ b/kernel/trace/bpf_trace.c
>>>>> @@ -861,6 +861,8 @@ BTF_ID(func, vfs_fallocate)
>>>>>    BTF_ID(func, dentry_open)
>>>>>    BTF_ID(func, vfs_getattr)
>>>>>    BTF_ID(func, filp_close)
>>>>> +BTF_ID(func, vfs_read)
>>>>> +BTF_ID(func, vfs_write)
>>>>>    BTF_SET_END(btf_allowlist_d_path)
>>
>> That feels incomplete.
>> I know we can add more later, but why these two and not vfs_readv ?
>> security_file_permission should probably be added as well ?
>> Along with all sys_* entry points ?
> 
> The first argument of bpf_d_path is "struct path *, path"
> which needs to be a BTF_ID w.r.t. verifier.
> 
> I think maybe we should target the common kernel functions which
> has "struct path *" or "struct file *" arguments?
> 
> vfs_readv and security_file_permission or other possible candidates
> are not added since there are no use case for those yet. But agree
> that adding some vfs_* calls and security_file* options are a good
> call since they could be used in a different situation and adding
> them may save another kernel patch.
> 
> The syscall entry points typically only contains fd. Although
> bpf program might hack to do something to convert fd to a file,
> I still think this is a unlikely use case.

Thanks for the review and suggestions.

I will send a v2 for review.

Thanks,
Hengqi
