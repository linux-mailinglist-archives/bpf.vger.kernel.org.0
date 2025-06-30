Return-Path: <bpf+bounces-61810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF29AED936
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DB1774AC
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631224888E;
	Mon, 30 Jun 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iG6cOWWv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aBTJD9f8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31323FC5F;
	Mon, 30 Jun 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277708; cv=fail; b=SYDwVbkZuYzWFr3zY5OxK1+E2CedIiVvKOjhO/wbFDRH9fku+sHN4lije4FXOnc8NNuhbBwdz8/TguSkKUUNYs29q8MJX34/uP+DYa9oCFNn2KHwCCW3tsVQ8OTxfcrhh2AbXxu9KUzikNl/Ffy8Zt2B7/Tlc1pZk2jtEiKTwO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277708; c=relaxed/simple;
	bh=w58snrZFIDR1Hi4Te2iXA1JjvihgdK2LrK9FP0R7AtM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GzogGMGPm/6cUKtZAJCjQX+gLRwLaAvm9j0INHs+vqeuPRl65IeTlrKeUKFpCyLzCCyd2GPcmNfByHFGjjwdeoL8s2WV16jYKekyi6vell1EdKtYQncvUj8NROMRHAN+cdYL4V7M2sziAl5m8JDpjRHAePanfl3+mZE+jw7uDy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iG6cOWWv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aBTJD9f8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U84b7S010142;
	Mon, 30 Jun 2025 10:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BXwx7MS+tUlhCuFe3ksrjUP2gpwUAjAhqXee03CTGBQ=; b=
	iG6cOWWv+93do2n/Wbi3sN+FwWgbrJQ5X2LGdlcpetvyA35Lbw7j7mzb839hF3Sg
	OxNgv3GsIIXz7CCTaXhdBJs56IWc5MFzqayTpPiw4oBoqUJ5K9KJNKyhJwbvjBqk
	3AQy+vyFI5fWSJXGKzJ/zpgKsRV5Dks0lf2Bp6KUUSYOiY/p9kFGKlOPg9N7wD03
	j3cLf41vgUOAG1J28N5rYKanCub3K+V5If/ptb2xNO5stUTkPcY0Q5q+bHBBWvLk
	x+A53Y9Q1+E3SvS6HlExCWbrUty717qaTUGYtf3aC7m9o0LCjF9KcbiPG75uTpAV
	9EcGGnCOzzzvcQ71mLQD3A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef25ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 10:01:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U7prS3018145;
	Mon, 30 Jun 2025 10:01:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ufchk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 10:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHe8S0tjOIGrK8pEm8WcjCmM8iwrN4E2ya1d+ncQXbWuJXZKq07+kYvMEzE5zA9iFXiYmqsYnw7b32L7zCeMw4lI/ZgkCuFL1FhKKgOtLBYy/30RA4tyaiEWNSQDVvQjbTATnXiSnbAYTzl/yxoHVYqOPSNLGH1j5XsrZk8m59ZaK0MSqoH91ZWIKXcNgK5ezZFmY7dPZiXX/q9ZmlVuUy6eo7hKojlKOdLYII699hE9VzEWi9VFKPQlsfpuQtpq1hmwr8xGQkTRDuiCyFoKFhgR+RpWG5di/OUU14tgfDhs7SFuyX4sETwtAXQwqqbvVRs4die+TzatGMZh6Gzdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXwx7MS+tUlhCuFe3ksrjUP2gpwUAjAhqXee03CTGBQ=;
 b=EgUp30/rNmoGZ+r61aDwFSS3wnNyUbTvI4989caaF4yuL51N5Cx0wg5f8OxnWOoMEIn/HdKS8lhobJmF0ov7h8yz1uhTHZHJHuky6Xp/wy9cEqiSLSLO0lyrYYzhuee/oFmQESAbHdsMvSbTho2tkKLKVMzCORpZ+DIuWTuACoKDBgHH2CrpB8+Iz77kxSa0ela85aTJXozF4VaqiriZjpWTt4KH7B7HftrluYkwKuRWBJDhDz2K0ksO5a6aC1Pn9JItPuoTGonaLDRvJ9auKleYHWyxon0yHRpomGtuR8U+iC/8IS6SHJKN8iwMA1Fwo5+mE/xDUf4NeSkS4Jll9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXwx7MS+tUlhCuFe3ksrjUP2gpwUAjAhqXee03CTGBQ=;
 b=aBTJD9f8FEYDIP5Txom+iIAdzDchPViUb4AzCJsm3Q57IfBLBt/MZf38Yi/ldvH+NWtBQBeZOUmFE2ERhCOgSYNvtzwcdDYvDELJA7Xd74Ekx7NwJRPqx+jIKw6KzT0Xpg12wwiQ+RQSmNfMs0oIt9FXXEExZr6iJXb0gl/27cI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 30 Jun
 2025 10:01:26 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 10:01:25 +0000
