Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D62618035
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiKCOyq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiKCOyX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 10:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3BA19C39
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 07:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CF361F12
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE909C43143
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487260;
        bh=+grgp1ZDtQRm+iKSqNoUKVQRaG3zHt2L2Mv91EyiMpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOS2q77iMg3CqaZE/RjDm2zvWx+GLyVGE3Zng6ZqQ+OSK5GWZyPZFkulgnP72dWyz
         lb9jpbkhwKtPIoe2kqInNzs8b17PW3JAgkvljDZ2EZN1ZTCq//Nr3ivde5KMwf7xM2
         bY/NPpyEgyn/WirI09/86YALJrajZ5htFqmD5tyAiNN5zbDVFeuFtE8ozVTvE4UuPb
         dq/a+syefzFwHzRV90KdDJQlgu19kjo5rltYwC+RzjIEHHKqIUPAG4/LywBCF3iRyj
         Z0sCE0DpOCuAKFHOUw2FN3M85Zx2J5nZpUmw86Fjui8k2HmRCZyGcd2j7It8O0mQHV
         07ngxK3wCn2AA==
Received: by mail-lf1-f49.google.com with SMTP id d6so3227019lfs.10
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 07:54:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Z7sdXE+mLaBBSGmwJPBPpg3P5D1L/9SHb1FNpN35Z3z56Soua
        s53QU0gf1sviZ+tWWNrdFFGFAxQDOtwi3pDGx4un7g==
X-Google-Smtp-Source: AMsMyM5quM5NrXkKj/KVEvben9SRRJX01SjoUXGwBtYB9wRlr3JTAiz7Sj7bGNzXhA8NPYFKXT65JZYnoJ8YfUMkM7k=
X-Received: by 2002:a05:6512:1596:b0:4a2:5de8:410a with SMTP id
 bp22-20020a056512159600b004a25de8410amr10783301lfb.627.1667487258680; Thu, 03
 Nov 2022 07:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072129.2325722-1-yhs@fb.com>
In-Reply-To: <20221103072129.2325722-1-yhs@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 15:54:07 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7uWytec60oF1-hRsbVxoDuO9RYZizdChT4Lj7ZJvYcoA@mail.gmail.com>
Message-ID: <CACYkzJ7uWytec60oF1-hRsbVxoDuO9RYZizdChT4Lj7ZJvYcoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Add tests for bpf_rcu_read_lock()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add a few positive/negative tests to test bpf_rcu_read_lock()
> and its corresponding verifier support.
>
>   ./test_progs -t rcu_read_lock
>   ...
>   #145/1   rcu_read_lock/local_storage:OK
>   #145/2   rcu_read_lock/runtime_diff_rcu_tag:OK
>   #145/3   rcu_read_lock/negative_tests:OK
>   #145     rcu_read_lock:OK
>   Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/rcu_read_lock.c  | 101 ++++++++
>  .../selftests/bpf/progs/rcu_read_lock.c       | 241 ++++++++++++++++++
>  2 files changed, 342 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rcu_read_lock.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> new file mode 100644
> index 000000000000..46c02bdb1360
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_read_lock.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates.*/
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>

[...]

> +
> +       task = bpf_get_current_task_btf();
> +
> +       bpf_rcu_read_lock();
> +       real_parent = task->real_parent;
> +       bpf_rcu_read_unlock();

The tests are nice, It would be nice to add a comment on what actually is wrong.

e.g.

/* real_parent is accessed outside the RCU critical section */


> +       (void)bpf_task_storage_get(&map_b, real_parent, 0,
> +                                  BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       return 0;
> +}
> +

[...]

> +       bpf_rcu_read_lock();
> +       bkey = bpf_lookup_user_key(key_serial, flags);
> +       bpf_rcu_read_unlock();
> +        if (!bkey)
> +                return -1;
> +        bpf_key_put(bkey);
> +
> +        return 0;

nit: Spaces here instead of tabs.

> +}
> --
> 2.30.2
>
