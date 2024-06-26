Return-Path: <bpf+bounces-33132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B54C917945
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099951F22665
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA615ADB2;
	Wed, 26 Jun 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH01qj8H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC12159598;
	Wed, 26 Jun 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384973; cv=none; b=EasSt4WD0VC53TzOU8WcTUAD1EG0QKZuXpNFhhKzefVOvR7ku8KxQhEUIXwPiNodWXztE/bvxzYPe6BRQP37DGcsV4Td1UlSCoCvn1CIU7xBsQ7tb9n6+i66FiTSC/7KuufcLcmmE58rdGqlQsvHMD8nEKkXR9+lP/rhiDaIXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384973; c=relaxed/simple;
	bh=TWUz/mm01bmp9LsDQBoEGU+NsSvmn88bz1v7DEaLm0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRHn4nwvOddYjlpFoTbS6080ckE6CQkuUrb7cVpiOQ4B5SqnZ3o+16CDBpBaV5noO26Pj90ri9MQ918IWIz1WHYchfNgptqzyLQro0PT6rNqxxsAZc293SENJw+CjxwDspQcyk2C5BlkvAhbilFQ9Se/0Yjz9Zs+pZPmElcFfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH01qj8H; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1f9c2847618so53431365ad.1;
        Tue, 25 Jun 2024 23:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384972; x=1719989772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtRT9bLHa8F/PNK04ktv2VypgsfPmD9Ti3tydIqRpTQ=;
        b=TH01qj8HGNrg7lkX6VmNcRUvmAEAMtG3aUjbqom0x0PanJnhDi24HPI9DIjQ5vrd+i
         uDmJniqpjNUDAdVwLHxBlCwj/0qv7OpSkbIKM/UGcBIdK7BcfW7sDUIauDm6ET9HMQPb
         mwFobOrIgj5nLJacGjmQKmBx7niKNXRyjNFKtOJAD4wUy/rjom+N1Xt20aEs0i2Cridw
         099FzXLTsKjuLeF5v3Qc3iiPenBEaRoIneS5wuOs8lZbhphwhZ70BpHgSB08W/wKopH6
         zcolF/z+Po77RoevJpTlAnGYmFsb0zsod7uO+9p++ioZxnUDf0kvuq8ppDGQvLSaGPk6
         c+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384972; x=1719989772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtRT9bLHa8F/PNK04ktv2VypgsfPmD9Ti3tydIqRpTQ=;
        b=JgMi5C8I5kIa/7BPJGd8VSyBMDj8dDwEaYethRIOZVV7KLo+REBxqLYKxhinzi/7k8
         iz5DMvdyA9atgxPFhqZ5KVc5gqKD/0L3qpUlcgxSPHRwvllqYWorSv7EHpzBmgKdWX9n
         EY0FN6XU6KWHa3FpYptnjcSQgDWo48Vcgy5/BxJMIC1tx81SHf97awAOZzppQPfEjboT
         NN3tZ0YNOljwz39Z5ghilgVTmLjrlKhxU4JhJwTC9VMH8RaL5bXhTAxg35c2NwfyR3sd
         J3xD2dBOzm7Favsh4tbtUJdiUJTaTQdqR+5Lj7NySJGzbeVIMksZuE3wbxbahuoth7dU
         OF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU4Zd33HLrjOftme9zVC0D+B3udhCc8nosehgyHB7J9QeW9eNmGsaZxqIauXVL62/+5ADqJ/GxCrs47UE61wf82fUNw8+DFvRA618OQhlr0RKT/9QaW//qwzbpqHZ+A3ay
X-Gm-Message-State: AOJu0YyCDRZuWGM53W2RqwoAci1Y59/nnaIg0qzMkbGqe31+x6fpDhdb
	p3Vgri2Kj0cVsJxVNK6Hataw5L15o5Ic9L5uMteybORnIGxcmvXy
X-Google-Smtp-Source: AGHT+IFBcF3fcSUKvgGC95H0dzLBcYy8eYiCFBgsJM9ldbqEmf3QX04ZUXPrEa3Ebj4ef9lgieKWRA==
X-Received: by 2002:a17:902:c406:b0:1fa:487:d930 with SMTP id d9443c01a7336-1fa15943643mr120029835ad.56.1719384971478;
        Tue, 25 Jun 2024 23:56:11 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:9d04:e74d:2a89:713])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5f87sm92776495ad.166.2024.06.25.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:56:11 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	sashal@kernel.org,
	linux@weissschuh.net,
	hawk@kernel.org,
	nbd@nbd.name,
	mkhalfella@purestorage.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH v2 1/2] net: Fix skb_segment when splitting gso_size mangled skb having linear-headed frag_list whose head_frag=true
