Return-Path: <bpf+bounces-78755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3FD1B532
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA453028F75
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADB3203A5;
	Tue, 13 Jan 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1FYkfQG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EYqVbFzV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B031AF07;
	Tue, 13 Jan 2026 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337994; cv=fail; b=DkPg8MuNezQ8EgqiBtd0Bcj/XC/KDXhOZVHorkad1wvfWX0OTZoIthvYQXAYe53MvO53Ujo4jmlvk7CcZKt2LZHP8BUbzLz3aI6BJUZFy42wadXsXaU9DuK+tVKAyzvQbmK1Gruz7u9ZZ5jJQqXRN68A9cxVDAuy3GATRvM36ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337994; c=relaxed/simple;
	bh=NbtItybYMDKP3dZEIGy9O2kc0j4KI7DZ8X3NPSTl7Nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VI8p9PLdhjsHj8PkBBrURozZTsmBMTcsPgwokLgHkeAcJpyXVWXzOWDkFviCai55/Wn17zf8vVribJmhw+jteky3E2uhDPlKdGEmY6CIr93W80kdDcSOR1T0nmeKOWqmmuUYDOAImMEMyypMDd/DCC7cXtwHo2rDQvC4I6C0VD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1FYkfQG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EYqVbFzV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DGBj012755030;
	Tue, 13 Jan 2026 20:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LAe08vYe1a4WUt8renq5pPIkbwn2DHeDJcLiZdp7Lf4=; b=
	W1FYkfQG5LtbnLi7g0mXvyK5Q5EexHgFP/AQt8geFwG0Qp8McMB0MauJSbxnivkq
	C8DGJt/mmELogFPe1dCGdW0nEsQki9joxvHTxRYZbZ5XDPKI8vvKe4w55ZdxfMc+
	XvaQ9BJ+nJ66jNbBldKxharh3TSoj9uiAx2NuZ3WT5BMghHAwK6tuPLsOYLIpmXx
	k6xSpFfhoDsVVE/XGr82OZ/xOkVWF1pURlaaAHZJABDYsAabVFwWuDRftg2XYiqw
	I7rNO0VtGSBfxlITnDreLlSGZMJe+czx00n9yFPOEX8vQG7lBIjJxUb2NFPmJvrz
	Z9p/IDKKr8Y94EzYsQ63EQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgm6du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 20:59:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DJ56eX040477;
	Tue, 13 Jan 2026 20:59:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7d091v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 20:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnD0EdhRBbKIuQD/2V80kag6lxCGiSRm7y1YSE9hOhr0kCJpXu0McVQKf3sleVBO/zFFMb8k7eQJZhBkZc7a20xLaGnc8SB7bmgPB8JgiePwnQZ3uSxJ18rOa3VT8LBL17XVdhh/tt59KQvSXrNbaBGbDgGYkYSoG6348rgrbScLSKHk5FcUsvqux475QD40t9+vFf2LNwzK9D6WpDiYFo8zLMpdV6exOX4Rop0sjINmyhdbvWkB+50ycuIAKK5GdXnHdY87BcWnY9pliy8MoFypyShrfohMY834P8rxCq1OTAi+yak8fncyGQGD+cju1SWhaLunrw31tyvrhrukSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAe08vYe1a4WUt8renq5pPIkbwn2DHeDJcLiZdp7Lf4=;
 b=LLnm5Ws7FgfbN27DqiogPCCM85KYfL/s5pCjHorlE+fvYDOTjPhluTamSPHKWowZscfzaV4KJv/6XFs7rJ5TK7sIshzavOh49WZyd/R8WbcWdypK291L4u3ykpE4dohIDe3H1pyQSdLzLG8fZiPoLwOXAtYhYXQ48sfwCUsBVpIOFLy7cTYQegio8O4I7Qu88Eefe486mH/3lCNSNptVedgL1Qd6XWM8VWBXwyo/HQCYmN7yBmOWRd/GWR2NPsVbh4cM0VuVCz8axkIzxl4PL96wa3pfDAip+0eH3o0akuBQFpWULfMkigLaO/TfwQr4wZizYyrtgPHMKBTwdW0vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAe08vYe1a4WUt8renq5pPIkbwn2DHeDJcLiZdp7Lf4=;
 b=EYqVbFzVs19Ox4/RAywjlSH0yG9hzRd/k8tnNLbaN6Neq8YBHp7oV+X281YNCv6chkRk8xxa9DH6KwDtK4vH1tXZGOiUHSAfZXItrj7NktB6xeOef7COvYkYmehPhVm1388jKzEWT4yT3cfNBDOTH7n/zyt5OeF5nPeqtosBjBo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 20:59:41 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 20:59:41 +0000
