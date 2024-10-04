Return-Path: <bpf+bounces-41020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BE991102
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081B2283C7B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B51ADFF9;
	Fri,  4 Oct 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A43qql4i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57115D1;
	Fri,  4 Oct 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075528; cv=none; b=eFofov1Cfr2HbzCK0Mdzj+ce7o+IoyEZCkQgYPiDNZPN/Zt6HHOgzgPwHS4s/gFUDsTkQlFi4+gKe7FOLrnYAdB4qq5o1FUC5Mq2wSncFuwN6FHbDrm/xTQ5Rw/MlG+oi3zKDbVZqiJCW7x+6UyKUsr6+3AUVeqdFirIl2sHXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075528; c=relaxed/simple;
	bh=+SIPTlY4Ra+gh5qZ6f682gM6s7Hbk87xrrHjMIEAzfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKmTlBKJzFMAnpPmqMvWmfy/FnI1+JEj2iK805TuNrtgky1I0GdVZCTSenTtSg1V4hfgqNHN0CUfHF+WLKQc3ZKGq+GNekBdXamPGT4y+Qpdu5qjpu+uYOhRVU/d18ukJULRKPgtIl/iVgriWuH0P0A2Q3crqtbjKX/yS/1kqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A43qql4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4924AC4CEC6;
	Fri,  4 Oct 2024 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728075527;
	bh=+SIPTlY4Ra+gh5qZ6f682gM6s7Hbk87xrrHjMIEAzfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A43qql4iUb8VJO15k3zF4RjhRHojEQedzwFl4zMMf6wPodm5F7wX2SejUQqDaemi3
	 Mmd9m3CIVR4JqxB7jSlt66bpO7k2XpjE+gbU9eJmlYSGrMma8J4yPS3Qyskznshtzi
	 BQ6UuHACIJZNqqtbvtUJm5LQvsb1QH4bngDdpSYpkBE+AGZuWySyx4mvwGxqxkf3lO
	 xqC/Eop0ZPFT0wcf7Ye1vqOEuRN8KVFXmReZ0XhvZSHoJ6TuzxR2aN+rxS1H2un5yl
	 KpA+bZdmqw915m7Q4ObWveA/i8YSTU/4w5c34slzDI4ZMF/nscTSfGkuikXTWCDhxo
	 kXTHK9YCQGhpw==
Date: Fri, 4 Oct 2024 17:58:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
Message-ID: <ZwBXA6VCcyF-0aPb@x1>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004172631.629870-1-stephen.s.brennan@oracle.com>

On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
> Hi all,
> 
> This is v4 of the series which adds global variables to pahole's generated BTF.
> 
> Since v3:
> 
> 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
> 2. Consistently start shndx loops at 1, and use size_t.
> 3. Since patch 1 of v3 was already applied, I dropped it out of this series.
> 
> v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.brennan@oracle.com/
> v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/
> v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/
> 
> Thanks everyone for your review, tests, and consideration!

Looks ok, I run the existing regression tests:

acme@x1:~/git/pahole$ tests/tests 
  1: Validation of BTF encoding of functions; this may take some time: Ok
  2: Pretty printing of files using DWARF type information: Ok
  3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
/home/acme/git/pahole
acme@x1:~/git/pahole$

And now I'm building a kernel with clang + Thin LTO + Rust enabled in
the kernel to test other fixes I have merged and doing that with your
patch series.

Its all in the next branch and will move to master later today or
tomorrow when I finish the clang+LTO+Rust tests.

- Arnaldo

> Stephen
> 
> Stephen Brennan (4):
>   btf_encoder: stop indexing symbols for VARs
>   btf_encoder: explicitly check addr/size for u32 overflow
>   btf_encoder: allow encoding VARs from many sections
>   pahole: add global_var BTF feature
> 
>  btf_encoder.c      | 340 +++++++++++++++++++++------------------------
>  btf_encoder.h      |   1 +
>  dwarves.h          |   1 +
>  man-pages/pahole.1 |   7 +-
>  pahole.c           |   3 +-
>  5 files changed, 167 insertions(+), 185 deletions(-)
> 
> -- 
> 2.43.5

