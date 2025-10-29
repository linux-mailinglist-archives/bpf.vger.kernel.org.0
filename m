Return-Path: <bpf+bounces-72850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29445C1CD2D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CCB189E60B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806233570B2;
	Wed, 29 Oct 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j63fRAvW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yxZ7MhYW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF43090C2;
	Wed, 29 Oct 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763650; cv=fail; b=PlUG7UE0PhhKGOaWft6xAKrTpFH6cNrOK96L9F2wyE3qsABdZUujpAxMf9Vii07mm7JjjT73QNYYCnnVQCKTuHJLsPEUIypC0zlhouIyfYd69RWknXcGB/JKumqjc4DWbWIOifRQ9qKO3NX7cH6JKVXh7A9wso4VzBqy+FGdm5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763650; c=relaxed/simple;
	bh=ntgG8sSnr0lqhdAD6yWNsFcau0Sfl3AmVzvml9JDsd4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBSYKrddiX2e0TVTeMdFCglu+wLkJ7TPhb9mbJum825VPC7mesZBTEHOrQyxjcJ/Vv9amwU8l8TlKK+sHGbtanRfvpONy7wL7DGy1heWrGMBPLHsmKQ71len7iNC2QHs2XimyJOiM5eWmnBHGhq9ph9nZuTPilJwTV3Sa0DfO+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j63fRAvW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yxZ7MhYW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfwfl011152;
	Wed, 29 Oct 2025 18:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V0YbEKkLoQuERnHmc9dJYTEwktDz/5Uu1T6z11xiaaw=; b=
	j63fRAvWlewPMNXbOfrJBKTsnRTl0iKHLPwY095Ji7b08TwRVWe+M3/YcwfJuSL/
	VwCtnlB2PPjha/trMawXTdm6Zwbk0NAfeKEFG3J9p4vdjxPuD5YKh3oOp7O7/olA
	EnyqfwiyROG+AyQ0B/Hd2mY2TzAzyruCZgfu40oOvGyEMV8QPew5iFz9FaLnozaf
	ohRk78Sa2yMNF/4kc/pR6eDJocFY84voPtaaVLNEd8Kp58mHOkjNNAVRJBWh1O6B
	lyvbkuzQB8VQfvBZizO+Yxv4PxylJcuUYTW9TCIp0W66qWVjHVlZ12oja9SvIR9X
	a2LoOo4cVBGtHCWFLU+a9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxjp95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 18:47:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59THXRXD015933;
	Wed, 29 Oct 2025 18:47:03 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q82fkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 18:47:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvuI+SXwGjzyKbTB+l+65lxI8u5qzL+C1M+wPFj3z/eGos8q/Uua9x0pPk9I8UkjhpQtpzVFydf1LQoatWeo1N2NKFL8RiuHH7VI7JqBxnRXXi+x+GZKVbeJS0EpIdxVCh+QHCxdQaUEnBx8p5Bf6bRfM3S1ySIhndaxop8y9jUUm31zvVC7sCsILMahQFEHACPoxxQYdvI6f3/hrhcBDt5JcOfbVZ68DWzZBKozDBL8wXOlgsV7j5ri/PRiMnPPwBP28rqVvFPCeAj9m9jttMbvZnbp759zCdSvGeeBYoopvMz5vShb+RBB+qn1nNd9t5zzEdXJQQMKYG+tP6eVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0YbEKkLoQuERnHmc9dJYTEwktDz/5Uu1T6z11xiaaw=;
 b=SnaX0iut9GjA5Te6cGT7CnnBK3oTCN3lXorTTJ/FdX/sHcmYQWBgSZiueVes+LVrBeSoAwz6uZHJwjl5hZ4pGXXvbNiJjMZIZRA2/4t66J1FFUCyO7Xl5DJXyfDzr6NDFw1AwiKUeOLDAjaxBO4ny1+UOUFvkV60Xy1TiJdcOADBZp5jwZjYO5wyp/2T8qcbzXbQykAh4h/M1YpzBZAnv6qezG+77RgYjV7UnjwooseJ5bKmRprLQUNDC5bNcXIyFz6OFkbL7mDO2eAxD5kAKHHczkBKMJUADEC9F6oPTkYjBtA81pxfIV79QU3hu5NEcJmNXMOsX4uG1o6F4Y/JoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0YbEKkLoQuERnHmc9dJYTEwktDz/5Uu1T6z11xiaaw=;
 b=yxZ7MhYW11ymHuL5tjU6xQiGL2xtXce6axwnaSZM5HYrrI/U1owSwEDPURTuGh3P06EnlEJaMYN80+nDJ3dBBi64xiDeUnqSa3yII+y8NxUhLFZjkXCqwkQcWVeFMAA9roEl4e2mkNhpoRKaZYNXsHO9aRHGoz3JfOExSv3Sp04=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH7PR10MB6650.namprd10.prod.outlook.com (2603:10b6:510:209::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 18:46:57 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 18:46:56 +0000
Message-ID: <b2a4b924-6207-479e-9990-c2cec1c6a50a@oracle.com>
Date: Wed, 29 Oct 2025 18:46:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves 3/5] dwarf_loader: Collect inline expansion location
 information
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251024073328.370457-1-alan.maguire@oracle.com>
 <20251024073328.370457-4-alan.maguire@oracle.com>
 <6558dc0590b174174321899af9981053db76845c.camel@gmail.com>
 <1a8cc336-f6e6-4908-aae1-ed3189219ec4@oracle.com>
 <9bb6431321c4fb91602e5260ef0b5989ec6e1ee8.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <9bb6431321c4fb91602e5260ef0b5989ec6e1ee8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH7PR10MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: b86b43d6-1ea2-425c-e611-08de171b88eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emtEZnRyNStFSjRNWEFsRGl3OEZUa2tSTXBRRUVvdENMOExTRGVZSFByd3NK?=
 =?utf-8?B?WE11dUhjY2Z3ZG90dFNDOERXU3NHODdMM3AxcHJtdlZYSVNXakgza0dOYTZE?=
 =?utf-8?B?QmNsZ0pwWmMrRFdsZ1p5ZHMxRytrQndndDdIRVV2Rk94ZXFSa3lHN1B6cS9r?=
 =?utf-8?B?N0U5NG03TzQySnpoeStCK2NkQThjTUZqYVhIaWdZaG1oUlNtZHlNRnJhbzh1?=
 =?utf-8?B?dVFnSmdGeG5aTXNUbGNENVVDS2RkRDdTTGNqeCsvWnZYU3Vmbm4xVGJZQXo1?=
 =?utf-8?B?U2UzK2ZqMVNENndoZURKOWZFY2YxSm9ka09heVlJSi9aYTM2ajZWVURlSnE2?=
 =?utf-8?B?ZWhTUWxFWHhkcjJIQU1kazlkblVpMUZNUXFsZEMzelh1K0lwMFNWSG96UDdo?=
 =?utf-8?B?dXhFNFZtclhtcUhqWmp1UWljNlIwdGRjdTd4Ym1UOXRnMGw5OEhsbjN5YnVm?=
 =?utf-8?B?a0pZZlcwaE1tMHhaenNvekpzUTdwR2h0Y29Nbkhiam1TS0sxU0NTWWx1Mnln?=
 =?utf-8?B?SDZoMWRBSkkwOEgyQy9nK2RwYzN0aVlySHlvVkNaVG1HWHBrU2hXUmJLd0pi?=
 =?utf-8?B?TTRZMDV2SCswb2tZeU12VGYxR1VLOVMrNS9QWURJZDFoQ2pPUS8xS0tQMk94?=
 =?utf-8?B?anN6SSsyN2xHRS9Mbi9jZU5FQXRsY0Y2cWxuQS9HMlo0dmNvdlQ2RjNYUjZC?=
 =?utf-8?B?eWoyejVPa3BwaGc4dzVhNSt4R3EyRHBqbE5iWCtDbnVvczgwOFhnVy9pZFdS?=
 =?utf-8?B?TEZTTEZvandjSlpzUUQ0ZVdPc1oxVVVCUkdJTmtUeG8xQ2FVVFRGWjJ0cmdq?=
 =?utf-8?B?aDdKWDBrb3RUcEtQY29pdmN0OXV4MjdhUkR6Y2pUR1hVeUl1dUR5cG9nWk9Z?=
 =?utf-8?B?SmtEM0g1Mno3WXE5M2ticDBycFV0T2VKTXJ0bUFkQWVOUDRyLzMzcld0RzlW?=
 =?utf-8?B?bjVqVFZoZS9Gb3dzS3REQW81TE51UDREcDdqcXA2QVVVNmpLNjlXOG5vcklG?=
 =?utf-8?B?OFpDVUw5MjB4VVRBQjhNMU1CTTEwdVo1NnZRMVBoR00ybmFrLzFDRDRKWW1k?=
 =?utf-8?B?OFNhaGJqTTZtNDJlSDhuRlBYVVFUbVpQWk1WU0NpL3FnU1RTS0RkMFpoeCtp?=
 =?utf-8?B?SUkrVzdqTStjVTZXK3RtbFpCUTB3L2FoOUdzUUs1V0FBVFdBaVFpbGNIWnY1?=
 =?utf-8?B?anJXVHorNXIwaXkrVFJoSW9IbjNoSzNFeGZ4dExPaGZOTGZVdDhJZWppS3pz?=
 =?utf-8?B?bjhETThQYWYvMkFMK05IL1NJTlN4UVo1LzdHYUNtVXloR3lKTmtBaCtEQ0tW?=
 =?utf-8?B?M1BCa2syRHQ1K2psSm1mT0NoN2ZLbXAzVHR3MEMzTVdkNWlmbU0wRXpiVldL?=
 =?utf-8?B?NmpseFNNMlVZeVA1R2hNTEpDZnEyYjBDZlJ0M29meUd5S3NuenYvalFVaEM3?=
 =?utf-8?B?dDRiRjNSb2JhZGJiSUVyMUpSaGlGK2hmU3NOVFJqYmtlcVZEWEdQNVRUZGZ5?=
 =?utf-8?B?V3FZMDdpZTVVUTJzZ0w1cyt1eWFDMjBwTTlNVnhXN3JsQUxZMk5wMmNCV1NB?=
 =?utf-8?B?R1liZkNsNlFUVGFCdG5RNlN3djJwUklzT2JIVXNZYWlpK0R2RENRZUt2U2dG?=
 =?utf-8?B?V2xsMXg2RDVhV2VXdW1NWjNxTW1DdE8wNXVqTTY3SEF0eUpUanpUT2hyWjcw?=
 =?utf-8?B?dkNFSWdqR2JucEhObE96Vmt6OFlmMFJsY2d4QUkyR1lUUmY2Nzl3TFpKT3p4?=
 =?utf-8?B?WGhpTHJaNEJvMlRHMTBCRno2QVpZMVRObXpkZVB2enBGQnp2eVZFT3BEbDZF?=
 =?utf-8?B?SlJydGxNQ2taSnQ3S2JLNVB4cWNUSzdVWERzelNvV3gyUXB0dFN1d2k4YmxU?=
 =?utf-8?B?Z3ZxZVRTcTFvR0x5eGJ5RWlFNUI1R28wdEZzVUUzajBaQTVCWXJPc1g4UHY4?=
 =?utf-8?B?SGROZ2JmWXpxUk51SzdqTFBmUDJUNFR3MEdvRFJBeERQZEVhS2ViVDQ2OUFq?=
 =?utf-8?B?cUdMT21ySzl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hwWUYybVl6QjF3SkdPcU0ydXB3VlpIbGY2REgzMXhJUHV0UlNyWDAvem9F?=
 =?utf-8?B?RjdQRllnNXZtTXRhbTY3UzFxT01sT004RmNTUUViQm4rVEozWURwb05TelhD?=
 =?utf-8?B?Y2lFWGJ6YjVkTmZoQ2N0RDBISmRSMGlQMzBjVjlhaFpPK2twWDRSRGttb2dF?=
 =?utf-8?B?ZVE2amg0R205dFJYYzhwcEFKb0pGamVzU05zOElCOFBxWHI4V0w3QnNIZU9q?=
 =?utf-8?B?NWpFblhxWHRxZ2VtV3lsbmg5THk5eFlwZGFjZ0NhaUxkallHOU5CYVBuV2Ni?=
 =?utf-8?B?ZGhaOXp2TG1OOWFiMm1PU1M0MGRMMEtoeit3ZWtXNUNNSmpPQkYvajdaWHMr?=
 =?utf-8?B?TEhsNzRIcWQ3Snp6S0FUb1l1QXZqZldKa0lyZmxWTVppUGFObUREL3AzSVN1?=
 =?utf-8?B?NDFKcjBVdEJxQlFkYlQ0Um1DajRDUHdVemJaSTBZbEU4ZkN5RDlySWFFeXhS?=
 =?utf-8?B?a1VmZDlJMzg3L1dqeGJwSXNUdk9GaG5NTTNxMmREL0tpWC9oSys5NnMraXJa?=
 =?utf-8?B?K1ZQS1R0dDd1aXlKUnlPbkpqZTY0L2JjREFYdVRFY2pQQ0liRUZHN0dPN0I3?=
 =?utf-8?B?b0ZBQkViUmVRaTVRVDhvQmZBR0pFVTlmWmtTb2l0YlpRczFCYVUwUHkxdjRT?=
 =?utf-8?B?M1FTalJKaU9FTHpBZDZ4dEIzNmRzRktrL0MzdllrcGg2UTlOaXdWMXoxd0Np?=
 =?utf-8?B?OWsxc1FXdUJMS2pzcW5sMWt2N003MUVMUWpZcVJSSkZIS01MU25QbFpRVUJF?=
 =?utf-8?B?TFRRMWJNakNWU3VMWW5PYTNjVC9oUktOVWNNcll1d2I3L0NESDBNOGlSSHR2?=
 =?utf-8?B?aTdwaXpFOHVGcjhlWGY1OGxMMEc1TTA3cjlsU0Vnb3ZXMTMxcmkvOElZYnVu?=
 =?utf-8?B?bTdKU0xtNnY5UWxKZ1AxVE0wbGwxSktTbHNxY1pZZUtQenRET1Rab084WU9D?=
 =?utf-8?B?dkYyOTZmZURYbUtJWkd3dXEveXhXZXU4VzkrOHRoMkVZM09ISjZQTUlGTVI1?=
 =?utf-8?B?aU0zMjJxdkpuS0JGZVlRZ1EydDFEWEtyeTZXS3prdng4U0pKME0yYzlOM1BK?=
 =?utf-8?B?NlhzNDhQejVLMjZ1WHZnYWVzc3drUDNGTTU5MlJYYTRxdFJHQVlQVGtmeGJR?=
 =?utf-8?B?K1hEUzNhcDQvYjFaUFFPcUU5TWt2S2tYOFNLV2NVY0w3YmFydU9QT3R3TE8z?=
 =?utf-8?B?RDZmVWtWQzhkTnN4RjdqM3gvWXlZOUl0WDJVRVNkZVpZRTR2OVlKZThMeEFD?=
 =?utf-8?B?SjBIUDNmRGZkM3ArU3dsZlhPMUE5c1M2MVgyS2lXUFRJdEo0YkpqZzluRVVD?=
 =?utf-8?B?YmVOeTJ1QUg3SmRqQ0JtbXhpeUdhL1V4S3htbncrY2ZLZjZXWU1YTTE4NFps?=
 =?utf-8?B?ZDFDcWJqNVBSVWFkRzkzQ21nODRzVkRoTjA0alVDc1J0ekVyMzd4TXYxZzVW?=
 =?utf-8?B?L2hwNnhmTFVMaEN1SGI2Tkp0UWFWUmFTamx0N0ZMM1BobHAxSytqdnJIT0RD?=
 =?utf-8?B?UloyTVhTUFl3VDR4L1BRb2RvaWNvQUJIc2pCR0Q3RDlVUm9PNk5EbEZ2L0s1?=
 =?utf-8?B?SGxDNGtTVkRwNFdmbzJVbldiajZTbFNaQjRtOERGSDF2N256dGZOU3RHRU5k?=
 =?utf-8?B?ekFTUmlnZGJNOFNKRDdRWnRSV0M3YmJKRlNQTDFNSDd0cVgyVDEzb3FNRWI4?=
 =?utf-8?B?aHpBOUlQQnFMcmhWTFRncXdZcTRmaGhNZWtJZnhaYjNkM1pFMmlkdjhyaU5r?=
 =?utf-8?B?VVI3YXlqUEZpWGZNZ2lLUWd5SXdMOVE0T0xZeVJIOC9CZWRpSzVkdElLMzk3?=
 =?utf-8?B?bEZrODQ0UmM5dmo4QkExTms2bE5SSnJISWo2WGRRT2VHTW1FdTJHZ0R3MWE5?=
 =?utf-8?B?bm1lRlR2bUlEYXNxL3RjWE9YanhQWXpLMExvTGw2TStETWZpZFFYNk9kM0lx?=
 =?utf-8?B?d0NjdXdrV0drcEswWjczNk51SkI0M21KMng5NlJCZ3l5VXRjakRSTEdjT1lS?=
 =?utf-8?B?Y3FUNUFrQ2wxTmtQZ0YrNXpkYmxhWkxFa0grUWNqc09QSzlLbzFUWnYxS0ZK?=
 =?utf-8?B?RElpNkVMUGxZRjlsNWFZZGc0TkVKVDJqWkorVnZqK2thU0V1a2YzMy85Y3o2?=
 =?utf-8?B?aWcwYUhMQ2JlNGFiTldkVlRnM0Q0MlJZdWdDbEU3K0hFcytyVDJrai9IQ3Jj?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q7NfAPiL+YVrj0MrVEHfXWEH2HEpK8eHoxDet2i1z02eNDBwQwMyCdiy4Qu1aaU7x8HnB1JTPIniHoAupzz9D005Rm78be1R938emXGlkODPJSl/UbayFFdGoR44WLT8G4+uD3WBay+kT1IX4m+EzhzB017w9prv4y15brAxlllT6xT3BnkqiA9cHCIYxqFwfcMW/y19Mk7yIhNa6JkFGIaZgkJ80lTPEtWiP1AHw8w2lJxUM1x5iqTNrBd/tDjyFf0p8xQpw7/XnwF4E1KziGNPKuiNZ+TTjCMgZi+Cdu6GCo1+nRQ9YLrhmrkElHRywRQ6zZm5iY8JE8CEWsv4Y+XL0TzK5ZO3SLwtchGk3vgZ3resiVI23eOSymquIExHJ9TmPjGnKI00Cof9fYr9KGGL9jM9wUgxbTiDfc7KwPbzl7rk0ohOasu4BJC0tiHua6QL0OAYJt5T/ObPc4JkyCwbTOvDlFYjDYgf+G9G4TCEaIQv7qMA6GavN7zpM6TseWJxVg9Uuw+FIdbDvV8Eh6LsVpsipbMPK/BJCxPtu479AY+IiqhDHeCRp1jN/FT3ELqej5Czogi2InjB92EwSGx6paMikuEfW6KumJMprHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86b43d6-1ea2-425c-e611-08de171b88eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:46:56.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29A5kbO0vrcfZZm+A1D3hpW8SjWnWSKaXWuOH9xauoJEsXHdR9lzZmFaS4+dpHjooSd4Ar04JaxaQsayiBddPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX0vQSDClvTXbp
 +t1El0x339cSUOwcsdlvEs0dG1WUpStyXyOuGiAO/x/dWA2wmwkminH8EfsAY71PTHgAV/xb/w/
 GDWN75VltXzMK2VmrRAECSe7PiTQoEtI4djWXjzE9HteSRRWla0zkWUhtgupB8iN+YDvB2RbTV4
 v3AzfXqtfK5yRYLMRplDl7kpp4ul2bperv2yfstUkt3ID91KZMz/SxV4IYV8N18o3ytTdAR6TGw
 UkaAH8dWYgj/i0HlrKraSQKQqqzL7KUsZZqWYXZg48STO7XMII2Mk6wIHfR+JKDBGLhdTgdg+0Q
 6DSCIUwf1cC0wEIqJantUMM6AiEIBnIKR/oL2SfjUSuICaGMDnVZhWHNkqmhdqL5X1mF4t+Fxz5
 C9OIg224KXDDEzzso/GTmOIQNoNEzbRqv6vYpP6sDkqAU4WEP2E=
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=69026129 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=HRI1k443q01319XJcKQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-ORIG-GUID: x6nxqi0SUni-5KVAara6SE3axSBdUUwZ
X-Proofpoint-GUID: x6nxqi0SUni-5KVAara6SE3axSBdUUwZ

