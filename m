Return-Path: <bpf+bounces-4588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C174D297
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90391C209FF
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59C111BB;
	Mon, 10 Jul 2023 10:00:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EA11198;
	Mon, 10 Jul 2023 10:00:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB901738;
	Mon, 10 Jul 2023 02:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcy9u7UJpcw1Wcc8AYztjwbq04at+4bQFWdfcJTa1IYukGAV8pEhVSgNVD9iW19u54h+zXO0z1VeO/tmQ7ZNehwJhCqkSrJapVBPyzCY1CiTVtuDlgsAT0dH/hVFMHf7TLMiV/0/TZd+VoMfeG0Qlqt1q3S5xFziNX/U6saj6e1vtRKz1IXj6h7Q27eUqcmbVNPLDiRrd9VQRTHISh8kCP07qNAMEhobfQ2o/tDQGGnEbu6DCkQzGsDO2K68nAkrc2MhO21Y/l+gaBpY4HkGL/l1D2RLL30yh5+3DFNSrWheiH1F4Lo8/Ut/tlfuJ+KIt7Y3gmf5uILzrB64Oigi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0oHsOuXgvTMjpbxKtqjrGPAMf2I/9i3elpw5czoUwE=;
 b=YHkUWHC82zNvHxVBG/0IMvfr+Y5lmf6gAg/A3japYniUF/b+wXHPX01KDxgDYeRQQvQNC9mkairnBi+6mq5Gwm7vY2ElzL6R6CbCc5YGq6dqPTws8uL5mPpy4hBOOb+O00s67g3l5E4ae7Mx/iws5rA/9O5DoClayCbltjQTokV/dRNbfL/WmPc9FFOPNG54yl/TZdE39viUknIA55IWoG4ooQfAaEuCkPJqBXKsWpZ5/OOCs1pC8Ty0OLAgrxjq2hFpwBx1XhLwijnq+AvX89zKI+ul5FFqCZXl8PyrzUQ3j+JD/gK/fjawkuo/2LChTV1KFrPgzO0C9LtXWN2gzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0oHsOuXgvTMjpbxKtqjrGPAMf2I/9i3elpw5czoUwE=;
 b=nBF++mE5KTaUyulgXHjJ3gfyrnm8Xzr4309190Dv/bTtV3aCrKaeUNeFmiwdXtBzELbvof/87EgQExxsR8LOqJPS1uTAR5dRjoq/dzPqcJag89hMpVzr0yXvM4ZA87ojB/z69exyfoZqXdJTy+QyPKJs9ubA3bdfYuP7cFNVphmZUAU6SKLT1k8KnDX0uCdjsXRaeD0Z3K6FnByp7cfdzYtQhICxNE2gBDrWVVnBhnWPDFsks+ZCdjOSko8Mij0v+3o1yg04ioJichkQDJ29nsaKdVGWEjjDjEKdgyjrnCsNLhkoDtHGAMAsKXSNY5ZkQWO2fkHd5U42T7l/xSVdOw==
Received: from DM6PR02CA0113.namprd02.prod.outlook.com (2603:10b6:5:1b4::15)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 09:59:41 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::9f) by DM6PR02CA0113.outlook.office365.com
 (2603:10b6:5:1b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 09:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 09:59:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 02:59:28 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 02:59:24 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <jiri@nvidia.com>,
	<dtatulea@nvidia.com>
CC: <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RESEND PATCH net-next-mlx5 V1 4/4] virtio_net: enable per queue interrupt coalesce feature
Date: Mon, 10 Jul 2023 12:58:50 +0300
Message-ID: <20230710095850.2853-5-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710095850.2853-1-gavinl@nvidia.com>
References: <20230710095850.2853-1-gavinl@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: d53efa6a-d020-429a-f737-08db812c6110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JbT08VsOq4mFyX9jfxHQ25yNawu71OEfVbEXK6WbjFJRoOdTyr3tahV5ES8B9tKI4wtBwXynC27usQDGWZZsnxQYiDorIDeS+78wcAe5WZqGa7VSw2vf+Wi5IFEJEiMBOnCtpV9lz4pcn8wxf0S4faNgnEfUVZPJdPJ9W88YWL1CIGuUHgnO6Or7shE2NXrt6ZdhfHNG9YFu1CDNPhT7JmPPk+SEKJ+8a3iI7Fmz1OfP72V0uK7ftutONw7vJu+b/rpBEKkcAPnD9+pDRTqjYrUJvHRnJtvjUwn3mMcRPhVfUikicmCdEQifUw1A0I2JF4/CCfLPJdQt6RX+VARTwXx4ATNm4WCrw7r4g0TDN+0ixz6fGY0wngcUVDDha1ow80x9/cxHTWwKEAZ8oiFj2L1zmMV6ytsdLYRYW/IMEzV8XjwyW8Ng+090YUG17Ah32anGlog264KCW7g3z03FJjq47H+du3XCI4S/J69eNEEk58ad9nIEmNsGZfrMFrYMwUVVWgfAZ3uaoLFinKma+n2rt+v/Q3r/VqsuyzxGmffPEtuJrlVBAXnftpk9zzkcHkC4fkHfnEr0UnMo0h2n5MwNx8OVXxGNgJwWAgkJ8r9ps7AJ4XnUXeWAytC0+TUzXtJG6JgmPvLRguZB12ZJd25iDy5E1l7O9Ee8rtYEGy8JfLKDtl76wV30noMW4GfZz6dT/GYT9QIfRJCYh03zDpd1tYnQMHJT2akDgLYonjVvajWwZu2dcS42xxQQd5g/Um6nyMDak1yLumygzeaeQ520KeRHpVoiAFabywSNB6Yp0BshHiA5wvUXHAd4ejci
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(7416002)(5660300002)(8676002)(70586007)(70206006)(8936002)(2906002)(316002)(6636002)(4326008)(54906003)(6666004)(7696005)(1076003)(26005)(47076005)(186003)(16526019)(83380400001)(6286002)(41300700001)(2616005)(336012)(426003)(36860700001)(40460700003)(478600001)(110136005)(82740400003)(921005)(356005)(7636003)(82310400005)(36756003)(55016003)(86362001)(40480700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:40.8540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53efa6a-d020-429a-f737-08db812c6110
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable per queue interrupt coalesce feature bit in driver and validate its
dependency with control queue.

Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 333a38e1941f..81bac3597a2b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4060,6 +4060,8 @@ static bool virtnet_validate_features(struct virtio_device *vdev)
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_HASH_REPORT,
 			     "VIRTIO_NET_F_CTRL_VQ") ||
 	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_NOTF_COAL,
+			     "VIRTIO_NET_F_CTRL_VQ") ||
+	     VIRTNET_FAIL_ON(vdev, VIRTIO_NET_F_VQ_NOTF_COAL,
 			     "VIRTIO_NET_F_CTRL_VQ"))) {
 		return false;
 	}
@@ -4484,6 +4486,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
 	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
 	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
+	VIRTIO_NET_F_VQ_NOTF_COAL, \
 	VIRTIO_NET_F_GUEST_HDRLEN
 
 static unsigned int features[] = {
-- 
2.39.1


