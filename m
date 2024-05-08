Return-Path: <bpf+bounces-29059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C58BFB13
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BBF283FBA
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74180C16;
	Wed,  8 May 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEwrclYB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6oeXGiD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDE42ABC
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164570; cv=fail; b=Vis+r+f3vWesCCxD2fzo/xj4Vqmu+70PnL6Ak9RSY1dhKscQKk7VJtbv8G1WJkOpa91C724qNqMGD2upv8eQOvRZz+NLJFzvKvQ4LADWyPvd8jNvH1h0ym0cZaT7gQxInDYKbq2C5fViUq0e8xiIi460z5Do+qg8FeP5613oi/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164570; c=relaxed/simple;
	bh=U23JkG3GAF3zIclr4d57iziKGT76WidMdLhRFRAmZy0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uFGvrHsPPWkCxGQmPO0dFMPgyHygHhIBWAzjInOMid+WnKdSPub+xytbHLF2ohaaVbdO6uSliZ2oOIvMsdgJTzKLURpboQFMx/QavFLzwo9F3cBsJdjqMiIIkwRY6Q8dRF9mGVBkTy0lMApVwVnM7dSLZl7TIrIvh3YsfhuDNPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fEwrclYB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6oeXGiD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4488nur4025861;
	Wed, 8 May 2024 10:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1AgF4wbzbNjtmFIJrXzczOVqxOgs14p/im0+C4T6h/E=;
 b=fEwrclYBEA3ZBud3qLlpAOAdhniPd4ps8uBlBm6z6I4wp9aBc/60EqFAMEnQv2DLvVW6
 i2CXdYHNW5OGrwnU/81662bJQgT1yXxdWuQJD4ix2voiOtpBn1XDM+TImrrQUEk9D/Rf
 Iy9XcxrSU0eZy/eEst5opO4o8xqshiAGv1H4quV1LtGDgKjL6i7ucABXPmdCM4linVhO
 ujrm4sbTDOCus49M7bLLDiR+1PoI2uSJ5IXrrTBv5WFWeJlXkofp84cEBpfZo4yX5ZeO
 IyRKa5K20yVfbFHY1764uk9eV7E+eJpTmPJjRUv+r28yLP6Fji+KG8TCMDySDF6IYyA1 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfy9drj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 10:36:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4488oKuO024272;
	Wed, 8 May 2024 10:36:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfn47yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 10:36:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8JlXK0HLFuXa4u2j3Lfqd1I1Ct8iHfwLFNRcRbDD+VmrfXdxK3S1D4yLcXlFcDhhEutdzP3vYKWIXtGIDPNzJ9ZdGPdxMBI/XJbXGa2g7DWeInny7AVsPQ5V4R4XOOzYQChp7U8dT5Yc8KMNvhk+TvisroLQHCeD9U5J6oQ1Xe3ERN3zmBiZx2TQ4s/nH+usHSfOCuVE1BSR1WelmDgXJf9ITA4bpYXsj0O2BAMVnySMCJC3f6UegJNkOmeKn43ZDtQPcUrOcp+CZ5qEeB3DyIkDIanmjUmwHSU7d3WF4BZ6ADKTch1vIhyV7JWON9vZ0K6wnB7Y75PO45x+v0XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AgF4wbzbNjtmFIJrXzczOVqxOgs14p/im0+C4T6h/E=;
 b=FmyeJEYN6pA/IeHVZmZ+bOWTXfu8KmMHlPA+Ztf+vuAWBpuvaT86puSc+xJkMfPOuVGxdeb0AONPuIyAzYXiPDmDCgmJMAPIzRxM5QKFz3QK+QGU8gtv5JIDB2tIFLEjyWZ/2OsjmbnyigQps+luojDZg1dig8bYGVvaO266KETqcIg7c0hBUAjGzatWe46wctibzUioppvaFRa1KKLFMXfLI9kzVTDug7JB5IZauO1t3InPwxd03CggQe2+ZGq1MGq5YyRQ0fFq4dlYqj+il6TPPTTitvD7JExZ+ijop9kxoRWCm01kNreciaabaw+uGenX391XGrXH8bbo4cxhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AgF4wbzbNjtmFIJrXzczOVqxOgs14p/im0+C4T6h/E=;
 b=m6oeXGiDJZQ3nMfNz7hPeuvHHkS/nztlfXyeMl4kfiSwZbXOy1PUb7s9As70eRZsA/mPBDVzPCZzbdCfCB+RGep3Z6hq9hJF4Hzoa88TZWhXS+J3iw5nfgbGetOmes+D3r01YadCAhdBwZnevbCpXl7wHHw6y/gd8Slp1MkizII=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by IA0PR10MB6844.namprd10.prod.outlook.com (2603:10b6:208:434::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 10:35:59 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 10:35:58 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next V3] bpf: avoid UB in usages of the __imm_insn macro
