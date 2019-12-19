Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8D126F9E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 22:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLSVTc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 16:19:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36195 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSVTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 16:19:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so6238021qkc.3
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+pEThUkfLCVQcsuAZh2dFC/+jJp6frZH4J8kG7KGZ1g=;
        b=fQpPOA5MDwAHabjkqANm9hv9bTKk88mvewYCOYForEEhgOxMAL0wl6lasW4iFC8KFP
         Z4w3cyRZkBGdS1g9E19ijcJzwKBoe0eDnG+ly50Dk02nDLryO+kVAtYENR56vCBvFYzo
         rTlA8WXOUpH4t+VJclgMAbNp//QfSnn4V6xqXDwwd+JLiAYloL47CRvHrVRGcX11epiV
         h5N4u7BerTbLrHy30t//7P0nwumP7lO/mILCMqXJnwOLCocODa0WVWM8kEc7yu1dpQ0p
         4Ut5tskP40yO60S9En6GUUDLEUCX//hWPHksJcqilu6BYSA2tI+xYE3GRE6Ox93Nn/cY
         rbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pEThUkfLCVQcsuAZh2dFC/+jJp6frZH4J8kG7KGZ1g=;
        b=iEcLF73nArkOny9PjaUWwm60PI4P5XAP/+UoEuL8X/p6sC5KIMQ6V5jUCp4yJXVrWA
         eiRFa1i/8twphPqqnLYrg3nSHna+TCF5daaA4xRu3c5X2BsE/ElDCgJlTHuwvH6xSUlq
         f+uaw4z3BZIX6NDCz2DgfXNxyi5dYURg3qST5WlzDzjuSV1MHr/q0cTdZevV2iPQX7Xh
         rPb/aXTVrCsI2DMm7rSOudjkayNhAsjb853+nm6k5TjNXq0gWPp2uO3mQXuGPghoP+0H
         m4A25cbzLO4kgUdYbavjXq3+6kXggCzKOET7ak6GWW/1pLcKN+PcaM0kV4o2N/4HiEAU
         7xYA==
X-Gm-Message-State: APjAAAUxa6Eh1Yk3pqyOe1hYbChC1Z6pJN4RRw46mHNHbs7PuhoV9gf+
        btvpfR6qvAsRC2IYv5L9ferMrKQc5JiTX49Fsm4=
X-Google-Smtp-Source: APXvYqzFADMejAGhkB7YEIfkUFAqqkAGfXPi3Oz5diHSayfMLl1Tf38utP+u60IXJER2ShnXzgeI9BAxv5+viv/fYlc=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr10447920qkj.36.1576790370188;
 Thu, 19 Dec 2019 13:19:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
 <CAEf4BzYWJLJgCt4QCcThg4-kbPr=L+Nv2A5Nd0YknWWkuM05tg@mail.gmail.com>
 <20191219073534.GC16266@rdna-mbp.dhcp.thefacebook.com> <CAEf4BzZUGqZd-Hc7jAgP=j8BRf1fDqRHMKtSW=dcGzU+V-j7XA@mail.gmail.com>
 <20191219210907.GD16266@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191219210907.GD16266@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 13:19:18 -0800
Message-ID: <CAEf4BzYYvqUSqYXz-k+Q6LYhDde1jwSd90dMShqx5iUqOvY8ZQ@mail.gmail.com>
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

