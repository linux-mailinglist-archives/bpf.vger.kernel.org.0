Return-Path: <bpf+bounces-7220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59E7737B3
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064A61C20D91
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D6EF9D5;
	Tue,  8 Aug 2023 03:21:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B8F9C4
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:21:51 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC79213E
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:21:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686be28e1a8so3619235b3a.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=P/V9ljiS+RZV06sSAc2COBIOCp251sZvy3FmMZoG/OkNXoyMAnbNe24EKZNrbifKu0
         TMw9/bIBHlaHnzbtUtWzPHTqYsy2sFGtkRs+xt8vbZzsiS0x7Rc9mKFj2RktzhmElS+2
         SIeHhQhwHgkVPUcIXzdkakUQs/PkxTbSAUA2zU2DOYbE+GTmiLeGsM6DB34oY7IioJoX
         u8Jqfm2ETyE34gqRs7naQ2o/4eL8Sh9ZBIOH/9/XmQWQmnyKbBt5QKI6jrWVjEbTDSob
         NWueoCvGAVQgsnFEvyZJztfQr+58ypf9d4mbmvIy2JWUjfWc7DNBUg9/MfRu1XPR5mvw
         xldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=H+kf8+2pXjasMoCM2/SGN2BTkcLt4LYd/9JTVzQ1PBIlD7uRtIooeNEYXGMLjmEw6b
         4oK8mCRBdLSKcsdhmPrqtvDrsAvX1AD/pbf1YWEBvUEKYGu0EpvG1cMKB2gdV0uvx6A3
         n9qwmW5AfjMRV7nAJ7AZHosFIf6B4k1pb0IiPXd1NRu26VAPkVoj+JZfkYhBSTelB+/S
         Cywkxekby4xbZgDUqfoL5oVJU62z+UFNuPjDPo/JUq2m8Glt0WlXTSby1mZhASnAnHwS
         1ve4MOFxPwOvYw9vSea3cEemWDC9j2k41kgmbwAJbdsuCxl31KWlvsWCpdaLsgH8XZVi
         fvZg==
X-Gm-Message-State: AOJu0Yys+vzQ4AvCwe7fy2TMIQsYP0Oy0LPn7QPtc3/E8ZS9SUAqVMjg
	s9rzuBNmkRlOkpZbvq5g+DRCDQ==
X-Google-Smtp-Source: AGHT+IFOa9auvTw+52jDK1Q58QGt14PBhuKoWVXpCxAriS0oNTmVYC/tpubsf59++3sdyZXGMGacNA==
X-Received: by 2002:a05:6a20:9193:b0:140:d536:d424 with SMTP id v19-20020a056a20919300b00140d536d424mr6753584pzd.53.1691464887689;
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 9/9] veth: add support for AF_XDP tx need_wakup feature
Date: Tue,  8 Aug 2023 11:19:13 +0800
Message-Id: <20230808031913.46965-10-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

this patch only support for tx need_wakup feature.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 70489d017b51..7c60c64ef10b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1447,9 +1447,9 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 
 	memset(&tuple, 0, sizeof(tuple));
 
-	/* set xsk wake up flag, to do: where to disable */
+	/* clear xsk wake up flag */
 	if (xsk_uses_need_wakeup(xsk_pool))
-		xsk_set_tx_need_wakeup(xsk_pool);
+		xsk_clear_tx_need_wakeup(xsk_pool);
 
 	while (budget-- > 0) {
 		unsigned int truesize = 0;
@@ -1539,12 +1539,15 @@ static int veth_poll_tx(struct napi_struct *napi, int budget)
 	if (pool)
 		done  = veth_xsk_tx_xmit(sq, pool, budget);
 
-	rcu_read_unlock();
-
 	if (done < budget) {
+		/* set xsk wake up flag */
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
 		/* if done < budget, the tx ring is no buffer */
 		napi_complete_done(napi, done);
 	}
+	rcu_read_unlock();
 
 	return done;
 }
-- 
2.20.1


