Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1067C22F
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAZBGy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAZBGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:06:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC99126F5
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:06:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so1357892ejc.4
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jy4NY9hjvIZY85IuEgExHWlOkHPoirgB27rnoxBpBUM=;
        b=nC48lCFShQgBBPGM8yVXGrEnb9vaX78BRK+4WLKVENWgufP4+ItbEE/ObhkcgMA188
         NcldP+OP/A89FSlMaThkO+UeJLMtIxfj5ADSpCbfs/+fNqrjJcrUpUkqvl0cEfWeqQlD
         UQsFi76Tl06Rb4RzkkTHGoA8bIscLVjMtvNDDM2rP34HlUFLVKviG/sAbgknJfDK7q5V
         +VjE7KV8UplJ8IZzSomcz9uR9Wx9AWJhX0XiCRQVZmkjhq+1L/E+OZnkF4OB5RvdlTBc
         kfsg3USRC1LNOl6DJnBWX/QmBSWcYeQAyZOo/VIhOj5DmeB1iWqdp2lvVdcQmGpR6KvV
         YzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy4NY9hjvIZY85IuEgExHWlOkHPoirgB27rnoxBpBUM=;
        b=2B+2vBPzCOCDrZ/dNsgQ17O19DhEOI2tnUscDfvhS6XNvLb/+5VqsTWCZZw62Nc1F3
         UJ5d3ixF5U3rK5mi5fjg5SoRwoDxshWwR21/NrSW2uyfObplyXZN8+Kq+71lbfPpASQu
         97q22UOYZJlBaXplRhk6ofnAx1hngEDPlhy1vhLfpNevksqICCXQnng0J6pcmjpLt/3l
         zA8xBU2uE7o+3ES55PG+ASMBDWiJygrU10ILtarL8CxsO5WlUql6WwzHQaXJQ6ZYlQe3
         TyAgIjp0yAvnbnVk5MppAuNWjgq0dvxc2vMKsGX1RNd37tO0Dg9emZk8iarJX+aUiQ3P
         Yftw==
X-Gm-Message-State: AFqh2koeiTy2F9iWbMsZzOf1Uiu9Pt+VYbmB8E177gpOwYJ/jvC9nIUO
        m2D6r6Nu2tUZp+1ixd747VCccQp/NmXXbU/YPuM=
X-Google-Smtp-Source: AMrXdXundIXdqET38igG+EQqq/SRQdEkh4ru1dnDmxbiI04jyvqenci3hkbwESssRuj0ZNQOFl6Wyf+/+owqWi3uEAk=
X-Received: by 2002:a17:906:ecb9:b0:86d:97d4:9fea with SMTP id
 qh25-20020a170906ecb900b0086d97d49feamr5509159ejb.141.1674695210745; Wed, 25
 Jan 2023 17:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-9-iii@linux.ibm.com>
In-Reply-To: <20230125213817.1424447-9-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 17:06:38 -0800
Message-ID: <CAEf4BzaaC4gn-BjpYWP++0GoHbJ2xaOOZ32ZNwq+_vxHVMKpuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/24] selftests/bpf: Fix verify_pkcs7_sig on s390x
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Use bpf_probe_read_kernel() instead of bpf_probe_read(), which is not
> defined on all architectures.
>
> While at it, improve the error handling: do not hide the verifier log,
> and check the return values of bpf_probe_read_kernel() and
> bpf_copy_from_user().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  .../selftests/bpf/prog_tests/verify_pkcs7_sig.c      |  9 +++++++++
>  .../selftests/bpf/progs/test_verify_pkcs7_sig.c      | 12 ++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> index 579d6ee83ce0..75c256f79f85 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> @@ -56,11 +56,17 @@ struct data {
>         __u32 sig_len;
>  };
>
> +static char libbpf_log[8192];
>  static bool kfunc_not_supported;
>
>  static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
>                            va_list args)
>  {
> +       size_t log_len = strlen(libbpf_log);
> +
> +       vsnprintf(libbpf_log + log_len, sizeof(libbpf_log) - log_len,
> +                 fmt, args);

it seems like test is written to assume that load might fail and we'll
get error messages, so not sure it's that useful to print out these
errors. But at the very least we should filter out DEBUG and INFO
level messages, and pass through WARN only.

Also, there is no point in having a separate log buffer, just printf
directly. test_progs will take care to collect overall log and ignore
it if test succeeds, or emit it if test fails


> +
>         if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
>                 return 0;
>
> @@ -277,6 +283,7 @@ void test_verify_pkcs7_sig(void)
>         if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
>                 goto close_prog;
>
> +       libbpf_log[0] = 0;
>         old_print_cb = libbpf_set_print(libbpf_print_cb);
>         ret = test_verify_pkcs7_sig__load(skel);
>         libbpf_set_print(old_print_cb);
> @@ -289,6 +296,8 @@ void test_verify_pkcs7_sig(void)
>                 goto close_prog;
>         }
>
> +       printf("%s", libbpf_log);
> +
>         if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__load"))
>                 goto close_prog;
>
> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> index ce419304ff1f..7748cc23de8a 100644
> --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> @@ -59,10 +59,14 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
>         if (!data_val)
>                 return 0;
>
> -       bpf_probe_read(&value, sizeof(value), &attr->value);
> -
> -       bpf_copy_from_user(data_val, sizeof(struct data),
> -                          (void *)(unsigned long)value);
> +       ret = bpf_probe_read_kernel(&value, sizeof(value), &attr->value);
> +       if (ret)
> +               return ret;
> +
> +       ret = bpf_copy_from_user(data_val, sizeof(struct data),
> +                                (void *)(unsigned long)value);
> +       if (ret)
> +               return ret;

this part looks good, we shouldn't use bpf_probe_read.

You'll have to update progs/profiler.inc.h as well, btw, which still
uses bpf_probe_read() and bpf_probe_read_str.
>
>         if (data_val->data_len > sizeof(data_val->data))
>                 return -EINVAL;
> --
> 2.39.1
>
