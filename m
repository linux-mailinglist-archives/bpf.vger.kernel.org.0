Return-Path: <bpf+bounces-39424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC1972D86
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780622866FE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88218FDCC;
	Tue, 10 Sep 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9Xm7KY2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFD1891A1;
	Tue, 10 Sep 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960276; cv=none; b=RmyYEOxF285hGNGuQl/i6II4LlGBmr+pTFB2pXbp87IYI8rX9Y0oZskEhwhkmWYNBlH+PT4q3AMKZi5OYC8I4aHtj800votis49SVzZc6Bm//iegxxXHw/MePa6uML6G/7ZpzlbDLfG4plzGSN1/U+Co+vQ3Wpzz14NKDXRPne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960276; c=relaxed/simple;
	bh=Qd0j7HD4DsmaZ5Rx4eSfD1A4i/7ZLHtFqt+DVyDB9E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5ypMbPYNG/AcEZ/yjAz4l7hNcQahJ18onzGHm9BgXwxb/gO5QDtVx0HhDT6goE37Y165d3ooNv+pgwWiNTuFOB1lVwdKUdadfiaVBvugGL2IoX+EV0SQZ/siuCndVdlYZRzPekwFwnglnxL7aGhFkXmF5XbJcZyWuY1UH6ZL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Xm7KY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC38AC4CEC6;
	Tue, 10 Sep 2024 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960276;
	bh=Qd0j7HD4DsmaZ5Rx4eSfD1A4i/7ZLHtFqt+DVyDB9E4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9Xm7KY2LeC0G3Ro51ESXTcIn03hjj3rmvEAjYGOWDzbF4BGONEUWD2QtSQkfHw7f
	 +35WRy8TtbVHa4mGGJl8UcHNwIsHdD1568YxZgdii24mgeuXSelrdTpcnMRfZi8aNX
	 SVYTwUKzpx0HLsv4qPrGp6LhA2MOMGrkMFpSLf60/LOGERx1WBNUspKAMKC0C0+xfe
	 EHxC3t1fYLaODbexPVVAW89O94daOU9nG/TYhq6PLCuqh0ERVI/uZeWppAKKivwoGP
	 2fVD1Q+fS4AFJIW63HUiBZf2X4Lvjz9mJwy8CcuqIQRkEYJfa1pjGbeJcA/NU5gZ4I
	 FF1dFcEwq85Jg==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:24:02 +0300
Subject: [PATCH net-next v4 5/6] net: ethernet: ti: cpsw_ale: add
 policer/classifier helpers and setup defaults
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-5-077fa6403043@kernel.org>
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Joe Damato <jdamato@fastly.com>, srk@ti.com, vigneshr@ti.com, 
 danishanwar@ti.com, pekka Varis <p-varis@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6095; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Qd0j7HD4DsmaZ5Rx4eSfD1A4i/7ZLHtFqt+DVyDB9E4=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA19Dv6aUGGhiRP/9HmBWT31pBFuWkt766K4
 iEGBPK/B2OJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNQAKCRDSWmvTvnYw
 k8WxD/0TYNHXhre4sESpo35jaaE1UYSad+WWq9bcfoWBsa2moRkS6xNjwNAgj863BqRK0CkIe9j
 S/u4M7Kxia5OStjHBBESqYDeW5Kh0McoJ2yM+IwlbB07VmbSYA2VK8Y+Fav0/Lv7wOAS4JPKJmP
 tud0HFC0kjwrP6x1uTjjV6bjQqqfxkjfGJWO4Pg+NiWcpJM2AyUfa4zs2jhRUZQNdWUwik9IwTA
 7cVvvLPejGxyXbPNDkG8NAI1IQjwKpyI+dTqyQGafp1jObWCHBxGwsXZmXB3PuuJw3HfZIKnQgL
 y3Ce1cqghs1oj+3cO68eH86FcGUHC0GUQ5DU/tbr7LBqUa2NdGvUHQtOmEB9wn99KVK0+xK+iF2
 J0QBSZwY8FKVgHUEdPCLvIZz8UOrJPN146+CaFhQpelYd7TDKd7BK9JC/vs0sCOLqvtMgKvMdmF
 +EOA/0Yrc0WLasQvwzyI54io2m2VvZPtQMH7IA9RtWL9kGfGVZlnyhk+xYaLzmXOhznijaS2np2
 F5E7JsKqA9uBT/rs7bBPIZyaK/+bOvYqLH0fSic8wugyve9yPktAQ19yDRZcmVxUbx5T6mjvTjF
 WtSInZSPHFnx30EE1k0UHhLppkCUtTf0wKTQZY+5ed1kxEb8C3v5KN7YHf8DeCF6EmTPoFJqGn/
 J2BESV/EwYzBZHg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The Policer registers in the ALE register space are just shadow registers
