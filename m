Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11904473DD
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhKGQj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 11:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhKGQjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 11:39:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A37C061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 08:36:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e65so13034097pgc.5
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RBIg6sevORHc5CjTwqOJ310R7+5wbcE9iIrn7MIs1F0=;
        b=ZQJKD0/8jctpF8bLHPPh2SdCHFhxtpjAc7AwszvEA1BH8YbTxTby06u6inOeARR9MK
         A258Lck579dqwHejdf3q7XfB7Q1FGRtNFxnbSYuCS9HQPY25ut33zQmWXm2q1QtAhwPA
         a8UPhbqkxtps+5cwaki4rYTec5LZH7r+goRSdr18QmPwGhtJTxlaycG1JaX6COkRG6C0
         gvV6SMNEgzFZcMJM165EBC+mn2tSBsj/6Up8IpPejS0pq0mwK1PUfLC2CWjRHPn8i/Ak
         JswfNfaxO08fz4EysBPNy8Ff5e4L1BaWnHb7iaJAEUZVaLTH2u9WuKumgnfya2mid+oV
         jIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RBIg6sevORHc5CjTwqOJ310R7+5wbcE9iIrn7MIs1F0=;
        b=wSPneHqfMnOJMrkoIzifcK/BilVGqAjY+T73c4TRW4qa9VntJ3NqflF35CglcXvjiF
         dyxt4AWYLPBJpBnSMkrCTBQnu5DN4TkKVLMq3JOfC0ZRwelCPML9W2BF0mH9zwiaOyR0
         sKUJz2tU+XpDQAL0Bf57H1nqGt73Wss4r9JCgF5XJwToRqSd3RfLlMBFJRtX7fw8aBup
         ArOH9beKKQyxHtN+werjHYGHsHY0znkgoZM7dM/P4LlJ2RBRMIALdJKMv2kDCKt3ivZ3
         oOEqby00u/VvErrAlwuNGvOIND9F6hBSHrKscwHe+7aN6eBVE/VrwhSr6SM0tdo2Z6/u
         36hg==
X-Gm-Message-State: AOAM532VQhbg5IjMrAuZoZPOgPVF1fB+PAQxM3RVNGh5aWKLQgr4Fjgk
        vrRFB79MIasEay7nlUO2pd1uPTcUjsZzZw==
X-Google-Smtp-Source: ABdhPJwWMJ9auSdjJgA4ci9XGCFnxvkoW4d7bx3UJn6mKns9LxJxvhKewfKJLmXJwadpaNesnygZkA==
X-Received: by 2002:a63:7d0f:: with SMTP id y15mr55267156pgc.446.1636303002611;
        Sun, 07 Nov 2021 08:36:42 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id s28sm5121259pfg.147.2021.11.07.08.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 08:36:41 -0800 (PST)
Message-ID: <134771f5-0218-17e6-3781-6f6fcd1f944d@gmail.com>
Date:   Mon, 8 Nov 2021 00:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 0/9] Fix leaks in libbpf and selftests
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20211107040343.583332-1-andrii@kernel.org>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/11/7 12:03 PM, Andrii Nakryiko wrote:
> Fix all the memory leaks reported by ASAN. All but one are just improper
> resource clean up in selftests. But one memory leak was discovered in libbpf,
> leaving inner map's name leaked.
> 
> First patch fixes selftests' Makefile by passing through SAN_CFLAGS to linker.
> Without that compiling with SAN_CFLAGS=-fsanitize=address kept failing.
> 
> Running selftests under ASAN in BPF CI is the next step, we just need to make
> sure all the necessary libraries (libasan and liblsan) are installed on the
> host and inside the VM. Would be great to get some help with that, but for now
> make sure that test_progs run is clean from leak sanitizer errors.
> 
> v1->v2:
>   - call bpf_map__destroy() conditionally if map->inner_map is present.
> 
> Andrii Nakryiko (9):
>   selftests/bpf: pass sanitizer flags to linker through LDFLAGS
>   libbpf: free up resources used by inner map definition
>   selftests/bpf: fix memory leaks in btf_type_c_dump() helper
>   selftests/bpf: free per-cpu values array in bpf_iter selftest
>   selftests/bpf: free inner strings index in btf selftest
>   selftests/bpf: clean up btf and btf_dump in dump_datasec test
>   selftests/bpf: avoid duplicate btf__parse() call
>   selftests/bpf: destroy XDP link correctly
>   selftests/bpf: fix bpf_object leak in skb_ctx selftest
> 
>  tools/lib/bpf/libbpf.c                                   | 5 ++++-
>  tools/testing/selftests/bpf/Makefile                     | 1 +
>  tools/testing/selftests/bpf/btf_helpers.c                | 9 +++++++--
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 1 +
>  tools/testing/selftests/bpf/prog_tests/btf.c             | 6 ++----
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c        | 8 ++++++--
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 2 +-
>  .../testing/selftests/bpf/prog_tests/migrate_reuseport.c | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/skb_ctx.c         | 2 ++
>  9 files changed, 26 insertions(+), 12 deletions(-)
> 

For the series, feel free to add:

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

