Return-Path: <bpf+bounces-51762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA02A38AA9
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C463B0B58
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343A229B12;
	Mon, 17 Feb 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OLz+gbDs"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011075.outbound.protection.outlook.com [52.103.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9921A421;
	Mon, 17 Feb 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813815; cv=fail; b=CqghZY359rt+V07Eq4IUyu4zEKKmDnKSB08Y8HhNrBnritWjqhSAtvoXRDGm7kR4aVzj1zLj9ZCBkIRJcBp4+reH/iJfq2WGtDoxctat6FyEQM1dyb9wqdI7NAFpNr4RpF2Y4Doc6FuvsoegV6XUbcB7C8lKmIQzlxEMIIWds6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813815; c=relaxed/simple;
	bh=OF/VRJ0Cyw3AuGaA6SRPtXGFqIrDHvpJ/MKjo/YDXEk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2PyIPTUa4QsbS7QiYAS+bDeiXt297i7kYWFae52tghr++EarEJUls2QkZhVwdwNebr45zgedkxMiOlXvfUflbNTG3c3FMsC0Uy9A33l4qzgNcW0ON+ebmg6rxysg+RAJHD0uiJ+7krOGm4GMI7YsNGaAXJqHqoMNBJU3/KgX7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OLz+gbDs; arc=fail smtp.client-ip=52.103.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6gb4q0ffQ4LNZ0nRYIEfqz00iRWycfZjr7H60LwOROmVmMRZGEhAD2M2q+oWY4uwT6cel8eaoL4ODK5Y1QQ4GoJgea7iJe+83MLRC5DV++JOF85M2lSLQMo7nAGIf04tSDD6iGAXlaFwMylkHO4PVl2QmLNnBFP3WNdpQgKv1OgimNmk+sNNToYW/te3Jh4TaognyO7VyvKlyMJlMpoNBs1gKK3tqEs2GeBdD811iAdjyD3WIjRR66bb0XU7qIWNJ2kZJWlgemJSy5FzSSd6V8Jwj3eWRGOoZmNuPkEOWrJ9DiE8ERD/qGdZI8lLxUIGoH4RuY/y3UttpdK9sOmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMh1thUxbBIPY/Tnh324XtduBJHz6rJCa7fJ/doVH2k=;
 b=VC+4S/oToXT446PpEQgZUFhT37/DAy7VuU651/s0SmtACRo3P9qlJjyo7CzF8y3OJFoD1A+s6+aTeFWZsG/ZTwWwnG0tr/MRuEibegMI6wZIjJg2Tw6xH/zvqsdbHPzjFWsNRmSJlgp/vVoE7J1VCY1VOknTxHI6Oz8g65kceN6tENO5P0vNsAErjLdb2QEUCpPG2gjpnn/K35AmMBPfh8POw66TRSfCeE5iA9KAj2EGr88av+HYaudvGsVKNflxcHLVc6rD64ni2JknIAzlRz0tYot7Qiee9vIY9vYjcixupnZwzPDQ2XLYAb6nkKyO4YMNysCJY+0qssUTc+wTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMh1thUxbBIPY/Tnh324XtduBJHz6rJCa7fJ/doVH2k=;
 b=OLz+gbDskoHjppgFzlmnVG075UuXDKHS8IKdw70FslZWiEN+OPDkYkeadUy/KYejNIODcVrOjJIuJc7ZVExrSDgMTAlhS3yS8NYgc8xy7++hTJjDjEQ9XQmy/qu25Ffp5QumHRDKLM7bC+TS7JqW8C7H8HmLUqgP4uPu9akhxUcpDvYqbIfu+Vzt7Hlp5WzmW6Vq8VO+t2REwIqPv7a46AkQcVKYgUVcjuwynbAjZ2YyY+ACWd6BAxElH8sxtq47r/RY7WtHbBG0c2YRb9u2A3TDotx4gx7LgpQPZ1MQ+K8bs8rlT/COkECzDcVlSaJq9gfyHiU76KOC4Xr7LHp0lA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB8665.eurprd03.prod.outlook.com (2603:10a6:20b:54b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 17:36:50 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 17:36:50 +0000
Message-ID:
 <AM6PR03MB5080865D2917551BDD92905A99FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 17 Feb 2025 17:36:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 5/6] bpf: Make BPF JIT support installation
 of bpf runtime hooks
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E1C3EEE022BC61FAF3DA99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB5080E1C3EEE022BC61FAF3DA99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <377f992f-b565-4854-8449-ce6981b18015@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0cce05-9c99-4b28-eea4-08dd4f79a891
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|5072599009|8060799006|15080799006|461199028|3412199025|10035399004|4302099013|440099028|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmxKMjk5emRLOGFxd1lzdlJWcElub1JVL2ZrR0o1elk0VUh0aFJKYzdTT2No?=
 =?utf-8?B?RDY3R1o2bjdJMUg2Y2xkMzl2YVJKSUtxNng4RnF0ZHlGTzNJTGxwWGNLTGZD?=
 =?utf-8?B?RnlxN3FwUzNvK1JsMlRMQVpYY3M1SEZVNUx4VisrWHRWQWthU1RPR3B2Um01?=
 =?utf-8?B?Y0dqTkJ5eE1PeGdmbis0TjFKcENqREhIaFdHblpza29FZ0VvSFRKcndPeFkr?=
 =?utf-8?B?U1hUWkg4OE9VK0tkdDBmMm1GNk9tSzU0QzM3SHc0ZUJseG5CemRwNnFrc0Zj?=
 =?utf-8?B?bUd6LytnRTkyY3F1a292Q0wyWm5CenJOazNrMkVQV2tJaitkc1E1WkYxUXh5?=
 =?utf-8?B?QzVhbGNXVlV5VnVyemZCMmdwUk9mb3RZNFJaS1hFZmU5dlI2c1ErK2hTeUgw?=
 =?utf-8?B?QmZjYjFUeWNEcFNJNWgrWlBxWVBvdDVFZmtaSE5xQndFeTNHaFZaWmM0TWdh?=
 =?utf-8?B?eDY2ek5DeWgvRm45RHpPOWMra2tsMlhGSnBIRC9tSDFkcWxaSm16dnV5cTJy?=
 =?utf-8?B?Z2EzZDJFa3ZWZlJobk1LK0dYeHNiRk1YdG1DSlpwOUZsdEl3NVdEM2d3SWd2?=
 =?utf-8?B?OEFMTUduQ1NuNCt0bHlGZlhKSVBjTjVWUE82MXp6c21tVUo4K1crOWYySXFJ?=
 =?utf-8?B?S0N3V3E0eFdzcmw4cDBsL2xlL1I5d2Z5bGJESGVQV2JyYTZ6UWJzaUNKZG1W?=
 =?utf-8?B?a2VsT000bVgyN0hVYlNaa0xUekhMZTJXOWpWMTB1SE5Hb0tweExTNUJyTHI0?=
 =?utf-8?B?MWFrWmR1YS9sRU0wTnRRQ0N5UytZOWY0MG9YMmtxK3JkL0VuZ1djdHZablNy?=
 =?utf-8?B?SWx5a0hOZWJEeVdoQWVUdHRBTnpnUk5GOWpISDQzcGJ5WTlQUnVMMDl5ek43?=
 =?utf-8?B?b1Nqd3Q3MUNsakQvaHZTSGJEa3VJSkhFdFpmeTVWU3podzNhMC9Cd3E5b1k0?=
 =?utf-8?B?WmNwQ0VoYUJQQVF1OFJuZjF1VFZuc0I4amJUNUFKbWQ4VHR6NVdWT09haVdB?=
 =?utf-8?B?cW9tTktnL1dmNjRFRVRWaWhFcndaSWp3N3I3R1RicEpqakI3RWkzdUZ6K21y?=
 =?utf-8?B?ZTNsZ2EwTjNhQ01CZEZMeW44QlhnczcrdXI2eUhCTXJ1b2ZQSEdVQmc1WXJT?=
 =?utf-8?B?Sm9vVVJOU1k3OTFXK09tMXFPZDd4eXZvU1E2cExQdjR5NkhEZWtsWnNOTTl0?=
 =?utf-8?B?N1NYSi96ZVRzcXY2dnRhWGxybzR6YmYrbHhGY0JCRVpPMWJFUTkrbThVSUlD?=
 =?utf-8?B?UmpHcm5yTWFMTmNkdzJzdHl1RktWOFlXSTRNMmN5Rlh2YkhpVzBNVkx2MVhi?=
 =?utf-8?B?eVlEUVpIeTY3WE1tK1ExSG0veHpCWHVMVnJ6SlN2TTlTTnB6Qzg5OEU5cWJQ?=
 =?utf-8?B?OGRnV3N1a1VIZWJOVWpqMTJpUEFUbmFOd2ttcy9hNXJ2TC9ubWNLUE9XSUpV?=
 =?utf-8?B?aXQ4aXEvc1JhYnNhVjIyVEVUaklCSUs2c25xSGlrNVVUWXNzaDllbDZDOXVE?=
 =?utf-8?B?RU5DeFNOUzgwcFlPZ0JCVFp3RkZMY1JxU05hdkhJcHppRGlmMC92OFp6c3VU?=
 =?utf-8?B?K3hVeHBaYlh5OFlyZFQrY3FzMUsxMDg4dXVxeXMyZ2FLd2VEMUFyVmF1amZX?=
 =?utf-8?Q?qnQzFMC1JvAiljlUQ/bTOiacxp4bxRmzPOig/KiIRQc4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUo4cVdhYzJwb29kV041NFBKcTQzQUhSYzMyejVsN1NsS1BoWFRKQWtHbFlC?=
 =?utf-8?B?S21tVGROZDgrS2JzREo1OTVVd2UwcGhlZzg2N3g0MkF0bmZBR3JRaE1acks1?=
 =?utf-8?B?ekFZWUZsdTViSi90WmJVQ2I1cXFhUllSVElaTXorZWRqbW5McFlSWE9ORCs5?=
 =?utf-8?B?RmJRWnRrWk1HSDhVc2ZXaSszNXdVbGFQbE9kR1pobDIzUjN2YUlYUythNjdW?=
 =?utf-8?B?cVkzSGVCbFh2YTRzSW5oU0EyQXRoemRKM3czNEtzTjNBMURUUFZrVHJKR2FU?=
 =?utf-8?B?eTNWaHNCZjkrYzZhVWdRbmNNaVByZWgwRXhqZWRrcXpmN240cFlSR0JXQ3ZB?=
 =?utf-8?B?Y2pIRkFoTHVPdmlOU0VFUWQrY1F2NFM5RXlNRkQyOEtZRmRpdUttV2lldUc3?=
 =?utf-8?B?cXkxenJ0bTJwTmt2ZVZLWU8rZ2cvSEsrcVczM0xMV2lwbStUNVlTa05QYkNz?=
 =?utf-8?B?MWtBVjMwUzBjc01IL0gyZHVTWitlajdETjJxYmdCTW9xeWIyWlhCUVg0REFL?=
 =?utf-8?B?QlB3cnVXbVRUWnJJRDlURHFXK1Q4dGtaaXdZUVFwQ0JTb1ZHV1pVMHNRWjJO?=
 =?utf-8?B?b243dUgxYjdSU1hWTmQ3aXo0WmNYdGpGMEdVM1dWVmFWaC93eFlwYWYvVnZm?=
 =?utf-8?B?SCs5c0hISk9WVHNxd1pqa0hCN0piL3ltTitXcEFRU2JWeGdMRVNSTC9yQUh0?=
 =?utf-8?B?OEUyejNCZlpCSWRDbTZsd3MrNHVNVzQ0QW4wcXRQUkNqOGErVUE0YWpEVnVn?=
 =?utf-8?B?L3hiNndVUXZ2TjJvbStxaHJHTDZ1RlhqaUtMZ2dOYmt4am81QU1ZNncya3lG?=
 =?utf-8?B?WDVaaG9rMDRickRZNVpaODFRUzZpR3ZEQWFNTnBPcHhqU1o3YmQ2U1dOSVZs?=
 =?utf-8?B?aXlIUWpLcERQRlpXeFNMUTl1RkpselFkUUp1VjNNVUsyZ0hrVGQwVVRiMzh3?=
 =?utf-8?B?dWhmYlFMVUZtV3lrenBIL000cnBucUx0VlJkMjRKdXBEb2dFZ2l4YlNOcTBH?=
 =?utf-8?B?WnV0aE92bkhiQzFGZlVRR04vYmM3V0JvMU41SlJuWGRRVngxNUovOWF5UE9R?=
 =?utf-8?B?Z0hxcWo5RlN0bGltRUZiZU10bFp6MXNYaU0vVi9TSndzRmlUeDZvTFVySHl0?=
 =?utf-8?B?dDZNU0ZXWGMxT081enYzOXk2M2owbitZVVRzWWtZZS8zMnJiTFlwWjd4N3JT?=
 =?utf-8?B?V1NOeG44RGVzLzBJcjhrbDA4YTBnSXlHcm5TK1Q3Z2JDSG9SanR4bm01RGhV?=
 =?utf-8?B?STVSMmtHeElnZ2hjRU50T1hOOGxiaG5NaGtlcWtITHJwdzVMbmg4Ym41ZmFh?=
 =?utf-8?B?TGVjSnNZa3psbDB2QnBEMWtsTmpmSG5BdmxITVpuOUY5dDgzUkVRTjBjVXNn?=
 =?utf-8?B?S1Zqa1FaQWhjMExDd1dpcDdCMjMxbFp4K0RCY3pWUXkxRHg1TnhYdjdjVGZX?=
 =?utf-8?B?Z0d2TklQeFdLK0hVQ3JLWnhhSHZEb2JvRVlGNkxCNWt6ZnhmQnRrNVlVQVRW?=
 =?utf-8?B?QkRwRE9lUDM4VFVMY0ptUlJCQkwxTzZGbzJWbFFrTHBvVGJyYW9ETTdDUEh3?=
 =?utf-8?B?SUp2UXRaMFRrejBBQzFGcjZsN1ZjWDJLaXUvK1l5d2ViSTAzZ0xhVkJFYTFE?=
 =?utf-8?B?bFd6RWg5TzJibWlRelgyOUNxUVJtd2RYRzlvU085LzBXKzJuY01VR1ZxZFlh?=
 =?utf-8?Q?vG9F8hschg1gIcPJWnM+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0cce05-9c99-4b28-eea4-08dd4f79a891
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:36:50.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8665

