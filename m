Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE9019C477
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 16:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgDBOkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 10:40:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38263 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388381AbgDBOkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 10:40:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id f6so3940770wmj.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nS8cpTbz4I96U/y1CPG/FhYzV6gTNrPxZl1fEIeuLE=;
        b=YcrINvY90D1vESWzzdCbRUyKK8HTqhOTOnPAhbt35KTAq0+/pcee8RAkV1Mtiy5Nq/
         d8izm6/sFrJPqGCM7IXrp/OPMRILzf+wbF5iJ6lAL7VVEWatMKyMav3vdTSFmqYezWmv
         qPYP9GNjAbng4eDAGEyAiPFbq9h3gXVLKLSaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nS8cpTbz4I96U/y1CPG/FhYzV6gTNrPxZl1fEIeuLE=;
        b=pBF24baiA/0c9fYl9m3ZGkCsn58nJGijCIBFv3is+MzzdqwmY5d9X8oL0xP06YLqEJ
         TIV4jEBSlKITkvCrLH9FBxniksWf3C36MtOA+Lukne1FSSowCilqknDL6wBL0wp6+gD7
         Jnp2kW5b0r/+F9wXZjLT1KRzdXMa4yolqt7JLJq27yzSpBW+id42wiEJVl58e0ihrHTe
         eXMwrInKI4pBT/vq7KEUnO/kgJOBAAjg2GI/N9MLeZjW+L8mf2UGhLn64tm+fQSp6m/5
         L0E9vkK0A/kvMU2+42mIJTUJ2QfQOTjPKdkp5g6BfcWkyBex5tjO+VV36Gqbcl4L+R9O
         S7fQ==
X-Gm-Message-State: AGi0PubFa+2WYe1REg1iQFvEoYZvL6gH9mak8ikcysMeHOx+3IxpMqCW
        ZRq5iNlfI0a5pi/TdFWXB6t1PkhGF15i52DKYcgLRQ==
X-Google-Smtp-Source: APiQypJZdoWG+P39Rq38w9urBK/FPQrtlyXJw566k1YbKozB/x64n/HiVRdJ+gw7T4c5ZF3x9YXUf75aJqE4PeDmOx4=
X-Received: by 2002:a1c:9886:: with SMTP id a128mr3680537wme.75.1585838418984;
 Thu, 02 Apr 2020 07:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200329004356.27286-1-kpsingh@chromium.org> <20200329004356.27286-8-kpsingh@chromium.org>
 <CAADnVQKP3mOTUkkzjWM6Qii+v-dCDwV9Ms_-4ptsbdwyDW1MCA@mail.gmail.com>
 <20200402040357.GA217889@google.com> <20200402043037.ltgyptxsf7jaaudu@ast-mbp>
 <CAG48ez3SdOVbzJQgo-p=rhKhPdJxjUdraEE6WK5GP3GdenWAAQ@mail.gmail.com>
 <20200402115306.GA100892@google.com> <CAG48ez3Nv0wA=7FOrHFJwy+uFfBQLP5-Y8h4wFnkKCp7HB9m2g@mail.gmail.com>
In-Reply-To: <CAG48ez3Nv0wA=7FOrHFJwy+uFfBQLP5-Y8h4wFnkKCp7HB9m2g@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 2 Apr 2020 16:40:08 +0200
Message-ID: <CACYkzJ6RbogQDATmK_F6qrOPvTWP-m3d31rs1=D3KSzWrbirmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 7/8] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     Jann Horn <jannh@google.com>
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

On Thu, Apr 2, 2020 at 4:39 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Apr 2, 2020 at 1:53 PM KP Singh <kpsingh@chromium.org> wrote:
> > On 02-Apr 07:15, Jann Horn wrote:
> [...]
> > > I suspect that you're using different versions of libc, or something's
> > > different in the memory layout, or something like that. The brk region
> > > is used for memory allocations using brk(), but memory allocations
> > > using mmap() land outside it. At least some versions of libc try to
> > > allocate memory for malloc() with brk(), then fall back to mmap() if
> > > that fails because there's something else behind the current end of
> > > the brk region; but I think there might also be versions of libc that
> > > directly use mmap() and don't even try to use brk().
> >
> > Yeah missed this that heap can also be allocated using mmap:
> [...]
> > I updated my test case to check for mmaps on the stack instead:
> [...]
> > +       is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
> > +                   vma->vm_end >= vma->vm_mm->start_stack);
> >
> > -       if (is_heap && monitored_pid == pid) {
> > +       if (is_stack && monitored_pid == pid) {
> >                 mprotect_count++;
> >                 ret = -EPERM;
> >         }
> >
> > and the the logic seems to work for me. Do you think we could use
> > this instead?
>
> Yeah, I think that should work. (Just keep in mind that a successful
> mprotect() operation will split the VMA into three VMAs - but that
> shouldn't be a problem here, since you only do it once per process,
> and since you're denying the operation, it won't go through anyway.)

Okay I will send a patch that fixes this test. Thanks everyone!

- KP
