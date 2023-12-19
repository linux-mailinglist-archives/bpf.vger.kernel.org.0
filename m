Return-Path: <bpf+bounces-18274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5B8185FB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00D11F25A80
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476215484;
	Tue, 19 Dec 2023 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2EYsxEJ"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2060.outbound.protection.outlook.com [40.107.247.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A121862F;
	Tue, 19 Dec 2023 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Zpu2Ji20UJv5QRLP1AuqTiylkdvg/IQEnLVvU2sfLemefeib1rqgwJgiDnmvKbrRAqXy0Amyq4l6N43mRZ1a5wGbxfPygtZDX/jJim0VVj394HVyMNLI6jcROFuDuCJlQMgMO8uooQ3nA8QYvseBVuIPS6LdLsNtcz2PyIf+ZFH5GWr/8FIcMd9Qpsm+UGCijmmsH+B8SV6vNxwvV4+UvyP1zVcwmJRRULnm0wUww12Oa4LEjcAF91+GuQnI4VL0CvVdS3HVYBid62X6/SFtkiDDwPbh7tUG+raB5eN7rVSykgXeLe0NYQbaXiu5eHy1MRv5W8kVVRGMmA9OZhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGmPW8MhjYS06UjczvfQLAARh9ju46JuP3AOalJpBEw=;
 b=H2SPHttlWIY3kHdcdEzy5uuRCXDxBA5D9FGuN7ZwhPjz9CFT/8ebCvFwB7qSO3zTlEYXg14eOgk/6hnm4bfpI2gL6H7rVh8bQdT7XPPVghhtEKPLVn//om3d/9MLWbqMmLhDue4wm2ZjBZyNiUto+7/NXM9gp0ecQoCoH8o5nIZ26VPqlDUHdadTj53idkWQ/fOo6O4Su+6KRSRECJbXdlfWML87E1CT8u8fjhUwL5Gv6rTuHEQYyNxBrIM/qF77Ks5nJsl23GHod170flE57GnemeodVfYOcPBQtOuM0cmkpbug8389cBDMoLa0d0C/hqmYtM2DSvaHKB7RkdS0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGmPW8MhjYS06UjczvfQLAARh9ju46JuP3AOalJpBEw=;
 b=h2EYsxEJdNFcO2bAoTd5e9xYiZGY47p/kyji6YicHAYE0yG9brXtWsVkbNNcdQpbaDk8thGJ+F/4IPB52zuNuDp3NhLsj04Lj+VmZDk5+CqENkpSfYapudrCCN4gHdgeaErO2yaFeOH0KDm+7n2jhRifQOeRaiU1A6PpaXq+cAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:02:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:02:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net-next] xsk: make struct xsk_cb_desc available outside CONFIG_XDP_SOCKETS
