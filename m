Return-Path: <bpf+bounces-38319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBED9633DB
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0121C2408D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14D1AD3E3;
	Wed, 28 Aug 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gm11JTZb"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CD1AC443
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880570; cv=none; b=k6XbBRl7dsNvEQdHe18Oeih3/+TqUBYlTbzE8I932yUS8zDaeCK4xVVy8wc2Bjyy+UwxenPjipXMX/AW+zjk4A+RDDT46MeOFZ3ftE43sC4dL6a/RIorMfTMViOgRMglpqO0O11rcKxteGZ9Srf6cJSxqdaLz8rtQDNBzNblkTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880570; c=relaxed/simple;
	bh=9sCPNmtAPxcbhDCTFFWA/8fBdfOsdaWBtBNT+bFXAWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT/2KjvHaWrnTiJdpjpyv7/OmRRC/mYBab+ckiC8fB33/e5H6S9k/5OYuVZA2WAJhZbv0z8GGjvdpD73qB6txNQO6jbZt+Flzw2aLuBNzBkqmhtZv+ZL/pXStkCdi23nG3em92+ZUPNrxSm7lupqVBvymfZP5VjN5i1+cS61Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gm11JTZb; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724880565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyljCDOX50IlTeH4bxvhhXlTuF5KPs/h7kPstVhqUDY=;
	b=gm11JTZbtLS91Yl2PR37OiViGVtxJ5SBwzkQu4/PbCu+9WRHDulRILdzHdbDvWjjEU5sc2
	/8GqgOskcaacVxCrko20e4WKX+/oUhBokkNU/EBAHselMoAtgkEifavSRjWsrORU8hljj3
	sdAYoFRHY6W0FBdu8wdu8I3CwgSMDLo=
Date: Wed, 28 Aug 2024 14:29:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: zijianzhang@bytedance.com, Amery Hung <amery.hung@bytedance.com>,
 bpf@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 xiyou.wangcong@gmail.com, wangdongdong.6@bytedance.com,
 zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240827013736.2845596-2-zijianzhang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> This series prevents sockops users from accidentally causing packet
> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
> reserves different option lengths in tcp_sendmsg().
> 
> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
> again to calculate the actual tcp_option_size and skb_push() the total
> header size.
> 
> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
> reserved opt size is smaller than the actual header size, the len of the
> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
> packet if skb->ignore_df is not set.
> 
> To prevent this accidental packet drop, we need to make sure the
> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
> not more than the first time. 

iiuc, it is a bug in the bpf prog itself that did not reserve the same header 
length and caused a drop. It is not the only drop case though for an incorrect 
bpf prog. There are other cases where a bpf prog can accidentally drop a packet.

Do you have an actual use case that the bpf prog cannot reserve the correct 
header length for the same sk ?

