Return-Path: <bpf+bounces-16035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1917FB7B8
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FE1C212D6
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC63E4E1DE;
	Tue, 28 Nov 2023 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUbe+j3J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818C4EB55;
	Tue, 28 Nov 2023 10:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2145CC433CA;
	Tue, 28 Nov 2023 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701167224;
	bh=aMkvxUa8jrh+xeMHrO0YpnLwPEa008e4u0uJfZHC+6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QUbe+j3JZsHRJJg2Iw8+I4VSrjQmTl8OFRsXAomv8uHPmTzar8lZ0GTpe76g/IxjQ
	 3RfdfYWleKz8XNxJlN/44SuFZ4/I7kgFuQjhyJB873mrq+kManZ3ao5wYyABBvr3kR
	 MDtgqh21Wi7Nmnz6X98WS9nDzlsoUy1ANBSg23XmEBEOAq/ZHCszrsH3iz11yW1zUN
	 MfdPr/GtdwPCnxt1D+SjbH8vdYNZ5sApw1M1Wcn5JfNHvPWUSsJcZVeZ4WysVND5pb
	 /Ug90FW8TdI+tmrj4x3f5yTlEBa3cLtjUBkjiqhTN41aVG52kEHHJVn8ZJ/CiiEGi4
	 mjHbZ7MDR7pzw==
Message-ID: <2fcc90b1-deeb-487f-b6e6-c649bee2e8a8@kernel.org>
Date: Tue, 28 Nov 2023 11:26:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/2] Allow data_meta size > 32
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>
References: <20231127183216.269958-1-larysa.zaremba@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231127183216.269958-1-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/23 19:32, Larysa Zaremba wrote:
> Currently, there is no reason for data_meta to be limited to 32 bytes.
> Loosen this limitation and make maximum meta size 252.

First I though you made a type here with 252 bytes, but then I 
remembered the 4 byte alignment.
I think commit message should elaborate on why 252 bytes.

> 
> Also, modify the selftest, so test_xdp_context_error does not complain
> about the unexpected success.
> 
> v2->v3:
> * Fix main patch author
> * Add selftests path
> 
> v1->v2:
> * replace 'typeof(metalen)' with the actual type
> 
> Aleksander Lobakin (1):
>    net, xdp: allow metadata > 32
> 
> Larysa Zaremba (1):
>    selftests/bpf: increase invalid metadata size
> 
>   include/linux/skbuff.h                              | 13 ++++++++-----
>   include/net/xdp.h                                   |  7 ++++++-
>   .../selftests/bpf/prog_tests/xdp_context_test_run.c |  4 ++--
>   3 files changed, 16 insertions(+), 8 deletions(-)
> 

