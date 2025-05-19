Return-Path: <bpf+bounces-58489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF5ABC46B
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05ECB3ADD0D
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1DF288C8E;
	Mon, 19 May 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ekM4tRZ/"
X-Original-To: bpf@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607F2857FA;
	Mon, 19 May 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671653; cv=fail; b=kOPjNi7He6vOnx/ZvottyYcClnihielAR+VV1JvdND+7fkatGHhIkVZQGuAbpRdSkoO6OtQe0FCaFWQ96t6Z8dPF1Hwc/LnEE4ta9e7hZglSssvKCymqHQ/p6roq+MdC4uql0uYunmpJUxoXXTRVbXJnMINE7lRyVAPxI1N6kvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671653; c=relaxed/simple;
	bh=bc+w6ysQMAb3BIvvoi5yPh4zFNgIImXv0ePcO4KJTxc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CwgnVF2Wg5LmJVz9LHVB4EY398Fi9oVd77jvJocXvGuKVL90yaOs9ojtUHIWSswVCYXn4DhJpmnOoboXnTEjgwXz+KdOKgQRhXm8KcQWt3DO4Z+10mz/pFNjvfZK9DLZebFK1+rH2W86V0VPdaZQCoIhKZwXYmx+QA4Ke3dMPLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ekM4tRZ/; arc=fail smtp.client-ip=40.93.201.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQtE3vlESWi7x02NFK4e1bPvI8xiZpuxlVnGab5Kh5BxY0BGyHvbFzWUv6EL/e0Q1LpSS8aO2WUjAakvExKEhJMOR+Y8CTwtVOkQxoNfqcNgjm3N87szP1nkgPzicF/Yyo/AY3e9r3sIsu5MtbeL0t+H274FiuTyRpVyNS+9CEXYJopPRUQ8VIAuxyQEfkQ/x4R9oRgIDS2ZqcvM9Q0wkAL9fXm6+AbEQ9Rm9/H8KV6prjksQ43szBM/2UZ4NHKk+MzxbvUdsUzJG/zW8rl0t/OA4kmb39yiNHWKTw1UddGymQ8m9OQ34cmraDNsPaf392ia/pyH8Rl6ms/iUTH7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZKSOEItx/FkOFKw+vSxnlUSNTuHSmuvtKIe+vaU+jg=;
 b=jsEMj2Y3i4DAPOJNU6ZQnjsuiqX91Qs4NQSWQptVPIhrHHLicu70hYiCzvfUH0eHFpYr8hXf84qUwYEb5njsiedoVdO7/qHwA2KPLRAuKg6PDEDU93QJSN0QTCk3jNfUDe4isbYm+WS8rDLse+u5jQ8EQGjVL1hoof3UL6Nhdw5Y2jCVRKxO8C7qLxv/3ryWc5ba4uQIwJBYy3NksHoJgi45sbWokcGuWRzl9E4uX3ApeEHc1Ssa2mziPdYM8EWFTuhIgqpqkYIZVDlnvw7yob7ftPINYoee/4I0uBKiqCZ9QVuNdz5jgQS2VRy0BOXRwRvckftTLQwElE271gxLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZKSOEItx/FkOFKw+vSxnlUSNTuHSmuvtKIe+vaU+jg=;
 b=ekM4tRZ/po4vRHJHdkCTLTg15pwyzNm9cIntJz3GcdEsT6K9F7T/26bowiHiSnDjlJc/+O9LGTzav1chcyFAJ64TjOToba6e8fSF/IGVGPaVet8Uq1gWGEZ4iNcFPabuhahWEwgv18ZxNWfpa+1gp349+Ou09pkbBdS0CU/oTD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by CH4PR21MB4265.namprd21.prod.outlook.com (2603:10b6:610:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.16; Mon, 19 May
 2025 16:20:47 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8769.013; Mon, 19 May 2025
 16:20:47 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	andrew+netdev@lunn.ch,
	kotaranov@microsoft.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2] net: mana: Add support for Multi Vports on Bare metal
