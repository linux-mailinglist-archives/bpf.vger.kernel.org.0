Return-Path: <bpf+bounces-71204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CBBE916F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 409EB4F23EC
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C1369977;
	Fri, 17 Oct 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ShIJqbjM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hcQcS0CH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAB34F479
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709775; cv=fail; b=thCOOrh4Lp/gSZ/3KzBPOORFIkpSocOlHTSwSOeyU4/x3pP3srF7swhguQF2kxTuhUJz6F48vxHg+DvL9esgz758nt2oNClEkh/FBIUqbE1e3Ua3OOKKET6jEgWQ3XKBwMVTqn7UIk7W+eVHcfl43mOyUJfEGJfLBs+/eF882rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709775; c=relaxed/simple;
	bh=tvI2QmZ0+jcfR10tlMKfVK2oED/e+8zu+c9Om8CWBIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mgVpoWJk+Qp1xOJRQoFMznJeo1/F4ZpfBc+kXohgovWoWpgakm9YOqWE+1eNAkoJ+V/J9vnewZHTe3D/ruT2tYugQKRcxgbZGIecTbij2ydfEyEN4NoZUXIq9BxDwSkYkkMa95bA6Sl+tdsssxB9eN0VN0JOafadtBjImS7ECSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ShIJqbjM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hcQcS0CH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdbch019437;
	Fri, 17 Oct 2025 14:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q3zf4zkFAH5MR1OOdH4fsC46MEzfUSDK8fxLU8I2p8E=; b=
	ShIJqbjM0tDsIAoBjYrw6Vte+lWluMOyHu9Yn5nkNC45jGIt/QIgv9b9EsABhLjb
	iSMWScQD6JOmfEtT24i+VqQwCrSj6/IRtK5Vs+8PZQNUO90RPaug6Lfs9wze1pS3
	rRMIWGiCVsP+B09V82i+uwr8bBGnlTY9JFehDhqKBCvlOAEa/L7JGlI/hq0fEKaL
	zwVo+OUBG0mxO8eBI/P7EJ6AZAj1gWqOLiLMa4QBk7sMmiTSzIG7kHy29tZgm6HZ
	SgnuFH5m3YIB8og5zL5b4fQocjTCTTUJVk++V+4/T4jK4kVLOgr+3e/D05ewUWb+
	c4nwhvhwFHvadG5LS2Ogbw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59k1jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:02:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCYYIU018169;
	Fri, 17 Oct 2025 14:02:24 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcvppw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 14:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybkeqiTFRs3RpJRab0HRLcf7YSidbAlnGKnAor0WqJe99Vhhxg+kvA/5HKFx7saH4Q0njHXBnoZTBFX0FoCZII9eQ3vTvu4u9v3U/8WiwVedUHFb9eI9gBDi8w7Ui4ELCqimpUxeQ9KxSTMuYWAQ8pqCTQjCZHIJf/u5p6wEYSP1uxiqtxXXe2PfY9JfR5ki/kqnNUO7OPAAR5zKYrgUX/vKHNRDzGCzUOZEZKa/CjCMih2vEtioTcIMZddIbkUNa3HFcCz8eORxP85cb6FuewEGiukTGBB7cAJckN3IbSjiiG1iTj7zd1zolAmliSONJ/qYzxy7yrRrLvdhdoeWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3zf4zkFAH5MR1OOdH4fsC46MEzfUSDK8fxLU8I2p8E=;
 b=J//wsiOXcogumpqBhwlYshtIuAVsRQ2e0XM2CoLam6dcM/ujUJGva9hDnDqkMvtwi/ArzxoXA5BKqZATyqNs71d3gWDLdMq7AGDLdlFZ42jbucsb+Z7MmROLvGTMlHKtBKYwqjzG3QvS8l1y9PZUOKThUaOBwU4KyrR/ZF+6gNce9tvrjxsxa0updVgsJJ51ksZAwdf2FY2dZyEcGTGGGw2HkJxZDa8rPs5fVNPjUh65w3VdTT5e2Ni131v1sdkftw7Ls8Ew7SUZBLDbx3/gKQSgRrtFvzx1nMx1rdoUHjH2girKkXCIoClyG69K4qz6gr9YlFkf441R+SoVs+eJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3zf4zkFAH5MR1OOdH4fsC46MEzfUSDK8fxLU8I2p8E=;
 b=hcQcS0CHQdFlzIMq6YThHK3q8p2rrQW7DbPEyf3cyjuYhqwMljLlcONR+wEy/AGKKbDtzOFxBOYa+SOjr4GOCLvVPVMrT4x3CGtQZ9N4dvXl8+dYjqJqH46KR8hTSMU1QRh4+ltiA0wS6HOC+9tzWsZb0CsHFenVCwkDyXcbCv8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 14:02:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:02:20 +0000
