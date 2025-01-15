Return-Path: <bpf+bounces-48989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8BA12E4D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCEC188A317
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417B1D90CB;
	Wed, 15 Jan 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKcCxzio"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE01DC9B3
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980355; cv=none; b=NVPw1zdCGlE4YhYNrsIDbjwWmbrxDFC42WHxGQA4WvZwHBXsSajkSzc9FIJG6RV/WNznnAOF/7R7N4MfCjEM9Gnd9xDqxBmihVTonutlJCtVIQx/nf0GhOGjIHKiwYt+WnHmj+Jrti2K6N2Uy5zyz60ngyh+rzlUi/NoeTIsZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980355; c=relaxed/simple;
	bh=MXbAlLu9pVzUu6uAAGHpuvLE0y422jLnih0GnaszHXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhLa8i+xTj9zWYC+4QgbP/ELaznMwj3d88FyBlx7FeTfJjjU5ryTZ8E9d1slywvgIEGjw72mlqm5fEPLQl5jRBWES9DSE62EOXYu6Mh7t1s233LXvWPIYP+qTBdmAl3BVKUkDOo7F0l00E3axheXGKcVCZvZ8Ue+m4FuGdQ50Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKcCxzio; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0071f8d-b7c8-48c2-b4c6-96074f4c4849@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736980345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXbAlLu9pVzUu6uAAGHpuvLE0y422jLnih0GnaszHXE=;
	b=bKcCxzioUOiB+sXouYofZ97y2CMonCwS3/2Z1Ny6YgHq1oRgZyPdbXVH4+QrP7KM5raovC
	Vb/SxLq/cC3nFgWmiWzySzEKB1HEuN/kbuuhtggM4NX6eM5e/lJX60edGRSBA8ni/aVvaP
	/R5DRXDuyaoSkplJG7RKlCOKOoilQ/I=
Date: Wed, 15 Jan 2025 14:32:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 07/15] net-timestamp: support SCM_TSTAMP_SCHED
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-8-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> +static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype)

nit. Remove the "__" prefix. There is no name conflict.


