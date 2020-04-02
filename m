Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9699019C473
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgDBOjL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 10:39:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41267 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbgDBOjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 10:39:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id z23so2922523lfh.8
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWhv97rUkQ55GmpwguZZwsTI0ItFj9NJgEzeV7LWnGI=;
        b=J9/iYRl4yr/VeWgdT9NFvLQFjlwy5H9vpo6LQ2yn7l9woZDLdH0VYw/hVM/4ANrn0F
         kJlOo2C0eE1S/9MDJ/4OX9d74rOy3Xn7kpCNfTVBDnCtg+5C/cILyA99qv5Yk6E3e5go
         h598w3yPPMo8N05VZsydb7aGq/THBedVIruVgYI6Ltnu3sodFXYrajv+fqUOWNr6s+Kk
         HHFrMavEIF5CjAjskyfNTyam/7cYIIGL4AW7nHPfFKtKDrXeC9a1Czjn1Ht345tJ399o
         UhsbKsY6V55vw0FXGxqGLfxc3MMmWNsXOl71Gx0afAhOqOOYaa87lDfgnsfRwScTP3J6
         9ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWhv97rUkQ55GmpwguZZwsTI0ItFj9NJgEzeV7LWnGI=;
        b=XBc0kGHgROVOrkwxFagUx1ReoBlPl2viWg1hiuNxm9lX+5fOAalveZ5eJFxfQR2heR
         1idLPDDI4azqU+4BLDpENjDHJq3Eyh/6Bo3nD8pIil+mShmOLobtjheOVY69gOnI8R/J
         cPLDEHHrFGNt3GSee8E+Q4151bAKlasw4CQevAtQMKXHIfCcrVdxw7nluhRv50Q2DAr2
         Uf3WiPg3StB2SiJ0fNVzEI1/CaPQcmyMk8hGNdSqkOQ1Yn3eEq71YjzuC7nHBW5Cgi9h
         cVWRH0CtsFHET6BoUOUv/P9rUcu0CgeGRcnUMNE6RweKOyvI/beByTUNJaYvCvfYj+Ok
         dEDQ==
X-Gm-Message-State: AGi0Pua1yqWvfGUjv2Sg9WK/vmxjn80o9na+Z/FudMTGgEPKmRMSSvPN
        qWN0bk9NIU/rFTzvE2yKJFu/qC1D27n59SqkhySkRw==
X-Google-Smtp-Source: APiQypKvCB2g4vVvIsuKTkjOiQsdbBiCN3hvgOmqDS9wl2fjZsNKW/7GM9acoWuCI7FCCNZ2qr/Q1Vaonslz9+/Ckzc=
X-Received: by 2002:a19:700a:: with SMTP id h10mr2478353lfc.184.1585838348128;
 Thu, 02 Apr 2020 07:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200329004356.27286-1-kpsingh@chromium.org> <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com> <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
 <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com> <20200402115306.GA100892@google.com>
In-Reply-To: <20200402115306.GA100892@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 16:38:41 +0200
Message-ID: <CAG48ez3Nv0wA=7FOrHFJwy+uFfBQLP5-Y8h4wFnkKCp7HB9m2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
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

On Thu, Apr 2, 2020 at 1:53 PM KP Singh <kpsingh@chromium.org> wrote:
> On 02-Apr 07:15, Jann Horn wrote:
[...]
> > I suspect that you're using different versions of libc, or something's
> > different in the memory layout, or something like that. The brk region
> > is used for memory allocations using brk(), but memory allocations
> > using mmap() land outside it. At least some versions of libc try to
> > allocate memory for malloc() with brk(), then fall back to mmap() if
> > that fails because there's something else behind the current end of
> > the brk region; but I think there might also be versions of libc that
> > directly use mmap() and don't even try to use brk().
>
> Yeah missed this that heap can also be allocated using mmap:
[...]
> I updated my test case to check for mmaps on the stack instead:
[...]
> +       is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
> +                   vma->vm_end >= vma->vm_mm->start_stack);
>
> -       if (is_heap && monitored_pid == pid) {
> +       if (is_stack && monitored_pid == pid) {
>                 mprotect_count++;
>                 ret = -EPERM;
>         }
>
> and the the logic seems to work for me. Do you think we could use
> this instead?

Yeah, I think that should work. (Just keep in mind that a successful
mprotect() operation will split the VMA into three VMAs - but that
shouldn't be a problem here, since you only do it once per process,
and since you're denying the operation, it won't go through anyway.)
