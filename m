Return-Path: <bpf+bounces-61694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2290AEA48A
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4801C2685D
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D92ED14B;
	Thu, 26 Jun 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjvzyAjK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF422EB5DF;
	Thu, 26 Jun 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959685; cv=none; b=AVXGDTBMzCQAAH41vena6pdN0QojwBHUTydrSb7W7eJ6t3px3yZhLcqWVMY1FoVep7raYQNeKWbLEwngb617lib+L3ECzP+92lQmCKfPenfDdLx68fzyBTmEqCtIjNoacYjNHb4V/bCBDRDTzbnBoJyTao9HPFz8HDNTD/p4bLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959685; c=relaxed/simple;
	bh=flbt68zPKINdWrx+aON7Uhaf+7rq9sJ/Wg+ASDQaYGE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BTPOwx+ATL6zR+6tBQQ4dV+8K0nYHN6UOOZnAnuoR5csFV8cN6o5jrfxI9AYXOEdBSprrPjd3ZPS26QsmVLps6gtk3ZgF9ispfqlBYIcxwsjWGUJoa/Qf99p2v3C2dITxR1vZSSz3eZZLtn9quEANtNLGgd+yJWUcxhvnZyZxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjvzyAjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE3C4CEED;
	Thu, 26 Jun 2025 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750959684;
	bh=flbt68zPKINdWrx+aON7Uhaf+7rq9sJ/Wg+ASDQaYGE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fjvzyAjKikeK58rIWpmZET2y+ETYlGnEahg6dyD63Jt4+5ahqunGKdTVJHNo+EdCV
	 WbzLyQMKxID0by92SIDGkvGt6vqPykOahrDGSimwgxaJzm0NCJcKYo70x/rKAHeZcn
	 athrbf6xKQp1EyaiGeVX03CKiuNFIMygYZDXM6G7jKDQqfYjUv0qwCA+bDYVDv+fiR
	 lWy9jtFq97hxqYXX5k80xD5SQ3EQRePeoaMPZjGi6hKoQlHBwgq5RHWc2P1qvEUeLV
	 CSVuvwNaNOcX6/lGZ4vEmbuYiSCQ1H1Gdmdq+/VB9yFyhAVaYMOF82y/siHjQT6rMz
	 o4GV8VjyJWFtQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250607061238.161756-1-irogers@google.com>
References: <20250607061238.161756-1-irogers@google.com>
Subject: Re: [PATCH v1 0/4] Pipe mode header dumping and minor space saving
Message-Id: <175095968444.2045399.15438256971505917077.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 10:41:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 06 Jun 2025 23:12:34 -0700, Ian Rogers wrote:
> Pipe mode has no header and emits the data as if it were events. The
> dumping of features was controlled by the --header/-I options which
> makes little sense when they are events, normally traced when
> dump_trace is true. Switch to making pipe feature events also be
> traced with detail when other events are.
> 
> The attr event in pipe mode had no dumping, wire this up and use the
> existing perf_event_attr fprintf support.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



