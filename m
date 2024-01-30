Return-Path: <bpf+bounces-20774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FAD842D49
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6431F2291F
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD469D1E;
	Tue, 30 Jan 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QMfkVW4M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WzCQrPUr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5117B3DF
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644181; cv=fail; b=JtBBqQGXbNYne1BBfA2cWjnEmBSKh+jkMwYQMLRs8PkdaWI2SYsZQupaHDQSHPTGjKwyC5gO1vWt/NM7kkmbdGD3txGgvYJWr9sEiKsJsdj60j6h+8nz2nVvpj+AkeJeCzmzZ62NTMWwOctk707CMpkdbgjKYXkN803JBqRcUDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644181; c=relaxed/simple;
	bh=M1GGhpFFcht43uycnr1HGMAgcALxWCs2uSBac6uijY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=inxBfK/rTitP+BaS/dMi3KAjzPnwCHpbVW4xSkRU1eESKjfZfABcDsEKFyu3Xc4T0UCGRmTSfLQ/adNXDvVZWyP7A2lnjVoucPeOYJGxyCmXiiMPa4NozY89uQ3fTBjhp9CsMmkkYf+8KBEMgX6uGASO6eiodwXdynx0P1I+12U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QMfkVW4M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WzCQrPUr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UHOuJI008082;
	Tue, 30 Jan 2024 19:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=/NY6hEhw+W5y4Q9xpQJcnj1KyDHC5RtSkQjPP5doMEw=;
 b=QMfkVW4M8GZhkKWwYM3wLgWVUGAPsEmtsS9RYQcLTJ+U3rw7Pg1vv8aqGcpmOAlk+F6B
 BGird+ZxDfYH6g1x89Pbyjj/o6On4FlVZXEVpC5WP/0zg1cdGGxa2MFboA+5oq2ZcJjQ
 mZDDIzYyi2jpAqcvSO0glir00fN10s2AK12OPQFcOpouTlkhdZ31xsEm8Si+MAw7c66M
 IPi+H/o1lU2kGYgrie5lhzyXglQC2LfuKnIarAJJFer3KRdrkorHv6/xWZkemu9Tprjk
 QYxTueji7/73F+un9bESoMbM3y8L0TcqdnPoYYysWYLlKH2PyHnXPorjSYpVMghAhUgj wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcg0wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 19:49:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UJDn02007813;
	Tue, 30 Jan 2024 19:49:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9e88km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 19:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7i1VM+g9Yk70EKQh7qjLBeqe4wzM81Wha/ae2OULHiLjjr0fv31bj7+kYmq5lDR7LhVBVTlXwWXU0s4oS5hXdaoc4/YGH1mPu/k09uW+boVOik3bx0Gy0S7UzuVGZjvScI0qJXC0CJWmb2Y0Q4qk2hxQcYbGXq+dl027UZ7aavMPoNzqrxwelhqicUFp5el8NBC0Qj9fst++pvz0MbpPG8puqYOznVPsPAsUC1CWtGr8vvPclMc9ti1fr+V0baguUMa7coxaJswUi/20kdVEJKw2eYsEoCAtTRGqWKYTdRgel6O9Tsm08SNpgT2M0Xv1dY5Gc5O7AV8TCwify9CWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NY6hEhw+W5y4Q9xpQJcnj1KyDHC5RtSkQjPP5doMEw=;
 b=BAe5vZwcJP38K7mnIhuqAeFJnT1RnPyXLZT+If/T5tbVXcYsad5yOetPOTMN5xbXGuJyd67rTonO/vMHx1hQPMfeFqT0BLq1KL8eij765FbjXlcDzrZXxGJEXudjOqVbCVTSu0OaFSjOR4hrOZIjPdLnIL9TtIB2vkfaI9vT5BRwzn0BqJ6H9f6V4C0+JnF2XX664Z8Cr/K08N4TWcMwIvNAGRaKGMle3DE8qUY/ZgjKblbQwHvgPm4/Oc+owTDXF1RmCDfAIdo12wTK7vZD/WFuE+DbNauJbVurXco50834t9Ka+K7aPEPPuWfNrjYoz9p7jE0qjfM9JllW/VTOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NY6hEhw+W5y4Q9xpQJcnj1KyDHC5RtSkQjPP5doMEw=;
 b=WzCQrPUrXmE/m8dEZqAo/0CUrpyeXfN7TlVB23ls1kWWHsJUsYAT6FnR1y0rqbibpKxOlnYKnAiyF78Yl0I2x/M/4IP19zqEsYtlexgHkjz3MgNaOyh5HYxJmPASPUVdlyFtvGVHkANFzs7OKFM+m4b16kehS19g/sMeBFWYzOY=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:49:35 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:49:35 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: "'bpf'" <bpf@vger.kernel.org>, <bpf@ietf.org>
