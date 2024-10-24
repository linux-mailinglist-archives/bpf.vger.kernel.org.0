Return-Path: <bpf+bounces-43057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C59AEBBC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE41F242E8
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556341F80B2;
	Thu, 24 Oct 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nQC58c44"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178251AB6CC
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786765; cv=none; b=AU59HUFfspzSL+A/pQbse2xbJr5acs6k/gSXS1qGl08VaA2Ivd8MbQB8uJ/v3niunekmE0VY5ZqKKlrrTHfG0bFcHMUJ1GU03/NNNkwsH/RVZ2PaWSEVadPGNluwm3N3E/MZxpztUAjAZyEICRxmccs1D+J1XDjLi8RE8LQU8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786765; c=relaxed/simple;
	bh=475YnfWnYBje4bzVTPJzQFtKcIzA1DKqzv6pac7oe5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTG9hRsj7V2SdjAsrSj9XIex5v6rGzC1Ejlv2a09PDimJk/6o/LG3m468w1Eu/8FwTqc86BmlYnYWhEdHhMV3+3uhUUUmTTIb41ZfRuecSLHbsoZB38nWRq/ttu1VVrGpT1jpq7zEhzQI8e+IdrLJHHWLKsumrQoC5pj2aia6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nQC58c44; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b467be5f-6c18-4a4a-a669-0708fd9de2a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729786761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=475YnfWnYBje4bzVTPJzQFtKcIzA1DKqzv6pac7oe5I=;
	b=nQC58c44p1tiPt4bDeP7p/hczaqENfHVDbGJ2voLB/cGYAIHfjdSqoG11i8MYeVFEyH8Sp
	vSBClFb2gJUclwPyracbtZuRJgEITXZpLqQ+sjF304u1dfhBE/vdnyVra3JSdBDYzucsJ2
	KPGWpJHrpS2IQUdd1ogbZK31z7xoG18=
Date: Thu, 24 Oct 2024 09:19:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Rename CFI stubs to
 names that are recognized by BPF
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
 sched-ext@meta.com, David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/23/24 5:54 PM, Tejun Heo wrote:
> CFI stubs can be used to tag arguments with __nullable (and possibly other
> tags in the future) but for that to work the CFI stubs must have names that
> are recognized by BPF. Rename them.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


