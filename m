Return-Path: <bpf+bounces-11654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6877BCC49
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB72F281D16
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746D4404;
	Sun,  8 Oct 2023 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pDAjb8r1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFE9CA6F
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:17 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC37D8
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso2131228a12.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742535; x=1697347335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5mxF0OX9xOXmYEMR+WWj7I9pRqOisNzgsEMTbX9Fcw=;
        b=pDAjb8r1pyoOoIgkbxYqZiqols5A9mnuszTRbedtgUp3glqaEpXhshft/kpn1fYZf8
         63HnfxHvVoGFIxk75z/mnIa0QQ71xh6FvDZpx+FrAqj2lVlPZSXzfabwpUXJ3HNh8hsK
         VIJXWv3CRbQ31VBWx6LjmhYZ5eCvu5OADYUtRRP4ghrbuTwrADrBvQ+uy2u5kjIdcugg
         FV1bD7mueXYtjBMWKzN+kKdYeXRzbHOKDalr7cUVQb/jw/5zHhCbs8mJzrKtweu7qvVq
         0GV/6vQRsSdMk5qNsbAAv1R5shF+vflFG86pHYBmNnAQsEFECIVuUdNqO1WJwb5qW3cd
         CWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742535; x=1697347335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5mxF0OX9xOXmYEMR+WWj7I9pRqOisNzgsEMTbX9Fcw=;
        b=pVe/SKhoHJ6/Wn7zbKWdHDsVUwmGq34tjuguoptU0MqSgfM5KrDYFJGoLWmm7o7wYU
         DMGAFoHsYw9u60nlOeaArrOkseexC2k5+PwCZ9yHn1tsqL5SubhMdDa+ykwj5XfOiB/t
         mhtBejRfSPXkOVzkCUuvD6anDBUzOeFWPIrHUVPG1Atv4lTBxqryAqI4/ViHxDsiHetT
         lKW0gS8YZyV8K+bek8unWVAZqp20ukYHyLO/81X830dtnVCZyd+LYvav8amJ38Ztdh9o
         Pws0Xc9vu0yh2WkFSe/NQilsIn3drvFEzX3EMNQNuux9XDtwJWtoqp9hcdHVPhh8vYbM
         S7HA==
X-Gm-Message-State: AOJu0Yz4juWjjxiXq63DVLobeQmGtdK6jz+XoxAuZ3VugmMMfID74//t
	MzvvDxHyyIRmbOMvrpea7+9wtQ==
X-Google-Smtp-Source: AGHT+IG9O4pTvHffkcpbfSSY2BqjAJCrJuGtiCOgDSHXbFaxRlalyaGem1e7MjUKpdr/veWyOVwJJw==
X-Received: by 2002:a05:6a00:807:b0:68f:b7f6:f1df with SMTP id m7-20020a056a00080700b0068fb7f6f1dfmr12856183pfk.5.1696742535241;
        Sat, 07 Oct 2023 22:22:15 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id ff13-20020a056a002f4d00b00693390caf39sm3945943pfb.113.2023.10.07.22.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo Shuah Khan <"xuanzhuo@linux.alibaba.comshuah"@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
	gustavoars@kernel.org, herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
	decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com,
	elver@google.com, pabeni@redhat.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH 2/7] net/core: Ensure qdisc_skb_cb will not be overwritten
Date: Sun,  8 Oct 2023 14:20:46 +0900
Message-ID: <20231008052101.144422-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052101.144422-1-akihiko.odaki@daynix.com>
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Later qdisc_skb_cb will be used to deliver virtio-net hash information
for tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38..305fb465cc1e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3622,6 +3622,7 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 	if (netif_needs_gso(skb, features)) {
 		struct sk_buff *segs;
 
+		BUILD_BUG_ON(sizeof(struct qdisc_skb_cb) > SKB_GSO_CB_OFFSET);
 		segs = skb_gso_segment(skb, features);
 		if (IS_ERR(segs)) {
 			goto out_kfree_skb;
-- 
2.42.0


