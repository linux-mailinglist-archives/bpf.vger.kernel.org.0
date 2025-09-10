Return-Path: <bpf+bounces-68006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2EEB51402
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA7D162F83
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429C31DD8B;
	Wed, 10 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RzUsltiQ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44372DCF55;
	Wed, 10 Sep 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500000; cv=fail; b=uIJmRP9zeMFdIDP1xqyYmm9UTVkhE85VCavtL+EzTVBfaOkO1sMuNFuGl/weOE99+MIVNtVtP8WpIufsQ0JHQ/ok8XlK5gGgwbVZDb6WcjevJKMp+bOWFa1u3J0SKAROR/UOxAWkOtZT4MJxKYHW238Q9L3Dnyt1SG89g5d9wBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500000; c=relaxed/simple;
	bh=fVPLugubNkZ8WBxNdinW7aSMQwLrb3lEEOyXIy6qDPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT2MbPtcip/7p7g7oNWcgAmM6JGEEeZHU0g+N9OoR+ril6SICXrsK3uW4aIVDVXXtLZHcAj0p3PXgWrUVaVTKFiS9lCi+gow4jw7eQFGjMHiPl48oBvOwiOaqFSBzMLREPWhbBdWfTF65nHAevBKR0sLYLAwj+mKoMus/5FESNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RzUsltiQ; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdLyflKNnEdioCbEesV61d9VE2wsdDg/pty00KfWa+PZRrzahlkOsuYGSzP2uPNcH/YP60CpDBZHAtASZoyMEFcSHU2atDA5MngQFf8TzWTY12tbKtkBOm7ouQDcMMifYzu7wEr+bzPeQ3k3718tOWmT2p+HloOPZbithBIIJxsI0DxKcAW28bp0SHxL65s64ccvyO5ismRVTvSn1M2lNjxY+kxwm1ltJt2VXKlYcbRsFzmG8o1Q0zPX0Tih4UACeqm9wD8+8Ibh22q1sZgo9EcHBbD+SI0Dl5j6k+TuMjbct+IIJveI7pUTdGpkwIePgcPQLKLhlxVQ5jRG3HYOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot0hPtS9oCQ4MvSoxsQcG1ll2sRlOFD5O3gIcuv1rLM=;
 b=dsyx+SrzGT7v3bAEu6Q/ijAEWpzHALk1ALWXr3CA7VFX9GN3yqN1IIMzZzovl5TLTYykeosKUlvq6xJdoE8jYItjNTTXnqb+CTznsruG13D1hAEBXpluyxzcMLlJSRryVvBzG83zRPd13pvKc/czI17gmTV0iWju/kGvzQ063LFtoAcpKa3bfPyDsbaup0llbCIObJ+6XsYasTu6yMJHhj9D9RjJDlEVP8cMGwp2GjTxGNcPlePY8q0A/jRoObWtvUKdScwF9krUeqv/89trUtvZFmLYdIkTs7SWshGmAMO88C87Www5xt3ZG3xOuDCgfpiXKG9AZh5iULcul61uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot0hPtS9oCQ4MvSoxsQcG1ll2sRlOFD5O3gIcuv1rLM=;
 b=RzUsltiQpDShiYcXqzHwqlWZ5QfwjnVKwDsuqca6isLFzqnrrgvV3HXhqh2IxbtS9ZzOF7Sr8SIgbLJEVhqux1+yNiOHKuxcyoFMs2NSiGnmro7qtHfBaDkUv6/8cO1wF3PRLjN/3x3Xyd7/m+JRiXaX2aOmMsJwgIHVK8whlDpGSvP9O3q5t7JMLW8BxS2WxveOX4FyhQbV3mqx11+I3S16fQf4vA9c/RuAUYlfepplCjxvUy+KcCpxVmpB9CCrFSwgMurbtlhUVxH7vzp3IsHTNFrqvVIyr+CCsmRk2HWPRysnr56FHIze8YSVpAKsIaexf7s3wVpBxgkhi7uTAA==
