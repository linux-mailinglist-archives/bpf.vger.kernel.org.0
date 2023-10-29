Return-Path: <bpf+bounces-13566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C27DAA85
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 03:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C9D281744
	for <lists+bpf@lfdr.de>; Sun, 29 Oct 2023 02:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C664D;
	Sun, 29 Oct 2023 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0w/HWFK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713738A
	for <bpf@vger.kernel.org>; Sun, 29 Oct 2023 02:34:25 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4221C9
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 19:34:23 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a877e0f0d8so38053967b3.1
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 19:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698546863; x=1699151663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kP5TYqOpckv2oidhfvFQ65R18JOcGrLBG2ZlJfCzw2Q=;
        b=F0w/HWFKq/MNstECmlM9eTrPMEbTuXXBv/s46vGXPuN1KqAMHWM/MCttK4MkoCoPm0
         z0xdRuYoyopBiiKYFP4dxVGZdzytPC5Fnykq/y/TTyX7xoLB0Edj1okcApy1lyDCxLGG
         2vrF6MzacvcHjlmbHVrk0H3bL4mMzx8+Ch+NaIbPmRlOp5YF4WFZtRrtHW1+dUfANkcp
         7P+EqrllK0AFJgRjO4cwGT+E9athxAM38zFaUhrXQWv+foXcXoPAxuWD1zX+2oIjS8Ye
         t01o/Moc2WOUG9lZOZaZfNYwtKpOD+OTfukzqov1DIoEPAwdAIqLrqgLrityFw8rTnbC
         gsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698546863; x=1699151663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP5TYqOpckv2oidhfvFQ65R18JOcGrLBG2ZlJfCzw2Q=;
        b=Mnpgdx5jDNt0Q6T6FkAdBTufy1HfUZq979udXwwhRbZvuDAVpCjXu4C5pldi91u2tv
         OpJiCl2PwBb7FlYZcYr58bxDM9Y670X5yrL9/jk+DKAU+lJMTvcFBIydv/8MpUrk9RIX
         QDSgMh5T9VSSin8PNBJW2IMd7rEF+t1YUpgok7ALAJFahFfxZoffv6HAnmfeGSYtpdVa
         a+c7OwJxPFgwJlghByju8VdgkHGV7tLqdHRSpPcdPXqKnI6pst7j+xCXHqH5P0cLmDnE
         +N1NtL6RRHErYF6al9fR6i+q8RbVH7CxcyRKfnScJcOBtZ+dtQxzsIAy1B4TmunmxUe5
         XEmQ==
X-Gm-Message-State: AOJu0YwALeAAk+sr7B7feR2qNxXZlqhb3QNFkZomMxhdXLD4em6R/j5d
	IT37F6iokNMI+kPRQFN0qaw=
X-Google-Smtp-Source: AGHT+IEBm8K2pfOJkywKrdazeYEliyZquV/aQkNc6rF6vpZWkJO7ZFUe8JOY+OKMUqvje415KdsGpA==
X-Received: by 2002:a05:690c:708:b0:5a7:b53a:3223 with SMTP id bs8-20020a05690c070800b005a7b53a3223mr13310217ywb.21.1698546863077;
        Sat, 28 Oct 2023 19:34:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6208:ded0:c5ca:2313? ([2600:1700:6cf8:1240:6208:ded0:c5ca:2313])
        by smtp.gmail.com with ESMTPSA id d14-20020a81ab4e000000b005a8c392f498sm2516909ywk.82.2023.10.28.19.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 19:34:22 -0700 (PDT)
Message-ID: <8fc15ddb-c096-4188-8f70-4d93293dd4cf@gmail.com>
Date: Sat, 28 Oct 2023 19:34:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231022050335.2579051-1-thinker.li@gmail.com>
 <20231022050335.2579051-11-thinker.li@gmail.com>
 <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/23 13:31, Eduard Zingerman wrote:
> On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
>> module. When a struct_ops object is registered, the bpf_testmod module will
>> invoke test_2 from the module.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Hello,
> 
> Sorry for the late response, was moving through the patch-set very slowly.
> Please note that CI currently fails for this series [0], reported error is:
> 
> testing_helpers.c:13:10: fatal error: 'rcu_tasks_trace_gp.skel.h' file not found
>     13 | #include "rcu_tasks_trace_gp.skel.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I get the same error when try to run tests locally (after full clean).
> On the other hand it looks like `kern_sync_rcu_tasks_trace` changes
> are not really necessary, when I undo these changes but keep changes in:
> 
> - .../selftests/bpf/bpf_testmod/bpf_testmod.c
> - .../selftests/bpf/bpf_testmod/bpf_testmod.h
> - .../bpf/prog_tests/test_struct_ops_module.c
> - .../selftests/bpf/progs/struct_ops_module.c
> 
> struct_ops_module/regular_load test still passes.
> 
> Regarding assertion:
> 
>> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> 
> Could you please leave a comment explaining why the value is 7?
> I don't understand what invokes 'test_2' but changing it to 8
> forces test to fail, so something does call 'test_2' :)
> 
> Also, when running test_maps I get the following error:
> 
> libbpf: bpf_map_create_opts has non-zero extra bytes
> map_create_opts(317):FAIL:bpf_map_create() error:Invalid argument (name=hash_of_maps)

According to what Andrii Nakryiko said,
once [1] is landed, this error should be fixed.

[1] https://lore.kernel.org/all/20231029011509.2479232-1-andrii@kernel.org/


> 
> [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231022050335.2579051-11-thinker.li@gmail.com/
>      (look for 'Logs for x86_64-gcc / build / build for x86_64 with gcc ')
> 
[...]


