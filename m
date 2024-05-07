Return-Path: <bpf+bounces-28812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CB8BE203
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105841F25B1F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724AF15DBCA;
	Tue,  7 May 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UFGNcRJu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KU93r35f"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B6158D9C
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084607; cv=fail; b=NUd7Ihk+aMDXwc/M5FhZ+JZInPrLh9i4B/jqLCwfNpbkZsfc2r83rJJs6sTsyxw+bmCsUQn61Uq2rU7lC5Rn7fI33HUwXs4OWFtdlqoYdOAEmXragPyD20F2Jl1salJvlC4B4fd0IrS4Gy7bmHkBUP6rLJAOHPIbdSATckRiGS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084607; c=relaxed/simple;
	bh=xSaHakNgWWlV3KVzpU+/O+99iYo5SVnpqFL80Y2WO+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jT4caxVfAlOLLeARLpqyVaRVbKwRmvd8Y+MpvPcV5O6ED+cIt7Si5PiHNEz9J5PgEBaKFfYTFFloZB4WW3oUzyjbMsCrBk0EMwB/amOzsybUsFO63PdsI79+8BTKVxnTheEF8Oy24a1K5hKBqX6VgqCNh3OLzLM+QWuyKatRf5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UFGNcRJu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KU93r35f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44794OdT031264;
	Tue, 7 May 2024 12:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=q/RuZo8ClfnEOtGfaS5SK+5QPVxL9WaWmmsXmyJeVis=;
 b=UFGNcRJuzyHC74Rb56vhsc4f5t6d03nHsC6VZdC104h7/M9OwdqizwzOcL/FyV0Ffn/M
 /uH/2aW4HgZLFhgyJN1kVB4/xllXfA5G+8iip1Xm7p0FIZ2/LG2Cl9g7lG88L4GA/dvF
 jTfsBA8DkRdEgyUk5ViPA53WirVN3U/wixl+Ai9eMONC2TKx41FcgtEjL6uia+J/CZu3
 4ObX4mo899Xq9ydvVBN3znJCxN+rNUrABzHMTlTWnMso59WtK/fjCbFti78KTQ76mMQc
 vNcc+gZRVtxOy0g6T4a/wCHokJ6g9hp1pH/6emcUwyHaBAbAnC2WkQqtzzB3sGcbk0OA JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbxcvvqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:23:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447Ai4aT014471;
	Tue, 7 May 2024 12:23:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7c6an-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 12:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkIfiz6e3S3XL30RXsBAPbsXNG+qsV43wswafGwB0CFUCgzJdDAamUq1wJ5nmDbr177cnraeFpXaurS12iLAa4I7G5HqqXcNcxOSrY8VlItvX3eWE1Nd5D/l24kHo1O/WXuBKNzCiTS+NSWCsy2z/kzpZWYBTwmCXBasNXIjWwHY3Gpx6ZextE7hpPqBpBLBmkfWsN413eFzkeFFjymCUekEsUM4zyu1QrL2BYhDJJVnk4hJw+xMgp8XUw9PHkgLVub94L4ae6esi5bZ2zaIQV0uTsqrwtQzy8WGOYHHiBAsM5IrNOsz6Rzc48aKkFiFZMC3fUXm1OpJQuf/qvEo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/RuZo8ClfnEOtGfaS5SK+5QPVxL9WaWmmsXmyJeVis=;
 b=G3B73DhzYiSjOXSkHhDTFMDgrtG9Nq8AsNOHdI7fHR/nHMyrqzSmMsklXW7JxMP3QDnn2cM0TkyfPyrzGqrjMp1Mo/mSChc77jNN1AObIrC2BqRcc1Gn7CnlH3HfINOVUjRsRFgRpACwBIa2Bhzg62QRmG0Rj9RAuOl7Tx3gKTmzASfIFh/n+TeFYGTrAJt4mtE43loSEyucXe0cJbkqHuCeE6oT/6kHeb0WybMcCWVDAjlh3CU3EK2kt9rfO3vqifKqg3Qb0BOg+bQfsVxuQe6yc7Y2ArS8kvHE3muPctLdCPRGr46tuaWM//bwuFZI2vxP/6FKRKgO1WWRIxGQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/RuZo8ClfnEOtGfaS5SK+5QPVxL9WaWmmsXmyJeVis=;
 b=KU93r35f8kBcBEHokWsCOnCO6bmpcX0kuGXlZQ6YCcbEXZ8kuyQ3z3WX/I8i19aSbAF4ZIUTWnnXikjrZY8Zv8HRq3dai9YyEt/BJu9VteJfAW3F9Y+RKNIvCL6ocpQOtq2bk+foOa4CuasCn41OC5Yuz4KpFgBDvr+a9H779cg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BN0PR10MB5079.namprd10.prod.outlook.com (2603:10b6:408:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 12:22:45 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 12:22:44 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Change functions definitions to support GCC
Date: Tue,  7 May 2024 13:22:20 +0100
Message-Id: <20240507122220.207820-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240507122220.207820-1-cupertino.miranda@oracle.com>
References: <20240507122220.207820-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BN0PR10MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: f205de0c-cd03-48c1-348b-08dc6e906621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7CnRCJfP2vzJSf2OSW7qfdCivHwkVSnEIsS7n6wEpiA2LqEfPAzqmwWlYDqt?=
 =?us-ascii?Q?FFXZzvzGStfVlBHE0wvpaRnISrOcKnBsVI11gi+mnHHC/l+Ly2dwmW+E3E39?=
 =?us-ascii?Q?SQD8QIaskPSu4KXQezKOzfQvz6Gop0RMgw5PcX2Hgjh0C8PBFWIy+lmNGduJ?=
 =?us-ascii?Q?R1NuC4L1y4iR7quO7i+4ZrnljLasuydhtewoJX1zvU3LzHu3QpPNC2X83S9D?=
 =?us-ascii?Q?BNlQYg8tEPY/y8sIkju7dbs3znGCbOsFaV61GC003Sgn5mNWzH2q+rrr/kcb?=
 =?us-ascii?Q?48SDV5XKlAZP/bJoagf7qh359Fw6oLbdDzW8VXFWmPe40ij+L+L4B1ttjZ4x?=
 =?us-ascii?Q?uZHquhVcKbAwoz5N9abgbpadrOaAtRm4BB7bIFZzxiDRT3AGmokm/JCbOhAk?=
 =?us-ascii?Q?/LTTs5XPW6tSf2MbzYnqfIltc8UIxAEe58X9DaFHU/ptlmZN0LLaVITVX2OS?=
 =?us-ascii?Q?0xM1CDsAzt07mX6CiI2Rx+igPZytgq3R3XOAiuiKnb7wvyO/+xdDjfaAdo7+?=
 =?us-ascii?Q?dfyCf6XIpyT0mPzigQqQHUmUNcClcKlkxBxQtSRBtUwGt6L8FBOEY0U1pe+T?=
 =?us-ascii?Q?Ify1wnLL/g80QHFQ5GyJ7R5eN6BM83ONZSlIT/zS/EOa8rgWk/m2VSknCoYN?=
 =?us-ascii?Q?GOGa0ndh0/EdS5ByNbj2Ji0QHsRsk3F6RNoCD6/t6lKCVgROcShtmp5PYAfT?=
 =?us-ascii?Q?7rA763YVGNY0KYmDMA3Kr4veLTNM+SlXr5N+uDXtLvrwoUCpS5v/GlsouWFm?=
 =?us-ascii?Q?aHVsHlln+mxFYmjI1eA8qzIcqHYwLV2DU6gOFFX8aEHNHXdQN89G9zJqknP8?=
 =?us-ascii?Q?N4i0pqzBm1quKgx9tZyBSK/7gj5I+604x6SARBRqrHEmRkbDEuZN/3+v0QXs?=
 =?us-ascii?Q?OY5BdNfBgO7ks7MihaS35aJmLuipCKf2mPyrZUOtM9kv744swtkrsDRLuyJ6?=
 =?us-ascii?Q?AETT7DJLnDEYTWDOaAX9yMR/owqfo7LFTI/kHTsfEQARgdhqir25iULKKXCT?=
 =?us-ascii?Q?P+VtxQvY+YH/7U/GUVKOjD6uD5mDvY+tzwYGT3uXm1x83BhE/Irj2wG4ENva?=
 =?us-ascii?Q?wszLibvds1w2Hl9x+Oz8B0B3VLpax1xobEcBIDPTKbdvZZOPQpY92GaW2hJx?=
 =?us-ascii?Q?n3mGBIa3pAEf1CiCjv+g1yHNjUTFqD7rJRJXPCIQQr94k1RXyu27fgE40czy?=
 =?us-ascii?Q?ZDKbtJc43KWtFxe0x0kBWHvLavP8Fcx9irMbOOGNl/l5DJVkwoj0CGHh23Pt?=
 =?us-ascii?Q?kCAv0Q8rR+eWtG5IANZs+UkzGtm+rHLyIXTGFQTy1A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CZs9MsHMuXYWHLVyCprMBj+obrOOkzO+okGLTq6pS4kLcnbMpyDm5oQ3FMa6?=
 =?us-ascii?Q?CWv+nWhF9AbMLPzVx2GeCYuGtlLYt0j0Lq9KtXwkiVULGupe0unyEzvr0vhF?=
 =?us-ascii?Q?yGN+BzRM7c/0JUMMWIozCKWZ/KiVDW8Tb4VmfBHguDqiRJxoXypf3NUoCTSQ?=
 =?us-ascii?Q?IV8fWEwKlt+CUxGB3fn+V1Y7jCmB7qxWWxxpo3jXXzBRGhkaUGCdmDaq32T0?=
 =?us-ascii?Q?4A0yLy9B5wCQoJp5iQH7eYNwyVAYa/ykYTATFic300jqSgztn1M6OCfz7jhw?=
 =?us-ascii?Q?F7l+Pri8OY8eIfqsBoJJ6LNkXLd32nSVe5A2hR4OEWsDkVOwqHaLx6qIgipb?=
 =?us-ascii?Q?3DywOr44hRt4y98yZl5qdrz/7csYpNYWyomsOsAN8IkHxypISFTd+JprFdcp?=
 =?us-ascii?Q?pGamBpOUDQiRN7NJ15+kget/gE0FiesdAw01916w3ZBcagq77VLnKr+EkwGD?=
 =?us-ascii?Q?z89qpzPq6ysg5wR7RKmJFvkhsLyatQeshD2CR7iqyKr70R8rESd36yiOoYh4?=
 =?us-ascii?Q?09nF6+FJR+etcPHnSe9pLn24t0sXPQuoG3B16HSIApQaEAuJSvmOS5QFGXaW?=
 =?us-ascii?Q?Dzq0qPo7zZPzF3O88Yt1JTRxpNFY+FmGdEejBnNOH99zKN0AotfntGVcBdxb?=
 =?us-ascii?Q?+epc1yseIOxIKWrbhqFRbZkU/vuKwEloQqAM3WPjtQtLPJ1V1guAH4jFFAeL?=
 =?us-ascii?Q?4zRJjawCUssuKNKXNuzzb46RJbP8txIGIo+gunYGIEN9g3JY1pY94NNBFKVc?=
 =?us-ascii?Q?oQ0opEaeBmfpUBLNclA7J2W+0qVyIabS3oa5tJtgGIpBvH37poH+eL6h2IZn?=
 =?us-ascii?Q?U61TbUq5wW2ot8o8cdVAPTefzwx764i1BstzWBQ/ibJ+1C1kGUfnuMhVaI19?=
 =?us-ascii?Q?gLb9zKYpkFAlLlYILrvCrsdNZpGdun61s/63bkEcq5pidVRzPahRtmJQUaWG?=
 =?us-ascii?Q?mUs7m4cqKgWENq6bOryFYRzPQJlxNQDkm1HaGZbvKzKwdp7jOYVFZgcf+nUc?=
 =?us-ascii?Q?frqs0YD2HqyRImNhfqxEUfIus6nfEstohOFhz7g3jo7cg7BLz7qYpGT7VCst?=
 =?us-ascii?Q?Vz35cPg0S6BEBQUR/xyaQDkgy6FIft8eoL/aOt+F+ZNvdEYtGd5uz2d5VaRV?=
 =?us-ascii?Q?HlEcBVEz/UlHYRFFRda4vMzxhGqwIBHgwyfG2HhS2iZm/tCcrnzPb5EyOsC3?=
 =?us-ascii?Q?LKiDRt+49IkgT9759GMmLortLAjEUk6wqMn09n4N2JwTGUIvaTqamic5SzW0?=
 =?us-ascii?Q?vnaMH0rkdyU4xSWmsvBXpl5hJyDqM1L3juobcy2VV1LUu2JQxy68k53Mfu1r?=
 =?us-ascii?Q?+Ur4GuZfZFAoVXqT2olcOypg8VorJ9behdefKY3voLqWelo4z8VpjnRU3hwX?=
 =?us-ascii?Q?pkI/ymg4mYm5d8c1t3acthnqbWaXhlvf6M3dAV9PDTrCKTawmbEa18l/aoio?=
 =?us-ascii?Q?YTbjJoxDlAWMtIrLXbyuitHxVQFJTh1esePmvUpFUQKAxgCGojqJAdERDzyN?=
 =?us-ascii?Q?zxomPLJ8sDLD8Z2oj37SmC0f68yBNjocWeZmKiNfOWb00cA8Xxf7j3j3Mgqn?=
 =?us-ascii?Q?1XjRHzFWQNBilB3Vcrxu1Gpf7eAl5bXn2jJcNiINyJ51tqz9y7ey1iCcMb1A?=
 =?us-ascii?Q?9s1WqDUdQV5oESr2t7FAKP0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HuUspCgOsg0kH3Yr0hMr5/ChtykX9AXDvP7+B7ve7IGQVkPIg9sGsHhuKaCsbNs9Zk+FFDVD9VqIch5nt+QX3qUihQQ3DiVAn0F/Zm3bfDEZSxr06H/CBibyf4wS2ywZ4q8sb+W7Ifiddvty1OMRj5Glurc+dFusJ0ctsxk944T21tpkHYaqE5vsvBDuKFCBq4cFnuwZF4p+7CKQuQyWZfDWIqPhUlQsd0ZK06Q7PYqJWW5zk5nNG1m4Znu6/CH42ahrNh+gR0rxauorVGzxznh6J+ai9cevzlEUra0VG9jJWez0CcIMGLE5VKXrWGUyJqYvqGfs3/CPofK3RAvbGL+WCHXzKzEOjnbf09YGQLt0+N6mjvLXF033XyEhsZbOR7j+QMPNpi03j4bXzNXMBu0Dq9XLRI4AUSmPS473dcCyRCd9kXxUJC6YQ0376g5OhMLNVEPYJ5A6Lk3GglFDec3/J9dTQYnGWcK+StkdRDqQwP7Pf8z9r7npceEIlTf29F9Hw/kDBXi9Z6FdhF/jS4PlT/ttqz7Me6BuF0OJKyEd5UNFbbNK5anBEN+sIoMSM3crPdMlNuAkr4Cyk7d4E4eKQSrRcmwsTCCmf5FKe+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f205de0c-cd03-48c1-348b-08dc6e906621
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 12:22:44.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gVdDLS/CknHDNfskbQPbDHWmLQOhifX8ox6YEGxW7kMNJd+dFSZgbHWbXoL6ESVnBeME9Uqe5Hq8SGPxrWzFdQPWhk4ibADrOBt3F+/Oo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070085
X-Proofpoint-GUID: -u27hGGVYPLXX8QGlseUPA7Vq8QBIzxD
X-Proofpoint-ORIG-GUID: -u27hGGVYPLXX8QGlseUPA7Vq8QBIzxD

The test_xdp_noinline.c contains 2 functions that use more then 5
arguments. This patch collapses the 2 last arguments in an array.
Also in GCC and ipa_sra optimization increases the number of arguments
used in function encap_v4. This pass disables the optimization for that
particular file.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/test_xdp_noinline.c   | 27 ++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index 5c7e4758a0ca..fad94e41cef9 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -318,6 +318,14 @@ bool encap_v6(struct xdp_md *xdp, struct ctl_value *cval,
 	return true;
 }
 
+#ifndef __clang__
+#pragma GCC push_options
+/* GCC optimization collapses functions and increases the number of arguments
+ * beyond the compatible amount supported by BPF.
+ */
+#pragma GCC optimize("-fno-ipa-sra")
+#endif
+
 static __attribute__ ((noinline))
 bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	      struct packet_description *pckt,
@@ -372,6 +380,10 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 	return true;
 }
 
