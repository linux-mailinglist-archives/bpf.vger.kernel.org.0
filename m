Return-Path: <bpf+bounces-13926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847997DEE62
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB981F21D97
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364F7474;
	Thu,  2 Nov 2023 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G1MXUbDy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682979C2
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:53:16 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8796712C
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:53:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bee11456baso705527b3a.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698915190; x=1699519990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVE1366znDDdUGahkb02KC8IFZyefUqtJav8pg5Z4yU=;
        b=G1MXUbDy+LDtqyxAaxBBfz7WbAdz461XRQB3pTmO8zVJse2o1R4uB01S010s6FtqUR
         r7tJ2bA4ePXftcGLGT6JFYpUmljqCUcoIFWcsbizCWl7gvD8E7aEJFRlMejhwYqTjue2
         CoHHRRUjt0CQeEVsZVUXaHo8N9hup+u1eijiJb78WpRH+R9puRZWLFteBV+zr70HSDRB
         kZNt17EgeQ9FuRKOX2z7oU2vtjewyme1km5KqRGVJPsZmZxocI9U0Csq9LUQ6hIgGyq9
         gRY1DqziVSUyukscjQGwQAXEKcZoRxeemgzdu/fAmwBt8vg6BZtCyMcw4t6WdxFBWIEl
         Y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915190; x=1699519990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVE1366znDDdUGahkb02KC8IFZyefUqtJav8pg5Z4yU=;
        b=wb0BG5wjTbciTCadVVVFy9bnDzeMbI3T1yE6b/o7+1kAoUV7ZpN3vST48PGYYiTGVU
         f6CfVMWfsuJFod/B25Iy5XvOaBwUug3cua43sPQNJ6q9ip8Abd8bRtLWxqZJdt9pSuih
         2TeGa746xRuijMaYNpOV47hF3DnCceJ5GIwLZaBSbOaq9uJDqkP8banDPA7mfjn3cymM
         Ed4M3lxmHWIdnTt09GIy4ox4niS2TjozR4e1keEHRUwb6+ewCG3I1jHmIzMHf+LafoBd
         e2aU+xlymHHE/kz3stERBstssuuqB3h+6oBjk0ZQE40VdYwGNNLKVLr+BuwwOS1HuP4o
         y65Q==
X-Gm-Message-State: AOJu0Yyt2tUHHm/+PQKns7yIaPVc3WvAcgBOtYF32WQjwjXwbbfE7Fo+
	GCooA1xotR8b16E/y/Lxfk7NsQ==
X-Google-Smtp-Source: AGHT+IFmL1R/UF0nhz7aD3cuUs+n6jN2r82/CxAkFfbJ0Tsfkn0j6Ww7vsvhb400ENoxqbuA7fqhdg==
X-Received: by 2002:a05:6a21:99a2:b0:153:353e:5e39 with SMTP id ve34-20020a056a2199a200b00153353e5e39mr17559102pzb.51.1698915189954;
        Thu, 02 Nov 2023 01:53:09 -0700 (PDT)
Received: from [10.84.141.101] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001cbf3824360sm2618011plg.95.2023.11.02.01.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:53:09 -0700 (PDT)
Message-ID: <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
Date: Thu, 2 Nov 2023 16:53:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: mainline build failure due to 9c66dc94b62a ("bpf: Introduce css_task
 open-coded iterator kfuncs")
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, regressions@lists.linux.dev,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZUNiwMLBsL52X9wa@debian>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <ZUNiwMLBsL52X9wa@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2023/11/2 16:50, Sudip Mukherjee (Codethink) 写道:
> Hi All,
> 
> The latest mainline kernel branch fails to build mips decstation_64_defconfig,
> decstation_defconfig and decstation_r4k_defconfig with the error:
> 
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |              ^~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
> kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |                                    ^~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
>    925 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
>        |                                                            ^~~~~~
> kernel/bpf/task_iter.c:928:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
>    928 |         css_task_iter_start(css, flags, kit->css_it);
>        |         ^~~~~~~~~~~~~~~~~~~
>        |         task_seq_start
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> kernel/bpf/task_iter.c:938:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
>    938 |         return css_task_iter_next(kit->css_it);
>        |                ^~~~~~~~~~~~~~~~~~
>        |                class_dev_iter_next
> kernel/bpf/task_iter.c:938:16: warning: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Wint-conversion]
>    938 |         return css_task_iter_next(kit->css_it);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> kernel/bpf/task_iter.c:947:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
>    947 |         css_task_iter_end(kit->css_it);
>        |         ^~~~~~~~~~~~~~~~~
> 
> git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> #regzbot introduced: 9c66dc94b62aef23300f05f63404afb8990920b4
> 

Thanks for the report! This issue has been solved by Jiri.[1]

[1]:https://lore.kernel.org/all/169890482505.9002.10852784674164703819.git-patchwork-notify@kernel.org/