Date: Mon, 19 May 2025 09:20:36 -0700
Message-Id: <1747671636-5810-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|CH4PR21MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af27893-4ba7-44db-fe94-08dd96f11ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/3Bn0JTY8dbdX5Q5EGlItdwb5D5Oh6xY/zEOeWZ11IPgFKX/Zieq7F6YrBK?=
 =?us-ascii?Q?MHA5q0lXX4rDCHy4CsHNNE0ypthzFN98l688+kL5rdWPqVoLcBG21F2SZf7a?=
 =?us-ascii?Q?+UFNIy2QAxPt+AxRMf7biSFVmNQZpAcs8q9t9+ysTYFZC5I63pVfO5aS9uGe?=
 =?us-ascii?Q?KXq9D6xVpJscTc20JdJSV+VWuI0PFRDQ734PxM7we6mrz0QEiF0BbkPXtsD7?=
 =?us-ascii?Q?jOVNvEq2pjBxjsvMWJZE84e4QNSycgrzLBVfjXg0E4ypKci0dy20KOPR1T7+?=
 =?us-ascii?Q?rcLSytiV2SLQg2ebX5eS9bIy7tY4kIIXHBVY+5Er6t48wpu3ZMIw3saWPibu?=
 =?us-ascii?Q?4o7tAjRSUnGkEvlK+rFo5rZDgczEXFJI7pEKEORwefXgQEsrATm5NV1I+dJr?=
 =?us-ascii?Q?YIiw9mbn2mmt/jUPjY6G8SQaahYjG8y2pEgbNb9Qp0a6av6gpW94phA3YKmS?=
 =?us-ascii?Q?gdqiPJUqZPlZKLZFjIKkn2Om+m8yyIl/rrhvwKpArXbmgVso03k2IJR3+vJd?=
 =?us-ascii?Q?5svJZiyHkmI+0G1UQ+af77JAT82KPvG+/QXGcJAkUfVJgZGjYa7ZewzQp6IF?=
 =?us-ascii?Q?v5voWteuycrhGJMv58SNTRZniP/QjnXT4qisRoMzsmsHMA3sD8IwXbMDPswt?=
 =?us-ascii?Q?zxGCoBVgmSEDtqVaTVTSu1N/JIvMGFj648xhqYAc1aX5Br3b0Caq7gyEy9Pd?=
 =?us-ascii?Q?c+NrtVrD1aycByOT4vMQSey526FC+SSJomA8dE0KMlkIR/9UzwfW3l8joEiP?=
 =?us-ascii?Q?jpxXfvtHWm1XyKW66WigruDfVxZa5IzGNrD9PNsOlH6RrfEks6SwRzbn6Qj2?=
 =?us-ascii?Q?2KOzQiTD8T21NPupefQBXRizIgraNj4+A816fxzSIGPqJ8I4VwBEtfbj6NvK?=
 =?us-ascii?Q?v8teK8a1Kjgl/kSuEKI1sx6ZjdfnDguLk3DiIxoDt3JMjaSipfmJYyPVNHiD?=
 =?us-ascii?Q?2Awea7HBQ6jvzSOXrFdNQhYe9L18zF9dvOdf51sbG9lOYG0apg9ODt8bp2hg?=
 =?us-ascii?Q?lixJkt4ALw2YGARRNP3tYyCp8h/Mu3NLYeeUe+BHqi1Xlq++8KzsUnN6KFkp?=
 =?us-ascii?Q?1kRGY2iS8Gsmsf15eUjySzQiZqkXzt2hwPBYpHOuUUAoo18q/37qfH5wNqc4?=
 =?us-ascii?Q?ldh8cy5S/bXlv+/mVcJ0kXtVL9WffdMtQn4MvMYd4EsFBI+gqHwfSLT2zA2q?=
 =?us-ascii?Q?922+gfk2Ima6/h8ya17H2nkBloQIsBFXSc/GugItW2BE2WceOWw1mjdbD5IO?=
 =?us-ascii?Q?fdAv9H7HxeaT2oOMKHki7AtqXUy8dINouM7SkY1mPnYIFWGhIDv1PG/u6dCo?=
 =?us-ascii?Q?MuoXCE2AyiL7Ad9hM2NMPEWky65xDdK79PMNM0cFofArA+aOPY8g1XKrSe3w?=
 =?us-ascii?Q?7b2WCWzchqOkELFt6gMuEhu9MHUQy12rTDBzVoCpjW//EIEhGMzdagP1cEp8?=
 =?us-ascii?Q?IC+cJXtWC6lW6rAGK5ZRdLqE3bONQIizgqvFYKYgOA062YRzM2rshA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?emnRnw8a4EuunRFDdaSOouhED6D88BWShR/KH+BQxCZcpzxfTYc67mRqH7l6?=
 =?us-ascii?Q?Lb+BsyGvJ6aw+DbSzXBDb7CGR/1KMCR2Qvf6w/NDp7VH08RX+G6xtrx+1ArZ?=
 =?us-ascii?Q?kf/D/D/+xfHQ+KSjX/7Q/k5PXI/N9x7eJhJXuJoZQ2g4E3VNDuexsMRXWtHT?=
 =?us-ascii?Q?OdzcVlduM7vUXOW/8yOVg9P56qACXwPF+KVwI0A4DUktFDcltb19fzqIdg0m?=
 =?us-ascii?Q?N0x9xNAGDvlz+NOooI6j09ENlRouw/y7HdrhlCQ2DqjQvmjcjHDSXgvwoSfu?=
 =?us-ascii?Q?ZLFibr5x0ueKpBNa/RiEXoTi/W1abwRGLRLDGCUntQbp8R+lnzi9V7X7usus?=
 =?us-ascii?Q?QjkRWjXt/juL/b0UoMUflzXFguLKefJZNpoNGOC0RdpNWLBBmt9WuXE8Npqk?=
 =?us-ascii?Q?q3s8lmKOWMHc09TvBebAJrW0/0LvzA7mtXmvei6soWrKvKtw5BKy2i4W+ns4?=
 =?us-ascii?Q?CuXtnvAFagiBiMiCEc1E35EmbmsZDXklI0WMBG+zAlQ1YDs5b0jEpLbSZrGZ?=
 =?us-ascii?Q?bWCnks8I840lTc7Ueh0a4cLQzl5V/fDWPH5nquAf5zmjppi5ZNQhANKb0zyw?=
 =?us-ascii?Q?o88NsME4/NHVhbmzG2yL2bJDXdWUHvu6qpt8/9uSvgaEP/pJ/DRFkuZAc0yR?=
 =?us-ascii?Q?pr2vFkVJCyvOrb/dFTTDht+vpXKt0JMOy9g4AQjKPHx1ES2sOcwfUhPgXjW5?=
 =?us-ascii?Q?AwjxXci52PcN7gnMhVFQkroIG0vmR2Ip1BOIPzBwFKEkzeXXIng7x648zycf?=
 =?us-ascii?Q?3KLWjyHdn2ErMx9gWtms6zqAvJJ0z33P8/Y0gxcCscWjZYgiNGeBv+/7Cx9v?=
 =?us-ascii?Q?E9+4Lsng/FfJdXz9KziEKQ3kYrQ246wr+BuGd14weaZ33gvtTi8Y+ehlr3SN?=
 =?us-ascii?Q?D2DrD0t7C6OhCijY1peCZojsLYrHjuiPns79+HPlbiGS6BLiswSlRS5WO8l8?=
 =?us-ascii?Q?vuMm4/TZtrewjU5jCstZtuHNFeHWFf+QVWNTqqDjJ0RtpVWiRo0S4FMoxhai?=
 =?us-ascii?Q?jCCYOLIQVQ7wv884ARdYbBW3m74IAAR5G2wihG6YlOLKa4xXKfjgPs2Zo5m6?=
 =?us-ascii?Q?fnoZpu9bcUN7NFHQIBrfxCZ9+4+LI7a5PEU6gE0e2pxeLXnKJiQ2MFGFb+El?=
 =?us-ascii?Q?df5PeMGvi3Ceu/JvwSJH/eJrOenFOQJHmt9Ha78Qmg6kTQlzphtiKYL4cOZn?=
 =?us-ascii?Q?TwVjKAnjFmgwFzI2F5cQNNOXZUGk9YyNd6r32SyDzlhKgmd85gJXGdJIoXiu?=
 =?us-ascii?Q?3eHOiACN5ODAR3PAqdSGGedgNUczSjRwgX+6VhplU/5dECFUn61iw7Z42uvp?=
 =?us-ascii?Q?crAqp2jiwU0m8NdvDkALjUyOXDdeC/FhjGb0/LV+HYaIaSQ2Te89Tp8FOGDO?=
 =?us-ascii?Q?air9LOVUrM29hPnSnfl2aNi+jYF2QX2z37xzsIV5mI8oi8MsgRGYvRAmW4cY?=
 =?us-ascii?Q?B9an89HzdLr+uHn+PaYZ3xJAqndUtrVzeq6tdJX6LBGmPMVoPXlBd0bBjQmd?=
 =?us-ascii?Q?LedBMtjh7dCQG20Eler6WleEiCHGTOnaEatb5ivKedC6oqT0DMc5sLqKSfWZ?=
 =?us-ascii?Q?97Kuo4oliCYA2g9oQLntmjjypOFaj25mI7vrXXhX?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af27893-4ba7-44db-fe94-08dd96f11ce1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:20:47.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb1YgeFt4UlFBXwciIUURkWoOBds5DZeGOhX5H2zdvq+9vrjHJuYnR/VNTrOaIGHVqzPCW5lyszYqeuKjBetMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4265

