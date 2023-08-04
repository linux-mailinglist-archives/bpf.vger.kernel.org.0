Return-Path: <bpf+bounces-6965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8D76FC34
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24B11C217B8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0DA934;
	Fri,  4 Aug 2023 08:41:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C8A928;
	Fri,  4 Aug 2023 08:41:22 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2134.outbound.protection.outlook.com [40.107.14.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5D130E5;
	Fri,  4 Aug 2023 01:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrE175AlX+fT+Kq2ggw2znyVdFUuE4Lwus519cj9SwLxc3OSG6nfokm8JcLeSfFRWJI8vcoyzEM5FMYtbiLSTlLNT3Whg1OxLLOxOX28hzmGP3ECjTi4R7BSRCZsTW69WMM6RaTeJdEJT7tAr64gXmprHNXMDkJ3v+1pybNlxBZVLRa6sjHvYcSKe4DxcSITWKNuHKx1AY72S4hEJE22HYiWVK4Wv4c1MnwFTuTsBQb4bSS2gdJfBUqhoLZwvnheSBqBU3QgILxkHQImsW5YC7kYsHioAnzXahwwYZUfhkEtKiPA+NnfYPQfiT7PgF0pzjJLazhMrMYRZjPs/Rw4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=QE7JBdB7u7tIXVYrTqNaz1IB9aWJ/qtIQuWhefPVF87vAh1aYMOFSUx34weIxcXDT86cjtZaUqksFekrWt9HQKeBazDq9KexU4lIKM6Bb4JWo6wU2x9gJ39za9E+/5DinELTriEwcIUv5aIWlOWlwFVx2z0oFDmOiQJQ47Uu6rCu82lyy9JZ1BQObtl4G14Jcpg2uaaYmUabjkPk66LyNJ2m6G7YXlrKXi6jFaK38GO3VY0FAiypDXrN5ch54Po9lKZ5SF94q/kL4FpLvUnxYbW5wn2edvIkjKTBj5tcKY2iGL4ORTW0fxAjiz+UPcxgYrqP/ZOh8P/ppX0uBP/GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec8tI81n3emaORjojzJTfh9xzHGICKi45AOXMsqZKJI=;
 b=eYP/9DHFBTcWSOe46brw+rE+ETlrArunN3QwzPM8GmdrPqwKUqZ4mqQIKnEXOMV35FkOYwmecPIDMak8x4TQokCeGv6CBjb0DVVBzwCmVIiXWX+q9wW1DcNK5LP6GpdN0WhNaY+iYR0zIQePxiTJ6VLglJQ2/Dw9W+1C5BPfU38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by VI1P18901MB0736.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:41:14 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6609.032; Fri, 4 Aug 2023
 08:41:14 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v4 2/4] igb: Introduce XSK data structures and helpers
