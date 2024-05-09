Return-Path: <bpf+bounces-29161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4618C0B2D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 07:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D50D1F23FAB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E31494AB;
	Thu,  9 May 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZbV0ydz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8701A2C2A
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233808; cv=none; b=KFPsBQf8nqWXksqpKrdGC7qUu0O1zP099KrGDJe/dxqv8CO43a6I0RJBFh5cbUEx9Q7W5Xr8+i8fDy/phnF896uJWaljviVIwDfLUtwmm8IEWo0wC727qKHwb7WYA6KTls9GmoMKDRMEPCvWJ2bpjpQphlvJq5qhmEbMWRy6pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233808; c=relaxed/simple;
	bh=kqZYC64XJ5KtbDifVIEIePIEW4gdhVZiXaKya7dD5/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhhgDfLq3bWBZEK6Y4rzuBI9d9eowCOwGTWGCkePbXKAj8TCgMK9X1FUJKU4yRZk6xyaKsz4NYUrvdm/muNtR5eEdLoNDyKuIR+phMJ8FnNk8IXO/nkJNPvEV4bu+/Atna39z0IltD5zai9Iw5XST4nZaJCWGb2KBJiNZu7Mo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZbV0ydz; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f065bc237aso284097a34.0
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715233806; x=1715838606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5RTgdA5b6xtX4qQuHEQVZIBfTzHqYajOC/YXGXY92o=;
        b=bZbV0ydztdONeSq9Hs+66AMfbnd+5qnmoQT+ZzdReKB2+30xKDrnW4fdd6YjgMQ/9e
         TgnOq/6aaY7bfBnpTM6N9MToQG9433akCVM97ljLV6I19FwolIQLvd0KjJdJ+pB5YjLL
         o+N+6brxTRCatXw96bcX1GsbA4PP4RIiramYewZZpK1E9DbgaMCoK2BlNBoVlOx8yaFk
         P76fq9RkDoCNvIPYqE8PJsOq10FesV1YvF8TNRpOQUkNxMhr9f2bm4NOXzKmcSdVVbBi
         UJqpsw2tkF4BRABnQ/LyM1Ljkf5HksSoqfHsehUkNOO58QFiDHtD3+RO7RglA7eg3gb0
         wY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715233806; x=1715838606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5RTgdA5b6xtX4qQuHEQVZIBfTzHqYajOC/YXGXY92o=;
        b=WbH6Ppej/6SBw3VLzcn+1JLZ/++l/Cp1S+x7Sl2MqtcHZPAPYtaAgkiXzO6AYm5pTw
         fAyO4rRiZeTMhdE3znBHlb0j4/BjA7ZyJw4M7jEwO3a4yU4rgBfQJvYent7YnhSznoJX
         lcFOS676cC9QuT392foWGmJeRT+tI7uUhNNYxp3q83P/Jmok2szs5Z3r64V5osUpSNNR
         MWarfejGE8KeZ86j6qjfp6Q0SvVoVRHuXkbkrvGsia0ZBL1ai/jED2H5bfEPkFMnq6sS
         3mjvB/J+WehOLiBDX1jIqJRRWw6kOk7xL6Y04T/r+kyURvgPuemC92K3FaEwpLdDIq1x
         xx6g==
X-Forwarded-Encrypted: i=1; AJvYcCWV8Ff7PzgI6wyJDMef4/iqjOKBoAHVAsZY1whkG6e3yi/GMPMEK6D+Lxbm8u1gdsaCfKWJByRwA9Qe5Ou/XZBnvHgM
X-Gm-Message-State: AOJu0YwjcmQEnBa0is1ncgyzzlARKnaV0O6b7qTBU542k6CJSPlj6gt1
	j5+z3kTxTu3eAzaYR0/ZyJimsNgZ5s8iwMVP1b+iwhC9qJ/gALgK
