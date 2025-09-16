Return-Path: <bpf+bounces-68516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53173B5994B
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD033A7782
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239434F492;
	Tue, 16 Sep 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fl+yD1ar"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BF34DCF2;
	Tue, 16 Sep 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032006; cv=fail; b=s9YPmTRNoduM/J++Wrx2zzi3GGDA8pEDO7fl/WuoZzzK9+k0v+kDT1oF3x2p+AK4HApe/A0keuPbXpwePAyG8sk1yWXI6pMd+aRb1+8VqfiNn9djR6KkL/t+nO0xRSliyz7rnXR8SYpacmvTs1RFFyXhwYT4KokWjTuQJ+XfWKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032006; c=relaxed/simple;
	bh=fVPLugubNkZ8WBxNdinW7aSMQwLrb3lEEOyXIy6qDPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNFrSuJDuy6UcPF52VE5XteJkFhsbnLYgTUtSFHZPp1cdvDhoDeez7x0/eAdt6WWnwWF/SY/oyWHpERPgI8ifOvEW2lY7gDoi8OHjhFx22V6Z1zaZugktzdtf7gFuhzigyk/7sUG8lZ4DGNW0lOy5GYb7I/4jayIQ8MHaXjj8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fl+yD1ar; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqeq/86eV+pXn/B19noMxJWAej05Lsv1yZrdraLu56Fsmk/Y7FzlPNu9rZmPFlJCoigcxQfag9mADR+U33iMYbmgdf8rGvNqyxzgsHPxP0XnHftcUTcf/jZYzPfeBouyQvVlmE2RE+HeTcADccEJ2aOwHhlcuN6Pnffv6fNnYhjSlriECTo5XY/4Q1KdAsoILfzGJuP4ZLi8zNLnp9FczahA4cQ3u6q5SuA2yspi3HUxOnhGvotPb9Mpy83xi3mdPRyZuM8OzpHyuY5Su2r1YOhG/u9YQ/SrBUutH17Y1bPpXQEvCtFJr4CnNrKXwK3PsWU16ny5QXCMPqyAwFcG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot0hPtS9oCQ4MvSoxsQcG1ll2sRlOFD5O3gIcuv1rLM=;
 b=OcdWBjLpaaO4T4bxaLZwN1+iin82H0HAcA02NTV4ZHtAr/6aqi9Fds3uog4Ji8uhEm6sL74EADwhQ46nLJLAPWyOwmVMO6lJApaTVxTcyW6/D4c61s3Hkm0CxxSvmbUyovqDpXLF9/QWDjVRek9yQvypQTs/RidlmNAEeWcgatEyt6nZazk9h6SpeUxTtKA+8We97eleOMWkbqZZGnP2vzSTFijw2GDUa3CcojMGzdLp9HJruCZYhnlnrHjS4ugNMj9YY/58zXG2obWJUjbdhydSkN4phQCiHMTSL64L9TvB1mUjO2W0XKVYf1z8QoG7HLha/RmKhzqUwL6J1CFAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot0hPtS9oCQ4MvSoxsQcG1ll2sRlOFD5O3gIcuv1rLM=;
 b=Fl+yD1arpjhFT7SGTPOYmE85v+ypAr3Soq9sheaDCIgZ9eTKTpBzUThU4JAIv+C9OcoW2g+9exgLtharKE8TqVG8tREv8WU582znSv0L22Li7uJox/w47R6N8E6sZweQFkomLzYr097XggxTQY7uL7YjysMhDtj/G8PDL0S9K4ciB8lDWSeuZpGblL8dMiMqhDu1TRz6+EOwhIY50f+m+/DybAP9TtgviyvF/HgYrXtMbr2xkVjP9oCtZEqkKo69j3n3Z1EDPmzefWiaZzUzKwc7/1gNlv6qj2a20BbP1+ChxDqKy75qsbTXJc4fOxiXo6D+dQapFT529C2HG2WLHw==
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:20 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::4) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 14:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 14:13:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 07:13:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 07:13:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Leon
 Romanovsky" <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH net-next V2 09/10] devlink: Add a 'num_doorbells' driverinit param
