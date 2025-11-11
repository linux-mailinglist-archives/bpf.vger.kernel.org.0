Return-Path: <bpf+bounces-74127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFCC4B30C
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06891891DDE
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBB346FB3;
	Tue, 11 Nov 2025 02:18:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020120.outbound.protection.outlook.com [52.101.196.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44E223DC0;
	Tue, 11 Nov 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827509; cv=fail; b=lrO2+otybtAo+aSCEb1Ip8EHLeRC7EqnokpsP4/bA4V8fKhxfmaeLElEqcmDQbbLYizI0+7lE6r4EgiJISUyuLbnoAXxOxDXbPJkdmfLcCqUSZiO5d08wl7aUbTFFj9d2d36Zt0rm2Sw7Ah4+qcS1Ms/MjZUXYVQmhErCyrnX+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827509; c=relaxed/simple;
	bh=GBYf2AVnSDI4CYLEwA1wR7pTFF6allkNLWMHMsfQGs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MlWGN7BMuK1t6OuDmMMYP04xUkCi3c639MoJUmBfJV5TycC9QVZlRDRuilmnwy1NM1dlMcNmQ31nAqgJcicNAk3uvJyhaT1xkm7T+ccvWlInpEj8ZmzdlwDpMG70lF8KQe4Op+PhjuF8EuaBRJ7beLRS5/Bqc+u1dVVffFIirZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGrLjIZBw8Gp2FvIL0MVfguaecJf/aVFcvAxHDAWmMhGXnUytItwdMrIL1kJFxtlxgSSaWcIfIbRVtZxDlscAm5wCpyVj339yh3A9qrGsCmV01XiyWiqh5/3QH5n9FCGnPn9YEb8ZUTPuXBFaUKSYgPQCchfkA0dSjolKpVC09ZU9TkEzWiHslV5ePYljmj0AyhI2VJIJLU/4CQvOpdT86f5ZsVlzkMK5jt1ItMDWLi7GpX4JaMgYlmnG6CbjZVCKZ2lSHJyslrHJloD8OLPaFP1GVrPdVE0DC/d2fpM5X85pJafNRdzoaNs5h17dawfp0uyRVz4giTpKgGweI6E4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PiPeO2C/l1gkOmY/HQd1TNtIo+IUW/DyJKujoK5TGo=;
 b=m/SZuu6Z1CcuqZEYA1kFV+MywFQtlwYxWCD0uspUNCXmF+5aQ3nuEmLA2ucEwDYfUdAumxrkB90if8kplTF25c+r7Kj8OoRbiRL6asBVrfW+bFZp87FFv0wC4H/SS8UMjG1UllTQMck7Ebt6MTXVkooncOwE4eFmoHQQY3c1kWjtAJRiRqT+q9kJyNed195HyXMuaG5pa4Q92dGctZJwd3svKIjOXj/OImlg9VFP0wFACLZOqvb7ieVeBg98wIIeVtcAZ/DJy/nEWSAyI1LpY4z9tnJ5LFezZQU4XSTNzHrfep6INTIEVYMDQuIAC2xol+wwF3fA/QXbhQwLCCAN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6415.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:18:24 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:18:23 +0000
Date: Mon, 10 Nov 2025 21:18:20 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kallsyms: Prevent module removal when printing
 module name and buildid
Message-ID: <oq6fd3ohxeyfzhtwkszbjqpzeccirhk24nqlzemgjoyc5vvnwg@3dlaiovrex4o>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105142319.1139183-7-pmladek@suse.com>
X-ClientProxiedBy: BN0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:408:e4::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b4d43d-58b9-4507-4dbb-08de20c89754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzRKbitLcDJrRHc1T2RRaS94Tkc5RGRnbENLTmJBenlKTHFvdE5RU1Urd2VH?=
 =?utf-8?B?L3RwMVgrTzZTUUMra0dZWENyYlk3NVorY0xhZS9XL1Q0S1VWOVdGYjVNeFdP?=
 =?utf-8?B?YWdENjJUSjMyanMvNGIyL1hPcm8vSGI1ejRpMURZVzZrN1JlUE1wWGhzNlpI?=
 =?utf-8?B?eFNmZ0dRaFEzc1NuMXg0YnQ1cjJUWm4rUVlzVUhzcmYzcEwxTWY2ZFd2Ti9h?=
 =?utf-8?B?KzdTaDNZK0ZNdFpmTUFDTHdpZGVmY1dJN1orNWxNbmtOV0hMeDU5MUVWTFhZ?=
 =?utf-8?B?ODhhc3J6aW94aHBCTUNlRFM0UlJUYm1EWHVYbklZNlVLK1lJZVZoSkFZTDgr?=
 =?utf-8?B?Ykd2KzdvYWlCeG9QOHVQeEc0dEtqcnByQXFBRytWbkVnOEZvb1JyeTRHclpH?=
 =?utf-8?B?czhmNkRqN25Xa1NaM0laNlFiZVVZN3JzMk5ySUxpTHcrV3l6MmxYcnB0UUth?=
 =?utf-8?B?R0tnWUw2aDhxb2NsUDhsbEhub1NaR1BERFBGR2lWUllUREJOTWFiQkhTZEN4?=
 =?utf-8?B?dlBOb1RjNjFYb25teTRnWXR3eEY4b2NOdXBPWGhBK1lNUDJ2WmwxN1Vxd043?=
 =?utf-8?B?K1JyOUxRNkxKc2x0UE5jTEVWZzJ3NitFc2ExQkh1NmFuendSWXlQenR2WUx2?=
 =?utf-8?B?Y1ZzZnhKQ01HTGlxaHE1cE5jVE9vdHZIQ0FmM2tpNkJreGNkdVdsMGxvbmVq?=
 =?utf-8?B?MEF2VkhUUVhLQ2JqbDkvbzNab0JiaXc1M2cxbXBXU0NucUVNcXh5a2NCWHI5?=
 =?utf-8?B?cGx4N2NwejZ4c0dsWXFSZ0ZRMW9QTHNoQVlxa3dsckU2NFdKRkFqbFFya0F4?=
 =?utf-8?B?ZmZwUUhPTElCOVMyWm5tODJLYXhJZzF0NlpXQzhrOTZhN2IxS094SkprZERN?=
 =?utf-8?B?SUxxdzdBekhpakRUZSsyT09CMjR6cE1uUlhRa09kTEg2b3dvWmdodU5ZSlJE?=
 =?utf-8?B?ci9QTGpicFNOajdrRklISHZvSHBDWEV2eE96c1A5cktUUTBCQlNwSlEvV2xw?=
 =?utf-8?B?ckt5b3Jkd0hHNVQ3RGtOU2pBSVBuRFg4Q2trcWxGY0VzczZwT2tyc2pGVTJT?=
 =?utf-8?B?ZlI3b0hDS1czelFBUE1tcjN0N0hHUzhwRGY2VGZHeUhmMUw4L3F0akVxb0VP?=
 =?utf-8?B?UjgwQmFDS2tFOFlvVGR6ZFgwU3B5OS8wR3M3TWpXT0JrRHdIMmVhcmo3cjVR?=
 =?utf-8?B?Z2VYSW9mcHBuM0VFcmh2T0FDWkJlRk9ZY0hSK0p6R2JWd1hWMXllQUtlUnhz?=
 =?utf-8?B?Q2xCUEhPVU9mQlBJNVRua21EYWxZUjZYcE5hVkplYzhJalVWSEU0WDBqZ2hv?=
 =?utf-8?B?YXNvMStJYldROTZvM2xMSnZYajFIZTM2OHFmVWNpd2JSNFFNUldBU1ZFVStR?=
 =?utf-8?B?T2JjZmpxMWQ4YStLellpaU1nZSsvS29ZUEpQNWh3bzdRME5hcUV2dVpNcjRM?=
 =?utf-8?B?TGM1S3NEMDRaWVZ3U2g3THpYWTJ3djdYZTR5QmRnOGdyeFZGd1IrUm0xTVhn?=
 =?utf-8?B?VndIUzc1d2ttSW55WElYRWpUb1RrUklGUldnWGphZlJ0TGltVHZlczVuK1k5?=
 =?utf-8?B?cUN2b3FYR3hlbFVLUTdDelNrb1lVR25Db3RBb3o1RmMvQzEwbC85SitMSFdJ?=
 =?utf-8?B?K2dKTFh2dXNuOVhjY2NkQUtVN09hYU5UREZQVGQ3SnVOYUNrWHJRU0ViSndv?=
 =?utf-8?B?K2dKNkQ5OTJBL1c4a2FHOWVXZjdNYlg1czNRZlY1U1VhdFFnRm5hbExpTWxX?=
 =?utf-8?B?NExVQmVUb3l0d0NPeE1TQkRoSys0OHA3cHpkOE4xMm1SYjhoY0tEUjMrempB?=
 =?utf-8?B?N1BaMnQrMHNFU1hpNVI3UnFJRWhSN05pNVR2MWdrekljZjBENm42OG91SEcy?=
 =?utf-8?B?ZlEvbDRXWG9MMUhzR3ZDU0FqWVoxRk8yelJwYmc4SVlVcjBKYVZ6OWZaK1lZ?=
 =?utf-8?Q?vSeXgWkgMSLLuIAy8UQ1lZZdqNAfatkW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBBWlZsOXBWUmZBVUtYNEZpbks3ZGFYMm9OZE9qNHMwSVhrNjNCelkwVmxO?=
 =?utf-8?B?QjhqbmVEQm8zZmtXdnFtR1R4YUpUNzdkZEFyRFlKV0NQYk42RTd2Sk15N3pt?=
 =?utf-8?B?S1BHV2NnUkNIcGtFUUtmNHlaTmlrTENmNkRRcFpLSzZueEpYN0FsL2NuSkhp?=
 =?utf-8?B?NTRlY3VCN0Vhc2p5OVM2UWR4SWRRWHpYTDNqcWtoWU15cDIzU1FSbVBSM2F5?=
 =?utf-8?B?L3ZYa05MRkhOcEhRazNpNFFzSlJ0NDMwdW1xSTNqLy9MdUFIRmMyZUZlekVv?=
 =?utf-8?B?aHp4WkkxcUF3eEFSOTZLbk9oYjJHa1hjRUk3bFhBczhQNjJBUlBXMEZMRDJC?=
 =?utf-8?B?WWlNUEduN0RQT2hWUnJaYVg0SW84UXpvNlhBQlJkNUhKcElwK0VBTm9JV1Uv?=
 =?utf-8?B?WGhzTnl4emhKUXdMbEhxa1h5cHptcUFBbmsvMG9XWHNHeDBIZHBuVWFxZXJM?=
 =?utf-8?B?UHhidzN3MlJuSTV5WlNjQ1NINER5andWZmFEbjRBakR2U2I2ak05QXI2Q051?=
 =?utf-8?B?V1pOSUZwWWhkM1lIMW9ZOU5tWnZwcmhBZGtEZmluVVN3ZjFtWGdjYVhNZnBK?=
 =?utf-8?B?Q3lJQmd0Z1ZuWm81bEpsVWJDQUZqYkRJU2lWR0h1MmY0eFoyVER1aGxwcy9H?=
 =?utf-8?B?b3BnQi9IamYrd2JHbzZ1bVBCMk9SckhBYTMxVUFMZEgxbkRuOEVqMzc5d3dK?=
 =?utf-8?B?NVJyMEw1anNGRkNDNlhRWG0vMDlQb2RiS0QvNWl4M1plcmZPMnZlc2VQN2Fk?=
 =?utf-8?B?cXFtSVBSamJkb3FCNS9QZmljT1JkbzhrcFFCTVFsUytJcFdUWXJCNzRBb1hX?=
 =?utf-8?B?YzFqMHp1Qi9VdllzeUxOUmhmd0NoRk5lNGhwUFBpR2hrdk45WDVmWkhkY3dL?=
 =?utf-8?B?UU5YYXpuSFpCSm9XYVB4dWFaTUprQWUvWEFWaWQxSTZLYnRYOWd1YWRiaHkz?=
 =?utf-8?B?WGtOMHoxbEU0czc4STI3ckZ3TjZUbVJrUGFYanZoZ0srcktlL21PS2pXR1JN?=
 =?utf-8?B?K25SVmZHQnlwa2dlaUtTQzB0Y3ZVZEZKSmRCK21KV0RLR0tOcU9qQ0dvQnRO?=
 =?utf-8?B?WWZUT01aZVpvOGFVb3ROcnlhN1J1YytGWmNtd0YxS2VKdHhKSkZBdDErYzMw?=
 =?utf-8?B?MGRuUC9uaDJPaXNtWURhNFBIVU0wSFQ2YW1uUXBMb0FGa1dwRU1VZzdCTnBn?=
 =?utf-8?B?NDRuc0pQMHl0STc3OTUySzlUc1NGVG9zZ3hOQ2F0b3VWWGQwclJTN0sxYjZx?=
 =?utf-8?B?cUljcFRUdGtkNFE4SkMvYzc1b1hKaTl6NGh0U3JjbjVwdTlCVFdPNmhDQ21G?=
 =?utf-8?B?QWxxbW42TFMrdW9wSVI5a2NZZ3JvcmEvSk03VVo5MFBXNmZialg2bVM1Vm5r?=
 =?utf-8?B?bXFUVzhCZjNQM0pzcjRzc2xid1YwTVB5SjVpYlNBd2ZielhwOEVDS0Y3Z2RL?=
 =?utf-8?B?cXY5RGd0Nm1XQkNXVGxucU9sRWhYekhOa3luWmsydElLVVBTWDFVcjNVL2Rw?=
 =?utf-8?B?OW5aemR5Uy9GUTkrR3hzOU9BWCtKT3RIZmZ2KzFLTzRNZmJGdGVYTXErOHE3?=
 =?utf-8?B?TGpoZUJFVGdTRDA0OWdSdHFITGF5cjF1bVZkbkhWRk5HNDNWUGxTRitvdVpF?=
 =?utf-8?B?a1RaVVJ0bG9jdzhmU2FFekp3RjQxd0hUZUlKUmRTVE12VkJOYityYkp1bGtT?=
 =?utf-8?B?NFowd3FyOHhUekpia2hZT0pacHFoQWM5QTh2cEx2WHBxbENJOXVJUjh5RVZN?=
 =?utf-8?B?VGNpeW5NN3pvMXVvUWpQZ2Z0RGhtMlNwUkl0ZWwwVkNQaUxOTmxJSUVPbG1v?=
 =?utf-8?B?dTlMTkVyaDRMaVpnVUVQRHlaZnVpNTBObEtBQVNNd2gyRW5BOEJCNXY5ZXk2?=
 =?utf-8?B?UXhDelRUazVmaCtoZXpkY2xHK2NFdzd4RGhMaVlMeDlwdngybTJtRUJ1VU9r?=
 =?utf-8?B?emkxZGlDZThMWkNxL0tmbnRUcXZJUkthWHd6aktTNlRROUtiZzFFbCtlVWFT?=
 =?utf-8?B?c2xmdzBvcTA5UEV1TzVZUGdZeEF0dHFwQzhjak1XVDdLZmRVSGdBZ25udzZF?=
 =?utf-8?B?bVNIRFJvTzhpc0I0eXBQM1p3U1dZVk8wQk9KV2tSNWRzTm51NjBRcFc3Znpl?=
 =?utf-8?Q?Vo0NfvBHUqmhYnWFU1f04yZTi?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b4d43d-58b9-4507-4dbb-08de20c89754
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 02:18:23.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: My8YLY1BcOCgeTbzdba+FqZ19EKqO9NuuiLcGtXCcUJeTRJivrlV3ajWWtZTzzeUz+PKHq9q3LZ7X7rSERMPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6415

On Wed, Nov 05, 2025 at 03:23:18PM +0100, Petr Mladek wrote:
> kallsyms_lookup_buildid() copies the symbol name into the given buffer
> so that it can be safely read anytime later. But it just copies pointers
> to mod->name and mod->build_id which might get reused after the related
> struct module gets removed.
> 
> The lifetime of struct module is synchronized using RCU. Take the rcu
> read lock for the entire __sprint_symbol().
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/kallsyms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index ff7017337535..1fda06b6638c 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -468,6 +468,9 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  	unsigned long offset, size;
>  	int len;
>  
> +	/* Prevent module removal until modname and modbuildid are printed */
> +	guard(rcu)();
> +
>  	address += symbol_offset;
>  	len = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
>  				       buffer);
> -- 
> 2.51.1

Looks good to me.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