On 29/10/2025 18:32, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 17:40 +0000, Alan Maguire wrote:
> 
> [...]
> 
>>>> -/* For DW_AT_location 'attr':
>>>> - * - if first location is DW_OP_regXX with expected number, return the register;
>>>> - *   otherwise save the register for later return
>>>> - * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is in the
>>>> - *   list, return the register; otherwise save register for later return
>>>> - * - otherwise if no register was found for locations, return -1.
>>>> +/* Retrieve location information for parameter; focus on simple locations
>>>> + * like constants and register values.  Support multiple registers as
>>>> + * it is possible for a value (struct) to be passed via multiple registers.
>>>> + * Handle edge cases like multiple instances of same location value, but
>>>> + * avoid cases with large (>1 size) expressions to keep things simple.
>>>> + * This covers the vast majority of cases.  The only unhandled atom is
>>>> + * DW_OP_GNU_parameter_ref; future work could add that and improve
>>>> + * location handling.  In practice the below supports the majority
>>>> + * of parameter locations.
>>>>   */
>>>> -static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>>>> +static int parameter__locs(Dwarf_Die *die, Dwarf_Attribute *attr, struct parameter *parm)
>>>>  {
>>>> -	Dwarf_Addr base, start, end;
>>>> -	Dwarf_Op *expr, *entry_ops;
>>>> -	Dwarf_Attribute entry_attr;
>>>> -	size_t exprlen, entry_len;
>>>> +	Dwarf_Addr base, start, end, first = -1;
>>>> +	Dwarf_Attribute next_attr;
>>>>  	ptrdiff_t offset = 0;
>>>> -	int loc_num = -1;
>>>> +	Dwarf_Op *expr;
>>>> +	size_t exprlen;
>>>>  	int ret = -1;
>>>>
>>>> +	/* parameter__locs() can be called recursively, but at toplevel
>>>> +	 * die is non-NULL signalling we need to look up loc/const attrs.
>>>> +	 */
>>>> +	if (die) {
>>>> +		if (dwarf_attr(die, DW_AT_const_value, attr) != NULL) {
>>>> +			parm->has_loc = 1;
>>>> +			parm->optimized = 1;
>>>> +			parm->locs[0].is_const = 1;
>>>> +			parm->nlocs = 1;
>>>> +			parm->locs[0].size = 8;
>>>> +			parm->locs[0].value = attr_numeric(die, DW_AT_const_value);
>>>> +			return 0;
>>>> +		}
>>>> +		if (dwarf_attr(die, DW_AT_location, attr) == NULL)
>>>> +			return 0;
>>>> +	}
>>>> +
>>>>  	/* use libdw__lock as dwarf_getlocation(s) has concurrency issues
>>>>  	 * when libdw is not compiled with experimental --enable-thread-safety
>>>>  	 */
>>>>  	pthread_mutex_lock(&libdw__lock);
>>>>  	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
>>>> -		loc_num++;
>>>> +		/* We only want location info referring to start of function;
>>>> +		 * assumes we get location info in address order; empirically
>>>> +		 * this is the case.  Only exception is DW_OP_*entry_value
>>>> +		 * location info which always refers to the value on entry.
>>>> +		 */
>>>> +		if (first == -1)
>>>
>>> <moving comments from github>
>>>
>>> Note: an alternative is to check that address range associated with
>>> location corresponds to the starting address of the inline expansion,
>>> e.g. like in [1]. I think it is a more correct approach.
>>>
>>> [1] https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L184
>>>
>>
>> thanks for this; I'll try tweaking it to work like this. The only thing
>> I was worried about missing was DW_OP_entry_value exprs since they can I
>> think be referred to from later location addresses within the function.
> 
> (I needed a few iterations to get the base address calculation right)
> 
>>
>>>> +			first = start;
>>>>
>>>>  		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
>>>>  		 * DW_OP_stack_value instructs interpreter to pop current value from
>>>> @@ -1216,33 +1241,154 @@ static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
>>>>  		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
>>>>  			exprlen--;
>>>>
>>>> -		if (exprlen != 1)
>>>> -			continue;
>>>> +		if (exprlen > 1) {
>>>> +			/* ignore complex exprs not at start of function,
>>>> +			 * but bail if we hit a complex loc expr at the start.
>>>> +			 */
>>>> +			if (start != first)
>>>> +				continue;
>>>> +			ret = -1;
>>>> +			goto out;
>>>> +		}
>>>>
>>>>  		switch (expr->atom) {
>>>> -		/* match DW_OP_regXX at first location */
>>>> +		case DW_OP_deref:
>>>> +			if (parm->nlocs > 0)
>>>> +				parm->locs[parm->nlocs - 1].is_deref = 1;
>>>> +			else
>>>> +				ret = -1;
>>>> +			break;
>>>>  		case DW_OP_reg0 ... DW_OP_reg31:
>>>> -			if (loc_num != 0)
>>>> +			if (start != first || parm->nlocs > 1)
>>>> +				break;
>>>> +			/* avoid duplicate location value */
>>>> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
>>>> +					       (expr->atom - DW_OP_reg0))
>>>> +				break;
>>>> +			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_reg0;
>>>> +			parm->locs[parm->nlocs].is_deref = 0;
>>>> +			parm->locs[parm->nlocs].size = 8;
>>>> +			parm->locs[parm->nlocs++].offset = 0;
>>>> +			ret = 0;
>>>> +			break;
>>>> +		case DW_OP_fbreg:
>>>> +		case DW_OP_breg0 ... DW_OP_breg31:
>>>> +			if (start != first || parm->nlocs > 1)
>>>>  				break;
>>>> -			ret = expr->atom;
>>>> -			if (ret == expected_reg)
>>>> -				goto out;
>>>> +			/* avoid duplicate location value */
>>>> +			if (parm->nlocs > 0 && parm->locs[parm->nlocs - 1].reg ==
>>>> +					       (expr->atom - DW_OP_breg0)) {
>>>> +				if (parm->locs[parm->nlocs - 1].offset != expr->offset)
>>>> +					ret = -1;
>>>> +				break;
>>>> +			}
>>>> +			parm->locs[parm->nlocs].reg = expr->atom - DW_OP_breg0;
>>>> +			parm->locs[parm->nlocs].is_deref = 1;
>>>> +			parm->locs[parm->nlocs].size = 8;
>>>> +			parm->locs[parm->nlocs++].offset = expr->offset;
>>>
>>> I think this should be `expr->number`:
>>>
>>
>> Hmm, I thought the bregN values signified register + offset
>> dereferences? Or are you saying the offset is stored in expr->number?
> 
> The way I read docstrings in libdw.h:
> 
>   /* One operation in a DWARF location expression.
>      A location expression is an array of these.  */
>   typedef struct
>   {
>     uint8_t atom;                 /* Operation */
>     Dwarf_Word number;            /* Operand */
>     Dwarf_Word number2;           /* Possible second operand */
>     Dwarf_Word offset;            /* Offset in location expression */
>   } Dwarf_Op;
> 
> Is that `offset` is within location expression in DWARF, and is about
> format bookkeeping, not the underlying program.
> 
> Double checking this with my tool, modified to print offsets:
> 
> ./include/trace/events/initcall.h:trace_initcall_start                            0xffffffff81257f15 rsp+8
>   die 0x19a62 origin 0x195d1
>     formal 'func'       location (breg7 0x8 (off 0x0))
> 
> Here is llvm-dwarfdump result:
> 
> 0x00019a62:     DW_TAG_inlined_subroutine
>                   DW_AT_abstract_origin (0x000195d1 "trace_initcall_start")
>                   DW_AT_ranges  (indexed (0x22) rangelist = 0x000002ec
>                      [0xffffffff81257f15, 0xffffffff81257f58)
>                      [0xffffffff812580bb, 0xffffffff812580d5)
>                      [0xffffffff812580f4, 0xffffffff8125817e))
>                   DW_AT_call_file       ("/home/ezingerman/bpf-next/init/main.c")
>                   DW_AT_call_line       (1282)
>                   DW_AT_call_column     (2)
> 
> So these seem to agree.

Great, well spotted and makes sense, thanks! Will fix for the next version.

Alan

