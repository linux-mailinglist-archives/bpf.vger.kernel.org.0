Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A22779B7
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIXTwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXTwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 15:52:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30651C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 12:52:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so470753pfg.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k70Xue22GFlB0rY9wGgnFf8SK2vwmBPDgshtczHYd+4=;
        b=U97pSE2E3cWH2OMa2/1j1GXuJM9azr9TZPGI6w4DyW57tj+j9Ltmd/pid9zUZwnBNi
         v1Nj4NptXZH5IE/5pxa9rv2NDAvYXrXKU7qOVssXD0Xio+R+4dq8ZzTUZn5qwdmrkUA9
         t4M6wZmpJXLoyG+/Q2rEe/S1dt04TRaQ99LTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k70Xue22GFlB0rY9wGgnFf8SK2vwmBPDgshtczHYd+4=;
        b=Eeg0+KYaMs3sjehC2BhxvZ3378T0qvAV9BGyrqgvsafQ0/c0RwMjOPi5/zX8bb21lc
         Ir3K+ZdTNnnVXsANuYVsBeCIcjay+tO9R6hYCcl5T+9oroD3Oq+OLil3BwIQ+yVDC048
         RYkbDsyshfCCQoOmKiJqMSmfYCMHiHdmcMrUH3NB7ZRp4zAKY8L7Bo25LPALcXkD42s6
         UA46GGh6rvoBnZBDO38wVdVi9H/JUtlhamOYsJtwX7BcnkiHg1ZEWwjadk/DoI6wL7wR
         6tv/h8eUkgt1EWGj5HxZAbycvGH5wUBCKhmHtpCeyea0oQtWMrGLcEnBd5xacjSJyWGr
         l1Cg==
X-Gm-Message-State: AOAM532D25rTnObMa24Oxqkw8QZyWPNQOgel0rhQvXgvfSXqzUnE6NBE
        712qCRR3mdfoWPKRYES+l57Jd+78jhmO6mpG
X-Google-Smtp-Source: ABdhPJzpsUJFf8IHAHpxoWh4JONrQ/df6mHI3aKnLsuTt2XZEKCv+YjNg5jbY6Sd/88urNoAFy6ZIg==
X-Received: by 2002:a63:42:: with SMTP id 63mr553646pga.419.1600977130625;
        Thu, 24 Sep 2020 12:52:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm295305pfo.144.2020.09.24.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:52:09 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:52:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>,
        Jann Horn <jannh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] seccomp: Emulate basic filters for constant action
 results
Message-ID: <202009241251.F719CC4@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-5-keescook@chromium.org>
 <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
 <202009240038.864365E@keescook>
 <CAHC9VhQpto1KuL7PhjtdjtAjJ2nC+rZNSM7+nSZ_ksqGXbhY+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQpto1KuL7PhjtdjtAjJ2nC+rZNSM7+nSZ_ksqGXbhY+Q@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 11:28:55AM -0400, Paul Moore wrote:
> On Thu, Sep 24, 2020 at 3:46 AM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 24, 2020 at 01:47:47AM +0200, Jann Horn wrote:
> > > On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > > > This emulates absolutely the most basic seccomp filters to figure out
> > > > if they will always give the same results for a given arch/nr combo.
> > > >
> > > > Nearly all seccomp filters are built from the following ops:
> > > >
> > > > BPF_LD  | BPF_W    | BPF_ABS
> > > > BPF_JMP | BPF_JEQ  | BPF_K
> > > > BPF_JMP | BPF_JGE  | BPF_K
> > > > BPF_JMP | BPF_JGT  | BPF_K
> > > > BPF_JMP | BPF_JSET | BPF_K
> > > > BPF_JMP | BPF_JA
> > > > BPF_RET | BPF_K
> > > >
> > > > These are now emulated to check for accesses beyond seccomp_data::arch
> > > > or unknown instructions.
> > > >
> > > > Not yet implemented are:
> > > >
> > > > BPF_ALU | BPF_AND (generated by libseccomp and Chrome)
> > >
> > > BPF_AND is normally only used on syscall arguments, not on the syscall
> > > number or the architecture, right? And when a syscall argument is
> > > loaded, we abort execution anyway. So I think there is no need to
> > > implement those?
> >
> > Is that right? I can't actually tell what libseccomp is doing with
> > ALU|AND. It looks like it's using it for building jump lists?
> 
> There is an ALU|AND op in the jump resolution code, but that is really
> just if libseccomp needs to fixup the accumulator because a code block
> is expecting a masked value (right now that would only be a syscall
> argument, not the syscall number itself).
> 
> > Paul, Tom, under what cases does libseccomp emit ALU|AND into filters?
> 
> Presently the only place where libseccomp uses ALU|AND is when the
> masked equality comparison is used for comparing syscall arguments
> (SCMP_CMP_MASKED_EQ).  I can't honestly say I have any good
> information about how often that is used by libseccomp callers, but if
> I do a quick search on GitHub for "SCMP_CMP_MASKED_EQ" I see 2k worth
> of code hits; take that for whatever it is worth.  Tom may have some
> more/better information.
> 
> Of course no promises on future use :)  As one quick example, I keep
> thinking about adding the instruction pointer to the list of things
> that can be compared as part of a libseccomp rule, and if we do that I
> would expect that we would want to also allow a masked comparison (and
> utilize another ALU|AND bpf op there).  However, I'm not sure how
> useful that would be in practice.

Okay, cool. Thanks for checking on that. It sounds like the arg-less
bitmap optimization can continue to ignore ALU|AND for now. :)

-- 
Kees Cook
