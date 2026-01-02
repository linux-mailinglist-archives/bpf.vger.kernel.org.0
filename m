Return-Path: <bpf+bounces-77688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 935BECEEDA3
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10B01300E7F2
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1526E706;
	Fri,  2 Jan 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDb6Smp5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584923A9AD;
	Fri,  2 Jan 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367270; cv=none; b=JlJpvoOUju6Nq9BxhHR8Hsi/+7v2HP+g5M+1W8BfDExV7FuAfu0ixVermvg2a68tlYIqdoRxtBh+EeaPJs2CxFq2FkeETxTWCTo4uTV8e0vtAGTN8V/9LVtWvl0qbWsEPZRWQu0CzGUmKPdRcogtiq6EBARe7QHWYTNV/x9K4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367270; c=relaxed/simple;
	bh=pMXCQW12wPyvlfidixRLtglysi2HvG9+Wl6UmWXVbTA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bDQrIFKZtisMA11HyAuzQDFTnrsG6ZfzqWjfEYnHxBws1PrTooJhHp/ZjGpdUN89YOS3FkcNe8TEXlG+uwATLZFYM+O+nQFGFmiNYOx0mc4rw+wtCxscP2zFgr1Ty110foommqpz2Zy4WUBAKBF4DnaYkcWGTd8o7oEkHNmK5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDb6Smp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27EDC116B1;
	Fri,  2 Jan 2026 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767367270;
	bh=pMXCQW12wPyvlfidixRLtglysi2HvG9+Wl6UmWXVbTA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZDb6Smp5r1qwHf5O207uvXnwSlFpojpN3A/HXVReK3KkTSOxHLxMEQ/j2WMrJuMiy
	 n+Zei+fXQ07vbkh2w7l57kLDGDVkAeR46Dxkc61yPQ1a/8ihN8C76oCCwF9x8HepVZ
	 lrScZ1Ro6BJO/3boeJ3Zfpg0U/krYZ3Y4R78M7TaEBgQoRPoNVQcDjjKE7TfMC5RXj
	 MQxgeoAB5KWO0fw+Ml+h6bQJYmD+GlqbxArV4vrHdv06E5tkyYP5JCeiEUfinYrtBF
	 weDu5tMwWpipFifeMpWkwFz63wZSAevA5pxIRchyKKGVaenyfmrg2KpYDV+FLjYZUb
	 c8qh6H96DdwnA==
Content-Type: multipart/mixed; boundary="===============7827669722571794812=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45f1e1978b7dc28e522dcc0a72954d892b37a85220749bd027c7395edb01d991@mail.kernel.org>
In-Reply-To: <20260102150032.53106-2-leon.hwang@linux.dev>
References: <20260102150032.53106-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 1/4] bpf: tailcall: Introduce bpf_arch_tail_call_prologue_offset
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,catalin.marinas@arm.com,will@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,akpm@linux-foundation.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,leon.hwang@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  2 Jan 2026 15:21:09 +0000 (UTC)

--===============7827669722571794812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b317..beedd1281c22 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -127,6 +127,9 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>  			array_size += (u64) max_entries * elem_size;
>  		}
>  	}
> +	if (attr->map_type == BPF_MAP_TYPE_PROG_ARRAY && bpf_arch_tail_call_prologue_offset())
> +		/* Store tailcall targets */
> +		array_size += (u64) max_entries * sizeof(void *);

Should array_map_mem_usage() also account for this additional space?
Currently array_map_mem_usage() handles special cases for percpu arrays
and mmapable arrays, but has no corresponding check for PROG_ARRAY maps
when bpf_arch_tail_call_prologue_offset() is non-zero. This would cause
the reported memory usage to be lower than the actual allocation when
an architecture implements this function (e.g., x86_64 and arm64 in the
subsequent patches of this series).

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20660615603

--===============7827669722571794812==--

