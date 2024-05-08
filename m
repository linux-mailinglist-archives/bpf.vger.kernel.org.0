Return-Path: <bpf+bounces-29061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDD8BFB8D
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD6A1F21262
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CB81AB2;
	Wed,  8 May 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="foRcbCi9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Agi6w7a"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A627E588
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166225; cv=fail; b=cSztsI7Pqzrb3pdH9zRRrIsJGPU9lxnTOJMHOdrbq9BYft1qUugwth7Ar7DNoL0xMuPnmC43cM4jA9pmj6dRS7hiOQcQmpSsvtOXm0TONtGIhyYYyZ+9gfpKh/wbCVXlzInRsFCYYA+txKaJHYLHUL6USah8KplqqBOLuhkobBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166225; c=relaxed/simple;
	bh=NbEEgrt7tN0kHcnwx8Glfaz7Cw65EanptWGv1bkda9U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Yjvp0cJJSTnCnQ18ROZFkfpjRh6iZzw6FXVx6lakvrUx0+rDtcSdYY0bghmIxxvQoam8s/Y0BwpisfrXn13dLdb0uk55l9qzQQ9nLrpSHvWSpAlRke+wdLLax0e7/ZlminmdhQ4Cgd9qpDlTN0zzSZ6AnDkgd+m0edpvjbHsFSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=foRcbCi9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Agi6w7a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4488nq50026082;
	Wed, 8 May 2024 11:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=CVLalJZ88fE/BjMVp/PqdpUMPVGWKABTiRdjke3UuOw=;
 b=foRcbCi9k3DXSNoKO3LG0FHPNj44lbNjTZw3XQiIu5VYsSTytUw0MEAm9FS2pl2rYY+P
 aeZAyP9AZx6TI+rPCQ3UntkbSgKMk77vvo8ZpcN30oDGPBuqxUdztY/zDrDb2WMKT3qW
 3TlLWg9kssa9satPKNV5NRMfoJmYcBBfYV5exgHYR5ynn+m+7GCmykSXEUDIsAVxwd88
 Uvs2XvfP2L9Vor/EOCp3Ic9b1OIV2mlaMVrG9qaoB5DG+VviYKH2dV7fsnSb2T0b+Q9e
 iInFoc2j4hVL1do9Nn1myJ+dMT2tyiU2k1xAL45uk7TvblhCD6EvBZLAxVHVCJBGAhdr uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysg2heqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 11:03:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448AlTHt031022;
	Wed, 8 May 2024 11:03:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfhmuwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 11:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiNokjMTLdj8AbP5tybf2rNT2KTRCXtaE6XPHAMAWfNT88V1ksVp3RmQcWXjwkf3rZvSBGoxBpP/V4m5d1UplZyTBkpCbFtBdjFVHCvdmt9kra+DQcMPJV7OsrJWsZUCJI6LV//LiJn+LQyNC3LyXbw0hKn/dZ02L18V+bNdR68GCu9IwCGmsavg9NaDZsstgeVUjVOfoY+BC1FqntCLASrHlxlI9wBumQrhjgDlPUNemAIflyKPKCe9vLBaynZr923olN1q74USw7tfvCtoSnwbf1CHqpsLFy8Rd2NV7pwzlig9UayLbGHtti1bMpHHlKnowZrEZI5hrzFWUUKA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVLalJZ88fE/BjMVp/PqdpUMPVGWKABTiRdjke3UuOw=;
 b=jiNrauNb7Nuw+VGAD5WFewCWFDeqnZX+yE3jkwLdz00eLqrtyoB9gU7+KJqyqcugNdNq6873wjE1lwJHDCOQ4qf4mowzEUdSPY/sUQ6TJlmbtANTtzAEiuols0v5FuEfEbTaybJC/v5rSyEHpsA1DiagUYamrEoFWsbOtILSPR9+ZdGTDtxucICa1kyei7B7OXc1Eg6y5SNrFy/orDDrUTWrtWprpmQ7zkKZBBR0vR2GOHEeefyVa9bxMo9i3dxLSqxNWycLykrQ3InHAbIIVAbvqnfzi7nfYfDnaNXI2CFcA+q5tbTozl7wUO5t84++8/kRw/UNlrEBa4cGpI1oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVLalJZ88fE/BjMVp/PqdpUMPVGWKABTiRdjke3UuOw=;
 b=0Agi6w7aChW1rEPmMwL43hMGwG+l6o4DdJxE27ODVFLephXubFVdFCCN0+vY6Y63YPij09WCu8nfHdEqY6ftlK5CwCp3pFC0+tRy5wgMtniQEKzKmLFmcF5U7BYv1nILPJNOUUi0KmVzav9py0SpoDYoKdkfHX6sN5Ho+lO/I08=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 11:03:37 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 11:03:37 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] bpf: guard BPF_NO_PRESERVE_ACCESS_INDEX in skb_pkt_end.c
