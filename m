Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5C3D4396
	for <lists+bpf@lfdr.de>; Sat, 24 Jul 2021 02:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhGWXar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 19:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGWXap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 19:30:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5ECC061575
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 17:11:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f26so1242859ybj.5
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 17:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeBwNxbBUPKqYld5n42MFcLDqYpmBa/wbajfBLo1ShY=;
        b=WzvmYxpMHtaeCxWYwebvkFFVIZRKj0nnx6LzfWKkp6lbyB9GDZiQL6ev/ZJFJt2IMK
         XRqo7g3bzti0mSz+IqdoKWb7uxBWxgugckicerJ8VwNDZSn1QjKrE3WL2wGJF8dQ9na3
         0T+dwle15gsPr2H9eKDwnonI9u+hs4H+3xDyAFIflGHMOk0QA1sNO77HQXgyD8eFSyu/
         ryqgzSgsx8Ku6K1QVhpCO3BzRzuSdS8xc7juXh6mSK9pa1V58IyOlQxyO3JBFG8OUzW1
         PpNmRsWOcv8toQpoykV9BJGvyynfU848oeon4rsOY7k0m8zak/Xsu6/Fw887P0aMbuMk
         7Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeBwNxbBUPKqYld5n42MFcLDqYpmBa/wbajfBLo1ShY=;
        b=cec7MbJ3onbRLyYIeOrRNbJNeMyn/6bU/Q5nSDc4aMgcHiMkx3TbmrjyII37WWZAa1
         jFmEyGu8U798GRvV6gH0bYSLcthVGsLDT+z7m/7Z1K17lLraxlj4vRUkw9cNNrMLPKlv
         gI8Eu7x+wtALP7YOFH8g3JCszAK05FXJ267GnE+YV5EP0gLWZvj6X8/GUDo2pcIReQy3
         bjdOKfzIx3EgpxM5zBfQYq/KhrZtC2q1Bzcv22uOtaIamRl17JjQ32YYB63mmw+ARMOd
         s5WxHMfB5ayieY93ZsW6ddZIz2oner0uIRDQZ9+2ZLY+gFxEjSXOrHE3wids7UlHijEn
         75Iw==
X-Gm-Message-State: AOAM532/FLYw+GWOv1F91iyXMvK1MDCrnX+/SNWbpBuLxL9u+xM1SgQe
        DWIjXFbBEZH/8tnEIfOc8o9E5SgTK34UDNCRlyg=
X-Google-Smtp-Source: ABdhPJwv5B5P0c0AjhNJRnArI4Oiu09hQjLe3NTNTf/XB7T3LvQnsFagphCQtWJVAFmGUJDZgb2eXq5tlZaApn+lA4Y=
X-Received: by 2002:a25:1455:: with SMTP id 82mr9521940ybu.403.1627085476901;
 Fri, 23 Jul 2021 17:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210723223645.907802-1-evgeniyl@fb.com>
In-Reply-To: <20210723223645.907802-1-evgeniyl@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Jul 2021 17:11:05 -0700
Message-ID: <CAEf4BzZy2FXPisrqa2O0ysDqJ5pGc2aXAN=o6P9xgSfXAPa-9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Document vmtest dependencies
To:     Evgeniy Litvinenko <evgeniyl@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 3:37 PM Evgeniy Litvinenko <evgeniyl@fb.com> wrote:
>
> Add a list of vmtest script dependencies to make it easier for new
> contributors to get going (I discovered those by trial and error).
>
> Signed-off-by: Evgeniy Litvinenko <evgeniyl@fb.com>
> ---

I've also added links to clang and pahole source code and adjusted
punctuation and the commit message a bit. Pushed to bpf-next, thanks!

>  tools/testing/selftests/bpf/README.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index 8deec1ca9150..e47786e93159 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -19,6 +19,13 @@ the CI. It builds the kernel (without overwriting your existing Kconfig), recomp
>  bpf selftests, runs them (by default ``tools/testing/selftests/bpf/test_progs``) and
>  saves the resulting output (by default in ``~/.bpf_selftests``).
>
> +Script dependencies:
> +- clang
> +- qemu
> +- pahole
> +- docutils (for ``rst2man``)
> +- libcap-devel
> +
>  For more information on about using the script, run:
>
>  .. code-block:: console
> --
> 2.30.2
>