Message-ID: <73e5248e-80d9-4440-92d9-864112d4e53b@oracle.com>
Date: Fri, 17 Oct 2025 15:02:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 14/15] libbpf: add support for BTF location
 attachment
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-15-alan.maguire@oracle.com>
 <CAEf4Bzanp4fSOLZp5a5bifXh3447-rjScPRVwf2xDsA_pNmizA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzanp4fSOLZp5a5bifXh3447-rjScPRVwf2xDsA_pNmizA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0320.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1d79fc-67fb-408e-48b6-08de0d85c9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmwvQTdkSUVQSG82VFJWZlN3YjloL1IwNVZHdU4xVUx0dEo5K2xwcHV5ZGJK?=
 =?utf-8?B?Mzh4OHVuZTh3cEovb29EOE5NY0ZtT1NUcUhqamlLbEwzUmsvZzlveTdQeFNv?=
 =?utf-8?B?endzVUNlczNuRWlHSWhmc2lHZG5OTDJwRWIvUUtqcnBiWXNWRWd3QkVLVHh6?=
 =?utf-8?B?Rmk4eWdkcVVWdURRd2RNZ2dtUG1ncXpOb1FUM3lhbzFYOXBOY3ZqeFhKS3g4?=
 =?utf-8?B?NkN1bHQ5c2xobThDaWpNTm1mdFFBNTkrL1B1VFFUVVNpbVNiWWVWbHZSRWx5?=
 =?utf-8?B?RTVyM0FBZG9GbkxOQk5DSXJPVWQxd1hnQmZIZTVSTFUvT3BRdlZPUEtiVWhi?=
 =?utf-8?B?RW42Uy9lZ3VPMERORHZnZjZyK241ZGRJV2U5SmNoak0vYys1T1hDNUtmZHBL?=
 =?utf-8?B?SnNNNlFnL2xySm5KOXJKYzFoS2x2WGNqR2srTzdyNDVhUzMvUzJjVlBZYUs1?=
 =?utf-8?B?Umk5TXBxcW5BdW5vOEMwU0tQRXRIR1FrMThDZExLU2JqU0FLSkhKRHBjY3Zi?=
 =?utf-8?B?aFNzSE5Dck9QODVqdWUxSENqYS9zWUJyTnBDRDgvSEdHbHhieFIyZ0dDR2ty?=
 =?utf-8?B?L2h3NFBTVWVudEswVW12aHN1aXN4Y2hRdGtvU25VUWFhbEs2eHpwb3FUUHVZ?=
 =?utf-8?B?d01heXN2bG5sYzdLYTBhWmhjbUFKYzlPUmVYS2tpQnNPanJwd1p5TFVQaEZZ?=
 =?utf-8?B?ZXBlUlArUjI4WGE4c0w0bHBPZVJlUkoyQ0h4NFZXdGxuS3M1SHdKZXNWbitm?=
 =?utf-8?B?Q2VMbTdtNi9TUXNVc2wya2hwbFQwaGVPSmh0R2wyYVkrV1huaFlscmMxSzdn?=
 =?utf-8?B?UlI5Tzl3YU5iZ1AxRERSbTkwWlBrb2tRMHJlUW5SZmVwbjFITUxLZE10UEYx?=
 =?utf-8?B?MUZyVlZERUg0RktHamZZVHBWNUdhTk9qa21mRkNQY2E0MDZnNGFXR3Ntc1VJ?=
 =?utf-8?B?d2xMYUgrZ2dNaDJzSWozTmVpMjAxWmxZZlBNQ1NRV2N6WXRmakZNTkN3aGRz?=
 =?utf-8?B?bWNKbXQ5UXI3SkJGbkhnRWhrK1hCYlVqTEFPVnAvTGFFZmV4RDNjUUJTTk1v?=
 =?utf-8?B?TUE5eDM5a2E0UmNrdC9FOUsxTzNOcFpqN2xLMlFYYlk5RGVrcjZMM29Xb2dx?=
 =?utf-8?B?MnJmM3VhcGJTNlJqM2o0MGpPUXAvcnhvTktKTVUrNnRhQ0tRa3dPQmU5dEE1?=
 =?utf-8?B?ODNxVms1Wm1WajB2SDJ0K01IaXdydmVQbVVxSTBnU1lZZlJ3ejhHSXNNdmo0?=
 =?utf-8?B?S2phcU5NcnBsY2xxWWxLNHZBRk14ZGxMeFQ1MkhvRktLSEF3SW54YzFPdDlL?=
 =?utf-8?B?cTVZTWJVcjFwKzRHekVRZitETHlYbDJoZitTdzJOUnVJTzJjOTZwMUNYdWFa?=
 =?utf-8?B?Ryt4NzJSdlpFUHg3YWtGYzhQOGNPdVZCa2FoNzRuZEhzSS9SNExkc3VrZW5m?=
 =?utf-8?B?NlZqRldFOXNjSWY3UGxTWTVSNzFIdWJJSVh2bFpGU1RSY3p4NWtNbEl5akI3?=
 =?utf-8?B?WXlPN3JpV3puUU95aGdkakIyRmFsK2ZJUVZkRFZ4cDFBSHYvSG9ROGxMQkhp?=
 =?utf-8?B?QXpQekV1UHUrTStqekIrTEtjNjA5NVltYnBvbCs1bVZKdUh2YkhEdjNXVTVL?=
 =?utf-8?B?S0hxN2ZxUW9OUUtvTm9Hc2hGNkwzeGh4Y3ViR0UxT0tCWVlDV09FbHpBQjF5?=
 =?utf-8?B?bkhBUDhDZjI0N2x3QkJPR054N1VaeldGSWhqS0RZQkVWRStyNjhPNjNxaVRk?=
 =?utf-8?B?MzllYXBtb1FLR3dqQmlwb05YME83cFQ3c3ZCTmVrQlo2SjFxdTEraHJ0OGtz?=
 =?utf-8?B?eG00R3Mya0ZWS3hjZTI2WGU0VUdhK211dGlKcWIyZ3NaS1JEMFZqeFVCRXZP?=
 =?utf-8?B?ajZrS01YQktGN09aS3BHZXRSWm5BcjBVMTdJMEpINUFUbXJoY3JhaUdLUXVU?=
 =?utf-8?Q?Co8YAKankoZrR+j+SKI0LDhLrnUkxjoB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qi9mSm5WNGVJejJCU2pKcTN4OGlHMDM5RFZSY1dlQUQza0ZydmxmTHkyczFH?=
 =?utf-8?B?S3JRdDEwSU9CM0paV00rbDlQalRDVWJHYm1ld2RRZFVkVllrY0MxOEF4T2d1?=
 =?utf-8?B?SjE1OVhBcEZwWFFMd2Z4NDl6cXp4LzNqNWxiZEtXTmJwTFhqdHM5bTlWOW5r?=
 =?utf-8?B?ZUJHV09hQVlMMU0weUlXcDdWMDRSbXVUZWxZbEZ1UXUyeG92bDlLanZLbmFw?=
 =?utf-8?B?dDYzY2dPY0VRallUUjVvK0JyWjEveHRKOG9vWUlDQnRxTDgyYzBCMGMzZlBX?=
 =?utf-8?B?VHliSTAxcEtiZ2lGRXZvSjR0cDZTWE5Pa0hoaVB2cGpKRDQ3YzN4THJtVGEr?=
 =?utf-8?B?U0NGVnd1TS9NQWtTYWd6MVM1ajNMcGROTUZGWWVWRWJrOTBYTDJZTjVaQk8y?=
 =?utf-8?B?RmlwZzVVRDBDRGU4NDJQQnJSM3lkNC9qcUZQUDlrRkdWaUhwY08wWU9mV29F?=
 =?utf-8?B?S29mTVRlbC9hVmt0RXM2aG94QmFTUDR0eXp4clNOaFJscVhnb2VMNTVyUHdB?=
 =?utf-8?B?K202VExuMTM3R3J0aFVBMDFrdjJ5Q3J4K2lDUEw0VEtFanVUb0toVlBNcFFJ?=
 =?utf-8?B?REt5b1l5SFQyWXdnVnYzME1WR3UvUU5BY09HQnkwcFZWWmRhRjlLYncxMG5s?=
 =?utf-8?B?b3JHbnZyNVFRV0NsUDNlZGc2M0JxZ0VVTFlaeUNQalVkREQrZlZKY0VMQTdO?=
 =?utf-8?B?VEI0ekExcVFjeW10SDh6ZkRFTkdHb2RjTnYrWWlHZmVibi9Zc3VKaEhOUHBr?=
 =?utf-8?B?bWppeVFYRUpNa1QrbTVFbUpDSzJiT3VsYXA1aGIzWHFPa2dDeEVBL1N4SGNs?=
 =?utf-8?B?emE2Z1JER3VXTVVQMGs4cWJXbFBuQTBzV09LTUQwWHRUN0dHNm04clArQXFD?=
 =?utf-8?B?cWhKejgwa20rK21jd2VwWlpEQUszdkxWbkhxdkdMMFZpRi9hbEdaSVZrVW9i?=
 =?utf-8?B?QzBvWEptOUJzRjRURk5GbTJPaVBHeWJDdGxvcDVTMThqeVN0Q2pEUDF0VlZI?=
 =?utf-8?B?cVQ5UEpZNjNTRDBFR1QvWXBZQnpiQnNyYlBDS0g5WUZld3JVVnJsa0JLbWtw?=
 =?utf-8?B?NWxKTW5EcUtEcEMwRzU4bWhtY2ptWWVwYkJBWms3N2RvY09Xc09sV2R0RERm?=
 =?utf-8?B?K25md1N6cGxzWFRTYlprS2ZKaE1TV0F0TGkrK2poMC82c1NjUDVZUkN0RkN2?=
 =?utf-8?B?U2IwZVlza1IyaUF6dTMxbXQ3bDVKeHdEdnBxZ2poWmdkekZURWdmZG1yYnZ1?=
 =?utf-8?B?Zi9PWDdaMTJDOEVXMmd1eWNpUWx4YzVURnhQMURxYWZVR0ZJaDFsSk5wZnM0?=
 =?utf-8?B?MmRlYWVDTC9uZEFsWHF6Zk9KWk8vRE9RcFFQZjcxYXdoYkFtQ0FwWlZjam5z?=
 =?utf-8?B?WHZuQkh2SU42ejc2c25zWFRiUnNkMjlsWDlmQWQwK1hvaWRaYkE4b3ArVVJp?=
 =?utf-8?B?R1JFQzRubDlCMzJGbFRnOUNHRmFqUFRaS0JhWkpSb0VOcG83Mjh4SFF0cmF5?=
 =?utf-8?B?Z2FrWGFoTFlPRDl5TlRHMHkvZStaQmxVemJIWnl5YnRYMGlzWnZhNVRVRmZo?=
 =?utf-8?B?VzVYRHpvNVM1Z1J5dVQ3VkJyci9xeWdPeThLTkF6QzF2VG1xNDBRZzdIa3JL?=
 =?utf-8?B?eitjR2FUQjhyMWM0K0RtTGtBY2wyTyszQ3lmeUVnL0lVQVlRWitpenRSSlp4?=
 =?utf-8?B?UEg1MmFOL3FFRGhXTHhTNFc2dVVPRktWU0hhRjhpN2FkOCtuaVhPUjAxWUp5?=
 =?utf-8?B?N2lSWklxVndlN2YrTUY4MFdETFJ6NzdaY2o4UkI3b25mOU1LcFZ0RW5IakF4?=
 =?utf-8?B?Tk04d3NEWHNlNDBKbHVkd2pUbCs4QlJSS1h4S043NEk0ZUtlM1gxVkhpODQ4?=
 =?utf-8?B?Y1BuMzRLcGRqeklVdndaQnNyOFp0bEVOZUhEMlpxSTBFY255OHhYcFdLcnlv?=
 =?utf-8?B?bnp6ZU9RNzdRNjNzNDJyekw1allqRUw5SE9WY05EWjFDdWptcFJqUllpR2xM?=
 =?utf-8?B?cnRhWGtDcTRsMWJiVXB2L05tK1FOdGFLa2VzMFQzeVJuZmE0Tnd0dTY5OXJZ?=
 =?utf-8?B?RTJ1TWtSSjB5TFEzK1kzdkh4WFV1Y1Vpa0pFenF6YW8vZWNJd3pvSFlCM1hB?=
 =?utf-8?B?K04rV3RnOHhYU0ZyWHBheFBMeGRFMDB5a3J1ZVhYME9jN3ZZcTZpcnVyNUY3?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ckGbK4THjowa7eDFprETYdzFuhdhDyA7zu6ce8N0AoEKcPpgPsqCipfe8ycKpNDcxO538alM2TMLpvWtPG06F8Ya7wEB5huscFW0JmxryglOsObGlw59K7xa7m5uPgqc3WYBMtBJSha/gi0fcyAzcKubsIW0plRd/+DRMkWe5bVZrMFnTKmXRbmvciPAs/U5UaK1iNBRAThZ33CbFVskgTD8S8BcOV+lkATZTXcbQobg4CK+1QknNfMO64bVmFyy/DHyOn24QA468J822B/9upfLe4uc93EhUN1JX8ct0F8M+4uFUcCo1o2NXWBMa7fBDbICNmyJJxks8J21EjRmsAepZcSPouuM3eiA02Cld+RWt3HB5Tf81LpwIj1js9lKHUR4Q08nxzJVa1MctrO4SoX8DcPP2ngOSAAo0UrD/e+MzxLdh6GGfn9eINAilA3/8UD+Kz3CtN/rxvlwrtl4bpgP+MQAdgM1NS4KPn1k4bASNPDlefYtIsFa99Ar5MG3JRaA/9shAxHVoBF+KxaBcoaRFNdj89hfk0M7cs3z82ryLL1fFiLZBekHo0X2UeygAdkGv8De2dRoByAsxAVekvue5dOjZ1hoGGT7S5GBOuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1d79fc-67fb-408e-48b6-08de0d85c9cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:02:20.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMlS36Lob46OS+o7d7PuQLfVrjuIDudKSgif+Kfo6C/e4SsT1M6ZDz5y0Kbg7C51VrKMoVlDs51r8HDQJmF38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfXwlU6SohYwnDw
 DYlTbhlL119NH6bPv8gghzOvWLbMHtALX0Vu4avxXarU3/+H2TqrpVq1UUNQ1nZYtdZvkSRgTem
 nxHcmleZJ5je5cbiGPzeHBBDQaJVuy4CH/LEmIOYvvJcMbIOmRcxaR/2Qa4ApaMYJfHVsJitONF
 jg1BUkCKWWGB+cgSrcvSxPybUn2YdDLzVlY8mglU4lBcZsVps/F8m6MWbSoddmrBMa1Uh1GvrTK
 Rs33mj03Nuhm3k9NNNJSnLZzSEH1r1ECbpCfwYNF9C0fSsW4iyyypQn/8PF/LWFA5EKp3xkX1fb
 dIdhfUEOgCWu7Ru/p45QD/14ZFAWoKm4p3l5t3ixcoWOoTzC1kjP4Ds63xjmg2adyTZGbetbhlL
 FtevdqL57SHYMINszWrLY1OfEBZxjQ==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f24c71 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=gJaQRuwwOYSv15aHxKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: lxGzNOtR7A1xKCN5PEYk60XRkINKz_y2
