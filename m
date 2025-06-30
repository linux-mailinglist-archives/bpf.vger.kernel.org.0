Return-Path: <bpf+bounces-61843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34544AEE198
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8FB7A44D5
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD7B28EA53;
	Mon, 30 Jun 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eXPjpdUa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2A28DF00
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295364; cv=none; b=qjEG/5RN8gmWZdllO2jv8ptXYhnsa1VUmiNOPwOJBMeRzZK3FrzwLoyZ4cA6R7y/IkwQVlZT+Ap/2mrX6U3aWN4k7BsVaURrvKSAfwXC9bcT8ONeY0BnbaiD5/CS3fnpb8VRBYTaLiz06sA+hls2Rxz0tETsU+ohgPZYW6Vsp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295364; c=relaxed/simple;
	bh=a3ROTLqAavkp4rwfffb8mrqANhf7FzXtyeXu16Yhpac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7cXbElMkscVa2USazZaOXvVBydWeVfMumo2A5VT/vtT3WZNXKmodm19IRtwJVuNYrui6kmTJueGLkt4ulJ16QbWbfs1yEU+eAerTB9T+FReWwJ4k9pISVyxGw1eRh4WJsZqcqTTVqbrNWJLC8lKBwplFNTOIJHkNeTaWFy2E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eXPjpdUa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae223591067so393493066b.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295361; x=1751900161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD26vKIyNfL79HGbpDEINEAFFrRHmSLhjJgTVN9WS8Q=;
        b=eXPjpdUaQ/Jt3viyMeIsItSLO8b9ayRfwssZTkZ4Gx+ikKV6eBpbxTqdFaVa51f6BO
         4l2y7nSenGqgawwIsHJKytL0Fb7KE4SM9p/xiNaxjRyNlCZiKQCe2pF+Ilzrx67/trzp
         6OkGnk0ZaNju8e8QtY38jSRYRtt52uoRf56ugbfnm1JqO7EcXy/+Zet8OZjMW+dBq4wE
         NijTJH7ue2NiQCJWw1XSyvOAeh2KrMd6Tlu0E6XVV7gBdA6l1ObL6py5zFxhJrQJL1gy
         3Oo8Q3/ShWLo9kBMmlaVDMBsLqMEt97jGgGqYgjAvu0CyYZb+iY9nZlohrDK//YGSHu5
         npDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295361; x=1751900161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD26vKIyNfL79HGbpDEINEAFFrRHmSLhjJgTVN9WS8Q=;
        b=M+2v3GZ3zTCpIrv1BMVYze2CxJh+y0YXKDTprXYDfBqE7D+KyXWell75rTub8qyaZ/
         MwX/JhYxRCUQ7hs7w33n0Y/43OTx/HmEcnPb6COflvjB/yABt/wVqKUyWDqSE+K6zJqa
         7H/e8p/wYtgHV7FZB9HCQYIskUy+B5pBVHItw4zOi8mk7Et+O6Kp1t7FXIHRXm9q0BKs
         JsnllJBabPkgjMuGcQ9D2SF1AK4zNv2AtMUHbM/ltGpVtnu3TRZNkO75KDrfSzMzRjYx
         PjWBfw6i2P+EdRW1Sr1P5Z82ed5mGfEopfZaouy4EHZFj5VnPXdA2li2SsKbbFKll9+p
         EDUQ==
X-Gm-Message-State: AOJu0Yycn5RnR8gpRB/CllGhD9XWp7msfjvHWnjFbsK3B8WEfL/PYttu
	8ljuWr9H/yb/LaCkVptIlcuxyGQGiUwQXvspmJbIJssrj2HmP+L8DYeiesTfbCVxXpsjSDhkl4S
	hg97r
X-Gm-Gg: ASbGncvb3vD22x/wObVuSZXFwaRBURt5we0ME9ftUyXWme6nNKTLjhQU5tOG9FL6RDs
	bqKAxIKBfrR1Qg6ExEgsZkZl3IuTFCcgrfZlzr2LEhgSEiLTfOjDh3FPS5y+K6DNyIfKXtljgV+
	Ne6pFM1yedRHgiRunmzSKRsuv11uUPUuZLgRFuUwXtIfojjZr0cI+b8KhExPWoEvPDmtUMX1uXX
	9RzcCiTpmEEQd4PWqxKMx5YiC4kgUS+95m2kWsl4gNFV2rV+REVZUmpd9B680anicoJAUKDSvTn
	kcyTyUbO2Xg8qCytbQFgl5Qt6LIP7ahYObEog1i5gJc20w2/XIpscg==
X-Google-Smtp-Source: AGHT+IE/Zb4rMlxmPjOzNJkDM1x0qOLrMzF1G2hhd8OLqR9/IZ6Ax0J9kuqbvn21eDwI6nQWBwUXDg==
X-Received: by 2002:a17:907:968a:b0:ad2:2146:3b89 with SMTP id a640c23a62f3a-ae35019cefbmr1245806366b.47.1751295361273;
        Mon, 30 Jun 2025 07:56:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659fdesm692689966b.69.2025.06.30.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:56:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:39 +0200
Subject: [PATCH bpf-next 06/13] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-6-f17da13625d8@cloudflare.com>
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

Make it possible to read from or write to skb metadata area using the
dynptr slices creates with bpf_dynptr_slice() or bpf_dynptr_slice_rdwr().

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index ab6599f42bb7..020da46f93a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12033,9 +12033,14 @@ void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
 		else
 			return skb_pointer_if_linear(skb, offset, len);
 
-	case SKB_DYNPTR_METADATA:
-		return NULL;	/* not implemented */
+	case SKB_DYNPTR_METADATA: {
+		u32 meta_len = skb_metadata_len(skb);
 
+		if (len > meta_len || offset > meta_len - len)
+			return NULL; /* out of bounds */
+
+		return skb_metadata_end(skb) - meta_len + offset;
+	}
 	default:
 		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, ptr->offset);
 		return NULL;

-- 
2.43.0


