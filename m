Return-Path: <bpf+bounces-56115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BAEA9174F
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 11:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918615A3119
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E15226CFD;
	Thu, 17 Apr 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="DSOccqml"
X-Original-To: bpf@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012054.outbound.protection.outlook.com [40.107.75.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82C320F;
	Thu, 17 Apr 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880900; cv=fail; b=NVbpKwailyCisMoFksbKlRMuDqPBj2Hf0CDNGqIKKRpH1guVNgBXCOMLzILnDXC8nC3NVWH3h/YQIsP9InEyx2YEhUjgJSrXSxJ/ybAekRTwm3h1/p47/QDKw+7DFbEIQRcYbIDAVlcB4NWDOWCWMZ38+Ct3d0yvIkDIGIDAo/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880900; c=relaxed/simple;
	bh=UyUO0qHbJgnEZysNpxnruUY1wihkI6rbAYKPpTvf1vM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3HPHPH+E9+Tiw2Mw7sN2ToKDK06eTBoWo6laSaS7ppOLyj6iUm6RIe38G78JahTN41Q6bjBISyRXaLNgZNoLaiuHtuGp9Y3sf32czzGODuhKviuZXxKjqgvOSI8oR7hEz6Ypd9qd30VTfoA0mpfcBxI54D+E3Te/FH+TF4PzAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=DSOccqml; arc=fail smtp.client-ip=40.107.75.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfNwjknL7L+q5fw3UKSbuexAqs1nimnasvUolbFBxAwMBGDWpSm1YusML/xfM4DVjeBZ1ZJvdjXOzX4xAJNWacIQlJb6yiKCNiWuPnuFUUiqh4mpZCSefsy+b6CU9qMJDZ1g68ASjvOWbII6+ruRyYjo+m3shZwG7CxMg44NBeabc8xQh6MmPJ/s7AT3zcDBhNTl+KxDPqOZv1SG1Jc4t5FQf+oUhlnNr7KQy4wrPh7Gav0MY1Xh+1qE6ZZ3b/hlFDGx4I0dIhp4qJInvF2WfTv17q2STugaaQnJw8SY+YYyBxp9ox/jEqxEC5O3SpalrhdQ8XfdBYyk3ZKwaAcBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN+bi0uLrdq8/TM2cxwFFBdomh+UYG70nbAOmAFCcdQ=;
 b=JuwI0uOr7CAWJnsJmSXorIP4rq2anfh4QrJsiQXgnjE0luP4IQ3aDQlO1H7eXrY5FkH9yPrEQvMLZNMgBeDC37dvYLGYDb+6nf39IYJigdhAz6rltmJuPl+JX6T6tGVWbHbzhPRW74Kz0ytcXB/s1hkZ93T0HOl4I3o0Ye14QHhi6aqL1BGloaII3XjAzZdGup9JAtdfWVf/U1wHX1sWmGlQ8JXQBP1NC5JtmzDpZ6PT6S98WDEFdEmiqXjDpeqVorSrysvZn0jrLUdNVXNAoZvPSP3DPR/hD+7aGKzik5zjHg2G2poQtP1YebEzZFt/yUh8LbI5tT6SOSm3DjuKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN+bi0uLrdq8/TM2cxwFFBdomh+UYG70nbAOmAFCcdQ=;
 b=DSOccqmleG91gZsGIaht7K2dbEl/9Rmk9Qv6pvcW1djqkseASI/fWxZSY7V89tFbL7FRR8ZZWXhzKWkbdCa0oZJ87RuhAr84jTJMRfFFJDQBDFX0vij+XcehJpLc3LeRcHaMzR6xB9QATjHo1chJVHoeAD1fNUXi8dU8HXhbCBs=
Received: from KU0P306CA0074.MYSP306.PROD.OUTLOOK.COM (2603:1096:d10:2b::12)
 by KL1PR02MB7450.apcprd02.prod.outlook.com (2603:1096:820:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.18; Thu, 17 Apr
 2025 09:08:13 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:d10:2b:cafe::d3) by KU0P306CA0074.outlook.office365.com
 (2603:1096:d10:2b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 09:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 09:08:12 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 17:08:11 +0800
From: Dao Huang <huangdao1@oppo.com>
To: <samitolvanen@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<catalin.marinas@arm.com>, <daniel@iogearbox.net>, <huangdao1@oppo.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <mbland@motorola.com>, <puranjay12@gmail.com>,
	<will@kernel.org>
Subject: Re: [PATCH bpf-next v8 1/2] cfi: add C CFI type macro
Date: Thu, 17 Apr 2025 17:07:35 +0800
Message-ID: <1744880855-497559-1-git-send-email-huangdao1@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CABCJKufDbYVAMi23aF=+daNkZa-8YHOoZfnLGtZ4qCG3EzJtCw@mail.gmail.com>
References: <CABCJKufDbYVAMi23aF=+daNkZa-8YHOoZfnLGtZ4qCG3EzJtCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR02MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: d05ed7c7-5f56-4273-2f91-08dd7d8f618f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKTM6b0qxg3W4AOkN1gvuMAxTjIh3sAvjDvalbaKahh/pcU1TNRXRcJ2pbIO?=
 =?us-ascii?Q?ED3PI6S8z8TDBnKoEfTpy0kQgHKwg+cMeT5gsyRIS40eWPdwj8UXPANTQBs3?=
 =?us-ascii?Q?ub/lNSjkWS2faWdgk6uMAvXPK3B8gOQhhoQ4X3ZGukkVkkQ6LMEO3gkJu1Ts?=
 =?us-ascii?Q?Ka/7h/cX6eBz3CvbzQrRMWTIK45mXnQBbCVPu+o+uMMhQM/53//nQSxTDvT8?=
 =?us-ascii?Q?anNAbmv9ft9ImqZm+7WAp19/xOZHGMLy+9cxs2li7w9vkH3SQALLpCsIwk9A?=
 =?us-ascii?Q?vAOQks25/SxX+cAbKMXqp53ZQEa9Vlt+8U6E+bLf4mmdVVgjniPa3f7sov8o?=
 =?us-ascii?Q?+cuXiGfS97DLEP9LEtNqN4d3RneiqI6j/C1NPEhGnYarqpjSeIRfjHGG1S16?=
 =?us-ascii?Q?JrSZmTiRsO4hiLI/VfPYboaImyTyLIz4rgZZUgMJNGqwv7pofZUjv8aU05gJ?=
 =?us-ascii?Q?qG5kXcvNfQaNc9LeS+XZS+6KcZgzTxmUCu1m5UL7GDvmUPET491HaBSLpIKq?=
 =?us-ascii?Q?qB7fKEaKxOFYjNLXVH4/Bf8Akd+Q6KHz04J9GIDnUPUd9OCSaJjaWJ3svfRN?=
 =?us-ascii?Q?kGYhSAp2tGHqCTUGjRlQg3E0vEzQg5p3NllhnnDRYruROuhM5/FMJKiC/xYs?=
 =?us-ascii?Q?CexvcleZs0Fq1HqY+UNhKAeR9s6BtBrl+X3nZdQwQgEMuMMhEsNCLiaGrWAh?=
 =?us-ascii?Q?zJVlnm5OFb1LUoYa+STtyaaB2DUvm//cs0ggXM+ouDdBsWRyw9Arx/TYDwNm?=
 =?us-ascii?Q?5wQI723Vh4EprKLpLXMCS9hmhNJNE4mq7Ka80mTbdOPgGm/n/mMrnS6KDo2E?=
 =?us-ascii?Q?e4uHiWV+PIMBXtLk2+fNcKC1FA3wcePj77oIP/3kJrgiDy4nhIR17dMGRs+v?=
 =?us-ascii?Q?6tTqb0DfUaRgDx314Ufp4qmD7ZnEhhdjQgbO4jkTe3IIFt+m3wYAgfw00y0e?=
 =?us-ascii?Q?2bbxSmWB7/yeADNmoyxjAZTn2HlzIk+cCPpGa7FBcjYkwOAkMZID4hOe4PHu?=
 =?us-ascii?Q?OEJiiGq/28BKR/jtxmkMUrVhf+nXQBlzy7zbpnG1yeg7vEoCTQonUR3cOYfN?=
 =?us-ascii?Q?ShOjO8pgAd9tcbcL5xX0qVDsD9zdWqnOWr/mpD6fxSzvGM3tVm8Viat5SY+w?=
 =?us-ascii?Q?yzllUdJf0U7u1AoUGSxIRWQuPbkk0KVxCmWdu8AiGXueMhGC/LtHJGWYPBQu?=
 =?us-ascii?Q?gVfxka/WZBvK15wOUnonwsyWehJw5ynzuQh8jUm3QDR9YRZYHxqntfVtndFk?=
 =?us-ascii?Q?A+3lc0NNgpSKZHkwKryvWp59P6Eca42U0YJ24f6c6u/erqaHnHcG3Kkw525A?=
 =?us-ascii?Q?5ZDFvDdbhJ73El/ClG8cHAxB6YRu8LOjYusOjD0bAU2yUc9Yb1aD1sYZypt5?=
 =?us-ascii?Q?ykXfoGSmZ/HTER22Ara0h3oC+nygI0GMIVWuhOJeVYTXISIbAWCjX44ChNzk?=
 =?us-ascii?Q?Fdt9XyyaOXJXqnQsOrN/+sQjH++LhtAfwIJVmP6mmjjHliHtjFLqkjpXaq0W?=
 =?us-ascii?Q?KmnftiUN2L6ZlmFvPMKObKNL0rqWl1VsxyKN?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 09:08:12.5328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05ed7c7-5f56-4273-2f91-08dd7d8f618f
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7450

> Hi,
> 
> On Mon, Apr 14, 2025 at 2:54=E2=80=AFAM Dao Huang <huangdao1@oppo.com> wrote:
> >
> > we oppo team have tested this patch on Mediatek DX-5(arm64)
> > with a kernel based on android-16(kernel-6.12). It has been running
> > fine for a week on both machines.
> 
> Great, thanks for testing! Can we add your Tested-by tag to the patches?
> 
> Sami

Hi sami,

yes, you can add Tested-by tag to the patches.
	
Tested-by: Dao Huang <huangdao1@oppo.com>

