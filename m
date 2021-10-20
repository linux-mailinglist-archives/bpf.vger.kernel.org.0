Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10F54350D1
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJTRAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTRAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:00:03 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25102C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 09:57:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g6so16162932ybb.3
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TjlL2wHfdKm3PM0O6nChZcZ0BGnuSf5J6ADPpNBCDA=;
        b=Rzt5zlzixQKffjte2LDTpQVoQXyk5FT0R6g+CT1XtOlnLMHp9uQbvMCM31X+1OUU3h
         8XXRed2ufpNkjRUsswt1XQREA1PBnYsjH3FWgWmmEZbxgUkfGnce5BfNgv+2kgbGqviD
         eMgctxWLCbdvr+rP1JMyzYoQyXdh040skdEEiECxyMy+X14zzH2pfq+P7LF+kr5QX9Ak
         sm3wWooP9/IeqUHrhaxkHP9HKCCzISThIJVDnT8YqszoqSHVNnpUgyixqjuaFFYDB7S8
         TvqxqZabHIL6db/fCcR2Hs+oPWTlq/bS07hFT60Y/REO6Rt5VNAQ0Nj1Pqdp1Vq5ZQwm
         QXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TjlL2wHfdKm3PM0O6nChZcZ0BGnuSf5J6ADPpNBCDA=;
        b=Eg5aZDhBQ9J4ILQP4XwpzCrd2JjqmR3GBFVUB7jS0PWCriUEdOC1WisRCqe1BmjVgg
         UhypsFEmBjKylsUCb3FntKHMMiXYHlGdr6eEHkwPw1UzNgHdULn5nwPJ3rSh7XQjIu4U
         vjZkSl9S5i4h3ufenDYJh8sZJiDKjekqo/TKNTjNeQxuFkJ9Rc3lXqzr+HBxB4kZegLS
         P7wZr7PFlCkSA4xusBG6CsfQIlW9ToaXcXRpzYj+3YHoyT2epHCYkandzxFaR9IaX3mJ
         yZC0+d91LPYRYEfuAUJVi0eRIH9uJYHAY+gyy9SFSRcgMceEEF6G7lS4AKeO1Gf1CPNw
         9sWA==
X-Gm-Message-State: AOAM533gjAMWsq+4t5cHSeN9Paz/jMq2f41F3YzLm2cJcj7NC13hiT3D
        5GaQt7uXzg+KUpABi75ELr3CFttwopWtz4pEF2qsGChLsyk=
X-Google-Smtp-Source: ABdhPJy4ev+DM7/0osi/yDSiMS0cOpwQEuQdEqCn4LhX5OdteNtXWezT8QEUKGDd9qCCwsPq+AK/NHkJced+z5cwcSk=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr148711ybh.267.1634749068355;
 Wed, 20 Oct 2021 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzYpp+VqqL4n1N7-Uw8sySVgvaCagEcVicgumtpK-y68aw@mail.gmail.com>
 <20211009040900.803436-1-memxor@gmail.com>
In-Reply-To: <20211009040900.803436-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 09:57:37 -0700
Message-ID: <CAEf4BzZe+VW+hRMOZpR3ZyRs_6TuTQRXN4tinwnq8krrVt2gOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Silence Coverity warning for find_kfunc_desc_btf
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 9:09 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
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
> the helper. Andrii noted that since __find_kfunc_desc_btf already logs
> errors for all cases except btf_get_by_fd, it is much easier to add
> logging for that and remove the IS_ERR check altogether, returning
> directly from it.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> v2->v3
>  * Remove unused variable (Kernel Test Robot)
> v1->v2
>  * Remove error check, log btf_get_by_fd failure (Andrii)
> ---

Patch bot missed this one. Applied yesterday to bpf-next. Thanks.

[...]
