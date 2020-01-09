Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64C135FEE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 18:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgAIR7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 12:59:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36254 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgAIR7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 12:59:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so6843009qkc.3;
        Thu, 09 Jan 2020 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PkSoGPOiy4o4DnP2NNYtjoXFAX8iabjQVoKoqIqz5c=;
        b=rqb+UPXBmbt9LxqHLWb2wQkjHE/m7Zrgy3kUrI+o7jFU+3/M3dfv69Wzsn4wrpWbYy
         zUHOy33yGGfU4PoO72twqpbkFq0KLL4V7csznzM287joigW0bMkLi/aqxGH9yaCKvf/w
         upqYKRrZSPc6e3khXFG+KxdZHeQ5gfJEmKxQJ4WaF/1hWuZgICoVSZb8aazY6XvLPsPj
         Ddf0NIvw/o5BsSfIq+PRt0D/R+bTzwWR+3qbIcpRZfnrnj4Nb7tnoZ2LILoyKq0eTYBb
         ryN78osR5tE0T0Veu21LPfmqW4WPVaHWB1sWGdfwrgBdeQ5izrHS31ZUitUE2RijpKrC
         J/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PkSoGPOiy4o4DnP2NNYtjoXFAX8iabjQVoKoqIqz5c=;
        b=Rbrj0jn1pXT/xqwoyqKaPaYK9sQ8caaC7aijtdYpCC9UiU502+6embF5889syEWc2s
         cnZT/gBFfmPxidQwwfyf0FiPA8MKhqgyUDcMp/OORw2YEWp3BwWT9WcdSXHZOVuTOBTt
         St1LTGv1Y8jh59B3cEtnezTMeZA6Vz5GpVWMWVxdsypM6wcIY86jatXyVYStpVffmImd
         w+KA+PdpazdHLxprRcnVmEhvopdvw64hQ6uLlOfWRSdm3tQeLsqnGXUc/8ZQn8oo49V9
         4eAS830B9ZZXjT9TnF5MGtYZVciIJDNxbLtP6cuOQ6GK8lAPHWg2yZynvsDh1K2sHnR6
         T2jg==
X-Gm-Message-State: APjAAAVTZ2MctjBDGQ59VSGwZoNrvCR3MiEUwHt7kcd9R/R7u/SDbASp
        gnvXdeqHFk33opqaQLWUTebYMmQaujhL/qUycDE=
X-Google-Smtp-Source: APXvYqwRSsDCOH2S2S4sv60fEnTRBs947fHi9e247NVahrgq8MxV2kgGpalTMfJ5tYF7+Kk+WnPM2QEv6CIOPhJJzh8=
X-Received: by 2002:ae9:e809:: with SMTP id a9mr10590771qkg.92.1578592787759;
 Thu, 09 Jan 2020 09:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-13-kpsingh@chromium.org>
 <CAEf4BzY4K-vgSFPjV=pn3quc5DT1+eGkJnZfSw4+b0fERzPVfw@mail.gmail.com> <20200104000955.GB23487@chromium.org>
In-Reply-To: <20200104000955.GB23487@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Jan 2020 09:59:35 -0800
Message-ID: <CAEf4Bzam_k99z-bh_kH=M9HUS3+nh_eSGJLffPO4y=_9psH9GA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/13] bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 3, 2020 at 4:09 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-Dez 22:49, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > * Load a BPF program that audits mprotect calls
> > > * Attach the program to the "file_mprotect" LSM hook
> > > * Verify if the program is actually loading by reading
> > >   securityfs
> > > * Initialize the perf events buffer and poll for audit events
> > > * Do an mprotect on some memory allocated on the heap
> > > * Verify if the audit event was received
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  MAINTAINERS                                   |   2 +
> > >  .../bpf/prog_tests/lsm_mprotect_audit.c       | 129 ++++++++++++++++++
> > >  .../selftests/bpf/progs/lsm_mprotect_audit.c  |  58 ++++++++
> > >  3 files changed, 189 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_mprotect_audit.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/lsm_mprotect_audit.c
> > >
> >
> > [...]
> >
> > > +/*
> > > + * Define some of the structs used in the BPF program.
> > > + * Only the field names and their sizes need to be the
> > > + * same as the kernel type, the order is irrelevant.
> > > + */
> > > +struct mm_struct {
> > > +       unsigned long start_brk, brk, start_stack;
> > > +};
> > > +
> > > +struct vm_area_struct {
> > > +       unsigned long start_brk, brk, start_stack;
> > > +       unsigned long vm_start, vm_end;
> > > +       struct mm_struct *vm_mm;
> > > +       unsigned long vm_flags;
> > > +};
> > > +
> > > +BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> > > +           struct vm_area_struct *, vma,
> > > +           unsigned long, reqprot, unsigned long, prot)
> > > +{
> > > +       struct mprotect_audit_log audit_log = {};
> > > +       int is_heap = 0;
> > > +
> > > +       __builtin_preserve_access_index(({
> >
> > you don't need __builtin_preserve_access_index, if you mark
> > vm_area_struct and mm_struct with
> > __attribute__((preserve_access_index)
>
> Cool, updated!
>
> >
> > > +               is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > > +                                    vma->vm_end <= vma->vm_mm->brk);
> > > +       }));
> > > +
> > > +       audit_log.magic = MPROTECT_AUDIT_MAGIC;
> > > +       audit_log.is_heap = is_heap;
> > > +       bpf_lsm_event_output(&perf_buf_map, BPF_F_CURRENT_CPU, &audit_log,
> > > +                            sizeof(audit_log));
> >
> > You test would be much simpler if you use global variables to pass
> > data back to userspace, instead of using perf buffer.
> >
> > Also please see fentry_fexit.c test for example of using BPF skeleton
> > to shorten and simpify userspace part of test.
>
> Thanks for the skeleton work!
>
> This makes using global variables easier and the tests are indeed much
> simpler, I have updated it for the next revision.
>
> One follow up question regarding global variables, let's say I have
> the following global variable defined in the BPF program:
>
> struct result_info {
>         __u32 count;
> };
>
> struct result_info result = {
>         .count = 0,
> };
>
> The defintion of result_info needs to be included before the .skel.h
> as it's not automatically generated or maybe I am missing a
> trick here?
>
> For now, I have defined this in a header which gets included both in
> the program and the test.

Yes, ideally all common types should be shared in a common header. My
initial implementation actually supported dumping out all the types in
a generated skeleton, but that was inconvenient in a lot of cases, so
I dropped that.

>
> - KP
>
> >
> > > +       return 0;
> > > +}
> > > --
> > > 2.20.1
> > >
