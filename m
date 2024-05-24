Return-Path: <bpf+bounces-30519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD118CE94D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60FFB214A0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2B39FD0;
	Fri, 24 May 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie3ViNa4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9680374DD;
	Fri, 24 May 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716573487; cv=none; b=I/a1IvEphUrqNg2TASjgIClKmsn9FtJw7jzqvsoUJaQ1RI59y1E9hGxH8HA3gfcF8RrVfuKmfwrAV+fHV/6pMFkrEkYdmkpDYUpydmWBUcfdoAvmHjo8K+I6aW0+XjxQKYkhif7GvOHGhvP+B5m3+OIrcbRUOexapMlBI34m3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716573487; c=relaxed/simple;
	bh=HCXERw4pdnyMzF91TcKDft8+ZQRzC4QNfKVaaHOPAWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJUpNNyeEaMvyCNoAYBD7hrasWJWIaZCYQZgCuliEupXB69QhnpvFO7r23EZZCWYDDc8cbrMRhHxm0n3bA1LqBD1H7r7bwJJMCea5Lgqb+9D86jmuQkK+/Ou0R0JfBK2nG0kKpVtHWAeBdk1EVqDRGcHQdG4z9WYJFK1P3YP7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie3ViNa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0E0C2BBFC;
	Fri, 24 May 2024 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716573486;
	bh=HCXERw4pdnyMzF91TcKDft8+ZQRzC4QNfKVaaHOPAWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ie3ViNa4P79QdvdC7wgE9jttccQ+QDyCHJPuf0AGgFHTLp+nnTlLqOeTHIy+hCtlE
	 qOGr7wpsb9iQ82vNRTgSUaXO+H9jLosH4i96Yyj1CQzWVhltjrPw2SZ1FngzATJZjE
	 sY6/EzZduSt/vCG2wcPsD3TnV6BTGIeCGbCnav8Vr22wgi5aos+g3dfPsn1TfxR+w8
	 x0hfruxD27vQY2XutYwyUHDfEWAinkX0323lgz8/Y8m4p55fgQ/AcznYsxHwDXBCmv
	 UVbP2qoqHXauLGsAP21fP+skBky5EmTEkFCJ3oQF9ES0ewzq1Edlfmt/BSpJaDMiF4
	 C/WhQBUeZVqig==
Date: Fri, 24 May 2024 10:58:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
Message-ID: <ZlDVLBQ84O7fN9K4@google.com>
References: <20240521010439.321264-1-irogers@google.com>
 <CAM9d7cibAi-Xnr5HTCT6HB0sat=w5qicDrr+pcMuUF0OfNQRPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cibAi-Xnr5HTCT6HB0sat=w5qicDrr+pcMuUF0OfNQRPQ@mail.gmail.com>

On Wed, May 22, 2024 at 09:38:57PM -0700, Namhyung Kim wrote:
> On Mon, May 20, 2024 at 6:04 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Allow uid and gid to be terms in BPF filters by first breaking the
> > connection between filter terms and PERF_SAMPLE_xx values. Calculate
> > the uid and gid using the bpf_get_current_uid_gid helper, rather than
> > from a value in the sample. Allow filters to be passed to perf top, this allows:
> >
> > $ perf top -e cycles:P --filter "uid == $(id -u)"
> >
> > to work as a "perf top -u" workaround, as "perf top -u" usually fails
> > due to processes/threads terminating between the /proc scan and the
> > perf_event_open.
> >
> > v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
> >     using a shift as requested by Namhyung.
> >
> > Ian Rogers (3):
> >   perf bpf filter: Give terms their own enum
> >   perf bpf filter: Add uid and gid terms
> >   perf top: Allow filters on events

Hmm.. I'm seeing this.

  $ make build-test
  ...
  cd . && make GEN_VMLINUX_H=1 FEATURES_DUMP=/home/namhyung/project/linux/tools/perf/BUILD_TEST_FEATURE_DUMP -j64 O=/tmp/tmp.EeXFOfLPt5 DESTDIR=/tmp/tmp.Y0eiZKvc9D
  ...
    CLANG   /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/sample_filter.bpf.o            
  In file included from util/bpf_skel/sample_filter.bpf.c:8:                      
  In file included from util/bpf_skel/sample-filter.h:4:                          
  /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:29:6: error: redefinition of 'perf_type_id'
  enum perf_type_id {                                                             
       ^                                                                          
  /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54086:6: note: previous definition is here
  enum perf_type_id {                                                             
       ^                                                                          
  In file included from util/bpf_skel/sample_filter.bpf.c:8:                      
  In file included from util/bpf_skel/sample-filter.h:4:                          
  /home/namhyung/project/linux/tools/include/uapi/linux/perf_event.h:30:2: error: redefinition of enumerator 'PERF_TYPE_HARDWARE'
          PERF_TYPE_HARDWARE                      = 0,                            
          ^                                                                       
  /tmp/tmp.EeXFOfLPt5/util/bpf_skel/.tmp/../vmlinux.h:54087:2: note: previous definition is here
          PERF_TYPE_HARDWARE = 0,                                                 
          ^
  ...
  make[3]: *** [Makefile.perf:264: sub-make] Error 2                              
  make[2]: *** [Makefile:70: all] Error 2                                         
  make[1]: *** [tests/make:340: make_gen_vmlinux_h_O] Error 1                     
  make: *** [Makefile:103: build-test] Error 2

Thanks,
Namhyung


