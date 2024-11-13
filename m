Return-Path: <bpf+bounces-44747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEED9C7262
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81AE1F21DD3
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2501F9A80;
	Wed, 13 Nov 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SEBQkpTA"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2229405
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506790; cv=none; b=D4Q2nZaU1YygNdgQOFI+AJDcGFX85x8n35mf1FSMXwyPGkzxtraU71Gm5Ipd80C3xwaRYCWgQy6M+2KqddFXAjo3GBOX7QjxBgozgzCPo3utY5Wa5omUZW7YRgA4smq0hZ+p7FOJa3ZO9KPyDMAJLZIKvujVR0zm3yDzdg8bXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506790; c=relaxed/simple;
	bh=rRhzu2DQbLlS03rN6PfOz4wLAMj6TChH6CZjgR8zf+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbVsP8ylVbTKlt43f0XNFmZeC9xESorPHR597DpFcpUdoLd1IfnaJUcH3Mfvhjc2wJysqBlpG1cIgMdagfv3ikcP9fgkioCLeN08Ldx2YGOpOSZPeWx+oMoHwyz7eZf4O4r4CC4NAWl+DVIL5m5GZqbDj8IeC9ze9M0PRouxxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEBQkpTA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3084f512-7476-4de7-9c28-92546d0358c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731506786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1LpJSEXTIsVtvFtU7z5WsJvp58+MoemqzStkxUQMbQ=;
	b=SEBQkpTAMyNiBlmpqvIV935RROsFBT19EGk+IojLYpvzHL0BIvGIv+vvWtPSsL6ueUWMqU
	lNygzxtR7O26eKosip7dBKlaBKnOzLq2bGd1LDCDo3petjqeNVlTOkncKmCQ/duoAuF0GS
	YFD9LM4zYRlxG51SMvBEynQqIvLODrc=
Date: Wed, 13 Nov 2024 14:06:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ARC: bpf: Correct conditional check in 'check_jmp_32'
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 ast@kernel.org, list+bpf@vahedi.org
Cc: tarang.raval@siliconsignals.io, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
 bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 13:41, Hardevsinh Palaniya wrote:
> The original code checks 'if (ARC_CC_AL)', which is always true since
> ARC_CC_AL is a constant. This makes the check redundant and likely
> obscures the intention of verifying whether the jump is conditional.
> 
> Updates the code to check cond == ARC_CC_AL instead, reflecting the intent
> to differentiate conditional from unconditional jumps.
> 
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> ---
> 
> Changelog in V2:
> 
> - Changed subject line
> - Updated condition check to 'if (cond == ARC_CC_AL)' instead of removing it
> 
> Link for v1: https://lore.kernel.org/bpf/e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev/T/#t
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

