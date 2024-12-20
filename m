Return-Path: <bpf+bounces-47428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B44499F9599
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC4E7A34EE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E06219EAD;
	Fri, 20 Dec 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yhkfd7K4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77719219A83;
	Fri, 20 Dec 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709293; cv=fail; b=s8F35+JFe1+4EMYohJgkpMuJ+mQx1IrgAHaWnzeKkmQphsl2SbuoWKuZsRgQCXp5fxHMByF5vkpMZKOkfwTd+7PLyLHKErh+sJG+pUvzzsZTgYi0xD0S8cKFcyILhv7rCc/gEDrjBBaAVhWKHVX9fQ2Q8DimRBJPYRPOEfjwBw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709293; c=relaxed/simple;
	bh=KlcYFBZqkx4sHZafnuBP7ghcKek87oc/S/koYFf9jIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pyoxiliR4dP5ri1qA8XGFXayK+JdFUK6bz/wQZZvxHxI6HDXx80JPK/7bZaC9Z2rI0yNec0BlcjHRqkZgGCgtInMQCvhn5DR8mhrDMsW1G/HLXfCeI4Tm0K/iKT+O0iyXjK2UtE/qh0ug9I6VnvEAX+1IjIBSljIZRceYTSwYMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yhkfd7K4; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFZpHuCNW3gnDDzR2rzr8IFzlQl5MqEm6SNVPvHY3bSrctqXF7utS7YMFAPvwB5Hiy4y9TDzqrRVqYhD0CkF6r9Kp4hztylKXbsfb6sPz0cxgjhkzCMEpfbu9cjJosgMfuEfSUbqmD7tsvH07W/zalAFPhDavMFzCPRAXN1pk2x+55BVJ1Ol8+lzLwzBc+2wHp549oUGQ5WO+8Pi2V813PsJuab8kbNczvM+jgd5wmExe2YDZRXPSsgauKCgV0zyEbHiddfPfQwdiiHSaVLk4QuqH+lOWPvB9VWs0xMoWPy2loX1k9st0VI9Pb6oBRb6zSdwyrzlx43EvYvtbBuy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9uSInKu/38EFQfNXL0CQk4Ggbv9bR33SfOxkDA4frM=;
 b=JtcuyhHlzX/gb8a/eT7OcFrEUBpDBiqI5XCI4hjIqsvgdipbHfEypLQlxfLBWIOdjwfHpslXfdkq0u+ITutDHFvhMNKO1CRtCt9JwM1SrN9nfb3IvQ5AznDQ96Gz+YTsb2azu3aaszgZE6TLzwxxoyE1zWPglqhXSPUkD9wkmY0GG6BDJR6MnYsiXMPHf6RHrbFmsqI/P1CRtTlHMfXYmolMnAcfQYD58IimaKSOWy1aKYCUsAZ2zJUgQ8ScEdjQ4hZ++U28tLwtupuMlgNseZnzJ8dKBrbbcI2Xv9DSvMUGUpR266imKfsQToTPHSWgB53STX9Zm9F7tqtjMtBTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9uSInKu/38EFQfNXL0CQk4Ggbv9bR33SfOxkDA4frM=;
 b=Yhkfd7K4Zha50OxrOrnGuH1mFdjP8cjbHOZtOlyclfrXauVl+Mzw4NwLa6yhvPsIzyuoQqRtVO+Qtlw6y3auh4DqIb0I0pHUzmPpUYUxogLEDNVQ5gQTpDqyXgPQ5BfiOX+AzjO4k9gqqUVrFk954BS6J9IXyeGadIpab2LGOF9EKIOTH0diB+B583e+3gomleUpMClytbkfUwist+/3g3tvFPz2BpLuofQrPA6z3aaSz4x477iH/bkb1kgBI1FD7dFegG9rRTkGW7jreCU3+6pYrS+vgndnbjbp7gFdix9whBvDbuIhlum0DSav/2uPfvhEJ5NDPcU/TljZdwxchw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 15:41:24 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 15:41:24 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] sched_ext: Move built-in idle CPU selection policy to a separate file
