Return-Path: <bpf+bounces-16040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E77FB974
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A01B20E97
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049EC4F616;
	Tue, 28 Nov 2023 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orhIIypf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F319460;
	Tue, 28 Nov 2023 11:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E1DC433C8;
	Tue, 28 Nov 2023 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701171046;
	bh=tJFvRHb29UV1hjsWD/7nNKH9Izo+hBGjwxMODQv16xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=orhIIypfm4VpdLLNuwrZ8SH/Zs5nnBisSW60l4UHRst+OQsvmw3+U20CwgpAq4s46
	 /9n/AXCFYsEzbFAqWiRST0SIwfy2eTKF2pWJ6mMMEI42wOZ/sddtVmQIhrqbufEtrH
	 XBxrLJyFY+DWwHKRTulWK5LnGIiy3AbWhmB1Sasn8jMz/5fk2as5WM/Snbxe+4EnKP
	 oehPtz+0/7caYyTzqJ+zQMSoY7qx3Nz76AJAWwHeu1jiNsz4MrZdBCeX6YRS5oMb1p
	 LKPe9RBSihpOLkLMCzZDdq+J5FUnqzkuhskVFIQs31Cd4u/hZZRU/J8q2UT8lxomzD
	 QgELkmhky/+YA==
Message-ID: <eb87653c-8ff8-447d-a7a1-25961f60518a@kernel.org>
Date: Tue, 28 Nov 2023 12:30:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/2] Allow data_meta size > 32
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>
References: <20231127183216.269958-1-larysa.zaremba@intel.com>
 <2fcc90b1-deeb-487f-b6e6-c649bee2e8a8@kernel.org>
 <ZWXB+8FQenT6717+@lzaremba-mobl.ger.corp.intel.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ZWXB+8FQenT6717+@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/23 11:33, Larysa Zaremba wrote:
> On Tue, Nov 28, 2023 at 11:26:59AM +0100, Jesper Dangaard Brouer wrote:
>>
>>
>> On 11/27/23 19:32, Larysa Zaremba wrote:
>>> Currently, there is no reason for data_meta to be limited to 32 bytes.
>>> Loosen this limitation and make maximum meta size 252.
>>
>> First I though you made a type here with 252 bytes, but then I remembered
>> the 4 byte alignment.
>> I think commit message should elaborate on why 252 bytes.
>>
> 
> You are right, will do.
>   

I'm looking at the code to see if metadata can be extended into area
used by xdp_frame, such that a BPF-prog get direct memory access to this
(which should not be allowed).  The bpf_xdp_adjust_meta() helper does
handle this (as you/Olek also mentioned in commit msg).  A driver could
set data_meta such that they overlap, but I guess we will categorize
this as a driver bug.

The XDP headroom have evolved to become dynamic (commonly 192 or 256
bytes). Thus, we cannot statically reduce metalen with sizeof(struct
xdp_frame).  The maximum meta size 252, could be achieved (and valid) if
a driver chooses to have more XDP headroom e.g. 288 bytes. So, I guess
it is correct to say maximum valid meta size is 252 bytes, but can be
limited and reduced further by drivers chosen XDP headroom and memory
reserved by struct xdp_frame (limited in bpf_xdp_adjust_meta).



>>>
>>> Also, modify the selftest, so test_xdp_context_error does not complain
>>> about the unexpected success.
>>>
>>> v2->v3:
>>> * Fix main patch author
>>> * Add selftests path
>>>
>>> v1->v2:
>>> * replace 'typeof(metalen)' with the actual type
>>>
>>> Aleksander Lobakin (1):
>>>     net, xdp: allow metadata > 32
>>>
>>> Larysa Zaremba (1):
>>>     selftests/bpf: increase invalid metadata size
>>>
>>>    include/linux/skbuff.h                              | 13 ++++++++-----
>>>    include/net/xdp.h                                   |  7 ++++++-
>>>    .../selftests/bpf/prog_tests/xdp_context_test_run.c |  4 ++--
>>>    3 files changed, 16 insertions(+), 8 deletions(-)
>>>

