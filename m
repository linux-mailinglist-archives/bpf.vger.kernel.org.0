Return-Path: <bpf+bounces-76986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B9CCBC82
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12CF3023D48
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7584330300;
	Thu, 18 Dec 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fZGYZoxq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fZGYZoxq"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134332D0D1;
	Thu, 18 Dec 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060774; cv=fail; b=GuFvwFZNzgDFvolWSz/CGDM+ISI+8qOQ9IhkgMtIEO4aRFNYXAGGVF0jqI0y7E+kBYWv/zohj9w+UNB5zXUunT2yKwOFd5za9qcDmiSMJuHYJIuLS5hkRXrBJLFvx5DmsskEZ1q8xur2wzNmq9xKzFis2JzdH5+6DjuUkGvLpJs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060774; c=relaxed/simple;
	bh=Ys9hWX3h7L0VUT9cVw2f9M2ONefcE+XaONp+HdKO+8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFKRaqVjHjhW46X6vZYQdwrXlmHCB/6g0Ip/sy4NecCqzaUW5aooC904aQkJIC2qG14oYlsZuk7XhYrKSVohk8IAl1gc7oy0veJFSTcMflFX4jvaXkpG2mPxC4duRxEqFm7toDwwQmsSdh5Y7KaYnzj08AlxyOa8DqwDfq1ELO8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fZGYZoxq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fZGYZoxq; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kmCccT0+GcqDGzMMbenuyg9DU4w6OfNnwqH8+vnT4/4yOk78WTABjvDQHCmgJ+5MBtJrqDkM7XRrTrelybYTmNm47oPs2c8PwOjW35ZcFVRUBlZHKlnoSQNq6sgwFRmEmG0p+VD50w+i0ggQ0Dn2HiH+CDHnbjJh1FIJK4PokUSblbwb7K+sUwF5nz4voo48ESs6Kkkn4rx3jJlzP0X5fhnZfym3pfTH3eAV2ZxxfZVWaUUsebbt9K6N6OV0yK/jOrpt8c1qUNbVecSR0hPX3yJwD7y38bALjbPrTUh024vY1cKe/9v1jHm0KcSNcaHfR9iosFICud8u8oomStvUkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys9hWX3h7L0VUT9cVw2f9M2ONefcE+XaONp+HdKO+8A=;
 b=rnUq3Rs36vV4NzERW7MM4H+IPK5dAzMaXw0YNGoUGhkGIdcjSacQMqID6kHtZ41322Eoe7SgdSuHjhJ1Au5b/Sb6EAcva5ztUgUhPb6n8d8dqEGMzLoPO3UWpfbr6QQHQV9fnqwkpm5/RHifPvoAjDuopv7WH5/085s/5ozPlg4HqceBigT8g9yfg9UwFwlXbTxdf5QjQhlcuCf03vLMiO5LapjSrRDiQVDli8o5JyF4zMThLkA5+J0MCVaM6RM497tXbY0M4Zz335NuU8qvHVUI4zA8ELIKDDsVf/0LlUkM0b2u5owu/r6dh9Hjq8yaoqtZEjWr+flYgQszboGUkg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys9hWX3h7L0VUT9cVw2f9M2ONefcE+XaONp+HdKO+8A=;
 b=fZGYZoxqJCdarZ4hsW/J9AVkyT7pM0JElMVO/YW+VsxSbwS/jTkJe6tPEFLUJLJ2KhPvQepRxX3dMvqFKkVXTANopUnhiNpBbwCSIf9R0qp14U2aSllcYPcJIxd/Lmx35dQPpXVWvIAjTiXaCH7pfnGNPy8xgxz5+/onuaCR95Q=
