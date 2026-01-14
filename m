Return-Path: <bpf+bounces-78899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38300D1F120
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADD88303273B
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAF39C63A;
	Wed, 14 Jan 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diUPluS8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871639C62B;
	Wed, 14 Jan 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397411; cv=none; b=ECjTLbDxcSiw5PR8t8TvCKi269MnSEYJnwzRuDQAfLNyx08RSbabqeu2Xft9INPkbCdCKMymdDSUPkjAs+WFGv1KfdADhaNadccrHYfRyueLbElfqhRk/oKhmKSNHsCufhLthS2ooWesgJiHYgqYh1v9R9yK9XCeM/10t6UVsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397411; c=relaxed/simple;
	bh=srG/rp6SiZUedgMQAF1TOxtf22RrWkjNu0gLUr/eMZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfInS/0NR6lNqxv+0/hyn1mdwf0w4xEweXiP9k+Ysp+wEf1Ub20Gf6u+BHkijBjcT5r9qWpTYm6XTlX+cAm1YptLRaKdWeJM4zsJ38dPCdqUbxQooNk4gYMLBqbwftJsXG+JoCWVZkb5pfrJykOE0hyDKdms8TWLkvqhms7DWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diUPluS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D6C4CEF7;
	Wed, 14 Jan 2026 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768397410;
	bh=srG/rp6SiZUedgMQAF1TOxtf22RrWkjNu0gLUr/eMZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=diUPluS8kWVPcYzmKDdzumuE4Y3MysN5Sp0CRPdgXV1pEwQ2Gc25NigfXI9vYD16a
	 9qVZdKazh3NC+rXloSecyx5oEs3mqa5BLWVnX6BFWfqGgD24t1KpMUYTl/V6j52IfO
	 OhdqgsghUcxdmcz8+utpVqUWAvGoCMqEMJjhmknxE3Z58K2lG2xIjPlMvHOSypGWQv
	 Wof8DetL630oloipW8g+P/cHL0ysTMk2ESPeP5ni2miVXEZyia9IERgYkE+QNAhYZB
	 dcwiKOCD4zOivmMvJSiLq469qm/90QOhAg9Ope+9bwQazwdmEqqnEYSuRHd4fp50P0
	 C0GFtcpjFu9NQ==
Message-ID: <dcad6dc7-b152-4511-becf-9e7721996f6a@kernel.org>
Date: Wed, 14 Jan 2026 14:30:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk>
 <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk>
 <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
 <87zf6gz83v.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87zf6gz83v.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 14/01/2026 13.33, Toke Høiland-Jørgensen wrote:
> Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:
> 
>> On Wed, Jan 14, 2026 at 8:39 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>>> Yeah, this has been discussed as well :)
>>>
>>> See:
>>> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.html
>>>
>>> Which has since evolved a bit to these series:
>>>
>>> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com
>>>
>>> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com
>>>

Above links are about 100% user defined metadata, that the kernel itself
have no structural knowledge about.

The RX queue_index (as you wrote in desc[1]) is something that gets lost
when XDP-redirecting. The series in [0] is about transferring
properties/info that got lost due to XDP-redirect. Lost info that the
SKB could be populated with.

  [0] 
https://lore.kernel.org/all/175146824674.1421237.18351246421763677468.stgit@firesoul/
  - Subj: "[V2 0/7] xdp: Allow BPF to set RX hints for XDP_REDIRECTed 
packets"

  [1] 
https://lore.kernel.org/all/20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com/


>>> (Also, please don't top-post on the mailing lists)
>>>

Please read Networking subsystem (netdev) process[2]:
  [2] https://kernel.org/doc/html/latest/process/maintainer-netdev.html


>> Thanks for the pointers. It is really great to see this series. One
>> question: Would adding queue_index to the packet traits KV store be
>> a useful follow-up once the core infrastructure lands?
> 
> Possibly? Depends on where things land, I suppose. I'd advise following
> the discussion on the list until it does :)
> 

Hmm, the "original" RX queue_index isn't super interesting to CPUMAP.
You patch doesn't transfer this lost information to the SKB.

Information that got lost in the XDP-redirect and which is needed for
the SKB is RX-hash, hardware VLAN (not inlined in pkts) and RX-
timestamp. As implemented in [0].

--Jesper



