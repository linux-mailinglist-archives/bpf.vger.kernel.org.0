Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B5276538
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 02:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIXAg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 20:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgIXAg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 20:36:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D65C0613CE;
        Wed, 23 Sep 2020 17:36:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so632137pjb.2;
        Wed, 23 Sep 2020 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDFv/RhyMEgSIdYNNun/DQyCy7wkiVHBQ14Pm7oiRaY=;
        b=S+45JSXzgkr09sRCcCdhdTWZqKjGiqaOTVPh6x4Hr3IKq7yQGY+AZH+183mxSCLvjf
         2wRiljZuy+jzjhGx4hWUxnqPHkZSewMIC4SsfqC7sYaruiXEAYfAz0dUFhu/LdBzxnSc
         T/iryvQXvuvaXswywD1clzhRhQfWhW1MViaAwsLawhN5ieaIH6OPi+WcbeNL4aBPmXiP
         IVU24kMSqalWd6B+dv+TIWsi49MBYZ37xmHIgUmCrtpfjvOHVPm0V4BOjrEe9R+/Xg35
         LHOtkejtneIjgUaU/n2/kZeHlVMc7Olyns38MZQUuio2vVwhMNsgaSAGXF2IFjL2Nxes
         I68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDFv/RhyMEgSIdYNNun/DQyCy7wkiVHBQ14Pm7oiRaY=;
        b=A84O3SBhwMamp41MvRAt2WVCBeKGEbguu12+TwdUjSVR0taq7Nzhb2Uh0WP3pmmzQB
         9VnwTDm1Vc0cyJTgOsjc7NRZHpU4WmOoByhfEaUH/gPMbtmI6wxGvzExfTqmfHM+AMeN
         ARB9UeLnFjygbV0H5PuVBz6EUDSrS08o2FO1cuKdqyv3Hp6t2rSZtE0TMnYjAl9E9B+F
         xpv4mzXnFxUS9mQbN/m7JGcrMO5Jy0OGo80bTYyGRYfM7cAdgoWyBo58dIgEPC3JL4NE
         daQ+pygxmbt6TLbvu8mqIjfiVi/E8nilC6dwU2ouGuczXRdzBlPbXyCkxKFnqjpokTVn
         na2A==
X-Gm-Message-State: AOAM533Q992lPM2jW4rg0s5vmHROG4B71t/QtmxMh9pJykIC/nKt6L+Q
        Wm1g//T3F2jvt8cKoStB7NYKkul8TawO+8En3/8=
X-Google-Smtp-Source: ABdhPJzcUri7TwdVOiQl74BHN9CWV7BcbuqvjJ4JyKP1RXR2dA1KPOUbcmXOantN/zjW6Rv9EXYhMdraD4cB2D9KhSs=
X-Received: by 2002:a17:902:7445:b029:d1:dea3:a3ca with SMTP id
 e5-20020a1709027445b02900d1dea3a3camr2137109plt.19.1600907819053; Wed, 23 Sep
 2020 17:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <DM6PR11MB271492D0565E91475D949F5DEF390@DM6PR11MB2714.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB271492D0565E91475D949F5DEF390@DM6PR11MB2714.namprd11.prod.outlook.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Wed, 23 Sep 2020 19:36:47 -0500
Message-ID: <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
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
        bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 6:29 PM Kees Cook <keescook@chromium.org> wrote:
> In order to optimize these cases from O(n) to O(1), seccomp can
> use bitmaps to immediately determine the desired action. A critical
> observation in the prior paragraph bears repeating: the common case for
> syscall tests do not check arguments. For any given filter, there is a
> constant mapping from the combination of architecture and syscall to the
> seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
> there is a single architecture.). As such, it is possible to construct
> a mapping of arch/syscall to action, which can be updated as new filters
> are attached to a process.

Would you mind educating me how this patch plan one handling MIPS? For
one kernel they seem to have up to three arch numbers per build,
AUDIT_ARCH_MIPS{,64,64N32}. Though ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
does not seem to be defined for MIPS so I'm assuming the syscall
numbers are the same, but I think it is possible some client uses that
arch number to pose different constraints for different processes, so
it would better not accelerate them rather than break them.


YiFei Zhu
