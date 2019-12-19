Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83393126F0C
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 21:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLSUku (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 15:40:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42481 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSUkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 15:40:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so6170222qtq.9
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXY3eF3xQ6aoym6DFfD2GSn7Syjunve+8e6E2BlgQy8=;
        b=l9gn4V3wz0KFaa2sU5Xjs3O2zuQXQrSYIfXE39FF0pxdkm61VBGtzzskZEsChHEzfd
         BNwZsSv8EFSXsgM+w5OXnB1Ct1VCAp0xkz6aWlxjTqo7c/+5OHhHwzfOo0a16LvzDsVv
         LjJDwqt6Fdi86fwLk2tG3Chwql8DbVIcf7sg06I7AS6nXNG3xsoQl0tJoHZSJsO4IhMq
         Ifu3jH7hpQv0Zkoye4+J5CT4DKPjSjd7iZdBgH4lAEMqzlwCR+gVy/Dn3vEcv1bciQYV
         J/R9hzS9Y9BBNG9uC6/JpvmGDDkAqy++K+SweMLHE51PQj/RRoboex830LWhrYtKkyC9
         7QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXY3eF3xQ6aoym6DFfD2GSn7Syjunve+8e6E2BlgQy8=;
        b=lPQYRIPEhKT4pHItRjT4nsqTzl74PI78fxf+Em1z5a91/4C3jduhToBd3rewga1UCJ
         vD2YLGKga6BVmmwBXSzEnNLRymTunJ6VzkjoVz/c/0yeRg1cz160DDXX45KdZ0uToZvA
         AK8S1FLHVqA/fg9PBh4qV4Py1MF41/dtPLBJfUM3heCKJBapZtK69oObgh3xogRnTRw7
         jjMAJJWJa/XqgKrabd1sg0uNJ7ptSwafqxR1nVB4tL5ft2XDMgJr4uu1JKAyJ6TRDyFz
         lg1n2meIxKo2T1EZtvPsfGZ3sFOgkDLB0LOi6VI7fL8B+Ni9OH929Bqns34K3YevOnCp
         ZA5g==
X-Gm-Message-State: APjAAAXvJBgXf/cGQ+erNWXZ+1PWsxwozDOzsQSys8krQMuRokPDxOm5
        KzBDxwqP/ad0+r38vlWGLvyUcYUr/ODxPIFk3vk=
X-Google-Smtp-Source: APXvYqyoMPxPs0KZDZOSG5anJd4jxGByaLztK2fdVlFyoZk7/cgYkvZSxGU3Rw0L1JP/FxgvckeMBJKpO9nyE0NSSd4=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr8614058qtl.171.1576788048079;
 Thu, 19 Dec 2019 12:40:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576720240.git.rdna@fb.com> <a13336d12dff699d2b437ffa024adc1d95c97fcd.1576720240.git.rdna@fb.com>
 <CAEf4Bzb2_UqGJxxXvqqpdymzrE06dhj4-XWg5ndsgDndNw787w@mail.gmail.com> <20191219072055.GB16266@rdna-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191219072055.GB16266@rdna-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 12:40:37 -0800
Message-ID: <CAEf4BzZG8tu_WS0h8MQ82N7pBcm1+wd-fHHGhErokEA6KFP_HQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/6] selftests/bpf: Convert test_cgroup_attach
 to prog_tests
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

