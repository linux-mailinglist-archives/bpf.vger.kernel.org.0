Return-Path: <bpf+bounces-12734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D57D02A2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE1C282326
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B003C686;
	Thu, 19 Oct 2023 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KoAjOWrg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2B3B286
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:38:46 +0000 (UTC)
Received: from out-204.mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA8B114
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:38:44 -0700 (PDT)
Message-ID: <45656c55-3b36-e5f1-e391-fcdf3b7894e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697744322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gdtap++lMZMR+npoayI3yJj/d7NXDRQud4t4dlixIKc=;
	b=KoAjOWrgYuvMBCnvtBDFwNWO8ZD33nPPs9iWlNLqybcahwjCcVTJc5AVHcEiOIroK1ljdK
	Ohq4ZJcXM/7eiRAqDVl3mr6JTHXZnJJJlrIcuXuZqyUB9NrqZ//UczaWu0sWo5py1I1k+N
	Lv689zCHO651BaHSRJ6lWs1cZxrWmTU=
Date: Thu, 19 Oct 2023 12:38:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 03/11] net/socket: Break down __sys_setsockopt
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>, sdf@google.com, axboe@kernel.dk,
 asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, krisman@suse.de, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-4-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231016134750.1381153-4-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/23 6:47 AM, Breno Leitao wrote:
> Split __sys_setsockopt() into two functions by removing the core
> logic into a sub-function (do_sock_setsockopt()). This will avoid
> code duplication when doing the same operation in other callers, for
> instance.
> 
> do_sock_setsockopt() will be called by io_uring setsockopt() command
> operation in the following patch.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


