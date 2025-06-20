Return-Path: <bpf+bounces-61215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C732AE243B
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1331E5A7630
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30FA239E60;
	Fri, 20 Jun 2025 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Q/EiGE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12B23814A;
	Fri, 20 Jun 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455666; cv=none; b=vBPA9YPcNhtHtYmcuH1G8/j+9qehU62oTqyF6HIdk86h3nQAosG3LtEstCP7292ip7NG/PPFOrnSHDikU/jZP5DRgVN/dbHWsaSgMUyefrbeQb75UySAF4GZ12BVXEMYR6eNo54kghHj8QNMSO1wrtQPtYPE40VreL/xb3bBatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455666; c=relaxed/simple;
	bh=rKjdBQKmlk3ftyyNyRJyICUhNkVNb/3e3jwzM9KV5lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c41vHiIj+TlXLQk2zM3qttnvm692TbnCXKOgENM62pOVxJ8Yp5jjW4cj7iTs0uH/OqUl2Q37KzTHdXn4UEaNoJqf//pzzkwEqVlt1yqhbsh6R3DswcuNSxyHTTZ1gTUypnq3n4nXPbpXsEFFKHu1IWtJQ+qWZZqs3yztI5oyVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Q/EiGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84B9C4CEE3;
	Fri, 20 Jun 2025 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750455665;
	bh=rKjdBQKmlk3ftyyNyRJyICUhNkVNb/3e3jwzM9KV5lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2Q/EiGEGh/O7kruofaRpkbSXvdSBv37Z3Avg+hm/eQ4M+QcsQVG836aM91JY9AA7
	 D2CXnmtUc0FF9PozAXT2neLUnYa5DNgSB2FCXrzn4aiHxKUd67KrR74m98pXh9V1J8
	 C05nfgS7u4+FyBfrFMS8oZ/TZCnN0tQT+VWdxBmgDp2i4TRYXHZRb5Ottr0WFLl2ND
	 IKwysLFwOqghQ/coH4eNJP51/EzPSmxImV+EFvHxU+itQymtsHmY0UrxMo7h3pt72p
	 1ss3wfmh+VE6+RLIzgTaG3PmbWSiIlSxzvzPHWt0NRf4kHi6f5WkFd7vdgK2usYVdK
	 8ohjiqag8p3TA==
Date: Fri, 20 Jun 2025 14:41:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
Message-ID: <aFXVbkxNoHOVyFwy@google.com>
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com>
 <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
 <CAP_z_CjRB6MwNrXW_o_XyWSwcXZKpVHyGZoj1udJU4uBu1iw=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP_z_CjRB6MwNrXW_o_XyWSwcXZKpVHyGZoj1udJU4uBu1iw=g@mail.gmail.com>

Hi Blake,

On Wed, Jun 11, 2025 at 06:02:55PM -0700, Blake Jones wrote:
> On Wed, Jun 11, 2025 at 5:39 PM Blake Jones <blakejones@google.com> wrote:
> > Is there anything written up about how to set up a machine so that
> > "make build-test" works reliably?

Sorry for the trouble.  I found it needs more work.

> 
> Barring that, I've confirmed that each of my new patches builds successfully
> under the following build commands: (I have a copy of libbpf that supports
> ".emit_strings" in /usr/local/include)
> 
>     cd tools/perf
>     make clean
>     make NO_LIBTRACEEVENT=1 LIBBPF_DYNAMIC=1 LIBBPF_INCLUDE=/usr/local/include
>     ./perf check feature libbpf-strings
> 
>     make clean
>     make NO_LIBTRACEEVENT=1
>     ./perf check feature libbpf-strings
> 
>     make clean
>     make NO_LIBTRACEEVENT=1 NO_LIBBPF=1
>     ./perf check feature libbpf-strings
> 
> Please let me know if that seems like sufficient testing.

Looks ok to me and thanks for doing this.

Namhyung


