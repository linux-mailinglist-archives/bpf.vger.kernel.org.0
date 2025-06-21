Return-Path: <bpf+bounces-61235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466EDAE2AED
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E0D3B0977
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597CE2701D8;
	Sat, 21 Jun 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvgL/LTZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB0A95C;
	Sat, 21 Jun 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528885; cv=none; b=Ls+rxMKw/XFtwN+qqkcLyS7whKlCGX6UnmWcIDiQSTl69/NU/VnC6OZzZN0XZEAAxN2ZewncDwl7U1RQP3SV9/FLPVX7z7q2MWomFuRTWnL97TAdWBMC65rQUkJ80WM0VH/sEInuIPwo05x6hM9qBw7SUKjG7zEVf94yNwJ82Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528885; c=relaxed/simple;
	bh=bhrh3js7JNzbPmDM6DWidEWrZuj2loCkb4r9vta/ZNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HvK/NbxowUJvYxsDG+2s6C2NqNZT1LFMNpsptvrUMcOvBB+c3Qsll3L+MgOzRldT4rPYAc6K85VchVhdzm5c6NWCu8c8DbZWNPXG62nRCyRlzvekLdoqyOTJfg32IbU28XrFP47AGkd2FH/kQsjUT4lMvvddT+X2vXdXy/HmUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvgL/LTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9219FC4CEE7;
	Sat, 21 Jun 2025 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528885;
	bh=bhrh3js7JNzbPmDM6DWidEWrZuj2loCkb4r9vta/ZNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dvgL/LTZPYIUcvJrvcwlIHml0YNFSSq21xR7HAUh8O3iTuc8HAmi6fwyIYVA62Z7e
	 kN+9aZzA+03Kq0QvIUbP/HSDVZnaW+t3NxZ03bpOYk/ZxlM0kO8xmjVeXT2r3gXgLi
	 znA96J1wshwYfnrB+HrWVYBtLqlUenprwJzzkS76fOfEcMr9hpRtinBzcxf+PElDIe
	 3i9H62g7jD8AT58DkhuXoxYpxXguNa500gPqdXL8AINlFw7/M1NU230xZqDUm4U5LR
	 q+Xtm9zMbkSglHkpZ5N/GgS6Qy8Va32s92dzcBxxC25NzsQ36UQRa4pNkol3ym0MoC
	 JWTE1E7rc/F0Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Blake Jones <blakejones@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Tomas Glozar <tglozar@redhat.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Guilherme Amadio <amadio@gentoo.org>, 
 Yang Jihong <yangjihong@bytedance.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
 Graham Woodward <graham.woodward@arm.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20250612194939.162730-1-blakejones@google.com>
References: <20250612194939.162730-1-blakejones@google.com>
Subject: Re: [PATCH v4 0/5] perf: generate events for BPF metadata
Message-Id: <175052888455.2250071.10445782247610137684.b4-ty@kernel.org>
Date: Sat, 21 Jun 2025 11:01:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 12 Jun 2025 12:49:34 -0700, Blake Jones wrote:
> Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
> added support to the kernel, libbpf, and bpftool to treat read-only BPF
> variables that have names starting with 'bpf_metadata_' specially. This
> patch series updates perf to handle these variables similarly, allowing a
> perf.data file to capture relevant information about BPF programs on the
> system being profiled.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



