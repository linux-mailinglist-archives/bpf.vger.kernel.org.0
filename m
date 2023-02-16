Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA91E699B68
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 18:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBPRkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 12:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPRkv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 12:40:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EA247405
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:40:49 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t11-20020a1709028c8b00b00199404808b9so1386681plo.1
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRivMNt7DoJA711HmR1Tokrd/ZOsQ3XJLhIdB9g1aI=;
        b=oGc5tvJBzIg/587viHmClaXUCxUPfkCQgWP49jJG2c5zpA3gzF4gUzw3NV9jFUyVeS
         D3ekwb5Tyqi1+PWVDGHPVE3mKJhzlRHhk3LzBQIMI3QPEoqTc/R5mgS44uIMnh2fEJXW
         V/WodDuW129lH39yBTDQXlUrSz27xxPtrW9X7akpNzZA+N+N4jlInbBG1rjKLriwQiD6
         FDHAz0Y2lRhZ9bMLabaVnCvQMVYjPM23k311wq4i4myC2dNqICh08wVC8pHzqp2k85+I
         AV37M2u6uD7OBvdbNph5UnjrFjS9QxYV5ZoI7W5B/zKJB0vH6jsOcUqFsswGE032YJdf
         OA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRivMNt7DoJA711HmR1Tokrd/ZOsQ3XJLhIdB9g1aI=;
        b=TZprd+Ii7RjtdWzkcVDpe5QdvS5vZO8BFJNdiInMnxtL/IPko/MBPi/dlIPXxiIK9S
         zfzfzXshhOlmCZMKH56RUgSpt1o9MNMsy6tmzkyQnRECi7CPXAouZczZm0HpSXRg1DLb
         w7nOZR6KiIGepgBGrKIDkq1c0Ax2w9L9dCwOJjEWp+0NGh/IK+xITigQ19uxb2VBEfPg
         0jgqQ8yEZgNMBYtrbWCGlZbkOtJD+SnF3HOn240pUf/z03B9M10Eaji+gzLvAr0QO22V
         +e/Rbuc4qMnROsSOXBJKbol3BIufZOZLuFouCil5ANL8T3DJa9AQI46EV04dTmpKzGF9
         /Tlg==
X-Gm-Message-State: AO0yUKWMqZ4IjK/pkAh8pKhWNpAsLevS6UVo289BWpCrG02yDT+5mHDj
        EaX4rjNy3DXjn7GgmJukTEAfEs4=
X-Google-Smtp-Source: AK7set99gd5D1vKOQ2GOUN4VqFM8rYPRhuMpxgBAGvfwEDae+UVk++pbk9N3TnKoBvxlIk5ajVGJn40=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:2784:b0:232:ce4d:8da8 with SMTP id
 pw4-20020a17090b278400b00232ce4d8da8mr642807pjb.143.1676569249324; Thu, 16
 Feb 2023 09:40:49 -0800 (PST)
Date:   Thu, 16 Feb 2023 09:40:47 -0800
In-Reply-To: <20230216045954.3002473-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20230216045954.3002473-1-andrii@kernel.org>
Message-ID: <Y+5qn2EMxN+3RN24@google.com>
Subject: Re: [PATCH v2 bpf-next 0/3] Fix BPF verifier global subprog context
 argument logic
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/15, Andrii Nakryiko wrote:
> Fix kernel bug in determining whether global subprog's argument is  
> PTR_TO_CTX,
> which is done based on type names. Currently KPROBE programs are broken.

> Add few tests validating that KPROBE context can be passed to global  
> subprog.
> For that also refactor test_global_funcs test to use test_loader  
> framework.

> v1->v2:
>    - fix compilation warning on arm64 and s390x by force-casting ctx to
>      `void *`, to discard const from `const struct user_pt_regs *`, when
>      passing it to bpf_get_stack().

Such a shame there isn't something like unconstify(typeof(xxx)) :-(
But thank you for catching this. Need to build a habit of looking at
the buildbot output.

Reposting for patchwork:

Acked-by: Stanislav Fomichev <sdf@google.com>

> Andrii Nakryiko (3):
>    bpf: fix global subprog context argument resolution logic
>    selftests/bpf: convert test_global_funcs test to test_loader framework
>    selftests/bpf: add global subprog context passing tests

>   kernel/bpf/btf.c                              |  13 +-
>   .../bpf/prog_tests/test_global_funcs.c        | 133 +++++-------------
>   .../selftests/bpf/progs/test_global_func1.c   |   6 +-
>   .../selftests/bpf/progs/test_global_func10.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func11.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func12.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func13.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func14.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func15.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func16.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func17.c  |   4 +-
>   .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
>   .../selftests/bpf/progs/test_global_func3.c   |  10 +-
>   .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
>   .../selftests/bpf/progs/test_global_func5.c   |   4 +-
>   .../selftests/bpf/progs/test_global_func6.c   |   4 +-
>   .../selftests/bpf/progs/test_global_func7.c   |   4 +-
>   .../selftests/bpf/progs/test_global_func8.c   |   4 +-
>   .../selftests/bpf/progs/test_global_func9.c   |   4 +-
>   .../bpf/progs/test_global_func_ctx_args.c     | 105 ++++++++++++++
>   20 files changed, 292 insertions(+), 125 deletions(-)
>   create mode 100644  
> tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c

> --
> 2.30.2