Message-ID: <7d0cb760-6745-4595-8e50-6f5cd8d0db05@oracle.com>
Date: Mon, 30 Jun 2025 11:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3] dwarf_loader: Fix skipped encoding of function
 BTF on 32-bit systems
From: Alan Maguire <alan.maguire@oracle.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
References: <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <20250522063719.1885902-1-tony.ambardar@gmail.com>
 <66861840-0d4e-4b83-a89c-3e56667ac55b@oracle.com>
Content-Language: en-GB
In-Reply-To: <66861840-0d4e-4b83-a89c-3e56667ac55b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0168.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::37) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SN7PR10MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: abfcb24e-4723-49a6-c9b8-08ddb7bd132c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WCs2V1B5WEtpeUo0eHp2aFU0TmtSUTE2ZDA5UjYwZEhqQkErRjBGL25KMXRn?=
 =?utf-8?B?RnRSZXhhVjVFUEN2aTVkeUIzYXZ2eklGSE9XeGJTa0ZRNnlxL1FLdzNIN1lD?=
 =?utf-8?B?WlR1cEZGaW9jSk1LWElTR3ByK0svNHc0ODlkUFJ6VlFWOWxNVW56RFBUWkxM?=
 =?utf-8?B?aHFQRmZxT2t6Y1VRaEJWN2g0Mk5yc3AxVWsyNWc3dmNGN08rSW5ZZ1gvZS9D?=
 =?utf-8?B?NnJIZ1R1c0NwRC9sV01meDZHbHhjbzVRTG1aU2tTYkN3d1c3TkFLVDFoVzNh?=
 =?utf-8?B?YXYwUFhLVTUrR0RxMnBaZC9WbUx3NWwyU1BGZVRNc0hJeHM0aGRpTjJhL1pF?=
 =?utf-8?B?MzBydkNOUkIwaitKSWtRRFNjNVJBUHgvRDV5SHZJR3pMNm1vMlAwWTc0RkdU?=
 =?utf-8?B?ZndDMU45Y1NiL0dPMnNPWFhqQVlJMmZOMVRmL3lBMUY3TDhvbXBveHZHU1Qx?=
 =?utf-8?B?ZVBidE14ODRoNndLU05UK244MU5Bc2IxR1pvK1pYNTBRSDlxT1cyQXBtWXhN?=
 =?utf-8?B?Q0szRVVDbEJkTzJxaVdQSExWL09FTTB6ZGZTNmhhdEdUejhCeHptYkpDd2Zm?=
 =?utf-8?B?Z0FQZWxlR05wd0trcG1uQzRZZjNhbURldnoyRzJiQWI5RmlXelNFZFhtQm92?=
 =?utf-8?B?azl0eDlCYkVja0oycEJRQ2dYQVBUWkgxQy9WcFlDMGlNTTdWd3YvMnFvY21w?=
 =?utf-8?B?MFVnSUp0a01GUXpkMlBGdzhNTHcyNTZLK2c4TTBSdUlsSW1mdE5qUzNrNTFW?=
 =?utf-8?B?UXVDTzlZVEp2Z2xRRExUYk50VThHWWM3V0UrNm5BV2I4d042eWpoQ3ZwbTl2?=
 =?utf-8?B?dlNoVTNaUnhwcTFWT0VUdGlhSDQ5M2V3M3BaZ2NIVFgxUVF0c2VsTTJ3SWdW?=
 =?utf-8?B?V2JuS24zZmNURmE1UjEwei9IM0hNbjhPbHNydUorcmFtN1QydGFad1lTaklm?=
 =?utf-8?B?M2F0K3kwejJvcThrRXd4WGx6ZFNnYUhiOGw0OGZHbUNObVVmVmZ1ZjBIekpt?=
 =?utf-8?B?OVVMZXBiVlpLN1dKdkxBQUtNczBCWWtIK1ZpWGliTWdweCs2UjZXd2JLUkE2?=
 =?utf-8?B?UDZWM3l4SSt0ZEc5L1pXZXcyRDhURFVGMG1IcGpLT1R2MFRUYWlWeTMzQURM?=
 =?utf-8?B?VWJrQnhhSlBVL0ZtOWpwMElidFVzYUhtUElaT1JUeEIremVDdnZsVFVmcnJS?=
 =?utf-8?B?S1VVNTlsWGU0bG1kWGx3TExlajFWWTBCcldaVGRoeGtnSklxWmlqbU5Md2pt?=
 =?utf-8?B?RnR2ME4yaFM4N1EwSDBBWFBUSzFJa09jRFQzYnpYZnJKK2J6TllrditIZ1lm?=
 =?utf-8?B?MFFENzQvZW8rMTkvM1NQb21Db05KM2QyZmFjTTJEbDhjdnl3OFh6dmtyS3Ew?=
 =?utf-8?B?N2VpcVRiN2diQ1c3NjlkbWVnVU1uSnN0NVZHR1FOR2VpQ241YnM1N01vRTdD?=
 =?utf-8?B?ZzhZUUtqNC95SFRmR0ZxTUp4Z0hIWldyK0dQa1A5RmlvNmRPZll2UmxBQlh3?=
 =?utf-8?B?MHZqQTM2bDZzVGdZTGVQNWpZc29LTStZNTFzeFg4bVBHcU03OThxd2VxVGFO?=
 =?utf-8?B?OUYrVHdrOWpMeDZsMmdscWMyTmFIUXQ1azF6aGVqbmd1YmxuTlJrcDBOWXEr?=
 =?utf-8?B?ZzZRcTlYbTBTZ0F1U1BlNzh3WjJkRy95czNZYmI1ZUhpR1M4OWI4RUJ3VVBD?=
 =?utf-8?B?QTJRUk5mQXRuRStlc1JyM2tIYm1jK1BWSlAraHZOSm5lR1Via1dDT3RmMjBZ?=
 =?utf-8?B?c1RTU25TYkhFZm9zc0dWQ1I2c3hpZnpuZ3Rmc2tCeExTazNGb3N3dmRSOVJL?=
 =?utf-8?B?SEpYdTQ3azJlSHYvRldLWU90ZnpLb2xTd3BXb0NvTjd4RHQ2NzRDRG1CTWVZ?=
 =?utf-8?B?NFNVVUQvWW13eUlXUG4vbVhhcTlud0J0aVE4RVpBdFR5K3FWTGFOOElJSGZT?=
 =?utf-8?Q?jymTdydNRfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWI2dElGZjJnN2JYRkdrdlpJVk1jcVBZaG1SRzhyVW5qSFc2Vld6NG4wMG1z?=
 =?utf-8?B?TXp3NlJCa1dnclJRcXFodTk3VmkrRk93cUFHQzgveUVrYW1BWGI3WTdQTEV6?=
 =?utf-8?B?RlpGZ2NMa0NzbE01a3Q4MEQ4VVAyajAzR2dTMDQ2OTRjQ1BLSzh1WWlFcmRh?=
 =?utf-8?B?ZllXS25EaWhTcStRQ0tQR25tUmQyOXN0MzU4Vklsd3c3OXpuUi9Iam5PS3Yx?=
 =?utf-8?B?QXRsTzdJNTF4QXloV0JwcmVUODE0U0NRNTgxbnoyamtPaStUV1pPZjROeEpD?=
 =?utf-8?B?NkUxb3lDcXdWSW1zSXJGbit0dXVDQmNSSk83a3ZlN2t3QWZjaDhwR2FOejBq?=
 =?utf-8?B?OVdtcmdtM0lrdlp0VEpiSE0vOFNaVzFjZko0WStuSUNWRERDWkRydkpyWEx5?=
 =?utf-8?B?VEhwR3dBWmdxUUhuWi9aSlBEajZiY2E5Zzg0emtmcTMyK2FXaG9kcjFkTVdr?=
 =?utf-8?B?T0xTV2p5T0F6YnFDYTkxdTdPQUZZbDRtdUM5ZkdBQ1VRWnovOVhWbzRicVZ3?=
 =?utf-8?B?RUUxL0pUWkFnK3FwTlRlWGU1N3diVVhNVEF5amUyTzlvdExVQkY2d1lWc2FM?=
 =?utf-8?B?cC9ITElsM0lZV1lKeUkzS0IzcmFvWHFnaDl4WHlmM0dENkJHdHAzcms1a1c0?=
 =?utf-8?B?amJKK29MbktmRy9USFlIVFZUSXJJQUM2MFpxNXNKYS9BenlwcmNkNzRpanhG?=
 =?utf-8?B?YTVpczlOTU9vRWMvNXZMMU5FUHVKZ0NXT3dNd2VxamtKaEhiTi8zSWxvMXZ6?=
 =?utf-8?B?cXg0aUlMU0c4OUwyZlFBUWdTY0hiM1V5NmI3WFBrTmRLVFB2dG53Kzg1U0Nj?=
 =?utf-8?B?bW93Y0RmaTFoZEZXaEtYNFNXYk5zVjdNSThvVStJaTYzUGVBSm1oMitYYlo4?=
 =?utf-8?B?THBROWxHVDlEVzIvdzVNSlJKcUFlRWJVcHdUWExlSGNSTFNJT01ZQjBKelZs?=
 =?utf-8?B?M3hQRXArS29sN3BGTzFNbkVXaWRQRmZ5ckJMOTh0MEJRRXF4YlpweFcwYk16?=
 =?utf-8?B?RXNrK1JHZVM4dlkzNFNRNFRoZVNnZjhzbm1ZYjhYLzE5ZlFvUHJ5WGJRWC9a?=
 =?utf-8?B?eGlJTmlKblRhVklMYWpQK1pQU0pBeVE2MjEwZzNWSjZVa1JQbGxIemMvVTMy?=
 =?utf-8?B?K1R2ckxwNlhubWJKZ0hvSDJEUWxKa2hVdjJNNEM0alA4NjUwS3hNeElhcWZ5?=
 =?utf-8?B?bm1RUHR3d0lCTUc5WEFVRENhTXQ4YjNFRFZzcWw3bTY5T3JNd3RsQk9id1J2?=
 =?utf-8?B?UnNKSmZURzUzT1R0bGlCalA5VEY2OWczeUgyWWd6c1BKTjlUcWlUUEZCaC9K?=
 =?utf-8?B?ejNuRmRvMEg3MXVZRkM0SFBtOUV6WDNGVlVOSFNMQlIzekpPUEJJSzlPRmlB?=
 =?utf-8?B?OFV6dGt5T3FTdnZkeGVheSs3dWlweVg0LzJqd0ovNFhlK1ZCeGtlTHhJVWxZ?=
 =?utf-8?B?Mlc2YS9sRVc0eGZRMThKY2JUakFyMmg3QUJMR1JKUnE4dnVNelFsOGNpcHpU?=
 =?utf-8?B?c2N5a0xHM3BzVTJocVoxTExaVnVrTTltZFRhT0NWRFR3OFN4azQxTzF3YXQr?=
 =?utf-8?B?dlhKMHgvUWtMeDgvaE5YbVVIaFUrMHBaekl2aFFlTnNXMGFvbzNYb3Q4Nk4v?=
 =?utf-8?B?aUtUZ1hLTlc1UHUvUm9vY2krZVZqZ2RwTStNQmUwRG1vcjlQOS9HWjIrUWZK?=
 =?utf-8?B?c3pMcG0wT1d6TjVuSVRIZVpJekpnZlVVSjZESzJTMzA1cXpjRVBtQ2I3bDN6?=
 =?utf-8?B?NExNQnoxL0kzbVhLV3g4TGwxTkNQL1BBcENvaS96cE9zb2NvQkcwdkRGaSs5?=
 =?utf-8?B?d00zNVJ1VVRJMzhMNG1FdDZGVVdhOU5mK1FNK0xmVGJHaVVIODFzTWJYK0Rl?=
 =?utf-8?B?cjdJNEtEWmZjbUJLWlNNaS83emRWMW4vU0p5NjM4MXMzanRDUktMU3BsWkth?=
 =?utf-8?B?RCt0eXJ2czUvOWExc3F3VEtCK1ZWbndkYitSb3hHZ2xHTTZFVUxkektRTTVE?=
 =?utf-8?B?UzRKc3FpQUdhNDB2cGdiOXlXK2U1M08xcHNlckgxQURBalEyeFNWSFdEV3Zn?=
 =?utf-8?B?MEcxUzljQmtOdldBZlNGY3BHWVRjcnpUYi9zYVI5REpQT3NMZ3dlaXYreXI5?=
 =?utf-8?B?UjNZdU5wdHcxMjY0cGdZYVM4ZW45YTZ0OGVLNitBV1FpaUFEcnZCL2ZUV1JH?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w6PeABeIp+1Dqn4002wQg3/ftm60DR39XnBnndocdslT4MU6knGkEt6xj9fsm4iduQ59zNLA4aRmdMoid/ya19ecN5ZTZbHzth/FgMJrQQXHVGSsO8o2oO1ZRY+J9LfiOzHeb+qdJai+hBTkCaLOIhnuwLP6yGNfsbLnRdEC2NzdAneD2h1AGn4Z+RxIJCCDswpmqfaKF6LvSIPUPWyiOJTYRmuwkC6qfwLQuwi/W7jEJLPfSGB1l1mbBy+StcNpt3Z6bkRZHf6Mf6XuFx+bSccAVc3qTky3o/IddaQGUadke6zC62JZ52igFZkxpmSylVlscxs2VhqmlSpBaaKpsJFyEAoKn0konVokl+mTQabDX/IbIXaaLEZMgJM68BtSgujPJoMFOXa0YFiOJMyOn096shdZYN1JodJjK8XTd164iT8BvsDLyG/cbuVNro/kWHAbngA7r7and81aYwX/MY8ev2ee5WaOJ304oiRCmVf3FrJ8XGEQg7DG/beiFqkFZMjPqdtKcj8RQNMhEvxbnz89Tlgcqs1ISPdxzdyoW8ORdCwrvoCwqh0UqYF/N7kNJ5Wysg4bHpPMjtNXVbb13fto3guWSJH8Ep1GCdvCEEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfcb24e-4723-49a6-c9b8-08ddb7bd132c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 10:01:25.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+3yPB6GGJCXdhXokAf4pSwjEb3F5/sp5r+BEJUrZv83Lf/7QGZq4IHrGbX+edfYnMU+88GAQE633SUEA+M0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300082