On Wed, Dec 18, 2019 at 11:21 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> [Wed, 2019-12-18 22:11 -0800]:
> > On Wed, Dec 18, 2019 at 6:14 PM Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Convert test_cgroup_attach to prog_tests.
> > >
> > > This change does a lot of things but in many cases it's pretty expensive
> > > to separate them, so they go in one commit. Nevertheless the logic is
> > > ketp as is and changes made are just moving things around, simplifying
> > > them (w/o changing the meaning of the tests) and making prog_tests
> > > compatible:
> > >
> > > * split the 3 tests in the file into 3 separate files in prog_tests/;
> > >
> > > * rename the test functions to test_<file_base_name>;
> > >
> > > * remove unused includes, constants, variables and functions from every
> > >   test;
> > >
> > > * replace `if`-s with or `if (CHECK())` where additional context should
> > >   be logged and with `if (CHECK_FAIL())` where line number is enough;
> > >
> > > * switch from `log_err()` to logging via `CHECK()`;
> > >
> > > * replace `assert`-s with `CHECK_FAIL()` to avoid crashing the whole
> > >   test_progs if one assertion fails;
> > >
> > > * replace cgroup_helpers with test__join_cgroup() in
> > >   cgroup_attach_override only, other tests need more fine-grained
> > >   control for cgroup creation/deletion so cgroup_helpers are still used
> > >   there;
> > >
> > > * simplify cgroup_attach_autodetach by switching to easiest possible
> > >   program since this test doesn't really need such a complicated program
> > >   as cgroup_attach_multi does;
> > >
> > > * remove test_cgroup_attach.c itself.
> > >
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  tools/testing/selftests/bpf/.gitignore        |   1 -
> > >  tools/testing/selftests/bpf/Makefile          |   3 +-
> > >  .../bpf/prog_tests/cgroup_attach_autodetach.c | 111 ++++
> > >  .../bpf/prog_tests/cgroup_attach_multi.c      | 238 ++++++++
> > >  .../bpf/prog_tests/cgroup_attach_override.c   | 148 +++++
> > >  .../selftests/bpf/test_cgroup_attach.c        | 571 ------------------
> > >  6 files changed, 498 insertions(+), 574 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
> > >  delete mode 100644 tools/testing/selftests/bpf/test_cgroup_attach.c
> > >
> >
> > [...]
> >
> > > +
> > > +       if (CHECK_FAIL(setup_cgroup_environment()))
> > > +               goto err;
> > > +
> > > +       cg1 = create_and_get_cgroup("/cg1");
> > > +       if (CHECK_FAIL(cg1 < 0))
> > > +               goto err;
> > > +       cg2 = create_and_get_cgroup("/cg1/cg2");
> > > +       if (CHECK_FAIL(cg2 < 0))
> > > +               goto err;
> > > +       cg3 = create_and_get_cgroup("/cg1/cg2/cg3");
> > > +       if (CHECK_FAIL(cg3 < 0))
> > > +               goto err;
> > > +       cg4 = create_and_get_cgroup("/cg1/cg2/cg3/cg4");
> > > +       if (CHECK_FAIL(cg4 < 0))
> > > +               goto err;
> > > +       cg5 = create_and_get_cgroup("/cg1/cg2/cg3/cg4/cg5");
> > > +       if (CHECK_FAIL(cg5 < 0))
> > > +               goto err;
> > > +
> > > +       if (CHECK_FAIL(join_cgroup("/cg1/cg2/cg3/cg4/cg5")))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
> > > +                                 BPF_F_ALLOW_MULTI),
> > > +                 "prog0_attach_to_cg1_multi", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       if (CHECK(!bpf_prog_attach(allow_prog[0], cg1, BPF_CGROUP_INET_EGRESS,
> > > +                                  BPF_F_ALLOW_MULTI),
> > > +                 "fail_same_prog_attach_to_cg1", "unexpected success\n"))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[1], cg1, BPF_CGROUP_INET_EGRESS,
> > > +                                 BPF_F_ALLOW_MULTI),
> > > +                 "prog1_attach_to_cg1_multi", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[2], cg2, BPF_CGROUP_INET_EGRESS,
> > > +                                 BPF_F_ALLOW_OVERRIDE),
> > > +                 "prog2_attach_to_cg2_override", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[3], cg3, BPF_CGROUP_INET_EGRESS,
> > > +                                 BPF_F_ALLOW_MULTI),
> > > +                 "prog3_attach_to_cg3_multi", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[4], cg4, BPF_CGROUP_INET_EGRESS,
> > > +                           BPF_F_ALLOW_OVERRIDE),
> > > +                 "prog4_attach_to_cg4_override", "errno=%d\n", errno))
> > > +               goto err;
> > > +
> > > +       if (CHECK(bpf_prog_attach(allow_prog[5], cg5, BPF_CGROUP_INET_EGRESS, 0),
> > > +                 "prog5_attach_to_cg5_none", "errno=%d\n", errno))
> > > +               goto err;
> >
> > nit: this looks like a good candidate for a loop...
>
> These tests can benefit from a lot of cleanup steps and yeah, this can
> be one of them. I'd prefer to deal with it separately though since it
> shouldn't be a blocker for this patch set. That's why I preserved this
> logic with just adding checks.
>

Sure, no problem.

>
> > > +       CHECK_FAIL(system(PING_CMD));
> > > +       CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
> > > +       CHECK_FAIL(value != 1 + 2 + 8 + 32);
> > > +
> >
> > [...]
> >
> > > -int main(void)
> > > -{
> > > -       int (*tests[])(void) = {
> > > -               test_foo_bar,
> > > -               test_multiprog,
> > > -               test_autodetach,
> > > -       };
> > > -       int errors = 0;
> > > -       int i;
> > > -
> > > -       for (i = 0; i < ARRAY_SIZE(tests); i++)
> > > -               if (tests[i]())
> > > -                       errors++;
> >
> > Depending on what you think is better structure (I couldn't follow
> > through entire test logic...), you could have done this as a single
> > test with 3 subtests. Search for test__start_subtest(). If that saves
> > you some duplication, I think it's worth converting (which will be
> > 1-to-1 with original structure).
>
> Yeah, I saw test__start_subtest() and checked if it would fit here. IMO
> it wouldn't since these tests don't have much in common and can't be
> converted to, say, parametrized tests that differ only in input that can
> be easily described by a struct. They do cover parts of same feature
> (cgroup attach) but focus on different parts of it. That's why separate
> files. This actually helped to identify and remove a bunch of junk from
> each test (like simplifying testing prog in autodetach).

OK, I don't insist, just wasn't sure if you are aware of subtests facility.

Acked-by: Andrii Nakryiko <andriin@fb.com>


>
>
> > But either way thanks a lot for doing the convertion, brings as
> > another step closer to more uniform and consolidated testing infra.
> >
> > > -
> > > -       if (errors)
> > > -               printf("test_cgroup_attach:FAIL\n");
> > > -       else
> > > -               printf("test_cgroup_attach:PASS\n");
> > > -
> > > -       return errors ? EXIT_FAILURE : EXIT_SUCCESS;
> > > -}
> > > --
> > > 2.17.1
> > >
>
> --
> Andrey Ignatov
