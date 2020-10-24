Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B277297A63
	for <lists+bpf@lfdr.de>; Sat, 24 Oct 2020 04:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759162AbgJXCvn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 22:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758805AbgJXCvm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 22:51:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F50C0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 19:51:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g12so1932278pgm.8
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=exQNVvRWJFpZVay5bCbuF8Chc+K90S79cyDW4pCR96s=;
        b=KV9CaDvJWjMnPRerYDVMgQAXXWpZHin64zb+D/uzzh1jn14cp0unh77C/PFSi1YRzK
         RZfD1gMNw3MWr1O3MZFrAq4q3G7PSiATA+70iI9uAQA2HKgtdZPU5ZKeEhN0FxWII7A1
         PAl5jVvc7Gf5OQwDzQpiXkqTFQP3OLcIftsxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=exQNVvRWJFpZVay5bCbuF8Chc+K90S79cyDW4pCR96s=;
        b=gtrIQ3+ZP8jBvFkxR0VlUA+s75y1Pu0z6hdW8y2bDt+5HsbpUfTyVBRBHSlZ7x8DB8
         gXvY8aRlLXjzmGhrOhOplK/T5HVQ1n5247rq8ax3DBCbY2eBt+bmQu3fAznHnVCY9R+N
         KfPjQOcGg7dWZC4j1yDJMDe1m93B0iYyBUfmMPSc/PWf3p0sXu7K7J/nhm7rKqKC8Ilg
         Aqe2D0D+krb7mYUawvVI/Uw7kDKwFsC+41BoithgJf9qnbBL535gZc7kA/K7T6RKtYGP
         iHfEj1XfyqZM5fMYL53KVtTnAX11MZh/wh/GtLdI55UKLsFvMlfuBWxe5I5TBH8AcXS4
         skUg==
X-Gm-Message-State: AOAM533Hji0Zn5EPKEatHQPCYXtih3qpRCMVY8XcUtbDiDLWCGzWunHk
        ieQ+Va8nS7QP4RYw+/FkHpL95w==
X-Google-Smtp-Source: ABdhPJzyHxgz6MKrJyx7Q6S+HFMiDqjWeZc2uxi66QjlrB6Ze3vMN0w5ckv5WraSwYbQvKBy86p7Rg==
X-Received: by 2002:a63:f84c:: with SMTP id v12mr4442172pgj.125.1603507902217;
        Fri, 23 Oct 2020 19:51:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s20sm3363159pfu.112.2020.10.23.19.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 19:51:41 -0700 (PDT)
Date:   Fri, 23 Oct 2020 19:51:40 -0700
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
Message-ID: <202010231945.90FA4A4AA@keescook>
References: <cover.1602263422.git.yifeifz2@illinois.edu>
 <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook>
 <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook>
 <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook>
 <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 22, 2020 at 06:40:08PM -0500, YiFei Zhu wrote:
> On Thu, Oct 22, 2020 at 5:32 PM Kees Cook <keescook@chromium.org> wrote:
> > I've been going back and forth on this, and I think what I've settled
> > on is I'd like to avoid new CONFIG dependencies just for this feature.
> > Instead, how about we just fill in SECCOMP_NATIVE and SECCOMP_COMPAT
> > for all the HAVE_ARCH_SECCOMP_FILTER architectures, and then the
> > cache reporting can be cleanly tied to CONFIG_SECCOMP_FILTER? It
> > should be relatively simple to extract those details and make
> > SECCOMP_ARCH_{NATIVE,COMPAT}_NAME part of the per-arch enabling patches?
> 
> Hmm. So I could enable the cache logic to every architecture (one
> patch per arch) that does not have the sparse syscall numbers, and
> then have the proc reporting after the arch patches? I could do that.
> I don't have test machines to run anything other than x86_64 or ia32,
> so they will need a closer look by people more familiar with those
> arches.

Cool, yes please. It looks like MIPS will need to be skipped for now. I
would have the debug cache reporting patch then depend on
!CONFIG_HAVE_SPARSE_SYSCALL_NR.

> > I'd still like to get more specific workload performance numbers too.
> > The microbenchmark is nice, but getting things like build times under
> > docker's default seccomp filter, etc would be lovely. I've almost gotten
> > there, but my benchmarks are still really noisy and CPU isolation
> > continues to frustrate me. :)
> 
> Ok, let me know if I can help.

Do you have a test environment where you can compare the before/after
of repeated kernel build times (or some other sufficiently
complex/interesting) workload under these conditions:

bare metal
docker w/ seccomp policy disabled
docker w/ default seccomp policy

This is what I've been trying to construct, but it's really noisy, so
I've been trying to pin CPUs and NUMA memory nodes, but it's not really
helping yet. :P

-- 
Kees Cook