Date: Wed,  8 May 2024 13:03:32 +0200
Message-Id: <20240508110332.17332-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c45f6d-5c21-41a2-9576-08dc6f4e82ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nY+MJbrj/LVEMN1aaxLyjvdGY86bBDghICjp4kvRSQQ85/aeAP+/HRL1eFUe?=
 =?us-ascii?Q?Ad0wHMbo9znxW3AhAhjdNALYPbp6ObgNzfleXIaXWly7vZMMi/Ma1ItUR9yr?=
 =?us-ascii?Q?LKnWr3RVnXSmmsZ+uVI7b5ZYpKZHz2ci3PEdSlF50iBZQexnHOkY+5S42rGU?=
 =?us-ascii?Q?iw91dArIHD2VKG6exbtYVyLmYMPeVkQfwhkdDVig7MlCAeyH1XTkJf6tekI9?=
 =?us-ascii?Q?KGS7iDAnwYLiJz6hrMzGFG+55ILaHBOPX6Qa2z6Lgt9Lln2KlAiwgxkZo6s8?=
 =?us-ascii?Q?6woiwXUtJarxsAkgTEIJADMujlGg6HolCE6OGQCBfRKuF38ecGrEGU9/ybN9?=
 =?us-ascii?Q?XtcMAKXNv1sJTKNSkgnSD8kyE8+pzbPs9xxFDwRG1C5JPgz1udlgT/3Sogn8?=
 =?us-ascii?Q?d5gvn/Ln9ww23NGkoACgu5Lv1sAYPASsgqm8Efxm1ZX2ZCAZZo1uLoytau24?=
 =?us-ascii?Q?ObIPW0N6KOtazR2cDlcpygyDJZX1J6pR3Jobr/AHM91DEbepy/6K0+s5J6dd?=
 =?us-ascii?Q?o8zYX5vdy38Sry0d021oYBQ2yOGaY6g2nJRwypKat90MSuckVbg5lpsISeOS?=
 =?us-ascii?Q?K//iWHBlt/LFUnTztjL9oGAcGnFkFNIbm/6TFUcElr75/SKu1bNWdgidHwOs?=
 =?us-ascii?Q?YhBpLXjpBjqgjiIIBpeTowdkNVGdGIQTJK7KJcDjgcgQckAEGRBNL9tuW7vl?=
 =?us-ascii?Q?h7WH/r8FEe/ljofkFhc6eHQKsWd1Hr+a8rVUiwurSp5QJbQIepaRv2btjfr8?=
 =?us-ascii?Q?xuorUWW5YM2JEk1kPKlZHlNihv8SQcLH9aBzfoPOnip1m4RXNQkJMvCEPTBK?=
 =?us-ascii?Q?mjXnfG0BRPEbUuOT9VGjzMnaMdPwNLW6yzsX0Ra22JWGRQveJ9TvaJCcx2GW?=
 =?us-ascii?Q?Yb1E3yAmiV1oC5/yaXSC963SyjzVbIeoIJxT2O6GoUZ18ZoWiZ9EbQOVTvMH?=
 =?us-ascii?Q?lV68v4yVlSRfsUh1GP6Ba7OyahmNL/ig0TsFUWPUAbkWR1W677DC20vswtRJ?=
 =?us-ascii?Q?tZzW3Y+HW5zd3lh61KiQ8y0dyuOTQAtgmqISgRZG/rcnSOfSe6RbbvVfBjwp?=
 =?us-ascii?Q?hZLxTdEfMMuQemw3Hnn2pK28qFNnlHmpEjQMPyICaQOPpmdpuGZ2NpYgd8Aa?=
 =?us-ascii?Q?JqhqACMFWPBFWFqQsLmgcJ8yvE9pQ6bMw4bvbMFnxi2XZMEf+392WYK9kne4?=
 =?us-ascii?Q?eMLNjug3F9LFLv+nJihGHNm0Vbi6jCHXBqoj4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9cvoWkeuAYBxoKIZHyxjHPWF+E090JZZWxHz393EHZA9eiLKkcQsDxFUGR1t?=
 =?us-ascii?Q?BzQUuEn+V1SxQ8vfPYQmFwKwse0R+oOg+Ut/B/wAX8UsM2ucEQXA/b9dHZBo?=
 =?us-ascii?Q?ETg/Ap9OtRqWp9G4Muz7mSJ7gpOUbhw1nWv+qqWu6VKjOztDSc/YXdnw65Y0?=
 =?us-ascii?Q?UgxU26Zs7UnnSUXbRR/uBl6nSnB/hIRTXkR3ZVtEFrNYYT4jOEWRRPNBm/r7?=
 =?us-ascii?Q?/e9Uxn0yvnWO9CFxnZeihvfVRRsFMz3zGcxb3DpsEqoN8eN3+rEIBPMlOxC8?=
 =?us-ascii?Q?/gt119aDZmUsMgoRMmwHKpdKN8k5rvdHBRtcQz1/iHkpkekf8ASrG42hPkh/?=
 =?us-ascii?Q?IPFj4oOdmyQCl7a1B9kK7I0UQP3gg8ppsbOEZi7C1SFPtMM4tfzjA29HpyQt?=
 =?us-ascii?Q?jauNVsxDwoBqpFgH5U/eAQSS0SEZEOQqPmZR0Lt7Zp7OZbIaU8XjMveYQFUf?=
 =?us-ascii?Q?OzVFv0IJNuOgls2KSmHhgJYU0LaBey9aRBvgORtbTsCB0MZfMT4snUddNwuC?=
 =?us-ascii?Q?uF3Uygg5j0lmQSitb+XmMyJk1WjeFwQVsox0YME0TFk3sTTkCkQjXT4Kc4sQ?=
 =?us-ascii?Q?iHL+xLDf2vFhtGPCDI39ofTWZIUo8b3zh9SBrJptqxSQraztXwkyvOlzgjpV?=
 =?us-ascii?Q?BUbBn1yWEqPA+bWM3FIm7sjzeR5/x641cg3B5hOy+SJFZBUOIAQsRArDYhKi?=
 =?us-ascii?Q?fUtCC77Cii3MtlJgVnG80v9uBg1fvsRIaIQBl++zVQl+a+b6S0A+cdCGl3oB?=
 =?us-ascii?Q?2/UzHgLmzh6G2CnLSGt0uoQH4wk8T+gjpSyAM6hqfSKeeXAYc5PPJjdAA3uV?=
 =?us-ascii?Q?0ZscbKf7k9liZFCWiZ36Eo1tmv+1QD9nzgtFtimtTjMUmHq5GAyiIjp2JE/N?=
 =?us-ascii?Q?QofrDn/X6M+LqQfpiYQSbp/wXjke8OdGXrAgsDg0p+OkzWxLaad318vKdCYL?=
 =?us-ascii?Q?EksvvyhjaigNtnwvt7zGf0w3ycYjROhp4QgFYafYtIAB5/h9yWJ277uMfjNC?=
 =?us-ascii?Q?FdN5dqLMbCnvFm7h4FOfj7cuIUQ3FqA4kOXkkMkg6TaLZ7eLAe/mLmT27hwr?=
 =?us-ascii?Q?vsUfHLe6bm7Th5bTMmOFqSRCY2V0WpHAXSGswFzkZES+ZPLbkJKXaENzMjlN?=
 =?us-ascii?Q?ILMz98Fzo/AFdxX/HNiSwkn1N1kkYW1RyCyTN6kEtI5ryehUgk9Y7Qa2gJS7?=
 =?us-ascii?Q?irej0tKCzmGdwfrh7sl04qGTBCLVvNenO6xqQAGsWwSQ96OdM85apkfC3w3P?=
 =?us-ascii?Q?w2OUHJMoTTOwAJ/XFyk9tcE2LIRPPKhBXAH67mS8mHyWq8i3EBqpzOg9aQ4f?=
 =?us-ascii?Q?7nCTx5hfwPF3xG4EkzAVGar/FqogRPSSFn4+p8r9lSxlx3YXJk2cb5oFuIK1?=
 =?us-ascii?Q?sKrUEZggLTtzqvE27IvXuhCtw41xhlDF5+hPQdwqAt0bLdDVLT3xkmv8Yd2w?=
 =?us-ascii?Q?CuE9ytQD9ttKBYbBxXi8rGG9mejIt9Hnc+jxNz5inmaCpMugmM9Stl5sD337?=
 =?us-ascii?Q?FlO/g5roDk2h8Oqul8/4ONkCGnHhH3rhCNsQnRQ/a/0c4rGgVs63m4peAyqb?=
 =?us-ascii?Q?fi/zMIKbAWgtsxKTYdAOBr9zdq2IJTnPZgq4dO/MezxL+bwn1pFGSpeOIIYi?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lEsVK30+n3DwpsXnlIu4VGrIZNvAJbdOt7eDf0FLXlE19loefTgHmFRz9ufWmp2w3Jy0wmQyCwCniCYM5weF6TG6a67MwV4q0a2dXPhasM7u2N19Kd2rsgbk3yJ7P1Mt+g0wct5JvU+UE0Vk3pC3prU2vr8MmxkWNHQXal7hzwxqO2+pRKFsstWdb1k/7MD7eO5MQjfHReMPve1QWFVQRhkhQrNA7t/TcLorEnB0Q7ioSw7Nbzv5UpYbnK5Na4HBkGNecDEhYjlYQsU2iTkW1CFc74p8Ufgcy/l7JRAP0QUTho1LsU4LCpQ1IB8S6rrLpjtSzVvYUal9CF9ckbgqyEMEA5cGq7OuoutTWei9O75Z+ISflM5kmLgFUFJbMlGrlYG6auJur0kM9Rhb/EK46JjCR2HcBlt8ZdUNmLqMTOQ8hdb5UOsdplO6LLmPDl31Xp4656D3XOYLWuNyMvoMT+0ai/z1TwjZPsWpmxdSmTOBqfSjvl87oifSfaVWIfYsYMaTJ/w6stGXhbIzmXHToLGejy1dAhi44R2R7gQSzokfbXlvhc7YcAx+8uyi5nCij41+iMe3k+9KC6XEaJ1b9j8JA9uXlzK14/00yBLqG/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c45f6d-5c21-41a2-9576-08dc6f4e82ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:03:37.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH8v08bZnx40g/gJcbhNfS2PmQkueeFcNQP2OZQGY7k8Z5D+srYinIljnW+btKu6p9dDfVSE0rc17P6zrqHj4VSMNOjGzvKI5h2ECbWjDT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_07,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405080079
X-Proofpoint-GUID: 0jTAa5hgDgeBoe8POTsZjOi4P8QeMoKK
X-Proofpoint-ORIG-GUID: 0jTAa5hgDgeBoe8POTsZjOi4P8QeMoKK

This little patch is a follow-up to:
https://lore.kernel.org/bpf/20240507095011.15867-1-jose.marchesi@oracle.com/T/#u

The temporary workaround of passing -DBPF_NO_PRESERVE_ACCESS_INDEX
when building with GCC triggers a redefinition preprocessor error when
building progs/skb_pkt_end.c.  This patch adds a guard to avoid
redefinition.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/skb_pkt_end.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/skb_pkt_end.c b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
index 992b7861003a..db4abd2682fc 100644
--- a/tools/testing/selftests/bpf/progs/skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
 #define BPF_NO_PRESERVE_ACCESS_INDEX
+#endif
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
-- 
2.30.2


