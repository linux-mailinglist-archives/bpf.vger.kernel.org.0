Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D9296758
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900959AbgJVWd3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895132AbgJVWcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Oct 2020 18:32:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB8C0613CF
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 15:32:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 1so1735416ple.2
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 15:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WP7MQH1ssAvDqFVXPY7V60qwcY9Im9dBsz5m4rL+ry8=;
        b=bIdceANej9lvuMPIaaLVFAdg2WqmqLlyNevfjw/ZimJhZx7nxKRHwJNp8tRnvP/ZX5
         C7E2p+hF/bFjvlQn97TfVSBWGRz53q2S8l2zRujVs8nBmbydDrs0P99KtLU2wmGowHSg
         8zkarDzOOeyc/ekBsYRaTSB22cjwUsXuLoCWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WP7MQH1ssAvDqFVXPY7V60qwcY9Im9dBsz5m4rL+ry8=;
        b=qBu4FBS1R5+OC6HEPWXk3DCskk30+LDDf/XjWrc17SYLP4mPLqLuNuWtt4PkFkpzbC
         34vxsz/uJRc2e51S9dlY/AoFMNDAgya+/Nvd4rUAqIkrvjEvBIfGZLfD3rTdeE6hCvDL
         tEdo/jSjTqFcDNyy4KY4GWaaDyLlRan+tn1HaloAjcgoscM2Tynp5IhxfgV3cJh09EjK
         wKiwGKRlYnfJlZdm2PNeEnWa3qbt85lZbtErjEyGgaOc1liU62q09DULhhP4G1unGoGY
         An83sAN69KXAhmQEuwv9XgC1a4LCO/lfBEYQeJFXvLPcBFoiyV7zEfm8j67tya9GfZmS
         XHCA==
X-Gm-Message-State: AOAM531GT9m6rajoINOAUmEGzXq/2IQ+YRAIcL1ZJ5dbsd7EBIrqHB23
        Js91c4Raesv4zAwI50vy+bvKQw==
X-Google-Smtp-Source: ABdhPJx9pRKL66H6CiwdaLL0xcN1gIQVhntB/+tpFfDzpc1b3GAd8xuM23vsryV1EPMtKne4pmJn8A==
X-Received: by 2002:a17:902:ee52:b029:d5:dd2d:df92 with SMTP id 18-20020a170902ee52b02900d5dd2ddf92mr4667294plo.37.1603405953445;
        Thu, 22 Oct 2020 15:32:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u65sm3394821pfc.11.2020.10.22.15.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:32:32 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:32:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202010221520.44C5A7833E@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook>
 <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook>
 <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 22, 2020 at 03:52:20PM -0500, YiFei Zhu wrote:
> On Mon, Oct 12, 2020 at 7:31 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> > On Mon, Oct 12, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
> > > I think it's fine to just have this "dangle" with a help text update of
> > > "if seccomp action caching is supported by the architecture, provide the
> > > /proc/$pid ..."
> >
> > I think it would be weird if someone sees this help text and wonder...
> > "hmm does my architecture support seccomp action caching" and without
> > a clear pointer to how seccomp action cache works, goes and compiles
> > the kernel with this config option on for the purpose of knowing if
> > their arch supports it... Or, is it a common practice in the kernel to
> > leave dangling configs?
> 
> Bump, in case this question was missed.

I've been going back and forth on this, and I think what I've settled
on is I'd like to avoid new CONFIG dependencies just for this feature.
Instead, how about we just fill in SECCOMP_NATIVE and SECCOMP_COMPAT
for all the HAVE_ARCH_SECCOMP_FILTER architectures, and then the
cache reporting can be cleanly tied to CONFIG_SECCOMP_FILTER? It
should be relatively simple to extract those details and make
SECCOMP_ARCH_{NATIVE,COMPAT}_NAME part of the per-arch enabling patches?

> I don't really want to miss the 5.10 merge window...

Sorry, the 5.10 merge window is already closed for stuff that hasn't
already been in -next. Most subsystem maintainers (myself included)
don't take new features into their trees between roughly N-rc6 and
(N+1)-rc1. My plan is to put this in my -next tree after -rc1 is released
(expected to be Oct 25th).

I'd still like to get more specific workload performance numbers too.
The microbenchmark is nice, but getting things like build times under
docker's default seccomp filter, etc would be lovely. I've almost gotten
there, but my benchmarks are still really noisy and CPU isolation
continues to frustrate me. :)

-- 
Kees Cook
