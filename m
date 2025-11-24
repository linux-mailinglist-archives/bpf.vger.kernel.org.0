Return-Path: <bpf+bounces-75356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96CC818FF
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AD4E6618
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607FE316196;
	Mon, 24 Nov 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dHtONt92"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4731771E
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001760; cv=none; b=OB9ZxX/HizO0PHIYoDSReF6BVyH50l0H79xZpI+fJnDwIV+MHFruCveUc3VLxvXeVYT7Am1MngtwwAfRrbppQa/hPVi+meaos3Ttt03CKrTMCPvW+oIfpUa+JTeWh7wix6kYEcE9iFNN8Ofeo9+SXocACTV+wbfHCa9I0DEqpxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001760; c=relaxed/simple;
	bh=vTSKYdEKalEEC0tYawisXPYcDqtHT/RCHD4qS7kEMbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jds5UYy+Vz2lslzrCewORJAOajuLFh022iRPlt8sSrh4sz3SMfnYAyQ7Qd+dwJiWWwwRXyNtoMjDPIZctMxXaNilXO0vRl09UHf5WoRsuTCGX+4W3H8X0mwVuK6A0fqhtbAXL5iQYNXUV7IkENaVjV+FJlFJEQtzCmFFo0cavxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dHtONt92; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso7538817a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001757; x=1764606557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=dHtONt92wzI3JXRmoAYIHucF9RvpwaRgs6jQ+dMQovp/jhzuO786iecmO3sw4DASQE
         JemWWuTGp0cjG/o5KBjuYe5O2jdURXXI5hezo3uKlVTUaK8ATYM8rNptqlTceqYXinFb
         /smHU/0gAX50kUsniVa7WSp3+02JdKVAyKjj9TwNCnquGQLYlnW3rwX2fKDHCe/YPOAY
         ZVJUyEMY5v0LtlsQcoWEM/+8wopdXcrzJGYYcc19OyiqKdPloPFeDG1oWZggls1Ng0w7
         hB11vBaYzQ+HwK5mDw9GYY57WXPRhfjYFNYkFdVI9eOhA6KKMT+kh7nGHejKft8d29DS
         QSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001757; x=1764606557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=emFEi/HmqvIz35rZRGXX9ycinftRyGRx9vYGA+4BDMg=;
        b=A4N2NhQMwH6fPTzn08MYkgUMEcfNxJMjkhTfx5k79mFgkRQRmGnZgxWCmzPjyYXDJb
         E8mouvgoFNkzV6gc8zf0g+ovRWp2++YaGHyRMeV3y9UC1vIw8joTb/bFEeEKTUmuNmHN
         hKflnb5vBD05trhLETrJbf0MErjeKjrPuNUELMW9QplEsZWbGJCkwRrCP7vLunJxDlGe
         IVs/JAPOnrgUFqTBKLyAk8mE8ECA1JbBe8eIKTUA5kelvcPNszmnyMwxc0t069+ksel6
         xCyD4IYcNC0gYnQATlGrPwFD/7yV+eWLkVPeG7qy/i+IUZQJydE3eJVPGTaLvD6RGy5G
         VmsA==
X-Gm-Message-State: AOJu0Yxz0aKcagOV4zCvyZzAetX2zZbH7wXh735tlglcKixaAyHcgoF4
	jbp6FSCnSc2NvcoIFvr05e408D6veTlIuoCG82MowrnWbg021l+Kh3NkdDwfUTpIyQ8ruI4wPU9
	fr/PL
X-Gm-Gg: ASbGncuhn7HBhSEcn9160jSrrQkqjKzb6qA6cfxK85OqtgzTjI44f0Du//MViTqkZvQ
	ymlbgKClUoED3G8/4W0hw67zDWMzA7wNvPwmimggodvB3ct2NuU0Iaed8kgcBsIsno9u4VgBrnq
	55gsNpuq54xvcGioGlzFZL4ygDdWe/sz/WYI25YhnHlx1AlxknxzQSyC545sYdJotmak7H0xQAX
	NkS2bOWml82miG3YpKr/naWYJud3BN9Qwxff45EcddAkwtQ223kdw2ap476YJzyE6HFHWEqZzJZ
	g5R4RX1tjEBd8u5J4fJg4xt2I1E3rVZbfxrnmMuUd1jcwbIwDe3g5/56rMgiEuf6a9MuvX4qIOg
	45O5hQUTLRQ3YMX4mLj2HtH1TLwEpUiZUdSgKWIEkznof5GdhNKqwSX9lRpaYPewo22NrV12Soi
	XEYp5mb0JjOtWRf81l4GprZNNMPeiwpnV7eOv+LoImYc9gBQx+KYjclvV6
X-Google-Smtp-Source: AGHT+IFjSlYcMZ90WNlywxV4QME6/MJnlcnxBFfR0BbSYGWFmqHRg2YN/iBVBTy8/WuLIIhuoT9sQg==
X-Received: by 2002:a17:907:7ea8:b0:b73:78f3:15b3 with SMTP id a640c23a62f3a-b767184c07fmr1253974566b.47.1764001757284;
        Mon, 24 Nov 2025 08:29:17 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd5bfsm1354364366b.9.2025.11.24.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:16 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:42 +0100
Subject: [PATCH RFC bpf-next 06/15] net/mlx5e: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-6-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564a..20c983c3ce62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
 	skb_put_data(skb, xdp->data_meta, totallen);
 
 	if (metalen) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	return skb;

-- 
2.43.0


