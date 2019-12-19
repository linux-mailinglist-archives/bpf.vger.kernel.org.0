Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEF126F11
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLSUoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 15:44:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41532 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSUoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 15:44:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so6193629qtk.8
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiZRAWcNTAhcKxDmnPgQFUmv1mgKQIoIIIcgKXTbXvI=;
        b=FwZwSQ/LrCVYIDMSNvbKu1PApkE9qefyb7NxDbnDuPHHYIp1u8XP3J7ay7SeY6uvae
         lJi1dpoACD8npDctnKGIZUF0MWzrrDeJClErHFY69WOJio2YTBJZyXAK/A+0O6zO5CnH
         8rPB+dc/evOEdP2jITJ7GMJlwZVOQqx3e9ikENQIwz1Csjvdoxilhq70kcxwQ5yQ4PSa
         GV4N8IRq3AnZNdzmpmLeacV2Gt1UI05CT1p09S68UlqOKN5Dx9krIFMLUI3EWLbyRcVN
         YdN9OBnWXF/JZiErVmZnvz4eJOId8Kr970dXWB73So+G5juEV+FFIsrdZrpyFrtHQy0w
         n0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiZRAWcNTAhcKxDmnPgQFUmv1mgKQIoIIIcgKXTbXvI=;
        b=giA6jBtWDovwwwDnRBtXKU83CcltCsZbmvWRLtaCqW3HCNFOBr/OgxRQbouStYoWpk
         VTHgIRqb6IeNDdkLF/6e1jJ712xb5mk8QTbMuX4H06KdOpP+d8iVTqwGylhImaCRB58w
         ndV32evwpXqyRK1Xrkw2NW3TpGJ8pJSpCf0Q+qXPcLAChdw+uIjheRG3hSjnMyqAr00d
         E/aleJE5ofOn4O1iuBSDNadWy+p6deFctvOYx+VdFTcdBBovJR0kLR1x53BDgAMKGaQZ
         W5wFRmrhdUsWA2uIxGilOcepvTs9pQWnADtmtBUMDQxk5IkoUZYwZOdyh16q6HCAqiNQ
         CnZw==
X-Gm-Message-State: APjAAAVdOpS/3p5JLd1PqsZ1Ut4aoBbrEN0HD4Nl1CdsLn+rsjPVrPbr
        4naZQ1TFHJYZUNCHyYiUJ7opgIlM66PqRfLdXjEMfgFI
X-Google-Smtp-Source: APXvYqxIJGIDwAnYIiduYu7DtU1QrJ5Zob7cLjOU4B1M7ogwaGNiFN8KMtCnDkhBYv++xgRISn5GixWpY7wcuwb4Cpo=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr8624059qtl.171.1576788252215;
 Thu, 19 Dec 2019 12:44:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
 <CAEf4BzYWJLJgCt4QCcThg4-kbPr=L+Nv2A5Nd0YknWWkuM05tg@mail.gmail.com> <20191219073534.GC16266@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191219073534.GC16266@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 12:44:01 -0800
Message-ID: <CAEf4BzZUGqZd-Hc7jAgP=j8BRf1fDqRHMKtSW=dcGzU+V-j7XA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in cgroup_attach_multi
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:35 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Wed, 2019-12-18 21:59 -0800]:
> > On Wed, Dec 18, 2019 at 6:17 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Test replacing a cgroup-bpf program attached with BPF_F_ALLOW_MULTI and
> > > possible failure modes: invalid combination of flags, invalid
> > > replace_bpf_fd, replacing a non-attachd to specified cgroup program.
> > >
> > > Example of program replacing:
> > >
> > >   # gdb -q --args ./test_progs --name=cgroup_attach_multi
> > >   ...
> > >   Breakpoint 1, test_cgroup_attach_multi () at cgroup_attach_multi.c:227
> > >   (gdb)
> > >   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
> > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > >   ID       AttachType      AttachFlags     Name
> > >   2133     egress          multi
> > >   2134     egress          multi
> > >   # fg
> > >   gdb -q --args ./test_progs --name=cgroup_attach_multi
> > >   (gdb) c
> > >   Continuing.
> > >
> > >   Breakpoint 2, test_cgroup_attach_multi () at cgroup_attach_multi.c:233
> > >   (gdb)
> > >   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
> > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > >   ID       AttachType      AttachFlags     Name
> > >   2139     egress          multi
> > >   2134     egress          multi
> > >
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  .../bpf/prog_tests/cgroup_attach_multi.c      | 53 +++++++++++++++++--
> > >  1 file changed, 50 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > index 4eaab7435044..2ff21dbce179 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > @@ -78,7 +78,8 @@ void test_cgroup_attach_multi(void)
> > >  {
> > >         __u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
> > >         int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
> > > -       int allow_prog[6] = {-1};
> > > +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
> > > +       int allow_prog[7] = {-1};
> > >         unsigned long long value;
> > >         __u32 duration = 0;
> > >         int i = 0;
> > > @@ -189,6 +190,52 @@ void test_cgroup_attach_multi(void)
> > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > >         CHECK_FAIL(value != 1 + 2 + 8 + 16);
> > >
> > > +       /* test replace */
> > > +
> > > +       attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> > > +       attach_opts.replace_prog_fd = allow_prog[0];
> > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > +                 "fail_prog_replace_override", "unexpected success\n"))
> > > +               goto err;
> > > +       CHECK_FAIL(errno != EINVAL);
> >
> > CHECK macro above can prints both in success and failure scenarios,
> > which means that errno of bpf_prog_attach_xattr can be overriden by a
> > bunch of other functions. So if this check is critical, you'd have to
> > remember errno before calling CHECK. Same for all the check below.
>
> If bpf_prog_attach_xattr finishes successfully (what is unexpected
> here), `goto err` will be taken and `CHECK_FAIL(errno != EINVAL)` won't
> be run at all so "success" case is not a problem.
>
> If bpf_prog_attach_xattr fails (what is expected) it has to set errno
> and this is the errno that will be checked by CHECK_FAIL, i.e. failure
> case is not a problem at all.
>
> If you mean printf() that is called from "PASS" branch of CHECK then I
> don't actually see a way to distinguish errno from failed
> bpf_prog_attach_xattr (what would mean "PASS" for the CHECK) and
> printf() from the CHECK() w/o changing CHECK() itself.

