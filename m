Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527E1279519
	for <lists+bpf@lfdr.de>; Sat, 26 Sep 2020 01:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgIYXtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 19:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgIYXtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 19:49:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A6C0613D3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 16:49:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so3862562pgf.12
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 16:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=14YkEVFhDzQ9kmT8n7KkV3/flMwf37f3cRskNvS9iFY=;
        b=Dhq8sDfxopl4Q3cF0hfW8uacmrZsnxnqM469tF/cbaqQgWxUcLW341eZhdaC9sJJyn
         Vd3sKc0u2BFXSQkNKik6hSID7YkG5IuBWahBwm5WIw/afnoJUjS8JHe0fhpl8qgmW47h
         c60dmZk7pCOxyF5yfTJ+xxs8KpLF0NEK+0wgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14YkEVFhDzQ9kmT8n7KkV3/flMwf37f3cRskNvS9iFY=;
        b=fwVH1rhKyPkhGLXSi/WeuW/4khBILIZhf46K1qevCcJ4t9wV957CdmIDigvNJOuO/O
         vfHm1weiZNHwCW8d5LIOZdgmw4HYfWb71HukIzs6+j1exNIyLTFD8dp2UQrEGg+hMy/1
         e9gBWFXOUht+UCluhDtNnQxHZO/wentgWPuug+FNk3iiLqKma2l9crxlPUjsrafV+9bP
         RxtYG6vZumzwoGzOh5NTb3TnqGsMmS0i0O1oxZeaWxXFLRlwj/N9KKIx+2NgamMc6Q/Z
         dreF/70X+qRHfDmn3j/fpARpK4RQBOO4oHpMkb6KNfP37YtwelIfnu5zdQF1zJGQg0RY
         o0Jw==
X-Gm-Message-State: AOAM533POujFPSZuk6anqC2tIm4sNMdSVnvU270CCA6M8yw4dQMQkPUZ
        I66/JiNQInLaL1iUe0PZsueZtQ==
X-Google-Smtp-Source: ABdhPJwIDA4II9IqiZJg4n18amMCI4BVRaDrKkBU+CyInzUJOwN0xubRBevoITgIsSZwI/VVaWgDWw==
X-Received: by 2002:a17:902:ba98:b029:d1:e598:3ff2 with SMTP id k24-20020a170902ba98b02900d1e5983ff2mr1757301pls.44.1601077754849;
        Fri, 25 Sep 2020 16:49:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ml20sm240719pjb.20.2020.09.25.16.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:49:14 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:49:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
Message-ID: <202009251648.4AA27D5B@keescook>
References: <202009251223.8E46C831E2@keescook>
 <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
 <202009251332.24CE0C58@keescook>
 <CALCETrU_UpcLhXSG84SA6QkAYe8xXn4AXPKeud-=Adp57u54Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrU_UpcLhXSG84SA6QkAYe8xXn4AXPKeud-=Adp57u54Mg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 02:07:46PM -0700, Andy Lutomirski wrote:
> On Fri, Sep 25, 2020 at 1:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 12:51:20PM -0700, Andy Lutomirski wrote:
> > >
> > >
> > > > On Sep 25, 2020, at 12:42 PM, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > ﻿On Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
> > > >> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > >>>> Why do the prepare here instead of during attach? (And note that it
> > > >>>> should not be written to fail.)
> > > >>>
> > > >>> Right.
> > > >>
> > > >> During attach a spinlock (current->sighand->siglock) is held. Do we
> > > >> really want to put the emulator in the "atomic section"?
> > > >
> > > > It's a good point, but I had some other ideas around it that lead to me
> > > > a different conclusion. Here's what I've got in my head:
> > > >
> > > > I don't view filter attach (nor the siglock) as fastpath: the lock is
> > > > rarely contested and the "long time" will only be during filter attach.
> > > >
> > > > When performing filter emulation, all the syscalls that are already
> > > > marked as "must run filter" on the previous filter can be skipped for
> > > > the new filter, since it cannot change the outcome, which makes the
> > > > emulation step faster.
> > > >
> > > > The previous filter's bitmap isn't "stable" until siglock is held.
> > > >
> > > > If we do the emulation step before siglock, we have to always do full
> > > > evaluation of all syscalls, and then merge the bitmap during attach.
> > > > That means all filters ever attached will take maximal time to perform
> > > > emulation.
> > > >
> > > > I prefer the idea of the emulation step taking advantage of the bitmap
> > > > optimization, since the kernel spends less time doing work over the life
> > > > of the process tree. It's certainly marginal, but it also lets all the
> > > > bitmap manipulation stay in one place (as opposed to being split between
> > > > "prepare" and "attach").
> > > >
> > > > What do you think?
> > > >
> > > >
> > >
> > > I’m wondering if we should be much much lazier. We could potentially wait until someone actually tries to do a given syscall before we try to evaluate whether the result is fixed.
> >
> > That seems like we'd need to track yet another bitmap of "did we emulate
> > this yet?" And it means the filter isn't really "done" until you run
> > another syscall? eeh, I'm not a fan: it scratches at my desire for
> > determinism. ;) Or maybe my implementation imagination is missing
> > something?
> >
> 
> We'd need at least three states per syscall: unknown, always-allow,
> and need-to-run-filter.
> 
> The downsides are less determinism and a bit of an uglier
> implementation.  The upside is that we don't need to loop over all
> syscalls at load -- instead the time that each operation takes is
> independent of the total number of syscalls on the system.  And we can
> entirely avoid, say, evaluating the x32 case until the task tries an
> x32 syscall.
> 
> I think it's at least worth considering.

Yeah, worth considering. I do still think the time spent in emulation is
SO small that it doesn't matter running all of the syscalls at attach
time. The filters are tiny and fail quickly if anything "interesting"
start to happen. ;)

-- 
Kees Cook
