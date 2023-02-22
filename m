Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7AE69FABE
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 19:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBVSHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjBVSHM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 13:07:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF141B58;
        Wed, 22 Feb 2023 10:07:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f13so33432186edz.6;
        Wed, 22 Feb 2023 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sg43hY4CJcWXv8RBvC/hzx01BE+SHCkZ4KVOapIBDjQ=;
        b=Y5xAzVNB/kGCd65ejJ/sBetwRGQyPa3JiXfOJCA86buDtTNIj8px+Mz/sKTNTZ/6vr
         ouqoQOao+7xo8eWqUGlrNXNWYdNbYtYGGUwVBKx0t3xpJJo0iNcLaAdQzepWMm9DNTaO
         bhR4ZfLCALcwgHvMit6lTY0Y9PjxA4pnZZyXEPKmjZOG0cDN6rjEe4ChvN8ofTZN1d/I
         m21SE15CVOnme4m3KZF3aObKe+KPX80MQ8XVQEJEn2RPpgiKWkEguEsWzyeTkr3JWK8c
         WGkS3BdyjOK6jCYKu4+HydpN+d1IaJw8RgQ5fHuvOSoxQow4iVVbtVG8s4Gpu13j8bd9
         +EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sg43hY4CJcWXv8RBvC/hzx01BE+SHCkZ4KVOapIBDjQ=;
        b=L25tXR+8N0as0hdZ634b36x0+Kq8LIUfqiXL8+lrq1iR8Y9DdSya03rchDhYcLTZlo
         jNq48SXDvS/ZSbAPKb2DzmHbTit+LIWjAI9bp6r5EAz0HWrLRu7wUahr4cDV4IuYtwaO
         S2+uLFYYYA/mkLKKUyt59mhxqOXPb3dfdLqYgvnZ9V7wNHmWokscLeopyQlT1GI5Jppo
         208n4ZfuxZGti3PbfuDTP4PXKL42LndjzYnHPQekKk/YVL8Sk7sEb4F8XfmJ588/QMnO
         WGEcoiNEtOS1iFfF+9s/to44JFklx61tdCpVzbtoUclQfK2rLYo0faeLy2Su1Xr4ej8k
         ZORA==
X-Gm-Message-State: AO0yUKUreostF3jfWCA/Nt2gJ9cw9eCpw4D7ktOmbQzYe4IluOKK4N0m
        G7FeOSFzC3u80zZb7Ov3HwuYM8TN+6za791I5SM=
X-Google-Smtp-Source: AK7set/vsgA6/MGZQ9iqrfcO5AldpGzfnzi6YcLPLLQoHIJy87BYFRt3PqqzWjoz9xq4aGU2BDj/bGTt0T7lg4KI6UM=
X-Received: by 2002:a17:906:58cb:b0:88d:ba79:4315 with SMTP id
 e11-20020a17090658cb00b0088dba794315mr9563122ejs.5.1677089230049; Wed, 22 Feb
 2023 10:07:10 -0800 (PST)
MIME-Version: 1.0
References: <1677066908-15224-1-git-send-email-yangtiezhu@loongson.cn> <1677066908-15224-4-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677066908-15224-4-git-send-email-yangtiezhu@loongson.cn>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 10:06:58 -0800
Message-ID: <CAADnVQLLborN3ABxRPUhSL5jQ1XcWNM9DBfjaEbvnF9qdE_CJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Check __ARCH_WANT_SET_GET_RLIMIT
 before syscall(__NR_getrlimit)
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Feb 22, 2023 at 3:55 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> __NR_getrlimit is defined only if __ARCH_WANT_SET_GET_RLIMIT is defined:
>
>   #ifdef __ARCH_WANT_SET_GET_RLIMIT
>   /* getrlimit and setrlimit are superseded with prlimit64 */
>   #define __NR_getrlimit 163
>   ...
>   #endif
>
> Some archs do not define __ARCH_WANT_SET_GET_RLIMIT, it should check
> __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit) to fix the
> following build error:
>
>     TEST-OBJ [test_progs] user_ringbuf.test.o
>   tools/testing/selftests/bpf/prog_tests/user_ringbuf.c: In function 'kick_kernel_cb':
>   tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: error: '__NR_getrlimit' undeclared (first use in this function)
>     593 |         syscall(__NR_getrlimit);
>         |                 ^~~~~~~~~~~~~~
>   tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: note: each undeclared identifier is reported only once for each function it appears in
>   make: *** [Makefile:573: tools/testing/selftests/bpf/user_ringbuf.test.o] Error 1
>   make: Leaving directory 'tools/testing/selftests/bpf'
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> index 3a13e10..0550307 100644
> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> @@ -590,7 +590,9 @@ static void *kick_kernel_cb(void *arg)
>         /* Kick the kernel, causing it to drain the ring buffer and then wake
>          * up the test thread waiting on epoll.
>          */
> +#ifdef __ARCH_WANT_SET_GET_RLIMIT
>         syscall(__NR_getrlimit);
> +#endif

This is clearly breaks user_ringbuf test on x86:
https://github.com/kernel-patches/bpf/actions/runs/4242660318/jobs/7374845859

Please do not send patches that make selftest compile on your favorite arch.
Make sure the patches work correctly on other archs too.
