Return-Path: <bpf+bounces-52810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E07A48ADC
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77F816A508
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4999271826;
	Thu, 27 Feb 2025 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F7XBIIMM"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2081.outbound.protection.outlook.com [40.92.91.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243781EB5C0;
	Thu, 27 Feb 2025 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693306; cv=fail; b=W74BzDg58P/725EbuiUnLp2RsyD967TNZlYMBQv3uG5/qU+I5xrSfCeoeGQ8Uz2OMp2IFq+WOyy7v4Nwq6GEp9Yx+nQjzoZzRFGd76nxC+owFV0vLz2CiUrUn6D9oIkjFFL7gAreqYgbaAyo3yy/kaaKH2n36ts+D3mp0TLgN/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693306; c=relaxed/simple;
	bh=kFdyQqLy9GIjBHmev7fBtmVAWWreZOxpo0EW4e8EKPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hyETJBpRlto9h7l7T7IYdYcKdWsRoaG0tdcqRCU4/fW8eyd5fKVnhX56ybeVHvb40OkW/H3IHsQs/1e+9QXLHkyL8C5uJC6Zbsg52hWQtgPNhf0SenTMCWyymAp+W/A6CdB2c9OvfOFNKXstrfj3JGwTEaTBIEHsVxOmp2vDiTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F7XBIIMM; arc=fail smtp.client-ip=40.92.91.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9LuVP+oMuvlFxId3dqusL8ERm6yuVTtxRaCHbWYgnCi8BmojDCpCDC62MKHPduv5q+QCFF7XNYbGmVWJ2wsSo5V7jN7rCYoBCVsol3jyxXPVb3Gb80KbeuawWAffXjl8xPR8+/OZL5zZ7SkCbutC+FQ3V5kp+CSZ4TrUdbLNlLHWeM/SKxmptkFcUd1KYPXxI+5KBcKXySFw1dqEpZvfd63fz9vJu1Zjn5J8FyU7MYYCWOHFJbV5HN39lYK4womI+VcmQenqFND+SfHtac3UDXoEQnaBUC7TapnxXjcOFshshjJmZWwV//Pzd+W5r8L1P+aurnldEhl9re4jv+Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPyCZMUu0hbgUwqUk9LmF8nIWqT1WaAa9a4I3dp5W2M=;
 b=jqDepE/5zN+tA2TGJ2CZm4ZkPcdLJPoyrJV6G8v8yj2mTgKm0SONsvdTcWjM0JWAkDJq5nQaJ3m+61qS7kBexm/1Cf6zMfwFc0+tBnQtdWtAlZ6cZ2mLI11eyQ9jUSSxCbLrhA0EwzlKZAmsDJZdm68OhrPBIEzQ/9yhC7Xfmkuasn39m277Bchz0TiWVmCgu2mTlevj4a+V0oC7Y/5RxpM2rm6b55udtquLnBiKHt1eQBu8IC4a/IzFXeO5AAQLl1FoFadlNMGHv2Yx1u8EUrWAHO9Z73+EULDUhH50C5PoCqGBgcmHAZPT5PIw8nxwOt4w7XYfCWkggyUrtPY4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPyCZMUu0hbgUwqUk9LmF8nIWqT1WaAa9a4I3dp5W2M=;
 b=F7XBIIMMLvDbdIhX/y91QFJsH4kQebkRDx6FdruXyNr7oeIOchraB8uMl/3ygLMKB+ClzbWCG4yjjOKE4SOTBPuWhc2iZw80vshp4n4ix3EzocjIp/JKvN5yS5DvBI6o66TmZSQvhYrec+qxrUXV86U/0i/4WtlrK38A6lZQyr85YG7imye1c/cj3YkudQvm61FKELN6M0WDFOSYnGImDLyQIfjo8WaoOiS8EOboiHGtMbTDyQ3tmjkkXo1FpWQd7oEIFcm+BVcq3eKDn73BCh/40kZq2YsW5m555tCySaGwEDAgOGuXdnIzcRNpKOOVq81ZPfu7OqUhC3iv/a47hg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GVXPR03MB10216.eurprd03.prod.outlook.com (2603:10a6:150:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 21:55:00 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 21:55:00 +0000
Message-ID:
 <AM6PR03MB508026B637117BD9E13C2F9299CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Thu, 27 Feb 2025 21:55:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
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
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
 <AM6PR03MB50802FB7A70353605235806E99C32@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+TzLc=Z_Rp-UC6s9gg5hB1byd_w7oT807z44NuKC_TxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0510.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <a525f43b-76a2-4d1c-a319-1bc8dc62144f@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GVXPR03MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: e26facbf-ded0-4f2a-5665-08dd577961c8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|15080799006|19110799003|461199028|5072599009|440099028|13041999003|3412199025|41001999003|18061999006|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVzd0dHUzVMU1hlNzV0cFNHcTR6L3hWYVJUSzZUdEZnMXc2WjZDUi9rbDhm?=
 =?utf-8?B?c0o2QTVKaFc0R3pnWjBGVGlQK0hpVU42TTJibG9wM3FiSzVzL2JZWEJEWGw2?=
 =?utf-8?B?OVFDRFcxTS9IWnpPY3ZPQVo3RXg5ZWlONE14UUVQTEp3UmRFek81S29PRGJO?=
 =?utf-8?B?OUlLZlVjY0xhSXViTWNrT3pCRFNMZDIyVnpLYWlIenA2QVo1NmhNcVpwOVpN?=
 =?utf-8?B?TzYxWXNhTWZUdXNGd1pIUjA2ZU1rNmV0RVRNWWdVcGpVT1hOeVZ5aDYvMHJR?=
 =?utf-8?B?bUdPSmRmUHU3U1ByWVJqTy8zNk82UmlvSnlMdjc1d24vTUdlZmdLbDk4clpH?=
 =?utf-8?B?RGlRaTkyeGl6VmVwVGNKRm9kdGVrVnVoWmlsMUVDL01pVE1ham5DbHdZTUJB?=
 =?utf-8?B?VnBjWXI3V2l4V1FCVjlDMmJJNW9xck05T2xiS29SRlZ5eWJTSmlNNDhpdFRq?=
 =?utf-8?B?dUNUdFJ1MW9zMDRZTXVRblY4aTJCQml2NU5SaXpCbVF1R256WW1SbGQ2Y3gy?=
 =?utf-8?B?RnlRRllrVGZtRVc0RmdaTlR0WENUWDRMa1dOdWlPR25qRWhON3M5MmxKS2Mz?=
 =?utf-8?B?cVRKTXRlYmRYSHdxTU43dHNvRGZDTTl2S3oraEIyM3ZQTWloV25tQWQzRmxD?=
 =?utf-8?B?bTZpcERnQ3orS1VhdmJxTU9GaW12NDg5a3Q4M2ZkKy82TDhjTnc5R0JETjhZ?=
 =?utf-8?B?azh3L0xFNGJ4REhQVHpRL205cUdDeVZoMCtVeDl4WkpSY0xxK3F5K0dkNk5M?=
 =?utf-8?B?RGNES0dxdVBSR3I1M0lHOW1QT3JPaWxocjFWWXBCSmNBWXY2R0ZoTXNENnFI?=
 =?utf-8?B?T1hZNmFCbTBVVnBFRE5jUFpGRGdvZTd6SkZBb2xsbWZ3VkNwemJjL0tmWlhL?=
 =?utf-8?B?WmRtTElVcmp2bGNMVmRLVkpibWRoaklCTysyZVRiZGlpalVNYXdPemRLRGZK?=
 =?utf-8?B?QTk1Mkkza2ZBSWk1NmxJVGgxZktRSkowYm54NzRhUTJrRnQ3elhsOHVhZ0dw?=
 =?utf-8?B?OFE3RXU2WStDZG1FQXlUbHB0RC9WQ2w0djhyaWJFR1lvVVlYY1l0WjQzK1Z0?=
 =?utf-8?B?TnB6VlNZdDRJd1VwSy9QUTRkbXFtRGlCRElRNlJCelAxOXJxbW1mNG5VM0R2?=
 =?utf-8?B?Vmsxc2JhUm1sK3RJcGxkeEViekFUbjV0bEh1N1hlOGIvL3hmbVY2Mk5DRVJx?=
 =?utf-8?B?V1dCUnZEM1pmMEtEZk9GSElNTFlPS2xIekJPR2tUVWFtbjhiUmJEd2tUWmps?=
 =?utf-8?B?Q3pnNFJXdkJ2QXQ1TmdnRHlHRGE4VXZOaHpkbllnWm5qR01PanVQaHA4Znlm?=
 =?utf-8?B?UXJZVGJuejFvRHNpSUhZc2RjODUzQ1NRRFZVOHplR21YTjFyUVlKMmg5NUxP?=
 =?utf-8?B?U3RQL2ZRNGQwblBxNmI3TTRyTVMvRTVQMkw5NUErQVZ6YmlEYnl0VVNxU3FP?=
 =?utf-8?B?N2trRGJNaENUK0JubTJjQUxxdzlzVkxDZ1puUHdqQ0x5alNjbHJiOS9oVlZx?=
 =?utf-8?B?VEdKMHE0aU9OOFZUQk8wejBZdXNsUDhxNmVrRDNXOVZkcE5Ub29QMzhpNDZX?=
 =?utf-8?B?bzhVdTRPNFY4bWIvbSswNWRVVS9QU2hMNE9DK3pBTW5iaFUzNnNKYlZpTEtt?=
 =?utf-8?B?cWZKMG81d2ovdjREMUh1OUJhTFJocVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTdwaTExWjcvVUMvSGZTMWd6czJEVDdodGordnF6WmlEemRiNDB6SGZGeFZa?=
 =?utf-8?B?alhSVFBReEVZYmFMbXN6aWJlZjVhc3loZXBaTFBYdWExbHpxUHlLZU15eXI3?=
 =?utf-8?B?clZzcG5KWHBQRzllWDFLaEM1bWt2RUZDWEJDOEFvelYvWG9VVDJVYmtWUUxs?=
 =?utf-8?B?SUc5dTY5MXJoTHMrN3RvdGNQRy9zMjllSXFyYmNmUmp5VjVlWmZlSno2NFU0?=
 =?utf-8?B?YkFOZnVycExVOG9XdlpCTnZaeTk2RDhUU0QrYjVPcStlcnVCUWlKeXZZS3Zq?=
 =?utf-8?B?NDVsSWtDaCs0a3pNd2xocWpGZnR2Nmt3WHR1Sm9pUkhmaGlOUGFPT3VMN2JK?=
 =?utf-8?B?bGZXUlkxcXJoMThGZkNqU1V5V2E0TmxHYXpNblhyenprc2t3VWVRZ3BmcjRX?=
 =?utf-8?B?K2lBdkZNWXJ6dzlDTEEwUFBPbHJtVGJlVkdta0FzTHEzQm9ZSXQ0a0JwNnRm?=
 =?utf-8?B?c0k3ZEQzK0NiTnpGQkVxOTU1MVJ0eVVVVDhVa0NkNVJDMldFcXRwNnNZSkNP?=
 =?utf-8?B?RXloWUs0RlVTcitleW0wNy85a2Y5aUNEbURlL0NuSFVuU3NHMUpLZ2pXZzQ5?=
 =?utf-8?B?UExTanpkcHZYWUFXaDRJa2hSMXcyQUJrUzJ6MWNlNnhXTitzc2lQaVNrdURl?=
 =?utf-8?B?c1VZL29FRkZpVlRPUHByU0laSGROOVNWcW1MNEtyanhRbjcyQWsycjlTMlUx?=
 =?utf-8?B?VHl5YXVsSWk3eU9tc3A2OEtieUh5U2JOVDZBd25IUE1oc29XdnVMaVdKTkRz?=
 =?utf-8?B?d3FvMmlHRXdsaTNPdnJvRDhGd2V3MHRGTmg4dlc0blhOSVVSdDRnTGcweEsz?=
 =?utf-8?B?V3doWTA4SGh4M3ZhN2ZTZEV6Ymk1RW9ETWNCa3BoU0RyaWNzYk5UNTQ4NTFO?=
 =?utf-8?B?ZEoyVjRBS1FzQkF1bnJFSjNjdlZFRzVxdEhEbVpYVUIrSXV2SlpuTUNaOEht?=
 =?utf-8?B?Q0NLeXhzSEIyclpQM2FkRTdINGdSc2xOR0RneDJ5WnkyZkFNL3Nkck5qUGFv?=
 =?utf-8?B?YStiZDhMdkhqSFMraGpQcFNsQm5OMG9mRXQxVXN4L081WnlRcURVWUdyWldI?=
 =?utf-8?B?QXpZNHZlVko4YkhUUDhtNjh2dG1lUis4WW4zcWJLKzJyQnZMVFpLQjdybnhP?=
 =?utf-8?B?NjdRU01JeGN3M2JzbHRUMXI0OURidWJTTFZaT2Uyb0hJYkJWM2twNmplYkpG?=
 =?utf-8?B?MFBMVlpZRGFBQldGUG5NeEFRWWQxTjR4WjdzK2J6MENJYXNxbk1yNndwNUdK?=
 =?utf-8?B?SE16eFdkY2ZRdlZtZ21rQmhJWC9DWFVzZXh3ZXd1TFFLblpNSHNSNXUxV3BF?=
 =?utf-8?B?d2Fkbm1XTEoyUys0K25TTDBuTlc5N1pCSi9rWU1yTThXQkhhWDdFK3RHVDVx?=
 =?utf-8?B?TlVibkFXSEdoa1VQQVhhS2FSd1pUalEybzIvZEJlRC9qUks2dTk5QXNyZWM0?=
 =?utf-8?B?SEFIZFppdjRITE5DUzdreXVXVThsem96VDduaWg4OTMwMGlYU21kbFViV0I3?=
 =?utf-8?B?SjlTWnF5azd5dWcwV05GZFZjbzJTdS8rM2VwaXhFM0hkVmV6MkU0QnNjcmlu?=
 =?utf-8?B?aUIyVk1UbVFHM0VocWU4dkY3blRVT1ZMWFNMK2xHekllWGQzaVFCY2pYTzhN?=
 =?utf-8?B?UjNKSTNjYWliRlFTNzgwWFE3d0s0NWRRNE9TLzdVNHhGVmRFZmpROWFOSWhV?=
 =?utf-8?Q?Ud7B3ExkHSX674BUpjdH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26facbf-ded0-4f2a-5665-08dd577961c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 21:55:00.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10216

On 2025/2/26 01:57, Alexei Starovoitov wrote:
> On Tue, Feb 25, 2025 at 3:34 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2025/2/25 22:12, Alexei Starovoitov wrote:
>>> On Thu, Feb 13, 2025 at 4:36 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> +void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
>>>> +                              void *arg4, void *arg5, void *arg6 /* kfunc addr */)
>>>> +{
>>>> +       struct btf_struct_kfunc *struct_kfunc, dummy_key;
>>>> +       struct btf_struct_kfunc_tab *tab;
>>>> +       struct bpf_run_ctx *bpf_ctx;
>>>> +       struct bpf_ref_node *node;
>>>> +       bpf_kfunc_t kfunc;
>>>> +       struct btf *btf;
>>>> +       void *kfunc_ret;
>>>> +
>>>> +       kfunc = (bpf_kfunc_t)arg6;
>>>> +       kfunc_ret = kfunc(arg1, arg2, arg3, arg4, arg5);
>>>> +
>>>> +       if (!kfunc_ret)
>>>> +               return kfunc_ret;
>>>> +
>>>> +       bpf_ctx = current->bpf_ctx;
>>>> +       btf = bpf_get_btf_vmlinux();
>>>> +
>>>> +       tab = btf->acquire_kfunc_tab;
>>>> +       if (!tab)
>>>> +               return kfunc_ret;
>>>> +
>>>> +       dummy_key.kfunc_addr = (unsigned long)arg6;
>>>> +       struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
>>>> +                              sizeof(struct btf_struct_kfunc),
>>>> +                              btf_kfunc_addr_cmp_func);
>>>> +
>>>> +       node = list_first_entry(&bpf_ctx->free_ref_list, struct bpf_ref_node, lnode);
>>>> +       node->obj_addr = (unsigned long)kfunc_ret;
>>>> +       node->struct_btf_id = struct_kfunc->struct_btf_id;
>>>> +
>>>> +       list_del(&node->lnode);
>>>> +       hash_add(bpf_ctx->active_ref_list, &node->hnode, node->obj_addr);
>>>> +
>>>> +       pr_info("bpf prog acquire obj addr = %lx, btf id = %d\n",
>>>> +               node->obj_addr, node->struct_btf_id);
>>>> +       print_bpf_active_refs();
>>>> +
>>>> +       return kfunc_ret;
>>>> +}
>>>> +
>>>> +void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
>>>> +                             void *arg4, void *arg5, void *arg6 /* kfunc addr */)
>>>> +{
>>>> +       struct bpf_run_ctx *bpf_ctx;
>>>> +       struct bpf_ref_node *node;
>>>> +       bpf_kfunc_t kfunc;
>>>> +
>>>> +       kfunc = (bpf_kfunc_t)arg6;
>>>> +       kfunc(arg1, arg2, arg3, arg4, arg5);
>>>> +
>>>> +       bpf_ctx = current->bpf_ctx;
>>>> +
>>>> +       hash_for_each_possible(bpf_ctx->active_ref_list, node, hnode, (unsigned long)arg1) {
>>>> +               if (node->obj_addr == (unsigned long)arg1) {
>>>> +                       hash_del(&node->hnode);
>>>> +                       list_add(&node->lnode, &bpf_ctx->free_ref_list);
>>>> +
>>>> +                       pr_info("bpf prog release obj addr = %lx, btf id = %d\n",
>>>> +                               node->obj_addr, node->struct_btf_id);
>>>> +               }
>>>> +       }
>>>> +
>>>> +       print_bpf_active_refs();
>>>> +}
>>>
>>> So for every acq/rel the above two function will be called
>>> and you call this:
>>> "
>>> perhaps we can use some low overhead runtime solution first as a
>>> not too bad alternative
>>> "
>>>
>>> low overhead ?!
>>>
>>> acq/rel kfuncs can be very hot.
>>> To the level that single atomic_inc() is a noticeable overhead.
>>> Doing above is an obvious no-go in any production setup.
>>>
>>>> Before the bpf program actually runs, we can allocate the maximum
>>>> possible number of reference nodes to record reference information.
>>>
>>> This is an incorrect assumption.
>>> Look at register_btf_id_dtor_kfuncs()
>>> that patch 1 is sort-of trying to reinvent.
>>> Acquired objects can be stashed with single xchg instruction and
>>> people are not happy with performance either.
>>> An acquire kfunc plus inlined bpf_kptr_xchg is too slow in some cases.
>>> A bunch of bpf progs operate under constraints where nanoseconds count.
>>> That's why we rely on static verification where possible.
>>> Everytime we introduce run-time safety checks (like bpf_arena) we
>>> sacrifice some use cases.
>>> So, no, this proposal is not a solution.
>>
>> OK, I agree, if single atomic_inc() is a noticeable overhead, then any
>> runtime solution is not applicable.
>>
>> (I had thought about using btf id as another argument to further
>> eliminate the O(log n) overhead of binary search, but now it is
>> obviously not enough)
>>
>>
>> I am not sure, BPF runtime hooks seem to be a general feature, maybe it
>> can be used in other scenarios?
>>
>> Do you think there would be value in non-intrusive bpf program behavior
>> tracking if it is only enabled in certain modes?
>>
>> For example, to help us debug/diagnose bpf programs.
> 
> Unlikely. In general we don't add debug code to the kernel.
> There are exceptions like lockdep and kasan that are there to
> debug the kernel itself and they're not enabled in prod.
> I don't see a use case for "let's replace all kfuncs with a wrapper".
> perf record/report works on bpf progs, so profiling/perf analysis
> part of bpf prog is solved.
> Debugging of bpf prog for correctness is a different story.
> It's an interesting challenge on its own, but
> wrapping kfuncs won't help.
> Debugging bpf prog is not much different than debugging normal kernel code.
> Sprinkle printk is typically the answer.

I have an idea, though not sure if it is helpful.

(This idea is for the previous problem of holding references too long)

My idea is to add a new KF_FLAG, like KF_ACQUIRE_EPHEMERAL, as a
special reference that can only be held for a short time.

When a bpf program holds such a reference, the bpf program will not be
allowed to enter any new logic with uncertain runtime, such as bpf_loop
and the bpf open coded iterator.

(If the bpf program is already in a loop, then no problem, as long as
the bpf program doesn't enter a new nested loop, since the bpf verifier
guarantees that references must be released in the loop body)

In addition, such references can only be acquired and released between a
limited number of instructions, e.g., 300 instructions.

This way the bpf verifier can force bpf programs to hold such references
only for a short time to do simple get-or-set information operations.

This special reference might solve the problem Christian mentioned
in the file iterator that bpf programs might hold file references for
too long.

Do you think this is a feasible solution?


