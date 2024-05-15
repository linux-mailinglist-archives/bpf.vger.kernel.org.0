Return-Path: <bpf+bounces-29768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536F8C68F1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387F01C20FF7
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BD155A4D;
	Wed, 15 May 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKjQK4qu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929E5C8EF;
	Wed, 15 May 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715784204; cv=none; b=BKkUyenRrVUjNECKVeG0O0B/mR+bdoyDB1ebuUTbWEKgyYuvgU0pAa9Fea0+nIdB+2g9ml9UqQUkNDfUhAI9ulfsgTwxgvaiXLhGKI3seML1NWncVSxxGiqFLIDUN9dtbQ2GOrf1WjWomI4wEgh4Ag2hyOWFCXiQFg9ywfgYMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715784204; c=relaxed/simple;
	bh=sSweIfZc/Nl0B/cXGGt+iL39xKMZmHaxI4advJUinLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=baWw4TOvC65w15bmh9TSmk2qFNXN85u/M6aPg3Y8tCO/i4+KKKT/49f0TMBK+fAQ1xK+CAZkaUJuD71JuigE2f5JXFL9WdOaMgYTFV3nB4vUm2wfGF4prMhMNNS0H7MQ6WyEU+070B2gJkh+L4KC/DDK/F20NcPIVy+nhn3fPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKjQK4qu; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6f4472561f1so6295465b3a.0;
        Wed, 15 May 2024 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715784202; x=1716389002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4G+Y5nvwbauhCzcIUnrl6gTVirBiw0CfcC+eP4E+JY=;
        b=gKjQK4quloa4QeQl3hdt9PWCoa5FkalcFfZwMspQRVANFLlfkjUJQTyVHDFWT1K2Js
         IKKqxKNw7/AOBphu6cAXbGYWM8tvCt1DUHUwcMF2+Q9qqva6k0qUcJuOF/55JYHGx7Vi
         yauBwCbgGmQb4N+GUk7EPmL5EQWWS/4McgOLIC/Ngll01MIZne15MhgBYP7Y9nIli2Oo
         vuNYYnCXSlOSRWL7w86KYEy94jm+FduTA4H7L3F/xgkwOEu2rYeCX8Qqi25nVW+6wH8K
         IHdfiiwOxIyNMCCqRltKwWNjrL9O9poPSUNjPVCgf4Qti/GTTQmLUHEyc9d6XRYWGAgl
         ixfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715784202; x=1716389002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4G+Y5nvwbauhCzcIUnrl6gTVirBiw0CfcC+eP4E+JY=;
        b=Mfl0ug6w48TPUITdaRnYiGUyzfS+2nmx4fgiLGXtvgx8goRIO3/6mHrdCsyNmHnt2w
         Y8BTaa2s9MQ3TApmCPw9AoXN/6fdBp0byelOiV+L1rAbI7ibsiOz8EQ3g+u4Rt5dt22z
         WItZRNFceVCSagIO4Om0GtPrKF+F/Yo/1WAnr8dIPJwGu2ASu9LY/NFUIOYzY6TqZpAU
         hc1lMJZbx4m0ucGJwQLBy357nVvkaOwbtzIAJwN5GmDOqEfD3Fgl4aYWC17/YGkuP1hm
         dYAMnF1Av8rJkWRZZftwVtGccMKzcECv4m47jKkSnDqjPDYX/hM79Rpn5dSXLn7slhM3
         L6AA==
X-Forwarded-Encrypted: i=1; AJvYcCWaH5J0ujQMwf4GnkUds1Q+3UTOXLnRBpleJa4O0JG/tI/jix84Z/5GXVT4KsfLRWlauhNcU2Ac+1mhxQuAmlbwlq401p5uAEzgSamzm6a9DbZ+Lt1XVKoSAQT62QzcwYbo
X-Gm-Message-State: AOJu0Yxq5/xb5hDDagksAE49m2YL2M+yptyqDuW4WlZ6+GL61s38pLMY
	bcdwVoHxtnTiArNj5B/ADxLix9y2C9mwBrLFHWn4tSdBuqKDesLZV/SPGix8omADOw==