On 2025/2/14 00:26, Juntong Deng wrote:
> This patch makes BPF JIT support installation of bpf runtime hooks.
> 
> The principle of bpf runtime hook is simple, by replacing the memory
> address of kfunc in the CALL instruction with the memory address of
> the hook function, and inserting the memory address of kfunc as the
> 6th argument.
> 
> select_bpf_runtime_hook is used to select the runtime hook to be
> installed, based on kfunc. If it is acquiring kfunc, install
> bpf_runtime_acquire_hook, if it is releasing kfunc, install
> bpf_runtime_release_hook. Maybe in the future we can use this
> to install watchdog hooks.
> 
> In the hook function, we can read the arguments passed to the original
> kfunc. Normally, we will call the original kfunc with the same arguments
> in the hook function, and return the return value returned by the
> original kfunc.
> 
> After the BPF JIT, the function calling convention of the bpf program
> will be the same as the calling convention of the native architecture
> (regardless of the architecture), so this approach will always work.
> 
> Since this is only for demonstration purposes, only support for the
> x86_64 architecture is implemented.
> 
> This approach is easily portable to support other architectures,
> the only thing we need to do is replace the call address and insert
> a argument.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>   arch/x86/net/bpf_jit_comp.c |  8 ++++++++
>   include/linux/btf.h         |  1 +
>   kernel/bpf/btf.c            | 39 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a43fc5af973d..da579e835731 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2184,6 +2184,7 @@ st:			if (is_imm8(insn->off))
>   			/* call */
>   		case BPF_JMP | BPF_CALL: {
>   			u8 *ip = image + addrs[i - 1];
> +			void *runtime_hook;
>   
>   			func = (u8 *) __bpf_call_base + imm32;
>   			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
> @@ -2197,6 +2198,13 @@ st:			if (is_imm8(insn->off))
>   				ip += 2;
>   			}
>   			ip += x86_call_depth_emit_accounting(&prog, func, ip);
> +			runtime_hook = select_bpf_runtime_hook(func);
> +			if (runtime_hook) {
> +				emit_mov_imm64(&prog, X86_REG_R9, (long)func >> 32,
> +					       (u32) (long)func);
> +				ip += 6;
> +				func = (u8 *)runtime_hook;
> +			}
>   			if (emit_call(&prog, func, ip))
>   				return -EINVAL;
>   			if (priv_frame_ptr)
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 39f12d101809..46681181e2bc 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -571,6 +571,7 @@ void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
>   			       void *arg4, void *arg5, void *arg6);
>   void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
>   			      void *arg4, void *arg5, void *arg6);
> +void *select_bpf_runtime_hook(void *kfunc);
>   const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
>   void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>   int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 93ca804d52e3..f99b9f746674 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -9640,3 +9640,42 @@ void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
>   
>   	print_bpf_active_refs();
>   }
> +
> +void *select_bpf_runtime_hook(void *kfunc)
> +{
> +	struct btf_struct_kfunc *struct_kfunc, dummy_key;
> +	struct btf_struct_kfunc_tab *tab;
> +	struct btf *btf;
> +
> +	btf = bpf_get_btf_vmlinux();
> +	dummy_key.kfunc_addr = (unsigned long)kfunc;
> +
> +	tab = btf->acquire_kfunc_tab;
> +	if (tab) {
> +		struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
> +				       sizeof(struct btf_struct_kfunc),
> +				       btf_kfunc_addr_cmp_func);
> +		if (struct_kfunc)
> +			return bpf_runtime_acquire_hook;
> +	}
> +
> +	tab = btf->release_kfunc_tab;
> +	if (tab) {
> +		struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
> +				       sizeof(struct btf_struct_kfunc),
> +				       btf_kfunc_addr_cmp_func);
> +		if (struct_kfunc)
> +			return bpf_runtime_release_hook;
> +	}
> +
> +	/*
> +	 * For watchdog we may need
> +	 *
> +	 * tab = btf->may_run_repeatedly_long_time_kfunc_tab
> +	 * struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt, sizeof(struct btf_struct_kfunc),
> +	 *		       btf_kfunc_addr_cmp_func);
> +	 * if (struct_kfunc)
> +	 *	return bpf_runtime_watchdog_hook;
> +	 */
> +	return NULL;
> +}

This weekend I realized that BPF runtime hooks can have more application 
scenarios, for example, it can help us debug/diagnose bpf programs.

A proof-of-concept implementation [0].

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#u


