Return-Path: <bpf+bounces-27040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60C8A8313
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483721F24834
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD813D290;
	Wed, 17 Apr 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="blL7ShBB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DGnUg8mF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79013CF87
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356682; cv=fail; b=ATacJG+mq4jeNVxbX+oU4kFumpifP/Y2Aj9ZbmjOoZ/AgkoJifJn41wggfKuSiojse/ItAZCnUl8mZq5KdKryR07MmJU525wagApJDuy1Bjvq9mblNpmAyKRxOuJHAs1PAuW3g3D7YbUu+ng/i3BBtwzpeJmth5Nths5bLZtM74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356682; c=relaxed/simple;
	bh=KefAPoZyBInfRkY/BrCja/VGWlDehTDClyWksT5hDaY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nSWGnw9Cat6b3QvzuQj9GVhuqc17vn+LidrXlJ4KHK9ugc0g624yoI7RLB0O3/xiW2gKGrdlKnQKL5OM3+x7itgrAqi4/oLUUtj6XIrZQxxZJOqTAh8xrEy5QhlFXLMaIJ+HvjZbxJrayQsnDuIW11pwN5wy0WN9OJB/Yl6abn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=blL7ShBB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DGnUg8mF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xVgd032477
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=OD8xVk9U05VnXl4hJoG3xe8L30rStG+zBHJsdty/c7Q=;
 b=blL7ShBBehsZErM4gTz8lQwqIdP7mMiShCaYMJpWbTljxdVlesHPIw8GCSLv/FkndRZ3
 oLRcoCNx27GsXtwya9qVAqq1Y+dJzf+ml51XZ59mJax7l6alLuOB6eJWdOsHjLzG/7rL
 W02mNEs1e3pORiLv6NXq5YyUhfZnEm6b9aMHq5A73CTZrgLR7UncbDr3piJ7ZLxc8t5N
 4bKo5kLkD3lDxXREaD/s7NANYP4TTu6pj/qhilF8TEOorHOPi6axEcDyu3y9UgK/EgKW
 Uw8Cg15duQk+g/vDGU3wB77VZR9xluH1Xke8MnB5e1h8Ey+XVAWwryBw+T0x5JhkFUHY Jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e7ug1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HCAON7012593
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwgs7ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5bYAK8/2stzfTCiKUKoJrTsyuhvPvTZw4P45rPXa82z6wGZ+hb0UCBIfFxUjqzznZjT5kQ69pO4mTwxZazwyfZ0dssVVmi0GKYYpuTriRb7UufbRwgDwwqtCh0tMpYuimp+EMPZwjwm6ZxWRyLHbM/BvXN273lC+/ygRKuv/rPztQ93ygx+9SaDlb11hOgr7M49lwjgjMak/SyNILs4vs/lf1/giNALDH9Su1z0Mucv9lODFcPp9pKs0JRoM6KVTFpcHCh+PbM0urpxN0OODYrzy1ytWveuZavVy8HfDhJM2sWLYtNWZ8thKnICXVtdUpXmDgN7dq7WHXARLCXY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD8xVk9U05VnXl4hJoG3xe8L30rStG+zBHJsdty/c7Q=;
 b=bs9DGwF9rB3Gnc4hozGuffrpVBRH9Hj+rpLRqnXfcNrI1m9cES3g+NRXIKRXzxvzdxB57qG93u9HMIehunYBxXCc79PCmpDH/Ju5FbHXxCdwZwJu406zGHO2XulqPH52gaF8cr0rXAbGyVsrp6+F1lM64BmYSl+3glEtFQrz/QkJDUIuIwIJdA4wuWpGPCptHAhtRS5m41AG1jE3NTYGuz4SlrtwrndJSP8adnc6mWwmNvOaIT/MuCLlvetDUqhr4VP10nsRZ6bBSbSDP3t4irRaTAmiYGXaQvyvwKXgKUGfxnvrYVmgHk4EJm+JE04pMRiRgqyKyFLhai9yRpuKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD8xVk9U05VnXl4hJoG3xe8L30rStG+zBHJsdty/c7Q=;
 b=DGnUg8mF/38rUkf1F1yjRZGy41F/rwqwhVoRlSdKZ49uCOiyq6naVblks/P8/MUEVBGst9f/qNa/Dw/zpr5oXHyCESltpgDNZNep5FYVnNtonQqcieuScj85apVSNBL0Jw6u0m18hY3GG6Rc/XiI28ZBdjnD0eceAu/PCATZaZA=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB4407.namprd10.prod.outlook.com (2603:10b6:510:31::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 12:24:35 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:35 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v2 0/5] bpf/verifier: range computation improvements
