Return-Path: <bpf+bounces-27756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4608B164F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465A11C22C10
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711616E86B;
	Wed, 24 Apr 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsZXQSpS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LtQP5jTn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4229216D9B2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998511; cv=fail; b=WbPMKyW8duT0VckwOxX7XJKz8jWYgW4PNHMzxLCgitFkCCo1bshVtOsdh+SOIPwCVl5YvHGFZ+IjkIXu5Sj+LMMWeEzClE9LbPTpi+2PTMmsmUxp7gtOEtXMy4FRZDc9ozJWI1KeW8BT7AuMnngAXILotPPYiN5hEIuzjrhnxss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998511; c=relaxed/simple;
	bh=DykkNqGP6yjiW2JlPBCYFchsIb99p95j5In8uG2dgDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvA9vHP222EbyIIbr1i1fAjXcqsdmBvG7Q7VKaTMhxMkzyl2y6dfvIACTjRkoWhwEGMTbrsZoKWTmQoq9PB4FYkygc7EGIgtOxKX4scMqsx160w3iqEgFD49JdNgzV4esU5aOo6vV11dYgeC2g4pejmMhjTo7PDWrQFDN8XPvN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GsZXQSpS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LtQP5jTn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OG3hp1018961;
	Wed, 24 Apr 2024 22:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Sj5wDxKFBCHeTAQhDgoEXdxm/YqoSOh5IcmA27gOuGg=;
 b=GsZXQSpS/2CaGUoZGHwE0dUsVky6q7pYtrqMEePauz0pQvuoqAB0LUrT2pgaMT3z7O3a
 UxbP3GRwabDwh9sfZKdcx6EMqY9OQkhksa0FIsQSa9w2A8aDZP0k5c/CAW05IBke2ZJy
 xhjom4M2KxXcMukPeyBv7TIYSgR4YUfDJBBqZjElOAN7ahjpJbPrrsXY4kjwe3ZF8cLr
 TH/0hsepKA8VS3fo0Kvj+jECT8CgBmIzJnQiLlO/K7mFClFEGNxg7BZMI5OqRaHNUVLv
 yDgk/A4FmfrvfspeCGtAO1ARizWVqhgKPx2Jr5tPZuK9Znwwta38VFeQIE2OHAlEGCcL WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f17r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OMUlkm006349;
	Wed, 24 Apr 2024 22:41:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459hg45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pia1T/9izBDUETuZhkuNKsKNYPfZtOc4r0XJwE6OvKOoSdZP8vFNPQO+2FsZZqM++cT0YvetcUVFyXfVHDypSlFjUI1da+SmiNrrLFs7xYu0X0WG836IdEJ1TzOjWRS8iMF8sCr9pt3gWjFV24LjBnCVgMg/4wMpmJcWrWRoqABvofZ9NbLmRDbOUw7g1AMYvjaKml4vchLzKWRC7BtLKnTG6rlKaMt2f3+n6HGrjRDTNj5yq38f/Kezp8oNXeLvbEdfr3EHjJr7HW9+iXNjLu/B90awbZj9mgJTJR2uDzHnL3Z9PRLYUuOl8SBUJYPBD63gVFTc2M3T6dEGxF3pXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj5wDxKFBCHeTAQhDgoEXdxm/YqoSOh5IcmA27gOuGg=;
 b=QHMJYdCoS/4nKGYvwYSvd+LQbNDFWduwCcarTvic2yAxUMCpO3iYohY0O2fCXiVq3Nc7Z05Pdq6o+rfiSqX45j+YTaJUu21Lg1vN5qretB1liwU9YcCbq/t1p6l08EXOr7HSHYOZgjKi8+vVenK6mzKX7KZXCSLeGLzrm2LwTDlPVkf5SoAAqGepdCGUGpaCJgTFGPE76Ko4onb93ei7V495ajuuZd5yjbl5pnDTsbZEg2huosiy3SN0Xca6yl9WnV49YyZyekC5aK8sLy2zAdSpVfj9gEbpILMUmGnBK7cNK1XYdPCNpTKCYmrzzPxps01NDYLvvdtCZ3+jYaI3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj5wDxKFBCHeTAQhDgoEXdxm/YqoSOh5IcmA27gOuGg=;
 b=LtQP5jTn6+Ft7GZxWNcWhMx5d3McfP9L0ugEtGMXP7s5rNobPqtNvcuK8GYXmng8BzkXDR244ps7rMBpAVXfxycztLa2TeDP88sJqD7gDraCY+zB7MpVX7G97Ad4o/iL1vNghXQmL+Id3AMoIi4xxNPCX4SGHL0wZb0NCqWjDdo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:44 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:44 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: MUL range computation tests.