X-Proofpoint-GUID: DDCJiFHyLA_5gqObzPrlRFgvGF9N_IPn
X-Proofpoint-ORIG-GUID: DDCJiFHyLA_5gqObzPrlRFgvGF9N_IPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4MyBTYWx0ZWRfX47DFhcvXJxHq y999DkOcS5xfq6LzGn4oOF4STYq4QFrb6YfV6K/6aR5UymFXAWw50yTlRYd6AO3Ej8+Q5BKXenh oT7lNcdnv0Yxh4FFQEiRgipwSbpHh/KmmtcIK5BVbcwtX5qZnZJflWxaE/H45WvLWEvyXRwPJB6
 IO5y7ACxDVN8CIAN3Z+ccruS7wV1UeMFJIEDs936dOKZ0dBbSlM73Hcr8qQvUQz+ka0ktWySy1J sM5Bj/m31y4KI1EG5mzM1uhecAB70qZaC7vV7NmnoPyl++4rpTQ0aZGnG93GFYtydiMDoirTO08 0RZR0oARO95Dtk5vcTIfC77o+Hq9LyeM/aYMQMy66SEWR+Xngixv/Lob7Dr7dscIP2oD6gTp155
 k3jJkL2ifLcJNfeOTLvURRWISO85QH3rOiWiBu1FhDzf1PImy38/6orvZg9P/XRIo9CJthg1
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68626078 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=VaIIV0qhVZEczU03TJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf awl=host:13215

