Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485D6487C3B
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbiAGScq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbiAGScq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 13:32:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF6C061574;
        Fri,  7 Jan 2022 10:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8443DB82706;
        Fri,  7 Jan 2022 18:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD57C36AE0;
        Fri,  7 Jan 2022 18:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641580363;
        bh=nO9Ewa73KnTnGP0YVJMQNv1b2ECj6Hnb9BCpFdSf10E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qod/10t0ufjlkIkJE1gCZybiKKKB5HPZrNKtj7Z9Ho54gR5IkNtN16mdGmiRJr6PE
         NImtYUppyO3+VAx6AkQV/9SHDpWTI5+W+tB9WjHy2AHOuL3uiZv5X52p333GEshHMh
         IfJ4y6ek0UFzJjd+kNyqqqCIN1wXrVGGoUp+h4O3eihut++lJtlHsaAkUGGUpq/RHS
         RyefQF53DjVYIl8pCyPekxLo6E2ctVhTCt/UQwnts40v1IPsmIs+an73fgoXDkxOYZ
         VpYc8pigJc6S6hZZjpprEsTvzwA1fk3bJ82c7uSsx7zMpsVaV7vuHDgDKxSvOfXNG6
         nUl6uElH8vFYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B62240B92; Fri,  7 Jan 2022 15:32:40 -0300 (-03)
Date:   Fri, 7 Jan 2022 15:32:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
Message-ID: <YdiHSF6CGBoswQ1G@kernel.org>
References: <YddEVgNKBJiqcV6Y@kernel.org>
 <YddGjjmlMZzxUZbN@kernel.org>
 <YddHmYhvtVvgqZb/@kernel.org>
 <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
 <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
 <CAP-5=fUN+XqrSmwqab9DyGtvpZ7iZkfnUNwBfK1CDA_iX+aF0Q@mail.gmail.com>
 <CAP-5=fVE5eo9TSX3rrGb-=DETeYvXtG0AqhpGwjnP6nr8pKrqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVE5eo9TSX3rrGb-=DETeYvXtG0AqhpGwjnP6nr8pKrqg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 06, 2022 at 07:30:34PM -0800, Ian Rogers escreveu:
> On Thu, Jan 6, 2022 at 2:04 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jan 6, 2022 at 1:44 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Jan 6, 2022 at 1:42 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Thu, Jan 6, 2022 at 11:48 AM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > > After merging torvalds/master to perf/urgent I'm getting this:
> > > > > > >
> > > > > > > util/bpf-event.c:25:21: error: no previous prototype for ‘btf__load_from_kernel_by_id’ [-Werror=missing-prototypes]
> > > > > > >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > > > > >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > util/bpf-event.c:37:1: error: no previous prototype for ‘bpf_object__next_program’ [-Werror=missing-prototypes]
> > > > > > >    37 | bpf_object__next_program(const struct bpf_object *obj, struct bpf_program *prev)
> > > > > > >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > util/bpf-event.c:46:1: error: no previous prototype for ‘bpf_object__next_map’ [-Werror=missing-prototypes]
> > > > > > >    46 | bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
> > > > > > >       | ^~~~~~~~~~~~~~~~~~~~
> > > > > > > util/bpf-event.c:55:1: error: no previous prototype for ‘btf__raw_data’ [-Werror=missing-prototypes]
> > > > > > >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > > > > >       | ^~~~~~~~~~~~~
> > > > > > > cc1: all warnings being treated as errors
> > > > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf-event.o] Error 1
> > > > > > > make[4]: *** Waiting for unfinished jobs....
> > > > > > > util/bpf_counter.c: In function ‘bpf_target_prog_name’:
> > > > > > > util/bpf_counter.c:82:15: error: implicit declaration of function ‘btf__load_from_kernel_by_id’ [-Werror=implicit-function-declaration]
> > > > > > >    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
> > > > > > >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > util/bpf_counter.c:82:13: error: assignment to ‘struct btf *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > > > > > >    82 |         btf = btf__load_from_kernel_by_id(info_linear->info.btf_id);
> > > > > > >       |             ^
> > > > > > > cc1: all warnings being treated as errors
> > > > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
> > > > > > >
> > > > > > > I'm checking now...
> > > > > > >
> > > > > > > BTW I test perf builds with:
> > > > > > >
> > > > > > > make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && git status && perf test python
> > > > > >
> > > > > > Nevermind, this was due to a patch by Ian Rogers I was testing,
> > > > > > bisecting get up to the last patch, since I had merged torvalds/master
> > > > > > today it got me to a wrong correlation, sorry for the disturbance.
> > > > > >
> > > > > > For reference, this is the patch:
> > > > > >
> > > > > > http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.com
> > > > >
> > > > > Ian, I have libbpf-devel installed:
> > > > >
> > > > > ⬢[acme@toolbox perf]$ rpm -qa | grep libbpf
> > > > > libbpf-0.4.0-1.fc34.x86_64
> > > > > libbpf-devel-0.4.0-1.fc34.x86_64
> > > > > ⬢[acme@toolbox perf]$
> > > > >
> > > > > But I'm not using LIBBPF_DYNAMIC=1, so you can't just give precedence to
> > > > > system headers for all of the homies in tools/lib/.
> > > > >
> > > > > I bet that if I remove the libbpf-devel package it works, yeah, just
> > > > > tested. So we need to make those overrides dependent on using
> > > > > LIBBPF_DYNAMIC=1, LIBTRACEEVENT_DYNAMIC=1, etc and avoid the big hammer
> > > > > that is -Itools/lib/, using a more finegrained approach, right?
> > > >
> > > > Ugh, this is messy. The -I for tools/lib is overloaded and being used
> > > > in tools/perf/util/bpf-event.c so that bpf/bpf.h, bpf/btf.h and
> > >
> > > can you do `make install` for libbpf instead and have it install
> > > headers into a dedicated target directory which can be added into -I
> > > search path. Quentin did this for all the other libbpf users in kernel
> > > tree (bpftool, resolve_btfids, etc) and it works great.
> >
> > This sounds good to me, and being able to borrow code from bpftool
> > should make writing it is straightforward. I'll try to find time to do
> > a patch, but I don't mind someone getting there before me :-)
> 
> So tools/lib also provides subcmd, symbol and api. These will need
> Makefiles to allow an install and likely the header file structure
> altering. This seems like too big a fix for the next 5.16rc, wdyt?

Right, I think the best thing is to revert the patch Jiri pointed out,
right?

- Arnaldo
