Return-Path: <bpf+bounces-43668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D599B847B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 21:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30DB1F22F72
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 20:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F421CC156;
	Thu, 31 Oct 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="drkgFHgi"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E6197A6C
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407187; cv=none; b=rXnGreGbJdqqhbu8eWcymhovE2KIqJG6n6yW3mPv9UhOFyleFYwHP5wmP0fx/BXMtSUPUPemmim1XrTGyOl2ca2Iv3+F/u1rA+X045OTWE3n27BqJ2meW4vRI/D/o235hiBzRfy0MEwj3XaTYqn4JS4sCRFT6QlO6xXJCe06HS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407187; c=relaxed/simple;
	bh=pwQJMig8pqTMJYRWafVSMjffQIxCG7FoU2oK/45uC+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8eAQSGFZNSEsXQz4JTGP5dDyNP80qsNCFNXXaaem0rrjvT4lSeSUJIpZh///VlDEFaLc3csuo4pXGEMYLc7ws11PDN5lWhZy+eHiBRt55/rb/oW45mxXr2N2t7xEMraw7IkGNTHVox8gtRFzSs7DPl5A/0GZ7Fr/Umw248VyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=drkgFHgi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e03cfadc-8720-4351-a83b-cc8d4566f53f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730407182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwQJMig8pqTMJYRWafVSMjffQIxCG7FoU2oK/45uC+k=;
	b=drkgFHgi7h2weZ1Ltf7O1cbmKY7B/NIqjeXyGM1EzLZBbu4VPEX9XspbTNml+m4a521W5u
	+yb+pKpIVCPk/BAEb8pSbDWJQ1t9HXiayucaWATdMbYvB5Ev7RLc8vFG/cSzncGbbx4fof
	Ti3ByPDsHVHwTsIfoNkjR7K4/qumdgg=
Date: Thu, 31 Oct 2024 13:39:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add kernel symbol for struct_ops trampoline
Content-Language: en-GB
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241030111533.907289-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241030111533.907289-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/30/24 4:15 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Without kernel symbols for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces.
>
> For example, the x86 ORC and FP unwinders check if an IP is in kernel
> text by verifying the presence of the IP's kernel symbol. When a
> struct_ops trampoline address is encountered, the unwinder stops due
> to the absence of symbol, resulting in an incomplete stacktrace that
> consists only of direct and indirect child functions called from the
> trampoline.

Please give some concrete examples here, e.g. stack trace before and
after this patch, so it will be clear what is fixed.

>
> The arm64 unwinder is another example. While the arm64 unwinder can
> proceed across a struct_ops trampoline address, the corresponding
> symbol name is displayed as "unknown", which is confusing.
>
> Thus, add kernel symbol for struct_ops trampoline. The name is
> bpf_trampoline_<PROG_NAME>, where PROG_NAME is the name of the
> struct_ops prog linked to the trampoline.
>
> Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

There is a warning in kernel test bot, please fix it. Otherwise,
the patch LGTM. I also tried with one struct_ops example and it
does show full *good* stack with this patch, and without
this patch, the backtrace stops right before trampoline symbols.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


