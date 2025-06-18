Return-Path: <bpf+bounces-60953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E12ADF0D0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D957A56A4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2372EE98C;
	Wed, 18 Jun 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="IRfNXHvx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544A13957E;
	Wed, 18 Jun 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259527; cv=none; b=ugIuJTJwkzkp1zfb3IiuiLHJxARJw1vk0XXNvYyr6dOyDSWxwXsRD19vg2Dxr7r3FgB+uLM0CABFN31TV0n4VVZDTq8JKwI7IaZsBX9ThHSTZadOig90DnUFq/GQakgyAnVwpFCOCZXmwxtV0F/WdjsVIxBiDkj4QPEGopK/Nfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259527; c=relaxed/simple;
	bh=9qXHVKH8f/N0LEcbPda4sJZL4SPMC/6YyX5V1p2E020=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ay8IH0bqVwcshVvhS39gEC6bvcpqO9jzDZpnrj3iUG150ZhuCuae63LAJYyAVttwzFc/J4skewMIRhfcozihn4zENS0lVS7U9Jat2G9wM7/SAi2pwtlWbU+K2iFBS/pN9cj/8oQovX2PjPNy04zYkJ3Qx21WVp6RjeV5uogbMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=IRfNXHvx; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id BA89524088F;
	Wed, 18 Jun 2025 17:03:55 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 87BBF240298;
	Wed, 18 Jun 2025 17:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1750259033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tCHHvOhRh9DyZZnyFB+HgxzJLHpg95SPVSIL7ZFZ3bw=;
	b=IRfNXHvxuDsTXXsVrMyczXi6xQeT4l87uG09OQWNT7QdPaxbtYoTOz4UI29cMSbSbU4bab
	OVmZ8nVMouL2oCPv4DqynXxlnW8D1mPDq32vBZfhYKoARa6Lpa2JVJJKIjAhFqIWbGftLr
	6a67hLylL92ZUHcYZ6txObjFfHzAOO6IfCSOnP8V0vWAkseGoWGSjs0naqnnBIQ/6tbNDH
	Ai0mrP2Tfz2qRXQ197I3/4chSvkNOXC5ZxWaWMyDAU6Nnv9duiweXtLrQzI1XCwx8lfS6V
	Q4bmqO2s1znkgiZrT+3j7HaGhj9VkQITjEmsfc5hB9aY5XwPcjDFZcVd+GMHlw==
Received: from [10.35.35.41] (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 89949240165;
	Wed, 18 Jun 2025 17:03:51 +0200 (CEST)
Message-ID: <d02c6db8-6bd8-48b0-b235-cf132d42057f@tk154.de>
Date: Wed, 18 Jun 2025 17:03:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Content-Language: en-US, de-DE
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
From: Til Kaiser <mail@tk154.de>
Subject: Configurable XDP Generic Packet Headroom to avoid SKB re-allocation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 39b83b
X-Rspamd-UID: 6a1df6

Hello,

While investigating performance issues with XDP in generic mode, I 
noticed frequent SKB re-allocations due to insufficient headroom, an 
issue also discussed in earlier proposals such as [1] and [2].
Currently, netif_receive_generic_xdp() checks against a fixed 
XDP_PACKET_HEADROOM (256 Bytes) [3].

I would like to propose making the generic XDP headroom configurable per 
interface via a new member in struct net_device, e.g., 
xdp_generic_headroom initialized to XDP_PACKET_HEADROOM at device 
allocation. The user can change its value via Netlink and/or sysfs 
before the XDP Generic program is attached to the interface, and 
netif_receive_generic_xdp() then uses this instead of the hardcoded 
headroom. When the XDP Generic program is detached, it is automatically 
reset to the default XDP_PACKET_HEADROOM value to avoid conflicts with 
future programs.

This would allow users to avoid unnecessary SKB re-allocations if they 
know their program’s headroom requirements in advance.
Would this be a viable alternative? I’d be happy to prototype a patch.

Kind regards
Til

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/039064e87f19f93e0d0347fc8e5c692c789774e6.1647630686.git.lorenzo@kernel.org
[2] 
https://patchwork.kernel.org/project/netdevbpf/patch/20220314102210.92329-1-nbd@nbd.name
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/net/core/dev.c?h=v6.15.2#n5279


