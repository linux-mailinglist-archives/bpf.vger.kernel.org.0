Return-Path: <bpf+bounces-55707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197ACA85215
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018A3464D0E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8A1E990B;
	Fri, 11 Apr 2025 03:37:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5C1E7C1C;
	Fri, 11 Apr 2025 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342641; cv=fail; b=HuaFJO1kz1s8ZiLo1Njl3UBOB96rPdF8PUVOD/oCGGbL8YGc9R4hKk/n4NI6HNEUA3ttiNZp69XR4a0/wFpdOqa2EwCtfMrdHZDdHwUhuxCjlGfNXzlWYAuaJRUWoxD3CGgJIxOOUWy05ARhJ5Hiu1baJ/qsCoDaM6l9+fZjjcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342641; c=relaxed/simple;
	bh=5Pt9Se35tJ+iopRRYT4iGr3ahtlmlgJtlqRaa2RUMaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bbM5H9abXvJCCw0G801I4yWs5nVGMxyV56vUZO67ZG6CLpBoAvnUXQNA3Td68YN0F0bWLwyZvHIM84bNH/BN1IE364LBW8v00cWF7mEVzXaBLV6NpBIXMXnutV9UZ/UqLEa3TJqtf2B7B0GeI8GoNV/tZcDwLtcohLPUMxjL67E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3RE9N013466;
	Thu, 10 Apr 2025 20:37:14 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4fjfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 20:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9b3fUD90nYT7AHQ0d1yn37ftkRayigcRZ7Oum9AZrMa/522cKa3OxLeg+EbWC1YWAXaluoHqsp3Z96hjurV8eJjbmpOTZutVqhUq9XYTj8I6HrJNqV1dY0Zcr4kPl1j4Vhg4BMDnjG1CZCmc5nKUQS+vxCXGs3JfYT7iHoMlUjFpFOchy58hjpTRapKbSizZbJQyFJIZvW/OW41nG3AwQRQpAmQoqbPDwGYKG3rSRieLdxXQJtAEinR9DZtJN6/NhqC2TaI6A4firXxiHYwRbtoCz/gnTweU8K/933yv5xJlzPrYsr2A8fUIXPzNUnSh157SbjNR8O7WeEO8EfQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH/rQr8ymrF43lU9IK/Jis0qVtsnILZdlN7BDzLMCsQ=;
 b=T753DZuqzGZsDXPOQDecifMFvlxMeRWWLsmy8WaeZftdOJPqWLKRb4mDmysGYNQMFqU/EVL+q4oFAsHeu9jyFAp+UPojGa1D7iDHTwAmbpCzTk8yTvgUexFRJTHxpSU+RoqdC0t2NgBpCd4dQNnOEliMa5l+0rdSBl5t/52bPhQhzW2ewocN6MgBepCPHOaXOrQJEQK8igx8vbqlr0eidR1Y7FU2Vb1/ZyddDbh4p3utnTmRWRVi50Kdlpl98vN07bvytmEY7syk6MM50S6sAXhAFE9dHCvgYEQgrja0SUNYRvsiUQAHPSgvjm1mB9/TsOOIMXpgQUmavD7TVm7TMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 03:37:09 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 03:37:09 +0000
From: He Zhe <zhe.he@windriver.com>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, ezulian@redhat.com, andrii@kernel.org,
        jolsa@kernel.org, acme@redhat.com, zhe.he@windriver.com
