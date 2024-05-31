Return-Path: <bpf+bounces-31072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98298D6B65
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 23:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543EEB21BAA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1EC8002A;
	Fri, 31 May 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTDtW2XL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6F7B3F3;
	Fri, 31 May 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190102; cv=none; b=CEw6nf7qpUXaPvibDU858NX4CnAZIh0wJNyBLShqPCG/rWu3XifFgu5CJltUs0Kj14s9ZMGmRmOj1eNLnVWzSWHoFASzlFxVCSwuH1VuHJmBuxaOCkfafZ+iuuCMdSGnfa4c/1+KgmnBCT5IA0C/dTsP7vG8FhzPdBZfHbyusTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190102; c=relaxed/simple;
	bh=KEb6+OV/fl9i1+HKLnG1O/1KspKfwLiTTNvwjl6wlBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVxJkEAiUMUTrgjHuqS54lHtqHxPNKNr7LIGajOcvkKK1LPBVd5q1KzZs+gC3lLCTU9EbUFGw4ua8S2BM40tk99n97hi7EJxj60rjXUFF5JhugAdmTfFqpO5KCRXe4cV+k7QnuEYE1TaLdJ8giO97VRo1UZX9QInAYG16ASF3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTDtW2XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923ADC116B1;
	Fri, 31 May 2024 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717190102;
	bh=KEb6+OV/fl9i1+HKLnG1O/1KspKfwLiTTNvwjl6wlBQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lTDtW2XLiIQzfratrse5mUxeOLKlIGksktt8IbiYp2MV3k3sh+IDAF4U/AXo5RSG8
	 pg7X4SwPrQihyyVB/K2Zj2RH2/EXVSyTvLlgwJllyLvO3bkt+SuNo9axrsv1DsEuS/
	 e8daXEs2lKf0X/2a0brK8/kHGeGxNryMXFqMnsxe6qx5Z1QEFtwKUtUMmUV8gNKsQL
	 iJecWeX2vwcI3aNpeySxmTSVfLJb83X2LwxVcW4YRBXBrCmNTA5ihlnHf4gpT+vywh
	 NIuvDt2Gp4ZNxmBxCvdbsSpnxboDTqlxFekms4AwoHFpVCBmsB2anpbB7kS4u+37c4
	 1g9neM2Olezcg==
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH v3 0/3] Use BPF filters for a "perf top -u" workaround
Date: Fri, 31 May 2024 14:14:59 -0700
Message-ID: <171718991319.2179562.4988746622967425681.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240524205227.244375-1-irogers@google.com>
References: <20240524205227.244375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 24 May 2024 13:52:24 -0700, Ian Rogers wrote:
> Allow uid and gid to be terms in BPF filters by first breaking the
> connection between filter terms and PERF_SAMPLE_xx values. Calculate
> the uid and gid using the bpf_get_current_uid_gid helper, rather than
> from a value in the sample. Allow filters to be passed to perf top, this allows:
> 
> $ perf top -e cycles:P --filter "uid == $(id -u)"
> 
> [...]

Applied to perf-tools-next, thanks!

[1/3] perf bpf filter: Give terms their own enum
      commit: 63b9cbd7941aa9ec5cb61567042176c4ce04b020
[2/3] perf bpf filter: Add uid and gid terms
      commit: d92aa899fe0a66350303a1986d6dc7ec4b3a1ea7
[3/3] perf top: Allow filters on events
      commit: af752016340021d433a962063067e819dba889b1

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

