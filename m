Return-Path: <bpf+bounces-50465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C667A28032
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50B0163237
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58821227B9D;
	Wed,  5 Feb 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z8pyDg+N"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2058.outbound.protection.outlook.com [40.92.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385679F5;
	Wed,  5 Feb 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716025; cv=fail; b=ZgnS5DPn60grrO/Vixb12n+3Mnq6NCJx4Z/EMNgNBzKUd/nK5elFIsGWsIssz9pcSa8ep+mk+ei19M38BudsfQDPU80UMdy+KpHjYyvuoq6lPxr9vrsgUV9b2wD5c5PxtaAglZvZuix5eLM/90JTIKZBZ+3NA2TnvPKPT/PCuWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716025; c=relaxed/simple;
	bh=IAROCoPDRCuTHFPZX1HUfzYQfVkZo95Er5V9/Ngtz4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYYkfOLquxpoSp5PVYvsBXs97L7tLUeNh9aXsdCBnpgwF4d/GzB/qRrtdvaxloNmYPkInfNf/PyR41LIDr4eKcuwEensW0a8I9AI8XX6Dl62O2cAKb8KTNJmFxcYZxRTTYab1jM85k80z3y0UNiPp0yMv1udiU57pgzRdV+Darw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z8pyDg+N; arc=fail smtp.client-ip=40.92.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOIda45wultgTj0nftUZI1vMK+r3+/nP8BUi4qdY30mS0ou6pwilMRNIpYc9g+fKdxSpwLkCDMww0B+P8VxJ/QxdgYZ3kGMrzMeF+NzffVZfdDVZ+FeO0b3RLei4KomK6+1WFzMdPzO8AeaX7VH/MqOmwBPXUx4wTycoptPhNbmJZXa+5t2s+b0G8apaol8zP2/sVOJ1NncUsxW0jCH3w+SL43uK31fGNsAfCQ8FrCb/MKBydl2J7VVj6UEZ6Jj3fLXC8+kJNBvWrNs051WVnShBORIhrKFNz0b7VhUj7dkktJdFuGYUpqv7v6YOfQDyFJs3itbyd5kMHZW0j6N7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opEJyGLFdW4u/LMP+C1PTy7Z7NjlA/T/E04YxcF3WFU=;
 b=rZUvmN2Gd+5N7BOZgnejm3+WOZP30aZbI95D4NXIYQT8s0zWusrvJMF3HRGLhy1+QtakEyZiczQU+AiBNAWlRHtjlyqXx1Hv6A3r50LbOa+0kd18pXhrB69cmafXlP9BDvlVEvEE/4ZHQ8RNmnypoy7s10W6qJl8wISAsz6VNDgONRtmdX5CRzTzme8odvgPrhkGSheTOX+kbU3i76MqJ5dmWWbu/4DbB1F3NkC4IgcsB8qFxtBeA9lP5UIXFTgou6Sf9R07nUfKE8DF4Jc0PJun9gYVibXlh9PJbA4b4omYde3kx+uMi5Dg+qxurxS/AmIMCEDnWMHml3xZVjsHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opEJyGLFdW4u/LMP+C1PTy7Z7NjlA/T/E04YxcF3WFU=;
 b=Z8pyDg+NYE8V2kQpuRcFxKATrREC1vRSaB6ntATWJIgTPe4FB1ckzmVcsnxu+GU+Vp1zqoqoRW0xy9cKW0q588/A+dmy3VAl12YRl3l6Gy2cGWhW0oSedS+RYhHfRqvaVtZ5/EPaQNPJqThQOJjSYlQ/B3dWOknCcmZ6ZwncPZnuZHmZHJF0Gh8xrI+b/Q/IAwuglYP4Oj7FZqs/X+MRRvPY5P+uyNAAZeGZIxFW9fODXe08vdz86zcFKbjiJgmTXdIZQJpxt8vvjiE1Eiy9fPEAacNo+30eBrX26tyW8Be+tdyQJws+2YN98eiOvyspJLeFzIwnNuEurkMPvswTvw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV1PR03MB8094.eurprd03.prod.outlook.com (2603:10a6:150:1d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 00:40:19 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 00:40:19 +0000
Message-ID:
 <AM6PR03MB508011599420DB53480E8BF799F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Wed, 5 Feb 2025 00:40:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bpf: Rethinking BPF safety, BPF open-coded iterators, and
 possible improvements (runtime protection)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLb--LzFmXZPLPa5V+cD1A9YzTnZSgno9ftcA4-GGTi8w@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQLb--LzFmXZPLPa5V+cD1A9YzTnZSgno9ftcA4-GGTi8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <44341c49-9f12-4588-83f8-1d1c05cc1cc9@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV1PR03MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: ce037012-efb1-41e3-b4b4-08dd457daa9b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|6090799003|15080799006|4302099013|3412199025|440099028|10035399004|12091999003|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3Z6a3NHVm5yTFdKSWJsYmlUQjZaSXQ0TkxDL3B0cUg0ZnJwOG80eUZoeSsv?=
 =?utf-8?B?S3dLMUJqRFkvZEpwNjFMYXBTQ3N1UU1NU1RBYmpqNWJ5dDJQZDZza0lEdzBs?=
 =?utf-8?B?TFUzTXVoTnNzV0FFWWtPeElESW5ad2tmVEJxYnQ4RStzU1R5RmRFYVljd2oy?=
 =?utf-8?B?dytaMUJxZjB1dElDM1RuNmNxRWY2T1owYnB3VnRlOHNDd090TnlKdEh0dkxh?=
 =?utf-8?B?cWxsbmZ1TCtIMGdIc2VFT296dHJhKzRLSmpwSUFJemt5MFNhTWVZcGRTMWV3?=
 =?utf-8?B?UVViN3IyelRqZjlOekJYQldneW5wZy91L2Q0U2VtUFdzbzVqVjhCOGhpdjFN?=
 =?utf-8?B?bHFrR1BvUGE1dTBhT28zVFJaM09qWXFzR0hFRVJXV3dtd2JWZHlQVkhvaEgx?=
 =?utf-8?B?YUk3UXBlT3MyTDEraDNwQmdobUZiUkprdzc1bXA4KzFZK0owbUxRSEkwd0M1?=
 =?utf-8?B?dmJweEdHZ0ozdFk1T1krMGpOb2UybjV0ZHl3dUI2dHJaTU5aVnNnN3J5dUhk?=
 =?utf-8?B?WHFIZkJCcWJueUNXOFh2cDBqMCs3MHFTcVVFaVlNVzNyeVdqZzVZU0VSSDZN?=
 =?utf-8?B?MlM4RnVYcFFQUVQ1Y2hjUFIwK3F4eEpwZ3RocSttSE5IenZ5MXV1NmRzRlgr?=
 =?utf-8?B?NVBwbHpncFBsRXdON0VBaTFsVEhGc3crNEtybTBlZHczRms2R0czMjlZL1BI?=
 =?utf-8?B?b09ZckQwdGRyN0x0Z0tvcmdwVmJmYTg3Y2MwZjZBbjZXaCtoUEpzSGUzZktj?=
 =?utf-8?B?Tkk1UWJWZUI5dG1OVzdKbk5oUnVpY0dtbUlxd1FZNmkraEdGOUVDOUlKVktj?=
 =?utf-8?B?dmhmbGM2Wjdyc3h3WCtVQndRQnNPdFdiUHVIOWkwbnJROEprUFR1MXI4Uzc3?=
 =?utf-8?B?NkdwZnlyOVRncTVONm9zcTR2OHdsNlgzNmVXZ3ZFSTk0MXk5ZVN6NVU5NHhx?=
 =?utf-8?B?dFhSaThsL1lwOEU3U1kxNy9hdktRaUo5QmFFNzhvUjRwSWN6OU56MWJHTTNy?=
 =?utf-8?B?eXlycTlDQ25ZYXl1cjNqY1ZlOGlKMVFRUXg0QWNiZlR5Q3JkcFd4NGdnMUtl?=
 =?utf-8?B?NEVEUko4T2JQRGlPU2wxWEIxZTdDbk9rNmYzTmpmK1N6TXdEbkI4MUhvWGcr?=
 =?utf-8?B?QXVLRmZMMHZ5MHhyeUJuYnE0M3VyMlFwODVqb2tuWTZFRzRPSkI2NnE1Tno0?=
 =?utf-8?B?QWRNYjNDWXhTdFBzdXhLQ25VRHl0TFFCckRDenhPaUhkMXUxUlAraEFLMlc5?=
 =?utf-8?B?SzlVRDRNdnE2UWRHaFpWRjcrNm9SN0RLdlQrSFVhTU5IVTVQa0NLMitGRjhq?=
 =?utf-8?B?dnlyekZvVHVnZlFxREUrZC9JNWZjVWd2dFVQSG4remZ4ZnJNbjlTQlVVQXJN?=
 =?utf-8?B?VnpHeG80NVB6REdCZVQwMDIzU0RUSEorcVh0KytTd1NWa2RjR1FiV1F1OXZz?=
 =?utf-8?B?ekhFdnd0b2dRRktRcnBuZnQzWTdHcU80UE1ISGl4MVI1OG45SDQxU2p0b0NM?=
 =?utf-8?B?ZE5XV2FkSGYzTWlXQTBMaEVFWkZWVldTSXhlYk4yR0g0aG4zR290L1lZdzlF?=
 =?utf-8?B?QXdtbEJpWmdVazVSQmp0aXVpZTJyU3lzLzdrVi9YZzB2ZGdqL0R0cXJ5OGhs?=
 =?utf-8?B?T0d6RVNuaHJ3c0FpSXNCeExab1lNTmJTc2dwQ1hxcTQyN3VWdEF1Yml6YnpS?=
 =?utf-8?Q?/ExL9je2BklJXQ1Qwjdc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXovOEZsTkJlSDBPa0NlL3gyTFpmUCtORWFWMzE5UWoxcWQyMXEwSTVua3li?=
 =?utf-8?B?TGxjSUx5Wk5WaC9zbGVnS0QxejhVK3JEMkpRQVJvajRvNHZCTlZDTW9DeWRE?=
 =?utf-8?B?ZU04R3NJQnlnNnh2TkpzVTNSU3FYQU51amlQdUthYktNVWdDVEdqU0MwQmJ2?=
 =?utf-8?B?dUYvNHhjcmJwcWlnVk1YZ1ZlOUhTSm1zY1JlWThmQ0Q5OWlRdzRLMmdNZC9U?=
 =?utf-8?B?cXF4ZHY0U2pyZHF1bEwzdTBOVFFuTW1qRVNuZHZHNzQwbmQzQXNBMmJvQUk4?=
 =?utf-8?B?K2ZQVllaZHhRSHVEK1dVN1dCZHc3OEtHMTd0NmwxY2pVaU1EN09iZDFiNEFS?=
 =?utf-8?B?OEJYT1Y2enA0Y1JyS21wSjNMTFFwb1E2bTZuRlR0TmVuMy9mdjdjWVpVWG5s?=
 =?utf-8?B?WnByL3pBcjMxT0NaS3FLRHRtZ3lRYnlCVUo0bFkrNW44eHc4UWlBSU8zOTZm?=
 =?utf-8?B?S0Z1N08zRGpGUDlTY3gyaEJhRTlad251eG9uZXE0bFRRVnF3VnhMYkQ5TXRk?=
 =?utf-8?B?UWRRZklzT29PSUM3aTBkWEZhbEtNUFdLeEVaTFdZdE16ZHd6TWxnYk55OUtP?=
 =?utf-8?B?SmplTDZOY3E5UHdVamtiS0FKTjdabmdkT0l1VXpmc0NRZGkraXpNSlFSQW5s?=
 =?utf-8?B?UXJJZGdackloSTJhdHRvbzB3ZXpvMnF5YUlyd2lVMGpzeHgrUTlmaWpxc0dt?=
 =?utf-8?B?VzhoYjVIVWtwYTg4SjJhU1pCZERYTnN3WEJOcThsUEFQaGhpQkg4VDhzeUI3?=
 =?utf-8?B?QTI2emxRRmRSZzJwSDRJdU1RbmlpUG1hNE94YUg1V2dWcXRzdnFXT01mcTdF?=
 =?utf-8?B?ZDUxTTVYdC9hRDN5bnpxMEJWMVdqUDY5Yy9pYmRYc2xwRTFmK1RXMExTUyth?=
 =?utf-8?B?eWJhemUyVXVuUkZMWlVFZGRucU1nVnFpcmJKK0FlSmg3VG80Zk96WjI2K0tx?=
 =?utf-8?B?bnNJUGJ2dHFvWlJMc2F3OFNGK3JwaVNXZ0JMMVpnQWtCRzlpQjZQVXQrRytx?=
 =?utf-8?B?bTZMMm96SHVpR01KTEFmVUZHb01hdFFQNGlvSHFRUkU5REJWREhBVGJHZndN?=
 =?utf-8?B?TnJpQTkyWUM4bGVwNE5objhuTFJsQTBUT3hhOXNFYkxFYTBaRXVkUHdqellM?=
 =?utf-8?B?aldGc28yL1NIaDZiY0tndzdXWkNubXNIVnNDVG1GQUNLQllZenFwUFQ0RUNO?=
 =?utf-8?B?ZzZvVy9LTXNuREt3WE4zbFFvSFYrU0dEZTM2ZTJVaWpndk9ONWtVYkloS0Zm?=
 =?utf-8?B?NnBFUXE3ai9KSllPUENGR2sxTUJqTmRzOEJyb0lORDhLdGtCcTV3dDhzL2d5?=
 =?utf-8?B?N0J4QTNOOS9UZE1CQ1drMFZrNW5YZXhPQitadjNoMkd4Rk9hMmxPK2U4NzN0?=
 =?utf-8?B?QjA5L1NSU1hqdDZPWWdScVVqWkJmeGpFeWtVM041TzVmT2pVWlVuMGo3NDRy?=
 =?utf-8?B?QytnSkUwNFVjL1RTK3NFUzNkUWtPS1RaYUgxR0tCTTlKU2dtdUxkTDdHSkVV?=
 =?utf-8?B?RkhGNGtiVWp4Z0QvaUdxUnBpWlZSL2pkK1hISzNkUFdzZjVJM2JPdWdLZXU3?=
 =?utf-8?B?M0d5ZUZXUWxkbVU2N2hJQWhZcHhSWlo0WVVFMVVVL3lSSVdadmVxa3JqcllO?=
 =?utf-8?B?YUdIV0tmdHc1K0poRUloWkxEck1mN1ZEWTJPbWRaSFBoeXFnbStyUnFZbGtG?=
 =?utf-8?Q?Zwm3AxrVlhoUx/keWnCL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce037012-efb1-41e3-b4b4-08dd457daa9b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 00:40:19.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8094

On 2025/2/4 23:59, Alexei Starovoitov wrote:
> On Tue, Feb 4, 2025 at 11:35 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This discussion comes from the patch series open-coded BPF file
>> iterator, which was Nack-ed and thus ended [0].
>>
>> Thanks for the feedback from Christian, Linus, and Al, all very helpful.
>>
>> The problems encountered in this patch series may also be encountered in
>> other BPF open-coded iterators to be added in the future, or in other
>> BPF usage scenarios.
>>
>> So maybe this is a good opportunity for us to discuss all of this and
>> rethink BPF safety, BPF open coded iterators, and possible improvements.
>>
>> [0]:
>> https://lore.kernel.org/bpf/AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t
>>
>> What do we expect from BPF safety?
>> ----------------------------------
>>
>> Christian points out the important fact that BPF programs can hold
>> references for a long time and cause weird issues.
>>
>> This is an inherent flaw in BPF. Since the addition of bpf_loop and
>> BPF open-code iterators, the myth that BPF is "absolutely" safe has
>> been broken.
>>
>> The BPF verifier is a static verifier and has no way of knowing how
>> long a BPF program will actually run.
>>
>> For example, the following BPF program can freeze your computer, but
>> can pass the BPF verifier smoothly.
>>
>> SEC("raw_tp/sched_switch")
>> int BPF_PROG(on_switch)
>> {
>>          struct bpf_iter_num it;
>>          int *v;
>>          bpf_iter_num_new(&it, 0, 100000);
>>          while ((v = bpf_iter_num_next(&it))) {
>>                  struct bpf_iter_num it2;
>>                  bpf_iter_num_new(&it2, 0, 100000);
>>                  while ((v = bpf_iter_num_next(&it2))) {
>>                          bpf_printk("BPF Bomb\n");
>>                  }
>>                  bpf_iter_num_destroy(&it2);
>>          }
>>          bpf_iter_num_destroy(&it);
>>          return 0;
>> }
>>
>> This BPF program runs a huge loop at each schedule.
>>
>> bpf_iter_num_new is a common iterator that we can use in almost any
>> context, including LSM, sched-ext, tracing, etc.
>>
>> We can run large, long loops on any critical code path and freeze the
>> system, since the BPF verifier has no way of knowing how long the
>> iteration will run.
> 
> This is completely orthogonal to the issue that Christian explained.

Thanks for your reply!

Completely orthogonal? Sorry, I may have some misunderstandings.

Any more detailed explanation would be appreciated.

Always willing to learn further.

> The long runtime of *malicious* bpf progs is a known issue and
> there are wip patches to address that.
> 

Glad to know this.

Could you please share a link to the patch? I am curious how we can
fix this.

>> Then holding references or holding locks in BPF programs doesn't seem
>> to be a problem?
> 
> It's a known issue.
> 
>> This brings us back to the question at the beginning, what do we expect
>> from BPF safety?
> 
> Safety is paramount.
> 
>> What do we expect from BPF and BPF open coded iterators?
> 
> They are not special. All progs can be exploited if bad actors
> try hard enough. Including unprivileged progs like tcpdump.
> That's why unpriv is disabled by default.
> 
>> Would we expect BPF programs to have flexible access to more information
>> in the kernel?
> 
> yes, but the tracing progs must be free of side effects.
> 
>> Would we expect to have more BPF open-coded iterators allowing BPF
>> programs to iterate through various data structures in the kernel?
> 
> true, but it's nuanced.
> 
>> What are the boundaries of what we expect BPF to be able to do?
> 
> Tracing bpf progs are readonly. If they cause side effects
> they must be fixed.
> 
>> Of course, there may be risks, but maybe those risks can be solved by
>> improving BPF?
> 
> Please help by contributing patches instead of screaming "fire fire".

Yes, I am willing to help, so I included a "Possible improvements"
section.

Since I am not sure if this is a good idea, I wanted to get some rough
feedback first.

I am also working on another patch about filters that we discussed
earlier, although it still needs some time.


