Return-Path: <bpf+bounces-35646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9AC93C3D3
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A26B231DF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DE19CD11;
	Thu, 25 Jul 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gFta7bZk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A91C8DF;
	Thu, 25 Jul 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916795; cv=none; b=cPHoZiWfkwtOWbx49GBcJl7gy8ivOsA0C4+wOzuhoCxunrokzzgUg7NEDUQO6cmflUF1OIkbzdL6EJuLGS/UOsTRLX+a2M1w+t4A3D4KW7JMwz6XDAAPzulK/88ykRR3nsf2/sOBog8FOkTh/6Ftgz9VX23OXBlVuMkwrdXgiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916795; c=relaxed/simple;
	bh=ZMyjb9umuc/z6Kxw3fRRu1lM4wDQ84uN+EQXieuQUZE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AEkWHA5FPRTugPts73K6VfLcuTuxr+jfCjOO4v30jBCFcTIfU1Sb8rauio+t82kq4lanz0JylLsj6LkWoKXE/RkYQxDNUSB8IjfXNl8D7P8f1mbCQU/wTW6ZZgmC3mxLj27ciESEmd9SoU+3fbeU6zmH9IrYCTvEW/7OcHL4z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gFta7bZk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=X2VO/usH3A0l1QH3ygPxcxOoPniwGfXYs928t2nGibs=; b=gFta7bZkUezKjU1ufmcjwUB5rI
	c/40Z52CCf7kK05NaozFQaPYlg7IrV0r7ta5gnFQncjRzbOpfxW+q8aPzFLOK/h07Yr2mcY4Mmx9E
	hNg1uBvtvtLbrjmxf2+i9gYGLHdcEj3VVKA5y2akJzyJhZzy2pyla/tdzrDw120YJ+B/YZHiUhqGp
	umV+APLxxObVkVayD9sgWp/z7RkDda6+6Xo6cUoy/w1JYTMEijOsAssZGJZ9cRXiKot8jgeyxTfxx
	+68xvSyHf3TH/UI/2Slleh5ZO67UtPEDKK9dRxY2sPBJXOIjwfNEf6YbHfGynjqE/jY8Qig+tPWe+
	AlySepvQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWzDJ-0003N5-H2; Thu, 25 Jul 2024 16:13:01 +0200
Received: from [178.197.248.15] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sWzDI-000AQP-1g;
	Thu, 25 Jul 2024 16:13:00 +0200
Subject: Re: pull-request: bpf 2024-07-25
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, chantra@meta.com
References: <20240725114312.32197-1-daniel@iogearbox.net>
 <20240725063054.0f82cff5@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce07f53f-bbe3-77d1-df59-ab5ce9e750d2@iogearbox.net>
Date: Thu, 25 Jul 2024 16:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240725063054.0f82cff5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27347/Thu Jul 25 10:27:42 2024)

On 7/25/24 3:30 PM, Jakub Kicinski wrote:
> On Thu, 25 Jul 2024 13:43:12 +0200 Daniel Borkmann wrote:
>> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> While I have you, is this a known in BPF CI problem?
> 
>   ar: libLLVM.so.19.0: cannot open shared object file: No such file or directory
> 
> Looks like our BPF CI builds are failing since 8pm PST yesterday.

Looks like you may be one step ahead.. BPF CI runs tests with LLVM17 + LLVM18
at this point, so we haven't seen that issue yet. Maybe Manu has?

Thanks,
Daniel

