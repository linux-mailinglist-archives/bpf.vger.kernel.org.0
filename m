Return-Path: <bpf+bounces-55428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E1A7F0A4
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 01:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653A67A5881
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B4226CE4;
	Mon,  7 Apr 2025 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrClBfMg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC74215061;
	Mon,  7 Apr 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066944; cv=none; b=UwwAOc5eOvZ+M+mWaA6zW4N3RCkb8N5H+gWvs1vy9X4BBkmM8kqI3+qromj0zpjIPYDFMQVgQ7tOWvg5VWAnAYH+rSiBSzaHMVRo0U+BmpRAHL2WrncuM82df4xFoylY1N4BnVurbI70kHk1h41ABBzhbo40eccTlb6WnJJUj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066944; c=relaxed/simple;
	bh=uB730CB1PBPl7nSnHd2UvZPlbUGBz0HQhVybjIlwOXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fkpszc4T4x/BTVRy06zmL8DLxaw/ryftzX2IRVw1AAkN4KCAdjUYht/a7RAt8dE9mL/h8oKRUlTdhm96nIzW2rKPlFGN/GtoTi7RcGUH+cNOpgnxtkc/sdZq1eRgZifZpjFUr0nyWudcAUCLQBfyhxsERTjcxIrsSTVSs0w6aBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrClBfMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4899AC4CEDD;
	Mon,  7 Apr 2025 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744066943;
	bh=uB730CB1PBPl7nSnHd2UvZPlbUGBz0HQhVybjIlwOXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VrClBfMg0WyZ/h9r8X2OZ2mzHNIL9xRbuL4QnFdFtHz1mH/zoWUfwngCG2tEt7My7
	 XmSz264vr4zmYK23dmRdbFEx/RDz3wmlIuCSEi+XErGU83xQHRYly9fbRQCMbURvQC
	 bUK1qQZnKfdxLkQgVhEUOL8+niUBSww7g6xe5SBv6xCvHuKP0B2HtYma1Ir9V5zV3k
	 o+LDFCfpezKFXcnV81qfTUR+7458/Wo9xAWHvcuLI3v1Lk5q5eDxZ+c+nVJtLSptgh
	 9Y/Q58DisZgATgKrNzMtiRahKjNYzSQs2P434ewHQuWbKtV9l2our/uqjlgi7YcnbQ
	 oZujA1DZC4WxQ==
Message-ID: <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
Date: Mon, 7 Apr 2025 17:02:22 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
 <87a58sxrhn.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87a58sxrhn.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/25 3:15 AM, Toke Høiland-Jørgensen wrote:
>> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
>> +{
>> +	struct Qdisc *q;
>> +
>> +	q = rcu_dereference(txq->qdisc);
>> +	if (q->enqueue)
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> This seems like a pretty ugly layering violation, inspecting the qdisc
> like this in the driver?

vrf driver has something very similar - been there since March 2017.

