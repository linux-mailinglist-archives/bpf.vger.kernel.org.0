Return-Path: <bpf+bounces-73064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F25C21C51
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68B9188FDDF
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D336838E;
	Thu, 30 Oct 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQ0KfjtI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4P5MPvs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA95366FD4;
	Thu, 30 Oct 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848810; cv=fail; b=NaCUHscI6EW0YJ9UuJO88ClgiKexnJwvOE5LQHuV64364f1cLVXscBWopOWI0xJ+0l1zVW4U73RBo3X/C2SBmQaTl5qEVYZsVLe2mxVMZVvyyQanbUdK+IAsbiNXtp2uoOb+CLbe5G9Ssfv7ho+hDe1PlMY1NgGwOf+af28ySE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848810; c=relaxed/simple;
	bh=yg/6ycAd86UkPJzvJR5zHgjy6lwLhq6t08kCstIk/y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9bZRouWh29Fc3UvSbYtm9NETKREzh72zwmLBytVw5W0MEmp2yoI2faNiWyZbBmBBVDVbggD4VF80jPxnJB0ETbbLwaPhlf8XE1dKOUNkPfthyIA5nCsWzhRgVJED9kMJ3IQgMjtSWvijptb3jovtrw5c9VKUDcyH8u/Vumo7Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQ0KfjtI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4P5MPvs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UHxnau001023;
	Thu, 30 Oct 2025 18:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ViWZUum7uPoaTcqY5MhRqyvQUy7I2RUkzcFZoaqKesE=; b=
	HQ0KfjtIUr8sGoLNx4sinYXdR+PE+NOIFC83OIASigaZnFnEw43Do7SQYvI8wyZX
	DsxPFiXRp90IWN/VS833hFRU5WDZIiRLFInymtpEJfQffonKkT+HgPwm2OcY1Hif
	QuwhkazfQiM2e1tdNrRUhCeKNvTBzUUjhlQYKuZGRW0ZWEwuRIjCnCSlTGQUQl/h
	1yB0igM1qGwB5FCLMXbo/wrcD9bEauaql1CJaRWmVUz7ofAMfCyeNteLSU2DA5q0
	c3AWXAjz7Viga4CKhtmqsiTcalenraTY9iwT+aQjalBfFTCYvos2qfk3v5EVlim4
	cg6XSX5JxxT/USwqrQDIsQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4cwc825a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 18:26:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIEuMv007889;
	Thu, 30 Oct 2025 18:26:32 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359vp25c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 18:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI0If4a647GdSk5WvZYRaBtijZox7+Zq50DcpSVOXtZevqvUKV8PUK2x2PSKkOXKGt8N131LpbERZFpHfeWCsNS2Uby2J7tm/UpDl20JuAx89NM/AGn+uZHyXm8rtMlet4vO6RyuBmawmjGAmpXzzvzqmx/0tq68+W20YOwMTpHKHPooV6mEKuRFbI4uCq2d1MKz+oIzR2/NTC+4fAPUdVYSmJ0MhUqTxeWJQsQLAB9J4IporyOMARHr3d6sWasQKl82t/opEe+AfYyw32Z6+N5TjmjZdNpGe9QGE2WVfSsj5fyXaewa+ids9hjXsYjBEaNmhuwCqzDRbzEU/1Pllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViWZUum7uPoaTcqY5MhRqyvQUy7I2RUkzcFZoaqKesE=;
 b=BfOrDbXpMaWCQxNQa9Sriwsc00pANQ0jXIjCJTPnltgY/xdvG/xAm7KllC4Y7QF2LpDpnAfrQhKvc3N0JyddBZH6RdjxJhf3RvS6vS04qq0SBjdcN7FU2yvmUrGvLW2QfM0IYnKK76ZbAzQ+6yHbxx2NoQpoNL4AxNo99COI4UzNpohIG8tMfuVOoHHX0M/El5fhjlDnvb3Fk2U/cMHkmzvoOwL/chSoNhp0/EzlE4NNSE4+yNTISfI64fwlODHf2bD2SG/JSE+hAaR51RonfMqKusqED9IsKXYvu0Ny2hRwF0cycv63kmTqD4eR0OTIU3YI/BSdXVFcde77pJxW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViWZUum7uPoaTcqY5MhRqyvQUy7I2RUkzcFZoaqKesE=;
 b=c4P5MPvsnyobwyDZdxc4wSOoF1ImyfSPPBYsH/66Dg6Ha8bIZEwxq/xDW6p6Oc44qsGepymSL8r95/OWairZwf7c6iC15VCAMdM0AoCztAqwFtdCLtgsOtB/x/FzNWrXZ6Oa9LsT1O8wAnvzrzzMulglfxR+1ffJZYzKmsoSEP8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 18:26:28 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 18:26:27 +0000
