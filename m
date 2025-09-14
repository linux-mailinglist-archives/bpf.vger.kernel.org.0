Return-Path: <bpf+bounces-68316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9BB56A09
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D9F3B892E
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0697E2C3268;
	Sun, 14 Sep 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnqVc7Uk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4735949
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862592; cv=none; b=PnAwo+7hn5jzc0RSK1VVYtWEH/FjieqN6VrCVzpjvTEoqXCdkHWaZg3RSh7YHjjrrE+XDGM2hRF6FIdY862tMiveNCIj5Xa3EIDsiu8f0RcdhwZMHq8xDbAEdxcC4w79nvUBH0FyRM5qbtyBqcFjZ5tjqiCGLZrh9jlo/vWrrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862592; c=relaxed/simple;
	bh=60KyxKGnCjXyEGpk6NUoYl13MNFsOGmPkbFaeacj/IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxU8awdObzsQzQw4qI8ZMxcpaLsZkRs4ubcAa+Bjgom5bzwWJfJ93AnkjnC4Te1vFdU+pK57+nKFlueZq5pO3LTIo9ZPF3HbBSb2uYhHWus9EFto+1ZJN5CfHYUUD85cl4w8HKBDh+KFHeu6PS50H4YlztaETDDOmTtLtB/tLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnqVc7Uk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so3339595e9.1
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862589; x=1758467389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHklcEshEm6ZKeS//M6BGsnbNwW2Sg8tVvuCjpX5nRE=;
        b=jnqVc7UkRa5eNT+s6kaCD3zGeeRJo8jNkKNOoiDG0mZkPX3dsI7z6zSQjuYr9hav3d
         S8Y4U9SjMdq3PVk/nFgu3/JwLqwNcs/7YsCOCFLDuKJRwXBgtD2qrA5EzdGukvePLY70
         dKa7Rk26PW7pi/SKPN9+0ZTsZdR6N4/Pbi4rCkaZ6sx59kS8C4vUrYROz/W4TuW0PZvU
         F6VVjp2FeE5/bGyuv9dxjrxCg7M4ZJEr+O5PThZmnRouYlGc/IGE+V7IeV5xX2Cis5r7
         gmK+XUDWaL/3XcO3Y3mcyTDDhySHEoaEa/oC5pM1aoCcP+Q2WV2Linie9zzzM+EeBkk2
         WMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862589; x=1758467389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHklcEshEm6ZKeS//M6BGsnbNwW2Sg8tVvuCjpX5nRE=;
        b=Hrqizfyd1jhjtqDN2uX3VBHWd8ZvC/WrQTJbqmGY02POvwiK+OSYZ0zI7A8SuTPsIy
         kwse8gyJBa0Xap/60dCwk8SK5aEV9pAoL5tPlCV7FhBXWck/ek3qSoHL7LbWnRwTCdFH
         r5lFn6mxyLyptW2rxX5UhpoHguv50iDuDlZnClOXRhHXwRqdPQpSVfjD/7uK4lJpvYrO
         /7qiGmOVuiMnWBoH/fsjlFV4uPgbHsb/PqmJ+gwLUE98SDhsXGdSmQYZxecpcLf6Mmoh
         /VX9Qem/ZRd5+H2W7V/rbxiZbaqj6fPQZ9Fx5RDXnLpYlng4g7RnPB/rCwFXOH3z7gO9
         EGJQ==
X-Gm-Message-State: AOJu0YwcJ83WyfDkUGLgBPK4HSnGtmvuJV+Xp2WeQhWZIBOyrjl8GmWo
	Fcm6PCG/MG8ZrzYXx6mdcpEX9I/vOw0W7DLLs4gdGslRpzUYyBoJdFCy/+EeQsXS
X-Gm-Gg: ASbGncsJZpuAUC4UJ8ojrtBuUIiJmpvb4KfWNdBiPOpAzw20xjbT5Fy2NLb86qFKSvT
	G5SaiSJfvitYZTV/LzfPAnR9sU0Uv+0jsmFn+LKkCo+/OCz3C8uExsOCAClTRWOGfOzM+orQhzt
	CHB1ma1c+6NhbrAM30n0X5dNTyke9Abl/+ExZsG5QCJUaB8itKf0Rr99XAjJdSblZjj/WWckMh5
	vXBBD6AbdRvEC0swP642alma37Kbkny16xlyacqnwAOn4f1jpDFaA4FJuEGerB+a1AZG9TpLB4U
	Pc44KlSUKqmN3dZZzQGx+nHOuZ0nVvBM0U6Bpd26lyLzdngZFhGYd6pAlOFbaPd4e3VtAH9ypIl
	E/awyALbWtjTOouZKhiho+bzjVNeyRVLhPXueHO+xsobZTBD3rc40c5gm7JV4qZKcluHmxAmUl/
	QAQBoZn7ch04ta6mvDsdn0DtWejhIFcg==
X-Google-Smtp-Source: AGHT+IGO816wUJDMAdj0wFgs4FgdCl3QRyGLrsam8NkmAVYat4dd5DZitGtB6Er/dRTwsOeZAGKiqw==
X-Received: by 2002:a05:600c:3ba3:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-45f2d7b7bb2mr88515e9.18.1757862589067;
        Sun, 14 Sep 2025 08:09:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00829f05581a33a178.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:829f:558:1a33:a178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm8500656f8f.0.2025.09.14.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:09:48 -0700 (PDT)
Date: Sun, 14 Sep 2025 17:09:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v2 1/4] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <aad7b97116293432fa9cbf42fb21043ab6f44bcb.1757862238.git.paul.chaignon@gmail.com>
References: <cover.1757862238.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757862238.git.paul.chaignon@gmail.com>

This bit of refactoring aims to simplify the next patch in this series,
in which freeing 'data' is a bit less straightforward.

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..a9c81fec3290 100644
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
 
@@ -1009,8 +1009,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
 	if (IS_ERR(ctx)) {
-		kfree(data);
-		return PTR_ERR(ctx);
+		ret = PTR_ERR(ctx);
+		ctx = NULL;
+		goto out;
 	}
 
 	switch (prog->type) {
@@ -1030,24 +1031,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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
@@ -1139,7 +1139,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


