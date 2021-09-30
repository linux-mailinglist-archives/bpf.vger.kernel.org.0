Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44641DE60
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbhI3QHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348160AbhI3QHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:07:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C726C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:05:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x4so4368307pln.5
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7xmXj9aYtYAmym4oYhLe4ffPu3Gf+FFTF05LNFdEIk=;
        b=WlxN9a2IkYc4C9+joG3YQeYmCZT50LrsNIW5dlmaRvJ8pXnlFdUeU1a4/tMEoJr0Z+
         f632lgprKGXHEgD6MYbRr0OAY+ZQXpi+jgNAIMTmzisb0A+E+TRW3/RrGLV0AjlC1qFO
         sy1ywIFrv7QT+6NJFnQhFVGxg+Uapqlfc3IiOXneKtudVkkVas1pobNR+pCOUeDenwzy
         +MblBsdKuU/jsfrx/dksmUoZthLDOwoCgEbJ3zalNDhnvjqOMYFblyzT1KTqgSJHLCCY
         7Dp7ZeNfkvXC3ve6+Qh9EbPHQzn0YTatw1ESzVDl9pJnhLH7dIbsrXpGp9+Ac+4noLf4
         jdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7xmXj9aYtYAmym4oYhLe4ffPu3Gf+FFTF05LNFdEIk=;
        b=M98VmMtxEwTwXFGZuGYuchDY7EG3Qhbyzw/MaZOboGaE+zUj+Su9aTYzo9JDV8vNIy
         xUi8haxsO1Cjk5wBtbDJms2epaO0NacCMdPjirIy2W999bBbDKnEPXHZsY0glynSLZhR
         hxtxXG3sqDmoVbVMa1ghPcnbvpsLdBZFQ/2x/4GHqckrYDRyw7L3kstwyBN4v8Fk1s2x
         vKRj0DpbYIPJPrOa4RfCUPoQlQyRPiS4vdK2swO+bV3uy0TIW5Gm/Lv7yVBfX7UwRQ7E
         Qv18NyW2rAv54Hr6vGO2H7AToQS2VFbU9/QEcWx/vlDcpvyJN44mCISj27w15oZ9VdnD
         oahw==
X-Gm-Message-State: AOAM530DNUqwzIXIGy3ItjaIo6VeqYXbKfEENRtWoA/BAZHeQ98bXyjA
        6jCyrfwYaKURDooQfZKjdsM=
X-Google-Smtp-Source: ABdhPJzNSdUzkYjvrNS1UxBLp3gGfy5YrckS+RjR4pXYun6uvX1U/5Bm9lDf8jmaWRaVAnhYtgZ77A==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr7485827pjt.183.1633017938054;
        Thu, 30 Sep 2021 09:05:38 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id q19sm819177pfg.40.2021.09.30.09.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 09:05:37 -0700 (PDT)
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
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <52bd9e85-4b5f-d260-8ef0-b5685654ae62@gmail.com>
Date:   Fri, 1 Oct 2021 00:05:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZnKxVRtkaGUbzCmi0SDsR4_KM=uqdgP+Q6seAygkst7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 12:29 PM, Andrii Nakryiko wrote:
> On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Test BPF map creation using BTF-defined key/value. The test defines
>> some specialized maps by specifying BTF types for key/value and
>> checks those maps are correctly initialized and loaded.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/map_create.c     |  87 ++++++++++++++
>>  .../selftests/bpf/progs/test_map_create.c     | 110 ++++++++++++++++++
>>  2 files changed, 197 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_create.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_create.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_create.c b/tools/testing/selftests/bpf/prog_tests/map_create.c
>> new file mode 100644
>> index 000000000000..6ca32d0dffd2
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_create.c
>> @@ -0,0 +1,87 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include <test_progs.h>
>> +#include "test_map_create.skel.h"
>> +
>> +void test_map_create(void)
>> +{
>> +       struct test_map_create *skel;
>> +       int err, fd;
>> +
>> +       skel = test_map_create__open();
>> +       if (!ASSERT_OK_PTR(skel, "test_map_create__open failed"))
>> +               return;
>> +
>> +       err = test_map_create__load(skel);
> 
> If load() succeeds, all the maps will definitely be created, so all
> the below tests are meaningless.
> 
> I think it's better to just change all the existing map definitions
> used throughout selftests to use key/value types, instead of
> key_size/value_size. That will automatically test this feature without
> adding an extra test. Unfortunately to really test that the logic is
> working, we'd need to check that libbpf doesn't emit the warning about
> retrying map creation w/o BTF, but I think one-time manual check
> (please use ./test_progs -v to see libbpf warnings during tests)
> should be sufficient for this.
> 

Hello, Andrii

I updated these existing tests as you suggested, 
but I was unable to run the whole bpf selftests locally.

Running ./test_progs -v made my system hang up,
didn't find the root cause yet.

Instead I just run the modified test with the following commands:

sudo ./test_progs -v --name=kfree_skb,perf_event_stackmap,btf_map_in_map,pe_preserve_elems,stacktrace_map,stacktrace_build_id,xdp_bpf2bpf,select_reuseport,tcpbpf_user

>> +       if (!ASSERT_OK(err, "test_map_create__load failed"))
>> +               goto cleanup;
>> +
>> +       fd = bpf_map__fd(skel->maps.map1);
>> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
>> +               goto cleanup;
>> +       close(fd);
>> +
>> +       fd = bpf_map__fd(skel->maps.map2);
>> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
>> +               goto cleanup;
>> +       close(fd);
> 
> [...]
> 
