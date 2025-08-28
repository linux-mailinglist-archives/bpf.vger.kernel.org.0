Return-Path: <bpf+bounces-66830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A592B39F3D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C333AE83D
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE531195B;
	Thu, 28 Aug 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXgZGRKs"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E11A0B0E;
	Thu, 28 Aug 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388532; cv=fail; b=cpFKc4qybRGbAbRycFAu270eRrVPiNsQNLq1Z4MGowpNo4N8YLBQRSPwbrnm6OjN3O5G2P+6a8SkT0nYq7DQRd/sKTlpsOreQSOy6T2lWTtelE1HX3/pduDm7XLM3hSgvrzw5po4LF7UuqU7b0R+VQ0UufNmwHGeHBkXX0VT1b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388532; c=relaxed/simple;
	bh=CkqERtqgpfEmeJDu/OTnQQb1Db9aGLMBv8xPRY+WcMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRs4Fiy7AlfSW8qu9unmqSS6Cj12Tv7GeHYstlGcLiKh6xf5hkWm3bz5DEPo2UelZU4sgwXJxqKJsgix6zh6Q6WijQ1OP9Ykkve2byUohMGaFHWCYkZbSfkt3VPkfHxbqWYJxIPRDYXGBknjqkUY4XDs9h7TI5vHdHf9iH/aJyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXgZGRKs; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxOx+U5WWptAV0WWvh/1cuM4MWf6oUxs/AMO/gpcoPxaMOU9/3eTZcohHaeXjIDbgXq2Otamv1a2linKmXxwVaAAWrJdFVd/vHvvFmMGmm2emOdOu6UO4tLrMrIS9NZmq/oM7RKzniWQg+A/YVOPCQ/xtX8M6XcCVpt93XOouY4RBegOn7guOMKvFTvi2ktHDz445ZKB+goL0JUNLqczD54aj6dVP0x0wKjrUocM4HGfBrzKq6jLc11d4Itn4PhNnIeiXNor6pQ6y+3YmgeQHc4C57lqGmq61nqTCaLxvqaTWx5AusCvzldz1+qHEGOUHdzDRy8rsHbGU2fBMQxMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdVZPVxlJu6O+makPIGpB1GU/1bFo1GqrXLPda+x6Vo=;
 b=WJ2ekYZl6lMorRrhkbUlqyMZQ81OeaAsrtuUBgJ874A7J8Zx/UNC33EkZBZAnMufZua1CWrrXEIm5HprDSTmdFi035V4b+fTdwcOWQpys6PuJaW5ok1FJ2adAShk5N6dO/kgWpqfWr9SVNBHLntDsZFTMTGClPqzDwSNBLwDjTR09Lanp/vwrA0cSoQDvG96aCIVDa3Ko7lmRKSjCDzBqNuQUTckbLuFlJIVBx02iEz9ysKycAi16MIfuXeYaW6RatbTBKUICnOMAQ/1qJMA4WffJAbtVDAMfkARWcAservpdnUE+tZw0FlqrnUJmEBQrhfRm/1qrLrInvVW/EF5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdVZPVxlJu6O+makPIGpB1GU/1bFo1GqrXLPda+x6Vo=;
 b=gXgZGRKsAosMwQqsdrFjr2g1ebveaKKZkrSxqUDbwZfaHlakJ2E3oIGCdMSVOt4n9C3czQQ75osJX/NwOOgWosldu+yNCc9IbMfdi2tp83d5DPniqZcRMeNVcZp1PUuDwWPM01b+uvrJpvQwAzkNzIj4MVp5WER7hXVU9M526UxmlPhAcwPQuMQve4Sde+woCpZp1plQMBUecwpoGMYQOjnLV47uWxY4onYwZkRBsin0Fb8qVJacj6A5oOovNTfcc3ZQ2hEoP7OqM8fB0Ln/Cr/kexX9JjndA2DgJTJZlxuvKBa83YHX0tcykuipKqLqoZY/Zmq+hfgUm6WI8A+arw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 13:42:03 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:42:01 +0000
