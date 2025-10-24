Return-Path: <bpf+bounces-72090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A7FC06603
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC603BBE86
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C031A067;
	Fri, 24 Oct 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qRqKuuHD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zdlrQgc0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8053195E8
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310522; cv=fail; b=JJ7yD/i5qYTghPzQxu8Itf9DpxyfFMhkvbFjlaRH8Uw9mDX7exa9abLRnuEcfRdAyBNUoSbheBQVZrPCyGsnpa9mmjhdxoMuXM9Kc8Ciix0DIXBtTtkshufv46o1BFbClIqAtEhAD2ItIQUIiRp+hbA4jUHAUC8K9YQ32DONFrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310522; c=relaxed/simple;
	bh=BQeHNAvMl/cOclXAbWHGP+1bIn7ktgdhXCWIrJ4lETo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrWw2w6FjBcDNiLN/p4vDQNdx0UV+STmL/76jaifgYgu0BrNSal8hSnSzi6pu59GMJPSeuBG0sTk5qYm45B6FAmZO+8Ok526Tn2FdL2nTxrkuL9vitwkPHmCwW2IpAyWfxLZcB62bOPnrVIpjl56/isDTm0EQfIXYJ86Jkb5Yhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qRqKuuHD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zdlrQgc0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OSCl015157;
	Fri, 24 Oct 2025 12:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZjuiUUiQrNB4FRNTVK2wD+/Enkx4OObtTPUpamOKlts=; b=
	qRqKuuHDSIfwD1miL6mvgnE9pSLzWjtHepWJu5pxB35CX/VzCrS4I2yiZLjZgppg
	q3CkH19CeZja83yZDSJKwuFPNJq3/CKj8jlW69Wf2wPz+jHlHq/Wsl47cwU82kZu
	RYMpY7jlSNoTka41POAawt+kF8Xo1kZQ1KhaMK1pIRYBZtsgoj/4o04jirF1JfAs
	mB/ZW2iQEAZz17J0NdiiVpE/KqfHdwZWGTaVw8+3PRiCmwk3szrMOyzMl4sI7YGk
	2QpXept1tVf5J8rMg1RoeyyFAOnIeCpcLnrcTXmYI4+a8EjU8MYWJ4pPIoKbWNwV
	yB/SGLVObo8Sdvyi35Wqrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah2ce9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 12:54:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OC4gLg030454;
	Fri, 24 Oct 2025 12:54:53 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgwgt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 12:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feSZUxBudnyUiP3FvWKWNLTtW9bmfDTxSOiwWRU2V/OiPNI5oBDCGRmoqx5hiajv+Fuf1AJ0C6p8+uQUG6SGk0XWmEg4u63cnijE5+rww7JnlXE+2HVbv+G1dgdL+VLezDQWPPX8ktCD9WEYD8UbAcN8cnhKloEEMCgYnRtUC2+OZQnxg6SvG/8tz2ZV1DBsitMRyrHCzo9NRSH5hF7eSbKkNauRnDLk4qdSuKhySWHOatNXEScUNh9EMkz5AUcdPS4pCf01I3Xxvc71ScTSePKM/Wp9WQ9HqGbJas/XeA2a75zLOz4RL3OfRnsImRvEEgbKLY4EKBAPaoLOblwIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjuiUUiQrNB4FRNTVK2wD+/Enkx4OObtTPUpamOKlts=;
 b=YnqeqlX7gs+/M+Voedfoy5EG0GOPqXtzaVj6F9wgg9rOZp9qt+SFBy4rPaS0EIKq39oOsSYIu9A0vn818abwOyeAkghbQReLKWZgOdvaFjAstIUFGC6gR7ZWtLBJxGbhcbsivoyG1AMsKCZifSJRqlR8RTtUDp/YYsn0at9VMUeMaz2Q26tWfR57IiilcFksaq55ZCkK1owhdRjvvMJYc88ivTLRk9WUFtdhu+YNtUnRhWmYDg/Qey8r+j+dQPhgXQq4RzHcwirvPUnT8FHeaa7Ip/WdQIuBc9jlfqfarbNa5qoIomTBs7qN859PCPWc2azlAf39FMyuN7TqQubMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjuiUUiQrNB4FRNTVK2wD+/Enkx4OObtTPUpamOKlts=;
 b=zdlrQgc0sADzVSDdS3M8YJI6LcdrPrHvbLC5R4aLShjuPdCbB221+dVX3yeNKNsrc+7hkeZ3KXAbwa1AHAD24I3EBcwlGHCDsxu31mtDldFw5tU1svnPNKGexNFXu6pqg8vwPmQtDZIp5UVi/cAdW2KahsF50uRj7cENHA1Y+lI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Fri, 24 Oct 2025 12:54:50 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 12:54:50 +0000
