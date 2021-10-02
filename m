Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0898841FD08
	for <lists+bpf@lfdr.de>; Sat,  2 Oct 2021 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhJBQTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Oct 2021 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBQTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Oct 2021 12:19:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD447C0613EC
        for <bpf@vger.kernel.org>; Sat,  2 Oct 2021 09:17:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so8282454plk.10
        for <bpf@vger.kernel.org>; Sat, 02 Oct 2021 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PY49L+fnBcdgAUsmL5kRKvClDHovJYhLW6ssxoeKSlg=;
        b=Hs+o9s8RFZ4qMk7E3YpRPP3Vmhj/aajRQRm4K5pYJ1vGTVjc8CRWe9XS8zuEPfMP7K
         B0rP6qOYvAQ6w/KaXyAfKohJNdympwGwVtEyXtDi5uMobG8MBNtGlx12pJSKb6yioLvk
         bZYmTghYUBlhotDTWP8lXJ2VpmZSGBdQoAIsLj2CxkcZjUZCcHz4bKRI1ACIvnkwSskO
         qzabdHoFH8RnelrdltQl4bgg1lYOHycfrim0Dl30S3pyABpL3ziH0anQjUGJG+xhW2zi
         GGV7G9qcpNcjGeruQzRA117plU5UmOCY9d9Ns3MPJQXP3AHbI0j7JwP1zFqzmFpMoNFT
         afYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PY49L+fnBcdgAUsmL5kRKvClDHovJYhLW6ssxoeKSlg=;
        b=WinPmojRdnctjk/bIhwrtxHBIvC0qy3iSF9WCSQxNo+i/Ff3iLd0NqUhXfbi3RLHZj
         lkQ5Wt+pKNjwdZARYtkyUYEEpF02+qRxEMMNt3nSY2pm9muQs5NwYokItfPuHDTfG4vZ
         A9bxMGs9Hk5hnCKOk3vKM4DU1Tv8Dj6YJHtH9GyTV/DdR6rdL2HSL5/XSyOMQ3zyGvsG
         PZOmO0guOhRJHFDGk45ShkohI3RUS13MHl/zWrWsf64aFk/KwlIUyODRVir6928F+YVU
         a5o78tB5bg/nHgAEGoWxPbfH6CZhLGD+3d07TXeu0p9GJe3VE24IZge4vuvrX6lkj+5c
         CXjQ==
X-Gm-Message-State: AOAM530hXIMFpKmEqCRyjMSPmneL1scceyLPhsNRPwbdJk7qh392nhxj
        S/DI6EIFgUWiMNRpDH0Q7JE=
X-Google-Smtp-Source: ABdhPJxT856W0Ac+csYwTX5hLS+xL283BHjW0IXFI3dwELopRWCmMqybTE7ODyTLE/yumnflDnlVYQ==
X-Received: by 2002:a17:902:a385:b0:13e:99e9:17f3 with SMTP id x5-20020a170902a38500b0013e99e917f3mr3870742pla.65.1633191475063;
        Sat, 02 Oct 2021 09:17:55 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id s7sm5199751pgc.60.2021.10.02.09.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:17:54 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF map creation using
 BTF-defined key/value
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
References: <20210905100914.33007-1-hengqi.chen@gmail.com>
 <20210905100914.33007-2-hengqi.chen@gmail.com>
 <CAEf4BzZnKxVRtkaGUbzCmi0SDsR4_KM=uqdgP+Q6seAygkst7g@mail.gmail.com>
 <52bd9e85-4b5f-d260-8ef0-b5685654ae62@gmail.com>
 <CAEf4Bzbni1-M=9S=R_xygOYKOFwuOJjcNtJVqQVdTOLjR6512Q@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <6fdca592-693a-f1d5-e2c9-395cfbdb4e6d@gmail.com>
