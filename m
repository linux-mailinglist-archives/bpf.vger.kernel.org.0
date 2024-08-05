Return-Path: <bpf+bounces-36398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D90947F0A
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF40528395F
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B313D24D;
	Mon,  5 Aug 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mb1jwVOZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mrPGRm53"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C51376F5
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874529; cv=fail; b=gFij5yyH6IiKu+u4HCnTT8oE7Yn/1j5O41NSoqRPk1Pn87LvPYhTjzx0Y55tG3O58PLIkCdNRZLRD7Xr5y3Ftn/sujxgpviAJ28/IJRshHDXXu7X7EPsTQ77p0GwNhr7KwSQtiI+1s7VWJaTJTeKpp3RFrJjqFUaZnBMmsNohPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874529; c=relaxed/simple;
	bh=6i8mW1AabgvolLzv0mbHk/M4Pxbe6d9ZAFBMwe4rG1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=G8h3QjRymaoTkmPSCqEuZUhfYysxQHu/9urRE3JV9aWiBzW+23qWyfO5Zn40B0mh+1TT17wHCZ+E9Z5AWw0dsUUvDOO7UrwkET4/pShvztUg+P94e+h1OVPui4Noi4oSdEoSpi9GTSCPnAFfXo1p7MacbcLBeAT3nunSuK2LMvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mb1jwVOZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mrPGRm53; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475FtW0U013494;
	Mon, 5 Aug 2024 16:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=kq9+2GmnqQurx+NWbJlyxoOomNMprwsYP4nlPqc4y5c=; b=
	mb1jwVOZiOkT26sqoX7D/i8iWzgquv3xD8iHexPSaIOu1PfHTbOtQQNPrDQy2XJC
	2/h48xXB8t6fZISegHN0dOpEp5IStZq7b0x9W03V9hLp9RzeDkn6UzpR6mUsXvzB
	dwRhHqQ70o9cSFG6KQYLeNQOa1XFpqiHg9YAEX5zs1moYfOvZ7BrxeYq2Jhl8ySh
	RM+wpBZOc0lSkQWJNtT7vnq1uIlZZ89er1Lm7fc8lx8VABrYXYQ5C60Vi995xzYO
	YT1RL7n07qK5tR2nrGhIix4LX9FAqbW/XVry94kZkvsVm+IEiZAj1B1n8dd/WzWE
	PLnQMSDq9jDWcDkFBdLCCQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfak2fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 16:15:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475FNFnN027465;
	Mon, 5 Aug 2024 16:14:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0dr5dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 16:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPXEAc5K/LTYCW8U1+WoY7UxHoNrr1TZ6aJSINI6Ywg4mpk85ZR+JHe8s0mufCb7gjVGVARZz2moEWbFjMlgYpft4ql9zMLET+6467TyWwTS3uvv7N8DoQsKdLU4Je0jNsGBchAym9Tn2ZJwQ0lfbfGmGBWuDLjMVX5lx8U+A0LEB/On1nizxGcq5IwTL4yYLb9FmnkhS/ER4p5AY2rbGdXUl3qQOwyUrkF2CbX76GHt9bkl911RSxm4P73qheyFeyMYMArEWIqty0Zc1qgDe4PLzP4RikBoES/wPanbRJ6CHcRJ61lnky1OqQdmlBuE50kfknKoUD8XGlXhKnnZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq9+2GmnqQurx+NWbJlyxoOomNMprwsYP4nlPqc4y5c=;
 b=j/aIHRXM+R3JY6CgnS7Pm2mCF9EkPMfP45k07hN01DZ493BHLJV95ZfdkKEhw7AdBsqV2lSO2Ke4EgkR3aKoREokoq7+dftuRsyEIeWyjVHGYovQpaKNOFxLmWdiYj16xY5S7NQXwiSZVFNV1wfPOrVgbDkdcm+ZhTGTAAX8sGDJBwPZfT+wP92nq4pZ7gkTRHh0CYHPHQ5pvyCkjeNnCankq8EYq5LL3lW2qFPP8eTcDIP5bXiyZO8QWUdBO+QXyJ2pQE8wBFxvniLUSQ/VlX0HNCDtQoCVJnBBIPGIcLJulx2hLsHEbYy15wbn2sZQxR4DknyboxYvEgPln+STzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq9+2GmnqQurx+NWbJlyxoOomNMprwsYP4nlPqc4y5c=;
 b=mrPGRm536GCwil3a4X1gc8GeF7vQ2aRA7L7o6qxAiRRDI5PB5SmBG21VIlDHT2n/c7QDhEXb4OavVfbpEn39aeaUclzq+aF32P71o13aZWcBQutpG4sQUlrbZ4tz79L58iJ5/YNAMQgG3qqYpdgjmTN5roiQfBs0DlFV/jScnAA=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 5 Aug
 2024 16:13:54 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%7]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 16:13:54 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Peilin Ye <yepeilin@google.com>, bpf
 <bpf@vger.kernel.org>,
        Josh Don <joshdon@google.com>, Barret Rhoden
 <brho@google.com>,
        Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>,
        Dave
 Marchevsky <davemarchevsky@meta.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
