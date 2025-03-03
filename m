Return-Path: <bpf+bounces-53112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCFA4CD55
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B3D1895927
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971B237180;
	Mon,  3 Mar 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="THy/mLfN"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2102.outbound.protection.outlook.com [40.92.50.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE501E9B3D;
	Mon,  3 Mar 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036378; cv=fail; b=jSi43rOFaA2Ry+AXJhy8+ij8dAu1slccJEkRgHT08RCHuVnxBseUT7MII14pC354xRyzPY1WppWtCSvd3iPWNsWWFQv4AW/xc9O+5PTgiBtJpSSphI2jW3mOFz72YmwBg5liCZyzzRDZBH9OW8tE8KOT4KkuBfhi3u/5FggKhEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036378; c=relaxed/simple;
	bh=OevsSB1mpboG64JtamGjBb/ct0RedgahdqiUvWw3OOM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ucqY62cNKYjUQfbjjx2kM2+KovYtZBby2l1HxJx28e9a2nlRxPWdmJJ7sSbsVyLN86Qw31zfnjcpgSVCJSxcY6C3fDYzhUk3dhp7sSbZlmEHhgJVtqRznVmCaH7+7uNon3n0z7qb1NgZq9v1a0R2HJHjqziuYFJSUPS2hvb9X0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=THy/mLfN; arc=fail smtp.client-ip=40.92.50.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVRIV03o7Hbs0QoIF9f6hoCeLdIxQIRXVV2eYL2AGCP5i6uFi1B9UsOgxVNH+os+Gavw7p384jLNaiATNlAKfFYrhJ7pcqCxAJidXLp9k+PO3feMGwFBUjEZxZZtbtDbeQyDs1IrjbETLO2LyCjX6mISupt55GyGNzUvkB0uS3j7p2ufSvJpOwyB/NeLezpjWIB03BzYyo0dVfFJQM5yRNF5RNiitDLAag1l1xIbTve5CqXe8pQ1xL36DIOYgHTMn9/evGtzyiyke1FZzoqNv9SSce2+RtqP38ows0SCxglHtN7m6U6PJ/uc3LLMqhb90fq1Gz7nAfOu5O8GCzPJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzTj++itutZzhT7Mnw7r6wy6qqUJfLqOYT1oAEszqBo=;
 b=qgwRIYEeIHVc2/HcRfaM/HVkPjIf7zftd0F2Pksh17hvUlf+NHojnyyv9bSk6pToOA2bHLRB9UVdqFklEZf9k8VwWXNjT9RPsoUvc+AdfevbJ9QGVikRtL/4QkUEAevyIY3l96x91oeE8GZZcRWCwcBhCs6ooLr9iKI94fbgQs9NBWGgD7tDmIMHOP33C7VpEdHA3yuvp43NBnwf7VyibelxxOTSZsFSQBI7dn7PAcSIqDGh7h8fhlQihv7T6ntSAf1jC9d2fgZMbPXpFzbKrc9kcdZ590HfDper9nDy4yCvKe5j8Epm5iHCXv3rwnPnzB9cFuTPgYB4W3JllkJSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzTj++itutZzhT7Mnw7r6wy6qqUJfLqOYT1oAEszqBo=;
 b=THy/mLfNCgKW1/Fgq521wjZGE1ykjCXEsqEAvyi8bQM55dKSS9iSC5zblJGqUTumMYxUU/n+1exQaU3zXNUWW49+jW6EmRdTrskDDbLsaxZF4lBHXz2ehQnO11a44BabjemmGBgJz8WxNZa17nIROP0T4tB2CI6Lz8+CKEwPgUbhH3NftpONrW71a6UM9r5CWZv304sdFkMRI5CYDanOArnff/jZWT4AjUnqwgRl0ssxU5hmMsX/vvl0SYN6opCVWCArdKRIrn6zNkrckv1hzCUyTWpoTQZ/dWTQKVVGyoUeAiM2PjlwDlKfRkgCYFqxDYwDJyaPpPAo+Jj5GGdyew==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM7PR03MB6149.eurprd03.prod.outlook.com (2603:10a6:20b:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 21:12:54 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:12:54 +0000
Message-ID:
 <AM6PR03MB50802468907B621471E451DF99C92@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Mon, 3 Mar 2025 21:12:52 +0000
User-Agent: Mozilla Thunderbird
From: Juntong Deng <juntong.deng@outlook.com>
Subject: Re: [PATCH sched_ext/for-6.15 v3 2/5] sched_ext: Declare
 context-sensitive kfunc groups that can be used by different SCX operations
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8IxQy9bvanaiFq6@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z8IxQy9bvanaiFq6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <d278bee7-6914-4509-ae96-297dae5caa75@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM7PR03MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e4b06c-1669-4498-cb2c-08dd5a98299f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799006|19110799003|5072599009|8060799006|440099028|3412199025|13041999003|56899033|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1h5QmVESVFzWExlRW1GZVM0T00wcGlvcjNEODBIQWRSZVNnRjUyejY0MjhL?=
 =?utf-8?B?bkVSV0ZmMVJHdHVCWjRKenJkQmRmdTFLTXdtSThoQUU0MlduODhQMU1VaE93?=
 =?utf-8?B?a0RIcTNlSTZPdFg0L3hMR0FKRCtibkJEN29NZTZTaVQ0R3IrT2tQakEwWDQy?=
 =?utf-8?B?QnppdFN5L2d4bnJDcUduTWdQRk5kVWdpRXBXUkorVWhLRHptTlZtMm9KYWkz?=
 =?utf-8?B?dHBRb2lialFZbU5TNktsK3dBMlJURVNBYjc4a1oxb05jWEI2Qk5KcTgrb3Q5?=
 =?utf-8?B?dWdCaXJseklOTmdlbVlYaDR2WkhHMzR6N0kwazFENm9oTms3Y3pDNERiV24z?=
 =?utf-8?B?L3FvWFFERkJKdEtWNHhYZk5PTU8rUm96alhOUnRxQ3ZnZkVjeHlOV3hLTGky?=
 =?utf-8?B?N3RoNU43WEdzYi9hS2F5QW84UFJub2RFZHVLNWtoVytzNGNURWhlOG05Tkds?=
 =?utf-8?B?ZlpPdmREUHcvczExUUUweEtMbC9UdFpJMTByYUQrRllEYlE3bVdvQTg2akw3?=
 =?utf-8?B?RUM2M2w4Y0Y0VGVwVDdkQTlxVUlGUUM2NFNLRmNBVVFuMWtJUmlBc29jeFFY?=
 =?utf-8?B?VGgybll0SG5LRkJlTkZ4U0MvQkE5L0VscllGZFVTK0NZNVduRTRtaUVJVWdE?=
 =?utf-8?B?bVJISllPWmZXV0V1TVIwbko1TWdpWFhBSURVc0swaEViVmlMNXhNeFY2alZv?=
 =?utf-8?B?Rko5d3FxUWs1NUZKZlNOZVl2U0tTQUc0d0VTcndWQTVCNmMyVWI5bEtSV05s?=
 =?utf-8?B?b0pORUU5MnU0NjUrTGU5MXgveGFkWmlDU2tnM1oxcm9xVVhPWnRQVVdPMFN1?=
 =?utf-8?B?dXk1Y1o3TFdtR01HZXVkY09Uc0tLVXQrNjRoVEhOQmZNS0VXcnZCUW5ubUNO?=
 =?utf-8?B?VEFRcHUzMmpHM01VOG5aeXhtUTdYTU9sZmJWR3lLdys2b3MwNk53Wk42bnpw?=
 =?utf-8?B?WHBWcHB4S1NiOWNjMk9QOVp5Z0loNlFaZk5NLzR6ZEJweUF5NmJMWXB3V1Fo?=
 =?utf-8?B?S0tLRHNLbUhYeFZZT050VC9kcXVjWkJHM2x1QTA0QmJBUXBzZEwvaEhhQTBI?=
 =?utf-8?B?YjVTbEJad1FhcVNrU2FMTSt4dzFKVFRhajhoNWZKSG5mMXlhRUwrdmdYSGts?=
 =?utf-8?B?THFPVEs0Q2UySU82VXBPemNaZk8wZnNicnpuU3RGMndkOU15d0p6RnZhdzFW?=
 =?utf-8?B?cXBDa0Z0UktsL3Y4WlhGbTRGWXFwaXdtM3k0TWpkY3c4c3dYVm1iQ051NFYw?=
 =?utf-8?B?bGN2ZWVjeDRzRUl5SzFyakpoajB1alJKb3dMbjNrajV1eVBPbDQzckRuSnd0?=
 =?utf-8?B?MkxjUWJ5c2tGSXFxMTNuK0VYUVdDZm9lWmRyRUhjTy8yRHJmS0hSOVA1ZjV3?=
 =?utf-8?B?YnAyajNVd29pNWh6dVFDM1Z1UTJnV0EzOEJzcFFQeUl0LzhDSXcrU0hrYXFv?=
 =?utf-8?B?NFZ2R3FaRUp5VnlIZUtCckpnTVhHUDdZMDlmN2RtODZxUUpjTnJsTDBJUUxJ?=
 =?utf-8?B?bUhVVVNrL0t2b3JLV2RIdCtkK1JZWVQ0TFlRdFdxWXZQdVl6cmNaZXdTWU9G?=
 =?utf-8?B?S0x4dz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXZ5cWtsSkkxWW9hL3VxYlZ6emlwQ3RvNitYUWJCQ1ZleXlyMWlNMGlBRkpT?=
 =?utf-8?B?UFEvdUphYlM2b0twWGx1UytBbVRRWDkxRTdsMWgxUDgydHRhSFJSVWhuWWVo?=
 =?utf-8?B?RjYrN3lwaW42anhvaE42VmMzR3IvNGFnZXdVS2paS0gyWG9PUE1rVEQ1MWsx?=
 =?utf-8?B?V0syWVV5S1liUjV0RHlYamRQRlBuNWNJUHlONEpuR1FITGtRQkN0Z3pwS01P?=
 =?utf-8?B?ZEpwTGhJdEhGWGNzRFVmV0xrbWhmUDV6b1YvaENJWEZhcFU5c1h6b0ZOR0Jh?=
 =?utf-8?B?RjIwVUV0U2NJK0IxQXladGtqNTlPTk8xNzlLNUlQZGtpNnlQb1E0WkZQclE1?=
 =?utf-8?B?NU9QbTdIZHNJQlhCU1ZyT1ArUHZtamhCR0JmeDN4cW9DdUtFM05QdmxUTTlv?=
 =?utf-8?B?MktTbFZFMUFlV2I5b25TTHNwUzVSOENlallLMXdzNWdXMU0renliZmJ1V3FY?=
 =?utf-8?B?YmtiUUpZMi92K3VCb2o4N1dYd2tvQldqdnhaZEtLbys0cEpWb2lweHVKY21C?=
 =?utf-8?B?RHFxM3VCaGdHdWh0c2Rjak5QeUdGVGJ0UmJVK0VMbHQvK1VUSGVXT0llYzR6?=
 =?utf-8?B?WFIyajkvc0NPTGh1WllzbE5FSmpoeWFZTDRlNkRKUG8yNUh3M3BXSmZWYjdL?=
 =?utf-8?B?ZXEvMnRPR3BVbWdjNnVuRENPVW5rNi9ZTXBJOGxnRlRFcSs5WURvTGR3OFpM?=
 =?utf-8?B?YnVyWUJ6SDNBL1FZK2FZQXpVRlBqUFF5SWhSalVCRXU2OU9nUE0xNWt3Z3lU?=
 =?utf-8?B?SERocUU4V2tKL1RQOEVIQ3pxYVpzWkxOTndOUEdFU0tSOXExaGJRMldoVC94?=
 =?utf-8?B?TWFuOE5zdUFSUVZlbVluVERDV2lveGFmaHZmS09uQi93YUVzK21WUEw5QmR2?=
 =?utf-8?B?a3VZN3J4SXV1TzhGWnpWWUJyVnpBWnBxYnhlMkxIT1lJTlloNUpiNlVGTDg1?=
 =?utf-8?B?K2xoT3gvc2l3NDVpSWJhU1p2bnlZc3E0d0JabGlnZk90SDBwcjR2UTcxU2dM?=
 =?utf-8?B?Zm41TUwvUE84dmp0eEZveXJCMWpjOHBLcmpKaHp0bXpOaUw5V0pPVWNDZWNa?=
 =?utf-8?B?Tm5EN1lzR0tBZFY1NnA1dHdjZTh3RUtYL1BtRzNYWkdTOW4zbnFQWTM2eTVU?=
 =?utf-8?B?UzJtWU5oTHZ6eDd3ZWk3dXdlSzJkek1PeVhIUVp1L3lJOENFb1JENE5iVzZI?=
 =?utf-8?B?bERPYTl5SGhzWCtYV3Nqb3g3cVA3aTZpNHJ2SUZIMDluUnE1WlZUWHdRQnFI?=
 =?utf-8?B?dzVpUzZDVGtQRHJpcDc4eW1ZTGgrVzkvbUZHVEFOdHBhMGpkTEZyMkdGMldx?=
 =?utf-8?B?dnllL3ZSWVZRbVI1dkFseTdGSy9NbFZTTzJncU9Sa2JDUUNJUmFkd1c2b2xW?=
 =?utf-8?B?eVJhVlRCcHNKNzRUU081NXpDSjg0TDRjR09EL2FZRk5oQ3VoOEo2SjBiK0RZ?=
 =?utf-8?B?N0FXTW5oVThjRU5zbll5UnBpSEowWnlQWjEzWExDU1pydzZoS3hkemFFRWEy?=
 =?utf-8?B?TUZQTytZbXJTbDc0MFVtWklIL0VUVyt3eEQ4RUxqUG01a3BZbXRnYUdNVk9Y?=
 =?utf-8?B?Snp4M2VCUjJwczdlcG82RXNKOWxOTXZWVGpzdHB0d3k1V2ZTTmdBQVVKajds?=
 =?utf-8?B?V0lsQWNPOFpWN3JSL1M4czJ2TStSbXI5a1BiRDBwVm1vOG5nVlJXMGp2cmla?=
 =?utf-8?Q?QfJrjJMt+iYNcqnIBBcd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e4b06c-1669-4498-cb2c-08dd5a98299f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:12:54.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6149

On 2025/2/28 21:57, Tejun Heo wrote:

> On Fri, Feb 28, 2025 at 06:42:11PM +0000, Juntong Deng wrote:
> > > > Return 0 means allowed. So kfuncs in scx_kfunc_ids_unlocked can be
> > > > called by other struct_ops programs.
> >
> > > Hmm... would that mean a non-sched_ext bpf prog would be able to call e.g.
> > > scx_bpf_dsq_insert()?
> >
> > For other struct_ops programs, yes, in the current logic,
> > when prog->aux->st_ops != &bpf_sched_ext_ops, all calls are allowed.
> >
> > This may seem a bit weird, but the reason I did it is that in other
> > struct_ops programs, the meaning of member_off changes, so the logic
> > that follows makes no sense at all.
> >
> > Of course, we can change this, and ideally there would be some groupings
> > (kfunc id set) that declare which kfunc can be called by other
> > struct_ops programs and which cannot.

> Other than any and unlocked, I don't think other bpf struct ops should be
> able to call SCX kfuncs. They all assume rq lock to be held which wouldn't
> be true for other struct_ops after all.

Ok, I will allow only any and unlocked to be called by other struct_ops
programs in the next version.

> ...
> > > I see, scx_dsq_move_*() are in both groups, so it should be fine. I'm not
> > > fully sure the groupings are the actually implemented filtering are in sync.
> > > They are intended to be but the grouping didn't really matter in the
> > > previous implementation. So, they need to be carefully audited.
> >
> > After you audit the current groupings of scx kfuncs, please tell me how
> > you would like to change the current groupings.

> Yeah, I'll go over them but after all, we need to ensure that the behavior
> currently implemented by scx_kf_allowed*() matches what the new code does,
> so I'd appreciate if you can go over with that in mind too. This is kinda
> confusing so we can definitely use more eyes.

Yes, I will use more eyes and be more careful on consistency.

> On Wed, Feb 26, 2025 at 07:28:17PM +0000, Juntong Deng wrote:
>> This patch declare context-sensitive kfunc groups that can be used by
>> different SCX operations.
>>
>> In SCX, some kfuncs are context-sensitive and can only be used in
>> specific SCX operations.
>>
>> Currently context-sensitive kfuncs can be grouped into UNLOCKED,
>> CPU_RELEASE, DISPATCH, ENQUEUE, SELECT_CPU.
>>
>> In this patch enum scx_ops_kf_flags was added to represent these groups,
>> which is based on scx_kf_mask.
>>
>> SCX_OPS_KF_ANY is a special value that indicates kfuncs can be used in
>> any context.
>>
>> scx_ops_context_flags is used to declare the groups of kfuncs that can
>> be used by each SCX operation. An SCX operation can use multiple groups
>> of kfuncs.
>>
> 
> Can you merge this into the next patch? I don't think separating this out
> helps with reviewing.
> 

Yes, I can merge them in the next version.

I am not sure, but it seems to me that the two patches are doing
different things?

> Thanks.
> 