and use an index field in the policer table control register to read/write
to the actual Polier registers.
Add helper functions to Read and Write to Policer registers.

Also add a helper function to set the thread value to classifier/policer
mapping. Any packet that first matches the classifier will be sent to the
thread (flow) that is set in the classifier to thread mapping table.
If not set then it goes to the default flow.

Default behaviour is to have 8 classifiers to map 8 DSCP/PCP
priorities to N receive threads (flows). N depends on number of
RX channels enabled for the port.
As per the standard [1] User prioritie 1 (Background) and 2 (Spare) have
lower priority than the user priority 0 (default). User priority 1 being
of the lowest priority.

[1] IEEE802.1D-2004, IEEE Standard for Local and metropolitan area networks
Table G-2 - Traffic type acronyms
Table G-3 - Defining traffic types

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v4:
- no change
v3:
- squashed 2 patches into 1
- added comment explaining the default thread to priority mapping table
- typo fix "classifer"->"classifier"
---
 drivers/net/ethernet/ti/cpsw_ale.c | 94 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_ale.h |  1 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index aafe1210de52..0d5d8917c70b 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -1627,3 +1627,97 @@ u32 cpsw_ale_get_num_entries(struct cpsw_ale *ale)
 {
 	return ale ? ale->params.ale_entries : 0;
 }
