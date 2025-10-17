Return-Path: <bpf+bounces-71190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C67BBE7D4B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 11:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F2B400EAC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F22D7DE4;
	Fri, 17 Oct 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pjvhbLZ4"
X-Original-To: bpf@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD162DA775;
	Fri, 17 Oct 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693635; cv=fail; b=lr8IRiVrMhQgx0gKV0G54eIQtshxnfOIOIQy/vFiTeEFc01d6dOGWe3Euu/L3u4dJflWnK2vHr9y+DGfx0umpsnNing7oDUgxYHAFLc2yf1+brHWj/rWGA7G9ewO3QmpnNB1R+cyRaTIkS0VN/FV3XHApKM4t/CG7WZGcKL5d4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693635; c=relaxed/simple;
	bh=0W5u5S+fISUi03wvZzGoPgNOF67Pnbl02tRsLgbDMR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBaExyRL+4zuqngw6IYUOJNsG30CJnds4kzDpIysXLnGtmL5its/c/ZvbUAhF8Q6HQfO7iEeOBeB8r5Jypvk0tb8Al0mO+nEswn1x46DUgTWY/98o3043R108QygwJCbBJmch48OSD3Boxgg9UDwLtn0Jc5i8YebDanS5XoHITI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pjvhbLZ4; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhdwetubeR5lhv3yySWUe5xbMgDXXyWAM4BkbDDDf92xK3V8S3rr/BrZdHBM+2X3nCe1r6lBZmXlsj2OAqBJjbGBzsHd7ptRDaItx9aVw+BzOfaIviZB8xPjzHlskGtDEZJwDbREmjXL/nNNFwaNRJRn/5A7eySOhz3/3Ev0SduISCBejU/cA3gQ9eVzYTLHiny6XXhpL/2EhgC55Qj6MD3NEEJ7mNCEtQ5Mwg+jn0DMooxdPnEgPpS1ELRKhuGY9CpDqJnFDTgQLptkoOSTyf86Dh/jo4kd54hbO90tcPaM1GdTmhaW4WPlbasNC7MT8bSDmbB8wLABNsINZk2+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpetSQCcbNuHfNDzX5jOccoNuAL+ho5nfr19FWXMNqw=;
 b=T/RzVWedyLQJzyRlosswhDTJzdHy/KtEdgpSSFxl0IIQp9YOBIu+tTeRS7k6YbYqkp6ASwK+Y2Gek5LZV9624c1t/5aPegZFNhpyRRjRSefgTPToFuCIzvuBWUQ2YLXCgWCEGxoKSnbtTG20/Xy+CC98Lo6ZikF2TuhJvUz+IHtl2p+gQ37sW+n7MJNmWbYq5qgh//SPocCAMIjJ/mx7nJIFDh1T44yFQnFP7dCCECjgikz/FKOR8aNILysGTOxMvI8cbgcEzvqVipaQ5SYF/p/tbvSzdWQgJacPg3z2rq5xDzW388jbdot7NaYOEMPn6Oqxig2UX0qbLL+axAKWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpetSQCcbNuHfNDzX5jOccoNuAL+ho5nfr19FWXMNqw=;
 b=pjvhbLZ4smJdtLWi+3q9mTu049zns+q4QWGIbrKewnBsqHpD+oeFTly7jCaThPk2m/L4lCAO4+dp3KKuu2OXiywPpYx9YhFEsy6lg+sPrztTrx4quv1LESYvmqJOu3bUfTaPcKmxL1DVF1gPJjYSDarGG1gJlNh/Jf2MN1/xf332qHrsNHZNhySqicSiglkroDtF1AuVrdtSsg/RFZmm2khX0PlACokq7kFGeSPSzCI2qB6HixwTyLT57ehVW+YUiXm73mlxaHuefLzA6VD3R7B3ZHxHKq5X6SJiQpF1F8kCDVE03qIvZYajmyq5agByPve0B+YZOyLJMuOoRMn3DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:33:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 09:33:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] sched/deadline: Add support to remove DL server's bandwidth contribution