Date: Fri, 20 Dec 2024 16:11:34 +0100
Message-ID: <20241220154107.287478-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220154107.287478-1-arighi@nvidia.com>
References: <20241220154107.287478-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: db35f5ef-2f77-44a8-95e7-08dd210cc263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TWElcB4F5U4aXJOFttBy/uk4yF8vvSgOa1Kak6lhH4RZxRBVQPYW0HgAfQSq?=
 =?us-ascii?Q?6tSzPSvmqSn4EekflXZ4KXRLMTuMv6OAy28SYRNQq3blbnDRviMAYrwTuUsJ?=
 =?us-ascii?Q?GwFM+v+DMSMNhg0HSiR9VdNSdJQnja5gWadpBh+WnvH+T/BoMFDCVmDqbd7X?=
 =?us-ascii?Q?f8nP6tBP46i1Z8bkgyi6IwXiYqiLb6LgkAQdCYkru/yc0wP3xozVfwkBF6uy?=
 =?us-ascii?Q?hkdviETeSNAiLqkUXrIgxVYshNxNHIGfex47YWkaHZDTUvlIlwFSoQzbyxno?=
 =?us-ascii?Q?YGatohZCakduuiWN3W/3Ug+KtMecaXkFhVI2WpxIlPtKdI/V8tPJxJ0CFOzd?=
 =?us-ascii?Q?dSTo0N68CLso9oIV10UpL+imrRQl1nPFxWst48TTxMmknuYoLT5rChKH3W+6?=
 =?us-ascii?Q?W4Rfwd3QRUkTKxQ/WRbbp3aoAv+hTmhInts3bUhSdaQaLvJg68rtt1C7Ykf9?=
 =?us-ascii?Q?ivoSnj7fwZvkWYjWyC5/2cOlBbh+9M22hC/4sRlrE7V+e2WsC/xvjmT/eajZ?=
 =?us-ascii?Q?gr7u6TJvcdxWiWvVlSLjgssVlV9uLWUMf8l+acEY03zFPAuhmZfi80djMN8r?=
 =?us-ascii?Q?L4ujOe1rNLV4c6tyL0aM99/dcir7Be0YC0QXr6963I4xe7v/SVhD//hmDhAR?=
 =?us-ascii?Q?oeFp7J0/QKYsu9g9hH7wfLSmNFDCw7TsGQDN5SDqUy7Cx/Aflr4vB9icf8Qa?=
 =?us-ascii?Q?3dizPPdesoylwUJC/gTBDhsOp8oy4la/G8H1jEvV5brKEgO+ryU1aaqn1sRm?=
 =?us-ascii?Q?8fw5/tbh0pSpOVrQquF7QT5tjjIDKuvL3gBDK9IKh/5etUz8FEC0LT21K2v5?=
 =?us-ascii?Q?ZvMf4OpLTjHua/kp5OA6Wtr8zcG1pQAaXJ0lQg1ZsGF/aLZcWGJrKGHvX8zH?=
 =?us-ascii?Q?+Jea+EQrO1e5YcG6Kp8KxHV5qDk7XQuBEK61jZ+0tRnfaQhc6jLY3NCK/Xtr?=
 =?us-ascii?Q?xcsSimbsV7wNMWuwqljWoFo5hC/RJQv/LasbM00Af+XUn612YcKFaNwUn8AR?=
 =?us-ascii?Q?KjvGYPx10bkYiZfNSQYkU8x6oR5+zoyINq8G+Lu4m/Dyj221XpgamPXMHuKW?=
 =?us-ascii?Q?q97NpDIdPlCRwcI75issKP+qe4PQuS0vbVbWUuCdej+kRoebf44kjE13QLOB?=
 =?us-ascii?Q?zYbIKEuz/9bccrIN/xpwzKLuKi1SA6eGpzS6ZqcQPLRBIk91IP5Hr4Z7cCjs?=
 =?us-ascii?Q?Vw2vcO6FSkOFFL4wRcwRMstd74nQGvdjO1c5Xsq2dQnxZTUYejArr8nmQuwu?=
 =?us-ascii?Q?X/MnHkE/qYF4o3+v5QYs4kxNCsdQNUpPhRomotkwK1HuwTFvQAugHGbIMR5d?=
 =?us-ascii?Q?aZOhFm/unOuwjBw8Z8tQEYGtKRiGRf8RYou4VTOvIrAKRBgl492+3xqlcdCS?=
 =?us-ascii?Q?qUdyGE4Sg+8c8X4QOA9xFjDktehr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZG9NRFnx4HRZBeEEB680eVaQemBztJUGymiwY2AS83iBAS7YM31j/vSAjoF?=
 =?us-ascii?Q?LwhHhWsJ36N1FVIrz+VrtLdfkDZlnQT3FArKkcmyD9UcViEbs2UIx0XiPFq8?=
 =?us-ascii?Q?OazPn4ot0tCegHBW6JwehIS9/AfXCzP+PG8h1vlAb75YjJ49oGV7SreWKvSh?=
 =?us-ascii?Q?rqcP144+s1BsM46wr02Oax9qVquivyP1OeODx+OGyLMILXfvZ06L4Z/6/YbF?=
 =?us-ascii?Q?OPEXW26saxuhQq2QSZ/RbzMOqLStq41bz4F6w4T0vIeDRJTpFWC5Z5xIxUnU?=
 =?us-ascii?Q?3D7xXL+AHbBXXkDF2+9LZpyGuHeCEnzAOCmt6W7B/ZcS8uDO+pO7Fqh27+ls?=
 =?us-ascii?Q?wQ3SDmsQTeRVZpsoEUJuzwuJmgMQCY+3HoibGzzMo3Nor3jgK9hDuURscRPM?=
 =?us-ascii?Q?DusFXKXqJUgKnK0LHAyGrtPaGeYBwE4tJVCjsdnk6YRvLKfMIznLhdmWwFlw?=
 =?us-ascii?Q?kw/EEg9RcUWynpYV75pc9FshyT7n42FNIklIfyUhwReNnuW0c9OjjKk00IdY?=
 =?us-ascii?Q?HuOGyhK5N4EXn3QBaeHov2UctZbqejBSRqG3y4q6aEu7kW9GYVgAN8xIsX/I?=
 =?us-ascii?Q?p9lZRz0I2WUxraQfc5ocdkHIc4GMxGCuxZgegr7p0cWcCgMvJlCW7Tyvg4Sj?=
 =?us-ascii?Q?8UghJ3aCFwE3SdeaetcnJzOTTQGzgwOEWp0SKEnIV28sWXy3/uLh5Kftkt3A?=
 =?us-ascii?Q?oSRWUUwFLHEWjbUgHfm4vMiRdefsl8qRxYH8vEdE8oRysbNFg3SEigv09qXt?=
 =?us-ascii?Q?a3zOTxGoqmmouA5VQJuFH9yAxmeIG17VVlBVLA69r8jixpmJ9SXGx0ymmIRH?=
 =?us-ascii?Q?yFvOI1hJfr7qodipcvRPcgI5j10n16Jiweri+fCKdRotGVW4+mdJix+Qa7Ht?=
 =?us-ascii?Q?88wXfJ73VwBJ5WmD8UtvX7ubSmvxFRJ6GOIH5VKneVxwhZMlPUMnImE8pNXc?=
 =?us-ascii?Q?opkPQM9IrgdQUKo7JqbB3WTkodopdKwCjUHg6LFe1D0mMZvGUe9bR2N3VsOd?=
 =?us-ascii?Q?tyePqwFSQEz+YtxlTs+49XIFvvrSNV3y1Tk2CXr2qmTjp4/RgrfEx18aj8es?=
 =?us-ascii?Q?foCzKAtod0xvMAkxLBKrNqe4qO81dgozFJ8p7O3xXXvVe65s9/RQ3AbjCabQ?=
 =?us-ascii?Q?BdSyZttqN3og+tgYlEXoQq1VLOm4hvCiE0qO2R3WxFzSAMDBDLFGEMRywDZY?=
 =?us-ascii?Q?zOIH1a5iGJeGUcNQ7+jX5JXnFp5mgnumg7AQwE1c0Jru21Kyd+v/XMoRmRod?=
 =?us-ascii?Q?344jt+d8yiT4EqGcxGVlk17NYujsZa4+F6X2beuOhL2gigBH87sNPkeWPfNa?=
 =?us-ascii?Q?2dSs4kR4Xnv4wqhCLUrr2q3qkJznp1DDd9iG9srV6nCoSp2PDmdVmZGCrnN5?=
 =?us-ascii?Q?i/9QW1tBb/Svw4PEXz3eliRCZFFrh0ISCcDpJXghtzuPNcZd+Twe1Echc47G?=
 =?us-ascii?Q?t4mD6YpnIsRliJ9ksmaS8+bD2vUI8b6NdRpHukYbsVMlx5z4fa6HJjv/dcWL?=
 =?us-ascii?Q?UVFzcPnwqPt5fuiFUDUS0VXGta65sjzupiShzZd/wVHo+j/Vwp8cg7xIUn3e?=
 =?us-ascii?Q?HiMwBEE+XN8GZfZEBImEKQdA/85PfMUwhSmpESpb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db35f5ef-2f77-44a8-95e7-08dd210cc263
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:41:24.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4x3uBWYEKl+OMh5t9S2Rh0x0wdD0c9HtyIp3Fm9v5YfPfDdU2PqUHF2d865QHgrpMFoAEpu0ZR2PmpjhwRiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

