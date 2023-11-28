Return-Path: <bpf+bounces-16045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879997FBA3B
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 13:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3D1C21429
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA84F60B;
	Tue, 28 Nov 2023 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKXHaiCv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391BE57876;
	Tue, 28 Nov 2023 12:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500D0C433C7;
	Tue, 28 Nov 2023 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701175064;
	bh=NpaJE5wWV0saL/VmxWVgh/H/xgc5Uqzp1bDwbHY+yyY=;
	h=Date:To:Cc:From:Subject:From;
	b=KKXHaiCv0pDKxQ0ft7roZ0YAUAkmPlSMlGJLT/l2qXvHkiBp7SKhcF+IV8/xjHUI2
	 flPXUoUtrAdKoe8SqWMgGNNjppVcE3oa3aIe3aZhfUcTdxFAHe7KlFW+6FE7lArlt4
	 K/nPY0j734zYkkKDsWNFbCO+qPHG+a+9TuZZ+vqiRFodpY0Cnk9lcuoL0DrzrTMD+r
	 iCZ8KybmJNDCSwn+bbIV/BGUylt2NFg6bU4gk/PRYb3FUXDWrHTVvZXbqviGksW9Kr
	 rukPnVwuFps20FaxhCLUhN4y+nX+rBf9rtSBRsKEezd+vKajHqXAIR2DjYi10Ixjct
	 hIYZfzYBaHkPw==
Message-ID: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
Date: Tue, 28 Nov 2023 13:37:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, kernel-team
 <kernel-team@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Does skb_metadata_differs really need to stop GRO aggregation?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

I'm trying to understand why skb_metadata_differs() needed to block GRO ?

I was looking at XDP storing information in metadata area that also
survives into SKBs layer.  E.g. the RX timestamp.

Then I noticed that GRO code (gro_list_prepare) will not allow
aggregating if metadata isn't the same in all packets via
skb_metadata_differs().  Is this really needed?
Can we lift/remove this limitation?

E.g. if I want to store a timestamp, then it will differ per packet.

--Jesper

Git history says it dates back to the original commit that added meta
pointer de8f3a83b0a0 ("bpf: add meta pointer for direct access") (author
Daniel).


diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14e..7fb6a6a24288 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -341,7 +341,7 @@ static void gro_list_prepare(const struct list_head 
*head,

                 diffs = (unsigned long)p->dev ^ (unsigned long)skb->dev;
                 diffs |= p->vlan_all ^ skb->vlan_all;
-               diffs |= skb_metadata_differs(p, skb);
+               diffs |= skb_metadata_differs(p, skb); // Why?
                 if (maclen == ETH_HLEN)
                         diffs |= compare_ether_header(skb_mac_header(p),

