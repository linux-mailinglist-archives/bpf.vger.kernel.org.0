Return-Path: <bpf+bounces-12233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEF7C9975
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 16:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA0B20D42
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89B7499;
	Sun, 15 Oct 2023 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="jOjNclAy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19593746A
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 14:17:38 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6ABFF
	for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5cd27b1acso31191025ad.2
        for <bpf@vger.kernel.org>; Sun, 15 Oct 2023 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697379454; x=1697984254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3e16X3BnACnel0/w/bQT7bK9RdqePAG/1Ajmk33nB0=;
        b=jOjNclAylNWhZ4hB+LFckWl9nZjeAdYIUYBxlpMMjRuXSf70wdqUDw1m3PBBelChkk
         nLQqE4n8aa2ZoFfZ0BjparIqreNrV64Ff8ga//0p9P24HdmueiH3bYlOZh5ZRUTxmr2Q
         Bsj5n/KP4Bxq9SQMLWBtg4QAkrprtUZBMOMUtzk1wBV8jdslEszB6tigt/mgtHUr2vpJ
         JmIC6Jy+LcrAjl7OPP7dUxx0xGOGSWCJLnSZbdocit6jH4QD9KyHFU7VaAenZptOZxaF
         //tXuDZUaogqUgVHPqMaYTdCX1EvdVrD0nkZ8h+qUdchz4L8I16yD4/NSCJ8//WBPnw2
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697379454; x=1697984254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3e16X3BnACnel0/w/bQT7bK9RdqePAG/1Ajmk33nB0=;
        b=P5ihqePSqZ9cqdOgt4doo069saFRy4+ZySG5pr2K3jjns6tq8c8c8Ih8fW62mtal6U
         rBxZ8Y6kktzwJtgkn8/+Rhv4tT0ldSQ+My9JSElg56lQzRSMLIycG3dC50K4AoCdJrzz
         PVyfJZnsX07ohUGzr75jRay00bcaypznp7r2d0xpR6X6GqBKi93WwyTDOYOjT4ASDQ/1
         x7TWfhfMqxrvab4dN9Q38ETupJs2K6Y2Gd40x14b5khkEH78q/id3PO1LamRGnXZI5/C
         8VAlNeLwupHZRyVvsWFUakElTBYmlk1WIMWNLxgIJE5noMF328dIB28QOQHF3J1Ygc/Q
         xYyQ==
X-Gm-Message-State: AOJu0YzXOedmKpKAOlcy1gauHznlaXTigqlJf0/GieqKcUNgLdf6czvq
	vGnpAM49tXUv6blHa6OwYjsTKA==
X-Google-Smtp-Source: AGHT+IGa+4527nTRMoq3BT4pWp6MGz5aJZtlZUNhOW5hIrk1Y1oqpKECZxuWNJqZ5/MeAEwk4c/hSg==
X-Received: by 2002:a17:90b:4ccb:b0:27d:51c4:1679 with SMTP id nd11-20020a17090b4ccb00b0027d51c41679mr4375745pjb.27.1697379454522;
        Sun, 15 Oct 2023 07:17:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id ij6-20020a170902ab4600b001c0c79b386esm7058350plb.95.2023.10.15.07.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 07:17:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 3/7] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
Date: Sun, 15 Oct 2023 23:16:31 +0900
Message-ID: <20231015141644.260646-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015141644.260646-1-akihiko.odaki@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This new extension will be used by tun to carry the hash values and
types to report with virtio-net headers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/core/skbuff.c      |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..1f2e5d350810 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -333,6 +333,13 @@ struct tc_skb_ext {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_TUN)
+struct tun_vnet_hash {
+	u32 value;
+	u16 report;
+};
+#endif
+
 struct sk_buff_head {
 	/* These two members must be first to match sk_buff. */
 	struct_group_tagged(sk_buff_list, list,
@@ -4631,6 +4638,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_TUN)
+	SKB_EXT_TUN_VNET_HASH,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4eaf7ed0d1f4..774c2b26bf25 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4793,6 +4793,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_TUN)
+	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct tun_vnet_hash),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
-- 
2.42.0


