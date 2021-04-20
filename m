Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C970E365DD3
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhDTQvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhDTQvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 12:51:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDDC06138C
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 09:50:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p202so136551ybg.8
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhlcY8FEVNGAKjQ0RJ6+4XOOKzlSCVvhyanZCd4gyB0=;
        b=ibAy8nahcPs58CUyAxaJIYpfJ0VPwPEaNBTB2CD6ZQ3GPqsc97Nx9EvZalaCSkeFsW
         737Yt7Q+QKNkDJ5+5Zk9Io43Km/p1hOuhH1FT/NXCrdIbDAJiin/OIY/DJkRwTBt4OzM
         xoBMsT7e8ux1YGfTwIUt/Qy97si0TzhsPQtW0+d4uEgcHCkpNWQ2ifKpc3KBzunoipf9
         9YxJcpUWUKaVMCOQLX/LjwM53L8enXVXDhrPS+47gPyJhNcX1tayBN9zwNkFEhIHW4wA
         Y/HWfyAm0YPmx4f2ctuc/tIYVDTJbayIXsRJwULyOd/WU5RJ0lf6r5ZyVuwyoluqcAlw
         kfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhlcY8FEVNGAKjQ0RJ6+4XOOKzlSCVvhyanZCd4gyB0=;
        b=YWI4JEkxuZiAxvjyKhvSvBDWSIovdUd11zebMbmkRUAIhlmTdEQc4A1h7eqGxEBbRP
         3EFDNvyz2Z2FoHoGRYN37JeaMIBkCvUoHdhO2KCSv/cC4yZE3fKAoIfz7+4bFtumtoHE
         kQTqN/6Z0EIOxRYPxdKY7kAw+KPy37JMn+H/4tbu5BAiGvSSazMTzngE6ggXqrixp7So
         qC+bFPawUAnK4Lo6/c9mi3braYz1UoZz9UxcO2f3vw8tcb2jAi32G1Vb0ZEg6RgJWo5a
         b5tLSa8dkkwovdz8Gryl88kCaVGkfYrYEuBQmHYK0y0F0yt4DRiK50LYSw1aINDnmjZ4
         JyDA==
X-Gm-Message-State: AOAM532UqdzuI1htjsOj9bognT0dzcEamS/5hQz0Zt3LcJFIROMZ4KQt
        2PsWwzw3bKaQaPE6srI21kIcFWB60KEk9i2BQWC3w5fG
X-Google-Smtp-Source: ABdhPJxfEw1khGjTAMrqYzxZxRpH0rZssy80h50lhWeMQMT4BmtcGns/uHRogoBRWWIklxEGWhjbS4QQLK4VzS6cV88=
X-Received: by 2002:a25:dc46:: with SMTP id y67mr26307040ybe.27.1618937429816;
 Tue, 20 Apr 2021 09:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210420111639.155580-1-lmb@cloudflare.com>
In-Reply-To: <20210420111639.155580-1-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Apr 2021 09:50:19 -0700
Message-ID: <CAEf4BzYWNahvHA+WYz13o9Wy7oAtPXo0gv9S6jT42fYnoN72eQ@mail.gmail.com>
Subject: Re: Some CO-RE negative testcases are buggy
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 20, 2021 at 4:23 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi Andrii,
>
> I was looking at some CORE testcases, and noticed two problems:
>
> * The checks for negative test cases use an incorrect CHECK(false)
>   invocation. This means negative test cases don't fail when they
>   should.

CHECK() misuse? shocker ;) This is why I'm harping on ASSERT_xxx() vs
CHECK() all the time lately.

> * Some existence tests use incorrect file names, but the test harness
>   is unable to detect this. Basically, failure to load due to a failed
>   CORE relocation is not distinguished from ENOENT. I found the CHECK
>   issue when investigating this problem.
>
> I've written the patch attached below, but there are now 12 failures.
> I don't understand the tests well enough to fix them, maybe you can
> take a look?

Yep, thanks for reporting, I'll take a look.

>
> Best
> Lorenz
>
> ---
>  .../selftests/bpf/prog_tests/core_reloc.c        | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> index d94dcead72e6..bd759290347c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -644,12 +644,12 @@ static struct core_reloc_test_case test_cases[] = {
>                 .output_len = sizeof(struct core_reloc_existence_output),
>         },
>
> -       FIELD_EXISTS_ERR_CASE(existence__err_int_sz),
> -       FIELD_EXISTS_ERR_CASE(existence__err_int_type),
> -       FIELD_EXISTS_ERR_CASE(existence__err_int_kind),
> -       FIELD_EXISTS_ERR_CASE(existence__err_arr_kind),
> -       FIELD_EXISTS_ERR_CASE(existence__err_arr_value_type),
> -       FIELD_EXISTS_ERR_CASE(existence__err_struct_type),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_sz),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_type),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_int_kind),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_arr_kind),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_arr_value_type),
> +       FIELD_EXISTS_ERR_CASE(existence___err_wrong_struct_type),
>
>         /* bitfield relocation checks */
>         BITFIELDS_CASE(bitfields, {
> @@ -864,7 +864,7 @@ void test_core_reloc(void)
>                 err = bpf_object__load_xattr(&load_attr);
>                 if (err) {
>                         if (!test_case->fails)
> -                               CHECK(false, "obj_load", "failed to load prog '%s': %d\n", probe_name, err);
> +                               CHECK(true, "obj_load", "failed to load prog '%s': %d\n", probe_name, err);
>                         goto cleanup;
>                 }
>
> @@ -904,7 +904,7 @@ void test_core_reloc(void)
>                 }
>
>                 if (test_case->fails) {
> -                       CHECK(false, "obj_load_fail", "should fail to load prog '%s'\n", probe_name);
> +                       CHECK(true, "obj_load_fail", "should fail to load prog '%s'\n", probe_name);
>                         goto cleanup;
>                 }
>
> --
> 2.27.0
>
