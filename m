Return-Path: <bpf+bounces-26196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8D89C853
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F591C23E6E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54106140E5C;
	Mon,  8 Apr 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BHu/3H5K"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B113FD84
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590318; cv=none; b=CMXGnBt6bM+nIHZ6sMjN20eBEgC4yOpNKEJ9kKuOzYTNUBnjjMIXXzTiyij5CEHyczdSjkqXBL3c+wQSGeHvHvF7dZ/9LFZVdhkMl0EzRc60J/pHnZmFXBafMc79PnNQMX32ruvhtXY13mSzKp5KlPdp0N3lsaZHXvEhAr0FmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590318; c=relaxed/simple;
	bh=tjGt1QyN3u9SP4WWPTA1ilz084j0cSgzKV09txr9r/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ9DvG/xVf+xICiGijzQrGMoIccbME5YHqPmh7MhHv+UMwJWkfyoHs+mPJShkWiEg63wDK+TNl+wq+2wn+ZR32kj+a3rnLNMkNLuGPIfJGPkIX4DGPZnnygKRR9yWt9qnoQsbuZTDk2xuQoXWNfxhXM9r03myM9+dPsHUy+8oGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BHu/3H5K; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f348afb5-684e-4cd7-a8e0-d5a10221dfaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712590315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjGt1QyN3u9SP4WWPTA1ilz084j0cSgzKV09txr9r/E=;
	b=BHu/3H5KbrEWe1u/+wFTHRkWp+IaZV2pwuHoPyv9t2T0sDstk+EvDR6obNnJ/Unt+NbC0c
	1hgtbWozusE5JqIJLMqp4At8ymZz5OHnEWsY2g+y2KwbpIYgho1JQ848X/h/IbTnIvZcpK
	OLof+IZ5d0N2igNyMsufTWRFhWAB/pA=
Date: Mon, 8 Apr 2024 08:31:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests/bpf: eliminate warning of
 get_cgroup_id_from_path()
Content-Language: en-GB
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20240406144613.4434-1-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240406144613.4434-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/6/24 7:46 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>
> The output goes like this if I make samples/bpf:
> ...warning: no previous prototype for ‘get_cgroup_id_from_path’...

The CI does not build samples/bpf...

>
> Make this function static could solve the warning problem since
> no one outside of the file calls it.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

But your change looks fine.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