Date: Wed, 24 Apr 2024 23:40:53 +0100
Message-Id: <20240424224053.471771-7-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::33) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2601dd-514a-44e4-80d1-08dc64afb7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JEG9vbgNIm/Bxgv/bbEs+0fmiBtTq/KZmHZzS/8KhHM8fagz7TxoFf01mnRM?=
 =?us-ascii?Q?5tBb47TPehHD0pc4/mh9+y2YfT+sRnX/A0ghUKO0Wi4S3PkR5llwvx6DXXkc?=
 =?us-ascii?Q?nhGCpSfk8q8FqOHCKFKGkUtWhvEb+aQ1jhtgyGdw7J5Du//ePx5L4CYGeVEQ?=
 =?us-ascii?Q?6qJZN0BULkM9Q+knLdvF+5BYONRd2kPGc8OdHhcc/g30VCyVxx7XDDxT7z66?=
 =?us-ascii?Q?wluGWrnQ2mPqxBNJUjdsMjoMftub952rErxt2wb2QX048NxZq7MsCX4808Jl?=
 =?us-ascii?Q?oifJs7BVA7c9dMEKQ+4PoMS6FLq0mYnN7yZSWhiB4c7xryxR7kY613BVi1Ax?=
 =?us-ascii?Q?d1KyGmep8lV0dEqlmcWin7Lqw/zfuQPh5HfghMdCj9/z9MbmofieIaiY/+Af?=
 =?us-ascii?Q?21t6HkARkgO9C30HGneWvVn+2A6biYqXfQddSDHHVp0+VqUm6nOdKH0S44QP?=
 =?us-ascii?Q?I5+cKKwcxU+YNTpyrmk4qdkgw9j7WiR3Wy4XnAS/3ushQJav/hMII+9MHvPG?=
 =?us-ascii?Q?pF6Q1uZoyNEiy9HWpaqAM1xhf2Y2b8WQ8Pu+xTlag5C0qiJ1zKcQTe8Goazk?=
 =?us-ascii?Q?dDxZDLs3pq5xo446xzXCL4wgh3h8bQsGoHlZ6G9zB8jmtAJbAeKj6w32Vmkx?=
 =?us-ascii?Q?03fnJMJje5c4W+cNEFro+uqXjDc+Tq6683s6OmWg0kdPsKLCRXYtAbGVa7QY?=
 =?us-ascii?Q?5KWCmpApcCk5gmqbxk7YJEwtnR5U/YNXDIPh77vjFuXaSs6IKCQRVx48s+Nj?=
 =?us-ascii?Q?DotRYkEzWEghtD/1Si2yUwtb9DnXWcFxyo18QWzo3DhrbTSm2mbhGN92AyUM?=
 =?us-ascii?Q?YRa7PVaRvbztFtf4wQ5qrRjZovGX3VSHfwW49DRA8Fpoiq031UwnClte5w4v?=
 =?us-ascii?Q?s0IKcL9go3/6OQV2e22ICGyBk4aeoCsbHAMtHsMUN3zz4ZFTEygfSOySPaw0?=
 =?us-ascii?Q?GlAmptSe6D/4JLHPyZBx42ltijOYcKrXD2cNLU7Y9vIhRjMKTidsAG6gi6sT?=
 =?us-ascii?Q?xIM1RFAU8O54vnhSWj+2+JtvUhPe6LDlOuYBw66ghoSL2+lGNv7V5QMwO0LX?=
 =?us-ascii?Q?69GkVmZB+7/EkyNUPOSQql1prKXxdKAqq4Bf4lTb8qntgs3LohfliI+1Cm4B?=
 =?us-ascii?Q?fOobwZZ/+VvXCFfpFCNmG4Qbyy3TUWrbxusxZHrxhrVfuRMRfelZIbsrxBio?=
 =?us-ascii?Q?oZO5n74t+suV93dvV8Sdnc919XeEwP1cYQ1ZlPKmSPrBgffcBI/ViMmx0KQA?=
 =?us-ascii?Q?WvwG0bD+3fAy9IWqRqbLQ+Wh6EPfrso7XAcNld92xg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j/eHxQ8aEyt75nalSOsQ3nUCkc30E5MkCrfnT/Meh06YbFUyIkR/T4gmPgUJ?=
 =?us-ascii?Q?SJIXslVPm/Q15PFKBnosEIamVcAM/TLoCKRpSozWt36JVyW9CUITjltOn2tf?=
 =?us-ascii?Q?c7yIiDvhVlZEbhQdSdKO1BA7M1rCXP+sOgJjlJpzcU6i8IVrAQVe3Ce8EQ8f?=
 =?us-ascii?Q?bU6meNjmCYVe0YTXTbEP+CBmeenOL1/E4kTqWuB/wBnRSensLhTCcckoEGM5?=
 =?us-ascii?Q?wKgM9jF12b9rWSLC6lQZIA5HEgVMfiyiTQKAteX5QZmEBRT04GLP2MdRYFPv?=
 =?us-ascii?Q?qhIArODEe56dFY1vDsl7WlDh/kFg2GYviJSDJjV7ocf/z8gP9arH1F/nChDc?=
 =?us-ascii?Q?+5ECw9v3ZG8gy0TVA45YcyZqJQ/oMGT+nWOFiW5RMRgi9CCTk3t5dZRQGGPj?=
 =?us-ascii?Q?fYGx9GSY39zwHs3eRY3uei0v6wAqwkEASZEhpe2FAvhMVGP52qKmA6cPqVsj?=
 =?us-ascii?Q?CDhJXj0XCy4iNkdbaR9Ywsr/TjNeGnhtdgiwKNQ4DzEUxCYMqnsvCe8sDxsx?=
 =?us-ascii?Q?N8FW0sBiLEK7p+SlfNCvy7P1dGgBZUQsWcFRaWJleBCyONzEYvNwisRe3M2l?=
 =?us-ascii?Q?621p+iw2NNWSHm50tlbIVS1siqE8SjwleEh8IIHbpY+K5Bq2jjojh9dT1s/9?=
 =?us-ascii?Q?cfe7isj+F+wYZk6IWBF9TcudaARZly9+MP2zGym7YxNb4bO+Dc8yxbAbd/vi?=
 =?us-ascii?Q?MToB2A3H64s+fTlHZOwhD9bRY7W87RimKkuZhSmFMVqvQYoVT8ee+Vf4sOXR?=
 =?us-ascii?Q?9MJRLD1/PHFW/e/HvRbO1VW+gQm7OSad3wMDbrfY0roCRPZlB1ihPrUlr+Wx?=
 =?us-ascii?Q?Hg2onosi51Ie6FRj0C5zfnNtttBbPL0qBNkiY1H/Zn/Y6K2gbFIH/Xatefi+?=
 =?us-ascii?Q?iFffknrgU/0tWa6UiMnvArDxrc2pF+bPTjC7YnTdl8OWqdtqth3apbVchfgQ?=
 =?us-ascii?Q?f0u7VYXWwBgMaB3Y74R/Qn8YYUAeB0VQOntF4aPoMIZ8lWJ/c4PVSI2SBUiD?=
 =?us-ascii?Q?nYTobRwHGckndT+oHZOBPD78Z3ZNdwvvKVLfI5FJKO+1nShnfmDDWg2SdbWK?=
 =?us-ascii?Q?IstT2F7LRjqSQDd36FeWRs9yjqS51y5HRUDEPIQylZxlPqjvla7AA50MJ7bM?=
 =?us-ascii?Q?hb+ub+CqEQZip793YdYlblyLQTxEDrR2jlWbHk03SfFEDM8Hjh7sQ44GxSUj?=
 =?us-ascii?Q?r8G6bAt7N4XyiSLAjT+NbKG6RGmhnkVbfaVjyUuDhX5V6tQh6k3J/ibnU8ni?=
 =?us-ascii?Q?cjtRpzKDOSry9wif+lIrMPFC9RGL68uTcA6imy0pME2RaSQivuZoPn7pSF8l?=
 =?us-ascii?Q?VrYXjj5XSRA7zwJ6zQNgrbxQpgwmrn7pLvrlx25rW1H5BeG+CSdgHSFifq/U?=
 =?us-ascii?Q?Houe55TipVsRhp3CBYv9rM4cRAKavXyMWVPTfyqD7ZBqIJ1s4PV/W119LUkE?=
 =?us-ascii?Q?7CyrqnL5VpgmMnXk8IpqCvGocYwTgBTVTwW2jNopozGwN1aKJSeeypy/tEmk?=
 =?us-ascii?Q?u9dOQxY8rKKuFaLUpWjTehW6gWsAej7hxAV9tQxVkbxsgxYfErCDCMZ5jBOZ?=
 =?us-ascii?Q?ZEfK2B0OVH688f/MPzCoJBMG/GVFkwViDgcnEFRqSSHkubU/GYeQkJ0oeTgc?=
 =?us-ascii?Q?KG9WnItQOmezflT/g85i0JQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BYw5JljyCoh9s9rRRA3IMAahrHycjNTxueEyOTjV+1GwP0Ts6mEAHmS6+8WmSxxj4vN8x5yK8f/g6H443fcLJ8Sog2E+xPstIiMX6tlAkWV+bjq2o/WoyNwCvmNLPYPci+E6KtDtg2OI3V3psqGLbxukL050QjupdmMKAyTtS8Kpe+vIbLTmImO0FwifGWaTgWEYYB7703bpwOB0yui2Nh12uRBx1mRE7ldSIc02bBySZDLVIeFfmqgGboLRgCc3EvoPwoHmJB8+oKhwZHwIQFLsrlhwlRsumvudjkBRkUVxVBu9BTr3yEcyzYLrazTjWrUmvAvijGXFm3GNJ3AyiAItAS+cgLtyiQIm0XCsPXl2db6eeEhHVLGY80zdVikM4kl7NjmlHpu9d5wcXzu0JzzqTmlRgaJiH7MwK3oAqvm0ap2JiVVU+01ZJ+VEVj0qlldiTQvGRGggGOJVGWpX9GI9n1/720yFar/xIfOdOA1RCB0CeGbDpUEE+wcZBXRHDGkZ0dk+Av0gisJQoybkZBZGL3NGE5lD0vsbvRxSlRaS0Q6a8tCmGY6BDY5hPohKvlA7X4XtY3AnViPY/ZevLWiN1BqMaiNorLk8R3u5vIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2601dd-514a-44e4-80d1-08dc64afb7e1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:44.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dua15s5mO/6ewc6q2fv8xShRkD7WjAp4tEFE5lhFAK2qO7lQ+o5vV9mXTT0pNVqthsRcdFabd/ilM7/FVcTdK8L+IHmf/oDSqZpyWdHGZGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240117
X-Proofpoint-ORIG-GUID: tZKi46qKLCi2fLm5j2tDeU9hbSbpE4gz
X-Proofpoint-GUID: tZKi46qKLCi2fLm5j2tDeU9hbSbpE4gz

Added a test for bound computation in MUL when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index aeb88a9c7a86..8fd7e93b112f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -927,6 +927,27 @@ __naked void non_const_or_src_dst(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const mul regs")
+__success __log_level(2)
+__msg("5: (2f) r0 *= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3825,var_off=(0x0; 0xfff))")
+__naked void non_const_mul_regs(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xff;					\
+	r0 &= 0x0f;					\
+	r0 *= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


