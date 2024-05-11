Return-Path: <bpf+bounces-29598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99F8C33D4
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 23:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF059281CFD
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 21:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0471A2233A;
	Sat, 11 May 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAcg1bcM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hlZDAKGP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BA1CD11
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462548; cv=fail; b=uxhr1AUvWeSoJCKLFxCySsFanbOry4y1sOBIwXJRPWadqshE3lJE0YIERipvf87P4Gw86OUZBjDQXOOMFVK8fg7visDlilmDAV1DCsB59g6IZu2qwVLLcGIPUISB7fu16DfsX/nH2Y5GleTSXHfJqphIOyrnnvvSsexAA+lTZzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462548; c=relaxed/simple;
	bh=xEJ/4cqmKzdxVcH1Tm/oj2PDhJToI2uIKBkcD+FsbRY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fq16YD/mEWtE8ZfshNIF+LPpJpY/2GL7AVUmFB/yklomPI5PGjIGFh7YJ/YsjoM44loN9eLQebkc2BX8jekKIY2TfUB4kJJ103m0kDORaFpCxrYBmq4PTlGfPc+0MyoNZoajaCilXBoEp5wzmFiWyMZNu+SjErm/SKSdjGeC7PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CAcg1bcM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hlZDAKGP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BL75GF031927;
	Sat, 11 May 2024 21:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=i7S6vR7skRewr8ry/XrasFZDQqJLaBDqk46/9HdSwbU=;
 b=CAcg1bcMYs9n5NjtxkXu26/JoTPSv7dvrrcgpg0lZ6JaQBUyIVzIEeh2Mtixk5RhIzzm
 UoKAhjS2dy25wBhnu36NtboPv2gfBGwf9Bp51eEraGpIPFt5KViQYs4VIn7iZynBCflu
 kog+C7WZ+GKPS82/FyxhKIHg5uazRnfGqkNW0DgIeDVrBADL5cFuzrUrwbpLnKGagE7x
 2nKPrqTtSKTpGLuJwrvt5T6PE6ulNSK5fmzJNfdL36v+dzu1ZqvITXFWNosmXVgzmBEW
 Hd4ksxW/wMczu2+d1MyoD0mcBdEFu6R18RhagJJXPw0YuqCT3t45lf0MKA+37R9yOMND 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y2ga2g065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:22:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44BKpJdU022362;
	Sat, 11 May 2024 21:22:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y44hhjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDluMmdFzjcMqlXFLzXH8tUmLSw0s8sTDdtk5HSFXaRZwX7DJ53mQ6tYwDD9qTSndtOXlXUuG/2y6GcOrsJcAvUj1jKm9397b3aq3mbMMhfvfQMpwcQ2iSJj1kw8RXu0Unh+79m/Nb/okzC+m0kSC8XXjNihscsTVUMStvNFHzOQg3ZxUXn3cUja6u7C2ZN1jB+zq2sP1D8tz+o01clSbDWQdWTxZX9SVTBpYIsuglBiG9iZYbMP1cGBpT8tLWTgYga/jqvAOSOO5/AAFzY1p63X5cXcB4C3RsgMhSmPtC4HpJm24+FK72VvoKpbV8V+3QOEBfGqnKg0NJXr34XKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7S6vR7skRewr8ry/XrasFZDQqJLaBDqk46/9HdSwbU=;
 b=JkeE915zzGTL/E3d53e/LqRljgM7AIxx1IDB2Pb81GMP9/bF0QkBMxgKoJft/L8czSBO5xfTEV+MOuuiM9PK/JJ+y7PZNKJZsdWmXiue5crzUe1p04BVOrGt9cVFzXmRYuc87UfhzhZx8Parn6N7gVulUg737P5fwfKPoHbR5uroZMzibLz/KmqIMC5CrELzHJRdpINVrseebe3MzkT0ebF71AO4+4Qz/A8ls5Z74w5WQK020aknbRQq4oQS9gBuXL9tQ0LugiqTnOOYwkovAwni2eEzo5JsJtXqgSXD2+Yz8p0iAjlwJpdpVd2XbsFtwI1G/O1mYp4370dMwu8i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7S6vR7skRewr8ry/XrasFZDQqJLaBDqk46/9HdSwbU=;
 b=hlZDAKGPqzA1GZDuJMM7HRPaRb/8vYmof/joAWAatsFZGZBYLN+HlJO/V8VRLI6xB6g7AOVFtHVHyN95SzAhqH5q1f4zr63RbZUmTMvSnfcbropgjeC7Rz+fUuUnLPeiG8m55v+b/MO/wGXxM8mCuFvAlB+SiduLBe0UdwjRUso=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 21:22:18 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 21:22:17 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] bpf: disable strict aliasing in test_global_func9.c
