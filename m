Return-Path: <bpf+bounces-61844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE7AEE19A
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE827AC213
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE828F531;
	Mon, 30 Jun 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xo9ug5pR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDEB28EA76
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295367; cv=none; b=fnV9Nnfdovs79JUpJcEF3YCYyWqXCPDn4P4ICqHywf7E78eTj8Q5ekJWlVsCT5+HBuF8RZixIKPdbC3bojYP5kbtWsUyuXB50dl5EHJAjjh9IPgXdohTpGZ4UypCTAK8bRt71FStzIzDxY0UE5dUOGg5L0F6XY75p7KpBLOOdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295367; c=relaxed/simple;
	bh=TDEFTacL7djEqHpABiIdeZuuRtjb8OR7YNrSJZFenlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nj6br0yBeScd9W2omlj67vDIzzmKX6/mW+XEdknmNE95d0SKWUVr0DH3En98g6k6j6CpuadxrXgfvly4k1NVogBkf8Sf5VeUBJxo/fiNP0H7ZT26Dg/QcnWBLft3KWFdnTWF4jGEUvZ76yIxh/sZ5yVjdJtX6mIo52idyViXW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xo9ug5pR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3766899a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295364; x=1751900164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCcnMwKNb++fyWYmbwcO1TGXRqyK5XVW7IW60BPy7mo=;
        b=Xo9ug5pRsuOu4kwTS2JWL9uPh519PCv0u0yi4KMaUQtS+VomIEz06SkxUasvRc7ikw
         MG2wArc1wL7Krr5rsxYbf0Y4Prad9Tfi+yZh40T9jQxM1gUNwo9760bjqjHrZT/gZ1bA
         dxIP0lp3O9R8C4Q4sDmVH+inNGe/29LPjnFFvMWmxzI2Uslt7PWhXFNvkuCSaktYKheG
         XnexFCFGOgzWv4y26EYKV7z62o9d5lJRH8tB5lECsohMf1eUMObmK61de1RCezO4V5os
         lJkaYfaIAW7VT3D8HiE3AnqH115sK5YM6O0hA0g4Omot0o62t0AMDZnhXnCdw7rKBW52
         RN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295364; x=1751900164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCcnMwKNb++fyWYmbwcO1TGXRqyK5XVW7IW60BPy7mo=;
        b=kOr6oRVPyUnqBxRvt4eqyHgRTOX/r/gos5EJjOcphBqP0/IVzV9kdvAkNLqFbkWFKE
         W9tyhgKIS1rW64o6C2qhejipoVf7AxLlWCMAPpXb9xvAVqP9U1b4+WOKihXCwxE9c93k
         3iAAcca39BlEniNKITEmsL14fsNBbMxIDWCmC76v5DGazlD5iubBInIptQ1Chbzjwhb0
         +pShNWQv5WPNRPvFSi17ZlMtEq/hPHvzXI2nh377+0ESEr4tsWhmDjnUhS+YF6rsfFrW
         +jBYaV8vFNwlI+Oz+09dGizDnk02b9v5Sliltm7YKcEd1uJaeRMl006MaAyy6dFKfuop
         FfTw==
X-Gm-Message-State: AOJu0Yyo2JHIkjBrwH5gKtYymi/Pb4cDL2XbjEiPTQuUB/TtHNYVrBZF
	S/kVnP8fdNET0z+pvw04Z6QdcBdLzVIVH8dGI8UkWAJAmX83kZUN4mxzjHtDhWlOnA8=
X-Gm-Gg: ASbGncs+BAiPj/WJ5joo4W1kqtiJZfl9mQtVcsWwVuLf6KB8EphcQ+Q/TSXSNVK3U+5
	IGAFBlTHKAtee//NeWKDg7h43HIGrSaRUygDkJ+Ih2t4Ork5+iXwJJgFFGlYGYznXI+4c1pxjUn
	/nWjdkUCzQOVf1ZxVR6yw9OkHbIMc/Ejd90qhDu5/f+YVpNEimI/V0NRXBztFSxNVaxYhT1rtjX
	z5HepIlZs/rKywCm9fR0VAEEyS0Sig8LJXf2dMa5DKwooiaSgj327fRstxh0MOOz+A2cvklHfG3
	Y31jxJoaRWklS3RaQlDNwnlWQSYi76KDXMQ1u8zHK7KeUaH+c3Pvs16s0sQiz/PF
X-Google-Smtp-Source: AGHT+IH9Fa4kiQKfb7hemNPlqBf2T3m141VlECeU+kmO/yhtIpuASpkwJDEuTZHJnosNzrZ4altY3g==
X-Received: by 2002:a05:6402:90c:b0:608:6754:ec67 with SMTP id 4fb4d7f45d1cf-60c88e3f3dfmr12149465a12.30.1751295363537;
        Mon, 30 Jun 2025 07:56:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c832073besm5840974a12.73.2025.06.30.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:40 +0200
Subject: [PATCH bpf-next 07/13] net: Clear skb metadata on handover from
 device to protocol
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-7-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

With the extension of bpf_dynptr_from_skb(BPF_DYNPTR_F_SKB_METADATA), all
BPF programs authorized to call this kfunc now have access to the skb
metadata area.

These programs can read up to skb_shinfo(skb)->meta_len bytes located just
before skb_mac_header(skb), regardless of what data is currently there.

However, as the network stack processes the skb, headers may be added or
removed. Hence, we cannot assume that skb_mac_header() always marks the end
of the metadata area.

To avoid potential pitfalls, reset the skb metadata length to zero before
passing the skb to the protocol layers. This is a temporary measure until
we can make metadata persist through protocol processing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..4a2389997535 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5839,6 +5839,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 #endif
 	skb_reset_redirect(skb);
+	skb_metadata_clear(skb);
 skip_classify:
 	if (pfmemalloc && !skb_pfmemalloc_protocol(skb))
 		goto drop;

-- 
2.43.0


