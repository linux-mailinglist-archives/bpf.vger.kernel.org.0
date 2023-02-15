Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0068B6974B3
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 04:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBODNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 22:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBODNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 22:13:42 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F572A16B
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 19:13:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ec7c792b1so160915247b3.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 19:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/AAFTBuE2KaU7hLwkAk2+VtBqEh4PsWDoE3E/98iw8=;
        b=q4IugXwFRMDzBMgVurjkAA4NYgocRL5Xu+i+12j7/3P32DB0ItB17+3TarXbLxwK9f
         nUk63uOp8AJ1XqQE/VNlS+HjIaBK0uSBbHlASuKQyLK8pRFqEiFPB0jwDW7UIM12n67X
         oAQZzBdC/C3d9LlBw3AaJo21OZRpJ/tbWyHQNC1xPWQE1mFHXN5yitofdO6K/joy6i2m
         WLYH3uwu1mmTrX4aksFNn2/qfRqepndhJa/3pSkwLF6HbB7QE4at/Tem2qQXi2HjPmRN
         5fsZXa/gD4w5K4GaHSaodJyOT26yB8WWTM06xT5Hthc3hI7OTBPiAOe939GKTPjnAKNB
         Cegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/AAFTBuE2KaU7hLwkAk2+VtBqEh4PsWDoE3E/98iw8=;
        b=s5ZJsi0qo3aPNLuDsfERRYpsLwv+jJskE3Fw0fnE+9zsgnlvRDwSxxMVkBBQEkFZE2
         jKPGdRNXUcAC3/DZd7tT4IyuDhpMhbgIxIhed1gzpBKUvg+m0ho2j8MrgTtoKZlf+7sD
         nWQy14xH629TUrh7+kORWT+17WlRAmokiOQahiKbA4ZJQmfrjmDdB64h/1M7buIAGX4J
         oNOeiTyD82FYliWzHoWW8onGuq3zgqltX/r94qpOxjAnqF/GFPN7b6p0aDZGPs4DGgh6
         ASQM7GyAO7T3deO0axtsptoPHTVzTIECWKFKQDXQrB74n7UuXPhX3ojDl/p7etTWs8Zs
         Vy3w==
X-Gm-Message-State: AO0yUKX+rB/cf383ojmPm/51vOavzm6LbxmcxIXLgR1B4616PPDaNoOk
        Xm8cis00vNA5s2vIlUJBCZ36UTY=
X-Google-Smtp-Source: AK7set9l0PcIefitkqpmg2i1QXn4gcjLUKGr79VYuxwCD5p1Fvxze5f31TBtVVHYoMLK91IZLr9NKzY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a5b:52:0:b0:801:e845:5eb9 with SMTP id
 e18-20020a5b0052000000b00801e8455eb9mr92439ybp.469.1676430820366; Tue, 14 Feb
 2023 19:13:40 -0800 (PST)
Date:   Tue, 14 Feb 2023 19:13:38 -0800
In-Reply-To: <20230215001439.748696-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20230215001439.748696-1-andrii@kernel.org>
Message-ID: <Y+xN4kdLsSB7kJVJ@google.com>
Subject: Re: [PATCH bpf-next 0/3] Fix BPF verifier global subprog context
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

On 02/14, Andrii Nakryiko wrote:
> Fix kernel bug in determining whether global subprog's argument is  
> PTR_TO_CTX,
> which is done based on type names. Currently KPROBE programs are broken.

> Add few tests validating that KPROBE context can be passed to global  
> subprog.
> For that also refactor test_global_funcs test to use test_loader  
> framework.

Acked-by: Stanislav Fomichev <sdf@google.com>

That endless loop+again in the first patch raised my brows a bit.
But I'm assuming they are fine since we are working on a verified
btf_vmlinux at this point...


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

