Return-Path: <bpf+bounces-28472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63B8BA043
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 20:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2B28612F
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936FE17333C;
	Thu,  2 May 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tu86B0Bb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q0kP9T+G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB6173333
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674280; cv=fail; b=HDwBoFfXuE+mYeXBZpEULEOq5CkrNdkgyZBps/ofkKH2/owbpvgpYCqshW3fV+dfPAq7GVOFXizdldS8NHDOuMHdT8t5qh40oxKGjn3vobsgJ2wu8iziZQzVY0K/oLMkXLwUXQXY2PoSBU8zGwlxrV3vDMoCcMBllEMgm6jokjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674280; c=relaxed/simple;
	bh=X1r7ndlKmY0KGKZFTebRZSCcM3uL4l8jPMEH6iNqkmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=F2SDl5qAbMPN39EW8jogJaAc0hciI9ukDl9BPMOtCZD5fJ01F3exi8+9JAEV84o/fGMVCWapyVe3bmJbBQJ80SyTWW7+4drtAZnoUXCH8WpytnQ8ghTuZor+RJCskVXRjsWBuj7skPX0gx0LS3ZZ8+6ezsh36WdYm7Jy8L8FPyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tu86B0Bb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q0kP9T+G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HHCDv012025;
	Thu, 2 May 2024 18:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ULQ4txBccqWQiZNOfwrzj+FozR0DHNpLhGzvPrGDwTM=;
 b=Tu86B0BbvB5G+5I1f3TGiqnS9pHA2ZJ5L5gfYFy88Sjacdt9qbVVzH/SVgeWFQlK77gs
 lEcpx1UKABPvrSP4VbDRudCbCI3S8n6L3iz85lr63aVXuR5ae1EnOcdL1lVp50KPymrZ
 QaqHf8U4d4tjb5i4iMV+R0fSbA254qSWXWAccJHjYJlww6gB+GL8VsBVD7c0KlaSvnKI
 iQWi9ZAUUqj6EtOlmmndpRMhRFuTJ4cGc8sJDLVFFtzbPagGcOD/PquOAPfNVLZsWBY1
 kln7sJETMa6GoLUg6+Mrk3PYWdTUnqJABsdtIRVXeHmYA2dtMthIqqetZe0WeLBPHnan Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdf082h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 18:24:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442HV4sL008829;
	Thu, 2 May 2024 18:24:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c2krpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 18:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2WGpVRQo3sgEiqPrK9px/S6oQZzGqg1e0zJviWZsDSc9eYJ0H19txbbkcIN4h0FHPitkWvw8THAL3dRV48Nxqn8vn6jibZN45MeyEbYAIavZ82Huumvz7X1RInyvl3+ExPgi+w1TLkNCe8ZFHTKpS/jTOeDnloHa2yAGlsxTE6mQwufKJKjkFwlNUyXhTPA9AZoVHSdk8fiSpnm7BB39Ub9dC7YsGvmhHur1abGj0T7kUzde07hbf6RZUVAYKk4IxcaVQjvXC99iN5RInmMPUonsCWYRfSBvRInUqWC7OXypmStxlSBCAF+QiigLKjGx8WfuO0T67lD0fZ0n5oWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULQ4txBccqWQiZNOfwrzj+FozR0DHNpLhGzvPrGDwTM=;
 b=Q2rjGKje2/Qh59bQbnL8eGnFzEEaaSr6z8LzEaFio770Ht8l+6OPhG17/ajZqzfYeieP9al8ZWsBlCF841ogxR4xZWk/xzFCbVy5XSzskBznl+kymUFwXns2+kl1AYN44FyD570qth+csxmrH9HZdcaORrD2OKwVInsL4fQVS/6q7pykTOWjJyeaZnUlKmO5MxZtGWW4QfC+HL7ylRJfKIyYiaqSrzzT3vhrBDQwvrJRA3OwKZ8gDyYrCCqgbxF3ftTkncnD6N2DLWZz2dnxjd3D9EE+C/c51M4BeFEoR+QniS1Cf4UuIShrc5pePMupcrVFv2XHcQFFgK4/xdhEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULQ4txBccqWQiZNOfwrzj+FozR0DHNpLhGzvPrGDwTM=;
 b=q0kP9T+GjACDD2K9qYg6zYGYLgljlAFXFI6TirKQwOIFqaQSk0YyywyYd41aGb8kV0GNN0zDcdh9hpkVeVk/MBORGaDmuMonwbA6fnDMtvEFEnrGaMh6WrzT2RSBYawwOo5Brz9GDRUIW3UqyudfVDBUFULgbKekig5zkfHC6fM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 18:24:03 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 18:24:03 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
