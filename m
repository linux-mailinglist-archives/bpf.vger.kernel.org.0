Return-Path: <bpf+bounces-62400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DDAF92D6
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 14:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18264A265C
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C62D8DB0;
	Fri,  4 Jul 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q75NzLXR"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF852D780A;
	Fri,  4 Jul 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632686; cv=fail; b=UcPMJ/EtVjcy1RWNbVQ2UTimusRgarnpT3+34ocBBIqOCi2vlGU5EYEVkzeG0N8V1kCaEMDMXO2BE8n4BLYeSb8LOASMWQPLuvWYACLYzzLAGtmZXZiYbxk+MQdku0fgr5cFIv6Js+gw6kTOs5vWoyllPX1fMSe6hnIQ5KEbqxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632686; c=relaxed/simple;
	bh=Et+LlAGiTSFN2HG+UnV5VW3Qp2oTkLyG1yOlMwYFivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l2lh11ZPC8S2Se5X566SODr4hirnPNN0V+P5QKBPy00NFMYil6kY9UWZO4RMQI5e+4rbshE9Qi3AKkGydoPnrV7vX/g7bOZ7s9yxBfDQQocUZ5RT7sCrHW2dmNdaOm1824DxHmGYQSdF0Jr2ww1+wvi82iPyCnCo1u8Zfc06JWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q75NzLXR; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNmqEKjRhq1xccpl2nRyNsQn5GiBXdxrtgYEOdene7BOHR2K3wjto7aClWWN9uBcIbd11Tc/hJ8QeOaSrP2o1HJ7Pf6IXPXGNRoO00S/XqyU0H1OB8GsVIOHW1EGA4m1ZEau5l56QzufQn9fXsjTf5/LplWtqtwh5RPYqJsz5Dtvi8swFS9niI/HsJ1yJi+pRGLLBW7SkRmaP27Q7bI4NJYBBKHu6wKnZ1AG6uYtrc9x68dCVJy+oR2y5ZJRV9BJRvkEJ2vfmbOofU47FzFMnfegA5oMj5NhdoXxoiOiH2gv5LBhO/5hEPBrh6DEnr4mhxd6kITUOPHviPK7hiTJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvEJExE8d/P9AxGY120Jxka00Ab1W8RFT2jevj4ruPQ=;
 b=ykhulpYJI0bKW21b+tiAB6vDGEXPD06TwEr5dSBy/EWT3XZqZ0b0L1oiW991FUGSicH55LcwGbMeyv5nZINB/oUi1uSTlHQzrPlwRlomTwZHp5lDbKK9OnRcOA+Yy3xxJRxxdUoL/itQj4IbC5BKoXP4jNxrbsntOMafcODF9RiT/XHvVU9aZtHPjmmWf/F4q77X9XUlMl9HU7/D24wUqvduvqoC1qfPlyl1bjgtcJ3RhOs70inNFcfPu9OIsI67uqDkScwsoO66JCO2TZOR4/EnT9l29OG98v/oc8af9r9ryBHzARZPQfnsCMI5Ms74LoG5qnT3DB2cNIn+qw+aKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvEJExE8d/P9AxGY120Jxka00Ab1W8RFT2jevj4ruPQ=;
 b=q75NzLXR6K9IEzAy5UyNhKdWYz05j6PpywAKlyh++1ByPIML5gKJNt2isT7wwVWUxuSOyLD6Fh9DNpUOolIfNdsC1TtqVmlqW2LObhTF4WRVrLhtHgSAacWMsVf+8p3JlUvIDms6lXeRcG++hgTZhmtKWXOfrMq4Vub786DWhkGzaCTF45pbdanDnPAK6p/LYycLVKSP7BExSswKbkHLJGgcshjWMJBOwE0JFuJbsJB4bTG7s8/pf2aISQr2jiwW/hn/TyP8+u2rNYCNCe49bgZF+RGdrrXxgR4ayzNqFPJ+32Ck27ATRAxdm0ND/Vt1h2Sr6y4UhSWLWq4cpl/Yww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 12:38:00 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 12:37:59 +0000
