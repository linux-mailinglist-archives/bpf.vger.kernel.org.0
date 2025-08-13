Return-Path: <bpf+bounces-65562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2BBB255E1
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68421B6211E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F13009E7;
	Wed, 13 Aug 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2QInnnN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A673009CE;
	Wed, 13 Aug 2025 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121481; cv=none; b=buvmrdb05+Xfo3jHceX4f0qxPFxzYP9GwlaaxJJt2cnSi1je4kz7t3auuRy3ktjo5sb1TB6JBtsbHUqKXqN9Fu/zUMW9jASQYo0vaScUUH6oPlIvwRfI76+1kVaebRTd7HMOeATKDozt7RJsKLxuiaF3ncJRXh58F0Evmhx2xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121481; c=relaxed/simple;
	bh=B8TLYOrm+thjL4AQ02G0n1/XMDfyeRaTPTTh3wBgamE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoyQpfU8mKmWoOWpVLBsHuc6/K1wap9tijaKyrlbQHdrl3c18JVHieWwoU7QqBOwufNDymMX/8TmagPd6RA46ypp7pSffwb/bar+ei3DsFu6C2SYe1ip8lRe7HftATqrYHCLWjKQfuKTEWCqBZ7HvJ+O/CJ9xuOrQnG+dtfyXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2QInnnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E2DC4CEEB;
	Wed, 13 Aug 2025 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121480;
	bh=B8TLYOrm+thjL4AQ02G0n1/XMDfyeRaTPTTh3wBgamE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2QInnnNt/HVy/vizQGgmRFvLlqgKCRIG9rNzWPPhBbTXLUwzQcOf2UqdwCSSyI8e
	 q1qHQhLW14Qr++1k+f2CMBIORs3LN/GDguSfgIk04jUXF2X2TDFWUDz2MpV4Sz8hkP
	 0PgjuGX1AYHwN5rhoS3sbs+A6Ev71AmyP95Nh751QAg2DdHLI+ZzMYfbkeL55ZCs12
	 GQFuIkyipA6S4cNQI7PSYsEcUxrLSJciqpdycHpwLVB4rDrjwE57QpkbgkeHx0kaKU
	 rdzFkiuR0+WcauQqPmBE2o+mVEPveMiefATbYLMuvFqkxRmHs2+Zu1+Pli91hNP80Q
	 sM+alGGZ8El4Q==
Date: Wed, 13 Aug 2025 14:44:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, lorenzo@kernel.org, toke@redhat.com,
 john.fastabend@gmail.com, sdf@fomichev.me, michael.chan@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 marcin.s.wojtas@gmail.com, tariqt@nvidia.com, mbloch@nvidia.com,
 eperezma@redhat.com
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
Message-ID: <20250813144439.71a09e9a@kernel.org>
In-Reply-To: <2ba29c9f-a44f-4be6-bd3a-eb9cdb34ac8a@kernel.org>
References: <20250812161528.835855-1-kuba@kernel.org>
	<46470d2b-4828-48ad-a94e-9d874de1b2fc@intel.com>
	<2ba29c9f-a44f-4be6-bd3a-eb9cdb34ac8a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:43:21 +0200 Jesper Dangaard Brouer wrote:
> >> Does anyone prefer the current form of the API, or can we change
> >> as prosposed?
> 
> I like the proposed change.
> The only thing that confuses me was that the u32 flags is named
> "skb_flags" and not "xdp_flags".
> 
> @@ -314,7 +313,7 @@
>   static inline void
>   xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>   			   unsigned int size, unsigned int truesize,
> -			   bool pfmemalloc)
> +			   u32 skb_flags)

It was matching the helper names: xdp_buff_get_skb_flags()

If we rename it to xdp_flags here do you want me to keep
the helpers (xdp_buff_get_flags()?) or access buf->flags
directly in the caller?

The idea was that the helper could filter / transform
the flags to whatever the update function takes. And the skb_ 
in the helper name was matching the skb_ of the arg.

> >> Bonus question: while Im messing with this API could I rename
> >> xdp_update_skb_shared_info()? Maybe to xdp_update_skb_state() ?
> >> Not sure why the function name has "shared_info" when most of
> >> what it updates is skb fields.  
> > 
> > I can only suspect that the author decided to name it this way due to
> > that it's only used when xdp_buff has frags (and frags are in shinfo).
> > But I agree it's not the best choice. xdp_update_skb_state() sounds fine
> > to me, but given that it's all about frags, maybe something like
> > xdp_update_skb_frags_info/state() or so?
> 
> Yes, function is only used when skb_shared_info have already been touched.
> 
> Performance wise it can be expensive to touch the cache-line for
> skb_shared_info, so the code carefully checks xdp_buff_has_frags() (flag
> XDP_FLAGS_HAS_FRAGS) before deref of skb_shared_info memory area.
> 
> Calling it xdp_update_skb_state() seems misleading. As Olek says, this
> is about updating the "skb_frags".  The original intent is that
> xdp_buff/xdp_frame is using same skb_shared_info area as SKB, and when
> transitioning to a "full" SKB then we need to do some adjustments.
> (Looking at function code, it is of-cause confusing that it doesn't
> touch sinfo->frags[] array, but that is because we don't need to, as
> non-linear XDP and SKB have same layout.).

Let's go with xdp_update_skb_frags_info(), then.

