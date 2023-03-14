Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF56B91C2
	for <lists+bpf@lfdr.de>; Tue, 14 Mar 2023 12:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCNLgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCNLgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 07:36:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9E6C190;
        Tue, 14 Mar 2023 04:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58814CE1255;
        Tue, 14 Mar 2023 11:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B2DC433D2;
        Tue, 14 Mar 2023 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678793805;
        bh=M2mHWXPIMyf36MInMAIEfhAMF3K+r+4D7kKbwFHmcO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pP5u788v3vDSAO/CLRqHe+jfwegEH9r6eNPHqQueUe+BdRnXqOX5zo1Zu/N446DrJ
         7b63WXBd9gjM7UTexiTtPtMSraI6e+q7h5u2kNTz3XyGs4XGrGGwKfJqd7JCY6c0bQ
         0FHuWnFwxT456dDk5HddqBPqD5btMNl45QLdjLW4fSnk5c/K7x4QYSFRNlpETlCiMO
         37XdvNQ+MLxPLNzX3vG26Z69FLfTN3Y72+kpnW/w3MvWVsV0XYhm9BCMReaCl6kje9
         oDV26J1AZzpL53+Ku2cTzSgWYNaWP0XOY3XCThgnmu5TT3UOV3RKMuDW2sDp2YhkfI
         /cQCAnEWiMkOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 486144049F; Tue, 14 Mar 2023 08:36:42 -0300 (-03)
Date:   Tue, 14 Mar 2023 08:36:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf build: Remove libbpf pre-1.0 feature tests
Message-ID: <ZBBcSiggg0RgM0HB@kernel.org>
References: <20230116010115.490713-1-irogers@google.com>
 <20230116010115.490713-3-irogers@google.com>
 <ZA+RUCE4vAgBlQRh@kernel.org>
 <ZA+X14KllWXrlr7C@kernel.org>
 <CAP-5=fWFYVyCCH19XrFSk0hwPoxGkWKJ=vyjrWNroFWzBZ-S2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWFYVyCCH19XrFSk0hwPoxGkWKJ=vyjrWNroFWzBZ-S2A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 05:19:45PM -0700, Ian Rogers escreveu:
> On Mon, Mar 13, 2023 at 2:38 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Mar 13, 2023 at 06:10:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Sun, Jan 15, 2023 at 05:01:14PM -0800, Ian Rogers escreveu:
> > > > The feature tests were necessary for libbpf pre-1.0, but as the libbpf
> > > > implies at least 1.0 we can remove these now.
> > >
> > > So I added this:
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 8b0bd3aa018ef166..b715cd4f43f4a014 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -580,7 +580,7 @@ ifndef NO_LIBELF
> > >            EXTLIBS += -lbpf
> > >            $(call detected,CONFIG_LIBBPF_DYNAMIC)
> > >          else
> > > -          dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
> > > +          dummy := $(error Error: No libbpf devel library found or older than v1.0, please install/update libbpf-devel);
> > >          endif
> > >        else
> > >          # Libbpf will be built as a static library from tools/lib/bpf.
> > >
> > > To better reflect the failure reason:
> > >
> > > ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-libbpf.make.output
> > > test-libbpf.c:5:2: error: #error At least libbpf 1.0 is required for Linux tools.
> > >     5 | #error At least libbpf 1.0 is required for Linux tools.
> > >       |  ^~~~~
> > > ⬢[acme@toolbox perf-tools-next]$ rpm -q libbpf-devel
> > > libbpf-devel-0.8.0-2.fc37.x86_64
> > > ⬢[acme@toolbox perf-tools-next]$
> > >
> > > I'll see if I can make the build test conditional on libbpf being >= 1.0
> >
> > I'm trying with this:
> >
> > ⬢[acme@toolbox libbpf]$ git log --oneline -1 9476dce6fe905a6bf1d4c483f7b2b8575c4ffb2d
> > 9476dce6fe905a6b libbpf: remove deprecated low-level APIs
> > ⬢[acme@toolbox libbpf]$ git tag --contains 9476dce6fe905a6bf1d4c483f7b2b8575c4ffb2d
> > v1.0.0
> > v1.0.1
> > v1.1.0
> > ⬢[acme@toolbox libbpf]$
> >
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 531324c3dab594e1..f866c58b916f4d7a 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -63,6 +63,7 @@ endif
> >
> >  has = $(shell which $1 2>/dev/null)
> >  python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{print $$3}')
> > +old_libbpf := $(shell grep -q LIBBPF_DEPRECATED /usr/include/bpf/bpf.h)
> 
> I think this could also be:
> old_libbpf := $(shell grep MAJOR /usr/include/bpf/libbpf_version.h
> 2>&1 |grep -q  0)
> Which may be a bit more intention revealing and future proof.

Thanks, I used:

old_libbpf := $(shell echo "#include <bpf/libbpf.h>" | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")

- Arnaldo