Message-ID: <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
Date: Thu, 30 Oct 2025 18:26:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Eduard Zingerman <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
        andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, acme@kernel.org, tj@kernel.org,
        kernel-team@meta.com
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::6) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8d5afc-f26c-488c-1ccb-08de17e1d705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFFjVHRFZm5zMlV3Uml6VTJBYzhZbXhVZkJVSld1ZVQ4VC80akJWZXFDWmlq?=
 =?utf-8?B?TndXOUFXanl4RHhBd3Y5S3g4d3NHUUkrUVhHMEZObU8zZXpJQ245Q1JFQnow?=
 =?utf-8?B?WjFJTGdoVzhzRmFuc1AvZjZTQkVUck41TDRPcDdyTjhwRnV4WG5kVDJ2THZG?=
 =?utf-8?B?bzR3c3A1RjBZQ3FvenFFdXlwVWtqOS9teUxvQngvOUkySW1LcXRmTFlmblhQ?=
 =?utf-8?B?b2F6L1RMaDQyZU10eGN4Z3pJc2RXM3VoZCs0emVnckxBTTdXUXBGN2lJM1hv?=
 =?utf-8?B?NU9qcmlXb1VSSnNSdDNqTHZERjI5WGgrNkNVZGhVanJiOG8wSkNrb0dVcnU5?=
 =?utf-8?B?eCsrMGN6ekMweVF1a1p3SFFXZTF6YXhtNm1OdzVoeEFUR1ZDSkZSUVZXSmlx?=
 =?utf-8?B?MVI2RTlsKzRwamdoNlNCdkhrQ21OcUhYdnBZU2wxVTNhaG9NRnhmcWVOeVRl?=
 =?utf-8?B?aVhadEM2OGl1ZGI1T0tSK1Z0alprOHhYWDBvSTFMeWJxdkVwR2ZtMmJwSmRW?=
 =?utf-8?B?UnNMU3l1U2oyWmltaG40RnAvNDRoUGJzeC8wRWRMUW9UOWxRUjZUSWZyNktl?=
 =?utf-8?B?SzRucGJRd1V6S3pxY0FiTnFtQ1lWRlBuYUVwOHlqK0tnUUUyNW1UdE4yazBk?=
 =?utf-8?B?VzlnQ2pPOVBROENNRkJPdjVrRnJ0RXlONkE3WTJITVB3dnFLbUhIamgxTjVz?=
 =?utf-8?B?OXdRU0c0aDY0YWFIRWFDN2IrR1RYNGFhTXMzekZxYlFBc2pSKzAxVWpCcGxv?=
 =?utf-8?B?ZW9SRUl6OWNjRlBrYjlJUlZadDBMcWt5dTluSXZKQ0xrWXpZeEFCUXJFejZ3?=
 =?utf-8?B?ekprcUJGVXJzdkFxV05ONTFLOUZMemVNbEZMeXNqM3QySXNQVGs3UjR3SDFl?=
 =?utf-8?B?SXRtRVgxNzJETGxyMXJpVUsxQlZwUzB4MWpxNjJxM3RiaVp4S0pWS2twT29Y?=
 =?utf-8?B?ME00UUNjY3FYd0J2NWJXdXVCdmtpeVpvYmhzY3VnZWtEa2ViUXVwOTBscCsr?=
 =?utf-8?B?dCtuWnN1bFBET05HN2dnNUpkVFAxNmJMUm9RUEJ3UkloOHhPd2VpQldabVJr?=
 =?utf-8?B?WTlCTTRubjdZK0NOQ05kM2FIbnovRjhETDEyVFRjUUU0RDRHdTdINHFKZS8y?=
 =?utf-8?B?V0VVU1B4akx3bVFFajN0bldRcWN1ekpPVTNPS010ODlkUmJMQ05HeEYyQ0lL?=
 =?utf-8?B?RE0xTGNRWmtqeEFjcm1zNnZBODFUSXFqNzlOc1FHcmphb1dIdlM4M0E2Rjgx?=
 =?utf-8?B?NU1tdkRSRjg5VEV2ODB2TVdnUVYrb2Z5RzcyTG9NdmtkbTNEUjhodlZqaXVx?=
 =?utf-8?B?Tzk2dVJBVXBtYmRRT0dNc045V2wwbk51U0VjdXFnVmJBckxqc0lKTzlPTzg1?=
 =?utf-8?B?Wk03UURxQllHQk1pOTl1bTQ5U1E2akswTVYrOENLTjBXRnlya2RkdVY0RWQ1?=
 =?utf-8?B?VzVpVitwelFTc3V3QzZhUHhqZHFpMGFpVk8yM2FtUTVLOFQ5cld2UG50TnFj?=
 =?utf-8?B?N1ZhK3JPR1F3dEtpQU4rc1pLNUkrWUFBc2FOT25BUzNScFFrT3hadStzVXJV?=
 =?utf-8?B?VUs2aGtsMXlMMENreEFnc21mbnoxVWp6U1crb3JhSWdZYnV4elVjZ1BrTFE1?=
 =?utf-8?B?eDFFZDhDWDlsOWwwVHY1NVA5OGpwL0tsdUJoQW1tanVYN2NiVWZjdVUyYkhV?=
 =?utf-8?B?NlowNTZPVjJTZTF3VjBrcnZ3N0dTTXF0L0l0emxCUDNxcmlCckdlRi9hVXB3?=
 =?utf-8?B?ZG1xMWJkeUpGcCtZZWtITGhRMWNjUVB5OTZlOFR1Q2xpZGRaTDI4Z2FnS01P?=
 =?utf-8?B?ZXhiNWhmMGZRMDFxdHRQZHRjcjlTMGJYV3ZVcFBvZjVoaXdReURlRGc4MUJy?=
 =?utf-8?B?SW94ZEoxcjBPTjNmTUgvaHdmTlQyaXFKVC9CSGdwTWNUQ1pMTU9Vak0rMkNx?=
 =?utf-8?Q?Gt6czs2DQD5s7aWfJSeDRasbnEAwlIba?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dmQ3R4Z1dQM05hR3RKcnNFaVNVVmI1UVV4OUdBS3hrVDVoZlZMdis5K2NR?=
 =?utf-8?B?RG03QTdEcXFDWVZwc1B6K0d1akJjbUtvcTlNbkozT2g1S3paWVhnV2ZVVzNK?=
 =?utf-8?B?WVNSR0ZuVVQ0N2dVcks0RHVqNS9ReHdoUW9qTEd0Y0Z2b3hreFhUbUd4b2xh?=
 =?utf-8?B?MUNFWFFDTWR4YVZUbUFrb0c4aXlQUVc3ZE1aRXBiMmNJdUQ3eXlsYm9QWVFS?=
 =?utf-8?B?MWg4UDNOMXBHZ05lME5ra01mNC80N3FkZmlLUDYyM0c4UzFNc2QvSUh5UVJa?=
 =?utf-8?B?dkhRNVhYSG0yWEN4N1NXWUR2K0VkT3M3cnhZZTV5N0piRVZQTEFJQVZaYWVn?=
 =?utf-8?B?c2RHVHJJVlg0UjJ4ZnR5NjJ6R3B2b1hVdGk1TkhSblIwZDZON01MOXhFTHlW?=
 =?utf-8?B?TWlnUmgxZTJpdzhOMDJaZmVDS2dhcGdUVFdEWVpSdVVMWC91djJIN2gzM2xQ?=
 =?utf-8?B?TlNzaU5iRE9vMzZxc1FmT1B0NVdXTG5ZdXNaRU5yc1hoU1FYTVNBVUpLdFlR?=
 =?utf-8?B?SzU0SzFnNDcwYlRpUDg5eDZUYUVRMWpTeHNMSVpYSmJsWHN0YVdKaHdDelIw?=
 =?utf-8?B?WmFtSHJ1aENzd2VmcnVSb1VoM2NrV1ZGTWZyd0pUL2lWelBkeUk0T1RjekNO?=
 =?utf-8?B?NWpzbnhsRElhcm80QnYxWVh3WTlPYjAzZVJ6YWg3dWpMUjBQeVhnOUl5b3N3?=
 =?utf-8?B?cHI4dm4zbGorbDBJb3dpbUZDN0lXTkhMSHBTSWlFU2xKNVF2bXptTnkvTkY1?=
 =?utf-8?B?YVQ0ODhwdXZlNG43VHNQck1Hd1dPU0pDVUZ0am5IK0JleEdBdHM1TCtwTmJv?=
 =?utf-8?B?OEMrUUtuNm1TaEZGaU5KWXVYRVZ0TXNRb0thREY3ZmhtVnJoaHVpM29SRVJY?=
 =?utf-8?B?dDdCcERjMDJZcmRMUUZ0UDdYaUdudVRTMy9KVGtVQ1FKTjg1ckVhSHJqOGR3?=
 =?utf-8?B?T1N6S2tuTFAwMGM5UmtqNEdMZkRBSXJ6YmJGTVREQzZMbE5uUVFCZUVMOWli?=
 =?utf-8?B?d043UGw0QVdNRlgyOUgyVXdDZ1pONUxEN3c2cjRrMVZSU0NWWm4vTnAyOHV6?=
 =?utf-8?B?NFlLSklyOHhnZU1oZTczSjQvRi90czdWNURzdHdSdlMrVU5vbWZGWVZWa1Vt?=
 =?utf-8?B?UElQMjc2Q0UyYm0vSVVQalh5d3dXN21XN2I4dU5ScFRGMmh2NFJ6UkozVXVO?=
 =?utf-8?B?VSszakw0SjJ1RVVJTEVwZWNEV1VCU0Fla2QyYVNMUDMwNm5ab21UNnF4R1g0?=
 =?utf-8?B?cU9MVHlXVER2bkdBay94bGJKYzNVcFdFcURONnU2Zk1laDNHbUdqNXQ4b3pF?=
 =?utf-8?B?c00vVWIrYkxjb2VMUUM1eUNtVkR0THFOd09uNVhsdS83Qzk1WmNuNEQrN3cz?=
 =?utf-8?B?NHFDSWJlNjZSQ0cybStZWE1JamYrUkdvclNpdGo5QTFvMTZtU1BJUUYzUzZE?=
 =?utf-8?B?aTZ5aDF2M3EwZ2h3ajNrQWU5aVJSd3JJeVM3UkZRM2hwajNGdzluVkI1SE9S?=
 =?utf-8?B?OGNnQmZTSFp0S0tjQlNvL2dUaWlCZmR5bDhWblgvc2RpZ3JKTE54dXpWcUFI?=
 =?utf-8?B?akZ4S280KzcyMFRuN2xZVERuTEJvTVB6RlZLUzlmajY5OTU2RjYweWhxd24y?=
 =?utf-8?B?TDJWSlppVG1hMWdvdWhDcVIreG9hMW5INTJZUytYRjlncm4zTmxEOU9hTVdn?=
 =?utf-8?B?K2xiUlQzSDZQNVdzYURuSUovRWp3Vk5xQk9tb3BhT2NzNHVGVmEreWtadnVq?=
 =?utf-8?B?UmsrWTdtQ0RjSk9GZ1hMTER6TmF2dCtxM0RLTkJRUllhTW4vOE50ejdUYkJV?=
 =?utf-8?B?a2l2NVR4Y3NiakY2RlFoYytKUFlRLzJQQTBkWHQzdCtRa1dBeVVGT3NQek41?=
 =?utf-8?B?M2pKYkY2OGZ2TEdhcFhveUxkMk5TSnUvYXdoMG5qclVKTXZ5WHRCbk45NFFQ?=
 =?utf-8?B?bWZRS1RkTFFPWXh1MmIxaDlHNlBuOU83QkZpRFR5WnhlWGtVS1lybUlyMHB1?=
 =?utf-8?B?N2FvblJxSHhKWXVDNnZRU2ZhMnQwTWlRdEt2Z0NtTnV4K0N0T0lZSFRQV2hE?=
 =?utf-8?B?VlhzYmR5ZUJqSFFrQkcwV0ZlVmtXTkdxWktGT3ZzQVNTWjhmdFRkQW9oUUpt?=
 =?utf-8?B?eWtxQzB4ODJuVlJQNWVWUkZMYUdsT1V4UkdFTDFEcUpzaXVsTXNMOGRaV1Nj?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BKN8VtMlp213QLtg31Jkgiu8PDODjOjP/08XCDfeRHLeRLDe4lpV23ty6ZE8X/hVB63yC/nO8HNLpZ+bzNpg6e7msh9PbKxfIVwVafh9Rfk2kJ6uoGWwJOMmg5B+VCBavqI38W/COPljQbMsnGUP+V4G/XRraYyJZBO9gOhGWuzRAiThp8lxiV3U8YT6zBByFf3+PSIK5An5dnQJ9pFg25tw32eNPPLWop2l5YTqAu6f6x4hDIxmCvHpUNnVvYg6kvoOgnTY3jJ7GPewLfB5d2Aj7HrTIvJF80nUl7K2jdfWY1ZG0veB4tbDIM7E524okXELC5J7lrXZds7IrDm2weZWvzi8Nl1NAX1ZzqqxcjVwAN98Cypp/CLCGEcT0XBjneY+HHVlZTMUzCsA+8jCGEyQqBTcBlPeiLfKM8GGZAwd6DTk7keu+oQextfzMCw3Q1EOH2xvBuvVLxv9J0VEkYdNIeKF+8RGNXB2QXEVYvFpNLkcTpKYgWWzKe6670ReC4TOWbfwBn6fzeIYFgOlAQO3k+NpK27KbR1Mum5eh+CSqEH1dEkA9XLilx1/s++woBufvD95EM2xw+mivxeFLYaFqtTP0B7iyXPidFAsLZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8d5afc-f26c-488c-1ccb-08de17e1d705
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 18:26:27.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk7EDfNRee/PO8+kALV685w3lKcEfhNl5dstmWQ58PQCGlYvgoWQVJqDXIGnczKP/yzIncN+9BecZ50RFq88tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510300153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0OSBTYWx0ZWRfX6Iu/fU3Tw4xp
 8qLyGU6i6SqqYbqbCOq6UyEY2/vK0ZZq5Vao3IunHdnU1oRoSdk8muIZdeGDPXdzCEFlAZdypSc
 usWIlpL6HKWXM8ODByKtJHJNpthwdTtqltb7y8VomCxzJd1kgdPOkOHoHagYStl6AU8TRAfVSrl
 9I6GJVjlVAnqsVEVFfGTPHas6wx6Qr+xk6mle81200sI/ARoFCUkF5zU+76HcErgGS7iC3XgjMW
 1A+RsNDvunXzMIrzjBmKb++MMUjIdq7xV7LQ4jM9tqnd4GYOwQXkQcxYJXogpnM3yOsq05gjpl1
 Gvh1CVt5+3zR7ZwOWTGPd7QoXDJ82FzID2KuJPS3tt5ZA3jpiRql2Ho6cQ3Bwzz2SXRLZAy6UZQ
 WkbPb3dC0ieYlxL8p/+7MwZakpVw8M1orjqIsXfl3xp2np7gS4Y=
