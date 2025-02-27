Return-Path: <bpf+bounces-52771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F856A484CC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9A27A2D18
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E801B042C;
	Thu, 27 Feb 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+lIBmYN"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C51B0103;
	Thu, 27 Feb 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673475; cv=fail; b=Llpl+tRddNpN/euyMKVJLMJyd7I1afDmtlleBdVWzTlUXlWnYjx4BQwbqiwfF330VFpinCIQD3M7kMy2CSgPD68DRyDuo6aIuzAOEXMUBHBcdJD8d1jItff1gr0dsT6eelVavCGBEIv1qCVEp8GNge8s5/HD1b5G4i7/drZ+WII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673475; c=relaxed/simple;
	bh=AqOl9h+ntvY4RC+Vcc2bKWyv+njnBv0GEQECVIsaHdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ldYySvEmm/W7/qF8//Od18uJ3L8w4wJultDuJ1GmBwfIY+eswhNixrbERmlocIEx9SdkjxbcLQnGAScUFQAiPkTsTZiAi0DnWEC2wK8EjKOAx4gvPIX186GTLj3Z6Y+3i4J7vS1zbCs/JmCIXmb/S+bybQPzEgTV2F2D8uDWxN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+lIBmYN; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoI2dDXk37PfHIQH1+yzwlc8Zygcy/t2VtwloLTejgmUkQwpwtgMqjW6VK01w3CHweujbExzmRyXWSZcga/whIz96NHAkzZrZ/NDKXhb40/bPhl+fE/zMwf0Y87CAUzmMd1t88K5WFYhvWu+T/vCwCI7GjdX4xfvVxpeI1PvBdcR5YnGFXbcT8xjBeUJZnzgwNe8PIKyTpaIIDhwmKxhUbobEJ0f69j+ax0U/zafEFI3pF3Ii0Y1EzQ6tuIPV+OLp5UBJ5JONHJ6hxbcejo+0HQju6TW6iL1zV1BJMYBX/SEIDQ97mFPjsV//f8sYzcuR2RMNanZ77Dk/xx29aikwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75WqvVCnUy5rT9H2b8AS0idaLfG1EnVXv1YDHN68QR0=;
 b=Olfoy6vpZzOL2/nhT+rpyq5XP9TUompCyFivNh7iwSACSnnPRpjTgZ/I9V56lHZqAqACpWEOC84c2yTVNZTBkRZqbCC+Ihr3yuK7R5j1mW2mLOsqqmvuDN7CPNzSqeuGKQ1eqavVxWOVnoG8oW8/SzvY9c6iUEpjbG+41+f12pEpU+wxElr7yplFjm/3gEAIVOzMt26vvBE0jzYoetDTiYKfucoczoYE+MaOimdCf/ByIUSWhE+b+WQ4NIph4iXwMOKQRxSkaHJAyBabQ6QtE9Y/huLN3a/TOrrf9z3lui/vXBpzLBcvIxHHoAe+DzwfpZmIqD0wpSz1HMM+ecJIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75WqvVCnUy5rT9H2b8AS0idaLfG1EnVXv1YDHN68QR0=;
 b=B+lIBmYN/9e0nLigUjB5vXeOLoERKgBBmueZz5hEaMXwZWPibW5v43zqjJd15EIfqkB6ZEKidkaLEPq7kVPTjdVGFDl3oYZ3EWdj2yVnDNUN7NNJj6Ksw54CAd+qiHC1cWZJIhUqu6JTin+t99qcJYYrnpD/1YSFNX54W1Y/xWk5xgKcncnci8dDHHKwFcQVUmtGwqlfQAPTEgCFIumVORUPVporiPpS4+p/ZskEjj3lObloELRjg2Nre3lg0RroRRr4iu8CIILBPb2GSk5t7oUjsGHWiRpI+pSaXTSDbvniBAjQ0O9EGMBrR22qUwebhyrQ387k8+xfe1U9ko3d4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:24:25 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:24:25 +0000
Date: Thu, 27 Feb 2025 17:24:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15 v3 4/5] sched_ext: Removed mask-based
 runtime restrictions on calling kfuncs in different contexts
