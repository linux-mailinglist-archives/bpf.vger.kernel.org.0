Return-Path: <bpf+bounces-77815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B17CF37A2
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB72C30A2E4D
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68808335542;
	Mon,  5 Jan 2026 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AuTlP2GI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA03334C39
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615284; cv=none; b=cRvhyhWKvdvs5JYJe80+ej81UhC64EJU6XLEfIUFKMcUkqng+/7QeZkzPDvAIKI/8eA+Z14uAYt/YJKwYKypbl12tS1SW2NKW6HTDVGVJaYNn2WDnaVI5l9374PG3fFdEqkTcKzl30OO0yoqKG2lSMSqVxeq+DnG6Sll8EsLemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615284; c=relaxed/simple;
	bh=1ck6tutHU4Ma4Atw3X74zSh/n05QAkXfc1PVlu4d8xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDqJMOsJHTzmIaYmTEYN8n4X1Bfm6kAi7Aj5gwyZwWSR1KRcPuarn9fKKP2BOO57+DPaZ4NWjLje0IIwMiVhpMcvK7ZAnhZ8vFkEEiK/IbZ1Oh/TvDqAmWnbkt/CVd1LWHAwSJTVfvUVaJfugRjOS02svOOSOiPmlPdta4Rv3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AuTlP2GI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so3430655866b.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615281; x=1768220081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=AuTlP2GIaRCZEj9/3kIiNCK8/3Sli6IFmeb6NegwzOUMadEReneU8SUzRRdFypN7vV
         LSNdO73ConesVA9Gx2/zTncQkcNhcNZX2kp4F5y02YTXbLBYzrh+66//OtvQ8NrNL+4M
         0hqOF/x4UXeK/IOsHU5/0XnvNB5n8+ZLHD1mBpSehc5IE7x/O1he2J4zLZlRel5A78v2
         6MN2q9cxlRTShXQXNWr3xcY6cJ5D7C5zTZuGfnHyr9pwAzWDzD/mkuLlfjv5IGlCD+Nf
         eMJ40RG+2XPK4t5RrEgr2E36iNU0bBLUb5/jc/pogpME/9lI4fo6RfFniZnD7iM2gk2i
         zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615281; x=1768220081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJsFK03V0pNRh3ST65sOF8XcGbv2MZfFShwn+TGVpfQ=;
        b=eQ8MoHUeuWpi9U9EAzB3qFXiQm1jDkDT34g+8HrglXDiOPH8XymblyjfNyC5V/vHfJ
         DmF4MCG3sb1P8Pzm9PXKLMDsrO1xoaaMuSDX1TfYCaxttMztWBy5eng74uo1KHLDFqjq
         oBaj6cwKE+AcCL/8dF3VVcc5ys+DXrYCw+1UC7TtYTuRy+WJGS2S9/QqH5F/rFhyyQFs
         5i9cfZBm3lC3buy7U2UjLjHDY6OiSJnDSHViPKhrcK2ACAM4o/H08DBU58jdqpMtuic4
         6sgbvFON/ahItaFl1yF0a7SSolC4QrIQjaNt1Ntl1FgWboVBhdtB4HmxmdrH4lnpa9bj
         YdtA==
X-Gm-Message-State: AOJu0YwZFERs6m2IHoP0EFxoVcH78x8zvHY84xUSYOE6YTBi07c2g+PK
	Kv/HwC2QQbdmkU2XCUUEMYoRglpASYvGAWckTjCj/TNePAJPX3sXigzNCh9Llo7yFB+or8b7Prj
	4v0aoEuY=
X-Gm-Gg: AY/fxX44h4qEUwqzZKSo9AKu/IgHdeO4AiH2UF8yLDar76Ra92wjedFCc2b/w+w8YiC
	0dKddIaHN88Kn3zJzTVdmh8q28qPHMZWKp103K7nHlkms/MSyA6MLhgGZmYspOPJW+ntXVh9qQt
	seSlSndcRzCq2OHAZWew5LPeX+mzowPokvEXcMfcyCYTn0qCLNFBvmIBIXcLEiqDSxFmLGYOumf
	eKuyZyIN/SbenlRaGWV8DFEl8iueGsGHMzrdeLYTWcmUpn/B/T/Ta28usOZNYX+VmQOmFIhtsbl
	BCSNq/yFpL7O0SRs0PWtHW1yL0fa4iYQISSS+EcGI9ZhtKLv2BwxM4ejOBLHtKiJNCgjFUKIPOe
	rXEQR7IblX3NJvAxji3oAo7P1eyNDJlUIDL7ZkvoVrZyKcqg5Sbrr+I1fwTDZJcB4ZRwQwZJoY3
	D0o7W9XjRpyPbS40vCK0L+HHhykWeWv5O175jMxt9lijM+cxLQ1cEbip0KpVyo5d3fDbG8Vg==
X-Google-Smtp-Source: AGHT+IGOT6Bk4VJMzMQiPlEuPUSOyq6Ozo/n+VyM+DoS/5EMBpe3oSN8Ey9v/D2nKU8l32oMOTB8VA==
X-Received: by 2002:a17:907:7e9a:b0:b76:6c85:9fd3 with SMTP id a640c23a62f3a-b8036960757mr5148682066b.0.1767615281118;
        Mon, 05 Jan 2026 04:14:41 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab4f0dsm5585773966b.15.2026.01.05.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:40 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:26 +0100
Subject: [PATCH bpf-next v2 01/16] bnxt_en: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-1-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d17d0ea89c36..cb1aa2895172 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1440,8 +1440,8 @@ static struct sk_buff *bnxt_copy_xdp(struct bnxt_napi *bnapi,
 		return skb;
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


