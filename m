Return-Path: <bpf+bounces-75639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16113C8E2C6
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5524E764B
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53A30EF81;
	Thu, 27 Nov 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWWwpRGO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBTSEjCX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45732E7BAA
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244928; cv=none; b=f26eaURAYL1sN/QYezSOoZ3//XWXp2/Oc6XS/o1tCM6tqVjj0yZ1K7xnpaJyBHK2CoMMD27yVi6uZiAhg0FzwfENfww2EqefKJQFDfwxGE3aXF4U6U0LFSi+j8FZVPfi/d85CpOgSCwoyJ2FWRSAeOgp74I96X885OJsrmiMLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244928; c=relaxed/simple;
	bh=ehWkCwHPO+pEw5/TrMrZVgpPVFj63hERVhd6qBsrUHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2kvGoGEDMaP/k6qMS0enRlYVc3itI2SJGxhK2pDnGcjVR/SO5ArJQOo73EQI394gpNd2Wl0Z97fMtfSQE+aRioaWYttCTW2G9Cd8/QunCFMV0/q0LixY+qF2ezvxPb4JPH0jDnJVtrSvKQhftzXCID2T3MWgAn1zjtAhOXd4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWWwpRGO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBTSEjCX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764244925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
	b=dWWwpRGO5VQm0OF1hRWRsVW7og1+6uP0mDY1fOfeZ0dbS0RteuaQ0YMWLuFa2gCotaxKyK
	kJU1grCM4KsjeDOZTszei94PyfnjWaco2P0k4qvBtlPwvsQ5jz1TwTDectfEvihs/G86dS
	vaFU/dN4BbxziwVHpyjM8CTmTeV5PsY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-wK_PpNksOwm4VLGQWBSx4g-1; Thu, 27 Nov 2025 07:02:04 -0500
X-MC-Unique: wK_PpNksOwm4VLGQWBSx4g-1
X-Mimecast-MFC-AGG-ID: wK_PpNksOwm4VLGQWBSx4g_1764244923
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779da35d27so8233895e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764244923; x=1764849723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
        b=RBTSEjCXWwTYESlXCR8h+fS6VC653h/5RJ18s9OxekjAj5UPB2Sq6gqYGY0VfLBxbe
         bwN29YcdnHUMgiDzRKWuhvWOlO/t7xBOtwZcNrbgU69gXS/YulZv18V663PsYxkch8Dr
         22EXTO/UwfY89clAVmvoMCo8L+qUi23izg4wf4XXLT9YWthl+ZRvJnbspAw7AF3wWmD/
         iodnX0ueWUGPEPR9D1UceRiDQNgfq9L+Z8mo5yhhkixUqXe3hhM2dDeZYa6tRu4yAIAJ
         oNyAktUBMmw6zJQk5ymg9aGCJAbogGQXIzYWywE3jLaVJfCTk6/stJK8YGFmNEmlWXIG
         ylAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244923; x=1764849723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWnfD3GFw00Hkm5qc5oCR9LKbsLwnCgkNDSNLBjpICc=;
        b=X02tFpKQ+NgYjw/0tAKfB3RUSCsMbacsK0IoQIWnsXdFcKOuaBo2ot3u+Crw8Hlh/4
         w/9Gm95va8OHykesHo7NmdMB/VzP9QJ+bIOt2eDB0XKy0QbGHy7sQ4ZGE8VP5m0Gyxho
         AfGBdOVfSy4lXBIDl1eIwU9nNSC3erYm8jf8eDhomUBRLNgEP1zGdy6KlRrB1fWcrv5W
         cfEesnz7HMWPhnSdkolcATzzwjBWs3FGSmiBhtPWeSj8iIqjANlnPNiEBgX3aMmRT1tm
         elAKqgZPTNEaGZrv5PIOCd7LEZESgWnNywYela8+SdPKzPzba7RIMY7xo1McPtA07n+p
         iglA==
