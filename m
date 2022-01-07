Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F11487CFB
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 20:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiAGT1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiAGT1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 14:27:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6AC06173E
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 11:27:04 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so8270211iol.13
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6AgMB0BliFhTnPqLx8MPzQovjh3xMAp8CJbNAjfQHdg=;
        b=FOAJPVZDE+rv5n40LPFaJfuooCCHfMlxRIQLIG0itXHXqGrpYkBVbRFm4d3+NYpdMn
         UWmeI6qlHOFlO43k+c8IxLrGACGW+ddYPINbubnpYmQapbLdeODZRodOf10UDV/pEXQf
         z6FmfhQm1qJ6TmyqIgvzGrzuapE5uinfCrKjD0YdR8dPV7Kdl1t8XpDxoh9ZNEOjEIXM
         OX607VLcdRGHWzdj8daQrAWq+E8AFQyDuAMxMGrohJ8EyvvN5HfGy8oMsC4vVc4XtRLw
         Te3T85hCQz89ZhRENCwGv2meh1QZwQYD13M3I6fd4xCqn7gdL7e2VSqwhOjPAZuD7NSN
         0wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6AgMB0BliFhTnPqLx8MPzQovjh3xMAp8CJbNAjfQHdg=;
        b=lOpiUWBdyS1+kOtV9VVIXdEFumOVgCK03u4+wDR3CNXWKcfhrDnyWdT3/QXIxSYEOE
         9PzO5mN21Csjx7GNjjBuYyNpfApEY+KUOaJR6OzxL3y7aZHVmGJKBpETDTToMOL6k4Pn
         ldWqi3QSlp4TDgtj8HoCK5nJJ7onSVAu5NbeoP22kJQ/QL1UMecjalSCHDjOmVdWWeiW
         HvDoPcNQ/JV4KyHHMVYXWCzUt718E0EPVrwPzPW8FcCdbg/Ci3fBojIB0uKla6pZxKvQ
         0vDhZa9356EXyeMze4qmqFhPbxb173KXdxat59Vgv92Svz9fSLYjzzq+YrUIJIMAjg/q
         5wOA==
X-Gm-Message-State: AOAM530m4S8/YzGe+AF6c48Y3reLb8XPKZIriJ967Mo9sYaHI5ksJjr5
        HC86Ac4Ftyb2YgHIL5AZ0RhO19YhPyHf4/K4G/0PadbYN5EL1Q==
X-Google-Smtp-Source: ABdhPJxYq21JQPQkcDcKXPoirZGB7XqqYaNPPvqWi8ceIjY0WSKVoIXBg8HcrRBpeit1RilSvNvQpnNEigv162fYnSM=
X-Received: by 2002:a05:6638:1193:: with SMTP id f19mr31185178jas.237.1641583623214;
 Fri, 07 Jan 2022 11:27:03 -0800 (PST)
MIME-Version: 1.0
References: <YddEVgNKBJiqcV6Y@kernel.org> <YddGjjmlMZzxUZbN@kernel.org>
 <YddHmYhvtVvgqZb/@kernel.org> <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
 <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
 <CAP-5=fUN+XqrSmwqab9DyGtvpZ7iZkfnUNwBfK1CDA_iX+aF0Q@mail.gmail.com>
 <CAP-5=fVE5eo9TSX3rrGb-=DETeYvXtG0AqhpGwjnP6nr8pKrqg@mail.gmail.com> <YdiHSF6CGBoswQ1G@kernel.org>
In-Reply-To: <YdiHSF6CGBoswQ1G@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 7 Jan 2022 11:26:50 -0800
Message-ID: <CAP-5=fX4-kmkm+qn9m22O_4A2_8j=uAm=vcXh9x2RqqDKEdnBg@mail.gmail.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 7, 2022 at 10:32 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 06, 2022 at 07:30:34PM -0800, Ian Rogers escreveu:
> > On Thu, Jan 6, 2022 at 2:04 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Jan 6, 2022 at 1:44 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 6, 2022 at 1:42 PM Ian Rogers <irogers@google.com> wrot=
e:
> > > > >
> > > > > On Thu, Jan 6, 2022 at 11:48 AM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de M=
elo escreveu:
> > > > > > > Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de=
 Melo escreveu:
