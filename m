Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359BB21EF18
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGNLUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGNLSm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC1C08E806
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so20900061wru.6
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/zoKcrmx2IW2qZYN8v07zqfWyovJdKlsFhRtVJoj8Y=;
        b=b1sAb44WGmZFCdVAFpOnOB6gjm1ZuIfnH5qfH6jEl7r1V5Ot0bj2a/haai/zLlbGwZ
         jyft/gXpKRKwhcAmBF6N1E3tVUv3FpyxaQDJbEMA+kzxFOdi5i/iC+SuVdGwUK3S7lkC
         JCMyVtDbRUfFVhAZkbBSmtUupdpqKKxXkUPJTaoOYPu5dPFvyg6Blg9WrDMzB/cseVM+
         rhmyyRlfWyztEMer+eWo6n3Do/AXv5WhKdZaS+4tgq6H2R8pELz1fQ3yZJcDDG53AKI8
         o6mlh08h6jJhiGMzg1aEP83hrtSL2JwTrrM/lGjoC5Bpn1y65cxU+TAsW9GNOLI5/kNh
         tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/zoKcrmx2IW2qZYN8v07zqfWyovJdKlsFhRtVJoj8Y=;
        b=ZtX28jDlJtWRH68C8UXNelCncNZgQqL00QJL9OyO6fkXLd/A0q4fB5rJEmxvPN58fV
         mQzPeGMfTq7nGPGO+kJF3o/x4IIUEeKE3kkqWl7zHSpUdPsiQyOCL/ymOwThfixxohVV
         5iMtJM7pFTuPKXY04nLeW4NzfbwFX0q96OlPSiMXjR2rkvoQr9f69B0jbISBKfsld2XF
         XFHeOJ6tEyx27PXWE/XRzfoYcR4fPs8MN/vFU72m4bMwctYwVV+sTYRmzahIy8TDxZwh
         HwaKza/D1AjeOoQAdoMkp7uaIitslGvXk/tUkb/37yIhhHU7a/yaMnp3R6EVIkm86a7U
         /v9A==
X-Gm-Message-State: AOAM531bAfKnRAmggOYzIqyZmkMviIQXkTLjplZid8sMNTz10xPK4+g7
        tNKb0lzblhBGL8xPPsYmXvN8Lg==
X-Google-Smtp-Source: ABdhPJyAUbTKcS5Sll5KxkNhZWdfScOwNs01z+UT0g/DeH+FLBo8B9AbZI4twgzB3lN+ZB/l5mfLmQ==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr4923996wru.301.1594725364528;
        Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 13/17] dma: nbpfaxi: Provide some missing attribute docs and split out slave info
Date:   Tue, 14 Jul 2020 12:15:42 +0100
Message-Id: <20200714111546.1755231-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/nbpfaxi.c:157: warning: Function parameter or member 'chan' not described in 'nbpf_desc'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'tasklet' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_addr' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_width' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_src_burst' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_addr' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_width' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'slave_dst_burst' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'running' not described in 'nbpf_channel'
 drivers/dma/nbpfaxi.c:220: warning: Function parameter or member 'paused' not described in 'nbpf_channel'

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/nbpfaxi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 594409a6e9752..74df621402e10 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -144,6 +144,7 @@ struct nbpf_link_desc {
  * @async_tx:	dmaengine object
  * @user_wait:	waiting for a user ack
  * @length:	total transfer length
+ * @chan:	associated DMAC channel
  * @sg:		list of hardware descriptors, represented by struct nbpf_link_desc
  * @node:	member in channel descriptor lists
  */
@@ -174,13 +175,17 @@ struct nbpf_desc_page {
 /**
  * struct nbpf_channel - one DMAC channel
  * @dma_chan:	standard dmaengine channel object
+ * @tasklet:	channel specific tasklet used for callbacks
  * @base:	register address base
  * @nbpf:	DMAC
  * @name:	IRQ name
  * @irq:	IRQ number
- * @slave_addr:	address for slave DMA
- * @slave_width:slave data size in bytes
- * @slave_burst:maximum slave burst size in bytes
+ * @slave_src_addr:	source address for slave DMA
+ * @slave_src_width:	source slave data size in bytes
+ * @slave_src_burst:	maximum source slave burst size in bytes
+ * @slave_dst_addr:	destination address for slave DMA
+ * @slave_dst_width:	destination slave data size in bytes
+ * @slave_dst_burst:	maximum destination slave burst size in bytes
  * @terminal:	DMA terminal, assigned to this channel
  * @dmarq_cfg:	DMA request line configuration - high / low, edge / level for NBPF_CHAN_CFG
  * @flags:	configuration flags from DT
@@ -191,6 +196,8 @@ struct nbpf_desc_page {
  * @active:	list of descriptors, scheduled for processing
  * @done:	list of completed descriptors, waiting post-processing
  * @desc_page:	list of additionally allocated descriptor pages - if any
+ * @running:	linked descriptor of running transaction
+ * @paused:	are translations on this channel paused?
  */
 struct nbpf_channel {
 	struct dma_chan dma_chan;
-- 
2.25.1

