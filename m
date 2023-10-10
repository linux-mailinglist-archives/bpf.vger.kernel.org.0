Return-Path: <bpf+bounces-11799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1FE7BF56A
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E23281C7F
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5E154B7;
	Tue, 10 Oct 2023 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W9T95a3X"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519BBA57
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 08:14:47 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C521C1
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 01:14:43 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352753fb42eso22596275ab.1
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696925682; x=1697530482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/HoMaOoKR0pGoq+6UqdtbB9lre+T0vb4C/YvnZ/SdQ=;
        b=W9T95a3XtqEx0v4CH8mIMsJXVZ2IUKZG4AhiqXfew0F4/lFxYfoWZN5DnL/LsL5Er6
         KrNweJ+yhgdW6u4CSra47XvDQbyKmPrIoFo6azXuFcTk7iSEKQhqDcAhPC3nUkiNXQHC
         SKfgkFYxjgeRWlMiiu0dU9CAGV0XmyDg6Iye4Qly3CeQ7pM5KLZ9HpjJYUiwy5K1ncFQ
         4AYsx74z6howsHceOQt6AKNLZt4M5OaKdSuiOiwlsZCJwqnTC7gguY7uNK3UwR/X5Rqu
         dELkCWG7+xtYIqgY824Yb+vTaocLnkQUdiciYK9V563lUPOuwknN4u14796V4+LlVGEW
         Gk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696925682; x=1697530482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/HoMaOoKR0pGoq+6UqdtbB9lre+T0vb4C/YvnZ/SdQ=;
        b=HOC7OXYPnCthrJfOJ6wyyIbFH910L1KH2onH+MR4Jnn+8zX13VmBZU75AEHP2bstp5
         XmTqgCXOBRqKwKi6WlW601k/VnjZR+y6uy0YPsKHmkKc6wPpt90PqlXc1TdQMNdJCXJj
         6xlW3BDAMA/X00PcTmjt8Dx/XHrXuQ0AprrC98vLr1s+fHzWP6AW5pdAya284ReU9ePM
         Q2LcfGZO3UqanK9B10S0hmAp+O1CjSxHZEMyEAIHXh+jyf/EF1LDvPnDUaqiDALS2VFJ
         e4ZbxVcSCbvIQ3rhvhg+ifcG/sG7dfZUgQzYnbdCvaXZLRT4KysEqrk2y78vMkU24Qhu
         /LRQ==
X-Gm-Message-State: AOJu0YxdQZ0U2aXGRGSaQRqeurMywCCXH1i0VUBpTXjdb7lPmtDlH+NP
	25FoXKrMXgmV63ooHuvpvhDTMA==
X-Google-Smtp-Source: AGHT+IGOkGKsxfcx84/hXVEjTu9O2t+8khMDt2f/9uKqJftbuY/vAUCFImLmVU2jPzwafwd0XEwYXw==
X-Received: by 2002:a92:cd82:0:b0:351:80c:bc29 with SMTP id r2-20020a92cd82000000b00351080cbc29mr22970088ilb.17.1696925682543;
        Tue, 10 Oct 2023 01:14:42 -0700 (PDT)
Received: from [10.254.8.137] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id z5-20020a633305000000b0057cb5a780ebsm9623492pgz.76.2023.10.10.01.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 01:14:42 -0700 (PDT)
Message-ID: <be35c8c6-16fb-4b9b-b406-7dd4c6f5811b@bytedance.com>
Date: Tue, 10 Oct 2023 16:14:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/8] Add Open-coded task, css_task and css
 iters
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
 <d25f9b70-e958-c229-c275-95ed664bf0ed@iogearbox.net>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <d25f9b70-e958-c229-c275-95ed664bf0ed@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/10/10 16:01, Daniel Borkmann 写道:
> On 10/7/23 2:45 PM, Chuyi Zhou wrote:
>> Hi,
>>
>> This is version 4 of task, css_task and css iters support.
>> Thanks for your review!
>>
>> --- Changelog ---
>>
>> v3 -> 
>> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/
>>
>> * Address all the comments from Andrii in patch-3 ~ patch-6
>> * Collect Tejun's ack
>> * Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
>> * Seperate three BPF program files for selftests (iters_task.c 
>> iters_css_task.c iters_css.c)
> 
> This fails to build BPF selftests:
> 

Yes, thanks for the remind!

I didn't notice this error since it may only occurs when using llvm-16 
to compile the selftest, and when we using gcc, it works OK.
(https://github.com/kernel-patches/bpf/actions/runs/6462875618/job/17545170863)

I can reproduce this error in my environment. Before sending next 
version, I would use LLVM-16 to double check.

Thanks.


> [...]
>   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:6: error: variable 'skel' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:166:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_GE(cg_fd, 0, "cg_create"))
>      TEST-OBJ [test_progs] xdp.test.o
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:162:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_GE(cg_fd, 0, "cg_create"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:190:26: 
> note: uninitialized use occurs here
>            iters_css_task__destroy(skel);
>                                    ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:159:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:154:29: 
> note: initialize the variable 'skel' to silence this warning
>            struct iters_css_task *skel;
>                                       ^
>                                        = NULL
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:7: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>                    if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: 
> note: uninitialized use occurs here
>            iters_css__destroy(skel);
>                               ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:213:3: 
> note: remove the 'if' if its condition is always false
>                    if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:6: 
> error: variable 'skel' is used uninitialized whenever 'if' condition is 
> true [-Werror,-Wsometimes-uninitialized]
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:244:21: 
> note: uninitialized use occurs here
>            iters_css__destroy(skel);
>                               ^~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:209:2: 
> note: remove the 'if' if its condition is always false
>            if (!ASSERT_OK(err, "setup_cgroup_environment"))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/iters.c:195:24: 
> note: initialize the variable 'skel' to silence this warning
>            struct iters_css *skel;
>                                  ^
>                                   = NULL
>    5 errors generated.
>    make: *** [Makefile:605: 
> /tmp/work/bpf/bpf/tools/testing/selftests/bpf/iters.test.o] Error 1
>    make: *** Waiting for unfinished jobs....
>    make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
>    Error: Process completed with exit code 2.

