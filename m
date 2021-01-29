Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054D03082E0
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 02:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhA2BFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 20:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhA2BEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 20:04:11 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA918C061573
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:03:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f19so8636866ljn.5
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ334V14gJBVPRQRux7USRa+GGWzhC/PqFRlnZdq4Hg=;
        b=gi9wFLd9NFdrHBfW3dciGsiIDexQQ1X4+VKF/KnTPZEh0pic2qKBo5fj0njKINNyKD
         HsyyGzlQpc11ogMf20HaL3Rab4hoTbGfM6JCCSJ8UfoGflY4Zc89uFs7YF5ot1Ljj1+i
         P8Nk7OWpimkPqhIfcx2+raXOAUx/KXrK5LIL25k+5TS9eXLWH+YBDfxEJ1bWvZ5T2Dn4
         C08dRqOhDlobpQPpLuJWFRV50lNPUbpFyJrEAdORvm1gkv+NcMdXE5YmYs3bxZaC97U2
         aQ2UwYmvIh0MsM+JM3LIZHUI6WUnSWvaSjS5uI9V9PAqTn/wOCI7QJlKX7Iw8bi2MtSt
         C9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ334V14gJBVPRQRux7USRa+GGWzhC/PqFRlnZdq4Hg=;
        b=EeIqSgrK06+cbQ+IqWBT0IyCZAW0ZHJIV0TkTpBB/B1RM8XffsoeyNVyuHtbXRnk5l
         YxFdp4I/Ta61cKRc4AQ1AEN3C57k/eGJIN8eYU5r8UcBe2b4Z96ZnvVhVSP0najM2KJZ
         VvXLQ61ne5TZXrOdZiXNjkX+gR/K2y1K5gFAD5DRP0EyWTUo6Q3l9/u2b3i5fWAg3ImV
         KI+27EDGxs0NwkZHIeOAz1e2RSTaXVLbVl+Ld/ftwq89vFbunQn9OyDzp5sy8Kjcpn7e
         A/Urq3U5oZC/80xakLrkPDuVHZzurdpxY6nqumxGEgPLEsJCzIgjZwYK1CQXpj4uYXhM
         DJ6w==
X-Gm-Message-State: AOAM532KM+rhxwylPPMREVdxQEwvXfSm7SxQ3OW8/heukXW9kCvRjCWf
        OJAACwuE2GMA3To3SXPvgqo9qxEn50it+t4/AVD4bA==
X-Google-Smtp-Source: ABdhPJwaj/ozZ9SCSkx6Ma6XKnjFR/1sTt06CJm8Z+dkWmF4LBzWUdTLbaQqD0mTQ/ubGcBgIEWSUEAIwAARSjPusu0=
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr1047900ljk.385.1611882209108;
 Thu, 28 Jan 2021 17:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20210126001219.845816-1-yhs@fb.com> <CALCETrX157htkCF81zb+5BBo9C_V39YNdt7yXRcFGGw_SRs02Q@mail.gmail.com>
 <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CAG48ez0s78q+ujyXb2M9W+EHz7XHZwHJzJzm=Sz8=4XYwgEYUQ@mail.gmail.com> <20210129004305.cwtt3f4c3kq5qyth@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129004305.cwtt3f4c3kq5qyth@ast-mbp.dhcp.thefacebook.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Jan 2021 02:03:02 +0100
Message-ID: <CAG48ez1zheHXaP47-grB_4VOk0cios0cege=vXhsZd0rMcz5bw@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 1:43 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Jan 29, 2021 at 01:35:16AM +0100, Jann Horn wrote:
> > On Fri, Jan 29, 2021 at 1:11 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Thu, Jan 28, 2021 at 03:51:13PM -0800, Andy Lutomirski wrote:
> > > > Okay, so I guess you're trying to inline probe_read_kernel().  But
> > > > that means you have to inline a valid implementation.  In particular,
> > > > you need to check that you're accessing *kernel* memory.  Just like
> > >
> > > That check is on the verifier side. It only does it for kernel
> > > pointers with known types.
> > > In a sequnce a->b->c the verifier guarantees that 'a' is valid
> > > kernel pointer and it's also !null. Then it guarantees that offsetof(b)
> > > points to valid kernel field which is also a pointer.
> > > What it doesn't check that b != null, so
> > > that users don't have to write silly code with 'if (p)' after every
> > > dereference.
> >
> > How is that supposed to work? If I e.g. have a pointer to a
> > task_struct, and I do something like:
> >
> > task->mm->mmap->vm_file->f_inode
> >
> > and another thread concurrently mutates the VMA tree and frees the VMA
> > that we're traversing here, how can BPF guarantee that
> > task->mm->mmap->vm_file is a valid pointer and not whatever garbage we
> > read from freed memory?
>
> Please read upthread. Every -> is replaced with probe_kernel_read.
> That's what was kprobes were doing for years. That's what bpf was
> doing for years.

Uh... but -> on PTR_TO_BTF_ID pointers is not replaced with
probe_kernel_read() and can be done directly with BPF_LDX, right? And
dereferencing a PTR_TO_BTF_ID pointer returns another PTR_TO_BTF_ID
pointer if type information is available, right? (See
btf_struct_access().) And stuff like BPF LSM programs or some of the
XDP stuff receives BTF-typed pointers to kernel data structures as
arguments, right?

And as an example, this is visible in
tools/testing/selftests/bpf/progs/ima.c , which does:

SEC("lsm.s/bprm_committed_creds")
int BPF_PROG(ima, struct linux_binprm *bprm)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;

  if (pid == monitored_pid)
    ima_hash_ret = bpf_ima_inode_hash(bprm->file->f_inode,
           &ima_hash, sizeof(ima_hash));

  return 0;
}

As far as I can tell, we are getting a BTF-typed pointer "bprm", doing
dereferences that again yield BTF-typed pointers, and then pass the
BTF-typed pointer at the end of it into bpf_ima_inode_hash()?

What am I missing?
