Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8941237B197
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhEKWYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:24:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE47C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:23:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r8so28370267ybb.9
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Isx1vL7wiG8GrWoWhjdURZIQr4CTuuHLR/9WfXw8Bbs=;
        b=ijGGuKw91g7K9HqV9Av5Z3h8KLFh/wmsRp1xBReql8wqVLfYZoIckvSRTguuAnVvqy
         JusISI0czkHM9EhSfaOHSxENx2KR63/eRqno18IQdSLV8Xkej08scca3uSc8KvZlO5SL
         TsT8Pagn9/w8cKLXD7YtRwHFPg3Qgu5Mk5SkCI++2jsoykVdXs0RK7fophrYf+BZjJ/X
         5Y+l2A6BvrqvObiaSsOa2PBTIj8fUt8Ffg8kpHe7dai6oe9yzqVhbetV+H0RBkyderFD
         1tLAoX6/Ylzw5GjP9UhdS19r96YM67iBBU8nlzeHJm3zwqGi6aGObmPmOJSMmyz8Itid
         FNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Isx1vL7wiG8GrWoWhjdURZIQr4CTuuHLR/9WfXw8Bbs=;
        b=RzQ69usDxF1aTBWf2pdDI7Q/KX6s+LcXfvOVtTlle3MaNsrv7cfDRVOgtxMCJ0wv5n
         QwBeVDQCFDqF2hne7xDGQnaBL+kn3zf1F0us1wSiOfSczq9ThTZhZn+rysCpWvUYS2Wd
         vvwHdLjOkF0sUbQJEbV//+AVYfO+gXh28wPO7ucztzD5uEpoyCvGfILQ+LPabvWIVp6C
         WYR7avgalupZE0eVx60ygrlgdPHMJsMOaQPc8gCrYn47Dt+WshtjvDDp9cqN0DnPE1+F
         II/XUW4LThhK72s3PU2tN/M6pEWfMti9iVvXIYLQ8IYzHqpXo6pfG56USp8bqo24b3wJ
         1jag==
X-Gm-Message-State: AOAM533XJwV1WDVAIHH76hWg54GiKX1sI9jwC7xmGSajk9TN75qenzZi
        1iZeK84QToPTI/hVPoFP0DRGY4dvRrmbg6brD2SHeD5Po5c=
X-Google-Smtp-Source: ABdhPJxKzhungp/cdGa4/hhqIZQ44D0TShJlGvyxjQiAAr9V070brH0q32ZwHM+kAXwdOBeNZgVayZZaoD4DArxEVHA=
X-Received: by 2002:a5b:d4c:: with SMTP id f12mr19370031ybr.510.1620771793495;
 Tue, 11 May 2021 15:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-3-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:23:02 -0700
Message-ID: <CAEf4BzbF7-R3sd7ftRf8MJk0mWZg4E0=bYzn8Qb3Bk9jxFmkZQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/22] bpf: Introduce bpfptr_t user/kernel pointer.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Similar to sockptr_t introduce bpfptr_t with few additions:
> make_bpfptr() creates new user/kernel pointer in the same address space as
> existing user/kernel pointer.
> bpfptr_add() advances the user/kernel pointer.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM, see minor comment below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpfptr.h | 81 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 include/linux/bpfptr.h
>
> diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
> new file mode 100644
> index 000000000000..e370acb04977
> --- /dev/null
> +++ b/include/linux/bpfptr.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* A pointer that can point to either kernel or userspace memory. */
> +#ifndef _LINUX_BPFPTR_H
> +#define _LINUX_BPFPTR_H
> +
> +#include <linux/sockptr.h>
> +
> +typedef sockptr_t bpfptr_t;
> +
> +static inline bool bpfptr_is_kernel(bpfptr_t bpfptr)
> +{
> +       return bpfptr.is_kernel;
> +}
> +
> +static inline bpfptr_t KERNEL_BPFPTR(void *p)
> +{
> +       return (bpfptr_t) { .kernel = p, .is_kernel = true };
> +}
> +
> +static inline bpfptr_t USER_BPFPTR(void __user *p)
> +{
> +       return (bpfptr_t) { .user = p };
> +}
> +
> +static inline bpfptr_t make_bpfptr(u64 addr, bool is_kernel)
> +{
> +       if (is_kernel)
> +               return (bpfptr_t) {
> +                       .kernel = (void*) (uintptr_t) addr,
> +                       .is_kernel = true,
> +               };
> +       else
> +               return (bpfptr_t) {
> +                       .user = u64_to_user_ptr(addr),
> +                       .is_kernel = false,
> +               };

Given there are KERNEL_BPFPTR and USER_BPFPTR constructors, any reason
to not use them here?

> +}
> +

[...]
