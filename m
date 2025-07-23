Return-Path: <bpf+bounces-64177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A26B0F6BF
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DFB1892EFE
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C82EAB90;
	Wed, 23 Jul 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dxypxNw6"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2122.outbound.protection.outlook.com [40.107.116.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C52E6112;
	Wed, 23 Jul 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283367; cv=fail; b=aw9LLvwkR0DaPPZhzNjjmdJs9W5TOouYb1dT1edm6JvnlzGl+pL08Pb+agLAC4OYKOxqfX6uj4HkgOgU7WS+rXIzCHGLLZQLddrA66WZjRfnUyRJYYKhqRyUNQDn2VPZyus4TiQqtyUxm6Ie6hfbvBZCmPCHa94gUkhMBTN3G7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283367; c=relaxed/simple;
	bh=hslzg7nuTCTJOH45ZEekUQu/Nv/DwmlWUP7/SUc+bz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YeAF490xRLCAuLq5ba5cT0fV5OVVm7r+1zqLsVRPFspawmJAcauVTECsOxA2O6WyfhurvmaloyMNiX0ptB0zmQudypY+5sfunIPUVtVO6hHpPiqd1Oad52AEJASWI5zNJy/eBw4N/y6Pj4ilY3WCxlvl5N30/LLISPFhnWAcJ24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=dxypxNw6; arc=fail smtp.client-ip=40.107.116.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6DaPMKOkQVehf9tO17BhBP8oSsxqy9ZKUjkD3JAYL5VXGFPQVBl5bD3sDPw6XgLdTBJndS2VlksTIO2kHDuJQ8aZ69cJhK70FjecLnjJ6XX9lEx6mvb9uIBMm0dAUWerRkKvqBir0TeAY1YKqY9yk33idyFNDY5l4DYfS3uUDyHtGVN1F9yzHZmdjFxFg5k35yrwSARexhJF0AFVCiI9ODLeHHKL+Jji+6SR26Pay1vzYdklbh9oBsvx3PD3EeNL4RzhXIccqzmW6N93h24lLdF5uxd3V8qSJ/r7qDDwfaBPY/VF/ysoYq+27D+73hdhjjGe8tZxgiaxMr1YBWYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmU7m46tbLmC08nwE1yRjKyN89eweTSFWvysc+dcx3Q=;
 b=SyiUcuZyXozrTvWmSeyUOSAnmuZSCOuRy4FscIE5FdLPzHrMWFZE6FvtDaNjHTiq0Z+G7QLtUTz3xOb1mvhvfjet9rVT6wCu1tqj1ArPp1TxTfGoSd1QI5wPnfoUMy9xb6Mv6XgIjDJPraEKeb0A9a2Cd5kDzXb1ydgnnuW70O2l+X+9z6yuzRDUzLZd6ZwmaVBtxDquRwIWmuQpMQGdd4kth5SQR8+xYGWxg7Eeejs7vG1lYZr33PB5q87OhCfuzdG1r1FvKxig0hqxEi5N39k7YL9qOxNAishQHV5nNvmp3Yh/k9YPhDpL2+HC3wehNRpVQtZ2HqZwF5vhXHnBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmU7m46tbLmC08nwE1yRjKyN89eweTSFWvysc+dcx3Q=;
 b=dxypxNw6xiUsIrerMmRgdPMHxxq3a2TNL0PG7XyioUIlvkqu46QZVaZxifC/D55fFspkjq87XoqFGXzrLtNG/8aUYncH9kuWBwn8qeUZdGOor/NLeXLV4K+/pLHn6SEUQB9TxsTPwH94eaxD0wIRq/C1tnh3Rj/GrlmqGzppvuX4Qk4MqjZDHqGQKeEdG4tlW0hnFNbb0shEmp6q2vha3Cyw+L8Bt02xpYEeXHupmCSC8qTeRZTZMzIah5mLl/G6nbRU4CFbG3kNV0PednqKpo3G1j6JezOQ9ZWa20TWDVnPvRh9tDHyRTaxmWY9zyPspsAJ1CoUsz7mBnI1vE+TgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8279.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 15:09:23 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 15:09:23 +0000
