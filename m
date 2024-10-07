Return-Path: <bpf+bounces-41155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0569936F0
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D2283739
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E01DE3A6;
	Mon,  7 Oct 2024 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5FuXz2s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8E1DE2C8;
	Mon,  7 Oct 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327608; cv=none; b=iChbi9PrHYDq7w6Kmd/RzycquHWaK8CbmePqiynhJx/QOoVtoSU0vPSRQLjckMYSV7+Cs+SYRbSsuxvFGT+TKEVR5Id6qHc9Gl58Kd7zMCaoLZp3WkKQIJ8K1lrPR8lIoGm2HcYGmXsby+/JwCVWnMGwivbY7D6VWqIDKu7PkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327608; c=relaxed/simple;
	bh=3/+Dc3JCshOzmtLuDamHFk3TAvQehUqMY+CpcMOGIjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMbOqTA5PZ0JHFRRPjjsdDbQBUWuUohJwKjFRvtXVwzExYcCmUPt3CZEqmFt1VwIukrCxF/xwiEOYrxmFOPyJO1NtMCwuOa8HbKdesOQIGl6CjRrkwhbSunRllhdMgk+WR1JuRb2NjGGsdUBx4tGQD1PuOsEbaZmeVNBGk6KmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5FuXz2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B59C4CEC6;
	Mon,  7 Oct 2024 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728327608;
	bh=3/+Dc3JCshOzmtLuDamHFk3TAvQehUqMY+CpcMOGIjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5FuXz2s8eJ64yorJ3/jMx+20pgBZuZeBGYweN1UCbI+rQtnfFXbwirG41DK5A51O
	 MKIcIUwxBH6szg+WbZVK69YEpj5SxvMC8PqHcc3f80/APZi6p/z9PUDIXlqLtRQoe3
	 8zzShqjyzBOSWCQkrEGhTNkYGUQLE0jtZVbFe/5zFFJHnlkPwxeONIDtqHC0r0Cijk
	 pNOHWPguw0Aeg+QtIgSIP0L9sBlQ9846K3nN56Oq7ni5aRijpZ4eFcwQtdBw6O8bPQ
	 EEW0OwaSs/P+iv3hvq/szOCgo7doxO6wElu9c2VAzMjsy4RSP7G8KG5phEccXaChhe
	 TJRH/D6eVtkpg==
Date: Mon, 7 Oct 2024 16:00:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves v4 0/4] Emit global variables in BTF
Message-ID: <ZwQvtCJN5idM92z_@x1>
References: <20241004172631.629870-1-stephen.s.brennan@oracle.com>
 <ZwBXA6VCcyF-0aPb@x1>
 <CAEf4Bza3cnyef1VAcGkmP02dBMU_fp=52aS9LknOWhN855-PPQ@mail.gmail.com>
 <87o73vltce.fsf@oracle.com>
 <ZwQs8K7VUrITuUtO@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwQs8K7VUrITuUtO@x1>