Message-ID: <ed7bbaac-f55f-45df-8aeb-1f8939d906a6@oracle.com>
Date: Fri, 24 Oct 2025 13:54:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <580ec956067975acbf18d354564be3459503ed63.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <580ec956067975acbf18d354564be3459503ed63.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: f567e524-ba8e-4e22-8131-08de12fc84d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW5qeXNlZWJ1QTdWWE1lbjNHNThIc2pubVhxYXY2Ny9KZHdkUElxS0lTQlBr?=
 =?utf-8?B?aVg5RFdRdXFCSmVRQnBhaFhVVVRZNWZ1OTZTZmQzc3FNM2cxUGF3UmFzeDRR?=
 =?utf-8?B?aTIzT1hMTU40TzBaNERCWDE3V1BoQjRhb21NS3luTUlGUnc1c0s5Z0l6SHJV?=
 =?utf-8?B?MU9UWG5YWk0zRXB2UGpkRXQ3MDhtdFdpaUlkR3RTM29DdHNaRGpPdDNOemRV?=
 =?utf-8?B?U2Y5R2tlck1oK0o1bDd1RTVINStCWXRMczAvZDF3MG9XOTA3N2NaSjRTQ2Nx?=
 =?utf-8?B?VWozSDlsT3Z3a2loNXpRT08yUUJNaGh4aGxsZVAxRFpvTHVoUlI5Qm9VcjFK?=
 =?utf-8?B?SjFKenIrRnlKZ0dBaVZ0M042MlBuZmhSS1JTeGFJdXVxRTJPZ0lqVmJ4dmw0?=
 =?utf-8?B?aVhWWGRLUE5OZytYL0luK0pyVUxnMDh1SG03SDhPVE04TWhUM2FJVnl2b2ll?=
 =?utf-8?B?am1iRFF0YjNWcDY3eCtQWWtXMDBESnNueWlwTW56a0tpWjBuc2txanNHWGdD?=
 =?utf-8?B?SkZYd0Vsek1DU25GOWN6Y0dyRkN1RCs4WmtpMGk5cDB4d2pMMnJRbHh6T2xx?=
 =?utf-8?B?dVcxMVJmbXNHTTkza2pKV1JlcUZlN2xKZExWbXg3bSs1dWxTMnRuUWFKbmhX?=
 =?utf-8?B?QjhxRGFvZVp5MlFLa3Rqeml3MlNRSGREVUdYTkFiT3A0Tk10ZllvUUFSeWZj?=
 =?utf-8?B?WXR1VVIzaHVpNUNmMlUzZ3htVUNnK3R1K1pKSlFvbU1hWkk2Y2I5dDNDMDVU?=
 =?utf-8?B?ZlZuZUFBbUxOdWc1U09SSEJKd1RjdXFwUzRTNFJIVC9RY2FZK2duS1R1TS82?=
 =?utf-8?B?QWI1RzYrbEpNZmxXZnlJL2Y2ZVNPYkhoVmVlRnRmd2FmVGltRTlVbFRQVjdN?=
 =?utf-8?B?MVgxK2p0UTZ3dVU5Zm5LZ2ZWQk1wekVFYVp6ckRBWjRQTmtBSHptMFRPRHVj?=
 =?utf-8?B?WWRldUdTRVBVYXc3TDhja3cxd2NabXNleEZGR0xTS3BiazY3bG0zQjcvRFc5?=
 =?utf-8?B?ZHRVK3phWllSNFkrSmQwaEtHNjl4R05jOUp4KzNhcXFpUE9BYkxRTTMwVHFZ?=
 =?utf-8?B?UnllemMwMGpGNW51UWJoSkRHWE1FNW16Zk1NZ0pKdCsyY0tERWxMV3huMnhN?=
 =?utf-8?B?eXBsSEFwUHEyUWhpTm5NZnE5WWdxOEdyekJ5NUNhc0xhOVByNUIrVXFibFFF?=
 =?utf-8?B?Q0YxSUZJNjVHczBOdlFxY3FjK1MxbjdKbW5OQ29ZNjV1NzVlSW5tT0hpY0JX?=
 =?utf-8?B?ZmFJbTMxbUU3cnZpbDVVQ1Q2ZEl0Q1NPNW1mcGhGbjArYjZscXRTRStYTk1w?=
 =?utf-8?B?ZC9US21CSVhKYWZEYUQzT3RSbVVidkFPbmN5dWRJTDA2SEpQVC9WTmhMVWVz?=
 =?utf-8?B?MjFsNmcxMTdHalNnbUJmd2R2RFRlZXpiRVhxY1dyNDFlWHl4T01HQXRtQ1lP?=
 =?utf-8?B?bklEd0RxZ2hmUnFha3cxUSs0UC93QUhrZmlKSk9ibUxha1F3d2ZzU0FIYlpM?=
 =?utf-8?B?Uktqd3R2emlFUmthNFgyMU9vY0p2bmk0cVFOeERUcStxZ2I1V1IrS0hSdHFi?=
 =?utf-8?B?eGVjZnpiYW93bkRlZlRkTkhnNVk0QUJmSEV2WktoOWs4WEVybVFIMXN0N3FQ?=
 =?utf-8?B?bld0QjFpNi9pSlBOVmRsUlJsc0gybkxGaXhOQ0VseE9vVXU5Vy9OeFd2VC9l?=
 =?utf-8?B?aXVmdUZQdnFrL3BwNWQ5VFJpWmFCT0pybGFHcXBuZTM1QjdiLy9xSnZuY2VI?=
 =?utf-8?B?d241NnM5TmhnYkp3TjhIdDVOVCs5eXlva1JLUzFuOXRpM1lqMUsvOTZmaDBM?=
 =?utf-8?B?aG1UYkdMVVJmVExjUGYvbFpsRTBIUy81Q0kvR1VTTnRqcWw2Q1NOVFRhWWY3?=
 =?utf-8?B?WXJobTdJMWtvbzR2eS9SeE5WdFZsZ3A0RjdqUVB3bElOSU55bTVJZnMzdDZh?=
 =?utf-8?B?MlN3RzVnT1Y1T0pJVTBMdzY4ZUZqWE9na1ZTSVJNd1NidDJRTHdUZmQyaUJ0?=
 =?utf-8?B?YTQwU1l3emV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2d6NnFSalIrbzVHblhocDJBQlRvUWlkUGdOeFNzcFZOeEE4V01XajMyazFQ?=
 =?utf-8?B?bkhYdFNid2p1SnlkU25HNGlodGlWaWFOS0ZQcUFtSEJPbXh4a2k5b3BlRmtK?=
 =?utf-8?B?aXkvWitDODNxYmREQkxMMi9PTC9GbXdHc0ZrMk9ZN1Nra3VXYituNGRDSFBk?=
 =?utf-8?B?elZkM2JzVDBheGxUWDZrSCtDODdVaGVqWGswa28vZ3VlU3FkdFA2eGE1Qys1?=
 =?utf-8?B?a2JIV2s5UkgwazgvMHZrb3hBK3NhM2tTalluRzJ3MWU4OU9DcTMxWVhKTXR0?=
 =?utf-8?B?YXU4MGV5Wk1tcXRkQ3QzYmtvRmpuZzVIS3I5TnBRdm5KQ2lOTUkya3ZLbWVC?=
 =?utf-8?B?cFJQc2RmMU1qVzJGVEdqOXhkbEp6b2NRVXMvMjFtREJFdWI2dWpoVTVnV0d5?=
 =?utf-8?B?c1lTNTFYbjR3NjZpUUU3OWhvUUZOOGFoNGs3azNxaG41NGhlNEllZ2pSL21u?=
 =?utf-8?B?RmF5VDdPOG05Rml6eFNweUI3aEV6T1g4N3JmWC9lUWFXQWEyeTJtdWI0TTFS?=
 =?utf-8?B?cXdnOVVaelcxWmx4YnVhRy94bmtuaVJ2UmNBd1BQV3JPOUU2T1ZKeFVxZ1BL?=
 =?utf-8?B?MGhwLzFOZkJreTJPd2h1QjAvU1lTc0cyTTFFcXE1VFkwdGw2cEtwNGU0RlVG?=
 =?utf-8?B?N0ZTeXpBdUJiVWloUDYvV25meE11ZWxEdXBaNFZEQmJRdWtFTFBNU3YwYXRk?=
 =?utf-8?B?Qmdna3NYMmQzWnlrSzduaXZCb0NoOXRhSnJvNDkvZGtMM0o3SVI3WE1aVG5h?=
 =?utf-8?B?MWtwYzFCVXlaRlB3V3pyeHNmUGE5WCtIeWQ5YU8wSGc4MWllU1pTcUFnT0xL?=
 =?utf-8?B?TE1TOGhiRmUzOXlZL3V6cjNBdTNLejJvdElGTXdsdHVVNzlSOTBaWUd5bm9V?=
 =?utf-8?B?bG5XbTc5dmFEMVdOdHRGN1h2L2dmbGttNG9kN2U5VVpzN2tXdFIzcVdkMkZC?=
 =?utf-8?B?ZW91c0xSZDZrTXlhV1NUbWV2UjIrUlNrOEZNdGx1emo3UFNDWFVHUXlqU1E3?=
 =?utf-8?B?cWR5Y3ExK3dKOUlwSzBPVzQweUZvdHMweFNrTll2R0g0S1pEakVrSXI3VUFC?=
 =?utf-8?B?V0d2aEtCNHVBck50cWgyeExxdFJjbCt5TXAyZGZ0bGtUdFZSeG54SjJXUkxp?=
 =?utf-8?B?SkFQYTNTcnh5QSs5WVZTczg0bk16MUNPWlQwTzNJQjhveFpTQlNKa2JqaDVT?=
 =?utf-8?B?RExZbFl3SWU4cGVyUHFTMnNBUkJNbjlUdUpqbHY1bEdGMTZoQlJYbmcxdjFw?=
 =?utf-8?B?UXF1REYvZGp1TW04OGJpOUVkVGVndDFoVnVvazdWUWdDVVRFclREejh2ZkxN?=
 =?utf-8?B?NHNXM29hcTBlbVR3R2w2RzlCNG9naENJWERYVld1YmJkaERGdTFtMWFQd1Fn?=
 =?utf-8?B?Vjhyckk3MkFzbE1MK01WN1FGczZUK2FVMFkycktRb1lKN0I1V2tiRVphMWVn?=
 =?utf-8?B?cU1nRktHSUFMWGJJbVdsbTBYVHhUY20ySGZFVFRITnRNVDZ4cnUxK0l6UGlJ?=
 =?utf-8?B?bnpaM1ppNEsycU82ZnMrcmtqRVNkakdiY2R1cUhKM2preG8zL1VZZG1HMXBz?=
 =?utf-8?B?U2tXcERFNkZYVlRwZkpvOWUyTEw5SUJxQlpQbG5jN2FLWFMrMWFrdGt3NWlo?=
 =?utf-8?B?K0MzVHdhVk4yT0FDZEJ1VWt0WENtRlNsNW1lVUxoSU9hZTJScjhzdEVPcDVO?=
 =?utf-8?B?aDZjTlRBcVZodVZ0V2VxVnJvY1orSlJBSTNkZTB0ZUlFUGlwRS84OTF4T1JX?=
 =?utf-8?B?cW1NWXVlcGFkUE04Q09wSzJJcGg1T2JtdURld2ovY0xYRWpZVWZYYld1ZWds?=
 =?utf-8?B?ZDh4aEovbkZHUitEVEx4cUZpWHM0ODlQZGpTQUFUcms5MGp5SE14VCtiVDhL?=
 =?utf-8?B?WjNEMVc2MGszMzhENUNOamlpb1l3N3FkdWswOXVVdERuMGs3a2xRbTdLNG5m?=
 =?utf-8?B?dlZkM29xZzRPRGJpYnIraGwzREJXVlRLUFdYSzA4VEh2bitOWTlwNWx1dmIz?=
 =?utf-8?B?dm04NlNya2Y5aGlRQm5WZnlySDk0VDFuMExlc2JzcFJEb3oxajlDTTljMkJ3?=
 =?utf-8?B?WmNwSUh4ODBEUTc4VW12aTZqTHNtWHFjL0E4OUFPSFRlWGYzUFV6OUMxVVRv?=
 =?utf-8?B?L0VubGxzcmtoRndIZ2l2VTUxR0FKVVJCc3VpN2VoZ1paQjB4V1kvMUlFQVI2?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zuJ55u8qhDUeZPH8qAWyef2cCpH+eLbnN5JsG1D/bnkxXgRG53MjnQ+JexQWgKPtjlHlYGIlGbPGDi5ewPo/bQoky4gIo7+0PGAWh/ivTGFo/hs5lZ/sKe0MjA3hFmz5HaIQFZHNYpZ/VNKu9Ujv0Jjzu2pMI+ASJgOpEYlOWMqFusJ+0jav4p5sV0sxhdz3BJ3wDkzwnnuhSD6fA2mfjHQiPUA7mwQ6S5vEUJb8/VA9dhAupj7pvACXSfOL63PKg60T31zSI0ZOejh9vyNtoGaaD8pmxIC0UeBcNmfI5Hge1VKVZK7xrP1uULcB8G//jsXAARuia5ylgdm3GMSlKl/f3m2WBonUMMkNMfS5uWSffxbmblYeNbrKYGf7WMbRBvXXG6VoyhIVrbux7FNvuyt6b+2nM0gsO83+hf7aWKZa6GHzM4syHCdU+S4ILSnVD2kWEv0ix5qGk2iCAHlmu3dTjz/mRjXXRDCDlj9CbyJHzLwysQ8D1LzivcvPQPYl7tTwcvhIJrgX3bEAW43IgxJDAWIbYxZtBJzQHQBujBdQlu7wXnZjc6S2eUoZ596WF6uem3fy7QkDXp7UuSvSj2oVEiht0zokSu5+o9CkVww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f567e524-ba8e-4e22-8131-08de12fc84d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 12:54:50.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDL+UQNhqMSy6upf5r+66wQYBN19PD4lQMLpbbaX6IVKlPkByQ/iKqHteB62tDWyp8lavCuZrtIdSEs3wlRrRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240115