X-Google-Smtp-Source: AGHT+IFtdnSqZnib1xsn4KAbZNLt/4csYJ9Q9uh85SO6PqeQQrIzWRM00kBvD57wQjQqNlSXqOrx7A==
X-Received: by 2002:a9d:65c2:0:b0:6f0:54fa:6697 with SMTP id 46e09a7af769-6f0b7836163mr4590180a34.4.1715233805847;
        Wed, 08 May 2024 22:50:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e321:942a:80e1:2a2f? ([2600:1700:6cf8:1240:e321:942a:80e1:2a2f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01cb9eesm137381a34.34.2024.05.08.22.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 22:50:05 -0700 (PDT)
Message-ID: <d66a62fe-cce8-43fe-86e0-f21d98a8c69e@gmail.com>
Date: Wed, 8 May 2024 22:50:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-6-thinker.li@gmail.com>
 <f0f66283-9c11-4fd8-9880-d9bbc6e36b55@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f0f66283-9c11-4fd8-9880-d9bbc6e36b55@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 16:50, Martin KaFai Lau wrote:
> On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
>> Not only a user space program can detach a struct_ops link, the subsystem
>> managing a link can also detach the link. This patch add a kfunc to
>> simulate detaching a link by the subsystem managing it.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 21 ++++++
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 65 +++++++++++++++++++
>>   .../selftests/bpf/progs/struct_ops_detach.c   |  6 ++
>>   3 files changed, 92 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index c89a6414c69f..0bf1acc1767a 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -502,6 +502,26 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
>>   static DEFINE_MUTEX(detach_mutex);
>>   static struct bpf_link *link_to_detach;
>> +__bpf_kfunc int bpf_dummy_do_link_detach(void)
>> +{
>> +    struct bpf_link *link;
>> +    int ret = -ENOENT;
>> +
>> +    mutex_lock(&detach_mutex);
>> +    link = link_to_detach;
>> +    /* Make sure the link is still valid by increasing its refcnt */
>> +    if (link && !atomic64_inc_not_zero(&link->refcnt))
> 
> It is better to reuse the bpf_link_inc_not_zero().

I will export this function to be used by modules.

> 
>> +        link = NULL;
>> +    mutex_unlock(&detach_mutex);
>> +
>> +    if (link) {
>> +        ret = link->ops->detach(link);
>> +        bpf_link_put(link);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>>   BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
>> @@ -529,6 +549,7 @@ BTF_ID_FLAGS(func, 
>> bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_dummy_do_link_detach)
> 
> It should need KF_SLEEPABLE. mutex is used.

To simplify it, spinlock will be used instead.

> 
>>   BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>>   static int bpf_testmod_ops_init(struct btf *btf)
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> index f39455b81664..9f6657b53a93 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -229,6 +229,69 @@ static void test_detach_link(void)
>>       struct_ops_detach__destroy(skel);
>>   }
>> +/* Detach a link from the subsystem that the link was registered to */
>> +static void test_subsystem_detach(void)
>> +{
>> +    LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +            .data_in = &pkt_v4,
>> +            .data_size_in = sizeof(pkt_v4));
>> +    struct epoll_event ev, events[2];
>> +    struct struct_ops_detach *skel;
>> +    struct bpf_link *link = NULL;
>> +    int fd, epollfd = -1, nfds;
>> +    int prog_fd;
>> +    int err;
>> +
>> +    skel = struct_ops_detach__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_detach_open_and_load"))
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
>> +    prog_fd = bpf_program__fd(skel->progs.start_detach);
>> +    if (!ASSERT_GE(prog_fd, 0, "start_detach_fd"))
>> +        goto cleanup;
>> +
>> +    /* Do detachment from the registered subsystem */
>> +    err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +    if (!ASSERT_OK(err, "start_detach_run"))
>> +        goto cleanup;
>> +
>> +    if (!ASSERT_EQ(topts.retval, 0, "start_detach_run retval"))
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
>> +    /* Wait for EPOLLHUP */
>> +    nfds = epoll_wait(epollfd, events, 2, 5000);
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
>> +    bpf_link__destroy(link);
>> +    struct_ops_detach__destroy(skel);
>> +}
>> +
>>   void serial_test_struct_ops_module(void)
>>   {
>>       if (test__start_subtest("test_struct_ops_load"))
>> @@ -239,5 +302,7 @@ void serial_test_struct_ops_module(void)
>>           test_struct_ops_incompatible();
>>       if (test__start_subtest("test_detach_link"))
>>           test_detach_link();
>> +    if (test__start_subtest("test_subsystem_detach"))
>> +        test_subsystem_detach();
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
>> index aeb355b3bea3..139f9a5c5601 100644
>> --- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
>> @@ -29,3 +29,9 @@ struct bpf_testmod_ops testmod_do_detach = {
>>       .test_1 = (void *)test_1,
>>       .test_2 = (void *)test_2,
>>   };
>> +
>> +SEC("tc")
> 
> The bpf_dummy_do_link_detach() uses a mutex. There is no lockdep splat 
> in the test?
> 
>> +int start_detach(void *skb)
>> +{
>> +    return bpf_dummy_do_link_detach();
>> +}
> 

