Return-Path: <bpf+bounces-44856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D39C90EC
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 18:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA3B449AD
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195318C32A;
	Thu, 14 Nov 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rise8zEF"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382B189F2A
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604577; cv=none; b=i6qBVTcV0qfagx+QUOZnqpg65tPSVOMF6Egif3JKzUwBhXmULl+0rgwzsAMDtleX7RZhblHjmu69uQBojhk+yb4CmxyPynk84Z32OssL5GDI7mTcDJJFH2O3SUNdIrxukV1oVooWJzKqEVlrvkRcw1DGxjoJxQ7HBpT/EBV72Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604577; c=relaxed/simple;
	bh=jOHx66YrwX3NMZF4Q66DQBXh5tNbdf4q1OFzvUBl0sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIlKOrCsYjxEw1PEFZ/hRKadCFRwsM8UFIv9cgMSH+FuIq+hLgnJuy5z4Ugal8pJjxPbpkE8P6Ae2Pjj/Fn0Xm/b0Xu6HQsfMEPwu6PnpXVLuGhg4PLnTvU5Bmh7YLMERyooYwBGEwl5/8Xe+y0cfII5leJnmszKT2MD5vD81II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rise8zEF; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f1b640d-2d95-4a85-94ac-d341dc9d353e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731604572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOHx66YrwX3NMZF4Q66DQBXh5tNbdf4q1OFzvUBl0sg=;
	b=Rise8zEFTDRo2cw2CiRxNM55nOrMJ3PaNpOsxUx4wevIgTnNLh8XqxF5yxXGXXyQLis6Zn
	YIsSd4P/1Zx7801/tHV7vCItxCqZcNcH755IjYcf5Dq/OfGE+n+XaqxqKBgwRkYCoSqp3F
	XZr9fzvb5/soiZABMxeCWHY6nq+250Q=
Date: Thu, 14 Nov 2024 09:16:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] BUG: unable to handle page fault for address:
 ffffffffa6df0480
Content-Language: en-GB
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: "jakub@cloudflare.com" <jakub@cloudflare.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 bonan.ruan@u.nus.edu
References: <B80BDA8B-4F1C-4293-8E98-AF78AEA7B3FA@gmail.com>
 <12c598fe-b799-4f30-b871-a8b7191935ef@linux.dev>
 <FF1DD544-67C5-4812-8E0D-5540930144C2@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <FF1DD544-67C5-4812-8E0D-5540930144C2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/14/24 12:29 AM, Yeqi Fu wrote:
> Thank you for your reply and assistance.
> I have attached my kernel .config file for your reference. Please let me know if you need any more information to help reproduce the issue.

Still cannot reproduce with your config. You need to provide detailed start-to-end steps, including, compiler version, kernel top hash,
qemu command line (e.g. number of cpus among other things), all command lines, etc.

> Best,
> Yeqi

[...]