Date: Fri, 17 Oct 2025 11:25:55 +0200
Message-ID: <20251017093214.70029-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017093214.70029-1-arighi@nvidia.com>
References: <20251017093214.70029-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc8f6ed-d097-4a60-e9b3-08de0d604772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lx8TWrFlHXZsvT9GRO5IHO9SMeJ04OSPlsixjSDPJlrI7F5OaN1cFaXgWqur?=
 =?us-ascii?Q?CgvXie013GcPwBxotLPcmfAqOWCo3a784hGfQsGPaojl7z8WHlQaOk6RkxYg?=
 =?us-ascii?Q?WjEw+5BKqEg596vv55LPeN3Ja7vfwahxqJTWEhOdb8ZOnSuA+vn42WutS9UV?=
 =?us-ascii?Q?wzECpf5fyFqY+ostoNgigweLxliL4ugC6rMpn3V6uTvX3lHowWoTK9CoHLJS?=
 =?us-ascii?Q?fbjLxGi8CSnuQebuODPo7wn4wf5S+MKoCQWKm+sxCE/FS5iwDk8AIUNbfkod?=
 =?us-ascii?Q?daiceZRS+q8siBEFrp+ShJdWY372Akh98i6nybd6THqiYdeRBPGDk9ogcL/v?=
 =?us-ascii?Q?A9BQAYH2NyBJpVgY6grXCeZcZnVhbLBlrLayhZeWZU7XLl8htC7O/Ak3w5/V?=
 =?us-ascii?Q?d2MZ13wqq/5Stf4yU9qatpiUyVzEtS8M3IjRQdVSvL4dZB8YCYxbmMFEv9WF?=
 =?us-ascii?Q?xHC9mf1hXw64YlDRhxc6z3aeNFxlykWXw+O8iy6z+dwYClfUgazoOzbd68CL?=
 =?us-ascii?Q?djR+x/MODR4z3oXJzJv8dB1gkYOuORdRveATtNRm5VpxYnFYmogGG7pZm3CN?=
 =?us-ascii?Q?l+SodOMJGBY48Pbr5hWs7TzxAnOdgloOIgds9Ejg0N6M/9XbDErc/SiqSnbI?=
 =?us-ascii?Q?S1rGue+Zbrw67gmZQyTh9y13+zbL3H8IPQQ9EF5CNYrB+KgdUlxr7KviCl9n?=
 =?us-ascii?Q?qUV45GgH4l1UbaNCAgjreHk3BG0iUWze7SrXZJ818aFmJ6NlHMh/LOIb5+sd?=
 =?us-ascii?Q?J0pKNDw9r18VoOnEhcO/LIczaB5ZRGWlMzuI3xx2lzOvOdQVjkEmjgbN7ZOU?=
 =?us-ascii?Q?f/r55rNinHcelYYLtzuACQAjuQgrkyjuQ+D7cA0ZTeg5389m0zIjJFpLgRZA?=
 =?us-ascii?Q?XJpxRr12mey1kOXzB2JTnXp/WgoUvVpOQSl0y2z6E0vA5lsEcEyu0MweiCdf?=
 =?us-ascii?Q?vNPxze1rPqAFfeu/jrDFz139xDpzk7aO8+Z6haXL2BbQlFujYzPdo2tOPEqw?=
 =?us-ascii?Q?CXZGrG48mjIaKyNVrQMTpkGFmI1js5Pu7rZjRr4w3EeVH/6L7wi9EIMEdbvk?=
 =?us-ascii?Q?nm2DIEeHTN8SFHuhZ8oW1kYgQAx663mK8/dY+xuafZzfQiimkrcvqjHRFWgi?=
 =?us-ascii?Q?U0o1ZR7molyLhJB9s+FpNleDrVLGiX6JR18bfHZy4XKQr7QG2FjWowNZiY0z?=
 =?us-ascii?Q?iq8FPksNd18iq2iKAsDK+uZnB+qSkuQvp8QieKfcafF1sgMsPY4W20U06pKH?=
 =?us-ascii?Q?yzdaOOrSIzi6uoYlbM2+eaOnl+bRMh0GRp6EXFoNoIEvEgAAImZeue01ao3R?=
 =?us-ascii?Q?KSuzzcCv7C3en/3P4yf8v/N3hu7P80n2+ZUQAOO8Q0M6iltPbG8yGsuG2kx6?=
 =?us-ascii?Q?3v5YeQJRe847pZjA0gfSUYaVznbLGbfsaFRXI4kWGrljG6wxkDmIP3q/WYu1?=
 =?us-ascii?Q?NGbHb0X2AiYQBp6Tm48gs2AYnaG56Fbc8Jvy39uFxZ7r9QU8ZP8MBKfFkoDp?=
 =?us-ascii?Q?Hl4eS5kIxtVg6k8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUoOvh7gD4mdhU/FAF4aH8TjUbCmKSlTm1dBQYOy6ADmT7Nnv/RTX4sk/KRH?=
 =?us-ascii?Q?NjfFEmjpAHduKWhyUSrKtieaKr0gO89DHbaC58mgBYoFJB2rCJTM6nU9NpnN?=
 =?us-ascii?Q?7F2z/McUSeKwhZxba5MmS13CxgXxrV6kW4UboS0JAASnqFgqUgVETelWW2jC?=
 =?us-ascii?Q?EYNkt0aM+R+GvwbSXmwwDcWVOru8CTxhqfEyadMjcTNnfT147CbYlD4BitCd?=
 =?us-ascii?Q?/h1kyjvfAu/ifRu92mIbT0oc6swthgQ474uflAGnBXoGOHysZozr4qAUFbXC?=
 =?us-ascii?Q?LRaSTtNsMF4E1s461GyeZulJWyTPthHLmm2ib+ZvURqJex7MS4DpKCOa0LHN?=
 =?us-ascii?Q?wxDtOgv3Z5HXwlcWZXj2Kn2UVirowu9BsgHQ5GlX/HAWAjijoa5004vSqavz?=
 =?us-ascii?Q?BxMjMCpBYX/pe2F3MlAOLnilu2krI9vFmLiLsfObH61UY2LaBoMQC2DPrWY/?=
 =?us-ascii?Q?qKf+vN1VebaH17Py1dUFniZ5HkYF6o9uKhbHyQlmiGubnjQDOuL88rXyRqoF?=
 =?us-ascii?Q?hAeV4r17vhvIAMmxFGE7HQLBaS9WFf68ZlcBDzj624ADsxe3O0OOSUZuqYA5?=
 =?us-ascii?Q?BKDnd+EDX8lLLfy29vAuf55AZt/wUivoz/eeTzpBUiDwjkVrp7VWX76RVd8J?=
 =?us-ascii?Q?DEqJdB76JYC8+rrcwrv5zwHNdc6IISxl8Maht03f1agDRawkaByB24j4J2Ch?=
 =?us-ascii?Q?rfnIIf+BD+LwONpNMs2ygdvWN9blDF9pt6YwoQf4oLpeBDDNIZ5rUDydodZq?=
 =?us-ascii?Q?w94xERzWMhWYcTSWJUHxCSD7ugvwH6q9l7Eq8ct6RGQHJqUKd6ehdBE1LYKJ?=
 =?us-ascii?Q?WVFDqERdcCpcT6n4iJ+g/ovMhgfWAi1k2oGdXe92vhu0vCs3MAS7UJ1xb/Mu?=
 =?us-ascii?Q?Si3Mkjz32OSSvRaJ4WtIhwFOglAaGShYikn6XO6ZkyWDE7L6KRzbOx/gm3IP?=
 =?us-ascii?Q?rR6OgDUDcYVhldzaZivgX0PFKh5Wx12YkqrzcR+dkbZ1zw8pLF8EHE0wQAFN?=
 =?us-ascii?Q?HQ5OBG5OeqgZeJVJDEPZUzzjgpfVZqZAHY8WaLszW/0W10kq0mueP1DY/os9?=
 =?us-ascii?Q?EOTv/4/Al5yaDQUtI697tH/eoYz1+2aUpEc7u6lOJAVFPtfnvj4WywRH3B/c?=
 =?us-ascii?Q?aHMgqJAdCq1ki08o10vu+aPyqb3xGg77eBsmYs0Uu1CUw/KI7krr1MqIBc2S?=
 =?us-ascii?Q?MGNJrgSqAColSgasnUagNlptrOZxVHBuFF/R1735D8pGnawxr8SKxSYNV7ek?=
 =?us-ascii?Q?apBvEWyrZx0mqEldTy/CF6XDmHfLw0FKgGQ/uRgyyrjzOx3QM628mK8sts14?=
 =?us-ascii?Q?d5X+H5qAtquQITGIDCWkLJqgn5RsGhe3xRjyK3ofKCdwbRVz3MBDmQlxFRBx?=
 =?us-ascii?Q?r9CURAcX7Bdp5sU+cuBVzFwpy/Z1HoV3xc6YTCeWnEKuvY9R+HcOxLMT61Wr?=
 =?us-ascii?Q?tj8ltv9LBAuvJgd0gtpbey1ehJLkDYPW579RQTnU+NeEYSUm2YvCDsrTjsbR?=
 =?us-ascii?Q?5mAYhn7KICaCuMBrJnARAOlONFDOBFuVAEy/eF0I5biqOTHslpEmwd0c3uZH?=
 =?us-ascii?Q?N8jAFCO75UYuDSptv0PnJM3o7ETDK6mIwxJPBcJS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc8f6ed-d097-4a60-e9b3-08de0d604772
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:33:50.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqgbg3erkNsC40wVvcTjD5U4R3tAXKB6YHY1K3Kj15YPo0emhX7GfCcXdtnKdtK+YtZaKW2rdgUJ5mXCXqYYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

