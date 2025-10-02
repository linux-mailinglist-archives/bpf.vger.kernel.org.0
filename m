Return-Path: <bpf+bounces-70190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDBBB38BE
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B863BC32A
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83B306489;
	Thu,  2 Oct 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nco1FElY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C52F3C10
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399635; cv=none; b=ncKtiWSSCfMcGqrkH5TbeXigE8XAPZ/++7EYUWxyLe9a1fBh74DTIitRLAHfsO4cPsIqONviUlLw7Yr4XnVSjawX9oWANlP9/rji++UJnxBSAOiBHa6G8O5b31UOKinj7wizub27ObGfoKvGUnWlF7zB3kR3Xxbx0rTb/+OwTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399635; c=relaxed/simple;
	bh=/xbf576UUEj/+rXb4X/DjGve0ybc3uBKP/IkAUA/vV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvp9+ovc8EaEaFhQRYCdwaCNYFa2wi5lgsGkiIbiexnZh3YqFYxD5oR1VSEmgx/YnqlO+Tm93F1bKys2hgYKnPvBO4jF9TK1sbsa9XZwOLooX4yAncmFbvzYqNMdP21HELmC4HZy2CGGHCPtu1leNUvr3jnwWg5eC/DA/khT8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nco1FElY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso468234f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399632; x=1760004432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHBBtVQ3K6NFakUuP3fDWPbCGuNdrBdaQs1B/p2eyPA=;
        b=nco1FElY/9EMLegif9KMcHJI81dzwXU1sik8DmW9AbfYH9RMpfJgj3MyJip+S0ycxt
         cX008XuWOriHQpgSIq8XNCdFlCItaLMVrhTH/TNf/5JY9LDrfrIlUSGwXHUTMffrUGzL
         cfjYeeVUPTjDPiyvlWlFINx+5hgd7jWEIPbv2RFfzMe67JSYigcaRsPIpb/5YWDNjIUw
         MmwKFYbKFx5oFONOEirdzsF8tkxS5CTvI6X5ClLxuVTYiYh9rnBW2OOHMvSPeeN1tuDE
         U59rKo1K5AFb9TUyiUtPFtGooMNQdtuVU3VI7CO7GtG51HkBeWFid6O84DosDqpGVOEt
         IxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399632; x=1760004432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHBBtVQ3K6NFakUuP3fDWPbCGuNdrBdaQs1B/p2eyPA=;
        b=IhIezHlDdYanb1yaxez9AbfdbAHC4BJLDkPGGwVvHPYrVVZJ3fNtsq7f1X2LoV3z4H
         tJHyg3KpDRdqlvMoPxwSuj+879IjUUFJXNLFQ3neHARG/7pfYE5uJsPAugh/D0NKFboQ
         UNf1eedq6R8k5nJmUPfSbuKk4uD86+PLJF0Jhyr55lWi2HKHt+JTVUrGOc9nnk69X7OC
         7lLJHbp+tCUosPQJ7hhQUXm6PAcLWwbmrYb0eM/mtI1N1nAzMuwB+7TKW9Qj1RBD3HSR
         XwSvraQmtkCnhJRsaTXFLmQZYgJGMgs88DhlrUWu5UX04YfWH37PS6BpR4ZwuTfjprOY
         6wuQ==
X-Gm-Message-State: AOJu0Yydp9MoJ10AwMoRCPCVt2B2pM1OJScDVoYbEeYf7hK2m/nBdL+o
	NND2fuOlDBEWDby0FM0QviRCHmyY8g3MUauNm+gEjyjj3gLoLtYBuNMG/W/xWDSu
X-Gm-Gg: ASbGncvcabCykdmWlX1t2PmdrKEUWNhccXu0R0cjy2M+hBLarkH8WzkM+0fGGMK854q
	pHrbnbF9bZSSw0tXt9YZp4KGCM+7gTm31tFPfjLfCBpIBwC2IO/n8my3uTlnBXOM0AdyV6E1efh
	4hy7qnOexO06DbkZh1XR+mgf3V4OO31QJMy9FyS1zw40DCvypuM163ORc/1rRO5xQXDAw6fxbH3
	Q6R3RBDg5W5PiGpn9mzXNQsPcA+1jrnpnElu6vfjJx6CabrgtkZRgDmkgG5YM52UivFDYrSm+Xm
	M7yuPTIp9BgwXYTOvHOGlghcofczSRcwXgOusYk+sSYC187W+1KhGbVmiDzg8KpQP65WkjpaMKa
	Zi9y2k77CqZXnUIr2lBQzimeods/jbEPoMhpRqqtx9eHrK5LElRIa3KA059Y7X4/YPwdKDgXKmg
	iPMvQgpi76iquSpAYmwloeL1PJhskBNjSdGVkOPaTgeO4iRognBpoePw==
X-Google-Smtp-Source: AGHT+IF4wTj+8Lf3Qi+xoflaTo5BUZIOnEXVB3/VaWpUNvXrE0AP1DU7E4VMyOA5lW4jWFRAf3sJzA==
X-Received: by 2002:a5d:5889:0:b0:3ec:dd2f:eeb8 with SMTP id ffacd0b85a97d-4255782017fmr5517432f8f.62.1759399631576;
        Thu, 02 Oct 2025 03:07:11 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ac750sm2954917f8f.24.2025.10.02.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:07:10 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:07:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <c95e9b5db39c97358fc9b52d94cdcb80155eab52.1759397354.git.paul.chaignon@gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759397353.git.paul.chaignon@gmail.com>

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
index 4b52db9e6433..3425100b1e8c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1004,19 +1004,6 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (size < ETH_HLEN)
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
@@ -1032,6 +1019,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


