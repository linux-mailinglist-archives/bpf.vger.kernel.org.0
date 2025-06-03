Return-Path: <bpf+bounces-59558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505BACCF22
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 23:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2CF1894DC2
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8A231835;
	Tue,  3 Jun 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="op3aNcQB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A4221F09;
	Tue,  3 Jun 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987082; cv=none; b=iBpHUt6Y/6HtgHzdbl7C/mt1dNFeVE+so2Fcut81KJ4+DoIampm2AGZWMdxj9W82vt3wf45Ed76rY0i9H/F9OZZDOOUTk8oJG64/yp0VjyPRywh5ZNgKXggiFEVPV7dSWfKu1o1n6ezaA3Wmc2UX5idMkGhKWlmfN7Zy7J68yKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987082; c=relaxed/simple;
	bh=7gflI8bQ8A18TGwYKDpl889ph/xH2f2J3Yd9be18SVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNaUcaRhu8tKpGugNAphZQ6EsJQyXa69ZcG4fPB4iRk2Gw26Jg3WqizIi8hp70KYJ2wazkoqlH9N1p9v4XbXOZIR1u7feUCDQ3go0dOynXe2bDdqfoIarhntF0bqpPeUeboExsDjbPUgZ9vewq2N8eNxcGBLtS7ZdK1T3irjEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=op3aNcQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B94C4CEED;
	Tue,  3 Jun 2025 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748987081;
	bh=7gflI8bQ8A18TGwYKDpl889ph/xH2f2J3Yd9be18SVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=op3aNcQB6siv2ePJTouwAfA4BRKm4uTb4lJgIU8bYhtE39YTPO7hvbpLwUCKLd0EG
	 NBxhtoMyNEuvoFzcvAzFCRiwnRmomxY9jOt54DOCDffbv6npVItTyrfI+tKmNL2T0I
	 SR3OyOOm6CeeheGvfpX2CxUkD57uVbPovQqdLf4uWLlk3XanYR8NK4PRoUJ/qLcZ1B
	 1k63vLtpI7E3baUodqkC2b7WBXW8NDxqYqwI7J6kLSrVrWInuhZTquDRO5hAziSfbO
	 QK5EL0hTyzYmTwHXnTrxvvd0FB180p+QBWu1Mszx9C7Inf6bLCJCDNci5CYke5nNg/
	 f4Oz/a/ATC6DQ==
Date: Tue, 3 Jun 2025 14:44:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
Message-ID: <aD9sxuFwwxwHGzNi@google.com>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com>
 <aD9Xxhwqpm8BDeKe@google.com>
 <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_Cj_8uTBGzaoFmi1f956dXi1qDnF4kqc49MSn0jDHYFfxg@mail.gmail.com>

Hi Blake,

On Tue, Jun 03, 2025 at 02:27:53PM -0700, Blake Jones wrote:
> Hi Namhyung,
> 
> On Tue, Jun 3, 2025 at 1:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, May 21, 2025 at 03:27:24PM -0700, Blake Jones wrote:
> > > Look for .rodata maps, find ones with 'bpf_metadata_' variables, extract
> > > their values as strings, and create a new PERF_RECORD_BPF_METADATA
> > > synthetic event using that data. The code gets invoked from the existing
> > > routine perf_event__synthesize_one_bpf_prog().
> >
> > It would be great if you can show an example how those metadata is
> > constructed and shared between BPF programs.
> 
> I've added the following to my commit message:
> 
> | For example, a BPF program with the following variables:
> |
> |     const char bpf_metadata_version[] SEC(".rodata") = "3.14159";
> |     int bpf_metadata_value[] SEC(".rodata") = 42;
> |
> | would generate a PERF_RECORD_BPF_METADATA record with:
> |
> |     .prog_name        = <BPF program name, e.g. "bpf_prog_a1b2c3_foo">
> |     .nr_entries       = 2
> |     .entries[0].key   = "version"
> |     .entries[0].value = "3.14159"
> |     .entries[1].key   = "value"
> |     .entries[1].value = "42"
> |
> | Each of the BPF programs and subprograms that share those variables would
> | get a distinct PERF_RECORD_BPF_METADATA record, with the ".prog_name" showing
> | the name of each program or subprogram. The prog_name is deliberately the
> | same as the ".name" field in the corresponding PERF_RECORD_KSYMBOL record.

Thanks!

> 
> > IIUC the metadata is collected for each BPF program which may have
> > multiple subprograms.  Then this patch creates multiple PERF_RECORD_
> > BPF_METADATA for each subprogram, right?
> >
> > Can it be shared using the BPF program ID?
> 
> In theory, yes, it could be shared. But I want to be able to correlate them
> with the corresponding PERF_RECORD_KSYMBOL events, and KSYMBOL events for
> subprograms don't have the full-program ID, so I wouldn't be able to do that.

It's unfortunate that KSYMBOL doesn't have the program ID, but IIRC the
following BPF_EVENT should have it.  I think it's safe to think KSYMBOLs
belong to the BPF_EVENT when they are from the same thread.

> 
> > > +     rodata = calloc(1, map_info.value_size);
> >
> > You can use 'zalloc()' instead, in other places too.
> 
> Fixed, thanks.
> 
> > > +void bpf_metadata_free(struct bpf_metadata *metadata)
> > > +{
> > > +     if (metadata == NULL)
> > > +             return;
> > > +     for (__u32 index = 0; index < metadata->nr_prog_names; index++)
> > > +             free(metadata->prog_names[index]);
> > > +     if (metadata->prog_names != NULL)
> > > +             free(metadata->prog_names);
> > > +     if (metadata->event != NULL)
> > > +             free(metadata->event);
> >
> > No need to NULL change for free().
> 
> I've removed the NULL checks.
> 
> > > +static int synthesize_perf_record_bpf_metadata(
> > > [...]
> > > +     for (__u32 index = 0; index < metadata->nr_prog_names; index++) {
> > > +             memcpy(event->bpf_metadata.prog_name,
> > > +                    metadata->prog_names[index], BPF_PROG_NAME_LEN);
> >
> > Is it possible to call synthesize_bpf_prog_name() directly to the
> > event->bpf_metadata.prog_name instead of saving it metadata->prog_names?
> 
> Not with the way the code is currently structured - we need the BTF data
> to call synthesize_bpf_prog_name(), and that's allocated and freed inside
> of bpf_metadata_create().

I see.  You already freed the map data and BTF.  Ok, it's not a big deal
and probably not needed if we can switch to BPF ID.

Thanks,
Namhyung


