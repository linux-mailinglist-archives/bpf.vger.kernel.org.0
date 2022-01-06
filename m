Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B340486C0F
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiAFVod (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbiAFVod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:44:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FEEC061245;
        Thu,  6 Jan 2022 13:44:33 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q5so4784642ioj.7;
        Thu, 06 Jan 2022 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CI6yuteSkCYc97vTodk0hHsFeqfx9VN/CKTtNora0Ng=;
        b=nfJwb8GxfndCAX+8A+g4bSw2XTQ+rhTZLOFadTqThUXYqxQf+rROIXPXj5bcYsRyec
         dBA3COn0tfnO/4GJWgAvZq+qacbtlr6cYVZU3Xr2zp5rk9kZj8O00XuuUIUsyEq9MNWm
         9YgeLTiLoIfFAzP3yywWsDnpHGaaDqXbOdMhGfpUmnfAlF/Es0KXoplKBBHHy3RPo878
         9wyYGa86il7dvzi+eaJjO4j9QCLiwwY7nNyTq3pvYhqdr8PHpPwh5d6+VJ/l9pUQEHSU
         RBUDITWmy6MftocDW5Q/fwJ1at4O4bxcWhB6pLcaK9iqNLJQqI0VAIAIdPk/sbBd7Vgh
         7bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CI6yuteSkCYc97vTodk0hHsFeqfx9VN/CKTtNora0Ng=;
        b=Z0AxPr861COUyO3BJbLmFC2dVGb5sOfZhFeOb7Undk9CPn4BvEF1i4vJMn4WuW8TI6
         0ADX1Lk+oNHkbO7KKwfEqiFPgcSrohEM/LBem38lqLXbpxjiPaUk3PmxNiErT5zAmvhj
         N5SfAhCdZzNy5PAinOimNhQ9dd8PuH+928TGuw4Beaib4huBGGitIF08uP9fqFdvhpdd
         8VGjwWB6f1LKq0s1U0Q6h20WYXgrVOQ0jAY2AjkHeLXrrKR14TRjfwH5/mhN9vozuFYI
         XialUPsEG48lmx0ycBEwn+xgLDomQXbuYqsWC6xBo4hz5BIcYWnuelz/NAi8GkTHLF2Q
         6bFA==
X-Gm-Message-State: AOAM533bEZc+MKAmzTr7UFRQ04ExzmaZhkWXDQ8Ib/wEBuR1Qp92d/sr
        Lj8+pBHiFCibKiqFT3PCBwJIR/GrtYPABv3VCbM=
X-Google-Smtp-Source: ABdhPJzaEc8AAontvkBWkT5/qItC3vQc4c3R02zK/htm81AmVIhot4sHlHwELeyN0UgCO/37FXgzNkvm/Ml/utyYZp0=
X-Received: by 2002:a6b:3b51:: with SMTP id i78mr28578270ioa.63.1641505472685;
 Thu, 06 Jan 2022 13:44:32 -0800 (PST)
MIME-Version: 1.0
References: <YddEVgNKBJiqcV6Y@kernel.org> <YddGjjmlMZzxUZbN@kernel.org>
 <YddHmYhvtVvgqZb/@kernel.org> <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Jan 2022 13:44:21 -0800
Message-ID: <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
To:     Ian Rogers <irogers@google.com>
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

On Thu, Jan 6, 2022 at 1:42 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Jan 6, 2022 at 11:48 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Jan 06, 2022 at 04:44:14PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Thu, Jan 06, 2022 at 04:34:46PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > > > After merging torvalds/master to perf/urgent I'm getting this:
> > > >
> > > > util/bpf-event.c:25:21: error: no previous prototype for =E2=80=98b=
tf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > >    25 | struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> > > >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > util/bpf-event.c:37:1: error: no previous prototype for =E2=80=98bp=
f_object__next_program=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > >    37 | bpf_object__next_program(const struct bpf_object *obj, stru=
ct bpf_program *prev)
> > > >       | ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > util/bpf-event.c:46:1: error: no previous prototype for =E2=80=98bp=
f_object__next_map=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > >    46 | bpf_object__next_map(const struct bpf_object *obj, const st=
ruct bpf_map *prev)
> > > >       | ^~~~~~~~~~~~~~~~~~~~
> > > > util/bpf-event.c:55:1: error: no previous prototype for =E2=80=98bt=
f__raw_data=E2=80=99 [-Werror=3Dmissing-prototypes]
> > > >    55 | btf__raw_data(const struct btf *btf_ro, __u32 *size)
> > > >       | ^~~~~~~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96=
: /tmp/build/perf/util/bpf-event.o] Error 1
> > > > make[4]: *** Waiting for unfinished jobs....
> > > > util/bpf_counter.c: In function =E2=80=98bpf_target_prog_name=E2=80=
=99:
> > > > util/bpf_counter.c:82:15: error: implicit declaration of function =
=E2=80=98btf__load_from_kernel_by_id=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
> > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->in=
fo.btf_id);
> > > >       |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > util/bpf_counter.c:82:13: error: assignment to =E2=80=98struct btf =
*=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer without a =
cast [-Werror=3Dint-conversion]
> > > >    82 |         btf =3D btf__load_from_kernel_by_id(info_linear->in=
fo.btf_id);
> > > >       |             ^
> > > > cc1: all warnings being treated as errors
> > > > make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96=
: /tmp/build/perf/util/bpf_counter.o] Error 1
> > > >
> > > > I'm checking now...
> > > >
> > > > BTW I test perf builds with:
> > > >
> > > > make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 PYTHON=3Dpython3 O=3D/tmp/=
build/perf -C tools/perf install-bin && git status && perf test python
> > >
> > > Nevermind, this was due to a patch by Ian Rogers I was testing,
> > > bisecting get up to the last patch, since I had merged torvalds/maste=
r
> > > today it got me to a wrong correlation, sorry for the disturbance.
> > >
> > > For reference, this is the patch:
> > >
> > > http://lore.kernel.org/lkml/20220106072627.476524-1-irogers@google.co=
m
> >
> > Ian, I have libbpf-devel installed:
> >
> > =E2=AC=A2[acme@toolbox perf]$ rpm -qa | grep libbpf
> > libbpf-0.4.0-1.fc34.x86_64
> > libbpf-devel-0.4.0-1.fc34.x86_64
> > =E2=AC=A2[acme@toolbox perf]$
> >
> > But I'm not using LIBBPF_DYNAMIC=3D1, so you can't just give precedence=
 to