On Thu, Dec 19, 2019 at 1:09 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Thu, 2019-12-19 12:44 -0800]:
> > On Wed, Dec 18, 2019 at 11:35 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> [Wed, 2019-12-18 21:59 -0800]:
> > > > On Wed, Dec 18, 2019 at 6:17 PM Andrey Ignatov <rdna@fb.com> wrote:
> > > > >
> > > > > Test replacing a cgroup-bpf program attached with BPF_F_ALLOW_MULTI and
> > > > > possible failure modes: invalid combination of flags, invalid
> > > > > replace_bpf_fd, replacing a non-attachd to specified cgroup program.
> > > > >
> > > > > Example of program replacing:
> > > > >
> > > > >   # gdb -q --args ./test_progs --name=cgroup_attach_multi
> > > > >   ...
> > > > >   Breakpoint 1, test_cgroup_attach_multi () at cgroup_attach_multi.c:227
> > > > >   (gdb)
> > > > >   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
> > > > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > > > >   ID       AttachType      AttachFlags     Name
> > > > >   2133     egress          multi
> > > > >   2134     egress          multi
> > > > >   # fg
> > > > >   gdb -q --args ./test_progs --name=cgroup_attach_multi
> > > > >   (gdb) c
> > > > >   Continuing.
> > > > >
> > > > >   Breakpoint 2, test_cgroup_attach_multi () at cgroup_attach_multi.c:233
> > > > >   (gdb)
> > > > >   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
> > > > >   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
> > > > >   ID       AttachType      AttachFlags     Name
> > > > >   2139     egress          multi
> > > > >   2134     egress          multi
> > > > >
> > > > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > > > ---
> > > > >  .../bpf/prog_tests/cgroup_attach_multi.c      | 53 +++++++++++++++++--
> > > > >  1 file changed, 50 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > > > index 4eaab7435044..2ff21dbce179 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > > > > @@ -78,7 +78,8 @@ void test_cgroup_attach_multi(void)
> > > > >  {
> > > > >         __u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
> > > > >         int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
> > > > > -       int allow_prog[6] = {-1};
> > > > > +       DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
> > > > > +       int allow_prog[7] = {-1};
> > > > >         unsigned long long value;
> > > > >         __u32 duration = 0;
> > > > >         int i = 0;
> > > > > @@ -189,6 +190,52 @@ void test_cgroup_attach_multi(void)
> > > > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > > >         CHECK_FAIL(value != 1 + 2 + 8 + 16);
> > > > >
> > > > > +       /* test replace */
> > > > > +
> > > > > +       attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
> > > > > +       attach_opts.replace_prog_fd = allow_prog[0];
> > > > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > > > +                 "fail_prog_replace_override", "unexpected success\n"))
> > > > > +               goto err;
> > > > > +       CHECK_FAIL(errno != EINVAL);
> > > >
> > > > CHECK macro above can prints both in success and failure scenarios,
> > > > which means that errno of bpf_prog_attach_xattr can be overriden by a
> > > > bunch of other functions. So if this check is critical, you'd have to
> > > > remember errno before calling CHECK. Same for all the check below.
> > >
> > > If bpf_prog_attach_xattr finishes successfully (what is unexpected
> > > here), `goto err` will be taken and `CHECK_FAIL(errno != EINVAL)` won't
> > > be run at all so "success" case is not a problem.
> > >
> > > If bpf_prog_attach_xattr fails (what is expected) it has to set errno
> > > and this is the errno that will be checked by CHECK_FAIL, i.e. failure
> > > case is not a problem at all.
> > >
> > > If you mean printf() that is called from "PASS" branch of CHECK then I
> > > don't actually see a way to distinguish errno from failed
> > > bpf_prog_attach_xattr (what would mean "PASS" for the CHECK) and
> > > printf() from the CHECK() w/o changing CHECK() itself.
> >
> > well, of course you can do that:
> >
> > err = bpf_xxx(...);
> > saved_errno = errno;
> > if (CHECK(!err, ...))
> >     goto handle_err;
> > if (CHECK_FAIL(saved_errno)) { ... }
> >
> > It's just more cumbersome, but nothing impossible.
>
> Oh, yeah, that would work, but I agree that it doesn't look great :)
>
> > > I think CHECK() can be improved wrt errno so that it saves errno before
> > > calling anything that can affect it and restore it afterwards. But this
> > > is not specific to this patch so IMO it should be done separately with,
> > > ideally, checking that it doesn't break some other tests.
> >
> > That might be a way to do this, of course. We can add that later.
>
> Sounds good. I can follow-up on the CHECK() change separately so that
> every test that does similar checks doesn't have to have additional code
> to deal with errno.

