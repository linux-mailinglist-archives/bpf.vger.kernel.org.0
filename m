Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A049818FE57
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 21:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCWUAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 16:00:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36870 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCWUAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 16:00:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id d12so10459475qtj.4;
        Mon, 23 Mar 2020 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qqP3p6NUFM3pblvdRB2elYDHfWUXO+b1eOHuuUBxWo=;
        b=XN6N/+/XUOYasY96gW1pjrCuXxY8GQUlnV5GJXilFIfrrnts8K7V/RdjEIFOFdTVHo
         HkyXrkBkUIHWwEVIpaIlhoLtZdPgXWHciZQHPpjN8nZm17zewSzyr25ptGZtnsDJtfos
         b5hYAFmzOKKE4cGf0/OYqMl1A412YyF9/XtxMzfbTiYd2nPbMGfTOGXkUBGt1NkGU1a2
         NFK4I/1L1FPdpv07v9Q8Gk2q0s6BO8C7UV0AtWW1QF20Ty28GjsTddd7Qd6bXy8FQkN/
         n5AUVjtCeu6ON59Kay8w1oqAW6ZkhSv2FFqNXlUIgxenc32X/DKdsSUE7IBJRDnXY7qY
         wMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qqP3p6NUFM3pblvdRB2elYDHfWUXO+b1eOHuuUBxWo=;
        b=CxhMLGMkCEAxzXByB7DDj8pc6uH97Zyr7QSGb4Yz12+iSy7KduYSN6qiZoPvwVlKO1
         6rQuJTJgXQTP0XueNpiSM+4kdo5estzTsvHOD5oxqi5F90qdNwOX8s7/rF3wvpER33kT
         sXFpV4cDGQx0m/rrJ4OjcL1DDprKH2Rx5jzHvQbkzEocyB+3pT7miQSYVKCAYXofGmjC
         mkOQPx121Mhzwt0nWhjEyWFhSPiSWspKCItN888fswOZxJrObw1A0KzAliUkTmS8xLyB
         9ZWK4grWtrRRiTmJNONGsLyTe7MLKT49WtGi11lOeQAY6tLXJ9WHgBNyebC40NGv2fj6
         PHMw==
X-Gm-Message-State: ANhLgQ0BFDFnMUkc77QhWeZBMNK0Ws3UmberFtlI3e4X1HGV1XDV7IpH
        DJjvgt/V6SEu4YWL4jP2/HCoL//Ywbm8I2VP4CM=
X-Google-Smtp-Source: ADFU+vvNQQv8DEH2ydvf51OvRh0rhtw/VacrRt6UqgAOnjfxKJcYGr3rb/Xy/PoTxUkzYGEIVuj3IWmg/Pyvi8BMEo8=
X-Received: by 2002:ac8:7448:: with SMTP id h8mr22843425qtr.117.1584993603585;
 Mon, 23 Mar 2020 13:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-4-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-4-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 12:59:52 -0700
Message-ID: <CAEf4BzbRivYO=gVjuQw8Z8snN+RFwXswvNxs67c=5g6U3o9rmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These nops are initialized as LSM hooks in
> a subsequent patch.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..c6423a140220
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_LSM_H
> +#define _LINUX_BPF_LSM_H
> +
> +#include <linux/bpf.h>
> +#include <linux/lsm_hooks.h>
> +
> +#ifdef CONFIG_BPF_LSM
> +
> +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82875039ca90..530d137f7a84 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,25 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> + * function where a BPF program can be attached as an fexit trampoline.
> + */
> +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> +
> +#define LSM_HOOK_int(NAME, ...)                        \
> +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)        \
> +{                                              \
> +       return 0;                               \
> +}
> +
> +#define LSM_HOOK_void(NAME, ...) \
> +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> +

Could unify with:

#define LSM_HOOK(RET, NAME, ...) noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)
{
    return (RET)0;
}

then you don't need LSM_HOOK_int and LSM_HOOK_void.

> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
>
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
> --
> 2.20.1
>
