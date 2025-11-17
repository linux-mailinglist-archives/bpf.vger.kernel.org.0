Return-Path: <bpf+bounces-74773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADEC65BB0
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4E27629415
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97968314A84;
	Mon, 17 Nov 2025 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UBFrOCG8"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A17258EFC
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404346; cv=none; b=URb8eoheUPIV7GvtU1ooFXxdkqktFHjeQfJXl1WnoUXIHyg4VRbH4ffPwcAgR3fvVeQuvUHKv9IRldxyj+8oEPzc8/KgNwyxvdjSx6R/BsXMckFHegyb8JY2ISt1dPRaNKEAaSPEa7T37gBPqPoTcgdmI4TiuemGK//cCl9yXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404346; c=relaxed/simple;
	bh=9Ha19C7jN7rJ27z3B60YznGAmAB6V8gFVZgovYD2sB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5kFbwt8I12n+TOKdjzpLzzYwvkhsFAr0NvY/XiPDjlZnml2piy9fsNoSbUCk48JeurV/p046o//IhRiVNFzUbSrToURETtC+LuLJIeAUN1SPhJoTdis07woK6gqyXQE5Jk+wJdUMPjX+9BWKlPpQ5p+dYMLW/lf3aQXPCdHgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UBFrOCG8; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ff1f67a-8684-48e9-a343-2546707eef75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763404340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ha19C7jN7rJ27z3B60YznGAmAB6V8gFVZgovYD2sB0=;
	b=UBFrOCG8plmnQ70N8ld9tdHYaykl34b5gbZ7sd8w8zHzL0Eils+VRqYcr3FJ9ry887D3Xp
	iazcm3I7YlpoX7Gm+Uyu/fkAg+iZA7C1XfCcV7jiE/yTiOSw55q0DIOnyiGO1fX7YzYidS
	g99F4D1L01+EHtCUbKcG5xlqdelu3p0=
Date: Mon, 17 Nov 2025 10:32:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Remove smap argument from
 bpf_selem_free()
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, memxor@gmail.com,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251114201329.3275875-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 12:13 PM, Amery Hung wrote:
> Since selem already saves a pointer to smap, use it instead of an
> additional argument in bpf_selem_free(). This requires moving the
> SDATA(selem)->smap assignment from bpf_selem_link_map() to
> bpf_selem_alloc() since bpf_selem_free() may be called without the
> selem being linked to smap in bpf_local_storage_update().

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


