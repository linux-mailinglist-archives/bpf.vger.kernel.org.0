Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3663310A661
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2019 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfKZWKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 17:10:25 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37450 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfKZWKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 17:10:25 -0500
Received: by mail-qv1-f65.google.com with SMTP id s18so8036497qvr.4;
        Tue, 26 Nov 2019 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7uKd08izb5nhQG0IjlgQ58waurbVqMVhBS+CAPl1bqA=;
        b=YrhtCL8ALUbpbN2Qt1JGWvskoSq6ghJ+qeCy1dQ2WT11GndTOvuc37X4eb2VtD3+Za
         3kevPyy6PY2RFIkkMW24zaOd1FT+K6GEdHljcIuRKN5O/XhkHbwk/odFiVR1dRG61OWG
         SV3Zhw/jKv9GP0w1awFkUv9qu1iHwlug2BiZG+lDepkYJYho8GmRfZ7KTSTB59NXEkiO
         hHz4iULFf/p5r4cWGiUhg1LAVwS0izWsfdKytxNeFWsc+EqDoXayg91PPlaXaTs4z1Yy
         08KQkibSjxARdWH3cdO56a/UYzT/N2Y74AQr2HEWAigKL1gDoZdSWVJhENXV5115N2tJ
         jpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7uKd08izb5nhQG0IjlgQ58waurbVqMVhBS+CAPl1bqA=;
        b=TQETSQBKjUFn0kMEmJUsL7H6whbKOvAzZh6lovxzb21DzfV38q/X/bWQ4crdOA2lo4
         P/iPA7LS9B6J0MzUOSD3h3AyfDSUjxniTslvYap+lOkkdCgbFliS1MREDtPeTYZAR5ke
         +xqRMX27Kzg1dF82zxqxgTNaU0SZ7ZDGxPwTinIntz8etDJCjAz3eD0ZFypxjejCS+3s
         b6mb/yhcKwFiETB8TsiUSZjumTw/GwqxbJSiLusR1AK5hReUf/C8pV7jKub02p6CqWRf
         tZ5xkP2rE15YvSDvGPVw+08coKAdLfoSCFGcSt29NlqbDhF7HrtKCk/xBDOuavSEZSSc
         eOXg==
X-Gm-Message-State: APjAAAUDe/7KgF/wnL/OEBf/kDNXzmyAoYIVFGscZHlKdIXc0X/S3PI+
        Z4zxqTQPW2upDt4vlw8xF28=
X-Google-Smtp-Source: APXvYqxDeh0auLaR0W0oUg0b+gGh0Y/GRnuZccm2tWl4SATLHtKuBRg/g0FL91s7HCxYJzKPDxBSmg==
X-Received: by 2002:ad4:4e52:: with SMTP id eb18mr1117920qvb.173.1574806221764;
        Tue, 26 Nov 2019 14:10:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h1sm5770095qkc.38.2019.11.26.14.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 14:10:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53C8B40D3E; Tue, 26 Nov 2019 19:10:18 -0300 (-03)
Date:   Tue, 26 Nov 2019 19:10:18 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Message-ID: <20191126221018.GA22719@kernel.org>
References: <20191126151045.GB19483@kernel.org>
 <20191126154836.GC19483@kernel.org>
 <87imn6y4n9.fsf@toke.dk>
 <20191126183451.GC29071@kernel.org>
 <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org>
 <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Nov 26, 2019 at 02:05:41PM -0800, Andrii Nakryiko escreveu:
> On Tue, Nov 26, 2019 at 11:12 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Nov 26, 2019 at 07:50:44PM +0100, Toke H�iland-J�rgensen escreveu:
> > > Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> > >
> > > > Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke H�iland-J�rgensen escreveu:
> > > >> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> > > >>
> > > >> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > >> >> Hi guys,
> > > >> >>
> > > >> >>    While merging perf/core with mainline I found the problem below for
> > > >> >> which I'm adding this patch to my perf/core branch, that soon will go
> > > >> >> Ingo's way, etc. Please let me know if you think this should be handled
> > > >> >> some other way,
> > > >> >
> > > >> > This is still not enough, fails building in a container where all we
> > > >> > have is the tarball contents, will try to fix later.
> > > >>
> > > >> Wouldn't the right thing to do not be to just run the script, and then
> > > >> put the generated bpf_helper_defs.h into the tarball?
> >
> > > > I would rather continue just running tar and have the build process
> > > > in-tree or outside be the same.
> > >
> > > Hmm, right. Well that Python script basically just parses
> > > include/uapi/linux/bpf.h; and it can be given the path of that file with
> > > the --filename argument. So as long as that file is present, it should
> > > be possible to make it work, I guess?
> >
> > > However, isn't the point of the tarball to make a "stand-alone" source
> > > distribution?
> >
> > Yes, it is, and as far as possible without any prep, just include the
> > in-source tree files needed to build it.
> >
> > > I'd argue that it makes more sense to just include the
> > > generated header, then: The point of the Python script is specifically
> > > to extract the latest version of the helper definitions from the kernel
> > > source tree. And if you're "freezing" a version into a tarball, doesn't
> > > it make more sense to also freeze the list of BPF helpers?
> >
> > Your suggestion may well even be the only solution, as older systems
> > don't have python3, and that script requires it :-\
> >
> > Some containers were showing this:
> >
> > /bin/sh: 1: /git/linux/scripts/bpf_helpers_doc.py: not found
> > Makefile:184: recipe for target 'bpf_helper_defs.h' failed
> > make[3]: *** [bpf_helper_defs.h] Error 127
> > make[3]: *** Deleting file 'bpf_helper_defs.h'
> > Makefile.perf:778: recipe for target '/tmp/build/perf/libbpf.a' failed
> >
> > That "not found" doesn't mean what it looks from staring at the above,
> > its just that:
> >
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$ head -1 /tmp/perf-5.4.0/scripts/bpf_helpers_doc.py
> > #!/usr/bin/python3
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$ ls -la /usr/bin/python3
> > ls: cannot access /usr/bin/python3: No such file or directory
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$
> >
> > So, for now, I'll keep my fix and start modifying the containers where
> > this fails and disable testing libbpf/perf integration with BPF on those
> > containers :-\
> 
> I don't think there is anything Python3-specific in that script. I
> changed first line to
> 
> #!/usr/bin/env python
> 
> and it worked just fine. Do you mind adding this fix and make those
> older containers happy(-ier?).

I'll try it, was trying the other way around, i.e. adding python3 to
those containers and they got happier, but fatter, so I'll remove that
and try your way, thanks!

I didn't try it that way due to what comes right after the interpreter
line:

#!/usr/bin/python3
# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2018-2019 Netronome Systems, Inc.

# In case user attempts to run with Python 2.
from __future__ import print_function

- Arnaldo
 
> >
> > I.e. doing:
> >
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$ make NO_LIBBPF=1 -C /tmp/perf-5.4.0/tools/perf/ O=/tmp/build/perf
> >
> > which ends up with a functional perf, just one without libbpf linked in:
> >
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$ /tmp/build/perf/perf -vv
> > perf version 5.4.gf69779ce8f86
> >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >     dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> >                   gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
> >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
> >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                    bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                   zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
> > nobody@1fb841e33ba3:/tmp/perf-5.4.0$
> >
> > The the build tests for libbpf and the bpf support in perf will
> > continue, but for a reduced set of containers, those with python3.
> >
> > People wanting to build libbpf on such older systems will hopefully find
> > this discussion in google, run the script, get the output and have it
> > working.
> >
> > - Arnaldo

-- 

- Arnaldo
