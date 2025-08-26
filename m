Return-Path: <bpf+bounces-66590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42182B37348
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D81BC0AA1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798B30CD94;
	Tue, 26 Aug 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nImsKM9y"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357F5661;
	Tue, 26 Aug 2025 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237101; cv=fail; b=R7opDTXrliUMDE3qnWSOfAjuHmvMe4q0U+rRNrm7l02ckoDb55cshEVlRx+Jduhi6xj0cyTFno8HcDuSYdcn34jzxzLsyP5cFLp0KmFRYVqN9yjTUbOOZoWu8yIt0cpkasIHMlBJzwNYSItwSxne3xBmk584BK+2SBPA6Th+2is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237101; c=relaxed/simple;
	bh=k9Rm7eLasu9wXzf0SxOy+eXX1KeeMJuTpe539i+5OFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WThMiwbPflfEwsFLF0J9ssECEhonC8YqQBnENufRdql+qmYoHodOIL9yP5rYRvEDHg1qCcqK5DHBrUoFb6h6bLJxYmw2RAwUNL6Dd1B60VgKrEiCjQ1RBti03diSBxdIThJV3kbVllxNQMf0xTLqSK7H3OjTA6FyyW38l0MMveI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nImsKM9y; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9sjlhUPZqkj+UYEl3HOPEKcK5QImYBbQQQQCiWV5+XJW9Y8s2eoppw0N6hYCuEtpfcyjp7+0UpMFe1T1/iB1X3W64XKPUjmGHTciwWdPYQg1j7wjoMLAzFvYBwEVyOduFKlWF8jC2f6MLzyxMvo1jUoySXxtDBo/MAzTYxEBgcqNSMSP+z0gTp+iD08cj5LQazxePTECH6GZPhbwvLeDaMBXNfFb8q7kepvNAtWFpJNKYeFNGe/mnB4smjv2fpcRSVEEPXmL0e5qC7k1HWhjs+2Kqc6aZ9/kpKe0Yd+HvH+95mjft1ZkkuHh/Z0rTRumdqM3Yl3GtoM+AQ8t1RBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS6/jpX+6k9ykdA1QwNRQcX/PdstAIgXJbEaQbxXaWI=;
 b=qx6Pn2luFe1HkdbfEpqwJYJFWrrs1MqAww702IlVohlnnc9FmMzWzDBTZzB10Qj87iuMsNaY3GWyNq2EZWKu8hgzvriP+yUtCflFew0lwH7kwRnbUU9TCEDmcEkk7hg6j4mDeto8y2ovPQ5OO7146DQr3X3HzwcyuRC1zfiRmB3EVSrsalwyF/qOEW7P6UgqwsrcFgEhgLovP/ASuDLttNeJ6beGL0Lz2/ZSp2BBScp7rK2jjWMxbCcjoKb3Ju0Y9/mfpp5rwTPdLH8pScuMnUD28u207xW7A8mTVypEXVW6ZbloQPfpgvfXXnTy3xhfJZR7UDlZR44FYiIjPnNG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS6/jpX+6k9ykdA1QwNRQcX/PdstAIgXJbEaQbxXaWI=;
 b=nImsKM9ywJB1EF8ihk++j3Ez4a7bVObXInOX1w4Z9gMDeac/ZGtwMiHxGigPdE2owNkoFkt9JCX0DNZos27nrWjpRpmiOhJhjM+fo7MZNTo1u64rsmdMp5jj6wwt3WgcZs5ZHGDdVKcAd33MuzEWgM17QqIPqe0E16p8rnAvSUvAbyoAxl574WadMMICgX6tUL/67uZQbLntW5kTWOZIvy/06BICuHzsL3/X1RyXne9m6k6jaEc14zMoJ6lRHL7t7hJAyox5olRndJJCsMMtIAh+iIy6fblUJVoFbfE8vT3hZeUzhoxZset8EYyJFhSxGIW1I828QtiXscFbutCcGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 19:38:17 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 19:38:17 +0000
