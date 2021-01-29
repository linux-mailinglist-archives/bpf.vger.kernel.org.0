Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E53083DB
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 03:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhA2Cdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 21:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2Cdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 21:33:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56851C061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 18:33:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s24so4988119pjp.5
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 18:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MG3gII+qeOjWvBYZlsxwaMzFZiXp4DBm0N7pQkjrDDE=;
        b=oByHlBRN0Oy7Yw4n0YKgh3/ISaLzLN0ZquZ/43BZkHsQr2UK/whff/agPwrLTdabZm
         RckXC1z4eXapdp89fS9NLqgrWeypN7TT9UOz/kN/fw+CqNF8iCejOlMiVtj6bF/UZcPh
         qbcMDtj41lqn6lrIJOmaIGReCSS20ScqjkGrgKQ68oDkdVbaAE0tKNR/bOBL8IIkgeB0
         RsAs0L+wjatFy+bgf5aLCKrb7JKrhQTt00S/nQOsKDKOC75iqi6EAiQkgIyMjqp3to1S
         zySoojgwzB+VRBPk83euVBDanbH+kdlconZHMAGcvif3CC0uUKfzcR3e1NberQ8sBWnN
         Kx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MG3gII+qeOjWvBYZlsxwaMzFZiXp4DBm0N7pQkjrDDE=;
        b=iaPCHSOJ8GiNidI2/QiVT1B2z4oEI/keU64d89ApTVdlwqj+KXfwYCT3TKki1dPdCq
         MDktvrDntd77WF0vay3eBdOULDej6Q7iiv+FNFnFbhlI2mpfnHOrQUk2cStRnEjRSbiy
         bUpx3n2MiWDaxRu4C21tYTD9FiFUT0GXTPt7410XCKnVvA7QZlDaYfC3gNMdLhl9ikh/
         NT4ihicU5JsR8m+7X6cWz0oduW8Qfon18U0CE1uUNY5Nhdc+hHxSSWEg+cIj/+FOF/Xl
         hb5Q2Ydchxj3FtnU5AUEMreJ2amqxCuQN2qhWV1M8K8LN0HaNuvatgnNG5l9/bKeQaHH
         LPBg==
X-Gm-Message-State: AOAM530rTyC/xAHo4Z73l3vqpfKPI2rjKOPvPc05xl+fC67sCnWDu69o
        53RetClKfE0KjxS98znZTmg=
X-Google-Smtp-Source: ABdhPJzb+z4Ne6p/YtDkjGRE+BqG3f9ZDwwYVgUVc0JqdAQkPGOUCqIdRcuVnMFku/1BCzpLaTo6tw==
X-Received: by 2002:a17:90a:5208:: with SMTP id v8mr2368040pjh.224.1611887582695;
        Thu, 28 Jan 2021 18:33:02 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id s9sm7123449pfd.38.2021.01.28.18.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 18:33:01 -0800 (PST)
Date:   Thu, 28 Jan 2021 18:32:59 -0800
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
Message-ID: <20210129023259.wffchzof4rlw5pvs@ast-mbp.dhcp.thefacebook.com>
References: <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
 <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
 <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com>
 <20210129015322.wngmsmyyon2ozcj6@ast-mbp.dhcp.thefacebook.com>
 <CALCETrU2pJUufTvr0c9jM2+ymSnYFWJ_mSJnCeEzaAiySkQyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU2pJUufTvr0c9jM2+ymSnYFWJ_mSJnCeEzaAiySkQyiA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 06:18:37PM -0800, Andy Lutomirski wrote:
> On Thu, Jan 28, 2021 at 5:53 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 05:31:35PM -0800, Andy Lutomirski wrote:
> > >
> > > What exactly could the fault code even do to fix this up?  Something like:
> > >
> > > if (addr == 0 && SMAP off && error_code says it's kernel mode && we
> > > don't have permission to map NULL) {
> > >   special care for bpf;
> > > }
> >
> > right. where 'special care' is checking extable and skipping single
> > load instruction.
> >
> > > This seems arbitrary and fragile.  And it's not obviously
> > > implementable safely without taking locks,
> >
> > search_bpf_extables() needs rcu_read_lock() only.
> > Not the locks you're talking about.
> 
> I mean the locks in the if statement.  How am I supposed to tell
> whether this fault is a special bpf fault or a normal page fault
> without taking a lock to look up the VMA or to do some other hack?

search_bpf_extables() only needs a faulting rip.
No need to lookup vma.
if (addr == 0 && search_bpf_extables(regs->ip)...
is trivial enough and won't penalize page faults in general.
These conditions are not going to happen in the normal kernel code.

> Also, why should BPF get special dispensation to generate a special
> kind of nonsensical page fault that no other kernel code is allowed to
> do?

bpf is special, since it cares about performance a lot
and saving branches in critical path is important.

> 
> >
> > > which we really ought not
> > > to be doing from inside arbitrary bpf programs.
> >
> > Not in arbitrary progs. It's only available to progs loaded by root.
> >
> > > Keep in mind that, if
> > > SMAP is unavailable, the fault code literally does not know whether
> > > the page fault originated form a valid uaccess region.
> > >
> > > There's also always the possibility that you simultaneously run bpf
> > > and something like Wine or DOSEMU2 that actually maps the zero page,
> > > in which case the effect of the bpf code is going to be quite erratic
> > > and will depend on which mm is loaded.
> >
> > It's tracing. Folks who write those progs accepted the fact that
> > the data returned by probe_read is not going to be 100% accurate.
> 
> Is this really all tracing or is some of it actual live network code?

Networking bpf progs don't use this. bpf tracing does.
But I'm not sure why you're asking.
Tracing has higher performance demands than networking.

> >
> > bpf jit can insert !null check before every such special load
> > (since it knows all of them), but it's an obvious performance loss
> > that would be good to avoid. If fault handler can do this
> > if (addr == 0 && ...) search_bpf_extables()
> > at least in some conditions and cpu flags it's already a win.
> > In all other cases bpf jit will insert !null checks.
> 
> Again, there is no guarantee that a page fault is even generated for
> this.  And it doesn't seem very reasonable for the fault code to have
> to decide whether a NULL pointer dereference is a special BPF fault or
> a real user access fault against a VMA at address 9.

The faulting address and faulting ip will precisely identify this situation.
There is no guess work.
