Return-Path: <bpf+bounces-27042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BF8A8317
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD5B20EE1
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA313D53C;
	Wed, 17 Apr 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDWeDOdF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sCRDFZVD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BF13D299
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356693; cv=fail; b=mbmMfT1q1oWClV6vqTEagTmzmMvnAR4E2FrcNHfEveguS2L6Huwcq/gRnPEhFrXPD/9pQjAQu1244L/3KBNnRDzIi0Od1fbic+l1brcO26YRELgoKh72icQuZC3PRrzsMWLWPi5Qnw4V2lUTx2i7WTci+SW84ZysfKYErUaHxTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356693; c=relaxed/simple;
	bh=x6ZnOX4qWtwbBnhNC5I6v70woU+o0qBgY5YnyK2f6aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8g4OVHscb/JDo5oNeL8fHHIh3VvF4reSGeAUruxIRxUwWUPM1hsKpyh7Qx76xzrZ43P5KyuLzwnNsuVTtWiDMcDCVu2oeg9vsh1c5NYLcSQtKnDMa1PdM0OqHCBwoQ0uTag7nzGV/b7nl4RFdF3VcUtkSO4WhzFx7gw8ulsAls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDWeDOdF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sCRDFZVD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xURH021820;
	Wed, 17 Apr 2024 12:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=4PmDskNSHCtCsT5oacYQ0Me/0wAlI1YjtcoEVkh1Q58=;
 b=KDWeDOdFtG0BgKc9RqGhgg1/GYJa8Ecnfn9ITIRYME5OGcXTf2bKhw9hlriKo3vD0GER
 ohlJcBpgLVtFC2qk6PG/zrnpPmK3f8/sp9sCxJblRvX4A1ZZUawesPVTiXhEuQSnkRtQ
 Z+khp/dbT0SgKAPOYWWGaQ8n6PWPRfOdnbSXa96pkmZWErWnh+e08AXDVzhUw8aMJBEH
 K9FNm+mt6esUiMGGR1f2G/14E6kxQ1jXb4mONJP5fbZAehJWS2tjZAvk5Jd/2ytKUagw
 78iprXDQOWhfEAYK9aqFkiWXknJMoOboDIvXDrX7JfqXA44IW63b6GHQYVcY16LYngg2 zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgfffr3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HC4enV028851;
	Wed, 17 Apr 2024 12:24:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg8qp2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0+JtAovjAmCtHoacU+Y+uJiR1n1IvfI7zLDddS0EGKgnniitAh4ZeDMFIfMtFBrfB0KpMtU6cISt3mZh+0PzmJCQiQgHOtcxuhsCFcFMBqL4DsOTQz3AO+kYlMfNpyeJdJAqa1WOxCyzNQH+dEKl0D+jlqYLHllAh2dzKVg60vHooRyzy2SHxwwHfs5L5N6RbhQaQExJMRXZQQrKye1Du4THt/PmAz6d4HUgU3y2kLA7Dc0jz5vnCHGSJwWf5NmYru1awFiAuLhyFK7mitiuYIRszE9r7FZ4yriqcRzykllz0TwB6FtKIpOthgAHuOsK6boABh7N+79smwClSWI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PmDskNSHCtCsT5oacYQ0Me/0wAlI1YjtcoEVkh1Q58=;
 b=gyxOEGln6422LG0IGJ3Qn4YcGg9KoFI+nhe0yAUlxy2Xs+AoOsExWpuNU8GbS6iwa328NJCGUJd98nXMtitFKOFXeP4nBNeRadboCaGoGp33Npv1bZ+HkqrqF43nz5/JptInYAghh+MtYTiyrdlOzBMDYUCATvfIjsOTkReHyrvzG4rPCaQU8wFtFN4vs1fUKdRA4AvGFGegvrCmczYyhJkh/7SdRwsVjeks3YkElh8FZNsUQ6b/E6hV/Z2pyD0fgeGyZ2xnEsjtSvUn05F88BmRmjuOkv7QeuihXTpdmg6LsoCzDhAFb37IFKLxezg6XBXpFD0d+ghDXQ2AenbW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PmDskNSHCtCsT5oacYQ0Me/0wAlI1YjtcoEVkh1Q58=;
 b=sCRDFZVDAa6JwEPyAixf81Daf8708Ck0PA/8zRBpOUxxr+q7hseEJtPMlt1dCsNMU0p+PSfyFzOWXrLK1rPD6aDT8+KDlcFpEXNaOucgcx5Ap0+Y1UtfvYnU9DYU6uBrLnwgi7toASrhbuoqx+TeSxm6H8TVZxati7CQpWUn6NE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:24:44 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:44 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 2/5] bpf/verifier: improve XOR and OR range computation
