Return-Path: <bpf+bounces-71298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA64BEE539
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C13FC4EA985
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A92E9746;
	Sun, 19 Oct 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dSePp/hl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807572E88AE
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877951; cv=none; b=Rge8wCP1RgSNjNXo4AGrZaEPuLfV7bDrOMA85YAhIzbvw8DZYJiA6vQomYEZFSVROsJF7Ug9CAgaZkrFvsNo0p7lGBygaxtWpLEagOJUGSET7rRuTrfQj1VRBqF0H1Rv1VYfG73bIndJmTGITIE2GlSm38OMqj7TE4RwKTxRmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877951; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXeizFezmXGNsGQg4ZmZ9EfMOoDeutC88VoT0S46D3zbSfDl2W8ZHBujKZa/dk1NMBqYxjnfGesMRNM3+a0betLZuaW6pw5rhRE3UWiMK6ciHrGJd5kXK/eBIYymNZK2Hvz6yUAlmrUOLwuaLNIH1V7E20UOQ47RYYLX8tAZDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dSePp/hl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so2986139a12.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877947; x=1761482747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=dSePp/hloCpjJnKOqB+Wqa6vYAxlJjS4Yvr0PkztXFrsEEP1wK1xrYIugUe4S/DVrD
         wcxHaxsA1i22GY+SKpvGC7PbmbTKycHMlV2dA0nLj4//CYP3FpSgA+mkrUKG1d5pde0g
         NFCp5DXEw2xBbfYSKU0DH/poPshxakQZb9LnNQlz+LgkKg/VasC2UCBS4YvCyygCuRd+
         w/g+gAq+Rx1ph+wIH8Gpg/Zh3K00sVYLjA3Q7Hhgrq7h+8msPUYPZqVppEh1IXZwT9Jy
         LcMs5f+0mPx2JKsLfyfJ6w6Z3rOpMVu9PIZtu2YV9q5rrWDM42E1twxW0bRuZmfGYfsL
         wEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877947; x=1761482747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=R+aA3fV/8iJRjNQzZRFEDnUPn7iO7CAq9ehyZaJlVWqst31peimlYG5z+RM9JcsodQ
         FBIh2ESrHf9RqitMDlMAVzmN+onWdS97LE5b2FvITeJcfyAMo5tE0l6EccLYx4Vyl8I1
         hTjiBZ5AdLsO5KrNK8duL5qyvFRvDxbJN6ZW/YA3OISRCPk5c3UBNhoXu/j35rN5QuZn
         0O58qVQ1qzTNbzWQ1ct5PJLE+AXYLKe5MvR38tVc/T+rHNHyCV+/wq22PdtHQjRJMGzc
         Ar/PEhvSDONvjRHbwqilXxL2GjPZ8yNeQO+rFUSVEkKfetpgD68ltFzEwLPl2nbn7RuZ
         PH6A==
X-Gm-Message-State: AOJu0YyvaGYzPrgezo8D9tOW/TKOeKExQJsbJotcALedbsEq+fnnTNb7
	Nv9yQW8F7piS/mnfH8r1FR0M9qBwzJw80FKYFRePD1SKaHrD0LDXfWyk+YMNNsRVKww=
X-Gm-Gg: ASbGncvap0/tLTNu9P7VklURNzgr4N5e7SGGkhBAXBW85ZnBanucwiLUDKUoFuyvMpD
	izLXtvwSynHqfzu7sdv1OeNlCjuI0qhYVxMz1dl8yYQXwyeEoUpLFI39XpWyjUmx48nFevovnj2
	dgYZZr1HQWJlKoKmMSkva3RtHj7GpqxF7Sou/FSi4DQiQnrpqIFmU19KtmCiy7I1Y+C7CpPeEAz
	MjXAykSxzgSSAQKTq+gmqZ79MVMneLlcUqJ0vSup40SVV/8J/o0KAp6vZ3puyWyW6IQz77CbQF3
	Ex8BufEM8xJH/wMvHfDYaw5u7JamhiYKj1FmzIg4yunMMzmkirT4Bq2Z3Make/1BELoNcGRDmKt
	zZl0mAIU0kcTkLHl4bMGQFRWDy6rHndkD2fP4kcUS+PG5rDvrcGA922RY218CmXUDg7AHKshoIC
	UUXzEu3LjT8GFNuF6gJ5udhthoQ9fPSO+We+vY2+AOvlSB6qvGl1MhlLtvkWs=
X-Google-Smtp-Source: AGHT+IFpcO5S6siaUvsRXvkKHYSNVxPHRFrWWrlCBR9YZZMVkB0ovmLJiuoiztfM+kngKVRTvI2MwA==
X-Received: by 2002:a05:6402:5111:b0:639:4c9:9c9e with SMTP id 4fb4d7f45d1cf-63c1f66c726mr9839827a12.10.1760877946759;
        Sun, 19 Oct 2025 05:45:46 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430272sm4118779a12.23.2025.10.19.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:28 +0200
Subject: [PATCH bpf-next v2 04/15] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-4-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Use the metadata-aware helper to move packet bytes after skb_pull(),
ensuring metadata remains valid after calling the BPF helper.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index afa5cc61a0fa..4ecc2509b0d4 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -738,9 +738,9 @@ static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	*vlan_tci = ntohs(vhdr->h_vlan_TCI);
 
-	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
 	__skb_pull(skb, VLAN_HLEN);
+	skb_postpull_data_move(skb, VLAN_HLEN, 2 * ETH_ALEN);
 }
 
 /**

-- 
2.43.0


