Return-Path: <bpf+bounces-60362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C03AD5E1D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5801E16B09D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEC23643F;
	Wed, 11 Jun 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX3gC0wi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB31C8632;
	Wed, 11 Jun 2025 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666569; cv=none; b=hzL8IK4JBi2hxAhKBscDQexcc+DDC0Hj6CpE3zckcfQToiJlSPeOSyAyLDjttdLQp5BM0fQ2wQrkVyFw1wEjvwH4Rb/kMWQu/k1OYANckfKZ8sIMrJSZKkyIHJmwkyuBhtoJQ+H0yQe9PJV0Ub7Ay4KHebuHpIk++Hgys0YBjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666569; c=relaxed/simple;
	bh=hlsAtbfYpRIThbtTRngh3/kZOTRE3e61UWfWc/gSwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTFnHMY0h9RdFqwWMkorKS/h6jsXsqKliHkyKiAzt8wstHx5FuzPpMcioMlzXeZ6blZ00fZtf1fJL+4C7KCwsyXjDTfUGI4ravyqz75ELZ6f8/x1S+dC/MV/AuCyboTSnkMlcMNCe/GA9gHfAasrHFPt86HH/IKLYRNu/FrWOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX3gC0wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7D8C4CEE3;
	Wed, 11 Jun 2025 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749666569;
	bh=hlsAtbfYpRIThbtTRngh3/kZOTRE3e61UWfWc/gSwJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nX3gC0wihj8Q19OWZEkEWH62UQz4+L+hAl5wIfmnD5HPmK7cKzrNQiz7z0519Wq0B
	 yAE+bLVWPCiwVg2WIFzGdMiPJ3vy0TXvN6PdkjjoBv2ROgrP1w9YQKYy/pEUVs41GF
	 nHrNo01IAS3hN8kWUnp6QoLmxyaMbKR05IFlzfdcxpYD5y3i2Kwe5ulu44evO8gpqZ
	 R0Nm426mhWO06ZIfUJ/srDoDoNHCuQ2ZhpLQsswx0ikTG6FzYXNHiItsv4GuUzoyk2
	 onr6t1gvSgZNd+wUnIt+ZT7l1zY1sVk27eLxpSb2LGTU9qH/NsgOzIyW+gIjGS6pEQ
	 zfv4+u0f5DtQA==
Date: Wed, 11 Jun 2025 11:29:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
Message-ID: <aEnLBgCTuuZjeakP@google.com>
References: <20250606215246.2419387-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250606215246.2419387-1-blakejones@google.com>

Hi Blake,

On Fri, Jun 06, 2025 at 02:52:41PM -0700, Blake Jones wrote:
> Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
> added support to the kernel, libbpf, and bpftool to treat read-only BPF
> variables that have names starting with 'bpf_metadata_' specially. This
> patch series updates perf to handle these variables similarly, allowing a
> perf.data file to capture relevant information about BPF programs on the
> system being profiled.
> 
> When it encounters a BPF program, it reads the program's maps to find an
> '.rodata' map with 'bpf_metadata_' variables. If it finds one, it extracts
> their values as strings, and creates a new PERF_RECORD_BPF_METADATA
> synthetic event using that data. It does this both for BPF programs that
> were loaded when a 'perf record' starts, as well as for programs that are
> loaded while the profile is running. For the latter case, it stores the
> metadata for the duration of the profile, and then dumps it at the end of
> the profile, where it's in a better context to do so.
> 
> The PERF_RECORD_BPF_METADATA event holds an array of key-value pairs, where
> the key is the variable name (minus the "bpf_metadata_" prefix) and the
> value is the variable's value, formatted as a string. There is one such
> event generated for each BPF subprogram. Generating it per subprogram
> rather than per program allows it to be correlated with PERF_RECORD_KSYMBOL
> events; the metadata event's "prog_name" is designed to be identical to the
> "name" field of a perf_record_ksymbol. This allows specific BPF metadata to
> be associated with each BPF address range in the collection.
> 
> Changes:
> 
> * v2 -> v3:
>   - Split out event collection from event display.
>   - Resync with tmp.perf-tools-next.
>   - Link to v2:
>     https://lore.kernel.org/linux-perf-users/20250605233934.1881839-1-blakejones@google.com/T/#t
> 
> * v1 -> v2:
>   - Split out libbpf change and send it to the bpf tree.
>   - Add feature detection to perf to detect the libbpf change.
>   - Allow the feature to be skipped if the libbpf support is not found.
>   - Add an example of a PERF_RECORD_BPF_METADATA record.
>   - Change calloc() calls to zalloc().
>   - Don't check for NULL before calling free().
>   - Update the perf_event header when it is created, rather than
>     storing the event size and updating it later.
>   - Add a BPF metadata variable (with the perf version) to all
>     perf BPF programs.
>   - Update the selftest to look for the new perf_version variable.
>   - Split out the selftest into its own patch.
>   - Link to v1:
>     https://lore.kernel.org/linux-perf-users/20250521222725.3895192-1-blakejones@google.com/T/#t
> 
> Blake Jones (5):
>   perf: detect support for libbpf's emit_strings option
>   perf: collect BPF metadata from existing BPF programs
>   perf: collect BPF metadata from new programs
>   perf: display the new PERF_RECORD_BPF_METADATA event
>   perf: add test for PERF_RECORD_BPF_METADATA collection