X-Google-Smtp-Source: AGHT+IHNGYdvH5ayqVAJ5BS+H2gZS9Q3Q8lnah7Nad5QXmoDKOWPL1IsDABDlp6jEARUqVUK8bying==
X-Received: by 2002:a05:6a20:3d88:b0:1af:cefe:9741 with SMTP id adf61e73a8af0-1afde0b6d8dmr24977788637.17.1715784201877;
        Wed, 15 May 2024 07:43:21 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:9881:7698:b1b3:f885])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d77sm11185155b3a.106.2024.05.15.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:43:21 -0700 (PDT)
From: dracoding <dracodingfly@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH] net: Fix the gso BUG_ON that treat the skb which head_frag is true as non head_frag
Date: Wed, 15 May 2024 22:43:13 +0800
Message-Id: <20240515144313.61680-1-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Li <dracodingfly@gmail.com>

The crashed kernel version is 5.16.20, and I have not test this patch
because I dont find a way to reproduce it, and the mailine may be
has the same problem.

When using bpf based NAT, hits a kernel BUG_ON at function skb_segment(),
BUG_ON(skb_headlen(list_skb) > len). The bpf calls the bpf_skb_adjust_room
to decrease the gso_size, and then call bpf_redirect send packet out.

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
#10 [ffffa3f2cce08800] tcp_gso_segment at ffffffffb98d0320
#11 [ffffa3f2cce08860] tcp4_gso_segment at ffffffffb98d07a3
#12 [ffffa3f2cce08880] inet_gso_segment at ffffffffb98e6de0
#13 [ffffa3f2cce088e0] skb_mac_gso_segment at ffffffffb97f3741
#14 [ffffa3f2cce08918] skb_udp_tunnel_segment at ffffffffb98daa59
#15 [ffffa3f2cce08980] udp4_ufo_fragment at ffffffffb98db471
#16 [ffffa3f2cce089b0] inet_gso_segment at ffffffffb98e6de0
#17 [ffffa3f2cce08a10] skb_mac_gso_segment at ffffffffb97f3741
#18 [ffffa3f2cce08a48] __skb_gso_segment at ffffffffb97f388e
#19 [ffffa3f2cce08a78] validate_xmit_skb at ffffffffb97f3d6e
#20 [ffffa3f2cce08ab8] __dev_queue_xmit at ffffffffb97f4614
#21 [ffffa3f2cce08b50] dev_queue_xmit at ffffffffb97f5030
#22 [ffffa3f2cce08b60] __bpf_redirect at ffffffffb98199a8
#23 [ffffa3f2cce08b88] skb_do_redirect at ffffffffb98205cd
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

3962 struct sk_buff *skb_segment(struct sk_buff *head_skb,
3963                             netdev_features_t features)
3964 {
3965         struct sk_buff *segs = NULL;
3966         struct sk_buff *tail = NULL;
...
4181                 while (pos < offset + len) {
4182                         if (i >= nfrags) {
4183                                 i = 0;
4184                                 nfrags = skb_shinfo(list_skb)->nr_frags;
4185                                 frag = skb_shinfo(list_skb)->frags;
4186                                 frag_skb = list_skb;

After segment the head_skb's last frag, the (pos == offset+len), so break the
while at line 4181, run into this BUG_ON(), not segment the head_frag frag_list
skb.

Since commit 13acc94eff122(net: permit skb_segment on head_frag frag_list skb),
it is allowed to segment the head_frag frag_list skb.

In commit 3dcbdb134f32 (net: gso: Fix skb_segment splat when splitting gso_size
mangled skb having linear-headed frag_list), it is cleared the NETIF_F_SG if it
has non head_frag skb. It is not cleared the NETIF_F_SG only with one head_frag
frag_list skb.

Signed-off-by: Fred Li <dracodingfly@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 001152c..d805a47 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4070,7 +4070,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
-		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
+		if (hsize <= 0 && i >= nfrags && !list_skb->head_frag && skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
-- 
1.8.3.1


