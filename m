Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638EA276B36
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgIXHvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgIXHvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 03:51:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC90C0613CE;
        Thu, 24 Sep 2020 00:51:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so1363642pfg.13;
        Thu, 24 Sep 2020 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48nix4rTdQigZRa9Vc7CjTQh3htJMAItDGYGEpyaX94=;
        b=LQ9fBJUkchQKhpDJK824w+FTNJrBTTwrBKUZD8qpIHSBjtOPhtIzo6VKaoMMHhNFAL
         lxtHy84Dpu58G96obf8L3Wlh+T+71fNnC8Od/NwficCfZb1+GYjfYw2XDgXjFX8eIQHp
         1YiOujXN/CFMVfOoMiIOvcWc3SFrb+s0TAX5ihF2qGNHuxCsqew19roD2DweOQBLVDtI
         oJxL6FeRwxwgkHl++r4TBYC/gJdE2FOJxlzGFfJv3DJMQs64aAAa26HAOILgU8tv6S8C
         AIq1mphBEYwZbyzic6qye7YROHHz+2iilIUxfJlFdtlG08D5cGckAo8BUW4KMR9JhLdM
         rLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48nix4rTdQigZRa9Vc7CjTQh3htJMAItDGYGEpyaX94=;
        b=hFXDFZ/+Jj1c88DddS5itIKuRhjVE5Kx6nqmmwMNBLJQWflZEO69ev619gdsXNGNuD
         v94vxwlbEER56K1l+zrJlqynG8KD1X9OHM0LTerXoBdWb/NlJf1f8gbkTWkrtqb5rqnh
         pvdsOUqn+8kLzIbYKmMhUuKwcVxv+2gkEPw7d4Iz++GqC1t1SWf0gidrqLQp+v9yHnyZ
         vRZLS04//OXCfYdS618UhLPXAHmLXAWGDms6jSs4dwHDHROzNEPcFsXxgtR4A38K3Wty
         BkG3k6wInL1EBwgPWXq4yXJ3kGDIRhHBU68OT0KD+LEr+LPWFOLJlmrb7+d5+nJ5UHRV
         phYw==
X-Gm-Message-State: AOAM530lqevAecA1YrYEn6m7yLbquVz9D8jamKPR/BWYZSkAQP9dV32A
        pL+ed0m/oqQTMPc+NIopUekidsrFAynsgV1TGnGYB0sSBm3tVg==
X-Google-Smtp-Source: ABdhPJx65pp+0WKMk7ffwPmRtbbQTqLX1EOoTsZNPeH430NNbFVserZlspAwXhx3O3RcBnCwjUoE6+jE3pvHXX1gUQg=
X-Received: by 2002:a63:511d:: with SMTP id f29mr3010937pgb.11.1600933891983;
 Thu, 24 Sep 2020 00:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <DM6PR11MB271492D0565E91475D949F5DEF390@DM6PR11MB2714.namprd11.prod.outlook.com>
 <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com> <202009240037.21A9E3CE@keescook>
In-Reply-To: <202009240037.21A9E3CE@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 02:51:20 -0500
Message-ID: <CABqSeATpdn48Jbc1zLugbJBhRJNKr0P+BVx0SyODrEQgrX9HMw@mail.gmail.com>
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

On Thu, Sep 24, 2020 at 2:38 AM Kees Cook <keescook@chromium.org> wrote:
> > Would you mind educating me how this patch plan one handling MIPS? For
> > one kernel they seem to have up to three arch numbers per build,
> > AUDIT_ARCH_MIPS{,64,64N32}. Though ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> > does not seem to be defined for MIPS so I'm assuming the syscall
> > numbers are the same, but I think it is possible some client uses that
> > arch number to pose different constraints for different processes, so
> > it would better not accelerate them rather than break them.
>
> I'll take a look, but I'm hoping it won't be too hard to fit into what
> I've got designed so for to deal with x86_x32. (Will MIPS want this
> optimization at all?)

I just took a slightly closer look at MIPS and it seems that they have
sparse syscall numbers (defines HAVE_SPARSE_SYSCALL_NR). I don't know
how the different "regions of syscall numbers" are affected by arch
numbers, however...