To support Multi Vports on Bare metal, increase the device config response
version. And, skip the register HW vport, and register filter steps, when
the Bare metal hostmode is set.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2:
  Updated comments as suggested by ALOK TIWARI.
  Fixed the version check.

---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 24 ++++++++++++-------
 include/net/mana/mana.h                       |  4 +++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 2bac6be8f6a0..9c58d9e0bbb5 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
 
 static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 				 u32 proto_minor_ver, u32 proto_micro_ver,
-				 u16 *max_num_vports)
+				 u16 *max_num_vports, u8 *bm_hostmode)
 {
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct mana_query_device_cfg_resp resp = {};
@@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
 			     sizeof(req), sizeof(resp));
 
-	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
 
 	req.proto_major_ver = proto_major_ver;
 	req.proto_minor_ver = proto_minor_ver;
@@ -956,11 +956,16 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 
 	*max_num_vports = resp.max_num_vports;
 
-	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V2)
+	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
 		gc->adapter_mtu = resp.adapter_mtu;
 	else
 		gc->adapter_mtu = ETH_FRAME_LEN;
 
+	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
+		*bm_hostmode = resp.bm_hostmode;
+	else
+		*bm_hostmode = 0;
+
 	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
 
 	return 0;
@@ -2441,7 +2446,7 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 	mana_destroy_txq(apc);
 	mana_uncfg_vport(apc);
 