X-Proofpoint-ORIG-GUID: bDpkU5OajZM8kfVZ2wubKG_8rUZ6Hpmb
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb771f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QcG3AlROMBRcIgnpWw8A:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX19mBYZ6FhEPo
 VWZzDJWoAfdcoxvJ+WDlUevScGWt3ZYHOC5FjLA96MKueuifBz81rC0Nr14P3C5c0ECb5ug9izw
 r7goShZEg2SqBZ320JWeOvD6Z7MeQTy6CGrCavr/3uCiC7v6+M0ZPmkDXsuDGBf0iucdQLh5VJe
 v7ofA4KUzGfTILGCDyQ1IsCsVnZo9gm8NbfnIqYER8AjxkcWiKJQ8a2U2cJfbGIR5FsL18KH91B
 hEJ+tS1f+T+mz65rRbA7oWTYJi0MsE0DgnEHMxajPyouSExP6wFmBvGls4xNtHK/9nxzqsw2Nzb
 o2qG6GYoQqnEuT2kumlDN0WI8ijpCTN6B+eHynyFyT8cGf4Omq6iztauSST2h7AeH70NLrN/4Ik
 dMyJHUn6o4n5mYXr+fNm153BZ1A9AB/n+wnQG4xw6x9O+NGiN40=
X-Proofpoint-GUID: bDpkU5OajZM8kfVZ2wubKG_8rUZ6Hpmb

