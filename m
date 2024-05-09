Return-Path: <bpf+bounces-29206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641098C1355
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9AD1F21A19
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E07C132;
	Thu,  9 May 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LikC0b9z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879239460
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274138; cv=none; b=mx3qw/l4g9hFugPlKSFobrhXgK5FC3kYdplZbDV5cgtdoTvimUcfCwtNcJL1AYkjEVyfAPuQJolrjpwiTHPFgBziWD1BZHGt7mMAHhnNHPRLvlIXpl+3fYHnEjeS35Mnb4pu3GYbY6eVZQn0ydGoPyHx6vgtQ5ctxg+19+KIsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274138; c=relaxed/simple;
	bh=i7PEuBogVU7WCkErMLg/agrDlaEjbScuEhGd8JV7KIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiTetk3w8z3lMP2zxkSlmecPKgH9s8hQFwS+ao/ScE6xy2+UHmUAzHCbCa3GV5n1VPMhhD6sSSrGN7FdpUZ67k0nbS8Ai7L229E7ZJvYeCwuJi9m81aVs3Zhx/DSpKBkiCjqAj9IcLxYuzJAS1MDzzMtWOaYBeR+WePT9br9GHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LikC0b9z; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c74b27179dso751909b6e.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715274136; x=1715878936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rw7Zah81pI++uAjwiKzLRB4Mugcn0iBNA/x7zIAAwC4=;
        b=LikC0b9zuO8z0NeEv3o90w0sG8tF01iBfMboSdWjBA5QFLmfSN0iI+JwEplrutKKaC
         4sXiwefVxSQkujKgZb1uuJ9WmmPO2asUn+Ff1wRlRh4gRcuhbqASK1ChMulJ5Nl6GznI
         uJ4jiv8ryPsbfvMLkhX7ZPEJJOjYfpF9u9BASad5CRdo/D+t07I5o77hU4Vz427kzoNP
         ZWYs7DXc6C0kAeK2oTM0dNuyO6PNA5S7Q2jXFR4hDIVLWC+LPK4e7KDiXx5h6Ntqenxw
         q/upY6eVJ1a1w0bAA3HADtEKAiTnoJSuSfDCZVkzIl1gesELzJMgESfqJ6Y7vSeuKGgY
         xr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715274136; x=1715878936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw7Zah81pI++uAjwiKzLRB4Mugcn0iBNA/x7zIAAwC4=;
        b=U8aNDgyRVqzgm+psFDnF5ASiV7slP3Ivht8mrwcBcyzurC0xWJcvKLsaaW5n/CXIyG
         0dyWr08FxuooiU/bmetovkbxV5DhQxuSQflEo0jelq7C1MoUa3ohpgtbgnwh+sJ1n/1z
         6Fbhon4quVGoQhL2thElTf+fU/6ZeRl3jAjVp/lHwiJLSOddEodZ/ndHQO7+lfT7UPsc
         50OgIAblqitPh0CfQsJ1bNpMJPL/1eQ+oWRz/Efg9sjwwH4jkGgezlWEmYfw/imjzQeO
         lsXITlX99vLvok/IF1s5xzUSSOSJ70Tn1iGHaGnlDncYZKJBjp4anHxTG2GHcE2+Jy51
         UKSw==
X-Forwarded-Encrypted: i=1; AJvYcCWp2G5NneuV7THhCJ3XtWfhDV4pFjffkol+z+uV37vbxoYzeF/X3jGNFVMSoB8ABLmW4vRDYi+BIx6vWa/peEsqPiXk
X-Gm-Message-State: AOJu0YwH8zdZLq++An3V0xeH19pr85IotZZEaGGIRStPzqmApB3Gvdaq
	URl8EJLN5B7Aj4siDkkboijIxx/llCm11peXJ3UBP7f1gm+1f3Xh