Subject: Re: [Bpf] ISA: BPF_CALL | BPF_X
In-Reply-To: <076001da53a1$9ebfa210$dc3ee630$@gmail.com> (dthaler's message of
	"Tue, 30 Jan 2024 09:27:36 -0800")
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
Date: Tue, 30 Jan 2024 20:49:30 +0100
Message-ID: <87wmrqiotx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0388.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0af087-18ae-42bd-c68d-08dc21cc95e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Mk86Ue3m14jEwfCRJ7ZxiQoUKQLdjoUtLdPCL56/rQXfyXYYaMN9tDacsr0flEgMXsR0ZjZdcuY8olrZDVN59ulVKyZQwIOE/KC5dqsCfqR4fHX4EL/mR+bYglp0V7MJHZceHsv8DZR9fXCrLKvwzIrkwmmJQhZZNKMJ4krSK/ZRH6yGdIOGt/ckz/IETc/pnL0jpRsbgCL5EJQGJZIaMTlX8zVfacdyJGryYeo+p2z8PMoHQlbShca+kCG+Kc9mENIBTLaE0sj8iUIGFE7ouLpUcTdZYFcMgMXoJBj1Yhh+09LBLjxVSPQqG8c62gqryUbDj3GSzvamKt8qscBXL/Z7WSa5UOgimrbtz5o8KNgNvKzj/1Nq//YyP0CyiVnkw3UFnWccHWJkqbqgdRAZ0ang+tM12kIZw+0BpiT9HrajCjt6kE58CSRD6CSStrPy4zh2z+nTwLngoX37yDfAIuNCUhxGtN3Y2TNvmgmRw14Ayb+N/WKmTgXl8TzzjJyxymQ/drF59dA9/hdHL9XVIh/U7IB2H76yEJK4JuZd9Tg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(6512007)(6666004)(66946007)(2616005)(38100700002)(316002)(8936002)(41300700001)(5660300002)(4326008)(2906002)(966005)(66476007)(8676002)(54906003)(6486002)(66556008)(36756003)(86362001)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nzBVo8bZrQH58Q47kABIIP8nM7XuEupibC7R9WJ6z++wN33bDKqziHaZahYB?=
 =?us-ascii?Q?2wfNks+jakc7eoRNsdEp9JUhWvr26QATFRZggO1mKosTMbXmVCC5Nse3OrYF?=
 =?us-ascii?Q?Cuum1JVD4qPJFGwQZk3pPNqG7nKjqnylpqWP6VlLlX4liOIYaw9GwrogN6zs?=
 =?us-ascii?Q?LAH3FKTPgpQEuYv4Q0Kdwt+VHW+CtMaREO2kIk+XCdsaZfrJuY3sxq3CNXBS?=
 =?us-ascii?Q?/lmaeggbHwCSl7/WvsMbe1YTB/DI7KzBAwBXg5hkUaU/8o9q7lv25L9u2bf2?=
 =?us-ascii?Q?malLa9yOOnn52m3Bks8/unLV/C8o7Bg3onoXRC+MCsHqiGAm1NF5cKF+jAH6?=
 =?us-ascii?Q?wBch2dRGaZFpp1Q8CnJ7dhPZNP0eUku8wDSKIiLWz5OqFmo0Fz2ntIXUblqh?=
 =?us-ascii?Q?neGJaa/LR6hEsEUueEB4sSk5UkMpDSmy3+E0pMW0GBSut0osy2LfYyj3aoXv?=
 =?us-ascii?Q?zaxuHIqFKD4ShvR1JDeeiVYaSAz/8ZQm0KQmPFfkWQGpsdRLqGN30LBKtNT7?=
 =?us-ascii?Q?zLTwdTdz7mJ46hBATMjudGLp7D01mfYXCWSS22s8uYcbyooIcL/9E3c3j+TS?=
 =?us-ascii?Q?fhCrytbKVX09xBd4LJwb1wEEk99049ZSUgaoiYM52G9TyitekA4NFe8Ztqk3?=
 =?us-ascii?Q?x5lPXmQVRYtqxn+rywwPqqahVXTJ36ZlQwP66dgMqtKaKb0h2fUuHJmU3Nsr?=
 =?us-ascii?Q?e3MfzugQhKpfT7j/6ZEBpZZnIv+oRGz5yFBJN5xm3vOC4ZWIhJ10i7LvgaFv?=
 =?us-ascii?Q?+MP7P/TkAE6K3KIRLkT36TqRafAVTBgJoFeFEqGdv6vqaLgl7XQqktFtuADV?=
 =?us-ascii?Q?oMsz4GF1jcL1BRH1wpGcDbTTrpCLUV2Q7Wkn2iJ7Bot5AVlqOKCQsyAL1yuc?=
 =?us-ascii?Q?mcWOzJBrliQ6VfWQohjw2g4Hv7sWq5UNomdxIKPoTLT4+Ub/LSrAVRLwdsue?=
 =?us-ascii?Q?5hzt3nlWyVrYmEA0tmkrZIYBDsrAz0P78U62CPVeaQZivH98476mQkWtVjD4?=
 =?us-ascii?Q?40MfccuzB5KH7DOev4FNJSwEvIp1Y/4F8yKIHf9Su2nadgVWjR3Y5U/rD+EJ?=
 =?us-ascii?Q?F4ri+PW/rJvkpL8bHT7ObFW8tJPXPnbxVPWGtBffJ2qmOMRobs1ObQAyBH1Y?=
 =?us-ascii?Q?EyyD/F3aN4lZdPYKe1wPrLb1SJ8oxgFnytvV5yjXVZS2/yI/RMJmf1IrDyxl?=
 =?us-ascii?Q?S1e2SHZe1E2iwIGv3qMR6JUP18bLxuUy2+UwWWNbuO+YV6Lx4ZYNtnHm2bzJ?=
 =?us-ascii?Q?3NB//hvO7xd2XHbFnfUI4n/6BqYFHQYFVm051981kEWOmQ1ua4S2MwxG0Zy8?=
 =?us-ascii?Q?8Lgfc3+BrcNzZRso1hyomSd43dH5Glvq4D5fceVSC0EJXpJByJza1eFOpwqX?=
 =?us-ascii?Q?PgabAELNXdgiJDjfYqHUJ+eh9uHzJ6dwZ42K3StTvMvlL9bGyLymKHIfeY9Y?=
 =?us-ascii?Q?a+Uem0Sdh8pY11pdR2LzkLaO+ksvFAynHZwb1Upg44aDf9/5MOdZMxCnVNZj?=
 =?us-ascii?Q?32IH4EVujxFCRQ48tzh7IFb5fQ5B9fs+O3bIw8HnFGzRtSgczKk/Aq7HKUVF?=
 =?us-ascii?Q?RtJHancYjb6l9mR9zliX4t/MUHFp21B4NNAhWeqYssgCVf/Hk/vjfGtVDkuo?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CMWuphLaeruZvgQNNM3UguBlM/JNSTqJEYEa5V57pWi7ccxbabo2NkVop2SWnFw5tmM2flWxPEiBNti1VmYLbU6kSg1WNXJhsydGd4Bi0UBlMPOivJgfVk5hRrpSe4KUCzyH8shY1sWirjU0ZG7JgrNZTqgCrjLZ8h6te6oHPaZ1Mr7v0DGi1c2q/LYVXmt92AgJjKOfi+oDBJOFwEigfwuJXYq9t4AZPPnziU1/j149Fh3LjRlDgvlzDNsEmh/FL8oE2Z6s+sTS9yg7U3nwNdunL9Z5Ix4GAPk0T4ZUxr+qFLbZLGTTM5q7ZDS4p4vZhCYSMPIf5tOW6bt3f6+kYluuOF1racccbKFWCZEiHel2DtyB7B1nzFKkIgpRjpnpoqAwI9t1Fn6Bcv0CZQaUSECDByIG99TCW54RkCFnfw/1rFoLhZEL4qcJXqufvFi6N9Gp27sahUjHXTdmJZkzz7L6YTkniTpHQ3Zn+lMUqRbcmfLnL8YzR44d82QzAFh0jnQ56sihZYlY8Yw9kLXwGDO43qubd7hYssD3u2+oMvWrPdZ2q+L9XUSR5NxalkKsgTXh+t5Z1FyWen4OXuhKX911rZ3WcC9v3GkEgK4srOg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0af087-18ae-42bd-c68d-08dc21cc95e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:49:35.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ1dwQmPObu0OBUeS0Y141+qD24JIwiz/vbeG1h8LoStJyuyJZXkAs9sLpMcXga/CQtk5A3RjSI2ZpyUwJywZ4Z8ibvVYjD6UatT39bD+2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_09,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=764 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300147
