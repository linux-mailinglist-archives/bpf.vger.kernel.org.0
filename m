Return-Path: <bpf+bounces-49620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C1A1ACBA
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9BA7A21A1
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86C1D432D;
	Thu, 23 Jan 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nkFccJbk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB031B4150;
	Thu, 23 Jan 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671793; cv=none; b=py6JC4gXvw42qQVJCj3N/HrMMc5DmlAB6i8g8ilLpa5OfwxwkhAjA4SM0m+16hSmfvsYEDFWRg8Dl1EpMt/R277gAJLOd6/Q08/CUS2qC+3TO4PRg2W41mS0qElV4WPSJynFLdxRcDP8tfVU3p/Rp7bphV+09wvaE26E6A2EhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671793; c=relaxed/simple;
	bh=YB48H/+ARqmRoWKUkkmP0pzuQRt8I7HFrtDDzOWrcpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqA8OPOWJv5Xjt/x31hN9OxongAYEhWQt68OLprpTehcmKXiB55y3hlfWbDAK2LLfCVBMst6eQTbcKaLfeWmTE580fF814wdIWwH8mpoET4EeLyyxLNiyXpxQC1E3vFzVbAL2YtqHF5kZY4xwck1+WACal+HNjsWRNRiI4Vyne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nkFccJbk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ghHc9zLCAckGzCmJHTVT77V0K7lkwTGFHtjBntGfz7Q=; b=nkFccJbkw/nE4ngc8WkoJU4i5B
	l6eM++6eTShelItHhv1/yE0SL+aKjJuOlUJodBYdgA6eS05vb9775D7KCSmOQnq+JkOQJtvCwwIuq
	jTWC9RkZo0HJRES8RHcaB3/vT56ycPBbLoaj4gxVHXXddwW8MsuXHt1wpvPz+0pnXkHhho5Q93kZp
	nlx4t1MEKZwhNTAoXgiieHj4klJM0n+yKLBdYBuLd6GN3UedGv0RJT33LcCboxMumGry2VDCuScP1
	YMCiFeO39H+URp1KGHQt8LgUQzwWiHvqAfgNIQJJblz3CjEi9iXuWfeNN5pc6lLkYzwr1ocgtDgaZ
	Cm9k8ZEg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tb5oH-0003xi-1w;
	Thu, 23 Jan 2025 23:36:26 +0100
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tb5oH-000Kpu-0k;
	Thu, 23 Jan 2025 23:36:25 +0100
Message-ID: <4a6be957-f932-426a-99bf-7209620f8fa9@iogearbox.net>
Date: Thu, 23 Jan 2025 23:36:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix classic bpf reads from negative offset
 outside of linear skb portion
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 BPF Mailing List <bpf@vger.kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>,
 Matt Moeller <moeller.matt@gmail.com>
References: <20250122200402.3461154-1-maze@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250122200402.3461154-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27527/Thu Jan 23 10:44:17 2025)

On 1/22/25 9:04 PM, Maciej Żenczykowski wrote:
> We're received reports of cBPF code failing to accept DHCP packets.
> "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r74)"

I presume this is cBPF on AF_PACKET, right?

> The relevant Android code is at:
>    https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=95;drc=9df50aef1fd163215dcba759045706253a5624f5
> which uses a lot of macros from:
>    https://cs.android.com/android/platform/superproject/main/+/main:packages/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=c58cfb7c7da257010346bd2d6dcca1c0acdc8321
> 
> This is widely used and does work on the vast majority of drivers,
> but is exposing a core kernel cBPF bug related to driver skb layout.
> 
> Root cause is iwlwifi driver, specifically on (at least):
>    Dell 7212: Intel Dual Band Wireless AC 8265
>    Dell 7220: Intel Wireless AC 9560
>    Dell 7230: Intel Wi-Fi 6E AX211
> delivers frames where the UDP destination port is not in the skb linear
> portion, while the cBPF code is using SKF_NET_OFF relative addressing.
> 
> simplified from above, effectively:
>    BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
>    BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
>    BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
>    BPF_STMT(BPF_RET | BPF_K, 0)
>    BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> fails to match udp dport=68 packets.
> 
> Specifically the 3rd cBPF instruction fails to match the condition:
>    if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
> within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> which results in reading -EFAULT.
> 
> This is because bpf_skb_load_helper_{8,16,32} don't include the
> "data past headlen do skb_copy_bits()" logic from the non-negative
> offset branch in the negative offset branch.
> 
> Note: I don't know sparc assembly, so this doesn't fix sparc...
> ideally we should just delete bpf_internal_load_pointer_neg_helper()
> This seems to have always been broken (but not pre-git era, since
> obviously there was no eBPF helpers back then), but stuff older
> than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Willem de Bruijn <willemb@google.com>
> Reported-by: Matt Moeller <moeller.matt@gmail.com>
> Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner internal]
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> Fixes: 219d54332a09 ("Linux 5.4")

Hm, so not strictly broken, just that using relative SKF_NET_OFF offset
is limited in that it requires the data to be in linear section. Some
potential workarounds that come to mind:

1) When you say vast majority of drivers, have you checked how much they
    typically pull into linear section and whether it would make sense also
    for iwlwifi to do the same? (It sounds like start of network header is
    already in non-linear part for iwlwifi?)

2) Perhaps rework the filter to avoid relying on SKF_NET_OFF.. tradeoff
    are more instructions, e.g.,

   # tcpdump -dd udp dst port 68
   { 0x28, 0, 0, 0x0000000c },
   { 0x15, 0, 4, 0x000086dd },
   { 0x30, 0, 0, 0x00000014 },
   { 0x15, 0, 11, 0x00000011 },
   { 0x28, 0, 0, 0x00000038 },
   { 0x15, 8, 9, 0x00000044 },
   { 0x15, 0, 8, 0x00000800 },
   { 0x30, 0, 0, 0x00000017 },
   { 0x15, 0, 6, 0x00000011 },
   { 0x28, 0, 0, 0x00000014 },
   { 0x45, 4, 0, 0x00001fff },
   { 0xb1, 0, 0, 0x0000000e },
   { 0x48, 0, 0, 0x00000010 },
   { 0x15, 0, 1, 0x00000044 },
   { 0x6, 0, 0, 0x00040000 },
   { 0x6, 0, 0, 0x00000000 },

3) Use eBPF asm, e.g. you can pull in data into linear section via helper
    bpf_skb_pull_data() if needed, or use bpf_skb_load_bytes() which works
    for linear & non-linear data.

4) What about pulling in linear data in AF_PACKET code right before the
    cBPF filter is run (perhaps usage of SKF_NET_OFF could be detected and
    then only done if really needed by the filter)?

Thanks,
Daniel

