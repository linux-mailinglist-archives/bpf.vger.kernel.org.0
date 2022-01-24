Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305149A8AC
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiAYDKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3412038AbiAYAfe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 19:35:34 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47BC0617A4
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 14:19:30 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o10so15253492ilh.0
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THQAUN1mbEudksIDDLPlW1QcJyiqdIPagdOlq/nWl68=;
        b=N0Q7pEz89wajTQyGT34jsiXokry693HX1d/6w9o68POeEL8q2BRjMv+sKQTsI4gErG
         KmpgO7wgcvFAFFIqyan7LEsl8Uv07ZavMglwtF29yLw/GGCd6dMPMz2vTmjU5hh+pKnu
         yzoOfkvzzGD3/AMR5e+BfuKcvU9tb7begoXDEVJgvv8BQGW0kjvLsvPOTj+bPiOUztGQ
         HiFfVl078xESly6WoD4Zp3RdEQppfbTCCZExmen2iAnDAWtpyAs8ssZAD8fZ/ujiwo55
         4weve12HC+A4z7jMowYtHoXKoVqpSm/j4EbhnQRKVOXGxTDcAoNAzC/5/dZW5OXC3zox
         2Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THQAUN1mbEudksIDDLPlW1QcJyiqdIPagdOlq/nWl68=;
        b=STjWsEDWyqQ72fF6a/twRmlg4zC+c58vNuA8IepM71rHzDu0AJlTpEi44Vm6nsrovU
         lYl33hHXApXSAMpOtdOFBUBOzShpsy2kJYugmTGSjdhdV9A+dsmjjh5t1FJgRHMiDJ+5
         smsFbDCdt8J1kCT8CF96LY4n+a8HUyjrJf9iuTZ+GgGpZcxhOOCuwbPVO/z7ly3T/tin
         u/SZ8ZjztO981H7wfDUwju3Rf0AnXvLEHLowEGDXgS7R+hIBuunTAnMZuWi0T4nDNggL
         Jty9lS04y8aGO+W9w70V2JpSxo03RBTRks1pT6eawNLmNWxkSMLroO/EggtYdD6Yceez
         0thQ==
X-Gm-Message-State: AOAM530/grZyBNpCGeSQq5xYuaJEBi44oMne3E6Qp0z0B2J5LauR/g5Z
        Gj8wyE45VZjWNZaCRiyZISbS2VnprOzRigorsnWFJu/Dbgk=
X-Google-Smtp-Source: ABdhPJyG1XdeGNpFeSpUzgr19rqvHdDDAXUevKiy+/Q9edpnQapIsLcNy9CLeVN079axBcaKX7TLHC6+2WB+9W4+D4I=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr9789637iln.98.1643062769974;
 Mon, 24 Jan 2022 14:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220124185403.468466-1-kennyyu@fb.com>
 <20220124185403.468466-2-kennyyu@fb.com>
In-Reply-To: <20220124185403.468466-2-kennyyu@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 14:19:18 -0800
Message-ID: <CAEf4BzYOZtORr63NbnTwcgob+aoNhk-Y_v4PpQiZenGHS-FHJw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/4] bpf: Add support for bpf iterator
 programs to use sleepable helpers
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 10:54 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> This patch allows bpf iterator programs to use sleepable helpers by
> changing `bpf_iter_run_prog` to use the appropriate synchronization.
> With sleepable bpf iterator programs, we can no longer use
> `rcu_read_lock()` and must use `rcu_read_lock_trace()` instead
> to protect the bpf program.
>
> Signed-off-by: Kenny Yu <kennyyu@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  kernel/bpf/bpf_iter.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index b7aef5b3416d..110029ede71e 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -5,6 +5,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
> +#include <linux/rcupdate_trace.h>
>
>  struct bpf_iter_target_info {
>         struct list_head list;
> @@ -684,11 +685,20 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>  {
>         int ret;
>
> -       rcu_read_lock();
> -       migrate_disable();
> -       ret = bpf_prog_run(prog, ctx);
> -       migrate_enable();
> -       rcu_read_unlock();
> +       if (prog->aux->sleepable) {
> +               rcu_read_lock_trace();
> +               migrate_disable();
> +               might_fault();
> +               ret = bpf_prog_run(prog, ctx);
> +               migrate_enable();
> +               rcu_read_unlock_trace();
> +       } else {
> +               rcu_read_lock();
> +               migrate_disable();
> +               ret = bpf_prog_run(prog, ctx);
> +               migrate_enable();
> +               rcu_read_unlock();
> +       }
>
>         /* bpf program can only return 0 or 1:
>          *  0 : okay
> --
> 2.30.2
>
