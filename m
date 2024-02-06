Return-Path: <bpf+bounces-21260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF4584AB11
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 01:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3364228332C
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED283EC7;
	Tue,  6 Feb 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5wQd7aW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2D639;
	Tue,  6 Feb 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178762; cv=none; b=jL0st7AsR5ME3IHkWac8psVeQcRVfeNbNEYvVhvFGpEPWaM2nIth8yeFku7XsmmmGhukG7PWmKAObMwpsnbqoiRZtcDMLjq4ex1m4cZv1TRGiX35x225RZcYCx21Jk+cXrvdSKsDEOFrDIrvCuIQ2eeVB6zpRtzxFRS1Hvr0jhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178762; c=relaxed/simple;
	bh=3aAnESqvgKhvpJ+yZI83GQOT7qLCqZAwLtA+27U5RZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPFw2uKc7h5gtILcnq3/r/7FdvBMgPZ7aPeE/92Svvw2QI/ornREQTvYlytGQ54vRL7oVi05z5WrSR9K+8H9icYvqmx6mU7SxTi/sd4Qbobi0pDmXJuIxstp+hkkCte2sfqd16HbkmGXohaJi9I+vkl4wyIeuwoXMcqNZyhv1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5wQd7aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B8C433F1;
	Tue,  6 Feb 2024 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707178761;
	bh=3aAnESqvgKhvpJ+yZI83GQOT7qLCqZAwLtA+27U5RZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5wQd7aWl9E2lPx5X5GaIcdsNR2n6Bu6YFV08gC2l+mNpbkdGaZ4j1oQsBs4QVBg4
	 8ToEqyDra8t8+oZtVplYxfiMAy7K52sLaur3SLGbZu+ghNrudvyTxyz/T7ew4VOMgK
	 lj//zfi14aitFfcY19E93LSK9m623OrYiY9d9YxSmdKtyDO89iEe4Qh/aCePpz4g6S
	 gAHh38/1VrFPOoaGOl1roJ9+8UIvyf8D8n8/9by+KH4DI8h4DkkEkOjy7Dt5KQUBmf
	 lOVDjfbDp/O3rOK5FG6NJ9oXmUZgQg4q6uAFbJ3uFlv6F5/hDPbfsbJtMJi81ztBUK
	 VPCBwJJcaqTcg==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong1@huawei.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 1/1] perf bpf: Clean up the generated/copied vmlinux.h
Date: Mon,  5 Feb 2024 16:19:19 -0800
Message-ID: <170717858573.1700937.13255681716633001438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <Zbz89KK5wHfZ82jv@x1>
References: <Zbz89KK5wHfZ82jv@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2 Feb 2024 11:32:20 -0300, Arnaldo Carvalho de Melo wrote:
> When building perf with BPF skels we either copy the minimalistic
> tools/perf/util/bpf_skel/vmlinux/vmlinux.h or use bpftool to generate a
> vmlinux from BTF, storing the result in $(SKEL_OUT)/vmlinux.h.
> 
> We need to remove that when doing a 'make -C tools/perf clean', fix it.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