Date: Wed, 17 Apr 2024 13:23:36 +0100
Message-Id: <20240417122341.331524-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0105.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::21) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 77600ac0-3a5b-41a0-ce9a-08dc5ed95756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pTU3k9SHsk5NUVmgvjvWKMal5A4/895mw4gKM/8LI0jcZDkwn+zSkaKO/Pk0beckqrCkiXqkO3Fc2mL7+T/NRPAnV0khMx9oFhZqP4ZUT5Q8KOrsIf8y/U/G8raAaL0ojXtioSdTQvAwTcD7vfVhw149aJety3qVHq0BBmex1TXQT6a9XKy/fPm2luOBObQ/IqVrRj3vx5koI65uXjW041cSxRClhbrsFGFPKR/Dl0nzxRXZJzE5eQU8dEDrU3s3jA6hQlQsWEtuJSox5LGM/aMjMdj5NKD9ilscWcxqkJ3NAqe4BzLTSF7H9spY1F5znEP8URzANuYiTa/sqHU5FrPWRR9jH3Ysh64fzogZ9aUgoi9zv8OKBQxNIfS46WbXGwEAjJSshDmp7g5dgW7peIYYjY6z4NyjZyKeQNta4xMCILZ7bQjGVddvowACj1sQ/PW/MtMv1LXl4teB1FZdRK7bJBEiNth74wZsZmcy4ZBbZ67C5wz2sVoeFlsygHYwvOx+GeMeRZ7uBB5DX3UWMdu32qbJxlV0o+m3S4d7DQxtOdjFz4rBnu+R2NJxz2wWDg48/WGsa7a9SoI8HTlgfYaGMu9m2uHnTB5lR0/2WxlztCXMMtEnxfp6yPDgloIz7T/s6kQROgEfi1NaSrE7g/wkcbimZ+FmqxINPFdnttQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ij8zM1x6bicc2xgIaLjgJzdu78okqxIxbVS1plqY5kHTAdxymKMgNq09JFYT?=
 =?us-ascii?Q?rek9C5lu0cWAkU0jMw8LZKBsTMma3AXvpvou+PrkIwoCku0zJOiHg4VjfugX?=
 =?us-ascii?Q?y+IziySc4C0kYf8p3F+ceXGzKvB5F1ow9g/MLXXbgxmtl8kTSJdvzr7Ra4yq?=
 =?us-ascii?Q?j05BGf2KB8LyI5wYtgFwCGDczLUBMIuSbsZ7PQU3AffYWcllxqpsKtOc+HJc?=
 =?us-ascii?Q?JGxtkmbpIJeTg8IIepiSVA1wN1HA5QR6NWxRVSlFGh4dedkZ5X53WnwmTugl?=
 =?us-ascii?Q?87B3+He9h8NbeJvbw2fowFJE7NFAbDwNEdZXEf4SM7eD2tBQyd+tRiVHyqZT?=
 =?us-ascii?Q?kPOewPa14yjcm0+CVIVIpCBlKcQPBShPcI5LWIIaL2XJYSjdv9mEwPXuVWSL?=
 =?us-ascii?Q?ErqoUxTPDf6IngMdfzfHggMp8meOeKp+ec3PhvvsTqEu3VKi1pV4da8P6v1i?=
 =?us-ascii?Q?iUpgzseWzVWfvCraOwvrxe9inRmj+zW0Uf3CbI7xhBTBS78Drg3gpSy3Qy3j?=
 =?us-ascii?Q?gEzMmduE/pzFLjqW6kk5CHDY4WukD9ozcEnT+jDzTdErpmwbBoSdxmL5kKnH?=
 =?us-ascii?Q?wLaWD5V0E01mVtp5GWsrEKEwDmmODKfD5YoHHYT72rKAteROyOAZY5XNfLu8?=
 =?us-ascii?Q?wQ1v/ejtIsiObWdGLfWCzip62zvHu10KGLnkOMSPmItMzax0mhzLQz5JmxQz?=
 =?us-ascii?Q?Xz3vYJyfalMpSwosMIpKk3cJ4MCw2Pzx6tj+Cj153qvsbaqOkJrD8eC2n0kl?=
 =?us-ascii?Q?LwwPciqIlDyXabjID9zf3NMtB5mklugRbGjN2EAweI3m/P61BvoITGZvmryR?=
 =?us-ascii?Q?NDbuf85lUvvmPOCPt96DUz+pJVszubT2TGx3GFEj1OnfMiiv/TLvoa0cycQf?=
 =?us-ascii?Q?9U7jUj/1Y8W2U0BIK8V8bQuIZB9JmER/OuwB5m+wZKD+q/1x8f/1sbpuqGAp?=
 =?us-ascii?Q?8NdjAKfU4UDGN5CGvHKv5L36H59i5dl2DcnvpiyFHNkmg8LW6EXC5H+tW44y?=
 =?us-ascii?Q?CvDcNp/A/ppHaq0RXvrSi9pI8omP5naNHR11JIf7XUW8VNfFTzNmRNJpBLNe?=
 =?us-ascii?Q?CRQKxkNwj9KTVbFdn8cQ1ABZzZNkdcgy1DzrnlXbZvTU5/2ET2iIDeZU1mkE?=
 =?us-ascii?Q?MN0Bty1ErUKrGa0yvEKicHa8UkFVgtF1XZnUzuWkassWZXVN/UURXujB0gx5?=
 =?us-ascii?Q?dvVxDMrIpk3WlCBzAX7RRc/qaDD3ylyUoVNw8PXeRU/jo9WkppE8ic7LMreM?=
 =?us-ascii?Q?TpN5YehygVCRYaaaniKfu1jLJiW6gAMU8uUGnbP7knxszFIhncJFZ4a6r8pz?=
 =?us-ascii?Q?Sb41hSBXRA4BTTpKl2zNHmAmhK3iOYqa11r9CPfBgYhL484RYOqU44jlBlQ6?=
 =?us-ascii?Q?tTTMVCBVtBGgzJ/4EaiNUsjRrOEnhYOqL4aOJbyv/+93w9Y66WdRIzw0yDSx?=
 =?us-ascii?Q?nTKGtxtoWlr7LKl0tUvJSuL4OEu+HI4dEMn1KWXUlwd9h1lEBs1mcPIOmf7J?=
 =?us-ascii?Q?6dul1aAdSpIoqoiQ8zUcsjIqaq29ZVKyFO5wsNHztNiOu/3DDWMfCRAUgs2W?=
 =?us-ascii?Q?b3iVHartsRpa6T2tSJ6pDzVS/fqk2ZRkDv326e5A6C8F1ngD5P+wRf3YXjE3?=
 =?us-ascii?Q?EVf/v1qF+rbLqwcRt3kQmhE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Cxb8d3bvEXtxpZ+VqWQq9gngzLHx4k4+ukXD5DGow3I9CN9XyGoj+a9mlFWYgAVwoV5nG6o51bghHGxMDE5JK1XUSUEdJsOvk4GR5nb186DHWZAbINXYCVefuwrba+1RSyRsY4pXWQrT1z+2ikE7JM4Gk3Lx++c98p+oZM4JXD0k5+50yY6EFWexQvbZ98hdh2g2t+KM/ASMDNSI+JL62T35OpRfkOx2nCg9pavKhxK/DqkOF5ZMejJXkK/InpvDcOUGUZxOwcwjNrapKLWIOC0VZPYPMHET7XMUCblGZmxDopoMsDEnmoAr/+Oqwg3Ixvv2W2nr0weqMiQhiJWVfhE1/tMTKq1CbP3h0ztLAWccEUUCtHDiXft9IR86btnhmowOoznW+Fd8DoRsh59Ma/8FOiWkI2yHxXUzeqOUy/8YCxLqU6MQR2IgtEbMqnrTKzgnrlALhwXe2DYyrymoS6CzrwrCjfZNZxSgSmnWZw6eSepZ1ZYV/bujhokPTJ+IGWe64mNs5EwyFjV9iiOkMoKWF8LfkXPJfboBHyVGZ018f+XehHKxd1zAdRuoiOAxeUt5FX0cMP/ztJGyj/jqSF8zgG9vFtt8mx3CtN4cdss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77600ac0-3a5b-41a0-ce9a-08dc5ed95756
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:35.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueVT5fDZR8jLvNz1z8bjDPwGwHl8ImSIuqdkVJI2CFX9Zjp36AZ1O4dbOXTAUB4/IBAaF4D6yckdZqivbSvIIeMmz0vaIHOUn7zMMbR95jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170085
X-Proofpoint-GUID: o3YIFYsekED7Dt0u1V1CKvfyzYqomL-D
X-Proofpoint-ORIG-GUID: o3YIFYsekED7Dt0u1V1CKvfyzYqomL-D

