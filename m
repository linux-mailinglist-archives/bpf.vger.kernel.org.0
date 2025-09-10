Return-Path: <bpf+bounces-68042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72462B51E87
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A11C86A75
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55372C11C0;
	Wed, 10 Sep 2025 17:05:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2C29BD85
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523918; cv=none; b=A77orJ4VS6owgITQ7YoOZpTmkTw0EsdminbN+XHMmZYVvjJfC3v9GVxyIUfuqc8atDhCYV4FX5sQwQArUUy08HlbTsdXySeqNRSvuUYNaOtfFBLVuo2WPdfgOXx9/KRdJSABoZ/16niXRbDBy7pDkUOJaTcgR2Em0wC1JgQm3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523918; c=relaxed/simple;
	bh=wG+7LZNX7s5LYYcmQjUqZsUh/cW2Yj3VemW29RyBPIM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TdUMpeNm/DzWGv36pwoIFY5RfVcQCOSBRQk68FfeytleWjK7XIOSfnFDnJXFcik+5gNI8I1U1Jc43pTj/s6pSZYlNQT/qsUBzEA7yMlPlxoh60UYP/vAZD4HJ4Wqxp3Nv3pjmFzAW8LTHUnQvhdDHB2IT7iOttE2DEzVXVZnmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1uwNvM-000N9f-CG; Wed, 10 Sep 2025 18:44:00 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1uwNuh-0008I4-0W;
	Wed, 10 Sep 2025 18:44:00 +0200
Message-ID: <4bfab93d-f1ce-4aa7-82fe-16972b47972c@hetzner-cloud.de>
Date: Wed, 10 Sep 2025 18:43:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
Subject: [BUG?] bpf_skb_net_shrink does not unset encapsulation flag
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Language: en-US
Cc: bpf@vger.kernel.org,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Organization: Hetzner Cloud GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27759/Wed Sep 10 10:27:04 2025)

Hi,

when decapsulating VXLAN packets with bpf_skb_adjust_room and 
redirecting to a tap device I observed unexpected segmentation.

In my setup there is a sched_cls program attached at the ingress path of 
a physical NIC with GRO enabled. Packets are redirected either directly 
for plain traffic, or decapsulated beforehand in case of VXLAN. 
Decapsulation is done by bpf_skb_adjust_room with 
BPF_F_ADJ_ROOM_DECAP_L3_IPV4.

For both kinds of traffic GRO on the physical NIC works as expected 
resulting in merged packets.

Large non-decapsulated packets are transmitted directly on the tap 
interface as expected. But surprisingly, decapsulated packets are being 
segmented again before transmission.

When analyzing and comparing the call chains I observed that 
netif_skb_features returns different values for the different kind of 
traffic.

The tap devices have the following features set:

     dev->features        =   0x1558c9
     dev->hw_enc_features = 0x10000001

For the non-decapsulated traffic netif_skb_features returns 0x1558c9 but 
for the decapsulated traffic it returns 0x1. This is same value as the 
result of "dev->features & dev->hw_enc_features".

In netif_skb_features this operation effectively happens in case 
skb->encapsulation is set. Inspecting the skb in both cases showed that 
in case of decapsulation the skb->encapsulation flag was indeed still set.

I wonder if there is a reason that the skb->encapsulation flag is not 
unset in bpf_skb_net_shrink when BPF_F_ADJ_ROOM_DECAP_* flags are 
present? Since skb->encapsulation is set in bpf_skb_net_grow when adding 
space for encapsulation my expectation would be that the flag is also 
unset when doing the opposite operation.

Thanks,
Tobias