great

>
> > I
> > think that errno for error code is quite inconvenient, I wonder if it
> > might be possible to retrofit kernel-style error code as a result
> > instead. That's what we do for high-level libbpf API, it might be too
> > late for low-level one though.
>
> There are a bunch of places that actually do it in bpf.c, e.g.
> bpf_prog_test_run_xattr() and bpf_load_program_xattr() return -EINVAL
> for error conditions unrelated to sys_bpf. I also added similar
> thing in patch 4 (libbpf part) for `!OPTS_VALID` scenario.
>
> But for vast majority of cases where wrappers simply return whatever
> sys_bpf returned IMO it makes sense to preserve the semantics similar to
> that of sys_bpf since it's just thin wrappers. Again, just my opinion.
>

can we have both? keep setting errno, but return -errno as a result?
If it's already a hybrid approach we are using, I don't think this
will break anything.


>
> > > > > +
> > > > > +       attach_opts.flags = BPF_F_REPLACE;
> > > > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > > > +                 "fail_prog_replace_no_multi", "unexpected success\n"))
> > > > > +               goto err;
> > > > > +       CHECK_FAIL(errno != EINVAL);
> > > > > +
> > > > > +       attach_opts.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
> > > > > +       attach_opts.replace_prog_fd = -1;
> > > > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > > > +                 "fail_prog_replace_bad_fd", "unexpected success\n"))
> > > > > +               goto err;
> > > > > +       CHECK_FAIL(errno != EBADF);
> > > > > +
> > > > > +       /* replacing a program that is not attached to cgroup should fail  */
> > > > > +       attach_opts.replace_prog_fd = allow_prog[3];
> > > > > +       if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > > > +                                        BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > > > +                 "fail_prog_replace_no_ent", "unexpected success\n"))
> > > > > +               goto err;
> > > > > +       CHECK_FAIL(errno != ENOENT);
> > > > > +
> > > > > +       /* replace 1st from the top program */
> > > > > +       attach_opts.replace_prog_fd = allow_prog[0];
> > > > > +       if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
> > > > > +                                       BPF_CGROUP_INET_EGRESS, &attach_opts),
> > > > > +                 "prog_replace", "errno=%d\n", errno))
> > > > > +               goto err;
> > > > > +
> > > > > +       value = 0;
> > > > > +       CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > > > > +       CHECK_FAIL(system(PING_CMD));
> > > > > +       CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > > > +       CHECK_FAIL(value != 64 + 2 + 8 + 16);
> > > > > +
> > > > >         /* detach 3rd from bottom program and ping again */
> > > > >         if (CHECK(!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS),
> > > > >                   "fail_prog_detach_from_cg3", "unexpected success\n"))
> > > > > @@ -202,7 +249,7 @@ void test_cgroup_attach_multi(void)
> > > > >         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > > > >         CHECK_FAIL(system(PING_CMD));
> > > > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > > > -       CHECK_FAIL(value != 1 + 2 + 16);
> > > > > +       CHECK_FAIL(value != 64 + 2 + 16);
> > > > >
> > > > >         /* detach 2nd from bottom program and ping again */
> > > > >         if (CHECK(bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS),
> > > > > @@ -213,7 +260,7 @@ void test_cgroup_attach_multi(void)
> > > > >         CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
> > > > >         CHECK_FAIL(system(PING_CMD));
> > > > >         CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > > > -       CHECK_FAIL(value != 1 + 2 + 4);
> > > > > +       CHECK_FAIL(value != 64 + 2 + 4);
> > > > >
> > > > >         prog_cnt = 4;
> > > > >         CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
> > > --
> > > Andrey Ignatov
>
> --
> Andrey Ignatov
