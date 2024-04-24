Return-Path: <bpf+bounces-27731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F38B152C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279731C238C4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDC156C65;
	Wed, 24 Apr 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXfPGaQv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fSHTQwD/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DF13C9DE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993912; cv=fail; b=qrn1OuYhQLGRunw6QhmlfjkEFEOZxBOswmnOcjBSfCyQPou7D3b7aLpT8A/vTFdjbhzhbYPzW7YPGqDa/pGsj5NjnIEeafSt7QoS5JKpjuHbRJGblkeAuiJD0yvgHTYHWNAylWcUJw9fXATRV+0H7knJjgb3bbgk04AT5cEaPAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993912; c=relaxed/simple;
	bh=rgbI3Z5Uj0f/sfes2OJmyt0SIhC8oYH6cBEImvH6sms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=HICJu7htRWUaqGFrh+e/f0rp2id8assaDEqKDkckwhTHPH3LS9HORDdtJg3PP3OcxJfHrYPevChDNnkUy2VbdIdDeZLI0NnS59uxbjTg3krpYSMPP7dciUDADimA5IfqzkxgFG0XfAK8CQIKo6Nlxm35H9Lgbs84/jiCWADdFz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OXfPGaQv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fSHTQwD/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OG8INj020629;
	Wed, 24 Apr 2024 21:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=/+M6CqZXHV/hhaB81LKdJEPqbkBDo3YxkzB7110P3Sw=;
 b=OXfPGaQvuSWLiQEu9iL/55J8QUmiuKJ0VDxtPGiPe/pmJHveSn+Px933Ua8k/Kai47lF
 /Hi87xiPXDynzwYpEOBSEQ5NAf+SsppsaBnwDxcXc9QNmxJWKqmzOxslMN7NjgfGvFxt
 qcmKbzJNmWaDPabkCDRvi5G3zpef0IgW9F2Dri9mz+0VuKsQiLHrCVvNwx6wvNmWz3MA
 FI42C2aY+DsUtyZ2Um5rHxh5mVpPV7GfRxmV0rFybpxn4qgVHcEk8jLXwHd3zItohEhu
 f+XMD0yTYKekc1e5jcmf4zml4sxekAPrvLFprKmxwyyDvSXj8uX+enatTP8TNZAq5pE7 cA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2j01f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 21:25:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OKkOuF025247;
	Wed, 24 Apr 2024 21:25:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fquwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 21:25:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8VvrplNbOHqk4Pb9JC6O4KI8q5x7NJeQD0829CPz4Xxpa87Vmg29WowlyM91lNZFuiC6GmBTee+HampW7eWaS4z6MNMDk6qdM8rjOtuIZFmLMVQfW2egRN1Opo2hw1gTOKTtHWHHCD9f2cxdXCb0JxBu3p7NSIbDO5u9vAbgchZIIPSop5Yrj19Y++uJXVa/wt6Qx+3WIzIUldy+eJi0bZ3Bp/dfrHM/o6IADU7pMyptfOKETmJUQbamOQ6AlIFauwugUrrd/LvZattqGFOzXo/VIn6ZwDkCJFgdam8H7hDAqZB7rqlaQ5z2NWz6JJ7+ckmzilF4/EN+NgWHCnOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+M6CqZXHV/hhaB81LKdJEPqbkBDo3YxkzB7110P3Sw=;
 b=KstzM4PmF+U/gr6uguVdhDdHUZXnQhvIksaM4ipQk3qKFi7FHQ16Dl/bFAnJEeU6KuNcfXj+CsNE1ZcCGRqHlZx8xYoSx44+p/yJi4QgDMQiPvPaMWD0NQFbcv9QPA9fmsUiVcAvJwHXVOeLCSVnEndx8ir8/Nsk2LFWDc41qdjyGlfdUtH7MVYn8KAgl0thFPzsNJ0p5CClr/t5v0O+1f4+NJYO1S1nIN6+qh3MM4QENUTpKV0h6+szWJOVuHiDHuh/OTUkKHhUQfNiJfVPw3F6NoNrxKrL2KAHlwq9wshc3T9BEyKg1p2NFuf3vEUKzgPfZJmNEOJ3bIKugsZCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+M6CqZXHV/hhaB81LKdJEPqbkBDo3YxkzB7110P3Sw=;
 b=fSHTQwD/TlrGatCgXl6zFbzcup4jNXxHyFRXMHuLvtaLPJWYBmOlmXKZ5CuTgFxe9nGmIUbSAwAz1d61aR1Yj6v4uho/EuWs8IXLVZBw/vwL7iR0jgb/SQGd++89BhdIMNIPr+OeOVTh2Yhj5LhNzpbHf3Nc/9tomUFs5U8Gmp0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6965.namprd10.prod.outlook.com (2603:10b6:510:272::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 21:24:59 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 21:24:59 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, indu.bhagat@oracle.com
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
In-Reply-To: <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> (Yonghong Song's
	message of "Wed, 24 Apr 2024 14:05:12 -0700")
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
	<744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev>
Date: Wed, 24 Apr 2024 23:24:54 +0200
Message-ID: <87v8465u8p.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::6) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 57592608-6a91-4235-2476-08dc64a4febc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nv8XV6jo8bOMTDszwdbJMYU1kmrKknPE3RXkB0kSRh4QTSUsEUCwwPgXzM11?=
 =?us-ascii?Q?xKP04sFNnuG04GGmuXb8XiMqSmeW96QzfMuHifGNr78cOVUvnjpbVQ1s5qeW?=
 =?us-ascii?Q?RAZDernE7eBDWj/2UAvzAMaI8zHKYT4oxhGvgcwF6BEQJzHTX0cBzL3n8gTm?=
 =?us-ascii?Q?qQJ/RSkA6nh+Nf89VAcuaOnGcJG6/I/Ic0GzSW4h/89Bckg9joRy0SQjfJMG?=
 =?us-ascii?Q?q8Hq97fvGzjC+Nga5UmKhP72cr6AftPvo3zffQkGhSeqmDPJq5zIAksyEC6B?=
 =?us-ascii?Q?Kqt7OkrNKLtBgjiQFK3g15xYxz0d/hQGOb9pI6Uyry9QvQx2GpRFZw7JdXIG?=
 =?us-ascii?Q?b03iVqN4Tw28JPCgEyc7iup+M5nnkakXacZwrUiwNeF/V0LJlTTTZKZ0vzy1?=
 =?us-ascii?Q?8TEUa9XT4gLq1aN4f/JqLRzQfITOdhXO74a+Bor6PVRqJhbQQLC73AsmAoLA?=
 =?us-ascii?Q?nULNkQkzIYrU/nZ0AEi4MogGMSevHdv2c1jFjuJIkRiFDRCL3nG0z8dkzS2W?=
 =?us-ascii?Q?J544X8H5+CKWMlXjlYJm8eZCC/n6d2JteGfdO1KdRKj587xe2/mAYAR4GBwC?=
 =?us-ascii?Q?m7eHQ/hCOqOKtTEmDyS3exKCG4Wa7LYmrM/cRRhshyNLnU1vXcfHeSycH4Zz?=
 =?us-ascii?Q?mfqTwb0961UY8owlwm8IxQIQxuTEBQsiToFvCAWd9ZZ+0fC/LvYOORbm+VMI?=
 =?us-ascii?Q?nqbtemGgu+Vkjp/5RjXV+LPQOh1UK0XmmQtBldZfzRX++uYGtoVr1bh13LnR?=
 =?us-ascii?Q?JHkK2ehJwrp70IK4J2uZ7ezXynRDlUsJ1PX1N3Z05a9YaQmEbl5jnWE85DUM?=
 =?us-ascii?Q?KGlXxM2pUl6aQ1h3jMya4WrO0NYsmR913IZiyL3UTcnRvdLafnNHSnp76Ped?=
 =?us-ascii?Q?FG9gNnwrkzOkqU2wBduxic7+gqWGATBh09zmPLRlL9MPFh+dDxKdPdWnYqfB?=
 =?us-ascii?Q?MToLBRudAd/AVuQjXkQQ87SxFk66CRsOO5m0Am4puHW90ZlpbxAZL7um4sdr?=
 =?us-ascii?Q?KGbr4cMUZaEP8poiP8td9/b/ib8l64V6MA35MxRlbpOzjmZDjMnUYCenRWKA?=
 =?us-ascii?Q?smS1C+A4+yX0L2eo1SyrzMFDQkuj5BVw3Dmv8dwRWsw0fO+UFQdvOtwiUwFm?=
 =?us-ascii?Q?PRqPf+D5U+TEJtxVu4aCR91p4e8np+H6w7V0x8nrx3XuwLScO5pHdDKvq4Ma?=
 =?us-ascii?Q?UV9hBhhE7ZCF7FGBC+FDIThkvfxwa6LdP6NZcxX+Xq0VgErziuOWToBixFzu?=
 =?us-ascii?Q?zLwejtaK1Ga7f5ueh7zkJ9vM81xnyMgKjrDEd4jWSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4NxHnG5zn0ig+KhZxhNXNQhN9CkmBUQu5GG2h9T46j+vQAujcajRu1Eib0c6?=
 =?us-ascii?Q?R0iXXCDTm62WpNUGoWC9txnnFMcB5hZ6FLf48E9fEip0Et2Yd8gT0Xhq41QO?=
 =?us-ascii?Q?zWPvDVCwrjoi/fgyp/XVvN2/ckO71bKGobiw88/J1JwBz6v6mW4mSYUAty/j?=
 =?us-ascii?Q?79aWOWuMfnvK7dMIKVSZhxnNXUR6VbSvWHlk2OwP7Oiw8GDyhT32tSVAua6L?=
 =?us-ascii?Q?ASoiwMYeSf67Rwz+w+JYv+C3AjH6jF850cwdCVT+4uJYC1LAWy8uzwNV7bcn?=
 =?us-ascii?Q?J3dssBPXk/aObS7QOJMlsQ1lpf559dFMbNKdjB1PrsP6lb3THVz4YbG60HEI?=
 =?us-ascii?Q?ihQXFnvQv1wf3DL3ZUbPNc8eQPROZ0KqmdmQanwL2GxeLNSCTORY/q6PoXYD?=
 =?us-ascii?Q?9guMIKkLjLXTS1DyofL61kzvJpsCVYo1z+b6FNNj16XljddJ8PZdwPLlXQ9J?=
 =?us-ascii?Q?2wuP6oS8KMHINtpdPX3oZi4yUxQmhbrGomzJfKK2zvpXnHFhi0fKKs0hdinr?=
 =?us-ascii?Q?Ok6cjHVPDslQD+5dAjDQBkfTILyxEBuDtzW8pi1v+pQL/ccJ4+hpfwWkwZMS?=
 =?us-ascii?Q?pS4AcoCYqLN19bXalX8+lvXBLFUAQueeHPLVLiwlzuuzB2sqTNUac7+TG3jg?=
 =?us-ascii?Q?gaOb8VPlkEWWVWfhJJCl1eHh5bi3oh8LC2BY0Txn5O4MvylHxa+cV+Gxmj5B?=
 =?us-ascii?Q?+VPA6nFv+TZy8VIv7KAbJEnvCs0/FhmJGgbZAVb7BzzP9AdG6M4eQteSF7uU?=
 =?us-ascii?Q?9WSklV/1IkKZk6smYScCESXhMn4MDITXU+x7osJQ/lueKk4KFzWikZn0uma/?=
 =?us-ascii?Q?99a5RHL6VWIcL/TSSMp/e5lnLEEQ29LZd3PJIlAyMqeKyTYNjzNV23M9RkVJ?=
 =?us-ascii?Q?+Hlw8ItpxNamWGigtU2Gqk738aYN/7cuQbBXC2E36xYqO8wDu47x+ukqA6HS?=
 =?us-ascii?Q?Uqh3xbtdrruptQ8XMyUiRM+pLdiwItK30DtghBNtHf+49uYXzhkfTXz23f8j?=
 =?us-ascii?Q?DK7p/y/TCzbk5IsHNcUChrH8bwyBPKnu6+7uXmaaYCe+q93BCtfnECFhVw+S?=
 =?us-ascii?Q?+jbEYCsAvIeKB9DITMXImR52n/m3CMYjUl1ctIgRIB35XvkTCFi8MM+XUo1w?=
 =?us-ascii?Q?WtVjX43mNAEsXvzqhw/FIalX6yVlD/rcsZnnEJv/h95sTwTScufpjECSIwIu?=
 =?us-ascii?Q?FBjcd02pd7gGmVW4QpQs0xj/33KR8wSNZdV+6PfYfaXRTtrf69QIaYBHSL2/?=
 =?us-ascii?Q?aN1cslmMKF3O9sWok9cRMBn3cLTqTrKIgX3GKndgjs+Ptt2XmIbLV6ivpnZw?=
 =?us-ascii?Q?lfL/ZbhQuOjrzuuLQFVIVyBny8UrbFsHkGjsru8D8IO8FmxLRsbOdRMkIDBM?=
 =?us-ascii?Q?tp18v6cOd06thlEqkOv7FulyMcjdFkNltgiLNUkaXz6m/emWYGTMXcadBG8+?=
 =?us-ascii?Q?/4Co37IgA8IukqqGWteX8Cg2fLSv9SJh0A7VEjSGIja6d68G1tmi4FWw6Fne?=
 =?us-ascii?Q?FDaEjjR4eaESbpVZFv2nNAzH+D8gdQ1rloK0Qytjigaoq9j+r0bmN8Bq6/4v?=
 =?us-ascii?Q?W9X86ml7+oPevXu/5MLSRSewDkuf1/3U75OZGgCdG9BDKkcmV54Vx9v9PCFQ?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZKrLP4YU80+M+SyUFL8JZCJtVZWSWle3P72UVmZmlHf8C7pE6UHenguuYH9J6KSrdbGCxCxm32GSb4Nmh9uyhjIobFvxtF15KeyciaCDeWm21MpHYSUsxPdh97rPuc1mrGsoPgWKF2b2i2y8d6iVXGkQfuFOVJ3JBpsZ/MhCh6TPNcoPJi+vDXP9oOnq27YwTrXc7DzgWrpGOwKZNH72LbLqTAt0yHa7obQlXy7lzCEDZhzPDRmngYu99OrNAfeuWE0lzyvU48wJmU+oZbhLOWGwUYAd2Ri/z2zgm0OkaTXirmPu8+J/a27NqGmQRZKZlw4BHqAfCH6cm5nt0kL+a9o/kqJA98/g5Yu+7oW/gd+YOpm4lITOiOQwV9F650C9yUT6hQ2RZqrLkSJqNgFovEuq1Jk2l5ZMrH25OQP2mqUr+ySz23Y+tHIFzggXW6xx4VkTHsNK/2YccYTJ4Xjob3sPPCcO7NqiV4/3ajmQT6aPMhI35OwI/5LDrKd5ZGQ/+57zLKHOX5FO8lrCnRJlP6Cl78nm+JAKm5zSc+cfXIoP+em7yD+Gh2A2UwHZnqXr9JqWwn4RJ2a/Xn3F8mEU1QJ8CLuBHwxWbb5UOAxHyLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57592608-6a91-4235-2476-08dc64a4febc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 21:24:59.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djzfyzmLy47Ab/7o0hso+z3cpP1/+qp/py+xL17+akCMuPp0NoajMO2KeNRpbmoY115P7u9+sznWlYfwC8bBRzIgEgPPiSbVe/SplQyxjVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_18,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240109
