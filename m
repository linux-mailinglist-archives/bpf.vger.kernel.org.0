Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D237124F33
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 18:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLRRZA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 12:25:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35024 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfLRRZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 12:25:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so2592005qka.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZkgCaY+rN6LvMl/fazSg5JtldwCwmh1f/r2wuUfyWU=;
        b=gkV/xFuz77YpvoMy83ATAyL6VaWKNlfqIkuue2u0pj/TdyAdtQ0/BixZpcOspgXcMi
         BnF5KPVlIQal8QlOFCdZphnFwZqC+T6RItbsTkNOjHBRVvzo28ntPtQaOQ0A+dhf/MpR
         kb+9R7F9sLcGcrrIXlwGbLj3TShvG8LNNT8f4Iz2ALN8bGi29Gzh/EYlK9bJaajNN7rP
         MGDMlKxYhzthmBe0MqhvuX5WWyKWbokERcOZEOBrKOF2Z6x3zE7Qt3TnIuYowIyCrFI0
         YwLVE/1lMxQJCbuxBAEqpnNAU31NgjXTimy9dPpoiv232ubM2loQdFul9Nd8svp+UZC1
         GR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZkgCaY+rN6LvMl/fazSg5JtldwCwmh1f/r2wuUfyWU=;
        b=IueNGBlKLFmGHCnSnS6gxK0FvzMOc38IpprZ1JzjByqvw05YU++We9AoL58evQ44Ab
         u/B4RBlDUq/AMWB0h1iKrfJNdm46lKXwjkDK3rLiBOW+RH71CV29CJSuEK8yLWEqEuri
         0omRbfr82cfLM5GYPOcs88CWN7Xj2MeozVmKwZZ6CCUqAhYLHiGYapfO0nlyzIQtS15a
         P44b7nly/Z7+AJywQKKvetujT7hnZUSO73Nb5olG9ejH3R0S2elZ1JRonL35ZEczEFLL
         AdFnd/ERORxx0EpvCnMIJfy/iondz0Ny0RIpRSPiYfJnmFbCN0L/tY2Y5RQpjBMfg0sS
         0QQw==
X-Gm-Message-State: APjAAAXe+1ZCRmuAzddWHgZtMUy2HofVpJI2H+b6X+Uo0CLHKCc0V4wh
        VMpD0cMubo77Q2O12GGG8ZeGmEnY+dmHggu4ZIM=
X-Google-Smtp-Source: APXvYqwFyC7g+c8dM0lGN6G+820FmPld4u4g2Moi4WkI07xPY3j3n1kwVStFWoZyKyU/RBf/OqXF2xZ3odp6Gg00Zqw=
X-Received: by 2002:a37:e408:: with SMTP id y8mr3711422qkf.39.1576689898844;
 Wed, 18 Dec 2019 09:24:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576193131.git.rdna@fb.com> <bc55a274ea572d237bd091819f38502fa837abb5.1576193131.git.rdna@fb.com>
 <CAEf4Bza7KU1r3iRuXiwL7AiOnEbNmxx_hsEUZL8up2OVtJX3XA@mail.gmail.com> <20191218165755.GA94162@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191218165755.GA94162@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 Dec 2019 09:24:47 -0800
Message-ID: <CAEf4BzZJrXPgmHSuDr1QoW8uPu61HXRgxBGt=T-8kTiOCAUnBQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: Cover BPF_F_REPLACE in test_cgroup_attach
To:     Andrey Ignatov <rdna@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 8:58 AM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2019-12-12 23:01 -0800]:
> > On Thu, Dec 12, 2019 at 3:34 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Test replacement of a cgroup-bpf program attached with BPF_F_ALLOW_MULTI
> > > and possible failure modes: invalid combination of flags, invalid
> > > replace_bpf_fd, replacing a non-attachd to specified cgroup program.
> > >
> > > Example of program replacing:
> > >
> > >   # gdb -q ./test_cgroup_attach
> > >   Reading symbols from /data/users/rdna/bin/test_cgroup_attach...done.
> > >   ...
> > >   Breakpoint 1, test_multiprog () at test_cgroup_attach.c:443
> > >   443     test_cgroup_attach.c: No such file or directory.
> > >   (gdb)
> > >   [2]+  Stopped                 gdb -q ./test_cgroup_attach
> > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > >   ID       AttachType      AttachFlags     Name
> > >   35       egress          multi
> > >   36       egress          multi
> > >   # fg gdb -q ./test_cgroup_attach
> > >   c
> > >   Continuing.
> > >   Detaching after fork from child process 361.
> > >
> > >   Breakpoint 2, test_multiprog () at test_cgroup_attach.c:454
> > >   454     in test_cgroup_attach.c
> > >   (gdb)
> > >   [2]+  Stopped                 gdb -q ./test_cgroup_attach
> > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > >   ID       AttachType      AttachFlags     Name
> > >   41       egress          multi
> > >   36       egress          multi
> > >
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  .../selftests/bpf/test_cgroup_attach.c        | 62 +++++++++++++++++--
> > >  1 file changed, 57 insertions(+), 5 deletions(-)
> > >
> >
> > I second Alexei's sentiment. Having this as part of test_progs would
> > certainly be better in terms of ensuring this doesn't accidentally
> > breaks.
>
> OK, I converted both existing test_cgroup_attach and my test for
> BPF_F_REPLACE to test_progs and will send v3 with this change.
>

Great, thanks!

>
> > [...]
> >
> > >
> > > +       /* invalid input */
> > > +
> > > +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts,
> > > +               .target_fd              = cg1,
> > > +               .prog_fd                = allow_prog[6],
> > > +               .replace_prog_fd        = allow_prog[0],
> > > +               .type                   = BPF_CGROUP_INET_EGRESS,
> > > +               .flags                  = BPF_F_ALLOW_MULTI | BPF_F_REPLACE,
> > > +       );
> >
> > This might cause compiler warnings (depending on compiler settings, of
> > course). DECLARE_LIBBPF_OPTS does declare variable, so this is a
> > situation of mixing code and variable declarations, which under C89
> > (or whatever it's named, the older standard that kernel is trying to
> > stick to for the most part) is not allowed.
>
> Yeah, I know about such a warning and expected it but didn't get it with
> the current setup (what surprised me btw) and decided to keep it.

yeah, selftests compiler flags must not be as strict as kernel's, I guess?...

>
> The main reason I kept it is it's not actually clear how to separate
> declaration and initialization of opts structure when
> DECLARE_LIBBPF_OPTS is used since the macro does both things at once. In
> selftests I can just switch to direct initialization (w/o the macro)
> since libbpf and selftests are in sync, but for real use-cases there
> should be smth else (e.g. INIT_LIBBPF_OPTS macro that does only
> initialization of already declared struct).

For compiler, DECLARE_LIBBPF_OPTS is purely declaration, in the same
sense as struct declaration+initialization is still just declaration.
If you need to postpone some of the field initialization, then you can
do that by assinging that field explicitly:

DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts,
    .target_fd = cgl,
);


... some code here ...
attach_opts.prog_fd = allow_prog[6];

It is just a struct, DECLARE_LIBBPF_OPTS just hides memset to 0 and
setting .sz correctly, nothing more.

>
>
> > > +
> > > +       attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> > > +       if (!bpf_prog_attach_xattr(&attach_opts)) {
> > > +               log_err("Unexpected success with OVERRIDE | REPLACE");
> > > +               goto err;
> > > +       }
> > > +       assert(errno == EINVAL);
> > > +
>
> --
> Andrey Ignatov