Date: Tue, 16 Sep 2025 17:11:43 +0300
Message-ID: <1758031904-634231-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: a3450aaf-1f69-4063-3f52-08ddf52b305e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACTnZJQyVpoSRNH2cnJXwcGaR5o8pBgVCqSTke7Lr+/W+eEJ+RJHtDpV/PFJ?=
 =?us-ascii?Q?K6T4ieu13R0n59Q1y/paC4Gw5QwCFJEcshZ7GZkq2cGuB2ezkTuPNBAb9V/7?=
 =?us-ascii?Q?DeXoCwSgL5+WeI8wVTKX2NsiOQ821JBQ9tGTFyPFVrVjHU3N5ztK7WpE9A1E?=
 =?us-ascii?Q?bqrNzrWIDtxNPjG8Ep6UcIqYtRROmlzGbRrALEV6TATzFlg4tRl0WuLf3zlb?=
 =?us-ascii?Q?Fm8C0XPtdgK0m56noGTmB/hNWC6izkybU0BoqhJIlJsARwc5jhx2KjFwz/BM?=
 =?us-ascii?Q?AcsPlgrwB4Bx/Rna4FVKEF6r6hatSKHdcGrwSsOxCcNJzbNEvU1gAWwp48eK?=
 =?us-ascii?Q?6ZQr7YNrG2VVBBU0a+JVNj5NXUL4BN9dTi3Sv+Tgu8tlwqShz9u5kytljfIi?=
 =?us-ascii?Q?5TM8BMwvXG3Uh8CNJqAeCy3xz7Ev4gWW2mNtgrmubV/ulLs2kJAV28AfQ2Ym?=
 =?us-ascii?Q?qvUveOCsfGmL7afAJB9DRQzi8ozNBKKM62mlydnXAg3GMChune007oPE2bhq?=
 =?us-ascii?Q?7IIrVj51v/9SmXH5DTrD/RX0lm2NN3YV9x9xLWfLfxIEj8KDiCnH/yQ51Afa?=
 =?us-ascii?Q?mOKQMqgPXJSshGEhNLuxhta9tuzEyPkmRs5ZGsCmCdPk4eTAkiHCK4y+XKNl?=
 =?us-ascii?Q?tjhx73beXDM0eVmI+va9GGJ0Lt8ejDYx7weSoIV9d9YXVsmXyK+Qv7BRWk6M?=
 =?us-ascii?Q?o3+XlC6CoD6fciB2aOI5p+t/AglSjyntYFHqlcmtCP4fVjXoCsf8ClGidIsk?=
 =?us-ascii?Q?zg4mTT8Msp4hpH6ay9ggfv30brSHTWeGGhECptzK3tgNomvjTU974jG/kHJf?=
 =?us-ascii?Q?Ab3a6maB4qoPrRicmDNM1tg0/VxQa4kHkkDg9+Ulq3yTu9XG16BtSyHtXC9f?=
 =?us-ascii?Q?FJQXrNFCb7fq1NJS4oop2Frg3DJXZLTExmXKu+bwtdC7/FBAEEBI9Vj6N+xD?=
 =?us-ascii?Q?VVXSaSy8gSvGPZS7p8wkcXFknjvMMxGoLlosAnT2FnYtTFiAhtyk3K+WLSrC?=
 =?us-ascii?Q?dJTXbkRjuYC3vQPo/TuXz2iKo1hYJbMtjULfi902lQMUyP3Bl753HbW9dWIZ?=
 =?us-ascii?Q?5Z98hxvYC1wSpY5UTpIj1WPQxEVDPqa8HOHJNoixJQ2xtm1Kuom/i7i1Tv5t?=
 =?us-ascii?Q?Y1vURcN/R6fPUo+s44R4TLX8ff4FZa+9x9z+56YxbW9Nt1XjvosIi/QEHGLi?=
 =?us-ascii?Q?lE+AwV5HYZ5X8lj3Sh9P5xhdt4MOsiErQXvVkU4bpL19tYad2GD8vj+gwC4r?=
 =?us-ascii?Q?MKPAEQ1kK2JALq4G0Ud7LHFrbr3qwG6u4aYk4yXgwlV4ICWX16Jejx1mwjPb?=
 =?us-ascii?Q?WdsjPZ/XLWDYt21bdrcNYWxm01e8zuzuNsFGza+Fc/g13YKTpACRYRKcJyTM?=
 =?us-ascii?Q?M8Hdm4NZ8eIAN1GOEEXnBiJru98F/GDrgeqtM+LtSnrfXEZUkC2Rp4gmBG3Y?=
 =?us-ascii?Q?ux6js/a5577C4cRxJ/MDd9CnpnINFsBRj+ONYFeERX2Ch81ONE4xUYW+wjWr?=
 =?us-ascii?Q?hu8lZNAfZ7xMxt0C8ms8r90xP6JdRsKjcnOh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:19.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3450aaf-1f69-4063-3f52-08ddf52b305e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

From: Cosmin Ratiu <cratiu@nvidia.com>

This parameter can be used by drivers to configure a different number of
doorbells.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 3 +++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index c51da4fba7e7..0a9c20d70122 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -148,3 +148,6 @@ own name.
      - The max number of Virtual Functions (VFs) exposed by the PF.
        after reboot/pci reset, 'sriov_totalvfs' entry under the device's sysfs
        directory will report this value.
+   * - ``num_doorbells``
+     - u32
+     - Controls the number of doorbells used by the device.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 8d4362f010e4..9e824f61e40f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -531,6 +531,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_CLOCK_ID,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -598,6 +599,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME "num_doorbells"
+#define DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 33134940c266..70e69523412c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -107,6 +107,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
+		.name = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_NUM_DOORBELLS_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.31.1


