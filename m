Return-Path: <bpf+bounces-67269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40362B41A9F
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68911BA5575
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502B2F4A1B;
	Wed,  3 Sep 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKs7FqLh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573B2F49F6;
	Wed,  3 Sep 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893066; cv=fail; b=WfidogpTDa9qxZaEe//xlsK+J30d6k1uDpmHsCBjLJ7SglMfc99CPAnHTC2ozNobH1To+a/TuZItu4/2ePnQdeZ3pKt4H0x9ai4KGlcxinslVd57gw1gBIoJ7SYzpM7O5uMp8P44BdonK3TQTlWST1f3IIJvzbRGbE1rptLtjac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893066; c=relaxed/simple;
	bh=ncofq7nxMcp4q9fagk/IbO2msZnX5B+nio9mW5qX79s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QrYhjRFEucNiwOmrJQTrv8MnXwf5Gdp8XX5t0uU9lt/DdBqwUPvZL/gFUe5zErSadr5gD1iUSKO0XqXOoceuW3XeWq6gsVtLWclmlizynf1tqLIHT9FTHZf4iiOJjSNQO5gwWUPcM6QHr+HIzVlYxBaDr6PrNGi+Bd1e0fWgFUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKs7FqLh; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8wz66hR2hBBzIwVCvng/qKHaPqBDYefiva9LYlz/vrr9CwDVWFm/yNlgbOS8q4WlgwkNWhTjFze4VTwEYFZEiaoPeAjvirrtw7q+vzch1Zk4pK1oWRCqQFc3g1Ls4+HiwgMI8xZ7EVp5mgZ2I/POZNl9hNQf0gy9ujPRhb1JHuPMoOeab4lgHv6ertt3BcXEUyaEk/kRb18bP1lr6Ng9Z9ZtI2IQHeIin1HrSl4NATMc475VEfszu7Zlfl4tslUlYQcDJBGeBvD6gy8+rRyhlToHsUEhrtyHFadoZ8HnoUyIIGoADKtZabE0zdS6kixjRo1ZSa+kfwUvc6e/Gx5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW3/QoN4Z1dmw6myvDBzU7EDMIyj8vd+YC/XdtKa3/Q=;
 b=MdREHdjbW4lOL9mrxTWb4Mgkz3InyVT0LQs49GrTvwKt/o8AZWdJ/uUGPERzOrs2DRiAGTqaJGw72nCZ6Ap0JNiCq4M/EBhHDvXkqLL7IZYtI/RrKJWgZqErcY4ct/3mhdpzrmpa33J9VqLv7jGxuMGixTWhIVVXV1Hsf9F7AvKmtmMj1bUIZqGz3iVOGeZFRpsPAFLrsmRvs0HMBCaMIe6U/oEtd/BUM0p1NBnqHvJjmqd11HupsH2voUCrGdnnXL98mIY+Obi18GvZMtNSqvcvISmAAVuSGcMgBmmiLoAvGtDtMvD8Zy+aehehUrVIvNpScLq24vaGUcbbvc0pmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW3/QoN4Z1dmw6myvDBzU7EDMIyj8vd+YC/XdtKa3/Q=;
 b=FKs7FqLhRtzerrCIVqm6IJmnmQ8jgjsiJmHKndKh/qA+mxR63HY3eFzdoEa48BeeYhR1cBAG92k0veHMsqlfWt+JQm2ON0gUtxuZ63ffeeY/OUXv801SHaskAvUzEhBdsCSZ146DfdpS/jugqSlc80PoPjpjnyi9Ds8kyTZscUm/4/Et3DhwDfAre8R9dQgA4w548uaoglEw1FxtItlcd6eQrhHEML9ndLajlx+BbjCUUvKVrBr1ne5YM0C6rQdHGtWrQ2xrd+SaG6l+NPXoor/zTi9ErvnOYvbKCZFBZD62GYlehdBTpJ5Sscxn0hW/3cEtDhx74YQDZNgxq7eRgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:51:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:51:02 +0000
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
Subject: [PATCH 12/16] sched_ext: Selectively enable ext and fair DL servers
Date: Wed,  3 Sep 2025 11:33:38 +0200
Message-ID: <20250903095008.162049-13-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903095008.162049-1-arighi@nvidia.com>
References: <20250903095008.162049-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: b61ae2c6-dd02-4df2-e498-08ddeacf6467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIwzAt4UDibBRCaluB1hH0SBdAnGtkHI99HeiUNFcYfCo6TaiKgTTgWXPePq?=
 =?us-ascii?Q?DSFfAGqlsJSZXydB/LDbeZEv3KAU9LFV6BRe9qGvfs9jtoRMrirmVcUDLgtW?=
 =?us-ascii?Q?009PvV0rGnJDj2MkNXJ0T3GiDTf+DNN6cQv3nCPjnTQTXhu8z7zBWf/paO/U?=
 =?us-ascii?Q?QI7aMSD8vkuwpGxQ0wed3TGafpmGnBde7R5cqtW5BCLsCgyDM9UUAi+Sahwu?=
 =?us-ascii?Q?xZ38ueCtE33Az1qYISTqr/VaUJuplAhnXW3/jyaGbYqOtShu5gIBfhYxTR5Z?=
 =?us-ascii?Q?omsBQ41wbGu1FzBTk3WwUWvYlR9S1oToOt9x2dWBIDzPfvnsk/fDiF3ZqTdT?=
 =?us-ascii?Q?UrWy9dwTkB2WFsKAqyFui+8g2rHjffI36i4EvtAl4O8kXwdOPrP8eZP0uVGo?=
 =?us-ascii?Q?hw3/yKa5D21/uTVHWGxRPhtv4/t1IDWT1X3Tyz7Yg3K/fdH2mukfC6T75rKq?=
 =?us-ascii?Q?TCzJp52zHvixrhwHD6RLkj4k7DCMBBVgtL+PhCN4HeUdn9+rwZw4/iOLttye?=
 =?us-ascii?Q?D5MISjc1rqHaYzcW9pYlXeqn0kgb2mkk2UwZq70WE3TnKCluuW0tIqkWeEuY?=
 =?us-ascii?Q?bqxcxigvVWGq57/NKMpAA1o4K1/hOKpgg39z7h8pm1m0MHiuSCUCJcOe4FX0?=
 =?us-ascii?Q?jdTkzZqzurcfg1SEbYlg9j0ngB5d3mh4ElyQr7RMjdWRlTBjpt9SBp019zqq?=
 =?us-ascii?Q?TevBKEDYmcltvLHU9C/SyUeWHkJoDnyxZNhAle6F9Xepef1bg6zCOklS/G3p?=
 =?us-ascii?Q?GMNX2Cn8Qo8DxYT4VKOeOtKhWf/xdMgEDlAMsFgjIUbFpiY1ktNXFIljazAj?=
 =?us-ascii?Q?J4rlPNejNq79nBFqp01277BmA/+XAaRC/sTtC+r//1Uz0V6A1cXJJZc6PnqC?=
 =?us-ascii?Q?jh2Af4M3Kce4WvnPxL7mNuKQsZdb1zZSDeWtBotmJLfml6YizwrA1XfRWww0?=
 =?us-ascii?Q?dnN3dwTfECa3XqQRntSMxggUZr5czq0eJCOJl7tAIfv8a9bEx5BposfsgVKa?=
 =?us-ascii?Q?1pFkzayBSeRLuYO0qjl8xtol2ltM5GscAwS1HwEbYd94o+ucfz/WE+tgJ0Xx?=
 =?us-ascii?Q?jQT+rPUhLnLqNh/Kf+YqJ4tzs281h/12kQm30jASL4A2eJkvANAwE3nkBa+H?=
 =?us-ascii?Q?GhejnNYyq1c3PEpxjGbunCeACbCXNFp5geGWiTmXhAUH30T0/eZqiOzoDLlU?=
 =?us-ascii?Q?s9TQU1XSOZGaoE3W09SXwnw4PM4uBHr43hDXb4potqSzDQQPEMxeCyvVFxI6?=
 =?us-ascii?Q?3TsEkrUvm2hjEpQX7ee6Ix7rTploJ1ffcWbTsCmqoiHYWlJAd3hWlKOXUdRi?=
 =?us-ascii?Q?jF/mEMquKykRzCsCLKEOklQwBjFpNjJbA+GJPdqQ53aPAwdW8S0Vkv6OP+n1?=
 =?us-ascii?Q?LBRNR5MXYIWD/5KRDzKI572Cm4Bz0yOJ6sVPMCOf+6MBI2esnY937qwB4KTF?=
 =?us-ascii?Q?wS7uVB9SdiRchqP2ky69GAccY2tZ7A7XbKgTdrhSR/59r80kFkl/hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlMRfXive/8HLi1e0thoqkZbXMuvFENjaYMsC6bSze3vnnfmG8pcH6Ds77nP?=
 =?us-ascii?Q?fLOyhmjHR6jJaMqoTvxbeAoVJJYFz+54n65Yz2IO3/R4w59/wi2hbMzEFelY?=
 =?us-ascii?Q?lE4D++GNOs7skN0pywtsXjYmsSFgXwhk72bo8EI9eM2VU5btnYXGFOPwTJKM?=
 =?us-ascii?Q?CBrGpF76kkOTQ1obayBFmqUPsTTJLmZZQVzp+lWPP6w5PTaF8hRQE8BIJJg2?=
 =?us-ascii?Q?rBEbazmmy1krAN99/Vxjl1Va5q3BPtQYmUe+vilAHQwkWFjAizNF8w7Hzf2e?=
 =?us-ascii?Q?wJhQbUgkrwzSiKPj1io/+5kVJarq4Dvk8jmtzTFH9akz+VULPX9ZPd60jMu2?=
 =?us-ascii?Q?a5imwpRR31821dwkGzNYzl6cjDSb0Exu0GqtAtovh92vAJu2c5Jdu8a9OguZ?=
 =?us-ascii?Q?/HWpFXvTTchxd9QIiVwCoMvSeO87nGY8KwmKar/KF2zEsbHppKB6sC9SflRa?=
 =?us-ascii?Q?oL1SWzuQ39G/ENzYKo+zHW8R8f63cOeTSooNTzoBP82dJRahPn8uNOgPA1Z+?=
 =?us-ascii?Q?BQSFH+5VZYamDSWqAkuwkljxzlTgnvh6C5q6Uym2B8wpW9HspmcckJ0ny/Fu?=
 =?us-ascii?Q?ie3JHIXjxG1UtwgSo9TZZZTRvlmkx76k39CP7yEFCIzGSssJNQ659B8JG5t0?=
 =?us-ascii?Q?PkDx2SEVnneLOd29SDjQ86yfdh6YAmWPmpqp9E/5cOOJuEyejA9X8UTry6sq?=
 =?us-ascii?Q?ev4L1X55v7nL03HtKf85MD6DSSr7u3ymgz9MVbFdqdFpPRtu9dbZNwt2g1Vd?=
 =?us-ascii?Q?oMGPEMxzCWgsSXoU+LoChiAJ7OZ+lVcI3JotRMUby0d2uwXVt576rihfhdLl?=
 =?us-ascii?Q?LFeVWUHywWU4F+fJiIBrFz/sD/ZsTfyfbctpp8/3TEjoBG97av9WfVrZ1ZRp?=
 =?us-ascii?Q?3RCrSgiJ7307O6TAWYQjTQieM6cKy5wmmGkmAS/nx3FXAnm5GzQ/VMbS+JNH?=
 =?us-ascii?Q?D9tJWhK50xnDNVW95JE50e9DKeVdvEXVJLAp7K275QlZpExdZKBWqvwu9EBW?=
 =?us-ascii?Q?VDuBWhePYPeK+s8qBjvVgnmhkxpd3gwYjTa8+v4vG2RnPEMdzp4/O0d4u6xe?=
 =?us-ascii?Q?saNYiSByWgyn+v5pgTjTAWZOu0O1deVnHREY7haaBZy+aOE1+lRzB3QEp/rf?=
 =?us-ascii?Q?ZyMQc6BJ7N+ub/Xk0buaybSJlWB+KDMjLtnForLJ0F+FNsbdT/mwjRGRQVtZ?=
 =?us-ascii?Q?KqHcYvovoKG6aLInTFhPotKYA8XlIrjLJmimJCX2SB9apEvvcHNKYWX9RApP?=
 =?us-ascii?Q?TsPCA4nWCE4TEuiMD6sR7MVn2m3nfr14cbLjgH8K+mD7r8SRxSrze+hp4B+L?=
 =?us-ascii?Q?vf5ESLkCKrgRugYCQ+FHr6Cmp+S5dtpJRl+SsTlF7AOMbLIGHlrZvDcgRUdv?=
 =?us-ascii?Q?glCJN8dmWokmJBh1YOiWUTQl6q3PNvCijN9TrD0GSZGKHFgf+GSc2SxMzpF4?=
 =?us-ascii?Q?TXcC2WbY5Cjqg4iICLVI58nCcFJ0GjfJuRzd76sUWk8Zm+6ltWPerq8ILEPP?=
 =?us-ascii?Q?wsW2koACSYt+8nxTaEdJ80vnFPhziFDWEJhqR5EL/kJrJqU5oZTMogNn6dwk?=
 =?us-ascii?Q?M9XZP+GYsoxKiikv9/MshxHyugq/LfuKKJ+per1o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61ae2c6-dd02-4df2-e498-08ddeacf6467
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:51:02.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tex4u1xSf9VE7C5MrVDot00FSIvTXqo3qtZhCSFrNvQiK/L9Lydh/gzRHLsYYJh/Cv++1E39pRliwbFjyEiyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983