X-Proofpoint-ORIG-GUID: YW_u9qedOvcsKAFxK6G2gKgFMU7wsm2J
X-Proofpoint-GUID: YW_u9qedOvcsKAFxK6G2gKgFMU7wsm2J


> clang generates BPF code with opcode 0x8d (BPF_CALL | BPF_X, which it
> calls "callx"), when compiling with -O0 or -O1.  Of course -O2 is
> recommended, but if anyone later defines opcode 0x8d for anything
> other than what clang means by it, it could cause problems.

GCC also generates BPF_CALL|BPF_X also named callx, but only if the
experimental -mxbpf option is passed to the compiler.

I recommend this particular encoding to be specifically reserved for a
future `call REG' for when/if a time comes when the BPF verifier
supports some form of indirect calls.

>
> On the BPF_MSH thread at
> https://mailarchive.ietf.org/arch/msg/bpf/ogmS9qFhdBCxC4VrOWL7nzjSiXU/
> Alexei wrote regarding BPF_ABS and BPF_IND:
>> DW never existed in classic bpf, so abs/ind never had DW flavor.
>> If some assembler/compiler decided to "support" them it's on them.
>> The standard must not list such things as deprecated. They never existed.
>
> Technically BPF_CALL | BPF_X never existed either, so can be omitted from
> the IANA registry.  But given the widespread deployment of clang's
> use, and the WG charter statement:
>> The BPF working group is initially tasked with documenting the existing
>> state of the BPF ecosystem
> I could see a potential argument to list it as reserved or something.
>
> Today, the document doesn't reserve it, so it's open for future use for any
> purpose.  I just wanted to verify that the WG is ok with not listing it
> in the IANA registry, given the above information.
>
> Dave