Message-ID: <9aabd05c-5769-41fc-a825-e6c6866d9fe4@efficios.com>
Date: Wed, 23 Jul 2025 11:09:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New codectl(2) system call for sframe registration
To: Steven Rostedt <rostedt@goodmis.org>, Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Brian Robbins <brianrob@microsoft.com>,
 Elena Zannoni <elena.zannoni@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
 <20250721145343.5d9b0f80@gandalf.local.home>
 <e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
 <20250721171559.53ea892f@gandalf.local.home>
 <1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
 <20250722122538.6ce25ca2@batman.local.home> <87jz40hx5c.fsf@gnu.org>
 <20250722151759.616bd551@batman.local.home>
 <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
 <20250722171310.0793614c@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250722171310.0793614c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::21)
 To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: baa3b1dc-0c5e-492c-2593-08ddc9fae7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVCRVZWV2t0bnZXR25JV0pybnZ1Z0xSaG45TUxldDYxSzg2bTBqYTVUc1hh?=
 =?utf-8?B?aXRKc1owUXdNeUJ3emJKR1NLUGpYNDlRcEJKd2hwYkJtMUEyMUZvT0hDMWVE?=
 =?utf-8?B?d3BuejdpdHVwZktTUVgxRUp3MTZRYm5WNXQwNXZRaXBWYlhWQURUQzk4cWFh?=
 =?utf-8?B?SkxTbi9GZFpKVE5qSWp0cG1vV3l4OThaR1hTbGYzV1JiZFJqbGNpRElmY0ww?=
 =?utf-8?B?RVUrcVJpeXhSTWg2T1NiSFlESmNtRG9WWHNJSEtzdmlWRVdodjRibnZGdHp6?=
 =?utf-8?B?bi9OWjlveFRkcERMK2J5bUJPbzhaMS9PWjNwd0NOSmRvK3Vld3k1V1N1a2tQ?=
 =?utf-8?B?MnlrOU1oYThJWVFJSFI0Q080ejNmQkVjV3kwd1VvY1NmcGpXY1YwMmZLUENJ?=
 =?utf-8?B?aEk5L2x5WEZyZ0lJck1hMVVneTZrYnFmbllJazNIZi9MUFJ3N21nN3NLSmZo?=
 =?utf-8?B?eTMzTjRhQnE5ZnQ4aXQ1OGR2dTd5ay9WdVpFcTFjTys3Wk1mcW9naDdYVGhO?=
 =?utf-8?B?RlVQSDRjUWpmdnc0Z2F2NytNY3JJUUhVYWNrbHBrODRUdzhFbmJ0MDNIbUhq?=
 =?utf-8?B?d3ZZdk9wMTMrdU4yeGlEaXMzKzFGbTNVbERXbHRjWUtBMUJaTzEzdGxycXNY?=
 =?utf-8?B?TitlS2dmY3ptaWhGT2ZCejVBZTU2U1JzZXIrU0pFQlBaZlcxR3BsQld4Q3I4?=
 =?utf-8?B?Qkd5dG9CbEYwZ1JYQTRxMnJjRVloczR1Qk42Njg3cFlKSTlHQXA2dVRKeHJ0?=
 =?utf-8?B?YnFuVWJPRU5BUS91TGhMb3AycXFUTDBVTHFhU044dWRVOCtDb01MS2hJNlMx?=
 =?utf-8?B?TzhNMlJmSm16Y0RSWG9IWDVJWnROYmprRld1WXNtNFp6WmlEbDZSR0RoM2pp?=
 =?utf-8?B?d0gzRzFmSzl6TTlSV0NWbG82ektFTWlUVDY2bGRKcUFjTWdlZExDaVE3dEtp?=
 =?utf-8?B?UnBFR2hrZjBKelJMa0F2UzBRVElqSWM2Vk9UZS9VMGdxNU9vajRwUHo1Z2Z5?=
 =?utf-8?B?RGRDdHIwbWMxM2FONDNGWnpJMEpNYVRlQWc0dDMrc1k3T2F4U3VHWmwwRTFv?=
 =?utf-8?B?ZTBQWit3bG8wSjNnUjkrcEIzdHUyUEc0a1RXUkNQUWJXTDJKL0ZyM2c1cmtZ?=
 =?utf-8?B?WWRUTHQvMCtRVFVQSHNIZkU2dHA0VDErek9tRzB0cGI2bVBvT3M5aWpZcG54?=
 =?utf-8?B?MFA4SkY0TkF5NHl2WUJ3bC9sbjI1SXJwREg1ZzFHNGd5aWZscWdnNU0rbnpo?=
 =?utf-8?B?R0pLa3lBWVBzL1RmVVgyRTM5R3Q2V3dXOURYU0NDeThYL1BpR1R5bTRzaE1a?=
 =?utf-8?B?Z0R1eHNGYnJyMzgyUG1uMzVMOFlkMXMyNVpueEVGVjliRDVrZWxrcHlmd1Ra?=
 =?utf-8?B?TkZVMDZyUURVeGIrVi9aTER1aWN0M1U1RVJaNlh2dU4zM1hVRkhtbWVWRDJI?=
 =?utf-8?B?dFMydXRDTmxoOFNPSCtQTCtMR2dnMGtWdkxtQ1hJSmhkNDIrUncwcUNneG8y?=
 =?utf-8?B?L2pZdnAzQklZVW92WE9FRy9CMWFGd0I5ODdQLzVFNm5UVE0vdmpXN25hQVlM?=
 =?utf-8?B?N1ZGN3JpaFY4bDIxMkdIWnk2dDNESlRNNlFTcXBBVVcxcEY5Lzg3ZHlOSFF4?=
 =?utf-8?B?c3o4eUxMcXB6K2R3M1ZKSXRHTFAwMWovMUJlRVBEcWttMHljbnJwWDA1N3RN?=
 =?utf-8?B?YnllaGZRTHJnakE3MklWTExtZzUzb2NRK0F5ZlQ1Y2dKd0hzbkpOcE4wbDMr?=
 =?utf-8?B?TFIxaGJuczNrTmlRV3diODNTM0c4UzIwZDZReCs1S1BhM3JzQXhNVG91aEhx?=
 =?utf-8?Q?TUnNFSlyhq8iC7aS+ce8qCv+0wJtqbEFDj8iM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wkl4L3RLeDAwUHVpR2NsdWFadENRUWlUZnRDeHZ2Q0JoQk1xbk1CWnlZeXk4?=
 =?utf-8?B?MVl1THZpdU4wMU9KZmlVbUVvS1Y1azE4bEpSQWtvSHU1SHFINGZaYmxFd0NZ?=
 =?utf-8?B?dnpzTGpySWo2MU5tbEhqRGh6dW5LSjNYZzlnSk9KTGJFOU1INTZ6ZjlVRHJV?=
 =?utf-8?B?MTI1bGtvWWdFTm9iMkR2cldoMDZXRXhmMlNmMmZBV0docDJnZ29qcGFDeG9t?=
 =?utf-8?B?SlFsaEtYM3hFMWN0eCtKaHd5UzQwTnJMRUQvSGtEOVdHWVh1RGMweXRDc09n?=
 =?utf-8?B?NDAxZjhIRERYcEl3TVNMb2UyWUVrQ0NKaFpxQlNHQStRdlBIUEdUT1FWT1ky?=
 =?utf-8?B?UGR5bkFaNnpTUi8vZDZuME0wZkNHUkJEVXJ5YkJzenhDbUtldWw3NVVpZ1Jr?=
 =?utf-8?B?NTE0VTF5THJWd2x3VUhoUisrZXQybk1IMnErQjMyN2RmVzhUdU1uQS9taWhG?=
 =?utf-8?B?dHdsRWxYVnNlZStTWjhMNUU1RnRiK2dEZCsrQm1yYVNtV0F1eFUxVUk0NGxR?=
 =?utf-8?B?elB6VnBIc3M1R0FSQzZxVUY4eUV1WHIwMXdtaVAvZVZXL1NraUpXYlJSRVll?=
 =?utf-8?B?eDlBQ1R6VWFpdHJEbFJsZDlFSG1FTngwNFRSSFJuckhBMEx4ODRaSVJQZnBt?=
 =?utf-8?B?d0lsemw3WFE2TUlGN2JyRTYySmRqTjZHMXNOODNvKzdDcEtMOHd4WmxSbDZk?=
 =?utf-8?B?ZWRYaVVJaSs0OVNKeTdWSk1WWTFzdHNpaXlrZXdnamZCVXp2dVBpTWlkSU9I?=
 =?utf-8?B?UExmSUFWR2Mxc2w1d2xzUVlxTGxIeHMySGwydFJURGxJVFNvM3lUcWc1ZTJs?=
 =?utf-8?B?VTJNcitRd3hrTnF3UXNYeDZiaHVrVEVCSVZ4cFp5Y251Y29ma3J1K3lzU1Jj?=
 =?utf-8?B?S1lSU28rMFEzQ0dsMHhGNDAyMTh3MXVocTMvTURxWDRxSHZNTjI0NTFwbkVX?=
 =?utf-8?B?K0tSa0ZVYU45RWxuTnpGb1ZMTFpKZDJaWmNZZXJxMTJyeFpwTjlNdnhhek5n?=
 =?utf-8?B?ZkVSWHUzS1hvOWdXdnd5bFB0NnMwRGJ2dURDT0FaQTM1TFgwdFRSaFNkbklC?=
 =?utf-8?B?c0cxUm1KSFlNOEpLb1VhcGxqbXBJUTZ3ZnFZMHJOYm9Ob0tJSmlPSGdxaGFt?=
 =?utf-8?B?VHhUSVJVVlZiS2hYTDJ1Vjd6ZWhZT3RuQy9pcWFTY1BGVlZQQWtUOEZ4VUFh?=
 =?utf-8?B?TEtzNzYyU3dlZHk1OEd4NDA3aGg2Q3NDb3RSdEhncFVlc0l6cGwxSmlEZTls?=
 =?utf-8?B?c1lIMzI0LzlVNlV0eVBSWWtSUDJSSnpYWnBiNzJIZUNQQlEvTFpBNmJaeDdQ?=
 =?utf-8?B?M05IY1hJWm9wZm1HaUxMazEzaFZ1clN0bWJ4R3JSWTByZWliL21iTk1rTXVT?=
 =?utf-8?B?NDVvdDdyMUI2S1pJb3VmVWJiMkRIekFaMFNpUGN2NWJmUVh0cWoyc1E1ZThs?=
 =?utf-8?B?RWs2MjdqaE5oZ0poQVVtSnVaZ3hQdll0dW1aOHRiYndKT2UrUE1KczhsYXZE?=
 =?utf-8?B?TEo5VzlkU3JWWkhGaktMVjY5d21oTld4aHp2N3R0Y0w5OWFjWHJjbFR1ZmtQ?=
 =?utf-8?B?R3d0MFhWUXN3RGxuZXliMlpDcVhDNXNtTGdJd3ZPc2FKUmVSTUI1bHV2eFFE?=
 =?utf-8?B?L3Fid3BzRm9YWDBiRXpwUU9WWEZlUG9jaEF6R1cyNWw3WU43Zm5mV0RPQkNL?=
 =?utf-8?B?bGVEOXBxVFBIdTJGMlY1MldtZUFsb0Zna2tvNWduRUlEbDZmZ1BQQzdFa3dF?=
 =?utf-8?B?U0ZIMkF3TUpGbmxxdHhyUkN5a0NrcVFGZTRLUENHdmVqR1grMnI5aEkxeVZV?=
 =?utf-8?B?WjM0K2FRRjNEaGg1akhTUlUwSTg3STFzbzRZcFVwdHpGcE1FN0lCbEVnMkFm?=
 =?utf-8?B?ZmlQaGV2T2dGTjJSbTdrNGhTMlBRNGpiRWFpSXJ0b3BRZm0yVlQzUDB6VmNF?=
 =?utf-8?B?Tzc3WlFvZ2xncHBDZW9Qbm00d21jOXM4OTdUM21iVnd4c2ttd3F5V2lhekxZ?=
 =?utf-8?B?K1dRdjJITDh2azNza0c4RlhleUhJWFN2WFRGeE1vT2lta3o4VG9mRDFtTGVr?=
 =?utf-8?B?bFpSbjBDdjUwSEdrbThSYzZUZjdlU3ppVXNNd2ZXN0Y3LzhQak9aRjJ0bE81?=
 =?utf-8?B?KzBvSmtLVkIxSVdTOFBwU3dQSHZuOGs2K2ovR2dSZFhuQ0F2aXFMMitNNHU2?=
 =?utf-8?Q?mw2scbzvQ8bWzfS+1RD3Q5s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa3b1dc-0c5e-492c-2593-08ddc9fae7c7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:09:23.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0SsMneMldH4SaxGEIPPf6SN6eZSR9lYn4riOMmvNE61dt3OTOeFrRmklRHAYBHRw2oDFwmTNb96VVP9oy1OrqwqndAafffSepzFTdGICXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8279

On 2025-07-22 17:13, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 14:04:37 -0700
> Indu Bhagat <indu.bhagat@oracle.com> wrote:
> 
>> Yes and No.  The offset at which the text is loaded is _one_ part of the
>> information to "fill in the blanks".  The other part is what to do with
>> that information (text_vma) or how to relocate the SFrame section itself
>> a.k.a. the relocation entries.  To know the relocations, one will need
>> to get access to the respective relocation section, and hence access to
>> the ELF section headers.
> 
> You mean to find where in the sframe section itself that needs to be update?
> 
> OK, that makes sense. So sframes does need to still be in an ELF file for
> its own relocations and such.
> 
> It will be interesting on how to do compression and on-demand page loading.
> 
> There would need to be a table as well that will denote where in the
> decompressed pages that relocations need to be performed.

If we can find a way to express all sframe "pointers" as offsets from a
text_vma base, then there is no need for relocations. This would
minimize complexity.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