X-Google-Smtp-Source: AGHT+IEZG5tJVCF/aH4L26l4seFEcjTjpx6Q6rcjNlNxJK2r7B+XCujOyex3Po/NgVLfFgHURiAX4w==
X-Received: by 2002:a54:408f:0:b0:3c8:5553:3beb with SMTP id 5614622812f47-3c9970307b0mr194989b6e.2.1715274134197;
        Thu, 09 May 2024 10:02:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cb76:16d9:1cf9:18f8? ([2600:1700:6cf8:1240:cb76:16d9:1cf9:18f8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fcaad11sm258706b6e.32.2024.05.09.10.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:02:13 -0700 (PDT)
Message-ID: <6c156d6d-02f4-4d9a-aeca-951103894be2@gmail.com>
Date: Thu, 9 May 2024 10:02:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: make sure bpf_testmod
 handling racing link destroying well.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-7-thinker.li@gmail.com>
 <a4a5571b-7536-402b-b099-19a9e54524b3@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a4a5571b-7536-402b-b099-19a9e54524b3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/8/24 17:04, Martin KaFai Lau wrote:
> On 5/6/24 10:56 PM, Kui-Feng Lee wrote:
>> Subsystems that manage struct_ops objects may attempt to detach a link 
>> when
>> the link has been released or is about to be released. The test in
>> this patch demonstrate to developers the correct way to handle this
>> situation using a locking mechanism and atomic64_inc_not_zero().
>>
>> A subsystem must ensure that a link is valid when detaching the link. In
>> order to achieve that, the subsystem may need to obtain a lock to 
>> safeguard
>> a table that holds the pointer to the link being detached. However, the
>> subsystem cannot invoke link->ops->detach() while holding the lock 
>> because
>> other tasks may be in the process of unregistering, which could lead to a
>> deadlock. This is why atomic64_inc_not_zero() is used to maintain the
> 
> Other tasks un-registering in parallel is not the reason for deadlock. 
> The deadlock is because the link detach will call unreg() which usually 
> will acquire the same lock (the detach_mutex here) and there is lock 
> ordering with the update_mutex also. Hence, the link detach must be done 
> after releasing the detach_mutex. After releasing the detach_mutex, the 
> link is protected by its refcnt.

It is what I mean in the commit log. I will rephrase it to emphasize
holding the same lock.

> 
> I think the above should be put as comments in bpf_dummy_do_link_detach 
> for the subsystem to reference later.

ok!

> 
>> link's validity. (Refer to bpf_dummy_do_link_detach() in the previous 
>> patch
>> for more details.)
>>
>> This test make sure the pattern mentioned above work correctly.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> index 9f6657b53a93..1e37037cfd8a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -292,6 +292,48 @@ static void test_subsystem_detach(void)
>>       struct_ops_detach__destroy(skel);
>>   }
>> +/* A subsystem detachs a link while the link is going to be free. */
>> +static void test_subsystem_detach_free(void)
>> +{
>> +    LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +            .data_in = &pkt_v4,
>> +            .data_size_in = sizeof(pkt_v4));
>> +    struct struct_ops_detach *skel;
>> +    struct bpf_link *link = NULL;
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
>> +    bpf_link__destroy(link);
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
>> +    /* The link may have zero refcount value and may have been
>> +     * unregistered, so the detachment from the subsystem should fail.
>> +     */
>> +    ASSERT_EQ(topts.retval, (u32)-ENOENT, "start_detach_run retval");
>> +
>> +    /* Sync RCU to make sure the link is freed without any crash */
>> +    ASSERT_OK(kern_sync_rcu(), "sync rcu");
>> +
>> +cleanup:
>> +    struct_ops_detach__destroy(skel);
>> +}
>> +
>>   void serial_test_struct_ops_module(void)
>>   {
>>       if (test__start_subtest("test_struct_ops_load"))
>> @@ -304,5 +346,7 @@ void serial_test_struct_ops_module(void)
>>           test_detach_link();
>>       if (test__start_subtest("test_subsystem_detach"))
>>           test_subsystem_detach();
>> +    if (test__start_subtest("test_subsystem_detach_free"))
>> +        test_subsystem_detach_free();
>>   }
> 

