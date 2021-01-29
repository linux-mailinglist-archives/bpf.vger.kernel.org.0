Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3FC3082EC
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhA2BGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhA2BFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:05:25 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB80C061574
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:04:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n10so5488847pgl.10
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kvg+moAcK1B0uyTOCIXheNF9e4qMnKZztZy9w8wlYuk=;
        b=HBDGwVZHkVQ8s8Vq6s0emFWautDFD07qwBJTYwffkVLO/Ib4G1lgOw3VUHILAhd/6/
         9YoQJzN8mG0eJA57Z6hagfdmPHJakLeCnXowq9c6vTcVr6YSTD/v16Zwo6su24EbhTKk
         owiFVqEbfsUppqI8zppMU2gvhrLY3h+CsL7uSDsUrIk7Ogv3Jb62ap4inUxcapNoK0p/
         9SdbzIXDOqeoY1EjkR8xS4nr/h9XQVgDiNu5waFzylIjpQCcIK/CJ+R2Ilsiylrg67o5
         C0dm3QFnUVIEEnrrTntc8XXjPpomjqUa/yjrozS34jPVe8kk5HrDrgyZj9drjW4hOdCQ
         EaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kvg+moAcK1B0uyTOCIXheNF9e4qMnKZztZy9w8wlYuk=;
        b=i7z0/1m0d6661aygZazZ2rwBM0NiAHoJ6LIwoSjSmVUDnGK3JIM3AlzmRHS5aIjziS
         tsuxi4ELvMcA0dfpkYQdAl7iR48khfNHcVIfByObRQl+kfFJMek0E36OXMfWcaZPchtP
         JRWQSJ6HP8D4ag3MYdNRFOIwNsMkbTVWu8jXExq3V/EMEyianvgBjD1BNnlffiw7lW87
         JwU93WJF5joRCuejEY20X8Kza99kvWhwBfJdKv3xk+Ll+yuNBgF+aLvM+hVJVQYq2lJy
         wonD8B1X+7Acp5zZoOQM9JrCoMFQT6ySA7AiNPKFC08Jel7HXoJzL6UkAPeBjjdxsHtq
         cXWA==
X-Gm-Message-State: AOAM533443+bDeYigdgGDv7KZfWGZIqMn41O50j+0Hmd+np96kjSvDqS
        w/j7uI0G+DsX+wZBtdpQWNE=
X-Google-Smtp-Source: ABdhPJwYt3+L47YjMBlza+IegvejZYvvWW3O0kB+kNPaRSmLO2vs/BaFlBa+CuhwK8Slm02dW88kRw==
X-Received: by 2002:a63:e109:: with SMTP id z9mr2063754pgh.5.1611882285028;
        Thu, 28 Jan 2021 17:04:45 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id fh7sm5996320pjb.43.2021.01.28.17.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:04:44 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:04:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
 <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 04:45:41PM -0800, Andy Lutomirski wrote:
> On Thu, Jan 28, 2021 at 4:41 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 04:29:51PM -0800, Andy Lutomirski wrote:
> > > BPF generated a NULL pointer dereference (where NULL is a user
> > > pointer) and expected it to recover cleanly. What exactly am I
> > > supposed to debug?  IMO the only thing wrong with the x86 code is that
> > > it doesn't complain more loudly.  I will fix that, too.
> >
> > are you saying that NULL is a _user_ pointer?!
> > It's NULL. All zeros.
> > probe_read_kernel(NULL) was returning EFAULT on it and should continue doing so.
> 
> probe_read_kernel() does not exist.  get_kernel_nofault() returns -ERANGE.

That was an old name. bpf_probe_read_kernel() is using copy_from_kernel_nofault() now.

> And yes, NULL is a user pointer.  I can write you a little Linux
> program that maps some real valid data at user address 0.  As I noted

are you sure? I thought mmap of addr zero was disallowed long ago.

> when I first analyzed this bug, because NULL is a user address, bpf is
> incorrectly triggering the *user* fault handling code, and that code
> is objecting.
> 
> I propose the following fix to the x86 code.  I'll send it as a real
> patch tomorrow.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fixes&id=f61282777772f375bba7130ae39ccbd7e83878b2

You realize that you propose to panic kernels for all existing tracing users, right?

Do you have a specific security concern with treating fault on NULL special?
