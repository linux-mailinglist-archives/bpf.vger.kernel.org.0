Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514A277B1E
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIXVfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXVfV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 17:35:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E1C0613D4
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 14:35:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so797683pfc.7
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CW8CM9pV/u4FfPt/5+0+4IcrrDDgdR3Q+VzmdoOROI=;
        b=CRtDJNrzy8wbkCV74afPa/S3o604Di/g6RRZLW1jbvaELJCnfqJ5X54uFz+2y4YVd+
         JMjENCSOJ8WiO+/T8ChnYyaZuJsyEhQOs0Plk7trxC06nHNaxqpOcT8y+sEuG5d/YU/D
         b9pHibkXtd7atL74qEQo+eWeQ6auJ2I9asgk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CW8CM9pV/u4FfPt/5+0+4IcrrDDgdR3Q+VzmdoOROI=;
        b=HjsWwtTaw0lnCeoP2RfGwfqo5UUD3nRbCozyW94kXTI4je4oulLwGJ4i5OkvOS/M0J
         G6reuFk0dE2zoiasig+PvJMV5xMLmll8lsqWFYv20sOj8Bmo9rqq6Y9gmHGgIGoe9clR
         6013LlHJxuDUmQhDutrHwQNTzvx29vzJf2LqNmyOSeXx/6AG9bwrjFlfLO2/laHIzNLG
         Pp/ERRL96Ni/5UPQNgyBQJxbCtNjEkqzCkj5zRCZLEwYALoiL+fg7Xc5qQI3qFiE1MID
         R6+vz4lFk5Z3GB5sUVhni+x0JmhU2WGtqzSfZopSUo/zdWOK+fl6nfodMOCx1lBliImp
         5e3g==
X-Gm-Message-State: AOAM531En3oeLn9veh88AXtfawnJKFkfav6VKxKRI/f8lmu90UtNCJIH
        og1BdC5KULsvvBL7mKkGVnAFfA==
X-Google-Smtp-Source: ABdhPJxPeQACYa4PqAeVCmVjvEbFidWdEHIEqDxU1SIdF2rEbkc88hcnIkpEODEOh3ASDI7d2YovtA==
X-Received: by 2002:a62:e107:0:b029:13c:1611:658b with SMTP id q7-20020a62e1070000b029013c1611658bmr954182pfh.8.1600983320933;
        Thu, 24 Sep 2020 14:35:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64sm378291pfz.204.2020.09.24.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 14:35:19 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:35:18 -0700
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
Message-ID: <202009241434.CF8C1BA1D@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-5-keescook@chromium.org>
 <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
 <202009240038.864365E@keescook>
 <CAHC9VhQpto1KuL7PhjtdjtAjJ2nC+rZNSM7+nSZ_ksqGXbhY+Q@mail.gmail.com>
 <202009241251.F719CC4@keescook>
 <CAHC9VhQudGg55atznkuWWW5h0d+vZZhO2NF4yNAqreg4NDsHKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQudGg55atznkuWWW5h0d+vZZhO2NF4yNAqreg4NDsHKg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 04:46:05PM -0400, Paul Moore wrote:
> On Thu, Sep 24, 2020 at 3:52 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 24, 2020 at 11:28:55AM -0400, Paul Moore wrote:
> > > On Thu, Sep 24, 2020 at 3:46 AM Kees Cook <keescook@chromium.org> wrote:
> > > > On Thu, Sep 24, 2020 at 01:47:47AM +0200, Jann Horn wrote:
> > > > > On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > > > > > This emulates absolutely the most basic seccomp filters to figure out
> > > > > > if they will always give the same results for a given arch/nr combo.
> > > > > >
> > > > > > Nearly all seccomp filters are built from the following ops:
> > > > > >
> > > > > > BPF_LD  | BPF_W    | BPF_ABS
> > > > > > BPF_JMP | BPF_JEQ  | BPF_K
> > > > > > BPF_JMP | BPF_JGE  | BPF_K
> > > > > > BPF_JMP | BPF_JGT  | BPF_K
> > > > > > BPF_JMP | BPF_JSET | BPF_K
> > > > > > BPF_JMP | BPF_JA
> > > > > > BPF_RET | BPF_K
> > > > > >
> > > > > > These are now emulated to check for accesses beyond seccomp_data::arch
> > > > > > or unknown instructions.
> > > > > >
> > > > > > Not yet implemented are:
> > > > > >
> > > > > > BPF_ALU | BPF_AND (generated by libseccomp and Chrome)
> > > > >
> > > > > BPF_AND is normally only used on syscall arguments, not on the syscall
> > > > > number or the architecture, right? And when a syscall argument is
> > > > > loaded, we abort execution anyway. So I think there is no need to
> > > > > implement those?
> > > >
> > > > Is that right? I can't actually tell what libseccomp is doing with
> > > > ALU|AND. It looks like it's using it for building jump lists?
> > >
> > > There is an ALU|AND op in the jump resolution code, but that is really
> > > just if libseccomp needs to fixup the accumulator because a code block
> > > is expecting a masked value (right now that would only be a syscall
> > > argument, not the syscall number itself).
> > >
> > > > Paul, Tom, under what cases does libseccomp emit ALU|AND into filters?
> > >
> > > Presently the only place where libseccomp uses ALU|AND is when the
> > > masked equality comparison is used for comparing syscall arguments
> > > (SCMP_CMP_MASKED_EQ).  I can't honestly say I have any good
> > > information about how often that is used by libseccomp callers, but if
> > > I do a quick search on GitHub for "SCMP_CMP_MASKED_EQ" I see 2k worth
> > > of code hits; take that for whatever it is worth.  Tom may have some
> > > more/better information.
> > >
> > > Of course no promises on future use :)  As one quick example, I keep
> > > thinking about adding the instruction pointer to the list of things
> > > that can be compared as part of a libseccomp rule, and if we do that I
> > > would expect that we would want to also allow a masked comparison (and
> > > utilize another ALU|AND bpf op there).  However, I'm not sure how
> > > useful that would be in practice.
> >
> > Okay, cool. Thanks for checking on that. It sounds like the arg-less
> > bitmap optimization can continue to ignore ALU|AND for now. :)
> 
> What's really the worst that could happen anyways? (/me ducks)  The
> worst case is the filter falls back to the current performance levels
> right?

Worse case for adding complexity to verifier is the bitmaps can be
tricked into a bad state, but I've tried to design this so that it can
only fail toward just running the filter. :)

-- 
Kees Cook
