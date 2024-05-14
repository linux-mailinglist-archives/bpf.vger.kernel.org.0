Return-Path: <bpf+bounces-29682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E88C4A9F
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 02:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2A3284638
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 00:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697351869;
	Tue, 14 May 2024 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT2r/08A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE8EC5;
	Tue, 14 May 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647858; cv=none; b=ca6uHv9fuJl84RMoPJ2IUDPU1zOKFrUpHj4ZdxON7s+b4gCVT0J750ZkM8S9/v8hPgstt26TMH7av8158EoDBc9PmaDpHoc+nXz/LkvSTQDzfuN678BoNnMfGWoWBNYiCtmf58qGWV/Nz/lVFRfdNc7uAZce7BoLz3MXFtfxkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647858; c=relaxed/simple;
	bh=U3S4rHf/j/59RgQxyd4HaMChiWtKURrQKrKmn8TPmxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EctRA0rV0I/xrFDZhjJCcnpDdllMuGZfuZlq1y+dGuILwcv4QgbLZekoaixqlwIsauSX/FFDTIMd5qGmcfTOYOSSx3RWp+r5etqTsPyGb4GYbWrgyIaxHzLn7XF5AYdECAb7VJHdQXwANLEbLEuZwp26VGXasc62ThMLQOIvTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT2r/08A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F08C113CC;
	Tue, 14 May 2024 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715647857;
	bh=U3S4rHf/j/59RgQxyd4HaMChiWtKURrQKrKmn8TPmxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kT2r/08A0fhbvtLpd1DROJX2GPmh11mxdVLwTwiqBEAC9urd5RkswWXw4RYjOqzcT
	 jAuw3k61K2WRHfcP3qI5Fsuirb5mfC5dgLTtnYAW7QfoI5EHvx8Y1MQFdi7yFBFXo3
	 XvIXvR818fjCKXDCi6fDK1cr0m4uYTEyi5X+4sMYtmRMZz6zwYRXpoP5eB7DUXuWfx
	 3NCYA2+DzGoi9kb6dDsuiZ0ZTBgh3Pfm/SLt4cY+/QuDCk9Ux8DtR86e6UJV9mjc9p
	 /soqA7GHDR6wD1Slkda4JR7m6SMiGOLvjlrWpPtGgsmFPG1UxnrTAfoBuiu3BTvztZ
	 2UJgbwcmnLPqg==
Date: Mon, 13 May 2024 17:50:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 vkuznets <vkuznets@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
 <longli@microsoft.com>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K
 page size
Message-ID: <20240513175055.0f537fe4@kernel.org>
In-Reply-To: <DM6PR21MB1481F5EE04BAB66E380A0706CAE22@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
	<20240513134201.5f5acbae@kernel.org>
	<DM6PR21MB1481F5EE04BAB66E380A0706CAE22@DM6PR21MB1481.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 20:50:37 +0000 Haiyang Zhang wrote:
> From the document, it can be:
> "ARM cores support both modes, but are most commonly used in, and typically default to little-endian mode. Most Linux distributions for ARM tend to be little-endian only." 
> https://developer.arm.com/documentation/den0042/a/Coding-for-Cortex-R-Processors/Endianness
> 
> MANA driver doesn't support big endian.

Alright, but please prioritize at least adding the 64k page support.
Linux drivers are supposed to be as platform independent as possible.
If you use the right APIs you shouldn't have to worry about the endian
or the page size.

