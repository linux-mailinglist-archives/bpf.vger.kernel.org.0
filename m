Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6EA308304
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhA2BJl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhA2BJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:09:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5FEC061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:08:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b8so4332964plh.12
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yn1pH1L4spfAf74bS5UHVZFwcIxb5sNKZjNzU/4dWR4=;
        b=ZUfnK1XW8uojto7T7rVsNbGRXK49kifl0tcuh4DOa9AgULOgR5qYWevZM9t7wzdmZK
         n/U4/e9Tac/YKK/FtQGXPKvz7ZjIasTFwvxsKhN0VoBrvKv3AR6/ao32/yYnoTkmAPFy
         UA15Dv8XxWHq7S12nk3sNEoZsFAkYZ0zxuHIgjcHVZmQhyDiSF4669cgSvfxWePhnVGX
         XPf0HbhQyRDy+kP1u7zXoS/6svRuVM3eZqm+oSRzVsz20hnYmWJlirL9uWeBrBghvbje
         AW+X4LhyRbLWH6xTibiRI5LnFjOuypOerboDQyUOKag08YbkITOTrKhdf6tQ7XYcoPYw
         Fx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn1pH1L4spfAf74bS5UHVZFwcIxb5sNKZjNzU/4dWR4=;
        b=g6eiumrtV3CHhFTAb2/0nefUFmCKGgtOU6AfXsZoge1c/uwCiz6HyvWuEqc7g9WWwj
         twGK1/QjR8Ke9n22EXIViIS2OloNUwN3M5r4vWmeIdC36MUAL7WG1lmh3Q+06/RhyKv+
         6irg0u0EYNDkTth73DtH4mstBCbS9ICW/R+Q6qMbwCjG9R9iUQ+ZPnhRJmAuc5U/EP2R
         oK7WXElFBEAzeH79MiX0TM7DldWz1N3NSkgNI0IEKUfviLvs5LAiE4D9LJJMUJG3pWS9
         TdeJ0zTGcFNN5AFFBDj0+BzRjAsYQdUBmR/TBMmsEbl9nr+xwJ2SP7wVew5bq9nWh9yj
         295Q==
X-Gm-Message-State: AOAM530dYYVoi+diEuJ2NyxLwIV5vVSVVdpOgkhHcFWUBLhRjDLKYlT/
        OqA5p63TXY5+m3VXz1WUdoDyixIR/Kk=
X-Google-Smtp-Source: ABdhPJyJSZhhI0iEAFbQFwI0w7kTQdODlfJh1JOfZcUSo3GTv7WR1HyJ5AhK3UnUFix1xP3JXisStg==
X-Received: by 2002:a17:902:bc4a:b029:e0:17b:b928 with SMTP id t10-20020a170902bc4ab02900e0017bb928mr1882819plz.62.1611882507535;
        Thu, 28 Jan 2021 17:08:27 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ed])
        by smtp.gmail.com with ESMTPSA id ga4sm6243521pjb.53.2021.01.28.17.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:08:26 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:08:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <20210129010824.6u73hbwfj7kaw6zy@ast-mbp.dhcp.thefacebook.com>
References: <20210126001219.845816-1-yhs@fb.com>
 <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com>
 <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CAG48ez0s78q+ujyXb2M9W+EHz7XHZwHJzJzm=Sz8=4XYwgEYUQ@mail.gmail.com>
 <20210129004305.cwtt3f4c3kq5qyth@ast-mbp.dhcp.thefacebook.com>
 <CAG48ez1zheHXaP47-grB_4VOk0cios0cege=vXhsZd0rMcz5bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1zheHXaP47-grB_4VOk0cios0cege=vXhsZd0rMcz5bw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 02:03:02AM +0100, Jann Horn wrote:
> On Fri, Jan 29, 2021 at 1:43 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, Jan 29, 2021 at 01:35:16AM +0100, Jann Horn wrote:
> > > On Fri, Jan 29, 2021 at 1:11 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > > > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > > > that means you have to inline a valid implementation.  In particular,
> > > > > you need to check that you're accessing *kernel* memory.  Just like
> > > >
> > > > That check is on the verifier side. It only does it for kernel
> > > > pointers with known types.
> > > > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > > > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > > > points to valid kernel field which is also a pointer.
> > > > What it doesn't check that b != null, so
> > > > that users don't have to write silly code with 'if (p)' after every
> > > > dereference.
> > >
> > > How is that supposed to work? If I e.g. have a pointer to a
> > > task_struct, and I do something like:
> > >
> > > task->mm->mmap->vm_file->f_inode
> > >
> > > and another thread concurrently mutates the VMA tree and frees the VMA
> > > that we're traversing here, how can BPF guarantee that
> > > task->mm->mmap->vm_file is a valid pointer and not whatever garbage we
> > > read from freed memory?
> >
> > Please read upthread. Every -> is replaced with probe_kernel_read.
> > That's what was kprobes were doing for years. That's what bpf was
> > doing for years.
> 
> Uh... but -> on PTR_TO_BTF_ID pointers is not replaced with
> probe_kernel_read() and can be done directly with BPF_LDX, right?

Almost. They're replaced with BPF_LDX | BPF_PROBE_MEM.
The interpreter is calling bpf_probe_read_kernel() to process them.
JIT is replacing these insns with atomic loads and extable.

> And
> dereferencing a PTR_TO_BTF_ID pointer returns another PTR_TO_BTF_ID
> pointer if type information is available, right? (See
> btf_struct_access().) And stuff like BPF LSM programs or some of the
> XDP stuff receives BTF-typed pointers to kernel data structures as
> arguments, right?
> 
> And as an example, this is visible in
> tools/testing/selftests/bpf/progs/ima.c , which does:
> 
> SEC("lsm.s/bprm_committed_creds")
> int BPF_PROG(ima, struct linux_binprm *bprm)
> {
>   u32 pid = bpf_get_current_pid_tgid() >> 32;
> 
>   if (pid == monitored_pid)
>     ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
>            &ima_hash, sizeof(ima_hash));
> 
>   return 0;
> }
> 
> As far as I can tell, we are getting a BTF-typed pointer "bprm", doing
> dereferences that again yield BTF-typed pointers, and then pass the
> BTF-typed pointer at the end of it into bpf_ima_inode_hash()?

correct. all of them bpf_probe_read_kernel() == copy_from_kernel_nofault().
