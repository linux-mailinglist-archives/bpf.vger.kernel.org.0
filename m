Return-Path: <bpf+bounces-70189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB75BB38AF
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2B19E04D6
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007F308F0A;
	Thu,  2 Oct 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC3qQuYW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E93081C1
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399510; cv=none; b=IiHd/HtJl6ClcffL2e4UZQlGzvs4cO1gGS7DwBxTcE/OwL/sP5Dgf5f6xEO+iys679o0kaftN+Gw6BUwpRXBGwhLuJ/K+OERrZH8gkiqrswLXRL2YepgytZgycnZtEYKFH2digMjyQiQyVfauLK99HrxUQMu0ywBu/+40ED0u2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399510; c=relaxed/simple;
	bh=W5gRZUzrScKJdmeG/bY286s5v2Vy0ukKbE8c8LUjLt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGbytM70afya+LzJpjC27Z6erlrtLBNk+03z/54z5EX6AMPq0O24WtEsmiTVjIG2Kg0oMsZEusbnVf4xtkRNX1oz2QqwAOiyHAE087pwb6qNHcqlkYmVOrFaJWo4ROZMoi3/Syob44FheZjhOb4yMbQEfJ96fdXH2b2TkPNnZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC3qQuYW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so398273f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399507; x=1760004307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3PyzdQjU6/7VLqlsUiPc40onpY++cS9OwKnKfcP40c=;
        b=LC3qQuYWUs05ZErHtDRt0TmWZRSWr2fycIuNI3rNr6CcCTfNZrLhUfTyv0lk8N+4KL
         sA9ihRo527tn7tIRp2nu4BjwT5cxjAVWiYGzdJyrUox7Tv2zIj9x8S8CPpg31BClnQLD
         Azbk9iR+bqMqnvC1kJhReb5gM0RjjJAeP+6YacwDMer9xEeSEbTrOn5MpEAuNbhnT3Ln
         mw4ZxDzyjueHG8f0vOHAMNbJQbmBW73PBdZz67kwLMF1slBP5g8s5O9yTBixnRcYXK9q
         vXvavnYELiWms74g1Rdg/Up8y6q5oPndkKGH2VmvD/b9aVcHC2nQ9fCC4RHBAK/urerY
         2wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399507; x=1760004307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3PyzdQjU6/7VLqlsUiPc40onpY++cS9OwKnKfcP40c=;
        b=irvbTdGlm0toHXTs66uCtcPjlEbjHEjqPnwNIr5qMi0Tw2IV6/45RZdTD3T+/OG5Lq
         eAum5WI2qyX81ATxO5FOv1w7srZWS8FfdoRCO66XrqKRdV1v+YS387eLlLDgwR+lQkJ3
         ZxqSYkiojibvszAHsFi6YGLF1D53m7Jv09t9rFYlWuYUtyDacI3TOKJDhBgEkYK75gzn
         lJWqYp82gBQuFO0B10I8Mb4BUhzhsB9yTpad0vAJeYzQ97ghLWlKUaPT0efkJNWxYRgZ
         yobPudwEUQ9Qhy0wNc4Slne21mTq8pSxVDrxNLrSU9O/gJmfOO7+kDOIHw0PRJ9pEVNq
         KZ4A==
X-Gm-Message-State: AOJu0YxDx3Q3n+uiVlXh6Vn40jnRMu0O1jM7HEtnlT/auvP2VOxFyWau
	2KVmsw+TEy8D3XkzF0ROuTjp/S65CUfIE6lrMO+4ZXGozc96fVDcAP67JgL08boU
X-Gm-Gg: ASbGncvYpn9oLdyUjKNzrQ2/9LTO2VbVbUbfrTk+A9SHQgrtvQ432o01XVy83UtF51V
	jQwRI6VFNj/tdIlA+zXx4s+CXnC6qpYJmvtKlxykmYqeomD/n+4VCUrxR6+0Q+tXUnRc6XkJZCO
	KRNmDqiGBaLLZKsd9FeweO2eHmf8lf1CKrzMddeQPS3lFj9RO6iLVBi3wJeqBGmjKqeZk89LnB2
	SnbbKOGnnnzX+0JPJuP+q8yk2qWhiz7LOKeKmPMRkT9B7wqiQZhDYGHub4yF3yUAQGH+eiSgXLk
	0OyefoZa3k+yYL6BreRfWI0oKMgesGYrqaNlmJKvXiy3sbsSxOwAmiuAZW5JEfQ0eeV0eTr97SE
	08QOtUTGUAbXMfvG7wus2xG2cq0LQguqFVYCafQpGZVObR8c/IBJVgMJG8WiVpyEAHmPFUTD/ue
	DJIH6VaT32yD2MBEOJdUcBbyMNsyfwTWJRvqwxYZKW6NzwoHLw5Zey3g==
X-Google-Smtp-Source: AGHT+IFdQyvZRMjaB0YEzO8qdDjKb0raU9vCuepVBAF4fy3btzLc8dVqcaw9X8ab80i6NlbHjH9M5Q==
X-Received: by 2002:a05:6000:288a:b0:3ea:bed8:7040 with SMTP id ffacd0b85a97d-425577f1b11mr5262528f8f.25.1759399507103;
        Thu, 02 Oct 2025 03:05:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9703sm2942975f8f.30.2025.10.02.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:05:06 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:05:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 1/5] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <1ef996b41290f542c13c5fb2fe0e271add4d8cdb.1759397353.git.paul.chaignon@gmail.com>
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

This bit of refactoring aims to simplify how we free memory in
bpf_prog_test_run_skb to avoid code duplication.

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..4b52db9e6433 100644
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
@@ -1033,24 +1034,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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


