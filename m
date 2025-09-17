Return-Path: <bpf+bounces-68691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787AB81634
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F61D525E58
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623502FFDFC;
	Wed, 17 Sep 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FlgltKSM"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377387082D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135021; cv=none; b=fxuq3UJH4wzP7viqZNLcATrEGw7IFd16ButFGN6ByBN2/Gg6iWssfLtf7tAchf+wK8wrhbK4+Z29M310TIeR0GUN2JzOVzNaR35GDkxdiSMySA0fdTgYdofSzgTrNQ+nFy8LQWEYT1GNpuju+zxRHii/kR5ED18pmbOs5BZ53uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135021; c=relaxed/simple;
	bh=+G2pHkGuiFtfIeNrHcTxCuyP/hEVUCpixjmbnjjdoQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1Vd2P9S/g2JUy/ygI8leUOxFcLE1k8oPi0Y163gq80LNCUIrP7sj+BEbNww6VuIbU0HnsCyouujJ2n4X7pyWiSSA/YlfUEL241MledomNIfDgCGaYEUrx2Po7SBJgjhN5lxk099YqPOj4juGMQxB2hNyGMhQDKs3Ipsl0vBSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FlgltKSM; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9ce1249-f459-440f-a234-bdb8dd4238f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758135008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtTtBGy4mtC2umScrIKAzq3ycxOTkYBHIjn59WkwjOU=;
	b=FlgltKSMOhyTz8KaMG6ZaPVWDhDgDHJNElwgggqZRgI2Q/+xlU1hCMOlRxf3xuk5Y1PnVd
	CU4r6KwDwAipt7KFD0u/GxT0b/m7iVXIBlTZBkJqUhFUUnyP1rSF/PxahUrcvgaYAG0HnD
	jWD+mSG4leVdetAfqCORrZDGVuVYC2c=
Date: Wed, 17 Sep 2025 11:50:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/6] Add kfunc bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250915224801.2961360-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/15/25 3:47 PM, Amery Hung wrote:
>   include/net/xdp_sock_drv.h                    |  21 ++-
>   kernel/bpf/verifier.c                         |  13 ++
>   net/bpf/test_run.c                            |  26 ++-
>   net/core/filter.c                             | 123 +++++++++++--
>   .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
>   .../selftests/bpf/prog_tests/xdp_pull_data.c  | 174 ++++++++++++++++++
>   .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>   .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--

I think the next re-spin should be ready. Jakub, can this be landed to 
bpf-next/master alone and will be available in net-next after the upcoming merge 
window, considering it is almost rc7?

