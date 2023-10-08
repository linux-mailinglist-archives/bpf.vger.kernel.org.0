Return-Path: <bpf+bounces-11655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEF7BCC4B
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 07:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD74281CDA
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 05:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0601FB4;
	Sun,  8 Oct 2023 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="V4mTdqPk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06C1FC8
	for <bpf@vger.kernel.org>; Sun,  8 Oct 2023 05:22:28 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EDCE
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 22:22:24 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1e5602c12e5so2065622fac.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742544; x=1697347344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPY8LcetYpbUlVlPFegVlbCc6qfJazG7CQ0SWRfz3jQ=;
        b=V4mTdqPkPMPDZBYohbxCoqITKGbl1WAPtQHeJ05bPnuQXpUPydkT6bIx19SKcgCRDu
         cs/570qHa3wo8pwZw9HAGKRPm+Kc++7ODlWpRu8t+yvI3qB+gvu2H/MAQ6FbtYdNWa9z
         hBrcLE+OLvEYVHJSbpj433I2AKf1gWcLDffjEUr+1DDQJlKVgzGC2sAjnlrL2TEPuX6F
         GqDgRB8z2OjGLx4frZYvIfTc+DPMs4/8zhsHRoG3OV5JPrcLSTVX7vP9pdkGvokVqSsq
         Joc6EISZeZa4Hn/mRa+h9MHSp8c2WcFP80sOLhAIhIbfAPuJkQqX40C6La9bv62DJkfx
         EURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742544; x=1697347344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPY8LcetYpbUlVlPFegVlbCc6qfJazG7CQ0SWRfz3jQ=;
        b=lh7Gt91RjGRytOPimaOEoQ7btLfzgcUEd6UFQ/imQxjZTFkw2nJy4zWORyvSk3Gm6V
         Esv21mN2zn4ZtFqr7QiptuVSg4OxONROKSE4/toVQG8swZEYInyjIKtS8ayLvjCAsvRf
         NRw1cfec3gcccytCWsSFt/BEOBTsRCTOrUUUGYrtNtLMomsk4XgY3mv3Cy9a6vTM5p+i
         cwadBk+A5KqUcGx+LWUwFRyg9+CcqZrJvX0qHFZA9G2WhbgJsr6jegu3ApIwPwA0VfKk
         hJy8bUmgquCuwlFyn5alXIHg0mqo1XAInaoUlY63dre+GwDgJFt5dF12Ye9ozURV7PHs
         HTbQ==
X-Gm-Message-State: AOJu0YzN3DWW0aj5iiOTg1EBv1GGC3r0E0E6081t62I8qLfv2SxAX0jE
	IHnlLcHYxgZ8xyGUNm0JcTaybg==
X-Google-Smtp-Source: AGHT+IHTSzRT9n0IpDWOr/8WZ3/TNnoy4ql0yHPxeP449Qn02WJ+7/ihPVg6XYJwBN2eH2IMyO52BQ==
X-Received: by 2002:a05:6870:6390:b0:1d6:5892:d279 with SMTP id t16-20020a056870639000b001d65892d279mr14600345oap.3.1696742544024;
        Sat, 07 Oct 2023 22:22:24 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with UTF8SMTPSA id z15-20020a170903018f00b001c7276398f1sm6787489plg.164.2023.10.07.22.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 22:22:23 -0700 (PDT)
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
Subject: [RFC PATCH 3/7] net: sched: Add members to qdisc_skb_cb
Date: Sun,  8 Oct 2023 14:20:47 +0900
Message-ID: <20231008052101.144422-4-akihiko.odaki@daynix.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The new members will be used to deliver virtio-net hash information by
tun. The other members are also reordered so that the overall size will
not change.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/sch_generic.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f232512505f8..9dfdc63859c7 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -430,13 +430,15 @@ struct tcf_proto {
 };
 
 struct qdisc_skb_cb {
-	struct {
-		unsigned int		pkt_len;
-		u16			slave_dev_queue_mapping;
-		u16			tc_classid;
-	};
 #define QDISC_CB_PRIV_LEN 20
 	unsigned char		data[QDISC_CB_PRIV_LEN];
+	unsigned int		pkt_len;
+	u16			slave_dev_queue_mapping;
+	union {
+		u16		tc_classid;
+		u16		tun_vnet_hash_report;
+	};
+	u32			tun_vnet_hash_value;
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
-- 
2.42.0


