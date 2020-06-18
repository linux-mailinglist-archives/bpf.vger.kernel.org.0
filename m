Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E01FECE4
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 09:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgFRHvQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgFRHvP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 03:51:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DEC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:51:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so4587088wmi.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c0N4ORUFQwbB9M7m5d2XItj7rXMe2rFFdByR0dXZXiE=;
        b=khTMpqPBNowRDJs1iV4XtzmDab/anV9zv6RRzrur8RM3EZCq9TlU9qpVoPG1EK4U6D
         q56fOdV9yXvSUggH4ZDQz3k5cmXA7okQvwqNf0m160Gg1umTpRnb//gNQ7q6d6zwgR6u
         Q/2cG2WEwwtUDTezn/GsCuMQOtOTS7STfDITITb4uQXZDHs6uDZVAQu7zxgXrZbc6llB
         G9sV466JCwxInqZ26XEwkNdg/MC1i8XgD+621HrG5vkRFHKiGaP55Ozd1V98Y5GjcZrn
         I60aL1t7/14Tu9HXu5GKHqwFDyxTyxnN8pI4VG3o/oHGzmliFmcyXCRgIEM8Pst1UwMU
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0N4ORUFQwbB9M7m5d2XItj7rXMe2rFFdByR0dXZXiE=;
        b=BTJ9K/LOr1uYvGXWVrgS5fogxUIf44o8TxaqH0OWsiFKKeubrfNP0doIgEVKShCcfc
         DWgcMNHuW1/QDT/GzRezdROhSFhFb4qgU7WeGJ9EudBpl63FSFDk7U22Y2B5z/ti7CKg
         9QDLK1uvefdOCzDQqNAWBVsyL4GT+UOE4wcV/1UslrGF6qrYFjT2dBOV2fQCRTFWkGM/
         mb5rxvAQNK1IIct9x748gcYDLz6KD7ZmM8Tx4wMzCocgLqfL+BLsBDw8GKjikpE3YB2b
         6U5xMgyoKN6uoeLECVuAgy8qZqWc7B/aIj2CNEVJqN1wvXxGdqtppepNH+BJorUVMPKW
         di+w==
X-Gm-Message-State: AOAM532uCDAlxJeZvy9GP42CbJKc1jIa7G4+m4Zi8eYXgOdPx/y1XeLl
        5tVQiogbR7/U9icMFfAM7IobHw==
X-Google-Smtp-Source: ABdhPJy/KVMONRj5cklPba9qZIoYrwNuWEFq2fIw9y6h9aHaBhi0B7/xUGdKMF5fPZ632hxDx+mJ9Q==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr2712345wmb.165.1592466672568;
        Thu, 18 Jun 2020 00:51:12 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.184.213])
        by smtp.gmail.com with ESMTPSA id r2sm2420969wrg.68.2020.06.18.00.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 00:51:12 -0700 (PDT)
Subject: Re: [PATCH bpf-next 8/9] tools/bpftool: show info for processes
 holding BPF map/prog/link/btf FDs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>
References: <20200617161832.1438371-1-andriin@fb.com>
 <20200617161832.1438371-9-andriin@fb.com>
 <eebb2cea-dc27-77c6-936e-06ac5272921a@isovalent.com>
 <CAEf4BzbwKObO7CTrC8DJJo-M2trrB94spn2Ta0-GDWJ82uE41A@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <f8ba3a62-0bca-a2b3-9b17-1209c6cf42bb@isovalent.com>