Date: Fri, 4 Jul 2025 12:37:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Chris Arges <carges@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, saeedm@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 365faa0f-0f15-46bf-5b1a-08ddbaf79c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhYbkVqQUJWZnA3OS9pS2RwdTh6S0VTcFkyWkl0ak5ZOTQyKzNmVzg5Z0VP?=
 =?utf-8?B?dklOWHZGR3crVGIvOFZmRjg0UGVYOTB3SC9DVTdyZ0JabEhWUGozekY0eGlM?=
 =?utf-8?B?TVFzR04vYVZhRmRpa1RlVml0T244T2dSdVdMV2JaM0tvd3JKMVYrbENleHh6?=
 =?utf-8?B?OEtFWE8zZFRRTnVqR3E4RkJCbUdYRExaMlBtWXR0cldYK0FiaVdRQTZ2T1ZV?=
 =?utf-8?B?MzdHbWlnOGxLdExibENFR2xpZW14OGxnVzFka09oWENSSlJReDk4Vnd1UkMz?=
 =?utf-8?B?dFBhdUIzUlU2bVpQcUNCUHRvMVFxY3JxZTYyQXV1N0V0TTRFNkJCb3lYdVNs?=
 =?utf-8?B?VkwyamtXd2x4R0RNWEhhRWdJaEJtRjFLcExDZkVoSk5LN0pkc1pOVVJrYlZu?=
 =?utf-8?B?Vit1V2xDbWV0VW9rSWdZWlZmbVdqd2pkQXQreDkzbnFJZ2Y3WXU5UVJSUmJP?=
 =?utf-8?B?N0NJWEQ5QTI1d3JocmtndzhFK3F1ZTVwdnVSZW9TaE5VWWZMQTRrV2JmSkN2?=
 =?utf-8?B?aUFaTGVOeVRSNlFPMjBiaVBwVGJWMzNuVDFuOTNtYk1pQWg4ZU0vYUpHdFNS?=
 =?utf-8?B?aXhQTDNkQXhDM2lMWHpZQ2FSV3o3T1dxMWpOdDZSL2VmNWdnMzlmT3JMUW5p?=
 =?utf-8?B?MC8xMCtsY1c1YU9lbDRmNFJnQTRZaUlZZWtnZWFpRDVLdjVQWWt5ZDY5QlFE?=
 =?utf-8?B?eUJJVE10T3ZJY05Fd25VTDhjKzBzRjZUQTQycFoxNm1vVS9IMGNvaTlEYnFZ?=
 =?utf-8?B?ajVHc09qTnN0OHNtNUhjdFBwcC9qWXJuVlVkQ3RISFU3Mk9nS0x5bG5wY29S?=
 =?utf-8?B?bFB6MFE4TXdhN3pORUM1NTVPSmZxSEtKV2hnNXhRN3dHWldHL2JvUFFFL0tW?=
 =?utf-8?B?YjRjdldYaGtUUDBYSW43bEcwSUhaNmx0UGZZaVRUU1gxcVJ2bWZhNU96UElC?=
 =?utf-8?B?by9Eb2hEY2l4VEJiQ05uNlhmejkzVzhTMGhWSlNQclZpSmRXZDNYZzBzN05G?=
 =?utf-8?B?VlZxcUZXZUJGcUlVMjlqY1FMNkJPdmgxeGpYTjZxYlhVVjZIRWtkWGNKb1Ny?=
 =?utf-8?B?WWoySXZBTjFSbnVlMXRQSHZBT2JEeXFZZ2ZlcGFpdW5wcWdPQ3RiekEvTk54?=
 =?utf-8?B?T2ZhbEpQWGU1OHp4ZHRJQS9KL2tOU3BPVnNYdWZiaDh6NGNROUV4QlNJK3pJ?=
 =?utf-8?B?cWVZVCtvZjRPak1sNGo4T2hWaGdLMDRML2hPU2VnUWlMQ2lCZ1BkSzJ3V0lB?=
 =?utf-8?B?bFlUYS85VFZzMGpuNFduTGpvKzVCam9sOWExWUt2emRyenJrQlVVdC9lWFBR?=
 =?utf-8?B?RCtGU2s4UFJMOUdwZzJhVjlETEVTYWpsM3BtMmIzSmpDMFF4YnRrYlQ1Q2xP?=
 =?utf-8?B?aU52SXRIUllJVndla3FBbURuVnk0RmU5Q21Ca1FyVG1tWHMyL1dqVzF0OEhQ?=
 =?utf-8?B?VWtFbklmRFFEcnVPaSt2YW1nNHJnbkdrRlhZMGdNTDc4eDMyMURJd1lROFQ5?=
 =?utf-8?B?YlJBd1cycmhiR1JnaCtEemZOZTBhQjRZYUpWSGpNRVlad3FQenMxUnBVSmF3?=
 =?utf-8?B?NVFnREhIZmJxR3JZNzRxMTQzOWJ4Z2JJSDl4TDg0ZHo3d3hwTzVxM05yVVJz?=
 =?utf-8?B?d3grWnl1NHZKUUMxZlV5c05pSmNDMVhJSk5nSk9jNUdwV3MyUjlLMW5tZWJ6?=
 =?utf-8?B?YnlDaXRub29xODVKdVllTGU5c0ZLUkcwNHE3dzdkYUhzeHd6ei8xcVVkaFg4?=
 =?utf-8?B?eDZzR3lWZDQyaUdrZm1ydWZ0UkZIOTNNMjJ3YW9xdUMrL2p5cXZweXhHb2Ir?=
 =?utf-8?B?UkxUNW9YakkxNmpqejNvaDh2NXdxRmJmOXZUcEtyWkdlOWxUMkhHL3N1WVA1?=
 =?utf-8?B?Ty9Oa1VhQTArSXBHZDI3MHJvZlA1K1h6TlBmRmlhWkxvYW1WSW03c0dsekUv?=
 =?utf-8?B?TDNsanNBTk9SWm55MG9SY3pwbXhXcGs2Rld3N01ub2tKbzFncllVSHM0MlVt?=
 =?utf-8?B?eGZPcVFwS2lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1xS3Y3dlFxSFJNNk9qUjIyWG9TNG9pM0tuVVNBQnpmZXYvbU5ydUdoYTBk?=
 =?utf-8?B?VWFIQThjSHF0aHNSdkd5WUhCUEJzVnNhNjZlblFBN3UvSUplaEdCZEo1ak1m?=
 =?utf-8?B?OStsWHFTMzkyTTFvc3JDL2VMK3NUNm9qRGh4cnMxcEZpK1Vmd1ZjY2hVUHln?=
 =?utf-8?B?eU81MFJ6RHlrVGx1QmFFZ1d0b3hFUTFCeUllK3RDaFUzc2RITUdDSURNWFhE?=
 =?utf-8?B?eVdRQmpzRmJFYlNuMU5ENUlXK0tZdWlzZ2Z6Y0ZPZm9CYjFXRGFLaWpEV1pQ?=
 =?utf-8?B?eDNrdEh5c2dYZXJSNEh4Y1ZlMW1IMEdsdUpvekdHUU5kc2VYTFE2NU56ZUw0?=
 =?utf-8?B?MjlDSndPTWNrRElLM0dTSnlzaC9WbHB0MytmbDZnK2QrZzBmMHZLazd0eTYx?=
 =?utf-8?B?SS9zY0xLS0dvbWRUaW1DbmFqMnJUL295ODMvOGZzck1wVEJLTkVZdStLK3Zn?=
 =?utf-8?B?M3ZDOHhQR3JydlRmSmZ2V2NsYjVOY0d2ZjlpZlArZGpyQ3AveDFyalRBVzlt?=
 =?utf-8?B?b0lBUCtuVmZ4L0YyUzRYelBHTWV5WnVJN0EzbWlEMGNtRzNYMjdiSHBrKzRt?=
 =?utf-8?B?ckU3R2VyMkdDR2RRM08yV1oyb0FMU3J2SUUrc1lMc2tac0VDVVhWQ2pldTNu?=
 =?utf-8?B?YjdzWGtyWGxKQjIzQ3RvS0hZZXl5QTE3T2pJeTB4Q1ZoTGYzam0zdzVabHND?=
 =?utf-8?B?YUlsZlQzTUlVbnVYdCthUVQ4QjJqL0xVc2lBNEhWTHQvOWk5UEJrTVFpeG45?=
 =?utf-8?B?MERLV3NpYlRhNkYrNWtia09QU2FML3hIRjdRNGQ3ZG0wS2h0M0daZzRFQjFJ?=
 =?utf-8?B?Si83ZHVTS2pLTzJpT3htckhDQXUrbERna0p0NVo4NFdmOTNHWldoYTBLOG1u?=
 =?utf-8?B?RFQxM251N2Evd3lVcTZKZnhXaS9iUUVzQ1Q5bkpJeEI4LzRUS3NVbFBRdkVX?=
 =?utf-8?B?cXpuRHBrTURyaFdtMVdKRnpHZUJuOHFGbktvMmZ4dDhjd3JROTAvWkxOZ0gx?=
 =?utf-8?B?LzNVU2VId29JVm14TUxybG9ia3YxQTF0RlluaGx0RFFGdFJXajAwQURiaExR?=
 =?utf-8?B?c3ptTGJ2bFhrU0MyVENZVUc2NGVXUGxaRVpwc0JUUy9ablRFNTd1N1Vac3lU?=
 =?utf-8?B?a2hnNklzTmFwcE56Qms0Y0pYd2E0cDV2QWdsOENYVTdzZFdUWXBCQmRDSGtJ?=
 =?utf-8?B?c094T3pjNnBOc2tQbWFyZ2Q4dHBxTlVGUGMrQXdXWkp3QzBYWTlMOEdQU3NP?=
 =?utf-8?B?a3BqbFdhSVZ4TW56Y3k2K3F4VFoybzJSQklWTU0vMGpHVVN0OXlpekdXdm9k?=
 =?utf-8?B?U21RVHRIaExTR2hNMER0SlpWZlIrQTRnblRWWGYxcG5EYnp2RHFpOWlYWkJE?=
 =?utf-8?B?YjczeHliYVRUc3R3Vy9OaUlCZGx2M1ZuUUswMUtGUWF2NXlaVFo2bnNHZUln?=
 =?utf-8?B?YVNVVXhCN2NWYjJJOTNkZVcwdFRmK0ZlM0NxVzZKS3JnYytJQk1nRUhPYytl?=
 =?utf-8?B?Vzd5TlkxemhZbVNtUnRZMHZWaGVsVHhPbE5MSkNzSmhMUWxWaURPSGhONnJD?=
 =?utf-8?B?RGNGZDdpZG9LbkJ2QjdYZDU1ZklpWGdYZnljSm9HUnczZDdLNjlnTDJCSHh0?=
 =?utf-8?B?cTZ3cGVDRndCMGJ1VGNJNDdYalRURDc4VEZMaTNRMFpwSUdnamtxM2lNQ1ho?=
 =?utf-8?B?YkY0MmdKUDNLMWxpUE0zcFdPSVI3QzVWbG9yZDJuazd1SHlDR3hPUXJYbVFn?=
 =?utf-8?B?U3o5bjd2RU9ydk9HdU5CbGtwODd0R1JyWEZ6T1gwY0dsSUFxRzV2OHh5eWQ2?=
 =?utf-8?B?aGFhSEdXR3RCcERJNytaNUZxMEdzd3AwaFNlcUVpeW9NbHRCQ3J3RkhiVmwr?=
 =?utf-8?B?UEczemhrQUlISWdCTHgyMVhzL3BHVjZTQ2RFbWk0cE5SdVB2TTlMU3ZpbzlU?=
 =?utf-8?B?UithMlpkTnh5Q3k4Mkx5RTJZczQzd0dTZjJDMFY1VFJsMTY0VFArcEFtb2U0?=
 =?utf-8?B?andWWEYrQ2tkcjFUUlBqZWVFR09rTmQxNklmb3FJdm1aNzE1R3lBd0JhTzlO?=
 =?utf-8?B?emdTelpmdU0xWmMxR1NDQStBa0hqWnRObjlrODdneXY0TTM0MnNmc2pIZUZS?=
 =?utf-8?Q?ymaCcV/rckH5zgUR2Dqs6KUPI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365faa0f-0f15-46bf-5b1a-08ddbaf79c0b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:37:59.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Zd8SeIwEMg0tBhjgyAl2XMrNGEUzWHA/wi8UTo+JPuQW5Htwq2NE+jd+qj8SJXwKBe5dVosFq7jjDsAcjkc0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

