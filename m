Return-Path: <bpf+bounces-6863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF24C76EBD7
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89046281FF4
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B67F24169;
	Thu,  3 Aug 2023 14:06:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A0200D0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:06:29 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347346AD
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:06:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbd2761f1bso8762235ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071580; x=1691676380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAdtU7SLip58WY/jMpbQZS/1BOrBTm47cvrvRETW+jo=;
        b=gje/ZNVdV37PsuBXcn9JcvDF1Ybdczh0zKLeYvcGuYmGxjT6hPC415oZTPIOtzx83g
         7FFCFIT6Kmor5VCwN/i3qktqe92oFscFmNOAH082Ja7YR86GHFserclV4lc3CJNE1JVd
         +JiXjBg0V2wOrubU8ZMJeKXuoUv0Ozj0un1MiQjMdSXoHWHZZSf8vRs5OnkLjIX36jjU
         ig5yH157Hd/7+McdeYRCdJOIPawm3lbgYqB1DJYMWZGMAML63qPftJeILVLdeNK3uyOL
         pQHZQMLoxkAmw95IlOXouBPXN7IMMwa9psr71neaanIiaQcBn8UqW9AyIOJ3Td1T4F+e
         6mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071580; x=1691676380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAdtU7SLip58WY/jMpbQZS/1BOrBTm47cvrvRETW+jo=;
        b=Co1PdT5EquF9AVyon8RhhWTdUg8+6sKqAfXKeB2+SvnUYXn6Q9QTM8PLza5K8ji1kz
         iCTIthesczfl9y99ot3Z3Erkotdm6om/EsYQ0R04Ju7NEKFYdSSNs/VGGLOuOp+ybRvU
         4oBn7arruF58heWo4luwjdydZTA8Xrdt5+UiUhUD1xIWBX3IO2E3USWigOJuRh/5AuFW
         407N6fUHbvMfBkbqKyaPIkxFDUjOkXmiTB9SY/NlUs71ZfhK9dC3dlgGQ/KFSKzSOtZ5
         jZwvqvGFEHDG8gIqA/Ms1nUNKz2fzYdLQvsEUG0Es7Uz7a4o2eifvnMF8P6V7glCSOKW
         EB6g==
X-Gm-Message-State: ABy/qLaA9rLkMjdO9LAPuMBkFYW28qbqYhQgXW1EoQVpdObmZ4153inq
	8btoV/dwcpHYKr9kP4gwsTuhaQ==
X-Google-Smtp-Source: APBJJlEB4J2N6PwO/XzHjVb9E/ZDHejJFXzJmb2/i3ejuedYImdsgBFrlBMRUUbpVS6DJIX4pEtG5w==
X-Received: by 2002:a17:902:e807:b0:1b9:e091:8037 with SMTP id u7-20020a170902e80700b001b9e0918037mr23334397plg.30.1691071580298;
        Thu, 03 Aug 2023 07:06:20 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:19 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 06/10] veth: add ndo_xsk_wakeup callback for veth
Date: Thu,  3 Aug 2023 22:04:32 +0800
Message-Id: <20230803140441.53596-7-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 944761807ca4..600225e27e9e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1840,6 +1840,45 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
 	rcu_read_unlock();
 }
 
+static void veth_xsk_remote_trigger_napi(void *info)
+{
+	struct veth_sq *sq = info;
+
+	napi_schedule(&sq->xdp_napi);
+}
+
+static int veth_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct veth_priv *priv;
+	struct veth_sq *sq;
+	u32 last_cpu, cur_cpu;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= dev->real_num_rx_queues)
+		return -EINVAL;
+
+	priv = netdev_priv(dev);
+	sq = &priv->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->xdp_napi))
+		return 0;
+
+	last_cpu = sq->xsk.last_cpu;
+	cur_cpu = get_cpu();
+
+	/*  raise a napi */
+	if (last_cpu == cur_cpu) {
+		napi_schedule(&sq->xdp_napi);
+	} else {
+		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);
+	}
+
+	put_cpu();
+	return 0;
+}
+
 static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			struct netlink_ext_ack *extack)
 {
@@ -2054,6 +2093,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_set_rx_headroom	= veth_set_rx_headroom,
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
+	.ndo_xsk_wakeup		= veth_xsk_wakeup,
 	.ndo_get_peer_dev	= veth_peer_dev,
 };
 
-- 
2.20.1


