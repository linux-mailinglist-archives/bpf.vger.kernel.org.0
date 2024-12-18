Return-Path: <bpf+bounces-47226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C39F6376
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0451A7A7BBB
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D14199EA1;
	Wed, 18 Dec 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BHV8DHUw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BHV8DHUw"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D850276;
	Wed, 18 Dec 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518380; cv=fail; b=AAKtxq3mdAdwLeNGbAIIyJObbKF++byXoFC7SttVJswrhoVVKfBOYdcrf1gLDBqcu1zYAdUpbBPPFKZs/Z8QEeq1Hr5XGYzmepydWA//wd5O9sAGjUf5grG1LfF4KN7k5NgOzFVubNFGAhkhHwu6R9TEYIK4QuP03KSwoAzp4bw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518380; c=relaxed/simple;
	bh=RtAiAAxTP0gatv+KSifwdpTL57YsgQO5HFty3cLmfUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=td2lHsGKHkdxb0yllvxSri8yw5sugw2ZDe3oS1MDMlLHnWODNMRZH6L57IXxSnZFtSb3S9sb7fnp86ugeYZ+8nOlXBgtRhzBOz40b47/3rUQ0z2alibdtrgvHAq8OxlafmjolJQ4t6u+r4a1wW3b70Z+JcLGShUfWNmFvJlLLQg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BHV8DHUw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BHV8DHUw; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nWtD1+3VOmubXladtMYUMi3dbl0Frm9cwpmcRepiNqCzUNPmMljS7+oPYvkxfI7mFqc8mPnYgugIyyn/0JZMhmmEQXGTx2CGjbLdAdHEt24gPly3nkq21SDwhDacLrUl8sNsqpCBUw8VXG5Nt9UaJ/te/WZZoXkmcjNbsnMiahRgYcgGTR8tREiJq0dUP8ib/YhwwJxniEGz5ehM0Eqjvbd8wQMslKxnKPLV/TrwG8xgCD3KoCrBEkBeQBV0T6x557VPHhSZFq50f0JwSQyiwu5Aunl7kluV4AeAsVniakVtUaStNFLLONrb9ZLSlbztfYMn1LZ6i3U9CqF7LJiSQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97XXSflLea4E6xV6V61aDDCo1PQcIA2/S56snjbX++M=;
 b=Oi56WQPAY0VGrZadGmiv02lj6j2iyqloeU5RXl5KD2c3J77qcU4ZBPbUd2C9NP7g1sMuw+dDoPvjXlPVMR+MhgAVd2D0b2uGeBKmMUR612ZDeycypufiSL1rV0/RX0QAwDRIYDpOjLrUked5fEGg3CuY+ftriHhTNYggeztcw2nSL9HV2iQbMaKNW2i5rxVXPBFaBpXKvfDQ6DM6LShUuuWnhuHucW8XM1kW3JcYAeL4aW+iFKbvNXMbLhmOShOqbZ7tSo+lwwxBzA9dkR0Rz51il38DV24C66JZfGQSNLTVwgKshvmjLJU1Ea2aXVMGaPWwzXWm1xu5lOG5sGszDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97XXSflLea4E6xV6V61aDDCo1PQcIA2/S56snjbX++M=;
 b=BHV8DHUwj5wGLhpMwdWxlqJ0A8bJynicieWbHl71psD2gjbi9cD2kalzp7VSAGrogLOUAbb3/xE4qkUpwOUlAKE2g0SD5+HEvJG83eRLD+VNjt287Ue8mQ7dUK1RYxv0xmL1dSSObgf9KoDKoUh/6OO34o9NF+csaYjFKW4LwnI=
