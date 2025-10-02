Return-Path: <bpf+bounces-70218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1397BB4B30
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 19:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4583B19F4
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243326D4F1;
	Thu,  2 Oct 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9uLzZQm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963DA4501A;
	Thu,  2 Oct 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426299; cv=none; b=O2ZYSd90+5d6tfuO8L2nvxq+smWJHhO45hhRn/FXnCyB+ObooEWVNvei22lYfwXaWmqMqREUy2mFj6X7apo9x3+/3oivJSmAlMsRLUIigSWFWuTf1qBlTmUDk9+z1zeRMTG/TVotdjCVPWBjVYGjp9wYers3iBn7KE6ttJ9AVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426299; c=relaxed/simple;
	bh=KDjDyeHkoRmO27Arq6cMJwsCPLv+zfc+5LY+k1xHiCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+6DWR7/1pMv3VGWH+dGmaDfHJFOZ2biPufMwVGaPLUeFyoJH4qZfAomrfi/Dd0ZjdvrdSQUk6wByfFoXRsyizuT/Qgif/Ir9mTK1Qbl2841pCowzptpE/E6jykkejoGa9dzc5CwXmDu+znk8XHC4GJI1F1qn2y68otngooLtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9uLzZQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E42AC4CEF4;
	Thu,  2 Oct 2025 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759426299;
	bh=KDjDyeHkoRmO27Arq6cMJwsCPLv+zfc+5LY+k1xHiCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9uLzZQmMTYawbDrpuDBhFYuAh9ix3gusakiGevbjudeEwgYJ5yYyjqIXuHxS5Sqa
	 gmtsW6rH6qSgN647MeaDqlP2JYo+ZGCScFdB9rOySW+7jvJ9HJCpHdoQWLvO9v/fAi
	 zHKJPy7hzSWNrr19S7IP5GKP4tkn+bbqc+ikez9SbCFtlkRIMQh47xlGwx3QpXObS5
	 qjYbdnSKk61g6vgvwsUsH7jSFD05Gf6PhBz7aSS68KwvvE6bM2YWoDSpOb+YjbElxW
	 2hrFFGgHQpkmfRPUJa4YdY/pXwWy8yQqKUogOolevPcKlMysSOAIavNC3pf4OtlcIW
	 7ws6hq9vwlGdw==
Date: Thu, 2 Oct 2025 14:31:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrew Pinski <quic_apinski@quicinc.com>,
	Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Message-ID: <aN629m1MlMXYh1te@x1>
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
 <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev>