Message-ID: <Z8CRtWS117dVEnFa@gpd3>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080BDE038C8E8E89996F30E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR03MB5080BDE038C8E8E89996F30E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-ClientProxiedBy: LNXP123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 104dd20a-5db2-4f55-9aa8-08dd574b332b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzRKTzBBSGowZWxvdnBMN1RwcTBPSys0NUxaTWFlRVhEQ29LTmdrVHM4ZlhQ?=
 =?utf-8?B?T3Eyc0RGaGJwRDd6aG5xdnZBd0hyVjladVZGT2R0Zm1ZaGovOFdnVE1HdGVk?=
 =?utf-8?B?Z09HbGp6NjRFVHJVbGpZYUQyZEVpTEN0Z21yNzBOOFJDbDJzWlNSb2MzbEk5?=
 =?utf-8?B?Uk1aWDMwSWFxeC9mN1N1WnlBTzhNN2lRNTYrNTJlSjhpdW9icWV2M2ZXU01N?=
 =?utf-8?B?cTFyL2gwV3k0SnpqVENoS01pbENaQVBCTVdEOWxnbWgxaW1DbE1XMllqNFN1?=
 =?utf-8?B?cTk2RlZNam9maFVtTmMwdzc4YjBYVUF3Wmd4a05zWWVMdkhIM0IrMjRPU1V3?=
 =?utf-8?B?TGJDdThKSmNmY05rVjRTbStvVkMwRUo5VXhmcDlCenJRemNBb25td3k5d0Nj?=
 =?utf-8?B?cnl2SFg2MUtXT0hVYjdlZ3ZPVHpxR1pBcHdXbzM5U1M5N2dpQ21GcTJ5bDY1?=
 =?utf-8?B?d0F0QmthWnB1OXZidlRaQUQvV3NrZFVCN1d5dkUzck5EeG51VnViWkQ4a2tP?=
 =?utf-8?B?V1BFN1BlNkxObklEVzlDd2dNUWlxRmZRN2Ywa3lLb2hpMTVja0xWbXgybFVO?=
 =?utf-8?B?SDBWejFhTnd6TEZyVmo4UEIwZzRFTVJCcjNydDNocmVnTDlEa3EyU3p3UkNi?=
 =?utf-8?B?c1c1T3lxWGV4ZERDUHM4cDl2ckdCMjFyV0FieGxGWmhSN1FzQjRBN0I4eHFE?=
 =?utf-8?B?enZ2bVorTEgzNVU5eXA0R0RFSmlsYitNVHVKc2FxUUh2S016SldtV2hPS2w2?=
 =?utf-8?B?RjM5NlNQZ25QcXZGQzFPNFZpbnpWalBpTzBqR3VXNjNSRGRuR29hbkQ1bjla?=
 =?utf-8?B?M3hNNVkvS0dHeUg1cUFxWXdnTnY2NHp5WDJKdFg1eC94azVCcmo3Ti9uL0tp?=
 =?utf-8?B?N2pJMGVQcmtiSjgrbVc1akRNU1JJL29DZmREY0JFK05KYlBnRGoyUFpjeVp3?=
 =?utf-8?B?cDlqNGNvR0kvQW5HQVNwTDB2a2o1VG1JNXVqcTZsZVlvdEFITmNvaDd6OUJI?=
 =?utf-8?B?alRqaktMdXZyT2pVcktVUDhHVEw4bVdSWG55ekw0MkZZMXA5cWk1U0ZnYkFk?=
 =?utf-8?B?bit2NWp2d3JNZGFmcGQzZzllSTBpU0dvUW5Gd1R0N1VYbFM3QkNDVmtRbFAw?=
 =?utf-8?B?Umh5WUNqVzhxQWJoQkQxOVF1aW5zUUo1WER1SC9wV3RSbmd6V3dycXNmYkI0?=
 =?utf-8?B?WGJhajg4bTJURWR2TEw2UjJzK0ZkamcxUk5EY0t3UllLbUprVWJyeWdPQms4?=
 =?utf-8?B?YzRoUEQwL2ppQ21tMG9iVnNmK0dVdWxBTTM1cmg4TDhpYWJ6VGg3T2cwL05Q?=
 =?utf-8?B?c1hmWFNHT1IrTHNJNTVid1RYQ09sMVg4MEIrTTAzMlpMNUZEQiszQWhXc1Ey?=
 =?utf-8?B?TnBtSkZpK0RPMFRlWDFveEpVTk5obVFNL1JDb2l3bU5FbTh2eXRPVFV2U0VT?=
 =?utf-8?B?MGlUOGtBWGVoUUpaZy9OdDdMSjloNmRSRGdzL2RzWEcvZkVQWjZaT2VHWGhL?=
 =?utf-8?B?K2hjTjN6RmlJNDVDbCttSW11ckdwaVBIV2ppbGhnK2owQVpmNUdzZDl3dkdI?=
 =?utf-8?B?ZUJYWUxSK1NkWW5ibzBMZzc2dVVDaVEzakg4dlozM1IxVldNeXFpTnZLOHk3?=
 =?utf-8?B?NXFGeVB2N3V1NEZ0UnN3RTVnL0R2dlRnV3RBQXUvcmxOTVdJT3NRVS8wWEs3?=
 =?utf-8?B?cURSUDlXOGVmWUR0V3p5WDNXSkdKczJEaDV4YlovTFpOTjMvZnVwQlpsYld6?=
 =?utf-8?B?RzdIaGtQcVc3TnRyRVJtWUZ0em94VERNYzVzMVgyZ2U2aVBkUkQ2enFVSGt3?=
 =?utf-8?B?eXE4VlBBclAyVmFlRVZkWDM2SkFKTVhCbFR2bEk5R3RWdFQ1d25KM1NhaGRJ?=
 =?utf-8?Q?0SP1tBYtGFJk5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUl2cGtqNllHNDJVeXR0eGZtUkZxdzByRkl4T3BPQjgzMGdHZ1B3UVdhakJH?=
 =?utf-8?B?VmFZUnlEcVB2eTBrMmsydkFqM0JFNGdPSUV1b0NOMzJTUi9FRzY1VmR3bTBH?=
 =?utf-8?B?cGNLdHk4b1RCWVdQc0RDRUZ1TFozVkdzN2FiQjIrWlRUUkcwL0xrRXEvNThX?=
 =?utf-8?B?K3lZN2JLQTlRYkZJMTg1RFhVZVBVdDhoMFo5ZjNQNWhycENoRGJaVG5GTXc4?=
 =?utf-8?B?TzNPTmcxWHVBeHllQmRQSFRmbk10NzFTZi9WQS9sLzFYNm1HNVZNakhvOFYr?=
 =?utf-8?B?c0x2WVBrams2Rlp1dVovaHJlQXJ0VTNkNkFSWVNrYjFjNjJvWGY3d0hJUXY5?=
 =?utf-8?B?d1IwVVVqWnlqTzNGaU1KRFEvMXovOXJPb2NCc2w4Vy9TL2hiWkk1bkxJL09V?=
 =?utf-8?B?dWhIbk1IM0RwVVVSVlpyMmI4MjhEdnhmeW8xYU9qcGNwSjM1RFlEVkhZSTNy?=
 =?utf-8?B?dVN4ZENmTHhPVklHamtHaFBGbzIyRVprMmR6bEpQQkJ0dDdxSGdOeG5RVGIr?=
 =?utf-8?B?MjhXK2ZSSTFQVHREZlpoMERCcnB2Y0trWmphUWRzSkFsOWpsVkt0YzhYQjVE?=
 =?utf-8?B?dVNxMmMvUzV3OVBVSGhTbDlBY1JNYlV4NXM1UzhPb2NEZ0gxbWRtazgyTk1P?=
 =?utf-8?B?elZkcE0zL2tVbk56WE4rRVk5UHgyV3FLTkl6Mlh2MUh4OFdqZC9hQ0hHQlJB?=
 =?utf-8?B?cUsxeCtBQTRMKzBocWVmZmR2NFRVbHdSdkN4SndKWVVEN2Zta0JwN25mbzQv?=
 =?utf-8?B?SERjWXFXejVNZFNRekIyN3U4ZUtEWkVscStSZzU5RjRCWGpjaC85c1p6VDZP?=
 =?utf-8?B?OGIyUUI5V29NaVRWenpsS01yVFB0aFYzaWNtZzBhZFJ3L1RoSkZhdGdGNUJH?=
 =?utf-8?B?bHB5bUs5TzBTM2dMZVNUZ3lBNTlNT2J0bm05c1J4NUI1b0RjVFBBYWpoK1Uy?=
 =?utf-8?B?ZHhOUlJpbHZQMnhxRU9pVDZjMG5yR3kwWDF1Y0tTL0NxSU55aktKaVFSZXdZ?=
 =?utf-8?B?T2QwSUJUem1VN1hzV1d4dStwRFEzR2ZOcmIwK1BQNUVTc3FzU0Y3NVNoR08v?=
 =?utf-8?B?ck9KQ0VqSnRUdjdWbHRNNzJIb29vN3ZwVG4wTlhEbk1wb0duSlJNb3lvclJL?=
 =?utf-8?B?cDBHYmhXeHRJQmFsRTJsOVhqYlhKWXZHY1BBVjZ3b0hoU3lsVThITzJITStN?=
 =?utf-8?B?bW1qbHhiZkxFc3F4ci9jLytKNmJoREJOL204TEJYS2N0MXFMVGtseWJBTGdU?=
 =?utf-8?B?eHBYNUNRZGVUYWJaUVFUS2FqNG8xSmw4S2pXZERnT0E3cWV3dkE3SzUwVmox?=
 =?utf-8?B?amdpL1VRcXUzL3dxb0daWFB3Tjgvam5kSFJBMnVlYkR2K0dFSkpyQllLWjJ0?=
 =?utf-8?B?YW9UdUdZVE1IRFlaUjJiVVFNeXFTZENTcEhYaEU3REdnbXJ6VEkyOE1Gekly?=
 =?utf-8?B?MElnai9kbWVHSGljckR6RlpMMWpRSHRKbTMzMXkzNm9ua1BkVWU0MkpNb3R1?=
 =?utf-8?B?TWpDNk1HV0pYbFhjbTJ3eXhkSEVCNWZTNXdkOVB6dW9COEtDWk5SbFpjT0Fz?=
 =?utf-8?B?MEYxWnpPZHpTLzg5V0tsenk1TThkZFJTR2M2RWt4RnBJblh4R2VoM2IxZzRT?=
 =?utf-8?B?VW4rZ01PaWlPZEs4NjgxNXNIQ2IxdnQxMktzTzZxMWdDcFJYaHZYWWcxRHhx?=
 =?utf-8?B?WU1oYzdzK0JRdUVRSENSdGJwTi9FdVQrclBBVG9JL210NmpaeUVOVWFSdEg2?=
 =?utf-8?B?WW1sR3BteFQzb3pNeWErZjhoWEw3OXVBTXo0UlBXMDhkTFhmN3VoOWJ2U2sy?=
 =?utf-8?B?S3hQa0ZtU2VTemtYcFJVZ05iNURsbGR1aFJmTVprTUF5Y3dwbzRzOGxqUGww?=
 =?utf-8?B?UHh6TmtyelFId0ZDVFlTQlNRZXB4a2EwNHh3dUJiNm1BL0Ixemw5RDRQRTUz?=
 =?utf-8?B?cFZPS0xkOTd1dkl5Z2pxazNLS0NVcXE1T2FSWFYzaDF6ekMxbFp4TUc2Ykxl?=
 =?utf-8?B?Y2MvREFFRjZydUkwdi8rRHk3eXlVaHVER1Nha2QydFFDVnJUZDBXRWdxaWhT?=
 =?utf-8?B?NkJHVFdRK1hHczZ3LzVLTU85ZmxwSlhGeVh2djJFWDJnR3hJWUFMN0VJZWxr?=
 =?utf-8?Q?ttfGnYEfgVCUhBEi/u00hq76G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104dd20a-5db2-4f55-9aa8-08dd574b332b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:24:25.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oHe9jMLBNQg6z/BV9xpRllBaS3Woo5X/BdhEoXfVzFyukjISblwtDfES4L7AubSso2Hky5jfm1rm7G7f7lVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Wed, Feb 26, 2025 at 07:28:19PM +0000, Juntong Deng wrote:
