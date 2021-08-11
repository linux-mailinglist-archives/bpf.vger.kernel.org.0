Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92873E9A79
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhHKVom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 17:44:41 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A36C061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 14:44:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k11so7487331ybf.6
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXKC6gDzbznuGBKFL66M1Ck+VJemMiZvheg2/vK5OMk=;
        b=TmKJVwyeoArwg/gsoyvBAc16WrdJsXB51TFZMwYzSpGxgrZVpfp9lSUdSjDaxF0OfS
         2gmABUF+ycmZ2kxBj0SHjOlSXoM1eeS1Y7MYF268w9pTobuK/Jb6iTTwoDwVP/+AEEox
         7OC30kJjb3NdJWilnnj+jUwDFWFljiUvqK/+KDeTIdHfqRKDrrEiSQZXDI4WBi5se1Iz
         P/ScgD5q5HMSTz/1yGleHk/DzjPizI7xDt8ZFhnrSWTW3MNxwYSld5EOiO2fZ8ORzNQS
         8eE3EeujuDym6ZPgubKkXUO7PLp+b1hgKEJkzlKPGG1U1cSZknw9osq4gUMUwESQM2Ty
         5ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXKC6gDzbznuGBKFL66M1Ck+VJemMiZvheg2/vK5OMk=;
        b=IgFel3TG0ZkmLk0yJ/hnNmwPpfIhFaarLJYz6LJ9NVSJZWe9+9UDV+uynrxgN71s3Z
         PxuKIp+MaY8BAcEF4uRL3LFVTOeNflW21ViGiQFq4/LIzynxeeQ8+7v9/onA0OxRLamp
         kYRjAaF63ivV4kGrhZSsYrCxJow4Wuknc8SN4rN1s3+zteQ1dFRnYVbUjlpZfTs4tIXf
         3p+4Ys20Y5Czbf2Qil48j41blTVTk+qY/cC5CXIxhKVrrs7VWXWFxCM4B8XlzTMSNrFu
         isVh4tp9IE8F/vFzYIwfL7hVW70XIemNbMLbPoehT2Yj89TeykAs0QPhl3eAZfuJwoXJ
         iWrQ==
X-Gm-Message-State: AOAM531GpzU/lJ9qBt7X1/FLypa7FvJdx64Q5xQVVDuIq0uoBmtKRh+2
        v2m9onictIO8AtqvtuQ0ILuhJ2KyeyqUhZaMvqg=
X-Google-Smtp-Source: ABdhPJxr9j90UnRx3IuiocEeKTh8uAZq5W+c8W0CEvA1iaNSpm1XWRL0dIaXv8IasLcrUFYy+8wddd84PsaU7CfHI0A=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr104868ybg.347.1628718256510;
 Wed, 11 Aug 2021 14:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210810212107.2237868-1-fallentree@fb.com> <20210810212107.2237868-5-fallentree@fb.com>
In-Reply-To: <20210810212107.2237868-5-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Aug 2021 14:44:05 -0700
Message-ID: <CAEf4Bzbtx0bnqCBOWHL_d+1meLZ2FvWCRyzy12T0xmhqL15HeA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: also print test name in
 subtest status message
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 10, 2021 at 2:21 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch add test name in subtest status message line, making it possible to
> grep ':OK' in the output to generate a list of passed test+subtest names, which
> can be processed to generate argument list to be used with "-a", "-d" exact
> string matching.
>
> Example: $sudo ./test_progs -a 'xdp*' 2>/dev/null | grep ":OK" | cut -d":" -f 1
> | cut -d" " -f2- | paste -s -d,
> xdp_adjust_tail/xdp_adjust_tail_shrink,xdp,xdp_devmap_attach/Verifier check of
> DEVMAP programs,xdp_info,xdp_noinline,xdp_perf

This looks a bit like a mess in the commit log. I think it's a bit
more useful if you just paste a few lines of the new output format as
is, with no post-processing.

But overall it makes sense. I remember Alexei thought that it's
unnecessary verbosity, but since then I often found it useful to be
able to know the full test/subtest specifier, so I'm all for it.

>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index af43e206a806..23e4ea51f9e7 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -182,8 +182,8 @@ void test__end_subtest()
>
>         dump_test_log(test, sub_error_cnt);
>
> -       fprintf(env.stdout, "#%d/%d %s:%s\n",
> -              test->test_num, test->subtest_num, test->subtest_name,
> +       fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
> +              test->test_num, test->subtest_num, test->test_name, test->subtest_name,
>                sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
>
>         if (sub_error_cnt)
> --
> 2.30.2
>
