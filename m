Return-Path: <bpf+bounces-62458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95FAF9CBE
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C6F4A845D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9428DF3D;
	Fri,  4 Jul 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0Y2iacI"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D872634;
	Fri,  4 Jul 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751672158; cv=none; b=aegIBHrkCAs+nwO+ZITKDrHI9bRZK3QsrxM6viS4eEHk0DzQfNZ3KpNC6gkj60vLK+s2f7NhnSLvOCs9SRcFq5rzWFrWoSasRS66ru4pt9ybbZob1Q//Satuigry994okaPi+6N/ShSdZ4/LNL9CKMde1GWpJ+RFyujbDxpfcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751672158; c=relaxed/simple;
	bh=/zE3J/0CoCzt89HErxjg3GhVh5GceiIJiHiKe+a+Axg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K791JJlLlMY38BsVx1gnOXCvK2m3s5JszTym8ugzlz/uuHucP4i6Wh3mabQqIC6T1e1NJte4BeT8Ccyqv7QWmQPqKu/+5Sv/T7Oi1fmsiF20A1rTxDz0u9ZGJz9BABCQFucpaKU1jbKxCeMqsUk2+NSZNTaLnhs324HRHLsjgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C0Y2iacI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Hi4EyK/rLRYDJy1/t94IDWD3QKEsnZZVt/mgsRKQuWo=; b=C0Y2iacIvuTc9kpDCk7+iXY3qn
	5B888KhBSHYDvGLkyQZ5PH1CpEutlV2eVqWUpWqLuR3I9RZpWUyP4mGuJJcY/nLAyZ9kH2DsI6zsn
	E3gn6dER4LWzq1qwZMG1FpqX3km/RP6dd+ULTFbj6OEhTM72SXGSAOQacCbLAwiGwxX2RqMfct0n6
	TDZVd2odcruTW6DJYI0LfeHgFmcTLfmVWRsQDz7nRE2KV+lP/72Bt/Tf3+Xr+ueC3FHcZZsSdozaK
	3rUyXoZKqKc+4MwnmPupR0cBsyWlMXfG1b5zqZpjLhDNZDPmiZ6oWZUIrhabge9qb/VxhDeDJlN7p
	Ejt596UA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXpwf-000000018qI-2KgB;
	Fri, 04 Jul 2025 23:35:53 +0000
Message-ID: <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
Date: Fri, 4 Jul 2025 16:35:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 4 (kernel/bpf/stream.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
References: <20250704205116.551577e4@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250704205116.551577e4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 3:51 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250703:
> 

on i386:

kernel/bpf/stream.c: In function 'dump_stack_cb':
kernel/bpf/stream.c:501:53: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  501 |                                                     (void *)ip, line, file, num);
      |                                                     ^
../kernel/bpf/stream.c:505:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
      |     


-- 
~Randy


