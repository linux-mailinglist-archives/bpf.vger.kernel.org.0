Return-Path: <bpf+bounces-62459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BFAF9CC5
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243FD7A578E
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAE28EA6E;
	Fri,  4 Jul 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9mIadHk"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF6285C99;
	Fri,  4 Jul 2025 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751672329; cv=none; b=obf+EOVICdFkWrAbkHbkzFiu11qxD9bcluMDh8iZatz5pfFGQfzADae1B0rFygf/wTtZmhyFNpJQDFBjC6on3ewnrmKfIZP8o99ABnpE69Mt0jd6f3Pvy0PFd7w4tE6K27XJ5xino6sYqgf862l6joehH74OxVEBzW7dU46+zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751672329; c=relaxed/simple;
	bh=boACrwX22LRkOJG93nW6MVH5ZSHkR5lQQxg4dZPrkcc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ttPlKq/QsIWv1u6Yi/J7cqggjqyjXw24qfHJIlyboDLaO+Odxsd3WDU9Bu3wEk3ynbOw2I+FcbMl1/4yJouTDGkJvtXBxXqTYncHgk8FXpCPUOBjf0X1t04cSF2ERVvGMi+UIfDvosAfY7Qmzx0N00+UGmmUX3wa9REJgdsWOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9mIadHk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=ks//WZrTiccz2OFfHdTqv+PE5CbqjT3gCKKb4ZvwCv4=; b=F9mIadHkKDXv7k0m8v5lyI9sLi
	iSD0/sQaod9H+G+FfRpVY/WA5xzPahMfm3d/ntsUEGMYLMZ/Q4vA1ISWg1mj58J4IdeSkqUkbDq6M
	+Rs0M48ymUPH21nVSDBsSR7148VmxlqJ1B8K2rhHP1zhCUb5HeX+Lu+/aNMqUn9QlOHeYC/RWYNOK
	5xilLhB4q0PtFX3WUfGP5PZA4PHfY7fsPQh3b+bLY72sFepBh/dVCn0Cd0hgEgSmrzMDBWH5kwKeD
	45GVVo0CyxQODYkz7RC/DXBccTh/zNPFcxfoFogIt2J15+EhfQqsq5irnmVRVAKM1eoBcDlNmNvIx
	Pgh5S97A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXpzQ-000000019Bn-0CIf;
	Fri, 04 Jul 2025 23:38:44 +0000
Message-ID: <f06082bf-27b5-488d-b484-fecc100014a1@infradead.org>
Date: Fri, 4 Jul 2025 16:38:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 4 (kernel/bpf/stream.c)
From: Randy Dunlap <rdunlap@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250704205116.551577e4@canb.auug.org.au>
 <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
Content-Language: en-US
In-Reply-To: <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 4:35 PM, Randy Dunlap wrote:
> 
> 
> On 7/4/25 3:51 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250703:
>>
> 
> on i386:
> 
> kernel/bpf/stream.c: In function 'dump_stack_cb':
> kernel/bpf/stream.c:501:53: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   501 |                                                     (void *)ip, line, file, num);
>       |                                                     ^
> ../kernel/bpf/stream.c:505:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
>       |     
> 
> 

Also reported (earlier) here:

  https://lore.kernel.org/linux-next/CACo-S-16Ry4Gn33k4zygRKwjE116h1t--DSqJpQfodeVb0ssGA@mail.gmail.com/T/#u


-- 
~Randy


