Return-Path: <bpf+bounces-66303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D358CB32283
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FCB567968
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2322C1586;
	Fri, 22 Aug 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="KTeFAj+C"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8E393DCB
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889095; cv=none; b=dLBhrNakaWHAiBr0ZsPnR1musnFxo1YNKwSMFI4nFgqU4WqvMPKQLLEbSno6i7pcxAze1NyxtaXqEv1vvNdOJ8C+13/QD/JY19gJwHJiHlfHXMpZOCzpkwu/kXOSll7lxN4dJ9WifS8jIbND3TNMt0njhjBdjl0E7uQsRPmi8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889095; c=relaxed/simple;
	bh=D0y7S4sLPYw+GXDSC+LMvH70YKbEvhcacfEQRDZLj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSjPG2AfkctHKvwD3WR3HHutm/H/vrsZJreQSQXT032VbTqRKuHDmGjTXsHMSZbsJRIBuWKmGtw1gPWQfMHHSyAsRdk7NM8KK+YGsA6Ih7V/fcNzMzeb9HfNYJyIyUl1f6XmEDlzyfvGm/keLrQtgOzaIBwxGIhFEqE4C/XLYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=KTeFAj+C; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.192.108])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 065F844C63;
	Fri, 22 Aug 2025 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755889090;
	bh=D0y7S4sLPYw+GXDSC+LMvH70YKbEvhcacfEQRDZLj4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KTeFAj+Ca2BwptD6PuVQJrH6fcFRTsClJU1qdP6FLwrVJtJPEUmfNeDoi7FpBg4n0
	 PzyWzq776sop1WwlRhRSOgT7Qnuh3jiy3vyXw1uC9VQTMyJIrz9HjLFDT2+LiVvPjP
	 warjU0xoL4YuJs1k+wOa0nFZoGcTU+KikzFCR+vAzokcWBRf6Y4Uc+s7marSz5bNCN
	 /of2cqyDZhMWaRUrV0ZqbqaqzJd0Fxu24ajVXPLWK3xZuXLuqPCpmn4DZbKJ4jVyCQ
	 KmlScDfl7kXs2vARy34yS4YM96FYeHIuBjHVrX+IvMJgqApqxGKhW6jWpSxB5r9vj7
	 2yK6vkYgebXLA==
Message-ID: <0d521dc5-043f-4f76-915e-725da860db24@nandakumar.co.in>
Date: Sat, 23 Aug 2025 00:28:06 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
 <7d150bc2d3ef8691c440f03bc5e57e92cda10a26.camel@gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <7d150bc2d3ef8691c440f03bc5e57e92cda10a26.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/25 00:07, Eduard Zingerman wrote:
> Nit: The above comment is good for commit message but not for the code itself.
>       Imo, commit in the code should concentrate on the concrete mechanics.
>       E.g. you had a nice example in the readme for improved-tnum-mul.
>       So, maybe change to something like below?
>
>       /*
>        * Perform long multiplication, iterating through the trits in a:
>        * - if LSB(a) is a known 0, keep current accumulator
>        * - if LSB(a) is a known 1, add b to current accumulator
>        * - if LSB(a) is unknown, take a union of the above cases.
>        *
>        * For example:
>        *
>        *               acc_0:	    acc_1:	
>        *               		   	
>        *     11 *  ->      11 *	->      11 *  -> union(0011, 1001) == x0x1
>        *     x1	          01	        11	
>        * ------	      ------	    ------	
>        *     11	          11	        11	
>        *    xx	         00	       11	
>        * ------	      ------	    ------	
>        *   ????	        0011	      1001
>        */
I really like this. Feel free to make this change, or just let me know 
if I should do it.

-- 
Nandakumar