As ext.c is becoming quite large, move the idle CPU selection policy
to a separate file (ext_idle.c) for better code readability.

Also group together all the idle CPU selection kfunc's to the same
btf_kfunc_id_set block.

No functional change, this is purely code reorganization.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 MAINTAINERS             |   1 +
 kernel/sched/ext.c      | 702 +---------------------------------------
 kernel/sched/ext_idle.c | 686 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 703 insertions(+), 686 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..02960d1b9ee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20909,6 +20909,7 @@ T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
 F:	include/linux/sched/ext.h
 F:	kernel/sched/ext.h
 F:	kernel/sched/ext.c
+F:	kernel/sched/ext_idle.c
 F:	tools/sched_ext/
 F:	tools/testing/selftests/sched_ext
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54e659ba9476..769e43fdea1e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
+#include <linux/btf_ids.h>
+
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 
 enum scx_consts {
@@ -882,12 +884,6 @@ static bool scx_warned_zero_slice;
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
-
-#ifdef CONFIG_SMP
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
-#endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
@@ -895,6 +891,17 @@ static struct static_key_false scx_has_op[SCX_OPI_END] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
+#define scx_ops_error_kind(err, fmt, args...)					\
+	scx_ops_exit_kind((err), 0, fmt, ##args)
+
+#define scx_ops_exit(code, fmt, args...)					\
+	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
+
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
+
+#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
+
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
@@ -922,21 +929,6 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
-/* idle tracking */
-#ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
-static struct {
-	cpumask_var_t cpu;
-	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
-
-#endif	/* CONFIG_SMP */
-
 /* for %SCX_KICK_WAIT */
 static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
 
@@ -1023,17 +1015,6 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
 
-#define scx_ops_error_kind(err, fmt, args...)					\
-	scx_ops_exit_kind((err), 0, fmt, ##args)
-
-#define scx_ops_exit(code, fmt, args...)					\
-	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
-
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
-
-#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
-
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 {
 	if (time_after(at, now))
@@ -1540,6 +1521,9 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+/* Built-in idle CPU selection policy */
+#include "ext_idle.c"
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
@@ -3164,410 +3148,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 #ifdef CONFIG_SMP
 
-static bool test_and_clear_cpu_idle(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
-	 * cluster is not wholly idle either way. This also prevents
-	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
-	 */
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-
-		/*
-		 * If offline, @cpu is not its own sibling and
-		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
-		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
-	}
-#endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
-}
-
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
-{
-	int cpu;
-
-retry:
-	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
-		if (cpu < nr_cpu_ids)
-			goto found;
-
-		if (flags & SCX_PICK_IDLE_CORE)
-			return -EBUSY;
-	}
-
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
-
-found:
-	if (test_and_clear_cpu_idle(cpu))
-		return cpu;
-	else
-		goto retry;
-}
-
-/*
- * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
- * domain is not defined).
- */
-static unsigned int llc_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sd->span_weight;
-}
-
-/*
- * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
- * domain is not defined).
- */
-static struct cpumask *llc_span(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sched_domain_span(sd);
-}
-
-/*
- * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
- * NUMA domain is not defined).
- */
-static unsigned int numa_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return 0;
-	sg = sd->groups;
-	if (!sg)
-		return 0;
-
-	return sg->group_weight;
-}
-
-/*
- * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
- * domain is not defined).
- */
-static struct cpumask *numa_span(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return NULL;
-	sg = sd->groups;
-	if (!sg)
-		return NULL;
-
-	return sched_group_span(sg);
-}
-
-/*
- * Return true if the LLC domains do not perfectly overlap with the NUMA
- * domains, false otherwise.
- */
-static bool llc_numa_mismatch(void)
-{
-	int cpu;
-
-	/*
-	 * We need to scan all online CPUs to verify whether their scheduling
-	 * domains overlap.
-	 *
-	 * While it is rare to encounter architectures with asymmetric NUMA
-	 * topologies, CPU hotplugging or virtualized environments can result
-	 * in asymmetric configurations.
-	 *
-	 * For example:
-	 *
-	 *  NUMA 0:
-	 *    - LLC 0: cpu0..cpu7
-	 *    - LLC 1: cpu8..cpu15 [offline]
-	 *
-	 *  NUMA 1:
-	 *    - LLC 0: cpu16..cpu23
-	 *    - LLC 1: cpu24..cpu31
-	 *
-	 * In this case, if we only check the first online CPU (cpu0), we might
-	 * incorrectly assume that the LLC and NUMA domains are fully
-	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
-	 * domains).
-	 */
-	for_each_online_cpu(cpu)
-		if (llc_weight(cpu) != numa_weight(cpu))
-			return true;
-
-	return false;
-}
-
-/*
- * Initialize topology-aware scheduling.
- *
- * Detect if the system has multiple LLC or multiple NUMA domains and enable
- * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
- * selection policy.
- *
- * Assumption: the kernel's internal topology representation assumes that each
- * CPU belongs to a single LLC domain, and that each LLC domain is entirely
- * contained within a single NUMA node.
- */
-static void update_selcpu_topology(void)
-{
-	bool enable_llc = false, enable_numa = false;
-	unsigned int nr_cpus;
-	s32 cpu = cpumask_first(cpu_online_mask);
-
-	/*
-	 * Enable LLC domain optimization only when there are multiple LLC
-	 * domains among the online CPUs. If all online CPUs are part of a
-	 * single LLC domain, the idle CPU selection logic can choose any
-	 * online CPU without bias.
-	 *
-	 * Note that it is sufficient to check the LLC domain of the first
-	 * online CPU to determine whether a single LLC domain includes all
-	 * CPUs.
-	 */
-	rcu_read_lock();
-	nr_cpus = llc_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus())
-			enable_llc = true;
-		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
-			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
-	}
-
-	/*
-	 * Enable NUMA optimization only when there are multiple NUMA domains
-	 * among the online CPUs and the NUMA domains don't perfectly overlaps
-	 * with the LLC domains.
-	 *
-	 * If all CPUs belong to the same NUMA node and the same LLC domain,
-	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
-	 * for an idle CPU in the same domain twice is redundant.
-	 */
-	nr_cpus = numa_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
-			enable_numa = true;
-		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
-			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
-	}
-	rcu_read_unlock();
-
-	pr_debug("sched_ext: LLC idle selection %s\n",
-		 enable_llc ? "enabled" : "disabled");
-	pr_debug("sched_ext: NUMA idle selection %s\n",
-		 enable_numa ? "enabled" : "disabled");
-
-	if (enable_llc)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-	if (enable_numa)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
-}
-
-/*
- * Built-in CPU idle selection policy:
- *
- * 1. Prioritize full-idle cores:
- *   - always prioritize CPUs from fully idle cores (both logical CPUs are
- *     idle) to avoid interference caused by SMT.
- *
- * 2. Reuse the same CPU:
- *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
- *     branch prediction optimizations.
- *
- * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
- *
- * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
- *
- * Step 3 and 4 are performed only if the system has, respectively, multiple
- * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
- * scx_selcpu_topo_numa).
- *
- * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
- * we never call ops.select_cpu() for them, see select_task_rq().
- */
-static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-			      u64 wake_flags, bool *found)
-{
-	const struct cpumask *llc_cpus = NULL;
-	const struct cpumask *numa_cpus = NULL;
-	s32 cpu;
-
-	*found = false;
-
-	/*
-	 * This is necessary to protect llc_cpus.
-	 */
-	rcu_read_lock();
-
-	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
-	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus()) {
-		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
-			numa_cpus = numa_span(prev_cpu);
-
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
-	}
-
-	/*
-	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
-	 */
-	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
-
-		/*
-		 * If the waker's CPU is cache affine and prev_cpu is idle,
-		 * then avoid a migration.
-		 */
-		if (cpus_share_cache(cpu, prev_cpu) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * If the waker's local DSQ is empty, and the system is under
-		 * utilized, try to wake up @p to the local DSQ of the waker.
-		 *
-		 * Checking only for an empty local DSQ is insufficient as it
-		 * could give the wakee an unfair advantage when the system is
-		 * oversaturated.
-		 *
-		 * Checking only for the presence of idle CPUs is also
-		 * insufficient as the local DSQ of the waker could have tasks
-		 * piled up on it even if there is an idle core elsewhere on
-		 * the system.
-		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
-				goto cpu_found;
-		}
-	}
-
-	/*
-	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
-	 * partially idle @prev_cpu.
-	 */
-	if (sched_smt_active()) {
-		/*
-		 * Keep using @prev_cpu if it's part of a fully idle core.
-		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * Search for any fully idle core in the same LLC domain.
-		 */
-		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
-		/*
-		 * Search for any fully idle core in the same NUMA node.
-		 */
-		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
-		/*
-		 * Search for any full idle core usable by the task.
-		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Use @prev_cpu if it's idle.
-	 */
-	if (test_and_clear_cpu_idle(prev_cpu)) {
-		cpu = prev_cpu;
-		goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU in the same LLC domain.
-	 */
-	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU in the same NUMA node.
-	 */
-	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU usable by the task.
-	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
-	if (cpu >= 0)
-		goto cpu_found;
-
-	rcu_read_unlock();
-	return prev_cpu;
-
-cpu_found:
-	rcu_read_unlock();
-
-	*found = true;
-	return cpu;
-}
-
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
 	/*
@@ -3634,52 +3214,6 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 (struct cpumask *)p->cpus_ptr);
 }
 
-static void reset_idle_masks(void)
-{
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
-}
-
-void __scx_update_idle(struct rq *rq, bool idle)
-{
-	int cpu = cpu_of(rq);
-
-	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
-		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
-			return;
-	}
-
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
-
-#ifdef CONFIG_SCHED_SMT
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-
-		if (idle) {
-			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
-			 */
-			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
-					return;
-			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
-		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		}
-	}
-#endif
-}
-
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	int cpu = cpu_of(rq);
@@ -3719,12 +3253,6 @@ static void rq_offline_scx(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 }
 
