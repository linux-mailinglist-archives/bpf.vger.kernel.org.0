Return-Path: <bpf+bounces-70505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09BBC189F
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82EC19A39D1
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C02E1757;
	Tue,  7 Oct 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbUrw4GZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C02E090C
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844283; cv=none; b=ANvb9OaqffqLsV/G8xzNPARz2914FynF/KZGMHYJ719rCPQxMmnTnwGzjsNTknfx+R1evBHmJauYkPVIa8TOLFK9dPDGHPOD8XBHO2BrHaupB7OElLB84uf2KF97/CGBYcoSOoJJwxkyEkjmjtmyz2W1hC/DpiHWJgIAQUn/Myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844283; c=relaxed/simple;
	bh=twzbDbSVuVLCL/1mLMV3Wl1fFF8tKjKbJU8UKnqo1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFwftheENZRH2WqncHGhvXT3pMHSoZPzBRs2Dxq0dvBObPGB4Pz/6Ub/gvUZxaO2+Bu9+ztOJ9MRDq9KJB576k/ETq1AUq4sixj4//MDdBDvXgrTdrP6SpXJSXGIzzhnn5JxI7pXar/sYTIPJY0mJ9F0LjYV/SHrJhysJ8uxVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbUrw4GZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4257aafab98so2012928f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844280; x=1760449080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=GbUrw4GZCT6tdTyfoT5JYAzNOBg4RrF/2n6hOEscbVc5GActYV77Td+TK8708jLPEl
         wKg/ZMj8cT2P0G2OEGVEexBuPp/DxkfiO0sBJ+zGaBLQygEEOFWdA41MZH2VKukicjAL
         CmyfN4Z9f+zTxeTF7vWTUv0J/T4SQPgvFYKseVhdz9pwCwiJQciv7fbFP45iQRljyVJG
         ZNv5vgRKm0E1Fzr/xKwfrVk4SOVgd+YvCq28pqI0HARzryBj6pC9lEBLrJF2oFdCI5FJ
         CLh/efuOWlk53VLSFihx8ri9/8YjA6I8XLp/IibAJfuBL9+qQLYqbrd3VGn2/PtRPyv1
         Ux/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844280; x=1760449080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=wonqN7ZTfKOFqvvbgxRN7V5knd0e41lGd1bi++XPniwBhFTJs67t9ZMcNrmXwWMWl+
         zhseWP079sKu+sh4TvyLd1nWMbU7kP8MMmeyBL22raPuYoxAP41CmJBN4e1o8LUb6w20
         uPn0TMvNRAd2ym+hy2OYG8A8rOWzr4gMYQNFOR7JKHZJu3u5UchhDRumXhuZyW60RuZm
         k0FIDq5reYGQUKY75sy7dItPS44VZOx967MXvC/lHk6DcAtvSppxQLAmt4czv22QhhQl
         KQu11X2Y1XNlxDwOa4kbMhdYbZkS88ZIDWRjiAVTC5mMRFBOj/ZmYrn/Yv6VVfS00h2l
         GplQ==
X-Gm-Message-State: AOJu0YxZXMtJrHGUH+d1/H8D2WfMQStQhpkdWBg8nqH+i+rP9cELcHP0
	xWjXy8TiBevYcxPqA4lk3cfCeYllb6eZ1Bo7l+mLZWsyqyTcpqbGNlcrdSaFKLcv
X-Gm-Gg: ASbGnctni7hDimrbkghR8lL3xFrknOqPXzyQqjn8SaLfKPid8HyiIXxEvIHRz6jz2g2
	xEpjqvIRH81eov4GzjgkProrYfW7vjX002Kzq9o3n9+t9l8+YAl1miXelpH6YelEv9gMw7X4bI+
	wGaRXS1FY4ErdDTvm8bApEMsiRLNRv3EbdSzP8RxIK2KJxoPap4cSYz4ZVbqTRx7kY4fWkTYg0s
	6Mk+XVMowpDC0hOJOD8bLXOY4FC0oSWjMiXElqShHT7T2LURO+uKoijd6z6tWjuz/Fra4jt9U2Y
	Oh6vhAWR0gl9teXjqbynoPNJXPfu4LDF4sEAcLTtYQ3NQk4hkmsQGdE/zaP4TBSl2zhoLej5nb1
	qVJ/sWB8JVLDMa5rqsd2GXtz6ud7L+T74nppR1gtGrqW97VXUVUlJwp2sOuovGTY5eA9kst/gaq
	v5yaV6Eo3P9KiL4a5YAjDB9Zzn6cAXRT/Om7V4cyUeuSgTTQ==
X-Google-Smtp-Source: AGHT+IFB0w5mUpbONs4FgBA1fbQwxVaMsDMBus/naLa6A0rLSNNPX9rVA7JS+AwLULCurKZiODZB0g==
X-Received: by 2002:a05:6000:2082:b0:3ee:1521:95fc with SMTP id ffacd0b85a97d-425671511cbmr11813082f8f.14.1759844280336;
        Tue, 07 Oct 2025 06:38:00 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0846sm25974322f8f.45.2025.10.07.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:59 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:37:58 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <6b4bda41cac19ef55424341364e2bab28e11868c.1759843268.git.paul.chaignon@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759843268.git.paul.chaignon@gmail.com>

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
index a39b26739a1e..b9b49d0c7014 100644
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


