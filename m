Return-Path: <bpf+bounces-23187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C319986E99C
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01511C21CAB
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838093CF40;
	Fri,  1 Mar 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB+yftRD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C83C699;
	Fri,  1 Mar 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321424; cv=none; b=Y64LIRerJofzw4jHebVz7QXkShGHjBVigTN/s/4dBQ5j20N6mYVunSZLsosPLMs6qp6bOHcRJeYKxjIcJIEC78U89d9BhKbRXMRHC05JQmKkDc71GUztelV4gYfxONTnlGNYh4ySQEMEagubAaxpJsIMgGmo5XwCCTZSgGyXsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321424; c=relaxed/simple;
	bh=nDzXcSLGBW1qmjkBvu5szXANnZ49BI0gVSIKl7PQxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsVH4FSm0laUpGkIByStWMLBnyL7nxf2gurMKtKsjvvHJ86B4IofLV2phAoQt9zlNiFrb2Y+Zd9CXaj4b6hnPGAuqXmCJKreCa3YkJoJ8y7JhLDpPWPS6zjvUBiDQ51MUzLpgFDSZo34AT9Gj24lR7bwTFHpLJm/GTMaD9O1rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB+yftRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166F5C433F1;
	Fri,  1 Mar 2024 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321423;
	bh=nDzXcSLGBW1qmjkBvu5szXANnZ49BI0gVSIKl7PQxWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WB+yftRDMXoV2Al5kHkT0CPaxuwR9ur+sq8PD6c6+GVselijgUAcUrxwTFIHndXnE
	 S99Wng1YV4UGymSW0hdp8oUmCqPzbVM+rhbwxbTFiKVixHsERpPgdENyhknj6MFLUN
	 pEqLHhgcLHJp/Y3OgkJkNLdKLA6Ld6aA87weFwquGO0O0fiftDzJr/P538K5GeLNYD
	 tD19QIcLeSGjsWM+kHyrzrRAUVjSVGdm6sgOh/mwnkKiocgre526GFt5AsjqBUf2NK
	 9LdURW3t/JX8ybx18vCNurvU228joARozDSOnxofsM65D34uJRs68BsAf4nPCmHz1r
	 sgqmSF8LRnbbg==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf lock contention: Account contending locks too
Date: Fri,  1 Mar 2024 11:30:21 -0800
Message-ID: <170932136988.3731358.12075871779065575043.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240228053335.312776-1-namhyung@kernel.org>
References: <20240228053335.312776-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 21:33:35 -0800, Namhyung Kim wrote:
> Currently it accounts the contention using delta between timestamps in
> lock:contention_begin and lock:contention_end tracepoints.  But it means
> the lock should see the both events during the monitoring period.
> 
> Actually there are 4 cases that happen with the monitoring:
> 
>                 monitoring period
>             /                       \
>             |                       |
>  1:  B------+-----------------------+--------E
>  2:    B----+-------------E         |
>  3:         |           B-----------+----E
>  4:         |     B-------------E   |
>             |                       |
>             t0                      t1
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

