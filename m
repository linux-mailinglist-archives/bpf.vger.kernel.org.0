Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A99434CC4
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTN4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 09:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhJTN4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 09:56:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F1C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:54:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o133so3029592pfg.7
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=611xAqXnimQaZan7BQQ8OSl4RHvr4F7Ld3Lp+NXsW04=;
        b=peM4hcfxZPVlYoTDOBefxi8UOCGt1QflYvmbinPjlFLVKCteEmtF1NOCF5EDb11kCz
         exrgNd/atLRaDpmtC+cmBnELdHt69+5wm/g8cBkuTL9vHOEIc3ES7ic1wK1ZvcJ1pAdx
         6h5AzoS9zRYE7NlROn00/4c8s9SFR19bq0XCev8A86HiYATdTQBKPaq8O/IxZk1W4lWV
         bS73CHsBp+D2vaUCCcuMRp9J1OZex9XpzxtjE67lE3DDIDYeIjeTmue2rD6yQGuxZ/CT
         gXgyAUxmhK86o6ZSv3tXGDF7QjHYJUlFFMWa+PBeORqomenL/IOFVlo1YB5hlznwfukv
         CZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=611xAqXnimQaZan7BQQ8OSl4RHvr4F7Ld3Lp+NXsW04=;
        b=Z9IcSpnK7hC5alrEnpUbh3XObw2l9Q5DeVmQLnhzBG56elU84BPfe8Pq8aLWAs5ofu
         ufsBRlqzb5CPUMv5MyV1XML5OKh3lz/CLvgHKQrCOPabMTbsPjF+FwT+l1I1BfwhWG7i
         XDN6WbgjsBZTcgiArZORfbAu1rua+tHWEM87KjuUpEckDe1pNAalLQ+KUsKNpfS00I9x
         3Yf0HlzZO5bnRGfMhslA51nbZS0MVsOfiPQlVbBlgBVOdy9Dxg/FckuSHsFvHBcDw+rV
         5IQ+f9BM07Ik6ajvSv4OZ3WVI0KGsCKpfNJ7yr84ineL5qHYSRb3VZnQMNWnOsiH/Ejn
         DiUw==
X-Gm-Message-State: AOAM5321FPorlRaiN8lL6ctXigt4YQA9fJa5etkYwVV2ah2DUlF1T4RL
        kX35IFFVY3qgDGjIn+XMqdc=
X-Google-Smtp-Source: ABdhPJwqkKFgDQDtK2ZC1NdSaXU9Tfecx8Lw5Bt6ER+OnrCqzEdeF4uFRSI9RGbH/3wV+a7ETfs21w==
X-Received: by 2002:a63:7504:: with SMTP id q4mr96397pgc.103.1634738075924;
        Wed, 20 Oct 2021 06:54:35 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id d2sm3082795pfj.42.2021.10.20.06.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 06:54:35 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] tools: Switch to new
 btf__type_cnt/btf__raw_data APIs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
References: <20211009150029.1746383-1-hengqi.chen@gmail.com>
 <20211009150029.1746383-3-hengqi.chen@gmail.com>
 <CAEf4Bza6iFBn6FJ4ps+ONwDQ-Otqt=QtBm7Tw00qg+zVYM0wdQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <66bfc72b-0cac-3c16-7224-49884e83b8be@gmail.com>
Date:   Wed, 20 Oct 2021 21:54:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4Bza6iFBn6FJ4ps+ONwDQ-Otqt=QtBm7Tw00qg+zVYM0wdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/20 1:50 AM, Andrii Nakryiko wrote:
> On Sat, Oct 9, 2021 at 8:01 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Replace the calls to btf__get_nr_types/btf__get_raw_data in tools
>> with new APIs btf__type_cnt/btf__raw_data. The old APIs will be
>> deprecated in recent release of libbpf.
> 
> "in libbpf v0.7+"
> 
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/bpf/bpftool/btf.c                              | 12 ++++++------
>>  tools/bpf/bpftool/gen.c                              |  4 ++--
>>  tools/bpf/resolve_btfids/main.c                      |  4 ++--
>>  tools/perf/util/bpf-event.c                          |  2 +-
>>  tools/testing/selftests/bpf/btf_helpers.c            |  4 ++--
>>  tools/testing/selftests/bpf/prog_tests/btf.c         | 10 +++++-----
>>  tools/testing/selftests/bpf/prog_tests/btf_dump.c    |  8 ++++----
>>  tools/testing/selftests/bpf/prog_tests/btf_endian.c  | 12 ++++++------
>>  tools/testing/selftests/bpf/prog_tests/btf_split.c   |  2 +-
>>  .../testing/selftests/bpf/prog_tests/core_autosize.c |  2 +-
>>  tools/testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
>>  .../selftests/bpf/prog_tests/resolve_btfids.c        |  4 ++--
>>  12 files changed, 33 insertions(+), 33 deletions(-)
>>
> 
> Please split each tool into a separate patch, and selftests separate
> from tools as well. Otherwise, great job, thanks!
> 

I was hesitant to separate these changes to individual patches.
Will do since you ask for it. Thanks.

> [...]
> 
