Return-Path: <bpf+bounces-63705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448AB0A0C1
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1DF17FC63
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2C29E10F;
	Fri, 18 Jul 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="P7ZOjkLX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32B198A2F
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834801; cv=none; b=fxvZ0lfpNXqpbMU3TLN39hnIbtT6nZ0odkQccwK83ttZfgUL+ngPYvqtVcY9G6KI1BB3MjjUTwifSAEtzHna/+dJswFh5jmnvctjjjV3TRuz73Dd7zcHz0Xf40GabHQ2sIpFyeJjziWC3DwVllLemgPK8grp8bO62Uw1IfLHnFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834801; c=relaxed/simple;
	bh=MZxnnVSvs/0WsHdvQkVxja+tke/AhUx/MmlasdjPGFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REe/DOJrfgguGmZucifT4nd2iuYbxNzzs8EmRLGOaUssaA6tvr+iswYkvKAOREhchjhuneaYouMNp8FQvQVfJyyF04GXhwpoIEDldn9NsPXAIAlkW79wlakTeZFA5UFTxlvbrMTwpPGXTvLI4T1GuUrjrkwn6G/ERqU9DInfI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=P7ZOjkLX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3020368a12.2
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752834798; x=1753439598; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPH+MSL3mefkL/YatwG52J+EAfQDGfIWHdPzs+J8XTI=;
        b=P7ZOjkLXNNcCgpGjrdKGr7UGEWtpWG109mQG35cNg7JndONnv4kfvNKvFEYQPPtyy4
         7+jVGg5oNnh7IgK9iVgUf6aaldAMW1Y0zGRnu4uCrsTx/UbARjrGBqrIbSJVbA1i3vGi
         ELpBVWdqoIa/bAWTwH5A1y6Ry0Md88q7Hq2mFZnpfjowkJMewF2k/47fSSe5aztdPIPv
         10Ie1q5Hes3x47PiXA5ZfVk5Pk0SGrEEFQI6s8+zRjrnOB5hGqOrGZW29eRLmhgrsWvf
         Ul6bSLN+Ds329q9ot1QVUgFExMyrwYZwySPQ7w4mE7JqwBpFrfyb22jUxG2eWZgD/hbI
         I4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834798; x=1753439598;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPH+MSL3mefkL/YatwG52J+EAfQDGfIWHdPzs+J8XTI=;
        b=lTFRnclijMKVqea8yazy5jHUoVFvQDhqyDhI2s5eY7cupnlrJuX1bN9hIZmGk+X+kQ
         LeBfOpJVCcqjv5O9l53qyAn5H5PBLKWYvsf9R9vF+JSP1a63C6QtinNavGvfwHem7Ql5
         waM+FHE55K5xTYv73b1+gJAxuGzMXzy/tJkbi9j6w1K9z7bM4u7r/y5/5BD9dmomjtZn
         5a+R4qCx2WbypUhVQ3KNX9iBBftvKitakqhLlo92K0NAy080TGhsn/vWjO2DxiwgnuPz
         tXbQvFSALuNVUbseVlS33+TTd+4z1OX9mDxs8M1Y+lnMc8iA8t6v9VNizQxmXDwI65c8
         WT3g==
X-Gm-Message-State: AOJu0YyFCtUb+BtCIQVv3XTphGBpb0G688sfAVKci7usOE1Wn4SEKYa5
	lKpKX5W36oyry6cGZyOo0OeL2UwFf8NNzmWoKHzil0BDyugARYFRBqimkzzM6eyP6Is=
X-Gm-Gg: ASbGncv8f1JzIojHBJqf94aUB5WXTFHVGJihRafIXVw8uzDca+kXninUDwMCK3cq96c
	JA3AX7jSKea0qG83sfkgLAJ5bFOWQ5dK299WeD+/mdppgyq2rTnJzNCth2sy2WVdFqs3beojM93
	ZSGqpFipk0BN4RkZsfSCf8kSJ/1bF8hEqjfjvTjxdEdJRGYsZBZ3qdubch+TioIvNgKwuNM4gFh
	5YN1eZcd00xFH1tMnKpRE1OHzz4CYiRMahmi4nSH0IBZHG79lmM6niffreCy0FaQhkPWPvf1cme
	PTq2aSaJWGqT0ntm51ilFI/C85uEaNz0UFQ7uJO8W+R/XV5kra/RccDYerhi2bqEjUrcrDJWb/D
	OS43Rx+82lrnM
X-Google-Smtp-Source: AGHT+IH+6hYQFYOiAYWIW7j/jrNY1Cumio9CfOWO/zWzNuoianqrzk61GpNfNEJZxcXlgD/39g4ukQ==
X-Received: by 2002:a17:906:8f12:b0:ae3:64e2:c1e with SMTP id a640c23a62f3a-ae9cdda3d23mr1043328166b.10.1752834798185;
        Fri, 18 Jul 2025 03:33:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7e069sm95626566b.122.2025.07.18.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:33:17 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  lorenzo@kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <borkmann@iogearbox.net>,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  sdf@fomichev.me,  kernel-team@cloudflare.com,
  arthur@arthurfabre.com
