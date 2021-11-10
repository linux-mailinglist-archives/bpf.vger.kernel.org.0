Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B394144CB8A
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhKJWIC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 17:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhKJWIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 17:08:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510CC061766
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 14:05:13 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p18so4088443plf.13
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMCJqEChjKc7no6BFNRwPxnobM3vuauL8iW5w1AznL8=;
        b=RQ1f6MlbKfVGvv7RyXzmtlROwH70Gi9P7UDVL5weyOBara5IJ83yt84rVp5zBDLkJi
         qjTFOqu0zHH02o31hYezMZmDZnCZblguxfMQafJAAFwheLVy6QSHFiFLnrLmMDXoo3cV
         1WS9WTuSHeZG1zx5svYezFIePncShAkVWEEwMN9URkwfuYgpFatWdgvRfl/LVruYUlhQ
         jf8wqDgDlKZJi2/23sgtEtF24V7ngzXHeYzRll/r2AP1JIrr02+FBVF41mkKk9CYofEJ
         Xy2ql0gDr7tol138T8fgOKEE/b6KMMH8OFKmYIqUtto9S8SE4E6H45RXnqVojNgP8Phf
         XycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMCJqEChjKc7no6BFNRwPxnobM3vuauL8iW5w1AznL8=;
        b=YtKoa3GZZ6oXpEm4davE0wkuHNwgXPLu0zMOcwVcMaiP6mqDVniJceX6j8G9Rc9w25
         yYNF0Y8jfiOinV6xk9VQAaSrLiNdI5Q1cLljVt7IpIEtVtcywIfbDfRbPDrATmWaOm3h
         ycVl6+VEd/e5hPR3A7SC11hjpc+fW/GizR0SnW6NgMIwDmKvNBN5oayFGnQkOFAwdlqQ
         0gjMVkjw5M2VGsheiWK/HHzXSEggt9GuSMfcGuH2I0VnR7tWM+mPM9KfWKEjewe0BVTh
         9p6IDgo3qXO14NFdKgujALiyNSKnVpbeCmgHYpRQCx/GClWS5NjsPS9nSikr/4YCUjYW
         lQOA==
X-Gm-Message-State: AOAM531tOd3q95kzc/HMQES+NigV8JQXbXFpiLea77fxjw71NHyBx4qF
        v2I0Y0AfWHfWveWXeDFCI2rTXFVLe9p3dRKnlqw=
X-Google-Smtp-Source: ABdhPJzmYBXXYx2hTVp3ktEcrCmsiIfnJ2wGbG64MXC9+r8ezpFfIn5Pu73Sc4iUIS9smBDsJxjiwzBRBn/GcUNYUqw=
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr2725284pjy.138.1636581913067;
 Wed, 10 Nov 2021 14:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20211109003052.3499225-1-haoluo@google.com> <CAEf4BzZn0Oa_AXYFbsCXX3SXqeZCRNVGPQRrkVH5VGPiOBe04A@mail.gmail.com>
 <CA+khW7g3SP5+0TYr-jtZ6Ookq9wwBWtR-bJhzPhDopxwkCbB2w@mail.gmail.com>
In-Reply-To: <CA+khW7g3SP5+0TYr-jtZ6Ookq9wwBWtR-bJhzPhDopxwkCbB2w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Nov 2021 14:05:01 -0800
Message-ID: <CAADnVQJv_MUnrHdCLK2fh4rWtzPJajF4rho7KAnWccaNfVBpqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/3] bpf: Prevent writing read-only memory
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 11:55 AM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Nov 9, 2021 at 8:43 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 8, 2021 at 4:31 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > There are currently two ways to modify a kernel memory in bpf programs:
> > >  1. declare a ksym of scalar type and directly modify its memory.
> > >  2. Pass a RDONLY_BUF into a helper function which will override
> > >  its arguments. For example, bpf_d_path, bpf_snprintf.
> > >
> > > This patchset fixes these two problem. For the first, we introduce a
> > > new reg type PTR_TO_RDONLY_MEM for the scalar typed ksym, which forbids
> > > writing. For the second, we introduce a new arg type ARG_CONST_PTR_TO_MEM
> > > to differentiate the arg types that only read the memory from those
> > > that may write the memory. The previous ARG_PTR_TO_MEM is now only
> > > compatible with writable memories. If a helper doesn't write into its
> > > argument, it can use ARG_CONST_PTR_TO_MEM, which is also compatible
> > > with read-only memories.
> > >
> > > In v2, Andrii suggested using the name "ARG_PTR_TO_RDONLY_MEM", but I
> > > find it is sort of misleading. Because the new arg_type is compatible
> > > with both write and read-only memory. So I chose ARG_CONST_PTR_TO_MEM
> > > instead.
> >
> > I find ARG_CONST_PTR_TO_MEM misleading. It's the difference between
> > `char * const` (const pointer to mutable memory) vs `const char *`
> > (pointer to an immutable memory). We need the latter semantics, and
> > that *is* PTR_TO_RDONLY_MEM in BPF verifier terms.
> >
>
> Ah, I am aware of the semantic difference between 'char * const' and
> 'const char *', but your explanation in the bracket helps me see your
> point better. It does seem PTR_TO_RDONLY_MEM matches the semantics
> now. Let me fix and send an update.

I thought earlier we agreed that flag approach is prefered.
Looks like OR_NULL discussion is progressing nicely and
IS_RDONLY or IS_RDWR flags will just fit right in.
What's the reason to go with this approach ?
It seems it will make the refactoring more tedious later.
