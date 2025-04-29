Return-Path: <bpf+bounces-56960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967BAA1085
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419CB46797E
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE9221717;
	Tue, 29 Apr 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZkkJ2Ko"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDC537160
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940703; cv=fail; b=gjU+Nii8lLMXxm+7zoANoXA+Y8eRbX2iMXZmkwCcjXrPbqNXiHuHFjBzRAIpiZX/W9wrhPHzKPPxNftwGxDjODTv6+M9r2kB1jbRdbfePsu7snbkSCB7qX2o+E1lShVNMKKYBjE9LFXnFGlFikw6RQAhUbFjf9Obr5/pUCMXQSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940703; c=relaxed/simple;
	bh=gUOcCPwPAVWsEm1mPHuuXLmChPVNA1FQx73Zc0IZQK8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=kp4wD2S3dShBpjO2E0I+7Ruu7ABbq0UOozNdqpa2bBdDVA/uxXs/k9KFAaR4bV2JUSwHUNPa9F6sprdE5euHxHA1AE6/uEVTv5Zq9e+6epAEkf9V6vYeA6GpTi1M9d8tds5/rVPYLYAcK3d+Qb2CCUz/3hQuk98uvWZJPaYJ2w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZkkJ2Ko; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raFsSsvgMToIimA6+tsG86mtCk5KCiwyyq9fv7kNOZF5PbyDw4vUWJR0VmV7LKAh/dRW4Qk2jBXwFnNs3356VqlNPF0ChoDhvku83OIfSzpb3ih92FG07Gls9c9oS1JhDtvkFNIVVHKwAnQrSKauJJcmHjhq3p22RsgFaYoAVLaFdcrRTzO3BGWalZ39BQgiwskdN8Gh3P2uIhYBbliOMQkCUVkuB/aGIcQwl+nQE8m0GJ4hkQxPTZM3MoZ0EX7S+wO81XqypTliWxJ/5YTY2RrOhnn1aP6dpErTZ86ljsgpcgC6S5twWjBYrR0pwM51uJTgCT2ZNaGI6pAsayCkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5JLspYTG0fhLQsuyBbU8Sc/vdGcPYs8wl0Xl/Va6PE=;
 b=nQZUtK+bBImiSqdDL3w8oFr38uuJUeUK1DEHNklkAjLPraqP7wHVU/lQYCC8Uh7OQiwui0YkaMoDmdYCPQhSufZ7fmTWJLArkoyVwcWWQlXZROl3w7s15X8RrJE4hQ8iV8W/1/OwP/KJog4jfcj6bUvFp1OrP0hP/3Eo2ON1hhp5MxUpkQyfhRQcQ9RaCkxVPfpRLwN8GBMLKDjKOMF8+JR0kvAWQIcpp0capi6Vcb2sQUCoedZ0g2XrtToDJKeniXwZb2kkKYML1MB53M4FlPlYxSPydRG3T2+2yieVmhU2cHjRfX1/3Xn2SoS8wb0kimZvdk7WliCmdsN958EDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5JLspYTG0fhLQsuyBbU8Sc/vdGcPYs8wl0Xl/Va6PE=;
 b=cZkkJ2KoZppGLt7Nc1bSvftRIH9ujj5S5KmnnnXfMa0JHS7V/gdy8ZHlbinH0zCc4v1b3hVW7XiekxhmqM6GE1R2KchIbWQLwRWS7s55lj4i2IStEqndZuYyLQrK+rLGD3D7hyoABc8XBbvxqytNBv9YzN3pa8mRHhv4P0xJ+7d+ofB/rOXhRBp2py8otkbe/DZ6ohAfG/qe8nO+Kl3WUpUuxYfRIvegWOZBCHhjXwVWuKObbDxLVB/MiMlIGVj0R9n/iGf+OHz85rfGB6b4qp4f8ntKHKMDAmSdZir7Q13JaCWhpCSL/AIYuYVsMCR5Io+mMYGqAYb6vheExEqYIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 15:31:37 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 15:31:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 11:31:35 -0400
