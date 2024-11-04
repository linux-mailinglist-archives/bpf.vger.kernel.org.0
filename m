Return-Path: <bpf+bounces-43911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E39BBC67
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134CDB21795
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D41C9EDB;
	Mon,  4 Nov 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzcKC5fL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8B1C8315;
	Mon,  4 Nov 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742712; cv=none; b=kFmGsHP2qnIIisgL7x22opLmhLBCdoOwiGtkBykIRZ6qOe3uRgqFtwlf0jPE6sb2JvU2q8NbnjTYCR8Aq3KZKyuPkKbIRG+YWouJpAEcqwsmXuiVKe3g9hgJrcHqso2/bK2e1R/lMgm70fwPUSNuM0UsFTbLbJ8hwDeLoA9GdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742712; c=relaxed/simple;
	bh=Gfm9SmyBOe5dDEm6FsMqPEiHJp/FRlkXrpYMnjGVGHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=buzSW2DwtqpeF30q1P09CFUWo6/6VauaNAH8dZ0/eag8Hix/YxJ8VCXZUCk95E+3Ci6S4LWZtIzoh04pZw0tHae079fADHI7uKnVpeOyA5sMge3/fEJ6OabZaSBZbnzoVkhYvmU17mHa4JlDmJ5cP+is+jZ/S4LzrGYu0007Wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzcKC5fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063C8C4CED0;
	Mon,  4 Nov 2024 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730742712;
	bh=Gfm9SmyBOe5dDEm6FsMqPEiHJp/FRlkXrpYMnjGVGHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dzcKC5fL+I+3XXmyw6V47JdMYWeUZuig3rXQqWtwBXS5hrXNb9VX4fTEgKI2bwG9h
	 EHOShi9+zPja1IgUU1q1dWMuWVldvs6PDYl/WGeitkXQuticwIdcCYjAP+4EddkBiL
	 BRT9RlbpNxzanHtflFbn+mgSS+lUOhL7QGmIDNflykfPdnYgNaf1rrgcCbobDQFb3c
	 OmPeTmmMn0gj1bAXjYzkd8s1f/vqgakJF63Y/b3vlootgXhRvxuwGbXpughM0l+5O+
	 P+plVMiMUJ7erscW5pUDf9K9GxdjB1qAYYzAeYWagevm8QKLX9gzlT6LWOEQhXNMf9
	 XNBU/E1sTf43Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, song@kernel.org, 
 Tengda Wu <wutengda@huaweicloud.com>
Cc: Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20241021110201.325617-1-wutengda@huaweicloud.com>
References: <20241021110201.325617-1-wutengda@huaweicloud.com>
Subject: Re: [PATCH -next v5 0/2] perf stat: Support inherit events for
 bperf
Message-Id: <173074271194.3826985.11091687571723568879.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 09:51:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 21 Oct 2024 11:01:59 +0000, Tengda Wu wrote:

> Here is the 5th version of the series to support inherit events for bperf.
> This version added the `inherit` flag for struct `target` instead of
> `bpf_stat_opts`, and also fixed the logic when TGID w/o inherit.
> 
> 
> bperf (perf-stat --bpf-counter) has not supported inherit events during
> fork() since it was first introduced.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