Date: Sat, 11 May 2024 23:22:13 +0200
Message-Id: <20240511212213.23418-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 456b3112-e0ee-429e-c84d-08dc72006f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IPqjm95PTd6z6OZny4u7S8buKnPnlxX7Hz4ie1X6/BvA/jSqk4q3N8fBFyjB?=
 =?us-ascii?Q?bNwFNKotVT4of4rFQp1U0ujXZq9sPiSsudcns8UMKtwzBdqWiOjUJO8DwzwB?=
 =?us-ascii?Q?2RO0G9Sc0MB7fQ8IWdBNZBGo+TMwZE30rwQbn5EGJUNDXzPomfyrFiJUstF3?=
 =?us-ascii?Q?5Y0zoqksMQ3b7mwAeZ8McsQeQwC5iJ4edh8JVoYU1S07zEv/kbLt9yrW7L7t?=
 =?us-ascii?Q?kxPW0eE3X6rmjWt/ZbwHc9+2092VSSOgpvVJ+3mNv6G5GaouKlaM8G6P99yE?=
 =?us-ascii?Q?7+VNGdmawvW6rxey4wEuv49MvB0x47wlmBWxfXv2+xZSMSY46Px5B/Dt9QvF?=
 =?us-ascii?Q?ytoK5XVrLl4mTy5Pb+yhT3LE31VdnuB9HSx28aL4Sfti580SQ4bCfX0kAuCO?=
 =?us-ascii?Q?ycT2pvbr5UOi+rwWwRQJcrRw4wE2aBNBiTfp/Y/rV27dS34AoGCt80l4HEgS?=
 =?us-ascii?Q?AMyICGauCoeg/eRUlsJdxcgM78YD00GiRRe4aHelYV0Ri1JxvhhUewHhmETp?=
 =?us-ascii?Q?puym2kz37F4h1XijzAN01pWki+GHsvZ/XaEBrtFhYJFGowWHQBrnhrRwudwE?=
 =?us-ascii?Q?U+e65daei0uYUPB6kmLBAhV7Rq+Y9Ey6L6IAl4QcHy3egGuONaDVrT2TWLL7?=
 =?us-ascii?Q?XQbXs8kl6w2ac2nES8XLg0UQxjZvUu58JLLTbYaWu1OPB2g/zQsqYCpXm042?=
 =?us-ascii?Q?Lo28kxzpQfQ/AEh/aru9Hg9leuCgS5XKIec6H6cdggWEqQ/DZARnLyq4R6Fl?=
 =?us-ascii?Q?TU8n29bbmGmTA7+b7NWrfNfhIRUFloYplB2mSTn5521ts5ANhaHn/CjEC2ze?=
 =?us-ascii?Q?uBDUxCqsk6gccjoyScf+tc99EtU4zxOGOuo4l85bQ01vfWbpU/JKaxWkWHL4?=
 =?us-ascii?Q?rVlJpvZdLUjrgOp1Mp7xHJPeTSi2nSmwfWTSWxjuhqTrOGfii7X9GuSG+Edz?=
 =?us-ascii?Q?SQUqwaGYvECtz3qIDZNpLf/Y02yXvbNtxmXKwTpaqOHim7ZjPRy6HVplAdNS?=
 =?us-ascii?Q?GYDr5DD2GBQ7sp5eznQb4NVVzFE7d13y5Uw6vZ03rrOey5pfMKJCbraWpG/7?=
 =?us-ascii?Q?8YgVirsFu2KVtnpb0w0/mBurzUchtWAjj29zbaJ0MKDVm9Ggd5rz2Gu1lKes?=
 =?us-ascii?Q?FQzmDRgrgKKGU3xiB6CIS2jsyP0bz+d2TgvWQ+EYH7KLc5ghVcnFxFzg+BWM?=
 =?us-ascii?Q?z0NZ+hR4TjQuMXBCQ9MYAqtt+mnIPl0+NylOS3X+aHCFPvnfWQT4XT/PnqnO?=
 =?us-ascii?Q?ZCD3kDA291pwO7m12N1NcFt0UqlA5aDKNCzyXCP+wA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z1yA0L0Qst1m5pys7WUftaAtnccZGBi0Rvos+vCmlihLlswwiR2sSPJRGLbW?=
 =?us-ascii?Q?QXwlDB/6zJxgrcsHB1gEHTrdCf+TIK4GsZ9RsFvj8UQ88FD9QNHaOTnKj9v0?=
 =?us-ascii?Q?LDVh8N/TUREfADLWdnVjTWnERfBFmh04Q6X5yj11gknxDHB4FZzc9MvSI6cN?=
 =?us-ascii?Q?WUKQ0im+uaFHtfo24Cb1TGObArWVdfTbnJgn0pRwznTCqt8W4C2L6calxsSx?=
 =?us-ascii?Q?/BMrVZpgksCTNeiIz8y4yfhf4Ih24LdCMFnU9Wc95MrRti6S8lY6dGOInYbQ?=
 =?us-ascii?Q?lV0chf24XB9hpbRy/w48h1qOMnArt5vZYfJC4xxJfYV2LDwPGwvCPWRO7m4Y?=
 =?us-ascii?Q?fTZ1sDTqj6q3Dk2jGWmA+z4Q7DdOFNH3MNubGVT5Bau8A8FrzlviGX51xtCt?=
 =?us-ascii?Q?/N6OPKiAdNkLZW/PIBG/QU/KD+yVTr3e3BRt7lC7pKUw9TBm0OFIb9qqdBAK?=
 =?us-ascii?Q?H3AeW/jSyjibKL4CA68C1Sfr3e4wEUdR2bjUQfta9Rh4mFhCuMInsuNF+eBM?=
 =?us-ascii?Q?DrxAOeDK86IgbK17PrEB86TAVkd/e5iD3BjFU+8o81cGeRXtgZTvJJ0C9oPW?=
 =?us-ascii?Q?xfNj+6XFzuMvuQbmUYQ2V3X5YaH5LjFcMzk+la/G4VNK1HvpMKa5m9XbMvl+?=
 =?us-ascii?Q?n9GeeNA7/obFdE5/t8XMliBgNgVKc1MxcGjsBqmR9gwOAwPgQYC36KpGDYO4?=
 =?us-ascii?Q?FkVfO1vttWF8mq73C1geXQKUG65uXoSkOoV15SWuzJmLaKTCJcbqTj/kEKH9?=
 =?us-ascii?Q?IUmxRUbBRUSGVygs86+PJFXwAtog8Qs95SGa0fNPH5Z1Kj65bfLzjewERAOu?=
 =?us-ascii?Q?yrf6JSTSbIhGAELLB52MGCf+TEGaSlaNxsogSDkySMQzkvUyh3dQG3mFJVCZ?=
 =?us-ascii?Q?PIkWjmq18X6uaisJIG9gX62jGpdSeZaSyzM0j7I/HrB7yM9Y+HbYEAHVQBzu?=
 =?us-ascii?Q?gx8OavXtKxvrZB64Vxivpbm+087N9mkgEVyz9Os0TB3J4JCLs+treRxVZT2w?=
 =?us-ascii?Q?sDI2OacTsZL0OXHndkqE0DsSlhPsEWn/DuWK0280s5qX2s/xGjBXNP5PPVZD?=
 =?us-ascii?Q?wKFEmxhJ7d5opb8v+XshAz7dtAmJ9bUXArGEDiidRdm8qQw4Evzr/eiVjVA1?=
 =?us-ascii?Q?erLY//dUu6GItzxe3c3dg4Sp7ygNK61vFrD/yZWTX80OirZ0eKZRIqc9hnUL?=
 =?us-ascii?Q?vzz8lTxgazgLYpC8TEI4udf4Nhq82XYYifKht1j2qbC9M1kuQi33IEUn6tPA?=
 =?us-ascii?Q?w+2/mObb+dECx4PHdqN3qFdojS2/ZnHxSbgbyOjZF9Xhh/8z10M9mT7LdwUd?=
 =?us-ascii?Q?iSTm7lzckN2OOegzRDzyOeljKNVOQVlnas5u3vHzf+ATtHuA6bCA8U+Rp/Zg?=
 =?us-ascii?Q?82R80uYcHNET/4xJhabKRLElfr4L/p7g68C5zwn7mFejEHsG4iQ1gNBCy0pS?=
 =?us-ascii?Q?j2As43W8BLtYiImcY+4ahwhxee4pv1fY9iJhgU3LmhIHFp/ltoP8/m4jqAYM?=
 =?us-ascii?Q?1NPHYAdQz2BUulin+ZhAVyQKGnW3OH59Od9xBHD6RBWYmpt7GP1vG8567+wQ?=
 =?us-ascii?Q?qGBts9ZD57xbZvMHY/M+yMxeO4+k04ZzcRE6ayGXdAABFwseWt/Plqokkk/V?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s0hyJ2wLZotZXZQHacWIVkpXc/E4beWomXRl6nNRwPQyxQDGhj3gFMAYPxgEmzKgIFZugYsqnqkD18FC2mIYM7A3R2B1gKjND6xU4qTQfXZcfJqWXIBe2dugTLwg1mzARBonPDCQmUV4GfTfpUDhrRVskcS2AxX2mp9S8TBQSkXKioJF2I4h2icnjPbHRYfT1RN++ex8Ogml8CA18ERGS85L6hFSqoDVS2zGjOODGzexxBTSNLB8/W6mzpSbM8pQ1oXSgv/Bl4KairezmOT+QKPXwy6pc5cTkfglp/ZCRQQbYzV27Q1ynGcI9Hgo8wZo0LzibMwYh/d5Gbavc7Pm2JfsDvO2TEcZ3Kzr24n3A1jtwF5R+VBlR3uqjTtTVB3iVCNnUlQ9M29qtGnTUGi/+G0UT2Fjrh9CkrH4mKJD8m8/oca1nh/0hpULXP1Kuj9Qa49jizB+rTeGc1vz6v+peiaYyNpjQFSwH8BFVCBMpa98YDYupGMq0opuZqotn3OFQPa7DssbY01I9IFEDRgN+Sd8LnhxZvANBrtH+9u/RoEFz2ucQ+Y37CjBohjGLU14EXYv0ew1HuyYjmxuAN3d0TaFuP94wkqsvkx1FrPOSUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456b3112-e0ee-429e-c84d-08dc72006f88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 21:22:17.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uVJyOUAzHfH9o6LzupZaJVcWIcTwKCSoeZBuVCotzB+6vura02N8ZOunHL+DjcQRPPGd75oAlDHiUoJt/YyJbtsP71M9ieX8F0CsDxdPFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405110160
