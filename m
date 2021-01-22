Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F113C300DD9
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbhAVUgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 15:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbhAVUdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 15:33:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB2C06174A;
        Fri, 22 Jan 2021 12:32:50 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id k4so6696091ybp.6;
        Fri, 22 Jan 2021 12:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0GZ7NuevMmCMIuPI0eOAmyldT5LRIFt3Apaz8yFSO8=;
        b=NnsP8lLaIUuEVQJndMp0ZMQpSrHbQWGP/mSgSnedY0FgEne6Jw9G7C9LFDlqKkpvoM
         N5NqLaqHgcIlc2WWszawJY/I14Tv72xIkCwD9nZrvwHagh5Fvxgfdnz0HKMqfRkkKOMy
         qWCq6HfyRKWDVjHYPWNQ4OUhG5H3BvMr6Kx7KxyL1gF1bc7/6WwIp6tRYUJBOOhpVYn1
         57S9wnCloQHHijIiKfcniY7RWzBeIDqBiCBqI/ID4WfYYfKKElyqmqN8nNq1OpXzOsuQ
         b7+h4PypTBh78F1oS0f40G0g/DYTJjka9vfezyUJzJ4Zbd1FN/8L/D5idoYvNd1AFyXr
         F1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0GZ7NuevMmCMIuPI0eOAmyldT5LRIFt3Apaz8yFSO8=;
        b=Hk43FFN4y+VSCadIWjGADlOvnO3SJsLLXzdSZXI0YEjEg8CQPCRzdw0bZo15uetJSD
         D88lKhzI1l58S/I7+mhACPILvCE/26b5uUdK4bALnOfj/S9f4YA8bnubht/aZRJbdY9g
         b3Do00pCeBghfdM1av9IM/eI1TTeuqiqOLAkBKY/fZFUK4ebCmWaC5tE/kmFdRBPaPsQ
         QC6ydZj6ewlAfvERuwdeD3WQWpb5CvoKHGkMutxzR5iEAOFdEvIfm1VRKxsL7pEJty5n
         aMxk7lEDDHdzS5fvBTs/+WPbliEOytQjDEscmaiC6QjbAacs5djGZ9iCbT1VmzVEEERY
         1uIA==
X-Gm-Message-State: AOAM533U37Ho1AcZKnSRaLzlWM43IGdQTOM2gKATazPfaZa08hu2POws
        AV406kk6XradtcKinzx+P/q8Ghas5p5oJ5RiKuU=
X-Google-Smtp-Source: ABdhPJzALC+KkY5L36vrXXI9OUok+525SBRRsx9IGOrNcc7mmpminaBQtrQ48fkp7rmczcZ5NrRWWfcH9Osq1tbonFw=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr8724204yba.403.1611347569578;
 Fri, 22 Jan 2021 12:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20210119155953.803818-1-revest@chromium.org> <20210119155953.803818-3-revest@chromium.org>
 <CAEf4BzYH26E_ASgX8rny-ZihEvD4K3PXZJvAi7nZrYLSLpKo+A@mail.gmail.com> <CABRcYm+gWJcsFxqriUMHeu3sFFLWWRGy=_wQ5R6hNoYu92c0PQ@mail.gmail.com>