Message-ID: <bac70ec7-3257-4a29-a298-b6d90fb7bfda@oracle.com>
Date: Tue, 13 Jan 2026 20:59:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 2/4] btf_encoder: Refactor elf_functions__new()
 with struct btf_encoder as argument
To: Ihor Solodrai <ihor.solodrai@linux.dev>, yonghong.song@linux.dev,
        mattbobrowski@google.com
Cc: eddyz87@gmail.com, jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-3-alan.maguire@oracle.com>
 <362ab824-6726-49ad-9602-ea25490e3298@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <362ab824-6726-49ad-9602-ea25490e3298@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 952a0e42-704e-49df-2d37-08de52e6abd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3EwRDIzZitMWnJxakhhQWtoVmQyOTZzcGtyWk1NMWluVzdtY0RJcnpEUWhY?=
 =?utf-8?B?RW80K0xWNzI0NmUwWTRpcm12OTlzZzE4TU1CS1dma0lRLzFOZmdqb2I0Wi9J?=
 =?utf-8?B?OWplR2RqbEJIRVM2QllGRDcvNjF3eWFhdzdZaDJBUlRpcmFlY3hnSmFlZjNu?=
 =?utf-8?B?RUJPbVpJdUpUdUZIblZCb2lpdFg3RGJMaUVISmhsK3BRTVdNNjNUblg2T3pp?=
 =?utf-8?B?V0ZZU0w1bnB3RzlyNVY2cVoyelJjS2JEMEd3UVZWSFhibm8vZkJEbUJHVnEv?=
 =?utf-8?B?dWVsc0VhVExrbC9SSExyaXFPT0hkQTVaT0JPUWRkckR6Z1JMdmFDZmhZRU12?=
 =?utf-8?B?SHZzekV1eXVDdGpwZWw0emZjQkpKTW9hWUpUQUgrUlpoMnZmODVYUS9sYTF5?=
 =?utf-8?B?Y0xFa0U0Wm5sVndaOGl1bEpMSzFwdU1VTDVaRzlwOXBlTlVVc05VbXZUbmxv?=
 =?utf-8?B?RklnWkVGNGFvWm83NGpIRzlpL0xxZVlZTHN0L2ZhTmtjSG4yN0VhQSt3eGg0?=
 =?utf-8?B?ZjEyWG00SWxFdkhVT2ZTSXVhVFpiR1JYaEk2aElsbUJhMzM3MVpBRFRTb05J?=
 =?utf-8?B?bHdEQlpDT1FpTC9HZFN0Mlk5NnRENm13UVQzM3h1Z0tCVXdFVUpUU3puVzJ0?=
 =?utf-8?B?WkVtdEZlS2tlaGdyUUlaQldKQnV2dXFhOUN4bEV6L2hTVTJScmFZeklMWUxJ?=
 =?utf-8?B?bkZZdnB5YmVGRTNkM0gyWE9WZ0taQ2JZcWNqYzJUeVR3UjJTQlVsN3NGdytL?=
 =?utf-8?B?dWxscUZ1NWhkYVBTWS9QRnBaRTlzbjh4WGx1SkhQeWhQNmlkeUxReUlNQjFn?=
 =?utf-8?B?b1FxRzlLS2dZQUhhOVEwUHI0R3Z0Y3o5VEdsOHJxQ0t2aS9JS3lVTG1pOFhJ?=
 =?utf-8?B?MnhmRE00YlZKZ0tHSFZvaktrZHNaR1o1QTM5djkyakxVTDdmekpibndHSWxC?=
 =?utf-8?B?a2p4ZkJabGFFek4zNDRtY21vWURhQ0d0bnpSYUpDV3VlckNjRkh1NWRTMVcv?=
 =?utf-8?B?bGc0UVc5NWNwUllCMlJxV1NBSG02NVVnQW04WVhHMW9Wcm1hNVBrRHkyUGVt?=
 =?utf-8?B?ZUtabVJNb1ZibUtld2pMTDJZTlFxVnFzSWE4NkhkWjNJUUFkQVRvV1BycGpt?=
 =?utf-8?B?bHQ3bUc3b1JhSjJqbGc5SGNZWDhlWitSMGQ4QlEyYU45azNLVkFkSkwvMTgr?=
 =?utf-8?B?QVl0MWZzQ1RDb1g4Z2k1ay9wWlVqdWpyRW96OEhPK2dZWU8vYzRreUF2OWQ1?=
 =?utf-8?B?MVZ0cnF1SmdzTnZDYjdzdXVxRXo0VDY5dWNUZ3RLLzcza3dlbHV0SnIzUmE0?=
 =?utf-8?B?b244QlRkZU5tTkdoR1QwVjU2NkJVZy9FTmRzMWVHeEJqVkRra2QvdDdoZHJq?=
 =?utf-8?B?SjVoRzh3eHRxY3VUK241VHRFU0Fzd2xUUFBwQ3l4L21ZNk5udGRMSzNzM1l4?=
 =?utf-8?B?MGZIQWJaVHZPaURYZUIzYktJZTRLV2huZk5PbVZ4Z1B6a0pTd1F2cXZtYWNn?=
 =?utf-8?B?cjBobHkzSXRwTGZuSFBEZnhMOVZQTDA5d3RlMEVOZXFNc1FmQUxjTmZ2T1pT?=
 =?utf-8?B?eVZSUHFrb0xhK0tJQnp0KytiZjk1VUNrRUFZVWcrOWFLREhkWldwbmZPK2Fr?=
 =?utf-8?B?NXRmWmt2TnNCNzJ1KzRWZ3AwVVJVVmpYOGQ4Z1V1ZU9lUVpESEw0SGh4MU9n?=
 =?utf-8?B?RWVqZE9tckhwRVh2ZUMzaVpMNEp3OHkxUGs2akpsS25VbDZrZEw3MXNYaVZm?=
 =?utf-8?B?RkpoUmx0L0pSczNUOVBrV1h5K3hCSEhnRmgydHpUejVYdExOVkY3OWJWVGMx?=
 =?utf-8?B?L3Y5MCtLU1krL3BTZGNZYTZ1NjE2WFVqbVZzUjV2eWZGYlZtUnkyTHZNZ3ls?=
 =?utf-8?B?clNySkxIVTl4RVhsUFhqNlhYai9qNE82V3I1ZE1rUysyN1kyQjVtVDdMRmFs?=
 =?utf-8?B?bEJvcUNmUFo2VVdPZFpHT01wVFNwYUNHZDJ6cXNxQ000d2l1cStLeXRxY0RC?=
 =?utf-8?B?Y25KSmVFRVFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhHWEJtaDRDdldXYU9oM0RYR2I5V3JLRE1Ick0yQ0tVYlVBUy9xR0F6YXR2?=
 =?utf-8?B?VGdmdTZ6K0VjOUtpYjJLZUZZSHZHRHJOS3dGUWwwcFpQTjJQdFJsbU16aEEv?=
 =?utf-8?B?ZWl4ZTNiZUVUYTYrcnBndXFnQXRBS2ZGbkZMNWhERWhxZnVJNXVvb1RScVFu?=
 =?utf-8?B?UGhhTUwzRU5UTUFvOE1za2J2TllNdFdyOFdSMEFURG5QWFl2ZzQwWjZGUFFi?=
 =?utf-8?B?blEwbi9JaUJBKzRyUmJLOVp6OWlGTWtJWHRQc2FBd3U5SzhvNWNZMGFueXZm?=
 =?utf-8?B?ZXlTOUlsTmpVTDdDbFg0VDFERmk3aDRPdlZld1E1VDNsNURPcDhqZTE1NUgw?=
 =?utf-8?B?OXJHY0x3TmVCUnhnUGxJQUNCaWtWMS9KU1lmR1I3RVRkc0NybE1zYmw4VU1o?=
 =?utf-8?B?LzR2SDR0blBYMWRHTlJUSkRYeHN3M0Irbk5WNmg2TDhKVG80d25VSlNnNGx2?=
 =?utf-8?B?cndzY1BvYWd5eTVwQUZqMDhFK1BYRUM4QjAyK3lERDFWWG9RZUx1VEJuTnpL?=
 =?utf-8?B?QURPbFRwMDhMMVFNOWNHQmcvUkU1T2RDN09sdXpReXorMjlpbC8rUitydDho?=
 =?utf-8?B?L3AxVmRFMVpZU2c3elRKZE5YNU15NEppQVM4aml0WWtoRWJyRDZpNDB3bUtY?=
 =?utf-8?B?M1dOMEJXUFNvVFhDYlV2Sy9EMkRzdXlhQmdYY1JTMzg5aVpWUnFMeWVjWGZv?=
 =?utf-8?B?VHZRaS9ZTjgycytSeklNMFdtOG9Fa29OdG9pckNUT3FrMktSYU1tTEZWejdI?=
 =?utf-8?B?L0lJNG5kTEE0c0hRV3A4MzAvOUVrdFdoOXEzYTE5Z1Nrem5yMWJjZUcwOWt3?=
 =?utf-8?B?aXd1U0NLWnc3eXhFVHRFY1lsd1ZYMmtYZ0htbURZQWFkSCtMeTA1MnhNTHN4?=
 =?utf-8?B?aEpKaGJURkVPWkdnVFgraFlEb29ZOHVGRFBya1lyVkR3bjlYV1NLVXpLdmNG?=
 =?utf-8?B?Y0dGUlJEb2lNdEFTeEc1c25aaFhxeVpUZC93UGVEaFpMcUhscDM1UTdoS244?=
 =?utf-8?B?cENQRXdJQWNrUFJxdXdKOGZTcDRlYzdRdXA2ZmFvb0tyQmV2UkhRWTVSdDlu?=
 =?utf-8?B?cEh4V2NHeDNGSG9WSkRaTXdNczZjdUhQVGNtQXlmY2hYZ1picWFKTUI1T25F?=
 =?utf-8?B?YjNmU1IwK3BNQVFJa3I5ZjYzNlp1c3IvZUFFdE9WWW1mMGtGVHhhb2MvcmM1?=
 =?utf-8?B?YStNVlh5bzU4SFA0Yy9UM0NHbEU1WVNNc2FEMURhdEx6WFowc1VQU0E1V082?=
 =?utf-8?B?ZEZLUmZ2bXd3UGhVY0ZYRloyOVhaaDduZC9YSHhMVUdIajVrVkRuR1F5dkRv?=
 =?utf-8?B?N1o4a3JtaFQrSXJrYndVOFVzQ1EvK0JBNmpmZXErQlk3VnNPTTUvMXpQUUdL?=
 =?utf-8?B?TU54VXcycVl3VzlQdXY5dnp1UEhIM2Nnd1g5WGx5N0swUUNaK2JxcWRlNzli?=
 =?utf-8?B?NFJyeVRWR0g3TFFtSk82QkF5bkU2cFNBbWRSREpBeHBVZ2xOc091Q3JDcDg2?=
 =?utf-8?B?Z2ora2ZHOWs2bHU2N09FZXZYQ1Y1RGFTaUlad3htRXp0NzlwY0RNc3V1UTNP?=
 =?utf-8?B?RW1CWHVFWStYUmFPcmNtT1JZeE9ZRlU5dWMwTTAyQVFjWjE5cDNhN0RlYW5Q?=
 =?utf-8?B?YkRSTGEwVkRKUmJsZ01nTnpySU8wNExlcTN4b1dXYkhnUXZPakdSSHRZV0Vi?=
 =?utf-8?B?T0FjZk9zUmRvSE9ERDk3SzM4enpUQkhHK3RQL29UN2FRM0dxUnhINCtDVUNX?=
 =?utf-8?B?b1ExdHVDbEM4cXIwZVB5WERJa0hYY2RMVDdlZ09NTEJGNmlXWlFjYWN5dFhx?=
 =?utf-8?B?L2ltS0xDLzFoUEVnZ0tjQ1dNQmNSM3hXSTJqMTB1MXZLVmpqVGwyTVVtc1Bo?=
 =?utf-8?B?enpDd0lvK3BwYVNYbWlDVm05WlZMS0JVRWhYMnp5RHcrMm1wUmhjcHdWNmN1?=
 =?utf-8?B?UnFwTGlYTDI5Z2J5dHlGRlhiRk1VOUdHOHkzSkp3RC9iSVRiMnZPYldJTkli?=
 =?utf-8?B?b2pjQzY0bnRCbVhPNmM5SEprUmJ3MlFLeHcrZXc3eit1cEFHN1J4aWF0MFZj?=
 =?utf-8?B?aFQwcGlYZnh5R1RsVzd0MVpXdm9XdFFQbE94bEEwOWZjQWQ4T3dycE1PbHdJ?=
 =?utf-8?B?amY3Qmd6L01vZXhNNXZFNTU5V2JLZHFqV2xkaG5jSUVSYTlHT3kzLzFuQWZB?=
 =?utf-8?B?NjZZeVI3ZytiOWJ3Z0d2eTZTVTBzc2VKc0Rob0VOaUFXcTBJMVJSeWdOYTRZ?=
 =?utf-8?B?NDA4WUxGNkQybWhJOWN3MHdOMHJ2NnBZRGVsMnVyVlczcGtaandRTUQrU3Fm?=
 =?utf-8?B?NGtGRndBMnl6ZHBQWUc1RkxEV2JYaDNKenpZRG95ZjhOZHFaVG9Qdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D3XHCG0THvw3DNZy6IygI58WI8IPrC4YY2WccyCdbx2bX4CKUXSjOJheHkJbOf+2aoWWc7RtRmq8wV9eND1/zb9LQBJQeV2qUmriEPgXW6feYcfC9NW6cM3OU57CynDSuftTQp9KUXe918KG4m3F3bp0MvdyCuV83C7IvPy07SNwn2vDbGJ2L9NtRao4HtF4wLTNa2kheFCr96GjZe3AirhGJAxlv86Aoj7zDyE0ywKmU6b1YSi1Tg2mpXa2tpL6YHG/+MOz2x1ARVJz6bQ4+o2Xfp40hkn7O59n4yoaeqzHJV1wQrkAn1DLRk/Og1cU9ls/JSbF8TUiJ1O/AzQjvAaWN9aePu8GQMz7yEzspuwEwIvz6QBbhlKB2TUf5fXWvqTKRw1zvIQaz/wL072oRQByLfziZ/DiYLwUzJ0zY16Bbwxi3+LPYScCThYwRE/rLadz7CJpGFu3mc0CG7plTSDNgZ0JzDGKmJKKOMqIwd2JXnbDZM7+2wtrrrCw2aDJai4Npyp47fJHeCHJLtw93cIvegWYIFTLPjMyPrihqdnHzH9pINmokvy1R1oywps5updZ7L8HAjbZgOR+5vdeSHmUtVvXdWiah/2tSCz00hw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952a0e42-704e-49df-2d37-08de52e6abd4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 20:59:41.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+cFds4Yq0u0HUgvpipRAYer2SeDhlLu1laH/fAh8jvv/FNKNEIux5O5FTK2FyuNAvgZf9iwyFiQpRRb31Mwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130173
