Return-Path: <bpf+bounces-21806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382FB8522D9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD20284344
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DB150257;
	Mon, 12 Feb 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rbLa3Ip8"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66C4C627
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782348; cv=none; b=Jrogzt++Z+lqelIWrxt+SVA7NEXvgB7LXI4nE8bu6hhpL+MJIUyVMc1BprCTsIhBt9NWlWfI9d+AQLHnDQORXejUad+GPATfl/uD6ehIinctSmZvsqCf9gCSJyMzUl17hLueBtNpBMwEVyfnKRpiwwDs5y8sO6x7bOANDhEc6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782348; c=relaxed/simple;
	bh=SBU2H+v18I6ht4fWaKdW2ufZYdcfuLzNzyHVqCemNXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byyOPRncwbXOgj//Ks5bezfrBMhswI1Ixfv+zOSwHX4rOuVMEEiDKCQlf9zXmFaA7FLFSQ1WA6DdE38x1+syRXm1OvWmvpAtUc/GkVUrpME3Nf2yOarHuqvWh+WHeHTKMuDXostrimt4YQxqxWWHOI79LLbzgb26uq6nxs1PXKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rbLa3Ip8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1837f55d-687e-470c-9911-dfe5d11a4f09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707782344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACT8teUH7ERm4sU7+LoPbXqECyHrcO+i4ZI6J1GvH4U=;
	b=rbLa3Ip8tCMh1AoaMQfIJu6j1EWDlL+zJzmUkdaVfH4ndKt/WAgchUHAksDUWeqHdkoDBu
	gYC/gSOMWz5cdPM4HVlemmsonZeErx+C3YG7UzfHGJHuR1ig+NCNX6mq8ocoCATQ7Cm9v5
	T3VcCVE0feZ8shJw5R63fa9lxIpDEBU=
Date: Mon, 12 Feb 2024 15:58:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: update tcp_custom_syncookie
 to use scalar packet offset
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, kuniyu@amazon.com
References: <20240212143832.28838-1-eddyz87@gmail.com>
 <20240212143832.28838-2-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240212143832.28838-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/12/24 6:38 AM, Eduard Zingerman wrote:
> The next commit in a series fixes bug in bpf_loop() handling.
> That change makes tcp_custom_syncookie test too complex to verify.
>
> This commit updates tcp_custom_syncookie.c:tcp_parse_option() to use
> explicit packet offset (ctx->off) for packet access instead of ever
> moving pointer (ctx->ptr), this reduces verification complexity:
> - the tcp_parse_option() is passed as a callback to bpf_loop();
> - suppose a checkpoint is created each time at function entry;
> - the ctx->ptr is tracked by verifier as PTR_TO_PACKET;
> - the ctx->ptr is incremented in tcp_parse_option(),
>    thus umax_value field tracked for it is incremented as well;
> - on each next iteration of tcp_parse_option()
>    checkpoint from a previous iteration can't be reused
>    for state pruning, because PTR_TO_PACKET registers are
>    considered equivalent only if old->umax_value >= cur->umax_value;
> - on the other hand, the ctx->off is a SCALAR,
>    subject to widen_imprecise_scalars();
> - it's exact bounds are eventually forgotten and it is tracked as
>    unknown scalar at entry to tcp_parse_option();
> - hence checkpoints created at the start of the function eventually
>    converge.
>
> The change is similar to one applied in [0] to xdp_synproxy_kern.c.
>
> [0] commit 977bc146d4eb ("selftests/bpf: track tcp payload offset as scalar in xdp_synproxy")
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


