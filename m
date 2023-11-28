Return-Path: <bpf+bounces-16048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBE7FBB96
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E881B218C7
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF3458ABC;
	Tue, 28 Nov 2023 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ai5O+hna"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A3A0;
	Tue, 28 Nov 2023 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xv7kkM3bD5JS3z0Z3022nvxV1GroAeAgG+bGfaKDzy8=; b=Ai5O+hnaBD1IlpfBEz6XbT1WdI
	meyGj4iUc/6nyKEj7z+ARnl+jg88fnth38ejk1aF3NmAxGV6N2xM593Bk7heIRZ4Ana1q6aqJw9m8
	2aeWKbR1q+qcg0hibK9QRXNbw67T5Qk/hFmYljMINY6TGaoHycvnr3GGrCYalBGvtQlR0hYKK+sxP
	0HKu9H/m8NuED9vaw3kTsMGWD93OM2OHHq+y1/QfUDPHWt+F7+hIBAUVy2u+OZBYYP9v9pgS1AJR4
	hJWJjhSk114eW1FLFOtrB2rzVawmqINF8X4jBOmWThrTJ91Ul+Vc3fjBDv6pkzYBJQDnGLaH1foKb
	ZSnRnmeg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7yAC-0006Q5-Re; Tue, 28 Nov 2023 14:30:08 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r7yAB-0005pY-04; Tue, 28 Nov 2023 14:30:07 +0100
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
Date: Tue, 28 Nov 2023 14:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27107/Tue Nov 28 09:40:10 2023)

On 11/28/23 2:06 PM, Jesper Dangaard Brouer wrote:
> On 11/28/23 13:37, Jesper Dangaard Brouer wrote:
>> Hi Daniel,
>>
>> I'm trying to understand why skb_metadata_differs() needed to block GRO ?
>>
>> I was looking at XDP storing information in metadata area that also
>> survives into SKBs layer.  E.g. the RX timestamp.
>>
>> Then I noticed that GRO code (gro_list_prepare) will not allow
>> aggregating if metadata isn't the same in all packets via
>> skb_metadata_differs().  Is this really needed?
>> Can we lift/remove this limitation?
> 
> (Answering myself)
> I understand/see now, that when an SKB gets GRO aggregated, I will
> "lose" access to the metadata information and only have access to the
> metadata in the "first" SKB.
> Thus, GRO layer still needs this check and it cannot know if the info
> was important or not.

^ This exactly in order to avoid loosing information for the upper stack. I'm
not sure if there is an alternative scheme we could do where BPF prog can tell
'it's okay to loose meta data if skb can get aggregated', and then we just skip
the below skb_metadata_differs() check. We could probably encode a flag in the
meta_len given the latter requires 4 byte alignment. Then BPF prog can decide.

> I wonder if there is a BPF hook, prior to GRO step, that could allow me
> to extract variable metadata and zero it out before GRO step.
> 
>> E.g. if I want to store a timestamp, then it will differ per packet.
>>
>> --Jesper
>>
>> Git history says it dates back to the original commit that added meta
>> pointer de8f3a83b0a0 ("bpf: add meta pointer for direct access") (author
>> Daniel).
>>
>>
>> diff --git a/net/core/gro.c b/net/core/gro.c
>> index 0759277dc14e..7fb6a6a24288 100644
>> --- a/net/core/gro.c
>> +++ b/net/core/gro.c
>> @@ -341,7 +341,7 @@ static void gro_list_prepare(const struct list_head *head,
>>
>>                  diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
>>                  diffs |= p->vlan_all ^ skb->vlan_all;
>> -               diffs |= skb_metadata_differs(p, skb);
>> +               diffs |= skb_metadata_differs(p, skb); // Why?
>>                  if (maclen == ETH_HLEN)
>>                          diffs |= compare_ether_header(skb_mac_header(p),
> 


