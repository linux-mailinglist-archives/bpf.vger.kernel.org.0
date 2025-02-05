Return-Path: <bpf+bounces-50473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3DA2817E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3C61888A27
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809220FAAB;
	Wed,  5 Feb 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWOQOSJB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12A20DD45;
	Wed,  5 Feb 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720682; cv=none; b=lcvRuLYAjQHnjw/gkMB5uqAsh26rEdjt+sqp9ZJINNy+wNR+4ZTsjgiGuO2tlcYd/aDGw2wdTUDhgZuCWR3LzVSedIJQ4/eKEt2PFKykZi/Xd8iv+HefefOsDGMiuiCKTdrMl6nJQxW85x8kbeIsm71BGyfYj1CqMF0wFZyf6SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720682; c=relaxed/simple;
	bh=36nNQFv27a8nUdP2WQTGRbi/MyOjHJoWvAR+wzGCPz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swo3tMBwEJmBDH9rXMPe4lnTxllpiqcNhsunYKS3scFGbjmcz5ZXHW5AnF92Wi/csBu6rTZ03aKZ+7XfNmwdSvwzq2YLjfCIAQtvtxOhu25P3Ta7NW8h0CFRyDZeWpcLJMD5IS74gINZMkeE7FF2DqOqqBA2Ae6fBX6JckXklUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWOQOSJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6A4C4CEDF;
	Wed,  5 Feb 2025 01:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738720682;
	bh=36nNQFv27a8nUdP2WQTGRbi/MyOjHJoWvAR+wzGCPz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWOQOSJB0M0hqQZs7cXNtXC5Yj0PmTJDDgi9eIRIFoFXAE42i9OFzN7F13AKHVi9c
	 XaT0Yp+UTjtB0shRuE/YUqY5k3SYeu62KpcsnJcNmBycKGZuCiRA0NBn0BCPe3ASvw
	 UTSAdI2R2Y4EjygxLo4lDlzaA46p3JRUlEdL3oKgMBKw6tEROyCvM1cM8lsMVnGt9l
	 bGR0t/b0uxHEVk9JAZUM3jRRWErWxzHcc3XWmO3ck5C0ugsosBHzAcSSslpybhVuHZ
	 rHeWq2+Ljy8cicoA5KLyIdpb0d4c/WkqK67SifjibVwQitAc3YlD1rhjPPlpjxvOQs
	 1HxEt5Sj2aTag==
Date: Tue, 4 Feb 2025 17:57:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Atish Kumar Patra <atishp@rivosinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>,
	Beeman Strong <beeman@rivosinc.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/4] perf parse-events: Reapply "Prefer sysfs/JSON
 hardware events over legacy"
Message-ID: <Z6LFp5jiED7_-weN@google.com>
References: <CAP-5=fXxMmn31iep6tdvaUGzZccR+_D1L4RbjaNiRdEau2NZ9g@mail.gmail.com>
 <CAP-5=fXdq2oSgTnNJJydAnBdSg5WeaPy6zjaink5+bsyXLoPiw@mail.gmail.com>
 <Z4f3fDXemAMpBNMS@google.com>
 <CAP-5=fWS8AzSo=vxcCFUaYMMth7FNMPNbCXjYOGApQ0AitqA2Q@mail.gmail.com>
 <Z5qjwRG5jX9zAGtf@google.com>
 <CAHBxVyHL4CO1xGpzkNfvxk71gUYdVyrXZkqZHZ+ZV2VxeGFf8w@mail.gmail.com>
 <Z51RxQslsfSrW2ub@google.com>
 <CAP-5=fWzzWqNAgmrDHav63Z+HMnSP0RZJ3Q7PQpuzP7Tf_HP7g@mail.gmail.com>
 <Z6FcHJFYGc7HzSna@google.com>
 <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW9f2mxuTV2FGCdhKm7M9g8v6VsLJJXTPTLRr5tUv9rOA@mail.gmail.com>

On Mon, Feb 03, 2025 at 04:41:11PM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 4:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> [snip]
> > Yep, I agree it's confusing.  So my opinion is to use legacy encoding
> > and no default wildcard. :)
> 
> Making it so that all non-legacy, non-core PMU events require a PMU is
> a breaking change and a regression for all users, command line event
> name suggesting, any tool built off of perf, and so on. Breaking all
> perf users and requiring all perf metrics be rewritten is well..
> something..

Well, I guess the majority of users don't use non-core PMU events.  And
we used to have PMU prefix on those events for years so old users should
not be affected.  Actually perf list shows them with PMU prefix so I
think new users are also expected to use the PMU name.

  $ perf list pmu
  ...
  cstate_pkg/c2-residency/                           [Kernel PMU event]
  ...
  i915/actual-frequency/                             [Kernel PMU event]
  i915/bcs0-busy/                                    [Kernel PMU event]
  ...
  msr/tsc/                                           [Kernel PMU event]
  ...
  power/energy-cores/                                [Kernel PMU event]
  ...
  uncore_clock/clockticks/                           [Kernel PMU event]
  uncore_imc_free_running/data_read/                 [Kernel PMU event]  
  ...

The exception is the JSON events like below.

  uncore interconnect:
    unc_arb_coh_trk_requests.all
         [UNC_ARB_COH_TRK_REQUESTS.ALL. Unit: uncore_arb]
 
which I hoped to be 'uncore_arb/unc_arb_coh_trk_requests.all/' or even
'uncore_arb/coh_trk_requests.all/'.  But it would be hard to change the
all metric expressions now.  Also users can directly use them as they
are listed by `perf list`.  So we need to support that without PMUs.

Thanks,
Namhyung


