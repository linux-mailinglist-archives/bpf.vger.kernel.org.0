Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFEE2CB4C7
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 07:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgLBF7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLBF7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 00:59:55 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992DC0617A6;
        Tue,  1 Dec 2020 21:59:14 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id x17so568991ybr.8;
        Tue, 01 Dec 2020 21:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F94yO1pwn3xIo22l06GSRvMTzN1e1hNRNmIShFlxrFg=;
        b=pDgtDxwd9en7BP/yXgYVNIbfwdxQtUIuwHWBkQJ3tfIXoiqveXReo80hcEaTrNRj9m
         4KUD1Q5CFPRcDuy3pfmd5mYiK84txeNb04sCEYNC9AuMqLcNCWl8lIc0t8p5a3v7MPpX
         R1Ay+QL1HUEio+BcjWcLmXuzUU748MtLnWwaJuaPDNyiwNCK02zsTBCMQdD99rieVLY+
         7btSHYeUJLLhHkiFha+u7RiX/d8Y44IJVvTAd3ao04wSKIx2anlC1aLSOGcW3fq93VHY
         SKtkAzK7SRoaO0TCvDKU+7rnf0+7gjz7gxIK+XfSZsOyhqCGQq8r8sQy8xdQoOAOubpU
         8TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F94yO1pwn3xIo22l06GSRvMTzN1e1hNRNmIShFlxrFg=;
        b=tCupU2q9+nTV6D246bZ944K8Qd3+ph3OSS3EcxVYjsk1PiqkCeWh7RZOpip3OONWnc
         8pNi1ZekAZYcuBuaS1DMj/zrP7fXAwDd2Byha+XTSjFEYPLJsO2rlMZunqlAITW+V+j3
         bBvqVEYjEOCQywYxjuPhOqEkGLtuWCujRlZuORndwxFzxTnxw4bdbEKpzdiw44ghQ4/n
         j/uT+JBdkzV6EJmw2cr9XLsfWY2rKeUYl5QuuyxiZSLCExSiIKlYKYc3PntayUzhGyQk
         BzLKbsvMkRe9mPVtKnFEumz1Te8roUWVHRYXJ5vFkNo8ksXUl2LAnlWKgmwvvrX+DT0a
         CLFA==
X-Gm-Message-State: AOAM533bD64aiKJTdlU+TZg87qvqkWvXquCh9udGZcUDvKOSfebuSecy
        it4mMhIGg4+jqEbC1kxvvwx+euWkH0mSdefnt/4=
X-Google-Smtp-Source: ABdhPJyhO2ALk+vxLjnUVqxXD+cISn4ojLs4nxlCLVf4SdZXp1WOe1coMg/ZgyLoJPrl9B9Davy3ZqH5AAif/9ROpKo=
X-Received: by 2002:a25:2845:: with SMTP id o66mr1599455ybo.260.1606888754244;
 Tue, 01 Dec 2020 21:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp> <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
 <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com> <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
 <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com> <5fc72beede900_15eb720850@john-XPS-13-9370.notmuch>
In-Reply-To: <5fc72beede900_15eb720850@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 21:59:03 -0800
Message-ID: <CAEf4BzY0vHvrj4jAc+qszSMcYABd0dGFVxkM-d8S=wwHoDFD=A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 9:53 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Yonghong Song wrote:
> >
> >
>
> [...]
>
> > > Great, this means that all existing valid uses of
> > > __sync_fetch_and_add() will generate BPF_XADD instructions and will
> > > work on old kernels, right?
> >
> > That is correct.
> >
> > >
> > > If that's the case, do we still need cpu=v4? The new instructions are
> > > *only* going to be generated if the user uses previously unsupported
> > > __sync_fetch_xxx() intrinsics. So, in effect, the user consciously
> > > opts into using new BPF instructions. cpu=v4 seems like an unnecessary
> > > tautology then?
> >
> > This is a very good question. Essentially this boils to when users can
> > use the new functionality including meaningful return value  of
> > __sync_fetch_and_add().
> >    (1). user can write a small bpf program to test the feature. If user
> >         gets a failed compilation (fatal error), it won't be supported.
> >         Otherwise, it is supported.
> >    (2). compiler provides some way to tell user it is safe to use, e.g.,
> >         -mcpu=v4, or some clang macro suggested by Brendan earlier.
> >
> > I guess since kernel already did a lot of feature discovery. Option (1)
> > is probably fine.
>
> For option (2) we can use BTF with kernel version check. If kernel is
> greater than kernel this lands in we use the the new instructions if
> not we use a slower locked version. That should work for all cases
> unless someone backports patches into an older case.

Two different things: Clang support detection and kernel support
detection. You are talking about kernel detection, I and Yonghong were
talking about Clang detection and explicit cpu=v4 opt-in.

For kernel detection, if there is an enum value or type that gets
added along the feature, then with CO-RE built-ins it's easy to detect
and kernel dead code elimination will make sure that unsupported
instructions won't trip up the BPF verifier. Still need Clang support
to compile the program in the first place, though.

If there is no such BTF-based way to check, it is still possible to
try to load a trivial BPF program with __sync_fech_and_xxx() to do
feature detection and then use .rodata to turn off code paths relying
on a new instruction set.

>
> At least thats what I'll probably end up wrapping in a helper function.