Message-ID: <e41d259e-ba24-47ab-8b08-279a2a3ec975@nvidia.com>
Date: Thu, 28 Aug 2025 16:41:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v1 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kuba@kernel.org, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <20250825193918.3445531-2-ameryhung@gmail.com>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250825193918.3445531-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To IA1PR12MB6186.namprd12.prod.outlook.com
 (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb42420-2803-4e35-1b1c-08dde638aaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmhwcitsQjFsNm5LalFmQlBWbmRYMkVPRkowalhBbExmU1JVYmRGd0RVbGRH?=
 =?utf-8?B?d3ZucmpYM3VwUm94QnRmRzQ3ZGpDY3ZjSjg3V2NZdnU3T1FUV3VLUk5UZW5G?=
 =?utf-8?B?NG5Ma3ErQ2F6djNKZ29wRm0vUHFpRG8wUzExUWltUWR4U1c3Ym95cjJSSzdj?=
 =?utf-8?B?eEYxVjk2UHh4bEVDSVZTVnk0dUZiSHZpTnJzNGRscURlYVgyTllsN3pYQVVP?=
 =?utf-8?B?bmN0S1JUcW5ZY3BzRjZpMjVqRzJMTlFxQzdZVERmLzVKNWFrVkZKbFAvSGYz?=
 =?utf-8?B?c3gzdG9SYUc4SEFPQUFvKzEyNXBtSyszUGxGM0pXWDkrdEFYdTVITG5QSFBE?=
 =?utf-8?B?bXc5T1lxRFMzU25oMDhJRVZ2eXF5QWlTMFFQQ3BRS2dWUE5MQUl1YkVvMHlP?=
 =?utf-8?B?eUNaN1B6MldnUDRjaFBmZHJnNTgrREp1bnFBTXgxNUpXZnNWTSs4K3dxQzJp?=
 =?utf-8?B?TkZzRGcveGkwZjFkQklVb2sxend6MkFPWkFNVlBMUndxQVFwdndVSC81eHJw?=
 =?utf-8?B?SkRCMi9TWXk3c0p4NEM1T2NmUG5WUDNZNG00alRWaW9oc0V0K2JFeUNXQ3RI?=
 =?utf-8?B?Z2hHNnl5V3A1aFMxcStIVXhmeXdsSVlWNThOY3NIbVVSSUp1Qi9ZbUV0Ynlr?=
 =?utf-8?B?di9oOGNhZzVBM3FaazBSS1Rzejl3NTQ5OU1iNzdDZi9YQ3ltU2h1d1VJM0RH?=
 =?utf-8?B?ZVNoWDByTHUrUnlodmFHdmhuQVdvdit4dmg3TVZzM0VnNGxDMHlpeFZsZEMw?=
 =?utf-8?B?MGlhMGpOcjR5MTdRNkZnci9WVHVPeTRqOHF3cjRmUkxyQlJtREhJTjJUa0ln?=
 =?utf-8?B?aW5uNjRub0dpa2RBek53em13TzB0L3B1Smt3N1hjRFU0UXpBQUVzVmUrMkhi?=
 =?utf-8?B?UGFybmFWVG1zLzlJMHBnTkR4QVZhYnZXZWRiNWNzZUJiTUlGUU83WmN3aUJI?=
 =?utf-8?B?dHYxRDNiR0phRlgwVWE4U1FXdDJTUkNoRVg1d0I3WXRrb0JZMU5GdkI0UytV?=
 =?utf-8?B?em4zQ013SmFaUmRnai80TFZxcjRzNEtaMjlab1JSUzVGQ3VwbjZLNThEVEdw?=
 =?utf-8?B?a0RGN1RVMTdqcUdaSlpvcUgrWm0zVkVnNkRGRjRlejRGOHBWYklRaWdGZXRX?=
 =?utf-8?B?dnhWazJGSjhnNE94Zmwxb3Y1TERRSW5qandpWHEySEcxODEzemFsa1VXeWJ3?=
 =?utf-8?B?TnJmbGFzU2lUMjhIRjExQW1PZTVEcENEMCtpTE5LREF2VUQ0S2dGb3RUaG9G?=
 =?utf-8?B?NVVMQlM0eUdDK2YxeTNpNG5UcmFnelU2WG9jTUZOOW1jZUZRSElUMjBTQ1Vh?=
 =?utf-8?B?ajFGZEdEQm5zejdpQ0hCc2R3WHJvY0JKVW5TNU8xcUtJbmY5L0JtdERMZmNO?=
 =?utf-8?B?b24vNVlmUjdnUXF3ZURZcHRvbGJQSXN1ZmdlL1VLUi85SlFKM1A1b1BZN3ll?=
 =?utf-8?B?NTA0WHZFT1B2TDBVNmk2R1NNOWdXNDhzeG5KQUFadWl5TmtVY2NPaENnMVlv?=
 =?utf-8?B?SmovcThHLzNnSEhLNEEvM1FKb1F3L1p6VzJxQW9MYkhzWm9pNnNNUW5uZVNj?=
 =?utf-8?B?cmZoajVDMTlCZjMrYnZSaTZIUzFKMXVLcndzVUIxZy9Kck9XZlBqY2Jxb2w4?=
 =?utf-8?B?MG5PN3BMVmlEdjdXeEpqRW5ZNU1yNThEajgwQ0V0UVIvaEZDQnNzUUF1b3Q0?=
 =?utf-8?B?cnhJd3J6VHJnSytTQUl4c3dtazBtNHZWSTNsSVBzaG9nRkpRUzFHcktmOTd1?=
 =?utf-8?B?YmJBanNXQUZFWjNJU0lUNGRZc2x2a0pwSzBNaUVuTGxDYkozM09IVHJneTFI?=
 =?utf-8?B?N2NNVGhFMXQrR1Uxb1hBQTlrdkZhTmpNcEMrU3JxMjU1RDlzUnoxUWVZOTlZ?=
 =?utf-8?B?a1k0N0pnbjN2dStHc2t6dnZXeVVWOVhjN3g4R2tnSHEvMkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekJwNVRsZlNQQkVpVURBSm9LOTYxYUQ1eXBRcVlqSGlBeUtoU0tRUFhLQVh6?=
 =?utf-8?B?cytoL3lMYnFPL2l2a1h2RUFLbHFkN2hKelJhWHNKaFdCZVRDWUNNd2RuUXly?=
 =?utf-8?B?TnlYSE9DaVVhVXZaUktOUEw5b25kQ2ljVWNyb2cxWWs3QnZlYTcvdVM5ZUh6?=
 =?utf-8?B?Mit0T1VaV0ExWjE5UERFQW83dElNQzM1d2FTNkNDUUxSM1pEU2FjZzlScmhl?=
 =?utf-8?B?U1lJYWJTZnhCNEFGWnJ4UVE4QUpnYmRCbk9uTVdUVXBrRHM4NXFWVlVDdUtU?=
 =?utf-8?B?K012NnBsL2VBem0vdC81YnBVNGZmdnA4SEZLY2gvTHpSTFhHNFp2WGV2RjhC?=
 =?utf-8?B?QVA3TGJJUFBaZ3FmenNmYmo5NENyNkRadEdPUE9aL053TE10bG5QQXllUU9Z?=
 =?utf-8?B?SkoxOVRqWm41em1uMzNsTVBXbnZTZzQ1dWxsbFg5bGQ5M01CaFpoc2Jmb3Ra?=
 =?utf-8?B?Q2RCdHBHK2EwYjRZUjhndUhHZklXZTJZMVZwOElLNk9uWHM1WHAyRlBGaWdi?=
 =?utf-8?B?dlBNYTdndkJQazE2MUtFeGk0bVVxT1lVZXZsZVJsVHZFSktoRlFZYUZmelFG?=
 =?utf-8?B?L0pvSzZhRmZ4NlhWYU1weFVlSERZMnpnTFFEZ0x3NmZoZmVrc1RSbUNTK1hn?=
 =?utf-8?B?cFFLY2h6K0IwbFY5Ym9Od2szbFJWcmo2KzVTRUYwQmRxcDlURHVLVHFQdWd4?=
 =?utf-8?B?VW1YVDZoQTdPdWdNbExKZUVGN1VpWmc5MnVaaE4vZXdrRm9DQi9HaXNLNzE5?=
 =?utf-8?B?RHRaZHU3MkpaTGJDcC9WMThIOGpoVExjc0RJOHVxQTF4bCtya01ncklqTC92?=
 =?utf-8?B?T0VWMUJzc05nUzZFK1VLTUcyYUdEU0MrYTV1RW9rTS9adktvM0xKOHRWdUxw?=
 =?utf-8?B?d2lLeVVLZHc1cTYrRzNFR09oMzJDYnhEUnZORDhmK1VzdnhiRGdDNXlkMjI2?=
 =?utf-8?B?cVRqczhkZlprRmNXamQ4OGNYRG5tMzJzckdpU0Z0d1VJQXlrYWp3NC95bktH?=
 =?utf-8?B?aEptNzVBeHMxSFhEa3o5N25MZEtRVWR3RWxJUDFueTBHY09vYXlubTJzMFlB?=
 =?utf-8?B?clFZQjAvWUN4YjZ4VTBEYXJxU2lDaU1yc1JySjlTNGpJRnVCVmdIL29CbDda?=
 =?utf-8?B?V2M4bnRraW53NG5nN0QveVA2TkFOZkltOVBqZGcvVGZwcDZJd085dUY3TzJm?=
 =?utf-8?B?cks1bnNwU3ZhYmZiSU5ra2hHRzBnVXRmRExwZ0I3V2pqZzNJN0ZCZ0Yrb2pG?=
 =?utf-8?B?NVJVSlNmMHVsVDJhZDNia0p6ajRGNXkrWTNGQmVqN25KOFVZRmNQcDhIV3E0?=
 =?utf-8?B?Yng0WkRVbCtCUU92eURDRVdKMUMwN1dIRmdabGYzaUJLSjJqdFZFMys2Qzls?=
 =?utf-8?B?MFlCdzJpNFNIdVgvbVFVZW1VNTE3bmNGR3dRNXBITXk4UmxRWDNBZmVUZStj?=
 =?utf-8?B?TmlBd3Fka3hJU2kxdkFBUk9rY0d2OStKbnpOTk01dkV0THRXV2xScmJzWXpP?=
 =?utf-8?B?d2t1aU9ZYlVQVlNhSXFwRVJ3QU5Md0diL0xUYjJoY0grNis5ck80U3RuamMz?=
 =?utf-8?B?VnNFa2tEK05hVnFWMWNtcTFnT0UzM2xTZVB5NFF2WGlONzRDZWdoMGVkb21O?=
 =?utf-8?B?UWVOVXRadWxZUDNQazN2WTlLb2s5R3gvaSsvUWRxNVdNU2tQcGtFSEVCbFhY?=
 =?utf-8?B?VEkrUHpSYzBmcUZTZzNLS2FMM0tvT0t5elVHLzYxSHFWRkdFRktXa3IyalhD?=
 =?utf-8?B?UktmNHBWd2dCN2pWYVg4eVZpWDR3UER6UHJqdklkUUMrVm5VUmcxRVBuZVBW?=
 =?utf-8?B?YXQxSDdhWUtRRDMzZXIwMlBxY014WE5Zd2xXczZHUFJnRWo4bk5Wem9SdzlG?=
 =?utf-8?B?RWNQdTdYNXBQR0ZYSjJHUkdWbFNXeHRXOVJGdTBuaUhUbE9TZ2ZBVEg0di9E?=
 =?utf-8?B?bFVSTmtFdmdCSkJvbHV6RG03SCs5WWZibEo5QXhlSW00UDRZNjNKZXd0dEJF?=
 =?utf-8?B?S0ZzRU83bjk4amZTanRVMEEranlLejIydHNobWpMbGVwTXJJR1RxSW9JdGZx?=
 =?utf-8?B?K0hiS3NJemsyNnk1WGNTV002TjNodU9QYTQ2ZXZnZDlIbi9TOEVZSGwwaFB6?=
 =?utf-8?Q?UsbUoyOl+BcZXxhIS/iww+XvM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb42420-2803-4e35-1b1c-08dde638aaaa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:42:01.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeLdPHNJRVYNoAqz1AS3rcpoSBpM5fKjog/FRofRd3PgrhweOu+mnqg2qlB0A4OIhbjoFENmBR4gkarrfZQ0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665

On 25/08/2025 22:39, Amery Hung wrote:
> +			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len, sinfo->xdp_frags_size);

I suspect that this is what caused the crash I mentioned earlier.
It seems that sinfo->xdp_frags_size is already zeroed at this point.

