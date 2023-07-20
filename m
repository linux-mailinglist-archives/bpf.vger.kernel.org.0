Return-Path: <bpf+bounces-5495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA8375B383
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB316281E42
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E719BA7;
	Thu, 20 Jul 2023 15:52:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED319BA0;
	Thu, 20 Jul 2023 15:52:47 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C464AE0;
	Thu, 20 Jul 2023 08:52:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad356fe4so6173715ad.2;
        Thu, 20 Jul 2023 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689868366; x=1690473166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHtQADxWGfF7hnz/vUvRDC9nByJ/dzs4+97gI1+O1CE=;
        b=qC+kqrKxie0lO91d6dS5jmb/uGM+ilFRMKuFaSLCT2kGDePbELpZbwVdixt5CDd8lE
         ufJW78/Uw29M4IXiPpkpQ0i/6Fc0N8hkrM2z5rgt6gK5R8mxlWkXWwhifB/6tQZJpt91
         XOcaEdM9XlZioA7XQIWVaE7BPu5Ii6xDwKxS+fOcaccujm5Jir6u0RFyQZBN4V+CdkqJ
         UbMgOw9uq32DV7Uc+Nvw02kwAi1BImFiHTKmp7d8+I8ckcFYToljWtY3q8AjjHOkvfhI
         IaBap3BusXFEEQp+g40cI0uZCl9BsWqEHrV4T/QwWb4faBZHILkYtC4M66dV07cQFgG0
         4VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868366; x=1690473166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHtQADxWGfF7hnz/vUvRDC9nByJ/dzs4+97gI1+O1CE=;
        b=asx9dxaI7H0hlrZLatb62Iu3YbVTCFicntYlHEflI/eIwCiGpH6MlkkxyQg4Tzr3fh
         vJR3R5f6YqK2R4JAJDlrKEE9891UqI8oaTt/HoRtssrXfeapa0IThKC+v1Al4cSvY5HJ
         Ie6WyPnEV875/TshGlasFFfQNxjc9tBetfoJyxh6WpqA5vg401d+YFtLwihFHVQSqZqZ
         1/Phvm7MyYwAllDhT+b2oEAdhGdXwc5X6QYi61lrVNtaHS/KOFQLTlz9PP1bmiujB8i5
         qYGzu4AeMec+zNYwliTiu4MZIPni491QDN6fKv/+dX3pypgotpewAYar13deijbJllFv
         +Pxg==
X-Gm-Message-State: ABy/qLZpqLqmeFk+dcfINvFqydw2/AnFxnuhBIJ38vyNSGY5a1oEiMpx
	GCh6H7O4V43iHh6OICuOqSc=
X-Google-Smtp-Source: APBJJlG+UHWa9yh1c/2zBUX++pVtToOTuBmeSFwq6sQrWe8wSFvmDvP3dqhapvsUGcP0bY6KegWxXg==
X-Received: by 2002:a17:903:60e:b0:1b5:5192:fa15 with SMTP id kg14-20020a170903060e00b001b55192fa15mr6814604plb.20.1689868366265;
        Thu, 20 Jul 2023 08:52:46 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001b8a00d4f7asm1569177plf.9.2023.07.20.08.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:52:45 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	hffilwlqm@gmail.com,
	tangyeechou@gmail.com,
	kernel-patches-bot@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RESEND PATCH bpf-next v3 1/2] bpf, xdp: Add tracepoint to xdp attaching failure
Date: Thu, 20 Jul 2023 23:52:27 +0800
Message-ID: <20230720155228.5708-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720155228.5708-1-hffilwlqm@gmail.com>
References: <20230720155228.5708-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When error happens in dev_xdp_attach(), it should have a way to tell
users the error message like the netlink approach.

To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
an appropriate way to notify users the error message.

Hence, bpf libraries are able to retrieve the error message by this
tracepoint, and then report the error message to users.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/trace/events/xdp.h | 17 +++++++++++++++++
 net/core/dev.c             |  5 ++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index c40fc97f94171..cd89f1d5ce7b8 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -404,6 +404,23 @@ TRACE_EVENT(mem_return_failed,
 	)
 );
 
+TRACE_EVENT(bpf_xdp_link_attach_failed,
+
+	TP_PROTO(const char *msg),
+
+	TP_ARGS(msg),
+
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+
+	TP_printk("errmsg=%s", __get_str(msg))
+);
+
 #endif /* _TRACE_XDP_H */
 
 #include <trace/define_trace.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 8e7d0cb540cdb..49bed890f807e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -133,6 +133,7 @@
 #include <trace/events/net.h>
 #include <trace/events/skb.h>
 #include <trace/events/qdisc.h>
+#include <trace/events/xdp.h>
 #include <linux/inetdevice.h>
 #include <linux/cpu_rmap.h>
 #include <linux/static_key.h>
@@ -9472,6 +9473,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct bpf_link_primer link_primer;
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
+	struct netlink_ext_ack extack;
 	int err, fd;
 
 	rtnl_lock();
@@ -9497,12 +9499,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto unlock;
 	}
 
-	err = dev_xdp_attach_link(dev, NULL, link);
+	err = dev_xdp_attach_link(dev, &extack, link);
 	rtnl_unlock();
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
+		trace_bpf_xdp_link_attach_failed(extack._msg);
 		goto out_put_dev;
 	}
 
-- 
2.41.0