I tried to process your patches but it failed to build like below:

  util/bpf-event.h: In function 'bpf_metadata_free':
  util/bpf-event.h:68:59: error: unused parameter 'metadata' [-Werror=unused-parameter]
     68 | static inline void bpf_metadata_free(struct bpf_metadata *metadata)
        |                                      ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~

It was a simple to fix by adding __maybe_unused but after that I got
another build error so I stopped.

  /usr/bin/ld: /tmp/tmp.N9VJQ2A3pl/perf-in.o: in function `cmd_record':
  (.text+0x191ae): undefined reference to `perf_event__synthesize_final_bpf_metadata'
  collect2: error: ld returned 1 exit status
  make[4]: *** [Makefile.perf:804: /tmp/tmp.N9VJQ2A3pl/perf] Error 1
  make[4]: *** Waiting for unfinished jobs....
  make[3]: *** [Makefile.perf:290: sub-make] Error 2
  make[2]: *** [Makefile:76: all] Error 2
  make[1]: *** [tests/make:341: make_no_libbpf_O] Error 1
  make: *** [Makefile:109: build-test] Error 2

Please run 'make build-test' and send v4.

Thanks,
Namhyung

> 
>  tools/build/Makefile.feature                |   1 +
>  tools/build/feature/Makefile                |   4 +
>  tools/build/feature/test-libbpf-strings.c   |  10 +
>  tools/lib/perf/include/perf/event.h         |  18 +
>  tools/perf/Documentation/perf-check.txt     |   1 +
>  tools/perf/Makefile.config                  |  12 +
>  tools/perf/Makefile.perf                    |   3 +-
>  tools/perf/builtin-check.c                  |   1 +
>  tools/perf/builtin-inject.c                 |   1 +
>  tools/perf/builtin-record.c                 |   8 +
>  tools/perf/builtin-script.c                 |  15 +-
>  tools/perf/tests/shell/test_bpf_metadata.sh |  76 ++++
>  tools/perf/util/bpf-event.c                 | 378 ++++++++++++++++++++
>  tools/perf/util/bpf-event.h                 |  13 +
>  tools/perf/util/bpf_skel/perf_version.h     |  17 +
>  tools/perf/util/env.c                       |  19 +-
>  tools/perf/util/env.h                       |   4 +
>  tools/perf/util/event.c                     |  21 ++
>  tools/perf/util/event.h                     |   1 +
>  tools/perf/util/header.c                    |   1 +
>  tools/perf/util/session.c                   |   4 +
>  tools/perf/util/synthetic-events.h          |   2 +
>  tools/perf/util/tool.c                      |  14 +
>  tools/perf/util/tool.h                      |   3 +-
>  24 files changed, 622 insertions(+), 5 deletions(-)
>  create mode 100644 tools/build/feature/test-libbpf-strings.c
>  create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
>  create mode 100644 tools/perf/util/bpf_skel/perf_version.h
> 
> -- 
> 2.50.0.rc0.604.gd4ff7b7c86-goog
> 

