Return-Path: <bpf+bounces-58339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFBAB8E03
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075A91890BE4
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13C9259C9F;
	Thu, 15 May 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJffKh/I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8A146593;
	Thu, 15 May 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330905; cv=none; b=OzJlIHHdbXCvtK7BedVx4GYEJIYQwEUScPbdZnsdyVYVcY4tqI8kst656NFdc5bQqZYoFImlAgVP9VvNpyXvT894yT+NnIpgO5rX4ZVvArv9zmOhrkQwlYtaRsnb2EpTptFLeY3Hivjgk4Bxi/9oHNIRzLZvM/Sa+LA1yREfJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330905; c=relaxed/simple;
	bh=NMVW3lg+1Kf/KNHgx8kW6B1tWctV1C5TPy8hNkSr3Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtndvLr8lPCEvLwXiTglVv2Kjk8YoP44NQSHxuaVfu8YlNuBMiqlS1wj7oFHB9LcybY2XUB2AzLEHQPtzLozD9Yi1tNGHbG4hpJ3AVomY14km8OPv6Um5qgrpSd7Hdbl02SENofM/jtlLf5kyrMuE5YMdfgvJZuERmwNhKgd3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJffKh/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929EEC4CEE7;
	Thu, 15 May 2025 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747330904;
	bh=NMVW3lg+1Kf/KNHgx8kW6B1tWctV1C5TPy8hNkSr3Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJffKh/IneLv502DYIDVWIMtn4VfBbGFIWZ28w10xdCXRWPM8zIvDLDQ30ZT+WKKZ
	 gf3tr3gn+nBwI1NogJuxqBIjgXGqfY3bSHAhqLW5nlJjHyOA8fTHG7H025Ld3DKd4O
	 M1/u0uJCdL7j6t3Sn8+Zm4mhK1kWBG+oW8TGchHAHtxnH/vZkUlxpI4LhIsSL/K+HA
	 ZsBqwfhRADcPFMuCVQ2B0cp+shcOTfWvaEm34fKFcc3UCymRcZKB0XyMZHzk6me3aR
	 q9NyxvW3tayLEp/qWO+CIVTvqJd8QV/oLDcNYCVqadkuQnSJZWzfMa6TTmgSA+yp9Y
	 QEOccDUKPLEOw==
Date: Thu, 15 May 2025 10:41:41 -0700
From: Kees Cook <kees@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <202505151039.DAA202A@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
 <202505150911.1254C695D@keescook>
 <20250515171821.6je7a4uvmttcdiia@desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515171821.6je7a4uvmttcdiia@desk>

On Thu, May 15, 2025 at 10:18:21AM -0700, Pawan Gupta wrote:
> On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> > On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > >There is an observable slowdown when running BPF selftests on 6.15-rc6
> > > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> > > [...]
> > > Where can I find the .config for the slow runs?
> > 
> > Oops, I can read. :) Doing a build now...
> > 
> > > And how do I run the test myself directly?
> > 
> > I found:
> > https://docs.kernel.org/bpf/bpf_devel_QA.html
> > 
> > But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> > tests, no info on building the test modules).
> > 
> > This seems to be needed:
> > 
> > make O=regression-bug -C tools/testing/selftests/bpf/test_kmods
> > 
> > But then the booted kernel doesn't load it (missing signatures?)
> > 
> > Anyway, I'll keep digging...
> 
> After struggling with this for a while, I figured vmtest.sh is the easiest
> way to test bpf:
> 
> ./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs

I can't even build the test_progs. :(

$ make test_progs
...
  CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy_from_user_task_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   98 |         ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0
);
      |               ^
1 error generated.


-- 
Kees Cook