-	if (gd->gdma_context->is_pf)
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_hw_vport(apc);
 }
 
@@ -2453,7 +2458,7 @@ static int mana_create_vport(struct mana_port_context *apc,
 
 	apc->default_rxobj = INVALID_MANA_HANDLE;
 
-	if (gd->gdma_context->is_pf) {
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode) {
 		err = mana_pf_register_hw_vport(apc);
 		if (err)
 			return err;
@@ -2689,7 +2694,7 @@ int mana_alloc_queues(struct net_device *ndev)
 		goto destroy_vport;
 	}
 
-	if (gd->gdma_context->is_pf) {
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode) {
 		err = mana_pf_register_filter(apc);
 		if (err)
 			goto destroy_vport;
@@ -2751,7 +2756,7 @@ static int mana_dealloc_queues(struct net_device *ndev)
 
 	mana_chn_setxdp(apc, NULL);
 
-	if (gd->gdma_context->is_pf)
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_filter(apc);
 
 	/* No packet can be transmitted now since apc->port_is_up is false.
@@ -2998,6 +3003,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	struct gdma_context *gc = gd->gdma_context;
 	struct mana_context *ac = gd->driver_data;
 	struct device *dev = gc->dev;
+	u8 bm_hostmode = 0;
 	u16 num_ports = 0;
 	int err;
 	int i;
@@ -3026,10 +3032,12 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	}
 
 	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
-				    MANA_MICRO_VERSION, &num_ports);
+				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
 	if (err)
 		goto out;
 
+	ac->bm_hostmode = bm_hostmode;
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 	} else {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0f78065de8fe..38238c1d00bf 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -408,6 +408,7 @@ struct mana_context {
 	struct gdma_dev *gdma_dev;
 
 	u16 num_ports;
+	u8 bm_hostmode;
 
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
@@ -557,7 +558,8 @@ struct mana_query_device_cfg_resp {
 	u64 pf_cap_flags4;
 
 	u16 max_num_vports;
-	u16 reserved;
+	u8 bm_hostmode; /* response v3: Bare Metal Host Mode */
+	u8 reserved;
 	u32 max_num_eqs;
 
 	/* response v2: */
-- 
2.34.1


