Return-Path: <bpf+bounces-5095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEC75667A
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375991C208E5
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F1171B9;
	Mon, 17 Jul 2023 14:31:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B3D2EB;
	Mon, 17 Jul 2023 14:31:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61C19A9;
	Mon, 17 Jul 2023 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehPbu+nIkrHFUEpbCVWV4e2gWphnInTlTTZOTPsZ89O3tMBPYEUfHWqmzJG26YkmqWqFIgxB5T/LrMvblGPTDt306yR7AeEk9SaQcFH/LOxyeTxNFW1awIZ98faPOVa+mYewfgMWhbo0u+NtYdXbrwCT7mSAh81WqNALRn8yuMHaOYevuY7SxfDUoOgu/P8eflsS+GIpftemvC+LMCHcxGZ2DytlWnwJ0dq/i10L5Lj2cVa0scbHpz6QBWloTbSzUigv4Ja1PhhVs63cBjwx/7Yd2XrEMlKAKOlI72S5p+jDSv4ppjxi5D3r7zxW1Ql1vu0bahkhtp9wKVol59f6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmThAU2YAJOzFnTrzw7PawSekE5lC5HJVtIHKCP6/YM=;
 b=nmroQyDvqgG6Ebm+uaW6Xa1cDAsYMmQFjnv5as9sbK391aXbNTCW8Hul/xR426RZQuMpJvRp5QCGW5DtnsRv64AuKQc3RFh7dmIHJzNNBJ0JORHmW4xNH65neSR+qQMXWBomjb6dTdhloM7WA+XKce3mRwl/cwvFecSLE7A0orCSgqoawU4viykcfpcXna0ATWx8zLstoX3+sX/+2y6rOrebDVz8I4+9N7SGGX9AMK7qrX8ZFGqd7F8b1jdhFy1EHibyunEdWXo4DnIUYKNQb5Wd/fkUzAfcRPvJjirQMu/Y8hQpRBBwvoYIStoeXgtdQx6zLcW3HCn1womCINpdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmThAU2YAJOzFnTrzw7PawSekE5lC5HJVtIHKCP6/YM=;
 b=N2uBzeogGTRDU6PHqGavQ4Yu2LyVBCZM+71gNXw6SOZwVVSJoX7REUa5s6/MsStcBmEZhOaAViLuy+T8xKpJVYpJruxdkJk5lP8mNHf6tNTDC7XBSGw6yzKOnoDdOhEc4/PcVfAp7KT0T1bOGgEEKJ7zuInKZsy2MfYJvOxFpvTve/Cr85HbMB39zcY6DhXhlDVqqITzLu68nba2D4tKnvlydp8/YjRtBc+zNr/DTWWTgUBSMPcWT/qOPo6rRnGHp4ga6YJ8+WYrW1daNyXOxNbShFvznoCAEN1YRKYq+jf7Tgx7/qaDKC81+fmvso29VmAFEPihB4IgkODAeoysrw==
Received: from MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:31:42 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::ee) by MW3PR05CA0017.outlook.office365.com
 (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.22 via Frontend
 Transport; Mon, 17 Jul 2023 14:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 14:31:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Jul 2023
 07:31:29 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Jul
 2023 07:31:24 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <gavi@nvidia.com>, <virtualization@lists.linux-foundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next V2 4/4] virtio_net: enable per queue interrupt coalesce feature
Date: Mon, 17 Jul 2023 17:30:37 +0300
Message-ID: <20230717143037.21858-5-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717143037.21858-1-gavinl@nvidia.com>
References: <20230717143037.21858-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|BN9PR12MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: a896d7df-6c00-4baf-9c77-08db86d289b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C5PKW1rwcysZJ7ek+aZ3FdTdSlaNAsJI0F4gtYXr4ab6Q3slmTWsSukyPkM0oGBwDj0H9HIiZjXxtlrOhpLea1PhIqcErsRyhnO3suaIWxP5QNXhMkpf+ymx7W0Cw87+DjUKJ/E1ceNiA5MMmg91wom9hWrVIGoPyPeMpYGWfvs1l6nIsOdi69w2dg1Sa6i8RXoqFnC8MOH/dgbWFYnZP1mjds60HiH+aacu7VY/cUSTQrN+DKT2WJVUcuGzHt23kAGU6Nisjtaf0Ibs3HVQm2kIb8kIEx3L+Zt51u8pth5dFE0RtY5btbOtl/jwmaakd39J1Wi6UYlpFYwgOXaeSD+uZ2TGI9mEt3OAWsDqO80qJBHUkmJwqXBgDhKsrKgvoCZYNDKxGFndOUWvc3CxtkZVnnyHzv8VEBl+oK4XxUUr5YvxMxHo0L19o6S+ULfxKcUQ6cxF4/hWEenhyNyUguNIOEUO/XRRJnyLEsQczDn08K/UeiG6QT3vVAGl60atbifVc4vcBq3lnBGvLjnNga1E49oUdf4PIDMXSYM3NIHKes7yLxfs3dHruX3VLWSwgObt7faS82Is4ETGb/OcBVoGkWMosE6YySuwFjFrzoaNiPI97BDVJKMjEHejdfRB8k2s8T3A7rZzOZvQS/cVB5ZCj2vxscp3NeVFnYvy4Q1I+TDKfwZ6UsnRGfxcSMciqMV6fkq1dqrPWaSFHvv32ShnYV1QUmfbtXmJ2DPs1tCNyx6gNFvBH9dcjqSzjUFdZeVddojZoN1Un4wnMTOMwtadkA3SUGyJIiFGOCRw1kWsbs0JIqgOobZCUo7pdaJ2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(478600001)(70586007)(70206006)(54906003)(5660300002)(4326008)(7416002)(6636002)(316002)(8936002)(55016003)(2906002)(40480700001)(41300700001)(8676002)(6666004)(110136005)(1076003)(26005)(40460700003)(7696005)(356005)(82740400003)(6286002)(7636003)(186003)(16526019)(921005)(2616005)(336012)(47076005)(426003)(83380400001)(36756003)(36860700001)(86362001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:31:41.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a896d7df-6c00-4baf-9c77-08db86d289b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1566c7de9436..6d9de7c74961 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4066,6 +4066,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_NOTF_COAL,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_VQ_NOTF_COAL,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -4490,6 +4492,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
-- 
2.39.1


