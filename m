Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D430BE7F
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhBBMoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 07:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232011AbhBBMnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 07:43:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8707064F49;
        Tue,  2 Feb 2021 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612269789;
        bh=qZjLe46fKviv2dKt6AecsFVYWc2+42SL2/KPB+XpkEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehXCdo9wrJ23/hOnURzKfdfHSkO5BUxIDkGX5dH5p7T+SSHFGxb9ZRn50oOYMeJMI
         dNbvLmd1gMGAhy+Gq7ribHQCeLOgqAF06JlS+FKbg0ihAJL/hZO9webd773dLQKuKC
         5RLblxeW/SkKxNd5XOaVumNM0/MAESyp5oYdVSLfwVBciZalau4bNRA6PrNcJwpxzq
         NyPOD/k0YWnSoioSGDck6cSzsqlCVOb2TK9g6wJ7h6F7aVFv5mntlAk/oTOz0iTvDc
         LK8tsJTYxm5Kp87yQq2weHp1fiTWR8CjhkSTlboX/pqNwim666gWqPwCVlwL0079Gm
         fPxiFt4W7XiIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E92340513; Tue,  2 Feb 2021 09:43:06 -0300 (-03)
Date:   Tue, 2 Feb 2021 09:43:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
Message-ID: <20210202124306.GA849267@kernel.org>
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava>
 <YBci6Y8bNZd6KRdw@krava>
 <20210201122532.GE794568@kernel.org>
 <YBgVLqNxL++zVkdK@krava>
 <YBhjOaoV2NqW3jFI@krava>
 <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 01, 2021 at 11:43:26PM +0100, Ondrej Mosnacek escreveu:
> On Mon, Feb 1, 2021 at 9:23 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > On Mon, Feb 01, 2021 at 03:50:22PM +0100, Jiri Olsa wrote:
> > Paul, Ondrej,

> > I put all the recent fixes and made a scratch build:
> >   https://koji.fedoraproject.org/koji/taskinfo?taskID=61049457

> > if you have a chance to test and check your issue was resolved,
> > that'd be great

> I just built the current master branch of dwarves (d783117162c0, which
> includes Jirka's patch) [1] in COPR [2] and then rebuilt the kernel
> with it [3]. With the new dwarves, the issue seems to be fixed -
> /sys/kernel/btf/vmlinux is back to ~4MB and the selinux-testsuite BPF
> subtest passes.

> Thanks everyone for getting to the bottom of this! Hoping to see an
> updated dwarves in rawhide soon ;)

Thanks a lot!

I've updated a f33 system to rawhide to test all this, fixed up some
extra warnings wrt mallinfo(), strndup() error path handling/potential
buffer overflow issue and will add a conditional define for
DW_FORM_implicit_const found in the libbpf CI tests that Andrii pointed
out to me, then go and tag 1.20 and do the rawhide/fedora package update
dance.

- Arnaldo
 
> [1] https://github.com/acmel/dwarves/
> [2] https://copr.fedorainfracloud.org/coprs/omos/kernel-btf-test/build/1930103/
> [3] https://copr.fedorainfracloud.org/coprs/omos/kernel-btf-test/build/1930104/