Date: Wed,  8 May 2024 12:35:51 +0200
Message-Id: <20240508103551.14955-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::32) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|IA0PR10MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c94e4d-faef-466b-3660-08dc6f4aa5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?09n7n6CxK0RxeNfs5G7tG59sg9TpxGPd7OD/KO5ch0CZxRdn4LuoRc2fPc08?=
 =?us-ascii?Q?nTyHuBdOI1YekhXn45QeAgHTMKxI2eHStfKH/h0TlzaM1gNqV3LkvuRsi5P8?=
 =?us-ascii?Q?dXxBV4vsBdtZ5KQf1YcW/XzyId6XatNvON7bY+mhWEWKd7mMlWC0xP67UTyk?=
 =?us-ascii?Q?qSQrLAt+T1lpW5hiHyRoE9x8Cz4l4SfFk5pcZkDrjv7cX5wG9tbgLezE+Hr9?=
 =?us-ascii?Q?XdiNekhAKlrkyigofM7K60Jyd6q8QgEapLipbhbOw7x3Kj2plp+4gS/RvDF4?=
 =?us-ascii?Q?p6ttysWJQnZ/zbq1HHiDdB71+ocxCH39kQ13PcZyMIh3iZ56I5tCUQOJ6kWw?=
 =?us-ascii?Q?bGwp22GAefZXvF5WjAyGbuAF0yufoNPSKcQBYbrfDeznno7Wvb0hURtNoiyq?=
 =?us-ascii?Q?43pSrYGZ3I5UwPKXH1m4KO40trgXzi/wzB1vTvtODD5D+QbYqHtxPZcu91cp?=
 =?us-ascii?Q?h1/NJZi2QQR1UIpssJSbjCUJLl3kxypGrwest+o+qNwUlTGNgEWe3x8eAWnQ?=
 =?us-ascii?Q?3ojv2TWdZmhBpkXZsFmxoMzlHP+uVrbmc7JvLOvrTUwgUIbIZ5bqojkNpN0S?=
 =?us-ascii?Q?OOeghKDd8oq7pEMfuVAmVd/Zldb36e03hO0vx9vXWFla5k6WPX23sE9a7fkb?=
 =?us-ascii?Q?YJtFDrcmGvxfiRFKy9tsagTXzfNIlhlMVkeU/92D5oetHHq844hrp27wfbvb?=
 =?us-ascii?Q?InZW2CA2hTTmhbCVQSQUN0Ii214E4g9psVVQ7xoxw+Y+gIFV34zHvmBuLFco?=
 =?us-ascii?Q?S/EiX30QeI3941mYv/rWru8NXb4Et6uyaCFtCIyPed2ST2fthXtZpi9JGZ5x?=
 =?us-ascii?Q?vNx9WUR5SOsV+2Xblty+Kkt/AwrXGpdxmhqq5CfKS04sHYoVwwIAQyKZwmNv?=
 =?us-ascii?Q?cgYRtWeKGAFdG/MVOKoqf4bb6DQF991k/ORVOMjaLkWqmUGKwJrHrI6pvC7V?=
 =?us-ascii?Q?SG5zLoHrVdg7E7OsndFXTi4qx6XxSPmspSI7vdV+xgXyP1ELCtnGX3VdQKFF?=
 =?us-ascii?Q?aRgP3wWtKd9w1Sz/SBaASUshnZl0dxtdMD1mNmucQiAWImqnjPrTFwqG9HBV?=
 =?us-ascii?Q?/IcRIZnL8DlBSuDwqcnEyXEigUgioyWpKcXpwj/uCKhu/DOI11SHcng3sCA2?=
 =?us-ascii?Q?+chP7MnYU/ptLqP5IjD6DE2kCJzwFZiizpG2ZvP/bUAPMt0Fv5hJG3a/LxXx?=
 =?us-ascii?Q?IjiBJrBLGduLAHvwyFSV/dPh7BcrPgQj8/K81TyiHkBz5nuhCh1UngzPvH/f?=
 =?us-ascii?Q?F52ZwtYP+XEDIP5//zdNbt3/+nxRHX10t5YrhvLMgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eYemYPCayLrKi2L3q1HMer7odpcApun8EjazGv0+qh37udhhrY8wM/oxbKru?=
 =?us-ascii?Q?Bhqjogb2+R1c/H29hkWDLJD/iBRgkRx6HrOtBXqNaelPkf3cyyrBqPDeMXU1?=
 =?us-ascii?Q?geipELRRgpXu/PxUtA20+zaYhAy23qXd6iTNvxd4MGxuaZs5FWc6+YivMv3n?=
 =?us-ascii?Q?8IKyytFBXN6YvO/jDRRZLQsCiLTk9ahERsLxid7Rqcn2z5bzQoio2Axy/i+w?=
 =?us-ascii?Q?LLzmKxQHx2twAwA9ApryYWGBxApsR5JpDHV5RNNH7hqUi7i3SQMH3Igtfx+m?=
 =?us-ascii?Q?HcrLR7JZJIVf52X7ZbNyPes6nQqweWqPSkMs47ijLSTIuWMfF0mNokC51z9R?=
 =?us-ascii?Q?WtJLdEaspl2Yljbfj8vsEUvqvtf6LSJ4k2VMl17zGa2bWarjwkd0SJ5lkv/q?=
 =?us-ascii?Q?FPdjfGbJIqb7JRoSQDNCtmDvmkNVFtvgPy6Tvlt/mDj0Uhb+lgN9Xro03Hj+?=
 =?us-ascii?Q?XecTJrvWe1O/WBwOWs21wi6WJk6x/tlOAU23ZLZF68Ont9eSHatj7m+nzudL?=
 =?us-ascii?Q?8tbLfIyZByyu42c4h0Qikq+FLw5LMtqFw6VMBiuke0UrOGw5GoX/I7406pKn?=
 =?us-ascii?Q?JLmv0634jCYdDw7nHrpbcQl1TDmYMMbrQmOfquiykIO3TCx/ByT2GF4oQm/W?=
 =?us-ascii?Q?28sb1DcIoVxavcjFGy5v44g02Mx1gc8fD3U9ExlYYTTLX/Cye6vdzeA/oZ/s?=
 =?us-ascii?Q?wBDc0fO2o2r8EfqlJvMMjCqfwQLRlSUmI67bYnc/0R3rVqFB8S4DICRzhBOp?=
 =?us-ascii?Q?QaIBpjtoNs0nE7smIlh8cgqa5ldEEb7IqiIOsN2Wy0yLNTqbY0y/7FtH75Pt?=
 =?us-ascii?Q?ZsqHb05Uu1TfvZt7B0HexME2VYqnzYi1m8BrD6TmrY3vPNQDd1t6Ntm9nvp6?=
 =?us-ascii?Q?8n3hguybawpXFvIEcqZdCJGd8sBJZ9eSh8nYAdvzge2p4zjdAzJiI9dZEQzB?=
 =?us-ascii?Q?VuOGWWYrTl+eGDZPn68dq9iV+mPrNkfW/5p9jgpqRhFmKW6BDl/clUklbHsX?=
 =?us-ascii?Q?141JzZ00mdSBOpTiDZ4fz6Lpbw86e1Of1a+HsQT3R3tBt4CuQ8mJPO2QhN3y?=
 =?us-ascii?Q?g0jAq+cKAaW28kvvpeL3+w7vT0VgQwYaRqt+gzRGVZ8RMtpAdOLutJt1q47n?=
 =?us-ascii?Q?vaqZKQcHnfoWerDg+XYBqm/pSM4mvmzQrMnsGyVKJjxgI5PT5EuAQ7u8Aeg6?=
 =?us-ascii?Q?ZglI9uPyTUUjKy5EwsQkhzihzl+ZZWONWpVwDqtj9qgzi7oCUlPzBlzaTbmZ?=
 =?us-ascii?Q?TfUmtUc29l3wmUA7YcyuMhDD7EJjT3wm/0Tg+8YBrWe6nsbte8j6T0ki4E2Q?=
 =?us-ascii?Q?vIhoYSX7lQ1CdWVIEGttuw68bydynrufl4NyRfLS5n2sAKKbsE0zssHICbDM?=
 =?us-ascii?Q?dlNGGX+ohMmsxD3h3Oww1LaTh7mOyIb8zRpLswgKj2MR1WcJo24zZrS5Z3di?=
 =?us-ascii?Q?JSobyaxc7Nf527EXTEh/yFH2rActr0lEb5+D26OJgDS3sy5fgQqD10Naipxm?=
 =?us-ascii?Q?Dtc8syAuzFgZSxc23JVfw5FMso8NsUZjm5X+MQZcwmUySFcw5Y1jcweUyZ/k?=
 =?us-ascii?Q?41OnKiAhCRQnJon8QcgY3d8SDaMMk9HvemLuBt+B8M2YkDk3ANzfH75t1arw?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E+uXLeJCtwoWhgCQxlULeEWs2q0Ulr9a52LX2ZNMcDXxLpm6cSjGQ3gRBMiOEtpRef1Kp5h7Hm3OMXpMXfY0vvcgtc/25L/Bjv5ZCPizHYYQzdDgxrU3F94TJxF3OGCui84X4ezI9Y3+6eQPEdkBFRP0d8n+BFsMLX3vMx8y8ae1c+2y8c4sF0Q5yf2o76+vyRnE8xKoC0Pin5wr79CbWWdqnxJ87RJRDbKxZxOf32ay13GPfFrED+j2AH/EaAhfo00arMV9cgpYrHd/8c1dyfeN5lC612JVIUVoAWSWQFzXU7y/64g4Oz3bVgGlp/LPKQi1jvSgMt7jA+VbKV2jK/0wc8PtyLqklL1TsDXuloOeKazJ50gZW9TIwZWNmmWYXwy91HT9yIpf3LTCBdog0e7UUPCa/3CkeXIsWk9qSYvblrj7a8rK6uM5Id2/TTnheBGVAKTF2uDISPUAQdZQnGsnoJ+olvnMfyywFDaAalUjBgDfKW4f6uo3j6CLKKmp5caJfEsdN8FX6NoK5+JV0jfkMFz0240Mzx6j22b51ASVHyZkWkolbALkRkS4vPihNg/uNdofd8b4hca99/azv9djURqg5hj09gsyeSauJ5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c94e4d-faef-466b-3660-08dc6f4aa5b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:35:58.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw9aCRxGUUt/PV0059r+bUAgIdQ2nflJp8GdJJzh631ixb6GsbgEGI9txxyNPV/PnWbYBrKYS2CxUKVbOd3bo0ZrmPFKKDCrLs4aGEGuAfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_05,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080074