Message-ID: <cf6d5d35-0050-4c93-905f-e5ad80b59764@nvidia.com>
Date: Tue, 26 Aug 2025 22:38:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Jakub Kicinski <kuba@kernel.org>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com,
 kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825154131.3aec6052@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250825154131.3aec6052@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: c5880197-a576-4c7d-ec82-08dde4d81ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmNRUmlPbGRuVmI2SEFGbEdCUzNnYUFtQVZreGpncGh1cHIwdTRHdUw4Mm03?=
 =?utf-8?B?aldkSkhvUFRDRWV1RFpwZk5Jbk9uM25LRFJrNDFZcldTZVcrOVZzNE1HV1Bv?=
 =?utf-8?B?R0lCcThDYkROZWFGTVRZdU1nRlpNWFVZdUMwdmd5QTIrdDhyaEVoK0NTOW1E?=
 =?utf-8?B?L0NzRXJCT3lnSWk5MGprTFV3RG14VkNxeHY0eVoxdUxGVjhVVnJMOTM4aU5G?=
 =?utf-8?B?Z1pXTWo4eFVMcUpyR0lwR25VU0pjeTBEZG5ERTdvMmo4U0UzRjUyVjJUZFVu?=
 =?utf-8?B?b0ZoK0lnT3VqWllEb1pGWVpRV2xzZXBxd1FMQWVidVBDVm9FYmZKWmRzMUZV?=
 =?utf-8?B?OXpiN2hoWXFvZjM5RXBsMFJqSHlld1FSYXpmNG5ueHJTOWE5MG5aSDBFUmpz?=
 =?utf-8?B?WTFYSmxNMmplZitKTytQT2ZmdGIzVjlNUXp3QUJESG53SEhsUkhzaStCbDBw?=
 =?utf-8?B?S0pZOTBlbnVnZzlTTzRVTElveGxrL0lHdkU2QXgzdUR3cmQ5L0pENllvYy8w?=
 =?utf-8?B?dTVoSUwyT1R4UDN1eU1uUTZCSDZrYXpOSWJjcWR2TjZmQ3pxR0tKb21oWGRp?=
 =?utf-8?B?cXQzenlRV3BvOUs3YmtUN2RqNko5SzJzTGxQeXlGUy9IN1dWeitQL2hFaWJF?=
 =?utf-8?B?ZzJYOUR2NFFYT0N0dXk5Sm9lVkZIUS9LZWdrR21HMzR3TmltQTdObXhWemx2?=
 =?utf-8?B?d1hScHdWZzRTN2tvQ2JhcTAzR21QSUEzK3Jnb0Q0NEdCZUxVNFUrcjlDemNr?=
 =?utf-8?B?VUZiQloyK3NUdGMxQkxHcWlzL3ZmaW5PVkl0YUpSTjBVSTM1cW5WVFFCTWhO?=
 =?utf-8?B?N1BjR3VIWVk2QWVVdUM0QlhXRHA5Y0dqUGUrb1djNXVjemZUTE54UXlPL0hP?=
 =?utf-8?B?R1Y3bTlQVGtUMXZwbnFrSmVmdCt0dkZ5ZXc4SStkb0N5RmhPRTdWY0ZzZW1Z?=
 =?utf-8?B?WjlQbWdZdEk4dms4RitGaXFuQ1pra3N0NUtUekxWTWdzbEtRNDUrelU0d2Z1?=
 =?utf-8?B?NC9wVUZhT2cxUm1iSmUvajF0Yk0yZ21TbkRCS1lnbndqVmJxOWlQc3RCSThX?=
 =?utf-8?B?NjdzcFFzUXNTYVRvdVJCY0lLaEVEd3pSanAzKy80SnhpNkZyR1VsTXhzTWl0?=
 =?utf-8?B?a25zWjU1VFQvN1VJWUNaOWpFKzVYa1JEQ0hTY2c0bGp2bzNET3g1RzhtcGdl?=
 =?utf-8?B?Zi9hTCtuK1AySE42dXR5cDljSFA1MmhOOGVmNXlJTWhVVVZPQ3gyYWFHSmJO?=
 =?utf-8?B?cXA2ZUZJTVlCU2hhc2JuUzdpWlBzQy9GN241dWR5dXBWaitWM1JrYWh4M25N?=
 =?utf-8?B?TVpUMTVoSFJOVDZ1cy94THRPSnhhM2dabjQ4N01nRklPUzFqcmZRNUk5NFUz?=
 =?utf-8?B?YXhRUHdpTDVTN0k0Y1ozQUY3MUQ4cFNFdTY0MHd0QWlHNXZsVmhhSkluVHp0?=
 =?utf-8?B?WE40Q3N4WXNoOHAzZUZZRGZpeFBHVExEbkE4VldMTERWd2NGMTMySzFIOStU?=
 =?utf-8?B?L1lKeVlZdkJKR0pYWUd6NzdVYVdCQ0FmLzA4WnJGa3cvZ3hsaUlBUzRvY3NL?=
 =?utf-8?B?RjJHWmx6d3V6Z0tOck5hVkpzcmlDN1Z5ODMydTdnOEFYa21ja01KZEE4K2dP?=
 =?utf-8?B?cGRMaDY5eTNORXliQWhoc1JiTk9OamFXWVZkM3g4UTczRmtKcGJsWVc3VURI?=
 =?utf-8?B?eWFYcHdYUitPYVZYWllrRnZPTzR3a3AzTjRJVWlQS0l5eDk1WHViZFNhMGpj?=
 =?utf-8?B?MHFKTGRJZWxxRjdqbjYxRXY0RWNKTHZ0dk9qdFo3eDNNb3VNMHRwQTRmOGdQ?=
 =?utf-8?B?QjF6QXVxd2VnS2R3cUR4OGZHT1kyVWN5SDN5NmVobWpNbG5Sd2xMbHFGZzJk?=
 =?utf-8?B?UE9rZEJmdDYwSUJEVE5DRXMrUDMwM2J6RGNhNHZXRzh1RVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFpTMURrL29QbHlETHk3K1l2bHFzQlVjeEF1RmZiVkhVOWcwNDN0N3NEaDZo?=
 =?utf-8?B?bXdsODZuNHMxdzI2cXpTbnFHcGlaVjJKY2h4Y2JVK1AvcWsyS2oySDNRcnFu?=
 =?utf-8?B?TnRCM0hlcHBsbkZGQ1I1TDFPNEFkWkwxZnhsWjlaY1RXVXJFd0FxTE5idWhv?=
 =?utf-8?B?M3NlbE9KbU9LUVFIVDFvMWtKdWhXazdTT2hvVHlqN3JMOEFTWjFhb2JqOE9l?=
 =?utf-8?B?MnVnLzhjbk80ZCtsQzBHVUI1d2ZrWnRQNExDbUlUenc0OXQxQUJXbGFzRVg5?=
 =?utf-8?B?eVdvclFlT09yL2xvYTFUTFBUbUJuekZ1d2ZOZXpaL1poWE96M21ST0Y1RFFo?=
 =?utf-8?B?S2ZBSXJyUWVSckpiR2grbEtlMnl0Q3V2VldxcnljdFcrdUVzUmplWnNpNEVs?=
 =?utf-8?B?V3BOaVZOanFzVmRwOVNYa0x5UGlHL1FYMHgxY2w0bTBtVUU5dlp5dy9TRXZT?=
 =?utf-8?B?cHR5a3ZIdzBpNTNVQlFuMHMyOFRBVVNpUkNKZVFqakxzRVQ4anVYOWt2TmJv?=
 =?utf-8?B?YVZqYzl6U1FpUmlLRjk1d2JQc0NaOFNVU1V4bTFCL3A4bUZQSDR4WVFucVM2?=
 =?utf-8?B?Ti91ak9JY3R5OXpRdld6dzZWc2lhYVRCMVFpM0luTzZqL2o4TW9YZ2hjZGcr?=
 =?utf-8?B?aHdSc3lkNkJiOE82ZWRlWE1KcGIxQnRYM0U4TVFsTE1wWlJtK3pGNjhKK2J4?=
 =?utf-8?B?QzdqbXF4c0NibnFGSHdHYXVwdnA5U05Cc1RXL0d1U2t0WFROanZBbU9PMzQ2?=
 =?utf-8?B?c21SSG9qLzRKNk90UXlkRHFOaWlaQWh0VEVEWXBvamo0ejhxZ1N4SjhBWGlK?=
 =?utf-8?B?eE5ueTUxTm1ZOFV4ZWovSUh6RkxDSzdIbmRaVksrVUc4UEJVdlk4eXJaekRZ?=
 =?utf-8?B?MjBDU1pRVmlCeWUzOGJlS1E0WVl6Zit1am96NTBDK1RORHZoWElqdzJEM21P?=
 =?utf-8?B?VXBiUzdrNUNUdk1uREp5MUhuTWZabnppdG8wUVF4bUw4WWNZNTllNEE3NTBq?=
 =?utf-8?B?Q2hKTzNrMlRaVkd4SFZINE04Zk1UcEcrd1BOREtUb2pkM2UvTWJEZ3hpMXZJ?=
 =?utf-8?B?ck92dDlnMjh1cG4vWUNqaXpWYjhtczFxMXZHWFN1UXVRcHpja0NQZ1NoR2Fy?=
 =?utf-8?B?NWZLYWFtSnR3TkI3elRlaWxCQm1CRlltaTdzY2NCb3krdkJhS01mVXZBRXMr?=
 =?utf-8?B?amlITkduSHlDWFl5ZFhydG5qWWE0bDlGTzY4MTBhb0wvaUdIMHdFVHJ0VWhG?=
 =?utf-8?B?TG5GdlhSSURlTEw0YWhTQ1BmblNOTzBtdnBpa2h4V1pOQVhGSUxSRUlVL2xT?=
 =?utf-8?B?bFNkZW1lZFRtOXlUQm8wbzJobm1haVlwYUpmS2tqdVltVnNUSVdLamJXazFz?=
 =?utf-8?B?cWVraGVML0lPdHVyb01TODIrbVdTdXJTVkpwQkprVmNDMlV0ZEpMWHNha2U3?=
 =?utf-8?B?K2E1VzVBc0ZzWW9VSkIweGlVZk5rMjRqQ3BQWWZQMEtEUEVjRW9qM0R3cjU5?=
 =?utf-8?B?aEFMR2o5c3JiWG1IeE1sdzJoeERJcFgvYk53ZmdoU1ljcTNlc1FXSGVCaVds?=
 =?utf-8?B?Q3NKOHhGOG1kQmJUMnBLWFlyT1NveGtjMkQxRnRyWmk4K1k0cmZ6WkRBNmIw?=
 =?utf-8?B?YTlBUmswdUVhYlA5UzVlU09EVlQ4WlExaWQ1enVvVXFYSEprZ2xOaTdRdEdw?=
 =?utf-8?B?WEg4N051cVQ1VTlId3dDL1pXNFJoQkhjYjloYVZVNHVOZUJic1ZSdDJQdzJ5?=
 =?utf-8?B?eGoxT085WVVmRVpNa3FacFN0eXRjejJTVGJsOFB3ZWhjc25lUUhnRWdscjdw?=
 =?utf-8?B?d1RGNEdmM3pFZloxTUY1QkJMNTRaamozTzMwaFJnZ0d4WmxyaEQwQnh2ek5N?=
 =?utf-8?B?SisvR3BJNUhZb0wrRnpHUVRzS0JxaHlSY0dpR2N6aGU4MW54aklHYjBkMnpK?=
 =?utf-8?B?RDhrQ1hKaVA1WU9US0hrRU5xWEJzbm16dktBVGo1OGhGWHdEdnJZOUhGVkxh?=
 =?utf-8?B?VFJxMXBDUjdKalRQUDRzUE91NC9lSHVGc29Ybzdkd25scE1xYzNjWnl5T3NV?=
 =?utf-8?B?SXNYVTM3VVo2ZGY0MGFSeS9vTG1TUGxzanJrTUVQNHNtTzd1cHYzMlU2NTdZ?=
 =?utf-8?Q?/zGQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5880197-a576-4c7d-ec82-08dde4d81ac7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:38:17.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxHjDtI2pLg00JsW1cORHeWHfz50y+Ai7y9Qgimg63P06t7jJ0XOZE4ms3YRVW2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

On 26/08/2025 1:41, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 12:39:11 -0700 Amery Hung wrote:
>> Hi all,
>>
>> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
>> pulling nonlinear xdp data. This may be useful when a driver places
>> headers in fragments. When an xdp program would like to keep parsing
>> packet headers using direct packet access, it can call
>> bpf_xdp_pull_data() to make the header available in the linear data
>> area. The kfunc can also be used to decapsulate the header in the
>> nonlinear data, as currently there is no easy way to do this.
>>
>> This patchset also tries to fix an issue in the mlx5e driver. The driver
>> curretly assumes the packet layout to be unchanged after xdp program
>> runs and may generate packet with corrupted data or trigger kernel warning
>> if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
>> bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.
>>
>> Tested with the added bpf selftest using bpf test_run and also on
>> mlx5e with the tools/testing/selftests/drivers/net/xdp.py. mlx5e with
>> striding RQ will produce xdp_buff with empty linear data.
>> xdp.test_xdp_native_pass_mb would fail to parse the header before this
>> patchset.
>>
>> Grateful for any feedback (especially the driver part).
> 
> CC: Gal, this is the correct way to resolve the XDP not having headers
> in the first frag for mlx5.

Thanks for the heads up Jakub, CC'd Dragos and Nimrod to review.

