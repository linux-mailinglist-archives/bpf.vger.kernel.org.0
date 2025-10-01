Return-Path: <bpf+bounces-70152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE0BB1D53
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F744C028E
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2131326C;
	Wed,  1 Oct 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2TbM+Zt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16ED312804
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354135; cv=none; b=F4DWKIqToMV0ADzK3ifH1kxfYicXZlqtM6piRbhe66CCtekKUKS4pa9TA5Ud6an11Pl7v6DgsnPnrI8ZMIFH1FFKdInziHMNt81BCLWiIypOMMqdO4RlQ8RGCuXeUp4OWvqg2B9msDv9oeWieWz2453YJx7U6ER56YTYH7pbguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354135; c=relaxed/simple;
	bh=FNzTWVcsRS6cIpLt1jFxcRzKe8CiPXBNU22xRzMKhUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOX1lm0YSITl5IV8wy3Rh3wqMLC5E6jYvZycXj0nXJIqcuhLXscVVXcOFuaXQkJtNXIA9uH6Qj8w2pJoCigPXQ5eIvK1TCn3MmycXJUkkIsNCaVmBy6MwlX0b1rD25Y9A3MiHfiey6sslxT1JK2CpMfGLH19bGXLWM9O0H2jhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2TbM+Zt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421b93ee372so127076f8f.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354131; x=1759958931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9thqMx9Tqh1i5ca2Rr2jPfuv4jAGHXYsUt+iaz3EUzI=;
        b=h2TbM+ZtI23bEs8Laz5NQYPyoN3pi+T88bWak+En2pdf2puWxI0wAaAXcX4ibAL0Mv
         TB9/c79dtnzTmHIB5ucDHzdG75sQrxCESrXuVr2Y3QXSBv68VidTS/XpbSnYvpWRuGn1
         Kvp8ljX4rNSLdcxgSaPrMDyKcvcl/XrbcZ60o3gUPAMqYIbORz/ea5b8ScZMnq7hLSrF
         DkOc6aud5KASiJD+mjLrdhpwa+DpMlK6vJGdGBcQL7Jvr+wOd3HgPsQCL78iEGVfvOjK
         KzzmQNEXdKX4wT/MiHoN/gQwvolbIFxJCxBn26hl33/XYK+201pTt8M+CO5We0uXApUB
         ThYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354131; x=1759958931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thqMx9Tqh1i5ca2Rr2jPfuv4jAGHXYsUt+iaz3EUzI=;
        b=npL9UmK5YRxd0ygeDUWBbqDh4CH9R5s63nmvZ3gJJwkVDglf0Rnl9DGTNY6r4r91m+
         T0OmXmYRXN8Vs8Mk5P+TXCfwr20LJ+M0Aa6RrF4fF96U5kC458ykuFmbudgLZS377isi
         tVVdp4OHlPmjVUa6VV0Zdxw641al95MPzSG1IXVjBoBFIG042Nw6bXoQDdh1JBurCcXI
         0Thj/6CZI3iw5EoCWF7cXZeOPyJ8ICflgGSGfLJ9nOz/29AIFrvQIv7oharojpdziUEZ
         YedIss5YMBXfObScjl+oMm0iQSc1RTFIadSZi1DByf8IicIlWKqKKCtk+D+uaJQJyKWi
         GvUw==
X-Gm-Message-State: AOJu0Yyldf8E2lX5ss6Dql5JWXbIiVLWQsuzkPyuA7NFI2wSR57ps2wS
	49/2nWEXay2VH6cjlwynugQMdQJ60zfy8kqsOYzR+vOkcz24nhU6RUWHNOQapr3N
X-Gm-Gg: ASbGncvh2YJ6kIYFAWcd5WPVJGxw7mf5taeQJWBQH3fRTHb0iE2432cT42y3OadbR54
	6wu4b41X33MPVr+DpPuJDZeikTSzLMdbXGTDJ1jPcnA+gdyQyssZ4bWCr4RKhYrjViTgzn7blyH
	vYr6OJYH+Kkyz+6HbWNcf7bsPC7n1dV8blQEemMDNYeO8Qgbd4fQipkcqAhw1tH8/ycda4ktrAy
	5dKQXPzH+47rrc6vcvi1Qjdb1OYPn9he/yKfV5ta2ezOXd8OQ0emYNVHfgbey57Re87426WBofw
	92GxaHCKcgj4FEHfNGssPfC2p3a1NYeyZh+mCFq4Dvyk07/RHSzZGA5qkuPo+zbFOVlh3v6HfXr
	97bD5wPIpHSoWQaqwskmFqvoyMXaL6JxaBGhX/Dtem3WhqqQr+T1ebo/XPELzh6rIZRHsJRR4MV
	37XW1/1w/okIjuZmdqiyJ12scrPmZxpwI0MGvjSvXX3N6r
X-Google-Smtp-Source: AGHT+IEvkMykuiOqEitXGtsgUfnVfUqtzH30vMEsMc2inu9DtsNdn+fOrGEwxEREy3JaK3seieVstg==
X-Received: by 2002:a5d:5d12:0:b0:3ee:10b1:17bb with SMTP id ffacd0b85a97d-42557821b39mr3706913f8f.61.1759354130702;
        Wed, 01 Oct 2025 14:28:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0846sm681429f8f.45.2025.10.01.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:28:50 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:28:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 1/5] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <574f4715e18d6cc2445c696708e9f2d473efff09.1759341538.git.paul.chaignon@gmail.com>
References: <cover.1759341538.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>

This bit of refactoring aims to simplify how we free memory in
bpf_prog_test_run_skb to avoid code duplication.

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..3a1bfe05b539 100644
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
@@ -1033,18 +1034,15 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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
 
@@ -1142,7 +1140,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


