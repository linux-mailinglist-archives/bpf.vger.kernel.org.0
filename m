Return-Path: <bpf+bounces-28943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529928BEC6E
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0898D289079
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0216DECC;
	Tue,  7 May 2024 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hqWnotWI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ngD8uYJS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744B16D9AF
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109460; cv=fail; b=Zal85qCCvoxGnS6r8JVQ7OerF82o+PeA7/3oShkGthRRVnnKf4ae+GycC9hhkOfXznSrQFsxmLeVPe0BNBs584eVrkqe/rNWQiuihXaIpy/oJRXjIAO3Y7qf1/BBRz+eNdeEyZt9EGeeFAYlSAW0LdZ0cf9FhjhPjAhW6EF0hbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109460; c=relaxed/simple;
	bh=CUoDqcYFM1HLE9TSe2Xx+h2G6cRri/jKnSHSDcYVuNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qiwVXBKdgMmusIh23opBjw9v0MVwZOUDDeCvxA9Yt9GzKzNZBrtQ4Yz+kCcK/ICfB3j/LTOmvFVAo6Dews1v45Cno0NIOtAfuSB5948s5PVCzd9REWY0VbAIz0EeygP2tdnf34cw2T87ItQ9exiqaUnYz1BNo3+CQShFY3Y6NBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hqWnotWI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ngD8uYJS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJsOT005996;
	Tue, 7 May 2024 19:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=d6lPFgYiYWahT4cKvVGT4ClJ2Nbqa9jcOO5ofY/6fxE=;
 b=hqWnotWI7L9WdrgORF6gvmpo78NUA+0URCxgtanZNm6zUi8Vm4XqLsPVfEtUza0XdHts
 VQwwmXyGSK+P3AlvbQVKbQ/yBvF4VkmhKYpVSkGC3h8Vq/LZhJksZ//0M8IciJojuS5k
 M9i69GvIvWwVLVYVf5x9b7Uzlezu1H/NpeXcCia8x/edGkltN3x1RTBgXxLsK7Dh0BC7
 5pUVzr8xVk1BrFM6nDbgARwOQO7h95zde9n+Jwmql84S5FOwTCq0RbQlDGTAgsimriKt
 U9xcqyS7RI5fhwmf2Yel+fFS+uEJ4FxV2MiYjMJ7BBhaizGuSFUcCIbWcPkwlG/jd8OD 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv04cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 19:17:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJCbv024795;
	Tue, 7 May 2024 19:17:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfmad99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 19:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ9vMefd8KozW7Z3xi4pKRWTrRFM6+i/VyRjP09PbjBHLaFWBgPbffaJb0EyrbRwzjOf8x0D67kXizFpQyTUrboNy3iZ3OYvOlFp4bNReuWVn71DY5agtcC239gNNYJshQxDwuIsHBkVsxC2h5tU8ll2EQp2ewEorTT5VpUs1kdaeiT5LRWJTRZm2IxocerzjJKW4dwMayUMCKdFvyUBNuIuRUhEmNs+mKO9Ragb9Ov3U+6wJAb606OzijXhLoi9Qmbq2dhYSnLntDBc8XJsQpgt8C/q3PV3/ud/E++9kwvKE4t38uCBscBM3dNCHUq4ISvGKCCXpPpJCjBESPQhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6lPFgYiYWahT4cKvVGT4ClJ2Nbqa9jcOO5ofY/6fxE=;
 b=NdE7RCQVwaT4l9BTr87+IF/RspzBnEJT92IyyLKJ1kzpu8+j9g5y1FUiwu7X3Ad7SjeR/jhXmMh95nppukm/98oR2G7KCg5XwEMAkHsyq4lFo3aftZOXGZoQKYV8y2zBMWl+fvmUZUASrBTWG7t1rLudA1O50x37jqDtnsfIoRrAToJGA3k9YBo5CoOSRhb2NOS4sztkr9ya1Qko1a+giKYinBoJs7it39llbt0bVqV/zc+1TdSltpEtXlPGeRvF6sDBBfKI4O9tGILYoBo2W+joYuMfafkN4bzvmjigNQPx0smaZQ51jSG1jfx0JrHkKUigtknUtwx6FfgLzcgJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6lPFgYiYWahT4cKvVGT4ClJ2Nbqa9jcOO5ofY/6fxE=;
 b=ngD8uYJShAUktEErQKFSqNGpkBjlIHvdgpmEwB6STT4SNp9o18mhKSuL6ljL1+l2u7G/MjDBOXT/VAOQciOwbE06QKMJ0uSTUDPr0YardgMpe0PkALS151VS+MjDAqTmbqyqP1caM5T+rreDVxj6JoJxaSa9UZ0KVoFoweRNH8k=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 19:17:23 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:17:23 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: avoid UB in usages of the __imm_insn
 macro
