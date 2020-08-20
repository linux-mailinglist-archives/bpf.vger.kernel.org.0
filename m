Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8224C737
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHTVet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTVes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 17:34:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14284C061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:34:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b30so1674262lfj.12
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgGg/lzlwTediVsGi+CqjcHwxBq5iC8XcBhTDFLRiJk=;
        b=IbQPXE7ycG5yDo04hNKHVhWhAvAsjHvfzE3bIq6gCsZ3oDErCZakMSD7V4TqCeSnUv
         X9cKf/C3MMTkbtbIjiY7Iqx57zKOloTWXQL6qCehwplUpiLRCFJwfrfVgQMi4xqq4o+n
         PKn/DQQYsTuLtJ4G5p1nvRRyGpjwcKK2rXGcHQcFiY2Wu0EiVqxiBC6TpmL1NmS4osGY
         IZZP0U9745X1iboHCrIXMbQ47/hvHloJ1VUT9xhMJ/NlIfTSxQj/QFMOYaNm9lD4tZfE
         E2kw+tySAPh1qTG+wdeK7GS8O4dkH4n+SpDa9DqKOB1j2ULaOlBRDx7XlT32OaP8uyv2
         TMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgGg/lzlwTediVsGi+CqjcHwxBq5iC8XcBhTDFLRiJk=;
        b=UU5mTQNUnHkr8vBP/VdyiGUOc6/rbg65EG6h5yFmXZEepx6xznEQ8Eqw3M1Cod4Jp5
         2CfecPgxlyvU+MosoEjoTw2/HBR6b3BBEebBcCyXUMnljrTCjn19wZKO/2QXWm/0vWZn
         zBKVoNw3Jmrs84YZD1l8zquO7YQtmGFkDxT0bLbapvsbf2bHVTJjMZ82jh9UcAtqd0Wf
         DDRKZnAC8wSdD5fwCdzvgnwpkVNsjj5iMtBdpmKm3lhr20wJqHZg3YgdnZuRaVu9Mcno
         uLA1fEm/aNHnjlxoPgjZCnai2BsFwjUliCWES64UP6oDwpIwOrSFmjckAIoOsKOcnoim
         Vizg==
X-Gm-Message-State: AOAM531/rmkHIXfRr6V8WH+FT5kaBf1MZvPwmrCy0qux9qHp8hpXBUQf
        jPOrDkQolrfmS59U3x3nmjXcqBjkVqr+Lyt5Z1M=
X-Google-Smtp-Source: ABdhPJwOaMOoPQ5Z9j8bbMBxmr5zgxN9jMOsHGRgDKEySmdMZBxhLv0rxiWAfnSPgpsFDaaTw+Ptn69l+MEMus0QAoI=
X-Received: by 2002:a19:84ce:: with SMTP id g197mr160696lfd.73.1597959286373;
 Thu, 20 Aug 2020 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200820115843.39454-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200820115843.39454-1-yauheni.kaliuta@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Aug 2020 14:34:35 -0700
Message-ID: <CAADnVQJYXQ6bQ3gZJ+3wMc4W9dwyMP53PP2xQZXik=jkE+S72A@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: selftests: global_funcs: check err_str before strstr
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 4:58 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> The error path in libbpf.c:load_program() has calls to pr_warn()
> which ends up for global_funcs tests to
> test_global_funcs.c:libbpf_debug_print().
>
> For the tests with no struct test_def::err_str initialized with a
> string, it causes call of strstr() with NULL as the second argument
> and it segfaults.
>
> Fix it by calling strstr() only for non-NULL err_str.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>
> v1->v2:
>
> - remove extra parenthesis;
> - remove vague statement from changelog.
>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_global_funcs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index 25b068591e9a..2e80a57e5f9d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -19,7 +19,7 @@ static int libbpf_debug_print(enum libbpf_print_level level,
>         log_buf = va_arg(args, char *);
>         if (!log_buf)
>                 goto out;
> -       if (strstr(log_buf, err_str) == 0)
> +       if (err_str != NULL && strstr(log_buf, err_str) == 0)

I got rid of '!= NULL', since it doesn't fit kernel coding style and
applied to bpf tree. Thanks
