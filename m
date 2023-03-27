Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A06CAD18
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC0Sgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC0Sgv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:36:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF1D3AAF
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:36:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so40068991edb.6
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679942208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHLPdl9Ozi+4GEA5UHRhcz37wly7L/X9kHjlz6jpd/M=;
        b=FbeFe1Zm83WZbUlBtT1ybAfly1bSUmmkVcas/lfPDm+JGjNyDmkZrycOIujcgjF0Tr
         Ib0SoF0fCuRuCGKskMYjTmylPG41MHCjEASPwz47Q4a7FCp2UQuJlfHx4Tmjm8gqOkv2
         brHbOyXt6fJ5WImQQ13MpoFsrfchdW5TUTH6KidSyOBuPwHc7hSSWI0CgkP9fOUUtnIQ
         vlVBLlaYvyfOl0eNm4Gw3hwj6zvHL/bxVacZtNQiG8aQGruEOxTtHXXbMZYxakudF9Dj
         hQ5eutRruca/RKDDoCZI5Wq7GdDFY6fthzBZmNaiAt0J29kvz32gJZz7Xg4RCvrJqLCE
         4/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHLPdl9Ozi+4GEA5UHRhcz37wly7L/X9kHjlz6jpd/M=;
        b=66LeIzywTSPsPiw5PF7b9EcQ83EnL42QNul8Bcg2NeTcNXE2bqLKh0GzD9fmT6bs7c
         y4J+2k/6FeAg938ohUofAQBZb16ZJuvS8ltp1jVtEfCQALTL29IRqFkbTv8S8aGyBccd
         2GLMHwbd4TlE/+isNaRdUK5OiaYJoi0rE8sjbHR7u/j7inAt+thH40q0v5K4qEK2wmTg
         evQOIYVUs8OU/FIOezztjRkp5sbA58Aovx44R2xX63KCSzRo+fBiCtWjkZWXCPrbZ8Mo
         OrGGMHKl30ksQV4UsOtch3UozlzY0TkypZtHC/59SeWFBwAlj/YnrgEbqaAMgUywrfTX
         K58g==
X-Gm-Message-State: AAQBX9dW82kVRaS0D5OyKjsUw6JtlVc7gff+asY9rKjMPHVjVmWVGyzO
        Zbx0tSV/cr/Z/NpyFmT0po58Iuje2kQJXDSfkDBUIMvf9do=
X-Google-Smtp-Source: AKy350a9CBUgtajxvUj3LL9KCtj7w3BLZdmfpMqubxpxxIUS91gsQK21x30GbMmaUL3u6hT2b4ioPQYLfWsW+MW0c08=
X-Received: by 2002:a17:906:6a93:b0:92d:591f:645f with SMTP id
 p19-20020a1709066a9300b0092d591f645fmr6649648ejr.5.1679942208540; Mon, 27 Mar
 2023 11:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230325010845.46000-1-inwardvessel@gmail.com>
In-Reply-To: <20230325010845.46000-1-inwardvessel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:36:36 -0700
Message-ID: <CAEf4BzaP=cc2chjub-Wp8583=tpp4pu+MzYJNj2p4JesoJw8iQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: synchronize access to print function pointer
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 6:09=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This patch prevents races on the print function pointer, allowing the
> libbpf_set_print() function to become thread safe.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---

I reworked the patch subject to "libbpf: Ensure print callback usage
is thread-safe", it felt more on point. Also changed to "thread-safe",
which seems to be a proper spelling for this term.

Applied to bpf-next, thanks!

>  tools/lib/bpf/libbpf.c | 9 ++++++---
>  tools/lib/bpf/libbpf.h | 3 +++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f6a071db5c6e..15737d7b5a28 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -216,9 +216,10 @@ static libbpf_print_fn_t __libbpf_pr =3D __base_pr;
>
>  libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn)
>  {
> -       libbpf_print_fn_t old_print_fn =3D __libbpf_pr;
> +       libbpf_print_fn_t old_print_fn;
> +
> +       old_print_fn =3D __atomic_exchange_n(&__libbpf_pr, fn, __ATOMIC_R=
ELAXED);
>
> -       __libbpf_pr =3D fn;
>         return old_print_fn;
>  }
>
> @@ -227,8 +228,10 @@ void libbpf_print(enum libbpf_print_level level, con=
st char *format, ...)
>  {
>         va_list args;
>         int old_errno;
> +       libbpf_print_fn_t print_fn;
>
> -       if (!__libbpf_pr)
> +       print_fn =3D __atomic_load_n(&__libbpf_pr, __ATOMIC_RELAXED);
> +       if (!print_fn)
>                 return;
>
>         old_errno =3D errno;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 1615e55e2e79..4478809ff9ca 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -99,6 +99,9 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_leve=
l level,
>  /**
>   * @brief **libbpf_set_print()** sets user-provided log callback functio=
n to
>   * be used for libbpf warnings and informational messages.
> + *
> + * This function is thread safe.
> + *

I moved this part to after @return spec, where details about functions
are normally put.

>   * @param fn The log print function. If NULL, libbpf won't print anythin=
g.
>   * @return Pointer to old print function.
>   */
> --
> 2.39.2
>
