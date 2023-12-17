Return-Path: <bpf+bounces-18111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D5815DE6
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B7B1C21176
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58941859;
	Sun, 17 Dec 2023 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhfvYMt2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68341849
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f50307a1fso178906985a.3
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 23:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702798346; x=1703403146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6NhZXlCGAdCAlck267aDYKH/LyZKZnMPBeOrGIRf2k=;
        b=GhfvYMt2ohsfe/yyhhWZ8vMJ5zz4CyqNOry5sDAVH53V1Bd36J4sBJgo1JBxuOwNU3
         etbmJOy5btkyZ/MoqwyVwL29hmnDhX/RuuyhRonurVamZPu8khsxU8bKMu9MvyZg8vkK
         oFj2MIrAcu0sFUXJpDQQsdvr+2xthg6K+EWd9fD+NmxIopQGlS6OU+gQooCN6+D+uAnT
         bBUM0HsB6t4i7IK1/dMQFgts2txsnW6pT/0dxuywfsST3gqnXhavp5lEtYlnokWz2bvx
         oKRul8N8EvWfwmmlUS4AYPFkQlYorZYZAZS3gWX+qjowoVgjgw9x9cYvYwhvzW6eXvqf
         ZEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702798346; x=1703403146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6NhZXlCGAdCAlck267aDYKH/LyZKZnMPBeOrGIRf2k=;
        b=mSKyz5n/yvm5vq3LfdsrDDGHGg00ccwEcp6cg0zyIdHwSMI7b/eQm+ixCF+2VHNUEg
         ILwdozueFEZpZP0O3IN5kBWmLNir2ThnHBziEx3ELW5eOx2PMFNRdWqWwT2eakYPW4Ky
         U/m1KHPgpQq29F7Tq2kUMjyxAfyL6evEmAJO+YmRCRgiQcn8bHacX0Rbfv1Drpp1wgng
         UMjviXQ6YmF+bZ9kph8tfBq5o35iCx5gunJNMQjtSDsz6+ZiJLiW76AJUDV51GxPfO6Y
         N0AjjaNRyS55N594JzpzpcskEBS8sunrs+NaB0VQHbEszVnd5zrh+bcvhP66NuO4hrTd
         QTBw==
X-Gm-Message-State: AOJu0YxDsPySTDL+TAo4254Wqa0U7FKuQ8+t7IrAUrpg1fHC9nq+Z13M
	vX3rz7+76Ig8B+AUAldS9wA=
X-Google-Smtp-Source: AGHT+IHBdFGr+TeHbiqmxqJ2vdFgBckNWC+Q/PTPmYYOwHftAsdvX5emG5Xj+4TzgKsQJatA7iwWxw==
X-Received: by 2002:a05:620a:378a:b0:77f:7e6d:3153 with SMTP id pi10-20020a05620a378a00b0077f7e6d3153mr9988840qkn.51.1702798345652;
        Sat, 16 Dec 2023 23:32:25 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf? ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id y3-20020a25ad03000000b00dbcd3e5ae6asm3135170ybi.37.2023.12.16.23.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 23:32:25 -0800 (PST)
Message-ID: <ee53a95d-cded-46d6-947a-55a9d200b09b@gmail.com>
Date: Sat, 16 Dec 2023 23:32:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 13/14] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-14-thinker.li@gmail.com>
 <83daf2e3-6e2e-45f2-9a54-32fac1c98cde@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <83daf2e3-6e2e-45f2-9a54-32fac1c98cde@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 23:17, Martin KaFai Lau wrote:
> On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> new file mode 100644
>> index 000000000000..55a4c6ed92aa
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <time.h>
>> +
>> +#include "struct_ops_module.skel.h"
>> +#include "testmod_unload.skel.h"
>> +
>> +static void test_regular_load(void)
>> +{
>> +    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +    struct struct_ops_module *skel;
>> +    struct testmod_unload *skel_unload;
>> +    struct bpf_link *link_map_free = NULL;
>> +    struct bpf_link *link;
>> +    int err, i;
>> +
>> +    skel = struct_ops_module__open_opts(&opts);
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>> +        return;
>> +
>> +    err = struct_ops_module__load(skel);
>> +    if (!ASSERT_OK(err, "struct_ops_module_load"))
>> +        goto cleanup;
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>> +    ASSERT_OK_PTR(link, "attach_test_mod_1");
>> +
>> +    /* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
>> +    ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
>> +
>> +    bpf_link__destroy(link);
>> +
>> +cleanup:
>> +    skel_unload = testmod_unload__open_and_load();
>> +
>> +    if (ASSERT_OK_PTR(skel_unload, "testmod_unload_open"))
>> +        link_map_free = 
>> bpf_program__attach(skel_unload->progs.trace_map_free);
>> +    struct_ops_module__destroy(skel);
>> +
>> +    if (!ASSERT_OK_PTR(link_map_free, "create_link_map_free"))
>> +        return;
>> +
>> +    /* Wait for the struct_ops map to be freed. Struct_ops maps hold a
>> +     * refcount to the module btf. And, this function unloads and then
>> +     * loads bpf_testmod. Without waiting the map to be freed, the next
>> +     * test may fail to unload the bpf_testmod module since the map is
>> +     * still holding a refcnt to the module.
>> +     */
>> +    for (i = 0; i < 10; i++) {
>> +        if (skel_unload->bss->bpf_testmod_put)
>> +            break;
>> +        usleep(100000);
>> +    }
>> +    ASSERT_EQ(skel_unload->bss->bpf_testmod_put, 1, "map_free");
>> +
>> +    bpf_link__destroy(link_map_free);
>> +    testmod_unload__destroy(skel_unload);
>> +}
>> +
>> +static void test_load_without_module(void)
>> +{
>> +    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +    struct struct_ops_module *skel;
>> +    int err;
>> +
>> +    err = unload_bpf_testmod(false);
>> +    if (!ASSERT_OK(err, "unload_bpf_testmod"))
>> +        return;
>> +
>> +    skel = struct_ops_module__open_opts(&opts);
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>> +        goto cleanup;
>> +    err = struct_ops_module__load(skel);
> 
> Both the module btf and the .ko itself are gone from the kernel now?
> This is basically testing libbpf cannot find 'struct bpf_testmod_ops' 
> from the running kernel?

Yes, you are right! So, I just rewrote this by calling bpf_map_create()
instead of calling the skeleton. To simplify the test, I actually use
bpf_map_info of an existing map created from the skeleton as inputs to
bpf_map_create(). And, the btf_obj_id (or btf_vmlinux_id) is used and
tested here.

> 
> How about create another struct_ops_module_notfound.c bpf program:
> SEC(".struct_ops.link")
> struct bpf_testmod_ops_notfound testmod_1 = {
>      .test_1 = (void *)test_1,
>      .test_2 = (void *)test_2,
> };
> 
> and avoid the usleep() wait and the unload_bpf_testmod()?


In order to skip finding module btf for using bpf_map_create(),
I use the skeleton to create a map first to get its bpf_map_info.
So, it still needs to load and unload the same module.

> 
>> +    ASSERT_ERR(err, "struct_ops_module_load");
>> +
>> +    struct_ops_module__destroy(skel);
>> +
>> +cleanup:
>> +    /* Without this, the next test may fail */
>> +    load_bpf_testmod(false);
>> +}
>> +
>> +void serial_test_struct_ops_module(void)
>> +{
>> +    if (test__start_subtest("regular_load"))
>> +        test_regular_load();
>> +
>> +    if (test__start_subtest("load_without_module"))
>> +        test_load_without_module();
>> +}
>> +
> 
> 