Date: Tue, 19 Dec 2023 13:02:05 +0200
Message-Id: <20231219110205.1289506-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:208:be::36) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 221647b1-c994-4b8d-7415-08dc0081fd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EfCch/Mrd48Bv3baO+66kITJHG+nk8TXZLDSFrvftWuHJgBw2uf+zwbgvxlHpAfjCx12qm55qymD1d5sC5Iv0ywd5Qme2lTcuehRuMHBpHRYKuoXAFSNk7WGNb9L8zf2mpvvKCRUrxI2fWcwfcdj0v71aLX1+xd4+nFlmrlrSEZ3wpdxrf2UP3Zl1aUToJZQkHTyTFB21ENcdzX2FDXvShSuunJ11Nq74ZtOytM7yFn3DO9LmRHPQ5Dlv8EOrGqbbwYH+1yJg0P+ynt9RXK1yJZmrGLa1XKH8Rx1sIE7gDjo+4mVtnMOGI39d6UySUp6Wf7GA+DyM53SSNzO2KZrdXVhAJaPY+fP72Lfha31QURMgyOT/3kn8JMNh5zbltz3FDSST1VGeYy4Otw7Cic6ysM+E5kqKmK7gUcn0Dy6opa2cnQ9ldy4LzlkP8KFnnAi1ELYGqwHxDv2PTSiwHwAKMxif33m4R/DHbsU3ycGNqQwDPY720WpRLYVKeKpJfESgzwA1vpKAhZ+x2j9qaAOMMuEesDeX0vksyBPgOIvm/Ti9PqOUyhcXniee2NR8yr6xBjX8hGM6+jTAa2VhtkVsM4vINPKbxtFaBfKUmHgBEI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(6916009)(66476007)(66556008)(966005)(2906002)(6666004)(54906003)(6512007)(6506007)(4326008)(8936002)(66946007)(316002)(8676002)(44832011)(7416002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zpFIn5TdmqYRwQx2VWZDwFa0z6o3TterblzuFOxE+QBpkJXuSCGCqQXem+uA?=
 =?us-ascii?Q?0nIOqa/H5jtwLg4N7BraDQmvlii55fdURFjih2AcZEDlvpXmMFZR67Kur3vW?=
 =?us-ascii?Q?bBa+my/GYROZMb0GsYHOQYzOAaOhtgiVq2j6zoQr1+el+spBrIrEFGBsrYso?=
 =?us-ascii?Q?/0jm78LZ3FD1DPx1Ma2xiZrz7MJc+pc+ietf+ga7GlJ7N9hikmVxC0Jrjb1y?=
 =?us-ascii?Q?IYsXqSAajys2LTYr2wyyPEYLMZrMFp13w55txXJaEGKcw559FPFauCYAjV1F?=
 =?us-ascii?Q?CJ3tgMiAHE9yttzta3AtXkagV2zxZYo/HGV+yxGNGqMiyprcAfmgRfhIo5mw?=
 =?us-ascii?Q?NYTjmaId50FrW1FlLi955NMJiNrejyIOorX4aZ3V+V6K14wkDtcpP3p1gTRr?=
 =?us-ascii?Q?JKam3WF+yaZnCptiA/k0ofSRQnsCLz4QxMDRMvEBBx99CjzNhBA5SLgEld9Y?=
 =?us-ascii?Q?2opMT/oONDgWAVrM6QwhiITJmm1bnbqZ07hXsCK+UmVBxJkY7FcyC2QyWU+D?=
 =?us-ascii?Q?zyTz2SyoHU4Q74GVc7pwO+XYbryViRYNOySud0CYGe9NNx43Ceb81Pl1dnr9?=
 =?us-ascii?Q?Le8YXVgkQ8s5sjeqyu/fG/hFWQVN+wmz9qPxaWaDvQoGyXOm0GhNpygFo22F?=
 =?us-ascii?Q?xSefX5RYKl6YG1opCWeAvlNwzTpTFAwDLU0I25kiYVz+8SHSHlwCm9Kc4NJ1?=
 =?us-ascii?Q?z9dK6IfzfcglVvq54A/FyyXXzyYrX3PDGe4Xi/I9T79t7hXsuqC17Y9kIeAk?=
 =?us-ascii?Q?4ZMydhv2tkYhbMw1zsfuKqPboVp0NhuQsAryAkE9r5ITDJ28JO9CjKJOTHxJ?=
 =?us-ascii?Q?zG9NTWhYpcJrZxCm9M6+VcPmPs1xc56JeJZGWZAZoRVAJnzNsG+FwuY0eGry?=
 =?us-ascii?Q?8huft9MrAlqrcC64kvmRMfNVZrc2Ieh21in+oXDZhXHNy5vFxFczes+sRTlI?=
 =?us-ascii?Q?ZVBITuyC5O+LUHPlb9AamzHdS+/KF7xMLxFjpW0x6fypFBodYTDhb77vmfVy?=
 =?us-ascii?Q?X1FEji538bH1j+DcKbL39siiJ+HOjsVZUoKEWYjBtFSfG3KGiFDibWhGiGo7?=
 =?us-ascii?Q?dPpd3jspOrZ7EcZcxLFE3zEyLM+cF+0WLHjiBJdxtUeI7x6Mol5BFG9PLYli?=
 =?us-ascii?Q?W4yKqKnybrxJZkQA5aDTbrSN4whX8VdR0S0SVuomDz4xbK6GWV+xj2EMGhPT?=
 =?us-ascii?Q?xtrAQ2ez59F7CzdJABQ3DSnrAjNhSmcQB2rwzhtgEYvSou6UodgjD52pGAfj?=
 =?us-ascii?Q?GNsWzTSLzrHQS+2SjCWBd2LkS59ZiDmdntuy2Eo73tyLr/NbhIPEGTUIDrmo?=
 =?us-ascii?Q?hgOBKbRCGMMlQFjx1r9L2dAZJd7hwkz83X6OnJa3U3rdPkz1fcCOFwxaKsjN?=
 =?us-ascii?Q?qYZ8ll1OTtBryP5buy9CI5txY+tdYHT49Gi+awv9/s9RyNOqLDYXRNoJHbgy?=
 =?us-ascii?Q?o1U3dsG+3pgj3aQzYPHXez6VC/xvxVufknzr2oo7AhTbqpMhS7/oZY0zxO02?=
 =?us-ascii?Q?j9HzCeFx34TQpZHnij8Q0aa3p+Y3OBYWNLCodo1sM2TUzTK7nb+L8S8Y0UpM?=
 =?us-ascii?Q?w4nRMRie+5mlNGg8ffbN8+p5eYP2it2pymbhgkF8LQ4hfLo/L/yui2nsOogz?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221647b1-c994-4b8d-7415-08dc0081fd34
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:02:28.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4OalOmGZHKAKuX+JCiE+Bn+v3OirmBVQdy+geYSeNdWZQxeBSe3W4sVX7g4fyYUrIGOKRrwYDuy6iiVQp1dCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

The ice driver fails to build when CONFIG_XDP_SOCKETS is disabled.

drivers/net/ethernet/intel/ice/ice_base.c:533:21: error:
variable has incomplete type 'struct xsk_cb_desc'
        struct xsk_cb_desc desc = {};
                           ^
include/net/xsk_buff_pool.h:15:8: note:
forward declaration of 'struct xsk_cb_desc'
struct xsk_cb_desc;
       ^

Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
Closes: https://lore.kernel.org/netdev/8b76dad3-8847-475b-aa17-613c9c978f7a@infradead.org/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Posting to net-next since this tree is broken at this stage, not only
bpf-next.

 include/net/xdp_sock_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index b62bb8525a5f..526c1e7f505e 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -12,14 +12,14 @@
 #define XDP_UMEM_MIN_CHUNK_SHIFT 11
 #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
 
-#ifdef CONFIG_XDP_SOCKETS
-
 struct xsk_cb_desc {
 	void *src;
 	u8 off;
 	u8 bytes;
 };
 
+#ifdef CONFIG_XDP_SOCKETS
+
 void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
 bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
 u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
-- 
2.34.1


