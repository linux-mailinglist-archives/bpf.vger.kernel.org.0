Return-Path: <bpf+bounces-69032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922DB8BB31
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286E8A07FEF
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5960142E83;
	Sat, 20 Sep 2025 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f572Tngh"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EE20966B
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329012; cv=none; b=OiJF/BYaw8fVCmtcvqi7Aj7I41anM3hD8mXhWxPLruu1BJAfD/MCaTHKC8x96j+NAmFALJoFhhsWUYB6FxHCqe5C2eg40qNAeldgdi4cZX/f1u19CEgbDw+asnaQ+TYxNl2+p5x55VQRXc1l+eoX1bhuiwYzOCW5qCQkcNbvmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329012; c=relaxed/simple;
	bh=WSem02O4QbxGCk+Tpcch2QGxe+XE21JzsJeFesvMpaQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=faB5ukvBOeyA14ZHo8yKMeTt6fclErZA48+fhmuNgjOOHwiTg0mdO83+Uu9mv0q6nkEzYU0l6suJrcCeuJCoGcFvUHFXttkhm2NlnKgaWpsppOqvt2S1ZiDrePfa1yer0OUEmdbddKGtuETmMXpAKGzHsXFXrYI5S4Z2pFrNqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f572Tngh; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758329007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnYZGpohqWkG2zIx8rYyGxu/tToNURYK9pWxDOhfsmk=;
	b=f572TnghSiUH0K8/gH2b0H97rN5A8oGSMxlM33r+Ao68pdlowG13dNK9H/h0M6PFy12rQ0
	9DuG/ZiOa6BCrJnhBMLZq2qcVdAXqsDSLacH9fmPh+T1CZIeyt3GzsvlY+AKHxTNU6OK3g
	1ZUteZjHHc5/vlRBuZUKDaaouDxtgZo=
Date: Fri, 19 Sep 2025 17:43:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1] btf_encoder: move ambiguous_addr flag to
 elf_function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: alan.maguire@oracle.com, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
 eddyz87@gmail.com, olsajiri@gmail.com, kernel-team@meta.com
References: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/19/25 5:36 PM, Ihor Solodrai wrote:
> Having an "ambiguous address" in the context of BTF encoding is an
> attribute of an ELF function, and not any specific DWARF instance of
> it. Thus it is redundant to maintain this flag in every
> btf_encoder_func_state, and merging them in btf_encoder__save_func().
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  btf_encoder.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> [...]
Hi Alan,

I've just noticed that you merged v2 of "btf_encoder: group all
function ELF syms by function name" and not v3 [1] as I expected.

This patch is essentialy v2->v3 diff merged into current next.

vmlinux.h is identical between this patch and pahole/next (09c1e9c)
for a sample vmlinux I had at hand.

Successful CI checks: https://github.com/acmel/dwarves/pull/70/checks

[1] https://lore.kernel.org/dwarves/20250801202009.3942492-1-ihor.solodrai@linux.dev/