In-Reply-To: <e76d3a47-fecf-4d2c-a417-9d1f5935df7a@linux.dev> (Yonghong Song's
	message of "Tue, 7 May 2024 11:54:20 -0700")
References: <20240507133147.24380-1-jose.marchesi@oracle.com>
	<e76d3a47-fecf-4d2c-a417-9d1f5935df7a@linux.dev>
Date: Tue, 07 May 2024 21:17:19 +0200
Message-ID: <874jb9ctz4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: f672ff25-c879-491b-8be3-08dc6eca52c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NSWp113zDuHYKxur3FlE6Cbqnq3Z5h/YZHfEW1iX1WJK7cUvDmBa09lIbAec?=
 =?us-ascii?Q?qOxCAEkQ//yt3NMMWYhTSLNf0aRKhP1/L0BdLsZ3XMO982J7joq+YLodz2eN?=
 =?us-ascii?Q?6/d5dqR58/QjiWkMTUVAglHRvAWfxN2RuYgJU3XGu/jmEYBomus7W9eqZN97?=
 =?us-ascii?Q?M4XPRP6XseL2WK+rPQRcMEyBI6Hsh5GoSmxSk3hO06lkaXp+Sb+ZFNuZ2emv?=
 =?us-ascii?Q?wrPU8R+fzsGePt5OXmClat3vQquuRl9HawD7xucxdL2MFQowCU9IoXAZGzux?=
 =?us-ascii?Q?AoBU331dvH94cvNJ8MLRKfO3Wv1KYHht/uGXL9/FV2Vq106nYWDkKeYpnBKp?=
 =?us-ascii?Q?tVW/apk/a5tNBIQ+wHwj1rRORDYNvG0vK0p9Iat9XogN7dERY7PzFrXaRM+G?=
 =?us-ascii?Q?1e12vrmyiXc2Ki/TBi3EZUgJeGc4od22VinlZx99NNNO9R5h4B2VcHi7cFCK?=
 =?us-ascii?Q?3NIKg/E/IFeHFNjCRUAt8VDEUkHcHxwJb2k2FI2DuKcoJJWL8G0Be0Q5vZRR?=
 =?us-ascii?Q?jsWQOJz6afCAmFA2+fT4F42qUxSxrlsotQzGeNyL8kxWlWO814v0r6LLXT/Q?=
 =?us-ascii?Q?wvULF1E++IiOX3vfD8Btt1r29qn7kVZYktSzg90yuKs/Yz6aBCJn08TntbB3?=
 =?us-ascii?Q?4SqOOKDFz8DSHtyWqfDa3giL+JBY9mFXYZ9kKS90RLNVj/WKYi8a7BCZioYy?=
 =?us-ascii?Q?bRrt6FgE44xlkfACA2pdIxKXoMIAQzVNlwgvo0yInISeTSYqGvMc9PZAM66W?=
 =?us-ascii?Q?yh2vkFRXjbsi8WMbyfYrx9ENT6MhygNSDJT2JgYO1Z4IZ9jaMOGFCPUNAfBV?=
 =?us-ascii?Q?KIOSpeenPX7h9RTZncyoG9nq3ysjnHJeLZajZow7n7eBbKQPUAi9ufzRw+uD?=
 =?us-ascii?Q?KyNWGx9tCjHxJqFACdWbkInOCsmsWhHkWFedphGB3hJNxoYRSusaD+zW2yiO?=
 =?us-ascii?Q?xa3Okscm7+iMzWbfcIU++EOCFxbBIyOf/x+7GURasn6CIAA0CvsP9/dLJXZT?=
 =?us-ascii?Q?U0GEsNfjLFH3V3Eukk8SPxK7dusntW6GGCcAVYU4YVAISKI3kPPnbrEid+AI?=
 =?us-ascii?Q?9oN3/8Wl94WqlV5fpZ2XmlNBxXyUvYnxDGLKYeh7Ghye+lhF0f3p5urHjttV?=
 =?us-ascii?Q?BZBycBYKm4a6ISAIKucyic1/YtULLoyK2TLrjTmlH0LwI1zRTHwm67moUpO6?=
 =?us-ascii?Q?ttpolnnaJVgTJQCBmEcTQtR3yl2prKLaGYfv5BvAo1HU85pBpSUjKFn2DGwx?=
 =?us-ascii?Q?vRRX/JXrlBKgB/fvdmaPML03tkZxA94BMNPn1ZlWxg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lTQZxnyRBFxpvK3/H+i6on1yD9cZ6Qlw6EOveUXfmtedG7LzgUH98vv9mTCz?=
 =?us-ascii?Q?wh6tW6AcaVezl+newBwYwcK/0Qa8a3oL85U4ivxayhbJNMoXr8OJ2X3WLYVp?=
 =?us-ascii?Q?nj0U52SeYpRGYQxthjW4C0csyis0uGdhOi2JknkqLI9jACl5uORhxA0biphE?=
 =?us-ascii?Q?0amzmxYCnBVBRPx/oWU3FrFYATZLUBzakWHQoIdb4Hm33vXRptIu+E1sLbn4?=
 =?us-ascii?Q?dFK1y5QVmwdj7G+FZQN2XHE6QSP3KD1V5hHCLqs4/sOcoNHdTSBziNSqQLZi?=
 =?us-ascii?Q?VMdMUj92O35T6PwY5S7MkzMCWIsfAWbrjwcAV85VqFNHYM0dJFst39G+VoW0?=
 =?us-ascii?Q?1bUErzPWOqlHmFhKbe3UfShPCcfuI7Sak9r9SvtiqbgWLjOe3jDzpciSMnPQ?=
 =?us-ascii?Q?Y48GbGfc/QHnMW4rA74de6IfKiHk2zSTjpcrP8ghRhRjRq85R7MfT3cV2tQw?=
 =?us-ascii?Q?LNvwnbBwbT7FUAu7Lr+jhv9gSeUAbKXdkqz31wJ+vHcgEH4PGWnwAhKM/kGt?=
 =?us-ascii?Q?NLCKs6o9Si/4AtP95zXNpfcH+8OeQLUhuEoBf1Jq5olKDI19ifiBWVFvrFPI?=
 =?us-ascii?Q?6MuNFygFUS3uS+8u9tvx5NP2ADxA9n6aGEMXtX0ENRe2vawZMdTPGPd1Nq0F?=
 =?us-ascii?Q?ycBgDgrw9gNKVR/0ADZYgSzQ3kqp1DSD7JeO51LCOHlhI93pxEwjn910VEGB?=
 =?us-ascii?Q?/mEvPsyU09sS9h81z2AYHRmRS3lX969ScRAVQhWKVTvaJAUpUYNk9nZGGLMI?=
 =?us-ascii?Q?zl31W9pNK5GaqhmJQBCitJCADiwC3hiVnrOJRca8V+qiNVUwQRpKOGoQFy9S?=
 =?us-ascii?Q?JiBr/EwdZYkpPar35OUuiqWfUz2RWbgmRqo9ji1L7kK2n9fD/YQHZsb8M1sW?=
 =?us-ascii?Q?EURFZ+83Eii/BmEqx8vI77nPfL62EWSMeblt/gEEb+h8Cx2mslCZQSedrr+n?=
 =?us-ascii?Q?udYJSi5HTGsIvKx357876t7c8O1S7rqhaabZl8izl0xkQZ8L2xUqdg67l8aS?=
 =?us-ascii?Q?st1UxVVgAPl3AW3bBDZFxnjCY/9Ic/YxLW0RVZR4+oc62Nz3CnARg+BT5/Du?=
 =?us-ascii?Q?MADciEOkMSLKhm+DkJChpYGRmPI4XzcH3PzZFnpAEyPMbn5J92rZ5mCW08c5?=
 =?us-ascii?Q?I+e+AyvkaXhi7WLofF7Ps4pjmcpboPMs3j4PL2DMcF1jus6RfPqlKuUj3jqf?=
 =?us-ascii?Q?sTvm1sOI8TYuZt9i/e07xyhIrneXIa0yphFx0u+9xwF264B2iCZJUhJSih97?=
 =?us-ascii?Q?4mM0kBcb7MZMLxKTU/C8CwawDw6SgEUfIyLxDl3jD/eMfrXs57PlUi5lhybX?=
 =?us-ascii?Q?o2TJRkRFuUbw/QtI4vB29SMrECs5hc5qv9ElBxl4bEo9DS+ytvUL6jWxdQBA?=
 =?us-ascii?Q?1JGKw/GaOpKzTonmyCDUgxMr9pudElgDkuID6IpssJl9jaHQm07Wn2oW2X+O?=
 =?us-ascii?Q?pNBllD70FR1CeF8R3ixhvhhnmaB1qzFwhiRKbBo7kaFvR+9zMiFmBZ4zCUfg?=
 =?us-ascii?Q?+uVyGgNCeZblgLDSX+1Q8t/QEM8iMYa8L4v8LOj6YIlU9Z0RU0y6MwOPe4To?=
 =?us-ascii?Q?MFsphXckqkmF+DiikWGj/lMgUQW4V/FEZ84Ww9NaY+nZpY+d+qemjJTXKVHc?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yx14PAONtgtaUQp+zUw+3hJGvE8dQaLTrmQm6YD0J+h2crdm6gtVVEKTh2scXBuph+6zbD26w5csWasPQSjeVVYgp5gplpT7PrN0jqK27zrVbxSwZQQv5b1SFy7ldzEdz85MgJf1KgPFJ7MkXJVFc4Q1li+DfYQFGA7lxcxbygoUhbYT7rfMX46Cq7YuoqPt5vr+vduxq96BCmlQCrlCpysxBF/vW2o5cyKxLa/ALBskKVfAh64Fhaxmtlg06INcFXmDB+76BcYuXgE6DqsXy19dVLsb56sipqH5u0cSGgvzgwvHochU0qeLPtIDv90sbnLAtl0BbTFZgpwNCQfCV1kxT1vZWM4cb0y+3SWrLkZQheg5Pe7XWQXWqRatrOV7w3mCSEezV1cGBjj+0CBiRZCkJzQNNXP7YrFT2zEvlDmLmJg+GIalwgjga/5KwAGeJ1W+Hhw1UJ/ggFapSjNHMPdoqsaSyZ7P5R4kkRpsRlVfvj8IpNKLOhewOnwb6eNaCmEyr9holqSd7TiuZI3U7iLG9WbVA0zUr2UrZqg1yyjnLwS+VE6iVzt+P16bNVKqUexIP+aQpwyrh0kLEYUVjmfBn6kOZkCJzJub/dACE4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f672ff25-c879-491b-8be3-08dc6eca52c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:17:23.2848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AGjIgrdtbf4UfbuFhmwh7ESp0Psx3c4W/fmI6HGCPOgE8gtHhlbC59KveWcW+EfgJIFQ8rAcFDZUQfafhv/0JEiFaZamjqCsrOu2asrDZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405070135
