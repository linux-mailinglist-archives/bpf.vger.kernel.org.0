Return-Path: <bpf+bounces-48570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72406A09732
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620477A41D9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3F212FB4;
	Fri, 10 Jan 2025 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGZU3Ef8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0E212D83;
	Fri, 10 Jan 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526180; cv=none; b=iLa1u1LQZ+NVgYlMZnXCexFrDrAOe348bTVFksUGktfcALkzwN+IUFd+GeKLH+CoPqcw58F+de6f7rAGPdozIhWLKMAP64vzRpiGwENYUvaovfLwhvRQiKxOEMRU0I18ubfYwYhRp2niow1JGQCKgivW+jSx+jkxCgiavicNp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526180; c=relaxed/simple;
	bh=mQgh00oTBEnPK3eaiUyErqe8gGMKiHL5sXNk/n6ICaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msoPTU2NIoE74TMenAUWjTfevcVuXbXnoVhXl8FIY+fUBaNb8SRKSDxi7Pen++p2mB07tfXsrMn3MyQAgfQ2yKhoMzeRwkDqQxgN+ldZIWnvOa67H2FXZvWK775sC/wwKmCgEOwI/pcpb9+AmtRqZqR5Z9inBmxnLYmpwgOOgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGZU3Ef8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC202C4CED6;
	Fri, 10 Jan 2025 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526179;
	bh=mQgh00oTBEnPK3eaiUyErqe8gGMKiHL5sXNk/n6ICaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGZU3Ef8D33bvTFUX/Tu2lXX4npAID97EObM21P4W+vsfHcYTVH9Qt4o+18iAeWc7
	 7+8up9z5xJj1tOzhINprHuhW8DGO8CaHO/utbP6vAj4NEuN2vMKZ5/iuud5yB8smDO
	 +sY1QsydT5KVI4C839eN1K91nD6/amLZKnmkKRbNSIzIJfpDdFn7CkhdH8u+LDO2/j
	 HyxY9Yejs1Y/1M1nZmZ2JdYd5RFQS4OQq69FcIkSa3Q1s30RYKw6KaDE8OxMwNgWgb
	 o+NWQQi/txTHozc/9RXdJeXpnJlluskdVyd+LTSLhzvdRzd3oE2hEkGoOz9RGi//Xi
	 lVT8XHiPC1bPA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org,
	James Clark <james.clark@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robh@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
Date: Fri, 10 Jan 2025 16:22:48 +0000
Message-Id: <173652065683.3245172.11665292685923367751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Jan 2025 14:28:55 +0000, James Clark wrote:
> Discard mode (Armv8.6) is a way to enable SPE related PMU events without
> the overhead of recording any data. Add a format option, tests and docs
> for it.
> 
> In theory we could make the driver drop calls to allocate the aux buffer
> when discard mode is enabled. This would give a small memory saving,
> but I think there is potential to interfere with any tools that don't
> expect this so I left the aux allocation untouched. Even old tools that
> don't know about discard mode will be able to use it because we publish
> the format option. Not allocating the aux buffer will have to be added
> to tools which I've done in Perf.
> 
> [...]

Applied driver and docs patches to will (for-next/perf), thanks!

[1/5] perf: arm_spe: Add format option for discard mode
      https://git.kernel.org/will/c/d28d95bc63cb
[2/5] perf docs: arm_spe: Document new discard mode
      https://git.kernel.org/will/c/ba113ecad81a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

