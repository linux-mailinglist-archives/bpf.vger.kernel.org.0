Return-Path: <bpf+bounces-67436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C7B43B17
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C497E3B49FC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7E2C2361;
	Thu,  4 Sep 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzoIMdTg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FEF2C0280
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987760; cv=none; b=OrCPCMjr4JXr0n689Lmk7+jrPqJxomJtpDHYP4tCLK8pbDGXeaTb0yd7n1XbSxNefPkjYwIXqXCRuv2Lazn7pE38Qn7yw+OhwWev+KfIjJtRQG6yYK/LHfrkIdTaJ0/IIkighS0tjJbAyuuD2ZHn7UhTK/OnNGHeK9oCEUSa6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987760; c=relaxed/simple;
	bh=NOgdTstWTpi44neiit/fJqZaWs5X+9OFdGtvLoCddQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyDutEhoU29kOF6deSTMlErk/iqUQeOSTjHXjt4ysmIpzqFKh/6dpSdUptvROSJduELrnpO20a5y6nyZACKwshElvaDt94W+1zI6hJR0IxLTwUS96AcWq2dbzc4sSXo4jdr531IzGrSl6q9HA52joAZxe8kdue4IFguiu2oiREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzoIMdTg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dce6eed889so688669f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756987757; x=1757592557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXs0gtFfTqj9974O+PD4xtO4N6NlemD3ykaO8TNbiNM=;
        b=EzoIMdTgbdD6CTkVnG0X1sr6evNqHHUHPQ+5dtus9eIxClIs4YFJXC6igf5qZduj15
         lQZpjzGUDSvE8WtaOwTG/+Pw4Vun4nyh3dXQFJN2zevtjnbL2PTGTYXS3bhvAcsOTym/
         tiaK7dF/utBoYYG1C9zDq+CIPum7QphLaCCqx2//NzdYzmj1Z052vXyUNO3KeEmXjZWo
         YaoVPs5JdJcHpQXkpc8exeHM8SZV66CR6IYI0Xt9HV8LB31L/WylksyZedParuJqRVn7
         joMh3SpuvBfUN8NiW81b5o8TUdy3ga5f6ZYi/2HboWFogl6DoegJp+Gy+wVZo4UwdyHa
         Nb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987757; x=1757592557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXs0gtFfTqj9974O+PD4xtO4N6NlemD3ykaO8TNbiNM=;
        b=ImX/d4OCBCibKBJTCuG3E4ne8t2TBu3d4zASHkFp/RqiPiHUovmfaEYya+xvQfN9Y4
         bErnmZVO077q1v+1kiaZIl8AL94VJHZl28hlaQ1QN3K2AeSKV1yxWgWcD+DI8HyTajtX
         ljLAQXs97H9h4XFvYiDofEyuQ2MqL3ols8qoKSm+spZcd1ujpx+uVABl/wnftSJarcvU
         WMvPZ8xZoEaxuivqBQ+4+dPyOlduizzPOVc+UTGSoa/7LQj/AQWEZ47xfOXT41QERgc6
         UPzle3TaT5dB9LTG/fHrejTT7s7S9SQSaASkvXYsnAAk/rRFf4AdCq9HZxTso0MyJPm3
         KK6w==
X-Gm-Message-State: AOJu0YxR9Zw1h1uYEW1Vnz+i9Vs5ydNA1r7JaGkcHdGgGBA8R2FbbCa+
	D4MhljePld8R2GEJPr2TPXDyHL4G6EOr8nhSHzWH4C001OYu8/RvS3/deF6CkGua4cY=
X-Gm-Gg: ASbGncuQvyGAmdh2o/jvJfBV1J+dFTMADA4UXQDxBPBQLRKY9vt440k3kZls9kpKpgW
	xA12qozVq/8TXqXNNtfo7C0UuVx5AcRYB3W5eqqOP8o+2Exjt96H53p1k0MmQStybizc1qlaeUc
	v8W9YwY4zJNtEuek8NONOchbJMoWIwgGgq/GHY2e766ZM28HBOXQUoXg28Wy28NU4sA7TqmPzU2
	J5sZZ6Cs9I8N+btXJsVTD3Il3L682qLMSrs9B2Z6O4PkJAybWMUsbsRfPzG8XURw0NaYZuh8/7Q
	lz9kLLgEIGOIxbpQR5/h9iCYjYu2bslFH3DgL1Xx9OQvyRquAnYWmfW8zFotEwo47dBaP7eFHyL
	LgllppdqbeWbaWRsiuXhVvE9pYxx71QDyaXb9I6rOxqIDR+mZdaZ0PzIkyiUYXqkM1ZZ7IQd20H
	ddhde88POOX+q1/cKvZ2Q9uLPxggP1px8=
X-Google-Smtp-Source: AGHT+IGt5RTqTgf90CeO84xmdA/hK8TUQIiPN+stepvnUnIYH1MWgJyrdaT9FIGvjQUZbHIKDvgx4w==
X-Received: by 2002:a05:6000:420d:b0:3cf:3fe7:21f6 with SMTP id ffacd0b85a97d-3d1e01d6741mr16395119f8f.44.1756987757329;
        Thu, 04 Sep 2025 05:09:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0084ffa21ee1457b9b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:84ff:a21e:e145:7b9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2ebb9sm17548882f8f.20.2025.09.04.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:09:16 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:09:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: Refactor cleanup of bpf_prog_test_run_skb
Message-ID: <6fda7c7fd57e6134ff70d12b622c9c7c3cf0b226.1756983952.git.paul.chaignon@gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756983951.git.paul.chaignon@gmail.com>

This bit of refactoring aims to simplify the next patch in this series,
in which freeing 'data' is a bit less straightforward.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..4e595b7ad94f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1009,8 +1009,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
 	if (IS_ERR(ctx)) {
-		kfree(data);
-		return PTR_ERR(ctx);
+		ret = PTR_ERR(ctx);
+		goto out;
 	}
 
 	switch (prog->type) {
@@ -1030,24 +1030,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
-		kfree(data);
-		kfree(ctx);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	sock_init_data(NULL, sk);
 
 	skb = slab_build_skb(data);
 	if (!skb) {
-		kfree(data);
-		kfree(ctx);
-		sk_free(sk);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	skb->sk = sk;
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
 
+	data = NULL; /* data released via kfree_skb */
+
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
 		if (!dev) {
@@ -1139,7 +1138,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	sk_free(sk);
+	kfree(data);
+	if (sk)
+		sk_free(sk);
 	kfree(ctx);
 	return ret;
 }
-- 
2.43.0


