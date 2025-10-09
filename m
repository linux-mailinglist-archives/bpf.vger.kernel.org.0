Return-Path: <bpf+bounces-70655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF981BC9685
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11294F51D9
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB02E92D1;
	Thu,  9 Oct 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj++3TyV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F1230BCB
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018521; cv=none; b=hMI9t5082gsD0Y5VTdaD3n6FUqP3z97KQjr8cfFyq0/6q27Orf8ArUzVUvE2RnYu7Cn6c2YVArCC3Yj/z9GJms2KZlQlH5YoeBHera4W8EW5thTVwvciwLy3e641P5SV3MbA35k2f52PegYMjeQU7eQmjDQLMvIwQqDJYRl2zGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018521; c=relaxed/simple;
	bh=JT//uUo3QD7Z8XClOZp52xHiiry7eH1sR+F2EwggIXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7BVEbB0bV9AAw6/OUghShcPOxb70ub5DOa7OsesLhtFGNQDn0lim9NgeH+kRzVqwWdlz8D7RhQK1k6PCBcBjBCsxasbPQJt+P/Qd+5x5FR5L0JYHmEsFXAJAERLy0gnlxKOKF7lJ6/uzhUbCmJjt6gODpbSAvNpMJcPkjMeykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj++3TyV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso8301495e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018518; x=1760623318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9t7fsApCE40DcnimQb1eR1S9jsNRTF6IWEsg41a3xE=;
        b=Tj++3TyVd6DT0Ul1kxq0Pqx+RM6i9T7CJ8qShhZiVKW21jGm7rmp+/VrtrXlky5InD
         iPe8ai9bjYyE8lbRubFtC1ny4Yye8dkaJe2ZA9dTVS+Ow3fNFYXrTHkrsDJT57/HhSVP
         wZOl7kU0hcXWdNrxU8LOIm7xUW69KvlRl5dq5U7tDnZ1PQgyl3HRL8r5B0FtSwKPNxPq
         Q02xpjwkegf8liubzW6FvCkTAbPYrHqtGqhbgrJQklGhEJebjkiUoaNOgZQkDi1lHim7
         5cXKu+EPbrvtaw2vtcHjNzVt0AwR/K1oYGox1PSOgHxXc49M+55WgsIegQuzp35bXluo
         DA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018518; x=1760623318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9t7fsApCE40DcnimQb1eR1S9jsNRTF6IWEsg41a3xE=;
        b=ejw+vD2K4RtHctjbTO+kKDJrXfRAwCq5COLX1FMJy3RMy3OXvV/g3T7X1/1PzImt2F
         PmgrP2mCoIQ9v5heRJRgt3VM0RgjgnOZ22JCRfjFpEsEJavKcYZHgSEZ2BBDs39ZN0VG
         GIEW9hipXdBmsUjUg0DsQ3hChpuDAURM7iGMg4FS2/Yd24uUqgclJO/Q1tcBPA6j/9ow
         s7NKaS1DnYHwI1lNGPOqKFF12Is1vg+t5gxQBYKJEdnJHpjx9pasA33MIgiQyluGVayr
         YZ/RK41aE6p9qKaJpmmeKV3qIE164+ujJ7/Ik0oA2UGhGtObhK8C0XBQdNU4bGs44vJJ
         GhrQ==
X-Gm-Message-State: AOJu0YxOTZReLJK+RZxZMeSfSjsm7wrqjWbQafcixhtDRFsmEQTalUms
	Pqk+nhKNU9NJLOqlattCsSd8tGits4cJGBBMnZk+1A30yuAB5FVlmqylGy5iLA==
X-Gm-Gg: ASbGncuweDuOXjM2iRUXcEt5jrEgjs7NrOUIPxLiLvSwP3/UjB5lB9HK4fiWKxhhnL2
	IMFZYxHQ+Ztbt2eGM8jp/gXI5PYBzHPOqkZ2RKzXJJdBnd/N1QiFmsOV+S3TCir6THQ+MvwvCDT
	XcDMkJoOxj3BYGrBmwqE0vj2xp8vv4wpTlwaRoSMi6YHxBA1w2AipKyaY4XtMau/JKnSYq+pf3n
	R32MwNgkIIQfgcpkTbgEMoaibrgxZzm/smUQpwZ+ejfw6MXW3tdTGlc19M8lsVeSGpGGLK4Qt52
	o9Ww+yBndvUyKKVYDFwUyaSNiBsPGM96Mc5CceoSJRdeFufeFuq3/mQXiAjyJbLcEaizBqsfEpj
	KONhtDPDDbpeOjvjPbNtoc4L6rBRvD8nsbBGLqYI9qqXhO2EjtFoLPTmZ0epBL1AiMq/Yz3jRNr
	Jpt1Xm4GchVcqbsyYTfTYf36G3NemuN/qYWYgSrIBf4ap3KA==
X-Google-Smtp-Source: AGHT+IFOUXvgeHiJBazpQ2NB4E+DZpOtfXKIYYhQsTqxMqND4NxVYSCXeFVhim8nWqx/dD2BYkkOHw==
X-Received: by 2002:a05:600c:4f48:b0:46e:3e50:e0e6 with SMTP id 5b1f17b1804b1-46fa9ed2136mr65257195e9.17.1760018517852;
        Thu, 09 Oct 2025 07:01:57 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36cc32sm39362525e9.0.2025.10.09.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:01:56 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:01:54 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 1/5] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <8971e01ae87b84f5af6b8b40defd3c310faf1c0f.1760015985.git.paul.chaignon@gmail.com>
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

This bit of refactoring aims to simplify how we free memory in
bpf_prog_test_run_skb to avoid code duplication.

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..a39b26739a1e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -990,10 +990,10 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
+	struct sk_buff *skb = NULL;
+	struct sock *sk = NULL;
 	u32 retval, duration;
 	int hh_len = ETH_HLEN;
-	struct sk_buff *skb;
-	struct sock *sk;
 	void *data;
 	int ret;
 
@@ -1012,8 +1012,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
 	if (IS_ERR(ctx)) {
-		kfree(data);
-		return PTR_ERR(ctx);
+		ret = PTR_ERR(ctx);
+		ctx = NULL;
+		goto out;
 	}
 
 	switch (prog->type) {
@@ -1033,21 +1034,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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
 
+	data = NULL; /* data released via kfree_skb */
+
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
 
@@ -1142,7 +1142,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