Hi everyone,

This is the second series of this patches, now changed after Yonghong
review. Thank you for the review.

Changes from v1:
 - Reordered patches in the series.
 - Fix refactor to be acurate with original code.
 - Fixed other mentioned small problems.


This patch series is a follow up on the problem identified in
https://github.com/systemd/systemd/issues/31888.
This problem first shown as a result of a GCC compilation for BPF that
ends converting a condition based decision tree, into a logic based one
(making use of XOR), in order to compute expected return value for the
function.

This issue was also reported in
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114523 and contains both
the original reproducer pattern and some other that also fails within
clang.

This is the result of an earlier test that allows to describe the
problem better:

  VERIFIER LOG:
  =============
  Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only those are supported.
  0: R1=ctx() R10=fp0
  ; asm volatile ("                                       \ @ verifier_bounds.c:755
  0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
  1: (bf) r6 = r0                       ; R0_w=scalar(id=1) R6_w=scalar(id=1)
  2: (b7) r1 = 0                        ; R1_w=0
  3: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
  4: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
  5: (07) r2 += -8                      ; R2_w=fp-8
  6: (18) r1 = 0xffff8e8ec3b99000       ; R1_w=map_ptr(map=map_hash_8b,ks=8,vs=8)
  8: (85) call bpf_map_lookup_elem#1    ; R0=map_value_or_null(id=2,map=map_hash_8b,ks=8,vs=8)
  9: (55) if r0 != 0x0 goto pc+1 11: R0=map_value(map=map_hash_8b,ks=8,vs=8) R6=scalar(id=1) R10=fp0 fp-8=mmmmmmmm
  11: (b4) w1 = 0                       ; R1_w=0
  12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  14: (16) if w1 == 0x0 goto pc+2       ; R1_w=scalar(smin=0x8000000000000001,umin=umin32=1)
  15: (16) if w1 == 0x1 goto pc+1       ; R1_w=scalar(smin=0x8000000000000002,umin=umin32=2)
  16: (79) r0 = *(u64 *)(r0 +8)
  invalid access to map value, value_size=8 off=8 size=8
  R0 min value is outside of the allowed memory range
  processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
  =============

The test collects a random number and shifts it right by 63 bits to reduce its
range to (0,1), which will then xor to compute the value of w1, checking
if the value is either 0 or 1 after.
By analysing the code and the ranges computations, one can easily deduce
that the result of the XOR is also within the range (0,1), however:

  11: (b4) w1 = 0                       ; R1_w=0
  12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
                                            ^
                                            |___ No range is computed for R1

The verifier seems to act pessimistically and will only compute a range
for dst_reg, if the src_reg is a known value.
This happens in:

  -- verifier.c:13700 --
  if (!src_known &&
      opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
          __mark_reg_unknown(env, dst_reg);
          return 0;
  }

This patch series addresses the problem and improves the support for
range computation for XOR and OR.
Apart from XOR and OR the patch series also improves the range
computation for MUL for the case where either of its operands is a known
value.

Looking forward to your comments.

Regards,
Cupertino

Cupertino Miranda (5):
  bpf/verifier: refactor checks for range computation
  bpf/verifier: improve XOR and OR range computation
  selftests/bpf: XOR and OR range computation tests.
  bpf/verifier: relax MUL range computation check
  selftests/bpf: MUL range computation tests.

 kernel/bpf/verifier.c                         | 160 ++++++++++-------
 .../selftests/bpf/progs/verifier_bounds.c     | 163 ++++++++++++++++++
 2 files changed, 260 insertions(+), 63 deletions(-)

-- 
2.39.2


