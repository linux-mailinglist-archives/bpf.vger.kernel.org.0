Return-Path: <bpf+bounces-70656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8440BC9688
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C1614EB68E
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9772E9759;
	Thu,  9 Oct 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmnA1pBL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD916EB42
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018537; cv=none; b=js9PfTPRPlLS/+zU+S1r/PVPCJF0jo/uA/ApB6kDNsdstYaQDiab6GYlD5iWpdZFpoofAj3ajuSSQmGtFYwK+bFbijyUl4E0V8ckUuf3KAyKwDio3+vjdWW9h+DEWekkokefBaNaeAP/i8H1qFSjPxvtTUOMetNKhPA/2z0zvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018537; c=relaxed/simple;
	bh=twzbDbSVuVLCL/1mLMV3Wl1fFF8tKjKbJU8UKnqo1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt90fwYzdPKHO3xOmoEI6yyz78Pt+yopOmJ23ppqmpwGcKBQvkaHGp6i+j3HdHJYesO5ybUsDcSD2x4Q5KjDKlpxcYDbABnE8oroke77UfaCWbaQq+IQjwkkCJU8+wyF0PzD1YNNIExwdMFMYYqcJf+mW1ZqBrXXYxlYM+JVKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmnA1pBL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so8307935e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018534; x=1760623334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=AmnA1pBLmVldsdOtYaO7BxO+SkPXLoH5PtwX76Y8w9cpvx1/BZQ98v6bD4aHP+iSY+
         W4vu0HR0ux9++O9HJ3vSCqYevewJUel1UVjv/y4+S0AykbXBEb236hT0frbAhrs5Cs8M
         TLdxCIc42/9IYh4nkjaiSuDRS6C89+hp9Nzbo/n1lDq+Xas8U8bguMWjNCchVZmpjhM0
         frB5cSUAlly6LwrVjrqoRNjJrDRH2YC15clZH7BUE+B0ZHmfot8kEKYJRCgJNv9gErh3
         ninVx1vnXBCGoyBBcVzQWJYjBB7MEEk0nrloXtjFS9LK5DRZ96z0zrhn60xwWgR9bLNF
         1Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018534; x=1760623334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=oE/962OS/zaoPizF14pIxUPynt6MxZgQPWvHTeuAtBLq4xU/mfsyo+P3HWuSCEGR7J
         dJtLrjznkOvKa53VaED+Loh+xrMzJcgeUgAzPcaD6WhgaxKlihJ5o4qiQlzD+dbuMH46
         g1aFiqP+Zf7Dy25qDliI1XOZWJh/1unjZ3uXHc7xk6Ks5SHuZlSg+4EatteQDgugoIOP
         6CGNBbqFXK94RiY4XYSze+Wb7cHSbeAWRqPy1yOCnaEc1L6LuL5r8gSIfHs0c9ctNGIO
         fKNNZoIBHNVUvkb06KoLVO0FA+6MSBUVTFSgkXIYbwSPruUouBdLZp/T6F4RDjDAg+/E
         lZgg==
X-Gm-Message-State: AOJu0Yy5/OCEONaGJQd0kox0bYRtbUcWiK5gAhG7oZQEoCJuqEuFdACl
	8ghXHa4BDkNe2hk4PM6SOPbRgwufWJgXBEuKwFcs9ey1u4wiQzushCC0vY0NKw==
X-Gm-Gg: ASbGncvUDdxhRSjct5JUpuzQ2uKn4n/ZV2uHqY5OuvJ798si6pu0FAVc95WgP0JWlz1
	osv6SzaXbo5i5xE/LztEsYrdFiJiVX9YdEaYMCV6KJnmMzGuWxTqsRinr4w4AZvrNBWi8nkP2F7
	cRjXsACap9HsBK6ChmkzI/tR+LwL4i4pK/QTgG7rlwlKTSf0KJJCqpVUZoiEFNSGyQGmGBHa6a3
	0aIUFfYqxoalMbyMEGVXKMhI9W8tVZVpo7V543ZSIuusT6YIUEpmMvi/x+gbYbUFukcNCWOdtaY
	vkD+64jPCDumI/bDq3GTNeCkgmrxP4LCKbMEDcNXmRnE1Y6F2b6YOXBfWJGlKczR9gKQ3pOhLQ3
	p7ER8c6ViTtSRGq+JVuLlc7ASu0HL59ZEzbgibdbddNtR61ZDrMil8oOEKMPw9Y5dcID9iOuiry
	iSK9FhzFHzpJnVqX/Mp9zEQW7UigPOsYBEXGtlBgCAIvuB8w==
X-Google-Smtp-Source: AGHT+IHQoxf4JlhZkNlvQlXBN2Ff/W64Epyp2MliA4d9+k2NQZYYIV4dOnDUvWF5t9V/wYsh09ceLA==
X-Received: by 2002:a05:600c:64c4:b0:45d:d68c:2a36 with SMTP id 5b1f17b1804b1-46fa9b079camr52394545e9.27.1760018533805;
        Thu, 09 Oct 2025 07:02:13 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf183b6dsm49614035e9.17.2025.10.09.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:02:13 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:02:10 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <063475176f15828a882c07846017394baf72f682.1760015985.git.paul.chaignon@gmail.com>
References: <cover.1760015985.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760015985.git.paul.chaignon@gmail.com>

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


