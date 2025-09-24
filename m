Return-Path: <bpf+bounces-69500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2CB98051
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 03:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73D017FD2E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 01:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28551FC0E2;
	Wed, 24 Sep 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9V6+sh1"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C42C8CE
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678122; cv=none; b=WW3kGoc/TjFydG4lHm7mPZHqIp3ObDugyll7suLP8x87lz/javc6hTgkc44dsi4rZdk7FzfaUhTESS75uH/8VBJXk1NPp6MxWrg9bzyGvdJyDKgm+m6gWoolLonaVnVqJTzdWMN0lTf5HSnop1ls3C/8AdPOtqGMuH3yzkKJ45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678122; c=relaxed/simple;
	bh=cXs9Owtwm5o6WI/dGqnXnOeTUqhihC4uz2+RrT6ySqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMLcNA3CxniJ6gkFQtO0OVaCV4FNoi9O1kdUSYiVQHsxZE/sCVQgROzNCGY94ep4wk0XbClC+uxeyRnI4f5CMP2B2fiYLOYMXrh+g/odtdGb8kl68gLEZiAgNzcg1EFw30t7e7dxgsatlrb4oMajWqP+J8xPvGVJvV/lWm+q+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9V6+sh1; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87568a0b-93c8-4fc1-a721-dbfeda01d0bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758678108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hirYrJPjT9hxA6JxeStFs+VMmPTpuoEk/zkkhuulHMI=;
	b=i9V6+sh1ybXBPf1eF5EKPYHUlisYDpcAIkxaaYbHBabMJRgv1iMqkyyIZn7YLcYmk4KVhT
	lITCxeWnp3+iXR5e052+P4SPA8pw11coE/cTKn80at+0JxHCS0a4ypQ0YccaLrr7SZeCvc
	VHA4a1FtzAZprTZHAvromiU9Hqo5FjA=
Date: Tue, 23 Sep 2025 18:41:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 0/8] Add kfunc bpf_xdp_pull_data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250922233356.3356453-1-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/22/25 4:33 PM, Amery Hung wrote:
>    bpf: Clear pfmemalloc flag when freeing all fragments
>    bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
>    bpf: Support pulling non-linear xdp data
>    bpf: Clear packet pointers after changing packet data in kfuncs

Please follow up with a selftest for this change. For global func, there is an 
example in commit 3f23ee5590d9.

>    bpf: Make variables in bpf_prog_test_run_xdp less confusing

This makes the code easier to reason. Thanks. Applied.

>    bpf: Support specifying linear xdp packet data size for
>      BPF_PROG_TEST_RUN
>    selftests/bpf: Test bpf_xdp_pull_data
>    selftests: drv-net: Pull data before parsing headers


