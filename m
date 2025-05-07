Return-Path: <bpf+bounces-57667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32583AAE6CE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B099865F5
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29728BAAE;
	Wed,  7 May 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrQsKPXF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281811CB31D;
	Wed,  7 May 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635754; cv=none; b=BbsKsh+9yD0qYjCXFnfej6wHeJ1Spxd1Ct2m2HSnkmKr3XD/Ngyoy+99OCMbw6j8xvubWae751nXzx51R4klcruZn4MXsQHvUBaVq8QJRfLjCW/xANyhuHpFRDOG045qaaj8L92+khZo1jDocgSkUnxIe7xzHgAOc/hZig0ioFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635754; c=relaxed/simple;
	bh=sblmv0utzdv+8ThOgBE6raOXo50apK1luciquPL4aqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0rnbFJxtT63xeuOrRJ1thm3u/J0LOfbR5qWoq8WXONQi4FtdJA11RFOFkOqbUnKKXO2hsrbILdZck8wkfpKDUSGGKxvObOOxasbdInWJmv/2yZSnCacnkigwsgu2edKW7+z/JxdQd8Q/LrMy4lxOLdeByXQd88wc9PHlgLeDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrQsKPXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00791C4CEE2;
	Wed,  7 May 2025 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746635753;
	bh=sblmv0utzdv+8ThOgBE6raOXo50apK1luciquPL4aqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JrQsKPXFa+whGnrNIZLEKq/rKZXjjPjlLx7TUV83ByJeL7QTml4aWFoBaeWajyUhP
	 U6fvWU4nm8QorQF6M/vWAyOG8Fc9RPEZbBJAbKIsJ7rZL9Kfzoe/l/r0+VUpHaWYsr
	 Q28bBNvl0KEVqfhJTmOtLWBT3kygJSfNvla5kUTxKUNBn7CnkxcDijwPCix1upydi9
	 jdP/TIDc+Nxf1REe6i6aW2gDpZLsJcMQ1fIMdUGo2S0nJRqV2wezHKTXyF0Ba/ysSr
	 2pzJaGQOZgIkvSFGZF54e8SZHEXBqKRyIzx1knBfyqAn0BkqoTsugZ2wUorPPSYXKb
	 BHOqor6JzyZRA==
Message-ID: <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
Date: Wed, 7 May 2025 18:35:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/05/2025 15.29, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
>> On 05/06, Jon Kohler wrote:
>>> Introduce new XDP helpers:
>>> - xdp_headlen: Similar to skb_headlen

I really dislike xdp_headlen().  This "headlen" originates from an SKB
implementation detail, that I don't think we should carry over into XDP
land.
We need to come up with something that isn't easily mis-read as the 
header-length.

>>> - xdp_headroom: Similar to skb_headroom
>>> - xdp_metadata_len: Similar to skb_metadata_len
>>>

I like naming of these.

>>> Integrate these helpers into tap, tun, and XDP implementation to start.
>>>
>>> No functional changes introduced.
>>>
>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>>> ---
>>> v2->v3: Integrate feedback from Stanislav
>>> https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1794658-1-jon@nutanix.com/
>>
>> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 

Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>

pw: cr

