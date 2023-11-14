Return-Path: <bpf+bounces-15017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D07EA79A
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 01:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2109D280FF5
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FC79DD;
	Tue, 14 Nov 2023 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvbEBsXg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68805688
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 00:41:50 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CCD4E
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 16:41:49 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so5134328a12.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699922509; x=1700527309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zyBgD9ylUBJw8cZaeW5giSbG/erUfVCuOr5v29FOJ38=;
        b=IvbEBsXgRtSNrtyXcFIWg12KiQrlp28gX0/QQZMOgbkY6EsBUO48N7hP9DeL9cV95D
         D8CWSBmZ99cWyJnWghXyBnPhSt5OqW0CRXNBJI/UYa3w6tCqAGW1/jn2pd0k/yqCpIt/
         ihFM22OFXijZUPffk7RPeaeiOhR6ZTAiJIWJhz0Ov5VkN3qdch6m3cJkSPPegpKFqUZW
         nJ5RhkdhDeO2LMRCvDVBleNuAq2GOXrnY7H0r+5G4CU3eh2EYrIzBKgsU4xz4/CRJ6jx
         EvfydTZtVvodfIbABCSzBgaa6q5wPwuEiOfIWVwF/zb7HYwSbiLRvc0N+vJIRNqP+QTQ
         mk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699922509; x=1700527309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyBgD9ylUBJw8cZaeW5giSbG/erUfVCuOr5v29FOJ38=;
        b=elf6tsrbxBKiKIWO6CSgGBCBO3KDM+/4nUtA+6MeH0Aha8lW57FtUI+2wo+AzBR7x7
         iWRVHicmNF2ds52j8geXH6KsmK93SPpn6tFT1jKGdxqu3hmxrbir1NYMZOqMBmHjhbDT
         wgeBh1x9cFwinO3hH/UVBzabAWcS+Zrvf/rvspyhwxGt1qykOB0OQT1qpQZUkNsqLSOn
         YtVnp82IyfffutixQTIhuj9c1RW7/ZyJXoS6Zd1Bu7f5W3Bu3OJWu4GZta+vgvsvWC5j
         CucNjtEBrosb/S0S97XFjV+PHfvhpIYBD3yWstZr4Aovtj6HBM51we/FFJtZmClPoAct
         Fcbw==
X-Gm-Message-State: AOJu0Yw+KJ3YIHJkd5HOr3QlClBi2bqpxc1eCAhQV+/2PThetMWJftub
	GaeVwS0wQWGKmSV25urm7UYBvztWCEzh2FU=
X-Google-Smtp-Source: AGHT+IEmE3fBSkl1WakSf+0JrgrW/hSDw02MQQ1y2FhtFZzr3H7LTgp75zfge+8giPnaBqwpxMxUFMFPRDd117k=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:79cb:40a5:1ac2:549b])
 (user=ziweixiao job=sendgmr) by 2002:a17:903:181:b0:1cc:4136:2b4b with SMTP
 id z1-20020a170903018100b001cc41362b4bmr247993plg.4.1699922509001; Mon, 13
 Nov 2023 16:41:49 -0800 (PST)
Date: Mon, 13 Nov 2023 16:41:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231114004144.2022268-1-ziweixiao@google.com>
Subject: [PATCH net v2] gve: Fixes for napi_poll when budget is 0
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, stable@kernel.org, willemb@google.com, csully@google.com, 
	shailend@google.com, jeroendb@google.com, pkaligineedi@google.com, 
	jonolson@google.com, sagis@google.com, lrizzo@google.com, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

Netpoll will explicilty pass the polling call with a budget of 0 to
indicate it's clearing the Tx path only. For the gve_rx_poll and
gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
to do all the work. Add check to avoid the rx path and xdp path being
called when budget is 0. And also avoid napi_complete_done being called
when budget is 0 for netpoll.

Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
---
Changes since v1:
 - Adjust the logic of checking budget when it's 0
 - Update the commit message based on the new change
 - CCed the maintainers queried from get_maintainer.pl, but it outputs 19 lines which seems excessive

 drivers/net/ethernet/google/gve/gve_main.c | 8 +++++++-
 drivers/net/ethernet/google/gve/gve_rx.c   | 4 ----
 drivers/net/ethernet/google/gve/gve_tx.c   | 4 ----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 276f996f95dc..2d42e733837b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -254,10 +254,13 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
 	if (block->tx) {
 		if (block->tx->q_num < priv->tx_cfg.num_queues)
 			reschedule |= gve_tx_poll(block, budget);
-		else
+		else if (budget)
 			reschedule |= gve_xdp_poll(block, budget);
 	}
 
+	if (!budget)
+		return 0;
+
 	if (block->rx) {
 		work_done = gve_rx_poll(block, budget);
 		reschedule |= work_done == budget;
@@ -298,6 +301,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	if (block->tx)
 		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
 
+	if (!budget)
+		return 0;
+
 	if (block->rx) {
 		work_done = gve_rx_poll_dqo(block, budget);
 		reschedule |= work_done == budget;
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index e84a066aa1a4..73655347902d 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -1007,10 +1007,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
 
 	feat = block->napi.dev->features;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	if (budget > 0)
 		work_done = gve_clean_rx_done(rx, budget, feat);
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 6957a865cff3..9f6ffc4a54f0 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -925,10 +925,6 @@ bool gve_xdp_poll(struct gve_notify_block *block, int budget)
 	bool repoll;
 	u32 to_do;
 
-	/* If budget is 0, do all the work */
-	if (budget == 0)
-		budget = INT_MAX;
-
 	/* Find out how much work there is to be done */
 	nic_done = gve_tx_load_event_counter(priv, tx);
 	to_do = min_t(u32, (nic_done - tx->done), budget);
-- 
2.43.0.rc0.421.g78406f8d94-goog