X-Proofpoint-GUID: E5l1i4f2YO9WgkkgAMrDw5_lkJrySQtc
X-Authority-Analysis: v=2.4 cv=UJjQ3Sfy c=1 sm=1 tr=0 ts=6903add9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SBbeMXpt0uN41cmdFq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-ORIG-GUID: E5l1i4f2YO9WgkkgAMrDw5_lkJrySQtc

On 30/10/2025 18:14, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>>>
>>> Do we break compatibility with old pahole versions after this
>>> patch-set? Old paholes won't synthesize the _impl kfuncs, so:
>>> - binary compatibility between new-kernel/old-pahole + old-bpf
>>>   will be broken, as there would be no _impl kfuncs;
>>> - new-kernel/old-pahole + new-bpf won't work either, as kernel will
>>> be
>>>   unable to find non-_impl function names for existing kfuncs.
>>>
>>> [...]
>>
>> Point being, if we are going to break backwards compatibility the
>> following things need an update:
>> - Documentation/process/changes.rst
>>   minimal pahole version has to be bumped
>> - scripts/Makefile.btf
>>   All the different flags and options for different pahole
>>   versions can be dropped.
>>
>> ---
>>
>> On the other hand, I'm not sure this useful but relatively obscure
>> feature grants such a compatibility break. Some time ago Ihor
>> advocated for just having two functions in the kernel, so that BTF
>> will be generated for both. And I think that someone suggested putting
>> the fake function to a discard-able section.
>> This way the whole thing can be done in kernel only.
>> E.g. it will look like so:
>>
>>   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
>>   { /* real impl here */ }
>>
>>   __bpf_kfunc_proto void btf_foo(void) {}
>>
>> Assuming that __bpf_kfunc_proto hides all the necessary attributes.
>> Not much boilerplate, and a tad easier to understand where second
>> prototype comes from, no need to read pahole.
> 
> Scheme discussed off-list for new functions with __implicit args:
> - kernel source code:
> 
>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> 	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> 
> - pahole:
>   - renames foo to foo_impl
>   - adds bpf-side definition for 'foo' w/o implicit args
>   vmlinux btf:
> 
>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
>     void foo(void);
> 
> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
>   id lists (no changes needed for this, follows from pahole changes);
> - verifier.c:add_kfunc_call()
>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
>   - Replaces the id with id of 'foo_impl'.
> 
> This will break the following scenario:
> - new kfunc is added with __implicit arg
> - kernel is built with old pahole
> - vmlinux.h is generated for such kernel
> - bpf program is compiled against such vmlinux.h
> - attempt to run such program on a new kernel compiled with new pahole
>   will fail.
> 
> Andrei and Alexei deemed this acceptable.

Okay so bear with me as this is probably a massive over-simplification.
It seems like what we want here is a way to establish a relationship
between the BTF associated with the _impl function and the kfunc-visible
form (without the implicit arguments), right? Once we have that
relationship, it's sort of implicit which are the implicit arguments;
they're the ones the _impl variant has and the non-impl variant doesn't
have. So to me - and again I'm probably missing a lot - the key thing is
to establish that relationship between kfunc and kfunc_impl. Couldn't we
leverage the kernel build machinery around resolve_btf_ids to construct
these pairwise mappings of BTF ids? That way we keep pahole out of the
loop (aside from generating BTF for both variants as usual) and
compatibility issues aren't there as much because resolve_btfids travels
with the kernel, no changes needed for pahole.

I'm guessing the above is missing something though?

Thanks!

Alan

