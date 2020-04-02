Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7419BB43
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 07:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDBFPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 01:15:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34755 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDBFPs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 01:15:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so1886598ljn.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 22:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTcfNjfm8P0FeG73gcZ7QZwnftr+Yyhb7/bVlFym4kg=;
        b=WJQ79SK4PKi3c41B0W9geo+0JZD2hAhagzdsZiZ3+RbPMvuNLTOhV560LTIZ1MOtRH
         mpGj5MOC+I8mhUXCsO8Me4pB3bForA0zhD61yeQNgVnjKQ9QYA9Hz4e6U+WXNK5M5Axp
         w8FbzqC2Tk79dXdqQjGaj8VT1y0cWI+MUoKsYIyvW5f/MQQUPLu3S5LiUD+Ok/Yd6Dzy
         zuiHsLQRmlsUUmpcx8YvUIIqStYS7ZXwNwQxMazTmfLzwe9RRtv0F10shtvVBb5AyZu2
         hWLFft1GGLA9UE/Ijrrt7kHYd19gHt9Lb8vKkiIjP4+qglpge4ZI4UjH0X7h0KO1RT3L
         m0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTcfNjfm8P0FeG73gcZ7QZwnftr+Yyhb7/bVlFym4kg=;
        b=TUg7sxKGSdPFyGqzoSRD846SlOWhOboMn17VUWKIcUzq0/Coz6guUPleriYVSRMzva
         +8DApYlp6kFCOkNENBFKIKLf1g47cvTCUpLYcvkLVIZ7zO+ECpfdcV7w1210OhZrWgzW
         V/oCP0+mXteyc5q35l0SLIwe2LDs4ye+iFs2pdpCzUyzgoomr5C1L3RpNEwooxEOrLiI
         T4iGxwweQYeLmtI82nVs3ADzO3LNERFRJapwvmRoytQH4n7HS3O1DUVipQ29S2pe+38D
         QmHUUjqjNJgPMRhdYzAehYyesPwG4/oyywdWIfHcNyowkQxGuf7yZa9E6cIZV9dK8IFG
         vlbA==
X-Gm-Message-State: AGi0PubZZ4N9QSdALIj6+f39q/o4xXfaMWL7v8ggYurtr1FgeOmqSlAc
        CA0yiCE0CECVFVAsiLKlx0+xSxDC+1SlLouAdNhbKQ==
X-Google-Smtp-Source: APiQypLxlkxRRi36bYoPjTO4+awlecpEx6QD3ZY5NeEDcFlLuKDjbNcX5c+fbVR9DooDitVX2EhX2uZGM+AwltWnZ64=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr826354ljg.215.1585804544388;
 Wed, 01 Apr 2020 22:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200329004356.27286-1-kpsingh@chromium.org> <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com> <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
In-Reply-To: <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 07:15:18 +0200
Message-ID: <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 2, 2020 at 6:30 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Apr 02, 2020 at 06:03:57AM +0200, KP Singh wrote:
> > On 01-Apr 17:09, Alexei Starovoitov wrote:
> > > On Sat, Mar 28, 2020 at 5:44 PM KP Singh <kpsingh@chromium.org> wrote:
> > > > +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> > > > +            unsigned long reqprot, unsigned long prot, int ret)
> > > > +{
> > > > +       if (ret != 0)
> > > > +               return ret;
> > > > +
> > > > +       __u32 pid = bpf_get_current_pid_tgid() >> 32;
> > > > +       int is_heap = 0;
> > > > +
> > > > +       is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > > > +                  vma->vm_end <= vma->vm_mm->brk);
> > >
> > > This test fails for me.
> >
> > Trying this from bpf/master:
> >
> >   b9258a2cece4 ("slcan: Don't transmit uninitialized stack data in padding")
> >
> > also from bpf-next/master:
> >
> >  1a323ea5356e ("x86: get rid of 'errret' argument to __get_user_xyz() macross")
> >
> > and I am unable to reproduce the failure (the output when using bpf/master):
> ..
> >
> > Also, I am wondering if this happens just in the BPF program or also
> > in the kernel as the other variable I can think of is the compiled
> > bpf program itself which might be reading a different value thinking
> > it's vm->vma_start, possible something to do with BTF / CO RE due to a
> > compiler bug:
>
> I don't think it's anything to do with clang/btf or core.
> I think that condition is simply incorrect.
> I've added:
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 311c0dadf71c..16ae0ada34ba 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -577,6 +577,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>                         goto out;
>                 }
>
> +               printk("start %llx %llx\n", vma->vm_start, vma->vm_mm->start_brk);
>                 error = security_file_mprotect(vma, reqprot, prot);
>
> and see exactly the same values as bpf side (at least it was nice to see
> that all CO-RE logic is working as expected :))
>
> [   24.787442] start 523000 39b9000
>
> I think it has something to do with the way test_progs is linked.
> But the problem is in condition itself.
> I suspect you copy-pasted it from selinux_file_mprotect() ?
> I think it's incorrect there as well.
> Did we just discover a way to side step selinux protection?
> Try objdump -h test_progs|grep bss
> the number I see in vma->vm_start is the beginning of .bss rounded to page boundary.
> I wonder where your 55dc6e8df000 is coming from.

I suspect that you're using different versions of libc, or something's
different in the memory layout, or something like that. The brk region
is used for memory allocations using brk(), but memory allocations
using mmap() land outside it. At least some versions of libc try to
allocate memory for malloc() with brk(), then fall back to mmap() if
that fails because there's something else behind the current end of
the brk region; but I think there might also be versions of libc that
directly use mmap() and don't even try to use brk().

So yeah, security checks based on the brk region aren't exactly
useful; but e.g. in SELinux, both cases have appropriate checks. The
brk region gets SECCLASS_PROCESS:PROCESS__EXECHEAP, anonymous mmap
allocations get SECCLASS_PROCESS:PROCESS__EXECMEM in
file_map_prot_check() instead. (This makes *some* amount of sense -
although not a lot - because for the brk region you know that it comes
from something like malloc(), while an anonymous mmap() allocation
might reasonably be used for JIT executable memory.)

In other words, you may want to pick something different as test case,
since the behavior here depends on libc.