Received: from BYAPR06CA0071.namprd06.prod.outlook.com (2603:10b6:a03:14b::48)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 10:26:35 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::32) by BYAPR06CA0071.outlook.office365.com
 (2603:10b6:a03:14b::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 10:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 10:26:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:26:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 03:26:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 03:25:56 -0700
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
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 09/10] devlink: Add a 'num_doorbells' driverinit param
Date: Wed, 10 Sep 2025 13:24:50 +0300
Message-ID: <1757499891-596641-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 872723e2-cede-4fb0-83ae-08ddf054843a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z3SYH1HRrYcx8+y8gBiQxYymJB57WIg7sW8DED89MTBjA+/a48hkCjCDtRAw?=
 =?us-ascii?Q?zIim8p45hJaMt4jl6R4U3bq1Mzp1qwJgTBvfVlJc+XN0+dxD+NImuSTVq49G?=
 =?us-ascii?Q?C7rN2jm4v0aQgMsl7bZM3xNA87pDGk9RHiKMlb1aBvSmekE/mF22oc9GmYPV?=
 =?us-ascii?Q?GzsdZqU0a9VwwxdSgHE24vNwobrNibAZOTOQe53DuAmjPCkR6ktg0zBHCGLF?=
 =?us-ascii?Q?JCHLBvn/GkdZlYuK1M/e6ZryEWUsdO5PyFhMGz+6XeUSW3xqWt6MybtMMWFt?=
 =?us-ascii?Q?c6lAv/HaBobdhHmg44KmWpNzNBgIyMda9BvMBOHGIkrTMzNJY+nHMN3p8Ty1?=
 =?us-ascii?Q?ZyBZRSBTd7hBpi6zG4pHlwbXasoO3F+2f4/PeB0oZepDms7Y/8Eq2llScKbv?=
 =?us-ascii?Q?UmnB6cAjOQO+ZF2mPhMfdp7jyTz47bTgOrD3q1OnGuQFTTFgNlb/3IgDDMkz?=
 =?us-ascii?Q?Iqa8/JcOOg7bD4aY93XzMKKVXB8AIxmnYby21tNEoT1kacBZVzQaH4Xnh1k+?=
 =?us-ascii?Q?O45CVJE74FUfkRlj1GTWxHgvOTnGaHGB1gBuPqKyHbW4EIRmA9vgoCAeyoIH?=
 =?us-ascii?Q?jdcP5E8ZYXIEgcEmmOZ6JfNGtePoQBkjSZbCVTak4WJ3u6P7FkanZiezyjEu?=
 =?us-ascii?Q?dA3tEYMSzuDqCulvk52zn30bE5xnRYImJLup+qxTIPVgtQ8Qa9c0leZm6G8l?=
 =?us-ascii?Q?VKj5ojIepQz027WWzL82WjB8EtlY/uo4entdvTObU0VF11Esf5YRMzAGk0Xw?=
 =?us-ascii?Q?ayyAaSiyZwRMFZPVOgLtQGADwhXJ+tre5KUYYceAD5YcPAMJU8k1ckqlmL3e?=
 =?us-ascii?Q?8ZaOAe3+NAc0niw/Vjl4DhUJjoPcGtsyVUzlQBxTVjIoiLOFvtFQxjloOu3l?=
 =?us-ascii?Q?sD2eZob1Ycs9RwZiC8WbWjxNS7lUZuJqkpvAnTVxGB2mXFwdUJtNUHFAjonE?=
 =?us-ascii?Q?tFBE/wfbfC753A3TIhL4YSE9zTERLzeYz6yM60GgqAUZp/LeOZ+ywOfKaxlV?=
 =?us-ascii?Q?+oMgSuMODPNFzPt/F2sGK32cA2jain0BNbfXVNtMMhFFlhKtCIfyYgEvFqto?=
 =?us-ascii?Q?wXCwqfM7MteC16Nid1j95t+dv11aUToW2Uo9sSRl54P9m5rpC9oLdjHohb3n?=
 =?us-ascii?Q?0WcPGn3JZYxoJgFW4Ga7fsfCBClkPGIE+a7fha6m3BIUQNRuhhd4sQI5SsBM?=
 =?us-ascii?Q?KcYXRkcK5Y/bdEWm7v1PGSIOWz7BL078UH6bOrMa2bkQF5wNA44FETIn/47q?=
 =?us-ascii?Q?UX9pY0WGJeNQlYogqhT9v3NDvkCv6B5vNNl/o4pptnTspc0Tp8SsSYImjMkz?=
 =?us-ascii?Q?JAXi6hT6FF8oM+F9lHaaXVT3/OkGZF89UWv91ohm9c/UvkSiYAhJU7M58/et?=
 =?us-ascii?Q?e7TWjOXuTJVMMiAo3xbtTYBFkLTE66ry3vTYcwsA3B4L+drEuX/ahETnlSMJ?=
 =?us-ascii?Q?0si4a7Iyd2EUKb3sIKPaVKtsNXHTOFmyR/ZooYSCzPH9QpkkgtfAoW1MARxg?=
 =?us-ascii?Q?ba9xuDH+DNPW4MpJGzqCPKC1v+sSNo1yRkw5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 10:26:34.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872723e2-cede-4fb0-83ae-08ddf054843a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

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


