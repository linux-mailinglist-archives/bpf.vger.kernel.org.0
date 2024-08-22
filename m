Return-Path: <bpf+bounces-37805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4195A99E
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555571F21A66
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA0A933;
	Thu, 22 Aug 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r4bhtL1y"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A2C190
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289488; cv=none; b=daOtgssKMmk7AbHY+xlC9m/2dWT84lR38Vn97iWWWrmp7qlsuwa/egTEY6tUhh+gSaVK+8nPo1P8AKhNVAsZfBFFLXVZgUNaEP4hsk+SuqOuSx6sPrquwXhAxB/vXN5llrfNsxb4msEsUF1ksZVG482G6QVapLtGvygK64Ro+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289488; c=relaxed/simple;
	bh=7qRBuaN1wFCHCgvPDXkV1THCCAsO/9MqlPxLejEoPmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmqS3ikYDCTYVIcPGDJ7QRwQKpf2CTD6Y6qb+hgXDRJiJC40JafzD7sMoGiGFk4wo/vvHXWSfc29NAA6Ky4RjnnVHKIc2BHJ09RoM5SU8/boZpFqK2zdWSo54KJ2uqfzvoongBR+JKs0qYv7Ql58HhLpVZ2c5PeUcUmrfT+oos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r4bhtL1y; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19598881-6347-4f8b-b9f9-825366e0e536@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724289483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXIMYQPVp0/YHbgk31D6G+wa32vrbcYmGHZcF3ADPLM=;
	b=r4bhtL1yHiJ5JuMujWGXMHAgYHlpYFIh4WXMWb8luZ/0f/kW/ogNSoqNBg34HhzthyISde
	k0BmzsoW53yMcukd9Iu03Jj54+bfOideYYS8L+O6Fjcc9MErKSSqo7V9y4M7ZwYQEbm+b/
	tDY8PO4M6Ir2UiPgLO6c14ZTgQzf98o=
Date: Wed, 21 Aug 2024 18:17:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/5] bpf: rename nocsr -> bpf_fastcall in
 verifier
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, jose.marchesi@oracle.com
References: <20240817015140.1039351-1-eddyz87@gmail.com>
 <20240817015140.1039351-2-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240817015140.1039351-2-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/16/24 6:51 PM, Eduard Zingerman wrote:
> Attribute used by LLVM implementation of the feature had been changed
> from no_caller_saved_registers to bpf_fastcall (see [1]).
> This commit replaces references to nocsr by references to bpf_fastcall
> to keep LLVM and Kernel parts in sync.
>
> [1] https://github.com/llvm/llvm-project/pull/101228

Let us change this link to

   https://github.com/llvm/llvm-project/pull/105417

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   include/linux/bpf.h          |   6 +-
>   include/linux/bpf_verifier.h |  18 ++---
>   kernel/bpf/helpers.c         |   2 +-
>   kernel/bpf/verifier.c        | 143 +++++++++++++++++------------------
>   4 files changed, 84 insertions(+), 85 deletions(-)
[...]

