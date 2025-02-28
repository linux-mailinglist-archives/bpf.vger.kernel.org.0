Return-Path: <bpf+bounces-52919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA8A4A5DA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BE51772F5
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915281DE89B;
	Fri, 28 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMhiwdTZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4AB1ABED9;
	Fri, 28 Feb 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781501; cv=none; b=PBXZNrbqNmdUWBZmvSDbeq+c7qqS0yY6kpXAa5hArb+qVg26HAGc28Z6oa1TNLsUv5aakv1OaQF8JZyY3XwZzcB4PAo/tba426TpO3Idp6FGJCAb5eLInQXpKcLpfHn5ZZ6tov4RDWKbAz57AVMsjMiu7gLawBf1M33STccbiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781501; c=relaxed/simple;
	bh=2kXlfnbhJgCCmcVwsge1o5c5OEeULnQ2hcMQRvr8CTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HTMAWks2IidMXF3/85GEtUtP7PvBsBw7EUxCCCHkEgLibL/O/oU1p0q/aiU94YAMB1Bh1s6mDNg7vYQ2825qfAQqMlD00pRqm7hzjF7VlTqIaaCDk4uoLZV72qswMIQR/XJdqdYdGtkOIjXDOB6+e92xSzMEm+Ohm+3ks2RakY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMhiwdTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CAC4CED6;
	Fri, 28 Feb 2025 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781500;
	bh=2kXlfnbhJgCCmcVwsge1o5c5OEeULnQ2hcMQRvr8CTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OMhiwdTZd3BznZHG6pj0df1Y1B3N0pDcHHTAlyZUjMivDhRckhe//SFNDBl4RijB6
	 LqXW8oKHEj3C1NtKjuczqFocTLcn7Q2KkVyYQgW1naKe4yr8y2UPXVV6ejzHM2ySOS
	 6eSQP99hmF8dwlzniIMH0AlcvT9qpzCPPkeA9a8DOIQAi0XtLAmV79QIJAOPWfaSoh
	 BtKPwuC7QVxvARY6MWU+OSO6YseDBuGEmxUt75F5/EivQdDa+MtaXFEg/zF/m/UQhQ
	 ps+NWxmYeDq4uloQwS3SvMIrEuxESULjcUghbphUDLO2ikT/Yjh01TkrOehtjIPaKB
	 BA6xNgfz7x1kA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 nick.forrington@arm.com, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20250227003359.732948-1-ctshao@google.com>
References: <20250227003359.732948-1-ctshao@google.com>
Subject: Re: [PATCH v8 0/4] Tracing contention lock owner call stack
Message-Id: <174078149997.322575.17228936303109215.b4-ty@kernel.org>
Date: Fri, 28 Feb 2025 14:24:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 26 Feb 2025 16:28:52 -0800, Chun-Tse Shao wrote:
> For perf lock contention, the current owner tracking (-o option) only
> works with per-thread mode (-t option). Enabling call stack mode for
> owner can be useful for diagnosing why a system running slow in
> lock contention.
> 
> Example output:
>   $ sudo ~/linux/tools/perf/perf lock con -abvo -Y mutex -E16 perf bench sched pipe
>    ...
>    contended   total wait     max wait     avg wait         type   caller
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



