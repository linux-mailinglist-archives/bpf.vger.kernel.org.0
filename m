Return-Path: <bpf+bounces-74031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60DC44805
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4851D3B0417
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A23261573;
	Sun,  9 Nov 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuSWbBXg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BC24469E;
	Sun,  9 Nov 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724324; cv=none; b=By2LtIbmdy4ljCO+weGGz5M5i0WVm3IPJn02N/Xyd1pKqBmSK4KWg8ZPi0GmRID8eBGq7L1/N+r40UW3qkCecE5xxA7OoUk62CjwdeQmVS3Wk0siBSZwCkzZYUiqD6xWgjH1kPjj+UjneyeMjfJNZZJyYSFm1E3eHwJj4l1c4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724324; c=relaxed/simple;
	bh=mYeKBxdNWxr3l2Xd+2fxH5pR3XRM2UpwbXIymhRfXcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQYT/8YvdabKUUqJf/jfMOgQekiDkcZEAw4P4n0ozKjSWCaO8SRTDUpJTo7SS9VHWE6plWQLmhOmq7r7/XIAaJMUxh0JmGPRXUqkdeuAL1s3BtPfjCPeG4b6YwYmUhdpDvTWOqENIdN1mU0CDES3BJm1kngpUaZwuk2HcdGfFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuSWbBXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598ACC4CEF8;
	Sun,  9 Nov 2025 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762724323;
	bh=mYeKBxdNWxr3l2Xd+2fxH5pR3XRM2UpwbXIymhRfXcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iuSWbBXghof79JaI2GX0Ghhh5oDX1JVe6wF7V08+c4bGBKeD83MgJg0X+01WyJ2MM
	 24Zh5+WF4RaFmPSSMyM/BrE9Q+gibWipI0eQAz9t7TuE3r0DaC6DVZPYC7FjUjcn20
	 RRdYw5DZAbPT/9GAZ6pU6BhyJU+lSyXG8Gx5/iXbRcbhJmtEbGNwWn1TtQdzNe34fQ
	 SahDtkZ6jyWduwQJTBeBCK5m2FYjJlHYHE8aEEmni9/1MOwx8XxuCXBGb3GEJPHJ+c
	 2oRfu9FHeS8tiRWeiSQO4W43n1UDSyQzI/fyIYTQPPN9x987HYN+GCPWIDZECUly6/
	 SmxQx7sJUOmyQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Sun, 09 Nov 2025 23:37:51 +0200
Subject: [PATCH net-next v2 1/7] net: ethernet: ti: am65-cpsw: fix BPF
 Program change on multi-port CPSW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-am65-cpsw-xdp-zc-v2-1-858f60a09d12@kernel.org>
References: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
In-Reply-To: <20251109-am65-cpsw-xdp-zc-v2-0-858f60a09d12@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>
Cc: srk@ti.com, Meghana Malladi <m-malladi@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=mYeKBxdNWxr3l2Xd+2fxH5pR3XRM2UpwbXIymhRfXcA=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBpEQnZcwLY0HMVPPZ/5ui9vfL2GAhL/5dDS3p3K
 kFMMOKF2SeJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaREJ2QAKCRDSWmvTvnYw
 k3maEACi9iTV7eypb48uXJC0Rh1cWcZbkK3adwV37dIK7x+5G8ZmM/4EsZB1KGbnghoKaBxmi8H
 nWYtXxAOi4IRXoFJ+Zwhm2BILJt0MXSQ4aFa6s09INzw4vzjQNkzuYKDkKPR8lGCGKJ+8d5CcMc
 gp5dyXlkAE9W4EM9YFGW3HxPR46uYbPW6+L0gNXZeumhjkqMIaXpcUt9ObiZJU4J0Cedyeh6/vt
 F1QSpFaN+1eDoc57RIlAdYh2ooHYq9vummsn9FHnSOHaXueeMDNdigkS/H+Z5lmUJyWLRM25XI4
 4W85nq3nSc2xlNnmas6hMg2nZo+LHZF+g0IAs4ewaUQ0ca4nAH0CJdJdLd2FY2bFVl1gUUJybdG
 TCoqq/9g44f/9FId7UrSLKFZnr39F5K9JoL4P7Kk1SqYlktqCMdF0VUSAg6H21iCI8dbLi8EzXr
 /iqn2Y0v259e6D8U7Ccd4+TljRflL1cGibPGO6XCjf/ZL5Q4iAmke6gbJpYbpwut9+8HnkEM07y
 yLhTM6W0fYiy7H2doBpa2WZtIm0dbjQth4NzbkOj6vAZpb+ZBoGcJVsSmrfoGcCPs+csaDjAcng
 pmgblzX2IvOkoaZgW9dkd2fE2JaXc0lwp8BUSZJ81/r+DiQcmTnNtJBjcFenlHDGV77gkuDpLL3
 Iqb9ctE7Y5SSCSA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

On a multi-port CPSW system, stopping and starting just one port (ndev)
will not restart the queues if other ports (ndevs) are open.

Instead, check the usage_count variable to know if CPSW is running
and if so restart all the queues.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d5f358ec982050751a63039e73887bf6e7f684e7..f8beb1735fb9cb75577e60f5b22111cb3a66acb9 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1919,18 +1919,33 @@ static int am65_cpsw_xdp_prog_setup(struct net_device *ndev,
 				    struct bpf_prog *prog)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	bool running = netif_running(ndev);
+	struct am65_cpsw_common *common = port->common;
+	bool running = !!port->common->usage_count;
 	struct bpf_prog *old_prog;
+	int ret;
 
-	if (running)
-		am65_cpsw_nuss_ndo_slave_stop(ndev);
+	if (running) {
+		/* stop all queues */
+		am65_cpsw_destroy_txqs(common);
+		am65_cpsw_destroy_rxqs(common);
+	}
 
 	old_prog = xchg(&port->xdp_prog, prog);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (running)
-		return am65_cpsw_nuss_ndo_slave_open(ndev);
+	if (running) {
+		/* start all queues */
+		ret = am65_cpsw_create_rxqs(common);
+		if (ret)
+			return ret;
+
+		ret = am65_cpsw_create_txqs(common);
+		if (ret) {
+			am65_cpsw_destroy_rxqs(common);
+			return ret;
+		}
+	}
 
 	return 0;
 }

-- 
2.34.1


