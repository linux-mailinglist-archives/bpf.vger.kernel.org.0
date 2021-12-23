Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D647DE55
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 05:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLWEnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 23:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhLWEnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 23:43:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BCC061574
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 20:43:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mj19so4012206pjb.3
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 20:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFwjkPbMKqFa9X+P9sB7lfHnsxS67gNA+SrAChfAE0I=;
        b=mJ0xfYBc3ZXE7Ez2l3ccerA73Jg0ar5MC75/JbCoAQ6nFxOCL03UFji2ufbfm0QYrx
         udT8oO0wntaKNlI7Jx5cmWuq8Kf+IgkYTOCTL2iQ3pUZXXwNemZ6h9JPNk56xCMc+Y/q
         2eCxizp8ksUes28sw+2fBqxWuSKl6qkVj7mHbpzlzjel3uhin3ReuUW3kYs5r94XuxQA
         lN20TfbKdd/PHEKeUwth5UshCZZKuMBQTKtl4nprLMHnOlGCJxcDB2Lc5LQ/EvgR0VUD
         aITSppqpLAI1RUoNtSLVedaGuyj6dVVFSeCjKVWQEh2nXfRkvw5aVfzvnDg6SzUo2wOs
         4Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFwjkPbMKqFa9X+P9sB7lfHnsxS67gNA+SrAChfAE0I=;
        b=pIduyynVJKs40dPal4IdHrOwyPm0AuFRKpUtYjUVBT2Q/Oa46cUhaPa7Q/XYxY/nD1
         Z25YXGeGKQ3jnTTdOONHDG6vwxv+2ZlRzlQadr+QFLp9wxPJaU4KuGEwFqbgC/JRpK0Q
         /p/Y9TyG+iyvWknq3Khmnsv1yn4nkQ9GeHAFvzcRx3YXS+JpTLY9Y4FnDURR0tyJ1KxC
         OuTjE6rOdRCOJlOFg7xf/6bvSmRN+2YLf0PJMFuS76E8ZXEpYTttRNpPh+zSPSIp8gvl
         nY6lbaHKgek/k0g+cHKMwUNUcHUfUMAnqvt9w6cRnuXLmFGRj7JItqfY7rY+jHBAHeUn
         CiSw==
X-Gm-Message-State: AOAM530STvhazCCwvqjYDGzZR9lqCP+IZ17EuC9yw6cU2AqJlvVb87al
        yk5SW6o1dIwum0wd2qqt9orB1XYNe68L/64CfCpJ5g4D
X-Google-Smtp-Source: ABdhPJz76FJ2e5tpQl3g1aMiOW23ME10nBmCjOJ3QJp1ghcPZsOt/0MkOp0NqjstMGO34t9WbzuDtZJTAeWoKv1pN/4=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr816166plo.116.1640234612669; Wed, 22
 Dec 2021 20:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20211222131005.1380289-1-liu.yun@linux.dev>
In-Reply-To: <20211222131005.1380289-1-liu.yun@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Dec 2021 20:43:21 -0800
Message-ID: <CAADnVQ+21_4gANJhARm7GECLRbshQUxAq4s0WL8OvAiHnD2oxw@mail.gmail.com>
Subject: Re: [PATCH] bpf: clean up unnecessary conditional judgments
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 5:10 AM Jackie Liu <liu.yun@linux.dev> wrote:
>
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> s32 is always true regardless of the values of its operands. let's
> cleanup.
>
> Fixes: e572ff80f05c ("bpf: Make 32->64 bounds propagation slightly more robust")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b532f1058d35..43812ee58304 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1366,11 +1366,6 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>         reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
>  }
>
> -static bool __reg32_bound_s64(s32 a)
> -{
> -       return a >= 0 && a <= S32_MAX;
> -}
> -

The code is the best documentation.
Here it clearly describes the intent.
Please ignore compiler warnings.
