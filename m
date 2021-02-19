Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E722F32016E
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 23:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSWnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 17:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSWnx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 17:43:53 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C65C061574
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 14:43:12 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id t23so3517753vsk.2
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+py9f07r18FJmzwKFIMXVghRyWCx341daM+ekXv2Uw=;
        b=fBG+HUXjhHPGuYhXWWLsfrhvwWZLf1pybb+iLGfWiu4N9b7BAIWyT5EOkEfL+m+2GY
         iSbQHhUI9+cMAiHYjefgqxUc3laDStjCRlrTxHYnvmNmgs9SUmLzvpr0uLeSdOUzR2Lj
         9fNZm6SsJPIm4h9wFpZQnMmxQb4sr2y5owIE+AMiZd9umV/WfHuuzyP3kEialu5+QBfN
         w/RfuUxxYkLADlhnncI82SYkjFwTzyB6/Dio4E7NNIu8Gxd4Ca7T/ySfuW0BggD/bH6j
         F38R8rWQadk+ev8DSlyBZ++y8QrsTIan5r/Gzcm8sRgWg8Hbgcar89O3dcKsVNTcxijU
         5hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+py9f07r18FJmzwKFIMXVghRyWCx341daM+ekXv2Uw=;
        b=MossDl/8d3TF+gnxOiciAONXoHRmAfDnGKGmfoLICyzmoBf+E6blb1OQAFTtlhGLPd
         IU/K6ub7jGTsVOLa/QBdDOsU14JGMJaM3Dj+1x8UMX6b1Iljc+QTF7Zsh2BIJL7miW0B
         n1JmCOJqw/BAh6xjSh6/qOuYTzv4WWgYqqSGycmKSWGfiOvVPwSZMqXoVq9g6P0Hub2a
         l7SnxES2F6PAX4ONHXZ22kC+NHujEz1r4jDc3oVmlGVWUT20S8RoyFKxiaW9FAN2klE9
         qtXRGW8C/tiKEN1Ga4lKzNBVmKeoIU1pbm1XHsUMOJTUnH8ZzNspN8TzU9qsA9YduH8q
         dzeQ==
X-Gm-Message-State: AOAM530Zrfienye7CRQQEJj2FMcLUfS/Rzfy/omiZmfJKazs+btjppNc
        qKWKQ0TkbQGFW7+Q9TtywOyrSSjK+0gPWIONu/o=
X-Google-Smtp-Source: ABdhPJyGIr40J9f5LELfKtIfPVNoRmGBYureuLwDvdyy5+uenMxQ+Ui3Pr+WVnj/6l1BYa232/Z5fVUipal80S63Mqw=
X-Received: by 2002:a67:f845:: with SMTP id b5mr2930866vsp.22.1613774591848;
 Fri, 19 Feb 2021 14:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20210219222135.62118-1-grantseltzer@gmail.com> <20210219223639.ml445wsp5otz5cqs@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210219223639.ml445wsp5otz5cqs@kafai-mbp.dhcp.thefacebook.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 19 Feb 2021 17:43:00 -0500
Message-ID: <CAO658oUwgX-aVutTn+3f=gZ5ZfdTuHUakAetfpXo_LN=Va=SyA@mail.gmail.com>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO_BTF check to bpftool feature command
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds the CONFIG_DEBUG_INFO_BTF kernel compile option to output of
the bpftool feature command. This is relevant for developers that want
to use libbpf to account for data structure definition differences
between kernels.

Signed-off-by: grantseltzer <grantseltzer@gmail.com>
---
 tools/bpf/bpftool/feature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 359960a8f..34343e7fa 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char
*define_prefix)
                { "CONFIG_BPF_JIT", },
                /* Avoid compiling eBPF interpreter (use JIT only) */
                { "CONFIG_BPF_JIT_ALWAYS_ON", },
+               /* Enable using BTF debug information */
+               { "CONFIG_DEBUG_INFO_BTF", },

                /* cgroups */
                { "CONFIG_CGROUPS", },
--
2.29.2

On Fri, Feb 19, 2021 at 5:36 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> There is no description.  Please provide a commit message.
>
> On Fri, Feb 19, 2021 at 10:21:35PM +0000, grantseltzer wrote:
> > Signed-off-by: grantseltzer <grantseltzer@gmail.com>
> > ---
> >  tools/bpf/bpftool/feature.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > index 359960a8f..34343e7fa 100644
> > --- a/tools/bpf/bpftool/feature.c
> > +++ b/tools/bpf/bpftool/feature.c
> > @@ -336,6 +336,8 @@ static void probe_kernel_image_config(const char *define_prefix)
> >               { "CONFIG_BPF_JIT", },
> >               /* Avoid compiling eBPF interpreter (use JIT only) */
> >               { "CONFIG_BPF_JIT_ALWAYS_ON", },
> > +             /* Enable using BTF debug information */
> > +             { "CONFIG_DEBUG_INFO_BTF", },
> >
> >               /* cgroups */
> >               { "CONFIG_CGROUPS", },
> > --
> > 2.29.2
> >