Date: Wed, 17 Apr 2024 13:23:38 +0100
Message-Id: <20240417122341.331524-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417122341.331524-1-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0335.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::16) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcd3f52-b1f8-4fd5-beeb-08dc5ed95d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RI/GyoNMtz2QoGOrPex1IvKNTiA8A0bIdiorVjvBOXs2E5HKP0/61jDR/zCHk/f0YqBsZRuJ9zCT6xnFWc7m/B0BE1kppGtOo+Rj7ygPsdWZn5ryFSFaY8VRTUdax5F2Q5lBmMCd4fWs621CHGWhVZ786wgRB5Ac4ngvf2OjcBsKYAupTX35vGzHWlsyyBo3yUM+XWjHEf64ov1DtFuWBPbdJ5kgJUpocCyynApaGUavVS9+xOd7/kmCpM47AMqlWmGCjEDbNRGHWS9uQ9HOnU+3QGTfo5SWnah5eKYPauATLXL2MjdyoYIHqa+VH36w6HpLf+GJy7MTS1CUEOQhrVSUlzKhbNhbZxcTZjXjFMX+eSgiQaFlIZXBsJs1gJEjxmeqwAfHYSk1bXE4g0VRt/Hkn8NzqmJZ+KcQ0SZP+ts+ZnYAmlW6fEWY3P2s2bYqi9qLSi0gcQB+U6UopyNM4LjE+nAExhu7mw6tpkwp7vgRvBWmCyWSNo7ScCLs54eUg0o+ZfTa47O3senVWGLB71Y3BL0Fb4fRdCPtVLHHTXZVWZY8wsqTfSQUjOxXvIdJ6Li0UY0Dy5eBhFruhJ/cMNn0lR8Z2NLKQ+yezFH9ObdICHsUMXRKtoc84qiUfqM1Yz80zHSfX+9WFDVV58v5gLrGu25mUPgmMb+drmlsGqE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6ZH4i0StZ9ifg4igfGlUpVmRTRbBHB4tdOpkxYbYHOAImH8xJHq3qxTMjXnV?=
 =?us-ascii?Q?fvT+WfrZy7zqd3Lj8KTNKB7Y782yl8lBV/4E9nIWA/YJCbuEY44qxfB/gssx?=
 =?us-ascii?Q?F7FA6AoDPDuvHX8bvgFTubq4o0lSl4shoUDAHmHmyfEmPfy9pADZj2TLriv4?=
 =?us-ascii?Q?OplUg/GsO7+FWFBJMzlqdcZQwXoq/vpL7AUBs1R5rzZcXc85n/yKTEXn2H86?=
 =?us-ascii?Q?xQjsUKBU59QmnzpdxmXam1Wn9yDvo5a+4uxEpju0PqXFWuS6kBI8MCDgOx0H?=
 =?us-ascii?Q?KMxDoRDm53PSnQjCKgsj6DGX8D/wvgJevPgZ28FoJdAFtDpzsPucbeCemV5F?=
 =?us-ascii?Q?q20TCvOIk23pEEqknK5JyBPuFplVwisA0yCKpEbEFX7V+dzc9RCMTAIUtyob?=
 =?us-ascii?Q?i9wDHcYy1Ox86JUTbVU3/rmd1QTVe5E4h+Ay91KL6cuTLvRbM8MhLcAEpaXs?=
 =?us-ascii?Q?GEPy9RyYAtFD5pOWTauYWkn3HlvTtNDkQmMAfeizVQ4Trcmj8wBNP7oPdrlU?=
 =?us-ascii?Q?avW89hk1L0qh7RynKHeKlyPD05RfOj5PsyW1UCrG6Yl69eez8L11ppdc4h2j?=
 =?us-ascii?Q?Lgn1xffH9lbUB+DEOAhZlW+KM8wxcmFqITFhHSebvML754zNEJJEOrvL2ZTw?=
 =?us-ascii?Q?GOfgNCA3mFFYc7g44Smnfkfsjzv5Fd6vc4QuHQtXQ27d7VPfMiLwT65E78Sl?=
 =?us-ascii?Q?ZdHWBScsX16XDU7XPFQszv4ieRVrVkRN4KAT4+zl6GFz6ZC0rOk91Y206JJe?=
 =?us-ascii?Q?OvXoQlqwqfr65ER13AJNaYR6C4kxxwu4ttuDhc6qeU1LgEGgPg99Wr9zZ11w?=
 =?us-ascii?Q?J/571SNI11tY28KY+1bdRRbIZqFXfL8HzKyCt1sPoEDiIO1+sUPuOrPFqsO0?=
 =?us-ascii?Q?1NhOE4Rz4EuP6ci8OtjALeoCJALGTwaYaePkJjB7ZFMwy+OSPWf5IqNxMD/o?=
 =?us-ascii?Q?/XzmpvxB5vnhXpHkfoYhf2kqq33eGe5xs2N2hJqoiVQ6ciNfx7T4m+AAvi6G?=
 =?us-ascii?Q?wSnJr6j3JtvKJCP96MoiFmRkH7EqajHUOA551tPpesaYI+mnm/4/KVhvAQHH?=
 =?us-ascii?Q?3Ief6RLRAZRMx8lwJfp0N4SM5O7MTjFTUuqoh3VlOeFfTcE4q7wOIe6a0qvW?=
 =?us-ascii?Q?YYzqXzAp3kkqLFD9z/OTW3WrtD8MyiEGMjZbyzmwmGa7PanOvrnVq4rKZHnd?=
 =?us-ascii?Q?R0fysibh8dPQy8O0If0LGp5mxZ+UOjdYMHsByEAxcHpoZYmsfuRGRKGv+DbD?=
 =?us-ascii?Q?JzoWgal7eOHGfP+GJY87kxYNmhH4y9FuMsakkl6DLYRYz4cftsq8yRhzAwOx?=
 =?us-ascii?Q?CivauaeJGOQbTWoub6bnufeptqOzuFcuQZIFpOjHsG91g97Mr2clhmVCuXLe?=
 =?us-ascii?Q?ekOYG/WHdynjw1+NulgbkLC/IvhpFqfhpi+Tb3hy5TxiaEZhKGCKwVhPKX6o?=
 =?us-ascii?Q?vQ4MzQCp1sSXOr87E6uIdsFWAwnnBzo0KyksEEsLN1yVzQIjfI9gbnsH8gR9?=
 =?us-ascii?Q?4Gf6i20KdgAREqzIlEFQVrEVtuYKdb3vvTlTnLhZYILgPURqOmxX5M4Y3gbj?=
 =?us-ascii?Q?eS2gtNsXNSYELRbBXK6ItmVcsVUPOMmILAmcy5JK/fHEhUDsscJymuPoO+y0?=
 =?us-ascii?Q?Ttl+ib407R0ngGTMSPf1deA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1hhcXbY566VnjPOYAht3hvZT3DKHhtxli8EhRydH75g85HsidKAAkLIRWURgIt4sYu936QZBUmrL3L0iKIfXgxHcMFTJ9PnXG+7aG+f+1NeJCStUYSXraE5RhHrxRGZA/UEbECkT7ce78yk9aCg7Npy8gF5I4quz3GQv1jo3wlDgzvoNtZxjfYTRgvgrQlOckEejYBj/wWJSvqdyMqjvQdY6TuK/wP2M6gxZgOdZTXtmyYLCoid22XzMnje94kFJrViXSTL8DHWTXLwnMG5k59/y8O0Jj+2Fp8ZSh1dRUsewxRtjB01J3bSXb/rsqdVVO17aXQBqTHV6208tvtKk7Na11097tmkJIrcvYBdoYoVU1JGH8ca0P9gsBKcFfTSs4iAK0mrloVFsNJoQgvv3GgfoCZ1tr43SLtPxrbUOlrbQz0p3lHQYIVI/wL8EQPgwJAiIWtH8c0CVL+tQ6LzvNWkgvYvpAAW73dXPDuuD4P21VrRcVq7wG79t9yHx7lAFiipSaMADr/kFj8ulex8+ajZNs7mVZvKrN22PaFM5VnLqXnkrZmJnkx5Y9C7vJLHuF2koM1vsewpm2PYGLvMyuv6OylmgtpmQfq975DyeM34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcd3f52-b1f8-4fd5-beeb-08dc5ed95d59
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:44.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC2ZDvzIEIFSfnma5RoWXYg0LLsOiZwd+IL0GaRva6vwCaGEdMdJBANHCndjU6Y/UyKbJtoboCDnKXXdsTvLSJRoMUscIC7NEqLW9LaDLfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170085
X-Proofpoint-ORIG-GUID: 0SuJQQQ7b3yVeKhxx9mjMMDSAud4pB7y
X-Proofpoint-GUID: 0SuJQQQ7b3yVeKhxx9mjMMDSAud4pB7y

Range for XOR and OR operators would not be attempted unless src_reg
would resolve to a single value, i.e. a known constant value.
This condition is unnecessary, and the following XOR/OR operator
handling could compute a possible better range.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0aa6580af7a2..f410eb027e25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13453,12 +13453,12 @@ static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_ADD:
 	case BPF_SUB:
 	case BPF_AND:
+	case BPF_XOR:
+	case BPF_OR:
 		return COMPUTABLE_RANGE;
 
 	/* Compute range for the following only if the src_reg is known.
 	 */
-	case BPF_XOR:
-	case BPF_OR:
 	case BPF_MUL:
 		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
 
-- 
2.39.2


