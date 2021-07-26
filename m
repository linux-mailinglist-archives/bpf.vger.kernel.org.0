Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B731D3D52D3
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 07:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGZEmQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 00:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZEmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 00:42:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379DC061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 22:22:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e14so10259372plh.8
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 22:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ig73Af08fuWuddTrX2Q0MR6gFbs0CGY/f7Ly0/R2xuE=;
        b=Ul6Ad2vyN5bVnuFNhfaTwn7/0/bm9vDbAdINLxxb2DfPjKwJYLBsZmWKpd07VAkSdC
         +jWy22gfK61TY8EUjL1FLadGu050+At2oAZXo+tfhdPWXEMTrgEW7rlGjMtzt1T2nkVg
         G90ZDBlaK1ymm/RkhVL8SLYiQCTZoijvE4licQvIn+V5xUUeSid4KBm0tW1lSztDzMdz
         jXJ4zfYQjCBp8byo+4nHwtoopiVedrDQ1jYuLHBC9ROwpTlYqO7sR4YCPTQ8T+3VJN+b
         qD2LUHUdX/BrmYcfM5shPrbYwcL1Zj8gMYr5mDzrl8m/HggwlpsgGv4qT3Ast0YbxxoS
         +MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ig73Af08fuWuddTrX2Q0MR6gFbs0CGY/f7Ly0/R2xuE=;
        b=ohPBQv5Xffk+EXIOOO8I8hnbMc7Ncl270fJqAVAa2Qy2LFSSf+sXA5gE6wR8XYzE6O
         Ic+yul7eSEbRxIvUO3HBbTfink3zN//bUe+cq/XEdnXQ7DQ9tBgoAPt0Y+19WFKnl0oJ
         stFqYQPTx8sDHaL49kWnIo/qhgU6SwC9GvUZ6RpUuG2mfjd53s9wNr5XEb8JfqffWE2y
         9FeoHfbQjfTmUyRcHaAHec7OGUCaUvPZ2QHIFULu48l26ADseqwjiQaMo940wjhc/tnZ
         HUrdTXu7vLAE2PiBBM3Sox3diHG8i6iFwCjJKBdQhxtoO5CiixbM1yDtHr+LvAsPuEGQ
         Af0Q==
X-Gm-Message-State: AOAM532KoKSb268HUa+WublGtM9+/oci2j2O6LR6ThHguMs6RnBLlW5e
        3eIstsYm3PmyVP77oyYMcfA=
X-Google-Smtp-Source: ABdhPJzP6dBVduQcPBeo8W14kvnA1Y5I6okWbsB0siSbOXLQIs2eAvHXxaAVPq/bsp7xXrrIKZYbeg==
X-Received: by 2002:a62:ab0a:0:b029:33b:6d08:2a45 with SMTP id p10-20020a62ab0a0000b029033b6d082a45mr15891926pff.38.1627276964285;
        Sun, 25 Jul 2021 22:22:44 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.119])
        by smtp.gmail.com with ESMTPSA id i18sm41947522pgb.83.2021.07.25.22.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 22:22:43 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, yanivagman@gmail.com
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-2-hengqi.chen@gmail.com>
 <dde36573-f6b9-8570-0878-e313e771345a@fb.com>
 <95d1c440-bb99-13ad-0227-f9ab20a001f2@gmail.com>
 <e077b67e-d7d7-b8ff-f026-2280ce89a6f8@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <f1e7a60c-78ca-ce24-313b-c0e46507501a@gmail.com>
Date:   Mon, 26 Jul 2021 13:22:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e077b67e-d7d7-b8ff-f026-2280ce89a6f8@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/26 12:56 PM, Yonghong Song wrote:
> 
> 
> On 7/25/21 9:41 PM, Hengqi Chen wrote:
>>
>>
>> On 2021/7/26 11:32 AM, Yonghong Song wrote:
>>>
>>>
>>> On 7/25/21 7:18 AM, Hengqi Chen wrote:
>>>> Kernel functions referenced by .BTF_ids may changed from global to static
>>>> and get inlined and thus disappears from BTF. This causes kernel build
>>>
>>> the function could be renamed or removed too.
>>>
>>>> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
>>>> Update resolve_btfids to emit warning messages and patch zero id for missing
>>>> symbols instead of aborting kernel build process.
>>>>
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>
>>> LGTM with one minor comment below.
>>>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>>
>>>> ---
>>>>    tools/bpf/resolve_btfids/main.c | 13 +++++++------
>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>>> index 3ad9301b0f00..3ea19e33250d 100644
>>>> --- a/tools/bpf/resolve_btfids/main.c
>>>> +++ b/tools/bpf/resolve_btfids/main.c
>>>> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>>>>        sh->sh_addralign = expected;
>>>>
>>>>        if (gelf_update_shdr(scn, sh) == 0) {
>>>> -        printf("FAILED cannot update section header: %s\n",
>>>> +        pr_err("FAILED cannot update section header: %s\n",
>>>>                elf_errmsg(-1));
>>>>            return -1;
>>>>        }
>>>> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>>>>
>>>>        elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>>>>        if (!elf) {
>>>> +        close(fd);
>>>>            pr_err("FAILED cannot create ELF descriptor: %s\n",
>>>>                elf_errmsg(-1));
>>>>            return -1;
>>>> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>>>>        err = libbpf_get_error(btf);
>>>>        if (err) {
>>>>            pr_err("FAILED: load BTF from %s: %s\n",
>>>> -            obj->path, strerror(-err));
>>>> +            obj->btf ?: obj->path, strerror(-err));
>>>
>>> Why you change "obj->path" to "obj->btf ?: obj->path"?
>>> Note that obj->path cannot be NULL.
>>
>> The diff didn't see the whole picture. Let me quote it here:
>> ```
>> btf = btf__parse(obj->btf ?: obj->path, NULL);
>> err = libbpf_get_error(btf);
>> if (err) {
>>          pr_err("FAILED: load BTF from %s: %s\n",
>>                  obj->path, strerror(-err));
>>          return -1;
>> }
>> ```
>>
>> Because btf__parse parses either obj->btf or obj->path,
>> I think the error message should reveal this.
> 
> Okay, I see, obj->btf may not be NULL due to
>                 OPT_STRING(0, "btf", &obj.btf, "BTF data",
>                            "BTF data"),
> 
> How about
>   obj->btf ? "input BTF data" : obj->path
> 
> The error message like
>   FAILED: load BTF from : <error msg>
> does not sound good.
> 

Sorry, I am confused.

If obj->btf is set, say, vmlinux.btf, the message should look like:
 FAILED: load BTF from vmlinux.btf: <error msg>

Otherwise, it should look like:
 FAILED: load BTF from vmlinux: <error msg>

Am I missing something ?

>>
>>>
>>>>            return -1;
>>>>        }
>>>>
>>> [...]