> > system headers for all of the homies in tools/lib/.
> >
> > I bet that if I remove the libbpf-devel package it works, yeah, just
> > tested. So we need to make those overrides dependent on using
> > LIBBPF_DYNAMIC=3D1, LIBTRACEEVENT_DYNAMIC=3D1, etc and avoid the big ha=
mmer
> > that is -Itools/lib/, using a more finegrained approach, right?
>
> Ugh, this is messy. The -I for tools/lib is overloaded and being used
> in tools/perf/util/bpf-event.c so that bpf/bpf.h, bpf/btf.h and

can you do `make install` for libbpf instead and have it install
headers into a dedicated target directory which can be added into -I
search path. Quentin did this for all the other libbpf users in kernel
tree (bpftool, resolve_btfids, etc) and it works great.


> bpf/libbpf.h can be found. Likewise, for tools/perf/util/debug.c it is
> used to pick up traceevent/event-parse.h.
>
> Assuming  LIBBPF_DYNAMIC=3D1 and LIBTRACEEVENT_DYNAMIC=3D1 then we get
> different combinations of:
> libtraceevent >=3D 1.3 && libbpf >=3D 0.6 - -I is broken for debug.c,
> -idirafter okay
> libtraceevent >=3D 1.3 && libbpf < 0.6 - -I is broken for debug.c,
> -idirafter broken for bpf-event.c
> libtraceevent < 1.3 && libbpf >=3D 0.6 - -I should build okay but
> headers mismatched, -idirafter okay
> libtraceevent < 1.3 && libbpf < 0.6 - -I will fail to link
> bpf-event.c, -idirafter broken for bpf-event.c
>
> As the choice of -I and -idirafter are binary then there will always
> be a way to break the build. We could modify the build so that the
> -I/-idirafter only applies to the affected C files. This postpones the
> problem to when libbpf and libtracevent are in the same file, which
> doesn't happen currently. I think if you want the dynamic behavior
> then you need to use idirafter.
>
> Thanks,
> Ian
