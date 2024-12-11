Return-Path: <bpf+bounces-46666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E168D9ED735
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D75167A28
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C758120C030;
	Wed, 11 Dec 2024 20:26:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8D1C4A36;
	Wed, 11 Dec 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948801; cv=none; b=SWSEDPjyyQP2BjMwY7EKUwRptl0ZzSquo/U3twWuCyXBNw/h6WM1+g5/kNzEkq/c0omnlP5toG+CNTUyzUYi0h8j2iIs5JAFP4nd9OdRTjp2k5Sj3VhpQ45V7AOAaHu4uCM2Vr/lly6D/VWiVanDMfcU0mJBG3c2PJDYuATmDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948801; c=relaxed/simple;
	bh=SIpF4uhuTecqxWTELI9e+fB5dAfCaf88LicXJ2ILHzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB0MEf4FJilWWKp3qxF3Of1brNBlOSO/m3+x6fqoeWUnt1Arz/K49dVcZ4eHYGsY9+QzDkH/ep/2y3mMgi05CX9sAJJQ3kdJgOj3VsdeU18fYXerlmZJmzLs3vZMV9jVXBhpPZhoOfTqJXalCXDn/kxr6lFIqKRDsAEiubZ2Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6054E1007;
	Wed, 11 Dec 2024 12:27:05 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D49AD3F5A1;
	Wed, 11 Dec 2024 12:26:36 -0800 (PST)
Date: Wed, 11 Dec 2024 20:26:30 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Nick Terrell <terrelln@fb.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/3] bpftool: Fix the static linkage failure
Message-ID: <20241211202630.GA3169297@e132581.arm.com>
References: <20241211093114.263742-1-leo.yan@arm.com>
 <Z1mREhJElE6cSrPT@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1mREhJElE6cSrPT@x1>

On Wed, Dec 11, 2024 at 10:18:10AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 11, 2024 at 09:31:11AM +0000, Leo Yan wrote:
> > This series follows up on the discussion in [1] for fixing the static
> > linkage issue in bpftool.
> >
> > Patch 01 introduces a new feature for libelf-zstd.  If this feature
> > is detected, it means the zstd lib is required by libelf.
> >
> > Patch 02 is a minor improvement for linking the zstd lib in the perf.
> >
> > Patch 03 fixes the static build failure by linking the zstd lib when
> > the feature-libelf-zstd is detected.
>
> So, this was originally reported as a perf build failure when trying a
> static build, so something not so common, no urgency, I guess, but it
> involves a tools/perf/bpftool/Makefile change, I think I can process
> this as I'll then test it in the many build containers for old distros I
> have, ok?

As Quentin said in another reply, there is a delta change between the
Linux perf tree and bpf-next tree.  So this series has a conflict on
bpf-next tree but it can be applied cleanly on perf tree.

Before I respin to update the commit logs based on comments, I need BPF
maintainers agreement with Arnaldo on proceeding on which source tree
to proceed with.

Thanks,
Leo

