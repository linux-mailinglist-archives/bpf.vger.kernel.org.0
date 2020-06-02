Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE781EC1EE
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBShH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgFBShH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 14:37:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A7C08C5C0
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 11:37:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ga6so1846052pjb.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8dG0md9kRtQdhb5ndQIeK/md9siJkHaGPvTY//uOBy0=;
        b=XaflqCjUN5FlsSToFlemzZsicWkV7UiByjL1K+8nJwpfrk/XBK2IMEhe7j87uftOHn
         gnu9hYKNoCQLHq731B/6kHrGtz2Pv1doz3UAgO4D4lAXKUxvPKJ4ZL0ifT6AiLyWDMmZ
         7f3RxcvYsG5dBx0jeCqXTEtMHexa39uytugic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dG0md9kRtQdhb5ndQIeK/md9siJkHaGPvTY//uOBy0=;
        b=NRHC09lRmD++YGf7thaGYGqFXapAXIyhgB7tNUKb4rZnwsTXlKede100XnjIG4J+pt
         eVvjMF76T2JYRDXu7F6RBs6UQLvde8pMy1ccta8q3Nk6HsAWWEmdLwCHWys7v5WO98Jp
         PaBw06UW+Qn/LRf+6rXAgypzvmZ56WBTZ7RHP6Fy6h9zSVOVrq/cA3oUWJHA5e2rlFUc
         47ySVfRe8ePDaF5CNDmgi7o36eBKt2d6cGmvjqNWaN5iSga1FQAdzAyTPaWywjJVJgjX
         bRuvh6wgoJDfIp+rkjuqIHFc5eo5fsVJPmfxJWBMVk28Ob2YKd7uYbfYF7itvGR9/2VP
         bmiA==
X-Gm-Message-State: AOAM530G1POOP7su02cyZDfH7hj7ltmv+bLoK9DEQss6KaVpru8TGC3o
        UTKfxcyM33N2refaLDT4nimPsw==
X-Google-Smtp-Source: ABdhPJxD/FOrnJrOJVhrgLcoDL4iQd0QuWXdekzpe4mOo9jOEa2SIrGMc52PTw3PCXMBOQWbINkdsg==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr26165164plq.111.1591123025384;
        Tue, 02 Jun 2020 11:37:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g29sm2495660pfr.47.2020.06.02.11.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:37:04 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:37:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006021133.B63A634406@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <202006011116.3F7109A@keescook>
 <20200602124431.GA123838@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602124431.GA123838@gardel-login>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 02, 2020 at 02:44:31PM +0200, Lennart Poettering wrote:
> On Mo, 01.06.20 11:21, Kees Cook (keescook@chromium.org) wrote:
> > Would it make sense to provide a systemd setting for services to declare
> > "no compat" or "no x32" (I'm not sure what to call this mode more
> > generically, "no 32-bit allocation ABI"?) Then you can just install
> > a single merged filter for all the native syscalls that starts with
> > "if not native, reject"?
> 
> We have that actually, it's this line you pasted above:
> 
>         SystemCallArchitectures=native
> 
> It means: block all syscall ABIs but the native one for all processes
> of this service.
> 
> We currently use that setting only to synthesize an explicit seccomp
> filter masking the other ABIs wholesale. We do not use it to suppress
> generation of other, unrelated seccomp filters for that
> arch. i.e. which means you might end up with one filter blocking x32
> wholesale, but then another unrelated option might install a filter
> blocking some specific syscall with some specific arguments, but still
> gets installed for x86-64 *and* i386 *and* x32. I guess we could
> relatively easily tweak that and suppress the latter. If we did, then
> on all services that set SystemCallArchitectures=native on x86-64 the
> number of installed seccomp filters should become a third.

Right, that's what I meant -- on x86_64 we've got way too many filters
installed if we only care about "native" arch. ;)

> > (Or better yet: make the default for filtering be "native only", and
> > let services opt into other ABIs?)
> 
> That sounds like it would make people quite unhappy no? given that on
> a systemd system anything that runs in userspace is ultimately part of
> a service managed by systemd, if we'd default to "no native ABIs" this
> would translate to "yeah, we entirely disable the i386 ABI for the
> entire system unless you reconfigure it and/or opt-out your old i386
> services".
> 
> Hence, on x86-64, I figure just masking i386 entirely is a bit too
> drastic a compat breakage for us, no? Masking x32 otoh sounds like a
> safe default to do without breaking too much compat given that x32 is
> on its way out.

Well, I meant "if seccomp filters get generated, default to native ABI".
Right now, it seems most things running from systemd with seccomp
filters are daemons, not user processes? (e.g. ssh.server,
getty@.service, etc have no filtering attached.)

-- 
Kees Cook
