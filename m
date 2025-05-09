Return-Path: <bpf+bounces-57831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC9AB075B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 03:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774231C02915
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40765464E;
	Fri,  9 May 2025 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WWDz/14Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ptFCyNWC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B820E6
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752663; cv=fail; b=NyZUVg4b3sMJOTZqxHZBU2MK577cONFreG90CtoySQCQYMoOLTzR8EIFYyopxVmUGg4R+8In1HKuMfpyNDuxO2k5zeGaFZm99Bj5WkOgnnngaowkrCrpFpTc4toSsW6AjnS02Q/LjbIVznZAahGW4IWIUWf1jOlRVQ1slZARvPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752663; c=relaxed/simple;
	bh=NJx1s14ddQanRbgjDmUYPGhV7482Z1Ky0kAtqBipVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tq6NU+hnyswuE6Vf61/FzQEBNcVDeHZ/Ia0lZgl49jmMIBsbp24PomFGNbVcTZD/dqiUoT5uTfiZNkv1aSnPDxC8WFbErgsQj7ZrnWvAJ2OEcdXtfVklKr6b6wdlTAL2vkooZg1PNf5LdZcZvwioRuLSug2GHKhA3BwEly9w4JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WWDz/14Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ptFCyNWC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5490WC7b029437;
	Fri, 9 May 2025 01:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=H1hFjBPAD2ve7jhQnH
	yXV5AcJO0aI9vsXtjR2or1Hgg=; b=WWDz/14Z+4hkFqcF9GhVnLK9uDNse5OT4d
	ovlWEOrj6iJilj8Ls9FFjHzrpiQmI+vUhLmrvMi9iadVzu2dVXc2sTYC5+CMR8Ij
	MG/vt4j2wbv6Xl1rXatm/LcSn96QAbc7e0ssVGJXfka+Hd6YyIfkTpnjlO6TLEpT
	RxawvEqWkHMV6AGl5/sGFcCkBMkhPzgChhPacOTTN1N3Ay5woE6+prMYcstKPe7Z
	LZrUnqJIrZoQuRTynwI44m6IEn00cGE4Re8l0U+6AKDU8TGarFmoJ8EzJfrip/Gt
	UFOFXONjjj3T8YkrCfvbRZ0kNjPme1MJBsd02IEL6PBBotUF9/aw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h78ag0wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 01:03:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54901ljb007327;
	Fri, 9 May 2025 01:03:39 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fmsb0e2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 01:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOZ4hGGo3qNEnMOsi6PkeXKf5Qx9XGk9udDqPzZm9rZQGnONP0wb2lkZ/q+JBK0FFMgkBB+hsEPjyeOcoqDwwvSufvkYMAUeatmpfjRdRgh4rATuTOWZSRMpETHvwFojJOT8AUDBG8AQwHmxWf4T4bQoTicACKj+5ftha4vG0gyGebJgKweX5vEhcrnNbfr8KHFJiHSLXA5pavFz/IsKb8W723sdP03Mxtec089K1j5hkPOmwLB48XRqt5+rAFui5AoFqM/eBgOiYVdFsg+Xw4CfsrTTJJByP3iWayeNN5y7pXoHSzQ46vQ40ocN9hWq3gCrAJVII8HVjc9+hPXaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1hFjBPAD2ve7jhQnHyXV5AcJO0aI9vsXtjR2or1Hgg=;
 b=fC2u5ZkGuIwoj7BLeP+i1sQplGFRGe6/O5rjpIgqkv3PvjC8VEBGMBbOzqta5Njjyy3qE4Hkk4WIBZ/lTUBNq2nFOGPVKNJFf9QewSquhESRXzE9iMXC7v/PsOYtJa2tvDPLxhAp1xZsUarKiuKiLuEJyaieXrftj0izgdycJHtjEnorsp6DvISZl5d6nyhlTdkodgyNheh2crglpNHW4Av/fUfK8LLjHRvloFc7ICuHbmfgLNiVATpd0LVxzXzkLVrZ6EvOfnAp3tweql6/wEoNA/2whDR8+EfO7YTw66w7Qds+jIct1hpbO/aLeqVmFWQKZbOPJx4yVrlWRISxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1hFjBPAD2ve7jhQnHyXV5AcJO0aI9vsXtjR2or1Hgg=;
 b=ptFCyNWCQZ72drnIbmgwGNXmBom7upo+Xb6u+RRWOEsIxHy4qfLyVdxli0rROFWrMHucyp1f2qLwursIhmj2uX8V7I/zz8H8pof5B2sA10FnQtNcfv5M6v6OJSC28/uBPqJAlO7IBNJp/YKqs3etNnXHcG6fWp8bKwFKqqXmAfs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6215.namprd10.prod.outlook.com (2603:10b6:930:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 9 May
 2025 01:03:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 01:03:32 +0000
Date: Fri, 9 May 2025 10:03:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org,
        willy@infradead.org
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Message-ID: <aB1UVkKSeJWEGECq@hyeyoo>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501032718.65476-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SEWP216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: c816060c-d82d-4d75-af34-08dd8e955147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qcm4i2MwABpqHYfRj0JDcNvnbHmfJOUAiz5Bo13NuZce6tGkVeEd0OMazd/6?=
 =?us-ascii?Q?1AEod9hjfT0dsDbJmdANSOaaOCnWzEW1jEeLvBybejIkd4rxgsDbjINmT1Or?=
 =?us-ascii?Q?b3t4W0/PHUztcpmdaOgd0cjuuHJ+l3KhQc5NFWx3lGkZ4TkV2hXhfs3t+rbd?=
 =?us-ascii?Q?yqi0YZjp2kNC42aaTGxBvE9OJ/b3b3mCxZkJPDWH+AjKSy3Jybo1Iu6hfrvh?=
 =?us-ascii?Q?3OgAZU5IEHeZk0w7EOLHutqnkNu1kRjBXQMIN/JqHDkaYl0nlHd/RHtPda2m?=
 =?us-ascii?Q?ahOsQJYt5gxgw11Ote2/aEiJecrNmYzSiMfosb5GSRwQDFKwM9HydoCviS5I?=
 =?us-ascii?Q?KBEwAeicYOX4wRxtiAjK2Hrm4M5P6yl0GL+5VWGsGuDzn8dFSEwe+gzkWOzX?=
 =?us-ascii?Q?MuHlTMhIxb9yLsfzgDtscx4bIVkcUatttaSD4fSa3/IwswdS9V9tOXXUAVgJ?=
 =?us-ascii?Q?Y1gGCzBfx29+Kz71T8Xv8sfrRL+rEuXwCG0tIt4PSqCXh4ytML/4rc9kzIyU?=
 =?us-ascii?Q?Xn4AUraRzEMDViBZSsbloBmFkrL2QpbIqnWH6GkdwkWWwQSbSMbcu0Q454sq?=
 =?us-ascii?Q?Lu2DdAhHhssFlta+XKWEpX0FSMUjGlc9Yir761gWlpxCNRqGXm8puFyjXBIq?=
 =?us-ascii?Q?ah5HwDYwkk5h0XkyzPdEQJRcyeHsnx1N5UMk4BhkwVM6tZ3Go00iKiQeCWwL?=
 =?us-ascii?Q?pVHMcqhuIkiQiaLlb+G0ww0heibb4tEvGXu2qkl89efFH2DZ69tHkG0Q1znN?=
 =?us-ascii?Q?7/WHR/qYRwWTfP7ZLmuOCJsLRDWlL0kBZ4VmZxag1PtUvhkYS37EhAjljaDe?=
 =?us-ascii?Q?HfpvusP3WY+f7jXzMC21A6RI7FD0hezZrifY2gjmDGQXxh9BnPFNaUN3Unym?=
 =?us-ascii?Q?Se++KIKraVMkhYje5o7ybm5FM4WzM9KsqUhC6HFK9g0gHN+L3CmP18Qb8Lka?=
 =?us-ascii?Q?Ex0QY/ERPu0lplXNNz8vgJINEaOGW5Utfj1865EXPIExs/OS6DuPhvqKGIEt?=
 =?us-ascii?Q?ynAUTAL2rqWslTlSalNZ2w7y/wg9xAaAKAj3stzWgvYrZLSatKMsQQ25shNT?=
 =?us-ascii?Q?5sFdIe2iExbun2fg4CeErENQCvCuQscZwSwlEMxTOk3LBhggxNOhsSwAER8b?=
 =?us-ascii?Q?ukPpMQR48Uztq4XsHKK26HZlBxaTmxr3De596HfWXl7E+e7thCqhS9/dUMWy?=
 =?us-ascii?Q?zcbVP2fjuxEGrQEZSBG1Ibq4jD7LPAn+MvPHp3hOyAi5xFR0UGwueKVzoq+8?=
 =?us-ascii?Q?KoW7FNyJLw7bhr2vLbf4Y2WKigWez3lpAnoTsYfikM/Pye8CkAsrnIcoi9sB?=
 =?us-ascii?Q?12oiN2RkXj5gf32LI1frFVvTuwWZ0cS8zdrIKhzT9BA+q57n05QWQVJXxtDz?=
 =?us-ascii?Q?/ImBHDyhNcieNtQYTIm66OiweeiBUoxKPRrJBeURM3IwQPPHRZarRfmAzG/1?=
 =?us-ascii?Q?00hl8kBYeJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xrajQRHbN0Ljv/WMWXoeZ0uHZTiTr1R6wp2zflhTUyING+KPnVP/PYGNYxQz?=
 =?us-ascii?Q?+6aTwdBwIJ6mlz2rTpmvVgaVGE9JW1/Lr1KWNn13rEwTMZPtzBx2M1oEQ2LU?=
 =?us-ascii?Q?kwJ1DnSOgc6JoyeVwWn77tIsCEku6xh32w+uc9oWGIoh2e6j/iv9XwBvkaGl?=
 =?us-ascii?Q?jAlX47CkVUB4LWdppKA2YeTKf0saT1sanMR3IDw4wjUI/LajyPSL+c7YRExu?=
 =?us-ascii?Q?OkUtKfKp10bPwJJQWEBMbeMxDaN24NRNYMRPcE+PSncHrda+zrSMLkQc2TJ9?=
 =?us-ascii?Q?i871KaZYBWIRqTdbrE81qTtYAMVj8GnMSjDDAQkq+gydt7AaGVhsGfj2tLL1?=
 =?us-ascii?Q?g+GiTYl6iVtnhMiJDAjTpLKU2x8hfAV7R7Ep0L/WpXcefNNA6Gbn8fWi1IQH?=
 =?us-ascii?Q?G/QOVgqKwkTfpIFVgqvAigFvE0lblDDoa8CjvBaW/DToMZbu1/Nd1P9ufHfT?=
 =?us-ascii?Q?4+6lVJAou3BTe+8n63TwOrwjo9LdIsc1QcKPcmsXxHLX8T3ZQPDy1ljVhw6X?=
 =?us-ascii?Q?JwGszcKGfUQpDZVQQzSnZPo9JrPIu+7ABms4RwTpaIopOyThr6AW8xA7x0yJ?=
 =?us-ascii?Q?o4v7Gj2preTizZI3VeKxwUNWFOUvyEV3lxo/FR9cmAyJdqWUB96PiJ1s66WI?=
 =?us-ascii?Q?uL29jh9vkp3iQGYORxU9tjnowNUP+u+0UhWwtd7kAI9r46fluQh3/RkIXFt+?=
 =?us-ascii?Q?JBPAtGw6ztRADG/hWUyG22oHC7kcU69hdEOEH6JkycXiR05M1/P+LGUpTqSl?=
 =?us-ascii?Q?CPXXvDQG+bJHEgUwxoGSCn7PCD49ndpaTZ3G3VaEAvRKCtXT7DO9rzh62mKh?=
 =?us-ascii?Q?hqw3vDCzwnqkE7eHPD/oCVbbqdIeeQ7gETbous/xe+foPH6s5Fv1rArTiLYP?=
 =?us-ascii?Q?TbqbdnvAjp5G9w4BByUy0BFadhf2POiGD0lvysVmqjznJEB40lS6XWteMxyD?=
 =?us-ascii?Q?soNpJCaoxJtdV8q9L+l92laydZQW65vDjUgkbAW04+ha5GuyPFWjNvtqB+eD?=
 =?us-ascii?Q?Cy0JURk4ArIu8vtP+OyRfL9qFlqRQHSpTVVdzYGW+E/GRn3Sw1NnBgR7MAMF?=
 =?us-ascii?Q?2USvJ6acCiAmqVIWnNxAZ8b/An2kNi+yUVgM/Tset7P9byxl4OfcmrvCtt7T?=
 =?us-ascii?Q?iJ/RQHaa/VGcp5xebUMrBB/b5bHYPg4VKWYJ1QuWre8pwPSTLR1tvRNC6KTE?=
 =?us-ascii?Q?/N/ArnaOLxCd6gVcJhJOPjw3Qtn3zMgsfsdedNID1hR5Ze6b+/wkl1hvkokL?=
 =?us-ascii?Q?n5YkWKhWGFRnGGXi9zayV/JX/oZvtyCPd2HSxdrCZjXdqpRARia42xdTck0t?=
 =?us-ascii?Q?/A5foD1bDgu7m8zRTH3Aqz896TXcoRXlv89AMU3F5wRfkuVLK19h9aeAkFTp?=
 =?us-ascii?Q?vmXVc8gLcJ6yZtcpmvosufxWf15v09Sdt7Gnvbuaq0NdCSRUAlyRuiVAaOMr?=
 =?us-ascii?Q?nE18+fnjuBCRPggpY/Nfs02MVvUFJfSckxwb7zGBQY7toIKyZyS0a1sI0tcD?=
 =?us-ascii?Q?T9RwBT4JvTwmcKo0sqjhY0y0btGLev0oaqCQQvlfXZnnLkCswjEF5yrdgmxC?=
 =?us-ascii?Q?Mdw7Vh+Dgcv3SVEWtbz6Q87pbd6xjNloGuettvd7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r68WcmJtkd0jfG+mn2U7gTHl4VsPYcYbheHBJ+k2t6BIVqeGSPYr135ofrXYAZd3aKuOjy261A+4Ga2DgdLSISsriBNxbxcYTMObAxSX60ClIUib7pcDIbrNsrX+UruozYWfIre2x0SrFu1i1BOe29NB/IAHNcWQZhf047dzosh5S39nxb/D0sCnKIRr3cpusQ3qvGDDeYsxFIKLOAZyM8Z0vus55lBqKFrQ/mhqcpWui78WHOGaTcKkN9Dwkf+wjx7f/nmjhYWqG8d0JsrcHQ/U8568qC+rUatOuTqfEHjQLnVOIgJjXRTuUnUYQeXUkeaBPums570EN6e87MZuSP8LCTtm5ibp91medwPB9PQIR0ELHab2SG9nHmDPWEfJN/yp9biI2yhoT5njUP+Va6Xlv3gE9sQl5pC2oBEM3XZ5/1eHl1reIMXslP0EDIwruqgUdNgb0Mxsa470rnUyj3INoljTDu5ePchjwtpbk9DmQ4TIwxAXtOg/fXAdU8AYcefL04fQTBXcTscq+RZYoZbwMCBB9ojw8mwnJmbGgUiTYBDoIwV/vl/DI4v4R4NOA8zH1p+DXCj//jOxRtYK9Bbh8GF0kwTf0v9XbLyiz3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c816060c-d82d-4d75-af34-08dd8e955147
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 01:03:32.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l30Txnpi05EsudbcBb7/84Bx26fcX3kRsaQFzB1ZWIleB0fzJJn9e8xhjEFFHXdsjdyua79RtzgiMjEneCyZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_08,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDAwNyBTYWx0ZWRfX76uURn673aGr gSjSopewGeMZnfiHacOW4L5EwD6e9RBkokMxaKeuDMbzH3T/G4pubpqVv0f1b9xrAbqWNOvdrg7 qmnbfKRazsFpL1cG+GQ9nZMbzyFf/6hHepZI0ePOJKnKtJYnh1IUgtH4sp+x9NcWlKlOoxD07U5
 0hQnqpW1zAslswnH+JsoKIO1oks0LljMGfH0C1OI3DAU7gXbZNAQaeepw0k8JA22gMYe65HO5kW +02zcCL9gAIpEao6H2xQ2PCGCoUe6CIQxo0wENoleMnXxn/E9+E28JcpDDGs/G6i0GNImNZlNxQ pHIGVWQz8xXXKkYfeA9AkIX+9fNSKLuGJtAjlyfPPtc9PtMyubocTpTVmKD5RfTW9NlXVMNR9+R
 QY0upd/+naPjVS7nFhQqyezPaDd0NkLkll+LpJDrbXq39KWatr3V4CmyH9aMsh76ylv+164k
X-Authority-Analysis: v=2.4 cv=Fbw3xI+6 c=1 sm=1 tr=0 ts=681d546c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=9Jg9XxT6BmH1zmaFW7IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14694
X-Proofpoint-GUID: FNArMLw9oQCcoAHHAKnf5I_tScRn7W4H
X-Proofpoint-ORIG-GUID: FNArMLw9oQCcoAHHAKnf5I_tScRn7W4H

On Wed, Apr 30, 2025 at 08:27:18PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation
> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> In that case retry the operation in a different kmalloc bucket.
> The second attempt will likely succeed, since this cpu locked
> different kmem_cache_cpu.
> When lock_local_is_locked() sees locked memcg_stock.stock_lock
> fallback to atomic operations.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> a different bucket that is most likely is not locked by current
> task. Though it may be locked by a different task it's safe to
> rt_spin_lock() on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/kasan.h |  13 +-
>  include/linux/slab.h  |   4 +
>  mm/kasan/common.c     |   5 +-
>  mm/memcontrol.c       |  60 ++++++++-
>  mm/slab.h             |   1 +
>  mm/slub.c             | 280 ++++++++++++++++++++++++++++++++++++++----
>  6 files changed, 330 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d5a8ab98035c..743f6d196d57 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -470,6 +470,7 @@ void * __must_check krealloc_noprof(const void *objp, size_t new_size,
>  #define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
>  
>  void kfree(const void *objp);
> +void kfree_nolock(const void *objp);
>  void kfree_sensitive(const void *objp);
>  size_t __ksize(const void *objp);
>  
> @@ -910,6 +911,9 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>  }
>  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
>  
> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
> +#define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))

As it takes node parameter, it should be kmalloc_node_nolock() instead?

> diff --git a/mm/slab.h b/mm/slab.h
> index 05a21dc796e0..1688749d2995 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -273,6 +273,7 @@ struct kmem_cache {
>  	unsigned int cpu_partial_slabs;
>  #endif
>  	struct kmem_cache_order_objects oo;
> +	struct llist_head defer_free_objects;
>  
>  	/* Allocation and freeing of slabs */
>  	struct kmem_cache_order_objects min;
> diff --git a/mm/slub.c b/mm/slub.c
> index dc9e729e1d26..307ea0135b92 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3918,7 +3949,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  retry_load_slab:
>  
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +	local_lock_irqsave_check(&s->cpu_slab->lock, flags);
>  	if (unlikely(c->slab)) {
>  		void *flush_freelist = c->freelist;
>  		struct slab *flush_slab = c->slab;
> @@ -3958,8 +3989,28 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	 */
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  #endif
> +	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
> +		struct slab *slab;
> +
> +		slab = c->slab;
> +		if (slab && !node_match(slab, node))
> +			/* In trylock mode numa node is a hint */
> +			node = NUMA_NO_NODE;

This logic can be moved to ___slab_alloc() as the code to ignore
node constraint (on some conditions) is already there?
> +
> +		if (!local_lock_is_locked(&s->cpu_slab->lock)) {
> +			lockdep_assert_not_held(this_cpu_ptr(&s->cpu_slab->lock));
> +		} else {
> +			/*
> +			 * EBUSY is an internal signal to kmalloc_nolock() to
> +			 * retry a different bucket. It's not propagated further.
> +			 */
> +			p = ERR_PTR(-EBUSY);
> +			goto out;
> +		}
> +	}
>  	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> +out:
>  #ifdef CONFIG_PREEMPT_COUNT
>  	slub_put_cpu_ptr(s->cpu_slab);
>  #endif
> @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(__kmalloc_noprof);
>  
> +/**
> + * kmalloc_nolock - Allocate an object of given size from any context.
> + * @size: size to allocate
> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> + * @node: node number of the target node.
> + *
> + * Return: pointer to the new object or NULL in case of error.
> + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> + * There is no reason to call it again and expect !NULL.
> + */
> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> +{
> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> +	struct kmem_cache *s;
> +	bool can_retry = true;
> +	void *ret = ERR_PTR(-EBUSY);
> +
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> +
> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> +		return NULL;
> +	if (unlikely(!size))
> +		return ZERO_SIZE_PTR;
> +
> +	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
> +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> +		return NULL;
> +retry:
> +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> +
> +	if (!(s->flags & __CMPXCHG_DOUBLE))
> +		/*
> +		 * kmalloc_nolock() is not supported on architectures that
> +		 * don't implement cmpxchg16b.
> +		 */
> +		return NULL;

Hmm when someone uses slab debugging flags (e.g., passing boot
parameter slab_debug=FPZ as a hardening option on production [1], or
just for debugging), __CMPXCHG_DOUBLE is not set even when the arch
supports it.

Is it okay to fail all kmalloc_nolock() calls in such cases?

[1] https://lore.kernel.org/linux-mm/20250421165508.make.689-kees@kernel.org/

> +
> +	/*
> +	 * Do not call slab_alloc_node(), since trylock mode isn't
> +	 * compatible with slab_pre_alloc_hook/should_failslab and
> +	 * kfence_alloc.
> +	 *
> +	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> +	 * in irq saved region. It assumes that the same cpu will not
> +	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> +	 * Therefore use in_nmi() to check whether particular bucket is in
> +	 * irq protected section.
> +	 */
> +	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> +		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
> +
> +	if (PTR_ERR(ret) == -EBUSY) {
> +		if (can_retry) {
> +			/* pick the next kmalloc bucket */
> +			size = s->object_size + 1;
> +			/*
> +			 * Another alternative is to
> +			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
> +			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
> +			 * to retry from bucket of the same size.
> +			 */
> +			can_retry = false;
> +			goto retry;
> +		}
> +		ret = NULL;
> +	}
> +
> +	maybe_wipe_obj_freeptr(s, ret);
> +	/*
> +	 * Make sure memcg_stock.stock_lock doesn't change cpu
> +	 * when memcg layers access it.
> +	 */
> +	slub_get_cpu_ptr(s->cpu_slab);
> +	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
> +			     slab_want_init_on_alloc(alloc_gfp, s), size);
> +	slub_put_cpu_ptr(s->cpu_slab);

Should this migration prevention really be in slab, not in memcg?

> +	ret = kasan_kmalloc(s, ret, size, alloc_gfp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
> +
>  void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
>  					 int node, unsigned long caller)
>  {
> @@ -4568,6 +4701,30 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> +static void free_deferred_objects(struct llist_head *llhead, unsigned long addr)
> +{

If SLUB_TINY is enabled and thus it does not perform deferred free,
what happens?

> +	struct llist_node *llnode, *pos, *t;
> +
> +	if (likely(llist_empty(llhead)))
> +		return;
> +
> +	llnode = llist_del_all(llhead);
> +	llist_for_each_safe(pos, t, llnode) {
> +		struct kmem_cache *s;
> +		struct slab *slab;
> +		void *x = pos;
> +
> +		slab = virt_to_slab(x);
> +		s = slab->slab_cache;
> +
> +		/*
> +		 * memcg, kasan_slab_pre are already done for 'x'.
> +		 * The only thing left is kasan_poison.
> +		 */
> +		kasan_slab_free(s, x, false, false, true);
> +		__slab_free(s, slab, x, x, 1, addr);
> +	}
> +}
>  /*
>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
>   * can perform fastpath freeing without additional function calls.

--
Cheers,
Harry / Hyeonggon

