Return-Path: <bpf+bounces-28173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E208B6489
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7E31F21E3F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE51836E7;
	Mon, 29 Apr 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+5BjEG3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KP7VeF6i"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BC1836C6
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425848; cv=fail; b=nFQ2vUECKrWuqqO1CXs0C1GluVaR300DkBITYHZhkrSzhXnEPtHfnOZNpymgiiYKT/oNpj6LDSNbFforkofKTeW3JxbAn5u0GWx5rVUVzokRF7tMV3FlRKKhwpHRKR9X77JqtYegROAu+6BVNA4n7+3hqwA9zss4PjaBrXkYUVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425848; c=relaxed/simple;
	bh=JKnYiEtRXy1wag8ftwtZ76Lj7M+XW1EeiAfnnrxopcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OMLwXHNateJWa19JxEYsDS5a+AeMJvmHsvnzBJ/fu/z/1pGUq+/NCeUA4vsBHVaCCnQiU4+qaG6CF/UUbh+xDdsLd8skdSE8rVuE0Os9jGtzEG5tSepsmrFu+hM2qiveIRlu9TMxGnDEMwAtxByiYUSrtMLdgFFG8b2IqomSr/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+5BjEG3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KP7VeF6i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFdEM013364;
	Mon, 29 Apr 2024 21:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=SuMwQEFkgktoVleGnGBAQfF4beb2ozr9tuvdmo4lz8g=;
 b=g+5BjEG3JQvxeQ8OlHsVygQVSuwBBgqnYpoNh8iTLS/IJevnGEyhHs36QCHkTB2DBw2Z
 XXfkiAC67vtRX1EHETxjocxHbsYwjRQmrLz3BajP/3zP6YWMSORzaYfvg4NYO4+I/pH/
 dLz5MCdfz1/pGHqblWsdmzTLMed6eUpouKwQQb6myAF4dTe4rXFUzrxpVALH0vECgULF
 8ZjG4XKVzAErfjAi/c47pQ6c1qKYHF8HO0xXOIkkfI8SB6tb+j/vd0P38n+bto/a4356
 PnPpxtlpQsX7SiR6iswXQZsLxMleWXVWH/0NdBfCcqbHgf4CENdKStTq7qEnOnrLIrYZ mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2urm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:24:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TJwqst016741;
	Mon, 29 Apr 2024 21:24:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcyuwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W44/MJPRKXDA74DrUvUDg9IHK7we+g8WdAr2Zh1UvFys+I+6O/xKCC6rnEF1yPhcTzh3IK0hIqcNK0dJ+qu8hf9gZHspuauCTctAJlj9tUaSAhcfr3czH/N8Y0QG7vbX4yksw1uoaH2YzMTxQ795WaW3lJCsNpVxaHAURQP8Zw6pDSSUEJyJpv5VA/flIh+Tnc76477aO4Y8a2mQ7KHDZepc2Gu8ZT+TTXRz0edDmfM26sdQOhRiHnMrrlIsiabnKO4gJq0taxFnfCXAKQMpVxB3uYs4SVidba6nDzo2BlIeWRoDMYjmGgnVEDvTkB++o8irNq8H33LYmRRGe8GAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuMwQEFkgktoVleGnGBAQfF4beb2ozr9tuvdmo4lz8g=;
 b=ZR49UTQIT/jkTUG3IhsLJ2maQCtlJguXKCyWtq9aQjY3oKds1jm1hdNVy7KqwbDnRWW6t7rBJNd2jVRBXhboj3Gd+1U+yTOBxtsS8xVyG+5VUyh8WROhkdBXyUmqLlaOjvh2NIUcTQyxrihl32PfSiUoQ80RWH+n/46Q8eidijLQpJUji/ZheXeANOkfTW+XSCeXSlYonrN4B5KfGMjV8KGyyuaxo/5XA/Um2ECp7v6CEPsxWjcUbw6GKQKX/G+BySDTqeuD5mJeGfcRZgxhiu4a0XNWZNs8ZnFG8X+rHDW1KS6HkViL9/WMEGAuclsmEHeEoyUaUZgi98/puwdFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuMwQEFkgktoVleGnGBAQfF4beb2ozr9tuvdmo4lz8g=;
 b=KP7VeF6ijRo+6XTOVQdgVyC4aymVhfwLcx+/PYmADs6saAA95ZPvtDOwbkIuzOh7VYIDgQdVHzcJLqW+QybcgRj9Nd6mSRqY3eljbmsihnSQTp7SaFEIwgRhJC86RZwhvWL8QVvE91JNOam8ZQqCiaNlIRCDnvYZI4Zc8TtOzN4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:57 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 7/7] bpf/verifier: improve code after range computation recent changes.