> > > > > > > > After merging torvalds/master to perf/urgent I'm getting th=
is:
> > > > > > > >
> > > > > > > > util/bpf-event.c:25:21: error: no previous prototype for =
=E2=80=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dmissing-prototypes=
]
> > > > > > > >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u=
32 id)
> > > > > > > >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > util/bpf-event.c:37:1: error: no previous prototype for =E2=
=80=98bpf_object__next_program=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > > > > >    37 | bpf_object__next_program(const struct bpf_object *o=
bj, struct bpf_program *prev)
> > > > > > > >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > util/bpf-event.c:46:1: error: no previous prototype for =E2=
=80=98bpf_object__next_map=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > > > > >    46 | bpf_object__next_map(const struct bpf_object *obj, =
const struct bpf_map *prev)
> > > > > > > >       | ^~~~~~~~~~~~~~~~~~~~
> > > > > > > > util/bpf-event.c:55:1: error: no previous prototype for =E2=
=80=98btf__raw_data=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > > > > >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size=
)
> > > > > > > >       | ^~~~~~~~~~~~~
> > > > > > > > cc1: all warnings being treated as errors
> > > > > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.=
build:96: /tmp/build/perf/util/bpf-event.o] Error 1
> > > > > > > > make[4]: *** Waiting for unfinished jobs....
> > > > > > > > util/bpf_counter.c: In function =E2=80=98bpf_target_prog_na=
me=E2=80=99:
> > > > > > > > util/bpf_counter.c:82:15: error: implicit declaration of fu=
nction =E2=80=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
> > > > > > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_li=
near->info.btf_id);
> > > > > > > >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > > util/bpf_counter.c:82:13: error: assignment to =E2=80=98str=
uct btf *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer wi=
thout a cast [-Werror=3Dint-conversion]
> > > > > > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_li=
near->info.btf_id);
> > > > > > > >       |             ^
> > > > > > > > cc1: all warnings being treated as errors
> > > > > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.=
build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
> > > > > > > >
> > > > > > > > I'm checking now...
> > > > > > > >
> > > > > > > > BTW I test perf builds with:
> > > > > > > >
> > > > > > > > make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 PYTHON=3Dpython3 O=
=3D/tmp/build/perf -C tools/perf install-bin && git status && perf test pyt=
hon
> > > > > > >
> > > > > > > Nevermind, this was due to a patch by Ian Rogers I was testin=
g,
> > > > > > > bisecting get up to the last patch, since I had merged torval=
ds/master
> > > > > > > today it got me to a wrong correlation, sorry for the disturb=
ance.
> > > > > > >
> > > > > > > For reference, this is the patch:
> > > > > > >
> > > > > > > http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@g=
oogle.com
> > > > > >
> > > > > > Ian, I have libbpf-devel installed:
> > > > > >
> > > > > > =E2=AC=A2[acme@toolbox perf]$ rpm -qa | grep libbpf
> > > > > > libbpf-0.4.0-1.fc34.x86_64
> > > > > > libbpf-devel-0.4.0-1.fc34.x86_64
> > > > > > =E2=AC=A2[acme@toolbox perf]$
> > > > > >
> > > > > > But I'm not using LIBBPF_DYNAMIC=3D1, so you can't just give pr=
ecedence to
> > > > > > system headers for all of the homies in tools/lib/.
> > > > > >
> > > > > > I bet that if I remove the libbpf-devel package it works, yeah,=
 just
> > > > > > tested. So we need to make those overrides dependent on using
> > > > > > LIBBPF_DYNAMIC=3D1, LIBTRACEEVENT_DYNAMIC=3D1, etc and avoid th=
e big hammer
> > > > > > that is -Itools/lib/, using a more finegrained approach, right?
> > > > >
> > > > > Ugh, this is messy. The -I for tools/lib is overloaded and being =
used
> > > > > in tools/perf/util/bpf-event.c so that bpf/bpf.h, bpf/btf.h and
> > > >
> > > > can you do `make install` for libbpf instead and have it install
> > > > headers into a dedicated target directory which can be added into -=
I
> > > > search path. Quentin did this for all the other libbpf users in ker=
nel
> > > > tree (bpftool, resolve_btfids, etc) and it works great.
> > >
> > > This sounds good to me, and being able to borrow code from bpftool
> > > should make writing it is straightforward. I'll try to find time to d=
o
> > > a patch, but I don't mind someone getting there before me :-)
> >
> > So tools/lib also provides subcmd, symbol and api. These will need
> > Makefiles to allow an install and likely the header file structure
> > altering. This seems like too big a fix for the next 5.16rc, wdyt?
>
> Right, I think the best thing is to revert the patch Jiri pointed out,
> right?

Your call. There is a latent bug that with LIBTRACEEVENT_DYNAMIC we
are using tools/lib/traceevent header files. Reverting the change
means we don't break because of this, but it means that people
building with LIBTRACEEVENT_DYNAMIC and newer libtraceevent (at least
my employer :-) ) lose logging. I can carry the change locally, so not
a big loss :-) There are a few issues stemming from this:

1) we've identified the current build is wrong for xxx_DYNAMIC options
as tools/lib versions headers always override
2) to address this we should make the tools/lib things proper
libraries like libbpf, libtraceevent, etc.
3) once we have proper libraries, we need to update the perf build to
build non-dynamic libraries then depend on the built/installed header
files

I expect at least some of this is going to break when testing on many
distributions as that just seems to be what always happens, and
changing the build in this significant way is going to have
implications. Doing this means that the code base is in better shape
and logging works. To counter some of the many distribution pain, do
you have a way to reproduce your testing? My OpenSuSE recipe is:

```
# Get the image
docker pull opensuse/tumbleweed
# Start it with an interactive bash shell and mounting the current
directory as /kernel-src
sudo docker run --privileged -it --net=3Dhost --env=3D"DISPLAY" --mount
type=3Dbind,source=3D"$(pwd)",target=3D/kernel-src opensuse/tumbleweed
/bin/bash
# Install missing rpms
zypper install make gcc diffutils flex bison kernel-devel findutils
libelf-devel python3 kernel-kvmsmall-devel glibc-devel
# Go to /kernel-src and build into /tmp, etc.
```
But finding every distribution, every rpm, etc. is quite laborious.

Thanks,
Ian

> - Arnaldo
