Return-Path: <bpf+bounces-69955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C1BA97E1
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BB43C7AC9
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF53090D9;
	Mon, 29 Sep 2025 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S5iEM8VL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370E3090D0
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154968; cv=none; b=X08HAf6HjTNyUOZEW8XaEKSvM2vWCn1cz4l8dQjpt7Guylb3Q2ayigi0NhTotc5YjcLaGL/ttRI4pCb2W1CPd6w3U7b8bllqPFB2sQ/A5V8I6oR+DV1zdyOx0iF5aKp8TnnRBWqTWZ+Np8qBTUXZC/3nUSaLnUli8+aP2ZBC1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154968; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=misZpN24n1ndd8evR4naJZ7BZYEt07Ow+/ioRbEk/k072Jw41bt/tF8+1gqnDyyEWxkJrg2QaTXXWE49slLINsUiAJk+1+MD9X1/0XdIVZVYNVAbcR9crwYs2BkFLNA1IoEB5npfltqG61Oh8IW/oprb4I2l+Crshi3+1o/OhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S5iEM8VL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso4099745a12.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154965; x=1759759765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=S5iEM8VLrSdeUyB6aRRmzNG7aAEZ4r4uTdldCsR3FP6XwGA60vgw/GzPeVWTR5INQ/
         eWNs63/Ghk7S7JF/E8TRSwP1O6f+oWr1rPo1+8vovaLqDvR9PrStxg0WVOFtIt8EkosL
         oU9UOJpRa4qEDSS6RL/JHl7LSqbBVogzvepC1guLNQYitdakGOyK8jEerlIQEp9LUrDf
         L7HOQQIVRbOaasrvxB7T7s8aI/IT8rVaTebr0fHj+MZxsc5sHFOY13hXrw/PqR0vU7Ly
         uIdCcd2oztwdmyZVX7VJo9MHWYHjiv+r5yUQq0osbaDxlUjswYImnINyT7CBvWoaci1T
         WzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154965; x=1759759765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=TLDkoFRnj8gMzjjKZCalPfUUzzxHEBuWDlFkJrKFbdqBTBZq3QS8nKIrBl8hfplNa8
         7K1mNjS/7O2fmR38G12+ul1xJCA1AN0eXbp2Fa/aR4W3bUVz5Y3mjMLmamVjiEibgChX
         INB8empntae7XB05fsAsGlLlXkVjEtAM+zizvJrfJhpxhrJSH2HOhTOv85mjVd+aZUWu
         HXwpraefx1k7NXIZfYOhfOwGIvIDxVBbInomqalnzB+4kEwXq3jnE3SGfVWmfNa0le1g
         x4W3xTcWjtfBi51V2WyCOgiyIuVT0ks9bMWhXoK0Md2PKvcl/2B1OB8vETeLxO5Jo5b8
         Tddg==
X-Gm-Message-State: AOJu0YxdAYQ7WbXGeR7OEMyxeQXP8yzSEJbSxTUaCIGBfweEfoUlBg/H
	vDXHzfMrsPtmVzsmlPPtH8Pe4GKhxxwTQwiaFMBdesGKKF7KcRWbkX0vkLVm91aUDhxXco+rzo+
	dhAoY
X-Gm-Gg: ASbGncsry+1yzRVCarXbq7Ylg7zBtKzJUHYbdrE53D96Tt2d3yaNZvy0eDqla3HaXBr
	HhiayyPIsGYm2a7gafp9AKEss+vXvqcA+EjoLXkPSTbxVo+eK5qOl056UKXZJAV1W9PZZji0VR/
	1KkRnsbWIzJmd3u0prjRJ8oojYcCWQfVjVajJEA45u5ERlr40w2uQ96akutQxuTroBpd8Nyas2z
	cY25eaIsTEd8xalCQBZJMOD2vIBt1FB3rS09W2PouzdayTbK5TORZzWDpxFXTMmn/XJNPAhdp/b
	7xmw5cDsLgxC5DHu6X5E+LSO7nExxGZGt12HuPsLW1xtfVsfNY+EYakrsIe9QPlLWczPEnYFfhB
	3/NtKEymemJOcP1C31F4u3wxDKEYJJjykR0UbZHxa3oqlFw/eHSYjRzjp3lFgLX9g68HJJl3WTu
	DnU+lHVA==
X-Google-Smtp-Source: AGHT+IHfYTKK7D2GCRM7CjqrVNQEML8OsJ5npVFLVU8/k6C4bbxCNtkV/3y4ZkdiBcYJiEQN9HqjkQ==
X-Received: by 2002:a05:6402:d0b:b0:62f:4828:c7d5 with SMTP id 4fb4d7f45d1cf-6365af2b69amr638587a12.16.1759154964842;
        Mon, 29 Sep 2025 07:09:24 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a36521c2sm7847111a12.20.2025.09.29.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:09 +0200
Subject: [PATCH RFC bpf-next 4/9] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-4-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
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