On 24/06/2025 17:14, Alan Maguire wrote:
> On 22/05/2025 07:37, Tony Ambardar wrote:
>> I encountered an issue building BTF kernels for 32-bit armhf, where many
>> functions are missing in BTF data:
>>
>>   LD      vmlinux
>>   BTFIDS  vmlinux
>> WARN: resolve_btfids: unresolved symbol vfs_truncate
>> WARN: resolve_btfids: unresolved symbol vfs_fallocate
>> WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
>> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
>> WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
>> WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
>> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
>> WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
>> WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
>> WARN: resolve_btfids: unresolved symbol scx_bpf_consume
>> WARN: resolve_btfids: unresolved symbol bpf_throw
>> WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
>> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
>> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
>> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
>> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
>> WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
>> WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
>> WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
>> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
>> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
>> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>>   NM      System.map
>>
>> After further debugging this can be reproduced more simply:
>>
>> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
>> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
>> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
>>
>> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>> <nothing>
>>
>> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
>>
>> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
>>
>> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
>> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
>>
>> The key things to note are the pahole 'consistent_func' feature and the u64
>> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
>> code handling arguments larger than register-size, allowing them to be
>> BTF encoded but only if structs.
>>
>> Generalize the code for any argument type larger than register size (i.e.
>> size > cu->addr_size). This should work for integral or aggregate types,
>> and also avoids a bug in the current code where a register-sized struct
>> could be mistaken for larger. Note that zero-sized arguments will still
>> be marked as inconsistent and not encoded.
>>
>> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
>> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> 
> hi Tony,
> 
> I'm planning on landing this shortly unless anyone objects; and on that
> topic if anyone has the cycles to test with this patch that would be
> great! I ran it through the work-in-progress BTF comparison in github CI
> and all looks good; see the "Compare functions generated" step in [1].
> 
> Thanks!
>

