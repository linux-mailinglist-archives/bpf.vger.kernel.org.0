Return-Path: <bpf+bounces-60441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AFBAD6647
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233751BC17DC
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDF51C84A0;
	Thu, 12 Jun 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DRrkFieR"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287654690
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700390; cv=none; b=TNqI+7eaXzX2sGnbFzbqJQteHA6DP19fxGTl4oq52hqa/Qwf+nkseIH+sFlqY8O/NdK/baHM7JgkVpVeXF0KKZK7ZYdL46N34xIkbeai4OR39iRhmgTDZzsmItpR1y9cQYtw/eUdWSKw3GU6WTnCUzBkIDNH7VGoDMZsWiPaVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700390; c=relaxed/simple;
	bh=boTdffM0YY6LvJ2vrbVdysstNGHA2kq/Qx89g7cwAeo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YDt79ZKe8EFFmr5kWP8dFFdcvvQnUy1vETAArYDKhVfUo4bAuFIh83B+vrszUqqb8q+xcbsBLR31vf8p0Cwxz7cM77IAQi1jeXTGo1f7PseAVVCZt8Flyc6ae73rV6WaENPqQED2PFKFeLzHropaRFXkBqfVJHShHrLxQqQ4JwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DRrkFieR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e680ab0-f4a2-410b-9002-e34442211f0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749700385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBxsMBbj0m54LEZ+PcWOe/40CWnDBHCKbkzHyXZuItI=;
	b=DRrkFieREkEfu2CX1wLFGy0jm52//Ha2ftpLrqygTVqidOC7E1FNfo3FVi1y2Ys8qpus7o
	YA+k8X8rBK3Jhpw0qGhfAbZANnmg6R0WWDAsk13SpRcB1WbqymdYn17qWCwccjSkr0r1JD
	Jz6Jg3RBi2XUNqLRVWL3nte4QKdumQs=
Date: Wed, 11 Jun 2025 20:53:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix a few test failures with 64K
 page size
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250612035027.2207299-1-yonghong.song@linux.dev>
In-Reply-To: <20250612035027.2207299-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Sorry, missed the below small description:

This small patch set tried to fix a few networking related test failures
due to 64K page size. Please see each individual patch for details.

> Changelog:
>    v2 -> v3:
>      - v2: https://lore.kernel.org/bpf/20250611171519.2033193-1-yonghong.song@linux.dev/
>      - Add additional comments for xdp_adjust_tail test.
>      - Use actual kernel page size to set new_len for Patch 2 tests.
>    v1 -> v2:
>      - v1: https://lore.kernel.org/bpf/20250608165534.1019914-1-yonghong.song@linux.dev/
>      - For xdp_adjust_tail, let kernel test_run can handle various page sizes for xdp progs.
>      - For two change_tail tests, make code easier to understand.
>      - Resolved a new test failure (xdp_do_redirect).
>
> Yonghong Song (3):
>    bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than
>      4K
>    selftests/bpf: Fix two net related test failures with 64K page size
>    selftests/bpf: Fix xdp_do_redirect failure with 64KB page size
>
>   net/bpf/test_run.c                            |  2 +-
>   .../bpf/prog_tests/xdp_adjust_tail.c          | 96 +++++++++++++++++--
>   .../bpf/prog_tests/xdp_do_redirect.c          | 13 ++-
>   .../bpf/progs/test_sockmap_change_tail.c      |  9 +-
>   .../selftests/bpf/progs/test_tc_change_tail.c | 14 +--
>   .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
>   6 files changed, 122 insertions(+), 20 deletions(-)
>