In-Reply-To: <CABRcYm+gWJcsFxqriUMHeu3sFFLWWRGy=_wQ5R6hNoYu92c0PQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Jan 2021 12:32:38 -0800
Message-ID: <CAEf4BzY8kv5rWVjr_x5hcyd9DH7sKOGLHWBXwfhoLdK9JD6rSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: Integrate the
 socket_cookie test to test_progs
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 6:35 AM Florent Revest <revest@chromium.org> wrote:
>
> On Thu, Jan 21, 2021 at 8:55 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Jan 19, 2021 at 8:00 AM Florent Revest <revest@chromium.org> wrote:
> > >
> > > Currently, the selftest for the BPF socket_cookie helpers is built and
> > > run independently from test_progs. It's easy to forget and hard to
> > > maintain.
> > >
> > > This patch moves the socket cookies test into prog_tests/ and vastly
> > > simplifies its logic by:
> > > - rewriting the loading code with BPF skeletons
> > > - rewriting the server/client code with network helpers
> > > - rewriting the cgroup code with test__join_cgroup
> > > - rewriting the error handling code with CHECKs
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > ---
> >
> > Few nits below regarding skeleton and ASSERT_xxx usage.
> >
> > >  tools/testing/selftests/bpf/Makefile          |   3 +-
> > >  .../selftests/bpf/prog_tests/socket_cookie.c  |  82 +++++++
> > >  .../selftests/bpf/progs/socket_cookie_prog.c  |   2 -
> > >  .../selftests/bpf/test_socket_cookie.c        | 208 ------------------
> >
> > please also update .gitignore
>
> Good catch!
>
> > >  4 files changed, 83 insertions(+), 212 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_cookie.c
> > >  delete mode 100644 tools/testing/selftests/bpf/test_socket_cookie.c
> > >
> >
> > [...]
> >
> > > +
> > > +       skel = socket_cookie_prog__open_and_load();
> > > +       if (CHECK(!skel, "socket_cookie_prog__open_and_load",
> > > +                 "skeleton open_and_load failed\n"))
> >
> > nit: ASSERT_PTR_OK
>
> Ah great, I find the ASSERT semantic much easier to follow than CHECKs.
>
> > > +               return;
> > > +
> > > +       cgroup_fd = test__join_cgroup("/socket_cookie");
> > > +       if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
> > > +               goto destroy_skel;
> > > +
> > > +       set_link = bpf_program__attach_cgroup(skel->progs.set_cookie,
> > > +                                             cgroup_fd);
> >
> > you can use skel->links->set_cookie here and it will be auto-destroyed
> > when the whole skeleton is destroyed. More simplification.
>
> Sick. :)
>
> > > +       if (CHECK(IS_ERR(set_link), "set-link-cg-attach", "err %ld\n",
> > > +                 PTR_ERR(set_link)))
> > > +               goto close_cgroup_fd;
> > > +
> > > +       update_link = bpf_program__attach_cgroup(skel->progs.update_cookie,
> > > +                                                cgroup_fd);
> >
> > same as above, no need to maintain your link outside of skeleton
> >
> >
> > > +       if (CHECK(IS_ERR(update_link), "update-link-cg-attach", "err %ld\n",
> > > +                 PTR_ERR(update_link)))
> > > +               goto free_set_link;
> > > +
> > > +       server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> > > +       if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
> > > +               goto free_update_link;
> > > +
> > > +       client_fd = connect_to_fd(server_fd, 0);
> > > +       if (CHECK(client_fd < 0, "connect_to_fd", "errno %d\n", errno))
> > > +               goto close_server_fd;
> >
> > nit: ASSERT_OK is nicer (here and in few other places)
>
> Did you mean ASSERT_OK for the two following err checks ?
>
> ASSERT_OK does not seem right for a fd check where we want fd to be
> positive. ASSERT_OK does: "bool ___ok = ___res == 0;"
>
> I will keep my "CHECK(fd < 0" but maybe there could be an
> ASSERT_POSITIVE that does "bool ___ok = ___res >= 0;"

Ah, I missed that it's returning FD, sorry. For FD we'd have to add
the ASSERT_GEQ(fd, 0, "blah") variant. So yeah, stick to CHECK for
now.

>
> > > +
> > > +       err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.socket_cookies),
> > > +                                 &client_fd, &val);
> > > +       if (CHECK(err, "map_lookup", "err %d errno %d\n", err, errno))
> > > +               goto close_client_fd;
> > > +
> > > +       err = getsockname(client_fd, (struct sockaddr *)&addr, &addr_len);
> > > +       if (CHECK(err, "getsockname", "Can't get client local addr\n"))
> > > +               goto close_client_fd;
> > > +
> > > +       cookie_expected_value = (ntohs(addr.sin6_port) << 8) | 0xFF;
> > > +       CHECK(val.cookie_value != cookie_expected_value, "",
> > > +             "Unexpected value in map: %x != %x\n", val.cookie_value,
> > > +             cookie_expected_value);
> >
> > nit: ASSERT_NEQ is nicer
>
> Indeed.
>
> > > +
> > > +close_client_fd:
> > > +       close(client_fd);
> > > +close_server_fd:
> > > +       close(server_fd);
> > > +free_update_link:
> > > +       bpf_link__destroy(update_link);
> > > +free_set_link:
> > > +       bpf_link__destroy(set_link);
> > > +close_cgroup_fd:
> > > +       close(cgroup_fd);
> > > +destroy_skel:
> > > +       socket_cookie_prog__destroy(skel);
> > > +}
> >
> > [...]
