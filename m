Return-Path: <bpf+bounces-58346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7385AB8F09
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CFD1C01074
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C46263F4A;
	Thu, 15 May 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neWj93rj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448525D1F5;
	Thu, 15 May 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333461; cv=none; b=k5tF7PmBwiLorErD9rbCu5d5CccMKpDlKAgfscGsNjZ+q+vdRmBvVCM0AWqtLAoZU0eAOgL60lV/9eaOjpjxRq+ewMfuZ7msev1C/5hO28Q/CvDbfqclMS2dMClwjOnorjDxA5muoPG7+l90qacmkPkVRvus057TK6thfbzyvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333461; c=relaxed/simple;
	bh=cmyb4fslMdZMeqJjaLXvuCdgMLSOPj2eAW7zLDTyppQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHX4vv34ohxrd22hYuYe1jvNVpKjfY7k87a85jMgWlkSpmva3FLtbIHCPqLHEjQFsNMsyc+jTwRW86ABQGUSNUzYgU0OZbIwm5v9xbjuIYuPeUqKrDLFVcrRfIFvQHSQzpqic/ENpnXgdHgxX8B1btfWUOZkDMy7hvPWJCXFjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neWj93rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B14C19421;
	Thu, 15 May 2025 18:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333461;
	bh=cmyb4fslMdZMeqJjaLXvuCdgMLSOPj2eAW7zLDTyppQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neWj93rjpazFcs+AlCYfjTtrA68QwMLPbqCAGKLV83Bw/9G5mYV5YGBG8kPiQvR5C
	 aFWcZ6XPUcMrEPg2X9JdqcpVtlFnNDYbBWlCcWGkxStYHbhHq1I/otEkFgkY3AmctU
	 85ZK90t0e8tjsxybIkI4t3GZ+OVaaVzhPh3OJXIaZtDSlc1C+BlEyQK75SJ9mC/Mkl
	 lgrpMKpgThEPyZ6vixgMLEzrmfK2eFm/zKEwCjcdqmYE9+uMQnKqP+W05IihwVECmo
	 TtVo1zvSB4eTuLdk8yXgGrC0ycL/ncy2YcAJHAchPB9GwAuTQ3iHcu3Uyh9IIgZ5Lf
	 83L70jE8yVpWA==
Date: Thu, 15 May 2025 11:24:16 -0700
From: Kees Cook <kees@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
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
Message-ID: <202505151116.4FFA176B8@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
 <202505150911.1254C695D@keescook>
 <20250515171821.6je7a4uvmttcdiia@desk>
 <202505151039.DAA202A@keescook>
 <CAEf4Bzb4LZK5p08t1y-32wAFDGoRGKR1w1T_je6+a_EOE2uSYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb4LZK5p08t1y-32wAFDGoRGKR1w1T_je6+a_EOE2uSYQ@mail.gmail.com>

On Thu, May 15, 2025 at 10:53:10AM -0700, Andrii Nakryiko wrote:
> On Thu, May 15, 2025 at 10:41 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Thu, May 15, 2025 at 10:18:21AM -0700, Pawan Gupta wrote:
> > > On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> > > > On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > > > > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > > >There is an observable slowdown when running BPF selftests on 6.15-rc6
> > > > > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> > > > > [...]
> > > > > Where can I find the .config for the slow runs?
> > > >
> > > > Oops, I can read. :) Doing a build now...
> > > >
> > > > > And how do I run the test myself directly?
> > > >
> > > > I found:
> > > > https://docs.kernel.org/bpf/bpf_devel_QA.html
> > > >
> > > > But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> > > > tests, no info on building the test modules).
> > > >
> > > > This seems to be needed:
> > > >
> > > > make O=regression-bug -C tools/testing/selftests/bpf/test_kmods
> > > >
> > > > But then the booted kernel doesn't load it (missing signatures?)
> > > >
> > > > Anyway, I'll keep digging...
> > >
> > > After struggling with this for a while, I figured vmtest.sh is the easiest
> > > way to test bpf:
> > >
> > > ./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs
> >
> > I can't even build the test_progs. :(
> >
> > $ make test_progs
> > ...
> >   CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
> > progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy_from_user_task_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >    98 |         ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0
> > );
> >       |               ^
> > 1 error generated.
> >
> 
> BPF selftests expect that there was a successful kernel build done
> before that. So generally speaking:
> 
> 0) cd <linux/repo/path>
> 1) export O=/path/to/build
> 2) cat tools/testing/selftests/bpf/config >> /path/to/build/.config
> 3) make O=/path/to/build -j$(nproc) oldefconfig all
> 4) cd tools/testing/selftests/bpf # everything is built within this
> directory, we don't support KBUILD_PATH or O for BPF selftests build
> artifacts
> 5) make O=/path/to/build -j$(nproc)

Linux ToT fails to build, -next fails to build. v6.14.6 fails build,
each in different ways. :(

> But tbh, if the above causes you problems, I don't think you need to
> spend that much time trying to build BPF selftests, given you know
> what the issue is and you are fixing it.

Well, nothing I've proposed makes any sense as far as something that would
double execution time, so I don't really know what the issue is yet. :P

-- 
Kees Cook