Subject: [PATCH 6.12.y] libbpf: Prevent compiler warnings/errors
Date: Fri, 11 Apr 2025 11:36:44 +0800
Message-Id: <20250411033644.1156976-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0054.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::19) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|DS0PR11MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b4d4ed-db25-4a40-d37a-08dd78aa2397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eC9KV0FFbXhRQUE2dGZwZDV5S0RYR0FmaHJWSjNQV2I1a0wyZGQzTkZqakgz?=
 =?utf-8?B?MkhLUmNZWFJiMkkwUDlCSzB4ZlRqVFlnL3pWTDJ0TGE3YmlsbTdYbm14a2RG?=
 =?utf-8?B?R2h6M2l2bU9zOTVqUU93SFNVVUlYRHh4U0pvZThRQk4vTStTWVdoUER0Q09x?=
 =?utf-8?B?bnJYWjZsc2paSTFCRmkzYS9WNGM1YXJwNVVPSFExUTgvdFBCMm5KN0xXckI1?=
 =?utf-8?B?MW1LSTN0dzRuMVZ5U0tvYTJNZkNwSElOS05GUVhrelAzVTMzSXh6OEJ4OTQ2?=
 =?utf-8?B?ZWQraFlYeXRiaXhIOEowdy9tbDhEYnYrY3VSZlI5Vzk5TmVheGk2TWpZUWlj?=
 =?utf-8?B?eHZhU2F4TEFXRndUckpvVHBXTHFsekx0NnRrY3AvL2R4WFI1azZEL0NINjY5?=
 =?utf-8?B?c1RWQkIwcjRDYWZTanhHejdxQW9Vb2s1aE9LMjZrUDBuaFpDZ2NNK3Z6dnp4?=
 =?utf-8?B?UkdPdFNwTGNPTXZYSXJrejJSZllOaVc1TlhKRE94U2RqKzFRK2h6bmp3Y2h0?=
 =?utf-8?B?RGxrYklFTk9Lak5NU0Y0bzVWMEYyNjNQN0ZkMkNLeEJOZWZacnRJMkN4TENB?=
 =?utf-8?B?enZLanI3L0czdnlvUVU1bUFRMkJ3aVN4WW9Va0Z1aEN1NVRhREUrTjdLY1du?=
 =?utf-8?B?cnlleUdRcW05QTVNT0dHeWYwS2pycm96OVNPRnhGVWQ2ZmtaTEorKzlNRXZQ?=
 =?utf-8?B?WWlUb2d2MkFPeFpiUGUxR2NCcVUxejNzYzFackxwMTFzVURJVjVYRytuMzhC?=
 =?utf-8?B?dFk4eTR0OVZCZ3ZlSmZ3aGowb3B3dWY4K3hsTmxHYVNjWnBHT0NTMHlRZ240?=
 =?utf-8?B?WDI3S1oxQTI3T2ZYRlZOT1QwblRjT3EvNFNIczJuWGVNSmhUNWtsYXN1d2Ey?=
 =?utf-8?B?UDg5czV3QlBrTno0TloraTJVNHhYQ3dkeFlnbmRWSFIwMEF1S2dHWG9FUkMr?=
 =?utf-8?B?WnhudmZSWC9ISEhjakpRZnRsZ2dqM0pNNkdLUmhhdkNHVVRWOFZ1QW9zeUdJ?=
 =?utf-8?B?SDhrSWFiZW04TDlGTStVQktra0phMENGQll0Zlo5c2tFMDVwallGRGUrVnVP?=
 =?utf-8?B?d1JFVVRPNTZSY1lYM21MNXI2QW1QNHZJVEc3eDR1dHF3M09Cb2ZEVmFZV29N?=
 =?utf-8?B?ZGo5Vm5tblNKZmFpUStKSzFVZmxpZmZMTldqS252UTl3eXRlNkhKdWJNd2dj?=
 =?utf-8?B?b1BEN2xDaW5xTFhDSDRoVXExMGJJRHQyNncyQUNMOXdjVkJsUklpUW9ueUFF?=
 =?utf-8?B?ZWNtVGY4SVNqeE5XZ2VrTnVLU3BWYWh5NWQ0MkFvcmlIaXdhdVJsSGZEcnZE?=
 =?utf-8?B?T1M4Vk9hbjdaV1BZQmJLMmtaaFZXYzNyZDUxenhhS1o2d0FOZzROVzJrM2V3?=
 =?utf-8?B?OHNkOGc1TnEyQ3lzWjZiaW9oZ1JpUzd4cnZLRWt4K2cyVkM3eHFkenhFL2p6?=
 =?utf-8?B?QnFNRlVEMHpncmdQYTF0OFl4aTR3ZFVPTkZYVlZodjNuYWhQcWVtQmQybXZB?=
 =?utf-8?B?U3ZmVFpuWjFYNGpIdTBQWE9ZTmM0RGxDemNFWnZpNGdDOUxpemFnclpCS1Ft?=
 =?utf-8?B?VkZLcmxYd2hTSGZLU0d6cTkyaXFjUDh3QUppbHlUeXFMTTZDbVJrZkdyQzZo?=
 =?utf-8?B?Mm1PY1VZdXNBMW9Kb0lCbzVsVTkxa3Z5SFQzb3pQOHp3ZXlqZll3d2dFMGtT?=
 =?utf-8?B?MDVsU2I4TEtNNElqeTlaZEExdTNkb1VNc3pDUmVnZHMxTHQ3eWJCelBDaXpC?=
 =?utf-8?B?MFpNS0RyU1pzNzhPRjExMXhxNnN1SUVLdVhOakt1eXUxRTRMbEkxalNubE04?=
 =?utf-8?B?VEFZeFZIandPd210OGV0eTZrTEtmRXdGUnRiNURBMGpKWWJZSVV2OERVYlZB?=
 =?utf-8?B?OWtHNG5URWlSdkFZWVFKUlY4bS9maUlaYkd2MmoxaHJaZTIwYlZQWGh2Qmd2?=
 =?utf-8?B?Z0lJQWhiQzRRSC9BMEhzeHFZTlo5d0NlSVhkNTIvamFoTU1WTXdsN0dMVWd0?=
 =?utf-8?Q?8gXCrOcOEIDVpW7cBcxMbyUhoRG/Js=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFB0cW1kNng0N0VLTElYUlJadUtGZDdZdDBBWWk3WDJZODJYUnd4V3FWdTE1?=
 =?utf-8?B?QlJ6OU5EQUppamRqemdTd3NhZGxlVThySmtiNG4vNGM4TE9USTZiWWJ1UjZM?=
 =?utf-8?B?bUw0YjN4cVUwaTEvRGNpVjkxNEJyMWhTaGtaUUtJQW5YOVd3cWJjL1Nkb2Vz?=
 =?utf-8?B?NHI4MW1DRkcvZHVmdm0wcGRsMUo5ME9kT01NbGFaTENhY3FWaGp2cWtURHRZ?=
 =?utf-8?B?TlpVZEhiV29TcmRSQmdSZnVudnJ2WTVLTFNsOWhmQ1BPcGpaUjhib3ozOEVL?=
 =?utf-8?B?emRkOXhCSEU5bkM2V3I4Z0J4RFJaOGgwTnIwV0J5eWpMdzVTNGFBYzZvQ1A2?=
 =?utf-8?B?UVJuQ2NYSGI0OGh4K1NpY25NWVhHME13MkJJVjU0dStpY0VxQjUvd2FWSGpV?=
 =?utf-8?B?dFZmSkkyeU9CMk5OS0FRaUZYYStKWlFpdnR6K2djZVJrUjhCTTQwREh0TmVP?=
 =?utf-8?B?TFZ2aEJyZmNvMHo5REJ6dzRQc1Vna1dlTVp3VXFEOTNaYWp0c2s4L3BXWmJV?=
 =?utf-8?B?aFdOcGRrc0dYSHpBNDR3eFlRS2ExNEZOMld5RWE1ZzVMRlFmV0Q3UUdOV2d6?=
 =?utf-8?B?VmRZMUJRckFWeXk0ckNwYXBnNkdrOHVoaTNOM2FXYnQwT1FVdW9nRVlVcUMx?=
 =?utf-8?B?aWIwRjRrNTRsS1gyZDExcSs1VzE1L3VqMjNzSFg1RTNYWGV3TWkwbktESnFw?=
 =?utf-8?B?Vy96R1ZCd29BSkZSQUh4RVp0d214NVpxUjJab2R5ZjloTDU0SkhtdTVNZi9o?=
 =?utf-8?B?MnYyeG91WkR6T3paWG5kTlZqMWt4WFE5cGhLTms1RzRnNXZSYWY4OE5tSmUw?=
 =?utf-8?B?a0FTSG96Mk91b2JJQno2elRPZjlveTY5TzhpeUlybjQzOVFiallnbXZKZ3Iy?=
 =?utf-8?B?MUVkeS9xcFkyWnlsR0hoR2ltSGEvQS9GV2x0SnZoSUx4ZDhmNURkWEcvVTJP?=
 =?utf-8?B?M1NBN28rTS9PSWR2amNQT1hFN0FWWUR0a291MzJCVVNFbGtPS2JiK0RxZHZ3?=
 =?utf-8?B?VlRkQ1cvMm5ZcjFjMzhlZ2dpSE5RbWV5OTJzbnArODhKZ1BQV3hEYUc1OUhP?=
 =?utf-8?B?TE1IRlNDY3RyOTdpcVBlS3lJWHJ0d3dlOVFBN3Y1N2NKZi9WbTd0dGhueTRX?=
 =?utf-8?B?TW9PeXh5TjBzeWdOM2N2ZXl6WG00K0lBb0xvNlhuNmVlRFk1VXlFOUZabnJS?=
 =?utf-8?B?eW9xV2pxTGtqY1kxRE56cUpvNWs3L3FySGVkekREdGJMMk81bDVSWEJDaFY1?=
 =?utf-8?B?MlQ3NnVoejlTMVRJSU54ZFh6TC8vSUpDV2Rvc1NmMUxNNkZNcnJ5b1F1eFlW?=
 =?utf-8?B?WE9LTGNxY1lKMVdNaGFiY3Y5SXRKeXBYeW83SWl4L0RnL0NBSDJBK1h3S2dE?=
 =?utf-8?B?Vk1NRGltYm0zQVpaVEwyV2Rpc2FxSGlRUTFzYUZCTXgvTWllT3F4OThsQnZa?=
 =?utf-8?B?SFBqSGFjbUgwYmY3TlQ2WkRUMnd1NTlMU1FvYjhDVGhSdjVjVjNCdVlxZkIw?=
 =?utf-8?B?ZGpZNlVMTDhoaG5LRHJMbjRMaHBVV25ycW00dmZNZUo1ekNINlVRWEFkODg4?=
 =?utf-8?B?cVMyU2dpa0RHSEgvTG4vcndxd2xMT01PSEIrVEVOUi9jL2xJbzVkNDZKOHN3?=
 =?utf-8?B?L1M2bk9qUjhpMERDK1laM1VvYm1rTG94c1gwbHdpQ2gwbnVHK3h1NVZaVG9B?=
 =?utf-8?B?UC9nbU82ekhMcUhsU0ZYcjZGNGwyVnVFa3V5K0Z0bVpRWjhhVzdXL0NIbUVo?=
 =?utf-8?B?dWVuNlJMejJFUWpmdFUrSm4yQ0VLcWY2akthWHpQTUJ2eWtKV3BsWnUyVWlw?=
 =?utf-8?B?enIxN2t2SjRSTUltOHd5YWpFc3FwOHhxY2o0dWozd01BdDZaRXc0UG94Zjc1?=
 =?utf-8?B?OVFBYVVJTnhrdUFSTy9WWFdYVG1QN2ZyNDZQWjV5L0g5QjhPeCs2MnJwVkZ2?=
 =?utf-8?B?c0tiS1pBUEl0ZS9icXZKV1laamFlQW10MDkxRGZ4NVBKdmFyOTB4MWlqTll2?=
 =?utf-8?B?TkRRZ0tReHpMUkN1UlNnTEUxeGlVdXpaR2FvZG9FbHVDZFUrZmUvWDh0ek5S?=
 =?utf-8?B?cm14TTJZb1lBNEpHa3M5Nmhwc09lZVVSQW10dlMyUEt0bE5MMkJjZFliMThJ?=
 =?utf-8?Q?6NpIkhaVMxaM2SkgkJQAsAoSx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b4d4ed-db25-4a40-d37a-08dd78aa2397
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 03:37:09.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXLc0O0uRhg1th2P/tPYdyDuaKhdXBx3YZxCWY2yNJlM5KS24cnm3varp+3MkZUFgERxrHqvuoU9iSHfdSFUlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-Proofpoint-ORIG-GUID: eNyU-2F9VA7c3IJetdTXS6mf60HYNLoS
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f88e69 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=PTYPUFVCpRl-t0CLiK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: eNyU-2F9VA7c3IJetdTXS6mf60HYNLoS
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110025

