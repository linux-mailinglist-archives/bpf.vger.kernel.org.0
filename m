Return-Path: <bpf+bounces-65498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F456B2449B
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 10:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA73B288E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352152F067C;
	Wed, 13 Aug 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKXWQNUy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83A2EFDB5;
	Wed, 13 Aug 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074607; cv=none; b=R8Kie8Uz3VVVfu4wjc9Kq8yU8UFHew8G4efSe8nl5zG5n4uDTy0zIJ1JXSujDJMaWyZY1abOrQZcMUkme5mrLVX/YDnKQUGcaztcUEQAz8eWMJUL2keAnkklXtjyeyGmeNw0lfPJ6b7uca3zpPJt8m70trKuaRUhSexiT/1m9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074607; c=relaxed/simple;
	bh=w8gAexE8HUB0CV05DNC00MXF4b6kSy0iHfD/95EwwEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwxlsMpkmmO4viPid75PVomstN/lGBUxrIyPT0o6zjc/bQX93GrwonvRi35SatX8cu3ZvaJ7BtOzVzTVWoL3W2B/zzgU6wR+8D8LlhE6Y1rKXGs7+TZbD2EVX/POMNqXmc6GCCZy4PmobEdPvuzcXyTcyiqyxLVakHxw54i1xxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKXWQNUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AFBC4CEEB;
	Wed, 13 Aug 2025 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755074607;
	bh=w8gAexE8HUB0CV05DNC00MXF4b6kSy0iHfD/95EwwEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TKXWQNUy4Nypry+jJm861Bpp76KsJzsLO9J9bSFS4/omiS8os+tGxStcEoQKhSYo7
	 SimvbVRavtza6ljVDbU3iLqiaIccfNI9CVadnMY7ECd1yJXligH21wLfmjGg8oLRsb
	 oOiK5Iql9fH8qq/e30fMnWYPzEw7mAIEM2Qnzt6hG1nxv3CjxQ1rgerXjOYHUc3aA8
	 gycMF7RXmfeDRzvd28g7XZ80jHaFEWfpVdYQUBElcKnTZAu3ZMQJIZjaWgjdVhJDw8
	 kkydB4g/3ZluY4yRB8qXC0pN29MxtASl4Y4N7/CpZ3709d4UF6hA6pD5+eutteREKe
	 iO9DIpODpVrBQ==
Message-ID: <2ba29c9f-a44f-4be6-bd3a-eb9cdb34ac8a@kernel.org>
Date: Wed, 13 Aug 2025 10:43:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, lorenzo@kernel.org, toke@redhat.com,
 john.fastabend@gmail.com, sdf@fomichev.me, michael.chan@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 marcin.s.wojtas@gmail.com, tariqt@nvidia.com, mbloch@nvidia.com,
 eperezma@redhat.com
References: <20250812161528.835855-1-kuba@kernel.org>
 <46470d2b-4828-48ad-a94e-9d874de1b2fc@intel.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <46470d2b-4828-48ad-a94e-9d874de1b2fc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 12/08/2025 18.48, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 12 Aug 2025 09:15:28 -0700
> 
>> xdp_update_skb_shared_info() needs to update skb state which
>> was maintained in xdp_buff / frame. Pass full flags into it,
>> instead of breaking it out bit by bit. We will need to add
>> a bit for unreadable frags (even tho XDP doesn't support
>> those the driver paths may be common), at which point almost
>> all call sites would become:
>>
>>      xdp_update_skb_shared_info(skb, num_frags,
>>                                 sinfo->xdp_frags_size,
>>                                 MY_PAGE_SIZE * num_frags,
>>                                 xdp_buff_is_frag_pfmemalloc(xdp),
>>                                 xdp_buff_is_frag_unreadable(xdp));
> 
> Yeah I think this doesn't make sense, it just doesn't scale. We can make
> more flags in future and adding a new argument for each is not a good
> idea, even if more drivers would switch to generic
> xdp_build_skb_from_buff().
> 

I agree. And good reminder that some driver have already switched to the
generic xdp_build_skb_from_buff().

>>
>> Keep a helper for accessing the flags, in case we need to
>> transform them somehow in the future (e.g. to cover up xdp_buff
>> vs xdp_frame differences).
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>> Does anyone prefer the current form of the API, or can we change
>> as prosposed?
>>

I like the proposed change.
The only thing that confuses me was that the u32 flags is named
"skb_flags" and not "xdp_flags".

@@ -314,7 +313,7 @@
  static inline void
  xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
  			   unsigned int size, unsigned int truesize,
-			   bool pfmemalloc)
+			   u32 skb_flags)


>> Bonus question: while Im messing with this API could I rename
>> xdp_update_skb_shared_info()? Maybe to xdp_update_skb_state() ?
>> Not sure why the function name has "shared_info" when most of
>> what it updates is skb fields.
> 
> I can only suspect that the author decided to name it this way due to
> that it's only used when xdp_buff has frags (and frags are in shinfo).
> But I agree it's not the best choice. xdp_update_skb_state() sounds fine
> to me, but given that it's all about frags, maybe something like
> xdp_update_skb_frags_info/state() or so?
> 

Yes, function is only used when skb_shared_info have already been touched.

Performance wise it can be expensive to touch the cache-line for
skb_shared_info, so the code carefully checks xdp_buff_has_frags() (flag
XDP_FLAGS_HAS_FRAGS) before deref of skb_shared_info memory area.

Calling it xdp_update_skb_state() seems misleading. As Olek says, this
is about updating the "skb_frags".  The original intent is that
xdp_buff/xdp_frame is using same skb_shared_info area as SKB, and when
transitioning to a "full" SKB then we need to do some adjustments.
(Looking at function code, it is of-cause confusing that it doesn't
touch sinfo->frags[] array, but that is because we don't need to, as
non-linear XDP and SKB have same layout.).

--Jesper

>>
>> CC: ast@kernel.org
>> CC: daniel@iogearbox.net
>> CC: hawk@kernel.org
>> CC: lorenzo@kernel.org
>> CC: toke@redhat.com
>> CC: john.fastabend@gmail.com
>> CC: sdf@fomichev.me
>> CC: michael.chan@broadcom.com
>> CC: anthony.l.nguyen@intel.com
>> CC: przemyslaw.kitszel@intel.com
>> CC: marcin.s.wojtas@gmail.com
>> CC: tariqt@nvidia.com
>> CC: mbloch@nvidia.com
>> CC: eperezma@redhat.com
>> CC: bpf@vger.kernel.org
>> ---
>>   include/net/xdp.h                             | 21 +++++++++----------
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 +-
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  4 ++--
>>   drivers/net/ethernet/intel/ice/ice_txrx.c     |  4 ++--
>>   drivers/net/ethernet/marvell/mvneta.c         |  2 +-
>>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  7 +++----
>>   drivers/net/virtio_net.c                      |  2 +-
>>   net/core/xdp.c                                | 11 +++++-----
>>   8 files changed, 26 insertions(+), 27 deletions(-)