Date:   Thu, 18 Jun 2020 08:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbwKObO7CTrC8DJJo-M2trrB94spn2Ta0-GDWJ82uE41A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-17 23:01 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Jun 17, 2020 at 5:24 PM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> 2020-06-17 09:18 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
>>> Add bpf_iter-based way to find all the processes that hold open FDs against
>>> BPF object (map, prog, link, btf). bpftool always attempts to discover this,
>>> but will silently give up if kernel doesn't yet support bpf_iter BPF programs.
>>> Process name and PID are emitted for each process (task group).
>>>
>>> Sample output for each of 4 BPF objects:
>>>
>>> $ sudo ./bpftool prog show
>>> 2694: cgroup_device  tag 8c42dee26e8cd4c2  gpl
>>>         loaded_at 2020-06-16T15:34:32-0700  uid 0
>>>         xlated 648B  jited 409B  memlock 4096B
>>>         pids systemd(1)
>>> 2907: cgroup_skb  name egress  tag 9ad187367cf2b9e8  gpl
>>>         loaded_at 2020-06-16T18:06:54-0700  uid 0
>>>         xlated 48B  jited 59B  memlock 4096B  map_ids 2436
>>>         btf_id 1202
>>>         pids test_progs(2238417), test_progs(2238445)
>>>
>>> $ sudo ./bpftool map show
>>> 2436: array  name test_cgr.bss  flags 0x400
>>>         key 4B  value 8B  max_entries 1  memlock 8192B
>>>         btf_id 1202
>>>         pids test_progs(2238417), test_progs(2238445)
>>> 2445: array  name pid_iter.rodata  flags 0x480
>>>         key 4B  value 4B  max_entries 1  memlock 8192B
>>>         btf_id 1214  frozen
>>>         pids bpftool(2239612)
>>>
>>> $ sudo ./bpftool link show
>>> 61: cgroup  prog 2908
>>>         cgroup_id 375301  attach_type egress
>>>         pids test_progs(2238417), test_progs(2238445)
>>> 62: cgroup  prog 2908
>>>         cgroup_id 375344  attach_type egress
>>>         pids test_progs(2238417), test_progs(2238445)
>>>
>>> $ sudo ./bpftool btf show
>>> 1202: size 1527B  prog_ids 2908,2907  map_ids 2436
>>>         pids test_progs(2238417), test_progs(2238445)
>>> 1242: size 34684B
>>>         pids bpftool(2258892)
>>>
>>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>>> ---
>>
>> [...]
>>
>>> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
>>> new file mode 100644
>>> index 000000000000..3474a91743ff
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/pids.c
>>> @@ -0,0 +1,229 @@
>>
>> [...]
>>
>>> +int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
>>> +{
>>> +     char buf[4096];
>>> +     struct pid_iter_bpf *skel;
>>> +     struct pid_iter_entry *e;
>>> +     int err, ret, fd = -1, i;
>>> +     libbpf_print_fn_t default_print;
>>> +
>>> +     hash_init(table->table);
>>> +     set_max_rlimit();
>>> +
>>> +     skel = pid_iter_bpf__open();
>>> +     if (!skel) {
>>> +             p_err("failed to open PID iterator skeleton");
>>> +             return -1;
>>> +     }
>>> +
>>> +     skel->rodata->obj_type = type;
>>> +
>>> +     /* we don't want output polluted with libbpf errors if bpf_iter is not
>>> +      * supported
>>> +      */
>>> +     default_print = libbpf_set_print(libbpf_print_none);
>>> +     err = pid_iter_bpf__load(skel);
>>> +     libbpf_set_print(default_print);
>>> +     if (err) {
>>> +             /* too bad, kernel doesn't support BPF iterators yet */
>>> +             err = 0;
>>> +             goto out;
>>> +     }
>>> +     err = pid_iter_bpf__attach(skel);
>>> +     if (err) {
>>> +             /* if we loaded above successfully, attach has to succeed */
>>> +             p_err("failed to attach PID iterator: %d", err);
>>
>> Nit: What about using strerror(err) for the error messages, here and
>> below? It's easier to read than an integer value.
> 
> I'm actually against it. Just a pure string message for error is often
> quite confusing. It's an extra step, and sometimes quite a quest in
> itself, to find what's the integer value of errno it was, just to try
> to understand what kind of error it actually is. So I certainly prefer
> having integer value, optionally with a string error message.
> 
> But that's too much hassle for this "shouldn't happen" type of errors.
> If they happen, the user is unlikely to infer anything useful and fix
> the problem by themselves. They will most probably have to ask on the
> mailing list and paste error messages verbatim and let people like me
> and you try to guess what's going on. In such cases, having an errno
> number is much more helpful.

Ok, fair enough.

>>> +             goto out;
>>> +     }
>>> +
>>> +     fd = bpf_iter_create(bpf_link__fd(skel->links.iter));
>>> +     if (fd < 0) {
>>> +             err = -errno;
>>> +             p_err("failed to create PID iterator session: %d", err);
>>> +             goto out;
>>> +     }
>>> +
>>> +     while (true) {
>>> +             ret = read(fd, buf, sizeof(buf));
>>> +             if (ret < 0) {
>>> +                     err = -errno;
>>> +                     p_err("failed to read PID iterator output: %d", err);
>>> +                     goto out;
>>> +             }
>>> +             if (ret == 0)
>>> +                     break;
>>> +             if (ret % sizeof(*e)) {
>>> +                     err = -EINVAL;
>>> +                     p_err("invalid PID iterator output format");
>>> +                     goto out;
>>> +             }
>>> +             ret /= sizeof(*e);
>>> +
>>> +             e = (void *)buf;
>>> +             for (i = 0; i < ret; i++, e++) {
>>> +                     add_ref(table, e);
>>> +             }
>>> +     }
>>> +     err = 0;
>>> +out:
>>> +     if (fd >= 0)
>>> +             close(fd);
>>> +     pid_iter_bpf__destroy(skel);
>>> +     return err;
>>> +}
>>
>> [...]
>>
>>> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> new file mode 100644
>>> index 000000000000..f560e48add07
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> @@ -0,0 +1,80 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>> This would make it the only file not dual-licensed GPL/BSD in bpftool.
>> We've had issues with that before [0], although linking to libbfd is no
>> more a hard requirement. But I see you used a dual-license in the
>> corresponding header file pid_iter.h, so is the single license
>> intentional here? Or would you consider GPL/BSD?
>>
> 
> The other BPF program (skeleton/profiler.bpf.c) is also GPL-2.0, we
> should probably switch both.

Oh I missed that one :(. Yeah, if this is possible, that would be great!

>> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=896165#38
>>
>>> +// Copyright (c) 2020 Facebook
>>> +#include <vmlinux.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +#include <bpf/bpf_core_read.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +#include "pid_iter.h"
>>
>> [...]
>>
>>> +
>>> +char LICENSE[] SEC("license") = "GPL";
> 
> I wonder if leaving this as GPL would be ok, if the source code itself
> is dual GPL/BSD?

If the concern is to pass the verifier, it accepts a handful of
different strings (see include/linux/license.h), one of which is "Dual
BSD/GPL" and should probably be used in that case. Or did you have
something else in mind?
