Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCC37FFC2
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhEMVXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMVXw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 17:23:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61504C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:22:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h202so36356507ybg.11
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwqqAgXpuJZWOXJXwsJMiGPYPZjwnWxuzvJIpc46848=;
        b=Yq8hh1WBqXL6fbQgySjPlvK1+5hU6P4S4XxCz7GWGQn0w0yxwLMx5esJQEZyZK9+j4
         28d3nFmD6Msw841/OoodLu/JNzJO+wIpNDozOynzGhpRBE/t7ZuWBi+P6Ujda4pIsiJh
         Fx6y6mp6oE2r5Cuce5oLiSsIokRuPpKtRzcAijlWsQY/N5H3KmoGpD6WiADHN/ZWqS3w
         Ss3QhCNeTp2+vCRiqkPPayACyb3i1frn+jDW+OLqClAfrYbhIJXoW7AeumEPv93Xt7ly
         FUTXRrPSkAcOjHm0LZf0Sw2ZWRDimxvjS92ykbtZ2GRf3K+mmvasM5UaniQXfTb6PXIX
         5AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwqqAgXpuJZWOXJXwsJMiGPYPZjwnWxuzvJIpc46848=;
        b=Weio0sKmpb9TgnqPy5vaHFo1R+gsKdymWWxn6poLBacnbTTzHfTPtMfBqTv4Hqmav5
         EODDeGYE2qzrDJBsRsef+QP5/at5OyGTqHC2q0X3BY8e36ouxQQQBUjx5sP+mbuSNKwd
         4E35KlAldH7B14mbHRNSfESLXA3bbnMIRdvIB53zhu1+ewUDIfJjlLKpClZ5yy4jEdck
         qLsmhceCBvlcPxxc210ABuQrMzzIqoN2mItz1MPV8N5iD6OPAhWVUi+LW+uIkfdWA+Vr
         PSzOCndZHYg7Fn16xMZUfzEA5SKO1XntmmoK3mkQ4y7sPZeXmn0o5Ab4Vp51obbg6mFs
         hdUw==
X-Gm-Message-State: AOAM532/91ngGvG+j0c7LgNtz4VEn/trxu4htFnI7FK0b/PqwSG0Jhsv
        5b7P5HfxHIU3so39XQOR2W1lb3qk8D6ICvRWndM=
X-Google-Smtp-Source: ABdhPJxsh4j+TUBWfTMAYAqoae4Bwg32EUcVfsh1f665CzR0abfIAhMS+sI1jyKNZHLuLD0tf9ZqMeqCAM9Ga/xsOis=
X-Received: by 2002:a25:da82:: with SMTP id n124mr86715ybf.510.1620940961744;
 Thu, 13 May 2021 14:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com> <20210512213256.31203-18-alexei.starovoitov@gmail.com>
In-Reply-To: <20210512213256.31203-18-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 14:22:30 -0700
Message-ID: <CAEf4BzbJsk3WXX90xBGH00jJq6UYMsPk+9Xn1LOuB976pfws9g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/21] bpftool: Use syscall/loader program in
 "prog load" and "gen skeleton" command.
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

On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add -L flag to bpftool to use libbpf gen_trace facility and syscall/loader program
> for skeleton generation and program loading.
>
> "bpftool gen skeleton -L" command will generate a "light skeleton" or "loader skeleton"
> that is similar to existing skeleton, but has one major difference:
> $ bpftool gen skeleton lsm.o > lsm.skel.h
> $ bpftool gen skeleton -L lsm.o > lsm.lskel.h
> $ diff lsm.skel.h lsm.lskel.h
> @@ -5,34 +4,34 @@
>  #define __LSM_SKEL_H__
>
>  #include <stdlib.h>
> -#include <bpf/libbpf.h>
> +#include <bpf/bpf.h>
>
> The light skeleton does not use majority of libbpf infrastructure.
> It doesn't need libelf. It doesn't parse .o file.
> It only needs few sys_bpf wrappers. All of them are in bpf/bpf.h file.
> In future libbpf/bpf.c can be inlined into bpf.h, so not even libbpf.a would be
> needed to work with light skeleton.
>
> "bpftool prog load -L file.o" command is introduced for debugging of syscall/loader
> program generation. Just like the same command without -L it will try to load
> the programs from file.o into the kernel. It won't even try to pin them.
>
> "bpftool prog load -L -d file.o" command will provide additional debug messages
> on how syscall/loader program was generated.
> Also the execution of syscall/loader program will use bpf_trace_printk() for
> each step of loading BTF, creating maps, and loading programs.
> The user can do "cat /.../trace_pipe" for further debug.
>
> An example of fexit_sleep.lskel.h generated from progs/fexit_sleep.c:
> struct fexit_sleep {
>         struct bpf_loader_ctx ctx;
>         struct {
>                 struct bpf_map_desc bss;
>         } maps;
>         struct {
>                 struct bpf_prog_desc nanosleep_fentry;
>                 struct bpf_prog_desc nanosleep_fexit;
>         } progs;
>         struct {
>                 int nanosleep_fentry_fd;
>                 int nanosleep_fexit_fd;
>         } links;
>         struct fexit_sleep__bss {
>                 int pid;
>                 int fentry_cnt;
>                 int fexit_cnt;
>         } *bss;
> };
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/Makefile        |   2 +-
>  tools/bpf/bpftool/gen.c           | 386 ++++++++++++++++++++++++++++--
>  tools/bpf/bpftool/main.c          |   7 +-
>  tools/bpf/bpftool/main.h          |   1 +
>  tools/bpf/bpftool/prog.c          | 107 ++++++++-
>  tools/bpf/bpftool/xlated_dumper.c |   3 +
>  6 files changed, 482 insertions(+), 24 deletions(-)
>

[...]
