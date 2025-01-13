Return-Path: <bpf+bounces-48712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5188A0C30A
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B697518892A7
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906F1FA146;
	Mon, 13 Jan 2025 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeAI3/e5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93391F8932;
	Mon, 13 Jan 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802066; cv=none; b=WQCZV7ZqVLKvYW1kc+DS1DtzN9e0NYCBHzzXqs0+QdcIp+mrNXsMgrs9aeeuSRBiymlgyZl92xKcQPyswB1QX5T+C4iAEmycW942HoV+oPHwhXoPofp8dbikbyexdrAUpgqssxmbh9j2wSZkhfmNB15R2oU6MYA7Mfq7VpnUEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802066; c=relaxed/simple;
	bh=g0mBU7aV8GIBGspT2cN1yB38Oyr2NFlgk+x4A5pjysU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUXjJoFTUGvkmHqLc9SlYGqmAlNwTpjQ2C4Vabqirrw/aM2ovuBhjlnbvBxWsP4+1EJ9RFg7blvHBqY11ZPVq8rJAfKtjWrgay75+OJgse4n0O5wsntB39qlMBBKqxkRePOowlcIDMLpuWj1uu6zSKiHrFQ9eDlIK4RNcrE3hOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeAI3/e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E70C4AF12;
	Mon, 13 Jan 2025 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736802065;
	bh=g0mBU7aV8GIBGspT2cN1yB38Oyr2NFlgk+x4A5pjysU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CeAI3/e55gERPTSiIjAXy83h3c6ohx/Aok8c1hwOv6j3esqUqfVydtPwsFIk2M290
	 Px6ojL4yO8vLcb3K4a8pkOdSFwjXq+n8qmIKi24W1eylsxAkz8EDvrgbOfTiedlu8Q
	 HK90jlle8svOLx8g9PiQQfa7JNEBzYlzdfUF0Kmy6CrVclPJSbkMJNIudbrpUmpQiH
	 h6STtgDTHhY8wS5UxujeY4VwvuT1mQEAn/p/uPv/b+n57QHcGqCH07HFy+4RajPbBv
	 QRqQDPKHL/ACYHCyvA9shW+p/CqfLlYVG3iyI7ImBZE/IO6QvKgWCXfW0kU6oEtRwH
	 R+Tu6nFMyYwmg==
Date: Mon, 13 Jan 2025 13:01:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/8] net: gro: decouple GRO from the NAPI
 layer
Message-ID: <20250113130104.5c2c02e0@kernel.org>
In-Reply-To: <a222a26b-9b1e-416e-a304-fd9742372c7c@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
	<20250107152940.26530-2-aleksander.lobakin@intel.com>
	<4669c0e0-9ba3-4215-a937-efaad3f71754@redhat.com>
	<a222a26b-9b1e-416e-a304-fd9742372c7c@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 14:50:02 +0100 Alexander Lobakin wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Thu, 9 Jan 2025 15:24:16 +0100
> 
> > On 1/7/25 4:29 PM, Alexander Lobakin wrote:  
> >> @@ -623,21 +622,21 @@ static gro_result_t napi_skb_finish(struct napi_struct *napi,
> >>  	return ret;
> >>  }
> >>  
> >> -gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
> >> +gro_result_t gro_receive_skb(struct gro_node *gro, struct sk_buff *skb)
> >>  {
> >>  	gro_result_t ret;
> >>  
> >> -	skb_mark_napi_id(skb, napi);
> >> +	__skb_mark_napi_id(skb, gro->napi_id);  
> > 
> > Is this the only place where gro->napi_id is needed? If so, what about
> > moving skb_mark_napi_id() in napi_gro_receive() and remove such field?  
> 
> Yes, only here. I thought of this, too. But this will increase the
> object code of each napi_gro_receive() caller as it's now inline. So I
> stopped on this one.
> What do you think?

What if we make napi_gro_receive() a real function (not inline) 
and tail call gro_receive_skb()? Is the compiler not clever 
enough too optimize that?

Very nice work in general, the napi_id is gro sticks out..

