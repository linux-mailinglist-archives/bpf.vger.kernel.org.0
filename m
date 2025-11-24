Return-Path: <bpf+bounces-75337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5141C809FE
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 14:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CB93A6D30
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE030149B;
	Mon, 24 Nov 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gd63M8XY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ySJUTcnc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B71EF09B;
	Mon, 24 Nov 2025 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989184; cv=fail; b=uia9Km2oJuseT5UAp/hec25XpUVxeafsH8rMtbA5orojPpGCirIjRVwA0ZO5K8s+9oQ6NpVow7STrVn9n9BllFA2lVuU2cbyhYj8qFusj8MoJmVHyU1gmnGkN3jLwD3/9QhxoiEHWgshw+aFaoCoJNPLNejBGaKrYUvg4UDByzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989184; c=relaxed/simple;
	bh=hydi8DouGzLiwhIEwsf+iDW+Qo0X7dpM7zRohoo0h6w=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=uQnMsm3A14uLqt/in2WKcGtfbybJIojuz21hmoncBVrI+MEhGeKhcocuF0CuPtQeaJ/z4FBZiVaIF66K5SdW7Yr0cd6bzkGYftvxlOxSGY3FJAqRKZPADMwcQNHeuvuEpzbwvHyFldfkwlS6SvBWqoukE7bpbot9mWcG2PVIgyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gd63M8XY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ySJUTcnc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVJh71078950;
	Mon, 24 Nov 2025 12:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=D4owhklmU/Kb5da83r
	YOMeZ03oRukKGtEuW9uYqFXV8=; b=Gd63M8XY+EHtV1ekNLAajft5eIfEfzAkXq
	3qTB4Rfy9d4Cnojg0Z+uTBrgV4n8ljbDXdwP/hl2iH54gCAxw8UnVemGZSbNEjaH
	nXD3zcUTai4W6Mpsb3/j97523qHVOW4Tffy1NFir+7MUhZjVh0MtS7+5SK1pkzN7
	6R32F2QVpQY/pInOVWC3SIk/uQu4h/EBtRIC9JW19Ejz8kN/dnH/wGI7ttWWeaks
	LoOypE1xmEBmGnlwiwwmaYlOyEvGyErLSP8+PXJZbOpbp6ODwNaZ5D8W2whWr4k7
	l1gbt3KO6SkaPzRvHqNOB6zQDy4V3K6GNRnJv+cOvmjfyCdKTnEA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8dd9yfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:59:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOAat4j022304;
	Mon, 24 Nov 2025 12:59:04 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mbtwdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB3sAkLG6jKGoCmw29Zk2tN2eCq4QDAmmMOFtJ7NpiCv/H3UJYkYlVNoi/Q6MOY+uqHsEMQCI5p0FW378xRcCGSV7yev4VAk2w6/6OLouzYugF4aGCetb4N5rve2H0MWXNK3jaU55gEHu3+PU713SeCDeuI5yFJPgzDF9XV/Xy7ZqT5Qc15pOAGxvcTS9oBLl851WtbIJjtI3NPFYUfUF9UDsndExUDNCewCvmniRZuwQJxsBuRX9ILYx91N7zyWIE7+BP24uuLcjYZaf1596lsdqC2In6Jn4Nw7Flnf2paRfRXMuHFAIDb79K2+DRzgsgdUKm3Phz4EfX/Exfj8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4owhklmU/Kb5da83rYOMeZ03oRukKGtEuW9uYqFXV8=;
 b=bCtR0CnsfdRWBl6w4aQCQqtzr+D/SS9arPyZY9cRmGLZA+asqw6VxMyOsd0ZHZcktJI/P/Xq4U+neZiz1Ix3T5sY1rdQTaxtHDIzpm4j8LHSMUhh3ijaiXOiuyhHYaMqPd//aNwopo7p1ON8c29D1uVhGaiZx6YUT6YWkMy4f0hbh4ektgmOnlAdYw0pVTqQpgDNSkWrp34a7WtQRZ9f5HkWcqoD47wf6CzStuiVftelEDGGo5B4doN3ARSKdx3CEL6luNz0z2xRAHR3l/TB2t7J436eipVYf7B5CXc94RhmxjobhzJZehLunt+KzzdYbI/vZO3Tuhu2FmaHDRNVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4owhklmU/Kb5da83rYOMeZ03oRukKGtEuW9uYqFXV8=;
 b=ySJUTcncKBIaS7xZzn9F6/GC1w1JOdbg1q5k0VUKWCeMd2JHREKQ2doN1uVd3gHOaN50kTP4q/K9Hywoj4pbabFz02WqfyE+gaNL4H7kqpMFtU0N/i0BRSpuWkkWndgkzVzN6y7rLqHyCIxmJ7IKg1xNFZK7D2YwXmZWwepwxnU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:58:49 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:58:49 +0000
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V2 4/5] f2fs: ignore discard return value
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251124025737.203571-5-ckulkarnilinux@gmail.com> (Chaitanya
	Kulkarni's message of "Sun, 23 Nov 2025 18:57:36 -0800")
Organization: Oracle Corporation
Message-ID: <yq1qztn4mfm.fsf@ca-mkp.ca.oracle.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	<20251124025737.203571-5-ckulkarnilinux@gmail.com>
Date: Mon, 24 Nov 2025 07:58:47 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: e7245faa-ca03-4489-ea97-08de2b59365b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MXnFYW+9alX73yl1PPH0bCEqtHwseLHa62MVkuDPz0KKXIC1D/O8wjB+5lnq?=
 =?us-ascii?Q?0pUiIt8EvopUKT5qDOgJX0yBe2jqXVA/X4PGkgnzpr4PoN2u8iwlyLvyB65a?=
 =?us-ascii?Q?fSCvyaYDbUkrZ+4izDsVBf8ta+v7n/2dhG060L8f2GCafltz307qFhm+6Ui7?=
 =?us-ascii?Q?h79UhBd4bC7IDxQBSM9cc+5cfFOhTa/bUjJKRfGxi/F55VHK3+r3Etrcnc8l?=
 =?us-ascii?Q?UbcibeXfFwCNspCM3jAATSg6X/qcU24GKlRzXXTFV7/6aGGl73zEbd5qSnWF?=
 =?us-ascii?Q?eeDnFbmBykt18AIe1nULJlZihV6JZX/0pNQNcuw0nVvSXnqw6zKU61LBs39S?=
 =?us-ascii?Q?kOA+Lyzg7PSskrlzo256sfNZse9WSo4eKz+DPpwrEwnkcj9J4ZxrIrSrv/QA?=
 =?us-ascii?Q?r4GLFAhGmCPDn8lEbCW4VFhWd9gFkYI4tesH1Ni8M0wpV8COXv/K+2hlyHwA?=
 =?us-ascii?Q?gCSH9mTCTeJYVOESQl/ZuYqOFaPnkCjaBMtWMX4+2o0UhXJaTa1FJ52yPTeQ?=
 =?us-ascii?Q?QfXG3LIbzrr4vtUp8VhTnvYKyGN4+IIRt3mco03I1amRlC76R+w8PxZmTDaV?=
 =?us-ascii?Q?JaV4hf6Taf+wyFSFd1qhGhrs20cDXQk+l+h+wLFzud6uG2l7GozShCKz5rC/?=
 =?us-ascii?Q?e9B7MAdYpOIXtCpcdOgv2rC8sE+EnBxxcXXdKyG+7tMOD7f0FBthaVleTPTg?=
 =?us-ascii?Q?opHC2HlY2wfdS1jOnYpS0PK/BQluG55Y01wFNV0RpIH2/Ur0oT39D6qkvU/V?=
 =?us-ascii?Q?+BZosH80rq5KkUXlD5uqJS0wSNt8bvczwzhbNOfJfV7qiQxbE4a3qaPG03Vw?=
 =?us-ascii?Q?b0ww7m1GmhzomAYOHvitgv4RTsQe0puK5psagRawDtyDjdy998g9iwMsAqYD?=
 =?us-ascii?Q?y00CF20blOFu03mbDm8VCGUmYR9iUj08Fjmd6LtVPRfoMZjUzbu99ebLUlcT?=
 =?us-ascii?Q?o34joWe0lpq0/u4q5A+lwa3Z6K4Ai3pxfvMxhKy1Cn5xQk2BydFM1b5fJ8FJ?=
 =?us-ascii?Q?nQEW0V8cGLmFgXNiPSZfoxnUcXIeB5zBe7/KbNPDN9owob+LCQMpJyn0MNnX?=
 =?us-ascii?Q?nYYuhuPmOH/WIp+pYw+kBLQQMIMCXB/4d02bvn3jVx2axIcUFTGF6V6iRlby?=
 =?us-ascii?Q?0WUv4CBacBU2jB5ABnvyHxmi2WaG1IajSW4jK/USIOaiC35G7v1urHBbNwso?=
 =?us-ascii?Q?SyKd0s2nNkJicp/gpMEIAbmMLqrB8hXbN4Cl/WsGliFY6owaw2U6kRwOVkzi?=
 =?us-ascii?Q?/gqM4YhLgAIaaVDaootseThGcjZKilV0Tls1i9EPnD6RXSOmxGZdDrBUM4L+?=
 =?us-ascii?Q?mXIAUA9BAE64nD5N2mBUr7w+0B7PG97zBX8qMjGdg6NeQMXG8aWwXmiuXlc0?=
 =?us-ascii?Q?AL7NTHNJbvIpv+XzSI+R40eFjw1/bCPRRTugaQCx2GM2oNFmQwWdzurh2MBa?=
 =?us-ascii?Q?3VXqteyX5f/IZGUUvdOOEhfDp0c9Abiy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hcwU65VHcvVOjDusHY/DmkVcSjxgvea8ieFQqxyeTiLH8O4NVMiEcESU4puH?=
 =?us-ascii?Q?gjUkvvvJBktuED0+3xIh57D6SpHFhu/wjIkH2RJApuCGxbYA0x+m+47hKeGL?=
 =?us-ascii?Q?urNCc43fvFklrqM1/49oYwK1JaXgOlagDcTDzYwKC6DScBWSwYD9qBeUHjOw?=
 =?us-ascii?Q?DlONc1WFB6JBDoFrfFp9ux2YL0L8OAIaLLbtU64BmNrG3D2ifDpcpZGBhEL1?=
 =?us-ascii?Q?ti2OrHGK+cl+Gl/OMw15jozdYodG/eb1xQjmRXbpZjf/G8mw/bUbQVUwEUTK?=
 =?us-ascii?Q?Px3k5/MsMKAK26QrmPzxOr4hrnPWGj2bkP9RpN5rzRweLmiNCd7jxX2/+G5m?=
 =?us-ascii?Q?uzq6ey0ZqXL7JgSzaBMS+bdXwjBqzItDtwyt0/4e+SVuXcadgjtjR/HbnAVU?=
 =?us-ascii?Q?YfkWbdO1j87JeWo5TVoI2uZOWyFwzCBwDYKN2n4IYNPVWxNYA3vKO1QF79ci?=
 =?us-ascii?Q?yOu1HqtkruDkcZnSpPRo0EMbjvYPRv/IJ6TxAU1FfxYBq4kNQuDHfMRscjKL?=
 =?us-ascii?Q?9+J2Y3be1ATWpkodPwm7CRVj8e6e/ZiDqm/r9jVj7aoasvJB4f+vxtC1vnEl?=
 =?us-ascii?Q?WsHNRTtX3yA6MNEteOPj/zZ1LLknwZgDaXAnSVlRBZQWmgml2muxRKgavEJB?=
 =?us-ascii?Q?KbaTSP8f/Li6xevmuUmY6XPSrYs1rwkdi+InzIcpuQdluolfYSeF2ou2G05g?=
 =?us-ascii?Q?rTNS9hqpD+Ek/DM85da8lUnITephJ5T9Qye9bBxaT/jvK9Z2z/5GtTKaG/nf?=
 =?us-ascii?Q?aMDLjevNRRu7No7X9/4So5A40i/uJIGXtvB5Jc7Y2xLm0c7re80NYsygb8eM?=
 =?us-ascii?Q?BvFSZ/UMwukgl/GnuGtqvMRA9CxhsY9nWa/9TsGeUYHSekx/vqvAuuFZnnO8?=
 =?us-ascii?Q?GvjaFF8jLCTfvahwhu002v/xAlGeuORm0WuXia1vwRHtiu0SbXjfULVCQggd?=
 =?us-ascii?Q?2rfqqwfVBz0/COY/Ym9VnujWFGoKraEfIn+i3YehCxmQVnhQgZnQ9ecIt1j1?=
 =?us-ascii?Q?ztVXs6tcmJiqnvKUGjARUHGTHEO1ejyYwQPQXhelHbGjEoAjbB0Yn+7s9wNI?=
 =?us-ascii?Q?wyAxj7dRdOd2ykO4CqgOE4lyNOXrkaala7DV/yroI4ds6Z+oBfKcaRQb22SJ?=
 =?us-ascii?Q?5b3/h2hbOlHlm+Sgr5v691PKk+wGWTTAvh13X+b99ZIpV3CtQFEG/ln15NEp?=
 =?us-ascii?Q?h97U7fu6WuxqZ5A5AaUgi8O2PH4AS0hZeigG2ionxCbZcO66Y9020tIjB/11?=
 =?us-ascii?Q?DSl41IcbxBm09U03lURAn+ITbxvVNxaMjqF6lPeWd0QZE/+4J/QhU5mZLIq4?=
 =?us-ascii?Q?+Gy0gnsYdSQwklSvsfxTPuKEOsSkrd+AsiVVwRBzW6PnBchSxndz19LkxaFr?=
 =?us-ascii?Q?FroeNmjhdE1MJ8mhYhhRU+Si7u+6cMHITxTn6PGUt4EjCaJjDMbaDSb0lMbD?=
 =?us-ascii?Q?eqF/hcKxI0a2wqKKwKDwMpspvrq08T/OAOzWSoNU7K6gAIBwKq9r5q/TinxQ?=
 =?us-ascii?Q?UpfjOZOoE8IaSwAcGRl0bhdEJ2APqtasJX3BHcxQA7zhmfezpMDvatspZNd3?=
 =?us-ascii?Q?DkLWQSc1+31ZbWK/Cr3jdjRArCltHw4KhxhwQ5xHgIlY34iuWY3NJr9H1sOU?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/iEYxicO5WJ0d3HTs9T/LeYC/tXMNicXr3Qddj/B4qxCcfatphhwV0PmFmsDYM2RF+hy1aloHZQsd6YfOy93i581OL3L2/oEG4vvlq8HyFMid7ZKUOCMfoH3vGBY7fdof6HmCZaBQaxO21YE8YSY/OvhK4V6dXR98+mTWnB4IjBjFos6nj5WQUzx80gUzmpz8nNPVNVTXKkFMGF/OfnNZHudBJbj0Nd5gtiglTOknST3RhPgN44LcJvgrE7+eUYoukjvSyxZtah8765V16OHfI5WwcxfNbUTrcD3a5cnBmWRhBQYvEtx1r984v8dBJcySVKc9m2nQ7J9Jc9b4el0OP4zNVgHTLE+jcIrk7CUgj99ansSKEkk20mrPe7//Pyr+XIEHmiI6KhW03O4Wg+aip43Ovmg8Y5xILACkcP/wLgD4FNGf7bUDrKurVTNtIZKi7jMQ2tHIW5/DR2/9SIMds8olGlmMbkIV/JJg52DKv/tj29CEdYJ5+/Vdyz1vZ9fIylrdq4/SbuoVxxthOGOAGucjkRUU/mJ+MlD0hRvMychQ3Z0izIkAEaoeWalIKYsQd53Nl176d9xjqgKxG62Pm02yXvD6RZXmZdyBYanTKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7245faa-ca03-4489-ea97-08de2b59365b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:58:49.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUwZEUSbUppyOU1BNB28IyAcaD2EQhXc19AqHUoEP8O/kN5wXaXSj81xx9gmlJQSgzL3XWeRQSWaN/TOkY6rZa2r72IMo+2nj5xZgQLfSg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511240115
X-Proofpoint-GUID: IJMKUhyqbuWLmY51z9RShN4ata04CtwT
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=69245699 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Zm5AFVG4S4P8tc4Be1sA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDExNCBTYWx0ZWRfX336jHVl9zZp2
 wT2aCvpWJbAoZ+V484t9TqRqbpfHcSQbX9ttL5sVmNrBxKkz40FNaaF7dl2KxhcwTQWWH2WlZ4u
 hq2ebBaf0L/WBYran+uQkOxVGeWgcthzIOF5Kv9/xDkZsPR/LowdaFpq4DO/Q19mtAS9uNMYi+v
 fdKzJEtB2qtccvaRB0JHmrFrtsiooDJEWjSm8GI6YDnGveZnVHhco0Rc9uMsFhZi37+S3kEhaoT
 1xI92SycyTiVI2DTT4Uzx1ROnIsGHfuFnr1V8VRgSvgE1X34KeXW506qEMBxzzwJmXb4fu9ijTS
 Lo2T4vxo4kgNB6xYZi1vnA8XAs9HGQAbDw9jyQp0LveQqDLxSFF40TjtY/npW6v5TdULIamCYTL
 657dHSdkUaP8OK/8Ob/+cD5xzm5V9cfSERSyfMiYcwm59YMM9/o=
X-Proofpoint-ORIG-GUID: IJMKUhyqbuWLmY51z9RShN4ata04CtwT


Chaitanya,

> __blkdev_issue_discard() always returns 0, making the error assignment
> in __submit_discard_cmd() dead code.

With Christoph's and Johannes' comments addressed.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

