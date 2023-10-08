Return-Path: <bpf+bounces-11653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296597BCC48
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2582281CD0
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F061FC1;
	Sun,  8 Oct 2023 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oS7RsZl2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B41FD5
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:10 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BBBD
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:08 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1dd54aca17cso2590368fac.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742526; x=1697347326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYCQ+fW716tmGuChYsDFVDZG3YnuxKzHlfuupc0GLGY=;
        b=oS7RsZl2BBnB13+koV64IOlKKa8vg2ZwAA/borqfKqPEZa/1e3+is7Ylvf4yRH48En
         iM74iFDL+D8j1YB2iuDwT+xMVEjhq9iCvCBkQDHUBJRYBSUzIYozVUFbecU1eeGizeuh
         42mLyVZFsb2cOdH1sZL8DOtxPsWZHEjLkGytWmOuBeV4J69kynpFTd36Qln9bm8HWp7j
         baPvIi9taQCh5Q3QH+VpAMRj+fGuByknwJ+yXcf3pavrBIp5mAzJvoKN3ppi6sVXkps+
         +xw5aIYmJQkfJI9U+7+JsLX7XaIx8l2xevaZ+LmPeUXYUmvNpsR1RI3R6i4hCXusxdA4
         QQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742526; x=1697347326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYCQ+fW716tmGuChYsDFVDZG3YnuxKzHlfuupc0GLGY=;
        b=qDYPPYhp4S52WTwnq/mBkHXUYmo5U1btvMeqjzi8/s9Rm7Stql7ow3fz3jZtcYzdDw
         vR/DUNa692WrkpTT5cXuPAtHAx9atNQl8EBT2UKnp2DYjJTPN+8+G4xcTDxRuKF++SPW
         4WeBNp6gLoib4dYEWP1DmO97GRu/nkmBcLhtxOpNl1uFSda0lvLOgdLZZSWO84/i0RSO
         vB4wYVrDKfrwdOKmbbAUOT9wozDnYF9vSBWelwFNi468UDyyaz9jL+BXg3tqDsIXkABj
         10SY4zi0abXAht84RjTQFg5FpvPdDQxuZB68pz8jFrVEaXiCz7dNFj+kvHG5zvNaw1yv
         uXTw==
X-Gm-Message-State: AOJu0YxRAR8CVBeUCJcrWjytZVvohIpdlLViqaTcoEQol3HEdNWMp4OC
	bWL0Q8gLE/h1DxqVELQFz5CyDQ==
X-Google-Smtp-Source: AGHT+IEBBXm6m/WtSPUhh5oF+VJBXDbr96mbF1KkK7r1eDIobYG0/oD0fn8R1wf3qYfKO3KIRt7bgg==
X-Received: by 2002:a05:6870:ab83:b0:1e2:665:49e4 with SMTP id gs3-20020a056870ab8300b001e2066549e4mr10360254oab.23.1696742526036;
        Sat, 07 Oct 2023 22:22:06 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id g22-20020a1709029f9600b001c61e628e9dsm6783558plq.77.2023.10.07.22.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:05 -0700 (PDT)
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
Subject: [RFC PATCH 1/7] net: skbuff: Add tun_vnet_hash flag
Date: Sun,  8 Oct 2023 14:20:45 +0900
Message-ID: <20231008052101.144422-2-akihiko.odaki@daynix.com>
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

tun_vnet_hash can use this flag to indicate it stored virtio-net hash
cache to cb.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..e638f157c13c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -837,6 +837,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@truesize: Buffer size
  *	@users: User count - see {datagram,tcp}.c
  *	@extensions: allocated extensions, valid if active_extensions is nonzero
+ *	@tun_vnet_hash: tun stored virtio-net hash cache to cb
  */
 
 struct sk_buff {
@@ -989,6 +990,7 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
+	__u8			tun_vnet_hash:1;
 
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
-- 
2.42.0