X-Proofpoint-GUID: 79QnUCD1YCd7Swbtjum7vXhqQxTZ19t8
X-Proofpoint-ORIG-GUID: 79QnUCD1YCd7Swbtjum7vXhqQxTZ19t8


> On 5/7/24 6:31 AM, Jose E. Marchesi wrote:
>> [Differences with V1:
>> - Typo fixed in patch: progs/verifier_ref_tracking.c
>>    was missing -CFLAGS.]
>>
>> The __imm_insn macro is defined in bpf_misc.h as:
>>
>>    #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>>
>> This may lead to type-punning and strict aliasing rules violations in
>> it's typical usage where the address of a struct bpf_insn is passed as
>> expr, like in:
>>
>>    __imm_insn(st_mem,
>>               BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))
>>
>> Where:
>>
>>    #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
>> 	((struct bpf_insn) {					\
>> 		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
>> 		.dst_reg = DST,					\
>> 		.src_reg = 0,					\
>> 		.off   = OFF,					\
>> 		.imm   = IMM })
>>
>> GCC detects this problem (indirectly) by issuing a warning stating
>> that a temporary <Uxxxxxx> is used uninitialized, where the temporary
>> corresponds to the memory read by *(long *).
>>
>> This patch adds -fno-strict-aliasing to the compilation flags of the
>> particular selftests that do type punning via __imm_insn.  This
>> silences the warning and, most importantly, avoids potential
>> optimization problems due to breaking anti-aliasing rules.
>
> For all the modified verifier_* files below, the functions
> are naked inline asm, so there is no optimization risk of breaking
> anti-aliasing rules. Is this right?

