Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E334C44222F
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhKAVCe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhKAVCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:02:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305DC061766
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 13:59:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s3so14456948ybs.9
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFSYdeyjLVGmHZ5jPLlYT8j3P5mh0wjkLXIvi1CRRDk=;
        b=GNBiiz/gsfqLzfQACW9bkr+JW9M+7yrKZGODWLCvMiK/EzEz4eNeoGQ8AFCK9Vb6Dg
         m+Lemb7wUZOcBRe/KEn+k3P8RVudd2lw6E9M/mthcyNM2edIhQFyIaVSXmmPxTfGfFNk
         zJYVJmGXEXUPs1BHrOYzJO0DqHVQHebrApPja6e9qptshwq3sFt+suc+q75uusObn9zc
         vbQBDRgAgLL8OOPkmTfSn9HOc9aoZOvP47yrjQVyzQb0tOhGRiVwBz3jG6TBJ+g1h8Mc
         TDLs1vvlZLCQ3mM/4Q11Zio8kV+543rvkB0rL+uvZ8FA7PoLNTSsVrUEeNZg4Ul5vhu6
         igLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFSYdeyjLVGmHZ5jPLlYT8j3P5mh0wjkLXIvi1CRRDk=;
        b=n7XRar2mDGS29Nm/B1/O9LMVOE9G5GpTnY0WDKwE7wyyI9SD9GGlLvc9HXEJHs/u2Y
         PMwCEXuWWCnT6sSf6+eZDSzOB4qvZNt5Kc17XNPvqyl/137gzvPaj337IBL0MXBqfNy6
         9Ut8A70SsOTb/4ks71PszMxTc+j7VJyyXCPbe9iAbKoy5SoacntpNupclnW8UBiZtyaZ
         p9cJYdhpvnSvVwD39pTRe2RPEC9if8292aJf6vkYCSvnPtXgVAMzhRl06nN0SCtYMPfW
         Me5JwRLPqVPJwHkIjFS9Nk2uEzu5qmWM3pfcUplkFtqMy6HVfnEe1M2IpvI1gSGAm3dX
         PcTw==
X-Gm-Message-State: AOAM532qLrEYkL6npy1IXgQI0P+6JoFylAmH5IQRnwz8d/SGJuffDaLT
        avNSy362YC4vs88G+Fv7aSJZn6UYKWDLpJUHTxc=
X-Google-Smtp-Source: ABdhPJxmfQBOl3wrbjfmConaHufOihr112paaeWpv7gHyky+65v8vqdzTKYhjnXD70jVtbcnWJl+hf7yoV73a9zlGsc=
X-Received: by 2002:a25:d16:: with SMTP id 22mr26949311ybn.51.1635800389829;
 Mon, 01 Nov 2021 13:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211030045941.3514948-1-andrii@kernel.org> <20211030045941.3514948-3-andrii@kernel.org>
 <20211101162234.fhtnmrdj5gil3qfo@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211101162234.fhtnmrdj5gil3qfo@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Nov 2021 13:59:38 -0700
Message-ID: <CAEf4BzYE=4Wv9-9Ccpcs-T_0+s4_fB49Usop__uZw-3rxT0iQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into
 public API
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 9:22 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 29, 2021 at 09:59:29PM -0700, Andrii Nakryiko wrote:
> > Move internal sys_bpf() helper into bpf.h and expose as public API.
> > __NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
> > follow libbpf naming conventions. Adapt internal uses accordingly.
> ...
> > -static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
> > -                       unsigned int size)
> > -{
> > -     return syscall(__NR_bpf, cmd, attr, size);
> > -}
> > -
> ...
> > +static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
> > +{
> > +     return syscall(__NR_bpf, cmd, attr, size);
> > +}
>
> I think it will conflict with glibc.
> It will also conflict with systemd that uses bpf() from glibc or does:
>
> #if !HAVE_BPF
> static inline int missing_bpf(int cmd, union bpf_attr *attr, size_t size) {
> #ifdef __NR_bpf
>         return (int) syscall(__NR_bpf, cmd, attr, size);
> #else
>         errno = ENOSYS;
>         return -1;
> #endif
> }
>
> #  define bpf missing_bpf
>
> why take a risk of renaming?

I actually didn't realize that glibc does provide this wrapper. I'll
just drop this patch for now, it's not really required for any other
changes in the patch set.