During switching from sched_ext to FAIR tasks and vice-versa, we need
support for removing the bandwidth contribution of either DL server. Add
support for the same.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  1 +
 2 files changed, 32 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3c1fd2190949e..d585be4014427 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1684,6 +1684,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
 
+	/* Clear these so that the dl_server is reinitialized */
+	if (new_bw == 0) {
+		dl_se->dl_defer = 0;
+		dl_se->dl_server = 0;
+	}
+
 	dl_se->dl_runtime = runtime;
 	dl_se->dl_deadline = period;
 	dl_se->dl_period = period;
@@ -1697,6 +1703,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return retval;
 }
 
+/**
+ * dl_server_remove_params - Remove bandwidth reservation for a DL server
+ * @dl_se: The DL server entity to remove bandwidth for
+ *
+ * This function removes the bandwidth reservation for a DL server entity,
+ * cleaning up all bandwidth accounting and server state.
+ *
+ * Returns: 0 on success, negative error code on failure
+ */
+int dl_server_remove_params(struct sched_dl_entity *dl_se)
+{
+	if (!dl_se->dl_server)
+		return 0; /* Already disabled */
+
+	/*
+	 * First dequeue if still queued. It should not be queued since
+	 * we call this only after the last dl_server_stop().
+	 */
+	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
+		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+
+	/* Remove bandwidth reservation */
+	return dl_server_apply_params(dl_se, 0, dl_se->dl_period, false);
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 55f8fbb306517..2c1404e961171 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -419,6 +419,7 @@ extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
+extern int dl_server_remove_params(struct sched_dl_entity *dl_se);
 
 static inline bool dl_server_active(struct sched_dl_entity *dl_se)
 {
-- 
2.51.0