Date:   Sun, 3 Oct 2021 00:17:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbni1-M=9S=R_xygOYKOFwuOJjcNtJVqQVdTOLjR6512Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/1/21 2:39 AM, Andrii Nakryiko wrote:
> On Thu, Sep 30, 2021 at 9:05 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>>
>>
>> On 9/9/21 12:29 PM, Andrii Nakryiko wrote:
>>> On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> Test BPF map creation using BTF-defined key/value. The test defines
>>>> some specialized maps by specifying BTF types for key/value and
>>>> checks those maps are correctly initialized and loaded.
>>>>
>>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>>> ---
>>>>  .../selftests/bpf/prog_tests/map_create.c     |  87 ++++++++++++++
>>>>  .../selftests/bpf/progs/test_map_create.c     | 110 ++++++++++++++++++
>>>>  2 files changed, 197 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_create.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_create.c
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_create.c b/tools/testing/selftests/bpf/prog_tests/map_create.c
>>>> new file mode 100644
>>>> index 000000000000..6ca32d0dffd2
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/map_create.c
>>>> @@ -0,0 +1,87 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* Copyright (c) 2021 Hengqi Chen */
>>>> +
>>>> +#include <test_progs.h>
>>>> +#include "test_map_create.skel.h"
>>>> +
>>>> +void test_map_create(void)
>>>> +{
>>>> +       struct test_map_create *skel;
>>>> +       int err, fd;
>>>> +
>>>> +       skel = test_map_create__open();
>>>> +       if (!ASSERT_OK_PTR(skel, "test_map_create__open failed"))
>>>> +               return;
>>>> +
>>>> +       err = test_map_create__load(skel);
>>>
>>> If load() succeeds, all the maps will definitely be created, so all
>>> the below tests are meaningless.
>>>
>>> I think it's better to just change all the existing map definitions
>>> used throughout selftests to use key/value types, instead of
>>> key_size/value_size. That will automatically test this feature without
>>> adding an extra test. Unfortunately to really test that the logic is
>>> working, we'd need to check that libbpf doesn't emit the warning about
>>> retrying map creation w/o BTF, but I think one-time manual check
>>> (please use ./test_progs -v to see libbpf warnings during tests)
>>> should be sufficient for this.
>>>
>>
>> Hello, Andrii
>>
>> I updated these existing tests as you suggested,
>> but I was unable to run the whole bpf selftests locally.
>>
>> Running ./test_progs -v made my system hang up,
>> didn't find the root cause yet.
> 
> This is strange. Do you know at which test this happens? Do you get
> kernel warning/oops when this happens in dmesg?
> 

No, when this situation occurred, I just restarted my laptop.
Will look into this later.

> But overall, the development and testing workflow for people working
> on bpf/bpf-next involves building latest kernel and running selftests
> inside the QEMU VM for testing. We also have vmtest.sh script in
> selftests/bpf that automates a lot of building steps. It will build
> kernel, test_progs and other selftest binaries, and will spin up QEMU
> VM with the same image that our BPF CIs are using. You just need to
> have very recent/latest Clang available and similarly pahole (from
> dwarves package) should be up to date and available through $PATH.
> After that, running ./vmtest.sh will just run all ./test_progs
> automatically.
> 

This workflow info is quite useful for me. Thanks.

> Either way, our CI will also run your changes through the tests
> (except there are some intermittent issues right now, so we'll have to
> wait a bit for that to kick in). You can monitor [0], or the link will
> actually appear on each of your patches (e.g., [1]) in "Checks"
> section, once everything is up and running properly.
> 
>   [0] https://github.com/kernel-patches/bpf/pulls
>   [1] https://patchwork.kernel.org/project/netdevbpf/patch/20210930161456.3444544-2-hengqi.chen@gmail.com/
> 
>>
>> Instead I just run the modified test with the following commands:
>>
>> sudo ./test_progs -v --name=kfree_skb,perf_event_stackmap,btf_map_in_map,pe_preserve_elems,stacktrace_map,stacktrace_build_id,xdp_bpf2bpf,select_reuseport,tcpbpf_user
>>
>>>> +       if (!ASSERT_OK(err, "test_map_create__load failed"))
>>>> +               goto cleanup;
>>>> +
>>>> +       fd = bpf_map__fd(skel->maps.map1);
>>>> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
>>>> +               goto cleanup;
>>>> +       close(fd);
>>>> +
>>>> +       fd = bpf_map__fd(skel->maps.map2);
>>>> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
>>>> +               goto cleanup;
>>>> +       close(fd);
>>>
>>> [...]
>>>
