Return-Path: <bpf+bounces-50480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C3A2820D
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0693F1886B06
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF6D214A7D;
	Wed,  5 Feb 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjbglBNa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB192135AF;
	Wed,  5 Feb 2025 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723323; cv=none; b=JPUTXPs4IIYQhtMAlUsv59qOHfRExmNCpoclye0zuKfUQ5GeBg6NTUyekpGOkw8m2mUJSkNLgSFjeAg+Tvt+QwtgLVROzf1aMGKfF+Duj67h03peTOjnDuLqhId8rk2dJUfOl7Yv+K2sx5Ze4HTkg2E9FgTjiQMIiDJQ03YlVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723323; c=relaxed/simple;
	bh=O4sXZPGu56IEZtWpYW7G71p/Z5bSTvgmVO3vnfoeqqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQ7aQCsW4UIR/x4Zg+wvej2TJ66jFUNGnsqdW1EdI1YZLKamU8tOZM1wpBjf5sM6ZGVuw8To0Crqh64YwAw1bmahXcX0Js0qGTeKF7unNA3kDwC72ObOz3/c3m4HyPqRPuHB1DZFQMwWXHmrzing7sTz77DQMKssfOBsF0BUCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjbglBNa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738723321; x=1770259321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4sXZPGu56IEZtWpYW7G71p/Z5bSTvgmVO3vnfoeqqQ=;
  b=kjbglBNamnGj2Fq2X7Df69LWxPb/ywk+zCVL2lrnjmhahKGBdyCGNJID
   mizgC1FTJKa7yZVnaPQFpe/xQtbCYWyJpSyvzHwsPZpv3BF/aVBcgUWMs
   CLCH4Ijwz+jae9YdL+iAaOBwOfxYqTZKCn2rWAvawh16c8s/fR/3KASpX
   JbW/hfWxLRXHzs/9SY9E0WdYpM1r/ACcjmErQ7fRiZQUVR60oVcWAnphy
   SToTpAIylZpVTIvuTcR0b8thF6JIkU2v2NmmhPkIbT4A0MFd2JS1fNCym
   bCrB32mjbVYWGHryki9eUkj4l4vodMjdQzXM0lT3I54SA6VJIJETZr5qF
   Q==;
X-CSE-ConnectionGUID: lvsnEAOhS+SweBJpZiVmXA==
X-CSE-MsgGUID: RKDSLc2USfSqyKiMHK5cvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39303869"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="39303869"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:42:00 -0800
X-CSE-ConnectionGUID: kZtIyOmSShqCSBndWI1zyA==
X-CSE-MsgGUID: NM+yU57tRaeqZdlx00NWBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110666589"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa007.fm.intel.com with ESMTP; 04 Feb 2025 18:41:50 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v8 3/5] net: stmmac: Add launch time support to XDP ZC
Date: Wed,  5 Feb 2025 10:41:14 +0800
Message-Id: <20250205024116.798862-4-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205024116.798862-1-yoong.siang.song@intel.com>
References: <20250205024116.798862-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable launch time (Time-Based Scheduling) support for XDP zero copy via
the XDP Tx metadata framework.

This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
on Intel Tiger Lake platform. Below are the test steps and result.

Test 1: Send a single packet with the launch time set to 1 s in the future.

Test steps:
1. On the DUT, start the xdp_hw_metadata selftest application:
   $ sudo ./xdp_hw_metadata enp0s30f4 -l 1000000000 -L 1

2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
   of the DUT.

Result:
When the launch time is set to 1 s in the future, the delta between the
launch time and the transmit hardware timestamp is 16.963 us, as shown in
printout of the xdp_hw_metadata application below.
  0x55b5864717a8: rx_desc[4]->addr=88100 addr=88100 comp_addr=88100 EoP
  No rx_hash, err=-95
  HW RX-time:   1734579065767717328 (sec:1734579065.7677)
                delta to User RX-time sec:0.0004 (375.624 usec)
  XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
                 delta to User RX-time sec:0.0001 (88.498 usec)
  No rx_vlan_tci or rx_vlan_proto, err=-95
  0x55b5864717a8: ping-pong with csum=5619 (want 0000)
                  csum_start=34 csum_offset=6
  HW RX-time:   1734579065767717328 (sec:1734579065.7677)
                delta to HW Launch-time sec:1.0000 (1000000.000 usec)
  0x55b5864717a8: complete tx idx=4 addr=4018
  HW Launch-time:   1734579066767717328 (sec:1734579066.7677)
                    delta to HW TX-complete-time sec:0.0000 (16.963 usec)
  HW TX-complete-time:   1734579066767734291 (sec:1734579066.7677)
                         delta to User TX-complete-time sec:0.0001
                         (130.408 usec)
  XDP RX-time:   1734579065768004454 (sec:1734579065.7680)
                 delta to User TX-complete-time sec:0.9999
                (999860.245 usec)
  HW RX-time:   1734579065767717328 (sec:1734579065.7677)
                delta to HW TX-complete-time sec:1.0000 (1000016.963 usec)
  0x55b5864717a8: complete rx idx=132 addr=88100

Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
        500 us in the future.

Test steps:
1. On the DUT, start the xdp_hw_metadata selftest application:
   $ sudo chrt -f 99 ./xdp_hw_metadata enp0s30f4 -l 500000 -L 1 > \
     /dev/shm/result.log

2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
   VLAN priority 1 to port 9091 of the DUT.

Result:
When the launch time is set to 500 us in the future, the average delta
between the launch time and the transmit hardware timestamp is 13.854 us,
as shown in the analysis of /dev/shm/result.log below. The XDP launch time
works correctly in sending 1000 packets continuously.
  Min delta: 08.410 us
  Avr delta: 13.854 us
  Max delta: 17.076 us
  Total packets forwarded: 1000

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Reviewed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f05cae103d83..925d8b97a42b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -106,6 +106,8 @@ struct stmmac_metadata_request {
 	struct stmmac_priv *priv;
 	struct dma_desc *tx_desc;
 	bool *set_ic;
+	struct dma_edesc *edesc;
+	int tbs;
 };
 
 struct stmmac_xsk_tx_complete {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d04543e5697b..5e5d24924ce7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2514,9 +2514,20 @@ static u64 stmmac_xsk_fill_timestamp(void *_priv)
 	return 0;
 }
 
+static void stmmac_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct stmmac_metadata_request *meta_req = _priv;
+	struct timespec64 ts = ns_to_timespec64(launch_time);
+
+	if (meta_req->tbs & STMMAC_TBS_EN)
+		stmmac_set_desc_tbs(meta_req->priv, meta_req->edesc, ts.tv_sec,
+				    ts.tv_nsec);
+}
+
 static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
 	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
 	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
+	.tmo_request_launch_time	= stmmac_xsk_request_launch_time,
 };
 
 static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -2600,6 +2611,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.priv = priv;
 		meta_req.tx_desc = tx_desc;
 		meta_req.set_ic = &set_ic;
+		meta_req.tbs = tx_q->tbs;
+		meta_req.edesc = &tx_q->dma_entx[entry];
 		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
 					&meta_req);
 		if (set_ic) {
-- 
2.34.1


