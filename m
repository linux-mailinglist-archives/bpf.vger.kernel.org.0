Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81C2FF93D
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 01:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbhAVAKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 19:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAVAKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 19:10:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A5C061786
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 16:09:50 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l17so2215149pff.17
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RavGfVHe+w3dtIeMBqaz6zQ9VwkDBaCQiimc6m0hfak=;
        b=dKG1d5LX5bfkc887lD8MSi0bwIDqhYnWwuRetEWAt/En2MoS/1oz6PnQNQz9H/2EN9
         MSbYbFZFR9IJzJa/K5V1yWeHbY4qLT9lU+A6AbSnQ7QZiHi/jWVGFS4/POtjdbn/ueFv
         2KnQZSIfQlJipwNQkwAySsN35hpTxsnSH6ercV33++pxeouHGNWzTX4Sv1HkqHkF1NIn
         dyf4dE3rtzbZ9r3quJ0U1iRyvr/lcuKdWVIK/Mia/ZeSVtjBml6tsNIoc2z0i3PLm6C+
         cuv1eISWyDavw6vOpJNA7lnK8h9s+cPI7NfFEwPVGm96dgpONAffYq06Gn065q8bve98
         03Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RavGfVHe+w3dtIeMBqaz6zQ9VwkDBaCQiimc6m0hfak=;
        b=o8H+Un+EitTVv+lzj1nzsIPy9nl3f+jrI1nWykp8HElQocNvN7TiYNXPTX7Tp64svA
         GuVUd6ILx8kze1n6CUpP8+tVjAbTk2kW1xGsZX8l9+i9tat8qVTctieSaHYkzABzheWJ
         EtFxDL4pFjPwmbZr6hUtDvrX50jF6IHdDHvp1fmWVYvWLhaMiSH1AIncx3MCqzkIvvOz
         8WHafsKpPP7X/FtkccrthUjiU02Jf5ux6nZcdMS669n+9qMGFc688YCdkF5y5YS5bBBw
         PAtsAD3oM23KsYO6bsy830RyRr3I4lhSGxp+LmSSKl6Oxngy3yWEmds4xoYEHGfhgdLc
         dinw==
X-Gm-Message-State: AOAM5302nfIMTXZnRaqXtl25h/ZYMia8rV93bBL7K99szk8rhN2nj59H
        O7jZCci89xzl7O2m6px6f8bP+l4=
X-Google-Smtp-Source: ABdhPJxDBRTaiWASndjxunEU/EXlMmIOr7fGAdn4uRQ7SpyTbG6WnfG3tY0wjVOfGXI4qEwaFoXa9Sk=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr695646pjn.1.1611274189692; Thu, 21 Jan 2021 16:09:49 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:09:47 -0800
In-Reply-To: <CAEf4BzaOjBN=C=zjmhP-nLJbtm-FKBdpQbJmxtavn6r9VC3eiA@mail.gmail.com>
Message-Id: <YAoXy0xcjhW8BftF@google.com>
Mime-Version: 1.0
References: <20210121012241.2109147-1-sdf@google.com> <20210121012241.2109147-2-sdf@google.com>
 <CAEf4BzaOjBN=C=zjmhP-nLJbtm-FKBdpQbJmxtavn6r9VC3eiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: verify that rebinding to port
 < 1024 from BPF works
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/21, Andrii Nakryiko wrote:
> On Wed, Jan 20, 2021 at 7:16 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > BPF rewrites from 111 to 111, but it still should mark the port as
> > "changed".
> > We also verify that if port isn't touched by BPF, it's still prohibited.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/bind_perm.c      | 88 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bind_perm.c | 36 ++++++++
> >  2 files changed, 124 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bind_perm.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bind_perm.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c  
> b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> > new file mode 100644
> > index 000000000000..840a04ac9042
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include "bind_perm.skel.h"
> > +
> > +#include <sys/types.h>
> > +#include <sys/socket.h>
> > +#include <sys/capability.h>
> > +
> > +static int duration;
> > +
> > +void try_bind(int port, int expected_errno)
> > +{
> > +       struct sockaddr_in sin = {};
> > +       int fd = -1;
> > +
> > +       fd = socket(AF_INET, SOCK_STREAM, 0);
> > +       if (CHECK(fd < 0, "fd", "errno %d", errno))
> > +               goto close_socket;
> > +
> > +       sin.sin_family = AF_INET;
> > +       sin.sin_port = htons(port);
> > +
> > +       errno = 0;
> > +       bind(fd, (struct sockaddr *)&sin, sizeof(sin));
> > +       CHECK(errno != expected_errno, "bind", "errno %d, expected %d",
> > +             errno, expected_errno);

> ASSERT_NEQ() is nicer
Nice, didn't know these existed. Now we need ASSERT_GT/LE/GE/LE to also
get rid of those other CHECKs :-)

> > +
> > +close_socket:
> > +       if (fd >= 0)
> > +               close(fd);
> > +}
> > +
> > +void cap_net_bind_service(cap_flag_value_t flag)
> > +{
> > +       const cap_value_t cap_net_bind_service = CAP_NET_BIND_SERVICE;
> > +       cap_t caps;
> > +
> > +       caps = cap_get_proc();
> > +       if (CHECK(!caps, "cap_get_proc", "errno %d", errno))
> > +               goto free_caps;
> > +
> > +       if (CHECK(cap_set_flag(caps, CAP_EFFECTIVE, 1,  
> &cap_net_bind_service,
> > +                              CAP_CLEAR),
> > +                 "cap_set_flag", "errno %d", errno))
> > +               goto free_caps;
> > +
> > +       if (CHECK(cap_set_flag(caps, CAP_EFFECTIVE, 1,  
> &cap_net_bind_service,
> > +                              CAP_CLEAR),
> > +                 "cap_set_flag", "errno %d", errno))
> > +               goto free_caps;
> > +
> > +       if (CHECK(cap_set_proc(caps), "cap_set_proc", "errno %d",  
> errno))
> > +               goto free_caps;
> > +
> > +free_caps:
> > +       if (CHECK(cap_free(caps), "cap_free", "errno %d", errno))
> > +               goto free_caps;
> > +}
> > +
> > +void test_bind_perm(void)
> > +{
> > +       struct bind_perm *skel;
> > +       int cgroup_fd;
> > +
> > +       cgroup_fd = test__join_cgroup("/bind_perm");
> > +       if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
> > +               return;
> > +
> > +       skel = bind_perm__open_and_load();
> > +       if (CHECK(!skel, "skel-load", "errno %d", errno))
> > +               goto close_cgroup_fd;

> errno is irrelevant; also use ASSERT_PTR_OK() instead
Ack, it might be worth unconditionally printing it in your ASSERT_XXX
macros. Worst case - it's not used, but in general case avoids
all this "errno %d" boilerplate.

> > +
> > +       skel->links.bind_v4_prog =  
> bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
> > +       if (CHECK(IS_ERR(skel->links.bind_v4_prog),
> > +                 "cg-attach", "bind4 %ld",
> > +                 PTR_ERR(skel->links.bind_v4_prog)))

> try using ASSERT_PTR_OK instead
Sure, thanks!
