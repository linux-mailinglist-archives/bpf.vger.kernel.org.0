Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56B49D320
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 21:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiAZUH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 15:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAZUH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 15:07:57 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C1C06161C
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 12:07:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s18so947084ioa.12
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LRYekgQCmmLNPUFDqEkwdQfaeSfSIIK9dg3zxbzjXw=;
        b=kL9Ndx6e/gZV9enccXP9lYasT+ZxiuEYQJ05BuqAaFdujpbzrOokqMKKzCqthcyU1W
         TvGHwis1jpf19vHCJjv0ehZy2ohtZKG6NvI/TplDBjT+7QTbtHWgxmDqwarP/zD6c59d
         tH3AW3XsvYCPW+RIQhYvXC1NeGFQseheyAJ9H+Nu8HhSuqQm9Cxj6gbHOKNo0C5bb7Qf
         QrVOE6fNzNFvEficKkGNgt5vf+hbarIm2gahxJfnznfX+NePqeixa0geFEY+bq8kMvS8
         6bK2sc7o8Mn/kdc2VnlPXe1zF7k9bz1qFpMe0hmUUsCGTbHuGzxN8UuvAoEEQpAsN5Lo
         MHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LRYekgQCmmLNPUFDqEkwdQfaeSfSIIK9dg3zxbzjXw=;
        b=bnelzHi2DEcSxDrYvKRSwZ3pcUSgKyqrkMcyTWX7p7Maa4Nc9tlVuxWQxGMpK6ZWlJ
         4PNJAAtON+YvaParBd+Deq7lAg7BSST+HzjpPqXgJH0E0GfwqK+Lb5A6svzoPcDzItpl
         UaTndnDstXNE7mC+Di2rI5xVrRMnK2XBChpVodsybqJHL6ZGMbYutpTgiaCRHQPfEgWp
         IViTMBcJavaM8QydF0ftol/LzkZGEWK2JoEZgHGQ1F30SF79c+pW4Nl6KW6VAg3KZ5ya
         jd4glUnDoQVTZg+FFAJw1cjrQCYf2hBLRS2g5Cp9dxhl6aMIzK8o1ZUm2y3jg3fBk8VK
         rSKw==
X-Gm-Message-State: AOAM532LbuDs/6AbTWXJgZl8gn4tPKILVX0hp2PhIBUkJAkMeTfZyzFd
        fQgOA9RlM3ptWE3T8C32zLVZYTwEkTY68Atksmg=
X-Google-Smtp-Source: ABdhPJy3ynSvAUNzgNEvq2G62YmIc0TCbjaWg4wX6wnSIbUow21sLx8mjliVrSfHktpFaVCCOkGmiDaSCrum5JJLmnA=
X-Received: by 2002:a02:7417:: with SMTP id o23mr138493jac.145.1643227676875;
 Wed, 26 Jan 2022 12:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20220126181940.4105997-1-yhs@fb.com>
In-Reply-To: <20220126181940.4105997-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Jan 2022 12:07:46 -0800
Message-ID: <CAEf4BzZrgk9Hjs14vVCN=UshGqEbhKNGjRvrQXaTKvxL9i3DGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a clang compilation error
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 10:19 AM Yonghong Song <yhs@fb.com> wrote:
>
> Compiling kernel and selftests/bpf with latest llvm like blow:
>   make -j LLVM=1
>   make -C tools/testing/selftests/bpf -j LLVM=1
> I hit the following compilation error:
>   /.../prog_tests/log_buf.c:215:6: error: variable 'log_buf' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>           if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/log_buf.c:264:7: note: uninitialized use occurs here
>           free(log_buf);
>                ^~~~~~~
>   /.../prog_tests/log_buf.c:215:2: note: remove the 'if' if its condition is always false
>           if (!ASSERT_OK_PTR(raw_btf_data, "raw_btf_data_good"))
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /.../prog_tests/log_buf.c:205:15: note: initialize the variable 'log_buf' to silence this warning
>           char *log_buf;
>                        ^
>                         = NULL
>   1 error generated.
>
> Compiler rightfully detected that log_buf is uninitialized in one of failure path as indicated
> in the above.
>

Yep, strange that GCC didn't detect this. Applied to bpf-next, thanks!

> Proper initialization of 'log_buf' variable fixed the issue.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/log_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> index e469b023962b..1ef377a7e731 100644
> --- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> @@ -202,7 +202,7 @@ static void bpf_btf_load_log_buf(void)
>         const void *raw_btf_data;
>         __u32 raw_btf_size;
>         struct btf *btf;
> -       char *log_buf;
> +       char *log_buf = NULL;
>         int fd = -1;
>
>         btf = btf__new_empty();
> --
> 2.30.2
>
