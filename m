Return-Path: <bpf+bounces-20092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D20839126
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05BE1F237E9
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1B5F858;
	Tue, 23 Jan 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XDzZJJKa"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D065DF0E
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019502; cv=none; b=tPxgw68KT2GKNJwoOmk/6ChDMAzFf346WBQxDYX8ZEQiGFKkQDP5lUofwafaZMOudhQa9/hsYpathNl8Tf3Q206Ad267uXLuEFh508IdCyLD0oN+u5iovHm+55pE3jxXL/7Rj/FWPMD7sxP3yIEOFVJfAT2mNd4K9DYCcHjisgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019502; c=relaxed/simple;
	bh=ffS+ScPCeVez6OL4+Ej9718Md/hM533j2EunQLhRix4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f0iGPSzW9F096QYgMZv9xLK/a1pJmCGBv6sBEjgMutNdN/nIsGEDhX0x7O7HJKgGvt6ToacizQTOWsrEOQrERYObZnmu+owm6j0qwdSv9fwuBIYMMAu78Xb/NRMLz/OJCLf8iQn5rxKRbUalRlgIS8q7F8bFiTbPO54ULT7EATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XDzZJJKa; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+mBezMCsio4vF2SPyvg+RD4LxCVT05dQgGMQuQ/EL7c=; b=XDzZJJKajJNwulUDnHDMrb4FqV
	hqvelF/6vI1jFqySzz6kcfDHW02pNEtCC8YPILrpjIGY2NA2Srb50UVXF1cKFbX10atutedEkbPuD
	aYrLj1BW0MnJcg0wmhg4U14D4vtvPL20yQWsUJU/XPZn7KIJyPirhwGj8D9xcLHtn++41Sc742yHO
	H7EeQPtMYQWrpimF9C4sKfHsOaUYeF0Mv20kx73P/T0E6naoBncxpjEWekSjsBJ3tVl9HRX7hP6cP
	mycnD/LVdvFg9WVS0Mg3xQH2B7V8F3x8/ETlfp78j1yxC4y+uIfVPkuQLD6xPNYaayX8n0ijjAyGa
	tdLLrEjQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSHbT-000Lvz-BW; Tue, 23 Jan 2024 15:18:15 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSHbT-000Y2B-2l; Tue, 23 Jan 2024 15:18:15 +0100
Subject: Re: [bug report] bpf: Add fd-based tcx multi-prog infra with link
 support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, bpf@vger.kernel.org,
 Mathias Krause <minipli@grsecurity.net>
References: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
 <d31ca459-5fcf-9e88-03dc-42e9fc10028a@iogearbox.net>
 <c900b111-d0ee-4663-8adb-479e4eb90f3e@moroto.mountain>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <faa5f64d-8320-8dc2-89bf-b5cfc4c3b2a6@iogearbox.net>
Date: Tue, 23 Jan 2024 15:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c900b111-d0ee-4663-8adb-479e4eb90f3e@moroto.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27163/Tue Jan 23 10:42:11 2024)

On 1/23/24 3:01 PM, Dan Carpenter wrote:
> Thanks Daniel.
> 
> Ugh...  This was such a stupid false positive on my part.  I have fixed
> the check.  The drivers/hid/bpf/hid_bpf_dispatch.c warning is different
> and still triggers.

No worries, it's always good to double check either way, and thanks for spotting
the other one in hid!

Cheers,
Daniel

