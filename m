Return-Path: <bpf+bounces-28809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889CF8BE11B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1B2851C8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E8152DE7;
	Tue,  7 May 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQtiYR4e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JrvW41oZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5407152188
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082005; cv=fail; b=JAeKoFFaYUXeEbBs0MDSEQxvWotW8bZ1SR5T8/BPBK2VP/2laX79xEDW2LPkjwzfT7PvKkZfEFqYw70mKDQOdc7x/6+Cd7hXYJefOzYW88otlzktRq8avTIKP4CL933luCYTE8eZuroWJHIzxqimKRuTy5y5GQCCY1g3l0C57Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082005; c=relaxed/simple;
	bh=cjDIYZ2u++XLsbFSza+Vs6VZg9xzEi2r/Ght+4tPJM0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UR6ZEgD/nOW58UHWU++Uv9T1tBISi5exrIJamoVe+wtJ5L8JH1XrakxiIrZ1UG8GtY+5Mn0Frq4Lpp+NSh2++Go/MnN3YvCW9DD0Kh2W2cSM1FQYIwOmxcPeVBk5CfHoQgUvLo4Wc7a0PqQmSRH23pGJXQPSLYuDnifKmtt7K8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQtiYR4e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JrvW41oZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44794Oxm031269;
	Tue, 7 May 2024 11:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1dZpg/h+dHCw9YhsyONJLlHosjFrfhyvUFpzYf+nWQM=;
 b=LQtiYR4enlhBaGBOxDKvZTmpXpOIGFKgjRo6mFDplxqgk91Yt6DIz7ZaGkSpShT9ti2W
 mTdtfBTcVJGRS4ZCEik+KMS2fNlxix4YQbLT8+Z82j4FAdhbOGM0hqBUprRSPVf3ef1z
 fdNK+MLtcuXNs1OYiFK0HkgNAAtIMeHrWxK2XzxK1wfdFbAZ+ErszLZDkAVcezn6ajgm
 xXA40Yv3lpSaYWdxWluBmgYyN2PwpksJVvNTYjcxLoh1NXZiZq0xfB8KSy23wmIpbEJI
 YVfniXYKI8mNjZ0oHkBlmCgEeo8ENUq5exsbprPAXx5kANH2CzpDW61jG4tZD0Y6OQBo Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcvt7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 11:39:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447A11sq027546;
	Tue, 7 May 2024 11:39:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfe4fwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 11:39:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYPe3EUQ4iVJik/8koUsOp46AwI8V5yhiHnwkOt2HP3Yfq+202g5x/h19nQuQXLoG5dhD8MImV4OpMfEe6bUcE7sEpfuebr5/hWz7ROo9Nk+E8dEuyEwX+nRN09QmK9sluSG75WvBPm4umn/5pTKv10DHGcEItg+C0q8MOq262FBEuU1jGxmRx444Nfw0a/aJQ6gMrzaYazJS3rSS7DzF/7b7B8uooE8r/GahBM+1l5dBvxyInbmvnF47neVn4iG1UAVGUHcY5tVYeFpGF8iB+n7jfCg4I7vLdRnNGlMHar1GXixNa1X4qzATINSsCt4vSmAgDzH8VcB2nt2sNJhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dZpg/h+dHCw9YhsyONJLlHosjFrfhyvUFpzYf+nWQM=;
 b=kTwPYaG7euEkpC1Ko/F3NyVkvTSHiPuWlTkmuvVWHtwK7kc4gqJVvIJMV/YxWPQzLcJTDoNryLIK/3Q6rfJkihXdtAPNem9mbaBRapowXHFQnoXUDJzG/vojayDf2NXWXO05R40Zm9UIqk1H1K2hPE0rUEjhkGyQ6nJtnNGGlTyloSJQJibFUr7HozKFmk5rMQRD1Rx/LX5pHtjtF1+29UI7IISK1So6eiU7D+F9Nahj/cDQMWMfCnONEhqaWl4dzHcUdq3glqqbrcFmdlo0JPHIwO46ru6/PiRhKHoZAT4oIr+VjuKty3GC4yGrBPq55ulkj39WD1WztMMUvB3IvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dZpg/h+dHCw9YhsyONJLlHosjFrfhyvUFpzYf+nWQM=;
 b=JrvW41oZegG1hly+pcWbcoCZTNyY5goWFd6AOcR7mwSJ7I9XF+0mt4bCYRZVhfqLefyQDAiLw2vzXOCAv/2eEwmQTQjdeXP8m/Mghc7S5JCqCF5Zt32jNl9vljyU09SUKyvq7lC6dLzNF78M65XkpX9U50qdeP4EpCLd6+j5I7U=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 11:39:56 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:39:56 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf: avoid uninitialized value in BPF_CORE_READ_BITFIELD