+
+/* Reads the specified policer index into ALE POLICER registers */
+static void cpsw_ale_policer_read_idx(struct cpsw_ale *ale, u32 idx)
+{
+	idx &= ALE_POLICER_TBL_INDEX_MASK;
+	writel_relaxed(idx, ale->params.ale_regs + ALE_POLICER_TBL_CTL);
+}
+
+/* Writes the ALE POLICER registers into the specified policer index */
+static void cpsw_ale_policer_write_idx(struct cpsw_ale *ale, u32 idx)
+{
+	idx &= ALE_POLICER_TBL_INDEX_MASK;
+	idx |= ALE_POLICER_TBL_WRITE_ENABLE;
+	writel_relaxed(idx, ale->params.ale_regs + ALE_POLICER_TBL_CTL);
+}
+
+/* enables/disables the custom thread value for the specified policer index */
+static void cpsw_ale_policer_thread_idx_enable(struct cpsw_ale *ale, u32 idx,
+					       u32 thread_id, bool enable)
+{
+	regmap_field_write(ale->fields[ALE_THREAD_CLASS_INDEX], idx);
+	regmap_field_write(ale->fields[ALE_THREAD_VALUE], thread_id);
+	regmap_field_write(ale->fields[ALE_THREAD_ENABLE], enable ? 1 : 0);
+}
+
+/* Disable all policer entries and thread mappings */
+static void cpsw_ale_policer_reset(struct cpsw_ale *ale)
+{
+	int i;
+
+	for (i = 0; i < ale->params.num_policers ; i++) {
+		cpsw_ale_policer_read_idx(ale, i);
+		regmap_field_write(ale->fields[POL_PORT_MEN], 0);
+		regmap_field_write(ale->fields[POL_PRI_MEN], 0);
+		regmap_field_write(ale->fields[POL_OUI_MEN], 0);
+		regmap_field_write(ale->fields[POL_DST_MEN], 0);
+		regmap_field_write(ale->fields[POL_SRC_MEN], 0);
+		regmap_field_write(ale->fields[POL_OVLAN_MEN], 0);
+		regmap_field_write(ale->fields[POL_IVLAN_MEN], 0);
+		regmap_field_write(ale->fields[POL_ETHERTYPE_MEN], 0);
+		regmap_field_write(ale->fields[POL_IPSRC_MEN], 0);
+		regmap_field_write(ale->fields[POL_IPDST_MEN], 0);
+		regmap_field_write(ale->fields[POL_EN], 0);
+		regmap_field_write(ale->fields[POL_RED_DROP_EN], 0);
+		regmap_field_write(ale->fields[POL_YELLOW_DROP_EN], 0);
+		regmap_field_write(ale->fields[POL_PRIORITY_THREAD_EN], 0);
+
+		cpsw_ale_policer_thread_idx_enable(ale, i, 0, 0);
+	}
+}
+
+/* Default classifier is to map 8 user priorities to N receive channels */
+void cpsw_ale_classifier_setup_default(struct cpsw_ale *ale, int num_rx_ch)
+{
+	int pri, idx;
+	/* IEEE802.1D-2004, Standard for Local and metropolitan area networks
+	 *    Table G-2 - Traffic type acronyms
+	 *    Table G-3 - Defining traffic types
+	 * User priority values 1 and 2 effectively communicate a lower
+	 * priority than 0. In the below table 0 is assigned to higher priority
+	 * thread than 1 and 2 wherever possible.
+	 * The below table maps which thread the user priority needs to be
+	 * sent to for a given number of threads (RX channels). Upper threads
+	 * have higher priority.
+	 * e.g. if number of threads is 8 then user priority 0 will map to
+	 * pri_thread_map[8-1][0] i.e. thread 2
+	 */
+	int pri_thread_map[8][8] = {	{ 0, 0, 0, 0, 0, 0, 0, 0, },
+					{ 0, 0, 0, 0, 1, 1, 1, 1, },
+					{ 0, 0, 0, 0, 1, 1, 2, 2, },
+					{ 1, 0, 0, 1, 2, 2, 3, 3, },
+					{ 1, 0, 0, 1, 2, 3, 4, 4, },
+					{ 1, 0, 0, 2, 3, 4, 5, 5, },
+					{ 1, 0, 0, 2, 3, 4, 5, 6, },
+					{ 2, 0, 1, 3, 4, 5, 6, 7, } };
+
+	cpsw_ale_policer_reset(ale);
+
+	/* use first 8 classifiers to map 8 (DSCP/PCP) priorities to channels */
+	for (pri = 0; pri < 8; pri++) {
+		idx = pri;
+
+		/* Classifier 'idx' match on priority 'pri' */
+		cpsw_ale_policer_read_idx(ale, idx);
+		regmap_field_write(ale->fields[POL_PRI_VAL], pri);
+		regmap_field_write(ale->fields[POL_PRI_MEN], 1);
+		cpsw_ale_policer_write_idx(ale, idx);
+
+		/* Map Classifier 'idx' to thread provided by the map */
+		cpsw_ale_policer_thread_idx_enable(ale, idx,
+						   pri_thread_map[num_rx_ch - 1][pri],
+						   1);
+	}
+}
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 2cb76acc6d16..1e4e9a3dd234 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -193,5 +193,6 @@ int cpsw_ale_vlan_add_modify(struct cpsw_ale *ale, u16 vid, int port_mask,
 int cpsw_ale_vlan_del_modify(struct cpsw_ale *ale, u16 vid, int port_mask);
 void cpsw_ale_set_unreg_mcast(struct cpsw_ale *ale, int unreg_mcast_mask,
 			      bool add);
+void cpsw_ale_classifier_setup_default(struct cpsw_ale *ale, int num_rx_ch);
 
 #endif

-- 
2.34.1


