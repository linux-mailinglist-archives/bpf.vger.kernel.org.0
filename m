Return-Path: <bpf+bounces-50705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1769DA2B6E3
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 01:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467DB3A7A10
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339F10F9;
	Fri,  7 Feb 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kk4Mc06Z"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2097.outbound.protection.outlook.com [40.92.91.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6277E1;
	Fri,  7 Feb 2025 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886533; cv=fail; b=Jlhisy0dvvgA8mK/ynpF8W161lxFF6T1agybiNLnzAazGYA8wIYhYOhHAfgdA4VaVmr+h0BY5PSro98az+VwEDmERRwxwTcRgyEpWTyEW0WNuAOI6vexPD7STdIzIEU+uY1IL0uwDXDfvR6vjZsKgBupM9/LzBy3PUqxMi7L/UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886533; c=relaxed/simple;
	bh=HMetcBsyf7+GnbxX2syQCHo6OlkKd+qM9Fhu5ukZfZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B773g1LsNW1lDSNQukwpKy5QUCCpv1o3GFbZ2rxXPqeSthauDXky/E3luzsiy2MJU11ZVx3y5TJM0aREXGB/KZ86pJF3xnySLAb+dOlISJEPaLV/9bFGMsLhYWzailqTNFP4sUSEyVzIg0eObTswOQ9EDPsNe46D6AMVrVZsaJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kk4Mc06Z; arc=fail smtp.client-ip=40.92.91.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYRQPr3FMPrg7u+qBTveWiBKZxMPuTVdMAbKhYCGaGPO8VEZwdDs+BZ/9OEMSALD3RxDTdxZbmhPvAlbhAVarvd6kImFO8Y8Hh8xUz9O+/fkJQ427QDMmDrOn/g3MyGmuPK1Qge78S4dCMxE1Jm0gm1ZTldNRPoqZw87kq6vqkb5/OwOuSAIx03bgigN2nZzgzuhU8mKncVXpAurn5fkEyT3TN6YMf5iTUkZJjsDo5Bv/gFu02p9gYRlxPiMhn3wJxToRUVeuR5Eg8jHTgPDLBMcYVZxqHg2T7lJ4kw6lHc7yL4u6rFCs4O+6G36nasu7kFH142lW6G9LCYTFCtC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0mbydsZ1fPhBfjFuDofgNZKED+uwVqxtMcnbXMqZeo=;
 b=V7Y7hLHJkwa6Yl7tUlgEjA47q4/L/EotTtgSm/5zKv2Wp2rNy3pmaB6btLUk6Iw+pXkXMDm+oqm4sVSrVILftwKkLKsGTVJozg+AIWf/Ch1KOrxX9rCJAgGQpv++CDn2qW4LaMZ3+wX9Xawlc7ZVXHkFMSm3zA4QIzS/Z7jmeewj7vA5Jg+HcUXeLw0R/BkKJBzIf7HC1qxXqMPUe8e3P3LilFQu0SbS5aVcupg5RrgqMrPzqvKY4101jNtd8OQgVVL5nInp3BcG9z8lL5XE+xJEviN1hy8ORbdgekWZu8M7aHIUv1TlLxQnb9qJu+ipt1dr3DgTCr3Od5qTCnkcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0mbydsZ1fPhBfjFuDofgNZKED+uwVqxtMcnbXMqZeo=;
 b=kk4Mc06ZGjmm3Zd2e/5b00lJj5yp9KLV+v6GVgVpI4WnFsKhUNvvWJTxfiCFyjar7Kj8IG02RDoEHUSwB6SC+toicOd5wSka7657DaBSaDNahIyZmQ9ko9lekYUDw2VNw5mcvGgXj3Qx9xFACZ6gR0Q83pWaKxGcnUXyh4XEXW6A9zYuLN9QwvQmnW32u+pjupZu9hdrm7GJpuIon7w1ydferBNvZkg/jBKd1FEamVjKhyiSkZB/UnsQ4+QMttxEgvev3xjU5ZsUQfyDKNFKkWXvScp+0Acxxn1wrOvKKKCm4BkGSEMVb3aHH7OMNUdfDdQJvcyOfsCQ/2ZFRhpQCQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB3PR0302MB8920.eurprd03.prod.outlook.com (2603:10a6:10:432::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 00:02:09 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 00:02:09 +0000
Message-ID:
 <AM6PR03MB5080B3CF92374D617347BC5299F12@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Fri, 7 Feb 2025 00:02:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 2/8] sched_ext: Add filter for
 scx_kfunc_ids_select_cpu
