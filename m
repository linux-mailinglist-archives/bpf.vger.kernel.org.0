Return-Path: <bpf+bounces-37517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B087D956DE5
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14104B20A4D
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7B174EDB;
	Mon, 19 Aug 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvLAw2E5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yvl2ayti"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFD16C6A0
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079219; cv=fail; b=TeD5p/neEYq2gQSZALZk3JcpxB7SMlbvE+WSn8yhrNTfWl9KycYUObag0hUBchCjpaUd+QNUs8XQRqDIdJ2/MEQhqRgZv68y5aIKhG4x0nhYavvRcpU0/aLMf0kgMWGb3xU4TJ0jj0Zruv5Dgs44VeQ00WUGMvefApvOS47hmNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079219; c=relaxed/simple;
	bh=M6viDdIvbBCln5EPHXmnhiqm24jMM23I+0M9uLRZLHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAguyBkea8XdIx1Ml+szg7fLV0Z3vJU/hurOG/LfnxIx4QasucAEkDhNIPCSyWrPmutHvBdl69phKcoKtvCco2YzOpU7nley8aa/2b6gLQoE1/0bPU/hY9JYl6ZCx14fwtr+ciirdqnshRfBfUgw4Uz0twvQ72F796gKeOhWpEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NvLAw2E5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yvl2ayti; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6xLv019063;
	Mon, 19 Aug 2024 14:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=; b=
	NvLAw2E5QsIwm8+dnVRUYB5Usm/FV3H4uBh42AjZPeSnCt7Q1KpjJKRXrxm30vND
	cUQ/bkxA4GEKksJ/LblGflYWR+fS91QosV6btp2Apw1RHctAEw8yyZLj6wgba1UE
	cppxU1ZGABE+iBdLexxZfHoFGbeltGWEP9Ckg5l+qbDfNPjZxNK8R6tBvGmXPHCm
	pIutRtfj/8txvCLpfGGtiyIfE9p1LE5zIKMHY34oIIH2AjDGJ+6nIUysYC3YzzPi
	ZPobgbTYP5b/nDeOC84EO6rd+U29kppxsoQNsEU0CL6Jaan/Vfn6SQjDW0J7UFi3
	dESVkXQkcUhGRdBAj7+l4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hjsby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47JEbIgA007873;
	Mon, 19 Aug 2024 14:53:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3p8dyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr8bByAt9RENrZedM7sEmQz98t25QI6DLIWDeqKMN3b+Nol2Dk5JqDqkwSMqbyQ43vn1v2HKFghHQ+RTJuCB6BdznspuUvs2v4BoXvsd+W3zhOyTHulpoabKxskZBv8bX4TuTkw/kL39XurYwYwngyntw4zrtQk5b7i3jDaEC+mrnR2mTSJe5ETgIsD75V5bwcdrSEBkY4aiFMesRMJ4XX6OVCd81UrYReYUhgRPHI9WrGQ1739U4lOgtOBCMpePht9/2+QHuLD8uBVs0DCRjoLdMyY/bUchviO2lss8BIS3FjRtQh82KxEJ/JXkYngX03EC7bldhGBWgcpjjKmfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=;
 b=IPZBJlD9JUQi8oLFwnLi7Z/bZecvmGq719+7EzfBObQyT3vOofGL/nYALwmcoOSRl3LqlWEoT1wPqO0aEwr8T7mYDMSCO99Jq8tsmv/UT4akNTGnHSbXX+lBRalNfclVwbhHFiLF91AfrfvQmhWAcyHjPvm2HNuS3GyHmw9GV51s8QW0QIJRruqsZvwgdkJwBdwrLCYNG94CNNADp6xJUg8hxBEJcqMPwZTOTsZwFXgVzIoXR3sl67f+2DrUVCA1y7/9sal7YL0PTNnMR+nNmB6RfKHbXYc7R9Zg9e7d2pbYb+JOcKtzzTpzBuBAdv0m70j28dpL/TzvkYovfTmtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xqX1CIYywwAFjtNMGRk1mKfTi+Zu4jjMh8QXXiS9Dk=;
 b=yvl2aytiO9/KVa2vvCG75oy2BPgLb39wLHQTuSkwzasVn41DaAMC8qBTmf0FrUIx+BivbX/DYcCtn1YepLorSxNL+DUUR6s0zwxrPQFhRcIuUdGDecDePPCLUdoMtgI/0KJTe/gibZYU7Hf0/9MhdRpWVSu5UZsIUhVxF1+cy00=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH2PR10MB4152.namprd10.prod.outlook.com (2603:10b6:610:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 14:53:22 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Mon, 19 Aug 2024
 14:53:22 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Leon Hwang <hffilwlqm@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>
Subject: [PATCH 3/3] selftest/bpf: Adapt inline asm operand constraint for GCC support
Date: Mon, 19 Aug 2024 15:53:07 +0100
Message-Id: <20240819145307.1366227-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819145307.1366227-1-cupertino.miranda@oracle.com>
References: <20240819145307.1366227-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH2PR10MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 52406f70-500b-44c7-8c4f-08dcc05eab9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0iYTnaMD+7m1g6EX+OqsrvxNK36OgSAb1B61J3Mkt/rNIKp76R7T44w9E1Yr?=
 =?us-ascii?Q?C/zT7XyyITeXgSToGxTrx8d9w5bFdPypzcsqDmYtt4ddWJIL9tPh0uuOFV+u?=
 =?us-ascii?Q?ECMw+VRjJerAmWmX8Dgc6xrZ2Jnl85ys+xIrKxEdUULrWYuSQs8vur6powhR?=
 =?us-ascii?Q?+CzXxCt9jckzIRn8T5q3dgP3uaruODT2wVglAsEWPo1odDGqP8cV5g/KNu2A?=
 =?us-ascii?Q?ijiU9h0K1o2mwULOC1k0jJjDbPkjVAB3ruaceGJw2RDkNytqFt7NDEa/qdf+?=
 =?us-ascii?Q?RSylJaUYai4XjRqlIB3oXEQFSz6tDsW2BBGCbU5tImVC1wz5YCNChc9W3C6x?=
 =?us-ascii?Q?loJVQHukJSceW3IthtgnAHQykmFpeDqziJuFtidIglxUZR0CxPkfzNkTmN9B?=
 =?us-ascii?Q?v6p+Fc3e5UhBBlbHwnxuKiY9R/mgzwJYPH7X4L6EsjRtD1nORYdc6OYVlFYN?=
 =?us-ascii?Q?MLG9oU0YM3Zx90100X8L2lErZ0VkPMxz1nJoLOoilXT9xZiV5z2QBzwhtAHs?=
 =?us-ascii?Q?6JQ6wVXarEcIApTVctVuVKM75xFq5ABC9APLnu7XJgR35I+ycqI1RzE6ffR7?=
 =?us-ascii?Q?jpfYobkUnRvYq/GfDhMh6p0JksyXCOIXi6G4EQ24NSyLHJgtnvbKAb+TPX3T?=
 =?us-ascii?Q?BaOhfaDYOy3nj2r+6gbvTgFp04jtvBaNsJj2c3Fvn5v7oV1Vf9z5RrOpbmzS?=
 =?us-ascii?Q?3AQfop/iE3ApfaSEdMTaX+fnqBlzGRPUttQs4IiskXAle/y0nLygWly+5qQw?=
 =?us-ascii?Q?QlQYvTB19D0VgYc//Jj8j8AMilxBzUA4NFAR7P0VzrHiCoA/ZKsHxXA/Ix6Q?=
 =?us-ascii?Q?01i26XOpo3AFADd2CNJ5U8gxWzghm+1z3lAwgAyFS3Yz7Otx7C4rgHscRUCY?=
 =?us-ascii?Q?VFgs0xPQSXEqZXXxLB/yt8H1c0nWFFAok+sp7e7Yk2imuJMLwx5zurukFPKv?=
 =?us-ascii?Q?LabSPNdr6BCAgT6yxkXpfluLqIGFLVZntTAzsGJFCsU/0sOsLBGUVQoba2E1?=
 =?us-ascii?Q?pPus85KmlU1gS/TWDSlYGcL735xcipmDcMq+q8EWXFHiqWahLh3hHRyOSU7l?=
 =?us-ascii?Q?576vlhQeYtaEGcxr7yX3T8xcFIKS6MH9ziX/C+C5Ncy2Ck2qtzEax2JeZeF2?=
 =?us-ascii?Q?WNoeKj1x3v5jL+cu2zotasefz5gEp/6JTsFAWq+T5h4Nn7qmVS2jqysKEG7p?=
 =?us-ascii?Q?gnjIomy0cEcdSnXT3MOs6lOWkxdR3d6Lp2qy0lKieOHZKFe3UBwOnYDGEBPq?=
 =?us-ascii?Q?F53DeY0l8SnywLfz0ArTeDNJ4Mzh6ar4mOaUgCNyGTBSz1Wn/V6tTNmrDpIi?=
 =?us-ascii?Q?WOxXn1fIY5gr84Y5qmpgJtHKJ7iWji8idT19+90PDHQw5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYToLfOGzkqhcw1+9dwoeWdfv3rbATdQYNx0BpgdwY48I756wqJAGAFDYM2x?=
 =?us-ascii?Q?WBKPZgZL2G2ZQac0Mg/dFg1ewdBps+TnYy131EU0yFjVkjMc7DswK/Gi8BK5?=
 =?us-ascii?Q?tbzyuLPYj6WTd/d1Xp8BaWEjpnC2n2SV91dAK0JV50Jj4x7uDdYGhKurezDv?=
 =?us-ascii?Q?0bsxMzM54Ds2T8ewigrV0Xpn71YQHO5CqjkeHbZiEgQnUXBZ/g5rkF4RBVJ3?=
 =?us-ascii?Q?4+60z5+TJJD08XdKeUlJanVkxqLxvY68gtZpTPtJW0bgc7rtjGzsX0SegFTO?=
 =?us-ascii?Q?dNqj9RXemvfcPXwVU5P2+8KVseAsXcHS8uyZi2OYQsTM0r6DIRx2kT5/mwg/?=
 =?us-ascii?Q?+FzXKmoqF7KhTgbuocMEhTMgAsapOhVnU/dYyeFqV6RmVa8ohV8gtDB3fCoH?=
 =?us-ascii?Q?IdLymvLa196koOpjkawdpA40FD6JHB16M8oL9mHIySpT9UwBhFLILjlyhSX7?=
 =?us-ascii?Q?CDuXqczUcNO5ejiXssn8euIttYfIAiIHzUEGEBvUjafW2R7MbTqcnlSve+On?=
 =?us-ascii?Q?x/P4k99RBemCt0TnJHR+DQYmpZw5QHJBHt2eMJiq9CgUnom0FSqposmBeHrf?=
 =?us-ascii?Q?U8wj8p3H/F/OXEiB9ds5kr1CRZW56DOS6oFR6comATfBu+3U+30PwAKxDRVm?=
 =?us-ascii?Q?+rU0rYxGMr6kG4YUkMQzg+LpUp+FPcO+GL8Q89o2rBnX3gnap3JSfTK19lo3?=
 =?us-ascii?Q?HCKKySA6qTOS5iV4qW8Fh22/4bu09GMZa+76IJs/bZ5lwIndD+A0Uabw1pu+?=
 =?us-ascii?Q?HBNRYMDoHa29Bf47r3yK0J9HyvRh932jXbpncW6X4/iNMxKP0IlxlVSI1qaB?=
 =?us-ascii?Q?550P2Yg/LAHWQ84srjtmoz3Guc++aE0BzIFir12vQOmey21776j4d6gtVAnf?=
 =?us-ascii?Q?s+xAN6VOe7QPAKPzkDlJ5Qk4aTSIsgpEtnD0mfwmtmbDnldY2+Hw7C+WY6HN?=
 =?us-ascii?Q?+MrSgaznEA0roMMfJKNvD/koDyIZq47CTKuf01oZIMQ6M4PxYFUn94qLXYN5?=
 =?us-ascii?Q?CCkNxD6TiaDduHyf7XcoSnkm6UlCTfzKR/WGAXpI1zxTkSJ7/NGbw7LVtJ8A?=
 =?us-ascii?Q?NWWOkJEjULhbe/37Stz9lcOoKgS0I7Er+SmiCIUG2HGabugsRISP/i2JU+hh?=
 =?us-ascii?Q?6gsG3j+KgI7KMm9ynWkzEG7f9VHXilm+tLSV61HW7LVi3Txs+qHMXJy+HTy3?=
 =?us-ascii?Q?Bu0b7pEyFV/9vsGCQjy0mw7oIyIeWS1LTdYuXB+E6Tln8Jy9KpNYLDtMpkOH?=
 =?us-ascii?Q?uvO/JKzuEjWcbQRZ6v3uukIuOTUvW8gmI8DKUSPCBKwnahrAOQXbswJ/378y?=
 =?us-ascii?Q?PCUztto2ZxAIv9nIHHaVf8DQ91p38+BFIpCSc5Qvmxpi1PItCmBXVqlq4VyS?=
 =?us-ascii?Q?lNJxSQw6IqLTWFZVkWF00YALfr8wMtm8IhBRTFVyA9GyeU+tqh77RH3Ig5jJ?=
 =?us-ascii?Q?ZAxk1N0nfpxzjFrZOi26wp+DEzN95hpHPWoH7zpHwrojGtASvftWJOLvWO38?=
 =?us-ascii?Q?p+ZsvHvVGh6grYK94vZHwYXR4refJUnztDlgBqjsQLOiZspfUUWCvKY6rBil?=
 =?us-ascii?Q?J9js05Q1yEKmJlmuPl2VaqyCpPFpfg0qU4f3KGT/HxV5r9zCPSwYW0NwqE0n?=
 =?us-ascii?Q?1p5MJ+VPCQJPU7sgyoLw1HE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HuHERymCC4gJn1xxz363eL8Micvpjy6YW+/hKC77Stop9og5odg/FHh63ixRJN2f2z+iUIesp+WEB/JmV864RzVnYoovPSCaWR9kYapjZkGPyYWifYKCNKsHutkrDATAAWM5RKiYMdo4wCKCWWjsFugVtlX2HMIWoR6ctqOYjfiybiUTJ2YHRdnCsQC25Nar7wptTw1VqeyoC1DEfB636qbOoa82ni6rEsgNlLB1YF4791M9vbrHuWOUU2xFNJzxyOHBWBy4+zJQxrqhP5hTMHGkQXYWSzjW4TW+ptbXmc2fKeA9QItZgqU+mWq5yI+4XTp8X3wGwNSX1t8yigMqU6/JdKguv1F04Lp99HzgvfGirXp8HROoozsga6uq85+1L3ixLU6hdofaoW+Q3caz2voI9bsLbqE/xJPhdTf/L4ES9HSaHFYsAgD4cek4OmhEhGKJZhLkKXd2DISCRYb3vDZIzwIljzQYyHyLYXeVo6+a1i896EccKSr5Vfh3tqOY4AlCJGkIwrf7CnmaTruSYyg0f+jm1tW1eED1UvFnzDjjhrGK5ItHRBfwvGC3ukyKSPeTwRdCiejIHVWNcr+Q7Yx8ioGkQkmtGEBmo52en4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52406f70-500b-44c7-8c4f-08dcc05eab9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:53:22.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKerNgwzvjNhE4yaHbU76M5rnYU5MfMYKkIXlOJMtrOAOKaDV2bDnbnV2u7yJm6/H8BfJ5ysSu85Z2f2eVju8nFXVltPSKnPbV9lS3q6sbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_13,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190099
X-Proofpoint-ORIG-GUID: TasyezQ-iw48R67d9U1B95SgTqBZhqAV
X-Proofpoint-GUID: TasyezQ-iw48R67d9U1B95SgTqBZhqAV

GCC errors when compiling tailcall_bpf2bpf_hierarchy2.c and
tailcall_bpf2bpf_hierarchy3.c with the following error:

progs/tailcall_bpf2bpf_hierarchy2.c: In function 'tailcall_bpf2bpf_hierarchy_2':
progs/tailcall_bpf2bpf_hierarchy2.c:66:9: error: input operand constraint contains '+'
   66 |         asm volatile (""::"r+"(ret));
      |         ^~~

Changed implementation to make use of __sink macro that abstracts the
desired behaviour.

The proposed change seems valid for both GCC and CLANG.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c | 4 ++--
 .../testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index 37604b0b97af..72fd0d577506 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -58,12 +58,12 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	subprog_tail0(skb);
 	subprog_tail1(skb);
 
-	asm volatile (""::"r+"(ret));
+	__sink(ret);
 	return (count1 << 16) | count0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index 0cdbb781fcbc..a7fb91cb05b7 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -51,11 +51,11 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	bpf_tail_call_static(skb, &jmp_table0, 0);
 
-	asm volatile (""::"r+"(ret));
+	__sink(ret);
 	return ret;
 }
 
-- 
2.30.2


