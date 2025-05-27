Return-Path: <bpf+bounces-58995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC0AC51C9
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DB53ABCBE
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4C27A462;
	Tue, 27 May 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HU9PFWgJ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606E2798EA;
	Tue, 27 May 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358863; cv=none; b=cuwalWRPJ85prqfXr6XbsrhLrCcfEfXOHJBXvpkjdrUC8kPJWa+aTV1xYIMn+3GOA0BQYX/Duc57HGvVwc9lgdsbIPdCpaiFDFaMX6hOk5p1tvJ8QEdOx1dk20M3S48wtalEb6kDVOLJrsQKLddCzBMVzzFXAg65ViWXu/l3Htk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358863; c=relaxed/simple;
	bh=QsoWPcV73QWcu7HU8/pl6BOv+BVHUlw1kEb2JklOYfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfaIV4galgu4IbVyl/wHF4WtUpZ+d5Vlor6v+an9nGcp40/hkB3EVp+E2OoFe27/U51ymeP/D7QjPPjfs9lAlkKok8FOx1q/QsK1qk9GGnrtyJiCTtrEh0L1lf6RA+jKd0WOQJrZ0YVvqLCTjbVrtZ1bdvS5EyDDs7rTbsPGXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HU9PFWgJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RmHGGS3y8Q/k8hp3rM4Xuzfh083IGBKoSwvQoX92ncE=; b=HU9PFWgJbhxdqFYCh5zHEsfaOk
	S6nstMplCaDK+IhP+WJIv8e/XEpgrrqPZawtWIP/gx+dfrY+TUiaPI9vMmknxqF4MoypcC6vdehJJ
	C8RWyIgADItyDS2iuAH6HFAoyfc7/27QwNP8O3vzpnyJN3ikqH+3V3cCCYsMMPaOGyAZOcbVYiU9b
	NdRwYRaoU59ESFzTXOV0L1PNvj0D4l8zUg45gcnlvJH8SnPCdW2hzHAo+eSg7Aadv4MKiZ/K/PHMV
	LXWGFXBcupOksajAf0aszO1SobBYN8mXmrd6mYPx9ROcn9ayg7vyHDA1jXHZppNdNtX72jMhF34Nz
	lWJMNGWg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uJw0N-000GOW-1g;
	Tue, 27 May 2025 17:14:15 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uJw0M-0003Gt-2y;
	Tue, 27 May 2025 17:14:14 +0200
Message-ID: <040e674d-7854-426f-b466-63dc36cccb98@iogearbox.net>
Date: Tue, 27 May 2025 17:14:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
To: Paul Chaignon <paul.chaignon@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Tom Herbert <tom@herbertland.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1748337614.git.paul.chaignon@gmail.com>
 <458dd94a6f546156fcf2ec325424cd43be3e8862.1748337614.git.paul.chaignon@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <458dd94a6f546156fcf2ec325424cd43be3e8862.1748337614.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27650/Tue May 27 10:36:31 2025)

On 5/27/25 11:48 AM, Paul Chaignon wrote:
> In Cilium, we use bpf_csum_diff + bpf_l4_csum_replace to, among other
> things, update the L4 checksum after reverse SNATing IPv6 packets. That
> use case is however not currently supported and leads to invalid
> skb->csum values in some cases. This patch adds support for IPv6 address
> changes in bpf_l4_csum_update via a new flag.
> 
> When calling bpf_l4_csum_replace in Cilium, it ends up calling
> inet_proto_csum_replace_by_diff:
> 
>      1:  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
>      2:                                       __wsum diff, bool pseudohdr)
>      3:  {
>      4:      if (skb->ip_summed != CHECKSUM_PARTIAL) {
>      5:          csum_replace_by_diff(sum, diff);
>      6:          if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
>      7:              skb->csum = ~csum_sub(diff, skb->csum);
>      8:      } else if (pseudohdr) {
>      9:          *sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
>      10:     }
>      11: }
> 
> The bug happens when we're in the CHECKSUM_COMPLETE state. We've just
> updated one of the IPv6 addresses. The helper now updates the L4 header
> checksum on line 5. Next, it updates skb->csum on line 7. It shouldn't.
> 
> For an IPv6 packet, the updates of the IPv6 address and of the L4
> checksum will cancel each other. The checksums are set such that
> computing a checksum over the packet including its checksum will result
> in a sum of 0. So the same is true here when we update the L4 checksum
> on line 5. We'll update it as to cancel the previous IPv6 address
> update. Hence skb->csum should remain untouched in this case.
> 
> The same bug doesn't affect IPv4 packets because, in that case, three
> fields are updated: the IPv4 address, the IP checksum, and the L4
> checksum. The change to the IPv4 address and one of the checksums still
> cancel each other in skb->csum, but we're left with one checksum update
> and should therefore update skb->csum accordingly. That's exactly what
> inet_proto_csum_replace_by_diff does.
> 
> This special case for IPv6 L4 checksums is also described atop
> inet_proto_csum_replace16, the function we should be using in this case.
> 
> This patch introduces a new bpf_l4_csum_replace flag, BPF_F_IPV6,
> to indicate that we're updating the L4 checksum of an IPv6 packet. When
> the flag is set, inet_proto_csum_replace_by_diff will skip the
> skb->csum update.
> 
> Fixes: 7d672345ed295 ("bpf: add generic bpf_csum_diff helper")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Great catch!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

