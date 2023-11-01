Return-Path: <bpf+bounces-13771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7E7DDA17
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A362281824
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833D1859;
	Wed,  1 Nov 2023 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6+4sLWe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71835184F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 00:32:50 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440010C6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:31:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da37522a363so1564446276.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798637; x=1699403437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1QWe/WzF4h5g7IAlpUKTip95GZKYYSkDhyEOswipJQ=;
        b=M6+4sLWeQkah6qHOWOe3zVtRHXZdBdJLUsTDrJ6yKMupV67kyqIN69lvmbHIjr2FnI
         G/A69rHLagfoYCBL7hZu3KwJPxzQzsQRWUTve7MSQCTg1207Xb5qiYjUNXXUbJbgYIQo
         MnrQ2bTo9YILj/Bji3AsCxvtI3fMvMGXPAy0wNQQO1nyEqUYy9S7KqRJs+5iwjjNc8Bx
         8TxCAt88wRa3N84OPx5e8Cu9XDNGUB9I0lvFeN3JmlTRllsm+ZpaPYwhefB7feHZCGo0
         cKrkr42fGyoZkVAX/rz7sLc+iGndgqh8C1+OrO9J6O7AxqBQTIdKd4KJJiD1Qto5ubHM
         goKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798637; x=1699403437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1QWe/WzF4h5g7IAlpUKTip95GZKYYSkDhyEOswipJQ=;
        b=KB/Hia21PoKk049YoY07PcsmcugOYGJ7Y9F6hNGSQZubtB+yKvhxXxFRSrMeHdiand
         kKi7y03Xao/3jynyNFfpSgNtCrbGB4IbuteP13BBdgFOr5kf9HaZv7ziivacdmAEDl32
         X7yF8ls9YPknRsqPSwC4Y27n0hr2QwSUqinpWkxOprAk6nNFVjqrAuAq68HMlSr/a/Ll
         45Uy6cNt7kA5p7ChH0FOtjNMpLZG8zGKAS03zJa/OLLcjMoZby/hECGQ3YM8wZ8WjxBp
         wnZZ25ibmPoKLg1faO6kaFV3mUC62wCDXDRnIc5vlXqVidhggXLGqPRhKBo5OKJhrNof
         qEIA==
X-Gm-Message-State: AOJu0Yy9Sse1t/Mt2IXGb4drwPMKUATVYb4Ntw0BZ68nES+QSdz9cHn/
	xgVTv01RiCEE8IwWO1RF0m1rZXLu/b0=
X-Google-Smtp-Source: AGHT+IHVVwifS616MirL+ZjgZiCXUV4Qaba5Loo4uJikrX/1U8AIom1KsNM8Qzn07quFOxZo+wJToA==
X-Received: by 2002:a25:30d:0:b0:d15:7402:f7cd with SMTP id 13-20020a25030d000000b00d157402f7cdmr15414185ybd.27.1698798637599;
        Tue, 31 Oct 2023 17:30:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id p188-20020a2574c5000000b00d974c72068fsm1467561ybc.4.2023.10.31.17.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:30:37 -0700 (PDT)
Message-ID: <c1267fed-e982-46ab-b0c7-83bed4108cd3@gmail.com>
Date: Tue, 31 Oct 2023 17:30:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-11-thinker.li@gmail.com>
 <ee0d2862-7bc8-76da-1eca-30b3c80858a0@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ee0d2862-7bc8-76da-1eca-30b3c80858a0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/30/23 23:59, Martin KaFai Lau wrote:
> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> new file mode 100644
>> index 000000000000..3a00dc294583
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <time.h>
>> +
>> +#include "rcu_tasks_trace_gp.skel.h"
>> +#include "struct_ops_module.skel.h"
>> +
>> +static void test_regular_load(void)
>> +{
>> +    struct struct_ops_module *skel;
>> +    struct bpf_link *link;
>> +    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +    int err;
>> +
>> +    skel = struct_ops_module__open_opts(&opts);
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>> +        return;
>> +    err = struct_ops_module__load(skel);
>> +    if (!ASSERT_OK(err, "struct_ops_module_load"))
>> +        return;
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>> +    ASSERT_OK_PTR(link, "attach_test_mod_1");
>> +
>> +    /* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
>> +    ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
>> +
>> +    bpf_link__destroy(link);
>> +
>> +    struct_ops_module__destroy(skel);
>> +}
>> +
>> +void serial_test_struct_ops_module(void)
>> +{
>> +    if (test__start_subtest("regular_load"))
>> +        test_regular_load();
> 
> Could it also add some negative tests, e.g. missing 'struct 
> bpf_struct_ops_common_value', reg() when the module is gone...etc.
> 
> [ ... ]
> 
>> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
>> +static int kern_sync_rcu_tasks_trace(void)
> 
> With patch 4, is it still needed?

Patch 4 shortens time of holding the module, but it still can happen
since bpf_link_put() is performed asynchronously.

> 
>> +{
>> +    struct rcu_tasks_trace_gp *rcu;
>> +    time_t start;
>> +    long gp_seq;
>> +    LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +
>> +    rcu = rcu_tasks_trace_gp__open_and_load();
>> +    if (IS_ERR(rcu))
>> +        return -EFAULT;
>> +    if (rcu_tasks_trace_gp__attach(rcu))
>> +        return -EFAULT;
>> +
>> +    gp_seq = READ_ONCE(rcu->bss->gp_seq);
>> +
>> +    if 
>> (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
>> +                   &opts))
>> +        return -EFAULT;
>> +    if (opts.retval != 0)
>> +        return -EFAULT;
>> +
>> +    start = time(NULL);
>> +    while ((start + 2) > time(NULL) &&
>> +           gp_seq == READ_ONCE(rcu->bss->gp_seq))
>> +        sched_yield();
>> +
>> +    rcu_tasks_trace_gp__destroy(rcu);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Trigger synchronize_rcu() in kernel.
>>    */
>>   int kern_sync_rcu(void)
>>   {
>> +    if (kern_sync_rcu_tasks_trace())
>> +        return -EFAULT;
>>       return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>>   }
> 

