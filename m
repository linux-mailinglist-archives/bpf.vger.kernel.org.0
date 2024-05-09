Return-Path: <bpf+bounces-29147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437FF8C085D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A350EB2120E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471310E9;
	Thu,  9 May 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeWEQ0S9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501836C
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214131; cv=none; b=bPIayhGGAytxQmC17G1yK+T10a6syssvZ9ToQz7C2ujFJz6o8BxEV7j+M4WY6DJ8qrJc1k9ddHDKvbzLBB4HawC/IENFbxzbP/+1lfiQQMDtOXfGiU70UXaNvqn2M63/zhAQTMVcxkCNHjnc4jSfRUsuKtq1eAeumW4vJ8B77Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214131; c=relaxed/simple;
	bh=9mvVnAhPK3XuTXqQUiI9a7C2frKTia3+7wSsw4/j7e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qva9EDFVscpBd8NaBk9SRbH0cR7PB93yBaI2C+TFjG813elmO7O7It79niCsUScEulN+0IoBRMczDhdvvzAZ3xI2xKPTf/P8aNO5NTaUXrxYXLPoIqJ4rPpkKF2K0CXq9TYUONIETB9hNDNlbNmOk9213Sf8eCmdQtsFeRb7VI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeWEQ0S9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b215ed1e42so196712eaf.2
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 17:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715214129; x=1715818929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dn+CgFaM8oqlEjS1ASUYv60/di/vapC3OUZjRpAaXmM=;
        b=OeWEQ0S96BGwjYXDY3FTOtvk8GFqg9fc+16C1NQFmirfV6OONTgimmeJXkTuHDYJHw
         1Sa22Y4tt95Qvp4sFZ7pGS9Q+Xr00FDCp3EuGYlLqgQEIL+oRHjh/yPEpNeNxGVivWEm
         yey14XTlIktCU9jUZMArcwDpVI7uETUE9SklizEMixZuInm3rdBGXMg9guY2JbFwYX8v
         ubh1EMvB4PjwfPROlcX+D93xDCMjswpGLRcgBwbaquE4Vp0ZpIel3jTih66f5Hi2sxw5
         Mj2siIjghR21sB7cLEQxfjEjz4jFUElN6n6vHPs+0IHuHtf2ULaWyydTl6JvjR+Dgrlm
         i6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214129; x=1715818929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn+CgFaM8oqlEjS1ASUYv60/di/vapC3OUZjRpAaXmM=;
        b=BgAUvSeSY7uv6i738dt4JN++TyJT5JkKr6rl1WSd9nFFXI+Zi8dq7Wg0rQfphBlEWQ
         MdziP7NUgyqmLKB6EnY+tQDtuRWx0L/qijxkWCHRmTm7/T/iaIN/ypAJ2gRPYm3ET4Bw
         zm5kOJi9t+LuHZdpAzs9Y5SbEtuTqbzAZW2mNhKEy0dgp+ZlHsMA8B9Zh4d2V2+VnCEg
         BhgqZxXmWWvI5CAge8NlsP4U96F0ZmOHeVUuEDkAnUzVpVwIdK8ef7OpmGouTu6xq96A
         MvFAqLc4opdSP/DgrKBaNz2StHnd6lPniSf7wHRhMVgYN4/8MzhL4xsEVf9jUOUVTHdF
         Ap2Q==
X-Gm-Message-State: AOJu0YwlDK1vwbhf0pF/KIpDt+Ga/NmBmeLrznwAExRJuElWKG4Zh/xO
	74vfFYz6Zrh5irDWuWM9qkVx9jWhP/welg9c/wp28Pc8CLB0y5Yh
X-Google-Smtp-Source: AGHT+IEz8c3wMqL/DdB4qJRarOB2UOA6jDIF5UTxGf6rVHnPctFT0tb1Xlt222hC2/THe9S6whn0eg==
X-Received: by 2002:a4a:55d1:0:b0:5b1:d59c:a815 with SMTP id 006d021491bc7-5b24d647137mr3835150eaf.6.1715214128942;
        Wed, 08 May 2024 17:22:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d81:68e7:6cdb:ae69? ([2600:1700:6cf8:1240:d81:68e7:6cdb:ae69])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b26dec43bdsm50716eaf.45.2024.05.08.17.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:22:08 -0700 (PDT)
Message-ID: <696c9521-74df-48f1-a1d8-bf2c49a55319@gmail.com>
Date: Wed, 8 May 2024 17:22:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/6] selftests/bpf: test struct_ops with epoll
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-5-thinker.li@gmail.com>
 <de29eee0-9a69-4f97-b77e-83294dc8ed6f@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <de29eee0-9a69-4f97-b77e-83294dc8ed6f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 16:34, Martin KaFai Lau wrote:
