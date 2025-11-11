Return-Path: <bpf+bounces-74124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBCC4B2C9
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2D73A7BBB
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14631BCAC;
	Tue, 11 Nov 2025 02:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022074.outbound.protection.outlook.com [52.101.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81781286A4;
	Tue, 11 Nov 2025 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826709; cv=fail; b=lI0t2duba0rx/3A1wDaMPEKBmVCib1fVq5eMnpAk8ejVK6NcSd3BQ22i0EF9FQ7EVFUNH+Si701foeQRHa3pfgfssxp0GBMHMB+ljDqflSsyA1cdfvMnmbp2GW4L+ENKN+AEHuTw2pt2ByhBnNi9xLersWGBGulRrDB3zmQlzV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826709; c=relaxed/simple;
	bh=rpAJy+ea4k5TAN49s/jEdRtgoJCTw85Nz8c26DWQfDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QJ6F3lbvWBfiyq0JiOLK8Fq0a7JXYyUePZ5BzblHyVmDTznc+EmdPstIB+UUhIMf/v+NmmreSCmC02Pe5WA1P85RIw/HWqRfGe3+hy2US8vBXIiJavH5UzpDPGxfEvKA0KgSs0LAf0a/sda7Qnt2Xk/CEPE63Fraatl1qosQz6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viDc6Vx35xnyE5LgrbfVyFXyS0SdI19I4wc2AF3G2mp6nYgQl9m5J+hSGekXsF9+GMAG5do94VZcV9w2xtlYoAB1QWiyD4f1sYcKj3Y65wBWkFkQ7ggpVrMPuvNbitxugaW4Memnle/a/hopmiS2F7Lx/qZLEG5OQ99WahorVWoN5lJCiOk6/8A2/+m6o0X9s2Wm5oRIex5TLe4/emJ3xahGca08vqXcaOYCxNCvO5HLQJfjIOEo6imptXFuOmr60Aye4lL4e1pv4DXcgIfVVMZ9mHXZES3YpT21Uyhs2nxXp1q2P560qBGJlBiOvTHZ68Ua0ZdLucC1rHuj797alQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMDRTRpyfTXBG5qVZBlcKPm07N7AiqtFdhVAhDYYpms=;
 b=Poo7qT6obY3eCOjDCc/oAvdh37acjgvI9xsO3ZO4dqi/kHPkI3a1rD+qSonc5vLIF1m6L0mRR6/vYDN4Dj71I22qD/OzfxmQGeplL5/ZWOok2CgI+D0RQHRseNY6iXdQMMFkAx8iySkhaDnqBk/jDP6aZ8fgu4fgxOcUbv23C+5N3j8hQWEMqZsdu+mAo3+u5fycWR9sk1/izm1JRCY15oXUbkUOK71Nbw/OC4bqEbjqI+U07/7FYqvnlunEh01SApgU4OQmWLKAFMwXHYroxNeIJxyXRcAVFp1UP/uJCeKqTYCC9HwNlMRZTqGeXkmd3Csw1/b6e8hTHKAmX2p//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6672.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:05:00 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:04:59 +0000
Date: Mon, 10 Nov 2025 21:04:55 -0500
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
Message-ID: <tmmraksbs6ollwmp3amhdqfajvenjhtxraeywyq3smvmsqydpj@dmvrbkiai5cd>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-7-pmladek@suse.com>
 <kubk2a4ydmja45dfnwxkkhpdbov27m6errnenc6eljbgdmidzl@is24eqefukit>
 <aRHoHMJYAhSoEh1e@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRHoHMJYAhSoEh1e@pathway.suse.cz>
X-ClientProxiedBy: BN9PR03CA0442.namprd03.prod.outlook.com
 (2603:10b6:408:113::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bfc027-65ee-4762-2d5b-08de20c6b7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGR5RGlNNk1kYzl1c2RWLzU2V1BDNFBZUmIralNGM29hYS9kWllBLzM5OFVC?=
 =?utf-8?B?UE0zd0tZTkY3djZqL2xRb0ZsdDNuQ3lFWHh1RmZUN0cxL2d3dmdldlJPT3Vk?=
 =?utf-8?B?U05ZaUV5bllwaHloYzRNOHJlRzNCZk55QUtpMXo0b2Y2K2VvRHI5SWxiS3NS?=
 =?utf-8?B?STMzTU5nMmJ3dThKd2E0SGZjQ0pHZXMrN3pYdTNrZnBCMTFadmMrVEhzSXhn?=
 =?utf-8?B?YjZFRVgydmx6bFFOckE3S1ZMNVJ1SGNkZERMZVpIakRBcEo0WDgwOWlMK1VW?=
 =?utf-8?B?MkhNTXVHQ3BWTE1VTkwrc3hKVkJZcWNKN0tVc202bFVoK3VLcXIyd1VHWnRE?=
 =?utf-8?B?NjZ2SUd6TXF3UUdNcng5VjRNaEhKMEZyMFdjS09xR3h5cjFBQlVlMXd2Zi9l?=
 =?utf-8?B?VU1DSnhYSk1haVhkRi9vZFVSbndlOXgvMDhpRmhhY29nK2Nmdkl4MTNVMWxi?=
 =?utf-8?B?b3pKb2RESXIwdVhZUzJWY1FmKzdKWGVOWjJTS0lkTzF5SEFteVR6a0JqMitK?=
 =?utf-8?B?RWd1MXRnTXNoRmtXN0oyMHlIYVViRVZlWHJod0NmeGpiOFhDUDdjS0hpSGls?=
 =?utf-8?B?Q0U2MGRVMjJ6Sm5QemUzNytPdmlyUWlhMk03dXhON1dUcDFGa0laYTlNd1JI?=
 =?utf-8?B?Rk1OMS9sc2lGNGZFTEJpQUxCZGUzdW5pb051Q0s3cGNqZitQSFdrbjFvQnN0?=
 =?utf-8?B?STNKSzhDNFRvcENnVSsxNlQwaEFZbFhUN0VxT2VaNWxULzBCS29OWVlTNDBU?=
 =?utf-8?B?Y1cvUWxUSEZUaW83MG9oWWVHS3JxVG9NYm5mUlN6KzdvZDQ2dlRVTDk5NjJq?=
 =?utf-8?B?dWp6cnZjRFhMS3gvWmx5dUlvK0hUNVJLQ1Q3MU42TUVLY2UyYmMyWm42cUd5?=
 =?utf-8?B?Q1N2akFTMUhjL25tTmtrNlZtUy9GbWxmaWNRbTRFRDdvcXdFdEErQ1JZdjd0?=
 =?utf-8?B?S0R1Tkt5NG05dE81a0pYU1lXcHhKdHh4c1dkaFBWTjNhNDVTRlFncWVrb2l0?=
 =?utf-8?B?TWJZVmEyNytwbDIrOVN0dTBoVWpTRExmTjFUZWkrcklodnQ5cUdDL1JJRWxl?=
 =?utf-8?B?bTlwcHR0UmFKbWRrTTU3bm54VmQvMmV5ekVrSS9ZSnFKQjdXUlpBMFFuTTcv?=
 =?utf-8?B?VDRsUXNsS0xKQ1U1cjBPTU9JL3ZlY0JyWFVSREJSKzVCVW5WQzhuMTRKSDJj?=
 =?utf-8?B?bUF4ZXAzTzhjYTRCMlNFdjh3L2hxdUNHS1lLRW5rOFBXdmFHWmdqa3FUdVNE?=
 =?utf-8?B?SFNzSE5teTREUlJvSGhKcUtPc3F3cW5jVEtoWk43WkdGOENNaHRDR0lOQ3Vw?=
 =?utf-8?B?bTMwZS9zZjBnV25BV044TDZsY3RURkxyTGkwQUxYeCsyaEZPV0ZHS21YcVJT?=
 =?utf-8?B?KzhQc3A2Wm9GL2NJTXo2eHFtbk16V1FWNG5hZ1Z4d0pxVE5Da0FPZWxXSHh0?=
 =?utf-8?B?NnUrZkVBNTlhWXdndmhXL3gyOUgrNUdPYmxweHVQWTlvTU03cVlHLzRHZmNh?=
 =?utf-8?B?SGFueHU3dHJSK3VRWlJnZU5qdlhRWFdHZFh0UEIwTmFHcEhPOUVRM1QwNFFU?=
 =?utf-8?B?ZmFxa25rTVNWRk5MQVhncjJPYk54UWFGTE1zTm8rOTI2RnpQVHVyeVdGOVdz?=
 =?utf-8?B?ZkVPcDRFTGpDWGFkeGhlYmJuWG1RdS8zWmpBWmFNQi9Jblc4R2VpVXpnVmRa?=
 =?utf-8?B?aG1IU0R1bkQ0b2JYTURnRnQ1RnRpTFJvN2gxUWh1RU1FWU0zTzZWU2d6a2s2?=
 =?utf-8?B?TFd5VUVyOEVTMVdKTFhwTGpxQXB5OS9sblljUlRuQ29WdzJmYTNNc2RtaWVy?=
 =?utf-8?B?UXNmVGxPazd0RmhXOHVFTDZ3anRhSUxVWFhYTVl1V0tiQ3VnTEMzYzRyVVY1?=
 =?utf-8?B?cS9TcVNrTmU1WVZGT1pBdElXQlcyVlJhaHlRTU1nVkU2c1ROelRNTFo3OWxV?=
 =?utf-8?Q?rLFW131urDJfhbHBflNsqrZgy1mJkspN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTNZMjNSNThVcks4UmJIVWMyRVVFM2tLQUplaFpZMXFISndHWmNpYXJidmxM?=
 =?utf-8?B?YmxlVjQwZGViUWFHTWp3U01wS1p0QUxFUFlSTHpDU294akV6VVRta3gzRHl1?=
 =?utf-8?B?ZldRcVJBUVVmelRuN1kxclgxZHZIVG5vQlZyNnltNDhFSkhVYmdSZ3NyVDls?=
 =?utf-8?B?THlYdlRSMmNMb3ovdjJ6ZmZtRkRLWCtkNmhicmhBdDMreU41WURWaFg3OGsv?=
 =?utf-8?B?UkUrY3NHcUFiRHEzVXVnWHEvanlhMlMxaFlLaW1ZWU04NGcxUXE3TzhtMWx2?=
 =?utf-8?B?a0cyZzVhWENsdVZUa2xvdFFtVlAyMnJIakdkV25kbFN5TjgxUEhEODVYWGls?=
 =?utf-8?B?TitrazRzOGpuOGY3TnBib2tBZit2WnQ3eHdrV2JRWUdlYkNOejM3M3JxV3dN?=
 =?utf-8?B?eEI0c3NHVTJCOXA4YXBlQVhNSG1SOGZkT3FDWmxLV3Foa2U2QTc5L3oydlBL?=
 =?utf-8?B?amhabGRNUktMeDBvcUhhUGp4MmRCY2hGVlp3MWkxdmFGSjBZdkV6UWwzczNj?=
 =?utf-8?B?YkZySW5MaW9ab3RCMDBxTEN5TGxFRW5rMC9KWnkrRFphTUdUQWNPNElGZUhP?=
 =?utf-8?B?bHVBQXpScXg1NWFqeWF4eDA0bjZPd05IZDdXU2tPMnlLZ0lqakEra0RnY2JJ?=
 =?utf-8?B?ZjJXdEl1R1AxRGxReWRKbnFFdm8xMWRUQXErYXU4ME1tVFZNZzVTNUI4NGNm?=
 =?utf-8?B?bHpqeVZNSGsxRmRBV09Ba3JmMzZLWXZOeTV5akphU2FqMjV0VVR2T3dlSitI?=
 =?utf-8?B?ZnNKUFFLUGZOdzBsVjhiMTRWd21SUjNCNlUxMzJWdE1KMmVRNW1TRml2SFYw?=
 =?utf-8?B?NDB1bnRaMXZKbzM5QTlLd0NvcThqRit3cGRYRnhNcktwWUZ6YW9MTzlEb1hq?=
 =?utf-8?B?aGRUUG84VzluY3h0MFlLVWFoNE1NVXc1WnNiU09lOTVsdG5UYzhPY0h6eGZS?=
 =?utf-8?B?cVQ4a05jY1A4bDBKNzNTTXN5dzNnbDVnZmtKd093dTRYTEV1M2tOcXg0WmVh?=
 =?utf-8?B?UE44akhIUk1QRUNSNVI5V0NzMWUwR0s5LzBSSllDcFhuN2FyWnBSVjVnUU8v?=
 =?utf-8?B?VVdwYXFEWE12MExoS1ZYemtxaGpXT2MxNnp6THBXRzM3ekg2bUtkUVZPRVZS?=
 =?utf-8?B?Z1N6a2ZaU1ZZWHVpT1Z3Q3BGc3lLSDJsR2NHZS9sSHpkSE1DNmJQVWQ2L1hV?=
 =?utf-8?B?eVRYZEhLeC8ySC9hekRBSkhMemZVcGVkNUtZY2dULzRWWnQ4cFlVQWFGVDVz?=
 =?utf-8?B?VXRIYmJmTkJZRWV0Uk1Na0FGWDJ4bHBXT3FxazV5K21OWnNYeDNGVW91Si9P?=
 =?utf-8?B?TFVNZGxocThhSmdoRXp4MHdTZUxWWjBGeTNlOFppWkJXK1BKeFBzVGVsQkl4?=
 =?utf-8?B?RWFmN3MyOGNsMWhVdGpmdUFIb2k2SmNkTUJMZ0xGamRNZTdHTWUzVEpOSXQ1?=
 =?utf-8?B?ZFdYRHRyWVFrYktGeFk4K2dGd0l5WjEzWUtCQ3Uvdno1Y0xENkJXMFkyRlZq?=
 =?utf-8?B?aEpHSDEyM0JyUFB6OG54RERaWCtZNmtWNFV4amtKMlp5bUt0aWQvRWxSOTNj?=
 =?utf-8?B?MlVBam9TTDBYNkVyM1E5U1ViYlRQVGdsSSsvaVMyWG9MMjl6ZVo4OVhNeEs0?=
 =?utf-8?B?S012MVFzQi9tWVNyTVRGMHZ1Q0wrVlVFRWM2Z1ZKU1VCYnRMTVFuWmFUMWpR?=
 =?utf-8?B?MWI0NXd3Y3pCcCtSVk9rOURsbkFwNWx4bWtIVk05M2lOVzFOaFhJbXFyZjcx?=
 =?utf-8?B?RmRlY010dmQvTUNtaXoyL0pwOFZ4b2xYTHE5dTBTUWsycm0wbFBLSG5LWGxt?=
 =?utf-8?B?bWdGbHhVUTN5UlNhYjUwRlRuWmRERWUvU2RaQ0h2ay9FRTQ4cEdiK3g4RXht?=
 =?utf-8?B?WDJBVjFnc00zR2RiWWhXK0VYcllISUFpSElqR1ZobTFFbkd6WUQvcHJLcFg4?=
 =?utf-8?B?bi9xTGM0UzVhRDY2QmZ0dW14SWdSTEFvcXFnZjlUTThXU09MbkNpeHZvdUh4?=
 =?utf-8?B?d3Faa0VDWExiUGoycjNSYlZhWW9DVExhbzNhczBNYjNCbXF5RjhCOHk3bmFF?=
 =?utf-8?B?YVpHWFRkejI5QisrOENVL0YzdmNma3FFbFdVMzczYVMyMGFjSnlJSEwwVU53?=
 =?utf-8?Q?sjDHQHF31QCG+87je8uzT18j4?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bfc027-65ee-4762-2d5b-08de20c6b7ff
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 02:04:59.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FAWXk+WYX+DigBbbCmbKsHYJKAbDgoT1j564rM8PMPdfjm5Q+kpV+nlzIahWvf4CC678SgG+YBy4YrQWD/EzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6672

On Mon, Nov 10, 2025 at 02:26:52PM +0100, Petr Mladek wrote:
> > Hi Petr,
> > 
> > If I am not mistaken, this is handled safely within the context of
> > module_address_lookup() since f01369239293e ("module: Use RCU in
> > find_kallsyms_symbol()."), no?
> 
> The above mention commit fixed an API which is looking only for
> the symbol name. It seems to be used, for example, in kprobe
> or ftrace code.
> 
> This patch is fixing another API which is used in vsprintf() for
> printing backtraces. It looks for more information: symbol name,
> module name, and buildid. It needs its own RCU read protection.

Hi Petr,

I see and agree.

-- 
Aaron Tomlin