-#else	/* CONFIG_SMP */
-
-static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
-static void reset_idle_masks(void) {}
-
 #endif	/* CONFIG_SMP */
 
 static bool check_rq_for_timeouts(struct rq *rq)
@@ -6290,55 +5818,6 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
-#include <linux/btf_ids.h>
-
-__bpf_kfunc_start_defs();
-
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
-__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-				       u64 wake_flags, bool *is_idle)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		goto prev_cpu;
-	}
-
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
-#ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
-#endif
-
-prev_cpu:
-	*is_idle = false;
-	return prev_cpu;
-}
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
-BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
-
-static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_select_cpu,
-};
-
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
@@ -7400,149 +6879,6 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
-/**
- * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
- *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-#ifdef CONFIG_SMP
-	return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
-}
-
-/**
- * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
- *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-#ifdef CONFIG_SMP
-	if (sched_smt_active())
-		return idle_masks.smt;
-	else
-		return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
-}
-
-/**
- * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
- * either the percpu, or SMT idle-tracking cpumask.
- */
-__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
-{
-	/*
-	 * Empty function body because we aren't actually acquiring or releasing
-	 * a reference to a global idle cpumask, which is read-only in the
-	 * caller and is never released. The acquire / release semantics here
-	 * are just used to make the cpumask a trusted pointer in the caller.
-	 */
-}
-
-/**
- * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
- * @cpu: cpu to test and clear idle for
- *
- * Returns %true if @cpu was idle and its idle state was successfully cleared.
- * %false otherwise.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return false;
-	}
-
-	if (ops_cpu_valid(cpu, NULL))
-		return test_and_clear_cpu_idle(cpu);
-	else
-		return false;
-}
-
-/**
- * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
- * number on success. -%EBUSY if no matching cpu was found.
- *
- * Idle CPU tracking may race against CPU scheduling state transitions. For
- * example, this function may return -%EBUSY as CPUs are transitioning into the
- * idle state. If the caller then assumes that there will be dispatch events on
- * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
- * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
- * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
- * event in the near future.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
-				      u64 flags)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return -EBUSY;
-	}
-
-	return scx_pick_idle_cpu(cpus_allowed, flags);
-}
-
-/**
- * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
- * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
- * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
- * empty.
- *
- * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
- * set, this function can't tell which CPUs are idle and will always pick any
- * CPU.
- */
-__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
-				     u64 flags)
-{
-	s32 cpu;
-
-	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
-		if (cpu >= 0)
-			return cpu;
-	}
-
-	cpu = cpumask_any_distribute(cpus_allowed);
-	if (cpu < nr_cpu_ids)
-		return cpu;
-	else
-		return -EBUSY;
-}
-
 /**
  * scx_bpf_task_running - Is task currently running?
  * @p: task of interest
@@ -7620,12 +6956,6 @@ BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
-BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
new file mode 100644
index 000000000000..9e8479dd7277
--- /dev/null
+++ b/kernel/sched/ext_idle.c
@@ -0,0 +1,686 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Built-in idle CPU tracking policy.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
+ */
+
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_CPUMASK_OFFSTACK
+#define CL_ALIGNED_IF_ONSTACK
+#else
+#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
+#endif
+
+static struct {
+	cpumask_var_t cpu;
+	cpumask_var_t smt;
+} idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
+
+static bool test_and_clear_cpu_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
+	 * cluster is not wholly idle either way. This also prevents
+	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
+	 */
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+
+		/*
+		 * If offline, @cpu is not its own sibling and
+		 * scx_pick_idle_cpu() can get caught in an infinite loop as
+		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
+		 * is eventually cleared.
+		 */
+		if (cpumask_intersects(smt, idle_masks.smt))
+			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_masks.smt))
+			__cpumask_clear_cpu(cpu, idle_masks.smt);
+	}
+#endif
+	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+{
+	int cpu;
+
+retry:
+	if (sched_smt_active()) {
+		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+
+		if (flags & SCX_PICK_IDLE_CORE)
+			return -EBUSY;
+	}
+
+	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+
+found:
+	if (test_and_clear_cpu_idle(cpu))
+		return cpu;
+	else
+		goto retry;
+}
+
+/*
+ * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
+ * domain is not defined).
+ */
+static unsigned int llc_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sd->span_weight;
+}
+
+/*
+ * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
+ * domain is not defined).
+ */
+static struct cpumask *llc_span(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sched_domain_span(sd);
+}
+
+/*
+ * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
+ * NUMA domain is not defined).
+ */
+static unsigned int numa_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return 0;
+	sg = sd->groups;
+	if (!sg)
+		return 0;
+
+	return sg->group_weight;
+}
+
+/*
+ * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
+ * domain is not defined).
+ */
+static struct cpumask *numa_span(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return NULL;
+	sg = sd->groups;
+	if (!sg)
+		return NULL;
+
+	return sched_group_span(sg);
+}
+
+/*
+ * Return true if the LLC domains do not perfectly overlap with the NUMA
+ * domains, false otherwise.
+ */
+static bool llc_numa_mismatch(void)
+{
+	int cpu;
+
+	/*
+	 * We need to scan all online CPUs to verify whether their scheduling
+	 * domains overlap.
+	 *
+	 * While it is rare to encounter architectures with asymmetric NUMA
+	 * topologies, CPU hotplugging or virtualized environments can result
+	 * in asymmetric configurations.
+	 *
+	 * For example:
+	 *
+	 *  NUMA 0:
+	 *    - LLC 0: cpu0..cpu7
+	 *    - LLC 1: cpu8..cpu15 [offline]
+	 *
+	 *  NUMA 1:
+	 *    - LLC 0: cpu16..cpu23
+	 *    - LLC 1: cpu24..cpu31
+	 *
+	 * In this case, if we only check the first online CPU (cpu0), we might
+	 * incorrectly assume that the LLC and NUMA domains are fully
+	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
+	 * domains).
+	 */
+	for_each_online_cpu(cpu)
+		if (llc_weight(cpu) != numa_weight(cpu))
+			return true;
+
+	return false;
+}
+
+/*
+ * Initialize topology-aware scheduling.
+ *
+ * Detect if the system has multiple LLC or multiple NUMA domains and enable
+ * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
+ * selection policy.
+ *
+ * Assumption: the kernel's internal topology representation assumes that each
+ * CPU belongs to a single LLC domain, and that each LLC domain is entirely
+ * contained within a single NUMA node.
+ */
+static void update_selcpu_topology(void)
+{
+	bool enable_llc = false, enable_numa = false;
+	unsigned int nr_cpus;
+	s32 cpu = cpumask_first(cpu_online_mask);
+
+	/*
+	 * Enable LLC domain optimization only when there are multiple LLC
+	 * domains among the online CPUs. If all online CPUs are part of a
+	 * single LLC domain, the idle CPU selection logic can choose any
+	 * online CPU without bias.
+	 *
+	 * Note that it is sufficient to check the LLC domain of the first
+	 * online CPU to determine whether a single LLC domain includes all
+	 * CPUs.
+	 */
+	rcu_read_lock();
+	nr_cpus = llc_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus())
+			enable_llc = true;
+		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
+			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
+	}
+
+	/*
+	 * Enable NUMA optimization only when there are multiple NUMA domains
+	 * among the online CPUs and the NUMA domains don't perfectly overlaps
+	 * with the LLC domains.
+	 *
+	 * If all CPUs belong to the same NUMA node and the same LLC domain,
+	 * enabling both NUMA and LLC optimizations is unnecessary, as checking
+	 * for an idle CPU in the same domain twice is redundant.
+	 */
+	nr_cpus = numa_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus() && llc_numa_mismatch())
+			enable_numa = true;
+		pr_debug("sched_ext: NUMA=%*pb weight=%u\n",
+			 cpumask_pr_args(numa_span(cpu)), numa_weight(cpu));
+	}
+	rcu_read_unlock();
+
+	pr_debug("sched_ext: LLC idle selection %s\n",
+		 enable_llc ? "enabled" : "disabled");
+	pr_debug("sched_ext: NUMA idle selection %s\n",
+		 enable_numa ? "enabled" : "disabled");
+
+	if (enable_llc)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+	if (enable_numa)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_numa);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
+}
+
+/*
+ * Built-in CPU idle selection policy:
+ *
+ * 1. Prioritize full-idle cores:
+ *   - always prioritize CPUs from fully idle cores (both logical CPUs are
+ *     idle) to avoid interference caused by SMT.
+ *
+ * 2. Reuse the same CPU:
+ *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
+ *     branch prediction optimizations.
+ *
+ * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ *   - if the above conditions aren't met, pick a CPU that shares the same LLC
+ *     to maintain cache locality.
+ *
+ * 4. Pick a CPU within the same NUMA node, if enabled:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * Step 3 and 4 are performed only if the system has, respectively, multiple
+ * LLC domains / multiple NUMA nodes (see scx_selcpu_topo_llc and
+ * scx_selcpu_topo_numa).
+ *
+ * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
+ * we never call ops.select_cpu() for them, see select_task_rq().
+ */
+static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+			      u64 wake_flags, bool *found)
+{
+	const struct cpumask *llc_cpus = NULL;
+	const struct cpumask *numa_cpus = NULL;
+	s32 cpu;
+
+	*found = false;
+
+	/*
+	 * This is necessary to protect llc_cpus.
+	 */
+	rcu_read_lock();
+
+	/*
+	 * Determine the scheduling domain only if the task is allowed to run
+	 * on all CPUs.
+	 *
+	 * This is done primarily for efficiency, as it avoids the overhead of
+	 * updating a cpumask every time we need to select an idle CPU (which
+	 * can be costly in large SMP systems), but it also aligns logically:
+	 * if a task's scheduling domain is restricted by user-space (through
+	 * CPU affinity), the task will simply use the flat scheduling domain
+	 * defined by user-space.
+	 */
+	if (p->nr_cpus_allowed >= num_possible_cpus()) {
+		if (static_branch_maybe(CONFIG_NUMA, &scx_selcpu_topo_numa))
+			numa_cpus = numa_span(prev_cpu);
+
+		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+			llc_cpus = llc_span(prev_cpu);
+	}
+
+	/*
+	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
+	 */
+	if (wake_flags & SCX_WAKE_SYNC) {
+		cpu = smp_processor_id();
+
+		/*
+		 * If the waker's CPU is cache affine and prev_cpu is idle,
+		 * then avoid a migration.
+		 */
+		if (cpus_share_cache(cpu, prev_cpu) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * If the waker's local DSQ is empty, and the system is under
+		 * utilized, try to wake up @p to the local DSQ of the waker.
+		 *
+		 * Checking only for an empty local DSQ is insufficient as it
+		 * could give the wakee an unfair advantage when the system is
+		 * oversaturated.
+		 *
+		 * Checking only for the presence of idle CPUs is also
+		 * insufficient as the local DSQ of the waker could have tasks
+		 * piled up on it even if there is an idle core elsewhere on
+		 * the system.
+		 */
+		if (!cpumask_empty(idle_masks.cpu) &&
+		    !(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				goto cpu_found;
+		}
+	}
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if (sched_smt_active()) {
+		/*
+		 * Keep using @prev_cpu if it's part of a fully idle core.
+		 */
+		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * Search for any fully idle core in the same LLC domain.
+		 */
+		if (llc_cpus) {
+			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
+		/*
+		 * Search for any fully idle core in the same NUMA node.
+		 */
+		if (numa_cpus) {
+			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
+		/*
+		 * Search for any full idle core usable by the task.
+		 */
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Use @prev_cpu if it's idle.
+	 */
+	if (test_and_clear_cpu_idle(prev_cpu)) {
+		cpu = prev_cpu;
+		goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU in the same LLC domain.
+	 */
+	if (llc_cpus) {
+		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU in the same NUMA node.
+	 */
+	if (numa_cpus) {
+		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU usable by the task.
+	 */
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		goto cpu_found;
+
+	rcu_read_unlock();
+	return prev_cpu;
+
+cpu_found:
+	rcu_read_unlock();
+
+	*found = true;
+	return cpu;
+}
+
+static void reset_idle_masks(void)
+{
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	cpumask_copy(idle_masks.cpu, cpu_online_mask);
+	cpumask_copy(idle_masks.smt, cpu_online_mask);
+}
+
+void __scx_update_idle(struct rq *rq, bool idle)
+{
+	int cpu = cpu_of(rq);
+
+	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
+		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
+			return;
+	}
+
+	if (idle)
+		cpumask_set_cpu(cpu, idle_masks.cpu);
+	else
+		cpumask_clear_cpu(cpu, idle_masks.cpu);
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+
+		if (idle) {
+			/*
+			 * idle_masks.smt handling is racy but that's fine as
+			 * it's only for optimization and self-correcting.
+			 */
+			for_each_cpu(cpu, smt) {
+				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+					return;
+			}
+			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+		} else {
+			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+		}
+	}
+#endif
+}
+
+#else	/* !CONFIG_SMP */
+
+static bool test_and_clear_cpu_idle(int cpu) { return false; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static void reset_idle_masks(void) {}
+
+#endif	/* CONFIG_SMP */
+
+
+/********************************************************************************
+ * Helpers that can be called from the BPF scheduler.
+ */
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+				       u64 wake_flags, bool *is_idle)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		goto prev_cpu;
+	}
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		goto prev_cpu;
+
+#ifdef CONFIG_SMP
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+#endif
+
+prev_cpu:
+	*is_idle = false;
+	return prev_cpu;
+}
+
+/**
+ * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	return idle_masks.cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask. Can be used to determine if an entire physical
+ * core is free.
+ *
+ * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+#ifdef CONFIG_SMP
+	if (sched_smt_active())
+		return idle_masks.smt;
+	else
+		return idle_masks.cpu;
+#else
+	return cpu_none_mask;
+#endif
+}
+
+/**
+ * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
+ * either the percpu, or SMT idle-tracking cpumask.
+ */
+__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or releasing
+	 * a reference to a global idle cpumask, which is read-only in the
+	 * caller and is never released. The acquire / release semantics here
+	 * are just used to make the cpumask a trusted pointer in the caller.
+	 */
+}
+
+/**
+ * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
+ * @cpu: cpu to test and clear idle for
+ *
+ * Returns %true if @cpu was idle and its idle state was successfully cleared.
+ * %false otherwise.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return false;
+	}
+
+	if (ops_cpu_valid(cpu, NULL))
+		return test_and_clear_cpu_idle(cpu);
+	else
+		return false;
+}
+
+/**
+ * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
+ * number on success. -%EBUSY if no matching cpu was found.
+ *
+ * Idle CPU tracking may race against CPU scheduling state transitions. For
+ * example, this function may return -%EBUSY as CPUs are transitioning into the
+ * idle state. If the caller then assumes that there will be dispatch events on
+ * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
+ * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
+ * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
+ * event in the near future.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu(cpus_allowed, flags);
+}
+
+/**
+ * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
+ * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
+ * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
+ * empty.
+ *
+ * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
+ * set, this function can't tell which CPUs are idle and will always pick any
+ * CPU.
+ */
+__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
+				     u64 flags)
+{
+	s32 cpu;
+
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
+		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	cpu = cpumask_any_distribute(cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	else
+		return -EBUSY;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_select_cpu,
+};
-- 
2.47.1