On Thu, Jul 03, 2025 at 10:49:20AM -0500, Chris Arges wrote:
> When running iperf through a set of XDP programs we were able to crash
> machines with NICs using the mlx5_core driver. We were able to confirm
> that other NICs/drivers did not exhibit the same problem, and suspect
> this could be a memory management issue in the driver code.
> Specifically we found a WARNING at include/net/page_pool/helpers.h:277
> mlx5e_page_release_fragmented.isra. We are able to demonstrate this
> issue in production using hardware, but cannot easily bisect because
> we don’t have a simple reproducer.
>
Thanks for the report! We will investigate.

> I wanted to share stack traces in
> order to help us further debug and understand if anyone else has run
> into this issue. We are currently working on getting more crashdumps
> and doing further analysis.
> 
> 
> The test setup looks like the following:
>   ┌─────┐
>   │mlx5 │
>   │NIC  │
>   └──┬──┘
>      │xdp ebpf program (does encap and XDP_TX)
>      │
>      ▼
>   ┌──────────────────────┐
>   │xdp.frags             │
>   │                      │
>   └──┬───────────────────┘
>      │tailcall
>      │BPF_REDIRECT_MAP (using CPUMAP bpf type)
>      ▼
>   ┌──────────────────────┐
>   │xdp.frags/cpumap      │
>   │                      │
>   └──┬───────────────────┘
>      │BPF_REDIRECT to veth (*potential trigger for issue)
>      │
>      ▼
>   ┌──────┐
>   │veth  │
>   │      │
>   └──┬───┘
>      │
>      │
>      ▼
> 
> Here an mlx5 NIC has an xdp.frags program attached which tailcalls via
> BPF_REDIRECT_MAP into an xdp.frags/cpumap. For our reproducer we can
> choose a random valid CPU to reproduce the issue. Once that packet
> reaches the xdp.frags/cpumap program we then do another BPF_REDIRECT
> to a veth device which has an XDP program which redirects to an
> XSKMAP. It wasn’t until we added the additional BPF_REDIRECT to the
> veth device that we noticed this issue.
> 
Would it be possible to try to use a single program that redirects to
the XSKMAP and check that the issue reproduces?

> When running with 6.12.30 to 6.12.32 kernels we are able to see the
> following KASAN use-after-free WARNINGs followed by a page fault which
> crashes the machine. We have not been able to test earlier or later
> kernels. I’ve tried to map symbols to lines of code for clarity.
>
Thanks for the KASAN reports, they are very useful. Keep us posted
if you have other updates. A first quick look didn't reveal anything
obvious from our side but we will keep looking.

Thanks,
Dragos

