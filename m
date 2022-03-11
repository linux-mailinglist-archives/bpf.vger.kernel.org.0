Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31284D566D
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCKASn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiCKASm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:18:42 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FB39B94
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:17:40 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o12so4925169ilg.5
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWe0JfJHHuNylBeo8eO34zsnexe4BP9ea0ZpHKEUp6M=;
        b=LyT11cx3bDwqixUOqMfLLTImeg7txjqEgURDDGid409AB6X81N2LouVAaa60epK8zJ
         emI9cbH6TB4trKfYUCrOYtc4YDQ6iLnutA/5q372BFUKDA+YhcvlPTK/2nLrZZwYc5dD
         yMgiCB+JYLKfcQ65NO363Sxqky26Y3FiV7hGCP+6A3gRiLqCPZUtk4ZWEkqfBkoRubBU
         83SqdVkGZtMrS54DDvFtAh2pbOAoZI2K2bJug/cqY9YJanQzAs366GRQ5rT6D15gyZzR
         j6UeJo6lGZBDINxUyJPWnmCpeZdfo8hRlj+AEAhj0LdKzkvHISp2Nh8JYqgCo2uCQnNO
         qQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWe0JfJHHuNylBeo8eO34zsnexe4BP9ea0ZpHKEUp6M=;
        b=euaUxsLPJnXomZz0lHl0EC0v9AFu9ENk/lo4i2n0fB/zrWRkueWyYvIhyJ+nHQNmKo
         1bvZGNhTF99/UjD3nJddSE6xp45Rp9hvY3IEDQlANY94aUBE1bTOezGWxtY2CJawnOw0
         4oJJUmuSVh+tKGIDEm3ui6PzV8t3CrWECOxSbT91QXY87OUulthNpcxMlrx8vYSMIHO7
         nMOIVsZkgx3GtmCgYajWISFLSj7mjuasUT4SFCZHM86yRW2bdwRTEd63Fk7aL3QGK4rV
         bfns9XmxY3JQ2kF0BevpjfiPCVS9g9AkFoTJ9GfdJwTf00MxkDjLasCcuQ8O9uuYoGHC
         lVug==
X-Gm-Message-State: AOAM5337tDfy1XfngMHUk32OTsVxuyxg5AQyW5/ub2XlC9crXyPBx9CW
        O3AqMnFKq/dmbmuCTMEcdDqE5drrr1oobnMkRXwUW4sJet0=
X-Google-Smtp-Source: ABdhPJxs61A6zST79Fao+P9X3frHF7Aom/lM6nx6YlRwQtLp8LrWk5A2HObHV6HhisPkhgsAu9yQby2ghJ9bA58EEYg=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr5659263ilb.305.1646957859519; Thu, 10
 Mar 2022 16:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20220311000508.2036640-1-yhs@fb.com>
In-Reply-To: <20220311000508.2036640-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Mar 2022 16:17:28 -0800
Message-ID: <CAEf4BzY0r07gydqXm6OpPWuzefdvta0FUhOn+Tj9W+KLWxiKcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang compilation error for send_signal.c
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, Mar 10, 2022 at 4:05 PM Yonghong Song <yhs@fb.com> wrote:
>
> Building selftests/bpf with latest clang compiler (clang15 built
> from source), I hit the following compilation error:
>   /.../prog_tests/send_signal.c:43:16: error: variable 'j' set but not used [-Werror,-Wunused-but-set-variable]
>                   volatile int j = 0;
>                                ^
>   1 error generated.
> The problem also exists with clang13 and clang14. clang12 is okay.
>
> In send_signal.c, we have the following code
>   volatile int j = 0;
>   ...
>   for (int i = 0; i < 100000000 && !sigusr1_received; i++)
>     j /= i + 1;
> to burn cpu cycles so bpf_send_signal() helper can be tested
> in nmi mode.
>
> Slightly changing 'j /= i + 1' to 'j /= i + j' or 'j++' can
> fix the problem. Further investigation indicated this should be
> a clang bug ([1]). The upstream fix will be proposed later. But it is
> a good idea to workaround the issue to unblock people who build
> kernel/selftests with clang.
>
>  [1] https://discourse.llvm.org/t/strange-clang-unused-but-set-variable-error-with-volatile-variables/60841
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index def50f1c5c31..05e303119151 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -65,7 +65,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>
>                 /* wait a little for signal handler */
>                 for (int i = 0; i < 100000000 && !sigusr1_received; i++)
> -                       j /= i + 1;
> +                       j /= i + j;

`+ 1` was there to avoid division by zero. Let's make it `i + j + 1` then.

>
>                 buf[0] = sigusr1_received ? '2' : '0';
>                 ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
> --
> 2.30.2
>