+#ifndef __clang__
+#pragma GCC pop_options
+#endif
+
 static __attribute__ ((noinline))
 int swap_mac_and_send(void *data, void *data_end)
 {
@@ -588,12 +600,13 @@ static void connection_table_lookup(struct real_definition **real,
 __attribute__ ((noinline))
 static int process_l3_headers_v6(struct packet_description *pckt,
 				 __u8 *protocol, __u64 off,
-				 __u16 *pkt_bytes, void *data,
-				 void *data_end)
+				 __u16 *pkt_bytes, void *extra_args[2])
 {
 	struct ipv6hdr *ip6h;
 	__u64 iph_len;
 	int action;
+	void *data = extra_args[0];
+	void *data_end = extra_args[1];
 
 	ip6h = data + off;
 	if (ip6h + 1 > data_end)
@@ -619,11 +632,12 @@ static int process_l3_headers_v6(struct packet_description *pckt,
 __attribute__ ((noinline))
 static int process_l3_headers_v4(struct packet_description *pckt,
 				 __u8 *protocol, __u64 off,
-				 __u16 *pkt_bytes, void *data,
-				 void *data_end)
+				 __u16 *pkt_bytes, void *extra_args[2])
 {
 	struct iphdr *iph;
 	int action;
+	void *data = extra_args[0];
+	void *data_end = extra_args[1];
 
 	iph = data + off;
 	if (iph + 1 > data_end)
@@ -666,13 +680,14 @@ static int process_packet(void *data, __u64 off, void *data_end,
 	__u8 protocol;
 	__u32 vip_num;
 	int action;
+	void *extra_args[2] = { data, data_end };
 
 	if (is_ipv6)
 		action = process_l3_headers_v6(&pckt, &protocol, off,
-					       &pkt_bytes, data, data_end);
+					       &pkt_bytes, extra_args);
 	else
 		action = process_l3_headers_v4(&pckt, &protocol, off,
-					       &pkt_bytes, data, data_end);
+					       &pkt_bytes, extra_args);
 	if (action >= 0)
 		return action;
 	protocol = pckt.flow.proto;
-- 
2.39.2


