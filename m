Return-Path: <bpf+bounces-78489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D449AD0DDB2
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 22:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE912300C9A3
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222D2C21C4;
	Sat, 10 Jan 2026 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b89wQ7Nd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6022C11DD
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079143; cv=none; b=gsXgpnIDYq7lgsExSEj76l7a8LzI0v/XH4XWHsSVEaiva1V3L2bZGrD0iWxWdt+mNRUTzfJyvkXnUYlRcCUu1cppBRSJ357DnbfDlTsH+KKDg2YAjnNvuLXOCUDEglPeoiaJ5jhruadZG/QZRffc+hX1Gj1YqdWuVMx1o3iM6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079143; c=relaxed/simple;
	bh=YYFkbgvHW4ptRZ3yNdkkSZwpQMcaeTni1eEXsRHp1lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ap5EaBJh5gM253B7imJ7a6mQYpb+A7jQrOZsTcAmsESQbslTfa0KfCxcTZ8SHJXd3HkUD8Wkk8ELDDqYCQyBukclMUSSmc23BWvmPpihn5c9T6FXqQa0sKoneMXaMzx653gdqG26yWEwupbylslibPIMnBeNeutN4r8LNknPi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b89wQ7Nd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72b495aa81so1005395866b.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768079136; x=1768683936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJGe4F24ZVfayrOmF+dW97eXhP3gCrceZMdfXokyiw8=;
        b=b89wQ7NdRStyFOGmSJCzk56eWd0V7i8uIRjgF07pV0S14YytTnZvLn1CRLy8TlNj1w
         4SW0HOGJkzQb+2zicB2Udj9v0re3Yh0K6F9EBmvQ6d4Dh1C7GP6r6h3AVY2WdJMOqMM/
         bqZIiheq5qjb78RdvNx5DeES4KT3DIQqCf0KjWlWyT5YFgiPeS4i+LRezDD1YZKCuFpy
         85lOBk0OMKEvPK9DwMIpHf4eOZrTKeKbpVqTMpMxdyflNh8Am/ApIh5sZk1JIom9P7Nl
         GAev2N06i7FPAS4BO5Dn6nlS/ZsGMOq/r1vOqQ0Ue1fyg5Ottj2xa/SUZIOv7Abk13RH
         G+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768079136; x=1768683936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gJGe4F24ZVfayrOmF+dW97eXhP3gCrceZMdfXokyiw8=;
        b=PdH4IJLKn3iQoas3xRgV6uW9w9hLciAZLZlljv35rvq+XitWLIxdk27vqB2Nd0SqYb
         GEANGWl0U0lKeypnvq7tXTBg5aQqL5VjU43j/DIiUeDw371vcElWPpnBPoEHhC5Rqqsm
         XxiW+JVPH9A8PPiQzLdNBAkkKLFvOi1g2i/pq/iF94HyQfoZB0r93NwxYzE/H+/NHaEN
         kCFsO3XblLEgJyTvGMdIyO6Rft9eE4SE0YYgoOxZ6l547BPs8jlHKb6kfdLwOQY2MLB/
         pDW+uIbSqqBp+Rg+eHRH6vTq5P9/p/P6gGYznsHnxUF+xpJY5u3yjQ+JLY0VwZQAXdyF
         i1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXgbLhff4zPSSco9oagbml+SXvIyUNcnN5Wehq64RRd/UhwijgBez8S/Oe0ec0dCiYtH6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2eGr2Liqeetn1eFtWPawl81igIeWl5pzd5IaPsyjwNqmPWUJ
	Xl7L3pOw88xnSIhr4J5R8QCGWmq0RM+6w0CsMTUJZDoKpmGVrIh3BbUoP968P+NVbMn8XYkOb/2
	hmt0I
X-Gm-Gg: AY/fxX42BNAkkGEho93jC/EK/+4Z/0+vwIr+lyfmkzCoR7XDFgFKJr7CUAmYkZd3IHb
	zSsCFAQ0ynN0vR7dtfBdG8ASZL0rCsyZMceXw0NWyat1wUjYeizfDzdfZB4rCzbuR5bHek93W0h
	md7Xv5T5p3kKXsqqMU2cUk/W41WM4DolrP68dO5loeP2UXQp8sh3+JtvGO1nDW34F5dvI2z848V
	imKx/y4PUOL/rhVLU6erqlJuHbYYBQXIYkQeL6v5iKtgnJ27fypXWQKKGmTKozken8vhgd+EzOP
	aZr92TnheC3/Y670ad19d5GcIpfn6sxYTrBAwRRgm6pJS4lDojsgG1VgpXNY9XHIqfN8qrSfPAb
	yWgeVWSkzXdq3/iaW2/XhjfgIkIwBo0xUiDPa1yYipqhnB/7xruieDYlCbTrvUAW+jAaE7Fg2ge
	Q3RxFd+2RPEOkviGYLSpr1u1AApX4VjeuOYJCGV34y1zWQ4h/jQx/NTh+6xHpYn//UNUc8aA==
X-Google-Smtp-Source: AGHT+IG5ojyykHKJrNS2iqi01P/vtltLLnJRqU4cDTs8uiHP43TabkDLYPv8nJjlhqnzI9Nx6i13Jw==
X-Received: by 2002:a17:907:97d0:b0:b84:22ab:a830 with SMTP id a640c23a62f3a-b8445233534mr1342410266b.18.1768079135871;
        Sat, 10 Jan 2026 13:05:35 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm1495187766b.4.2026.01.10.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 13:05:35 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 10 Jan 2026 22:05:24 +0100
Subject: [PATCH net-next 10/10] xdp: Call skb_metadata_set when skb->data
 points past metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-10-1047878ed1b0@cloudflare.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
In-Reply-To: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org, 
 bpf@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.

XDP generic mode runs after MAC header has been already pulled. Adjust
skb->data before calling skb_metadata_set to adhere to new contract.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..f8e5672e835f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5468,8 +5468,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