X-Proofpoint-GUID: KZic0Dfh64GVAi04MYoE_iMZKPHm4tWS
X-Proofpoint-ORIG-GUID: KZic0Dfh64GVAi04MYoE_iMZKPHm4tWS
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6966b241 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jzrY2hYxtuYy4QkN-6YA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE3MiBTYWx0ZWRfX90Ll0tPrsDuB
 xG2jy+gB5pi3qDmvPa70ARgQfDgy+uIvpSZ7Z0pWgrlWN1L+dK/AnKDR2XMdKhx05tpLvDD8Vtj
 0s7cFjPeHGmQMjCt+ubOkICmrSgGHULJyrbcJ2Ffl2OqItHpwvgaWKFAJG3Cx0Kn8VZDDcbxxbR
 uHNtaB1kUBhMamoIOug+x8h5gcEg0UmdZA4hA8XYLDNd4QxZROPe/zMSN8DkSP/O8UrJ5kDLQpR
 XsYEKM1JuUHtEY48faDwjMHpMVbZyORLbn9wbU6BnTE6p9iGf3CVkzZT8t05psr5z+pP9cEyCI/
 33iKFPq1E0uyy67qG15U/Sf9bIXCXTsWcEpwdBjzORleJf4jNAw5GZc6lA7ynGgEff4tjRlL+1N
 coKbMeDnOM04VtHyJtbSS+h17QfswKE5y2t1EJvHGXkLhIbgTjvRro6IrDWrAjkpkdvQ41c1lCh
 s4u8BdLN7gJ+7+RSFsSAINiKiG75F+jZq0zcUSkc=

