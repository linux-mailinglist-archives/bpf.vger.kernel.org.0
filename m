Return-Path: <bpf+bounces-26262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1089D59C
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405A72836B6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D307FBB3;
	Tue,  9 Apr 2024 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+pY/74f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0397EF1F;
	Tue,  9 Apr 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655055; cv=none; b=VIESJebtXa+2E0MbHylYGQqWNxW77Ozk2xwOTDPsDwo+rGMevSZjNDbgmK5MurdtLl782DIsrC+nmcutBvXUCYy6IB7He1wPr6W6vivYnnYaKIiXGTbVxVdk3zyjnNIj+d8jkcDrKwR33dc7UIX0ldkfAXJa+E6HCUDyBIsorG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655055; c=relaxed/simple;
	bh=jEtT5oh0VuwdEukTzdXhBGXjl3jsARbIDDLFOf2IqPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n448dcd7xgBLHDAjV/FL2v5JKspKsQp6tG3Mf6edu1eMub6ekmiwUWzHMN828dTv267BDZzZ+8T8qx1CPEIEF2ws8+fp0OHo6yfCPNVDRtsI2hzEhiBr37sUDHhTszDIMh+Jv3GnHaffU/NfzfvcUFKXum7AEYIpfaHvgkhenos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+pY/74f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4169ebcc924so5458975e9.0;
        Tue, 09 Apr 2024 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712655052; x=1713259852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrQFgW5NMDk7lpDGirGRe1MHp1a/P3mgVccPOJo0IK4=;
        b=c+pY/74f1VE8gAnbPytMWqEVJBmhJ9ol7gfBdZhpQkhNnFPXhpbsj772UkCJxdEooj
         CWeywDTVyxWSu9cKCYmdu6Z8um/AVuB0k8G6Yv15DTm3bCWXDzd+mOFsyAYK36VsrMmt
         C5he/kQD2RQzXTXNFAkc7dcZP6XWPLUR+1u04OPipNXISNMDZBdOhtGfEA4uaTYGOGXc
         Fgl3j3QPo6Fk2bCrz07YK+HisEHpUt8aDf/j4KQNomFuvpsIN9CNxz1BXWB3NDZwjn0J
         n8xjCJfPP4uqPsHVRglnYUNiZdFpcvwqSjlJX50nu9G1jGYbAGXlpVwqZzIX958mVcEb
         aQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655052; x=1713259852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrQFgW5NMDk7lpDGirGRe1MHp1a/P3mgVccPOJo0IK4=;
        b=h+TJ4BK9o3U8fVSl7d0GxXtvyTxnEsZayRaLOzqKq+fAPazXj9lOpwQjGq5h8ntDz8
         OSSy44Km5DWix0FlBKSu0ssO0mfm1NlS3zQjyzqgYSyN8VNXx7jWc9Y5nUs7xrDDSW5n
         Kv61FN95B/iFk+5eZd5eAHIicFHZSKe6husgy+o15NzdoMbi8tJwktAPHUZWhRJIA/kw
         u4KxxnPUvY8jMXjfEa8Yur0MtTVKmMI7jQbXSuxpWaXJSVPFVNTlxq8gOcuU1++1pe8x
         bD2LphsIyLKQU6YYNrFytagL+EhkFxcr6OYR+mZbOjMHLl+NqGbGS3c9YNNbKH9BMfYj
         2EtA==
X-Forwarded-Encrypted: i=1; AJvYcCVxuv/1h4AhUVdHNNdqCJXO4ICqs4pGWAdDrUY4LCHYCDOqAcW0XRxcO6ZM2FZkyiumScK2C/1zLw6HPiRsQ6R2wM7dNnY1wAQZkHEZo7uVrUVTXHWwbpO3G4OkYKoXCr97aH1i4DdqVTqMN3TBe1bSeDh+oLGAU5eH
X-Gm-Message-State: AOJu0YyuHiH83Rmh+agrRjmLT8GSiIKm39mpfMMB/Qs2Nrkj/0eidnty
	2OUTq3hZlYKKDrzNgShfoMcfuFbUT3FLZjmYwq6poEmA7jIr3zSR
X-Google-Smtp-Source: AGHT+IHdx8m3SXXRh9w1ZQWKaJqtKhg2r8xplLgr4jH1JriaRbjVj9T8P9OaSiD70FncD1cHxBlxxg==
X-Received: by 2002:a05:600c:358b:b0:416:8e14:cd90 with SMTP id p11-20020a05600c358b00b004168e14cd90mr2441118wmq.11.1712655051599;
        Tue, 09 Apr 2024 02:30:51 -0700 (PDT)
Received: from pc-de-david.. ([2a04:cec0:1021:d54f:6305:1522:b3ea:4a38])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b00416a7313deasm1716750wmq.4.2024.04.09.02.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:30:51 -0700 (PDT)
From: David Gouarin <dgouarin@gmail.com>
To: 
Cc: david.gouarin@thalesgroup.com,
	David Gouarin <dgouarin@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Camelia Groza <camelia.groza@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v4] dpaa_eth: fix XDP queue index
Date: Tue,  9 Apr 2024 11:30:46 +0200
Message-Id: <20240409093047.5833-1-dgouarin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8edda7aa8ff27cee1b3fa60421734e508d319481.camel@redhat.com>
References: <8edda7aa8ff27cee1b3fa60421734e508d319481.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to bind a XDP socket to a queue id.
The DPAA FQ Id was passed to the XDP program in the
xdp_rxq_info->queue_index instead of the Ethernet device queue number,
which made it unusable with bpf_map_redirect.
Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.

Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")
Signed-off-by: David Gouarin <dgouarin@gmail.com>
---
v4: fix patch formatting
v3: reword commit message
v2: add Fixes: in description
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6..988dc9237368 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
 	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
 		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
-				       dpaa_fq->fqid, 0);
+				       dpaa_fq->channel, 0);
 		if (err) {
 			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
 			return err;
-- 
2.34.1


