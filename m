Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919FA3E4AA5
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 19:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhHIRRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhHIRRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 13:17:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54142C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 10:16:50 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a93so30947344ybi.1
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vrua/5U2MCXhEKhyrjjQz1dlh/LhKcVbNZFfPWZtVY=;
        b=Lo4KDQ2OZHLdi+no0i/kq/fr6d5FPcuXD890JUKg+bsmODQ4IlNU6YP+jXBc7pBve+
         J6pc6hpI0nJTJERP0hZvEiSQbggvpYRfw2N8Ln/1rL6DIaIPMf98SL4nKHw01dQFiF/T
         /JsxWKv4j6LHlJYgUr+fQnhJ+GvDUzXvQ/aBUy16F12u2OuIvwFA2EFFUlaxzOyntNkk
         /KGG2TkqPfqVOFxOYCqDEsJ8PBZ1e7qYB56uwAux9WLY3zLOxz0buQCWPQ1CoIr3W6fO
         9EQ1tVDPsrlOqoUXZrrMYdyalG+oamVgKpZTcMjcZ8Ezofq/kip71Qo661AsxVuIyzNq
         Bmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vrua/5U2MCXhEKhyrjjQz1dlh/LhKcVbNZFfPWZtVY=;
        b=Hec247Mjn5+AOuh39bCtlAeADyATthIAWQe5ftJHEN/r0v4Mqjcx4NCVvvAncgRmCp
         Dj02EuLOw1KLr7BIkTNJWL1Mc/f/Kjm30XPPAvLljIpNhBCAW8SEYdodtfV8kAObASgD
         hYYofI3WeXk5ORZ7xHtRwTQPTgaPh4j/kMK+R5bDnu19OmoZ8YtOoFRmKjNOEiAaq8iF
         R89VUMAu9+u2QFWId6v9i02MVjMxiaN/tPFqphffw5bhOV2RNraGmC8+kRZfZUxiodaY
         n/klUWias0iQvOmU037UhFwYEjyZSDUVvLVx+/X+KGG4v0qHZQwfEjiNiziCGpVTdVKS
         DsgQ==
X-Gm-Message-State: AOAM531FH2hRsEwSCysFwMqoU8kse6sOb3sDFj0HZqkF9iqHbo9NhnWu
        WLwGGWyPD7k96HSsFzH/0p5h81/Dd/aL1g9FiOY=
X-Google-Smtp-Source: ABdhPJyZQL/e7fGz/IRMxnrk/XP0lhacyVpmVXoUi9p68GTmrKEz2geFj/aYUwyLOIyh/GAZo5HvT6iNLlyiky/l0go=
X-Received: by 2002:a25:d691:: with SMTP id n139mr33893168ybg.27.1628529408791;
 Mon, 09 Aug 2021 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210809060310.1174777-1-yhs@fb.com> <20210809060320.1176782-1-yhs@fb.com>
In-Reply-To: <20210809060320.1176782-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 10:16:37 -0700
Message-ID: <CAEf4BzZ4-L0KQX8b+hMQZrbAejva3i4ZE1ZrjVTh-yDyUQv7=Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: add missing bpf_read_[un]lock_trace() for
 syscall program
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 8, 2021 at 11:03 PM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program type.")
> added support for syscall program, which is a sleepable program.
> But the program run missed bpf_read_lock_trace()/bpf_read_unlock_trace(),
> which is needed to ensure proper rcu callback invocations.
> This patch added bpf_read_[un]lock_trace() properly.
>
> Fixes: 79a7f8bdb159d ("bpf: Introduce bpf_sys_bpf() helper and program type.")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  net/bpf/test_run.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 1cc75c811e24..caa16bf30fb5 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -7,6 +7,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/etherdevice.h>
>  #include <linux/filter.h>
> +#include <linux/rcupdate_trace.h>
>  #include <linux/sched/signal.h>
>  #include <net/bpf_sk_storage.h>
>  #include <net/sock.h>
> @@ -951,7 +952,10 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>                         goto out;
>                 }
>         }
> +
> +       rcu_read_lock_trace();
>         retval = bpf_prog_run_pin_on_cpu(prog, ctx);
> +       rcu_read_unlock_trace();
>
>         if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
>                 err = -EFAULT;
> --
> 2.30.2
>