In-Reply-To: <2fcdce74-e1c8-481c-ac43-e15fbb6765d8@linux.dev> (Yonghong Song's
	message of "Thu, 1 Aug 2024 09:44:14 -0700")
References: <20240729183246.4110549-1-yepeilin@google.com>
	<CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
	<24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
	<87h6c4h0ju.fsf@gnu.org> <87v80kfhox.fsf@gnu.org>
	<2fcdce74-e1c8-481c-ac43-e15fbb6765d8@linux.dev>
Date: Mon, 05 Aug 2024 18:13:49 +0200
Message-ID: <87jzgvrlqa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CO1PR10MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: dda89f43-e53e-4afa-7694-08dcb56999f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzhHcjh6VW11VDBsb01UZ3I5UDRjMlN0c2U4Rkl2RkFpb1ppRmRHSmxNb2wr?=
 =?utf-8?B?THppbk1SZ0JlUWo1QnRYYjZNeSt4Qnp6WU10cHVkbWVWL0R6Rk1DR1I0L2JQ?=
 =?utf-8?B?enI1YTVMTlVYWDR5VFlpTzVaRkhFTHExWEhha3k0c0tMaDVZaWt1WU4vWmpp?=
 =?utf-8?B?WTZJM1NQVXpVT2g0cTZ2bXVzMXpkTU1rZGNTek5zNndxMnNuZk1lbk8xOVpv?=
 =?utf-8?B?T3g3YlBlSjdoelNkOGp0VWkwd2lNQVRHZHBFT3k3OTdIdklCbmlkbkJRQUgz?=
 =?utf-8?B?Wkx5a25uZGRGKzlOT3g4djgyN3o5Zy9hdC9oRHlkdXlwamxOcVUzMjJqSkpI?=
 =?utf-8?B?YS92ejEzZXNGc1E4S2lGR2twMXBKc0d0QWJLcCtHY3dxOWs1dFRES1BSL3FP?=
 =?utf-8?B?WTlKSVpVdU9tV2dMYU9CRCtQWTZLdHBSVExDQytvZ3dyUWJBVFk2SndBMUpZ?=
 =?utf-8?B?REd1REgzcTZRL2p3Z0lMMG1mQ2E3VG5pNFJyNGlHRE9zeHVIOWM2SmNxb09m?=
 =?utf-8?B?cUREWXNpc2c2WDJUZlFWWEZ5SXpHNE12a2lJUU1rMk1nWDU1QUF4VStRNzhH?=
 =?utf-8?B?K3ozRHp6T3I0WGhTcHdGcXZJM3YrRHpnaGszdE85dWZkRWZ3TG5JMWkrU0Vy?=
 =?utf-8?B?MnFKbXBMaEJrRExDNkx0UGFrcnM1MG8yUFBSbkFLaUFaWDZDTnZZTlJid0tT?=
 =?utf-8?B?RFRMYXAwRVNmZ3dPRmxSYno0d1ByTDdKemU4TFNwZittVklDWkN5YVdDbStq?=
 =?utf-8?B?dis2MEtXUFg1ME9GZXloUk5jOVgxSlFKU0U3elRBQkdoMDZZcElKK3dpc0Zq?=
 =?utf-8?B?Z3ZIWFpFc3dYbDJaNk9Xamh2bjhxbXNTUk1qM2Q1WDlVWmpFaEgrVG56TGZ2?=
 =?utf-8?B?K2w4b2RnZEtZTHk5TVdndFB2anJPcVppb0ZUK1NseW0vMDh3TlY1Z24wSGN4?=
 =?utf-8?B?ckpBZzgzN1VMTmdVZXBxUkFWeEw1cnduQVhMaDJXYnpKSnJIWEhOa3lXYUlZ?=
 =?utf-8?B?UTNnamUwNy9OOVZITFpZWW5wWVVWcTR5VDRWVFRNdi9MU2lEWmRhZHI1cmhY?=
 =?utf-8?B?N2lGRGpkMWhlejRiOTE5RVJYdkVEVHRqOGlHNFFGVGpLcmVCeTNzaXNERmxq?=
 =?utf-8?B?bDlVY3ZaZmh2Y09LelVrd2MzUnlCTSswZkNiN2tNZ2RXQm5VNHBmVFM4VkVR?=
 =?utf-8?B?TjdJTzhod0orallWa2lDV2FWYUdzUy9uVlFnL25LUkxKOEJXL3BIV1Y2ZVNE?=
 =?utf-8?B?VGtaeTJJdzFyMTBOYkZ1VlJMVWJBRjM3TXVEZXZQbFF0Mkk1bEFKVVMrdkJ5?=
 =?utf-8?B?QWdpRVlrQnlXVkhOY3JORGlXQTE5dlFzbkZobG91V1B5NkVYVTFOUzAwRnNX?=
 =?utf-8?B?MUNpYXhZUWlKNjhFdXl1VnZEMzFFYWkrR0JXMm5hR3MyOUhqUW9COGRPSU5N?=
 =?utf-8?B?NDE5dE5SVko0OUFGUE4xVUEybXhXRExTbXdxaDhLTXNiRWJXN3ZCNDdxT0VV?=
 =?utf-8?B?a3g4VU5NeUlRODdINkxqWFFUdVZ0djdzTElHV2VpQlFQREJNREUwaWdVM29R?=
 =?utf-8?B?K3VHRENPV2prV0lEVDQzMHlkdDVZRVd6VlRKRkFZUFF6bWlnQk1CMTdCTHR5?=
 =?utf-8?B?RXNpZSt0d1Fpak9CejNNd3dWUUVudGd3UUt2SUVpLzYxZWRvYXFaOC9ERFJm?=
 =?utf-8?B?dnFvSSt0MURwTWk2NDQ0MFVhU2RMcEcvS3IzZUZzZHMvVWFsSjZaYkN6Z2Jv?=
 =?utf-8?Q?Z4En7EzNfHzdYNgjl3bzz5/Mt7WBno0ZxGRURUX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkZTSkJVS2FWc3FPNElPd2hVT2lncmJ2cmtBYndUaFBCalBOeW1tWisvc0tV?=
 =?utf-8?B?WWxXWWNRYTFpWFFwZmI3N2pCTVpFcXZHd0dYNHlrNmZyc0lyc2UwUHJUSkdE?=
 =?utf-8?B?a1llZW90Q1B1d0RBUFQrSzZZakJtR3dVYjdvMUYwcWhaR2JxU1hESGE2elFM?=
 =?utf-8?B?bjBjUjFlY2RDUVdBWG5qY3VKNCtBbDN3OHRpN0t1bnR5b3hFblhmYUQ4dkhK?=
 =?utf-8?B?S295cm5JMFA0ei9KdFZIM2x2c243cDlORXpCd2NoaDVtcXBTSXhZMUxJNkkw?=
 =?utf-8?B?TUlKcW45Zm93WndyVDh5Tk9zUklqRk9zeW1vZmtoalViQ1dnTCtnZG9hTXU3?=
 =?utf-8?B?M3VQM29mRWNuS09pZjZtZGdZZklwTSsyeEJleEF3Z0NNVTdQQk9RL1NUVzln?=
 =?utf-8?B?dWRVV29BRlhsckZQR0Z6UEZEUkY2aVVNeWdXam1QZnM0L25oeXc3dzg3Lzgy?=
 =?utf-8?B?cFNET25DVDViMUZYdkdzMklLdWlRK3JhRnMvQUVXODdxZHM5VEV1dFJpN1NV?=
 =?utf-8?B?M0cyVXlMRDFoYXozK0hxSHpPTTVTaFV0K3d6MCtyY252UCtJMEQvVkdvSmhB?=
 =?utf-8?B?U3pGYXRNUTNYRmxSNThiMnNLYUdrVXJUbUZHdTRnV1F2NHYyejMyOW5qamFl?=
 =?utf-8?B?RkJjeGx2NDhlWFFHMzdPV21TTUlybzg0UCtoNUtjM0VkMCsyRzhWSGNLc1FE?=
 =?utf-8?B?Wkp2ZE5ZVTZDOG85UVBsUjNsWmZUeWxEblBIQ01mZ2RGdjlTUzhkNzhhQTVy?=
 =?utf-8?B?aVRzbEtOUWk0SmJmTWtXc2RkU3B1SHkxOGRoTTI5bFVFdHVSSExKTjMwNysv?=
 =?utf-8?B?MEJzQzdTeWd3OG11Z3Q5bjU0TjZmVEErQ0dqOHFZbGZyZ1lXQzljT0UrNS9w?=
 =?utf-8?B?NjRmb0lSUUpVR2pyQnhvck8wNnYreXpSTStuM2llSlVDTkFmbmFpU0tmMTRH?=
 =?utf-8?B?RDJ5OW9lTjdwSWdsQ0RCb3Vlb3FZMU9GQXI4b25SNW1HdEMzMTRXaXFzcXMx?=
 =?utf-8?B?YWhsNzljZDNkQ3lpZ0d2WngxZC9waDVpanpLckszYlh1bjNpSDlkMjkrS1RS?=
 =?utf-8?B?bDI2TmtsWGZaQTRPWGVkNTU4YmhBLytoSTZWMzEyUzFIUEF5VVFaU2IrSXdT?=
 =?utf-8?B?RncvL0xmR05URkZyMGp4WXM5U1BJWEJwSzgxWGdTQ1pvNDN3TGhiNy95NHVR?=
 =?utf-8?B?dmRteXMwd1RZUUM0U0YxUWd3MXQ0YUZ6K0FZdG9Namx2U2doSVJ1VVNwK0hL?=
 =?utf-8?B?Z0pidkhuU3FudStmOFFOTTUrTWZ1TVhZVXB2V2hnSUN2VGZQcytuanRHc0xr?=
 =?utf-8?B?S1MzZkJxUjBkcUxiOWx2ODFGVklLQ0dqeE1YZTdidUVEMXNaTVloNmhHSUVZ?=
 =?utf-8?B?Z05ZTmRUUFo2bGlSeWlwam9MNVZWYjJjMld1cWx1TTB3d3NYNFBGWTc5SzVX?=
 =?utf-8?B?T1N4UW5DTGpvNThqRjQvemswa1lkODQ2OFU4MmMyYUd0Qnc2eXcyUEg0cmRl?=
 =?utf-8?B?d1NwYlZ1NTZKRGZKSXFQNTBPK3M1MjFueWJrK2l0RnBxek94eFlLZjJmQzZQ?=
 =?utf-8?B?Q0FCRXM2ZHF5UEJ6WHpZbEUxS0V1YjdvTUtSZ2Q2YXp4RlRGeHl0d09OQUkz?=
 =?utf-8?B?RU9mWFlwT2VtcFlMdzlvV25SeGVxWGhuUmxOWlc1TGhqSnMvTjNtY1pLQmd3?=
 =?utf-8?B?T2VNUWw4cklicEhKTEoyOHRPUXhqSW5jcFUyU1JOUjQycVN6Y0JJZ0p6SW8z?=
 =?utf-8?B?eWlJL0xTWTlKRzQwdDBmOGptU0RJZ3Z0MW1OWVFSRGJnWVNNYUtJc2MrNUQy?=
 =?utf-8?B?MXlucDVucU15OVBHenBwUnhMTU1EdXpueUZQMjUveHhSUVF1KzFkV2Y2aWsy?=
 =?utf-8?B?NjRZbnppb2VhcnhGTUVXbHVqVS9nZWJySGdmS093VkQ4RUlzUDhQUEJXMGJU?=
 =?utf-8?B?Y0pzbkJodmoxeXZiZGF0akRrVEJkU0lza2d5TWJUSk9CKy9YTGExRWZBQmJC?=
 =?utf-8?B?akE0V1J3b0NXVEVBQnA1YVpBdFRUVUozZHo2dENmTktIUE9rZUNVODBWZ0dV?=
 =?utf-8?B?NzUvbDdiL0xrd2JzQjdNWmk0MWY2MkxaSVlNSHB1cHZOeWR2ZlZyYlg5NEFD?=
 =?utf-8?B?Z28rcDgxTjFRN3dUc1NSRjZuYnR2eEx6ck5PdE5udjRIZnkzK09HNGFlSjZQ?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XSJv1xPUzZOOMUBIqNU3CEz9kQFz6JFhCoFNO8Xz1px1ybI3hCsn9XFPSVCxdfJokY+INQh11JYUrrEpqcebtUVmUn9aCpPjDX79uUGuBpQIQkD/YUvA7glbANFhjBNlL9KIru0z7kmYus/t5/8WbY98juWagJrS2Yi0RvQYnGMpl4fvbcZXF1xAbm9L2PHsf+rqcLv+CHOOLLs0Nv3K8XlXmElFHk+r+gghD8lrZ2wH3HsgZ25FIFJa1P83RwqWGgD5aqw3uZsxl04KKERO/DSWgfDe96D3PcunWKtMrDo9SVfU0rxmK3Ev9EjTMvZEBWJ7pfXOvYLhC6XOKET+uxy5JKV1bD7UPodqgIkYrzMdzovMr8eE58FYs1sgexfGXF0HyMH1b/0hmUmvpP0/QymuJZeo5SsDYPHDcCQbaO3n0E6WDSTHLjCwpQH20il4JHyeXLCsPLWlPc4l3HR0RGPbTIwK/jOEjkFKI1Uy4rLyH5O50b+E5oylArCagP0aIx1CuAzCKq8DVCu3d95Kh8BAOZ7rYKKc9PL4CL/BPsvAPIsXex9Auvy5+d9/icuEEo5SzClFyjaghg3pvdB5YuPGSJ3rgvjKSSfaHbewvnY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda89f43-e53e-4afa-7694-08dcb56999f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 16:13:54.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ued/tyCTsZBeacPz76rSGQH+YbW8kiuLdSBsCHNresPYKWJ8LmSRcR9YM9X5EYn8kZyrGkRRi4+Pc8jrV6JtyumjIr2m2cEKyEb01Kujyg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_04,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050117
