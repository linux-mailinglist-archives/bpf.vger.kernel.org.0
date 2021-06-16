Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4F83AA762
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 01:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhFPXXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 19:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhFPXXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 19:23:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783DC06175F
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 16:21:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f84so5510978ybg.0
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxzRVJ5JpRy9PwxWROqxZPf0O4ovf8/yF3n60iNyHdw=;
        b=NvHztaFVirAfsZbkp0OT7Uc18l8HrC95j9x0XYUihr4vBwyBhNcM6h4vn/JCee/XLi
         SkcX5iXTNaXkwThpy8jMUpr/DHIyDioG7r9/pCVsLHZ2DrWR7Phc9qirE6NgvVmS8Qbw
         ST87UQtWvwe1ATbg9V6JiNpqYzCBqEXJbq3p/cDZpzbufOmkzZXq0BwXKCMG03cyCpK1
         7MyF/5fbS5xTn9rFY5+12ZTyPx3F+SwP02wz0XDLn/pLweA23Fg5UJAmDf3W24B/gJpL
         X649ih3la9h0iRzEJM77i4nezISv2Bny73oUiFUeIicLo3EXp/B5pcajV6yR0rOiCfrI
         fgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxzRVJ5JpRy9PwxWROqxZPf0O4ovf8/yF3n60iNyHdw=;
        b=O6wEAWc3F5xHdUs/uQVlbl5tVnQQwCKcG/Rym2DZUhbtPTn/LDaTCyH5XxBDE/aH5o
         ktNL8XyUegxZD965mfeL80RCoFOrp+u2RAmvcCJpSYK9c4pItblvnQTmHHv0YzqTxRpm
         Jq9bIBy8MYXX3kvoDvhfMR2u85IjkkkAJb7WM1mR76ew5g2iqp433okbE9V/gzCxafwX
         Wi9m6wp9oF2IzUuX5DwzQvMQaiOD3h4J+Wj/BW0yId2kDkA5N9LIkRMFW1Jvr3agysEp
         dBIM3e+KawY0kxOfqBVe5ip1PVjdYYKUzcyBACwYjPoTAi3ErNkGcehtLI9fHVezLTfz
         5qeg==
X-Gm-Message-State: AOAM5331XnjBUqjbMwY8E3pSzSmtFnABm4T0SghrGuROMSA+Dfqkp/z7
        6oG6W5bqslFL1NqOWAf3RDyyvgADN5WXNfl9RwM=
X-Google-Smtp-Source: ABdhPJwsnzcsqf5LrVaFpEcXOqphNNrIkcTaGg6D5njlpP/Sfk3lqgd909Gl3ilopIBAfMvGLSKGWrLpB2NPjIVhzgs=
X-Received: by 2002:a25:9942:: with SMTP id n2mr2134969ybo.230.1623885675387;
 Wed, 16 Jun 2021 16:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <a46f64944bf678bc652410ca6028d3450f4f7f4b.1623880296.git.dxu@dxuuu.xyz>
In-Reply-To: <a46f64944bf678bc652410ca6028d3450f4f7f4b.1623880296.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Jun 2021 16:21:04 -0700
Message-ID: <CAEf4BzYZCMQuRMWbUKEnE6p0DNY9x6jZypr3SARFQfM3kuKfJg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: selftests: Whitelist test_progs.h from .gitignore
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 16, 2021 at 2:52 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Somehow test_progs.h was being included by the existing rule:
>
>     /test_progs*
>
> This is bad because:
>
>     1) test_progs.h is a checked in file
>     2) grep-like tools like ripgrep[0] respect gitignore and
>        test_progs.h was being hidden from searches
>

Nice find, thanks! That bothered me before, but not enough to investigate :)

> [0]: https://github.com/BurntSushi/ripgrep
>
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/
> general rule")
>

Commit references in Fixes: tag shouldn't be wrapped. And there is no
need for an empty line. I can fix it up when applying, but just for
the future. And bpf-next is probably the right destination, I don't
think it needs to go through the bpf tree.

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 4866f6a21901..d89efd9785d8 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -10,6 +10,7 @@ FEATURE-DUMP.libbpf
>  fixdep
>  test_dev_cgroup
>  /test_progs*
> +!test_progs.h
>  test_verifier_log
>  feature
>  test_sock
> --
> 2.31.1
>
