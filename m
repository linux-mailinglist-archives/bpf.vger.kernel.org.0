Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0423DC068
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhG3VtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhG3VtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 17:49:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92743C061765
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:48:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p5so13013358wro.7
        for <bpf@vger.kernel.org>; Fri, 30 Jul 2021 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EsDUW54IWbSf8Z8O6hHXb0pLwJ008/IDYgFj2trnnwg=;
        b=u1TpaivkM/E1CosRoNcFDY9b+EJtgycc1bA/NnYw+lyxTPIY3nbM426VjyJwsYTxJ9
         6iZNULYfNYiS7GyMMXLzCY7Th3o8RciFE7aorvOcWm2fpid2Ow6dyRAuylaFH83KZPcV
         y1yNukSZjmFvJ9Rjb1UyDmoAPgySsj4SYWZsj+Rdvjpm5QkSF0kxuDAIRXd0LC/MKLsB
         k0RD4qkw/fT4d+3OgUSkqaumE7KRxRc9cI1xgSIXiE7XyxQPrF+9P/BXhBtUM/ib3sG5
         iHLoZ0WaIEGuPJs84Y2BhJ9rbjhdQrMb4JrMhZOHzXdP0C/H0MuIPzzvuWlbWuxgxGSk
         7Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EsDUW54IWbSf8Z8O6hHXb0pLwJ008/IDYgFj2trnnwg=;
        b=hYNHUbIhS5BA/KS4T1ylpVtkcaRCZi+QxWZwcmQcpALHeojRNRyjqIO03SDfIIXgD7
         M49rwzQL6lIz7RQsvI4IjjkMQ+pEMwqF/3XotepuoBYEiQwli5ekbgbDvU92+akv/dIA
         T2da+PvSm/AjA6YSZcKNmlkvwiZ1MZRudmT437ypa89dT/9yxQuPmfxjwZRyXScVExeL
         CG76UkDu1FT0jEGzlI4AT0NNvy4rvjzl60LT1KAN61X9C/u0UcXSPm0wb4Bn1JNBYbcB
         F9nnRIx1q7LhZweYdBTECgZfDFcml7FS+8IQNzI8kkFSc7X7ZloBkPHNZZSXhvbjPpr7
         aE1g==
X-Gm-Message-State: AOAM530350Vt+Nv4KrAmYDCE9HkB2xs9e5S8jl/NSX2P2i+AeFGkI0o6
        rLHOHb3LPLTg0CXGAREIOKOI0YGtl/H+HEDo
X-Google-Smtp-Source: ABdhPJwD9rAzFxwDBtwIoYVOmyydM4bpYGMITIhqUE3r3Cz0AXNJcAJErKPRYh1/pQXG1FB8pVrvWw==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr5246937wrp.3.1627681735870;
        Fri, 30 Jul 2021 14:48:55 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.68.125])
        by smtp.gmail.com with ESMTPSA id i186sm3004650wmi.43.2021.07.30.14.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 14:48:55 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/7] tools: bpftool: update, synchronise and
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210729162932.30365-1-quentin@isovalent.com>
 <CAEf4BzbhmxAXUOoCr7wX-dqkzvQm0OMDLi+A+k6pFs=BCsDY=w@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <c61560c7-47eb-bd86-45cb-131b15cd89c1@isovalent.com>