Date: Tue,  7 May 2024 13:39:50 +0200
Message-Id: <20240507113950.28208-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::19) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5a5ca5-0c0f-40e4-a613-08dc6e8a6b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7L1OZoakyxWp/cWmyDyTar7Vl8xt9ZzeUSJuziv6boV3iINQUxgk00GGGz+F?=
 =?us-ascii?Q?iASOo9TsRxtts3YmCyD1oGj2FE/T94q99LBtQRWTzXlQvmuUP+3vTwmcbOCz?=
 =?us-ascii?Q?OW9wAksPLOumZTzZvTbJ5I1D4KreLczAX2PggsGS+Y1f+4er5npjZN4elxqa?=
 =?us-ascii?Q?7FXov6SLdQ3PI79MW2nyqSttJWF7Df+gPOfX32sPxzPI5i2UtZkyXXLmlWYy?=
 =?us-ascii?Q?D4XaUtjcwNX9mb4D+N/Ct2i7QIb/7BfsnpRzVA5ZCuhEMOyOpQbBs2I+YLhK?=
 =?us-ascii?Q?/4AThws8JQTzLx6SyIe9tttKlhIN3CKHrdsGIyP1Uj7pLjJfNEUFZOEraAJv?=
 =?us-ascii?Q?gVogDGK+AUPFzFxoj9/r3BU1DCdQ6oDWHed0KYgPOq2hlDTitp+MiyFHRIU8?=
 =?us-ascii?Q?hTXbWw0S+8mgYMD5kNtmI4xfinUNcAZZCeoLBHQR1iluF27JwjzHCG2kLRyC?=
 =?us-ascii?Q?esIbPZlXDQIbqWzkn46dqdhJKthR+N/0/z7aoWuvv+NSp/hFybSJKFw7NCWD?=
 =?us-ascii?Q?Ihofrn4czLxjYSUn6h+9qVNbmb0k4KFqS7ywIOqLD1C/Y5gYF9EOKliuOj5U?=
 =?us-ascii?Q?LIbEJYWjpmoP38lua9aCbCbkaaMCuReZMshpX/LO4GpTd6oVFzwYLOvLiMiP?=
 =?us-ascii?Q?Wvlzkcfp4ElmK6bl7RYy4qvzy7xQWnyEtH5XheoUXml+dZVXRITUEd93EQIW?=
 =?us-ascii?Q?5ehRbTsmPJWknsW7O0hUp5m/HAn3OaF/m0Rl0nO0MCofVPHHp3v44ai6vtr0?=
 =?us-ascii?Q?3GVm5FZEmMn4qjkxr5IqBPLZbu/zLzZF9vHJF/E5Z93jkHmYxEA9UkFM/5BQ?=
 =?us-ascii?Q?yTXm331ydshN8jj/1kjS87aIVnKuQhOk4A2TaEFbt/N5nQnBxF4shOLXx5Px?=
 =?us-ascii?Q?NBLNgguR1LBmH0F5eOiwqB72y3a9gHOdJQMalMHiUmbUW8zo1JVYefPg8rXh?=
 =?us-ascii?Q?8v74Z+pc2IYfNSIsU0Q+rJhIwpBwQF0AbUDycAAXYEAdCkW/K2xsDq6xWPr0?=
 =?us-ascii?Q?4qr3QTNnHP5IsZMt9QBX/ByovsyuwtWF7Zcc5vPdi6W6pvFB3lYMYzEp+o9I?=
 =?us-ascii?Q?MwcXPrpOAXTWaKF9fWwInQPLOBT/fMpGTXr+k4tH7FysMyihX5f5syICXVra?=
 =?us-ascii?Q?tWt/HqsCdcQ8MLIkWQlM00z3qIpLbR/mdfjKrIlHSIpm7/BS7kewYNHK/zRg?=
 =?us-ascii?Q?ma73x7x1pnE7oIXVAgzlNTQBGP2mW9P6FyLrCggY8LvJ0Nl20YZ3LVQ2rY/h?=
 =?us-ascii?Q?I4CprFsMiOWqxMLtbKwzdKyHLbWiYWtBvkR7XIqj9g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VXRVjQGG8+rBRqSrIxaAfcPZMmDB9Z5JiFP5ski5zDCmRVKbctAxB6E/wTOp?=
 =?us-ascii?Q?Pr7+RnaZuLsq1oxb12yMv7HbrMM1QMFj9cdU1E2JQWsj2l7e+W0TOZXDVgnS?=
 =?us-ascii?Q?StmjkMIuMH4bnYVYRO3/rfS9uj4Li/QKkeVCFKIvViNVMOmJ+ReQqm7RS0w8?=
 =?us-ascii?Q?UVmOIl4jAewO0yEBtAy1nFMzjZ1sJ13eDuip8g47ahqgjPqZtVLKSSytuFUg?=
 =?us-ascii?Q?N4rQB+gpAoNWkSpEYjaRPzc4iIhWhBkkKd71FrulFVi5lkA6oMLSSIQi2s9+?=
 =?us-ascii?Q?oyxv4oTckY99NNSCyyH4e8LMg05FFSz5wpss0d6Sa6aUMuEGtysO1k0ubLmE?=
 =?us-ascii?Q?OQoHfCV/x9arFgwIZsWwa00Y4Jix0sw7Yfjuoet1+1M53BsXiCeqWt7g1oGC?=
 =?us-ascii?Q?0U2LP0StnunWjux2w6DrUnHuGxjaEwqRwl9aV2JrHzEuvv0d1YTkXrt06ds1?=
 =?us-ascii?Q?0zQdwGGyLUsf5WWtYS258wBTrt5oI7wuQQE+EvQOqlSQi/kLi/yYf9xmOqYF?=
 =?us-ascii?Q?k16ymQuB9/UedCIfoZtWw917N2VtnEXudgJLaXfCrjdCg4ySfI58+6xt92W6?=
 =?us-ascii?Q?0NCgj7jaJC6Nsi2kvJPg+IaDfENFCBstBmZnSNoaXWgkalX5pBcmanP2pvF1?=
 =?us-ascii?Q?V+PpdOBKsO4djD3q+JXyD9gxQFICyywoWuZioCQaS+4ejpGJ1xryrbmTc0B2?=
 =?us-ascii?Q?qhwFXJVG+n+pbr39Vyev2uMydaOmigD2yqiLogilVPQoOChjTOzEWMxn+uaY?=
 =?us-ascii?Q?n4uOW2l9lBJdduzXtIX3E1yJC1pJL5HQaDkUlAlN5RJ2GwAQONh1QjCmDNFj?=
 =?us-ascii?Q?GliXWZKBFzQIK+cs5YlPsNXgL/OSGR8ZY9AeGcQcBcNBAtXXBAf7wBUfARZ8?=
 =?us-ascii?Q?eZgAtBrjgi3PvwDymuW2A6lcCdSkAKehPyobnU7nTgEgWfACgwTS5SJJESUm?=
 =?us-ascii?Q?WtKjd8n+MJW97ncXgHl3Cw3M/HP8RZ5zdGRynTUWa8yMCD0hp05s4pPFy8aQ?=
 =?us-ascii?Q?Q1gB4sEzgmykDp5OGGbCWikpSDAFFbikrnYty9o+rULUgogYjeGzp4vDfUkN?=
 =?us-ascii?Q?tOq5W9ornh/B7v8fDFXGWlbvPIy2/hwaI0nxjZEV1BB6y5/fA4G21Cn0/TQ5?=
 =?us-ascii?Q?CNy9yfI1maGjCgkqRg7lpZkW9zYlaV+3rZgKPax0s9Fp+s8sHyaVKqgNeEUI?=
 =?us-ascii?Q?z+uco/9GHev+mzPbMT9x0DNr+G7Q4NaX97tBdaXYj61FbjhP/TMPnPgyRghz?=
 =?us-ascii?Q?EO1TT/SyEBSDUhVRpjayJ2nYkZTJJenEQbVMQ2svdTfW43x/cB/9eu7MS6oH?=
 =?us-ascii?Q?vBHU3WiYodm7uJxcR7phBS9bs4YDaWLW2zDpl+wxjb+ghVGABe0GoMqwP/aE?=
 =?us-ascii?Q?QqSP0eqHDZb/ofbqPzI/Ccf/lySKt+iC4k8IYeNAk2b42CLB5jlqCHJG5+WB?=
 =?us-ascii?Q?+tshHQHz8la09NV/wn8TXNeiEqLubAXaOrfKHzC0WUStf/JA/+ANmLfK1XGH?=
 =?us-ascii?Q?p1lRF5Iw0fTgcu4+zS3cw6SMAeA8QDYnfN0BRTLCy9grceLkIHnVhrRGkfIB?=
 =?us-ascii?Q?TJ4+/VtM9V95Zziqr/g9aG1TZeDwyESbK0skeFS5rLJWqlfvG0EAG2CkVFAC?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iB6MlNbLaHDMGaoCB4xssak3/FNQDiama8H1rL0DXtQaaBwI8y0J3NwD6i16QkPtlJk0VKiZxGzh9q/z1sh4d2ZdVBG3mX8jNA1UDvzB3mBpaYezlNzjXKi3QpKRmZswbIzmVXDckPTXq++LqWRhZ7RF6pYir2pDiQh3VG3zGAvplEVtM0o3rEYyb4Di4APfKn7FclpDE2LaK/XePNqum/vRAB4RFhcy8CY0k+4e8dBW+cOgMhDZMI4/pNt51MFt9dWFHyOonciehjO8+pVMzJiY8gISzHZr7eQOb4emxIZoJm94Wp5kyEkP0WF9OLw0X6bRZUaJLyig6T6fJ+TnIu1JrmneAPbZFPj8KTdgc0rgoSBXP+8FnM/MfwzB0yvcBqpaDAFTkqsityAtVFy2c9iGUoVTdoDvBEs0kllGvTsKfBiDCxJ3sQDjcBVy7JR7D5mjMxX5h4wMbhVb7knPYhXyVZivzQ8K0katih8iJLaFiogdgmDmcTosMTqVMDWE1r2/nh5U2TdhkLbL4nGxDyxid0BocLGxz+CZHQ4Qrdb+22g4v9hG3NH8bmgfDX4YhIAzJ+5iq5WNFmyATYATZm0IxBIFgiFX+iUDJbxjnsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5a5ca5-0c0f-40e4-a613-08dc6e8a6b15
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 11:39:56.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 960Bo9YEBD7i0nuUvxQr08L+WqHJWZuL3/ZC5mn1dUqnQ84JEHslLjcWd0/VEiW9bebOBGRVQlb3SF/V4JzezTyb17Gc9ISACF9mB1mmRBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070080
X-Proofpoint-GUID: r4ejEpm7ttTa4bUZwjy2h_jhBLlLFVrA
X-Proofpoint-ORIG-GUID: r4ejEpm7ttTa4bUZwjy2h_jhBLlLFVrA