> Currently, kfunc filters already support filtering based on struct_ops
> context information.
> 
> The BPF verifier can check context-sensitive kfuncs before the SCX
> program is run, avoiding runtime overhead.
> 
> Therefore we no longer need mask-based runtime restrictions.
> 
> This patch removes the mask-based runtime restrictions.

You may have missed scx_prio_less(), that is still using SCX_KF_REST:

kernel/sched/ext.c: In function ‘scx_prio_less’:
kernel/sched/ext.c:1171:27: error: ‘struct sched_ext_ops’ has no member named ‘SCX_KF_REST’
 1171 |         __typeof__(scx_ops.op(task0, task1, ##args)) __ret;                     \
      |                           ^

I think you just need to add:

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4a4713c3af67b..51c13b8c27743 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3302,7 +3302,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	 * verifier.
 	 */
 	if (SCX_HAS_OP(core_sched_before) && !scx_rq_bypassing(task_rq(a)))
-		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
+		return SCX_CALL_OP_2TASKS_RET(core_sched_before,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
 	else

-Andrea

> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  include/linux/sched/ext.h |  24 ----
>  kernel/sched/ext.c        | 227 ++++++++------------------------------
>  kernel/sched/ext_idle.c   |   5 +-
>  3 files changed, 50 insertions(+), 206 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index f7545430a548..9980d6b55c84 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -96,29 +96,6 @@ enum scx_ent_dsq_flags {
>  	SCX_TASK_DSQ_ON_PRIQ	= 1 << 0, /* task is queued on the priority queue of a dsq */
>  };
>  
> -/*
> - * Mask bits for scx_entity.kf_mask. Not all kfuncs can be called from
> - * everywhere and the following bits track which kfunc sets are currently
> - * allowed for %current. This simple per-task tracking works because SCX ops
> - * nest in a limited way. BPF will likely implement a way to allow and disallow
> - * kfuncs depending on the calling context which will replace this manual
> - * mechanism. See scx_kf_allow().
> - */
> -enum scx_kf_mask {
> -	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
> -	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
> -	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
> -	/* ops.dequeue (in REST) may be nested inside DISPATCH */
> -	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
> -	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
> -	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
> -	SCX_KF_REST		= 1 << 4, /* other rq-locked operations */
> -
> -	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
> -				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
> -	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
> -};
> -
>  enum scx_dsq_lnode_flags {
>  	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
>  
> @@ -147,7 +124,6 @@ struct sched_ext_entity {
>  	s32			sticky_cpu;
>  	s32			holding_cpu;
>  	s32			selected_cpu;
> -	u32			kf_mask;	/* see scx_kf_mask above */
>  	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
>  	atomic_long_t		ops_state;
>  
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c337f6206ae5..7dc5f11be66b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1115,19 +1115,6 @@ static long jiffies_delta_msecs(unsigned long at, unsigned long now)
>  		return -(long)jiffies_to_msecs(now - at);
>  }
>  
> -/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
> -static u32 higher_bits(u32 flags)
> -{
> -	return ~((1 << fls(flags)) - 1);
> -}
> -
> -/* return the mask with only the highest bit set */
> -static u32 highest_bit(u32 flags)
> -{
> -	int bit = fls(flags);
> -	return ((u64)1 << bit) >> 1;
> -}
> -
>  static bool u32_before(u32 a, u32 b)
>  {
>  	return (s32)(a - b) < 0;
> @@ -1143,51 +1130,12 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
>  	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
>  }
>  
> -/*
> - * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
> - * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
> - * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
> - * whether it's running from an allowed context.
> - *
> - * @mask is constant, always inline to cull the mask calculations.
> - */
> -static __always_inline void scx_kf_allow(u32 mask)
> -{
> -	/* nesting is allowed only in increasing scx_kf_mask order */
> -	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
> -		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
> -		  current->scx.kf_mask, mask);
> -	current->scx.kf_mask |= mask;
> -	barrier();
> -}
> -
> -static void scx_kf_disallow(u32 mask)
> -{
> -	barrier();
> -	current->scx.kf_mask &= ~mask;
> -}
> -
> -#define SCX_CALL_OP(mask, op, args...)						\
> -do {										\
> -	if (mask) {								\
> -		scx_kf_allow(mask);						\
> -		scx_ops.op(args);						\
> -		scx_kf_disallow(mask);						\
> -	} else {								\
> -		scx_ops.op(args);						\
> -	}									\
> -} while (0)
> +#define SCX_CALL_OP(op, args...)	scx_ops.op(args)
>  
> -#define SCX_CALL_OP_RET(mask, op, args...)					\
> +#define SCX_CALL_OP_RET(op, args...)						\
>  ({										\
>  	__typeof__(scx_ops.op(args)) __ret;					\
> -	if (mask) {								\
> -		scx_kf_allow(mask);						\
> -		__ret = scx_ops.op(args);					\
> -		scx_kf_disallow(mask);						\
> -	} else {								\
> -		__ret = scx_ops.op(args);					\
> -	}									\
> +	__ret = scx_ops.op(args);						\
>  	__ret;									\
>  })
>  
> @@ -1202,74 +1150,36 @@ do {										\
>   * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
>   * the specific task.
>   */
> -#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
> +#define SCX_CALL_OP_TASK(op, task, args...)					\
>  do {										\
> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>  	current->scx.kf_tasks[0] = task;					\
> -	SCX_CALL_OP(mask, op, task, ##args);					\
> +	SCX_CALL_OP(op, task, ##args);						\
>  	current->scx.kf_tasks[0] = NULL;					\
>  } while (0)
>  
> -#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
> +#define SCX_CALL_OP_TASK_RET(op, task, args...)					\
>  ({										\
>  	__typeof__(scx_ops.op(task, ##args)) __ret;				\
> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>  	current->scx.kf_tasks[0] = task;					\
> -	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
> +	__ret = SCX_CALL_OP_RET(op, task, ##args);				\
>  	current->scx.kf_tasks[0] = NULL;					\
>  	__ret;									\
>  })
>  
> -#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
> +#define SCX_CALL_OP_2TASKS_RET(op, task0, task1, args...)			\
>  ({										\
>  	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
> -	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
>  	current->scx.kf_tasks[0] = task0;					\
>  	current->scx.kf_tasks[1] = task1;					\
> -	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
> +	__ret = SCX_CALL_OP_RET(op, task0, task1, ##args);			\
>  	current->scx.kf_tasks[0] = NULL;					\
>  	current->scx.kf_tasks[1] = NULL;					\
>  	__ret;									\
>  })
>  
> -/* @mask is constant, always inline to cull unnecessary branches */
> -static __always_inline bool scx_kf_allowed(u32 mask)
> -{
> -	if (unlikely(!(current->scx.kf_mask & mask))) {
> -		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
> -			      mask, current->scx.kf_mask);
> -		return false;
> -	}
> -
> -	/*
> -	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
> -	 * DISPATCH must not be called if we're running DEQUEUE which is nested
> -	 * inside ops.dispatch(). We don't need to check boundaries for any
> -	 * blocking kfuncs as the verifier ensures they're only called from
> -	 * sleepable progs.
> -	 */
> -	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
> -		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
> -		scx_ops_error("cpu_release kfunc called from a nested operation");
> -		return false;
> -	}
> -
> -	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
> -		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
> -		scx_ops_error("dispatch kfunc called from a nested operation");
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  /* see SCX_CALL_OP_TASK() */
> -static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
> -							struct task_struct *p)
> +static __always_inline bool scx_kf_allowed_on_arg_tasks(struct task_struct *p)
>  {
> -	if (!scx_kf_allowed(mask))
> -		return false;
> -
>  	if (unlikely((p != current->scx.kf_tasks[0] &&
>  		      p != current->scx.kf_tasks[1]))) {
>  		scx_ops_error("called on a task not being operated on");
> @@ -1279,11 +1189,6 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
>  	return true;
>  }
>  
> -static bool scx_kf_allowed_if_unlocked(void)
> -{
> -	return !current->scx.kf_mask;
> -}
> -
>  /**
>   * nldsq_next_task - Iterate to the next task in a non-local DSQ
>   * @dsq: user dsq being iterated
> @@ -2219,7 +2124,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	WARN_ON_ONCE(*ddsp_taskp);
>  	*ddsp_taskp = p;
>  
> -	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
> +	SCX_CALL_OP_TASK(enqueue, p, enq_flags);
>  
>  	*ddsp_taskp = NULL;
>  	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
> @@ -2316,7 +2221,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	add_nr_running(rq, 1);
>  
>  	if (SCX_HAS_OP(runnable) && !task_on_rq_migrating(p))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
> +		SCX_CALL_OP_TASK(runnable, p, enq_flags);
>  
>  	if (enq_flags & SCX_ENQ_WAKEUP)
>  		touch_core_sched(rq, p);
> @@ -2351,7 +2256,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
>  		BUG();
>  	case SCX_OPSS_QUEUED:
>  		if (SCX_HAS_OP(dequeue))
> -			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
> +			SCX_CALL_OP_TASK(dequeue, p, deq_flags);
>  
>  		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
>  					    SCX_OPSS_NONE))
> @@ -2400,11 +2305,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  	 */
>  	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
>  		update_curr_scx(rq);
> -		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
> +		SCX_CALL_OP_TASK(stopping, p, false);
>  	}
>  
>  	if (SCX_HAS_OP(quiescent) && !task_on_rq_migrating(p))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
> +		SCX_CALL_OP_TASK(quiescent, p, deq_flags);
>  
>  	if (deq_flags & SCX_DEQ_SLEEP)
>  		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
> @@ -2424,7 +2329,7 @@ static void yield_task_scx(struct rq *rq)
>  	struct task_struct *p = rq->curr;
>  
>  	if (SCX_HAS_OP(yield))
> -		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
> +		SCX_CALL_OP_2TASKS_RET(yield, p, NULL);
>  	else
>  		p->scx.slice = 0;
>  }
> @@ -2434,7 +2339,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
>  	struct task_struct *from = rq->curr;
>  
>  	if (SCX_HAS_OP(yield))
> -		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
> +		return SCX_CALL_OP_2TASKS_RET(yield, from, to);
>  	else
>  		return false;
>  }
> @@ -2992,7 +2897,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  		 * emitted in switch_class().
>  		 */
>  		if (SCX_HAS_OP(cpu_acquire))
> -			SCX_CALL_OP(SCX_KF_REST, cpu_acquire, cpu_of(rq), NULL);
> +			SCX_CALL_OP(cpu_acquire, cpu_of(rq), NULL);
>  		rq->scx.cpu_released = false;
>  	}
>  
> @@ -3037,8 +2942,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  	do {
>  		dspc->nr_tasks = 0;
>  
> -		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
> -			    prev_on_scx ? prev : NULL);
> +		SCX_CALL_OP(dispatch, cpu_of(rq), prev_on_scx ? prev : NULL);
>  
>  		flush_dispatch_buf(rq);
>  
> @@ -3159,7 +3063,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
>  
>  	/* see dequeue_task_scx() on why we skip when !QUEUED */
>  	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
> +		SCX_CALL_OP_TASK(running, p);
>  
>  	clr_task_runnable(p, true);
>  
> @@ -3240,8 +3144,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  				.task = next,
>  			};
>  
> -			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
> -				    cpu_release, cpu_of(rq), &args);
> +			SCX_CALL_OP(cpu_release, cpu_of(rq), &args);
>  		}
>  		rq->scx.cpu_released = true;
>  	}
> @@ -3254,7 +3157,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  
>  	/* see dequeue_task_scx() on why we skip when !QUEUED */
>  	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
> +		SCX_CALL_OP_TASK(stopping, p, true);
>  
>  	if (p->scx.flags & SCX_TASK_QUEUED) {
>  		set_task_runnable(rq, p);
> @@ -3428,8 +3331,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
>  		WARN_ON_ONCE(*ddsp_taskp);
>  		*ddsp_taskp = p;
>  
> -		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU,
> -					   select_cpu, p, prev_cpu, wake_flags);
> +		cpu = SCX_CALL_OP_TASK_RET(select_cpu, p, prev_cpu, wake_flags);
>  		p->scx.selected_cpu = cpu;
>  		*ddsp_taskp = NULL;
>  		if (ops_cpu_valid(cpu, "from ops.select_cpu()"))
> @@ -3473,8 +3375,7 @@ static void set_cpus_allowed_scx(struct task_struct *p,
>  	 * designation pointless. Cast it away when calling the operation.
>  	 */
>  	if (SCX_HAS_OP(set_cpumask))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
> -				 (struct cpumask *)p->cpus_ptr);
> +		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
>  }
>  
>  static void handle_hotplug(struct rq *rq, bool online)
> @@ -3487,9 +3388,9 @@ static void handle_hotplug(struct rq *rq, bool online)
>  		scx_idle_update_selcpu_topology(&scx_ops);
>  
>  	if (online && SCX_HAS_OP(cpu_online))
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> +		SCX_CALL_OP(cpu_online, cpu);
>  	else if (!online && SCX_HAS_OP(cpu_offline))
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_offline, cpu);
> +		SCX_CALL_OP(cpu_offline, cpu);
>  	else
>  		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
>  			     "cpu %d going %s, exiting scheduler", cpu,
> @@ -3593,7 +3494,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
>  		curr->scx.slice = 0;
>  		touch_core_sched(rq, curr);
>  	} else if (SCX_HAS_OP(tick)) {
> -		SCX_CALL_OP(SCX_KF_REST, tick, curr);
> +		SCX_CALL_OP(tick, curr);
>  	}
>  
>  	if (!curr->scx.slice)
> @@ -3670,7 +3571,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
>  			.fork = fork,
>  		};
>  
> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init_task, p, &args);
> +		ret = SCX_CALL_OP_RET(init_task, p, &args);
>  		if (unlikely(ret)) {
>  			ret = ops_sanitize_err("init_task", ret);
>  			return ret;
> @@ -3727,11 +3628,11 @@ static void scx_ops_enable_task(struct task_struct *p)
>  	p->scx.weight = sched_weight_to_cgroup(weight);
>  
>  	if (SCX_HAS_OP(enable))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
> +		SCX_CALL_OP_TASK(enable, p);
>  	scx_set_task_state(p, SCX_TASK_ENABLED);
>  
>  	if (SCX_HAS_OP(set_weight))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
> +		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
>  }
>  
>  static void scx_ops_disable_task(struct task_struct *p)
> @@ -3740,7 +3641,7 @@ static void scx_ops_disable_task(struct task_struct *p)
>  	WARN_ON_ONCE(scx_get_task_state(p) != SCX_TASK_ENABLED);
>  
>  	if (SCX_HAS_OP(disable))
> -		SCX_CALL_OP(SCX_KF_REST, disable, p);
> +		SCX_CALL_OP(disable, p);
>  	scx_set_task_state(p, SCX_TASK_READY);
>  }
>  
> @@ -3769,7 +3670,7 @@ static void scx_ops_exit_task(struct task_struct *p)
>  	}
>  
>  	if (SCX_HAS_OP(exit_task))
> -		SCX_CALL_OP(SCX_KF_REST, exit_task, p, &args);
> +		SCX_CALL_OP(exit_task, p, &args);
>  	scx_set_task_state(p, SCX_TASK_NONE);
>  }
>  
> @@ -3878,7 +3779,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
>  
>  	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
>  	if (SCX_HAS_OP(set_weight))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
> +		SCX_CALL_OP_TASK(set_weight, p, p->scx.weight);
>  }
>  
>  static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
> @@ -3894,8 +3795,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  	 * different scheduler class. Keep the BPF scheduler up-to-date.
>  	 */
>  	if (SCX_HAS_OP(set_cpumask))
> -		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
> -				 (struct cpumask *)p->cpus_ptr);
> +		SCX_CALL_OP_TASK(set_cpumask, p, (struct cpumask *)p->cpus_ptr);
>  }
>  
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
> @@ -3987,8 +3887,7 @@ int scx_tg_online(struct task_group *tg)
>  			struct scx_cgroup_init_args args =
>  				{ .weight = tg->scx_weight };
>  
> -			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
> -					      tg->css.cgroup, &args);
> +			ret = SCX_CALL_OP_RET(cgroup_init, tg->css.cgroup, &args);
>  			if (ret)
>  				ret = ops_sanitize_err("cgroup_init", ret);
>  		}
> @@ -4009,7 +3908,7 @@ void scx_tg_offline(struct task_group *tg)
>  	percpu_down_read(&scx_cgroup_rwsem);
>  
>  	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
> +		SCX_CALL_OP(cgroup_exit, tg->css.cgroup);
>  	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
>  
>  	percpu_up_read(&scx_cgroup_rwsem);
> @@ -4042,8 +3941,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
>  			continue;
>  
>  		if (SCX_HAS_OP(cgroup_prep_move)) {
> -			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
> -					      p, from, css->cgroup);
> +			ret = SCX_CALL_OP_RET(cgroup_prep_move, p, from, css->cgroup);
>  			if (ret)
>  				goto err;
>  		}
> @@ -4056,8 +3954,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
>  err:
>  	cgroup_taskset_for_each(p, css, tset) {
>  		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
> -				    p->scx.cgrp_moving_from, css->cgroup);
> +			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
>  		p->scx.cgrp_moving_from = NULL;
>  	}
>  
> @@ -4075,8 +3972,7 @@ void scx_cgroup_move_task(struct task_struct *p)
>  	 * cgrp_moving_from set.
>  	 */
>  	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
> -		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
> -			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
> +		SCX_CALL_OP_TASK(cgroup_move, p, p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
>  	p->scx.cgrp_moving_from = NULL;
>  }
>  
> @@ -4095,8 +3991,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
>  
>  	cgroup_taskset_for_each(p, css, tset) {
>  		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
> -				    p->scx.cgrp_moving_from, css->cgroup);
> +			SCX_CALL_OP(cgroup_cancel_move, p, p->scx.cgrp_moving_from, css->cgroup);
>  		p->scx.cgrp_moving_from = NULL;
>  	}
>  out_unlock:
> @@ -4109,8 +4004,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
>  
>  	if (scx_cgroup_enabled && tg->scx_weight != weight) {
>  		if (SCX_HAS_OP(cgroup_set_weight))
> -			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
> -				    tg_cgrp(tg), weight);
> +			SCX_CALL_OP(cgroup_set_weight, tg_cgrp(tg), weight);
>  		tg->scx_weight = weight;
>  	}
>  
> @@ -4300,7 +4194,7 @@ static void scx_cgroup_exit(void)
>  			continue;
>  		rcu_read_unlock();
>  
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
> +		SCX_CALL_OP(cgroup_exit, css->cgroup);
>  
>  		rcu_read_lock();
>  		css_put(css);
> @@ -4343,8 +4237,7 @@ static int scx_cgroup_init(void)
>  			continue;
>  		rcu_read_unlock();
>  
> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
> -				      css->cgroup, &args);
> +		ret = SCX_CALL_OP_RET(cgroup_init, css->cgroup, &args);
>  		if (ret) {
>  			css_put(css);
>  			scx_ops_error("ops.cgroup_init() failed (%d)", ret);
> @@ -4840,7 +4733,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
>  	}
>  
>  	if (scx_ops.exit)
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, exit, ei);
> +		SCX_CALL_OP(exit, ei);
>  
>  	cancel_delayed_work_sync(&scx_watchdog_work);
>  
> @@ -5047,7 +4940,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
>  
>  	if (SCX_HAS_OP(dump_task)) {
>  		ops_dump_init(s, "    ");
> -		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
> +		SCX_CALL_OP(dump_task, dctx, p);
>  		ops_dump_exit();
>  	}
>  
> @@ -5094,7 +4987,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  
>  	if (SCX_HAS_OP(dump)) {
>  		ops_dump_init(&s, "");
> -		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
> +		SCX_CALL_OP(dump, &dctx);
>  		ops_dump_exit();
>  	}
>  
> @@ -5151,7 +5044,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  		used = seq_buf_used(&ns);
>  		if (SCX_HAS_OP(dump_cpu)) {
>  			ops_dump_init(&ns, "  ");
> -			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
> +			SCX_CALL_OP(dump_cpu, &dctx, cpu, idle);
>  			ops_dump_exit();
>  		}
>  
> @@ -5405,7 +5298,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	cpus_read_lock();
>  
>  	if (scx_ops.init) {
> -		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
> +		ret = SCX_CALL_OP_RET(init);
>  		if (ret) {
>  			ret = ops_sanitize_err("init", ret);
>  			cpus_read_unlock();
> @@ -6146,9 +6039,6 @@ void __init init_sched_ext_class(void)
>   */
>  static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
>  {
> -	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
> -		return false;
> -
>  	lockdep_assert_irqs_disabled();
>  
>  	if (unlikely(!p)) {
> @@ -6310,9 +6200,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
>  	bool in_balance;
>  	unsigned long flags;
>  
> -	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
> -		return false;
> -
>  	/*
>  	 * Can be called from either ops.dispatch() locking this_rq() or any
>  	 * context where no rq lock is held. If latter, lock @p's task_rq which
> @@ -6395,9 +6282,6 @@ __bpf_kfunc_start_defs();
>   */
>  __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
>  {
> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
> -		return 0;
> -
>  	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
>  }
>  
> @@ -6411,9 +6295,6 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
>  {
>  	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
>  
> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
> -		return;
> -
>  	if (dspc->cursor > 0)
>  		dspc->cursor--;
>  	else
> @@ -6439,9 +6320,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
>  	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
>  	struct scx_dispatch_q *dsq;
>  
> -	if (!scx_kf_allowed(SCX_KF_DISPATCH))
> -		return false;
> -
>  	flush_dispatch_buf(dspc->rq);
>  
>  	dsq = find_user_dsq(dsq_id);
> @@ -6632,9 +6510,6 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
>  	struct rq *rq;
>  	struct task_struct *p, *n;
>  
> -	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
> -		return 0;
> -
>  	rq = cpu_rq(smp_processor_id());
>  	lockdep_assert_rq_held(rq);
>  
> @@ -7239,7 +7114,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
>  	struct task_group *tg = p->sched_task_group;
>  	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
>  
> -	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
> +	if (!scx_kf_allowed_on_arg_tasks(p))
>  		goto out;
>  
>  	cgrp = tg_cgrp(tg);
> @@ -7479,10 +7354,6 @@ static int __init scx_init(void)
>  	 *
>  	 * Some kfuncs are context-sensitive and can only be called from
>  	 * specific SCX ops. They are grouped into BTF sets accordingly.
> -	 * Unfortunately, BPF currently doesn't have a way of enforcing such
> -	 * restrictions. Eventually, the verifier should be able to enforce
> -	 * them. For now, register them the same and make each kfunc explicitly
> -	 * check using scx_kf_allowed().
>  	 */
>  	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_ops_context_sensitive)) ||
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index efb6077810d8..e241935021eb 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -658,7 +658,7 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
>  	 * managed by put_prev_task_idle()/set_next_task_idle().
>  	 */
>  	if (SCX_HAS_OP(update_idle) && do_notify && !scx_rq_bypassing(rq))
> -		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
> +		SCX_CALL_OP(update_idle, cpu_of(rq), idle);
>  
>  	/*
>  	 * Update the idle masks:
> @@ -803,9 +803,6 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  	if (!check_builtin_idle_enabled())
>  		goto prev_cpu;
>  
> -	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
> -		goto prev_cpu;
> -
>  #ifdef CONFIG_SMP
>  	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
>  #endif
> -- 
> 2.39.5
> 

