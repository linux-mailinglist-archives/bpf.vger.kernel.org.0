Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABAF43855F
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJWUxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 16:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWUxO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 16:53:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4BC061714
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:50:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u18so1225498wrg.5
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=u5tOprzfZxY9dYzPdeQe4CIXAQ7I+IIO+8ZPmz5/Nm0=;
        b=XE9Z1GITD/yve6kA5C7F2A9m+evUq6YmNG5o/bRVKSCvqbcHriC8xL83AAcztGXCBi
         NfATYY2iMytAxeoSnQlEBs8yc6+hiRQVcAEj2vTaG089JxMvqe1IuHtIELwPq4L9FqAX
         2t5rJ6e1H7nT4TQIyPBwfWs5n7kDNXbLHp2k1MYzAvsHeVLzwtSm4LWmiGsNFIkd7POJ
         YF+4M29rR2znRQRZbVO+yBE9EGRQ07tzXglI+qMhVqe1XHAPHfiJJuQmQFlZJvCY9tSs
         8b68fV2QalXluiuLU/5gq4RVahKadQbsMDmrcM3kaqVG/05YIJMtXMhLSa0O+igFz1yJ
         nslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u5tOprzfZxY9dYzPdeQe4CIXAQ7I+IIO+8ZPmz5/Nm0=;
        b=plfXR4hqKYBTZDII3DNGRP0ZMQ3fF5gL1OCfAbrKgl5Uu9KWmJrUNZZl2zssF5iFp7
         TMUMiSFNnK+gm6yYsgnN1rJjxsX8jiXt9qM3ua8WHlglICQQa0YhVtcBB84MuCSoMT2v
         01qLBtnzIPqV7ig5pS6BcHLseQ5odOEXd+SHACh9dCRYfGHD/BGwEHo5/TLcrgjdmKTI
         ekG1N28CxYii7yT6IS62j+gPlnBAZQ62E44LBOBPlwCne8P911WY+NCJz4nLCjJvDULX
         1NCWlCne9XGUsiyTnNBpga38N4ay5u+syoSum4mw24KuoLmwoFvx4vhhsOLYzb/LkPWD
         znsw==
X-Gm-Message-State: AOAM530YHmrKEMwLDN/QjEllAbFmgFGoSV2N4985beHzl7A3j1JapoXA
        ilthgR0MAATOz/BmBbIJipNXcg==
X-Google-Smtp-Source: ABdhPJy8Y1/C3DAISfDs4wNpa6m2dY0bCRdl+vBWw02IFQWFErKZo179mY1zekeE9AcDtpnhm8kMKQ==
X-Received: by 2002:a5d:564d:: with SMTP id j13mr10161655wrw.402.1635022252736;
        Sat, 23 Oct 2021 13:50:52 -0700 (PDT)
Received: from [192.168.1.11] ([149.86.74.50])
        by smtp.gmail.com with ESMTPSA id c7sm8629285wrp.51.2021.10.23.13.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 13:50:52 -0700 (PDT)
Message-ID: <d6da1761-1da8-b7e0-0be5-663d37929072@isovalent.com>
Date:   Sat, 23 Oct 2021 21:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 2/5] bpftool: Do not expose and init hash maps
 for pinned path in main.c
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20211022171647.27885-1-quentin@isovalent.com>
 <20211022171647.27885-3-quentin@isovalent.com>
 <CAEf4BzYouGby=iKWb18E7XH9RDg+vNt=8DuUv9AAEKgM74b4sA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzYouGby=iKWb18E7XH9RDg+vNt=8DuUv9AAEKgM74b4sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-10-22 17:13 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Fri, Oct 22, 2021 at 10:16 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> BPF programs, maps, and links, can all be listed with their pinned paths
>> by bpftool, when the "-f" option is provided. To do so, bpftool builds
>> hash maps containing all pinned paths for each kind of objects.
>>
>> These three hash maps are always initialised in main.c, and exposed
>> through main.h. There appear to be no particular reason to do so: we can
>> just as well make them static to the files that need them (prog.c,
>> map.c, and link.c respectively), and initialise them only when we want
>> to show objects and the "-f" switch is provided.
>>
>> This may prevent unnecessary memory allocations if the implementation of
>> the hash maps was to change in the future.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>  tools/bpf/bpftool/link.c |  9 ++++++++-
>>  tools/bpf/bpftool/main.c | 12 ------------
>>  tools/bpf/bpftool/main.h |  3 ---
>>  tools/bpf/bpftool/map.c  |  9 ++++++++-
>>  tools/bpf/bpftool/prog.c |  9 ++++++++-
>>  5 files changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index 8cc3e36f8cc6..ebf29be747b3 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -20,6 +20,8 @@ static const char * const link_type_name[] = {
>>         [BPF_LINK_TYPE_NETNS]                   = "netns",
>>  };
>>
>> +static struct pinned_obj_table link_table;
>> +
>>  static int link_parse_fd(int *argc, char ***argv)
>>  {
>>         int fd;
>> @@ -302,8 +304,10 @@ static int do_show(int argc, char **argv)
>>         __u32 id = 0;
>>         int err, fd;
>>
>> -       if (show_pinned)
>> +       if (show_pinned) {
>> +               hash_init(link_table.table);
>>                 build_pinned_obj_table(&link_table, BPF_OBJ_LINK);
>> +       }
>>         build_obj_refs_table(&refs_table, BPF_OBJ_LINK);
>>
>>         if (argc == 2) {
>> @@ -384,6 +388,9 @@ static int do_detach(int argc, char **argv)
>>         if (json_output)
>>                 jsonw_null(json_wtr);
>>
>> +       if (show_pinned)
>> +               delete_pinned_obj_table(&link_table);
> 
> Shouldn't this be in do_show rather than do_detach?

Yikes! How did it end up here? Thanks for the catch, sure, I'll fix it.
