Return-Path: <bpf+bounces-51605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937DA3670E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F198B16E3ED
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E851C8613;
	Fri, 14 Feb 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/+ROcA4"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64B193086
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565790; cv=none; b=pxeIHUDOlBmGkWs+w8YJWKqVWCCHhKxPBXPSnq/7wTgCyn8odbgPy/4RmoTJOVFLjJUT/gszSY7NKHRJa1+KtfnWGcYvOoX5a8JcAklYAGD526ty+bJhGLeXalyugFp9T9gNkoXduxFSntQ2WNF9gy9znIiGUiWZIwJR1pXy2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565790; c=relaxed/simple;
	bh=28b8zhdrUU4bm/CmeTmiGV3nUJqUZ3vT4wExJKP2z4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAEoKlmC7OWgBgTKS2i9b7ixVrAtHAzsN9iXm5d4llaeoFRWKr7TNMFZbpY+GiRCAeWRqDzouQGkoEaf73BzOG8Ezud4hDs23dJmF6Og2KmB9HiB9KWiiZxHAN3rGAHxK9ReeT2ti4Fia8kx+9sO1tQ0PayFvxBMyKbwxmEGBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/+ROcA4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <035d99ac-0f39-444d-bf2a-68d46f0e22a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739565786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6YzWD7f/jPVk7pR5S1OI8mishtn1WCwM57dNK163eQ=;
	b=N/+ROcA4831LPC27mULzuAyAblhQtlrkiwtP/rtcTDfhWG+vlxZQ8v+n/+8SwYntYeFQnW
	HglQw6YPkEy0HXyASEMWFAy/8AZFpduVWrgMnG2URH1CE15fJDQcXVxuJdzbYgXawPyirv
	zEpOPpUdQIflTe2Ebb+nCEa3sVq8/Z4=
Date: Fri, 14 Feb 2025 12:42:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 5:00 PM, Jason Xing wrote:
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
> This series adds the BPF networking timestamping infrastructure through
> reusing most of the tx timestamping callback that is currently enabled
> by the SO_TIMESTAMPING.. This series also adds TX timestamping support
> for TCP. The RX timestamping and UDP support will be added in the future.
> 
> ---
> v10
> Link: https://lore.kernel.org/all/20250212061855.71154-1-kerneljasonxing@gmail.com/
> 1. rename hwts with hwtimestamp
> 2. use subtest and pid filter in selftest
> 3. use 'tcb->txstamp_ack |= TSTAMP_ACK_SK'

Overall looks good. I only have two minor comments.

Willem, can you also take another look and ack if it looks good to you? Thanks.


