Return-Path: <bpf+bounces-22156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B9857FDF
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B9B22BF9
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FC12F377;
	Fri, 16 Feb 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON17NlzR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215061292F4;
	Fri, 16 Feb 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095456; cv=none; b=eQywxlq7oWvXVG4Vgswb2Nc4DBrXDcc2R1IS8ChARzfGnDVZY35FLGBm+FEgj4coYawRnBUHQmAEcKLiIM2gpV93S3Fl15tJjFrXTvAHPKAjtECGffvyeTJd26iYOa2D6kqT5Q8+GP9+tt5T4RlMkoEJUs0HZl0nd22d6QirsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095456; c=relaxed/simple;
	bh=bYPWSFzizc6hw98vYyVTqVDrmSgriMmL7bU5ekFvWl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe0h17EyiSYFJ7/kmQehEdF39iC2Apconl5r+XVWHGh/5hgK1KWLd1D5A22HTxpvuAQgt0fFtA4u2RAASq8e/uLzjOtYgvmBjFkC4RbYTCDDdHBSlZ//xK9i72YFM+Gf/vBytGbQ5ml7+QIYHMbkTc1O4N3jvRj0ToFlOiYud8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON17NlzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D25FC433C7;
	Fri, 16 Feb 2024 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095455;
	bh=bYPWSFzizc6hw98vYyVTqVDrmSgriMmL7bU5ekFvWl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON17NlzRcf8XTrWnC+hTMNpCsGM1tAcbZi6+rqehI6NuTCTr+djCCRYLpsETn3VXC
	 2BKbQzWxuhdpbQALNtUf2xld8nq5g4tO+x57/h0vP8eAN7WbVZOfnng4CBYDmXpNEr
	 rSoUbLY6R5zQWsdGtMv9prHBcyWVgUuPHBlZJutDnIsvIJyw8KA0OWEDTi4w4hx6Gm
	 OObeLuQQJU3FkXXNybRgLECXc9lZiNHBcppbA9MTF06VOtFC2Qmirapn/zuRXeHBwo
	 zYApWHFl6BxJuL9bH5jcESqg3saem/kiO1gM4FohvD+bW+3Mmd49HS6LqU2odBEIQ0
	 vMZtXxEyWKcNg==
Date: Fri, 16 Feb 2024 11:57:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/6] perf trace: Ignore thread hashing in summary
Message-ID: <Zc933IYjWlkMo4D2@x1>
References: <20240214063708.972376-1-irogers@google.com>
 <20240214063708.972376-3-irogers@google.com>
 <Zcz3iSt5k3_74O4J@x1>
 <CAP-5=fV9Gd1Teak+EOcUSxe13KqSyfZyPNagK97GbLiOQRgGaw@mail.gmail.com>
 <CAP-5=fXb95JmfGygEKNhjqBMDAQdkQPcTE-gR0MNaDvHw=c-qQ@mail.gmail.com>
 <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWweUBP_-SHfoADswizMER6axNw89JyG7Fo_qiC883fNw@mail.gmail.com>

On Wed, Feb 14, 2024 at 01:36:46PM -0800, Ian Rogers wrote:
> On Wed, Feb 14, 2024 at 1:15 PM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Feb 14, 2024 at 10:27 AM Ian Rogers <irogers@google.com> wrote:
> > > On Wed, Feb 14, 2024 at 9:25 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > > On Tue, Feb 13, 2024 at 10:37:04PM -0800, Ian Rogers wrote:
> > > > > Commit 91e467bc568f ("perf machine: Use hashtable for machine
> > > > > threads") made the iteration of thread tids unordered. The perf trace
> > > > > --summary output sorts and prints each hash bucket, rather than all
> > > > > threads globally. Change this behavior by turn all threads into a
> > > > > list, sort the list by number of trace events then by tids, finally
> > > > > print the list. This also allows the rbtree in threads to be not
> > > > > accessed outside of machine.

> > > > Can you please provide a refresh of the output that is changed by your patch?
> > >
> > > Hmm.. looks like perf trace record has broken and doesn't produce
> > > output in newer perfs. It works on 6.5 and so a bisect is necessary.
> >
> > Bisect result:
> > ```
> > 9925495d96efc14d885ba66c5696f664fe0e663c is the first bad commit
> > commit 9925495d96efc14d885ba66c5696f664fe0e663c
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Thu Sep 14 14:19:45 2023 -0700
> >
> >    perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
> > ...
> > https://lore.kernel.org/r/20230914211948.814999-3-irogers@google.com
> > ```
> >
> > Now to do the bisect with BUILD_BPF_SKEL=1 on each make.
> 
> This looks better (how could I be at fault :-) ):
> ```
> 1836480429d173c01664a633b61e525b13d41a2a is the first bad commit
> commit 1836480429d173c01664a633b61e525b13d41a2a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Aug 16 13:53:26 2023 -0300
> 
>    perf bpf_skel augmented_raw_syscalls: Cap the socklen parameter
> using &= sizeof(saddr)
> ...
>    Cc: Adrian Hunter <adrian.hunter@intel.com>
>    Cc: Ian Rogers <irogers@google.com>
>    Cc: Jiri Olsa <jolsa@kernel.org>
>    Cc: Namhyung Kim <namhyung@kernel.org>
>    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ```
> No LKML link.

So simple... ;-\

I've reproduced your steps and got to the same cset while testing on a
recent distro kernel (6.6.13-200.fc39.x86_64), scratching my head now
and trying to figure this out.

Wonder if trying to run on an older kernel the problem would appear.

Will try and add a perf test shell entry with a simple:

root@number:~# perf trace record sleep 0.001 && perf script | head | wc -l
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.034 MB perf.data ]
0
root@number:~#

Has to be 10 :-)

Thanks,

- Arnaldo