X-Proofpoint-GUID: rEQat-fagqWjUfJKTV3gO9Pi3ivN4TDD
X-Proofpoint-ORIG-GUID: rEQat-fagqWjUfJKTV3gO9Pi3ivN4TDD


> On 8/1/24 7:20 AM, Jose E. Marchesi wrote:
>>>> On 7/29/24 6:28 PM, Alexei Starovoitov wrote:
>>>>> On Mon, Jul 29, 2024 at 11:33=E2=80=AFAM Peilin Ye <yepeilin@google.c=
om> wrote:
>>>>>> Hi list!
>>>>>>
>>>>>> As we are looking at running sched_ext-style BPF scheduling on archi=
tectures
>>>>>> with a more relaxed memory model (i.e. ARM), we would like to:
>>>>>>
>>>>>>     1. have fine-grained control over memory ordering in BPF (instea=
d of
>>>>>>        defaulting to a full barrier), for performance reasons
>>>>>>     2. pay closer attention to if memory barriers are being used cor=
rectly in
>>>>>>        BPF
>>>>>>
>>>>>> To that end, our main goal here is to support more types of memory b=
arriers in
>>>>>> BPF.  While Paul E. McKenney et al. are working on the formalized BP=
F memory
>>>>>> model [1], Paul agreed that it makes sense to support some basic typ=
es first.
>>>>>> Additionally, we noticed an issue with the __sync_*fetch*() compiler=
 built-ins