X-Proofpoint-GUID: lxGzNOtR7A1xKCN5PEYk60XRkINKz_y2

On 16/10/2025 19:36, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Add support for BTF-based location attachment via multiple kprobes
>> attaching to each instance of an inline site. Note this is not kprobe
>> multi attach since that requires fprobe on entry and sites are within
>> functions. Implementation similar to USDT manager where we use BTF
>> to create a location manager and populate expected arg values with
>> metadata based upon BTF_KIND_LOC_PARAM/LOC_PROTOs.
>>
>> Add new auto-attach SEC("kloc/module:name") where the module is
>> vmlinux/kernel module and the name is the name of the associated
>> location; all sites associated with that name will be attached via
>> kprobes for tracing.
>>
> 
> If kernel ends up supporting something like this natively, then all
> this is irrelevant.
> 
> But I'd test-drive this in a purpose-built tracing tool like bpftrace
> before committing to baking this into libbpf from the get-go.
> 
> Generally speaking, I feel like we need a tracing-focused companion
> library to libbpf for stuff like this. And it can take care of extra
> utilities like parsing DWARF, kallsyms, ELF symbols, etc. All the
> different stuff that is required for powerful BPF-based kernel and
> user space tracing, but is not per se BPF itself. libbpf' USDT support
> is sort of on the edge of what I'd consider acceptable to be provided
> by libbpf, and that's mostly because USDT is stable and
> well-established technology that people coming from BCC assume should
> be baked into BPF library.
>

