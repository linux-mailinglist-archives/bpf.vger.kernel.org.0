Return-Path: <bpf+bounces-5696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8175EA23
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6905A1C209DA
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528C10E4;
	Mon, 24 Jul 2023 03:41:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F9A44;
	Mon, 24 Jul 2023 03:41:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF216191;
	Sun, 23 Jul 2023 20:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1/2E61IhGEs7dyuvkDt7R0Cd11G0mQ1u+ZekuqX7ugoKSbk+E2Qr7sfFY1KVc9fBeGnjj1k1zF/J+vC+97am7yy+cpcSGFGzsMCaF5im47MzPdD7meMAipfkjmGC6Di3EQz36lH8f4F7XuvZ3VZJR6g2ZkC3/ZQFYxq4xB9JzlgODxtQ89NwmGNUwA6V+IrkdZMb2lXrEfzGKjcZwMISzodei+Wlf/8PMLTRewdfjJckQCMWnJrZQG5XMmF0CdLXNd4gBLLoz9Lfl6qtMm5p2Doa9ssFcU2QAfWvQiXZYNa2XzUr2d5zxeHduf/6hOoK6oAsLfgECTLG4a3zW2OuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TukpwDkspVzbKAYx1mKpALHfem9avZFKyvq4puhxA74=;
 b=iiKcHtXGzKy+JE906YGUVAkUJ7GMyoABsD13EifDOQAnJtPirBqykPmJw1YvRNH5J5QllUZ+r7vN8E5yBCdTfxgi6RuhPChLIz7aHVfWpZuUckclZqsydBob4dNMef3DX4TfAJ2wu47NvQjfupTGPBAd9VWFYg4MqxtAC23jIT+5twtNajzkQMlviZutyCY7pV+Xgm/Czan7PloeR+/udMlSgUtiUnpRQvRKSzXAB4WFLoUdFhzrIh10wwVOlafFxAr6vFP9pZNbYxKyFukxbBHmv22rPSRM1e9c7qJ5ChGml3TptYyT+tH1CrDR5yroIV8BWguOlZoJuOifW+dJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TukpwDkspVzbKAYx1mKpALHfem9avZFKyvq4puhxA74=;
 b=ivKKLyGEVfRmrvA1mOJduJ6ZXPJpHnd/w92llVGobmJw8N9FOQ4mIKr5H9oLdI/NR49giJCdvyU1BTINAqjZu+iv85/3jXuV2XsKwAsq645tCm91WTiwbGeF9MKy6GvbhvRCR6ouqjiBdihF70Wx5ypZ2ApHQZjQrSa9p/A5QTRBQ4doe0IvfIi+FD5N1MXlVbnMsirvuan41AtIojyJbHdo0OOZmAXu30TQs0gKsaYrCNEY4W/zrakmGzdHSV7MM8BklJJuy5D5Rhxdgu0IXRVBpH964/JjQ2Bj5VGPDU5vF9WM70Qt0GTvbdWlJKyRldczJzpeooPst2MRbg6ILA==
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 03:41:29 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::1f) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 03:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Mon, 24 Jul 2023 03:41:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 20:41:16 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 20:41:11 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V3 0/4] virtio_net: add per queue interrupt coalescing support
Date: Mon, 24 Jul 2023 06:40:44 +0300
Message-ID: <20230724034048.51482-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: fe122a90-8f56-4ba4-2210-08db8bf7ddbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Autz09lFlj9MlzVIZSbzA1Jsl6N8arUC/46s/iu5yqwbc6zyjJ+LcqOQFaGqM22arKaqJm8e7gcFrtJ762XKO4UmyukOs1WDtz5NrktdFSSWfUo6Z0Ym5DCa1vOSCoJbT7eEkvjHlea7LFZmEfg/I5ALSD54pd//OhrYrUTULIIAWjjfu1eMhFkOaRy1nwioEml08YBQT7BlwiPH4nfYR+qADkJvjG+i7YhPPrtK34r+ugIVocB2YUiX4xvW2SRKmmAul+TVefTSzeyNgZsZ+ITihQb/ncHf7Nj1VVAAWdGNJPwd4I/6t0GTDPvqn+UvLZ4RaT9LqkQz2dlRwlE9+Q8znX3EgBFUiP423T9VbWJuRO0S2xCh932ooLJgBb5iv+KF0rXI5UO3Vm8WpfZs4xzfsNjgm0vOtkQ49NdQ/pRziamMXo31V//Wdjt5nJ0m/XW5AwMFNgl9L/E7rXpcLzAqgEkEnNs/1NeWiryodHfYXm7PIgnkl7FXSVDqTHq9J/cPsXiT/Mht7G/D3FlAJO9SD2kgh7mECt0iHI3Y2HSqkoKhG2O6iFGPVFxtvGP94tO8vofCwRuP+SSkKKEw6Rjwv48y3I06sfMCVhpzz9D5OTtnUBjYhHSgxoODOCXuLY5awlO5txIS62CPgCXNz91HaUgT28QyA81oEYFKIFkjW+LbG65G77aWt36WhbOS5uv6YCNyB6XkZm75RUoWw8Z1GVcRKvBmcpOQzYFng2NdYEfEHet/Ir4E/j0oEpqzbY1v6pah4+ALDeALNwhEWGLiw/wVTW8gG09NBHstEtb5pYpAOoFvUOx4hpFaTbM7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(8676002)(8936002)(110136005)(7416002)(478600001)(40480700001)(2906002)(40460700003)(70586007)(70206006)(4326008)(6636002)(316002)(41300700001)(55016003)(5660300002)(54906003)(36756003)(82740400003)(6286002)(1076003)(16526019)(336012)(186003)(86362001)(26005)(47076005)(2616005)(426003)(7636003)(356005)(921005)(7696005)(6666004)(36860700001)(83380400001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 03:41:29.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe122a90-8f56-4ba4-2210-08db8bf7ddbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
	messages
v2->v3
- Addressed the comment from Heng Qi
- Use control_buf for control vq messages
---
  virtio_net: enable per queue interrupt coalesce feature

 drivers/net/virtio_net.c        | 172 ++++++++++++++++++++++++++------
 include/uapi/linux/virtio_net.h |  14 +++
 2 files changed, 157 insertions(+), 29 deletions(-)

-- 
2.39.1


