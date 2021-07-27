Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84FE3D6C37
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 04:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhG0CTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 22:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhG0CTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 22:19:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9454C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 19:59:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so14055503plg.11
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 19:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tkaVodGxMMI2P6adzYIFFY6Kxd459Ol6RPpmO50MNIE=;
        b=d9hXCpMDNoaIlKQrBSnRmWGEZYIo5ZeG8AST2iHLRhpCWAbwSgd34v4E9E0SF/9bOz
         zdwC7zLcmZ2sH/OSA2GvJnUA8AfvQPhn+JZrFMNgtxF9FDAS3H7Mr/vJhvF8TP4G6oLQ
         He3JQtwrAolzfDD/cMfjmZTWNoD8Zzm68Q/FICLg+eQlytGvrCvn/qTPRy52y4+KvWFP
         IAZGgcaSdNyaQMSJOr68Z8/GFSU7SKdHKr3Vu4CEnSwrH6faJhMWbWji5QeI/zJzx9Bo
         humcwspaUfOarBLusvbAJMRU7iSZysfmx+z+I39Y7lumDq+sZDNt84y7j3y5v3fR7Z0f
         LCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tkaVodGxMMI2P6adzYIFFY6Kxd459Ol6RPpmO50MNIE=;
        b=hYpBbsnili2uf5uh+GZdMG5feVEkx+R1qQyYW/gTfjSuhbLhwlBhzFDcQxiEJ1dEtu
         EgbzDia7PhdMFbm03Ra8GiyL4mqape3aF1Co8X0IqPRI7vaLzDBGFqvz9KzcbfGJJlCW
         cjpEPOSpeaxunzyt1nlh5vzCUrAjA2TqC8nvz0XzX/HISlzmguuIXPDqlCG1VzST+Uu2
         URYNsGEsE6LZUYj1U3z+dN2VD7LC2PGXRT70R7lfzmyVh58Q+9GGVvHPv3hO4yC81DnF
         uXxhB+nPFJbjdwXJ9MzfapiDpDxTMtwGtduS8w1LiJWDSdEAK5gJguYHKjF7exdjTnhV
         SIHQ==
X-Gm-Message-State: AOAM5300rt8awLQjiOLXpz/LMD0MQEpg5aziX6EMsZAG7cLqxHtlFR+3
        2fm0yl5LJHAvv9Qorbm/rqY=
X-Google-Smtp-Source: ABdhPJwMAVs6aJHNqUEL/EEHioTz+jYwZDSQK4nvklkDek+wtrL+Wfur7sOAjwmezY79YkLrkC/GSA==
X-Received: by 2002:a65:6704:: with SMTP id u4mr20964348pgf.406.1627354773430;
        Mon, 26 Jul 2021 19:59:33 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id d2sm878970pjd.24.2021.07.26.19.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 19:59:33 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-2-hengqi.chen@gmail.com>
 <CAEf4BzaN50T=4sCDhXKMLNZPXJor6DVtOSoJ10NNxLU8kiOvBA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <7089d476-8ab1-50b6-56fb-55026c992f3d@gmail.com>
Date:   Tue, 27 Jul 2021 10:59:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaN50T=4sCDhXKMLNZPXJor6DVtOSoJ10NNxLU8kiOvBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/27 4:16 AM, Andrii Nakryiko wrote:
> On Sun, Jul 25, 2021 at 7:18 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Kernel functions referenced by .BTF_ids may changed from global to static
>> and get inlined and thus disappears from BTF. This causes kernel build
>> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
>> Update resolve_btfids to emit warning messages and patch zero id for missing
>> symbols instead of aborting kernel build process.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/bpf/resolve_btfids/main.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index 3ad9301b0f00..3ea19e33250d 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>>         sh->sh_addralign = expected;
>>
>>         if (gelf_update_shdr(scn, sh) == 0) {
>> -               printf("FAILED cannot update section header: %s\n",
>> +               pr_err("FAILED cannot update section header: %s\n",
>>                         elf_errmsg(-1));
>>                 return -1;
>>         }
>> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
>>
>>         elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>>         if (!elf) {
>> +               close(fd);
>>                 pr_err("FAILED cannot create ELF descriptor: %s\n",
>>                         elf_errmsg(-1));
>>                 return -1;
>> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>>         err = libbpf_get_error(btf);
>>         if (err) {
>>                 pr_err("FAILED: load BTF from %s: %s\n",
>> -                       obj->path, strerror(-err));
>> +                       obj->btf ?: obj->path, strerror(-err));
>>                 return -1;
>>         }
>>
>> @@ -555,8 +556,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
>>         int i;
>>
>>         if (!id->id) {
>> -               pr_err("FAILED unresolved symbol %s\n", id->name);
>> -               return -EINVAL;
>> +               pr_err("WARN: unresolved symbol %s\n", id->name);
> 
> we should probably give a bit more information for people to get back
> to us for this. For starters, maybe prefix the message with
> "resolve_btfids:" so that people at least can grep something relevant?
> 

OK, will do.

>>         }
>>
>>         for (i = 0; i < id->addr_cnt; i++) {
>> @@ -734,8 +734,9 @@ int main(int argc, const char **argv)
>>
>>         err = 0;
>>  out:
>> -       if (obj.efile.elf)
>> +       if (obj.efile.elf) {
>>                 elf_end(obj.efile.elf);
>> -       close(obj.efile.fd);
>> +               close(obj.efile.fd);
>> +       }
>>         return err;
>>  }
>> --
>> 2.25.1
