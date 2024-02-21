Return-Path: <bpf+bounces-22396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594E85D67E
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FFD1C229FA
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026053F9F5;
	Wed, 21 Feb 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1XlPWMC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="beRbhwm5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295C3FE24
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513783; cv=fail; b=gGW/T6lab/3vON/x+cHGKSXxEA8r0TVrLuW9sRlKAXCMUmkfnmN+jpUPn1ESDHME2lIG8qYbfw8emz1C5yDafYUM1O4ZXrnaPLm+XN+LekMisXLh49CETk95quMzCJvONJWSQsikqRkkegZ21lb7513HSetqTUmo1Oc2JhS4zOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513783; c=relaxed/simple;
	bh=nEOsKNC4NE4k+3P+MCZaSXn58fe5rrRb2ZT4Pb/mhSw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IqsPY5V5CN28/+Nz3jrLDVJTUtAXrw8u4N7IYJOWqka1RMtbnDta2iPoWXsCAQeqjWzTVtLDNEtWQJppLrx5qnla4Hwb4UWxKY6Aq19bj9oWs5PXw0q0lLyKgUxy/bWklkCYN9FKP3jqB4fX3KjydcfwOnoKMjrq1cgaZxz7f4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1XlPWMC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=beRbhwm5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L9iGOo021493;
	Wed, 21 Feb 2024 11:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=JMknsSRY0+Ok7zgx2lF7qwnyqdHlXkEYrpjxMSnyP7w=;
 b=I1XlPWMCj3wrJcI3rbSKP8THSM35OlfhqJjWUqWrNgbr6nB1p1Gx2MbhVrpZeIVTExk9
 sqEb3tSBm9QmNOEyG0XhD6CPasF5uiiu37nReaexO0D/tXDtEDpZlJqNDU1IDciNpHoM
 DPoUnaKaYfzEH/Xf0Dhq4h2B3OrFXG1C4noFLwZJupZRtqMf4JcnP5cEVhMCS466qTzD
 aLU2aYt2GXODDF9Q2AP18KdrTNwTupkQQhvHkVBjxwEHAWvf8bePacpyFbLrP2tSX0oe
 KNsHid1UHr8dX35raywPTCA8ucqTDpgHBAL7g9fYI2bA+uGWbg1BxPKSTQXXUnoiOxTJ Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc9f0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 11:09:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L9aCRb039655;
	Wed, 21 Feb 2024 11:09:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88utfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 11:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adAGj+dpO7fh2wbIrvWtXYox9kkTV0k9uhpk7Vr0B10yjPsXwpSZu9dg1sZ9cftm+r8cbYIrDFcriOrDRoy4ezCfwIW9lyvh/zOp9nYb2xKIVwJ+79BqImyAJwhNHx6MdXPXrCuoZ0NFf1DkTvamYc+LGnRq8rrlGZT8DDV3bHUTSyLv8bHqA1Kj0UK6ZjoOe6dbgK/Mr82VTnvdmH0KSdJlRFLMIKQvGlIknyKx8TlDy2ZrYZl4Li2Mmp3ZB20nv/eSNDegL26OFcODibvE/zon1BwKJOmI4yidwHOMsGQpANedw8lqQlEJYfP44ga561BQf/v2zMuVwWtHm7Hfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMknsSRY0+Ok7zgx2lF7qwnyqdHlXkEYrpjxMSnyP7w=;
 b=hVVH+ui+t34CZ7HOOeTkhWKIBCKFHzFDIOc/3Jepa2rqoRV7ByaS22LqhsVKckYUkKao/NLfQ+UpfPjpSgpX8NNab+DhJSdrEaCAdPtvdPc3zZ8hoCzbuNCMBeUoMOdhmRzUIUWm2J4Nvd7IpCz06DS0wmakVXb5cXyC0FHQDgX9MzrmgTDKhYFlrNNzcwEQbMf8fz0tG6CzMxYGWW8f7mNQ4jAxnb9opxskHf0WFDea0uBv569u3odyEFovKcNRUwfxRGdIdzWxcT1FUWUNVUFTpMsf9bz8nfOjxvXZBEJboLlQ66ceL+dN9nZa1rGYmh1yqO8rmYii2sDVvwlnUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMknsSRY0+Ok7zgx2lF7qwnyqdHlXkEYrpjxMSnyP7w=;
 b=beRbhwm5Mrt+++LnXFZuR64OtDzfwxI8IBj2AgzVg2bWwIZOBkps0RLiOgzXbD8JjbX7AR1Cuj9W6Y/XIP4J5UsqVrbo/cwuFveWIpuMGqPh8R4Q5gxL4JNKlSovvMiywN09HD/4ohKXOCCKXHh/L+8+b3rK3GctMgHcXO1acFA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA1PR10MB7418.namprd10.prod.outlook.com (2603:10b6:208:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 11:09:07 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 11:09:07 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Compiled BPF and toolchains
Date: Wed, 21 Feb 2024 12:09:02 +0100
Message-ID: <87frxm2hwx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0447.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA1PR10MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e18be19-733e-42f4-011a-08dc32cd85a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t8hWY40wmiXa5xYOolaAPGTq4L4EI/XDMbffNwtl/mNHTxLSf0GV7mNb2gQWYAUSM39R3+j+QQqTa5oHCzXnAZHsXf5nReAojzrfU/F/ELQ3yJLPU2rqB4MZW8wAa8eKzodbdH58c8b0OO7Ir5ltkWG0kfbWfpMN0hRliRr+znbDBaj7czlBGuL+ipxa5Xg7fKyhTgFxsZnvMO+lVjW75rqpZyHhpt46TzM/3XupjPA0UTs6kn4aE9f4S4Dp5EzwIyX2KLLO6s3WW0lATSIB1nBnJgqRrv9AN7b8iY8pth6Mj3hlb+IC4GNheKd2NB4gjoTW/PUizOQRogKYbHh7wyBdzEi6RmZsE01TmP4mZzfs6y8GIfkoeWji4axfjWmMG9AO5ihO+IByLYQyjiZUZhgjL2B4RoOWep13WrZDHwtm+/p2h538Zr6z6QncNgSfN2WvipHH+7RRqSlrET5eJkiyEMBc9y8b6GDYSK2nosCnhV7y5DcWao3AZ/T1vH9n2OL26IvzzBfEif8C65mMi725+BGyu5Y49udPoNdu9z4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eRhZM0Cv9sy1qsmGtmM1q09WfCSLUePy2udYCFwL81p9ne5BVmbdvsvwwFCm?=
 =?us-ascii?Q?emcApxJamWoiYGTNncQoXW4pvWmlhZzsmX6l04wcjoOwwbaJxWGD976kK6hR?=
 =?us-ascii?Q?hKAir+dYRUG1v53k10dl82/GuwUX5oxuI4yPP3keFvfKzyEyEn46inZiCzsq?=
 =?us-ascii?Q?rhXgflVbQGkbDzk5GBe5L+udwL1cCIElctzSjhT4K3uAvG7+rPmTFA2oLOl/?=
 =?us-ascii?Q?qHWb4J0rKdmsxWytQ+HQZwvD9wWVwGrFp50gz8nn6B14ZaIm8x8hOjlJ23yq?=
 =?us-ascii?Q?bmBM6SKWSyBPEGvYBejzxA7EgPLela9jfvG3AS9v2Hnz+Xc5NtpCITwRQJzB?=
 =?us-ascii?Q?rJ4ERlUtahSbpeY2v0/kbBjcIRBqpX5q/F/xfdi7l8+cC2eUtqww0KAzFuHc?=
 =?us-ascii?Q?66Een/gZ84VDpgftqreGp/eie5EKjeaY0vrtYMMkbRtP9JI+BgKRM5cFaYrZ?=
 =?us-ascii?Q?2LXKKxOhMhoyUzZ0Qbc6XcbqJSzqfnfQ39onBlJsQvyYB2o1aeZSmoMAA/Ml?=
 =?us-ascii?Q?S/wdHCwo4jEUOfzTss7Xlk61TDJjKJ8Zg9Ag4iS4pnrwFaWCyVqHkPamjVCY?=
 =?us-ascii?Q?dUj1NQi2yXHgpvuFh0m7fFagBJ6Jwo7PXI4n2gfKVQ21bj8s+E7BFNGkD5sj?=
 =?us-ascii?Q?3Wtd+7I2GxWimrgOBsd3rb3RUeLba3/wqnlBFtpJqey+Ie9m4wSG8KIIERMX?=
 =?us-ascii?Q?6o+rR9JLn3jAimI7RJ7XQ3qraJMvzYj2EzFoSgZ6n0mFV0p1EyQNxAPGpmH+?=
 =?us-ascii?Q?jUon05luCrBgTfX7pJrv4sncELQXQ2/QlUQ57Kv4FdBouWHnsuHxZt/tHnih?=
 =?us-ascii?Q?xnZGKS9wV4uhoOm4cr6swxSjmfvILhqdlucG5OTd6pOkkNHac2SYf5VwL6WP?=
 =?us-ascii?Q?tSTYhogYlip69eGuaFb/kHAAI98wH2Du77W2CxZU/1PUhY3CJl4SpfaEa6Zq?=
 =?us-ascii?Q?VpWl1eEmv5iArXfl+Y7qc9KZ21MdomCkbb0zZT7CPm5kCy/XBN3fU5b0P9DK?=
 =?us-ascii?Q?qx0oZVL2vfV96SWpKh3gBFE+vWXLHj+ObozK2azCMU+tz89vKYbddsa5ABKc?=
 =?us-ascii?Q?uzrHS0QimomqArWw08Bsr8xLcj3xC/Dkz2/l9VYI7gwhFy7NLAW6/G3mMX88?=
 =?us-ascii?Q?NkJ9qEjGyWkoInenDYedh/Wd0vozTxYriPq4A6R9xdaMsotSdQGox6IRRRiq?=
 =?us-ascii?Q?XiQIf5CvjVoA6FOQUZlMkCtZ949ogv21OWsKgHtTKL2LAD0ujQBvatwLAhLJ?=
 =?us-ascii?Q?aEvQlKY82D4/HPXh8XZIGmpyJDeiWDX1N8ragaQnJp/P8WCzeONu8+8E9Ev1?=
 =?us-ascii?Q?yxQHJQ9m70bXYsHqq9PcpRYVF5h8mqU+qXEMxTCep1IWz4eiL2keKqzgLKX2?=
 =?us-ascii?Q?RSNcRqR4DOPIG3o4m0jfcyIfix4J6nVRudReMAft/pzYMO3uJVI6YHjHFNVM?=
 =?us-ascii?Q?5hCohFzA5qlwU2ozrApnw3GOZO9DQ9HD5pkgEjdBQ6SsmZLiQ6syFxx6zo+U?=
 =?us-ascii?Q?qZR+N6uj+140CvpIr6OHXaZWnW1q68I5djxAUHjvIdsukF5TE8jGc47Kyc+5?=
 =?us-ascii?Q?QTHI4Gg0MpYpYYF+VSkxeLdjSbEnI+Es/6dQ2trDxvCkLbkLRKzF746soUTq?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fWBdfIqRFWKSfnFX5H8n/TNLfkICLvqzyExb1IEUS29jDY6z7iV+/e4qvKqzUwvg+lDMIfRVbnlk3wkA0qIJx92apX4c8NExsKd3JjPWIjIhoBxbUIjjsisVpXjy2/fnpcvIaTVHUwsdAn93BOmKqhpiHpMIfYbnxb+3O9jCdSICjTvyNw4qc80PbJNuVdJD3eFbT5/W470MrSzEorXNrItTePs5mHqKZAWvcjNE6YtF7Fqa1dEmaNOggZ8RaDzxS8C8KEw9Md26kOlRZV2kPQ8sZMwznR4i7CaWH0Jm1n9erwaX20p0I9YjUkfsiBtMOoPGbCGBZfsHu7wWAbphsi9IYtkIvS+t7K8BtRD5cbQgI6HD/RIgaF2z5BYzvvkYE/ElMUzJnkMgNeGmQWxA5PksNGRbURJ3lmc9WlmBW/c54P5FfiKBbTnfe0YC0QboPJyx8BthXAySumVNO3CXTtIWjniT4PBImuPejQcmrfDSv0Cp1pKd5HuwMwT//rR7j8d2It+wIH2QRHG5XtHhbU8tOA9JQdMAFry3F4wODWjix2faSucns9TueD+PKmBOICzyGfPjLeRTRaIjTOVrAm7ickCEwEAi3orIWzn3NWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e18be19-733e-42f4-011a-08dc32cd85a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:09:07.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipyO9tpmK4w1G/wXiptPmTERBn2V+7Agt1ouxZ3xWaLA4zMh/ZXOOT6ZRT6hcpsqL6tnc5GckjYPE5aHxQnTHkCnOMcZF9d4nkeBTeC6L6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=950
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210086
X-Proofpoint-GUID: d-E_UZJCeJ0cTHD2DPPbWsyHKJ95ekE0
X-Proofpoint-ORIG-GUID: d-E_UZJCeJ0cTHD2DPPbWsyHKJ95ekE0


The discussions we had last year in LSFMMBPF about BPF support in GCC
were very useful, and led to more and better interactions between the
BPF GCC maintainers, the BPF clang maintainers and the rest of the BPF
community.  This helped a lot to achieve better convergence with clang.

We think it would be good to repeat the experience this year with a
session where we could discuss particular topics related to compiled BPF
in general, like the toolchain requirements introduced by the new
features being proposed for BPF (such as supporting segmented stacks,
just to mention a recent one) and how to better support these in both
GCC and clang.

