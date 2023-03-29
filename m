Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BA06CF012
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjC2RDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2RDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 13:03:30 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7844A2
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 10:03:02 -0700 (PDT)
Message-ID: <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680109380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HdTulejskKnhhD2fTKS1so6aPSpsIp0mo8E1D1FQNpw=;
        b=FgsqpZlWynLZIDO71XAl/GFW3E7QD6uE3DO5e5zTXnLSBdYUqRDgNQszhxVWogc4U2hR1h
        n95uihqkzVlXeGAQut/CKpttfjYdyJ0CsmMPgtLlu7PJx8btfTjK4Zt9k/UgM+YgscTCMZ
        d4CiftmL+E5L5w7VY7Wq/PWI1n9LKQU=
Date:   Wed, 29 Mar 2023 10:02:55 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage
 creation
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev>
 <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/27/23 8:51 PM, James Hilliard wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>> index 2814bab54d28..7c851c9d5e47 100644
>> --- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>> +++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>> @@ -22,6 +22,13 @@ struct {
>>          __type(value, struct storage);
>>   } sk_storage_map SEC(".maps");
>>
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>> +       __uint(map_flags, BPF_F_NO_PREALLOC);
>> +       __type(key, int);
>> +       __type(value, struct storage);
>> +} task_storage_map SEC(".maps");
>> +
>>   SEC("raw_tp/kmalloc")
>>   int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
>>               size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
>> @@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
>>          return 0;
>>   }
>>
>> +SEC("tp_btf/sched_process_fork")
>> +int BPF_PROG(fork, struct task_struct *parent, struct task_struct *child)
> 
> Apparently fork is a built-in function in bpf-gcc:

It is also failing in a plain C program

#>  gcc -Werror=builtin-declaration-mismatch -o test test.c
test.c:14:35: error: conflicting types for built-in function ‘fork’; expected 
‘int(void)’ [-Werror=builtin-declaration-mismatch]
    14 | int __attribute__((__noinline__)) fork(long x, long y)
       |                                   ^~~~
cc1: some warnings being treated as errors

#> clang -o test test.c
succeed

I am not too attached to the name but it seems something should be addressed in 
the gcc instead.

> 
> In file included from progs/bench_local_storage_create.c:6:
> progs/bench_local_storage_create.c:43:14: error: conflicting types for
> built-in function 'fork'; expected 'int(void)'
> [-Werror=builtin-declaration-mismatch]
>     43 | int BPF_PROG(fork, struct task_struct *parent, struct
> task_struct *child)
>        |              ^~~~
> 
> I haven't been able to find this documented anywhere however.