From: Eder Zulian <ezulian@redhat.com>

commit 7f4ec77f3fee41dd6a41f03a40703889e6e8f7b2 upstream.

Initialize 'new_off' and 'pad_bits' to 0 and 'pad_type' to  NULL in
btf_dump_emit_bit_padding to prevent compiler warnings/errors which are
observed when compiling with 'EXTRA_CFLAGS=-g -Og' options, but do not
happen when compiling with current default options.

For example, when compiling libbpf with

  $ make "EXTRA_CFLAGS=-g -Og" -C tools/lib/bpf/ clean all

Clang version 17.0.6 and GCC 13.3.1 fail to compile btf_dump.c due to
following errors:

  btf_dump.c: In function ‘btf_dump_emit_bit_padding’:
  btf_dump.c:903:42: error: ‘new_off’ may be used uninitialized [-Werror=maybe-uninitialized]
    903 |         if (new_off > cur_off && new_off <= next_off) {
        |                                  ~~~~~~~~^~~~~~~~~~~
  btf_dump.c:870:13: note: ‘new_off’ was declared here
    870 |         int new_off, pad_bits, bits, i;
        |             ^~~~~~~
  btf_dump.c:917:25: error: ‘pad_type’ may be used uninitialized [-Werror=maybe-uninitialized]
    917 |                         btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    918 |                                         in_bitfield ? new_off - cur_off : 0);
        |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  btf_dump.c:871:21: note: ‘pad_type’ was declared here
    871 |         const char *pad_type;
        |                     ^~~~~~~~
  btf_dump.c:930:20: error: ‘pad_bits’ may be used uninitialized [-Werror=maybe-uninitialized]
    930 |                 if (bits == pad_bits) {
        |                    ^
  btf_dump.c:870:22: note: ‘pad_bits’ was declared here
    870 |         int new_off, pad_bits, bits, i;
        |                      ^~~~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20241022172329.3871958-3-ezulian@redhat.com
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
Build test passed.
---
 tools/lib/bpf/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 0a7327541c17..46cce18c8308 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	} pads[] = {
 		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
 	};
-	int new_off, pad_bits, bits, i;
-	const char *pad_type;
+	int new_off = 0, pad_bits = 0, bits, i;
+	const char *pad_type = NULL;
 
 	if (cur_off >= next_off)
 		return; /* no gap */
-- 
2.34.1


