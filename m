Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97994ACA0F
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 21:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiBGUJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 15:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiBGUIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 15:08:39 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6EC0401DA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 12:08:39 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id m17so12058910ilj.12
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDedeMsdV9ZFHfYVa+OoEpxOnzvrU7cWSly4ZXcsTHM=;
        b=nEv4BTT61pdi+ZJsF4kA08sUGIrtSDT4K+MbBz8amgXB9+sXdwbJCulY0VxEuStJAD
         6GQv+Zjh/5Lvy4/EoxG+puZ3fCgQ1tdj5lmd6U4BqW16oYy6d+4MuF9LBg8lw48/D9oB
         MK1jwcOt7gzvhL/fQFv1NKSuBUaj63A4ML6jkb7ll9EwiHVPihMokonaTCuMIU1pHDAS
         /ZX9eKtNl2zk7LCLALesESa4nL6h/ACQZXfPEo5dMVOI1NkFjZrhuKIW2Q4UbRPBRfyr
         z+xeiL9/ic2s4sxIdO1kvIlopuSChK5hgEx29hB6aSw4MzhyqDMSqNiGa8VhGJlnPLRI
         JUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDedeMsdV9ZFHfYVa+OoEpxOnzvrU7cWSly4ZXcsTHM=;
        b=QemQ6fN8ycxHu+pRwvOH3BfqoSfNkY992fqrcWsjE8CAfQZoK5BUXNXnKnetjmbDW2
         6wtC6WhU7+KTvGYa78E1QsUFUyA5HR0oENY5GiWHcCoQ95sQ/P6bT1qQOwN2CcfQB+fB
         osbRrizhPJ6coyEnTXWFXD+eveirNK4wb1KWUYZ1nKCOA9o9a3O4S06kg+KQXPv70uXQ
         OsdRiYzv8bUsUcLn3D6cbx23MW1QnG6rheVFKnz/SHyJh17TNwZIP7GtVluzCROsTdzt
         opn8peveKkMWeZSbGVfGL1F28HXYYTWcQjSAQiSga1r9SB633XhdPrhL7zj3Uvg+zc3l
         EYBA==
X-Gm-Message-State: AOAM5338xJn7hNq7VpSglpPjE+oJY/1q+3bdzD2fJqCzZpaxJWzyNsXf
        qDrwCezw99wAUb6F2thirKkb7rW+gLQVhDqZVig=
X-Google-Smtp-Source: ABdhPJwtSpJCUh5GFsHq5r5NZpvCXgnL6nZffnf4ecoydOlT3+9fLJRWFMhY9fX3oSI/DWmcSw6x2oId4SnB2m9mnaE=
X-Received: by 2002:a05:6e02:1bcd:: with SMTP id x13mr579596ilv.98.1644264518514;
 Mon, 07 Feb 2022 12:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20220206145350.2069779-1-iii@linux.ibm.com> <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
 <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
 <CAEf4BzZfn4-dbnRcsStu+EoKD12EoKCShcoAVH9Gj0mqieBAaw@mail.gmail.com> <e01e42fdb43deefacda093ba2e6add680179600f.camel@linux.ibm.com>
