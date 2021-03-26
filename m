Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5C34A0B1
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 05:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCZEuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 00:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZEuH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 00:50:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A57C0613A5
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 21:50:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o66so4597153ybg.10
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 21:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhrplnH7qow7cy4DQZhuAyk7Cv27lJUU0vbgEz0i398=;
        b=d2QoO+rvEBqueuTofL4iluj+r/rL6d8Flo/lOdkE4Ah6JXz4NQ1ZrurKGrRRPZf6NL
         JLOn1ynHo7MPeRDiC6lpEbB7TyWvKToIULpk2BXEJAjVwmc50WA0WeZ58fbWyJ15undA
         X+yHY42LT/pLVSk0dm3hALLDf70m7qDHNkIDrvX49wJ03CvUvA+sazpI+rHetY/jAmW3
         8cDIFPOOp/VK8Ge+nb+z8ZkiPIyrPhZnZBtnDiN3y0ZYx+YdGyOzrMrec/88nOQ9uvCj
         +TVVhfGaiOHv7N3AJDDJIdrt8an8xJmtI9A09gUHKCwvdok17ieChXb0A1ig1a6470Y6
         d8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhrplnH7qow7cy4DQZhuAyk7Cv27lJUU0vbgEz0i398=;
        b=PX0smcl1YV0DMm3cZNYkJOLxCL0jGloPOI+7KLCdN/zmz3mkpmulOHb/UsErQHbZJj
         juKezlEFTPfAkTt+T1kKY5+6+h5VQqsIKElu+Yjlp75XRFG9jAJtDyhTUFp3oFMP6/W/
         r/JgBMh+iIOAK+uCDZdLeY6774OKALdSiA5Yim9f7YOrlY7alRa3NCSfZaDISEkivuDg
         06dNRe2PEnSzOR4p8wwJovONWX2DU1FiJDp8ZxJMtvmNr4inE9drzDJIvMHwywz9ocak
         cj/0tj44jb63lbV6RQOevB5CGUYFQ3JOfzIrWOFkU8PQ0jGWnZ58caxacP/+aQv4U+jg
         QL1w==
X-Gm-Message-State: AOAM533oMua86/ijLjraAE6EX0PFCfUdHVfGnkY1uW/CZCUTq4Vk5MXl
        ssUqgqP7ps9QS3jvOhSlQpYhDTCrfx7dFtYZPBg=
X-Google-Smtp-Source: ABdhPJyyn2S8HKsGKvBZb6w493YLx44dzVt1Ix+2t23NS1T4X+HruEXMYEu4c8Qh/mFZ8RUdKmzkYqVdpm/7obG5IYE=
X-Received: by 2002:a25:4982:: with SMTP id w124mr15933882yba.27.1616734206322;
 Thu, 25 Mar 2021 21:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210322170720.2926715-1-kpsingh@kernel.org>
In-Reply-To: <20210322170720.2926715-1-kpsingh@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 21:49:55 -0700
Message-ID: <CAEf4BzbqJkTDhUUb+7roJ8a_Ek-mUagx95dYeu8H6HpC_-siXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Better error messages for
 ima_setup.sh failures
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 10:07 AM KP Singh <kpsingh@kernel.org> wrote:
>
> The current implementation uses the CHECK_FAIL macro which does not
> provide useful error messages when the script fails. Use the CHECK macro
> instead and provide more descriptive messages to aid debugging.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---

This was applied to bpf-next, but commit bot doesn't seem very
attentive at the moment :) Thanks for improvements!

>  tools/testing/selftests/bpf/prog_tests/test_ima.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> index b54bc0c351b7..0252f61d611a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> @@ -68,7 +68,8 @@ void test_test_ima(void)
>                 goto close_prog;
>
>         snprintf(cmd, sizeof(cmd), "./ima_setup.sh setup %s", measured_dir);
> -       if (CHECK_FAIL(system(cmd)))
> +       err = system(cmd);
> +       if (CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno))
>                 goto close_clean;
>
>         err = run_measured_process(measured_dir, &skel->bss->monitored_pid);
> @@ -81,7 +82,8 @@ void test_test_ima(void)
>
>  close_clean:
>         snprintf(cmd, sizeof(cmd), "./ima_setup.sh cleanup %s", measured_dir);
> -       CHECK_FAIL(system(cmd));
> +       err = system(cmd);
> +       CHECK(err, "failed to run command", "%s, errno = %d\n", cmd, errno);
>  close_prog:
>         ima__destroy(skel);
>  }
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