well, of course you can do that:

err = bpf_xxx(...);
saved_errno = errno;
if (CHECK(!err, ...))
    goto handle_err;
if (CHECK_FAIL(saved_errno)) { ... }

It's just more cumbersome, but nothing impossible.

>
> I think CHECK() can be improved wrt errno so that it saves errno before
> calling anything that can affect it and restore it afterwards. But this
> is not specific to this patch so IMO it should be done separately with,
> ideally, checking that it doesn't break some other tests.

That might be a way to do this, of course. We can add that later. I
think that errno for error code is quite inconvenient, I wonder if it
might be possible to retrofit kernel-style error code as a result
instead. That's what we do for high-level libbpf API, it might be too
late for low-level one though.

>
> > > +
> > > +       attach_opts.flags = BPF_F_REPLACE;
> > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > +                 "fail_prog_replace_no_multi", "unexpected success\n"))
> > > +               goto err;
> > > +       CHECK_FAIL(errno != EINVAL);
> > > +
> > > +       attach_opts.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
> > > +       attach_opts.replace_prog_fd = -1;
> > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > +                 "fail_prog_replace_bad_fd", "unexpected success\n"))
> > > +               goto err;
> > > +       CHECK_FAIL(errno != EBADF);
> > > +
> > > +       /* replacing a program that is not attached to cgroup should fail  */
> > > +       attach_opts.replace_prog_fd = allow_prog[3];
> > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > +                 "fail_prog_replace_no_ent", "unexpected success\n"))
> > > +               goto err;
> > > +       CHECK_FAIL(errno != ENOENT);
> > > +
> > > +       /* replace 1st from the top program */
> > > +       attach_opts.replace_prog_fd = allow_prog[0];
> > > +       if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > +                                       BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > +                 "prog_replace", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       value = 0;
> > > +       CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > > +       CHECK_FAIL(system(PING_CMD));
> > > +       CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > +       CHECK_FAIL(value != 64 + 2 + 8 + 16);
> > > +
> > >         /* detach 3rd from bottom program and ping again */
> > >         if (CHECK(!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS),
> > >                   "fail_prog_detach_from_cg3", "unexpected success\n"))
> > > @@ -202,7 +249,7 @@ void test_cgroup_attach_multi(void)
> > >         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > >         CHECK_FAIL(system(PING_CMD));
> > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > -       CHECK_FAIL(value != 1 + 2 + 16);
> > > +       CHECK_FAIL(value != 64 + 2 + 16);
> > >
> > >         /* detach 2nd from bottom program and ping again */
> > >         if (CHECK(bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS),
> > > @@ -213,7 +260,7 @@ void test_cgroup_attach_multi(void)
> > >         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > >         CHECK_FAIL(system(PING_CMD));
> > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > -       CHECK_FAIL(value != 1 + 2 + 4);
> > > +       CHECK_FAIL(value != 64 + 2 + 4);
> > >
> > >         prog_cnt = 4;
> > >         CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
> > > --
> > > 2.17.1
> > >
>
> --
> Andrey Ignatov