X-Gm-Message-State: AOJu0Yw1iDhlLqZEhB4z57j5R9hcfm+K4Vk3PqDtR24Cf5ScSbvCBU3q
	gUtqd2QyCQtNUstfMcdWjB2ckjdc57QxYr70KOIZ654qxw90J23Q7W0IG0u9Bakfe4W2bZVoOnK
	DSxdU+/xg1lTHL8lpXPu8sH0SK2gzMKLC8a3LUcn42NkB+fR1qh4zQw==
X-Gm-Gg: ASbGncv2y3pb+sdaGELsgi+UU5Zp4Q2wrH8huYbuo09b3x6hweBzG/GvZ42LN0ytOnk
	dC4c0i584Ruv8N8xYtbyy2VOi6XtpBJu3o7CkGNPzzGVo5I4f/HfvVHf6M3+8V8tLySnrdTOCy7
	+z85CDwsFxjVjpHtIO5tppU6g9EJSJ7JKwz4dGs2XSRcJUVybQKTG4gv3uAtFVRNFPhlilOJRGO
	I8hSZb8uhw68xzc6GBPldRHru/euuaxqgZeQXuHgEVFjNvuEs05zJUosDPePlRalXp2a8H8m81o
	2MKShmXK1k179lNWfyadUdmhhLHwqbw9aNM59cHU3usi7F2bFJyomCZw4PL/UGasZbMD7duvyR3
	q/O04N8eShx9qEw==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr98284605e9.26.1764244923116;
        Thu, 27 Nov 2025 04:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2W68LFAdvuVXZdLjoN0So8upVJgTz0J7veoBYOYmjnfap1Go0y1jQBhOt+rN+UOJ2VeylEA==
X-Received: by 2002:a05:600c:4f48:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47904b2494cmr98283915e9.26.1764244922617;
        Thu, 27 Nov 2025 04:02:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add4b46sm100442865e9.4.2025.11.27.04.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 04:02:02 -0800 (PST)
Message-ID: <b859fd65-d7bb-45bf-b7f8-e6701c418c1f@redhat.com>
Date: Thu, 27 Nov 2025 13:02:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] xsk: skip validating skb list in xmit path
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125115754.46793-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125115754.46793-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 12:57 PM, Jason Xing wrote:
> This patch also removes total ~4% consumption which can be observed
> by perf:
> |--2.97%--validate_xmit_skb
> |          |
> |           --1.76%--netif_skb_features
> |                     |
> |                      --0.65%--skb_network_protocol
> |
> |--1.06%--validate_xmit_xfrm
> 
> The above result has been verfied on different NICs, like I40E. I
> managed to see the number is going up by 4%.

I must admit this delta is surprising, and does not fit my experience in
slightly different scenarios with the plain UDP TX path.

> [1] - analysis of the validate_xmit_skb()
> 1. validate_xmit_unreadable_skb()
>    xsk doesn't initialize skb->unreadable, so the function will not free
>    the skb.
> 2. validate_xmit_vlan()
>    xsk also doesn't initialize skb->vlan_all.
> 3. sk_validate_xmit_skb()
>    skb from xsk_build_skb() doesn't have either sk_validate_xmit_skb or
>    sk_state, so the skb will not be validated.
> 4. netif_needs_gso()
>    af_xdp doesn't support gso/tso.
> 5. skb_needs_linearize() && __skb_linearize()
>    skb doesn't have frag_list as always, so skb_has_frag_list() returns
>    false. In copy mode, skb can put more data in the frags[] that can be
>    found in xsk_build_skb_zerocopy().

I'm not sure  parse this last sentence correctly, could you please
re-phrase?

I read it as as the xsk xmit path could build skb with nr_frags > 0.
That in turn will need validation from
validate_xmit_skb()/skb_needs_linearize() depending on the egress device
(lack of NETIF_F_SG), regardless of any other offload required.

/P


