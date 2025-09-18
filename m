Return-Path: <bpf+bounces-68825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45433B8617D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B016B1C2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5223BF9C;
	Thu, 18 Sep 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1NHgdDy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3C220F3F
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214031; cv=none; b=NuLJYvbYYP4eQeDlw32WM+GOIDwlXbaRkgfQSnyhPdZao+a82xkTJq9+CSGcfWEkHDbofuZrWnNXbToJzWfjGDzOQB8ZBByCdYDixvZ9r9wO/CgM4OecT8jtdaH/B08gMkskB/bJeYW8tQUrIjqm+zK9DghlJcSmLmi3o9lIaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214031; c=relaxed/simple;
	bh=uviyCQmlo1MCa+9hKkfaBK4vHCraVtFbyoZ04W/Axqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcH7IPLvxdueSni4cJWznIZ6lHu+iydP3dIfsHPlEy5uklYLTJ6NItmPhVkbiw1ARxc6Bg+CLxfg0E1f0V6co8vpkYex7ZaG1hiuGGwdsZJkDuPL/mooYGTl5ITR6k/bDAo+/1aDkRMFgR8S6vslV3Ywwdef419GXRpnh9unr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1NHgdDy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1000670f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758214028; x=1758818828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNrMbVpTFqoXO3385vekH1PhnckeHNboaMqJge5AvVo=;
        b=K1NHgdDykxSUypo4PMy1962/j+ciN3qQPNtEZSQdBSEsQ41aIPoqryNLAKExVc2UmM
         dLvqhRkqrYFw1ZJhs+SZaPyZ933JvnHCV/FWQaE7Fw9t1vxM6wvocMFSv3mXB4iXyyhK
         hiHVFAq+nn3piohO8D1AdQQDm8xxN2BOdpiJ+UMSkNoQcl7IB9gSwklJ2JzNg7MHeCOq
         I3ueUE3w+/n1C4+yes6AeMdrpLytXaS6msmIGMJRNlBRvTA93r4RyttlObIlUdcgBIl3
         9zC8pwfbRF+4681ylA+6inAHXvggruHaVQSSPdgqpXaBJd3RdPicwtIPSIBiAh5ozPAX
         2pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214028; x=1758818828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNrMbVpTFqoXO3385vekH1PhnckeHNboaMqJge5AvVo=;
        b=EvOXmpYN7sbCbk5CDlfC8nPVsoKzKvvKUxRDGMB0i3QLKOwEvAFKJ8wCLKFFC2Kbx7
         IgYAX42Qm0OKJ/u2b7CzJcDOzGZMQBzz/0XQ+mEkxvpvFC1I3LHDD/PxKKgjAvx0DsxS
         cGXKogoGUS9o5F7fGK+h1Z7b7pQTeqnpM0kWRIQiY42zvFeqbVe8pcG4MlMcPh4KJECQ
         xxGx5vKrQn/Ydh3pzP8ZAsTj9vb82fGtHyjMEiTL96esnVF0aRpro4HwgHAKO3d+vKVo
         NqMNYaG9nOVeosJwIYVr7KjVJ2zCT20G76pkjWXE3PE1BK3gNjp+CVw/lJJo/x31Up5d
         LytQ==
X-Gm-Message-State: AOJu0Yz3GX6xLtCk2HvGU/8dn0C+bJsVfED2Q2U2y3UBzKo/ndoSMRvd
	D/kuaWv7/wosys8HKQYsejNA8LgtJAhLY5MO/wnyJMUCLnje4ue+9nyyXFr/IxRH
X-Gm-Gg: ASbGncupt1XMyoo4HQ/WILZ/+EVL/b8T2+1EANLh4qdF5aOlKIQUP6biuC583uH60yQ
	ZZhztsdrnxgQgUmfxcp+NvhE8YN4zPr3u9Fmr5X0fumQN2DLO2EiUlIH9zBffpCe+K3qLZqKE0x
	dy7vsJPCItr1MykwDrZd6MW7NDJVmhOwsclTXF9gZDDswQ4eth/Ed1GuBY7MK5n45feXuhOHhr7
	6RYniLitAspW1zog2pZV1YeeriUUB7RIaYQlTuK0DlV2tZEaRKkBq7c4wIH3dqGfzDNb6LvQ45f
	wGO8izLFAqvAJdqTYRIfhEI8/px6iLk4skH+Jq8g+u3TrTHQhxju+DkUu5I1IQEiGu2J7hBr9KU
	2kqnP4krm5EXb+5caMT9jKNImtBayYhZy4/gYFHVETrz69kQasH4iV0h64RXrHMYZGOQ5EDTF9b
	XcRdHyP+sI7vT+kYkLlvW7vg3pAAh0LV7lKyahsJqC8/myl5ua
X-Google-Smtp-Source: AGHT+IHw9Q3p3//u6Hf6OjK1KMKeUnk0xkZ26Tz6w7DIanoCrmSjZEgXvMBkRocpUTCBKcEBPU+EUA==
X-Received: by 2002:a05:6000:268a:b0:3ee:15bb:72c8 with SMTP id ffacd0b85a97d-3ee15bb7385mr673006f8f.36.1758214027639;
        Thu, 18 Sep 2025 09:47:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm4338147f8f.8.2025.09.18.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:47:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:47:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <da90eefdb9f8f6d3c9ced393025bd535f035aaac.1758213407.git.paul.chaignon@gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758213407.git.paul.chaignon@gmail.com>

This patch reorders the initialization of bpf_prog_test_run_skb to
simplify the subsequent patch. Program types are checked first, followed
by the ctx init, and finally the data init. With the subsequent patch,
program types and the ctx init provide information that is used in the
data init. Thus, we need the data init to happen last.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index a9c81fec3290..00b12d745479 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1001,19 +1001,6 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
-	if (IS_ERR(ctx)) {
-		ret = PTR_ERR(ctx);
-		ctx = NULL;
-		goto out;
-	}
-
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -1029,6 +1016,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
+	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	data = bpf_test_init(kattr, kattr->test.data_size_in,
+			     size, NET_SKB_PAD + NET_IP_ALIGN,
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
+		data = NULL;
+		goto out;
+	}
+
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		ret = -ENOMEM;
-- 
2.43.0


