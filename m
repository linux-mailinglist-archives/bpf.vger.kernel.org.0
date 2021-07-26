Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975F53D5293
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 06:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhGZEBS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 00:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGZEBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 00:01:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFEC061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 21:41:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so11223912pjv.3
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 21:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMrCLiuPhHZzcW1K/9ky6v5p3IK2AQZhC975NAMZe+I=;
        b=Poh35TOFYHWiJG0Ywsue6vMq2gsL2hsTOo0i5P8IJ9pteDGMH+LAr5shwbsHHhXvJQ
         Wi3+jGPcpzwKqi28XOmmDJ4X2SCCLMNtjUtvrh4AUzRv0MO4VWxI9qvOfC2DisxhDFSu
         SeLrOsf0HIIGsfUrfxAoZLzQpTplB+kvvpiqK3BjoyIKoUKcPdV3gXIc88iJ3snOdKy/
         lQ1zAlgupLE7ns3k89L6oq+k+3urqGBfMQJ6UFXdWUFs0MKoYZKif7KRG6NlNmJLdUPA
         nPHbPFIZ/bQCE2DBvRY3XOv2cGdEgn/LWEobINtP8RMtKK2rM48y0XH3JWJ12GjfLA7e
         CLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMrCLiuPhHZzcW1K/9ky6v5p3IK2AQZhC975NAMZe+I=;
        b=DIpR/plRxZCnoce7+7ZHIDKt6qCsWKSdeA7t3RQzU8LnmjazRkAKF9PYlJxuS/Y46h
         nj0tn5AwC1mL8TUHjnab56aq4y+QCpugD9ne/2adNfapoRHq0qPwKj8mrpsgjZ05nSOs
         5qSxD3lwjNSk1dSiAqvzEFWeUiRQdhG8iZbqVMSC9Nz3GA/WN7bsdK6POViIzhgfGQHe
         j3m1AmZc197UVEWFynu4jB8mCycYrhQyaIX1yDLrHetg85UfIJU5sgloQFxhOTVZxk08
         z+9wX9qLpWzBlCMjXwzL+EsVojcMRrxfyTk33YBloU/3SteJYEXYyyuFWjKZM0qIQi+F
         U9Lg==
X-Gm-Message-State: AOAM533+V6o6q8Y56/FOpowfIs9PhfwpvKxjW252xtD9+KgYwnhP+iBD
        2wIqA9iXUw20ajKE4xmYTRE=
X-Google-Smtp-Source: ABdhPJy3C4ElvQhBvD+ixn5y0DQE9nfjTvQPIxv3D3RgYVygXgsOtrO3Tg/dyggvJbLQRuCE21CYxQ==
X-Received: by 2002:a63:9c5:: with SMTP id 188mr13061406pgj.187.1627274505064;
        Sun, 25 Jul 2021 21:41:45 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.119])
        by smtp.gmail.com with ESMTPSA id p17sm12546883pjg.54.2021.07.25.21.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 21:41:44 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, yanivagman@gmail.com
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-2-hengqi.chen@gmail.com>
 <dde36573-f6b9-8570-0878-e313e771345a@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <95d1c440-bb99-13ad-0227-f9ab20a001f2@gmail.com>
Date:   Mon, 26 Jul 2021 12:41:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <dde36573-f6b9-8570-0878-e313e771345a@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/26 11:32 AM, Yonghong Song wrote:
> 
> 
> On 7/25/21 7:18 AM, Hengqi Chen wrote:
>> Kernel functions referenced by .BTF_ids may changed from global to static
>> and get inlined and thus disappears from BTF. This causes kernel build
> 
> the function could be renamed or removed too.
> 
>> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
>> Update resolve_btfids to emit warning messages and patch zero id for missing
>> symbols instead of aborting kernel build process.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> LGTM with one minor comment below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
>> ---
>>   tools/bpf/resolve_btfids/main.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 3ad9301b0f00..3ea19e33250d 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>>       sh->sh_addralign = expected;
>>
>>       if (gelf_update_shdr(scn, sh) == 0) {
>> -        printf("FAILED cannot update section header: %s\n",
>> +        pr_err("FAILED cannot update section header: %s\n",
>>               elf_errmsg(-1));
>>           return -1;
>>       }
>> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>>
>>       elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>>       if (!elf) {
>> +        close(fd);
>>           pr_err("FAILED cannot create ELF descriptor: %s\n",
>>               elf_errmsg(-1));
>>           return -1;
>> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>>       err = libbpf_get_error(btf);
>>       if (err) {
>>           pr_err("FAILED: load BTF from %s: %s\n",
>> -            obj->path, strerror(-err));
>> +            obj->btf ?: obj->path, strerror(-err));
> 
> Why you change "obj->path" to "obj->btf ?: obj->path"?
> Note that obj->path cannot be NULL.

The diff didn't see the whole picture. Let me quote it here:
```
btf = btf__parse(obj->btf ?: obj->path, NULL);
err = libbpf_get_error(btf);
if (err) {
        pr_err("FAILED: load BTF from %s: %s\n",
                obj->path, strerror(-err));
        return -1;
}
```

Because btf__parse parses either obj->btf or obj->path,
I think the error message should reveal this.

> 
>>           return -1;
>>       }
>>
> [...]
