Return-Path: <bpf+bounces-9728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F013B79C7C4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2961C20AD2
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610517723;
	Tue, 12 Sep 2023 07:11:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D6171DA
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:11:53 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8AE78
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:11:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso3751754a12.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502713; x=1695107513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t0udRiXjhYOvxVMqfWNiG3ptcHFZyJFhFtiEzZwrt0=;
        b=D2kAnvjrk5S2aNnzZkan5+RoAtPLlXFSmjA+pxy+7UzMyFJ/OHo8M6176VaGL1nWCK
         zC4jZhbIjyu/sm8n4+as7AGzu2sXWJyvRUSTbtaKWdNw1sUVcSsOKFzIxqI/mCkKjuN3
         MjspG489auun8Eaxb5ifKcGbY/0XFpSiIhr+DoMYrFKt7o9sWsAf14HW3aTtyYq6VDDp
         N8Hg0Xs16YSlmDca3ZL7aUzjEizkapJPoyRyKvCHPuZbiLXweCBW4G3oeG65TOuZa0kA
         RIGB4Xf9gOtO2QXN/3RmcHl/PakJqPKPs+Ep7POAzz+8EPFSHQolDJIF1Esk82KofDfH
         bD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502713; x=1695107513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9t0udRiXjhYOvxVMqfWNiG3ptcHFZyJFhFtiEzZwrt0=;
        b=u4nPxTpJndl1pPQYH2OAszxRJN0EqHBlneDD9HTQefiriwGogyhIAXMzMXYQ8/NguW
         Yp+nT1nVXGBe7oCVm/wKpM9ROg/NYMnLWTc1kulDEMGEGfKvO5QOjbI/jFWnBzZNNsxz
         KdFuQLCkqIZYjDnsbwjhuyuWDgLgY+409nMzsP5KfD3TkBASajGWA9xkWXWqu4/+ufwe
         RzGkClCAyUI237mpDNOzLEznsNt9GJtlcpBEfXDjGlL0Kq+SjXhNDeGW7UX5XkyX/8Zf
         P7xuU4gP+hykCGgU3fyp8oG1Jzg8EFiLA4zxq92Cea2GU7fSPfMVIkWFSovKPRtSuGLm
         GJSg==
X-Gm-Message-State: AOJu0YzJs+yotXcWzQ71N5KmIXf4/OK/SyOhztlmdWgPYbEY8YD2Jvhk
	mzhP2Fi7qNnOwQEZ7cepUt8F9pPihnbKVn8bM5s=
X-Google-Smtp-Source: AGHT+IHXPZ3Bxyk/SMdB9Cb7Z0JxPDyUlTQsQ3eM9jNpudKNWZJy+jqIlCyTMQDEa3+ucZSY+po2rg==
X-Received: by 2002:a05:6a20:12c4:b0:133:be9d:a8d3 with SMTP id v4-20020a056a2012c400b00133be9da8d3mr11252087pzg.14.1694502712756;
        Tue, 12 Sep 2023 00:11:52 -0700 (PDT)
Received: from [10.254.144.32] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78515000000b0068a414858bdsm6681307pfn.118.2023.09.12.00.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:11:52 -0700 (PDT)
Message-ID: <09a0a33a-57c5-a81d-1b5b-982aa0e0441d@bytedance.com>
Date: Tue, 12 Sep 2023 15:11:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next v2 0/6] Add Open-coded process and css iters
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/9/12 15:01, Chuyi Zhou 写道:
> Hi,
> 
> This is version 2 of process and css iters support. All the changes were
> suggested by Alexei.
> 
> Thanks for your review!
> 
> --- Changelog ---
> Changes from v1:
> - Add a pre-patch to make some preparations before supporting css_task
>    iters.
> - Add an allowlist for css_task iters
> - Let bpf progs do explicit bpf_rcu_read_lock() when using process iters
> and css_descendant iters.

Sorry for missing the link to v1 
(https://lore.kernel.org/lkml/20230827072057.1591929-1-zhouchuyi@bytedance.com/).


> ---------------------
> 
> In some BPF usage scenarios, it will be useful to iterate the process and
> css directly in the BPF program. One of the expected scenarios is
> customizable OOM victim selection via BPF[1].
> 
> Inspired by Dave's task_vma iter[2], this patchset adds three types of
> open-coded iterator kfuncs:
> 
> 1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
> itearing all tasks in the system.
> 
> 2. bpf_for_each(css_task, task, css). It works like
> css_task_iter_{start, next, end} and would be used to iterating
> tasks/threads under a css.
> 
> 3. bpf_for_each(css_{post, pre}, pos, root_css). It works like
> css_next_descendant_{pre, post} to iterating all descendant css.
> 
> BPF programs can use these kfuncs directly or through bpf_for_each macro.
> 
> link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
> link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/
> 
> Chuyi Zhou (6):
>    cgroup: Prepare for using css_task_iter_*() in BPF
>    bpf: Introduce css_task open-coded iterator kfuncs
>    bpf: Introduce process open coded iterator kfuncs
>    bpf: Introduce css_descendant open-coded iterator kfuncs
>    bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
>    selftests/bpf: Add tests for open-coded task and css iter
> 
>   include/linux/cgroup.h                        |  12 +-
>   include/uapi/linux/bpf.h                      |  16 ++
>   kernel/bpf/helpers.c                          |  12 ++
>   kernel/bpf/task_iter.c                        | 130 +++++++++++++++++
>   kernel/bpf/verifier.c                         |  53 ++++++-
>   kernel/cgroup/cgroup.c                        |  18 ++-
>   tools/include/uapi/linux/bpf.h                |  16 ++
>   tools/lib/bpf/bpf_helpers.h                   |  24 +++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 138 ++++++++++++++++++
>   .../testing/selftests/bpf/progs/iters_task.c  | 104 +++++++++++++
>   10 files changed, 508 insertions(+), 15 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
> 