In fact I spoke too soon; there was a bug in the function comparison.
After that was fixed, I reran with this patch; see [1].

It shows that - as expected - functions with 0-sized params are left
out, specifically

< int __io_run_local_work(struct io_ring_ctx * ctx, io_tw_token_t tw,
int min_events, int max_events);
< int __io_run_local_work_loop(struct llist_node * * node, io_tw_token_t
tw, int events);

We expect this since io_tw_token_t is 0-sized. However on x86_64 it did
show one _extra_ function that I didn't expect:

> int __vxlan_fdb_delete(struct vxlan_dev * vxlan, const unsigned char
* addr, union vxlan_addr ip, __be16 port, __be32 src_vni, __be32 vni,
u32 ifindex, bool swdev_notify);

It's not clear to me why that function was added with this change - I
would have expected it either with or without the change. Any idea why
that might be?

[1]
https://github.com/alan-maguire/dwarves/actions/runs/15872520906/job/44752273776

> Alan
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/15854137212
> 
>> ---
>> v2 -> v3:
>>  - Added Tested-by: from Alexis and Alan.
>>  - Revert support for encoding 0-sized structs (as v1) after discussion:
>>    https://lore.kernel.org/dwarves/9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com/
>>  - Inline param__is_wide() and clarify some naming/wording.
>>
>> v1 -> v2:
>>  - Update to preserve existing behaviour where zero-sized struct params
>>    still permit the function to be encoded, as noted by Alan.
>>
>> ---
>>  dwarf_loader.c | 37 ++++++++++++-------------------------
>>  1 file changed, 12 insertions(+), 25 deletions(-)
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index e1ba7bc..134a76b 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -2914,23 +2914,9 @@ out:
>>  	return 0;
>>  }
>>  
>> -static bool param__is_struct(struct cu *cu, struct tag *tag)
>> +static inline bool param__is_wide(struct cu *cu, struct tag *tag)
>>  {
>> -	struct tag *type = cu__type(cu, tag->type);
>> -
>> -	if (!type)
>> -		return false;
>> -
>> -	switch (type->tag) {
>> -	case DW_TAG_structure_type:
>> -		return true;
>> -	case DW_TAG_const_type:
>> -	case DW_TAG_typedef:
>> -		/* handle "typedef struct", const parameter */
>> -		return param__is_struct(cu, type);
>> -	default:
>> -		return false;
>> -	}
>> +	return tag__size(tag, cu) > cu->addr_size;
>>  }
>>  
>>  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>> @@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>>  		struct tag *tag = pt->entries[i];
>>  		struct parameter *pos;
>>  		struct function *fn = tag__function(tag);
>> -		bool has_unexpected_reg = false, has_struct_param = false;
>> +		bool has_unexpected_reg = false, has_wide_param = false;
>>  
>> -		/* mark function as optimized if parameter is, or
>> +		/* Mark function as optimized if parameter is, or
>>  		 * if parameter does not have a location; at this
>>  		 * point location presence has been marked in
>>  		 * abstract origins for cases where a parameter
>> @@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>>  		 *
>>  		 * Also mark functions which, due to optimization,
>>  		 * use an unexpected register for a parameter.
>> -		 * Exception is functions which have a struct
>> -		 * as a parameter, as multiple registers may
>> -		 * be used to represent it, throwing off register
>> -		 * to parameter mapping.
>> +		 * Exception is functions with a wide parameter,
>> +		 * as single register won't be used to represent
>> +		 * it, throwing off register to parameter mapping.
>> +		 * Examples include large structs or 64-bit types
>> +		 * on a 32-bit arch.
>>  		 */
>>  		ftype__for_each_parameter(&fn->proto, pos) {
>>  			if (pos->optimized || !pos->has_loc)
>> @@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>>  		}
>>  		if (has_unexpected_reg) {
>>  			ftype__for_each_parameter(&fn->proto, pos) {
>> -				has_struct_param = param__is_struct(cu, &pos->tag);
>> -				if (has_struct_param)
>> +				has_wide_param = param__is_wide(cu, &pos->tag);
>> +				if (has_wide_param)
>>  					break;
>>  			}
>> -			if (!has_struct_param)
>> +			if (!has_wide_param)
>>  				fn->proto.unexpected_reg = 1;
>>  		}
>>  
> 
> 


