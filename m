Return-Path: <bpf+bounces-48698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F44A0BA35
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023DD1888EA7
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC320F09D;
	Mon, 13 Jan 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjGQw4qr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D91FBBCA;
	Mon, 13 Jan 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779556; cv=none; b=go540K5LhMOkYZZXO5qK6g86VPOy4W78QJnh2eO0jZpWpJD77HNCxGYtAi55fyiM6RCIzgP3sc635TUdiHDjAXQQAIkYlx5wqgVO2e1VRG75nno5UsjCmfzOvveqchJeRUr9l1cK12Pp2jZKlscCbvQznwQ0ryUbJGHTrtPADXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779556; c=relaxed/simple;
	bh=4Vujzbm4kNtV5/o/KXPggv4nUMTIKxP0LOJAZ9i8Z+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9rkQT9jd0xAaiZ03c5Vg2yzWypXSDD+A3TPPvephhS8lfo4eO2QKr9VfeFLvTHBM7EzrAfGq6xyO2/qohddZFzt0UeCLQa0O8wP6HEvB70+IfGXaHiZKmFIkqxgJ+oE+EubzhnW5p6s7BKi9MrE5APHKF+Y5u4TNPoVDFfRWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjGQw4qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543CC4AF0B;
	Mon, 13 Jan 2025 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779556;
	bh=4Vujzbm4kNtV5/o/KXPggv4nUMTIKxP0LOJAZ9i8Z+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjGQw4qrc+25VwrU5o7c9G3d/cR+3CwDJHhEQLzEagi/U7UsotaPFVUfY5mHihKPM
	 ukP5fL2SRcmpEtGWyI5yFsXX8LS09ahNaQE30YcFWnTS4U6dGx3OhImPgnoSir5OL0
	 fSkkiFeSOy1h5QOSf2yTbdTDuVCT73Hpy4bnFcS8qSWoFm2Zkssdqb3/L9cbdcX7+q
	 AYbcvhxZA+tV+1TqTQcGkiWDwG5SHCgshXTJj05m0o5U9yGH0jjEQkaMmK16Ic3ovU
	 M3F6JXJRcgdrURmFSPsuUuQRuZXpOPAicnrl91k9kRkz3AgC0XIE5+EjEhwXNxXgoy
	 Bz8YtOupu7h4Q==
Date: Mon, 13 Jan 2025 11:45:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
	irogers@google.com, yeoreum.yun@arm.com, mark.rutland@arm.com,
	namhyung@kernel.org, James Clark <james.clark@linaro.org>,
	catalin.marinas@arm.com, kernel-team@android.com, robh@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
Message-ID: <Z4UnIH8SXQC7kGXL@x1>
References: <20250108142904.401139-1-james.clark@linaro.org>
 <173652065683.3245172.11665292685923367751.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173652065683.3245172.11665292685923367751.b4-ty@kernel.org>

On Fri, Jan 10, 2025 at 04:22:48PM +0000, Will Deacon wrote:
> On Wed, 08 Jan 2025 14:28:55 +0000, James Clark wrote:
> > Discard mode (Armv8.6) is a way to enable SPE related PMU events without
> > the overhead of recording any data. Add a format option, tests and docs
> > for it.
> > 
> > In theory we could make the driver drop calls to allocate the aux buffer
> > when discard mode is enabled. This would give a small memory saving,
> > but I think there is potential to interfere with any tools that don't
> > expect this so I left the aux allocation untouched. Even old tools that
> > don't know about discard mode will be able to use it because we publish
> > the format option. Not allocating the aux buffer will have to be added
> > to tools which I've done in Perf.
> > 
> > [...]
> 
> Applied driver and docs patches to will (for-next/perf), thanks!

Picked the rest and added it to perf-tools-next,

Thanks,

- Arnaldo
 
> [1/5] perf: arm_spe: Add format option for discard mode
>       https://git.kernel.org/will/c/d28d95bc63cb
> [2/5] perf docs: arm_spe: Document new discard mode
>       https://git.kernel.org/will/c/ba113ecad81a
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

