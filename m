Return-Path: <bpf+bounces-72235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1BC0A961
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAE83B19DB
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4B2DF159;
	Sun, 26 Oct 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sa2pA6wN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0B26ED43
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488325; cv=none; b=i/Gz4U3h3aJlNkWF4vjD5HCJL9mHHFvBxGPoINYP4lihR1CgD9wDqIdBbSyRuH6qI2+wC5NKLFE0oPvhsFnK93arguRHmHiyuvssmKpJAeHbALvwCPwYWnmliBvzwzudJYHlakwtza1hUJoOuThCefQy1fkb0w6/JZsdJDsCB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488325; c=relaxed/simple;
	bh=jphV3hLYyJpq5wHhzxxIdaldllEhemXAkq3l8pQxo6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4xrPzYUbkTIi2aAgI/4M1QDLIqeb07SZqaOlR+YaGbWIbJlr0dvtKpz0YUUZzxc0+SXX5y+dzsdj/BtpN7XrEwWareMuS+ZAgTo95STlKX1EzY4klg0HePeWBRKpHjKkv6FepkeQQqovtpIgH12sknPw9v0ONiDcBth8GGw01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sa2pA6wN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so5674914a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488322; x=1762093122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=Sa2pA6wNT37EOrzXIh3GWpFsVcL1jKxltmWJqzaH7lRmGNZAoVJvXMm9tH4i/8qUXP
         noNDXtrZWkcI7r/TfExV4K8mGuP0bu+TreMea7L+7ZVcRnTHvYXAV8HbntPL40mPfwa5
         2gX/8MaSn1FCu1uYVqxP1QFelLktbbpCD8CHhX1kuDHFILIGhlbVsNY25WqeJe+owTM8
         +UhxwzqeFfdX65+y1LYJNBhBYa9WRZTekV9RYY0ASFHuiVLwbgPsBOTWIazNCvVecX9T
         foMAWD6H1XGo3hpZsmPHp0aToc3GxVmBzSZPc1SkeRSGkIMlDNtiz9ncINALwZYp3H1q
         k45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488322; x=1762093122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phiaj2apVtnJOs8yCgS1f4Ia15HnRGM+EMU3gmWsJiA=;
        b=Z9Gk3Xs9wmoIIVCjS4x9wkt3zSLC3SmqX+BWwQ9Vt0NWIbPnGcYf+Ua0ZwaAWvuShd
         vRdP9zNa2t5rejrKifn9GTMxY7Oi5c0puQUYCy6KetENW7HihcOCgF5J79f8bTY3SKHL
         8e5Bnm3PumJ1z7cqI6YN218v44D+z7pTsrdjzM8ZJQgqXj7axBuqdL9EtztUMucX/BOP
         5iolcQyWR2v3YgchQlp1dbmgkOrHITp1P+RPf2iKPJ/FYjs2WkKWaXnaf/P7u7QSYDH+
         GqKIG9lv7p+7nw/sAO2rhv4QoHPc+/hX3O5Kd7ti11ao/jW+FpnWDa0EE+HC7V3FKTRe
         IOew==
X-Gm-Message-State: AOJu0YyjT8eHv9tTz/FwumItI6J05jqnQ7CyZakU3Sz5F2UyPchNYBTL
	nWBbCZWJb/4VupSibLB5JFyQl992Y8AK+b6bkY/9b39oB8LFycibo7bmjAxTlmPj3KY=
X-Gm-Gg: ASbGnct9lod6tmgxz/ddIF0uji74y2aIXp8x6uSlwFVcOPzLlph7Tn9i9sdePA9uGgb
	p08U+OD4FvkuxKtJEh5yeI+68pmYrr1mvULUySGomRRh6DzlSCm3m8ifUzGLLYKCEpuZukEtFRP
	LpaBeZ5CXIn9eRRbdu1krXOU8isPcbo0LZ2EmI7YiMec9+f/JX3oG+fUuLw7+ryL/x26JvPMdYx
	esIA6kir0VbSGvmhl8b8sqAceZ1kmVOU7qcWWMQC9XShCCdwfMP7Vj2AsduIUr2qJnXvX4q2bUR
	Yq3nNk5EgTG5knv14kfdyOcPLuRQQUfjCHKx7Ihw9vunT/HousCK6Sk7vLHC0kHbQseNvhYYeaQ
	/9kd+OfYXRCBhuJh+KykcYLXP0Li9HTsDjUNpx8wyHA0xppfqXKXBRbyOayJPuOkxzacUd5BBG9
	D/vkLB2ESzhSKh1WAzFYXKt+UP1wfpK9bqkAth3f5eaXy3og==
X-Google-Smtp-Source: AGHT+IHDoSQuLmZ0G85khQ3BcIwgUaCdIiwalX9UUVGR8MCUJTFHyK6jO5jCuCpAr4Jxxp35lurlsw==
X-Received: by 2002:a05:6402:51d1:b0:634:b4cb:c892 with SMTP id 4fb4d7f45d1cf-63e600995c8mr7196990a12.32.1761488321779;
        Sun, 26 Oct 2025 07:18:41 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82b6esm4061891a12.11.2025.10.26.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:24 +0100
Subject: [PATCH bpf-next v3 04/16] vlan: Make vlan_remove_tag return
 nothing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-4-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

All callers ignore the return value.

Prepare to reorder memmove() after skb_pull() which is a common pattern.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 15e01935d3fa..afa5cc61a0fa 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -731,10 +731,8 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  *
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
- *
- * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
-static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
+static inline void vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
 	struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data + ETH_HLEN);
 
@@ -742,7 +740,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 
 	memmove(skb->data + VLAN_HLEN, skb->data, 2 * ETH_ALEN);
 	vlan_set_encap_proto(skb, vhdr);
-	return __skb_pull(skb, VLAN_HLEN);
+	__skb_pull(skb, VLAN_HLEN);
 }
 
 /**

-- 
2.43.0


