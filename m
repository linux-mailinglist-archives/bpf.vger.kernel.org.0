Return-Path: <bpf+bounces-52807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708DA48A60
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4F01890472
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58E270ED4;
	Thu, 27 Feb 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SBrEKj8p"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2075.outbound.protection.outlook.com [40.92.49.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1071A9B2A;
	Thu, 27 Feb 2025 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691405; cv=fail; b=GQDTKsdlKyzIigGvUSWUCcqCjE+pxH3f8iInSZ8pgknYsRNEszZO+C48oSVft3kHbGbnd5mtnYfOCn6gocubD6lm4big/Q86HWJ3WCMCdnh5YI1FfpME0mzQC65xNQR6W7GKHVpKGTzmLlpktsN+k/eZJqnyoxSdQMCzDBYlN5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691405; c=relaxed/simple;
	bh=/6bLB7s+3MLyWtXXYDZbRhi3HZT1rBA7Al2lcviNAgM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=amb5e7rCMeQeYQk9Z66PpjWX/N11KuuW3k7x2bpQBLa+0mPIMMGhTDvIPbHRgh0pH6S2UUg31kYhyJL5zkZ5dzqYUi666VbiDilJIaETRfPzgNnQUOUVu5QUsFrXU+622z4PZGE+tXH3X9Itu/82H6y3y11Lmd/ijY3KHFHiKdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SBrEKj8p; arc=fail smtp.client-ip=40.92.49.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmtbSCbKCopCaLsbWzlpSEVHeAcI1bByZ5hJJ3PDrqJHyQbrOmLHdza5BfxW0RiopvMf5jyDp/YDZQ1/DRve7srtcMt2vDDS1TrLCqvDepsvEZqi8aYTIJLRn6ymbk65MBj/GN/TNxgDUIuVG2TrFHb7ybuDuNFsW2QDKyeE9SL/NKRYT2J7FMvl8Xu2q3ncBV/wmxiKdmD927i9MGKz8BGfr97i+v3Xj0rJW6wmw5KzxhMcwuE7AJxn4l+t5VQ8agEbf12XDw83o39zDx/7eS1XohBUO9IOzqFnf8Hiw7r/6YwL3GM6ssJc03l+jIyoCEgMd4shdHoK9zItHxEPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziWopomaMmHODOqm612fGGMhcd+dWWr+LnmcEjGOIcE=;
 b=cCzxS1vhPzG9ZeN/EIwx9WIqL/vd3vYJSzpdWfxXSw+4xj3784OGtaZY1Xnr6FR3mCVEA931kKzyoY8ykR/jGKfSb7cEmpbYkJM8F0rWaIt68xSZME+YCzJksKM0wYop6vFcS18so/mLsb/qiFHY68NXw0B0F2yGuMaKPzJian8hAxuSCDxWUSJiDs4jgkj0cO9nL/UAS4+d9VvJApgOpoByCjo9EsYqFltiraLQbWSS73hqbTE5nSUpzQ988fI3P42mDRwy5+n6Jovqvg0IjYQ/z5I0od9QNaPyK7VMTEWjarcohGUU2E0SQt12RhgEf25mQqtz0d5uDpZethGdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziWopomaMmHODOqm612fGGMhcd+dWWr+LnmcEjGOIcE=;
 b=SBrEKj8p1MKJZ8tF055SkbXjkD1vMlFyhhkhLsH/cTi21cwihApqwQHM/EzLKQQ3a2tUQW+UQJsvJCiu/xOvJD5lsioGRjJE54rm8uP6tlwv9QgpV+1Pn9bL2N55MMlhkG+Mg928DYOu0NkMQGGUL+JQ50Ia8v2SexcOohoj1qyVnOI+wVDC/fnseGMsiFIBWOWMkFWF3M3khmIM4BWJ+vunTobdX6xPl4QbF7oLayK6PJ61Qtt8hmdDscSjRxB2YDol3bF5wamoWO9inole1lO3FaVC6hUHOH+euvdQ/BWCi8tYn068eBrPMTP+u2N3n6TJNmwbhhFVCm17Ptce8A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB7630.eurprd03.prod.outlook.com (2603:10a6:20b:411::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 21:23:21 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 21:23:21 +0000
Message-ID:
 <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Thu, 27 Feb 2025 21:23:20 +0000
User-Agent: Mozilla Thunderbird
From: Juntong Deng <juntong.deng@outlook.com>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z8DKSgzZB5HZgYN8@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <669ef0af-59f7-4fea-a4da-44ff668550d2@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 82278add-fc21-4600-b019-08dd5774f5a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6072599003|461199028|15080799006|5072599009|8060799006|6090799003|19110799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M00rNTFpcHlvTHRqMlVOeVE2UGd5c2NHWmVpUkw0aHJjdm5nWGhYbDBha0xD?=
 =?utf-8?B?ejlVbVBSbTJGNUFzeUUvRWVnTC9LWkJsNFBYVW9pa1pyMjBpLy9pRHRxd2lB?=
 =?utf-8?B?djNrQXZCT3g3N2d1dkowYkxOY1M5b2Q5b0M4RS9xazZoWWo3L1doRXl6VDNV?=
 =?utf-8?B?YzJzZnFseWoxRHpnRUJIcnQ2ckZxQjNlakdWcHR3RGNsZEk0NHNIZ3BPUFlT?=
 =?utf-8?B?WVR6NEhGOCtOdW1OZkVUWHR6RGNobzF0WFM1RTh6TUdnMjhQWTBuOU0zaFhU?=
 =?utf-8?B?VU5kS1pEbHZNMEhleTlibDlsdkdMRFhxQUdOUzRGOEgwWGNuOHJUais1ZHZy?=
 =?utf-8?B?L3lHbDU5MzNaVk5jdTN5cWZiaW5ieEpsL1hWQmpaTXIwaXJjVFNqSHdscDRw?=
 =?utf-8?B?ZUtGVE1HYzdwLzZsZlh3aEQwNVlmMm52VkY5ZU80QUtiL0x0eG1EdjB0TlZR?=
 =?utf-8?B?b05GSEVoeFJidGtFTHRvMWl3dEJrOGtmS2xOYzZrM2srcUNpSzlCNzdUdG9P?=
 =?utf-8?B?eFZBQkZ1cUgzSmlpdzR0S0REZ2x4UER1T1crZkxEaElhSFFhMzNydThRWUYw?=
 =?utf-8?B?WjBIMit3c3Q3QkhHVXkrcmQvMXdlMUVjbHRmekhFTHl3bnZtbjk3VGdkSHpY?=
 =?utf-8?B?SHZPY09RMWFQdE9EVkNobXd4UFRIRlRFSHZQR0d5MlQ5RlN0dXNDRVNDWStD?=
 =?utf-8?B?ODNiN1dRTEFjN21OcGRZMnNkdWZaUHlENUh0YkhLbEN1d2F1R2J5R0RQQ1NS?=
 =?utf-8?B?Ti9zdTY3OGJ3eEMvK3p1US8zSjFhdDRXN0luMnl2aU5BMWJSSHJkT1l3Y29j?=
 =?utf-8?B?Yk9yNldycEM1TzlCdlhaWHk4eG9GQmFSS3hQYnB4UUIrNmZXOXYrN3pSTGJP?=
 =?utf-8?B?aFRMNFZ5cDRnUTRncU16YUUxOGptS0E0cktySTV0eG5ZaDBhNkRYWE54WnA4?=
 =?utf-8?B?TVdpajc3L1lWWEhZODJTVFJXMnFNSlJ3YzJoQ3BYZkw2aFpCK2crMGozaC81?=
 =?utf-8?B?ZXhIaDFWanpsaWJ4UU5FZmJXSGlZR2crSHBGT2dVQWVWdzJKZUx2MjdKbXg2?=
 =?utf-8?B?dmUwUHEwWHAxVFRGUk5vZEpJaFhuc1ZkVXBhUFRjSVhBb3ZxcnJkYWlzL1cy?=
 =?utf-8?B?eHExY0xpbWhMS2N5SzNqK0UwMmpoSWt2OVRZeFVHYW4veXdGTm9GRnFnMWYr?=
 =?utf-8?B?anBlck56cG1Ua2NWbkZDSnR6Y2ZMRjlxSndRMlBwRTJ6a2laTkoyQUxoOWFY?=
 =?utf-8?B?V3B1bHRaTlZJa0JreVF4Ull4RG9XaFpMalE3amhkbEtHcy9YWXFaK09lYWtl?=
 =?utf-8?B?MTJUdzRoUWVvVXdvaXlxZFBqT1pXZ1hJU0hsdlAvYXgxYjhmZG45Zy8zREpL?=
 =?utf-8?B?blM4bnduN3lPd2d5dUpuNmZqZnErTThDOVp4V05wNnZnMENzV055VTcxRklt?=
 =?utf-8?B?ZW4yeU1FK083Nk1YUXhIY0N5L1FkMnI5anp5MEszaENnUm9GbXdVWGZEbDRp?=
 =?utf-8?B?clUzR29MTGZZQTg3ZndoRTIzOWo1UGxpTVJzMHVUK0RzYS9lYmtJbSszSG9L?=
 =?utf-8?B?RHBVZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVVLYStaYVg1cVp4NlBnVU50c2VUMTZSeVdjK3FRcmF4OUtpaGhZUW13Ylho?=
 =?utf-8?B?R1YzZTlVRWxGdE5lTnpLRm5MQk9ac1BsZ1hRL3pSQ2RKWG4xNnFocVphMkwr?=
 =?utf-8?B?Y3Q1QmxFVk9nR3MvNXNLUU1zNEFDK253WVdmV1NIRHR3am1rYXB3dS8xZzVX?=
 =?utf-8?B?THUxeDJwRjJuNXhsalh3ZENobGdkKzBXOTNOWHQvUmF3VitNdDBQM3ZpTXFX?=
 =?utf-8?B?aUpzVXU3YmwvL1dSWjRXUnRoZ1oyRys1RzdrTlVtYThNMlZQVHdQUVhoTElE?=
 =?utf-8?B?RHNGNlJLVDZuYVV3N1J6T2MzczZMZXM1cEtjZmtKaEVIQXZqTHoyQVdOTHcw?=
 =?utf-8?B?R0hkLzhVR2lHcnAyTkY0QlhFU1c4MHNFMEZPWld1TEhaZStlNVhkcW1OTzQr?=
 =?utf-8?B?amx3ZkFIRkVVOXZXb0lhdWlBdVpOVitWamgxV252dmpMUTFhbGNzOTE5bkZo?=
 =?utf-8?B?NXA1NEtpN29BVlA1OTVZbDExZmphZlgzVVdzNzF5STRzSHdDVWh1cjJydWw1?=
 =?utf-8?B?dlBZNDdHNnBIUnlabFh5YWtUTkwzeG9mZi8xcWZENW4xMlB5V3dOZEtPUnFH?=
 =?utf-8?B?RGdodG4wQ2xMTHhMYnhXa2JrbFBiNWNwZnVNQXhZdnc5OWE3SmU1dWF0V05L?=
 =?utf-8?B?TFk4U04zN3JLcUc1eGc3N0ozaEppMWZRYzNxVlR6eEtnUnRvT3VvUkVFSVBv?=
 =?utf-8?B?S2NDZDdkWm1JN01mM2NXM3lvT3U1VUtERHJBelZyLzk5cERJRzFiY2V4bkJx?=
 =?utf-8?B?Y0lTL2FyWkc2NlhaWEdBN3dNbHQ0MUVqZ2c4YnVzWGkra1BZb1dzbkFxRlpa?=
 =?utf-8?B?bk9ydEU5aDFBcFVQTHRGdGV2SGc1aUNKK3pIM3V0STR4WkcySzllTEF1S1FD?=
 =?utf-8?B?ZlU3eUd1NXc5K3RiUWJydG5kVW1OUTk0ZHo0bloydnNTSHFkS294NlNXaFNF?=
 =?utf-8?B?cUJMU1pKWmVnVEhKK25PR1hJVW1hNlZWcFo0UzkrTGtTaHA2TlRmS0FQTmwv?=
 =?utf-8?B?Q0c1RGkzUkc2eDVpc1pkN09IU1RkRmI1MlZnMTZmMlNvdExvWGFHdWY0cHZT?=
 =?utf-8?B?RWN4SVZHMm4xallzemcwSWNyZjYrNHpnZkI4UVgzK1JRbHozUldYTUZ4QS9k?=
 =?utf-8?B?UzFQVlpnSU1Wd0NUN0FXS1RUK0xHYjIzY0JkTTgwSTdGRVdGYjFQUERwNFk1?=
 =?utf-8?B?aUluc1JOZlpvbHJzN0l4UVdLUG01K2pxbkYvL3lkWVJlak5OSnI3bEp5TXdB?=
 =?utf-8?B?WEZvQVlDQ3FuRlU2RmJTbURkblh1dVl5YXVvMW1LUDZRci8rZXVJanNncUhU?=
 =?utf-8?B?MU4xTUhGalR0eFRLaEtQNVZtdlBCQWNoQjV1VGM3aVY1OE9YL0dkNElNV0pW?=
 =?utf-8?B?KzdaZFdQUG53a2k2eTNxYXMxYWR6N3JWL212NGlQQWtEaEErcSt0VlZ5NGFG?=
 =?utf-8?B?Vm5mWklnR2Y0ajhWcnRwQzJXbVZGSitLaDUrZlNjN0dEV21kZGx0eGQvZ3ox?=
 =?utf-8?B?Mi9IRWtadFRMVEl6SUppQmNPUGI1MUdrVm5JTzZFQXBzSjI2SmxBQ1MxSTNM?=
 =?utf-8?B?VWIyTlBPQ21VQy9XY29GQURsWmtrNE5NWit6Z3FhTWJuZU5OdjJrOVlUdk4w?=
 =?utf-8?B?YTBTZGttT2JWdlhsNEdhUlYwR2N5UzVlVC9DUXAyNVRhY3hHcmJXS01sUk5L?=
 =?utf-8?Q?vzu16Tt0zWwpgqra2SaR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82278add-fc21-4600-b019-08dd5774f5a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 21:23:21.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7630

On 2025/2/27 20:25, Tejun Heo wrote:

>> +/* Each flag corresponds to a btf kfunc id set */
>> +enum scx_ops_kf_flags {
>> +	SCX_OPS_KF_ANY			= 0,
>> +	SCX_OPS_KF_UNLOCKED		= 1 << 1,

> nit: Any specific reason to skip bit 0?

Thanks for your reply.

This is a mistake and will be fixed in the next version.

>> +	[SCX_OP_IDX(exit_task)]			= SCX_OPS_KF_ANY,
>> +	[SCX_OP_IDX(enable)]			= SCX_OPS_KF_ANY,
>> +	[SCX_OP_IDX(disable)]			= SCX_OPS_KF_ANY,
>> +	[SCX_OP_IDX(dump)]			= SCX_OPS_KF_DISPATCH,

> Shouldn't this be SCX_OPS_KF_UNLOCKED?

This is another mistake and will be fixed in the next version.

> Hello,
> 
> On Wed, Feb 26, 2025 at 07:28:18PM +0000, Juntong Deng wrote:
>> +BTF_KFUNCS_START(scx_kfunc_ids_ops_context_sensitive)
>> +/* scx_kfunc_ids_select_cpu */
>> +BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>> +/* scx_kfunc_ids_enqueue_dispatch */
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
>> +/* scx_kfunc_ids_dispatch */
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
>> +BTF_ID_FLAGS(func, scx_bpf_consume)
>> +/* scx_kfunc_ids_cpu_release */
>> +BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
>> +/* scx_kfunc_ids_unlocked */
>> +BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
>> +/* Intersection of scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked */
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
>> +BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
>> +BTF_KFUNCS_END(scx_kfunc_ids_ops_context_sensitive)
> 
> I'm not a big fan of repeating the kfuncs. This is going to be error-prone.
> Can't it register and test the existing sets in the filter function instead?
> If that's too cumbersome, maybe we can put these in a macro so that we don't
> have to repeat the functions?
> 

The core idea of ​​the current design is to separate the kfunc id set used
for filtering purpose and grouping purpose, so that we only need one
filter and do not need to add separate filters for each kfunc id set.
So although kfuncs appear repeatedly in two kfunc id sets, they are
used for different purposes.

scx_kfunc_ids_ops_context_sensitive is only used for filtering purposes
and includes all context-sensitive kfuncs. We need to rely on another
grouping purpose kfunc id set, for example, scx_kfunc_ids_dispatch,
to determine whether a kfunc is allowed to be called in the
dispatch context.

Macro is a good idea, I will try it in the next version.

>> +static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_prog *prog, u32 kfunc_id)
>> +{
>> +	u32 moff, flags;
>> +
>> +	if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, kfunc_id))
>> +		return 0;
>> +
>> +	if (prog->type == BPF_PROG_TYPE_SYSCALL &&
>> +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>> +		return 0;
> 
> Not from this change but these can probably be allowed from TRACING too.
> 

Not sure if it is safe to make these kfuncs available in TRACING.
If Alexei sees this email, could you please leave a comment?

>> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
>> +	    prog->aux->st_ops != &bpf_sched_ext_ops)
>> +		return 0;
> 
> Why can't other struct_ops progs call scx_kfunc_ids_unlocked kfuncs?
> 

Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
called by other struct_ops programs.

>> +	/* prog->type == BPF_PROG_TYPE_STRUCT_OPS && prog->aux->st_ops == &bpf_sched_ext_ops*/
>> +
>> +	moff = prog->aux->attach_st_ops_member_off;
>> +	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
>> +
>> +	if ((flags & SCX_OPS_KF_UNLOCKED) &&
>> +	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>> +		return 0;
> 
> Wouldn't this disallow e.g. ops.dispatch() from calling scx_dsq_move()?
> 

No, because

>> [SCX_OP_IDX(dispatch)] = SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,

Therefore, kfuncs (scx_bpf_dsq_move_*) in scx_kfunc_ids_dispatch can be
called in the dispatch context.

> Have you tested that the before and after behaviors match?
>

I tested the programs in tools/testing/selftests/sched_ext and
tools/sched_ext and all worked fine.

If there are other cases that are not covered, we may need to add new
test cases.

> Thanks.
> 