On 23/10/2025 23:32, Eduard Zingerman wrote:
> On Wed, 2025-10-08 at 18:34 +0100, Alan Maguire wrote:
>> The Linux kernel is heavily inlined. As a result, function-focused
>> observability means it can be difficult to map from code to system
>> behaviour when tracing. A large number of functions effectively
>> "disappear" at compile-time; approximately 100,000 are inlined to
>> 443,000 sites in the gcc-14-built x86_64 kernel I have been testing
>> with for example. This greatly outnumbers the number of available
>> functions that were _not_ inlined. This disappearing act has
>> traditionally been carried out on static functions but with
>> Link-Time Optimization (LTO) non-static functions also become eligible
>> for such optimization.
> 
> I looked at patches 1-12 and at pahole changes.  Overall the changes
> make sense to me, it's great that this is finally moving forward.
> Left some minor comments in the thread and on the github.
> 
> Could you please post pahole changes to the mailing list,
> to facilitate wider discussion?
> (I'd like Ihor to take a look at the btf_encoder).
>

done; see [1]. There are a few issues here that will be fixed next time
around, but it should at least give a sense of how pahole will handle
inline encoding. Thanks!

[1]
https://lore.kernel.org/dwarves/20251024073328.370457-1-alan.maguire@oracle.com/

> [...]


