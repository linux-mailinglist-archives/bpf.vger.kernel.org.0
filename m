Return-Path: <bpf+bounces-52116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1AA3E873
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC923B4EC9
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC001267705;
	Thu, 20 Feb 2025 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq7nautW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220326561A;
	Thu, 20 Feb 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094025; cv=none; b=DmuIgsepkNl1DwNwGZnV71ANMVJyI3LIbrHK5OhvbP94Y93T+8D+ymzF36RkT29M2SLjQhAP0+RSqKaOJ2m6owE86+n8Grkq1DN3nqrkTBl14cp1ho9eU+Un0/JmkTQkAfAaZ/y9Rkoq5jQhTwLq8jd/bzd88wzRrEpXF2vv6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094025; c=relaxed/simple;
	bh=fcDoYTZuB9egKez17BvmDVzB5Ai7JHNxUWf4Me/VCC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrJJ/3BXMlZ+O+p9CE4jM3ks2G/GipxnbYWvpHi2IXm5lb5lg5+zYWkD9i7slC2MPKnbRTCZtOEuh/cbbRFMHmoy2bBz/BF8v4xPM8WdhDWqW6B6cSiJT/9lo805c+HPtI1OFJrJZnJBYXAP8QwNwrWb0FsHoRsXsyUM994fweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq7nautW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A6C4CED1;
	Thu, 20 Feb 2025 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740094024;
	bh=fcDoYTZuB9egKez17BvmDVzB5Ai7JHNxUWf4Me/VCC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fq7nautWCZjudWAsRQBa3TYivdlWvZJoEhxlXUSJqQ1Z94fc2Z3TTfEHf6OVH8GVi
	 smlhz396cJ8QzTZ+wzQEaR35VNliOaEYx+R8oKRTUUw16M0LnRfeFfjj/OyTHwFeVK
	 iyqBIbIs69E8sLoqRcX/2vqHbQ9v3szGxiB+cPlzEg/ZwIoathmJJstRhT0YR37+dB
	 +l6PYc/oc1XCWCoZFjqHZrV77I6qjkQTGCnfWnCeOxt22K05a56om5GQGmETJCNGpN
	 4wB6OFI4f4/CHcBIE7n8uc0Qt6pIxKmr8lp/995+Iqyzg4FMeOwt+UMvPb0zJqHAWH
	 0wysLJqvrqvIQ==
Date: Thu, 20 Feb 2025 15:27:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.ne, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ricardo@marliere.net, viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru, aleksander.lobakin@intel.com,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com,
 syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v1 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <20250220152703.619bf1c9@kernel.org>
In-Reply-To: <20250218133145.265313-2-jiayuan.chen@linux.dev>
References: <20250218133145.265313-1-jiayuan.chen@linux.dev>
	<20250218133145.265313-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 21:31:44 +0800 Jiayuan Chen wrote:
> -		*(u8 *)skb_push(skb, 2) = 1;
> +		*(u16 *)skb_push(skb, 2) = 1;

This will write the 1 to a different byte now, on big endian machines.
Probably doesn't matter but I doubt it's intentional?
-- 
pw-bot: cr