Date: Fri,  4 Aug 2023 10:40:49 +0200
Message-Id: <20230804084051.14194-3-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000000E5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:19) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|VI1P18901MB0736:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6c717d-704e-4d2e-8ac1-08db94c68f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O8huwWnMn4/zhMxrWfBezBHucohZ0kqCELxC14GfA/4Q/SUJZSWlud16EpdOy9/wy9n8CdM5aPn2HR1Bt2n2aL4Jz/OuJQYHQtMliX+KPyj65JkyolpWZhisCC2ErokTLb+EOg+1whSHhhGyPXdHbU6VzWH7LzaLNaU2nmvIJ9jSROAAhfN67C29/M4dtROZcZ7ssKHVBphJFuoq/uzPDczfcF8qdtdL5R+D7wRCJrZc2zswfyQXO/ZHMSWneLTl0ou0eom2OK4g01/xzGNL1RS4wt7KVdYd05lYdtOvJ7TuOSBTNRsgkZUR1XtefevKgtNPTE/7za7XCPhsEMqTeTJgpHs7CK6D7ymAPDA/cUCY5sTNNqdnAN72R3GklvkS7vFlh9G0RT/HeuappMjRKw+LNpolqnjbmwxOIoCjWFGcNVEE0IhlhR60OfPewY0B3dtZ2kPR8KXX/hqeVWMC0fycA715DmHyV50FQucIUGYCw6+BRH3nnjRDVDPaqmhSkpmyCcJNDbz8PJkmBbrlZPV3Ql97KplRA5dR0yO39rD2u/4kHMpGfCkJbX19aKMIDDYDwidPx2/a+sgwrSoXFsW0mdZ3wbtnYe4NaimtFS9HsLxhlqluWppdzyHtgi0zGo2K/VLv78rGHclSWmdxFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39830400003)(346002)(451199021)(109986019)(1800799003)(186006)(6506007)(1076003)(26005)(38100700002)(2616005)(83380400001)(36756003)(2906002)(5660300002)(7416002)(44832011)(8676002)(478600001)(54906003)(86362001)(6512007)(6666004)(6486002)(41300700001)(316002)(8936002)(4326008)(66556008)(66476007)(70586007)(66946007)(66899021)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MG7mnWBML1hxLLUiW78C+eStF+m+LHy99BVZcB5APHEQ5dPKH7GbFdo7NdXU?=
 =?us-ascii?Q?QRwr0d9TBGdAvQ5iC6IYr4ks1y92Gc+kty5HyB4t1rGCoUJ5nKa2eLDhoDx3?=
 =?us-ascii?Q?tD3Jz4FscXZLheFXp4xk630t6+2CYv5+/xeqy8MQKXCByIkZPSzDUuN4WjJr?=
 =?us-ascii?Q?WROrIiJBaQZnsisiMx1DaKdSNhTKjTSAwe6U66DiTE2ax4IYcEgiGk2jo2PK?=
 =?us-ascii?Q?vxkh+dXGJUSJlbluy4eHl0uEp/Q8qL/TP4bYGBTyd30/ayherQ6M+srUEPCV?=
 =?us-ascii?Q?dwtzIDnHGA+sIKKp5yYoE5yhls1Gx274oBM7+gyWgOntVVF10oHmQGHF8Yvq?=
 =?us-ascii?Q?sg5hkQ1Y4+HSZtK76myn0g7XN7SQAMRKtba8I0rKhdiEa+9kyvXj/b7sJGfR?=
 =?us-ascii?Q?mP+HdQZhAtBsmYQ/TbGddUsEAQ5073dE6iFE04OC5Z3RAqyWwjVWViNBCllp?=
 =?us-ascii?Q?K5SBHKq0IqpJhdZvxos3LG4iRlGKJ56UKIvBGSBXrXM0eXhJNs4a58+f4O9a?=
 =?us-ascii?Q?ple7ZUNl1t9QqFtsKryclCWq+4fagyYzsvHCdHEl173bhTXCmPq8D0AapwSv?=
 =?us-ascii?Q?Ymrag0uOQOrmPAstwlnJde8g00+eCHKvi0rIJwMm7jsNak+Z96DYoS/N3T6t?=
 =?us-ascii?Q?TPzh8mCTZ09XOggaUVyw4VISacWje2KgAcVnrxgAxeWDtQKorW3T/z/p96ql?=
 =?us-ascii?Q?hp/7119F8n3HF1F2lXEtLwp/NAoLNW8dzass2hbuHS4DklQ3twGVkPpvHxNl?=
 =?us-ascii?Q?UgstfpnZYWZMJbsjqaze2YkYvtwT1+5xi/o6JUpHTYKadShevck8BObT8yzx?=
 =?us-ascii?Q?75WahDPQ5BpO6dr4+ZsmRoVaHNWhXoZ9SnBar2teffV7tJYzelosuxX99h/S?=
 =?us-ascii?Q?uINpkeodv1zjd7iCj8yU0bjq39pAMuMoySDW5Hf4U1kPrcqSlJAk+r9UpAEc?=
 =?us-ascii?Q?3W64beYGvj1oIrh90WX1PEGg3OKt1JHMaJGde+KhLrBJWAEYggh34HIzkZJA?=
 =?us-ascii?Q?dTGvL25ZmXSLWhM8MRJa3XEtR6AEzEi8s5ldvofu3Pj8BH29ouQ9/DQruqNF?=
 =?us-ascii?Q?zBMEsLiJft+PX3ocfmXxkYzrOHIumYknqcgmOUv0wiRoM1o5ToqQ9Y1vQO0E?=
 =?us-ascii?Q?Brhd3q4SOMRgUo4WTcj1iLIsBZMU2lxEfiMK44DpoUb0DGIkMdPZrOQfJ4+/?=
 =?us-ascii?Q?P5zTyiGzM+pYuUtns+yY9pycNoj3oLmGyKnFPK0o5T4PMyameXSFCN7X1ZLM?=
 =?us-ascii?Q?DSXMg9OSOoTqdgmnDxreNssekT3XKiILTJ3aRSdogKQdUz6tdfUubexcYl8d?=
 =?us-ascii?Q?Mu4B4w7Q55B/MTgopfNMNAUPkG4XMSiAzOxQ9Z57hVhwww1r3rwfuBW0Ok2K?=
 =?us-ascii?Q?dNR+OrvQufdmcMDXeQ412INNS73D4R4KaQP4To8rWAepAiz3V4z6o9GHJgLs?=
 =?us-ascii?Q?VQbF6hNJ6DQ9HL30mZqvumhHoKVDyCdfhWGTWWG2dJcnVoJ7ntwXbqgWdaN7?=
 =?us-ascii?Q?UPUuspwx3DkXuv8sqxHPpIynZTG3u/mxgYMhk7lZKvMgnX/mAxTxnPby4YtH?=
 =?us-ascii?Q?9n0//fAbpuDjufP+IoDCXSoINjemV1hSuS3PwSDojwnymhGQTdqcVlpMA7Cd?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c717d-704e-4d2e-8ac1-08db94c68f8e
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:41:13.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViCuq0H5fvbDgDmY7ec8HB0b8GqyvypdBDqSI7cuWfo3e8d5BEub1Tfghn3Hdry/tuakVdFc8tVA8d2DwsCcuObyugv6s9YIGNzMFJTxf9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0736
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the following ring flags
- IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
- IGB_RING_FLAG_AF_XDP_ZC (xsk pool is active)

