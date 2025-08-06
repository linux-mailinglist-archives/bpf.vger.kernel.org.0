Return-Path: <bpf+bounces-65158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9EB1CF3F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 00:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D3A567C4F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63795233713;
	Wed,  6 Aug 2025 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVbWCavC"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F73634
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754521172; cv=none; b=pRh7qdCacCGjHEZEvkoBlEZIJdT/X9B+F0Jq5amgzNY27EmR9wG/J0g65ShH/wkeWXmfQ8spRDuMOqfOFVOGpmWc9kMTduXV+KJfPE0s1854e/milOfm09KnI657DGKtjemlcP4gPHC4Q2cEnSnPcNINR5/9AaLycLIqAs3JUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754521172; c=relaxed/simple;
	bh=Fwf9iuhc0toFLOYtLLmLXDF7MhRTI3hMMWHKbGUl8EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dWXOwBoDClqFF6wc1gEYgHQEOdBo0GOSLSOL1h9TMvZsfzEsMr+xI6m8wMaZHEdVbJ37/ARDABXvbl+v53Rx8ECGUMMrQMberzF8+QwtQUv9SD9zcRb5MxQ6hsu6MDvJylJe79aGdQW7Kz/gleIY6bOb7Fc9gogy7lmADWQMRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVbWCavC; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75940147-d026-485c-b7fa-fa769bc6e82f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754521166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fwf9iuhc0toFLOYtLLmLXDF7MhRTI3hMMWHKbGUl8EM=;
	b=WVbWCavCg03Ij9qyFhXOD+n0JrBWa90zPhk672C/LMlJfShju1lvRHxitqhvTV+8LcOcmv
	R92WO24FiY/tjK0KTDjcLUySLNjGiL96RMH4sq4G64+Q2NNQbWuOV+zjNLLJx6MszZeKmW
	cuVN0zunrnzKnWO4FxfVgTM862WUJic=
Date: Wed, 6 Aug 2025 15:58:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: arm64: simplify exception table
 handling
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
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-2-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250806085847.18633-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 1:58 AM, Puranjay Mohan wrote:
> BPF loads with BPF_PROBE_MEM(SX) can load from unsafe pointers and the
> JIT adds an exception table entry for the JITed instruction which allows
> the exeption handler to set the destination register of the load to zero
> and continue execution from the next instruction.
>
> As all arm64 instructions are AARCH64_INSN_SIZE size, the exception
> handler can just increment the pc by AARCH64_INSN_SIZE without needing
> the exact address of the instruction following the the faulting
> instruction.
>
> Simplify the exception table usage in arm64 JIT by only saving the
> destination register in ex->fixup and drop everything related to
> the fixup_offset. The fault handler is modified to add AARCH64_INSN_SIZE
> to the pc.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


