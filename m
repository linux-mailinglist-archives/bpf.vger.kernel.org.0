Return-Path: <bpf+bounces-69852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED3BA4752
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444287B5D73
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B26D21A95D;
	Fri, 26 Sep 2025 15:41:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B135966;
	Fri, 26 Sep 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901302; cv=none; b=uQdqf9A51ke8lYJuEM36zeQdG11cYFR7ZnrWqnk+JhZ0Oi3XQs7Ok3qNtZByBBV9wd1SM7PHyci8TRL+dBeGrnxjedZwXLoPWgV+RFt/JQ6SW0D5EOzkN9tBUfiSNMQE2+ahr8teSk8rFrnuK1SptXZfSsXV2mpiM9z9q26sxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901302; c=relaxed/simple;
	bh=8kE59LS+3I081Ra628/WHl3xrBDQHSFblc54GpQcwys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8av4cPiZFGyU6wMgruioT1P/vLySMNJPD9fgw1QwQa7/a4rHYSnYklCqjd20e12KHH3gLuocva1RCj9Z+5RjWop9h3c1KZi+0aIG21Q5mVu+JCXDrQFl8UPVkv/79kOLD7gYE+z1/UQvUwX8jDW222XRk6KJ6QCNF6dQ0AUuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14DAC168F;
	Fri, 26 Sep 2025 08:41:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0E863F66E;
	Fri, 26 Sep 2025 08:41:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:41:37 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 8/8] perf docs: Document building with Clang
Message-ID: <20250926154137.GF7985@e132581.arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
 <20250925-perf_build_android_ndk-v1-8-8b35aadde3dc@arm.com>
 <CAP-5=fV45npmMUVGakzpB0XDMJ+WudiHoanBXzJtrX2442k-YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV45npmMUVGakzpB0XDMJ+WudiHoanBXzJtrX2442k-YA@mail.gmail.com>

Hi Ian,

On Thu, Sep 25, 2025 at 12:43:55PM -0700, Ian Rogers wrote:

[...]

> > +5) Build with clang
> > +===================
> > +By default, the makefile uses GCC as compiler. With specifying environment
> > +variables HOSTCC, CC and CXX, it allows to build perf with clang.
> > +
> > +Using clang for native build:
> > +
> > +  $ HOSTCC=clang CC=clang CXX=clang++ make -C tools/perf
> > +
> > +Using clang for cross compilation:
> > +
> > +  $ HOSTCC=clang CC=clang CXX=clang++ \
> > +    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf \
> > +    NO_LIBELF=1 NO_LIBTRACEEVENT=1 NO_JEVENTS=1
> 
> The three NO_-s here are going to cripple the build quite a lot, I
> wonder if we can list package dependencies to install and failing that
> use the NO_-s.

In the next version, I will drop NO_ options to avoid confusing.

Missing libraries can occur in both native build and cross build, so
this is not a specific issue for cross build. OTOH, the build logs
already provide clear reminders, here no need to bother readers for
these NO_ options.

> > +
> > +In the example above, due to lack libelf, python and libtraceevent for
> > +cross comiplation, disable the features accordingly.
> 
> nit: s/comiplation/compilation/
> 
> > diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Documentation/android.txt
> > index 24a59998fc91e814ad96f658d3481d88d798b60c..e65204cf2921f6bd8a79875784c5b3d5487ce05d 100644
> > --- a/tools/perf/Documentation/android.txt
> > +++ b/tools/perf/Documentation/android.txt
> > @@ -1,78 +1,12 @@
> >  How to compile perf for Android
> > -=========================================
> > +===============================
> >
> > -I. Set the Android NDK environment
> > -------------------------------------------------
> > +There have two ways to build perf and run it on Android.
> 
> nit: s/There have/There are/

Will do.  Thanks a lot for review!

Leo