Enable or disable the appropriate DL servers (ext and fair) depending on
whether an scx scheduler is started in full or partial mode:

 - in full mode, disable the fair DL server and enable the ext DL server
   on all online CPUs,
 - in partial mode (%SCX_OPS_SWITCH_PARTIAL), keep both fair and ext DL
   servers active to support tasks in both scheduling classes.

Additionally, handle CPU hotplug events by selectively enabling or
disabling the relevant DL servers on the CPU that is going
offline/online. This ensures correct bandwidth reservation also when
CPUs are brought online or offline.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 97 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7e2f9157496b..69163927a29cd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3603,6 +3603,57 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void dl_server_on(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (switch_all) {
+		/*
+		 * If all fair tasks are moved to the scx scheduler, we
+		 * don't need the fair DL servers anymore, so remove it.
+		 *
+		 * When the current scx scheduler is unloaded, the fair DL
+		 * server will be re-initialized.
+		 */
+		if (dl_server_active(&rq->fair_server))
+			dl_server_stop(&rq->fair_server);
+		dl_server_remove_params(&rq->fair_server);
+	}
+
+	err = dl_server_init_params(&rq->ext_server);
+	WARN_ON_ONCE(err);
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void dl_server_off(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_stop(&rq->ext_server);
+	dl_server_remove_params(&rq->ext_server);
+
+	if (switch_all) {
+		/*
+		 * Re-initialize the fair DL server if it was previously disabled
+		 * because all fair tasks had been moved to the ext class.
+		 */
+		err = dl_server_init_params(&rq->fair_server);
+		WARN_ON_ONCE(err);
+	}
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root;
@@ -3618,9 +3669,20 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (unlikely(!sch))
 		return;
 
-	if (scx_enabled())
+	if (scx_enabled()) {
+		bool is_switching_all = READ_ONCE(scx_switching_all);
+
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+		/*
+		 * Update ext and fair DL servers on hotplug events.
+		 */
+		if (online)
+			dl_server_on(rq, is_switching_all);
+		else
+			dl_server_off(rq, is_switching_all);
+	}
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_online, NULL, cpu);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -4969,6 +5031,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool is_switching_all = READ_ONCE(scx_switching_all);
 	int kind, cpu;
 
 	kind = atomic_read(&sch->exit_kind);
@@ -5024,6 +5087,22 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		/*
+		 * Invalidate all the rq clocks to prevent getting outdated
+		 * rq clocks from a previous scx scheduler.
+		 */
+		scx_rq_clock_invalidate(rq);
+
+		/*
+		 * We are unloading the sched_ext scheduler, we do not need its
+		 * DL server bandwidth anymore, remove it for all CPUs.
+		 */
+		dl_server_off(rq, is_switching_all);
+	}
+
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
@@ -5047,15 +5126,6 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		scx_rq_clock_invalidate(rq);
-	}
-
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -5796,6 +5866,13 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 	}
 	scx_task_iter_stop(&sti);
+
+	/*
+	 * Enable the ext DL server on all online CPUs.
+	 */
+	for_each_online_cpu(cpu)
+		dl_server_on(cpu_rq(cpu), !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_bypass(false);
-- 
2.51.0


