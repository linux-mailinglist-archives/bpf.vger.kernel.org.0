Return-Path: <bpf+bounces-43058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F479AEBC2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A428116A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C061F80A6;
	Thu, 24 Oct 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aLLZzL1S"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30901F80AD
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786801; cv=none; b=WqgQrAilOwiHuVw2LFiC24oQKZfqJloOK5HLRZrsbo1rsS76jDabwWzjaRursuHkC/kdUmPMnMfJwnpDZv2Ye+v6JxY8smQonyy+3hkU0XqMUJvPeaq2yVzUJ+hxqQXlJrwp2Yf3WtedavEJc1+W8zYoYfisjKSRlwOdJQZ3a/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786801; c=relaxed/simple;
	bh=Zm1jVU2tfw8vmS2m5TOFDEtxXSeEP7qw2Q0PtzxL9Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9AkiiGVnXoBnM/6odoR5+IpwYjRSm+C/6djHOt0wQ57kqLaQ8Xv1NJIkVJFd/RpzWx2yMJWEtoc4NIXOf0jR4NvDqZCup93G7Eoh3GugHU/5Tk62Xhz0GJxedI61jm6b6Rdxj8+LA6Q8Bf1axmjdaH2q6hdpCyJzZ1WrD/t2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aLLZzL1S; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b4fbfec-8315-426c-8c7b-9280726558cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729786796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zm1jVU2tfw8vmS2m5TOFDEtxXSeEP7qw2Q0PtzxL9Xs=;
	b=aLLZzL1S6L0jyZAy8jW1OikUAXqYDxR9d/VW8+6uiC5nvj5enWf48yI4qt2SfEJ3rpEctk
	TwDwcuFT/DTYufCmrE9BvlWJzqxWITEJXFM+WLBVY+ZEOf69ZR3sVFRgLxyGCKOuQS2bh2
	LvVrA7CNXY4+7yjGPRpmJVyQm3Uk+xM=
Date: Thu, 24 Oct 2024 09:19:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH sched_ext/for-6.13 2/2] sched_ext: Replace
 set_arg_maybe_null() with __nullable CFI stub tags
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, David Vernet <void@manifault.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, kernel-team@meta.com, sched-ext@meta.com,
 linux-kernel@vger.kernel.org
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
 <Zxma-ZFPKYZDqCGu@slm.duckdns.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Zxma-ZFPKYZDqCGu@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/23/24 5:55 PM, Tejun Heo wrote:
> ops.dispatch() and ops.yield() may be fed a NULL task_struct pointer.
> set_arg_maybe_null() is used to tell the verifier that they should be NULL
> checked before being dereferenced. BPF now has an a lot prettier way to
> express this - tagging arguments in CFI stubs with __nullable. Replace
> set_arg_maybe_null() with __nullable CFI stub tags.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


