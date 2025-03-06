Return-Path: <bpf+bounces-53508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F1A5587B
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4826C1711CE
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A698D214A61;
	Thu,  6 Mar 2025 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HivyfPwt"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1821FFC47
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295677; cv=none; b=Qi1nEmid0E/oH8Baph4pMptHD7P9YgJskDQLWnIisxpwaqJqupWZ9Iz9xTFtyiNnWJxDRbYVkjLFkG23VzrVK9BuN+40WVBPlDc3D6udTy/4kvallnBnVLignY5EKPO5qHWAapmvbQQGpoS5wxEjg6Hy90hMoLPQIS+wtt9VG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295677; c=relaxed/simple;
	bh=Do9Yp6MWB2tMvG8iBKw9cCoG4aVdb76Gf+FNGCoqU00=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=okU/KtGHpPWzUSntAW7b8yZdWmPkF/onqRvBTxryH3j6mQ3zxiyiIn59GAZMYCxrPFSCGRDWX/wW/aZGB/MNXC6Pa3B5E2WNV39PRXwGkbfGGof4T1cXKGDlyBa1M0JqDmpdgmS3KqQsABSdSL1YX2W0+QXJZBtfakHYPupiWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HivyfPwt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741295673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovbZ6e9rkSA5FpW7VkCHel1WZ9KrE9pO07uaPpAtzb8=;
	b=HivyfPwtMTopzQt6E4TNOg4DQm3TOYpUxOGV9yZpE6iCetie8K5ePDdXyd2XQDEJh50XYd
	qCv6FcXPpfeD2pJKh2+rizx6sOHkZAqtN5XowpUm0EWV/dwZzGCOrHM8X7veDPQln3MPGr
	M4VQojvnP4MyBasPkT/LH3ynClQ49JQ=
Date: Thu, 06 Mar 2025 21:14:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <a469919eb5be205dc9c44ee40566ea1ae2bbc757@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves 0/2] dwarves: Introduce github actions for CI
To: "Alan Maguire" <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, song@kernel.org,
 eddyz87@gmail.com, olsajiri@gmail.com, "Alan Maguire"
 <alan.maguire@oracle.com>
In-Reply-To: <20250306170455.2957229-1-alan.maguire@oracle.com>
References: <20250306170455.2957229-1-alan.maguire@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 3/6/25 9:04 AM, Alan Maguire wrote:
> libbpf and bpf kernel patch infrastructure have made great use
> of github actions to provide continuous integration (CI) testing.
> Here the libbpf CI is adapted to build pahole and run the associated
> selftests.  Examples of what the action workflows look like are
> at [1] and [2].
>
> Details about the workflows can be found in patch 1.
>
> Patch 2 fixes an issue exposed by the dwarves-build workflow -
> a compilation error when building dwarves with clang.
>
>
> [1] https://github.com/alan-maguire/dwarves/actions/runs/13588880188
> [2] https://github.com/alan-maguire/dwarves/actions/runs/13588880200

Hi Alan. This is great! Glad to see you're working on it.

I haven't read through the changes yet, but I already see that most of
the CI code was copied from libbpf. Just want to note that you might
not want to reproduce all the workflows from there in dwarves. And
also there are inconveniences with local actions and ci/managers
etc. I think it's worth it to try and eliminate as much of that code
as possible, given you're starting from a blank slate.

If you haven't done so already, you might want to check out "pahole
staging" job that I tried on BPF CI infrastructure some time ago:
https://github.com/kernel-patches/vmtest/pull/330/files

It's a bit different from libbpf, as it reuses BPF CI workflows. But
you might get some ideas there about simplifying dwarves CI.

Another question is: are you sure about merging CI code upstream? Both
for libbpf and kernel-patches/bpf the CI code lives independently of
upstream and is synced from time to time on github. My guess is, it's
because .github code is unlikely to get merged into the main Linux
tree (which also makes sense).

>
> Alan Maguire (2):
>   dwarves: Add github actions to build, test
>   dwarves: Fix clang warning about unused variable
>
>  .github/actions/debian/action.yml | 16 ++++++
>  .github/actions/setup/action.yml  | 23 ++++++++
>  .github/workflows/build.yml       | 37 ++++++++++++
>  .github/workflows/codeql.yml      | 53 +++++++++++++++++
>  .github/workflows/coverity.yml    | 33 +++++++++++
>  .github/workflows/lint.yml        | 20 +++++++
>  .github/workflows/ondemand.yml    | 31 ++++++++++
>  .github/workflows/test.yml        | 36 ++++++++++++
>  .github/workflows/vmtest.yml      | 94 +++++++++++++++++++++++++++++++
>  ci/managers/debian.sh             | 88 +++++++++++++++++++++++++++++
>  ci/managers/travis_wait.bash      | 61 ++++++++++++++++++++
>  dwarves_fprintf.c                 |  2 +-
>  12 files changed, 493 insertions(+), 1 deletion(-)
>  create mode 100644 .github/actions/debian/action.yml
>  create mode 100644 .github/actions/setup/action.yml
>  create mode 100644 .github/workflows/build.yml
>  create mode 100644 .github/workflows/codeql.yml
>  create mode 100644 .github/workflows/coverity.yml
>  create mode 100644 .github/workflows/lint.yml
>  create mode 100644 .github/workflows/ondemand.yml
>  create mode 100644 .github/workflows/test.yml
>  create mode 100644 .github/workflows/vmtest.yml
>  create mode 100755 ci/managers/debian.sh
>  create mode 100644 ci/managers/travis_wait.bash
>

