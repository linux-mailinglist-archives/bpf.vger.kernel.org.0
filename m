Return-Path: <bpf+bounces-5091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D130756664
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0916D281380
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43373BA53;
	Mon, 17 Jul 2023 14:31:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D87BE50;
	Mon, 17 Jul 2023 14:31:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E1E72;
	Mon, 17 Jul 2023 07:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX8q9Sp4uSsMyD0WNZOsWaHEFBhr+YOcnu7lgyPIGF4fZ1nf78zOGeXb1TeESSvX1lbmkwYI+nBnEVgAF5iUk6T7dlwcd+Wc7BajzahzFwWH8k5uJQUzdSwgHZwla3pha9NnCd4rlhZQUzFHivXSVTcvzBbSeuObIg2sq62JIimVjLHqjknTPasbW39KA5+CBw+tmJ3FbW0sSRiiVfHnlMpJq5O3pjQnMgDl/SnCvr0LxoS4oorVfCyMA4d9J+0a+/XcTMZ4ECFA3MkGq/4P4h86wry6BxmkF0EeSI10P7zcFP9PeBlvbJ07Lrmzym59qMIOee9WnsdpztnZeMspXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ESNNOEfFU8j6J6zi2N+8dgKHJGgR5Yt3xKros6d2gQ=;
 b=nwGwCRq8p39RLs/j1dhYS07BkFfwaISon8eFKUG1Z6eJfKre8hSApv9hpsg5RElWpIUmY+8BUUNObGesyNnPCNWgJQGg3d8evQpfY++lviLZPVh+iK3EzcSvgF8BA5YRjTh/aXpeNywLSJBkT+nhSLPZRHNnSqh+KtNdrXRuToGVFc0OcJx4DrNltqyMiAWmE0HtOQF47oQqS2s7VWyoAs0dq3CLLQ32XZJHfm4CiLXiSw4rKH/ogOQ92U/zRIYz5c0FkqjnR0DiHCwEhk4AmfQNxuqiSwVAmxtlyM1esftkxo5Z+n3x7k8tCZFXl7yn6mgV3LmQy0MgNK5ZEmaoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ESNNOEfFU8j6J6zi2N+8dgKHJGgR5Yt3xKros6d2gQ=;
 b=jek+Trfc1jSqpde9GjEQI5MxOxdMkYz13qAxI9u+almPpmSrUs+dyZJqOZ46INylXmf82crZRuPlfiKqKcsc1vjtpQUpL1leGeVyXqeKSDru6rqUQXgSbzKz/FvBZ+UG4eH0eSgvvfdeIBrzCMk7X8/TPJRVuLd2ukw0Fuxbc/qdGFhz5o7oRjsa9yHlahyewnIRCDa/w9Nl7tl+CLxtS0TOObdlOblVWCQvHRh8NfqCQupxPxO4GaJxMniedDTKloztCsBSLRxfciLt402o7//vH7m6lBvn/3odtOW6UK4VOjntshmvUKOpD8jZcmEdMkuPJu+ZqQFodPSSOSWiEQ==
Received: from BYAPR02CA0016.namprd02.prod.outlook.com (2603:10b6:a02:ee::29)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 14:31:23 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:ee:cafe::eb) by BYAPR02CA0016.outlook.office365.com
 (2603:10b6:a02:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 14:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 14:31:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 07:31:09 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 07:31:04 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V2 0/4] virtio_net: add per queue interrupt coalescing support
Date: Mon, 17 Jul 2023 17:30:33 +0300
Message-ID: <20230717143037.21858-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|BL1PR12MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 717b4257-0bca-485f-4af6-08db86d27eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HiBDDVDnRFZdMaB6F0tuUSh5ZkIaaJQ2Au8ERdfknDSnSK4pUXWhsITh6fPRO9+VhBtyJYhRHchv2jVLZXhLIcanxVia9H+Zylr2rEIzTGcbj70rQSMJA92O7PAgFJq6Uz9lVTTHaC5RP7c3XhGDxjTcLPSABRkKGtRMc3zksAxSPsXwDJOMuDH6mnhH9i9O94YenExlccETHiDSkkbp91YGuZt48COm/G8hqFlLRlvTbI4/9MytJzAE3egO2+hXwWEWGm/wZFw0Tp3uqwRU1LpQgpGf7uG96KJp5eQdtDcKFM1IkGqrl3SQ2/x5V4UNaaXXLUYGSgyth+/TFw9ZZWVx3lXCYEGUOsU7xIklDHh9KfK+F08uPbj1pdkk17NN/ESAfEAoTHzqOjHQLoIGdlgqibaJGePfHxpyhAAhSpmylDMr5s/0yjKNINPe6iOSXr6rIfT+AF6/R5+YXs1aPD+42MPbooPyLIThNT4l5c1Ng0sWIC01zsIX84oB4Ks7oE6U/SWiWD1Fhdg5aadHEBZwmrAfaqihz1F+PmlG/A4/x+IMgJlFJuBuK92QWV6vEISlCWvGFk9LFaZBvswJahfCKPItoDcKlJvsQuikN9znqUo3903IsdCvGWEiTES1MIe5tTo5R19NhUlP9wzTrDnkwfX5m77SIdsE2Hywv0eJ9Y4zIWaO+zLfyjfLig7LywEdO+XvD7wrzEY9KDHoG+FF0+dAWv54OT1kzqBR4ccV3Vv5PWXl9cF8GpCDzB2c0IpaQYjjst5wIPAH8JPUG4gg28pfdREzKDj3A6xbuwFrzeec/orYlHdvqyKZ9Z1h
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(7416002)(40460700003)(55016003)(40480700001)(186003)(6286002)(16526019)(336012)(36860700001)(83380400001)(426003)(47076005)(1076003)(26005)(82740400003)(921005)(356005)(7636003)(70206006)(6666004)(7696005)(54906003)(110136005)(70586007)(6636002)(316002)(2616005)(4326008)(5660300002)(478600001)(41300700001)(8936002)(8676002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:31:22.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 717b4257-0bca-485f-4af6-08db86d27eb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

Gavin Li (4):
  virtio_net: extract interrupt coalescing settings to a structure
  virtio_net: extract get/set interrupt coalesce to a function
  virtio_net: support per queue interrupt coalesce command
---
changelog:
v1->v2
- Addressed the comment from Xuan Zhuo
- Allocate memory from heap instead of using stack memory for control vq
	message
---
  virtio_net: enable per queue interrupt coalesce feature

 drivers/net/virtio_net.c        | 175 ++++++++++++++++++++++++++------
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 160 insertions(+), 29 deletions(-)

-- 
2.39.1