On 13/01/2026 18:32, Ihor Solodrai wrote:
> On 1/13/26 5:13 AM, Alan Maguire wrote:
>> From: Yonghong Song <yonghong.song@linux.dev>
>>
>> For elf_functions__new(), replace original argument 'Elf *elf' with
>> 'struct btf_encoder *encoder' for future use.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>  btf_encoder.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 2c3cef9..5bc61cb 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -187,11 +187,13 @@ static inline void elf_functions__delete(struct elf_functions *funcs)
>>  
>>  static int elf_functions__collect(struct elf_functions *functions);
>>  
>> -struct elf_functions *elf_functions__new(Elf *elf)
>> +struct elf_functions *elf_functions__new(struct btf_encoder *encoder)
> 
> Hi Alan, Yonghong,
> 
> I assume "future use" refers to this patch:
> https://lore.kernel.org/dwarves/20251130040350.2636774-1-yonghong.song@linux.dev/
> 
> Do I understand correctly that you're passing btf_encoder here in
> order to detect that the `encoder->dotted_true_signature` feature flag
> is set? If so, I think this is a bit of an overkill.
>

hi Ihor, good catch; actually I think it makes sense to drop this patch until 
we need it. At one point I was using the encoder in this series but it's not
needed right now, so let's wait and see if/when we need it later. Thanks!

Alan