In-Reply-To: <e01e42fdb43deefacda093ba2e6add680179600f.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Feb 2022 12:08:27 -0800
Message-ID: <CAEf4BzaRMrM5KzJzm+Q8rDXEZTcehHNWct=afBkRDfL7N3CrnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 3:52 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Sun, 2022-02-06 at 22:23 -0800, Andrii Nakryiko wrote:
> > On Sun, Feb 6, 2022 at 11:57 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > On Sun, 2022-02-06 at 11:31 -0800, Andrii Nakryiko wrote:
> > > > On Sun, Feb 6, 2022 at 6:54 AM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >
> > > > > libbpf CI noticed that my recent changes broke
> > > > > bpf_perf_event_data
> > > > > ABI
> > > > > on s390 [1]. Testing shows that they introduced a similar
> > > > > breakage
> > > > > on
> > > > > arm64. The problem is that we are not allowed to extend
> > > > > user_pt_regs,
> > > > > since it's used by bpf_perf_event_data.
> > > > >
> > > > > This series fixes these problems by removing the new members
> > > > > and
> > > > > introducing user_pt_regs_v2 instead.
> > > > >
> > > > > [1] https://github.com/libbpf/libbpf/runs/5079938810
> > > > >
> > > > > Ilya Leoshkevich (2):
> > > > >   s390/bpf: Introduce user_pt_regs_v2
> > > > >   arm64/bpf: Introduce struct user_pt_regs_v2
> > > >
> > > > Given it is bpf_perf_event_data and thus bpf_user_pt_regs_t
> > > > definitions that are set in stone now, wouldn't it be better to
> > > > instead just change
> > > >
> > > > typedef user_pt_regs bpf_user_pt_regs_t; (s390x)
> > > > typedef struct user_pt_regs bpf_user_pt_regs_t; (arm64)
> > > >
> > > > to just define that fixed layout instead of reusing
> > > > user_ptr_regs?
> > > >
> > > > This whole v2 business looks really ugly.
> > >
> > > Wouldn't it break compilation of code like this?
> > >
> > >     bpf_perf_event_data data;
> > >     user_pt_regs *regs = &data.regs;
> >
> > why would it break? user_pt_regs gained extra fields at the end, so
> > whoever works with the assumption of an old definition of
> > user_pt_regs
> > *through pointer* should be totally fine. The problem with
> > bpf_perf_event_data is that user_pt_regs are embedded in the struct
> > directly, so adding anything to it changes bpf_perf_event_data
> > layout.
>
> I meant only building from source, at runtime it should be fine. At
> compile time, the compiler should at least warn that pointer types
> don't match.

Oh, you meant that cast would be necessary. Well, strictly speaking
code like in your example is broken, it should use the type specified
in struct bpf_perf_event_data: bpf_user_pt_regs_t. But the fix to
satisfy compilation is trivial as well, so doesn't matter much.

>
> > I, of course, can't know if this breaks any other use case (including
> > ones you mentioned below), but using user_pt_regs_v2 will probably
> > not
> > work with CO-RE, because older kernels won't have such type defined
> > (and thus relocations will fail).
> >
> > I'm not sure the origins of the need for user_pt_regs (as opposed to
> > using pt_regs directly, like x86-64 does), but with CO-RE and
> > vmlinux.h it would be more reliable and straightforward to just stick
> > to kernel-internal struct pt_regs everywhere. And for non-CO-RE
> > macros
> > maybe just using an offset within struct pt_regs (i.e.,
> > offsetofend(gprs)) would do it?
>
> offsetofend sounds like a nice compromise. I'll give it a try, thanks.

It's kind of dangerous as well, let's maybe leave a comment in pt_regs
that this orig_gpr2 location is assumed by libbpf's tracing macros so
shouldn't be willy-nilly moved

>
> > >
> > > Additionaly, after this I'm no longer sure I haven't missed any
> > > other
> > > places where user_pt_regs might be used. For example, arm64 seems
> > > to be
> > > using it not only for BPF, but also for ptrace?
> > >
> > > static int gpr_get(struct task_struct *target,
> > >                    const struct user_regset *regset,
> > >                    struct membuf to)
> > > {
> > >         struct user_pt_regs *uregs = &task_pt_regs(target)-
> > > >user_regs;
> > >         return membuf_write(&to, uregs, sizeof(*uregs));
> > > }
> > >
> > > and then in e.g. gdb:
> > >
> > > static void
> > > aarch64_fill_gregset (struct regcache *regcache, void *buf)
> > > {
> > >   struct user_pt_regs *regset = (struct user_pt_regs *) buf;
> > >   ...
> > >
> > > I'm also not a big fan of the _v2 solution, but it looked the
> > > safest
> > > to me. At least for s390, a viable alternative that Vasily proposed
> > > would be to go ahead with replacing args[1] with orig_gpr2 and then
> > > also backporting the patch, so that the new libbpf would still work
> > > on
> > > the old stable kernels. But this won't work for arm64.
>
