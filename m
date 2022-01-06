Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9F486D04
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 23:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiAFWEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 17:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbiAFWEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 17:04:39 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48081C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 14:04:39 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id 9so3162192ill.9
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5lCMFrmKhRkcXXvDt5cwlZjJinUAktC4NqCvpS04174=;
        b=pD1rFucmR46qqxkXoaSy+x+Q68ByrPXZh6xWdlE74Hj9mIC0VXltNLqQ88I/xWdglD
         iJdVcL8F3HZfeChQ/0X2+ClqV8RvGQI9ADtSfznZWr7tylswqN0WeXrkImoitvKuOq/r
         7LjiZstSSYgxWeWeZDgVWZUHggdqwlFd2uzkadgzQBgGvxwctaZo7VEMjm/asziO32GN
         1EPueFX8h9RWS+3nTWwKMPoQjSOgq8T4ZcysL9EQv/mdRgogvicJPG5d3UW6ZTUFH2LA
         8xriR0KFf4UBxjhDsKST9Sbr0CAXLCkvm/q7HQ2BFrWKel+diYAnjfBkpW0/7/0tpxI6
         zQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5lCMFrmKhRkcXXvDt5cwlZjJinUAktC4NqCvpS04174=;
        b=svDu7rSdbnpmVaxfEqIyMBMEVcITh3xiA1UtxWO8dUKEQWhA6RmvJXBlOfqK2nhkGG
         1R4fK/zMni95h2+BDBIWONKKTkZrBHbIRM+Nlzjh4Sg5K2lKorAy4ZywC+x7YxF2SL3u
         74Ascmken3ftFtQCPuukoxpbuBsLktqe3irdiPWbpAe/60hiYfKKtHyF672Y6OQbr8z9
         dIlU/7iYqMIuPf+Alc5lEP9fpORZb96R5Ml5DkEq9ewkRFAPjh4ujrsuDmOHYMk/PqAJ
         BkI1FfrvJNGCpYa/n/igQZvvm1CIDfW65SAsQRzYUoHv+UEZ4uqjLEa63KZtPhqYO9c5
         sFuw==
X-Gm-Message-State: AOAM531sjt960uaP/yytm2gWG98Yy5X3m6XnuL5Giqg1pSe92VjcmQ79
        rqz6nDHQq8rMkO9+w+zGZee8fLTW4PWHv00iRpKegA==
X-Google-Smtp-Source: ABdhPJzAMAQgMooGtqRDN40j09UsYvwRjjhj9krflCLslxZqCmlo0k1UyQ8SX0b/aozYQqrCNQo4a6eaX9DRQi9ppgM=
X-Received: by 2002:a92:dd87:: with SMTP id g7mr5165224iln.174.1641506678460;
 Thu, 06 Jan 2022 14:04:38 -0800 (PST)
MIME-Version: 1.0
References: <YddEVgNKBJiqcV6Y@kernel.org> <YddGjjmlMZzxUZbN@kernel.org>
 <YddHmYhvtVvgqZb/@kernel.org> <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
 <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
In-Reply-To: <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jan 2022 14:04:25 -0800
Message-ID: <CAP-5=fUN+XqrSmwqab9DyGtvpZ7iZkfnUNwBfK1CDA_iX+aF0Q@mail.gmail.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Thu, Jan 6, 2022 at 1:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 6, 2022 at 1:42 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jan 6, 2022 at 11:48 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo =
escreveu:
> > > > > After merging torvalds/master to perf/urgent I'm getting this:
> > > > >
> > > > > util/bpf-event.c:25:21: error: no previous prototype for =E2=80=
=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > > >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > util/bpf-event.c:37:1: error: no previous prototype for =E2=80=98=
bpf_object__next_program=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > >    37 | bpf_object__next_program(const struct bpf_object *obj, st=
ruct bpf_program *prev)
> > > > >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > > util/bpf-event.c:46:1: error: no previous prototype for =E2=80=98=
bpf_object__next_map=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > >    46 | bpf_object__next_map(const struct bpf_object *obj, const =
struct bpf_map *prev)
> > > > >       | ^~~~~~~~~~~~~~~~~~~~
> > > > > util/bpf-event.c:55:1: error: no previous prototype for =E2=80=98=
btf__raw_data=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > > >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > > >       | ^~~~~~~~~~~~~
> > > > > cc1: all warnings being treated as errors
> > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:=
96: /tmp/build/perf/util/bpf-event.o] Error 1
> > > > > make[4]: *** Waiting for unfinished jobs....
> > > > > util/bpf_counter.c: In function =E2=80=98bpf_target_prog_name=E2=
=80=99:
> > > > > util/bpf_counter.c:82:15: error: implicit declaration of function=
 =E2=80=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> > > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->=