>>>>>> related to memory ordering, which will be described in details below=
.
>>>>>>
>>>>>> I. We need more types of BPF memory barriers
>>>>>> --------------------------------------------
>>>>>>
>>>>>> Currently, when it comes to BPF memory barriers, our choices are eff=
ectively
>>>>>> limited to:
>>>>>>
>>>>>>     * compiler barrier: 'asm volatile ("" ::: "memory");'
>>>>>>     * full memory barriers implied by compiler built-ins like
>>>>>>       __sync_val_compare_and_swap()
>>>>>>
>>>>>> We need more.  During offline discussion with Paul, we agreed we can=
 start
>>>>>> from:
>>>>>>
>>>>>>     * load-acquire: __atomic_load_n(... memorder=3D__ATOMIC_ACQUIRE)=
;
>>>>>>     * store-release: __atomic_store_n(... memorder=3D__ATOMIC_RELEAS=
E);
>>>>> we would need inline asm equivalent too. Similar to kernel
>>>>> smp_load_acquire() macro.
>>>>>
>>>>>> Theoretically, the BPF JIT compiler could also reorder instructions =
just like
>>>>>> Clang or GCC, though it might not currently do so.  If we ever devel=
oped a more
>>>>>> optimizing BPF JIT compiler, it would also be nice to have an optimi=
zation
>>>>>> barrier for it.  However, Alexei Starovoitov has expressed that defi=
ning a BPF
>>>>>> instruction with 'asm volatile ("" ::: "memory");' semantics might b=
e tricky.
>>>>> It can be a standalone insn that is a compiler barrier only but that =
feels like
>>>>> a waste of an instruction. So depending how we end up encoding variou=
s
>>>>> real barriers
>>>>> there may be a bit to spend in such a barrier insn that is only a
>>>>> compiler barrier.
>>>>> In this case optimizing JIT barrier.
>>>>>
>>>>>> II. Implicit barriers can get confusing
>>>>>> ---------------------------------------
>>>>>>
>>>>>> We noticed that, as a bit of a surprise, the __sync_*fetch*() built-=
ins do not
>>>>>> always imply a full barrier for BPF on ARM.  For example, when using=
 LLVM, the
