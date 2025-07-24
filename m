Return-Path: <bpf+bounces-64288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25ACB11022
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A1F1884B67
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA71FC0ED;
	Thu, 24 Jul 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3eqHIPl"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD022083
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376647; cv=none; b=CONn8Q2FABInBhoy1GFfgqTXK3xf6nOnckbAD1KU+mpCH90gU8cow3pqFuuDR6IgNf5G8vbsgI/AmFYoObH9HWJ9O0lQ65MHbLdqZ+SIedaiOPBAw7QWSd8gByVA8N91Aj4ekOYlxGgaS0GtJwXuxAPiAU+1Sjoz8dLnvZyXZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376647; c=relaxed/simple;
	bh=XEY3oVsTmzptmVo3oaTaITHMrJH+Q1e9VoRDX2WWuO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=liK2EHRouJWPVv6icK3A32WDmbQ+qWoEllNubOU4cxXnaQwRo6R7S9LeTxzH9C+1S4tSlXb+LPsu9ZFuo3Pq6Ruu+iLUdktEABaPpcbHgzi6sMg4PCUv0Nmij3sgU2NyfUOywq/4TZ87YFzvw5qdzd7wB4Ozwim2HIKjCuYloAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3eqHIPl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <473786e0-4b25-499f-82c0-adc54aee5fd1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753376643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRs90u5hRpQzrEjixv7oNnzyO2PDdFON0S0hqRyw8kM=;
	b=R3eqHIPlwg3ey/2p5D/TWE1KffYdqb8Szhh1olNsqoVUnhUwLgpmhsqiWEgAI2aM6BlFG5
	Z+/01noOuxOgqGnmh6oKS6mvvZLZFyH+3+zfUzDSLKRFki80cBF+O+gORtEY3KDqVoQtC+
	tMMNfEGWuNRueAxBSD44UiRSMeyefGg=
Date: Thu, 24 Jul 2025 10:03:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: enable private stack tests
 for arm64
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org
References: <20250724120257.7299-1-puranjay@kernel.org>
 <20250724120257.7299-4-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250724120257.7299-4-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/24/25 5:02 AM, Puranjay Mohan wrote:
> As arm64 JIT now supports private stack, make sure all relevant tests
> run on arm64 architecture
>
> Relevant tests:
>
>   #415/1   struct_ops_private_stack/private_stack:OK
>   #415/2   struct_ops_private_stack/private_stack_fail:OK
>   #415/3   struct_ops_private_stack/private_stack_recur:OK
>   #415     struct_ops_private_stack:OK
>   #549/1   verifier_private_stack/Private stack, single prog:OK
>   #549/2   verifier_private_stack/Private stack, subtree > MAX_BPF_STACK:OK
>   #549/3   verifier_private_stack/No private stack:OK
>   #549/4   verifier_private_stack/Private stack, callback:OK
>   #549/5   verifier_private_stack/Private stack, exception in mainprog:OK
>   #549/6   verifier_private_stack/Private stack, exception in subprog:OK
>   #549/7   verifier_private_stack/Private stack, async callback, not nested:OK
>   #549/8   verifier_private_stack/Private stack, async callback, potential nesting:OK
>   #549     verifier_private_stack:OK
>   Summary: 2/11 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


