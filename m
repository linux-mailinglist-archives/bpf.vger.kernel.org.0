Return-Path: <bpf+bounces-71334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADABEF0FE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A85B189899F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087D23BCE4;
	Mon, 20 Oct 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r72YhEDF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B914239072;
	Mon, 20 Oct 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926327; cv=none; b=aLQ04KR4kDqatZKkoq5D1Z3hUZmGwAAmV0y+niBAphrlMfC5vCQP2ZHMpCsnEhB02C8GjK7fZilvajJ+P/kbnm/iVhVckMAyIsju9ZALktGZ7IJGjGuKn4Y8jBLD5K0U7+YrgCs9AzWI01bdNI2/RqeMu79Y/PBtsqtHHFGSoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926327; c=relaxed/simple;
	bh=gX2MoPkKeBy21P54fODg5jJxYzVDoGKL+IdZJTCcDHU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YFix453kMv3Qr49MgSCoTDK4s5hSTJXpBrjQhAMRckLyxgXgtOVEqd41VKtDDgxcQb1ZNGrREwB77BqraRcgYkUe7vXN3TYP05dsD5ctAjq9mH+T6XCCbZfSkB+ncpMZYiqHCrE5SsBAi4mZ8m7UNQBaBPyrDCNg3SA4rjeJR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r72YhEDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC23C4CEE7;
	Mon, 20 Oct 2025 02:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760926326;
	bh=gX2MoPkKeBy21P54fODg5jJxYzVDoGKL+IdZJTCcDHU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=r72YhEDFXM8S5wWtOVe7XRa/k/ud0Pc/kBm18oA1f1YLVaMyhoSoYNxVagF1LY9GH
	 768AR7foewYgAnsOSW3EEbkIB44+fz4Gkr1qNW9ZSjqPSwSHcIMbB4dD6IeF2Syivb
	 OZhdTBaCxHmHDNTmoVL8znq0r+Fo4cdGYpPtwFgH4jVKgqXnmn7e+xhnbMWsafygkW
	 4g6oN0B1hL7zMtC/jFqO/KAOO9O93G8uuGX49A7vYWZdbuHAYDZ82PxTFDFFHJTAt0
	 LLCw+I9p2FWy6DwoD5DwB+CKN2eBD+q28tUtdtU466r3Pclo50M3a+H7jXk/bkTKbG
	 Ool7V9EmI269g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251016150718.2778187-1-irogers@google.com>
References: <20251016150718.2778187-1-irogers@google.com>
Subject: Re: [PATCH v1] perf stat bperf cgroup: Increase MAX_EVENTS from 32
 to 1024
Message-Id: <176092632423.143093.13411796449610394890.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:12:04 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 16 Oct 2025 08:07:18 -0700, Ian Rogers wrote:

> The MAX_EVENTS value ensured a counted loop presumably to satisfy the
> BPF verifier. It is possible to go past 32 events when gathering
> uncore events. Increase the amount to 1024 as that should provide some
> amount of headroom.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