Yeah, that makes total sense; the implementation is really just there to
facilitate in-tree testing. We could move it to selftests and have
custom ELF section handling there to support it though without adding to
libbpf. It would definitely be good to have some in-tree facilities for
testing to ensure the metadata about inlines is not broken though.
Ideally this would be done by adding inline sites to bpf_testmod but the
RFC series did not support distilled/relocated BTF (which is what
bpf_testmod uses). Next round should hopefully have that support so we
can exercise inline sites more fully.

> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/Build             |   2 +-
>>  tools/lib/bpf/Makefile          |   2 +-
>>  tools/lib/bpf/libbpf.c          |  76 +++-
>>  tools/lib/bpf/libbpf.h          |  27 ++
>>  tools/lib/bpf/libbpf.map        |   1 +
>>  tools/lib/bpf/libbpf_internal.h |   7 +
>>  tools/lib/bpf/loc.bpf.h         | 297 +++++++++++++++
>>  tools/lib/bpf/loc.c             | 653 ++++++++++++++++++++++++++++++++
>>  8 files changed, 1062 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/lib/bpf/loc.bpf.h
>>  create mode 100644 tools/lib/bpf/loc.c
>>
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/loc.bpf.h b/tools/lib/bpf/loc.bpf.h
>> new file mode 100644
>> index 000000000000..65dcff3ea513
>> --- /dev/null
>> +++ b/tools/lib/bpf/loc.bpf.h
>> @@ -0,0 +1,297 @@
>> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>> +/* Copyright (c) 2025, Oracle and/or its affiliates. */
>> +#ifndef __LOC_BPF_H__
>> +#define __LOC_BPF_H__
>> +
>> +#include <linux/errno.h>
>> +#include "bpf_helpers.h"
>> +#include "bpf_tracing.h"
>> +
>> +/* Below types and maps are internal implementation details of libbpf's loc
>> + * support and are subjects to change. Also, bpf_loc_xxx() API helpers should
>> + * be considered an unstable API as well and might be adjusted based on user
>> + * feedback from using libbpf's location support in production.
>> + *
>> + * This is based heavily upon usdt.bpf.h.
>> + */
>> +
>> +/* User can override BPF_LOC_MAX_SPEC_CNT to change default size of internal
>> + * map that keeps track of location argument specifications. This might be
>> + * necessary if there are a lot of location attachments.
>> + */
>> +#ifndef BPF_LOC_MAX_SPEC_CNT
>> +#define BPF_LOC_MAX_SPEC_CNT 256
>> +#endif
>> +/* User can override BPF_LOC_MAX_IP_CNT to change default size of internal
>> + * map that keeps track of IP (memory address) mapping to loc argument
>> + * specification.
>> + * Note, if kernel supports BPF cookies, this map is not used and could be
>> + * resized all the way to 1 to save a bit of memory.
> 
> is this just a copy/paste of really we will try to support kernels
> without BPF cookies for something bleeding edge like this?..
>

Yeah, copy-paste; it seems unlikely that a kernel would have location
data and not have BPF cookie support. Even given the fact distros
backport stuff it's generally fixes not features like this. If we end up
moving some testing code to selftests I'll simplify removing no-cookie
workarounds. Thanks!

Alan

