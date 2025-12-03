Return-Path: <bpf+bounces-75984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A747CA0B83
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2E0530194CA
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4535933343E;
	Wed,  3 Dec 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkTT+88u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC33EB06;
	Wed,  3 Dec 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784717; cv=none; b=AdDtVqbC6rmNO+7dKQW35UR5sjvcL602IDeSUFvodzwbnPPikPyTHcsKrNWAEhoZM7jeLf7ixfcF0wQveMQkO+uZYJfhBOh04ouY46oxCgl9jMWSIWd3UipXHIa9/rWBFihoSBmgs3XlvP3q42q6BB3d/EZ/XC1pgatkPI2ID0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784717; c=relaxed/simple;
	bh=pBHaqc1UaMxy6DaEmtPewMkqaPweraKDE02V5olQNd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lyg2zcIfvMDD+4QoCjY2vNaD7V0ZmSEKL6F8cgMGI2N1AiTbH+Xurr1LQgCQWzrNDNWpi4m0laCS6ByjvwRtpPsHsX8iS5QlFdNaTp3cc88QQUGPqKG5GKwN5apTSFQ38aVJG6UlZ8rAMyB02dKMzVGSUvfbhrIiA7z82JoTHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkTT+88u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B870EC116C6;
	Wed,  3 Dec 2025 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784717;
	bh=pBHaqc1UaMxy6DaEmtPewMkqaPweraKDE02V5olQNd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dkTT+88uVT1bgCNEJxz465IiHx71Tr2tn3AQlRd7d41E5PxmwGqiNsGCelwOFHR6H
	 MC1tBs6oIyC4xq07cTo5yd+9Jms4PYlYaVgfI8tN8CL/FeXlc3aRy2UNyyG8xyPKqZ
	 gU8Zq29L5sABFt0zXPAYMUz5t1lPVLRxXuhrQxHgY+QLx/wo9DJ5LGEdGn7TdHiAUr
	 XyM5GIerL1F4oOJdxvvOz++wqswCriHZ9kFPUDyi4gsVZ8D4afm5QOt3CWWnJG+/pE
	 SwGngMndgAp3ARY+M9yrrFzKX5BZNSTrHb64WAaAO+l9ClLEY//cyFpMTV3qZhNWyl
	 83oBYm497vw+w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20251120234804.156340-1-namhyung@kernel.org>
References: <20251120234804.156340-1-namhyung@kernel.org>
Subject: Re: [PATCHSET v6 0/6] perf tools: Add deferred callchain support
Message-Id: <176478471565.3636162.18444163502613500865.b4-ty@kernel.org>
Date: Wed, 03 Dec 2025 09:58:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 20 Nov 2025 15:47:58 -0800, Namhyung Kim wrote:
> This is a new version of deferred callchain support as the kernel part
> is merged to the tip tree.  Actually this is based on Steve's work (v16).
> 
>   https://lore.kernel.org/r/20250908175319.841517121@kernel.org
> 
> v6 changes)
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



