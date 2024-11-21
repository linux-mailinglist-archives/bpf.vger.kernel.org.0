Return-Path: <bpf+bounces-45357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0D09D4BD8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9454B27D13
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B441CB528;
	Thu, 21 Nov 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="ezVOgyW2"
X-Original-To: bpf@vger.kernel.org
Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6C16C6A1
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188323; cv=none; b=uWtZzh/D3Pqt7byRM36vlDnCKSZGdhFsY4DfBMXjjvDVfC/LxKfT6aAD9fZqhULt07PGzAo6kPIN5DybdFg7crQGyfYlx9Ux42DHp2bfKqsZD2ut3jCS46zbqVPKmivWsQtWDTjRSyHCWjulEodZcWcClB/htZ1cAQjeqaW1TFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188323; c=relaxed/simple;
	bh=VN8kcMOTvZA0hov09g308nqTt966DoS8Jy+3442ncmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=BE4/raJGRW0eI1XVZAzcucYuTelStYaiU5LHEXIFtoReOmzzv2LxktAZEXB4gIi7LO/tQ0b2NOqmDFB2ddaYjJ4BVoSyN7+xEiFKuLW6ppJJab6Bk3ZIK9c4spCWKVveL4wFyeF5sz7jk+UMjZlScYY5OLi04T3rU47jBK5WFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=ezVOgyW2; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (c04cst-smtp-sov02.int.sover.in [10.10.4.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4XvFym5yDzz3K;
	Thu, 21 Nov 2024 11:15:44 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4XvFym1r1dzJd;
	Thu, 21 Nov 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=ezVOgyW2;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1732187744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VapkBddr2S4W5HebeNqe703YCfRWNJ69frD76lvwLTw=;
	b=ezVOgyW2CdXTlXoYDLpiyEUJbClGgT9Q3vGGGIYAR8AQmiWnQMxJmw5L+DKb4ySMBb214a
	oWkN7teTD9weXDXVcXAdsBfNZSXrsjfa5jgAYB6FePgDYxKo71kNKPhxZSf9zxAISt7yjq
	e7W3ZjhvypbLnqbVUgXD8nXfQ4ABp7b86HG1Yf1dlBXAR+fSHK1lyiywevi4j7aoJ09rKQ
	+X1hLKlshW6e4tAKUlupRKkBAFX9LWnUNGAHCq4fuM0elNoTDTa4wJ29SYzLI69oM+/NwH
	F0OUJF7wdj9aVteJnCZ1v/w7AWgX7rXJ4qLAavN0IbnIYWFxD8hRTK4sTI140w==
Message-ID: <0252e691-18f5-4e54-afff-e18147d2ebd5@qmon.net>
Date: Thu, 21 Nov 2024 11:15:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpftool CPU profiling support
To: Keren Kotler <kerenkotlerk@gmail.com>, bpf@vger.kernel.org
References: <CAJKOENWotzg5VswWbkCrbP=QgdPAJhXWOvWBGKpvRA+8WUMMhw@mail.gmail.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
Cc: Song Liu <song@kernel.org>
In-Reply-To: <CAJKOENWotzg5VswWbkCrbP=QgdPAJhXWOvWBGKpvRA+8WUMMhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham

2024-11-19 07:14 UTC+0200 ~ Keren Kotler <kerenkotlerk@gmail.com>
> Hi,
> 
> I saw bpftool profile supports cycles metric via
> PERF_COUNT_HW_CPU_CYCLES event, which is not supported on some
> platforms*. I wondered why there is no support to measure CPU load of
> a (ebpf) program via PERF_COUNT_SW_CPU_CLOCK event - I patched the
> bpftool to support it (as a POC just replaced the attr event def in
> the metric list) and it seems to be working.
> 
> So my questions:
> 1. Is it risky to use it? (Why wasn’t it supported in the first place?)
> 2. Does it make sense to finish the patch and send in order to release it?
> 
> Thanks,
> Keren
> 
> 
> *specifically I tried to run it on Intel(R) Xeon(R) CPU E5-2628 v4 @
> 2.30GHz (Ubuntu 24, kernel 6.8.0-48-generic) using AWS EC2 machine
> (and previously on an Azure machine). I suspect it might not be widely
> supported on cloud providers hardwares, but didn’t research this
> theory.
> 


Hi Keren,

As discussed off-list: I'm not aware of any particular reason blocking
support for this metric in bpftool. I suppose that SW cycles count is
not supported today simply because nobody has needed it to the point
they'd spend the time to implement the feature, so far.

So if you're interested in adding support, yes go ahead, thanks for
working on this!

Quentin

