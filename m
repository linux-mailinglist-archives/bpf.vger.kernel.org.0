Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3258912830A
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTUKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 15:10:45 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43440 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTUKp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 15:10:45 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so4082407qvo.10;
        Fri, 20 Dec 2019 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AnFVXcpaMggl4isK2KnEZsWpPp4HGly8JnBK5gmpAI=;
        b=oK+kh+0MsknQ032w8zMAVC02TIgrYGdMIyen1bd/7jTfWFT2IFI1Nc2kd5KWVzFBOz
         K03JieNRd9G5plx77dxoI8pRx/tXmZjQ9tfPA/ZzV05xXsg+dv8wNBFvhgLL49Hhq2NT
         BocZcc8p1vTo2TDOWcA7k/VwvY6oHtPI8k50P6fSHcJ3W8HqbgoHL0eWlVm8tKocoFk5
         1T2RMeGY37h32j/v00dGq8XeIDJAuCP30SgmB285PfEyxSPCzjecSWA4SutWSotiYTKD
         BYeK0hgzwG5sg3mXolyArUptUW8rai4nDroBqbWa5fHgb44vizfRtdMpmgK1OgkAcIXU
         Fifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AnFVXcpaMggl4isK2KnEZsWpPp4HGly8JnBK5gmpAI=;
        b=F2hk3ZkxJxsow+VvAEKZzoZVo6uDl0jiNKmRPJ7irvH5qws0R7xZ2saPF+uJX6/91A
         +ZI+gGPSO1RZhzi7iaot06PF8OZMn12LPr0Naak3LUZTFfdCPVQZTOZMwHUWE4J4tRRv
         RNGieo4c3a3qyCgkA/cruYhNJlaYd2ffFtZ+2FgsSfZ1d10tg/9sPNwIHr+CEF/fPuRI
         4uo0Yeq1cWR9q7TLbMrAVa5qlXD1XP9jcqa9pxT7F5bPpsJOab1pvRcfhJL8sILMNOVz
         eSi7txpvVxT0PAIhCyi1ok2+jpJxdEd/glXg0DBajqVDBvaUTQJjPwh/N9izLq/9cNZd
         p3hg==
X-Gm-Message-State: APjAAAXAneVIKVMGIohjui//EfTMH7kfWcmDGP/Bvk4hVLvHRrsidQ2z
        j5w450Pml6qiGYhgBAcGmQwX/q3locxqt4vfh+8=
X-Google-Smtp-Source: APXvYqzMC8VDhootDrscnawAbrG4m/tH2DJ6nL/RoOUGJXfF1Ax00uff5xVnpdZ4pFD120TXNJUKVLUW0LWv4zXXmXs=
X-Received: by 2002:a0c:990d:: with SMTP id h13mr13782566qvd.247.1576872643845;
 Fri, 20 Dec 2019 12:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-2-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 12:10:32 -0800
Message-ID: <CAEf4BzZJf_GBCXYYmE0Hk7O2GdeOr-3VCxdAaxCUk-MHRar3Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Refactor BPF_EVENT context macros
 to its own header.
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> These macros are useful for other program types than tracing.
> i.e. KRSI (an upccoming BPF based LSM) which does not use
> BPF_PROG_TYPE_TRACE but uses verifiable BTF accesses similar
> to raw tracepoints.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_event.h | 78 +++++++++++++++++++++++++++++++++++++++
>  include/trace/bpf_probe.h | 30 +--------------
>  kernel/trace/bpf_trace.c  | 24 +-----------
>  3 files changed, 81 insertions(+), 51 deletions(-)
>  create mode 100644 include/linux/bpf_event.h
>
> diff --git a/include/linux/bpf_event.h b/include/linux/bpf_event.h
> new file mode 100644
> index 000000000000..353eb1f5a3d0
> --- /dev/null
> +++ b/include/linux/bpf_event.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +
> +/*
> + * Copyright (c) 2018 Facebook
> + * Copyright 2019 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_EVENT_H
> +#define _LINUX_BPF_EVENT_H
> +
> +#ifdef CONFIG_BPF_EVENTS
> +
> +/* cast any integer, pointer, or small struct to u64 */
> +#define UINTTYPE(size) \
> +       __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> +                  __builtin_choose_expr(size == 2, (u16)2, \
> +                  __builtin_choose_expr(size == 4, (u32)3, \
> +                  __builtin_choose_expr(size == 8, (u64)4, \
> +                                        (void)5)))))
> +#define __CAST_TO_U64(x) ({ \
> +       typeof(x) __src = (x); \
> +       UINTTYPE(sizeof(x)) __dst; \
> +       memcpy(&__dst, &__src, sizeof(__dst)); \
> +       (u64)__dst; })
> +
> +#define __CAST0(...) 0
> +#define __CAST1(a, ...) __CAST_TO_U64(a)
> +#define __CAST2(a, ...) __CAST_TO_U64(a), __CAST1(__VA_ARGS__)
> +#define __CAST3(a, ...) __CAST_TO_U64(a), __CAST2(__VA_ARGS__)
> +#define __CAST4(a, ...) __CAST_TO_U64(a), __CAST3(__VA_ARGS__)
> +#define __CAST5(a, ...) __CAST_TO_U64(a), __CAST4(__VA_ARGS__)
> +#define __CAST6(a, ...) __CAST_TO_U64(a), __CAST5(__VA_ARGS__)
> +#define __CAST7(a, ...) __CAST_TO_U64(a), __CAST6(__VA_ARGS__)
> +#define __CAST8(a, ...) __CAST_TO_U64(a), __CAST7(__VA_ARGS__)
> +#define __CAST9(a, ...) __CAST_TO_U64(a), __CAST8(__VA_ARGS__)
> +#define __CAST10(a ,...) __CAST_TO_U64(a), __CAST9(__VA_ARGS__)
> +#define __CAST11(a, ...) __CAST_TO_U64(a), __CAST10(__VA_ARGS__)
> +#define __CAST12(a, ...) __CAST_TO_U64(a), __CAST11(__VA_ARGS__)
> +/* tracepoints with more than 12 arguments will hit build error */
> +#define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
> +
> +#define UINTTYPE(size) \
> +       __typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
> +                  __builtin_choose_expr(size == 2, (u16)2, \
> +                  __builtin_choose_expr(size == 4, (u32)3, \
> +                  __builtin_choose_expr(size == 8, (u64)4, \
> +                                        (void)5)))))

Is it the same macro as above?

> +

[...]
