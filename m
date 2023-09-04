Return-Path: <bpf+bounces-9167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A5790FE6
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06DD280FE7
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 02:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F031396;
	Mon,  4 Sep 2023 02:07:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D6381
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 02:07:16 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4A10A
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 19:07:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso2353925ad.3
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693793231; x=1694398031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQJ9QCa6FQtC3tkMRp9THJpoMasl6gGHI0oe62CLOJk=;
        b=ZZie/J6FYustFTVjWIHzEuDfFlvoMYKrOCuntiWxzLVOZOS4fEmWaW/9kx5sP2YsJi
         fgSoUMJ967bHXSzYk3Sn+xntjYE98lHHW5izJik3jvBr+w8Haa9TfnCXGAs89XyY+V5v
         NtXJvDMTYVLcZDkb0dyMapZUObdC5hwAfRKSHE2+RVxFWWslAmF3b7k+DQrew0JF6bRi
         BcAlfgWc5ejqEALyBHjGHetAGGtVTebFUJLQVzWB18eAPEq0uUx9yZaC0rTkwCUQQbxe
         KjfxMG3G9UWcwCP+mqAXKslcF8R5ehjVHtKjGOTgC095/pQYg9Nuf/PiMSZnSgvcGdk/
         0AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693793231; x=1694398031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lQJ9QCa6FQtC3tkMRp9THJpoMasl6gGHI0oe62CLOJk=;
        b=eqg0B9Sf4TXjYEjQIHyeSczLzyXzKO6XZEkvKgt5Dxk9/zfqYqHsttj5A7+2QBgDbf
         9eT4WWsMh1S0KHVilRmtk72R0NCzuIChHIEmCOXYpSS5DXIyKR3fKjYIbeTjeJVBV5tH
         PAr1HKh/Zcd6ipC/D4mX8zm+8UBLR6VZ/ykLKHSRIbhqohhwewgGBIs6epoMHs4POiYS
         0dS55wiy8jP6w7LCMJdx/AkPoQInQBbylDtuIITaAaTiDvo8g0WvtGUiAOeYBIZp8Bbb
         LDfomD5Wi1RFCdOB/X4cFKKawbJMLmHsWL+pFZO9rwLBLwSqv53iP/fHVNFLjEyxKaQ7
         /5Aw==
X-Gm-Message-State: AOJu0YxTGFwQGirHvzUB7qJmeGZI7csswVsW6xhAJ5aGQCrj/pFdEBFY
	1Mj/w+saSnB6MtUbEii3CBiwS/iAICXLJFxULo8=
X-Google-Smtp-Source: AGHT+IG2Cd0YqVwkNvk8B2ct9yL3AJjzvgEY5++BngaCb9038fb+43O+5ycLCZZTs4tJI5LkRJaG1w==
X-Received: by 2002:a17:903:2605:b0:1c0:93b6:2e4b with SMTP id jd5-20020a170903260500b001c093b62e4bmr5652266plb.33.1693793231173;
        Sun, 03 Sep 2023 19:07:11 -0700 (PDT)
Received: from [10.84.146.222] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001b8a7e1b116sm6545111plb.191.2023.09.03.19.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 19:07:10 -0700 (PDT)
Message-ID: <6ce9d118-912a-df27-c015-17dee5762e1f@bytedance.com>
Date: Mon, 4 Sep 2023 10:07:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next 0/4] Add Open-coded process and css iters
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20230827072057.1591929-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Friendly ping...

在 2023/8/27 15:20, Chuyi Zhou 写道:
> In some BPF usage scenarios, it will be useful to iterate the process and
> css directly in the BPF program. One of the expected scenarios is
> customizable OOM victim selection via BPF[1].
> 
> Inspired by Dave's task_vma iter[2], this patchset adds three types of
> open-coded iterator kfuncs:
> 
> 1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
> itearing all tasks in the system with rcu_read_lock().
> 
> 2. bpf_for_each(css_task, task, css). It works like
> css_task_iter_{start, next, end} and would be used to iterating
> tasks/threads under a css.
> 
> 3. bpf_for_each(css, pos, root_css, {PRE, POST}). It works like
> css_next_descendant_{pre, post} to iterating all descendant css.
> 
> BPF programs can use these kfuncs directly or through bpf_for_each macro.
> 
> link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
> link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/
> 
> Chuyi Zhou (4):
>    bpf: Introduce css_task open-coded iterator kfuncs
>    bpf: Introduce process open coded iterator kfuncs
>    bpf: Introduce css_descendant open-coded iterator kfuncs
>    selftests/bpf: Add tests for open-coded task and css iter
> 
>   include/uapi/linux/bpf.h                      |  13 ++
>   kernel/bpf/helpers.c                          |   9 ++
>   kernel/bpf/task_iter.c                        | 109 ++++++++++++++++
>   tools/include/uapi/linux/bpf.h                |  13 ++
>   tools/lib/bpf/bpf_helpers.h                   |  18 +++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 123 ++++++++++++++++++
>   .../testing/selftests/bpf/progs/iters_task.c  |  83 ++++++++++++
>   7 files changed, 368 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
> 

