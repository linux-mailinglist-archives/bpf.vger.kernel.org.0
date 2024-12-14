Return-Path: <bpf+bounces-46974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB49F1BA5
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD207A06E4
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3C10940;
	Sat, 14 Dec 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E+Lrn486"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0CD51C
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137834; cv=none; b=kbumENxw1m3eYN6zLpjegu3LwvLo6h7RvOtCEvykZGbMHG5wXbF6NJjcucG4tJNpvG4vFlIepfqfCtrN17P6CSsNCHJ+cE6UF+2UQx3eyzcw8GwaKEcY44S+Fzhc91GNqUvedn4EtjLktKE2Lce4lyRgAX/fA7Mhj8i4zlvoRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137834; c=relaxed/simple;
	bh=C3+IdVuAvnQ/KvxDoMwIrGuR+P8O2WYRvXW6r7ofiSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiJ6H8WOxsIHnpucAyu4F/LRJFN+fz/B8G1XEtJww/Oc+f0qRHAKHnk116FE9n26mVN2hR3W8GYZ46alx/8iJy5eujL9DHTXvA4cngNbF7CrM2yi08Tyk3I+itIYCQOzfEPEaYWIg2LXI5xQe0oQrO2rrNSut6tivk+Tq9F/soc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E+Lrn486; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac054b6e-2120-4598-b960-ddd275714218@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734137829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3ancRC7bUqqknIEsbXLtYA27OtEWXwqh95I45KDQXM=;
	b=E+Lrn486GsUg/lfcCqmCK9lk51mHDZi1tYvjRnIzTD0ocv/rRTMJ7NrFA6KkHmJAp/nrka
	tCEy9nLE3T17MD/pkszWE/V/83jXeFNCEwfkee6D326+jsMJ62P7KmwPiV0T75iQbcdsiy
	6LrISLRl/y8vlnua0sYac0vCWbBMg88=
Date: Fri, 13 Dec 2024 16:56:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: unregistering tcp_ca struct_ops can cause kernel page fault
To: rtm@csail.mit.edu
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <96319.1733959698@localhost>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <96319.1733959698@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/24 3:28 PM, rtm@csail.mit.edu wrote:
> Martin,
> 
> When I build from bpf-next/master with a default .config, I do not get
> the crash.
> 
> When I disable CONFIG_MODULES, I do get a crash from tcpbps12a.c.

During make:

"WARN: resolve_btfids: unresolved symbol module"

Without going into the details, the bpf_try_module_get failed to bump the refcnt 
because of missing the "struct module" btf_id.

With a quick thought, I see bpf_struct_ops should be able to work around this 
CONFIG_MODULES=n.

I don't think it should though. The bpf_tcp_ca is using the "struct 
tcp_congestion_ops" which can be implemented by a kernel module and the kconfig 
wants nothing other than the built-in tcp-cc. I don't think the bpf_struct_ops 
should be a way to work around that. I think the right thing to do here is to 
also disallow attaching bpf_struct_ops when CONFIG_MODULES=n to fix this UAF issue.