Subject: Re: [PATCH bpf-next V2 1/7] net: xdp: Add xdp_rx_meta structure
In-Reply-To: <d0561121-3d36-4c55-8dbb-fc6b802a0f68@kernel.org> (Jesper
	Dangaard Brouer's message of "Thu, 17 Jul 2025 16:40:47 +0200")
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<175146829944.1421237.13943404585579626611.stgit@firesoul>
	<87v7nrdvi8.fsf@cloudflare.com>
	<d0561121-3d36-4c55-8dbb-fc6b802a0f68@kernel.org>
Date: Fri, 18 Jul 2025 12:33:16 +0200
Message-ID: <871pqdeqkz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 04:40 PM +02, Jesper Dangaard Brouer wrote:
> On 17/07/2025 11.19, Jakub Sitnicki wrote:
>> On Wed, Jul 02, 2025 at 04:58 PM +02, Jesper Dangaard Brouer wrote:
>>> From: Lorenzo Bianconi <lorenzo@kernel.org>
>>>
>>> Introduce the `xdp_rx_meta` structure to serve as a container for XDP RX
>>> hardware hints within XDP packet buffers. Initially, this structure will
>>> accommodate `rx_hash` and `rx_vlan` metadata. (The `rx_timestamp` hint will
>>> get stored in `skb_shared_info`).
>>>
>>> A key design aspect is making this metadata accessible both during BPF
>>> program execution (via `struct xdp_buff`) and later if an `struct
>>> xdp_frame` is materialized (e.g., for XDP_REDIRECT).
>>> To achieve this:
>>>    - The `struct xdp_frame` embeds an `xdp_rx_meta` field directly for
>>>      storage.
>>>    - The `struct xdp_buff` includes an `xdp_rx_meta` pointer. This pointer
>>>      is initialized (in `xdp_prepare_buff`) to point to the memory location
>>>      within the packet buffer's headroom where the `xdp_frame`'s embedded
>>>      `rx_meta` field would reside.
>>>
>>> This setup allows BPF kfuncs, operating on `xdp_buff`, to populate the
>>> metadata in the precise location where it will be found if an `xdp_frame`
>>> is subsequently created.
>>>
>>> The availability of this metadata storage area within the buffer is
>>> indicated by the `XDP_FLAGS_META_AREA` flag in `xdp_buff->flags` (and
>>> propagated to `xdp_frame->flags`). This flag is only set if sufficient
>>> headroom (at least `XDP_MIN_HEADROOM`, currently 192 bytes) is present.
>>> Specific hints like `XDP_FLAGS_META_RX_HASH` and `XDP_FLAGS_META_RX_VLAN`
>>> will then denote which types of metadata have been populated into the
>>> `xdp_rx_meta` structure.
>>>
>>> This patch is a step for enabling the preservation and use of XDP RX
>>> hints across operations like XDP_REDIRECT.
>>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> ---
>>>   include/net/xdp.h       |   57 +++++++++++++++++++++++++++++++++++------------
>>>   net/core/xdp.c          |    1 +
>>>   net/xdp/xsk_buff_pool.c |    4 ++-
>>>   3 files changed, 47 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>>> index b40f1f96cb11..f52742a25212 100644
>>> --- a/include/net/xdp.h
>>> +++ b/include/net/xdp.h
>>> @@ -71,11 +71,31 @@ struct xdp_txq_info {
>>>   	struct net_device *dev;
>>>   };
>>>   +struct xdp_rx_meta {
>>> +	struct xdp_rx_meta_hash {
>>> +		u32 val;
>>> +		u32 type; /* enum xdp_rss_hash_type */
>>> +	} hash;
>>> +	struct xdp_rx_meta_vlan {
>>> +		__be16 proto;
>>> +		u16 tci;
>>> +	} vlan;
>>> +};
>>> +
>>> +/* Storage area for HW RX metadata only available with reasonable headroom
>>> + * available. Less than XDP_PACKET_HEADROOM due to Intel drivers.
>>> + */
>>> +#define XDP_MIN_HEADROOM	192
>>> +
>>>   enum xdp_buff_flags {
>>>   	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
>>>   	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
>>>   						   * pressure
>>>   						   */
>>> +	XDP_FLAGS_META_AREA		= BIT(2), /* storage area available */
>> Idea: Perhaps this could be called *HW*_META_AREA to differentiate from
>> the existing custom metadata area:
>> 
>
> I agree, that calling it META_AREA can easily be misunderstood and confused with
> metadata or data_meta.
>
> What do you think about renaming this to "hints" ?
>  E.g. XDP_FLAGS_HINTS_AREA
>  or   XDP_FLAGS_HINTS_AVAIL
>
> And also renaming XDP_FLAGS_META_RX_* to
>  e.g XDP_FLAGS_META_RX_HASH -> XDP_FLAGS_HINT_RX_HASH
>                            or  XDP_FLAGS_HW_HINT_RX_HASH

Any name that doesn't lean on the already overloaded "metadata" term is
a better alternative, in my mind :-)