info.btf_id);
> > > > >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > util/bpf_counter.c:82:13: error: assignment to =E2=80=98struct bt=
f *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without =
a cast [-Werror=3Dint-conversion]
> > > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->=
info.btf_id);
> > > > >       |             ^
> > > > > cc1: all warnings being treated as errors
> > > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:=
96: /tmp/build/perf/util/bpf_counter.o] Error 1
> > > > >
> > > > > I'm checking now...
> > > > >
> > > > > BTW I test perf builds with:
> > > > >
> > > > > make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 PYTHON=3Dpython3 O=3D/tm=
p/build/perf -C tools/perf install-bin && git status && perf test python
> > > >
> > > > Nevermind, this was due to a patch by Ian Rogers I was testing,
> > > > bisecting get up to the last patch, since I had merged torvalds/mas=
ter
> > > > today it got me to a wrong correlation, sorry for the disturbance.
> > > >
> > > > For reference, this is the patch:
> > > >
> > > > http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.=
com
> > >
> > > Ian, I have libbpf-devel installed:
> > >
> > > =E2=AC=A2[acme@toolbox perf]$ rpm -qa | grep libbpf
> > > libbpf-0.4.0-1.fc34.x86_64
> > > libbpf-devel-0.4.0-1.fc34.x86_64
> > > =E2=AC=A2[acme@toolbox perf]$
> > >
> > > But I'm not using LIBBPF_DYNAMIC=3D1, so you can't just give preceden=
ce to
> > > system headers for all of the homies in tools/lib/.
> > >
> > > I bet that if I remove the libbpf-devel package it works, yeah, just
> > > tested. So we need to make those overrides dependent on using
> > > LIBBPF_DYNAMIC=3D1, LIBTRACEEVENT_DYNAMIC=3D1, etc and avoid the big =
hammer
> > > that is -Itools/lib/, using a more finegrained approach, right?
> >
> > Ugh, this is messy. The -I for tools/lib is overloaded and being used
> > in tools/perf/util/bpf-event.c so that bpf/bpf.h, bpf/btf.h and
>
> can you do `make install` for libbpf instead and have it install
> headers into a dedicated target directory which can be added into -I
> search path. Quentin did this for all the other libbpf users in kernel
> tree (bpftool, resolve_btfids, etc) and it works great.

This sounds good to me, and being able to borrow code from bpftool
should make writing it is straightforward. I'll try to find time to do
a patch, but I don't mind someone getting there before me :-)

Thanks,
Ian

> > bpf/libbpf.h can be found. Likewise, for tools/perf/util/debug.c it is
> > used to pick up traceevent/event-parse.h.
> >
> > Assuming  LIBBPF_DYNAMIC=3D1 and LIBTRACEEVENT_DYNAMIC=3D1 then we get
> > different combinations of:
> > libtraceevent >=3D 1.3 && libbpf >=3D 0.6 - -I is broken for debug.c,
> > -idirafter okay
> > libtraceevent >=3D 1.3 && libbpf < 0.6 - -I is broken for debug.c,
> > -idirafter broken for bpf-event.c
> > libtraceevent < 1.3 && libbpf >=3D 0.6 - -I should build okay but
> > headers mismatched, -idirafter okay
> > libtraceevent < 1.3 && libbpf < 0.6 - -I will fail to link
> > bpf-event.c, -idirafter broken for bpf-event.c
> >
> > As the choice of -I and -idirafter are binary then there will always
> > be a way to break the build. We could modify the build so that the
> > -I/-idirafter only applies to the affected C files. This postpones the
> > problem to when libbpf and libtracevent are in the same file, which
> > doesn't happen currently. I think if you want the dynamic behavior
> > then you need to use idirafter.
> >
> > Thanks,
> > Ian