Add a xdp_buff array for use with XSK receive batch API, and a pointer
to xsk_pool in igb_adapter.

Add enable/disable functions for TX and RX rings
Add enable/disable functions for XSK pool
Add xsk wakeup function

None of the above functionality will be active until
NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  14 +-
 drivers/net/ethernet/intel/igb/igb_main.c |   9 +
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 210 ++++++++++++++++++++++
 4 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 394c1e0656b9..86d25dba507d 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_IGB) += igb.o
 
 igb-objs := igb_main.o igb_ethtool.o e1000_82575.o \
 	    e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
-	    e1000_i210.o igb_ptp.o igb_hwmon.o
+	    e1000_i210.o igb_ptp.o igb_hwmon.o igb_xsk.o
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 58e79eb69f92..1af1a0423fba 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 struct igb_adapter;
 
@@ -320,6 +321,7 @@ struct igb_ring {
 	union {				/* array of buffer info structs */
 		struct igb_tx_buffer *tx_buffer_info;
 		struct igb_rx_buffer *rx_buffer_info;
+		struct xdp_buff **rx_buffer_info_zc;
 	};
 	void *desc;			/* descriptor ring memory */
 	unsigned long flags;		/* ring specific flags */
@@ -357,6 +359,7 @@ struct igb_ring {
 		};
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xsk_buff_pool *xsk_pool;
 } ____cacheline_internodealigned_in_smp;
 
 struct igb_q_vector {
@@ -384,7 +387,9 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_RX_SCTP_CSUM,
 	IGB_RING_FLAG_RX_LB_VLAN_BSWAP,
 	IGB_RING_FLAG_TX_CTX_IDX,
-	IGB_RING_FLAG_TX_DETECT_HANG
+	IGB_RING_FLAG_TX_DETECT_HANG,
+	IGB_RING_FLAG_TX_DISABLED,
+	IGB_RING_FLAG_AF_XDP_ZC
 };
 
 #define ring_uses_large_buffer(ring) \
@@ -822,4 +827,11 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring);
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid);
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
+
 #endif /* _IGB_H_ */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 775c78df73fb..2c1e1d70bcf9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2929,9 +2929,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 
 static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
+	struct igb_adapter *adapter = netdev_priv(dev);
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return igb_xdp_setup(dev, xdp);
+	case XDP_SETUP_XSK_POOL:
+		return igb_xsk_pool_setup(adapter, xdp->xsk.pool,
+					  xdp->xsk.queue_id);
 	default:
 		return -EINVAL;
 	}
