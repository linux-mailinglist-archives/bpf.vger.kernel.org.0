Return-Path: <bpf+bounces-63737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C20B0A7B5
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282518840B9
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBA2DEA75;
	Fri, 18 Jul 2025 15:38:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226FD515;
	Fri, 18 Jul 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853086; cv=none; b=FWKhVbSMF+xTb8nizo8xwqJySwJX8Fk1eO7D+dy9tXeMPb1C67hsLbUZi41vy/etM5a6AzlfL+FP4B+cxKMm8Sf7FUlEfvzHjbvFnBv8MkEiJoxsnLhQXsCeB3USqo4Yt+1ioStSeJcbSY7eCac9yAt9r46fnIdiJDTbvse6Gd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853086; c=relaxed/simple;
	bh=wVzzfH9VNd5QcyCYf3Hm3wOcD5aMu7o9CHpXNXTfKzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg5IJANfnvIPytf5ivnfpPeBkBIN1LobqU/7PRfkd6QAu7+JejO8KG4hPRWnjbuLxBUSd4SwARzRyjHmO8dChPqYw3ZLMitr2cG/5a7orxPeQPWXvDp5xe23bLb9QXMemuOgq6Leapc6L1oGbT/8KvboZQ5yuI1zfZgUY/Lp8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A469F16A3;
	Fri, 18 Jul 2025 08:37:56 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774AE3F6A8;
	Fri, 18 Jul 2025 08:38:03 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:38:01 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
Message-ID: <20250718153801.GB3137075@e132581.arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
 <20241215193436.275278-3-leo.yan@arm.com>
 <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
 <20250714174505.GA3020098@e132581.arm.com>
 <ba5c04f4-a33d-4d7f-9272-eee4a4389def@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5c04f4-a33d-4d7f-9272-eee4a4389def@linux.dev>

Hi Yonghong,

On Tue, Jul 15, 2025 at 10:12:02AM -0700, Yonghong Song wrote:

[...]

> > I'm not certain whether using __bpf_kfunc is appropriate here, or if I
> > should stick to BPF_CALL to ensure support for accessing bpf_map
> > pointers?
> 
> Using helpers (BPF_CALL) is not an option as the whole bpf ecosystem
> moves to kfunc mechanism. You can certainly use kfunc with 'struct bpf_map *'
> as the argument. For example the following kfunc:
>   __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
> in kernel/bpf/map_iter.c

Thanks a lot for suggestion. I followed the idea to refactor the patch
with kfunc, see the new version:
https://lore.kernel.org/linux-perf-users/20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com/T/#m27a72255c93fa672e164cb87a322b979fe8f9408

Just clarify one thing, I defined the kfunc in new patch:

  int bpf_perf_event_aux_pause(void *p__map, u64 flags, u32 pause)

Unlike your suggestion, I defined the first parameter as "void
*p__map" (I refers to bpf_arena_alloc_pages()) rather than
"struct bpf_map *map". This is because the BPF program will pass a
variable from the map section, rather than passing a map pointer.

TBH, I do not watch closely the BPF mailing list, so I may not be
fully following the conventions. If anything is incorrect, please
correct it as needed.

Thank you,

Leo