Date:   Fri, 30 Jul 2021 22:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbhmxAXUOoCr7wX-dqkzvQm0OMDLi+A+k6pFs=BCsDY=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-30 12:06 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Jul 29, 2021 at 9:29 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> To work with the different program types, map types, attach types etc.
>> supported by eBPF, bpftool needs occasional updates to learn about the new
>> features supported by the kernel. When such types translate into new
>> keyword for the command line, updates are expected in several locations:
>> typically, the help message displayed from bpftool itself, the manual page,
>> and the bash completion file should be updated. The options used by the
>> different commands for bpftool should also remain synchronised at those
>> locations.
>>
>> Several omissions have occurred in the past, and a number of types are
>> still missing today. This set is an attempt to improve the situation. It
>> brings up-to-date the lists of types or options in bpftool, and also adds a
>> Python script to the BPF selftests to automatically check that most of
>> these lists remain synchronised.
>>
>> Quentin Monnet (7):
>>   tools: bpftool: slightly ease bash completion updates
>>   selftests/bpf: check consistency between bpftool source, doc,
>>     completion
>>   tools: bpftool: complete and synchronise attach or map types
>>   tools: bpftool: update and synchronise option list in doc and help msg
>>   selftests/bpf: update bpftool's consistency script for checking
>>     options
>>   tools: bpftool: document and add bash completion for -L, -B options
>>   tools: bpftool: complete metrics list in "bpftool prog profile" doc
>>
>>  .../bpf/bpftool/Documentation/bpftool-btf.rst |  48 +-
>>  .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
>>  .../bpftool/Documentation/bpftool-feature.rst |   2 +-
>>  .../bpf/bpftool/Documentation/bpftool-gen.rst |   9 +-
>>  .../bpftool/Documentation/bpftool-iter.rst    |   2 +
>>  .../bpftool/Documentation/bpftool-link.rst    |   3 +-
>>  .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
>>  .../bpf/bpftool/Documentation/bpftool-net.rst |   2 +-
>>  .../bpftool/Documentation/bpftool-perf.rst    |   2 +-
>>  .../bpftool/Documentation/bpftool-prog.rst    |  36 +-
>>  .../Documentation/bpftool-struct_ops.rst      |   2 +-
>>  tools/bpf/bpftool/Documentation/bpftool.rst   |  12 +-
>>  tools/bpf/bpftool/bash-completion/bpftool     |  69 ++-
>>  tools/bpf/bpftool/btf.c                       |   3 +-
>>  tools/bpf/bpftool/cgroup.c                    |   3 +-
>>  tools/bpf/bpftool/common.c                    |  76 +--
>>  tools/bpf/bpftool/feature.c                   |   1 +
>>  tools/bpf/bpftool/gen.c                       |   3 +-
>>  tools/bpf/bpftool/iter.c                      |   2 +
>>  tools/bpf/bpftool/link.c                      |   3 +-
>>  tools/bpf/bpftool/main.c                      |   3 +-
>>  tools/bpf/bpftool/main.h                      |   3 +-
>>  tools/bpf/bpftool/map.c                       |   5 +-
>>  tools/bpf/bpftool/net.c                       |   1 +
>>  tools/bpf/bpftool/perf.c                      |   5 +-
>>  tools/bpf/bpftool/prog.c                      |   8 +-
>>  tools/bpf/bpftool/struct_ops.c                |   2 +-
>>  tools/testing/selftests/bpf/Makefile          |   1 +
>>  .../selftests/bpf/test_bpftool_synctypes.py   | 586 ++++++++++++++++++
>>  29 files changed, 802 insertions(+), 96 deletions(-)
>>  create mode 100755 tools/testing/selftests/bpf/test_bpftool_synctypes.py
>>
>> --
>> 2.30.2
>>
> 
> The patch set name ends abruptly at "synchronise and "... And what? I
> need to know :)

"... and validate types and options" is the missing part. I noticed
after sending -_-. My editor wrapped the Subject: line, resulting in a
truncation. I'll fix for v2 to relieve readers from the suspense :).

> 
> Overall, it looks good, though I can't speak Python much, so I trust
> the script works and we'll fix whatever is necessary as we go. I had
> one small real nit about not re-formatting tons of existing lines for
> no good reason, let's keep Git blame a bit more useful.
> 
> Also, it doesn't seem like you are actually calling a new script from
> selftests/bpf/Makefile, right? That's good, because otherwise any UAPI
> change in kernel header would require bpftool changes in the same
> patch.

Hmm. Ha. Certainly I wouldn't do such a thing. Please don't look again
at patch 2, and let's focus on v2. 0:)

> But once this lands, we should probably run this in
> kernel-patches CI ([0]) and, maybe, not sure, libbpf CI ([1]) as well.
> So please follow up with that as well afterwards, that way you won't
> be the only one nagging people about missed doc updates.
> 
>   [0] https://github.com/kernel-patches/vmtest/tree/master/travis-ci/vmtest
>   [1] https://github.com/libbpf/libbpf/tree/master/travis-ci/vmtest
> 

What's the process to add them to the CI (did I miss some doc)? Should I
just go for a GitHub PR once the script is merged in bpf-next, or do you
have a tool to mirror the relevant scripts? Do we need to have the
Python script in the kernel repo if we don't run it as part of the
selftest suite, by the way?
