Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B541943516B
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJTRjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 13:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTRjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 13:39:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15391C06161C;
        Wed, 20 Oct 2021 10:36:47 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b9so1912644ybc.5;
        Wed, 20 Oct 2021 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnOn7gWEVYHdcRp4y5YIlp2bdpip9/giinxRFtcv7E8=;
        b=FqrlMr3zEzSN/Nw/bfV2e4wEqtydzRWtn+s0D6SrnhDkMb8N9TXPWo6PWM9kUv584r
         KQWDLFvkMSIawnDiKHW3ZTiwu8oWT5URzw7yUuhiZXcclMzDWKmtlCTRfnTlDjy1NJ/U
         x7PJ4ovsL1mQGJbIvk3QTeds5bFFCsB+SZQxV5EOlx0nnStMIxOjww4JF5M3JgKcb8fX
         tYh3AucH6DrIaKfN0zHvhVqmCt1XSG83ZeIobOEGhdmglmcf9+tB68nhoOIS8XbNvhGL
         ZMeIHqwwP8kaOafKHHZ639AE5TN0/Vou5FlcVoIby6Q7PNRb7b7eAx1Yp4jia7Pj7Lm8
         Kb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnOn7gWEVYHdcRp4y5YIlp2bdpip9/giinxRFtcv7E8=;
        b=ltQ7m6R7U5ORzuCKVO8LtxmWrECHDL6wfcP91fqKiNs2d6qZfBegcyhH6KQjVBDlxT
         HBt/1/AnEZkRJUTRGi9vj8VIriGRXkfL1IiByRdrA1FVrBfwblgHpUI4zyCnQVGAqC/1
         Pu3dAoFS4B9jDwKbJwk2Fv8UmNvrRfZRz1NV0ZxZXJE8lcHZu9ekLbdfZt4nb76W7IGU
         oj0FGe72qg4TxmapCa/IZ3b6JWGe8/oeUaDCEW+btK+Gy+HGiFGaAELHtMrcgbtspnsa
         75Z5G5MnsqFsr5vPudfK5BuK8t/WyiF/boKOwVuczNMR74OJQliLHuGdkvUrJOKZ/Odc
         p8EA==
X-Gm-Message-State: AOAM533U4hkdFsgKNFvrjyakGwyyaRdZiZSH7p3LXzbw6pRH3mkuBrZO
        gHuILrsgYb6JkUCybVaPN4pgXL2SPefeRniXZo4=
X-Google-Smtp-Source: ABdhPJxXxMyzxPfAX7WpZ5q97gB6wu/EJh0YhUymgRLhjWQd+9c+tfFWHj1N7zd1lAoOGm9afcTQXtzFS1sWhh/p9xU=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr385695ybf.455.1634751406275;
 Wed, 20 Oct 2021 10:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211011082031.4148337-1-davemarchevsky@fb.com> <20211011082031.4148337-2-davemarchevsky@fb.com>
In-Reply-To: <20211011082031.4148337-2-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 10:36:35 -0700
Message-ID: <CAEf4BzbRdUn4FG208egs+MuHy37W5=Tp=CHngMLQdNyZooWqiQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] libbpf: migrate internal use of bpf_program__get_prog_info_linear
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 1:20 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> In preparation for bpf_program__get_prog_info_linear, move the single

for bpf_program__get_prog_info_linear *deprecation* ? fixed it up while applying

> use in libbpf to call bpf_obj_get_info_by_fd directly.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

I've applied this patch for now, as it is pretty independent (and I've
already fixed it up already and didn't want to lose that :) I hope you
don't mind.

>  tools/lib/bpf/libbpf.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ed313fd491bd..8b86c4831aa8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8459,26 +8459,24 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>
>  static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>  {
> -       struct bpf_prog_info_linear *info_linear;
> -       struct bpf_prog_info *info;
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
>         struct btf *btf;
>         int err;
>
> -       info_linear = bpf_program__get_prog_info_linear(attach_prog_fd, 0);
> -       err = libbpf_get_error(info_linear);
> +       err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
>         if (err) {
> -               pr_warn("failed get_prog_info_linear for FD %d\n",
> +               pr_warn("failed bpf_obj_get_info_by_fd for FD %d\n",

I've also added err code into warn message here

>                         attach_prog_fd);
>                 return err;
>         }
>
>         err = -EINVAL;
> -       info = &info_linear->info;
> -       if (!info->btf_id) {
> +       if (!info.btf_id) {
>                 pr_warn("The target program doesn't have BTF\n");
>                 goto out;
>         }
> -       btf = btf__load_from_kernel_by_id(info->btf_id);
> +       btf = btf__load_from_kernel_by_id(info.btf_id);
>         if (libbpf_get_error(btf)) {
>                 pr_warn("Failed to get BTF of the program\n");

and here




>                 goto out;
> @@ -8490,7 +8488,6 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>                 goto out;
>         }
>  out:
> -       free(info_linear);
>         return err;
>  }
>
> --
> 2.30.2
>