On Mon, Oct 07, 2024 at 03:48:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 07, 2024 at 10:24:01AM -0700, Stephen Brennan wrote:
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> > > On Fri, Oct 4, 2024 at 2:21 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >>
> > >> On Fri, Oct 04, 2024 at 10:26:24AM -0700, Stephen Brennan wrote:
> > >> > Hi all,
> > >> >
> > >> > This is v4 of the series which adds global variables to pahole's generated BTF.
> > >> >
> > >> > Since v3:
> > >> >
> > >> > 1. Gathered Alan's Reviewed-by + Tested-by, and Jiri's Acked-by.
> > >> > 2. Consistently start shndx loops at 1, and use size_t.
> > >> > 3. Since patch 1 of v3 was already applied, I dropped it out of this series.
> > >> >
> > >> > v3: https://lore.kernel.org/dwarves/20241002235253.487251-1-stephen.s.brennan@oracle.com/
> > >> > v2: https://lore.kernel.org/dwarves/20240920081903.13473-1-stephen.s.brennan@oracle.com/
> > >> > v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/
> > >> >
> > >> > Thanks everyone for your review, tests, and consideration!
> > >>
> > >> Looks ok, I run the existing regression tests:
> > >>
> > >> acme@x1:~/git/pahole$ tests/tests
> > >>   1: Validation of BTF encoding of functions; this may take some time: Ok
> > >>   2: Pretty printing of files using DWARF type information: Ok
> > >>   3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> > >> /home/acme/git/pahole
> > >> acme@x1:~/git/pahole$
> > >>
> > >> And now I'm building a kernel with clang + Thin LTO + Rust enabled in
> > >> the kernel to test other fixes I have merged and doing that with your
> > >> patch series.
> > >>
> > >> Its all in the next branch and will move to master later today or
> > >> tomorrow when I finish the clang+LTO+Rust tests.
> > >
> > > pahole-staging testing in libbpf CI started failing recently, can you
> > > please double-check and see if this was caused by these changes? They
> > > seem to be related to encoding BTF for per-CPU global variables, so
> > > might be relevant ([0] for full run logs)
> > >
> > >   #33      btf_dump:FAIL
> > >   libbpf: extern (var ksym) 'bpf_prog_active': not found in kernel BTF
> > >   libbpf: failed to load object 'kfunc_call_test_subprog'
> > >   libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
> > >   test_subprog:FAIL:skel unexpected error: -22
> > >   #126/17  kfunc_call/subprog:FAIL
> > >   test_subprog_lskel:FAIL:skel unexpected error: -2
> > >   #126/18  kfunc_call/subprog_lskel:FAIL
> > >   #126     kfunc_call:FAIL
> > >   test_ksyms_module_lskel:FAIL:test_ksyms_module_lskel__open_and_load
> > > unexpected error: -2
> > >   #135/1   ksyms_module/lskel:FAIL
> > >   libbpf: extern (var ksym) 'bpf_testmod_ksym_percpu': not found in kernel BTF
> > >   libbpf: failed to load object 'test_ksyms_module'
> > >   libbpf: failed to load BPF skeleton 'test_ksyms_module': -22
> > >   test_ksyms_module_libbpf:FAIL:test_ksyms_module__open unexpected error: -22
> > >   #135/2   ksyms_module/libbpf:FAIL
> > >
> > >
> > >   [0] https://github.com/libbpf/libbpf/actions/runs/11204199648/job/31142297399#step:4:12480
> > 
> > Hi Andrii,
> > 
> > Thanks for the report.
> > 
> > The error: "'bpf_prog_active' not found in kernel BTF" sounds like it's
> > related to a bug that was present in v4 of this patch series:
> > 
> > https://lore.kernel.org/dwarves/ZwPob57HKYbfNpOH@x1/T/#t
> > 
> > Basically due to poor testing of a small refactor on my part, pahole
> > failed to emit almost all of the variables for BTF, so it would very
> > likely cause this error. And I think this broken commit may have been
> > hanging around in the git repository for the weekend, maybe Arnaldo can
> > confirm whether or not it was fixed up.
> > 
> > I cannot see the git SHA for the pahole branch which was used in this CI
> > run, so I can't say for sure. But I do see that the "tmp.master" branch
> > is now fixed up, so a re-run would verify whether this is the root
> > cause.
> 
> right, that is a piece of info I sometimes miss, the SHA used for the
> test run, but today's test is in progress and should have the fix for
> the inverted logic, we'll see...

https://github.com/libbpf/libbpf/actions/runs/11221662157/job/31192457160

Passed, so and here as well:

acme@x1:~/git/pahole$ tests/tests 
  1: Validation of BTF encoding of functions; this may take some time: Ok
  2: Pretty printing of files using DWARF type information: Ok
  3: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
acme@x1:~/git/pahole$

- Arnaldo