I think you are right, in these particular functions, since the result
of the memory read cannot be discarded as the asm uses it.

>
>>
>> Tested in master bpf-next.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index f0c429cf4424..c7507f420d9e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -53,6 +53,21 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
>>   progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>>   progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>>   progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>> +# In the following tests the strict aliasing rules are broken by the
>> +# __imm_insn macro, that do type-punning from `struct bpf_insn' to
>> +# long and then uses the value.  This triggers an "is used
>> +# uninitialized" warning in GCC.  This in theory may also lead to
>> +# broken programs, so it is better to disable strict aliasing than
>> +# inhibiting the warning.
>> +progs/verifier_ref_tracking.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_unpriv.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_cgroup_storage.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_ld_ind.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_map_ret_val.c-CFLAGS := -fno-strict-aliasing
>> +progs/cpumask_failure.c-CFLAGS := -fno-strict-aliasing
>
> All these verifier_* files have __imm_insn, but I didn't see
> __imm_insn usage for cpumask_failure.c. Did I miss anything?
>
> All these verifier_* files are naked inline asm. So it should not
> cause any issues with -fstrict-aliasing. Since there are no
> issues for clang. Maybe just add -fno-strict-aliasing for gcc
> only to silence the warning.

Ok.

I will send a V2 as soon as Cupertino's patch adding support for
-bpf_gcc-CFLAGS gets applied upstream.

Thanks.

>
>> +progs/verifier_spill_fill.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_subprog_precision.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_uninit.c-CFLAGS := -fno-strict-aliasing
>>     ifneq ($(LLVM),)
>>   # Silence some warnings when compiled with clang