Date: Mon, 29 Apr 2024 22:22:50 +0100
Message-Id: <20240429212250.78420-8-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d29b180-56df-4e90-d27d-08dc6892ada9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s1816jFXnxwJS2J4mN/BVbTg1qbOOfOQsnqjQsGFeuQkPgn7XYH5xKrgctk6?=
 =?us-ascii?Q?Yw4fTZiMojH9TM1OSNQH/Q/PQ8yHxncPBSTgDkpLTp1R5DR+l8FLrMJV+ySA?=
 =?us-ascii?Q?8OcSJl0tNWE+jIRFlu78MwDxjYor2nUSI2Pv7ovegEyZA8V2TeYZoa/q67Qt?=
 =?us-ascii?Q?OvXINvAf/7+/+IV4K4mLY+o0TO1NGLuDe7CnpQticgN5JigcNfODL30tnUcn?=
 =?us-ascii?Q?5gt1D3Wm+s3P97VmDDL52sRn+9Qk7JD3+Ly0yhd0jOCT2tvGa8mCeijlhhr4?=
 =?us-ascii?Q?UhKlioJ8gghuxZLMrkeQkvx4rWETUtfqCskCtBDV9JI7N0zJX+GZR8JwNglD?=
 =?us-ascii?Q?daZJB80Z+vgrbLl/X9jsmwMPXzp1m8t8QCIvdMr5elamL/tDRS3WZHHa6IgP?=
 =?us-ascii?Q?MesCyj6GrjQyapEaakvgpXg8jgi5poZdbC81KWIgFGqStb8Kjasxyk8H4qvj?=
 =?us-ascii?Q?N86nh/mwTCMuArOXPNG6Q/bOGJi96Cm8OjCPpGZeiUdIa0UhXospHnmadZt0?=
 =?us-ascii?Q?KK8DGVyQnN+tIzck7VHPO+NeeYVEWVsOGVUdy5QP205VT7l1NN3T838Ue4jN?=
 =?us-ascii?Q?axRseBSXHNJi0a8HnkWX0HuKM/1qVUyasY5Z8kcoyo0gErYHv9G6FtYMJMir?=
 =?us-ascii?Q?XSB/5sRNyliViL7sF/YYNgroplyB9kW9rZep2N5navQ9OJJS2wmAow2EF4Ug?=
 =?us-ascii?Q?UBJleBjY4ZUR9mkz9w24nsZkBv5WMQBzn032DSTsfGV5nvgRf5xmNrRi1jCN?=
 =?us-ascii?Q?g7kEf4dtEJyz8QpLNA1wZ3NzfsefqYfBrtV3OUbl6mQKWH3D+lnWFSKQwiNC?=
 =?us-ascii?Q?y8CeXvRZpfgW4eDIFWEmFFIrgw8hvvKiHUavo7Bbot12ieI8IkJepqAn5usp?=
 =?us-ascii?Q?U0pVbhasq6fICBB2ebeHRpMLDpCJqeBGwE+ROrD7BXFS3MlLNqJOfppfQ+DP?=
 =?us-ascii?Q?ht2SISbE3arSaY5Upg4dVMoNeavbvwrPpfWiuLlbaRjgrXULm1Jp+EOb6fIV?=
 =?us-ascii?Q?RoHKeVH+WCnyWjOSORPP33tlF1yUMywTXMPixzS4uopqid5eM5gwt+454mXE?=
 =?us-ascii?Q?o3Aan0Rvn9gaVSaxCdAz36LNzDNmWE3QEQv79+MwW7PzJMegF65YGxfqWBv5?=
 =?us-ascii?Q?BIY6mADSVnvo6hS+Z86+M0AZ9rBi4b6ljWL2Jz7dQ8EtIj7oI7o+yFc/8fgO?=
 =?us-ascii?Q?Ws5rx2pi2X3A6YsXLV93/j5Cdpo9KvyFbrVdBVbBCgY6tB5IqIu9vxGRAKzi?=
 =?us-ascii?Q?bjNVVvYEHrdjP1+QU0VAaC9vQqYeJ7wK4cQLnvQ3+Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cyd4iaqBNjVWYR7Q6Eidec6G152pmc+H+Ay6zF+N499iwPgD037Je0blotls?=
 =?us-ascii?Q?a5JyGqhBXQfWMowQxG0h/N8V3z3deXZLxNUH9WN737r0AHcespfVXVAUIZPG?=
 =?us-ascii?Q?yNvtXdJbQr1O0j3M1WZjqcO5vWuz+0+nVn+JBrPT5zli4/6gTkpZepzG37Hh?=
 =?us-ascii?Q?3Ec/Q0kGZXNFKL9zblUqAiGsWuYUU4f4S4K23g/MgW1jz8BXUtvulvrzZJqz?=
 =?us-ascii?Q?aO4kyrvtmFNUsj8uTnOfYYutYVCIoOc9nvlbVEL5fy1fB7RubqZSXzbf/KIL?=
 =?us-ascii?Q?cbe4LCE/SSsifukv9DrP/ZYYj2aJ/FJ6pgr0njbaOSUyAB3z0m1zDsaH2Jly?=
 =?us-ascii?Q?F/rvpIJiwRp3OQQNfabIRKYTl5xr6ZGW+H8fvgut6EbdZXldzS+7Gu2c3lzO?=
 =?us-ascii?Q?BrXyS+YjPyiUOS5Eh5PB9rdT1zIM/e2OPwPv8LGmxGt+vJM3BbBwtQ1h52mW?=
 =?us-ascii?Q?1tid/2CRtfcv8gvB7RJdPqRf8ObfZ+bC/TYUZiN3I9PDqq53u4GGo7haIERr?=
 =?us-ascii?Q?GtABu2IUHsG0QrJ6roQNpFc5mgqibFkY6StSY2iq099n2CAFsBAj4KIsLYum?=
 =?us-ascii?Q?pMwSxn3MU+OqNRdLCqVL7OYhOmE7ARjHtVg0ANOHFQ1qji36rvdaHiRvcwOm?=
 =?us-ascii?Q?E406ybtEJxxKhfdYQss8uAgWrgk4RpkMq0SJhdBeH3RSHkN9Kn4nus3Jwjlj?=
 =?us-ascii?Q?Rx8diS+x08fh6l6MZQxzYH19QMeNOQRL90lk9MVu46BF9zB6hauVPMsmdWKq?=
 =?us-ascii?Q?60xmbedm7jzKKmqkVjfrfnohd+T6xGg8ZQtLUFnfolw67baXPL7pcMGBD1tp?=
 =?us-ascii?Q?ggbNQU/zfWFvWCuep9tJMwCX0vTXgwBwvU6QEc3GPVl+r84i/fTJuij68UdM?=
 =?us-ascii?Q?Eoh4JLOwIYg4r8IvV015NkQWpJwj1sOg5gX91p7QRx7Di18Tsa25wJ5ouOu8?=
 =?us-ascii?Q?2KgKcCww44MvGmhVpQ6q37Z4RhmQwaSi+ZfZz+lMV+3IYxnP4pg09AA47DWY?=
 =?us-ascii?Q?f+ONMUAjXNxhvhyCHudAHqMwwy9KG2YQa4qLE1ExtTyPYOVY1DlQ7pG7TeGd?=
 =?us-ascii?Q?csvOOykdE/uNK2PChh2vNk0NIKXeOouEy2+uq5AN0us0L3wuFucEHZDt1Ygi?=
 =?us-ascii?Q?4yGsjHqJ1UywLTZmGblLQTVHVELbbMeIzQzUMMkjmimWMA+Ih96J9Ja17avx?=
 =?us-ascii?Q?pEDz4EOK4xwbobtW9dGN13gcL+t1MIKnAkrRgbbol3d7GEsQEgTviDbkTjdv?=
 =?us-ascii?Q?0jRqPZZ0UZz3UOqTcBGYUqWeYuHI23nEpTYYeJHRjaTYZfld4MZ4QdrB9P3l?=
 =?us-ascii?Q?FTKIOuPu/QGNQFMYkTXD7YXxjTpWLVSkU1yJ1uuvi1acZPBr6RQvS81EIziS?=
 =?us-ascii?Q?yyMr0xa9OKehbpQ4j1eSp3TUDdzL+OIk6emMLOktvltXMvyNzc9JDtV5oNwe?=
 =?us-ascii?Q?rnFt0nwSU1fYwVSGsDa7ZTLQn439U4zzv3CLhNUPY9vZO2N5pLbDvdiwt5lA?=
 =?us-ascii?Q?VT3aYatDIc74ur+elqt+EoC/NBtfyhTUrGaq1BS8yGurRXn/6+bfD06adGJJ?=
 =?us-ascii?Q?xcQQa8xoeFOzWSn3UM8Dj+VZB2xrN/Fkd0I31YrjWgZ1G+rVuyfYkkak2lfM?=
 =?us-ascii?Q?1wpMt9PkPBmJ/9HqDjOKxMM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2Si7uk2qmroETYl9HnswfIwLwAu6s/IkNeY5tfVPXAINDMmH/OObKJO7wwmZ6TleUuoLdb0hny1zyHrMZ86wOMR8f+tLWivw+JrNTFJK4i9/6fHrRaZLKBagrAz0MDk2HsSDTWmLaoP3cJ6ujSv3/OgnXXQM1p4sQXcHSTgRlsMlLlr9PbiCWpNIfAheDVylDTNqRhYwDR7xI0eqcA87peqmYO6qUbX+d7fsPDlF8OO+cTnKDv6PxrWQph4CtIJYaNKb+K7lE3aKWUTk9h1ZXrJVCNeDJAdRzYcu7ZayNvK/ewyehwyxHePAkx2/jLrj5kDwzTtH22e1EQIpInLsYI7Mcb7zu6oDfluldSOUOrjeTVqnEDL+iew0r9pMnj0wTbdo4RGZc6CsLUu142gSuiio6PbLn22p24UEhP4cSKxOJX34zAD8dXcU1qZN7fD/a6HtpwXbmnq7hPOSeBgxlJXB2SJQ0RdVqItq/swn4YSBuQ5GT9TYiqTmMMMPQF0IbLy5vKCVXt0lub8I6hqb7jfLex/tPX8+xlFATKtQdg7r1tnfqi8H6W8pEnwgBXbAI/cZJTq/YnF7BLBwlfg7ogPNKA4H/FXWiPnFSwPRzdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d29b180-56df-4e90-d27d-08dc6892ada9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:56.9983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iLsa1lso4KvoZUsDkH+SbmzbX2pyW5DOY0XJsqVHxaNFdSo7FKF6Zt4N0jeOqzViQY8YqRPwO/RL90haH7dd+mtSolXo/dUORBxCIf7sCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290141
