Return-Path: <bpf+bounces-64454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2508B12CFD
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 00:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D392D7AE668
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF07218ACC;
	Sat, 26 Jul 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyu7HE4m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F8262BE;
	Sat, 26 Jul 2025 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569413; cv=none; b=lwUaEVMkBBKce4bCedjM3w7aiOeOA6/TlwUA1xlnJqnEuH4kdOvzhuOUDOuIoYUhwg9muPkmUKkqUbwagY2IKyg5h9m8lJrXYvK+vlFvdabCFls2WTNco5m9+hN6gV2qm/uYYE0GQIyF50n7tOpXMBsE7PeuIBkzvdB2LnM4U4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569413; c=relaxed/simple;
	bh=OiJftdl5ztiM1/XWQYd8Bk+NcmMFqEdRaWhAfk7h8lU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XRcQmZDWYTAnpMtYBsuic1lz5+56GpSJuYsdnyMUYnfO+rpRvjdueVo2c/HWFqV3wt0neDkSQG4ntta7k2Cv0a1VAEqvxFospAh6quYw9s+RWZd/zTJLgOhDoz++v3ZC/B/kPfqvcYlhPTUViL8hNbMGLOBqrkuJctBsQX/UOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyu7HE4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06401C4CEED;
	Sat, 26 Jul 2025 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753569412;
	bh=OiJftdl5ztiM1/XWQYd8Bk+NcmMFqEdRaWhAfk7h8lU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nyu7HE4mJueadmEZRMHJZEgcLNsahhcrMme/HUipEKM7hM7DEP0RMa1q0FAEdM0p9
	 C8oOzjBdXAbesBaLe6nnEHQe2oUAnbDkwl8aS2jhOJJ3lFGapdXSunm3LmI2eSwQaT
	 mq3l4D2s+8Krmw2IhyFzaxdlWJ0GrzMPL4dLccXIU3YLu6z4wkLmgjX5IPg4LggKnd
	 +YT0c6AjhM7uUs8mtdmnPoSYFysEyUBbcdsFI73Bn3Bmrsdeubbd3gQoGHrYG8KGLV
	 M3k0zvUajtY5qsrdUTI0Buej/PrXFIUDZM+OAX/UorUW+SJh9zTl7ABxx+hUBiVIlo
	 uhFX+bg+Zp8EQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Blake Jones <blakejones@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Collin Funk <collin.funk1@gmail.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20250726004023.3466563-1-blakejones@google.com>
References: <20250726004023.3466563-1-blakejones@google.com>
Subject: Re: [PATCH] Fix comment ordering.
Message-Id: <175356941196.2081367.16703727987372724704.b4-ty@kernel.org>
Date: Sat, 26 Jul 2025 15:36:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 25 Jul 2025 17:40:23 -0700, Blake Jones wrote:
> Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
> BPF metadata collection") overlooked a behavior of "perf test list",
> causing it to print "SPDX-License-Identifier: GPL-2.0" as a description for
> that test. This reorders the comments to fix that issue.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