Received: from AS4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::6)
 by GV2PR08MB11348.eurprd08.prod.outlook.com (2603:10a6:150:2a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 12:26:02 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::30) by AS4P190CA0021.outlook.office365.com
 (2603:10a6:20b:5d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 12:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Thu, 18 Dec 2025 12:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRGL2VfmIfEA0jrVIy9GUAFWIUyGtI1yQKVhvdS24pSOU1bN5/c8B9JCyz1wX1FdtCSdoCUFMXkPa0h0R5OlCBSeqPc4OJybKpX7lvwGjvCTKJtz9UldWuWyByPavoWiVA+rPcqehsd1VZo+En0QKAQXhOJS4/BZz3gUKu+At/482eNstJ+NtGcK3fdSl24cvUuVVbBXJJMwq7rxwz734KwXAvdcr8IuYaEw1mcyCnc+tI98BiaWMbnlcOi9SUhWbht7HeFAOMpAfkmdULBN7U4HNJ5V/3BpybyQZJtnjX/eOl2EqZ8190n/FDj6iKWcV1mywUuhzNFgn3la/uBAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys9hWX3h7L0VUT9cVw2f9M2ONefcE+XaONp+HdKO+8A=;
 b=t4ZosobpbJjnt4Zy2R1Bm8SzV/8GYnHKaGZxNnZXhZpMCkzKWr1AvE683vtxvcT5AUdWDXOHVnrqtSJJ3zs8vBkQG6C5vNYepdRjn9zHxX7EnOXfHeG5tqRu/tBuzsWStDDZTv4lvuZtOf4mwwgnzu8dkkn0JX+iYP8dJpsHrJoC6Ns9nqXnVXctmKlYBmfq4PpJ6Zz+Aj1aXAZN9PAXhgGEwGORU6WB9FlctLR4652icRvoD4eZBGLf1cyxdk2p1IkMuXsiGE4aUZDEfSFjqhSyZdLau5G14T7Wa7y78w9XHFp+Onz+CGu8d3JGyY4p8/QsbQrrrVieiUMgGWsmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys9hWX3h7L0VUT9cVw2f9M2ONefcE+XaONp+HdKO+8A=;
 b=fZGYZoxqJCdarZ4hsW/J9AVkyT7pM0JElMVO/YW+VsxSbwS/jTkJe6tPEFLUJLJ2KhPvQepRxX3dMvqFKkVXTANopUnhiNpBbwCSIf9R0qp14U2aSllcYPcJIxd/Lmx35dQPpXVWvIAjTiXaCH7pfnGNPy8xgxz5+/onuaCR95Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB5912.eurprd08.prod.outlook.com
 (2603:10a6:20b:29f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 12:24:58 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 12:24:58 +0000
Date: Thu, 18 Dec 2025 12:24:54 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUPyllWslvMakLMx@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <aUPJuZINNuNxddRX@tiehlicka>
 <aUPLCPAyxkPeBaoD@e129823.arm.com>
 <0d08b4bf-35c5-4c63-964b-ef886b8262d9@arm.com>
 <aUPw1YFNLf7ONqe9@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUPw1YFNLf7ONqe9@tiehlicka>
X-ClientProxiedBy: LO4P265CA0156.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB5912:EE_|AMS0EPF000001A3:EE_|GV2PR08MB11348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a05b1ae-7124-45ae-fb3e-08de3e309b86
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?RSPsB59X+PF3sMX1/h64jk2xT9cb4dBN4aMP7D9GYCTVFcW9ZaRG29FeROvb?=
 =?us-ascii?Q?ebMN66LtKJTTVx1DrtO55qvBaTGiDQOpqn1I/lMVig439AZT9gWHYNpxn1bF?=
 =?us-ascii?Q?YSd3bU1UiSDc33FtCq7l7KbYO8mJZF9fCSYx/y7nsGHynwRo4WhRmeyZJdUz?=
 =?us-ascii?Q?iiZTgg67JyVvTR4V6bIIULNbHW6h5E1TzMv0SvIqx85D5+mZY21SnK6G9o8c?=
 =?us-ascii?Q?NaBApfHgFu927blueJgQB5iV/YzVtrMtOPfN8/jew1oNXdeJy6pwP02s+r9c?=
 =?us-ascii?Q?afHa7oXwq6cQr5CHFmGps2INGBBDqGqOtSizsZ6THuqrbHzuDyvnRkfUCNnf?=
 =?us-ascii?Q?qeOzcp4O11atwn+2qiw5Wd2NaFPEnJowRO7vNQiJx6+GbT1vJYA4r/YqTMjR?=
 =?us-ascii?Q?qSe3GJVo2TBAeDlDRcu6vjfcKYNAnrydO7turVMXrZfIEOSNIXDXi7yvysRd?=
 =?us-ascii?Q?+1neqq1YbUIUViTn+Iw8HVe5MDr1lObbGlOSQN+QryGdaG0vBTgK/Gn8UiZp?=
 =?us-ascii?Q?x+99dx61pXvGf1kJtKyMfQY/pxbJdv9NadLqp2HNQEVGDQuf0yMRogJ2JweM?=
 =?us-ascii?Q?6CWB2MYcQDlbsQ6zhmO0Mqj+mefRusLUAkErg3v+4sbkhPgo8bmqqFY5FWAp?=
 =?us-ascii?Q?aadbtZ4j5280Ozc4b/zRyMuLc/M/x4OhWj+v5i0hqrX1TXtuhLrQ2q8+wKZR?=
 =?us-ascii?Q?qAiklux18CDbwzy7Vdcz8Psz2v44wVktzcikfYHrM9ZsuECZwioyUFtFMZAt?=
 =?us-ascii?Q?277XS7hqlRO70EGtCE7Xw0wABWO7p2yltoR2dJvlt1DQVXxAIyaacDZHynFE?=
 =?us-ascii?Q?3k2eW1thCcj0KFti6XjqqcXkgq0dyWrPM8hK9mnr7/8U52sD/lubbXf/F7KW?=
 =?us-ascii?Q?LMqPMYXdivxOV9tRUMx5s9gYli0QukyBa9cTIzSzNwr2bauexCW9NOfBnu3U?=
 =?us-ascii?Q?XyaSSeoDWYfUPLHJzQ/BzUrTbwqeQDaOCtbHODrcumh8Bjz0G7FkrXljEElF?=
 =?us-ascii?Q?pj/3ecWWY1/vTWrhC4ClNavPVCDDOg1WTAM3RTmoplUgxx1WS8NKa+HeL+uo?=
 =?us-ascii?Q?LeCIPkjBZ1eR+cswNuy4+GRdpaUwmAza4SdJ4RFjzgbF0mX6UZ8PmBOo8J8q?=
 =?us-ascii?Q?yDxjokDED8N/AMpYb0UvyiKZOGJgeqpf07viUTv8tctfczY9qXLySblH497F?=
 =?us-ascii?Q?nWupSDIVpbH9q2f5RK+XCruQ2B+ZBSXlveffaYcgAl7xAI/wOjJ55vUZPrGC?=
 =?us-ascii?Q?xR5felRwne5STNJ/lyuSeeD6MCGwnFDAU2z9id8Hw2XqUJJm43+nFcsXLC5C?=
 =?us-ascii?Q?S4qVJpmPKt/fUArw1L3Lej7iKJvxErdwUvfaQWwP6H5wyJCBc3Cgw3ulLCgq?=
 =?us-ascii?Q?QDCxuzVrfV+4lAiUR/hI0mFjaVwTzG8/0wVRGgsBD43p7/Y2UmdEra3TiTlD?=
 =?us-ascii?Q?u4obtKt8NJGoRiPIY99zvqh5SR/K25IfSeomDodXDMJCE5b78gTeOQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5912
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	40ca2d27-c175-4e1e-b660-08de3e307558
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|14060799003|35042699022|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVIWGui3MkyPeELeUCByxQEwKo7It2OY4Jfa9TXkauR9OxgXMu+uJZi47+FM?=
 =?us-ascii?Q?ZSrAsBfm4sDs29WAJT4bhkd3jjYnqw3gbyj7AnE1wx2SqRrrCjwVTAPiW7TX?=
 =?us-ascii?Q?it4fUym5kolo8aXme6bWI2Si4rUCvzZJIGSm3moA9Wx/U15pqFaIrHq/quXk?=
 =?us-ascii?Q?BFjUIVbF3j6cdR6WFmfQ4E/WBMgiV2ef4YyzI1KmnnC/c9B0+sDpCmvSmMRm?=
 =?us-ascii?Q?nyMmETb2kfqChwzkpqvwHwHu0udVz1KRcVZmXm5qnviebdARvBqNIVJCcLYD?=
 =?us-ascii?Q?jIUGmZx32jxa5OpRxg3k3AH1d2M9TA18Fkkk3KlLQlszMMvtL+Hgxy/SCX3t?=
 =?us-ascii?Q?LXWhFu5tIt5duXU6+7nuAq3Qqf7lccndF66IHisJsRDvRrHA3M6AC+3E26Wp?=
 =?us-ascii?Q?WgNeLSXL5pcuxLjb5hg6F3weyBsKZVwIqJHWeAX4KlC/+nhcdMR8XNSwEO6R?=
 =?us-ascii?Q?Sxvmg5GkgeBaJhKRki4ygI+GiOjkS006niFRFk4X2ra5KYPKmO9WclibUjFD?=
 =?us-ascii?Q?ik5+RVSOFYqOpVmZib71sle/dwvxKpd8Xm9Hh7sVGYm7HCfIzHnYxH/qvHNw?=
 =?us-ascii?Q?l8VvMmjCopzZuxgIY81AmKr8OYfDSD6VdnbzrMsKWkNx5k5U04tE0h1oDGe1?=
 =?us-ascii?Q?MxfalxyJGT4DLG/yIh7LWvn+pF1GU4A7riCkpKZv/fCCLsyk7835HxoT+NNt?=
 =?us-ascii?Q?seiZS+BE1XcbzzY8OAC8L/hGc4sRAK3qxGa6Up+8KCC0xnh1qJliVGllwa7i?=
 =?us-ascii?Q?NytRb/f0pW30+oNqgovDwXBdZMF0ar2pvwayj0JD9Z620MgVI8mSJ5bUA3LO?=
 =?us-ascii?Q?hYHahqtxLpLK9oiKcpOLe0ZvXNUZljziUwzOBv7Rf+XnXzzAVeiHN7lst4kw?=
 =?us-ascii?Q?ArwrZstJtwPDsvOrHA1JUA5NDNpVWgCofh0bgA7PrnDggNDoed9CgtHM+MLU?=
 =?us-ascii?Q?ZY+rksg95YPVNATytw+WMa4jyh6Wc4+Fmp7FWjdzzz/4COSiGsefosP8CR1r?=
 =?us-ascii?Q?HzeQen+gubg5pCkL/BvyvMYCYVYveXKvTEs9w84K7larcQZXfBSRb2dBxD+C?=
 =?us-ascii?Q?4oOiTsBFvUgwzLfQm8TBxG4cPjR6/0qjXptYUg4/qaQI8/jmUmtcVX8TA1Lb?=
 =?us-ascii?Q?/QV3BvC89JPwtXrIyvOaA1VC1SpXTJ5Qh4lezRTrhMf09ayeh0NqDixmJyT+?=
 =?us-ascii?Q?IF7r5jtDNu8vvB7WzZCbeixV6HX7RgYnYOqK56H9uwp/y/QD7/4XqIllFLJd?=
 =?us-ascii?Q?HnfBX3FM/LjNcnhdeeNvMbDXRr1jAqx2885h5Zb1/axKkVEggPsVeKoBtoWO?=
 =?us-ascii?Q?DCxJkDcko/gcv0dWJQazOFutAqKhPzPoIiQekniuwOE1qRfPXljSjbpzdsCF?=
 =?us-ascii?Q?kPsw8OoLxRdw80CM4/IBpaw+P0CcftVFqaLTA2s349pBMVdvlP7xqn5yQpC0?=
 =?us-ascii?Q?zjvF2+1Mwq1RMD6ZMla3/w20toxNIlz4lDdk/681FYOo9Fd8rYP5IzCcAqZv?=
 =?us-ascii?Q?J5EZdtRBNX7stoL5oUvTFgK0yNe3btZ+Uswg/HtD+KHZWIXd/qRwMDCoqDeN?=
 =?us-ascii?Q?5cWAZ1YhcSsu0vn1FBGw2q3jyt5dbPTT/eYBWQQs?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(14060799003)(35042699022)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 12:26:02.1326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05b1ae-7124-45ae-fb3e-08de3e309b86
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11348

> On Thu 18-12-25 12:02:14, Ryan Roberts wrote:
> > On 18/12/2025 09:36, Yeoreum Yun wrote:
> > > Hi,
> > >> On Fri 12-12-25 16:18:32, Yeoreum Yun wrote:
> > >>> linear_map_split_to_ptes() and __kpti_install_ng_mappings()
> > >>> are called as callback of stop_machine().
> > >>> That means these functions context are preemption disabled.
> > >>>
> > >>> Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
> > >>> __get_free_pages() couldn't be called in this context
> > >>> since spin lock that becomes sleepable on RT,
> > >>> potentially causing a sleep during page allocation.
> > >>>
> > >>> To address this, pagetable_alloc_nolock().
> > >>
> > >> As you cannot tolerate allocation failure and this is pretty much
> > >> permanent allocation (AFAIU) why don't you use a static allocation?
> > >
> > > Because of when bbl2_noabort is supported, that pages doesn't need to.
> > > If static alloc, that would be a waste in the system where bbl2_noabort
> > > is supported.
> > >
> > > When I tested, these extra pages are more than 40 in my FVP.
> > > So, it would be better dynamic allocation and I think since it's quite a
> > > early time, it's probably not failed that's why former code runs as it
> > > is.
> >
> > The required allocation size is also a function of the size of the installed RAM
> > so a static worst case allocation would consume all the RAM on small systems.
>
> Understood. But is it possible to pre-allocate early on so that the
> allocation itself doesn't have to happen from a constrained context.

That's the same suggestion from Ryan
(https://lore.kernel.org/all/100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com/)

And here is the v2 which have accepted his suggestion :)
(But soon respin):
https://lore.kernel.org/all/20251217182007.2345700-1-yeoreum.yun@arm.com/

Thanks ;)

--
Sincerely,
Yeoreum Yun