On Wed, Aug 06, 2025 at 05:27:02PM -0700, Yonghong Song wrote:
> On 8/6/25 4:57 PM, Andrew Pinski wrote:
> > > -----Original Message-----
> > > From: Namhyung Kim <namhyung@kernel.org>
> > > Sent: Wednesday, August 6, 2025 4:34 PM
> > > To: Sam James <sam@gentoo.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > > <mingo@redhat.com>; Arnaldo Carvalho de Melo
> > > <acme@kernel.org>; Mark Rutland
> > > <mark.rutland@arm.com>; Alexander Shishkin
> > > <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > > <jolsa@kernel.org>; Ian Rogers <irogers@google.com>; Adrian
> > > Hunter <adrian.hunter@intel.com>; Liang, Kan
> > > <kan.liang@linux.intel.com>; Andrew Pinski
> > > <quic_apinski@quicinc.com>; linux-perf-
> > > users@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > bpf@vger.kernel.org
> > > Subject: Re: [PATCH] perf: use __builtin_preserve_field_info
> > > for GCC compatibility
> > > 
> > > Hello,
> > > 
> > > On Wed, Aug 06, 2025 at 01:03:01AM +0100, Sam James
> > > wrote:
> > > > When exploring building bpf_skel with GCC's BPF support,
> > > there was a
> > > > buid failure because of bpf_core_field_exists vs the
> > > mem_hops bitfield:
> > > > ```
> > > >   In file included from util/bpf_skel/sample_filter.bpf.c:6:
> > > > util/bpf_skel/sample_filter.bpf.c: In function
> > > 'perf_get_sample':
> > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42:
> > > error: cannot take address of bit-field 'mem_hops'
> > > >    169 | #define ___bpf_field_ref1(field)        (&(field))
> > > >        |                                          ^
> > > > tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29: note: in
> > > expansion of macro '___bpf_field_ref1'
> > > >    222 | #define ___bpf_concat(a, b) a ## b
> > > >        |                             ^
> > > > tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29: note: in
> > > expansion of macro '___bpf_concat'
> > > >    225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> > > >        |                             ^~~~~~~~~~~~~
> > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9: note:
> > > in expansion of macro '___bpf_apply'
> > > >    173 |         ___bpf_apply(___bpf_field_ref,
> > > ___bpf_narg(args))(args)
> > > >        |         ^~~~~~~~~~~~
> > > > tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39: note:
> > > in expansion of macro '___bpf_field_ref'
> > > >    188 |
> > > __builtin_preserve_field_info(___bpf_field_ref(field),
> > > BPF_FIELD_EXISTS)
> > > >        |                                       ^~~~~~~~~~~~~~~~
> > > > util/bpf_skel/sample_filter.bpf.c:167:29: note: in expansion
> > > of macro 'bpf_core_field_exists'
> > > >    167 |                         if (bpf_core_field_exists(data-
> > > > mem_hops))
> > > >        |                             ^~~~~~~~~~~~~~~~~~~~~
> > > > cc1: error: argument is not a field access ```
> > > > 
> > > > ___bpf_field_ref1 was adapted for GCC in
> > > > 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
> > > > but the trick added for compatibility in
> > > > 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
> > > > isn't compatible with that as an address is used as an
> > > argument.
> > > > Workaround this by calling __builtin_preserve_field_info
> > > directly as
> > > > the bpf_core_field_exists macro does, but without the
> > > ___bpf_field_ref use.
> > > 
> > > IIUC GCC doesn't support bpf_core_fields_exists() for bitfield
> > > members, right?  Is it gonna change in the future?
> > Let's discuss how __builtin_preserve_field_info is handled in the first place for BPF. Right now it seems it is passed some expression as the first argument is never evaluated.
> > The problem is GCC's implementation of __builtin_preserve_field_info is all in the backend and the front end does not understand of the special rules here.
> > 
> > GCC implements some "special" builtins in the front-end but not by the normal function call rules but parsing them separately; this is how __builtin_offsetof and a few others are implemented in both the C and C++ front-ends (and implemented separately). Now we could have add a hook to allow a backend to something similar and maybe that is the best way forward here.
> > But it won't be __builtin_preserve_field_info but rather `__builtin_preserve_field_type_info(type,field,kind)` instead.
> > 
> > __builtin_preserve_enum_type_value would also be added with the following:
> > __builtin_preserve_enum_type_value(enum_type, enum_value, kind)
> > 
> > And change all of the rest of the builtins to accept a true type argument rather than having to cast an null pointer to that type.
> > 
> > Will clang implement a similar builtin?
> 
> The clang only has one builtin for some related relocations:
>    __builtin_preserve_field_info(..., BPF_FIELD_EXISTS)
>    __builtin_preserve_field_info(..., BPF_FIELD_BYTE_OFFSET)
>    ...
> They are all used in bpf_core_read.h.
> 
> > 
> > Note this won't be done until at least GCC 16; maybe not until GCC 17 depending on if I or someone else gets time to implement the front-end parts which is acceptable to both the C and C++ front-ends.

So I'm taking the patch as-is, ok?

But first we need the Signed-off-by tag from Andrew Pinski as he is
listed in a Co-authored-by, that I replaced with Co-developed-by as its
the term used for this purpose in:

Yonghong, can I add an Acked-by: you since you participated in this
discussion agreeing with the original patch (If I'm not mistaken)?