X-Proofpoint-ORIG-GUID: dxKpD6EfpWog1UTIIlSXlXTpILrkFrF3
X-Proofpoint-GUID: dxKpD6EfpWog1UTIIlSXlXTpILrkFrF3

Recent changes in range computation had simplified code making some
checks unnecessary. This patch improves the code taking in consideration
those changes.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6344cead2e2..a6fd10b119ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13695,33 +13695,19 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
-static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, bool alu32,
-				   bool *valid)
-{
-	s64 smin_val = reg->smin_value;
-	s64 smax_val = reg->smax_value;
-	u64 umin_val = reg->umin_value;
-	u64 umax_val = reg->umax_value;
-	s32 s32_min_val = reg->s32_min_value;
-	s32 s32_max_val = reg->s32_max_value;
-	u32 u32_min_val = reg->u32_min_value;
-	u32 u32_max_val = reg->u32_max_value;
-	bool is_const = alu32 ? tnum_subreg_is_const(reg->var_off) :
-				tnum_is_const(reg->var_off);
-
+static bool is_valid_const_reg(const struct bpf_reg_state *reg, bool alu32)
+{
 	if (alu32) {
-		if ((is_const &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
-			*valid = false;
+		if (tnum_subreg_is_const(reg->var_off))
+			return reg->s32_min_value == reg->s32_max_value &&
+			       reg->u32_min_value == reg->u32_max_value;
 	} else {
-		if ((is_const &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val)
-			*valid = false;
+		if (tnum_is_const(reg->var_off))
+			return reg->smin_value == reg->smax_value &&
+			       reg->umin_value == reg->umax_value;
 	}
 
-	return is_const;
+	return false;
 }
 
 static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
@@ -13729,16 +13715,8 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 {
 	bool src_is_const;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
-	bool valid_const = true;
 
-	src_is_const = is_const_reg_and_valid(src_reg, insn_bitness == 32,
-					      &valid_const);
-
-	/* Taint dst register if offset had invalid bounds
-	 * derived from e.g. dead branches.
-	 */
-	if (valid_const == false)
-		return false;
+	src_is_const = is_valid_const_reg(src_reg, insn_bitness == 32);
 
 	switch (BPF_OP(insn->code)) {
 	case BPF_ADD:
-- 
2.39.2


