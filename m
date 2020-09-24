Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6727754F
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgIXP3I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgIXP3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 11:29:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8205C0613D3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 08:29:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so3772951eds.9
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWwrSFR+XsVbo72EXCPGN7Yvsrb6I0oZs+oVxjkh+2I=;
        b=hN3JCT4/0mr9lHn1el6A+W9IHJhVcZfLNiBn+2+2ptYhZ2E3ln93PIdOTyrZm4MsWg
         0pPA5aEFZnOI3KgY8otAO4fYpSdYshKnZ4CmKXSbw5JqMttXF9UPXapl5M86DohboovX
         I3ro4WAml5gPUcfGG3zbCTYxhnoAJoBotyNRCrSyqpZDz/gaQeuJnjABGulXeW+vgul2
         WfLGjGxh/urIx8OZzhTSMu8/a21/AzyXO11afB8SfNqZpdfRIv+08n215LLwBniNZZEh
         jK3alXiJ//9LzmOTJndQYIOo7J2mNf+tk68S7tAY55J1Ph4eY4IoKrvEDEnzodg3nw3v
         1Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWwrSFR+XsVbo72EXCPGN7Yvsrb6I0oZs+oVxjkh+2I=;
        b=OGAOVLlENNvnnVbrQ6C3vNJ3thwAeGN/ksrEMF+sK41Mh25VYSh+vOd9XWRzSfvHkk
         NtvKl8J4c3X0GEIjf0Btc4Vlfkd0jUHpBpLwqv+ez0B/Jzj4B47qUtGmZhG76LJ0D4ZL
         5tkMHAjkA+gkt23gn/Mc/T9PiiAxxgtaHYfOJ3KBQOmWYOUHfj1otAnY01QupQ7wxQLi
         j/lWPP1xPRs5C48BvGXE0RPIOuoQxRjWBKifl+kHGqglhtw/FnQili6TC7YpZbxqiL6l
         1hKfjgWo3P0IX4E3oIcrRVX/5GS/FgSu1OJ+t0V3vh6rH2WQb6xRSPfMne9U7ShK2Zgk
         m85Q==
X-Gm-Message-State: AOAM5328hOsNRK2LQBaUCTVGMR5MXFu7jpxKYDjzz2QPePDa6NpRg4oU
        mzslwV2FJt7ZsPtPIx+aZ6RcW0V8KE9NMjl9LZ3J
X-Google-Smtp-Source: ABdhPJxwnRvlu4GIjD+pyeEz7LhCUZQ/skYgUffP4gTtRClyXesIuk5Q/rFSvs+tgZ6Sn7QvuUd3X5CwxfSMAX6NAl0=
X-Received: by 2002:aa7:ce97:: with SMTP id y23mr494977edv.128.1600961346147;
 Thu, 24 Sep 2020 08:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-5-keescook@chromium.org> <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
 <202009240038.864365E@keescook>
In-Reply-To: <202009240038.864365E@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Sep 2020 11:28:55 -0400
Message-ID: <CAHC9VhQpto1KuL7PhjtdjtAjJ2nC+rZNSM7+nSZ_ksqGXbhY+Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] seccomp: Emulate basic filters for constant action results
To:     Kees Cook <keescook@chromium.org>,
        Tom Hromatka <tom.hromatka@oracle.com>
Cc:     Jann Horn <jannh@google.com>, YiFei Zhu <yifeifz2@illinois.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 3:46 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 24, 2020 at 01:47:47AM +0200, Jann Horn wrote:
> > On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > > This emulates absolutely the most basic seccomp filters to figure out
> > > if they will always give the same results for a given arch/nr combo.
> > >
> > > Nearly all seccomp filters are built from the following ops:
> > >
> > > BPF_LD  | BPF_W    | BPF_ABS
> > > BPF_JMP | BPF_JEQ  | BPF_K
> > > BPF_JMP | BPF_JGE  | BPF_K
> > > BPF_JMP | BPF_JGT  | BPF_K
> > > BPF_JMP | BPF_JSET | BPF_K
> > > BPF_JMP | BPF_JA
> > > BPF_RET | BPF_K
> > >
> > > These are now emulated to check for accesses beyond seccomp_data::arch
> > > or unknown instructions.
> > >
> > > Not yet implemented are:
> > >
> > > BPF_ALU | BPF_AND (generated by libseccomp and Chrome)
> >
> > BPF_AND is normally only used on syscall arguments, not on the syscall
> > number or the architecture, right? And when a syscall argument is
> > loaded, we abort execution anyway. So I think there is no need to
> > implement those?
>
> Is that right? I can't actually tell what libseccomp is doing with
> ALU|AND. It looks like it's using it for building jump lists?

There is an ALU|AND op in the jump resolution code, but that is really
just if libseccomp needs to fixup the accumulator because a code block
is expecting a masked value (right now that would only be a syscall
argument, not the syscall number itself).

> Paul, Tom, under what cases does libseccomp emit ALU|AND into filters?

Presently the only place where libseccomp uses ALU|AND is when the
masked equality comparison is used for comparing syscall arguments
(SCMP_CMP_MASKED_EQ).  I can't honestly say I have any good
information about how often that is used by libseccomp callers, but if
I do a quick search on GitHub for "SCMP_CMP_MASKED_EQ" I see 2k worth
of code hits; take that for whatever it is worth.  Tom may have some
more/better information.

Of course no promises on future use :)  As one quick example, I keep
thinking about adding the instruction pointer to the list of things
that can be compared as part of a libseccomp rule, and if we do that I
would expect that we would want to also allow a masked comparison (and
utilize another ALU|AND bpf op there).  However, I'm not sure how
useful that would be in practice.

-- 
paul moore
www.paul-moore.com
