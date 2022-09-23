Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BB5E8513
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiIWVnq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 17:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWVnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:43:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE513FB7D
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:43:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b35so1948735edf.0
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1WxJiMEwTGPWQdWUzu3v6ZouTt9Rj4Iw64qRE1Zi6Ak=;
        b=jOUCGiF5YEmRM05jW4NtvwLBUItg2/sYfSZwExNOTxzXxptt3/Dn0QnQzaypmsVnEX
         mTdnjuk6SOA4SL6JaDRYEBTeqAqkq+wX+dkn6PRpjxTPtKU/g2fZakag3biAZJNaaxtk
         oLAXqwx+askNs04lMQ5YMeXlZqQR9gLb0x/N0MizLdaQ4qt5ak2B641Dj57228AmTGi/
         ocgYBC1kdWmmKYTc8AdigEXVE0JfupU+CSwKU8VbI9EivyF9WY8exTmWMMllovwM0eS9
         U88X+0QzzukdLPFXKcUnMAUL6v6o46qMqTi0puKzyUd8ydm/1Z77FAiBzpMT8gwnG9nF
         UOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1WxJiMEwTGPWQdWUzu3v6ZouTt9Rj4Iw64qRE1Zi6Ak=;
        b=aFykoR5nZbZEdJwFR4Jjh8kksrOZzrJc2+gNtSBh70dKf7N2cnQ3NaaoXgjmKibDm5
         WGO+M8QQe0FJ0AYQzEpTs9DSWeOpUaQzn4u/tyKpaswol464Pui6dh+JtV+/hF2RWgCj
         YUtiBGOcFEdI7Auwg2UMF6OZBr50V2ma3uP+dWXIu2kj5ZWUBNUuYmAZv4lp+w0U1CbR
         lVvDUguuc6a3061fsDOGTncd8mfBqr0GjJTLGKsr5RVM1uNmPAdQ2bGzWS/WSLFbn/mf
         KfAiAjwH8AegVvBUhlGYok1INkSbp64p6UYTf/haM6KGx5R9LzC78A5JkDbB7l7csPF1
         M4iw==
X-Gm-Message-State: ACrzQf3TnPtSOKvZJnhMzRcaNBxVZhgai7Kisocz7NGqwSLmgHcGCT1x
        bXor146OSDfQlhnPU1OKzBNjzq2yr+/2ZJ8Tksg=
X-Google-Smtp-Source: AMsMyM7GpG772MtK1NtcHTcKVVOiiiQBPbo7B4qlKt77Rt1dMysfw8qmuzs3QvcEotlwu3gtKyUE1gKNbxNitDcdulw=
X-Received: by 2002:aa7:cd57:0:b0:456:d566:3f3e with SMTP id
 v23-20020aa7cd57000000b00456d5663f3emr3728458edw.311.1663969423385; Fri, 23
 Sep 2022 14:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220922210320.1076658-1-jolsa@kernel.org> <20220922210320.1076658-7-jolsa@kernel.org>
In-Reply-To: <20220922210320.1076658-7-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 14:43:32 -0700
Message-ID: <CAEf4BzYUsq2Rr8hvwYHBOmk6GJ7am3JA-GwayjwMgwPrEmqE0A@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 6/6] selftests/bpf: Fix get_func_ip offset test
 for CONFIG_X86_KERNEL_IBT
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 22, 2022 at 2:05 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> With CONFIG_X86_KERNEL_IBT enabled the test for kprobe with offset
> won't work because of the extra endbr instruction.
>
> As suggested by Andrii adding CONFIG_X86_KERNEL_IBT detection
> and using appropriate offset value based on that.
>
> Also removing test7 program, because it does the same as test6.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/get_func_ip_test.c         | 59 +++++++++++++++----
>  .../selftests/bpf/progs/get_func_ip_test.c    | 23 ++++----
>  2 files changed, 60 insertions(+), 22 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index 938dbd4d7c2f..fede8ef58b5b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -2,7 +2,7 @@
>  #include <test_progs.h>
>  #include "get_func_ip_test.skel.h"
>

[...]