Message-Id: <D9J8BMXE7LDS.3HMRLBRFZJNO0@nvidia.com>
Subject: Re: [RFC PATCH 2/4] mm: pass VMA parameter to
 hugepage_global_{enabled,always}()
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>
To: "Yafang Shao" <laoar.shao@gmail.com>, <akpm@linux-foundation.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <20250429024139.34365-3-laoar.shao@gmail.com>
In-Reply-To: <20250429024139.34365-3-laoar.shao@gmail.com>
X-ClientProxiedBy: MN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:52f::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d9f83-da76-4c49-1af0-08dd8732ee3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUNlSnQwS3d0bmFJdGdOcUhRb2RLaXhBQTdpaE1uMlRjQzdzUEJQRFdDS2Zy?=
 =?utf-8?B?d1JvblZoNlgxeFhOaTk0RkRXM3ZnNFdlSm14THZDdmdwU0RWbFdCQTd3RjV5?=
 =?utf-8?B?K3VRNVpEVU1zbHZXdGJId0xzWGZUVmlpMWhRemJXaUlhaU5QU2hWRUlkNk1V?=
 =?utf-8?B?N1VwbnZsNWd3Z2I5YTVXZkk3dVhzYklVbHcxY2xpTXY2eVlKMGJYRVN4a1Zw?=
 =?utf-8?B?OTVhb2g0ZXYvS0t6SUZ0ZEpTcHZ3L1pVK0s5OWNqNFRlQ1ZoSmdzUjAxb3Er?=
 =?utf-8?B?M0Z3TjY3RTdGb1RXakEydys5WVNTTHFjSHQ0VGFVSVVWdUI4TlNGeENXWnNz?=
 =?utf-8?B?eGNteFllZmlicXJRUElTTExPWi9JNFVGczV1SzY4V1lkNGZyNFIxaGk4N2hD?=
 =?utf-8?B?Rll5dUJaeFRYSzVEQUxhaEFpU29yamxLcm9PMmNFOUszUk9Tak9SSzU0aU1R?=
 =?utf-8?B?Rjg3SisvZHFxcUlwdDlKdHBNWGtHYmsrM2ZnTXVWYjhZb05uV1RVSFpNRGdu?=
 =?utf-8?B?Wk9LWlh6aEIwRDRKbTJSa1BrZXhXbXc3R0pLbUFzbS81QVh1UGlJWkxJc25Q?=
 =?utf-8?B?cEYyS2t4bEM4cU9zcnB4U0xub2wwaExXb3c0V0VtU1BPODdsTE84SDNzdE1a?=
 =?utf-8?B?YnBWK0N5aGt2VDJtUDBnNGdwb2FhcUJvb1hocURMUTZDTkRKOGFjK0Q3TnlC?=
 =?utf-8?B?bFRMVG1tdE0rd204UFIzaTQ4WW1rYlQ1aHlXZkk5U3BvR2NUSjRRczkzV0Rj?=
 =?utf-8?B?a21ITmp5cVloVWhBczk3V2IrUnhKT0M3K3ArV3lBRWpEWXFBZFhwVFFwSWwx?=
 =?utf-8?B?TjI4QW9keWUxNXVLMUdzc0xHVkxPV0QybFBOQVpqbStSOFdZaHFEUXU1aGN1?=
 =?utf-8?B?TEE5QXVZSWlQUkFQdjlpTnRrc1dCcTVENUpuaDYzWmZlUW9OL0VvRFczeHc1?=
 =?utf-8?B?dTBIQzRLNW5CaDVzSWRHanlwZzZYZm1DRHIyTGlYUjBLVC8wUWNmOUxDblh6?=
 =?utf-8?B?cEFTU05aZTdJZEdKbUpFbDhnWnBEQ2NDUUk5aVVGT2tvNU9MQlUrb2JXdGxs?=
 =?utf-8?B?SERjUDJYWkVoRktzWG9zR0JUMnBCZlhYdE9YU0ZJcFRtRTBZeDdrMGUrK0tl?=
 =?utf-8?B?MHNBd3g3U2pQMUJoSElRTEExbS83T2o5QUYxaU9oL2l1c2F4TzFwbkpnWVEw?=
 =?utf-8?B?enordi9DU1lNQWtrOTFWUmVrOWJZdytKUmJGV2UvaXBmQ2ZDK0xYY1o0R2V6?=
 =?utf-8?B?S1NBeUFnamFIYktlcE8xU3ZrNmlBTkFINkR0T0lpL3lUQWFuTzh1MkdZTzM0?=
 =?utf-8?B?T2s0OVo2ZFE0Y1JwTjRkaUxZWTBrZWptVkVoUm42R1l6dnZmaDhEREdDTEJy?=
 =?utf-8?B?bml2T0pXbUh2ZW8zSVZBZUdMcENSSGozN0Q3cEE4aXQxdWFVcjVEMXVNeC9z?=
 =?utf-8?B?ZVRZaFBzcFpwWTJZNk9RVDd1UGNQcTlycHlSRXI3ZUFRUEhJeERDdGtHekhy?=
 =?utf-8?B?OHMzNE10L09TcDAwL1M4YXREeUhqZ05rOVUzLzNCWFZJK24vMEVlYkdPNTI0?=
 =?utf-8?B?REpWbiswQlZQUHgrNDJUSE9ZbXdEcVNxcHdFcWdmOFdvZWlKRnZVWFQ4VTFE?=
 =?utf-8?B?REZISkc5TURuK1czQjFMdGg5QjY1cjFJWWllU0JBNFVOdk9nSEtSNWNoVERx?=
 =?utf-8?B?U3dTZWUzVHMxMEJYMnZiMFBNSitFemJNZkdRTDk1bkVhNUxTWTJMUEw4UzY0?=
 =?utf-8?B?ODlST1ZCM1FTVFpjUkxkT1dTd25KMGhtSkg1YnJiQmhnTkpkaXloOFhzbDhT?=
 =?utf-8?B?MFhLZU13YXJLMEI1Q1VkRTliK3pxL3czNzVHL0lUUnpOZE9iRDFGMzNic0NB?=
 =?utf-8?B?ZkREQmpHUHBqS3J5Y3VLRE9Nb1dTTERRSGp6T0NaSW1VamxpQkRvdW5UaXlo?=
 =?utf-8?Q?lZADkThDKr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVM3d1BnL0hGTzdISThrdTdFSjZ1ZjQ4QkQ3WCt3TElpSzJXWTlnSk9pMWV6?=
 =?utf-8?B?NUdta2w3eTdreE1TNGYrMnZmZVlDamRaTmxCYzBkYk1rdDRCVUw4ektLK3Z6?=
 =?utf-8?B?NFhNS1lrYi9hQmRCWTYrc1NaVHNVRWpJbXhyM0QrMXdQci9Ib2lrL25Ja3h5?=
 =?utf-8?B?T05HRTBROGZvSTVoMkJVNWhIUVF6NUNmU3ppNHJkSjI5Nk1NTkg4TzIvWUo4?=
 =?utf-8?B?d1E2bXl3dE1OU2JDbi9wVGR3eTVDUUZnYytBTDBIWlBHdUtYTEdCdTlTOWRq?=
 =?utf-8?B?WTZlNFA4Zlpidi9IQmdWellqOGptUitzb1BOQ1krc0hoYWlGQnV0aEdjelVh?=
 =?utf-8?B?RXVWenRYQlYvdUNWSTR1Ui9aUWhOelpDQmVJYWVwSzY4U2FJNXhCdTBPMTlw?=
 =?utf-8?B?a0RhOXl4NCtZODhReUxzcGsyMGk0Wldtclh2TkY0b25BbU40eVZRbWRBV2pR?=
 =?utf-8?B?QjArK1F1UUdZWXpYVGg2TXdhc1FMYjF5bFVFTnhNemhrYm9PbUlzbUFZR3hQ?=
 =?utf-8?B?U0Q0SjYzdm9MelB4UVR6RktjMlZIVXNYaS9yYVJoUlAzMTBRTmswSTUwRnEw?=
 =?utf-8?B?NFI5MW9zcFFuZWpweTBwMW8vdWxpdlB6VnpkbjhlaGxsVm82SGJQL1NGaHhx?=
 =?utf-8?B?aXQ1SzVVeTl0N1Jwck92M0VXZktNdU9NLzluQjNUZ3hsajFnSTNFTGNtZE1k?=
 =?utf-8?B?NmZkUXZtN2phTm9kdEtRbS9SWnR0M2RZbGcyd0NxNXFJbUhjaTlCVnFNc2du?=
 =?utf-8?B?bE8vYktwK1B5UWg5RVhmeVdxeUkvdmxPR1lienVPWmY3aGJjY3FzdlFRMnlX?=
 =?utf-8?B?eWxuZ2JmSW1QVGs2NURkZ3lzU1pzbmJwSUYrTGszaTJ4RWxDRDNaT3NSSWkv?=
 =?utf-8?B?bWRhbVBuYTRlc2VwbXJwNzE0UDVnYjRORnhsVnB4MEppTFp6aENpUW0xWVR2?=
 =?utf-8?B?b2NOZEcraGJvVWtOdmpQME82bzlHY0NVY0Nua01aRjJGR05ORWVsSmhuc0N3?=
 =?utf-8?B?QXhDSFp3bjZRSDEyY2JDeGNkVW1saW9nQmY4WGFSMWxUUm4zdlo4amFoZDV4?=
 =?utf-8?B?Rk8xMjYxY0kxM2pMT1NMZVUvT0VTUmk3TmUyY1VpRGRxZXE2aHRaY2Z1dkJT?=
 =?utf-8?B?WGhSNXNJQjREbmVMamxJMC96RnRGVmRWVU1oWlZqZHprZ0ZFNVptVE15TEFN?=
 =?utf-8?B?bnBINlltR0JKaVIzUlBlaVVuSjVkUzVSNkR4SHgreEgyU3RWK2RBUFBBLysw?=
 =?utf-8?B?aGczNS9rNjhHa0JQQmtLMktLYmNocVNBaUdqWkxVL2dTUlBtdFFqc2pQRWtU?=
 =?utf-8?B?YldvZis5V3lNNUt2UzcwNGFUKzA4Qzh4VklZazdnMzdRejJZREg3U2Jwb2VS?=
 =?utf-8?B?K2ZVaTYyMEV0S2hnZGhjVEMxc25IYXFwY01Ca3N2Z3UzTkFEVXFlbFhxTXo0?=
 =?utf-8?B?Nmo1ZTVRUlhhWXFrUzhZM2dKbnJyWlhSK0dML3dPbktwaTBBNXhhMHdaNG8r?=
 =?utf-8?B?UDRWZExxaGt4SUJuWDNiL0FEY0xqU1RpczdMRSt1MjhJWUJvNHdzeEJrOGEy?=
 =?utf-8?B?bUlFMnFuQWVvYStzMGp5V0RwRlJ6bUQ2d2JuVUplTlpjZzdIVEVvQ1F0SGt0?=
 =?utf-8?B?TUsyT0hmWTUyVzFybDBKbTR1QUViUzlKLzFyeVcwd0t0T0xRdGNNSVRjM0FF?=
 =?utf-8?B?K2NRUmZEeGE2V1RIcm5CM1pLVVJtRnI1WDR3cnJHN2NsOHJEcS9OakIyUE5r?=
 =?utf-8?B?SWZDRnlVY0pZSU5EUTV5YjFvZXFXTm4vU1grRXhFMUhsb0wxaElYektlV3J0?=
 =?utf-8?B?Z2pHZkpMNHZNa2xVZ0F4Z1dOMm94bE9tMHZ4a1R6a09qM1FYcFJnckhVbzZQ?=
 =?utf-8?B?UEtZaXdoVHZVdEpYbHphL2N0ZlNOQTFmd0ZXMDJKbWhIcHd3bTRiNkZUR1cw?=
 =?utf-8?B?YmRmcmpHM0MvRmlzMTZRelJDVk05QldiblBGdUdTVTBmL1pxYm9VRElSdUk3?=
 =?utf-8?B?RUhmM3JKVnZqWEhHcTIybElFU25heUxDdHJLeElCMW03NVU0Y3dxdHhjbVdV?=
 =?utf-8?B?dCtFdmdzZzVQWlRjRis5NnZJQ1p3UXBKV3lNVUJxVjNwZllBckFmSkQxZWxR?=
 =?utf-8?Q?R9MPihBSZjqgkMj52D/zbqX0i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d9f83-da76-4c49-1af0-08dd8732ee3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:31:37.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nNMisjincWdTkEYC0511fTaRhkzvYprv5LU1BHZIy1bX5Z2th/JOzamsZFJf2Bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> We will use the new @vma parameter to determine whether THP can be used.

