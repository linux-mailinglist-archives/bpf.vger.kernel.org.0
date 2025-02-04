Return-Path: <bpf+bounces-50360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53801A26A09
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 03:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF44C3A3D86
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B213BC0E;
	Tue,  4 Feb 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8UP63wh"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1F179BD
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636058; cv=none; b=YyxkyNpUzi6P6pDR2v9+6nzO7AmKD8S4Np64+Ys7SuZZDhXvT+ekCFZUFQ1N495NNeNjQr8YG8J2GWv++U2rMhHUXSLJdhVA2tFBGyFwhY1eeXMpraSPamTvunXo0+/HCSfMdk9MrbVcaWf2bA5bBKGkMxGMYiAyBgoL4UsstXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636058; c=relaxed/simple;
	bh=giKV7IBfa5TNifPFNJi5zG1LfF0ATeb1RwNi6a5RaSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paatVlGGh2VldzJ9/yRxOdDZ25an+w8Z7lHEpDfe4WiIbve6NrEINDa+ptY0RLII7+DkV5HGaUpDuD3Z0tCk4cMUR771BH3cI3yiMBZG/XGiCee5qUexNovUO2ukURNRLpWgvmES70DpyPUqBtlgKKFDxrVJmA+ZmmT41n/y0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8UP63wh; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738636053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDOjkWeZDxQA0dcDawvIHdzCfu8gPdyp1yIL9e6+a3c=;
	b=M8UP63whNboMiNhLZuEIYOh/XJdgltcMap7pkRdJ+nVALF46Czut5XMNt0uFkjdfZ2pohu
	iwSJe8zZNZIyipRrh2LfHWfMnyHkMTXfuVpwh7hPqqSLDPSa/gETU+sNP343qBRNPK4Xwo
	NF1q5sivgMhxib5RQxwY+UigCJm8fAg=
Date: Mon, 3 Feb 2025 18:27:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> "Timestamping is key to debugging network stack latency. With
> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> network issues can be attributed to the kernel." This is extracted
> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> addressed by Willem de Bruijn at netdevconf 0x17).
> 
> There are a few areas that need optimization with the consideration of
> easier use and less performance impact, which I highlighted and mainly
> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> uAPI compatibility, extra system call overhead, and the need for
> application modification. I initially managed to solve these issues
> by writing a kernel module that hooks various key functions. However,
> this approach is not suitable for the next kernel release. Therefore,
> a BPF extension was proposed. During recent period, Martin KaFai Lau
> provides invaluable suggestions about BPF along the way. Many thanks
> here!
> 
> In this series, I only support foundamental codes and tx for TCP.

*fundamental*.

May be just "only tx time stamping for TCP is supported..."

> This approach mostly relies on existing SO_TIMESTAMPING feature, users
> only needs to pass certain flags through bpf_setsocktopt() to a separate
> tsflags. Please see the last selftest patch in this series.
> 
> After this series, we could step by step implement more advanced
> functions/flags already in SO_TIMESTAMPING feature for bpf extension.

Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. Patch 13 
should be "selftests/bpf:" instead of "bpf:" in the subject.

Please revisit the commit messages of this patch set to check for outdated 
comments from the earlier revisions. I may have missed some of them.

Overall, it looks close. I will review at your replies later.

Willem, could you also take a look? Thanks.