X-Proofpoint-GUID: wh_sIyHwD4xKZBwnthEk0j6uD_uLuK1M
X-Proofpoint-ORIG-GUID: wh_sIyHwD4xKZBwnthEk0j6uD_uLuK1M

[Changes from V2:
 - no-strict-aliasing is only applied when building with GCC.
 - cpumask_failure.c is excluded, as it doesn't use __imm_insn.]

The __imm_insn macro is defined in bpf_misc.h as:

  #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))

This may lead to type-punning and strict aliasing rules violations in
it's typical usage where the address of a struct bpf_insn is passed as
expr, like in:

  __imm_insn(st_mem,
             BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))

Where:

  #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
	((struct bpf_insn) {					\
		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
		.dst_reg = DST,					\
		.src_reg = 0,					\
		.off   = OFF,					\
		.imm   = IMM })

In all the actual instances of this in the BPF selftests the value is
fed to a volatile asm statement as soon as it gets read from memory,
and thus it is unlikely anti-aliasing rules breakage may lead to
misguided optimizations.

However, GCC detects the potential problem (indirectly) by issuing a
warning stating that a temporary <Uxxxxxx> is used uninitialized,
where the temporary corresponds to the memory read by *(long *).

This patch adds -fno-strict-aliasing to the compilation flags of the
particular selftests that do type punning via __imm_insn, only for
GCC.

Tested in master bpf-next.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 511ea84139a3..e962a0bd8a78 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -86,6 +86,19 @@ progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
 progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
+
+# The following tests do type-punning, via the __imm_insn macro, from
+# `struct bpf_insn' to long and then uses the value.  This triggers an
+# "is used uninitialized" warning in GCC due to strict-aliasing
+# rules.
+progs/verifier_ref_tracking.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_unpriv.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_cgroup_storage.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_ld_ind.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_map_ret_val.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_spill_fill.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_subprog_precision.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
+progs/verifier_uninit.c-bpf_gcc-CFLAGS := -fno-strict-aliasing
 endif
 
 ifneq ($(CLANG_CPUV4),)
-- 
2.30.2


