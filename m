Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68842726B
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbhJHUly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 16:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhJHUly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 16:41:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A27C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 13:39:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h2so23568310ybi.13
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0lWyVjqIUHirVBXI53Fa4kyQOf5tRF59QkI/dVrgDc=;
        b=DRLZSAfaGEiqceFDmFAW508M4aJXVgvn79xplWdGpjUj490FySe3QaDUPa2XALKScx
         7BYW0sp2o8wM16752IMe4eTfHOW4aD86W9nN6/8GOFNi7YwV4u1YZGUp8Mt47MZK7A+M
         HDZHLpFaKAlU7qleCesT8jMTzTLczWet4WDSZBwgqZsFGay49AxcT4pc06EqOMl66fAV
         qya0i+R//bGMlvifHEW5sZ8BCCTBel7otx1L3ffsfOOzSgI8C0ISDfHeDDrhsaMRTEaE
         Bo8QmNotrBBdqUU7D3kAgKazEu0RU3Tcip+G0BEktc6vsDmrDwroD0jmbwtI6ZJ4XjhP
         5r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0lWyVjqIUHirVBXI53Fa4kyQOf5tRF59QkI/dVrgDc=;
        b=6I7H6yK6CinLpklpOXEZRJS4QCFlI2h51wxM7N9ZYAFpMAdN1K952+N2d6Yk8hFVIF
         1xxsTQkwbfocuwcCG9/fWpgXwYsh2fo3c2QPN5kbl+RuifTHutZpM+l3d1R4h0TUPtzW
         R8yuAdlL1oAm4vIBFQvnWti/xdUfO7251eOcjEMQFT2X2lbR77vK3WMZ8QSb1mEQPOuT
         IDxXzGuHBmSfqJ0GOM8joyDpXljgwRzplGPpR7WLmsrarfAhwoeyeHClyYXMpold7V7x
         ikAnfkz+a9tgmkYNgoMXgvDO+KQiuJlPGdJkHvvspeRnfwfXQvgOfBZqnqkSqGWQij4V
         QhSQ==
X-Gm-Message-State: AOAM5329WObQCj+pALDrGwqd3yKFCzSUyCWbC0Nx6BGdbjouCyqcQKWO
        oQ00itOqAKbkwdg2aq3FMdMfXeSAkO77h+LN3Y8=
X-Google-Smtp-Source: ABdhPJxWnoGbTbb2XZkhkkA1q8bof9YDJn1foMOrSrAhKY7xboFuhV8Qctav3HH/yKOGZqpARh1z5yYSmyfHQvFh++c=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr5875042ybf.455.1633725597666;
 Fri, 08 Oct 2021 13:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211008170751.690570-1-memxor@gmail.com>
In-Reply-To: <20211008170751.690570-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 13:39:46 -0700
Message-ID: <CAEf4BzYpp+VqqL4n1N7-Uw8sySVgvaCagEcVicgumtpK-y68aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Silence Coverity warning for find_kfunc_desc_btf
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 10:07 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The helper function returns a pointer that in the failure case encodes
> an error in the struct btf pointer. The current code lead to Coverity
> warning about the use of the invalid pointer:
>
>  *** CID 1507963:  Memory - illegal accesses  (USE_AFTER_FREE)
>  /kernel/bpf/verifier.c: 1788 in find_kfunc_desc_btf()
>  1782                          return ERR_PTR(-EINVAL);
>  1783                  }
>  1784
>  1785                  kfunc_btf = __find_kfunc_desc_btf(env, offset, btf_modp);
>  1786                  if (IS_ERR_OR_NULL(kfunc_btf)) {
>  1787                          verbose(env, "cannot find module BTF for func_id %u\n", func_id);
>  >>>      CID 1507963:  Memory - illegal accesses  (USE_AFTER_FREE)
>  >>>      Using freed pointer "kfunc_btf".
>  1788                          return kfunc_btf ?: ERR_PTR(-ENOENT);
>  1789                  }
>  1790                  return kfunc_btf;
>  1791          }
>  1792          return btf_vmlinux ?: ERR_PTR(-ENOENT);
>  1793     }
>
> Daniel suggested the use of ERR_CAST so that the intended use is clear
> to Coverity, but on closer look it seems that we never return NULL from
> the helper, hence it can just be switched to checking for IS_ERR and
> returning the pointer, similar to the cases elsewhere in the kernel.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20900a1bac12..2551b6be8d42 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1783,10 +1783,8 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env,
>                 }
>
>                 kfunc_btf = __find_kfunc_desc_btf(env, offset, btf_modp);

Seems like __find_kfunc_desc_btf() already logs most of possible
reasons for the failure, with possibly btf_get_by_fd failure being the
biggest user-visible omission. If you complete __find_kfunc_desc_btf
logging and just pass through its result here without extra check,
wouldn't it work?

> -               if (IS_ERR_OR_NULL(kfunc_btf)) {
> +               if (IS_ERR(kfunc_btf))
>                         verbose(env, "cannot find module BTF for func_id %u\n", func_id);
> -                       return kfunc_btf ?: ERR_PTR(-ENOENT);
> -               }
>                 return kfunc_btf;
>         }
>         return btf_vmlinux ?: ERR_PTR(-ENOENT);
> --
> 2.33.0
>