To: Andrea Righi <arighi@nvidia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, tj@kernel.org,
 void@manifault.com, changwoo@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z6VIFPucwML5YLSJ@gpd3>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z6VIFPucwML5YLSJ@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <572116c5-d517-434b-a35f-5b3d30244b69@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB3PR0302MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9cdded-c608-444e-1ebc-08dd470aaa35
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|6090799003|8060799006|15080799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTlSN0M3T2xkYUJZR1oyWGplYTZzeVRYeWtRSzBzMUVrZFBQeDJNY1VjYmdt?=
 =?utf-8?B?VDR1NUYxN2g0WUUyZEFYVU1kSnJWWFJFcHhCYnpLNVJkSG9pR1VOd291aXg2?=
 =?utf-8?B?RDV0dC9yWU54TnBSU3QzMlNVTmg0M0EwR2RpN0NlbDdvc2xaT25iTmdRQ0p3?=
 =?utf-8?B?dDlBM1Q1WTZZY2RKeWVFY01jQ1EybCtnSldZekZsOVE5RkU5ZDRQVEdXNDVo?=
 =?utf-8?B?WnZHc1BVZkhKdTNFRW05cnVsNmpERTk0YkFma1BFWDQ1MUJ0OHZKK0hLbXFh?=
 =?utf-8?B?UWcrMXlsSlZVNW96WTV0V0hnL3NOcWFtUmpGb1NGV0RNNG1hWnFLamx5R1lS?=
 =?utf-8?B?Z1VjNlVlYW1hWTJNRUptNlY0VXpTNWpZN3E0eWVtUUMydzljdGExTFVBVkVi?=
 =?utf-8?B?cGdTZlp6RmdRODc2bnhTV21zSkN4RUZxUE81Y2xUWjFtZDk4SndpdnpxZUds?=
 =?utf-8?B?NHY5UWV6cGFWUEhiTWZHMGg2MDhGUXZNRmJ4dk9BVUtUQXRiNVhRdlg4OHJW?=
 =?utf-8?B?OGtaVVlUWkQwWVlldWZENXBiZVNiRFlCTk1kWTgySGc1MGZ4ZmJPSWcrSExQ?=
 =?utf-8?B?NnUvSmVJOXZ2U3lEY0Zoc1B5c3l0b3I4TDVaNUYrZDJGMjFETFg4SGNyK0JQ?=
 =?utf-8?B?L1htREpzdVRpbE15aUtoWEVXOEUzdTE3dlV0cFRHUkljaWw2NmFndHY2emJN?=
 =?utf-8?B?SUcxWVYxVm1hbS9qN1UvNVZJNGFudlVwdGtUeWlVSTh1QzVhZ2ZuZ1NMemlP?=
 =?utf-8?B?am8xQlVRdjRTUUhpUW1wMXlTQXBJT1kvUnR1aTdxazdDdnBlSG92UEtSNFht?=
 =?utf-8?B?MnJ4VHBIWlBWNVdiaVFJbUVHbUdyWFFSQTNxUmxZeW9tQm9hVWNTc2JTZlNx?=
 =?utf-8?B?a1lpZ0o5VzkvMHUyVlZPUHFoRGdHWnlQTjZZc1ZMKzNNTndmUDUvenNZaGtS?=
 =?utf-8?B?SzFXdm9JK0FCeTJNM0tJR0IwLy81R0dvSVRnV1FwVy9TeWtUM2FqdytkSkpt?=
 =?utf-8?B?V25lN2ZVUjhGQi9XcStOcy9TNTJteC9hOW1DUVg0c3JUYVFhbFFTK3M5anhB?=
 =?utf-8?B?U1pCNDE2QU1SSXpYNjNOdVNKN2taTmh6K0xDajFOSWhCLzVyL3VBTGgzeGkv?=
 =?utf-8?B?SWNMSWN3R0oyM1MrVTg0MlBnSi9CZXR5c0IyNTBTb2dpZEVIbkY3Z2lVUERz?=
 =?utf-8?B?bzhoaVYvMXhKMklBMnhPTlZmVWZicDdqVVVyRlpZUGFFckwvblRxL24yT1U4?=
 =?utf-8?B?eUFuMXdNYklvdW9ENWRQTW1iRjJOQUN3dklnQmU1NGlIemplOVJEN3ZzYVk2?=
 =?utf-8?B?eG10LzU2Mm1qMEJpcjhUNGw5UGFKcThLQ2ptaXRzWmJ0enR0Qk90MEJUYTNG?=
 =?utf-8?B?c09qNmFicHZSMU53Y3hjL0NQM0VwZ3hjeWpZNDhhMGlnKzA2R3F0MG1MUVBX?=
 =?utf-8?B?WmZLUnJ2VDdFRUQ3cjBaSmJhUmRuMTM2TzBRUjdGc1pyNVNYWVQ3TGZDN05Q?=
 =?utf-8?Q?ty6Qio=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpYR1MxOG1vNmR2SzdpeHA4bjZVQm1qM2JDUFcreUhNVGhEOVFXRGpSbFNl?=
 =?utf-8?B?WEZ2elAzbENQSGVXQnNzbXE0UXM5UWdtZHZocWhpOUJEbWtVdFVHZXFKWkdM?=
 =?utf-8?B?TVNmeGVMSDgvYWlGV25aV3ltalJJbWZyQXJIVVl3dVVOTHEyQ1k1c2swbmlQ?=
 =?utf-8?B?YkJSSVloN1lmQzI2NXNtSVFSMU1VZUlQNi9wT3doOHkrZ3lFSWk5Uk9HSVNY?=
 =?utf-8?B?VXJjb2tMUHhQV1N1UXhEODF2cENwcTAxVnpBNitjUWJzQmNCM3Uyc2lRNTBm?=
 =?utf-8?B?UG02ZkxXdFhrKzlIVXpERk9CZEpuRnl2VnUyMmJmR3ZNNDl5R0VtdHRqWFBj?=
 =?utf-8?B?RFdlbjNKQ0pCNXBPdkhibVVsKzlnSmVNclBPV0w4U004OUdJb2pmUk9rbFhF?=
 =?utf-8?B?RUExaHg2MlRFV2cyaHUvMnFmV2hjbjNvMy9rSVRVWUNXWjgzZ2FOVURNSTZ2?=
 =?utf-8?B?Y3dJbG5jL2NLSmtlMlgwWXpYbkdRTVR3QTJTWTIvRmZkRGtGcmJvS3ZxSlVa?=
 =?utf-8?B?bTkxKzI2SjNodVZLZTRtcnMrUFQ4M3AxZVFyMSt0ODhxaC9ZSTJ4Z25xcXJz?=
 =?utf-8?B?QVZFNUU4WEJFQ05RTUJmbnZoK0xVZXFlQVBIczdmbjhuRVZXYjA3Ym10dHZF?=
 =?utf-8?B?QUdhZWIwcTF0RnVWTVIwY3V3TTg1cTUxOTRzMENFekpXaG9zcWtCM2JYNnYy?=
 =?utf-8?B?czQwdG9VM1pLWTE4clhUYTF4Y2dKZVpGL2tIOWVxOWpxWWx6SmhjdnEzZUk0?=
 =?utf-8?B?b2Q2WVZLRUJiWGZHYVdPMWRFakFwV1VwV3N4RFBLRUw2andyUWtTOVVuQURB?=
 =?utf-8?B?T2FjUERZQTBtbGhPdTdvaEcrNEtyM09LMGZXTzBadnUrSlpPSWJHY05LSWMw?=
 =?utf-8?B?ZHVmNUU4TXBVRTluZDdqeit5WUt6RG1sWUV2VlFmWkJiSnhhMTFtdnBSUE5Q?=
 =?utf-8?B?d3h6Zkg0dHhLYnczYlJmbzljcnJNK2JqcTRiL2Q5cUg0cnE3NG95RjQ1d0I4?=
 =?utf-8?B?dTFHUE5BcW95YlRoVlNlcUxhdG5vc0xzWXpZRDVCY1VvdTh2U0FQbFk1WU44?=
 =?utf-8?B?T3FxVm84Si9zdGlhQXlhWGt4cU9YKzNySzZ2SW1UaEdJQmJSWlFJb0RESGVt?=
 =?utf-8?B?b2tLSmJTSzJwUk1WeDRLaHlmb0ZmcFJrVlIvWWtJclZKYU9QQTVuR1dacURB?=
 =?utf-8?B?TUlMS1VDZFV6QVRKd1lIb0c3WmlTN2xDU2Z1RmU1UTVkVTlPcUNJbkhrS2tQ?=
 =?utf-8?B?UFBwQUMrVENkcHFjc0xlNlJBeFZUaldEWEYzSzVvMDdEdG9Bc2VEa254cjFH?=
 =?utf-8?B?bFVOOHZUQUxINktJNWxGbGFYRGJxVXk4eWwxbWc1aGdRWTNtV2I1SmR6UmxF?=
 =?utf-8?B?R1EzRllhRFZtamJCWjZGT2FpdnlWY3ZJTk5DcjE1clJoM083cWN1V096bHU1?=
 =?utf-8?B?MWc2S25RU1NURCttbTFXYXpPWkJLTnl2N0pNS0V6aXhGOFlndGFCejhIN242?=
 =?utf-8?B?MlhGRVN0WVA0cS81NmZNUG9VN0RaUCtSbnEvMDg1Ujdaek1CQVVLWGJscitn?=
 =?utf-8?B?cWFrOVZaNDN4WFVMbTJKdzFabjRMUU9ucHkwWVVOLy9ES1VqS1lNV05pNVRj?=
 =?utf-8?B?THY1d2ZPd3FBdkN4aFJuVG5LKzVreldkajdwdFRKWFZKa3R3NTAydTdGWWhR?=
 =?utf-8?Q?c2WBUhF8zRpDTfl6Qf4l?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9cdded-c608-444e-1ebc-08dd470aaa35
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:02:09.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8920