@@ -3058,6 +3063,7 @@ static const struct net_device_ops igb_netdev_ops = {
 	.ndo_setup_tc		= igb_setup_tc,
 	.ndo_bpf		= igb_xdp,
 	.ndo_xdp_xmit		= igb_xdp_xmit,
+	.ndo_xsk_wakeup         = igb_xsk_wakeup,
 };
 
 /**
@@ -4376,6 +4382,8 @@ void igb_configure_tx_ring(struct igb_adapter *adapter,
 	u64 tdba = ring->dma;
 	int reg_idx = ring->reg_idx;
 
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
+
 	wr32(E1000_TDLEN(reg_idx),
 	     ring->count * sizeof(union e1000_adv_tx_desc));
 	wr32(E1000_TDBAL(reg_idx),
@@ -4771,6 +4779,7 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
 	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					   MEM_TYPE_PAGE_SHARED, NULL));
+	ring->xsk_pool = igb_xsk_pool(adapter, ring);
 
 	/* disable the queue */
 	wr32(E1000_RXDCTL(reg_idx), 0);
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
new file mode 100644
index 000000000000..925bf97f7caa
--- /dev/null
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2018 Intel Corporation. */
+
+#include <linux/bpf_trace.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
+
+#include "e1000_hw.h"
+#include "igb.h"
+
+static int igb_realloc_rx_buffer_info(struct igb_ring *ring, bool pool_present)
+{
+	int size = pool_present ?
+		sizeof(*ring->rx_buffer_info_zc) * ring->count :
+		sizeof(*ring->rx_buffer_info) * ring->count;
+	void *buff_info = vmalloc(size);
+
+	if (!buff_info)
+		return -ENOMEM;
+
+	if (pool_present) {
+		vfree(ring->rx_buffer_info);
+		ring->rx_buffer_info = NULL;
+		ring->rx_buffer_info_zc = buff_info;
+	} else {
+		vfree(ring->rx_buffer_info_zc);
+		ring->rx_buffer_info_zc = NULL;
+		ring->rx_buffer_info = buff_info;
+	}
+
+	return 0;
+}
+
+static void igb_txrx_ring_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+	struct e1000_hw *hw = &adapter->hw;
+
+	set_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	wr32(E1000_TXDCTL(tx_ring->reg_idx), 0);
+	wr32(E1000_RXDCTL(rx_ring->reg_idx), 0);
+
+	/* Rx/Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
+	igb_clean_tx_ring(tx_ring);
+	igb_clean_rx_ring(rx_ring);
+
+	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
+	memset(&tx_ring->tx_stats, 0, sizeof(tx_ring->tx_stats));
+}
+
+static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring = adapter->tx_ring[qid];
+	struct igb_ring *rx_ring = adapter->rx_ring[qid];
+
+	igb_configure_tx_ring(adapter, tx_ring);
+	igb_configure_rx_ring(adapter, rx_ring);
+
+	clear_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags);
+
+	/* call igb_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
+
+	/* Rx/Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+}
+
+struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
+				   struct igb_ring *ring)
+{
+	int qid = ring->queue_index;
+
+	if (!igb_xdp_is_enabled(adapter) ||
+	    !test_bit(IGB_RING_FLAG_AF_XDP_ZC, &ring->flags))
+		return NULL;
+
+	return xsk_get_pool_from_qid(adapter->netdev, qid);
+}
+
+static int igb_xsk_pool_enable(struct igb_adapter *adapter,
+			       struct xsk_buff_pool *pool,
+			       u16 qid)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct igb_ring *tx_ring, *rx_ring;
+	bool if_running;
+	int err;
+
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (qid >= netdev->real_num_rx_queues ||
+	    qid >= netdev->real_num_tx_queues)
+		return -EINVAL;
+
+	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
+	if (err)
+		return err;
+
+	tx_ring = adapter->tx_ring[qid];
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+	set_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, true);
+		if (!err) {
+			igb_txrx_ring_enable(adapter, qid);
+			/* Kick start the NAPI context so that receiving will start */
+			err = igb_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
+		}
+
+		if (err) {
+			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+			clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+			xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
+{
+	struct igb_ring *tx_ring, *rx_ring;
+	struct xsk_buff_pool *pool;
+	bool if_running;
+	int err;
+
+	pool = xsk_get_pool_from_qid(adapter->netdev, qid);
+	if (!pool)
+		return -EINVAL;
+
+	tx_ring = adapter->tx_ring[qid];
+	rx_ring = adapter->rx_ring[qid];
+	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
+	if (if_running)
+		igb_txrx_ring_disable(adapter, qid);
+
+	xsk_pool_dma_unmap(pool, IGB_RX_DMA_ATTR);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+	clear_bit(IGB_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
+
+	if (if_running) {
+		err = igb_realloc_rx_buffer_info(rx_ring, false);
+		if (err)
+			return err;
+
+		igb_txrx_ring_enable(adapter, qid);
+	}
+
+	return 0;
+}
+
+int igb_xsk_pool_setup(struct igb_adapter *adapter,
+		       struct xsk_buff_pool *pool,
+		       u16 qid)
+{
+	return pool ? igb_xsk_pool_enable(adapter, pool, qid) :
+		igb_xsk_pool_disable(adapter, qid);
+}
+
+int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
+{
+	struct igb_adapter *adapter = netdev_priv(dev);
+	struct e1000_hw *hw = &adapter->hw;
+	struct igb_ring *ring;
+	u32 eics = 0;
+
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return -ENETDOWN;
+
+	if (!igb_xdp_is_enabled(adapter))
+		return -EINVAL;
+
+	if (qid >= adapter->num_tx_queues)
+		return -EINVAL;
+
+	ring = adapter->tx_ring[qid];
+
+	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &ring->flags))
+		return -ENETDOWN;
+
+	if (!ring->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&ring->q_vector->napi)) {
+		/* Cause software interrupt to ensure Rx ring is cleaned */
+		if (adapter->flags & IGB_FLAG_HAS_MSIX) {
+			eics |= ring->q_vector->eims_value;
+			wr32(E1000_EICS, eics);
+		} else {
+			wr32(E1000_ICS, E1000_ICS_RXDMT0);
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1


