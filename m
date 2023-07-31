Return-Path: <bpf+bounces-6402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C6768D29
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD54281520
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB3468C;
	Mon, 31 Jul 2023 07:09:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1540211C;
	Mon, 31 Jul 2023 07:08:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28835AD;
	Mon, 31 Jul 2023 00:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3aCRPr5xb5YOBQm73y7cIG9i3SIz3l8Z8/1PcpjnTxL7IwOhzzhUcFV1hwh4snfC05jVSwQWBtJ5f2j+TcL9oxy7aOajCq2zGwPuGQp0dBXxTqpTJ9GLj9UpqcGr10PDyZFGRfxt3MnzoH25kYwPfkNJ6xOOViW4CHNJK850ydvlSfbg4ikAdt30PHYWlgYBy8E2HVaT5m2AI+n7iLAwabjbQzdX0jTAlCQj20kO37tFP40wQaTd/IJNysJwuYXLwAs8JoSmEVr9WuNjl8+xi//zsFu3TpuUy/yFNBNRZDSaZorud8gklnVLOf9vTTb0OGZ26Lr0JudQq3VECpyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TULw49U32vBH9B5ibYORbOWiuhznrPCO6FZe+GYJs8=;
 b=KWv3/Qwlm5yefFeWr7i0PUagqF2vBt7Kzu1cdCr4j/QciOAuRP8H6nKYLeU3C//a7odksvaHXPlwYLmK0rmelRtH3rR8mlGaZ0yKKZ5iKbbHHx1vK79OH4nqkepTW3JqgqFo3215FjpqNhLh679/1PjyOTychFiZojiXiUNqR3PBxZ8+4V910kUZxKbkEXecKFJVFyn0EO3g76RlQKZY4bZ66fxC1O6hdIbRL5Eg3lXOKGx6R+qSO5+oE672rD91Gn/sKJwPj5N067Z9YCLM8XsOYeVHLf9VYLh/p1SDMFe/kXE8SKt2cVOUA6gzkbAR0kpLLsEfTPpTf0YfGRLCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TULw49U32vBH9B5ibYORbOWiuhznrPCO6FZe+GYJs8=;
 b=BuQDZbm+cIAWZPJ8nWFYdipwZPKRRN6RrdF+v5fv6H1ABjvdExfo6qB7Hlj4EpnRrB4YZ9zXR4amArSn4OoMkzUEeQEPdI3faUsTRopnGRYpHG+/FbIa6o0361zpRuml3UaOjAh/XTCAxmOx19K0H6i5bfead1upWADrDl7q43iUvV7W0WdLJpNBVTgDp5LzMSiT4omvD5hh5WAmLV3xPiXxf4MRtjrYiwnhEDYQ4bBka2GPL5Sbrjpe0XZjIOShCwmCgDeSnBXTwKgL1XySDPptifZpK2k6fNC2T+bhKsbGiechHk5lJESW63HfFmR03KGPzk8IDhkfoMh/ZRpZTQ==
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 07:07:35 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2a) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42 via Frontend
 Transport; Mon, 31 Jul 2023 07:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43 via Frontend Transport; Mon, 31 Jul 2023 07:07:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 00:07:20 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 00:07:15 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V5 0/3] virtio_net: add per queue interrupt coalescing support