GCC warns that `val' may be used uninitialized in the
BPF_CORE_READ_BITFIELD macro, defined in bpf_core_read.h as:

	[...]
	unsigned long long val;						      \
	[...]								      \
	switch (__CORE_RELO(s, field, BYTE_SIZE)) {			      \
	case 1: val = *(const unsigned char *)p; break;			      \
	case 2: val = *(const unsigned short *)p; break;		      \
	case 4: val = *(const unsigned int *)p; break;			      \
	case 8: val = *(const unsigned long long *)p; break;		      \
        }       							      \
	[...]
	val;								      \
	}								      \

This patch initializes `val' to zero in order to avoid the warning,
and random values to be used in case __builtin_preserve_field_info
returns unexpected values for BPF_FIELD_BYTE_SIZE.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf_core_read.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index b5c7ce5c243a..88d129b5f0a1 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -89,7 +89,7 @@ enum bpf_enum_value_kind {
  */
 #define BPF_CORE_READ_BITFIELD(s, field) ({				      \
 	const void *p = (const void *)s + __CORE_RELO(s, field, BYTE_OFFSET); \
-	unsigned long long val;						      \
+	unsigned long long val = 0;					      \
 									      \
 	/* This is a so-called barrier_var() operation that makes specified   \
 	 * variable "a black box" for optimizing compiler.		      \
-- 
2.30.2


