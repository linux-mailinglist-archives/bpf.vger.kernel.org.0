Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC52A27924C
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIYUhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgIYUhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 16:37:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15280C0613D3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 13:37:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so4348327pfd.5
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GfC/K5/eyr5f/R6KNnYNTFVKM8gTDhQ8O0T6Bc65g7I=;
        b=iuXRcgXHEiB9o39H9hbvhItGSIju7sdYkPIXMM1iEESsQCqXomWCjd5+I/Y72J3MmH
         pE8Ycf2qbqERCla+//BzWiE8E/xZAo9m473D7cg0uxM/yJXGtfUTlhDO2rRmdAOvY+dE
         v9Kt55YnQOItQGdI3tA4n/0wtmB/7neNsMa94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GfC/K5/eyr5f/R6KNnYNTFVKM8gTDhQ8O0T6Bc65g7I=;
        b=sJ3oE94UwEPwossnkSMpXKesSJaRzu3YHVRVImoVFL7BqqlDmLs3nGlH9xmHQqgdeQ
         yE80m815cjFuthprhYuwrmstxO7fikvvugSxUn/9KSJRx+C3mRvMaANAqBE9BZXOZzDS
         H4VsncyzBNMVj5S1Z1seKAGooaXrBLvzFTFlT8YZYwWzUcobqNBlARZ5+j6E+39UjrdW
         supBwq35MNydTA5m0rjz9+x34xG9f1xlxO6HSoPlJmBof6IvMxYW9oRomH0Ob2QlmSda
         HLk3Vp4P7m26OxpelMcN6kfs3x7fJAvq9pKKtSHapgsoMy5K+6J5gfHov2Jjo3hB1aNk
         Dlgw==
X-Gm-Message-State: AOAM533UFaZ8lZ+OQouR+wLzMUwqtJ3ZTGyeHQx7OKS22ENMl3Gd+Xhp
        sRFomVxgrgg0L9seWnTFVaTc7A==
X-Google-Smtp-Source: ABdhPJx5DRTSBJLZM4R1CgkCB9Vmp/ILkSaDUH73jMRCTvs/2F79SPo4ijjl1Tk1Fd/fHgDAR7Ze3g==
X-Received: by 2002:aa7:8249:0:b029:142:2501:34db with SMTP id e9-20020aa782490000b0290142250134dbmr982040pfn.52.1601066229568;
        Fri, 25 Sep 2020 13:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z8sm3049258pgr.70.2020.09.25.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 13:37:08 -0700 (PDT)
Date:   Fri, 25 Sep 2020 13:37:07 -0700
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
Message-ID: <202009251332.24CE0C58@keescook>
References: <202009251223.8E46C831E2@keescook>
 <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 12:51:20PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Sep 25, 2020, at 12:42 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > ﻿On Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
> >> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >>>> Why do the prepare here instead of during attach? (And note that it
> >>>> should not be written to fail.)
> >>> 
> >>> Right.
> >> 
> >> During attach a spinlock (current->sighand->siglock) is held. Do we
> >> really want to put the emulator in the "atomic section"?
> > 
> > It's a good point, but I had some other ideas around it that lead to me
> > a different conclusion. Here's what I've got in my head:
> > 
> > I don't view filter attach (nor the siglock) as fastpath: the lock is
> > rarely contested and the "long time" will only be during filter attach.
> > 
> > When performing filter emulation, all the syscalls that are already
> > marked as "must run filter" on the previous filter can be skipped for
> > the new filter, since it cannot change the outcome, which makes the
> > emulation step faster.
> > 
> > The previous filter's bitmap isn't "stable" until siglock is held.
> > 
> > If we do the emulation step before siglock, we have to always do full
> > evaluation of all syscalls, and then merge the bitmap during attach.
> > That means all filters ever attached will take maximal time to perform
> > emulation.
> > 
> > I prefer the idea of the emulation step taking advantage of the bitmap
> > optimization, since the kernel spends less time doing work over the life
> > of the process tree. It's certainly marginal, but it also lets all the
> > bitmap manipulation stay in one place (as opposed to being split between
> > "prepare" and "attach").
> > 
> > What do you think?
> > 
> > 
> 
> I’m wondering if we should be much much lazier. We could potentially wait until someone actually tries to do a given syscall before we try to evaluate whether the result is fixed.

That seems like we'd need to track yet another bitmap of "did we emulate
this yet?" And it means the filter isn't really "done" until you run
another syscall? eeh, I'm not a fan: it scratches at my desire for
determinism. ;) Or maybe my implementation imagination is missing
something?

-- 
Kees Cook
