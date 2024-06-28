Return-Path: <bpf+bounces-33366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193F91C3AD
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAF2283C8A
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3271C9EB9;
	Fri, 28 Jun 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eW0IJh0q"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9B20DE8;
	Fri, 28 Jun 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591865; cv=none; b=WvJkZ69Pd9jR9lVy3BsOAGdmtBw3Do3F2uErMJTFGf1kpF+MyXXxNUpyz52WeLAvFBtWjrZqDx5XUTqbtDYTcwrdIJFMriuuP2SM4e2SQWudbV0aS/2GDU4BoIsXUPDivSE4hcMbCbl+tyMmV6wVua/dBmmKlxwD1mJJ9ww7nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591865; c=relaxed/simple;
	bh=yvtPvvPRPZ1sxTgao/urH0vGpYPTK0NiFT/UVTRfUl8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HmGdnLtxr2CcglDvI2DGgi2j3BPuIbuTJvgC/SaneFOJ7drVUn2GLjjL7M7Z3GOLV5Iys2ldBHxYmhsOX6pT4tH/6+Rlnd6WTWkp5nyLle/o7ZUTkP78xUv9AHNKxV7cYvBq8Ta6r9KY6W2fMcjdU4SkmwM7CwnlcLlbqf4Diw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eW0IJh0q; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=76O4roCkGHt1MFnLnJ/Cxt40W/3GurQ7qaqeHCyHr4g=; b=eW0IJh0qyYmn8Ql5avxoVrFEZ0
	7KkgrVy+cKsUlfhL3zB+lRBCun8ep7y159fGb5PYlxCJDry7HuDAk9hl0xff0mu5gs8Licn/Zt6IN
	pjOYWyUBUXDH1WNNHl22lsqnwyvIumiwSguF9mzVKmxquqPUEHr42tFmXBkwCEhDijSwdJMlDpq+L
	tVh0yP7DpSoCXGNDw4MetoXYtjsuIgEzh64sZtHixWuulQfWoI0N9RIkvaOZpmUGNO24Y/HlPOqZa
	CSA/IaR/yVi5QNCcyzlNVOjHFiJRMdVyEPhAN8N1UGWOy1IDYU76Y2mMPbR0xQDmAdeL9KJI72mIY
	jTBrgw2w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNEOU-000EvQ-O8; Fri, 28 Jun 2024 18:24:14 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNEOU-000PcB-0f;
	Fri, 28 Jun 2024 18:24:14 +0200
Subject: Re: [PATCH net] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Lex Siegel <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>
References: <72b5939b13efd4fde6e9c0f9fb00edd314f4bcce.1719392816.git.daniel@iogearbox.net>
 <20240627144920.788d282e@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <076cd018-1c1c-cc14-7283-fbe0a37cf8ab@iogearbox.net>
Date: Fri, 28 Jun 2024 18:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627144920.788d282e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/27/24 11:49 PM, Jakub Kicinski wrote:
> On Wed, 26 Jun 2024 11:13:47 +0200 Daniel Borkmann wrote:
>>   net/sunrpc/xprtsock.c | 7 +++++++
> 
> Could you repost with a wider CC list? We don't take all sunrpc patches,
> this one makes sense but best to avoid any misunderstandings.

Yep, will do thanks!