>>>>>> frequently-used __sync_fetch_and_add() can either imply "relaxed" (n=
o barrier),
>>>>>> or "acquire and release" (full barrier) semantics, depending on if i=
ts return
>>>>>> value is used:
>>>>>>
>>>>>> Case (a): return value is used
>>>>>>
>>>>>>     SEC("...")
>>>>>>     int64_t foo;
>>>>>>
>>>>>>     int64_t func(...) {
>>>>>>         return __sync_fetch_and_add(&foo, 1);
>>>>>>     }
>>>>>>
>>>>>> For case (a), Clang gave us:
>>>>>>
>>>>>>     3:    db 01 00 00 01 00 00 00 r0 =3D atomic_fetch_add((u64 *)(r1=
 + 0x0), r0)
>>>>>>
>>>>>>     opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>>>>     imm (0x00000001): BPF_ADD | BPF_FETCH
>>>>>>
>>>>>> Case (b): return value is ignored
>>>>>>
>>>>>>     SEC("...")
>>>>>>     int64_t foo;
>>>>>>
>>>>>>     int64_t func(...) {
>>>>>>         __sync_fetch_and_add(&foo, 1);
>>>>>>
>>>>>>         return foo;
>>>>>>     }
>>>>>>
>>>>>> For case (b), Clang gave us:
>>>>>>
>>>>>>     3:    db 12 00 00 00 00 00 00 lock *(u64 *)(r2 + 0x0) +=3D r1
>>>>>>
>>>>>>     opcode    (0xdb): BPF_STX | BPF_ATOMIC | BPF_DW
>>>>>>     imm (0x00000000): BPF_ADD
>>>>>>
>>>>>> LLVM decided to drop BPF_FETCH, since the return value of
>>>>>> __sync_fetch_and_add() is being ignored [2].  Now, if we take a look=
 at
