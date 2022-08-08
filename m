Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CFC58C79C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiHHLhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiHHLhJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 07:37:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0664E9
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 04:37:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r6so4676244ilc.12
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Y9ph6CDgEbMbD6zI0GgB41BGosHvGtQ24rR5rI3Jt5g=;
        b=ayhXL1UK0hK8otJWZg6929sPd+lXxkIwv+4sqhxUkoUWcaaEPSRO7H3jPfgL5wS6KX
         XYcuUHKWh9xI4xV0eZbsN6r2RDEiC2eAXBhuHoQT/M7SrnPN1pJi2ib/nkpPuxydbPO3
         UCm0WvybtShZZWVhJbjHRaGtnRFl5nslqKWLwiOiqbaH1EGmFmj4RyVbhyKzNfYLlnAb
         bt7xuD09zOqd9A/zXY8VQvXRwKq9JMifPKxKaeW7Y5S4hufVv+Rm9hbzGNKK9bK4TnmB
         HUVgQDNx06/VFmkRhqo8TTJuVYpXgBeTgqiJiQpfivmYXQhzKptaMZ8FBK5eLFK/xt4h
         PLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Y9ph6CDgEbMbD6zI0GgB41BGosHvGtQ24rR5rI3Jt5g=;
        b=HCb752uqVF+6nt0FfZlBvSjoS3iBYomrYMyCa5N7Uo9jq+Gwx7e5QWmjwA//dGQWwE
         K97ANQFbiciUG1nCM8dWY6UFMiXvcEYXbQDAFg5Cu4e+hflD/KFcfarBSrkshmdUiDmV
         b3mtj7ItzvB84lnwcpvQt8s7QCi/iwj13gG/Pl3FEN17ZSGTb25LiB8B9ZA0fo1MwAUo
         RiKlQuQuteyGI6oSFXc3sg5fn2kkigPBe49FW6lBiPHwLlyFKMjH4KLYdkf6uWnMQ/fJ
         a9xODMK7Z0HDKdj5ViEXMd3v6Tzvt6SqNWzd6lWjH/Dhy9hNmyKGB4Az4boyZVNJOFGu
         cdXQ==
X-Gm-Message-State: ACgBeo31gqzAG4FfXZ0HJSKTeoBOebnFzOrDdEu/hUlIIocOx2pkf3sn
        OEWYqiXKNaVRMgtumd/E5gIF+WbnV6aB0/0no5F7EZEv
X-Google-Smtp-Source: AA6agR7PLZuZvqpzZ7LQaVWtxauI3QCXgYchH/05fiBEwajSgOZrhU1PHX8CXcPgTxUVvCso6ZKBaxIcByyL8mcqL5c=
X-Received: by 2002:a05:6e02:198c:b0:2e0:ac33:d22 with SMTP id
 g12-20020a056e02198c00b002e0ac330d22mr3967165ilf.219.1659958627991; Mon, 08
 Aug 2022 04:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220806014603.1771-1-memxor@gmail.com> <20220806014603.1771-4-memxor@gmail.com>
In-Reply-To: <20220806014603.1771-4-memxor@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 8 Aug 2022 13:36:29 +0200
Message-ID: <CAP01T76wGPEgsunzDP=Df0-SGYSLmOZfhN5CzpMkDqodNJ3PDA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 3/3] selftests/bpf: Add test for prealloc_lru_pop bug
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 6 Aug 2022 at 03:46, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Add a regression test to check against invalid check_and_init_map_value
> call inside prealloc_lru_pop.
>
> To actually observe a kind of problem this can cause, set debug to 1
> when running the test locally without the fix. Then, just observe the
> refcount which keeps increasing on each run of the test. With timers or
> spin locks, it would cause unpredictable results when racing.
>
> ...
>
> bash-5.1# ./test_progs -t lru_bug
>       test_progs-192     [000] d..21   354.838821: bpf_trace_printk: ref: 4
>       test_progs-192     [000] d..21   354.842824: bpf_trace_printk: ref: 5
> bash-5.1# ./test_pogs -t lru_bug
>       test_progs-193     [000] d..21   356.722813: bpf_trace_printk: ref: 5
>       test_progs-193     [000] d..21   356.727071: bpf_trace_printk: ref: 6
>
> ... and so on.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
>  tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lru_bug.c b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> new file mode 100644
> index 000000000000..e77b2d9469cb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "lru_bug.skel.h"
> +
> +void test_lru_bug(void)

CI is failing because map_kptr and this test both want to observe
refcount when it is not being touched by either, so marking this
serial_ would fix it (map_kptr takes time so it is better for it to
run in parallel mode).

I will wait for the discussion to conclude before respinning.