Date: Wed, 26 Jun 2024 14:55:54 +0800
Message-Id: <20240626065555.35460-2-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240626065555.35460-1-dracodingfly@gmail.com>
References: <20240626065555.35460-1-dracodingfly@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using calico bpf based NAT, hits a kernel BUG_ON at function
skb_segment(), line 4560. Performing NAT translation when accessing
a Service IP across subnets, the calico will encap vxlan and calls the
bpf_skb_adjust_room to decrease the gso_size, and then call bpf_redirect
send packets out.

4438 struct sk_buff *skb_segment(struct sk_buff *head_skb,
4439                             netdev_features_t features)
4440 {
4441     struct sk_buff *segs = NULL;
4442     struct sk_buff *tail = NULL;
...
4558         if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
4559             (skb_headlen(list_skb) == len || sg)) {
4560                 BUG_ON(skb_headlen(list_skb) > len);
4561
4562                 nskb = skb_clone(list_skb, GFP_ATOMIC);
4563                 if (unlikely(!nskb))
4564                     goto err;

call stack:
...
   [exception RIP: skb_segment+3016]
    RIP: ffffffffb97df2a8  RSP: ffffa3f2cce08728  RFLAGS: 00010293
    RAX: 000000000000007d  RBX: 00000000fffff7b3  RCX: 0000000000000011
    RDX: 0000000000000000  RSI: ffff895ea32c76c0  RDI: 00000000000008c1
    RBP: ffffa3f2cce087f8   R8: 000000000000088f   R9: 0000000000000011
    R10: 000000000000090c  R11: ffff895e47e68000  R12: ffff895eb2022f00
    R13: 000000000000004b  R14: ffff895ecdaf2000  R15: ffff895eb2023f00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffffa3f2cce08720] skb_segment at ffffffffb97ded63
...

The skb has the following properties:
    doffset = 66
    list_skb = skb_shinfo(skb)->frag_list
    list_skb->head_frag = true
    skb->len = 2441 && skb->data_len = 2250
    skb_shinfo(skb)->nr_frags = 17
    skb_shinfo(skb)->gso_size = 75
    skb_shinfo(skb)->frags[0...16].bv_len = 125
    list_skb->len = 125
    list_skb->data_len = 0

When slicing the frag_list skb, there three cases:
1. Only *non* head_frag
    sg will be false, only when skb_headlen(list_skb)==len is satisfied,
    it will enter the branch at line 4560, and there will be no crash.
2. Mixed head_frag
    sg will be false, Only when skb_headlen(list_skb)==len is satisfied,
    it will enter the branch at line 4560, and there will be no crash.
3. Only frag_list with head_frag=true
    sg is true, three cases below:
    (1) skb_headlen(list_skb)==len is satisfied, it will enter the branch
       at line 4560, and there will be no crash.
    (2) skb_headlen(list_skb)<len is satisfied, it will enter the branch
       at line 4560, and there will be no crash.
    (3) skb_headlen(list_skb)>len is satisfied, it will be crash.

Applying this patch, three cases will be:
1. Only *non* head_frag
    sg will be false. No difference with before.
2. Mixed head_frag
    sg will be false. No difference with before.
3. Only frag_list with head_frag=true
    sg is true, there also three cases:
    (1) skb_headlen(list_skb)==len is satisfied, no difference with before.
    (2) skb_headlen(list_skb)<len is satisfied, will be revert to copying
        in this case.
    (3) skb_headlen(list_skb)>len is satisfied, will be revert to copying
        in this case.

Since commit 13acc94eff122("net: permit skb_segment on head_frag frag_list
skb"), it is allowed to segment the head_frag frag_list skb.

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f0a9ef1aeaa2..b1dab1b071fc 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4556,7 +4556,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		hsize = skb_headlen(head_skb) - offset;
 
 		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
-		    (skb_headlen(list_skb) == len || sg)) {
+		    (skb_headlen(list_skb) == len)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
 			nskb = skb_clone(list_skb, GFP_ATOMIC);
-- 
2.33.0


