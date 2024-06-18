Return-Path: <bpf+bounces-32400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3590C869
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 13:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426351F21493
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861F205AEE;
	Tue, 18 Jun 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Klvjhi4Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFKuX3We"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143C205AE8
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704108; cv=fail; b=Kd94MdLTj58PXdOW8CsvCUT5Hv7SZCkCn3yzhXoriT+ByWpHuCnCwGOC5UfsxVfgfqER3chE9DWFRSkQXgfhrp4haNLsq95txGx1eFVFuwKZb8Vtbput0wtcgfAliVp4kkGxWFjslWJ9Of0Svv3b85dRtxi+gkzhy/pOdV8PtVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704108; c=relaxed/simple;
	bh=KZ8+4TbcfH6KVDD7gAcQkRj5gPV7Aqy/axr7SwclcNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0F8numrTlrO+VwubpRxPpTYtHqjFiPVczbmXvCc+fd9kibs8RYYJkYYpg0J/jDlYbMEbGHkyR1WhJhBYEgGYyNsbaWJ7Pf14YcXkX9rp6vqusBIV1V86eE5ySJBh8sXTG9HKg1k20QXXH8Jess3Gc6oVJTWJUY3Xwn4H8neJh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Klvjhi4Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFKuX3We; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tYPc012638;
	Tue, 18 Jun 2024 09:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=o7/w85bA9kbBeguwXUTB+7DPi4Jvw+CzXX37A2igmq4=; b=
	Klvjhi4Q1/9fvivaX1imQCjfiq+F5fHpZeFJBn2mpRlgqHH1Wam7D2lHHovuVVYL
	ZBu7FW1csSwx/iXbkWmTGPVUtYew7ukqMr/fPHHynLL8S+1j36VMGu54TDjTC61D
	8MQaK3fRjGKnc4eMFpd3nL8pNbL2AAW0xxPzS665kRCdii2UW22eoZMFzDJSNG8Q
	96sVIS2WoGeq9ljlpI5rcebkzgxJbTrFoszKcbDxsNe2Dy5g/xHkKWH1PqUsaJNa
	s3RNzeagcl+b/9+utGP0VypHp3NUFxFVoNO0feEYnddanZLSy+Dt6rdpNEtwFXWu
	I1gUF8rxluoTLaRDSzJfvA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys3gsmhqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:47:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45I9FajJ030610;
	Tue, 18 Jun 2024 09:47:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d7kw2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFvkLJPea+NKgA/Ls0Kvw7XhD7+WtrShaT863EM5DrzmtKRMBa1uFxrPBxBISMfncTsJmcLpV1SnK4tszMeJih9oK6ca4OXR3Pir9gS3Z8+9nBoZL8u3d7tSmcft9V2EktfQm8bHSXkfomPgmDF6H2fIbmoaYU2bhFv5PFnCwG3msv8awhLumlhdR+aysNhTAjEqTocSAJau4P/B8jR9YBAMY+xL6sWq4R7UIBxWVrRVNgBw6hRsqJ2IlLjv29Ni+2gAIK0yxD4+ALNk3JyPTyhuJZGUhi+rwqSiwKn5OI1j+Qj4fVtXlqVkeAVnKhCtkfdTJmwj7izyb2n0+qoZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7/w85bA9kbBeguwXUTB+7DPi4Jvw+CzXX37A2igmq4=;
 b=oKDBgrf3UEFoK0zZkYgkBAFdnI8OW0JaAk2ZPd5qtaOgkcEoUOhfjjgD9SQIrgdsqFV+trTzFOoiOFKJgr/URr2SNHS0zijVc3CIhTwbPJDf46IPJ7my8+mGAJOCekbOqltAWM3kQwOPs6T8Kk50gmNOPHBKBbW91XnOIIs6UpPUvK0inNSAbkTn2V1vm7LvjEO4o+cA6+9nU++IEPx1TWIpSJd+7burwhYKX94b+o51UnkOTV922r0oXeCrQKU+oHF1BnHTW3xShPWUmTiL+dP5T+FfoFtV6DRZzjnSjmVsQ8IUt41nB0NvbCmUS0p3hXw1POoFtwEPJeocCd/Cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7/w85bA9kbBeguwXUTB+7DPi4Jvw+CzXX37A2igmq4=;
 b=YFKuX3We1OBSlNMqDaaqLxV5lKTIjhzU2rpNo99uq/C51WriDwv/SmbrXLjDwyhRu8yqMrIl8oNG7v+SN5gh9wN78C04gfyn1FjOT+G+uHXSdZPKOPlwNdbDqFzuwCHmSp+0vhNMuMgtciwvijB2kyKrwA0vUCk2b60zPHXxPdE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV3PR10MB8131.namprd10.prod.outlook.com (2603:10b6:408:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 09:47:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:47:53 +0000
Message-ID: <a3ba5985-354c-4ab9-ad58-9ec3d08503c8@oracle.com>
Date: Tue, 18 Jun 2024 10:47:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org
References: <20240613095014.357981-1-alan.maguire@oracle.com>
 <20240613095014.357981-4-alan.maguire@oracle.com>
 <CAEf4BzakBgJ2FEPP7PBuDeKODd8t6Y0j9LB==W=R7TyK9PXuyg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzakBgJ2FEPP7PBuDeKODd8t6Y0j9LB==W=R7TyK9PXuyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV3PR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb60d53-ce04-4017-55e3-08dc8f7bb90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azlZZWYxNFkySE52TitUTFFVVDBhTE5oSkxqVGNxQkp0cS8wd2ppTFo2czFY?=
 =?utf-8?B?ZEcxSHFpdU9QR1laUXRSWTIwaWtydnIxdmdUalR3dTVoUHhqb0dma2tyS29v?=
 =?utf-8?B?T0Iwek9pbm5MbnRMa3FBR1gzd3JWNzRhK08vN1Raemc1L0k3SVFWbXEvd0FQ?=
 =?utf-8?B?M0ttbytJcmlvUlVVam9hdnloVzRoOUhQdnFBNXJjeGtOUEh5S2RrK3VNb0Z6?=
 =?utf-8?B?VzFoMDJTNi9hRUkwTUJRcUxIS1JpZWJPckJZSlM3NS9jWDV1Z2dlQXhJd212?=
 =?utf-8?B?RTVzelR6azROUlp1QlFnK2tINURyZFJXUTNSb1NJdXI0RVF5YWdoanlxZHRV?=
 =?utf-8?B?ejEwZ3NLRjRUKy9EQ1RKQ3dta3VYSVJyZDZsUml6YW13WlloT1pta1MzelRu?=
 =?utf-8?B?aGNnZlZMeDBiQW4yMTErMHU5cldLQXJ0QkxHbnJpdXdqeUk0K3lQd1EzWVUx?=
 =?utf-8?B?bTU4dHlSTXJnL1AxV1V3MVBwenZEY1R6MGoxS25yRlNRWnFJaUNlaXhMdTk1?=
 =?utf-8?B?MlhPcEtSc1E4bU9BL0NSU09YalpLL2pDcHZYalhvOFV6c1lyNHFCUWdZbU41?=
 =?utf-8?B?b1VycVBtZ0tTY1I3SFVpYXpkR2F4RENFc0lzN1VOQ0NIRlRhTFByUFpoWGZL?=
 =?utf-8?B?TytQRzZqdFczdFpkbXlPbnh2a3ZSeXRXa0kvekJmUW1RMG1GZGlLSll2UUFB?=
 =?utf-8?B?QVIvVkVuV2I3RXdONElGK0dZME96aTZhL3R3OXZmaGVBVHI5VURKMXhKTFdX?=
 =?utf-8?B?amppSHZpdy8yTHBQRk80aVBrenRhNFFBM3RZeGYzWHRoVVdIbGNoRWo1MGFy?=
 =?utf-8?B?ck9iQUpFUytoZDRkWmZVR0R5MTJTVTdOS1E5cUd2Um5nakp0YUpyMnNhTytF?=
 =?utf-8?B?QXJyNDAwdHpWclUwa1l1Ti96RHZ4WGxxcHlWcnJZQ0hvbFlETldhNStjTDhs?=
 =?utf-8?B?YmRpTXRVamZqRTZZa1dnNGlzaEo0dmkzYjd6aEt6K09jK1ZiWGlxV1BDekJF?=
 =?utf-8?B?ak0zZ3ZxM2ZYczR4bDZXWHg4dHR6YlJDdFVOU3BndnZPWHJvbDQybkgvb0Er?=
 =?utf-8?B?d0ZrRkJNZmRPdVRscDhROXV6WEZCS1RGR2t4K1VyYXp5dCtOSGtaVXBKd2N2?=
 =?utf-8?B?L1cwNDc4c0ZWVGcxRFRHS2IxTXpjRzIxMFdOM3lZKy9uZ1NJb2ZjdEJwN0NX?=
 =?utf-8?B?alpiaTZacFBGbG1Rc0pBOGNXa2MwKy9GaEJ0UGVTZVhDZVFuMnk1VjZMY3oy?=
 =?utf-8?B?b0dsZytpL0duU0wxZVNTZWdRakNZTUtpTU1MTGI3ckZqTTh2RXJDRW00Y3Iz?=
 =?utf-8?B?bkVyRkNuMmNVZHJ3bEl6Vjg4dDBHTHNQSmllQ2UwVjZZM2I1YzNhVFFEc2Mz?=
 =?utf-8?B?SmZ3d0NOOHFwU3oxRkxHWDFvbHFZc0hBZmRwelA1M1pHMFgrdVFPRnFMYzBv?=
 =?utf-8?B?NG95UEY1ck5xdS9wYjZZV1d1blRuWDZtZkNlenBMVkJ6WG5GbjNpSmttQnBr?=
 =?utf-8?B?U3pSWWxXdzRjL1pXcm8zL3dFTkZsVnZMT04rWWljbCtxSWxrKzUrcm1qT1Qw?=
 =?utf-8?B?REExaGt0ZGZyc0xlMjVMRDNkajRzcnIveGpJMzNHcnEwdC9INElTQVpBTU1R?=
 =?utf-8?B?b2xDTjdoTWhnNitMVW1qZU5EWXJOejRtZzVIWmdQdG13MkhLNTdPYzNaR3dq?=
 =?utf-8?B?QkVHMjlMQU9oVWxKQVpSc3RvemdUb2ZaM2NiQWNSNWQ5RjF5NDVhTWZIVHpr?=
 =?utf-8?Q?TVWsRUqBszv85FLHYaCbkxAK3wFBfuSB8ABsE0W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cjJ2T2IzdGgwSUNyakxiLzcvdlFMVExXZEo3NFB1WkJRUW85R1lyNXIyVWlN?=
 =?utf-8?B?c2c4U1VNUEIwN0xLWlFWWGhHTkt4cU9nekJ1ZkVveWlBSkE2SFprQXd1WFpN?=
 =?utf-8?B?VHowUVRKbHZiQjkzbCtEa3pjZFM4Unl1OEZrcTltWEpKZHJzT2tOV0Zkd1dI?=
 =?utf-8?B?VDhseWRaMW9iMHBWamNic3VhOS95aVl5K2FyVnBXZWZjVzZaZzI5b1VuWlZp?=
 =?utf-8?B?WVdudWNTQ3hWWWtibUs2N0s0eVRWUHlZMzN3azZXZTBmSVlzNldmT0NHa1dW?=
 =?utf-8?B?NEFDQTF5enZjU0FWVWFOaTJ1dUVqY3VadXJRbTBubkpHanhtSHpycUtoRUtJ?=
 =?utf-8?B?cDYybWtaS3JuV1lyYmNoT0VuL09IaExiaFkxb081eUkrMFI5U3BmeTlBZXlw?=
 =?utf-8?B?WVMvSUo2ek9FTGhNUlQ5WFhyODZQRFZDc09aQ0UrYVlHdEJkV1lWM3B2MDZE?=
 =?utf-8?B?UUU1bERmbnd3NFNuMXptN0ZudTN0U2gzUWo0Q3ZFcCsvNG5ONEduc285NVNG?=
 =?utf-8?B?SWM3bWt6c0tUeExicGd3eFlLcG90dXE0dmtSeTh3WVAwVWVPZis3UlFPZEFB?=
 =?utf-8?B?dWNiR2pjemxNZndMeHFkQzNSY2tkQlAzU1lhWGc1K0VmOVJMTE84ZnZ3eEcy?=
 =?utf-8?B?dFBoQWdyeFV0alB2Ym8rUWc0RjR4ZVk2NUNNTFhMNjNlS2dxRVJZbU9jUlZT?=
 =?utf-8?B?TkpNYjJqSlhHb1lDdWNGRFZjWkRiamdaOUtYeGFrMUhFZG5tYWdPZTc2NjdX?=
 =?utf-8?B?T3RQc0dwcE10ZVlmcEdHeE9aTm5TVHpEbTQvbUhteXhJclR3VlJnbE5Pd3Bs?=
 =?utf-8?B?V1E3VWJYNmU3TC80L3Q5YjJ6V3NRaU5CZjFINE9UOStlRjZDWHRrQ0ZQOFJS?=
 =?utf-8?B?cEtyK0dOcFg2SXlkTiszRnZ5c2RuM3JvQ05TS2hSVnNjSVc1dDdtTUNYb1Az?=
 =?utf-8?B?ZExsYW8rbkRGMTY3YktUY0dtbmhheHNoSzd6MFdZeU9HUzJGYTNRbmV2MlR0?=
 =?utf-8?B?ZWVzamVVZ0RPQmczWkdCZFNLYTZCRUsxbUkzeU1BQU9DdHNpU2J6ZnA3NzhO?=
 =?utf-8?B?cUxGRnk5dVdBN2x2TThwN1JoNFhXbnczL0hFU2QzaWYwdUppaG5YNytwbVB5?=
 =?utf-8?B?blRxRFF5amcvaFVwSi9KbWVVVkVxR1J1d0I4b3F3MFg2YXNNV20wcFZXTTZC?=
 =?utf-8?B?WFgwUXQrVnEvckl4cGZSSVBTMzJrSFUrVWFvcVJvblVEVXIxWWVLZjc3d0pj?=
 =?utf-8?B?VmRDeURuUWlwaURzd3BJbW1mWGgwWEtOVkNWV3VsWWw0WXpkbjhOTUEyYmYr?=
 =?utf-8?B?a0VMSUlrSGZ0cTN5SDhRV2lYdEw0VEVvTW9RVmhhQnhqbGpsY1lRbVBuS3hB?=
 =?utf-8?B?MWNhR3MvQ21tazMrcDlqbms4R2FVM1N4WnNUbEduMmZTZmt5aGFyMzB1MGNk?=
 =?utf-8?B?L256U1NFR3VVaHdlcGkwMGQwL1RzOWhmbVZTN3dnVTUwWFJ1TlVGd3RPazVI?=
 =?utf-8?B?SkhhSzFvMlFDbWF4QllaeVZNL2pDaS8zUmMzN1BUdmpmKzhpUFB1czNkTXI4?=
 =?utf-8?B?TVBNUVo0QXJIcGRWdjgyc2RwcDVCMEEzSXNSYjZKYVNZUnhsMTN5ZDU5dGFC?=
 =?utf-8?B?T3hDSCtZUkNKWnhhcS9NbnZLclRkWHB2Q05JR2VoSEJzU2ovdFRuMjlRdEJZ?=
 =?utf-8?B?bGhYMDNLd3dnNzUvSkZIVzJxSG1hWVRERENYeWF1ajhLSTZNYXBHWjZVYjUw?=
 =?utf-8?B?MkV0a1BPYkRTUW1GSmVIVGt6K01TVisvYlVLNEN6SXAvVnJBR3dtc2QrSU10?=
 =?utf-8?B?RmFJMEhzUVhFb2k4ZzV4blZmdzZYdnRKb3A1ZTI2QjJ2cWZNVWpFL25uTkhJ?=
 =?utf-8?B?dUk3U1dxUmRwTHQ0aEtjMmdmQkxZaFQ3cFc3ckkrelJ4QlJzUllDck44TFJB?=
 =?utf-8?B?d2lHZ2RxZ2xCbHZJOUxkZkYzVmpPb3Yyc2RKMklhSW9odVNrcjBPZ0NoOCtw?=
 =?utf-8?B?YjFJRXppL0N2QXNadlJudlIvdVJQWGhhWlhCSXNud1FWNXpGRHBueFZadTcr?=
 =?utf-8?B?RkFrNktENGYxUWZQWkZuRko3YVhDMHVEblA0NnUvU2NnZEVMcHF2MGZSdzMw?=
 =?utf-8?B?cmhPRnZOeGViZy8zdCtaSHpMUmw0NUIvMDAvSXEwUWx5MkFsaWRnSythSlZM?=
 =?utf-8?Q?BqSbFwuvX4hCmci1Vaxerbw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a2WtlJeFGlBnOPPGzDxDc/HqK0NEFfzWuXVHopYq+7iRIA9J8Lu3UNUKh6zEwwhlIewp0wGnsKDRdfgrAfytlrml79d9iBPPHWQjExwHekqibmSr745oWJdjyooCuHZ+MeliymSDcy5dTEKmo+WJUSuaHhmnvApwD6R9QW5WyATQk1sOtsr02bx5FPdJ5QjM0DNh4zBC1pseTbGm2n7eyyZ75j422x98KYK3mcXD4MoudUCBhhym064Ql7teodDxPXMSPWk8S5GDw/plj32E5B9n4AzAiBFCsQewNP8umEdS1c7aEC+0MTMGrvB72k1uk04UVcH2OVq+35iUhCrkvWEyoyqfwH9ETDvbDdUi50rB/nUjIvsCuj8JT+yOvfCZ3wCWVrkaVeHNp0qyGyH6GfRVlW+dgPdGDJh7WT67bq3FwQGZ5l6C5SiEgokC0CPUVr1V9YBpx0NJDxlHId/p9sEfOaWZBSoqK+K+754GqHnn8rNCYgEtPKTQiOsjPlViNpZI2aPPXmA/Cbj1fOpNHwsVdCrX6JgE44EFxbjDvD3vxz50Pje2lNU9DqvAlPboSIDnbfBE9FbmyukuHX8RS1/RpPEMZWmMvrB9+sxBWQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb60d53-ce04-4017-55e3-08dc8f7bb90d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:47:52.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61XgUnmGqBSUHLeFGf5UStKHtQvWMRA6FgYYrUtZyCS7cgCOA0AW4xAmaNEKYWMTZE2rIvLm7rEV7evIDadseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180072
X-Proofpoint-ORIG-GUID: fnQ7qJEac1jyHoNt4x4FRXr9IlENFfef
X-Proofpoint-GUID: fnQ7qJEac1jyHoNt4x4FRXr9IlENFfef

On 17/06/2024 22:50, Andrii Nakryiko wrote:
> On Thu, Jun 13, 2024 at 2:50 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Map distilled base BTF type ids referenced in split BTF and their
>> references to the base BTF passed in, and if the mapping succeeds,
>> reparent the split BTF to the base BTF.
>>
>> Relocation is done by first verifying that distilled base BTF
>> only consists of named INT, FLOAT, ENUM, FWD, STRUCT and
>> UNION kinds; then we sort these to speed lookups.  Once sorted,
>> the base BTF is iterated, and for each relevant kind we check
>> for an equivalent in distilled base BTF.  When found, the
>> mapping from distilled -> base BTF id and string offset is recorded.
>> In establishing mappings, we need to ensure we check STRUCT/UNION
>> size when the STRUCT/UNION is embedded in a split BTF STRUCT/UNION,
>> and when duplicate names exist for the same STRUCT/UNION.  Otherwise
>> size is ignored in matching STRUCT/UNIONs.
>>
>> Once all mappings are established, we can update type ids
>> and string offsets in split BTF and reparent it to the new base.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/Build             |   2 +-
>>  tools/lib/bpf/btf.c             |  17 ++
>>  tools/lib/bpf/btf.h             |  14 +
>>  tools/lib/bpf/btf_relocate.c    | 506 ++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.map        |   1 +
>>  tools/lib/bpf/libbpf_internal.h |   3 +
>>  6 files changed, 542 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/lib/bpf/btf_relocate.c
>>
> 
> [...]
> 
>> +/* Build a map from distilled base BTF ids to base BTF ids. To do so, iterate
>> + * through base BTF looking up distilled type (using binary search) equivalents.
>> + */
>> +static int btf_relocate_map_distilled_base(struct btf_relocate *r)
>> +{
>> +       struct btf_name_info *dist_base_info_sorted, *dist_base_info_sorted_end;
>> +       struct btf_type *base_t, *dist_t;
>> +       __u8 *base_name_cnt = NULL;
>> +       int err = 0;
>> +       __u32 id;
>> +
>> +       /* generate a sort index array of name/type ids sorted by name for
>> +        * distilled base BTF to speed name-based lookups.
>> +        */
>> +       dist_base_info_sorted = calloc(r->nr_dist_base_types, sizeof(*dist_base_info_sorted));
> 
> s/dist_base_info_sorted/infos/. Do we have any other info here? Not
> distilled base one? Not sorted? What's the point of these long verbose
> variable names besides making the rest of the code longer and more
> distracting?
> 

When we discussed this earlier the concern was in distinguishing between
distilled and base BTF information. Later we have name info and
associated types from both base (the search key) and distilled base (the
sorted distilled base info). So we can use info here certainly, but I'd
propose using dist_info/base_info later in the function where we also
use dist_t/base_t.

>> +       if (!dist_base_info_sorted) {
>> +               err = -ENOMEM;
>> +               goto done;
>> +       }
>> +       dist_base_info_sorted_end = dist_base_info_sorted + r->nr_dist_base_types;
>> +       for (id = 0; id < r->nr_dist_base_types; id++) {
>> +               dist_t = btf_type_by_id(r->dist_base_btf, id);
>> +               dist_base_info_sorted[id].name = btf__name_by_offset(r->dist_base_btf,
>> +                                                                    dist_t->name_off);
>> +               dist_base_info_sorted[id].id = id;
>> +               dist_base_info_sorted[id].size = dist_t->size;
>> +               dist_base_info_sorted[id].needs_size = true;
>> +       }
>> +       qsort(dist_base_info_sorted, r->nr_dist_base_types, sizeof(*dist_base_info_sorted),
>> +             cmp_btf_name_size);
>> +
>> +       /* Mark distilled base struct/union members of split BTF structs/unions
>> +        * in id_map with BTF_IS_EMBEDDED; this signals that these types
>> +        * need to match both name and size, otherwise embeddding the base
> 
> typo: embedding
> 
will fix, thanks.

>> +        * struct/union in the split type is invalid.
>> +        */
>> +       for (id = r->nr_dist_base_types; id < r->nr_split_types; id++) {
>> +               err = btf_mark_embedded_composite_type_ids(r, id);
>> +               if (err)
>> +                       goto done;
>> +       }
>> +
> 
> [...]
> 
>> +               /* iterate over all matching distilled base types */
>> +               for (dist_name_info = search_btf_name_size(&base_name_info, dist_base_info_sorted,
>> +                                                          r->nr_dist_base_types);
>> +                    dist_name_info != NULL; dist_name_info = dist_name_info_next) {
>> +                       /* Are there more distilled matches to process after
>> +                        * this one?
>> +                        */
>> +                       dist_name_info_next = dist_name_info + 1;
>> +                       if (dist_name_info_next >= dist_base_info_sorted_end ||
>> +                           cmp_btf_name_size(&base_name_info, dist_name_info_next))
>> +                               dist_name_info_next = NULL;
> 
> Goodness, does this have to be so verbose and ugly?...
> 
> First, does "dist_name_info" give us much more information than just
> "info" or something like this?
>


I'd propose using dist_info here for the interator to distinguish it
from base_info (the search key) as we do for dist_t/base_t. More below..

> Second,
> 
> for (info = search_btf_name_size(&.....);
>      info && cmp_btf_name_size(...) == 0;
>      info++) {
>    ...
> }
> 
> And there is no need for dist_name_info_next and this extra if with
> NULL-ing anything out.
>

There's a bit more complexity here unfortunately. The loop initializer
is straightforward - we do our search for most leftward match. However
from here we have to check a few things in the guard

1. has dist_info run off the end of the sort array? (dist_info <
info_end). We can add that into the guard.
2. does the current match match our search key? In the initializer case
we've already checked that, but for the next iteration we need to
  cmp_btf_name_size(&base_info, dist_info)

So doing 2 is unneeded in the initial case (we've already confirmed the
distilled info matches via search_btf_name_size()). Setting the _next
value in the body of the loop therefore seemed like the easiest way to
handle this without the loop guard getting too unwieldy. Putting the
test in the loop guard would mean an extra unneeded comparison (that we
know will succeed for the first iteration), but if that's not too much
of a concern we could certainly do this:

		for (dist_info = search_btf_name_size(&base_info, info,
						 r->nr_dist_base_types);
                     dist_info != NULL && dist_info < info_end &&
		     !cmp_btf_name_size(&base_info, dist_info);
                     dist_info++) {


> Please send a follow up with the clean up, this loop's conditions are
> hard to follow (I had to double check that we don't use
> dist_name_info_next for any decision making; but I shouldn't even
> care, it should be obvious if written as above)
> 
>> +
>> +                       if (!dist_name_info->id || dist_name_info->id > r->nr_dist_base_types) {
> 
> another off by one? Valid ID is always < number of types, and so `id
>> = nr_types` is the condition for invalid ID. Please fix in a follow
> up as well.
>

Will fix, thanks.

>> +                               pr_warn("base BTF id [%d] maps to invalid distilled base BTF id [%d]\n",
>> +                                       id, dist_name_info->id);
>> +                               err = -EINVAL;
>> +                               goto done;
>> +                       }
>> +                       dist_t = btf_type_by_id(r->dist_base_btf, dist_name_info->id);
>> +                       dist_kind = btf_kind(dist_t);
>> +
>> +                       /* Validate that the found distilled type is compatible.
>> +                        * Do not error out on mismatch as another match may
>> +                        * occur for an identically-named type.
>> +                        */
>> +                       switch (dist_kind) {
>> +                       case BTF_KIND_FWD:
>> +                               switch (base_kind) {
>> +                               case BTF_KIND_FWD:
>> +                                       if (btf_kflag(dist_t) != btf_kflag(base_t))
>> +                                               continue;
>> +                                       break;
>> +                               case BTF_KIND_STRUCT:
>> +                                       if (btf_kflag(base_t))
>> +                                               continue;
>> +                                       break;
>> +                               case BTF_KIND_UNION:
>> +                                       if (!btf_kflag(base_t))
>> +                                               continue;
>> +                                       break;
>> +                               default:
>> +                                       continue;
>> +                               }
>> +                               break;
> 
> I gotta say it's amazing that C allows this intermixing of breaks and
> continues to work at completely different "scopes" (switch vs for).
> Wonderful language :)
>

It's an odd feature alright. Let me know if you'd prefer an explicit
goto to make the logic clearer; I agree it looks strange.

Alan

