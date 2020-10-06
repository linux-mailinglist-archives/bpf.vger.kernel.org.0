Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351DF284806
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJFIB0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Oct 2020 04:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFIB0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Oct 2020 04:01:26 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730FC061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 01:01:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so12295865qtp.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBgowMB3V0i6sZo04bdyjPSbkK5WHinUQaPovjko9D4=;
        b=nmd7QrzYOg9yQoI4Ql0fFChpJeOLuqm4AnOhBU7aZ8MrwOU/R3OxEXrDnhHdNa2SKd
         PBmOrfz3ik1XxdjeJ4k0PZVQWz/+9deIdu7HaFcd77NMRvCcBMZUEluupfq99ivJpTfo
         TBmQOkVCOcRWA3kE7N3bmJRbvtXIgjJmWX6iKtWvE8OGDkVjhF9jeymFrWT66Q4Q9ZSx
         iyr8bTgANp8FQl/o8TwYpDjsjPMJyoGIHLUkQ1SVmzl/fA02xaMAgRQS5vtRRbdAhYs1
         wjwJd8G0hWOpR1oWmDA5OgtenXaV+Nb9DzlyzK9yLM18Gqo8MnIALVsECJEh4sM4jxMA
         C/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBgowMB3V0i6sZo04bdyjPSbkK5WHinUQaPovjko9D4=;
        b=F1vM9ln/BE254kldXVpXSrz9KrL56zPwSQws81uGzoVnzHMzItVRxCTk1yuMx0LzpE
         WdGCrSYFMUCfglDsHhpSP58Msz9DqAuDHeEEivkpuWBP3F/8V2uz44SQaFKbdsu+GiYn
         taH9KUEcmHvI2Pult4s3++8PGEO7VFLD90sqY08yOSSKiyUAwHZO9WadiU2PmUf8mS1P
         hJFkDI591d3uZ6LWH7dIDg2eGw3uXN/btB+kRsmQZwlwtzsDXLmeISihd5T7d2A/tb48
         BZC/45Wslt1oVTIMiSxZEw5MNG1rwDcxxP9+IIF9AdpOU+bYnko0yAdogvCaghRg8HUT
         jHdA==
X-Gm-Message-State: AOAM533QIceeoVaaShKKmWaA/1wDpLdSBC50bUGxMfi8t5DgMu9rPsgt
        lrzlyblu6ELXdUPPtU92WFSK26sEYrv6309hi3DWHKgvBRkODA==
X-Google-Smtp-Source: ABdhPJzi+jq3Vt+Xsb6u1Iox8oD8Sz6Hg66UaPbA4iWoEahzJrLEkcvMUE4f91bZjnRwLzgcJIBd0Kn8wZasWE9UbYc=
X-Received: by 2002:ac8:5906:: with SMTP id 6mr4014457qty.100.1601971283905;
 Tue, 06 Oct 2020 01:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201005224528.389097-1-lrizzo@google.com>
In-Reply-To: <20201005224528.389097-1-lrizzo@google.com>
From:   Petar Penkov <ppenkov@google.com>
Date:   Tue, 6 Oct 2020 01:01:13 -0700
Message-ID: <CAG4SDVUaGiy3RVeA1yVpQqwGuE7MecbKe23gjE3fPFezDj4d3g@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, libbpf: use valid btf in bpf_program__set_attach_target
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     bpf@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, rizzo.unipi@gmail.com,
        Andrii Nakryiko <andriin@fb.com>, tommaso.burlon@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 5, 2020 at 3:45 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> bpf_program__set_attach_target(prog, fd, ...) will always fail when
> fd = 0 (attach to a kernel symbol) because obj->btf_vmlinux is NULL
> and there is no way to set it (at the moment btf_vmlinux is meant
> to be temporary storage for use in bpf_object__load_xattr()).
>
> Fix this by using libbpf_find_vmlinux_btf_id().
>
> At some point we may want to opportunistically cache btf_vmlinux
> so it can be reused with multiple programs.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Petar Penkov <ppenkov@google.com>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  tools/lib/bpf/libbpf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a4f55f8a460d..33bf102259dd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10353,9 +10353,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>                 btf_id = libbpf_find_prog_btf_id(attach_func_name,
>                                                  attach_prog_fd);
>         else
> -               btf_id = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> -                                              attach_func_name,
> -                                              prog->expected_attach_type);
> +               btf_id = libbpf_find_vmlinux_btf_id(attach_func_name,
> +                                                   prog->expected_attach_type);
>
>         if (btf_id < 0)
>                 return btf_id;
> --
> 2.28.0.806.g8561365e88-goog
>
