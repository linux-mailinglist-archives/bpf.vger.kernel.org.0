Return-Path: <bpf+bounces-12731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABC7D026C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2349E1C20F05
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9F639853;
	Thu, 19 Oct 2023 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cMOzuvxp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EC354EC
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:24:52 +0000 (UTC)
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A478E8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:24:51 -0700 (PDT)
Message-ID: <97a90b2d-cdc3-ac00-b1d7-1e735648ca8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697743489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erlpPmXWY7ZgLDQf2M75tSp97C2n2Bc8pqWhV/xELGQ=;
	b=cMOzuvxpwmLzmJbBkoXqhQdHNGyh15FaR2A2gm2PCoORxqU7QRUcx0BtQsWs6aqYz8dzyj
	1DPOnTWCaGdln779BeQw8Sfo29neyXcflWnltqZScgP/n6pNZTbYx6WYFGw0B8IHdxTNYE
	qvWySZcJ7YIXtL+4TcvZRm3dmO5hoTM=
Date: Thu, 19 Oct 2023 12:24:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 01/11] bpf: Add sockptr support for getsockopt
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org, sdf@google.com,
 axboe@kernel.dk, asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, krisman@suse.de,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-2-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231016134750.1381153-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/23 6:47 AM, Breno Leitao wrote:
> The whole network stack uses sockptr, and while it doesn't move to
> something more modern, let's use sockptr in getsockptr BPF hooks, so, it
> could be used by other callers.
> 
> The main motivation for this change is to use it in the io_uring
> {g,s}etsockopt(), which will use a userspace pointer for *optval, but, a
> kernel value for optlen.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