Date: Mon, 31 Jul 2023 10:06:53 +0300
Message-ID: <20230731070656.96411-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 507b8434-a2e0-4e29-4782-08db9194d0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AFtkd5W3fmMSMLjyfOs8w/igYpvAZDQe1yj4MTqpEpV2lUf4OZ/PN8n20f41q09yz5wqLDwHPYBvP9ZY2hYAgxxpRc/AEEja47LzpauViY/07xJir1iNpEebV7gikQaeeM+97vZgK2BK9oazUOug+Ir17SHSBAJRKFEreQwnImulIXcIemWdw32k9uKjYECHa+WVx3SRh1rUSXO2Z3pdyhjzwMTiI4Nr0Yyoizg52QRsa8nuPAnkkYxQrsIjAS5dYSil02Z+LjrzH3REt38FpAuJLmSkhZhkiHG419lT9F0yldzImme93GRXvqvLKeCQtGu6KFryCPp4kNnuGxfF+4rDUgLZjxr2le5vR7qJiRtsZWwGCX7LXWE33obxrHqp3xS4J5nxxEHlLdXDmiPARdnf4z9GwRdQh8RZ4mku2jTLR0HGIRmfISB4m3X4k0MVaJ1+vYQ6+cwhQ1LE3YTJcNc4y+Zb2Re8iCu+oK6pEU8rC4Ur99bCAvWh8dTU8cqg14ioP5ptCc1xuZgSkvdtsVXTuI3WHzGVJCcwIKNhtqoBL0MBKhgQl98zM3l4C7G8jRwQBIzyiqAmZ+uPAOLDKpGtM/64VX9Westt7hJPpIexF/TFlnQy3gH0xThuHlrl670LolVQRIWCBYdsFHm3xUMtCF0FjKkwepfvt4uXy0KE/pHSeJXtLmyfWk4Kfq/O/ZWjnGtKNxnUMUO2/H9W5ZdBWM3hos0RnAE64OGodm+2q8lLYiVfcWVwXrnSZCCwIPl0/A8YpJgcLUDDwe3FGw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(356005)(7636003)(921005)(82740400003)(55016003)(40480700001)(86362001)(36756003)(478600001)(7696005)(6666004)(16526019)(2616005)(6286002)(336012)(186003)(1076003)(26005)(8676002)(8936002)(7416002)(5660300002)(70586007)(6636002)(4326008)(70206006)(2906002)(54906003)(110136005)(41300700001)(316002)(36860700001)(426003)(83380400001)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:07:34.6748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507b8434-a2e0-4e29-4782-08db9194d0d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, coalescing parameters are grouped for all transmit and receive
virtqueues. This patch series add support to set or get the parameters for
a specified virtqueue.

When the traffic between virtqueues is unbalanced, for example, one virtqueue
is busy and another virtqueue is idle, then it will be very useful to
control coalescing parameters at the virtqueue granularity.

Example command:
$ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
Would set max_packets=10 to VQ 1.
$ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
Would set max_packets=10 to VQ 0.
$ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
 Queue: 0
 Adaptive RX: off  TX: off
 stats-block-usecs: 0
 sample-interval: 0
 pkt-rate-low: 0
 pkt-rate-high: 0

 rx-usecs: 222
 rx-frames: 0
 rx-usecs-irq: 0
 rx-frames-irq: 256

 tx-usecs: 222
 tx-frames: 0
 tx-usecs-irq: 0
 tx-frames-irq: 256

 rx-usecs-low: 0
 rx-frame-low: 0
 tx-usecs-low: 0
 tx-frame-low: 0

 rx-usecs-high: 0
 rx-frame-high: 0
 tx-usecs-high: 0
 tx-frame-high: 0

Gavin Li (3):
  virtio_net: extract interrupt coalescing settings to a structure
  virtio_net: support per queue interrupt coalesce command
---
changelog:
v1->v2
- Addressed the comment from Xuan Zhuo
- Allocate memory from heap instead of using stack memory for control vq
	messages
v2->v3
- Addressed the comment from Heng Qi
- Use control_buf for control vq messages
v3->v4
- Addressed the comment from Michael S. Tsirkin
- Refactor set_coalesce of both per queue and global config that were
	littered with if/else branches
v4->v5
- Addressed the comment From Paolo Abeni
- Update comment for the range of queues to be updated according to
	current code
---
  virtio_net: enable per queue interrupt coalesce feature

 drivers/net/virtio_net.c        | 187 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 177 insertions(+), 24 deletions(-)

-- 
2.39.1