X-Proofpoint-GUID: 3TtdK4fYWGShgvlSL1PWeTrQpbsVXwv3
X-Proofpoint-ORIG-GUID: 3TtdK4fYWGShgvlSL1PWeTrQpbsVXwv3


Hi Yonghong.

> On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
>> This little patch modifies selftests/bpf/Makefile so it passes the
>> following extra options when invoking gcc-bpf:
>>
>>   -gbtf
>>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>
> Could we do if '-g' is specified, for bpf program,
> btf will be automatically generated?

Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
-gdwarf.  DWARF can always be generated by using -gdwarf.

Faust, Indu, WDYT?

>>
>>   -mco-re
>>     This tells GCC to generate CO-RE relocations in .BTF.ext.
>
> Can we make this default? That is, remove -mco-re option. I
> can imagine for any serious bpf program, co-re is a must.

CO-RE depends on BTF.  So I understand the above as making -mco-re the
default if BTF is generated, i.e. if -gbtf (or -g with the modification
above) are specified.  Isn't that what clang does?  Am I interpreting
correctly?

>>
>>   -masm=pseudoc
>>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
>
> Can we make it the other way round such that -masm=pseudoc is
> the default? You can have an option e.g., -masm=non-pseudoc,
> for the other format?

We could add a configure-time build option:

  --with-bpf-default-asm-syntax={pseudoc,normal}

so that GCC can be built to use whatever selected syntax as default.
Distros and people can then decide what to do.

>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index edc73f8f5aef..702428021132 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -442,7 +442,7 @@ endef
>>   # Build BPF object using GCC
>>   define GCC_BPF_BUILD_RULE
>>   	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
>> -	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
>> +	$(Q)$(BPF_GCC) $3 -O2 -gbtf -mco-re -masm=pseudoc -c $1 -o $2
>>   endef
>>     SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c

