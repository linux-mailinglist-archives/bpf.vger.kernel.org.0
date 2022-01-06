Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC6486C0A
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiAFVmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244347AbiAFVmC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:42:02 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94113C061212
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:42:02 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d3so3108531ilr.10
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HeoT0mQrj9JvIgt5NiHK7dnl/tGxYKl1417jYmdtGtM=;
        b=Ms8vDWwvsUMeTK3hnY/EkhJydyrkOK1e7wWJGowWXCYsro3ZMTKXhno4PCFQz5/0qH
         +f9PTFeCU7YqKMqOsQaDXKbylLp8nSClPcpEI8eeQQ4PPwCaUIlhcdWhnsR4RjGNgmFS
         +uIlu57DVwc2wlt7lovl52K6+9FMUgPj5jNgiScHpKaFkXoKbru8NE5K1hNWhyESKK/W
         lQbTEbLxXMiFV6z66u/Sn99tGMbDXXZ3BC11fPz3coDkngxgdWZIWayWmOYAmBEQaVdM
         UqOl5LY2d7xT0dmhURdJboT3qR106v1Eyt4b8Y0YxyET/NCevpJeSom1P7kD7PN5n90f
         JhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HeoT0mQrj9JvIgt5NiHK7dnl/tGxYKl1417jYmdtGtM=;
        b=bbaeX1MYSXltsEEJl77/N5Ymm3g5cL35SVQVanWVoryY/l6Rwx7SAEIBTlECFc5U5X
         eqb18ZT8YtnclxK42vmtsRRhN8M0dP0Bg8dKzx+Byk3Yshl3pQ9zw9ky6FK0P0ZqfFkl
         8eTuWrf4chb5++Y5YoGBOsqsHJJCqCHKmh/bYOZx4cGusDY2UzbcnEVx/9mC6O50ARzC
         oBLrfGI1CfUwMqyyMk9hvRtVI2zJ29wD61WmowaOhJRKo010ucSdhEjdZFZFcytTehnU
         ra3JpuOJuRlIPmET41lKTpcOvvRXBGuJAxli54ynwUcQkvhzH47h1RbbcIXshcyapC8t
         auBQ==
X-Gm-Message-State: AOAM532cqyq0WRMhmpIdYahP3u62AlxhCynLdIl8tXeBIdUKePhMa8nC
        8PkdP+6sWNILfQFSrwgU2pA0EfKiL5K/QdHioGlUQQ==
X-Google-Smtp-Source: ABdhPJyU33dQiQIgwHreTOmvHttQQLVMwIuI0OBX9XUWDqhj4QWUrm/Ugebp8LtCvNHgpWwO3E2orcUIViamqx3Jh1g=
X-Received: by 2002:a05:6e02:1c21:: with SMTP id m1mr5596173ilh.150.1641505321618;
 Thu, 06 Jan 2022 13:42:01 -0800 (PST)
MIME-Version: 1.0
References: <YddEVgNKBJiqcV6Y@kernel.org> <YddGjjmlMZzxUZbN@kernel.org> <YddHmYhvtVvgqZb/@kernel.org>
In-Reply-To: <YddHmYhvtVvgqZb/@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Jan 2022 13:41:48 -0800
Message-ID: <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 6, 2022 at 11:48 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > After merging torvalds/master to perf/urgent I'm getting this:
> > >
> > > util/bpf-event.c:25:21: error: no previous prototype for =E2=80=98btf=
__load_from_kernel_by_id=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > util/bpf-event.c:37:1: error: no previous prototype for =E2=80=98bpf_=
object__next_program=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >    37 | bpf_object__next_program(const struct bpf_object *obj, struct=
 bpf_program *prev)
> > >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > util/bpf-event.c:46:1: error: no previous prototype for =E2=80=98bpf_=
object__next_map=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >    46 | bpf_object__next_map(const struct bpf_object *obj, const stru=
ct bpf_map *prev)
> > >       | ^~~~~~~~~~~~~~~~~~~~
> > > util/bpf-event.c:55:1: error: no previous prototype for =E2=80=98btf_=
_raw_data=E2=80=99 [-Werror=3Dmissing-prototypes]
> > >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > >       | ^~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: =
/tmp/build/perf/util/bpf-event.o] Error 1
> > > make[4]: *** Waiting for unfinished jobs....
> > > util/bpf_counter.c: In function =E2=80=98bpf_target_prog_name=E2=80=
=99:
> > > util/bpf_counter.c:82:15: error: implicit declaration of function =E2=
=80=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
> > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->info=
.btf_id);
> > >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > util/bpf_counter.c:82:13: error: assignment to =E2=80=98struct btf *=
=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a c=
ast [-Werror=3Dint-conversion]
> > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->info=
.btf_id);
> > >       |             ^
> > > cc1: all warnings being treated as errors
> > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: =
/tmp/build/perf/util/bpf_counter.o] Error 1
> > >
> > > I'm checking now...
> > >
> > > BTW I test perf builds with:
> > >
> > > make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 PYTHON=3Dpython3 O=3D/tmp/bu=
ild/perf -C tools/perf install-bin && git status && perf test python
> >
> > Nevermind, this was due to a patch by Ian Rogers I was testing,
> > bisecting get up to the last patch, since I had merged torvalds/master
> > today it got me to a wrong correlation, sorry for the disturbance.
> >
> > For reference, this is the patch:
> >
> > http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.com
>
> Ian, I have libbpf-devel installed:
>
> =E2=AC=A2[acme@toolbox perf]$ rpm -qa | grep libbpf
> libbpf-0.4.0-1.fc34.x86_64
> libbpf-devel-0.4.0-1.fc34.x86_64
> =E2=AC=A2[acme@toolbox perf]$
>
> But I'm not using LIBBPF_DYNAMIC=3D1, so you can't just give precedence t=
o
> system headers for all of the homies in tools/lib/.
>
> I bet that if I remove the libbpf-devel package it works, yeah, just
> tested. So we need to make those overrides dependent on using
> LIBBPF_DYNAMIC=3D1, LIBTRACEEVENT_DYNAMIC=3D1, etc and avoid the big hamm=
er
> that is -Itools/lib/, using a more finegrained approach, right?

Ugh, this is messy. The -I for tools/lib is overloaded and being used
in tools/perf/util/bpf-event.c so that bpf/bpf.h, bpf/btf.h and
bpf/libbpf.h can be found. Likewise, for tools/perf/util/debug.c it is
used to pick up traceevent/event-parse.h.

Assuming  LIBBPF_DYNAMIC=3D1 and LIBTRACEEVENT_DYNAMIC=3D1 then we get
different combinations of:
libtraceevent >=3D 1.3 && libbpf >=3D 0.6 - -I is broken for debug.c,
-idirafter okay
libtraceevent >=3D 1.3 && libbpf < 0.6 - -I is broken for debug.c,
-idirafter broken for bpf-event.c
libtraceevent < 1.3 && libbpf >=3D 0.6 - -I should build okay but
headers mismatched, -idirafter okay
libtraceevent < 1.3 && libbpf < 0.6 - -I will fail to link
bpf-event.c, -idirafter broken for bpf-event.c

As the choice of -I and -idirafter are binary then there will always
be a way to break the build. We could modify the build so that the
-I/-idirafter only applies to the affected C files. This postpones the
problem to when libbpf and libtracevent are in the same file, which
doesn't happen currently. I think if you want the dynamic behavior
then you need to use idirafter.

Thanks,
Ian