On 2025/2/6 23:39, Andrea Righi wrote:
> On Wed, Feb 05, 2025 at 07:30:14PM +0000, Juntong Deng wrote:
> ...
>> +static int scx_kfunc_ids_other_rqlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
>> +{
>> +	u32 moff = prog->aux->attach_st_ops_member_off;
>> +
>> +	if (moff == offsetof(struct sched_ext_ops, runnable) ||
>> +	    moff == offsetof(struct sched_ext_ops, dequeue) ||
>> +	    moff == offsetof(struct sched_ext_ops, stopping) ||
>> +	    moff == offsetof(struct sched_ext_ops, quiescent) ||
>> +	    moff == offsetof(struct sched_ext_ops, yield) ||
>> +	    moff == offsetof(struct sched_ext_ops, cpu_acquire) ||
>> +	    moff == offsetof(struct sched_ext_ops, running) ||
>> +	    moff == offsetof(struct sched_ext_ops, core_sched_before) ||
>> +	    moff == offsetof(struct sched_ext_ops, set_cpumask) ||
>> +	    moff == offsetof(struct sched_ext_ops, update_idle) ||
>> +	    moff == offsetof(struct sched_ext_ops, tick) ||
>> +	    moff == offsetof(struct sched_ext_ops, enable) ||
>> +	    moff == offsetof(struct sched_ext_ops, set_weight) ||
>> +	    moff == offsetof(struct sched_ext_ops, disable) ||
>> +	    moff == offsetof(struct sched_ext_ops, exit_task) ||
>> +	    moff == offsetof(struct sched_ext_ops, dump_task) ||
>> +	    moff == offsetof(struct sched_ext_ops, dump_cpu))
>> +		return 0;
>> +
>> +	return -EACCES;
> 
> Actually, do we need this filter at all?
> 
> I think the other filters in your patch set should be sufficient to
> establish the correct permissions for all kfuncs, as none of them need to
> be called from any rq-locked operations. Or am I missing something?
> 

Thanks for your reply.

I think I misunderstood SCX_KF_REST.

I incorrectly thought that all but SCX_KF_UNLOCKED belonged to
SCX_KF_REST (including SCX_KF_CPU_RELEASE, SCX_KF_DISPATCH, etc.).

I will remove scx_kfunc_ids_other_rqlocked_filter in the next version.

If you find any other mistakes, please let me know.

> -Andrea