X-Proofpoint-GUID: j3aPj4kpEObAUkwPusKwLF_O5srTRYwn
X-Proofpoint-ORIG-GUID: j3aPj4kpEObAUkwPusKwLF_O5srTRYwn

The BPF selftest test_global_func9.c performs type punning and breaks
srict-aliasing rules.

In particular, given:

  int global_func9(struct __sk_buff *skb)
  {
	int result = 0;

	[...]
	{
		const struct C c = {.x = skb->len, .y = skb->family };

		result |= foo((const struct S *)&c);
	}
  }

When building with strict-aliasing enabled (the default) the
initialization of `c' gets optimized away in its entirely:

	[... no initialization of `c' ...]
	r1 = r10
	r1 += -40
	call	foo
	w0 |= w6

Since GCC knows that `foo' accesses s->x, we get a "maybe
uninitialized" warning.

On the other hand, when strict-aliasing is disabled GCC only optimizes
away the store to `.y':

	r1 = *(u32 *) (r6+0)
	*(u32 *) (r10+-40) = r1  ; This is .x = skb->len in `c'
	r1 = r10
	r1 += -40
	call	foo
	w0 |= w6

In this case the warning is not emitted, because s-> is initialized.

This patch disables strict aliasing in this test when building with
GCC.  clang seems to not optimize this particular code even when
strict aliasing is enabled.

Tested in bpf-next master.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 135023a357b3..979838c5a495 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,6 +53,7 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
 progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
 progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
+progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.30.2


