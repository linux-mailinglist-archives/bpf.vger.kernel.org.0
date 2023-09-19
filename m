Return-Path: <bpf+bounces-10388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508A7A649C
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 15:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E057281A90
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F130FA6;
	Tue, 19 Sep 2023 13:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430F37CB6;
	Tue, 19 Sep 2023 13:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738B3C433C8;
	Tue, 19 Sep 2023 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695129402;
	bh=Tgx947AMX984xnlu4hGkPuGi+cgC/mGGmoaAgMZ9kF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoNVqpVQs/KdLWOrd11QjiNg3qHmz+zOP7mH9PZruHvJCBC65jY8f25Y8XdI7SB2j
	 J33K++/dgnu/J+4jCKcqQz1Tbv9RTE0KdbXHaklBl3g/GydG3MjDlbgXp2IP80jyUe
	 XAaybnL0twZ/IHlgZAXlruZJ6uXFrZtBstrYR1X4/uK39hFpbVRzh7ygJWqiEWgRW6
	 CzO3PJuI0JfonjDC5pPaJ9v8a8jmhAYjn0KxuwVAtbyPDek3uSAhl3FRrSdOf7Rypn
	 MdloMtXODd4nYcT6QAD+pb+TFqL42J6QYZEe+ZUJwiNuNCKYSo0GORdXQ0fPzsaknh
	 02fhScU/Brbuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2AEC0406D9; Tue, 19 Sep 2023 15:16:40 +0200 (CEST)
Date: Tue, 19 Sep 2023 15:16:40 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Patrice Duroux <patrice.duroux@gmail.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/5] Enable BPF skeletons by default
Message-ID: <ZQmfOO0tt9FuIkrj@kernel.org>
References: <20230914211948.814999-1-irogers@google.com>
 <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgNbRs3LJh_AjqAnRkJzsTxrGr_yqVK-urtoS-B2k1S=w@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Sep 18, 2023 at 04:40:15PM -0700, Namhyung Kim escreveu:
> On Thu, Sep 14, 2023 at 2:20 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Enable BPF skeletons by default but warn don't fail if they can't be
> > supported. This was the intended behavior for Linux 6.4 but it caused
> > an issue captured in this thread:
> > https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/
> >
> > This issue isn't repeated here as the previous issue related to
> > generating vmlinux.h, which is no longer performed by default as a
> > checked-in vmlinux.h is used instead.
> >
> > Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
> > to 0 disables BPF skeletons. Also, rather than fail the build due to a
> > missed dependency, dependencies are checked and BPF skeletons disabled
> > if they aren't present.
> >
> > Some related commits:
> > b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
> > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> > a2af0f6b8ef7 perf build: Add system include paths to BPF builds
> > 5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
> > 9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
> > a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
> > 1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
> > a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL
> >
> > Ian Rogers (5):
> >   perf version: Add status of bpf skeletons
> >   perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> >   perf test: Update build test for changed BPF skeleton defaults
> >   perf test: Ensure EXTRA_TESTS is covered in build test
> >   perf test: Detect off-cpu support from build options
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Is this verbose by default now? Maybe its something on my side, but I
noticed a higher level of verbosity, can you check?

- Arnaldo

