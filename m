Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46944F4610
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 01:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389791AbiDEP04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 11:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiDEPCo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 11:02:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484572C13D
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 06:24:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o10so4981780ple.7
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cd9/Y2D17XcuWIgRiYXbB/cqX8pjST4tGSGws0ad5LM=;
        b=LDIMi6Ds2x7txo4u1N8chKfN7utgymzox1FU7PJIKbDHx39WSq8Ky42xfV5utfkCDO
         nFKuZZPq6cE6OSVCK1go/gQbj9ivhFnPrY42Af5p8nXJzC556Gw3nth6qccJf2BIKNpJ
         pnk66f9fBHH5Jpi0C2KF/6XMOFgOcHfIVhLJ8TEN0QTLl8nLPo0nbNxkvcPmkrNBajrd
         GgBeYwfnOsCo6RkTmUIKJk6ZBRaPO0kkkkNNo6iwXbIYLAOjhtjYqPaj2JfAyR9dn5jc
         O78RE+4GJPTPnbnGuGS8jMHtKpSi1NXLSy2TDHlGwLihch2e57fBvK/N/A/eIwG5Gp7u
         GAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cd9/Y2D17XcuWIgRiYXbB/cqX8pjST4tGSGws0ad5LM=;
        b=TrJlbpWVTHkmqAjaGEsyxJmd8RhKUx/nQ8ftLWNXWsf9S0vx0soShjpCec2ajZFtTM
         gvZyUeZGl+x8gIzCCVqiIGwTeSIGsTYpFkMWaNk4Hd4fIZI7z9pEK5U9Rz9VfWFvQaU+
         zC5x5gZQGy/lewAKNUQ6qFEdvTBIb9oHkq65NZFXPK4zZLlHUXIJ4ukLhZNOLzdyTkfH
         vreZ+VmFTx6RfVbszc1K/KgVcjYT8CXR2o+1SHNFuEF9cOCCF9wrPJAApJ9G2o5MOXWI
         BlB+jzcr45fMuFbscZtpxJiQcZBHA9uhesWnDAk0TXfx0xqBbNIpE9xC5CkcIZL1zXfg
         BufA==
X-Gm-Message-State: AOAM533/o0oniqwrU8bvI+4Clao7/gaoT+30yKnONp3zLVV1JKK/eLjM
        ypMZ4+jQH67mePeiccqcYjk=
X-Google-Smtp-Source: ABdhPJypem/xKXSlZHtHcp/JCJP44vXu2Wec021POnl6mDs3zhehUBZr7hJTlU98aymp8yKT5NI0CQ==
X-Received: by 2002:a17:90b:1b4f:b0:1c6:d91b:9d0 with SMTP id nv15-20020a17090b1b4f00b001c6d91b09d0mr4174352pjb.72.1649165041492;
        Tue, 05 Apr 2022 06:24:01 -0700 (PDT)
