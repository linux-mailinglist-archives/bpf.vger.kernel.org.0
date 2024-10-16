Return-Path: <bpf+bounces-42212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BCF9A1063
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9128A1F22B77
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817E2101B7;
	Wed, 16 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isWgfLIY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFE18660A;
	Wed, 16 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098762; cv=none; b=Udpt0YsrBFk+eUKiNCpFY+HqGCG3F6MoWVxjBCJrm97NUGWDlKivIVFxUcJtSJt4kg9ZDEaJswiNqrP1MHx1dLa60cW/YeHLN5uog76K9vVCas/3kVV7+TBP/iQDBbRwgznlRA7idPG2deqnmhTWN7One3IyVwQnIBYsnxkILFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098762; c=relaxed/simple;
	bh=Rl3gy5Vl2zrK+bfmn5LbLCvFikHLNss6GUqX9LuMmFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q3v7FfPTkYBnhglmUJszZAyX18mirLmmRJoi7gkxC8Zqs89NPmg+Pm6o+jphJ7+Sg90ofOKo30qe+vYUqGu9S8JupJ5Ymi0dSKCONypjHTpsm+2w9JO3/rvZIVQHe51XWpAKlueBHg5ZClNViK3iuFdL8rfavd4NnRGVul5qtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isWgfLIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D57C4CEC5;
	Wed, 16 Oct 2024 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098761;
	bh=Rl3gy5Vl2zrK+bfmn5LbLCvFikHLNss6GUqX9LuMmFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=isWgfLIYBS1wHJOsuT8iupAnds4s+m2FhP5XUjSZIgPyugkLuoESsVre6qiaFnytu
	 XmnHzppFtxS5JqD3uidzobZpaGi82BNXgSpKP10OJUHDjbYOlEqSP8vuLFJOfYhYvr
	 sVt62RuRA3lBVW5jU+P9jKiV2U8DBTwMsV+tQXGItkg9WxrBNV47MmeGoSdJB7YuQD
	 ni6b55mG8zKV5JrxPhjfHr6/U54097F0xpWdjrojfVhYgvhHAYAt58taC80GCtNVgt
	 UneK7ymNYnyb/9EI7vJRxPObyV5taLyQF9AIloJ3C4RDqJUs/u3UJoygupRbbgTrI1
	 FrVFrtz8bjZCA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20241009202009.884884-1-namhyung@kernel.org>
References: <20241009202009.884884-1-namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf tools: Fix possible compiler warnings in
 hashmap
Message-Id: <172909876148.288721.10451526265503632803.b4-ty@kernel.org>
Date: Wed, 16 Oct 2024 10:12:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 09 Oct 2024 13:20:08 -0700, Namhyung Kim wrote:

> The hashmap__for_each_entry[_safe] is accessing 'map' as if it's a
> pointer.  But it does without parentheses so passing a static hash map
> with an ampersand (like &slab_hash below) caused compiler warnings due
> to unmatched types.
> 
>   In file included from util/bpf_lock_contention.c:5:
>   util/bpf_lock_contention.c: In function ‘exit_slab_cache_iter’:
>   linux/tools/perf/util/hashmap.h:169:32: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
>     169 |         for (bkt = 0; bkt < map->cap; bkt++)                                \
>         |                                ^~
>   util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
>     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
>   /home/namhyung/project/linux/tools/perf/util/hashmap.h:170:31: error: invalid type argument of ‘->’ (have ‘struct hashmap’)
>     170 |                 for (cur = map->buckets[bkt]; cur; cur = cur->next)
>         |                               ^~
>   util/bpf_lock_contention.c:105:9: note: in expansion of macro ‘hashmap__for_each_entry’
>     105 |         hashmap__for_each_entry(&slab_hash, cur, bkt)
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


