Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91E25E1A2
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIDSvK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 14:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgIDSvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 14:51:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B5A20665;
        Fri,  4 Sep 2020 18:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599245468;
        bh=Twj18k+c6SsPkUog9LNw71943z1B88d4+qHItMScd4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iB7/I4m6L5ixT8RwW+Sq/m27FvNI9TLhbt00GurT02Iuvm6pGlib+/R7T+sPbku3s
         IO0iF5B/G5l1YRR+XTsXkhBI0WQV3EJsBp+GRPXdHdzzzPQ5PpMoU7Q4Ey/NkLhe45
         tAOX/Rl6tNToULAzEA27OcLiwAylgNVxoMlPJvZw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 16EF940D3D; Fri,  4 Sep 2020 15:51:06 -0300 (-03)
Date:   Fri, 4 Sep 2020 15:51:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/5] perf record: Prevent override of
 attr->sample_period for libpfm4 events
Message-ID: <20200904185106.GB3752059@kernel.org>
References: <20200728085734.609930-1-irogers@google.com>
 <20200728085734.609930-3-irogers@google.com>
 <20200728155940.GC1319041@krava>
 <20200728160954.GD1319041@krava>
 <CAP-5=fVqto0LrwgW6dHQupp7jFA3wToRBonBaXXQW4wwYcTreg@mail.gmail.com>
 <CAP-5=fWNniZuYfYhz_Cz7URQ+2E4T4Kg3DJqGPtDg70i38Er_A@mail.gmail.com>
 <20200904160303.GD939481@krava>
 <CAP-5=fWOSi4B3g1DARkh6Di-gU4FgmjnhbPYRBdvSdLSy_KC5Q@mail.gmail.com>
 <20200904184803.GA3749996@kernel.org>
 <20200904185013.GA3752059@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904185013.GA3752059@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Sep 04, 2020 at 03:50:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 04, 2020 at 03:48:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 04, 2020 at 09:22:10AM -0700, Ian Rogers escreveu:
> > > On Fri, Sep 4, 2020 at 9:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Thu, Sep 03, 2020 at 10:41:14PM -0700, Ian Rogers wrote:
> > > > > On Wed, Jul 29, 2020 at 4:24 PM Ian Rogers <irogers@google.com> wrote:
> > > > > > On Tue, Jul 28, 2020 at 9:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > > On Tue, Jul 28, 2020 at 05:59:46PM +0200, Jiri Olsa wrote:
> > > > > > > > On Tue, Jul 28, 2020 at 01:57:31AM -0700, Ian Rogers wrote:
> > > > > > > [jolsa@krava perf]$ sudo ./perf test 17 -v
> > > > > > > 17: Setup struct perf_event_attr                          :
> > 
> > > > > > > running './tests/attr/test-record-C0'
> > > > > > > expected sample_period=4000, got 3000
> > > > > > > FAILED './tests/attr/test-record-C0' - match failure
> > 
> > > > > > I'm not able to reproduce this. Do you have a build configuration or
> > > > > > something else to look at? The test doesn't seem obviously connected
> > > > > > with this patch.
> > 
> > > > > Jiri, any update? Thanks,
> > 
> > > > sorry, I rebased and ran it again and it passes for me now,
> > > > so it got fixed along the way
> > 
> > > No worries, thanks for the update! It'd be nice to land this and the
> > > other libpfm fixes.
> > 
> > I applied it and it generated this regression:
> > 
> > FAILED '/home/acme/libexec/perf-core/tests/attr/test-record-pfm-period' - match failure
> > 
> > I'll look at the other patches that are pending in this regard to see
> > what needs to be squashed so that we don't break bisect.
> 
> So, more context:
> 
> running '/home/acme/libexec/perf-core/tests/attr/test-record-pfm-period'
> expected exclude_hv=0, got 1
> FAILED '/home/acme/libexec/perf-core/tests/attr/test-record-pfm-period' - match failure
> test child finished with -1
> ---- end ----
> Setup struct perf_event_attr: FAILED!
> [root@five ~]#
> 
> Ian, can you take a look at this?

Further tests I've performed:

    Committer testing:

    Not linking with libpfm:

      # ldd ~/bin/perf | grep libpfm
      #

    Before:

      # perf record -c 10000 -e cycles/period=12345/,instructions sleep 0.0001
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.052 MB perf.data (258 samples) ]
      # perf evlist -v
      cycles/period=12345/: size: 120, { sample_period, sample_freq }: 12345, sample_type: IP|TID|TIME|ID, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
      instructions: size: 120, config: 0x1, { sample_period, sample_freq }: 10000, sample_type: IP|TID|TIME|ID, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
      #

    After:

      #
      # perf record -c 10000 -e cycles/period=12345/,instructions sleep 0.0001
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.053 MB perf.data (284 samples) ]
      # perf evlist -v
      cycles/period=12345/: size: 120, { sample_period, sample_freq }: 12345, sample_type: IP|TID|TIME|ID, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
      instructions: size: 120, config: 0x1, { sample_period, sample_freq }: 10000, sample_type: IP|TID|TIME|ID, read_format: ID, disabled: 1, inherit: 1, enable_on_exec: 1, sample_id_all: 1, exclude_guest: 1
      #

    Linking with libpfm:

      # ldd ~/bin/perf | grep libpfm
            libpfm.so.4 => /lib64/libpfm.so.4 (0x00007f54c7d75000)
      #

      # perf record -c 10000 --pfm-events=cycles:period=77777 sleep 1
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.043 MB perf.data (141 samples) ]
      # perf evlist -v
      cycles:period=77777: size: 120, { sample_period, sample_freq }: 10000, sample_type: IP|TID|TIME, read_format: ID, disabled: 1, inherit: 1, exclude_hv: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
      #

    After:

      # perf record -c 10000 --pfm-events=cycles:period=77777 sleep 1
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.039 MB perf.data (19 samples) ]
      # perf evlist -v
      cycles:period=77777: size: 120, { sample_period, sample_freq }: 77777, sample_type: IP|TID|TIME, read_format: ID, disabled: 1, inherit: 1, exclude_hv: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
      #