Received: from [192.168.255.10] ([163.125.129.230])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm15503057pfb.142.2022.04.05.06.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:24:01 -0700 (PDT)
Message-ID: <278c1ba7-13c8-c83f-9b74-489d10f4fb4b@gmail.com>
Date:   Tue, 5 Apr 2022 21:23:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 bpf-next 0/7] Add libbpf support for USDTs
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
References: <20220404234202.331384-1-andrii@kernel.org>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/4/5 7:41 AM, Andrii Nakryiko wrote:
> Add libbpf support for USDT (User Statically-Defined Tracing) probes.
> USDTs is important part of tracing, and BPF, ecosystem, widely used in
> mission-critical production applications for observability, performance
> analysis, and debugging.
> 
> And while USDTs themselves are pretty complicated abstraction built on top of
> uprobes, for end-users USDT is as natural a primitive as uprobes themselves.
> And thus it's important for libbpf to provide best possible user experience
> when it comes to build tracing applications relying on USDTs.
> 
> USDTs historically presented a lot of challenges for libbpf's no
> compilation-on-the-fly general approach to BPF tracing. BCC utilizes power of
> on-the-fly source code generation and compilation using its embedded Clang
> toolchain, which was impractical for more lightweight and thus more rigid
> libbpf-based approach. But still, with enough diligence and BPF cookies it's
> possible to implement USDT support that feels as natural as tracing any
> uprobe.
> 
> This patch set is the culmination of such effort to add libbpf USDT support
> following the spirit and philosophy of BPF CO-RE (even though it's not
> inherently relying on BPF CO-RE much, see patch #1 for some notes regarding
> this). Each respective patch has enough details and explanations, so I won't
> go into details here.
> 
> In the end, I think the overall usability of libbpf's USDT support *exceeds*
> the status quo set by BCC due to the elimination of awkward runtime USDT
> supporting code generation. It also exceeds BCC's capabilities due to the use
> of BPF cookie. This eliminates the need to determine a USDT call site (and
> thus specifics about how exactly to fetch arguments) based on its *absolute IP
> address*, which is impossible with shared libraries if no PID is specified (as
> we then just *can't* know absolute IP at which shared library is loaded,
> because it might be different for each process). With BPF cookie this is not
> a problem as we record "call site ID" directly in a BPF cookie value. This
> makes it possible to do a system-wide tracing of a USDT defined in a shared
> library. Think about tracing some USDT in libc across any process in the
> system, both running at the time of attachment and all the new processes
> started *afterwards*. This is a very powerful capability that allows more
> efficient observability and tracing tooling.
> 
> Once this functionality lands, the plan is to extend libbpf-bootstrap ([0])
> with an USDT example. It will also become possible to start converting BCC
> tools that rely on USDTs to their libbpf-based counterparts ([1]).
> 
> It's worth noting that preliminary version of this code was currently used and
> tested in production code running fleet-wide observability toolkit.
> 
> Libbpf functionality is broken down into 5 mostly logically independent parts,
> for ease of reviewing:
>   - patch #1 adds BPF-side implementation;
>   - patch #2 adds user-space APIs and wires bpf_link for USDTs;
>   - patch #3 adds the most mundate pieces: handling ELF, parsing USDT notes,
>     dealing with memory segments, relative vs absolute addresses, etc;
>   - patch #4 adds internal ID allocation and setting up/tearing down of
>     BPF-side state (spec and IP-to-ID mapping);
>   - patch #5 implements x86/x86-64-specific logic of parsing USDT argument
>     specifications;
>   - patch #6 adds testing of various basic aspects of handling of USDT;
>   - patch #7 extends the set of tests with more combinations of semaphore,
>     executable vs shared library, and PID filter options.
> 
>   [0] https://github.com/libbpf/libbpf-bootstrap
>   [1] https://github.com/iovisor/bcc/tree/master/libbpf-tools
> 
> v2->v3:
>   - fix typos, leave link to systemtap doc, acks, etc (Dave);
>   - include sys/sdt.h to avoid extra system-wide package dependencies;
> v1->v2:
>   - huge high-level comment describing how all the moving parts fit together
>     (Alan, Alexei);
>   - switched from `__hidden __weak` to `static inline __noinline` for now, as
>     there is a bug in BPF linker breaking final BPF object file due to invalid
>     .BTF.ext data; I want to fix it separately at which point I'll switch back
>     to __hidden __weak again. The fix isn't trivial, so I don't want to block
>     on that. Same for __weak variable lookup bug that Henqi reported.
>   - various fixes and improvements, addressing other feedback (Alan, Hengqi);
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> 
> Andrii Nakryiko (7):
>   libbpf: add BPF-side of USDT support
>   libbpf: wire up USDT API and bpf_link integration
>   libbpf: add USDT notes parsing and resolution logic
>   libbpf: wire up spec management and other arch-independent USDT logic
>   libbpf: add x86-specific USDT arg spec parsing logic
>   selftests/bpf: add basic USDT selftests
>   selftests/bpf: add urandom_read shared lib and USDTs
> 
>  tools/lib/bpf/Build                           |    3 +-
>  tools/lib/bpf/Makefile                        |    2 +-
>  tools/lib/bpf/libbpf.c                        |  115 +-
>  tools/lib/bpf/libbpf.h                        |   31 +
>  tools/lib/bpf/libbpf.map                      |    1 +
>  tools/lib/bpf/libbpf_internal.h               |   19 +
>  tools/lib/bpf/usdt.bpf.h                      |  256 ++++
>  tools/lib/bpf/usdt.c                          | 1280 +++++++++++++++++
>  tools/testing/selftests/bpf/Makefile          |   25 +-
>  tools/testing/selftests/bpf/prog_tests/usdt.c |  421 ++++++
>  .../selftests/bpf/progs/test_urandom_usdt.c   |   70 +
>  tools/testing/selftests/bpf/progs/test_usdt.c |   96 ++
>  .../selftests/bpf/progs/test_usdt_multispec.c |   32 +
>  tools/testing/selftests/bpf/sdt-config.h      |    6 +
>  tools/testing/selftests/bpf/sdt.h             |  513 +++++++
>  tools/testing/selftests/bpf/urandom_read.c    |   63 +-
>  .../testing/selftests/bpf/urandom_read_aux.c  |    9 +
>  .../testing/selftests/bpf/urandom_read_lib1.c |   13 +
>  .../testing/selftests/bpf/urandom_read_lib2.c |    8 +
>  19 files changed, 2938 insertions(+), 25 deletions(-)
>  create mode 100644 tools/lib/bpf/usdt.bpf.h
>  create mode 100644 tools/lib/bpf/usdt.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_urandom_usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec.c
>  create mode 100644 tools/testing/selftests/bpf/sdt-config.h
>  create mode 100644 tools/testing/selftests/bpf/sdt.h
>  create mode 100644 tools/testing/selftests/bpf/urandom_read_aux.c
>  create mode 100644 tools/testing/selftests/bpf/urandom_read_lib1.c
>  create mode 100644 tools/testing/selftests/bpf/urandom_read_lib2.c
> 

For the first 5 patches:

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>

Hengqi
