Return-Path: <bpf+bounces-48987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064EA12E1E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54B31656F4
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED291DC98B;
	Wed, 15 Jan 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cbIzWtaI"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4511D7E3E
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979080; cv=none; b=h7vmlL0ED3KvVfl9itDRS067wVDAz6dLetJ9aqPoWrmgNJwqt04XamL+n03DPJxtcWohfgqHNg6apC7lGuVI4FkPIdPLz6vePQtsZnEaW8VBAJh2N3VTqoqFbYuvi28741WxZSXc2c49F7Z45nfcXOPZkyOCdOtgUiiDHl7QzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979080; c=relaxed/simple;
	bh=2HvmyCLKsllrJAtQaoW5j+0UXwvggo8fZ5Pq+9buQlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBJ8I/mPWqwzdtr1puKdlOAGAQHV8OcGDDhqcv6LExUN4BTFqjqF9PSaQIa/UpF9qtfJmhbso0fTusvxNq7XnuRI9PhYK/reJRNRt1XL9SUy9ry3Xw1k9hU516R7YUiPBXs+yc67BTnBJewCuwT4w/g46IDQvf8rfixa5wuObn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cbIzWtaI; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96b5bf3f-b99d-46ac-a22c-754582020c17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736979075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZeuF7Ba0Q9yT6HX+wb3/FL7TqxwpcmPs82oCf2VVtE=;
	b=cbIzWtaIT7uPxwyqC4RtNIqSnyETerTKroP4/tTYPAr9/eU4Kl7U9l/U0kC3ZOtnMHTcfq
	qFEOwYLkM/wTX45jZbfJMR6VAkgiVvv2pmWDr+6Uw2/+Jp/YsqHq4VG/4GRyQFAL2m4pgN
	L20ZdS25eoDYpYBBuGzUf31UywR2t+o=
Date: Wed, 15 Jan 2025 14:11:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 06/15] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-7-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype)
> +		     struct sock *sk, bool sw, int tstype)

Instead of adding a new "bool sw" and changing all callers, is it the same as 
testing "!hwtstamps" ?

