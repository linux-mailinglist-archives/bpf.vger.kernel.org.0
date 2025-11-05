Return-Path: <bpf+bounces-73705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB81C37B0B
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608733BDBEC
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B634C818;
	Wed,  5 Nov 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UG7NYaft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4D34AB1E
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374000; cv=none; b=kkh2VKbAie/zsrvwkxb4D+M7P3D406WrLKHRVuusIXC02d88HuRSOFrc8MwVrubwdeGKdK4oWk2AX8RCXDm0DEQapXNx763f9PoDcxErazH7xB9wb7ZdjIxGalIt7FamBuxYIXYsGnpwwqNM5cbkv16gXW+T9m4s55QgPO1dHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374000; c=relaxed/simple;
	bh=1I+ZsuBg0UdnoIKEEzTbkQeFlzkeHVAGD2Ztup8Ifyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOQ+xUTFhfSYjb6b2zOCLyyvxtTZtmQ5oNmHjE+xZxZCMagftdFNg4Rd16296EDjmoRF6HgdwYwevs/64upt1E+joABIp3ZBi/cyj+PWSLqHaJDsl66BHg6rbpkO/VtSUEpQk8p62hjaLvFGF/HignI+C/seippkZD2S8Cn3Zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UG7NYaft; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so235639a12.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373997; x=1762978797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=UG7NYaftEppXB0x8Mce0KCEX49wsd1W55Wtg3cIyAsKTJv17/Mrihd9+FU4OuYljhU
         LXRraLbccYougGlgX7nfjOwTxa47retKOfjYPOhWLAEz7OE/zsCKpgLUhZmsGoHzz9jR
         Yo2/6kMV1L0YAGAjUtRRT2lhcq3oCEhC9/VHuwS/zmv8a67f6s11Epm51wYNjoGZ25f6
         rPNrwK/GDMOtk22UBY9ctp9eHbbTHSQYJvOFX0oahC0ZldOKwd1Yw699WC6dLG8D5gWX
         F1yNzFCDHapjyxcrT+nvNzRYjkmyxzUXj60naO6s1kN7OFXKutzv8HdaWncD7CmViwui
         zoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373997; x=1762978797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB4CC5zvn+S4YI0MbjpF4L6Qba6coIxIhHj/jqUzm+s=;
        b=LdjhpW18aHupXLiGihRoBlzRdkxvnNK6JCQlfe1YUeAZbEL41I7Czlj6Mq5h43kRPd
         QX79kkDqvk8E/8QT6yeGYfTP0S3FNn207aGTZ6mjz/GjV7fbfMZn3UXH0BCrtUorKsAH
         dxKDviErO/5F7Ygnj8Jy49PGfkCzJmSFt/dxSDu+C7XNobrcvYASCpUXa1KdUXFfSvzl
         rMaBL9N9HEDR3oZUreOn+W1k22ficCG5p1XfXBXk8q6S19ZR+QQ44xGTVPBCPQZv5P+t
         6PuHadp5g4WTG74LgNxu5kSruEDsQL10upJvb1OHuMXyEvTpabBhVyRaqT63pYyEkjGs
         QkUg==
X-Gm-Message-State: AOJu0YwOequY9W9/zIaL8u/bdq7oz65p7E6xA/Csfu4QvyyVe/qRT7EW
	8Ug1Sajg/xGQxPyLkGz9zioNvuwF3ahsOq/nYRyYqE7DbqYnqeQ2VYRHhgele1+6Oqs=
X-Gm-Gg: ASbGncvLu4D2iqZpk2b3EQHB03epnfhvwE+8VsQ3qXRy9WmGh5e2QuTxh8/gWSg6Kgq
	HuPLwECqsYydjYawHgTVjW1NTrumm0ffY30mMHIE+9pLX0ukqwVtaacULcprmwvHwPy67Cz9vl7
	IJIGmgJf2qMs2s9NRy/dziTuXvkH67woI5PQoQEEq3fLO3Mxw1el8/jcGn8xT05M4q2DCBjOP/3
	NOxGXKNiorexcdfoVGEHtlqEh33lrkrrE6KCAWbzjvsdD2rhZUoTCBeC69y66kzY1aIyZAEkdkw
	7vKt+qS0bt1AoqMTEJQwg604chLXd1BZZQSQSkLnih+I1NotBgkXE8lDIOs3sPjYyufVF1rTZ/+
	AH3EJKebdTc7veyy+KzMf7zqCLA/6yPnOt/BPXeHpgxexNogwhVkDtR0d12aLPGirCOjXx6JWfk
	RGITcQ+JxaN0jRaF1oxCJoTQL35c4uuQx5z7JRCx3eaMzojQ==
X-Google-Smtp-Source: AGHT+IERuTRjpcS2Q2Bp2khXOxcPMKKMlVGFqCA4NZtr4Y5pJb9RY7AKeaB9zf9knEK+IeOzQTSgQw==
X-Received: by 2002:a17:907:7e9b:b0:b72:5983:dafd with SMTP id a640c23a62f3a-b726529ed98mr432500766b.24.1762373997262;
        Wed, 05 Nov 2025 12:19:57 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937d305sm46188866b.24.2025.11.05.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:42 +0100
Subject: [PATCH bpf-next v4 05/16] bpf: Make bpf_skb_vlan_pop helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-5-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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