>>>>>> emit_lse_atomic() in the BPF JIT compiler code for ARM64 (suppose th=
at LSE
>>>>>> atomic instructions are being used):
>>>>>>
>>>>>>     case BPF_ADD:
>>>>>>             emit(A64_STADD(isdw, reg, src), ctx);
>>>>>>             break;
>>>>>>     <...>
>>>>>>     case BPF_ADD | BPF_FETCH:
>>>>>>             emit(A64_LDADDAL(isdw, src, reg, src), ctx);
>>>>>>             break;
>>>>>>
>>>>>> STADD is an alias for LDADD.  According to [3]:
>>>>>>
>>>>>>     * LDADDAL for case (a) has "acquire" plus "release" semantics
>>>>>>     * LDADD for case (b) "has neither acquire nor release semantics"
>>>>>>
>>>>>> This is pretty non-intuitive; a compiler built-in should not have in=
consistent
>>>>>> implications on memory ordering, and it is better not to require all=
 BPF
>>>>>> programmers to memorize this.
>>>>>>
>>>>>> GCC seems a bit ambiguous [4] on whether __sync_*fetch*() built-ins =
should
>>>>>> always imply a full barrier.  GCC considers these __sync_*() built-i=
ns as
>>>>>> "legacy", and introduced a new set of __atomic_*() built-ins ("Memor=
y Model
>>>>>> Aware Atomic Operations") [5] to replace them.  These __atomic_*() b=
uilt-ins
>>>>>> are designed to be a lot more explicit on memory ordering, for examp=
le:
>>>>>>
>>>>>>     type __atomic_fetch_add (type *ptr, type val, int memorder)
>>>>>>
>>>>>> This requires the programmer to specify a memory order type (relaxed=
, acquire,
>>>>>> release...) via the "memorder" parameter.  Currently in LLVM, for BP=
F, those
>>>>>> __atomic_*fetch*() built-ins seem to be aliases to their __sync_*fet=
ch*()
>>>>>> counterparts (the "memorder" parameter seems effectively ignored), a=
nd are not
>>>>>> fully supported.
>>>>> This sounds like a compiler bug.
>>>>>
>>>>> Yonghong, Jose,
>>>>> do you know what compilers do for other backends?
>>>>> Is it allowed to convert sycn_fetch_add into sync_add when fetch part=
 is unused?
>>>> This behavior is introduced by the following llvm commit:
>>>> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa=
4ca74488615744
>>>>
>>>> Specifically the following commit message:
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D
>>>> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
>>>> instructions are added for atomic operations which do not
>>>> have return values. LLVM will check the return value for
>>>> __sync_fetch_and_{add,and,or,xor}.
>>>> If the return value is used, instructions atomic_fetch_<op>
>>>> will be used. Otherwise, atomic_<op> instructions will be used.
>>>> =3D=3D=3D=3D=3D=3D
>>>>
>>>> Basically, if no return value, __sync_fetch_and_add() will use
>>>> xadd insn. The decision is made at that time to maintain backward comp=
atibility.
>>>> For one example, in bcc
>>>>    https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#=
L1444
>>>> we have
>>>>    #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>>>>
>>>> Should we use atomic_fetch_*() always regardless of whether the return
>>>> val is used or not? Probably, it should still work. Not sure what gcc
>>>> does for this case.
>>> GCC behaves similarly.
>>>
>>> For program A:
>>>
>>>    long foo;
>>>       long func () {
>>>          return __sync_fetch_and_add(&foo, 1);
>>>    }
>>>
>>> bpf-unknown-none-gcc -O2 compiles to:
>>>
>>>    0000000000000000 <func>:
>>>       0:	18 00 00 00 00 00 00 00 	r0=3D0 ll
>>>       8:	00 00 00 00 00 00 00 00
>>>      10:	b7 01 00 00 01 00 00 00 	r1=3D1
>>>      18:	db 10 00 00 01 00 00 00 	r1=3Datomic_fetch_add((u64*)(r0+0),r1=
)
>>>      20:	bf 10 00 00 00 00 00 00 	r0=3Dr1
>>>      28:	95 00 00 00 00 00 00 00 	exit
>>>
>>> And for program B:
>>>
>>>    long foo;
>>>       long func () {
>>>         __sync_fetch_and_add(&foo, 1);
>>>          return foo;
>>>    }
>>>
>>> bpf-unknown-none-gcc -O2 compiles to:
>>>
>>>    0000000000000000 <func>:
>>>       0:	18 00 00 00 00 00 00 00 	r0=3D0 ll
>>>       8:	00 00 00 00 00 00 00 00
>>>      10:	b7 01 00 00 01 00 00 00 	r1=3D1
>>>      18:	db 10 00 00 00 00 00 00 	lock *(u64*)(r0+0)+=3Dr1
>>>      20:	79 00 00 00 00 00 00 00 	r0=3D*(u64*)(r0+0)
>>>      28:	95 00 00 00 00 00 00 00 	exit
>>>
>>> Internally:
>>>
>>> - When compiling the program A GCC decides to emit an
>>>    `atomic_fetch_addDI' insn, documented as:
>>>
>>>    'atomic_fetch_addMODE', 'atomic_fetch_subMODE'
>>>    'atomic_fetch_orMODE', 'atomic_fetch_andMODE'
>>>    'atomic_fetch_xorMODE', 'atomic_fetch_nandMODE'
>>>
>>>       These patterns emit code for an atomic operation on memory with
>>>       memory model semantics, and return the original value.  Operand 0
>>>       is an output operand which contains the value of the memory
>>>       location before the operation was performed.  Operand 1 is the
>>>       memory on which the atomic operation is performed.  Operand 2 is
>>>       the second operand to the binary operator.  Operand 3 is the memo=
ry
>>>       model to be used by the operation.
>>>
>>>    The BPF backend defines atomic_fetch_add for DI modes (long) to expa=
nd
>>>    to this BPF instruction:
>>>
>>>        %w0 =3D atomic_fetch_add((<smop> *)%1, %w0)
>>>
>>> - When compiling the program B GCC decides to emit an `atomic_addDI'
>>>    insn, documented as:
>>>
>>>    'atomic_addMODE', 'atomic_subMODE'
>>>    'atomic_orMODE', 'atomic_andMODE'
>>>    'atomic_xorMODE', 'atomic_nandMODE'
>>>
>>>       These patterns emit code for an atomic operation on memory with
>>>       memory model semantics.  Operand 0 is the memory on which the
>>>       atomic operation is performed.  Operand 1 is the second operand t=
o
>>>       the binary operator.  Operand 2 is the memory model to be used by
>>>       the operation.
>>>
>>>    The BPF backend defines atomic_fetch_add for DI modes (long) to expa=
nd
>>>    to this BPF instruction:
>>>
>>>        lock *(<smop> *)%w0 +=3D %w1
>>>
>>> This is done for all targets. In x86-64, for example, case A compiles
>>> to:
>>>
>>>    0000000000000000 <func>:
>>>       0:	b8 01 00 00 00       	mov    $0x1,%eax
>>>       5:	f0 48 0f c1 05 00 00 	lock xadd %rax,0x0(%rip)        # e <fun=
c+0xe>
>>>       c:	00 00
>>>       e:	c3                   	retq
>>>
>>> And case B compiles to:
>>>
>>>    0000000000000000 <func>:
>>>       0:	f0 48 83 05 00 00 00 	lock addq $0x1,0x0(%rip)        # 9 <fun=
c+0x9>
>>>       7:	00 01
>>>       9:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 10 <func+=
0x10>
>>>      10:	c3                   	retq
>>>
>>> Why wouldn't the compiler be allowed to optimize from atomic_fetch_add
>>> to atomic_add in this case?
>> Ok I see.  The generic compiler optimization is ok.  It is the backend
>> that is buggy because it emits BPF instruction sequences with different
>> memory ordering semantics for atomic_OP and atomic_fetch_OP.
>>
>> The only difference between fetching and non-fetching builtins is that
>> in one case the original value is returned, in the other the new value.
>> Other than that they should be equivalent.
>>
>> For ARM64, GCC generates for case A:
>>
>>    0000000000000000 <func>:
>>       0:	90000001 	adrp	x1, 0 <func>
>>       4:	d2800020 	mov	x0, #0x1                   	// #1
>>       8:	91000021 	add	x1, x1, #0x0
>>       c:	f8e00020 	ldaddal	x0, x0, [x1]
>>      10:	d65f03c0 	ret
>>
>> And this for case B:
>>
>>    0000000000000000 <func>:
>>       0:	90000000 	adrp	x0, 0 <func>
>>       4:	d2800022 	mov	x2, #0x1                   	// #1
>>       8:	91000001 	add	x1, x0, #0x0
>>       c:	f8e20021 	ldaddal	x2, x1, [x1]
>>      10:	f9400000 	ldr	x0, [x0]
>>      14:	d65f03c0 	ret
>>
>> i.e. GCC emits LDADDAL for both atomic_add and atomic_fetch_add internal
>> insns.  Like in x86-64, both sequences have same memory ordering
>> semantics.
>>
>> Allright we are changing GCC to always emit fetch versions of sequences
>> for all the supported atomic operations: add, and, or, xor.  After the
>> change the `lock' versions of the instructions will not be generated by
>> the compiler at all out of inline asm.
>>
>> Will send a headsup when done.
>
> Thanks! https://github.com/llvm/llvm-project/pull/101428
> is the change in llvm side.

This is now fixed in GCC upstream as well.
https://gcc.gnu.org/pipermail/gcc-patches/2024-August/659454.html

Salud!