Received: from AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::16)
 by DU0PR08MB7905.eurprd08.prod.outlook.com (2603:10a6:10:3b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:39:33 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::1d) by AS4PR10CA0024.outlook.office365.com
 (2603:10a6:20b:5d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 10:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 18 Dec 2024 10:39:32 +0000
Received: ("Tessian outbound a83af2b57fa1:v528"); Wed, 18 Dec 2024 10:39:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7a85d368ceaab7ad
X-TessianGatewayMetadata: YHWAQpftdxU7UcHcE0xisS2RUgFUzgkbT30mhbQybQIKNUX/RMrxTeJLBHa69cbw31Ufd1uFFOCZ1bd3CCK3LwMy/8qSPPEjmV86ZYz43zTffYJMb7Iu9ItpUbGwHK914StkguqOFes2Rjyy9NlnRpMu0sQPjPU0J8944kZftbbtNnVnRBOyBdbpZtSHMG+rb3pHp9B31PymwQkp2Zrkow==
X-CR-MTA-TID: 64aa7808
Received: from Lf3d0283cbf63.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E280F88-CE66-4AC9-AC9E-2FEDFBFFA9BA.1;
	Wed, 18 Dec 2024 10:39:25 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf3d0283cbf63.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 18 Dec 2024 10:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZMBcT7m0VPGDF3MOQjCJcDN/lTVZ104/MY0m+WR6AMvvSsPGXdZ4c3i46d+hLuJ3hoNkPQ1S47JUdcZmsiEDGh3Hi7LwqNSxq+tkmKZQf2pkcp4LaRcKqsCH6HGK2l1Zz4rahV+IoZCPg0NmDbUXMZYEGiuB8eqW8Tyi0AGo21uNvxv07q5ifrKbsWc1KqzJAkEUqJ6OEvDuJnyw/tXV62ewaFIupGy5CIM/F+dEXe6SSZ1T0vxkxugH8J+Kmw2bw3jweVFa7W/gE0aLUoi3wMYwjyZB9gBglE2KHa50PxTnVg0C7bvWp9d+3V4wx/2Tdc8Kc+ooNcj0q5QVHyUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97XXSflLea4E6xV6V61aDDCo1PQcIA2/S56snjbX++M=;
 b=ferIq97XjZieELPHZOIehK5BiBnONj22V5rWqzjTNwmiagMro3ndOfYdRVkKaGsDS/YrTvE2rN4tTbf0XxJ5zlcswobsEJc5uUDlTvzEfrxI76m01wwzyvJTH3siHZR7ytz0mgwyUNdzSA50M8TyexoGLjL7+HdZc5J+qb9DnKWzvO3kK7x8zyKQVqDwfQDk5rdjEZjrSz9WgDR6DNX52qY9HKkswvgK5e8haavl/ty/kbzEpSX93EudtzomdPhbSTFDYRObgPlPt6n0IT0/sqHFFtFjSS+mwfgELvkzt4KLoPY6tbpN84yjviQyvxX0K3jl3f6eOgGIEbKYd63SMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97XXSflLea4E6xV6V61aDDCo1PQcIA2/S56snjbX++M=;
 b=BHV8DHUwj5wGLhpMwdWxlqJ0A8bJynicieWbHl71psD2gjbi9cD2kalzp7VSAGrogLOUAbb3/xE4qkUpwOUlAKE2g0SD5+HEvJG83eRLD+VNjt287Ue8mQ7dUK1RYxv0xmL1dSSObgf9KoDKoUh/6OO34o9NF+csaYjFKW4LwnI=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6519.eurprd08.prod.outlook.com
 (2603:10a6:20b:31c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:39:23 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 10:39:22 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
CC: Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, John
 Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, Leo Yan
	<leo.yan@linux.dev>, Graham Woodward <Graham.Woodward@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/5] perf: arm_spe: Add format option for discard mode
Thread-Topic: [PATCH 0/5] perf: arm_spe: Add format option for discard mode
Thread-Index: AQHbUHrAAGpTiLfU1UmrBw6mVgzbs7Lr0QkG
Date: Wed, 18 Dec 2024 10:39:21 +0000
Message-ID:
 <GV1PR08MB105212F0EF7B3CE7FAD9CE36DFB052@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241217115610.371755-1-james.clark@linaro.org>
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6519:EE_|AM4PEPF00027A60:EE_|DU0PR08MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab6c53b-0c24-4a28-a629-08dd1f504272
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Cqllw3CHXZkh33LKUu1rV5Xiqe5k08sV8czjOs4kQLvafh4YVsWbiS4IE/E8?=
 =?us-ascii?Q?/FssqMQl0R5WY/QGibXWtr+unY21q4jJBAXqfUq3Hh3IwWh88PKWRkydFkAr?=
 =?us-ascii?Q?aS/mxqm2MfFTW6dfIFbACNSo4dS+EN7fZD7XjqNopj199MpfXLokPjkDfj8q?=
 =?us-ascii?Q?i2UYFWdBtbiRBCMF/NOBfUNW/YYaGitATMMJuBwuD8pCbEePi6KHbIE7uAm2?=
 =?us-ascii?Q?rvK8I3aipeWfkilZYyVtvP8ikPlnsicAyoaYltol+TanPbzs1RZHkLoy1z/x?=
 =?us-ascii?Q?WBCPseuebNbaIU4xY1JeIqV803zm0S9qOoloqlm8sJLbMvSeHDjen+MxFbVn?=
 =?us-ascii?Q?POfVli2cpL/1v+aWQr5eUy2KyTzAUuFPxpdiWIBkf+sX5vxum1ztUsSnq+vG?=
 =?us-ascii?Q?l4DLMbAJpjFIa+1QRNTHEzkGySTiLknmd+KJrYxjuo+AyFDfkJedOfDWbuDG?=
 =?us-ascii?Q?xkysXNlH59vpEYf4WbWwwE0n+dxkZe3uKNn5pI6UGLC4wpP/YEGKWBQz+PzW?=
 =?us-ascii?Q?pHOmZcG9Y+ewhPB07emNg0jf0+YfpkTwYfTq2w64uMrySs7dphpafxJpJAoy?=
 =?us-ascii?Q?I+HYfo7Dn1TzS1SX2mwHNgXNBZxD9AuypS6IDFq0OikRSgPTnXG3Z6gj3rrH?=
 =?us-ascii?Q?sqrRbxtnbDj4+5S4YqV3pgpsnr5MzEukp/M2UJreYusEp5rmVB+6i08xm/2l?=
 =?us-ascii?Q?c+8pi6MdPUIJFvQ+Mc7X9IGwuTuC+qIJWCYS1iHbkRLqlq9plt+ff2OYrSPk?=
 =?us-ascii?Q?hnQih4ql1u05YxufeBIz5qya21SKvCpE4zClYJFakF1YPtl1BH/M3QHmbl0+?=
 =?us-ascii?Q?zBvDdwxrSpbkBkr3n7/3yLvxGaexzAl+u/+KRkkVq/tHC1tRAF7XOC4JERgD?=
 =?us-ascii?Q?+8bYFKlt5C88ytSBPSjxNyD1o4e9Qo2Ys/MdBGisqdeAavAcibZ0vIBgtZO+?=
 =?us-ascii?Q?xBBofYAS2XMNQSN1smC0WeXPsaLt/FMW1PMNhMXy1ftr82BPIXt4yRgpnxny?=
 =?us-ascii?Q?dPmnnatAJY9a3+KKCwxHK/JOYkVQ2HtY/Bt2O/W5ovit6gj0JDCO1mWtYUFB?=
 =?us-ascii?Q?UXSMxb67WfSEe+JP/DkBJEntuGPdVBPAuFO01FPYF4kzWlsroHDtULakECmZ?=
 =?us-ascii?Q?qUS3D3xXahEmyOvO5EBEH7KSB0R/VavAaHVEnBKoVgOaxh9Rn5TIAwRxYzVt?=
 =?us-ascii?Q?swv2UmTnk+QKohtRRur794CcIG4t0LQjVpLPkXA5hplo1qF/JL4v4fAg3NCT?=
 =?us-ascii?Q?taKBJrODNSq2FtIAHuNVZxeOKBFpvO9E0g0aUXfq3X8AjSBlwnWMZLa8/pFX?=
 =?us-ascii?Q?U3N04T6VWpScN4wR8CXG7ZM9N5st+bfM/QI7gNOpNM4/FqmwYmSXxohgDA8S?=
 =?us-ascii?Q?ohoqOXIxzFh4oBHSvhJWqOtDp7hQUw8idunKdLZBChNIvUZM8kwJdx0YahCm?=
 =?us-ascii?Q?hmirBI3V6a8vqDBqNufoUwSSPtXqeoii?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6519
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4dc434fb-2193-4403-45c1-08dd1f503bec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqPZtKFsMdwH8zqVIefZQUBI/mbFr+gAtpgn8VRFmNsVwFL/qxHv1/qStaXT?=
 =?us-ascii?Q?4V9a5HLPAb4+3ZIc7OIw2Xs+bCceP5oYZGayBx99r318Qu1Dr3jf4s8kfwDP?=
 =?us-ascii?Q?ZiuFJYws855nbYJAZ6LbMBt41+exRy9xNpcj0gyRPb1xIJpSR2yhxLvejs1R?=
 =?us-ascii?Q?mdt4MX/YCZnpkkkTNvQ2gLMqH19NLuO5ZLTdgZ4BN6m4E04jPpTPWAcBDDtK?=
 =?us-ascii?Q?+OjILOS9aRnSu/hdwtI0CcTwwU1Bkc74rNY5+tYSTdWU2JILTJtGNsRFlTwc?=
 =?us-ascii?Q?ScLwTvsFlr2Wh+LillSbA6M1wScCTjp8DlLFtYEg6nrPzRUy/ms+K6dbxJbi?=
 =?us-ascii?Q?tlbu3kDNB5rCYnkbXkTgit3aldlmCq5+xTSXuYPgjlqVFo1godatj/UEaivl?=
 =?us-ascii?Q?jajYJn9tgu1xtWHhhZ7zxZAx1zeqncJJFlKgwEKya0jMuNlYGQU3QooevSZf?=
 =?us-ascii?Q?F0zYRXVQ1/I04frjBw8e5fS2uTV0uTtVGIlrJyrCZx2gNIIszcoKklQ1lxII?=
 =?us-ascii?Q?ChC9SAg9RFkt/THB80Mjq82lGzL+7uouNW9z4J3txvVdpB/LJDI+qNQmaJDA?=
 =?us-ascii?Q?P3HGlhB9sQs/7BTiCxf46Ix05CVBuTZ0Zz6YUMW88Me4D+4j1fiEsrhFOL/E?=
 =?us-ascii?Q?aeUrVfsjkUWLBM01FjjO9zExdGq7lrL9FCpgQQegQhFgAZMSU3DOFMwNT0kL?=
 =?us-ascii?Q?RtQ5gi8PY8lFsVZkvB/SHLB8KCsihMaDKg8DMTUO4vQN44SX2Vv+8qZu88XK?=
 =?us-ascii?Q?YthVUYh8DB0RghWew2+R6PTYcyQC7D6vLuUPWQkySml8zGs+TirtlHcV0ba1?=
 =?us-ascii?Q?EJ7faZDsYmoX+YMn4RYjOh9w3jmbOxF93DxMe0xpCnqFSN7lGWsjdhFCJYp6?=
 =?us-ascii?Q?XGFjHNKYUQbsdSo3FwHYPVoXrWcqf6FY1m63grk9iNOgpFaLYnx5kPTFQyVn?=
 =?us-ascii?Q?5Uzfz2thGaQhtIEK2+S2sWSkUSRh1OqJDmZUMVBumbXSvbsTs4fxbgnjiwDG?=
 =?us-ascii?Q?8zzam4u8JyJidfCnESd4gfaHxpmAYSmmThrcm0PmZ2y8yFsOwmdAiJ0D8OoK?=
 =?us-ascii?Q?3+JoPl5FDremtRFGAO2swWjjIJf8vKgfX6iNfh81MwYO+h3108wa+3xwCW3X?=
 =?us-ascii?Q?EptEw0tr9MWwhE9aAtlwYR5BW6Ym/kzVifMiu06UxgWD0URAaFJTIC/zL4sb?=
 =?us-ascii?Q?jwo0eJ9s5OxHMBYUCiiH1wGRgDr8K0UevVEBt7lo4gdSTiIX/VZ/wDTxlgNI?=
 =?us-ascii?Q?x/ZqCQiG/YWa0eLMVMJ3nk7RjD7QgiiANr4q83VcieMEIQYJPavrkLJr/yi6?=
 =?us-ascii?Q?KTlgO30RPqNseR3vKy+LzGWZUWhdupMPnp3JGucEEtnEdM1ESKfRjtyqzbUe?=
 =?us-ascii?Q?yQV0VhBWeEIAMVBXipqaPLEc4hI1iPZKZFiS8p3ukz/jtIPgF+Z6AujPlBlK?=
 =?us-ascii?Q?5mc6+rai66iL42QTDPu8E2q19zdgWFy6wlQi91VkxdxnVhnRxoP4J2sHD+9F?=
 =?us-ascii?Q?RCGOy/Meq2gBbOI=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:39:32.8195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6c53b-0c24-4a28-a629-08dd1f504272
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7905

This patch series looks good to me.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

________________________________________
From: James Clark <james.clark@linaro.org>
Sent: 17 December 2024 11:56
To: linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org
Cc: James Clark; Will Deacon; Mark Rutland; Peter Zijlstra; Ingo Molnar; Ar=
naldo Carvalho de Melo; Namhyung Kim; Alexander Shishkin; Jiri Olsa; Ian Ro=
gers; Adrian Hunter; Liang, Kan; John Garry; Mike Leach; Leo Yan; Graham Wo=
odward; linux-kernel@vger.kernel.org; bpf@vger.kernel.org
Subject: [PATCH 0/5] perf: arm_spe: Add format option for discard mode

Discard mode is a way to enable SPE related PMU events without the
overhead of recording any data. Add a format option, tests and docs for
it.

In theory we could make the driver drop calls to allocate the aux buffer
when discard mode is enabled. This would give a small memory saving,
but I think there is potential to interfere with any tools that don't
expect this so I left the aux allocation untouched. Even old tools that
don't know about discard mode will be able to use it because we publish
the format option. Not allocating the aux buffer will have to be added
to tools which I've done in Perf.

Tested on the FVP with SAMPLE_FEED_OP (0x812D):

 $ perf stat -e armv8_pmuv3/event=3D0x812D/ -- true

 Performance counter stats for 'true':

                 0      armv8_pmuv3/event=3D0x812D/

 $ perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null=
 &
 $ perf stat -e armv8_pmuv3/event=3D0x812D/ -- true

  Performance counter stats for 'true':

             17350      armv8_pmuv3/event=3D0x812D/

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode
  perf docs: arm_spe: Document new discard mode

 drivers/perf/arm_spe_pmu.c                | 23 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 11 +++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 122 insertions(+), 32 deletions(-)

--
2.34.1



