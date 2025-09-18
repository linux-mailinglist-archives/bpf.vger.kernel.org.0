Return-Path: <bpf+bounces-68824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED2FB8617A
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F86189BA7B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D523D2B1;
	Thu, 18 Sep 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLJvHY4H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A87157487
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213998; cv=none; b=s2qeSdbXgOO3YB1ciE3tzZ8ZuEz+ek6cN1S5LmGk/VSlHsiXT1CHzaLjMdxSr2SI+ZRs4w2MMMz0DBYbEjQA1BuwUa6/Fi2Q/7koOC4bEqFn5OYxturCiUqz45/yaHMZU1FiQe5At1xF3LCS8LB/g7bjbp4Hr0wHDcUIxtN6Jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213998; c=relaxed/simple;
	bh=60KyxKGnCjXyEGpk6NUoYl13MNFsOGmPkbFaeacj/IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myDnO5O2P3hO9ZSPsOS1LhsELhsa9eq1Z+ZEWozJsDnlxbdlhsWQEwpzyUFAJ9THDxIscRuYH38HuGq+RBdngWjCk56C6eZ07wROLh9wOKyQNk+YPRXcizbnZpIBaUtxczOpDdD5TmUvHQe3UxenH+SOFkB1aOWsknrj9CVLq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLJvHY4H; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so604510f8f.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758213995; x=1758818795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHklcEshEm6ZKeS//M6BGsnbNwW2Sg8tVvuCjpX5nRE=;
        b=aLJvHY4HGf6Vr0dlNdrWGF71iJqbkodco/zBpLxeTK6ohoh3minV9enlwDQEiPJqpy
         1peIZR4KRHVfFwJIExvl5vsLp78RGJsmdRIHlpu3NeKYTKViSmyDMDn0KQdboFrLJgZM
         jvSDvvdohT/F2vHZ/a7B88X9G78g/X99due5i/+yk/OXXP4AXBixHS5Y41b7Wu3LcD4J
         Rxn7hi2zYFTVAYFpfoxhC9tZFpQzEsbSlTBTNJQaETioYS6vBhY5j0s1ys971x6RykrE
         kTrTVbGlGC41KJd8jF8pS4+3b++mGic86BQU9ooOZSo8qQacDTmJKHpvyG1hbNcRXNte
         GneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213995; x=1758818795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHklcEshEm6ZKeS//M6BGsnbNwW2Sg8tVvuCjpX5nRE=;
        b=ui49Cdu7jp2Yb5l0Pq4fH6OTLbn5BfXGylBJuZSjDXtCLbK9SBtwcX44MM9VW7Z6OL
         5htkPGQighRyseFn3pWtTKWHuluc6UY51ZV6h/ZZqENDLfkkMhCBFlYg7TZKd6R8tRpd
         Y5I6U+KCvmHsF6AwF5PtEJZeBKpMHNzrMo0DRNNDaEXIgStG4Sh8Ylss5GpBJoCTjpHh
         YmWWdFpnEFfQqY5/eyU6FHUVkLVM6rBI86dV9iSPFuQeiqmfmuT+e+E4SLsOfzvGW6Tb
         FGNl9lwGZe1xj8T4PRDHe01bc8VHFfZes7RNkefGgtet0vkkQaeNKGvP9XaMiwexhaIx
         yiyQ==
X-Gm-Message-State: AOJu0YyhmjNBZgDNgAd6x6H2NltHDxRaSE2wpXaOKY1W0Sf1K87r9uwX
	skP1hbm+vNFWHJzcXIrtCzsMe2xj1kSPEb70SAwFRiisjODjF1asuPRzdWHXxqhh
X-Gm-Gg: ASbGnctyw9ihL/1Q2hDkD4rf2JCQFfe8ddHv5JVsSC3PET7yPtApJbLRENktXu3KzsE
	X6gt5vFZArub6jUA/NvXWms2ciJYVbqUqm987+53KsMmiwAtFZqyw+xOmDLPHmHYjuimLexpnjZ
	1AFMrSPYJN1w9DVRNIaFhn3N+6WaSZkm0NFoiMdE80Xr0cHuaTgBPMpV+gXInnuD1+PRb9Zitzx
	b+QhE09f9h3arDIpSwmg+anqpg9bpHYQbQiPDUaEPC8QAyr53kfRccCHk90nWHaqXCRKyMbbiMw
	I6Lueq/1njH1qejcNZTrEDNR2z+8AFodjH7HpRsTf85s5t+9gvPOvzlQdYJGWzQrVvEhVZ3hpv7
	RMwopaKLhWsqzOj+6haekWw5PpbDRDG2g1h0p/yRtmTFijL12wb82vBS376J9IwSyNujTMqJ0aZ
	+r9Rn/hSi6NwTRBgxHffyO1yeMe5d6s5EllkrZHA==
X-Google-Smtp-Source: AGHT+IH+rtau1reUjiVMH4JoicHpY4Yd5V2lpYaN5D8qnAPcYcr97q7Dbpy3/aXGSIBUbbDB+5Whyw==
X-Received: by 2002:a05:6000:18a5:b0:3ea:c893:95a8 with SMTP id ffacd0b85a97d-3ee7bad112fmr325f8f.7.1758213995114;
        Thu, 18 Sep 2025 09:46:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm4402183f8f.63.2025.09.18.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:46:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:46:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 1/5] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <fb83d566c9260fa30054e07596e7072f364e3442.1758213407.git.paul.chaignon@gmail.com>
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


