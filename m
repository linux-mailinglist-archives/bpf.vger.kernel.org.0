Return-Path: <bpf+bounces-76717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B856ECC40FE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56DB30A7A60
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63FA2C3252;
	Tue, 16 Dec 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NG2ZskgG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ODqygYwR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93918279DC2;
	Tue, 16 Dec 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897212; cv=fail; b=uzwjMrJWnD5LPsLsw39wKcgcMpcwYs7LdWcOzwyf0sYw2Ppe2dXGpmsSxfhSpCjkbFg8d77XX7JCElTnj2HXBydSGv+BOHCCcxtNzs7ofmqk3yBZkte5/yDpyh3ywqs6B2foKXwf5URViSeCBJHNwx22mQ+Fe2GFKpW8JikYsvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897212; c=relaxed/simple;
	bh=3VO1QqvARIm6CVTXfwUcn7JhpJ7YJoYsPbTX7o+zWHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvLKotaaBg7ay85RwDyMh0/lEaNMmCv1U61bXL7P+tHxmQSSb182ZekPcYxDfX+SyV9L4BABXf0hX6ErZTwd6Lq8qOi8HGonQzIMHK0TiFOA10d0NdtsGKbLpWGeEPb6u5ei0CjisX1ePbIBGg7lvTVdGgAOrdNug4apxFyiF/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NG2ZskgG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ODqygYwR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuiCV444124;
	Tue, 16 Dec 2025 14:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zzprXNvP1nQ1zyXnKno9buRN00qQgOqie+SyjJvGPGQ=; b=
	NG2ZskgGqf2OHlFalknprodkgAnirttbkiXMYZuwl7JobNW8WN/KneSOv2cy2Cq4
	6sMBGH3khRZvpJaQht6ue6pGcxBsLtYo3tbIvjpEqiu6ykY0F58MGy/hhobEGmKY
	5UCPr52loANbJkVD/h9j2G5kVC8dMDGI1vrgi3kfBO6EndAn/vsCOE1yNIpi/Spl
	n4C/l8t1wfahSyHZnJsM34WJ7Xf8gb/RoI0098e3pPGQ10FdjArslpd+xbIgqzvn
	clrgL4zVvW0ZMmT/FXR3prazuYvtjniFZzJr+HgZ6d+Ohivr169Qt286LBse3jM1
	Uy3Y6wRXRY9hI6HTATJzEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja42kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 14:58:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGE5eUd025872;
	Tue, 16 Dec 2025 14:58:38 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkajqh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 14:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDNEjP8zjnHSc6deQHhGyl6LTJw6IThuFcH+94vNT+5aqJejOw1s80AeSuKGmr+DaWP8L3XhSuvmo2/BFMdq8RNpAy52e/sa5mw3KJszD68vlwJvIynFQWNF5tPxQ+EIo77ggEMIQJR2M1RRifXAY3eSLcIvyKdh1WyJFnh2QdhrH5Z7v0n9K3TVh/nRYuO8IS2PvL5BQOp17iI9iUsgzcN0vmjhx4SQ/kqYFUoKwEASF1gDKvYSGf4hs9oZBJ912h0nBGxu6BScsbhV4qivcuBVHZGkTFur+sqM9oFd0dgQTEtsAJzYkXTCuHE1YRZy7N/H3Z8m0i+tUky+l+yq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzprXNvP1nQ1zyXnKno9buRN00qQgOqie+SyjJvGPGQ=;
 b=EuQRBqgie3lubNiMsqALmyDpLs2hIZY8fIn1lGQE66wSztB4rBZtPn29LojoV8d5zXTMZ1Hs/KWOfEngUTmu8/F9iFo1RJFmunOZngx7PoLycScHQnQNRdb9AMPdU4JCvlz7gU6VUKFC9zSetZliR9u8cO1PnnyFQepYZc673/uovHLFj8Hn3vNp7QkugFGM3MM4sgt1VoNei2SmIf47lhYCfKJoNEH5+jtAMjaANUUZuKcjylQKjgGWlm9S+hXtSiMwh91qZEyfLYbinEe6Ym7vmEiVbBbff545i2aBoZ63qLKtr31UUY7H+JyErIpBrghz5obFRseL9rXb7HYfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzprXNvP1nQ1zyXnKno9buRN00qQgOqie+SyjJvGPGQ=;
 b=ODqygYwRpgAvkkt368giVRDaAHJ1XDzJ38ZpUbylUQB5g8MlkBBJcDidP24do8AHr/noLJVZuz+iYRVhnj+Lf3XwX3KsBXyP4JMwu/yi9j3gavTXoBzhr5yvOh2vU+Vjp7H85OhFUruvTCFYeyNUL89yyl67yENkJOUCk2XDtT4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB4415.namprd10.prod.outlook.com (2603:10b6:a03:2dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 14:58:35 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 14:58:35 +0000
Message-ID: <67984e4e-c747-4735-87e2-abe8f6865e69@oracle.com>
Date: Tue, 16 Dec 2025 14:58:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com>
 <73e7a9185fa9de89513108a5ec2b545fa344d237.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <73e7a9185fa9de89513108a5ec2b545fa344d237.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8e8474-5623-434c-c865-08de3cb3960c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1hXVHVmZUVnTTlBQXBPUXdqN2I1ZWNGQmx1dC91dWRCL0lrYytHclNDdC94?=
 =?utf-8?B?dCtmcC9IWkI4QVk2RGNuL215cGVmYWxlaG4zQmR6NDZ3c1BZYUdPc3pTb25W?=
 =?utf-8?B?SWhyQTArYkRISnZyWTdnSzZsNzYrYVd3QlJwcUlVOThmamdETk8wWk8xM2Y0?=
 =?utf-8?B?WkhRSnBVc05XVU44aDhGSzIxZlVlZTUvakxHYWxJNlBRd0ZYUTA2Qk1YdGxs?=
 =?utf-8?B?enJPa1pkWXVkb2kxVnI4THlVODdBNHhpZC9zQU5DL2VtUDNWZDA3L1g3R0dE?=
 =?utf-8?B?bllWeXZPYk9XK0RoN3RGdCtUc2NpanFjZCtNam9BSGRVcHo1S0owcCtMNDBG?=
 =?utf-8?B?T01YREsrK3VjRmZTMGtqSW1vMGJJWXZZN0FucXJHbDJxd1hKRVFlY05OVDdC?=
 =?utf-8?B?VTlLc1JyZkQ3MHo0Y1VQZXBKTDY4NjZBSHhaQVNEaTVMU28rZnJXUXFEOHNm?=
 =?utf-8?B?aUVtcWlDM3kydG96Y1BWWmRXS1ZYUzNvV0tuWWZkaVVWNDU3T0FFak5veEdR?=
 =?utf-8?B?eUFSdlQwNjhyQ08rRmoyaUN4UjRJZ1pqYUFUYU53SEY3ekluaHR6VjNyNVNF?=
 =?utf-8?B?OVd6LzEwRE1KcGpIeDBLZEVMTkJXTWNJT3JLUUpnUERtUkxqWTgvOTVCeTBk?=
 =?utf-8?B?TXY2UFVveCs1Z0s0UUVkZmJhZi9KTFFPL3ZseGdhRlVPd2pYUk0xTU8rTm5p?=
 =?utf-8?B?ZjdHMWZua0RRdy9jWUc0b1dXaEx0alVCUmRtTmw5NjZvaTk3VEVCTldRNnEy?=
 =?utf-8?B?WktKYVpMbWNMOHcvNXI4cEF4MXhjc0NoS3M1OCtlN2NzbnE3azZZbldlRzIy?=
 =?utf-8?B?aDhqMUxMSTVQKzNleVN5dGlNd1NSblFtN3pRUm14Z3NwdUV0NStsMkRRNFp4?=
 =?utf-8?B?SSttL2dGYlVDMERxbi9ZY2J3eEJJWW4yVHVIc1YrZEp1K2VTVkNDbDljdGln?=
 =?utf-8?B?b0I5Tk9jRkZZUVZobUEvTTN0b21jVjNhNWFNRFNPbGRyZk00ZXVSV0F2azJT?=
 =?utf-8?B?cCtGeHpFTFpqVTI5Nmt3MFJJSS9WbGhZOVVnUm5paEhuN2I3NWZWbzB3VGo1?=
 =?utf-8?B?UE5kSnhtelZ1WEx4N3FNZjVFUklWOVVjc3c2VEsvWkwyOVZpNzhWbTlPS2VK?=
 =?utf-8?B?NVB6NG5BckhLMDljK0p5bThuYjVRNmZoU1NqOU9qU1RmOUZYNS9vdkxObHYz?=
 =?utf-8?B?ZzdxMlNTaWx3dGlJK0l1WmRNV1BlVlBnbkIrQlhWbUYvdjBKM3N2bmxEWjJF?=
 =?utf-8?B?VnVJTXB6S3RxUlZHdjRiZUxBSzcrejdLM0Ezd2wvbkt0WTUxbmVoa2RYWngv?=
 =?utf-8?B?WVBHTnNzc2J4VHpUeXJnU0huZkd1Y3NKSVowQVFJNHNmaVprN29uUkZrVG1U?=
 =?utf-8?B?NFRwNGdmT3A3V2lsWUJuK3hseUtvWjBDa1QySEYxRUFJb1h1eUozZXlENFB0?=
 =?utf-8?B?WGZhYUlmNHBlblVaS2sydlh4SkwwMXk0STVsTE1McHIxQmtyT3h1bzRiKzB3?=
 =?utf-8?B?TmRaU0NPVi8rN0NmdTIvRFBYWklJT2FrYmkvdW1pYkVkSkZRVW51dnBUVW4w?=
 =?utf-8?B?QUhyKzN6L2p2eUMxTmt2TGFQMXBXY0NIRWRoNHJFSld4L1FacnBsYmtZS3Nv?=
 =?utf-8?B?cWtqTWFVZ1VyNGFGY0pmdHg1R0NzMnFMbUpSbC9Oenk2bWUxZDhpV09CaldJ?=
 =?utf-8?B?bHNKc3VMckxSRTJmNGZUSmliSHdtcW5MVWt3eFFBYmd2Um1sbmcyTW9OcXM5?=
 =?utf-8?B?dDE0UjNFdEJzV0tDcVZiZ3o5bjlNUUpjWkRyZHh5ZU1wb3lOck5QOXRpTjhE?=
 =?utf-8?B?MUxMT3p1byt3Nm1xdVlUMnVPZnAvR2hNRFhvczNvOTZFeW4rd0Y4Z3plYXBk?=
 =?utf-8?B?cGt1NWlvUmM5djdlcVNMUUVYeGNCSDNmUlNEeWkvVmc2dURBVUs4WnA1aTYy?=
 =?utf-8?Q?xOZAs12nFahBORLNW3JPODIbA2O/BtuO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01wOGVWSDUwdVJHWnZicnR6NDIwaDZraVVXTk14dnZZNUZGYk4zM1RpNFRK?=
 =?utf-8?B?WkpobmFSSHRJWkxqa3VqbHFDaHRpLzdLK2JVMjJHQzFFNXQvMEFDbVNVZFEy?=
 =?utf-8?B?Z3JHcm9DZUhnR0NNNEZMNU1yWXh6Nm9VL3k1Y3BzQzhMWHNsamU2aXFaZkp5?=
 =?utf-8?B?aEI5OEUwUmJYUEZOOG82QzA2QUJ6aDQzbURGSjBhMnJONi8xZFFQRDhxLzVJ?=
 =?utf-8?B?eFF5RmMwVDNtblQ1Y045bUJRNEFDclJ2ZFo0cU9tbTZST1R2ZUFSSzhVbmxP?=
 =?utf-8?B?Sm5oSUlUOEZzWkdlTUdTc21FT1B5eFZxYXlRREQ1aFcvYXVzMUpMeDZPVGp1?=
 =?utf-8?B?R081QkRIR3l0bGdHRkZWU0phdkhLQU5rK3JMZVg4NWQvd2lROFlvRHhiNS8y?=
 =?utf-8?B?YUFMSEFSTDZpVzdRdHphWm42MzFES0swTWNjbVlKS0I5cnBVM0gxOC83QU9p?=
 =?utf-8?B?NGN3K00weGhVVEtValF2NWJpUTFsZGk1Q3dJbFlPZmQ3WVAzbWZYUFRYOS9E?=
 =?utf-8?B?d0p6SW8xYWdrK1RKcytqbDBtUXRrOEk5cm80T3VlalIxTm9aQTU5OHR4UHZQ?=
 =?utf-8?B?T2Z0UUVtQkhHSnJVamcwSGFTaXVVQU92b0dEczczSjFsdXk5QlBXWkVObGVB?=
 =?utf-8?B?eEpaNmhzalc4RWkwaSs4ZVVEL2o0aVVwbXh6NHEreHo0NjZvTXI2bmhZMXpQ?=
 =?utf-8?B?RjU4bjBleW1hSFgzUmdRSm9ZTTBqNmZtVkhsYVYyZDF3OWxjYkp2OHRwUXhZ?=
 =?utf-8?B?UDlTOUZOd2ZvVjBuSFRQMVNtUjdZMFVYU1BDZW94bWxVRU1BelVOWVhyN0hk?=
 =?utf-8?B?c2hXVkZrUmFjV0Qxd20vRGtKdFNMUjVmcWpCTllKVjhrT1c0MUVvblNFMFcz?=
 =?utf-8?B?ZGRxRWlXd1JEVUxlaCsvZ0tYUTNJVDZ2OUtFcFBQSjhOdzU5Z2k1Nzc3WDZ0?=
 =?utf-8?B?ZEMxcmpIem1nYyt3WU9nOW1KK0RsR05SUWJld0N5K0ZmazJpZmc1TE5heDdx?=
 =?utf-8?B?elRXQ1JXRG5DcGR5TWRISi80VXU4ek1TVkpnc0hwMUdjWVhoeDVpREZuMlVy?=
 =?utf-8?B?R0dnMTB0dTlKWGtocHFXeUZCY2F2NHZKN0dWakh3SzZONFBYNGo2M0t1SzY1?=
 =?utf-8?B?MGVvZ01lYkZmSUxiVGxvNHZZNXM0Rm5kVEZwc2NDZU1TeTI0NFFjWTJnNjVi?=
 =?utf-8?B?NXRtWWl2aHVmV1lpbk1TYy9DdFVlQ1ZFUmUyd2VmdDBjeTdMY0F6aW1UL2Jr?=
 =?utf-8?B?d1RqS3FUVkdwdHEva2VkSkNSTkdoZWo3ZE8wbXNKcjIwa3ZXUW90a3pLc3Rj?=
 =?utf-8?B?ZDJvMkdHM3k5TmRxMndhUXVEVEdpdlI5REcybHBBODFSaVBDb0tzc3Vmai9a?=
 =?utf-8?B?WnRxMFVreE50WHlTMU9VaFY2ZE04UnlMcVQ5Q1ZuTWxWS29wTGZwbzFIeWk0?=
 =?utf-8?B?UEtaSVZJN0FSSWhubXJKS1U5ckduOGpxQ0d5b05nTEwrbW5ML1NtQnlFaGdL?=
 =?utf-8?B?aTNLK285TkY1OXk3TTIyS0NuWCt0b3k0QldtekltWUhzN0xjQ3piam1Cc1VE?=
 =?utf-8?B?eFd5MmhIcit6M2RFY0duZkY1U0duTjFpMTBCUHhOMFZtaExod3RMMUxrVG5F?=
 =?utf-8?B?RE9tTkhoVzJTTU1INkNqTXVtZzhnTU5ZWnpSZ3JIa3dnaTQ3alJqUEFvdXpC?=
 =?utf-8?B?SFRocjBoY1VVWHBsVUU3a1ZETzh3c2ZBL3JrVWt0RlJab3lGcmJqVnk0RFRv?=
 =?utf-8?B?TUt0b2duc0l3RTRPQ0h4QjJ4SHluUmpWTWRDMGR0dlVETjdpeGROQk1HYlBn?=
 =?utf-8?B?M2ZwQ29ibWZ0bGlQK1ZITG9TdFlvWG1xOGZLWi91U0E0c3F4WHB6d25Zbkti?=
 =?utf-8?B?a0xNRlIyc2JxYnVtbDk4b0JKdU0wdFVyOXV2K1FNNDFvdk9aNFhIVzQ2eER0?=
 =?utf-8?B?K1FGbWswVUZSZjBoNzQ0ZUkySytNUnlFZmhSUE5wUWdaZm5LK3dpUjlveXYv?=
 =?utf-8?B?YnRpaVpqbURVajV1blN1QkZMVzZIMjJCYzFHbnJSdUE3Rkg0N0hQaUtySVZI?=
 =?utf-8?B?RU1UN0VlWm1sZXRNTG9zT0taZHVvd3ZYSEZOUENlbUpqKzU2Y0ZEYWIvWmV4?=
 =?utf-8?B?QUU3ei9sK0RES2gvbnIwd2lkWStvZGNDZ1hpc25PVzBmbTlUdW52MjAzbDVQ?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nT4P8HlegyWlR7eTmCa4M/gZOGSTfml9h4XGfSNsrUAD+eJJoMDITOqn3L1T91s1O+peh+KCM3VWoh8i0oib7HD9EtkNV8qHEv4u1fHlC31YffenpBTM/WcWS/GbAOPhVm0AA6657lRoDcngljY5mC/LF/K7GxI2T3Gg53MT/NcaYz+RYuas1URvx/1DqSK8fv6O0o9NreBJod/2n2DGbxGjdd13CgHT6N4Doq5HgD+jKsUI7jvuoOGX2TL2LDYzV7QgxTaulgWMRTiCqH8l4b2VTOUWTjpMWzvKnagk45+3Z4Lrk6RKIqp2lWhFMzn+RU8D/LRIJvhr9yP+Njt9+8pl8Hj+DBjWcWhwcaPJrJAJbFE6IKvhezYOfqyJrGhEtKnHypBAI1Hu0NjRfaV8WIscq+/3zxy8RvT621ZFKY6ZVbdCMxSqgkZ7Gbsmm3uc6lAon+FLmpthC6PVQPQ6cuUwLj0JZVMoF1DJH9DrDVivIyQUPJj5jvmzjfllGPmQ8P2BiizvDmgLpF3D6dW29A0oIb06FAaRHJS+eHM9rZOjZTTKVHqNJNWlPa15nMVyUV+O3fFeD8JC4z9jTDLZJi4fUdDxwTBkEkGw+GAo4gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8e8474-5623-434c-c865-08de3cb3960c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:58:34.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKRD0p2Q9oQBkIbuwC7tohJsi4k7SXCVwSf+Hym2c25f+xSDYx7L3Bgr1ns+5G58L3ydltFJaJWXaARyVElWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160128
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=6941739f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p49hIUUaA1TGLwAjVLUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEyOCBTYWx0ZWRfX4J68YUkx0q5r
 xez/fmAgK0DnWLFnDi49ReqQMrc5N9TB4PZmU39FV9yublYMaPGisnbUiEax2iamJsrCCEQswdf
 CJa37WUpRquhamYZoHIrKuCF+3G8vU6XkyXnFrW1hpY9o4OtT+oGneX9o9rONC6wX5HhREOwWdf
 uFb3sbsVi/OJr9G436+weA+oF68PZ0ERL522mBYgxOlZBTXkOsJZFNNhgGLSAoh9lrA/XDNNA8U
 h0UmsvHVodecO+Xo0ZfjRjnIWOzDdN01qYHQp9iEQKt9BbWuSv2XynyM/lAA9KR/2s+lPfea3wS
 kiXObBQD1Dmpbj22tF0fVDqeZ2gwxLLuqvyV6h0V1Z9tG7we2mhVU6uNwDdD7s1foDjBbdSeJCe
 yDaXuOdGli6+HuN81VXJuN8XLo1tgw==
X-Proofpoint-ORIG-GUID: JMwSpRU0CUqizqVxWAkt1V83s5fH3gN4
X-Proofpoint-GUID: JMwSpRU0CUqizqVxWAkt1V83s5fH3gN4

On 16/12/2025 06:01, Eduard Zingerman wrote:
> On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> 
> [...]
> 
>> @@ -951,7 +1018,8 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
>>  
>>  static bool btf_is_modifiable(const struct btf *btf)
>>  {
>> -	return (void *)btf->hdr != btf->raw_data;
>> +	/* BTF is modifiable if split into multiple sections */
>> +	return btf->modifiable;
>>  }
> 
> One more thought.
> If some kinds are not known to libbpf, BTF modifications are not safe,
> e.g. endianness swap will fail for non-native endianness and anything
> that depends on btf_field_iter will produce partial results.
> So, maybe forbid conversion to modifiable in such scenarios?
>

Good idea; and ack on the embedded header in struct btf. Thanks!

Alan
 
> [...]