> On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
>> Verify whether a user space program is informed through epoll with 
>> EPOLLHUP
>> when a struct_ops object is detached.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 +++++
>>   .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 57 +++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_detach.c   | 31 ++++++++++
>>   4 files changed, 102 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/struct_ops_detach.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index e24a18bfee14..c89a6414c69f 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/percpu-defs.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/tracepoint.h>
>> +#include <linux/workqueue.h>
>>   #include "bpf_testmod.h"
>>   #include "bpf_testmod_kfunc.h"
>> @@ -498,6 +499,9 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
>>   {
>>   }
>> +static DEFINE_MUTEX(detach_mutex);
>> +static struct bpf_link *link_to_detach;
>> +
>>   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>>   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
>> @@ -577,11 +581,20 @@ static int bpf_dummy_reg(void *kdata, struct 
>> bpf_link *link)
>>       if (ops->test_2)
>>           ops->test_2(4, ops->data);
>> +    mutex_lock(&detach_mutex);
>> +    if (!link_to_detach)
>> +        link_to_detach = link;
>> +    mutex_unlock(&detach_mutex);
>> +
>>       return 0;
>>   }
>>   static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
>>   {
>> +    mutex_lock(&detach_mutex);
>> +    if (link == link_to_detach)
>> +        link_to_detach = NULL;
>> +    mutex_unlock(&detach_mutex);
> 
> The reg/unreg changes should belong to the next patch.
Sure!

> 
>>   }
>>   static int bpf_testmod_test_1(void)
>> diff --git 
>> a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
>> index ce5cd763561c..9f9b60880fd3 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
>> @@ -105,6 +105,7 @@ void bpf_kfunc_call_test_fail1(struct 
>> prog_test_fail1 *p);
>>   void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
>>   void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
>>   void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
>> +int bpf_dummy_do_link_detach(void) __ksym;
> 
> The kfunc is not added in this patch either.

Sure!

> 
>>   void bpf_kfunc_common_test(void) __ksym;
>>   #endif /* _BPF_TESTMOD_KFUNC_H */
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> index bd39586abd5a..f39455b81664 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -2,8 +2,12 @@
>>   /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>>   #include <test_progs.h>
>>   #include <time.h>
>> +#include <network_helpers.h>
> 
> What is needed from network_herlpers.h?
> 
>> +
>> +#include <sys/epoll.h>
>>   #include "struct_ops_module.skel.h"
>> +#include "struct_ops_detach.skel.h"
>>   static void check_map_info(struct bpf_map_info *info)
>>   {
>> @@ -174,6 +178,57 @@ static void test_struct_ops_incompatible(void)
>>       struct_ops_module__destroy(skel);
>>   }
>> +/* Detach a link from a user space program */
>> +static void test_detach_link(void)
>> +{
>> +    struct epoll_event ev, events[2];
>> +    struct struct_ops_detach *skel;
>> +    struct bpf_link *link = NULL;
>> +    int fd, epollfd = -1, nfds;
>> +    int err;
>> +
>> +    skel = struct_ops_detach__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_detach__open_and_load"))
>> +        return;
>> +
>> +    link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
>> +    if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
>> +        goto cleanup;
>> +
>> +    fd = bpf_link__fd(link);
>> +    if (!ASSERT_GE(fd, 0, "link_fd"))
>> +        goto cleanup;
>> +
>> +    epollfd = epoll_create1(0);
>> +    if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
>> +        goto cleanup;
>> +
>> +    ev.events = EPOLLHUP;
>> +    ev.data.fd = fd;
>> +    err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
>> +    if (!ASSERT_OK(err, "epoll_ctl"))
>> +        goto cleanup;
>> +
>> +    err = bpf_link__detach(link);
>> +    if (!ASSERT_OK(err, "detach_link"))
>> +        goto cleanup;
>> +
>> +    /* Wait for EPOLLHUP */
>> +    nfds = epoll_wait(epollfd, events, 2, 500);
>> +    if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
>> +        goto cleanup;
>> +
>> +    if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
>> +        goto cleanup;
>> +    if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
>> +        goto cleanup;
>> +
>> +cleanup:
>> +    close(epollfd);
> 
> Better check epollfd since it is init to -1. There are cases that 
> epollfd is -1 here.

Ok! Although close(-1) doesn't cause any issue, it makes sense doing
check before calling it.

> 
>> +    bpf_link__destroy(link);
>> +    struct_ops_detach__destroy(skel);
>> +}
>> +
>>   void serial_test_struct_ops_module(void)
>>   {
>>       if (test__start_subtest("test_struct_ops_load"))
>> @@ -182,5 +237,7 @@ void serial_test_struct_ops_module(void)
>>           test_struct_ops_not_zeroed();
>>       if (test__start_subtest("test_struct_ops_incompatible"))
>>           test_struct_ops_incompatible();
>> +    if (test__start_subtest("test_detach_link"))
>> +        test_detach_link();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
>> new file mode 100644
>> index 000000000000..aeb355b3bea3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> 
> The _kfunc.h should not be needed in this patch either.

Sure!

> 
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int test_1_result = 0;
>> +int test_2_result = 0;
> 
> Are these global vars tested? If not, can the test_1 and test_2 programs 
> be removed? or some of them is not optional?

Yes, they are optional. I will remove these functions.

> 
>> +
>> +SEC("struct_ops/test_1")
>> +int BPF_PROG(test_1)
>> +{
>> +    test_1_result = 0xdeadbeef;
>> +    return 0;
>> +}
>> +
>> +SEC("struct_ops/test_2")
>> +void BPF_PROG(test_2, int a, int b)
>> +{
>> +    test_2_result = a + b;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops testmod_do_detach = {
>> +    .test_1 = (void *)test_1,
>> +    .test_2 = (void *)test_2,
>> +};
> 