In-Reply-To: <c4d99195-f000-47f2-b167-12e76b705dc9@linux.dev> (Yonghong Song's
	message of "Mon, 29 Apr 2024 13:52:48 -0700")
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
	<c4d99195-f000-47f2-b167-12e76b705dc9@linux.dev>
Date: Thu, 02 May 2024 20:23:58 +0200
Message-ID: <874jbgqdhd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d234d70-4455-41f8-9c51-08dc6ad50b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FaZK7ZLpeuzNxT02LSkvLOir88zulPqRK5kehYOsJ5LdkHtvo06/zzwaUwDl?=
 =?us-ascii?Q?aH9J3TwQwhym3AERNUOXZ67JXU3c48kNMD8xK9vHw8QJuMHBl3i00hqoS183?=
 =?us-ascii?Q?TCE4hJAp8iF5/yoyad3ZK0xRPDakaC8B+XHNUrsmgULvaMsaFWuWDCDcwd3z?=
 =?us-ascii?Q?GBjzhPvmSEnEaSWzn0RWPKsePQ7OqLAvg+Ur/iyoqcORqvtqWMAbRiB8RmeM?=
 =?us-ascii?Q?7AaMt8LuJszRpvfzQfxJN+nqSSFfpL2UvQtMrdwWNb3FB4bWwOWMol8YAHRo?=
 =?us-ascii?Q?DS18pDgjAb9qOTlKiy7R0GqOVDtJPT6vpj22pNIhKlX1EYrKuNupEwuzBrsv?=
 =?us-ascii?Q?s/paPk13+FD0i4Se+d5qOEw0wzesyvYj1wOJb2m9q+8Srtp8QlFHE3bOx9Nc?=
 =?us-ascii?Q?hx7BbBcKLTmkl8CMzSKCbodsVOvGtTzPhcrTx+mTkCfiRJa6K4EWokUn3in0?=
 =?us-ascii?Q?bvA6f256u7k8bS5Sw4KaTDaet16Sn/DZd+5qMfUSd2b5Je5gqDwjO1WjGJT1?=
 =?us-ascii?Q?kwkP3r5bY8YIRdh35z14z50xn/USYjFxTfVQUf4SDNJVvEkJKHnzUbdQeQyk?=
 =?us-ascii?Q?YKlrNg5ix3WuRChW+6bpASH4zBFi5XOKcjqgP/bKUHYIxKaQUPI7qRs+ttSD?=
 =?us-ascii?Q?caQf+MVuXw4X1z22Q3zfOUQlzWSrQTwTxide4bxxF8QdX1I/+DXPffx2pwdR?=
 =?us-ascii?Q?wBlP9hVevTZyGMDdpgWqNRuxbAasDefCwyxdbAv4GPGhrkxHVJ4a6Dwm+3sI?=
 =?us-ascii?Q?go8AA3fXmVYZ7YIMTTRG1NKElnY2f+8fnjxM4N336y3cmmN/ThECqMXRsoR+?=
 =?us-ascii?Q?i45kwGr2l2MYdKdjxyMqqfhyZRSNTu4JZh9RWxGpqDm2wOoWwOTqILgejnMu?=
 =?us-ascii?Q?NX9AeFVqasRlNSdfvxRKczkyOwpYchxqjl1q4paIOIpzp1XYbwxWWRBBgUBl?=
 =?us-ascii?Q?VhbacFxxPx8eHBJbxeQ5gGbkZtIvJtVMAFx0btRCtisoc5Ze5B6tzeeubtxP?=
 =?us-ascii?Q?StudBEjnQ/xmhjoYot3/ndlyNlWc1XnmiwYKgzliVSGNqRI350RaHK8pzx40?=
 =?us-ascii?Q?0gEkwfDAMOzqQvwdijwQMgECIjs88ItANaO7WvYKSh9/6gzKXQbsvL4T0FdJ?=
 =?us-ascii?Q?3WCPXIkCJ9sFJCMuUxWzIgXKNALNJaLXM2gh6csSXV994YhcDVJscDImthA0?=
 =?us-ascii?Q?5+wkdPyRwIgPzgljuv0qmRcdJeoiU1juFbJH67XbK51UH1fOT7hvuNwmM3FA?=
 =?us-ascii?Q?uLti/SAtAMPhe4MhnH6NSJi4xHONkynice4u5tHixQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VFG93tkqeZIoO9gSFMPa31q69KsbTiOLbILUXTvtvLjLrwdfd0+FWiEoptSo?=
 =?us-ascii?Q?5XezkN2KCNkr1SgvQ7OO5gPjbmO+cctOz14rxCxtBbvZ5mf8M8us9s8gEvcT?=
 =?us-ascii?Q?b5T/2ZF8E2bJBRdjlTfGhXpWx2N+6hDdrdvFGz5k8siuTPGsg0fpWvkA1d4t?=
 =?us-ascii?Q?2Dujys7XJsOX9OMm+zml4hRF5UX4Bh/JCWl4S3TaDrpGaaJiG95OXfSXDOMU?=
 =?us-ascii?Q?vy72PCCDXjLLF7owcXtz4g0RbsDQSwa70Zkmag9aYw+fYgemQNy3rdiFeDni?=
 =?us-ascii?Q?b8nuSUmtLjDCXSe7RFyuP7TcVNuLnjMbcyiaxlSErwJW5ChEGk+Gi8mhYfsq?=
 =?us-ascii?Q?y8GT3hLwpQ1gkMyf8qm3xq3mq/AeccwGcGx8+yKTZ5tMV0BCKWRq/ar4wqtb?=
 =?us-ascii?Q?2Mk72y3UWVxa04ncGuDLFdYRwu6wtP1l/d8T3ygiUBasX9ecattMBoICiiY+?=
 =?us-ascii?Q?JuAHDpJahtey0TZjOsAhy59o2m6sJzJm2/vRpY1S4MnYDL+4qe45+k8VOYsu?=
 =?us-ascii?Q?ZL6eUrSO8R/6ZzfNywvuTp4OUMxjJhMR9Zrm2M/twvGg4WxyU+n/3sddsmFB?=
 =?us-ascii?Q?M+Bn74ylwUm0JuJ6u8K3Ouxl2vjrOG8o/blSul4leOdVXD43s6Z2OZ8sr4Pl?=
 =?us-ascii?Q?6c4lImquLFaTGDhJkTCfOjqYv8fQ7AMIU8pV8uv+zfiZnn7km7hu4ys2pd9h?=
 =?us-ascii?Q?iNc4oCyvn9brRE+kFDs9uwpavpZNjFJkL+sUMcZ81W6FA3/skQwLRQ/aons2?=
 =?us-ascii?Q?V7gfDmgq2YBRJR/zpxVk78+bo5OrMogt9IR3kCHlPw9GQMrIMpC/mKGdEU+G?=
 =?us-ascii?Q?rj6nzJwH0SdzBSgZk/JsoQsci262PkP1m7043uu3Rsz+/e7xD6EIVEBpOFPn?=
 =?us-ascii?Q?V2k3AM8lMBx9wBh02Vi83kxgy65/qDg8agUBYwxKzWtBxhi+DGG9EtjCm7c7?=
 =?us-ascii?Q?wzQin6aZ/PnU4dcV42VMU7rVX+SUv9nbH5yszAFYy6CLTC0NusGEFrYLKI+h?=
 =?us-ascii?Q?RcLYH1+3Jay3yhAGOUs7N/gpNwxx1sWMp8KPHHQGPYx0Csj/ZbqbfNUovawS?=
 =?us-ascii?Q?OQ2+Y7l/5DR0GxU+33tA7GfBAuTmv9Z1oDwNt5Hr5/lT0bb5TYM8cSHHWqpB?=
 =?us-ascii?Q?Yx9VEpt+Snq+vETCy8v+iYcVMQdXkAOrcTXQgwUbpf6tsEYOAVmWf1I+PSJA?=
 =?us-ascii?Q?XSpBreNf8BI6eVGwq9qqfWMPj8zPZ1j7qcAIGQe5+2Ga36+negL1VHY/vYew?=
 =?us-ascii?Q?KhjvngzeDURbLcu921bO4n2UECB1Ui7TKLzZS8QUZKWtkjg23p3PDqMd1/bV?=
 =?us-ascii?Q?5wi9cu01lsJ0etWEiiaiA2fnK+uJMx2h5Mqp4a8S1qBmDsdHCdtJXNWz/lv4?=
 =?us-ascii?Q?PlUAXD292KloKn1t6yHv0nb+NHfVYTG82UvVtA6SGqT88/X/rsif8qFcLpxp?=
 =?us-ascii?Q?NyJiwkTRhU4/BgHCAFHHazz5XVEL2iFXxTZxP42ufiZwIK+ebEZOJkJGkhth?=
 =?us-ascii?Q?Kvjq5PLxgTA8Yebm8IXorWewA9GGv8t2/rE/ldRpZJ9o347cN7mCwmNeV9+j?=
 =?us-ascii?Q?BT3cMMfK7RNqATtPm5oP3naTWM+yevVNwcFUPSzaAO980843G7Qlbnoq2Yg1?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hWXaq/bOdVB42zwG639y1qFaSTt/rKiAkjaN5/8ukdfrzLr40nknERJ80yGwIiTpGXLeCKsqOTxyQeJN9vhZ6K69Ut+GC8juBwMImsxeDQwa2qH3zRf0kPunWdTAj5zmGvSwc09u697Z8ybqhUYwWRbH64djGaIQqLZLBOz1c47W3Ch1xDWhfE1ylzjiP3SNb0uLEa0OglFcmf2w1Z7O6VOrUmLhoVZNyAjVDVPFXITbssVsF8JfdU5PFUMWm7+ClpJOMl9Vl/4da3yRicra/Q1CYsmBadvmfyrumfILv89Do3nU35txqHgvCQ67KGO4bFRp2tRKZVmt4jkJbzLD5egwmt9ZEui4VFO8qk6en0tgoUHE3qHYqOG1fytnyLT7VKSj+hhl1tS2JR0uzA5YaUTQYvUCc//j4wlZX38UCED5f3Kkh+W6WrvWi6doXVpdgPEHzRDk1ufVfKWcBpHPB82aw7QP+5/MsRPCOlqDDBnabdDEvFn8eoKoH9UWl1JS70mnJneK2f0cCBBoBARbQiKstZfl6F3tVKQEZ2BHyWM0ozOhl8AGYEzNQn7att5Y38tOr34nNM2driKwBUTTDz2bxL9kcezDr8eU2ew2J1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d234d70-4455-41f8-9c51-08dc6ad50b6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:24:03.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5NlxhsiBY7PXyB9VZAKSuFW0KJmYfiY+4KTvrwNrZInOvwjhYNtJjsn35uxQ6ISGYzSDCndvshY5QFfOR9Kdqc1aPsRDr3P6kjbHRA7jhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_10,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020122
X-Proofpoint-GUID: fxAS98UZ28TPua3pDAguLVahrC-2Cl1f
X-Proofpoint-ORIG-GUID: fxAS98UZ28TPua3pDAguLVahrC-2Cl1f


>         .long   runqueues
>         .long   3264
>         .long   388

Just to be sure, there seems to be a little discrepancy.  The size of
runqueues (struct rq) in the latest bpf-next is 3456 instead of 3264,
when compiled by both clang 18 and GCC.  This is correctly reflected in
the BTF generated by both compilers.

Is the size of struct rq different in your testing machine?