This is wrong and a completely hack. hugepage_global_*() are sytem-wide
functions, so they do not take VMAs. Furthermore, the VMAs passed in
are not used at all. I notice that in the later patch VMA is used by BPF
hooks, but that does not justify the addition.

If you really want to do this, you can add new functions that take VMA
as an input and check hugepage_global_*() to replace some of the if
conditions below. Something like hugepage_vma_{enable,always}.

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/huge_memory.c |  8 ++++----
>  mm/internal.h    |  8 ++++++--
>  mm/khugepaged.c  | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 39afa14af2f2..7a4a968c7874 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -176,8 +176,8 @@ static unsigned long __thp_vma_allowable_orders(struc=
t vm_area_struct *vma,
>  		 * were already handled in thp_vma_allowable_orders().
>  		 */
>  		if (enforce_sysfs &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> +		    (!hugepage_global_enabled(vma) || (!(vm_flags & VM_HUGEPAGE) &&
> +						      !hugepage_global_always(vma))))
>  			return 0;
> =20
>  		/*
> @@ -234,8 +234,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area=
_struct *vma,
> =20
>  		if (vm_flags & VM_HUGEPAGE)
>  			mask |=3D READ_ONCE(huge_anon_orders_madvise);
> -		if (hugepage_global_always() ||
> -		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
> +		if (hugepage_global_always(vma) ||
> +		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled(vma)))
>  			mask |=3D READ_ONCE(huge_anon_orders_inherit);
> =20
>  		orders &=3D mask;
> diff --git a/mm/internal.h b/mm/internal.h
> index 462d85c2ba7b..aa698a11dd68 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1626,14 +1626,18 @@ static inline bool reclaim_pt_is_enabled(unsigned=
 long start, unsigned long end,
>  #endif /* CONFIG_PT_RECLAIM */
> =20
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static inline bool hugepage_global_enabled(void)
> +/*
> + * Checks whether a given @vma can use THP. If @vma is NULL, the check i=
s
> + * performed globally by khugepaged during a system-wide scan.
> + */
> +static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
>  {
>  	return transparent_hugepage_flags &
>  			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
>  			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
>  }
> =20
> -static inline bool hugepage_global_always(void)
> +static inline bool hugepage_global_always(struct vm_area_struct *vma)
>  {
>  	return transparent_hugepage_flags &
>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cc945c6ab3bd..b85e36ddd7db 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disable=
(struct mm_struct *mm)
>  	       test_bit(MMF_DISABLE_THP, &mm->flags);
>  }
> =20
> -static bool hugepage_pmd_enabled(void)
> +static bool hugepage_pmd_enabled(struct vm_area_struct *vma)
>  {
>  	/*
>  	 * We cover the anon, shmem and the file-backed case here; file-backed
> @@ -423,14 +423,14 @@ static bool hugepage_pmd_enabled(void)
>  	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>  	 */
>  	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> -	    hugepage_global_enabled())
> +	    hugepage_global_enabled(vma))
>  		return true;
>  	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>  		return true;
>  	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>  		return true;
>  	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
> -	    hugepage_global_enabled())
> +	    hugepage_global_enabled(vma))
>  		return true;
>  	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
>  		return true;
> @@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  unsigned long vm_flags)
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> -	    hugepage_pmd_enabled()) {
> +	    hugepage_pmd_enabled(vma)) {
>  		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
>  					    PMD_ORDER))
>  			__khugepaged_enter(vma->vm_mm);
> @@ -2516,7 +2516,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages, int *result,
> =20
>  static int khugepaged_has_work(void)
>  {
> -	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
> +	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled(NU=
LL);
>  }
> =20
>  static int khugepaged_wait_event(void)
> @@ -2589,7 +2589,7 @@ static void khugepaged_wait_work(void)
>  		return;
>  	}
> =20
> -	if (hugepage_pmd_enabled())
> +	if (hugepage_pmd_enabled(NULL))
>  		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
>  }
> =20
> @@ -2620,7 +2620,7 @@ static void set_recommended_min_free_kbytes(void)
>  	int nr_zones =3D 0;
>  	unsigned long recommended_min;
> =20
> -	if (!hugepage_pmd_enabled()) {
> +	if (!hugepage_pmd_enabled(NULL)) {
>  		calculate_min_free_kbytes();
>  		goto update_wmarks;
>  	}
> @@ -2670,7 +2670,7 @@ int start_stop_khugepaged(void)
>  	int err =3D 0;
> =20
>  	mutex_lock(&khugepaged_mutex);
> -	if (hugepage_pmd_enabled()) {
> +	if (hugepage_pmd_enabled(NULL)) {
>  		if (!khugepaged_thread)
>  			khugepaged_thread =3D kthread_run(khugepaged, NULL,
>  							"khugepaged");
> @@ -2696,7 +2696,7 @@ int start_stop_khugepaged(void)
>  void khugepaged_min_free_kbytes_update(void)
>  {
>  	mutex_lock(&khugepaged_mutex);
> -	if (hugepage_pmd_enabled() && khugepaged_thread)
> +	if (hugepage_pmd_enabled(NULL) && khugepaged_thread)
>  		set_recommended_min_free_kbytes();
>  	mutex_unlock(&khugepaged_mutex);
>  }




--=20
Best Regards,
Yan, Zi


