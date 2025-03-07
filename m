Return-Path: <bpf+bounces-53518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E20A55B71
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F5F189A646
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 00:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909EBC8CE;
	Fri,  7 Mar 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bbcYG014"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013012.outbound.protection.outlook.com [52.103.32.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF38BE5;
	Fri,  7 Mar 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306061; cv=fail; b=REVDk1CSxnVmauyXJabVQDitWvscBYg0xfjzC1dweNQ2ewXCmPuKyZsckste4EyKifoHYWhetHwSLfUV6XHeIfsPSqO6srGtkY3GWHBwT9r2qWxLp8G8G68mxum6CO9+C9JocN8WLthJLsK84Yq/QC+eznc9kUHfb7nkljJhT14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306061; c=relaxed/simple;
	bh=7DoSleIsvSkakSZPwokBVkHsR8XhPw+Y4km2SgUZsAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B76qmW11mKRcOapCCFetphYznekWthHEWDqvCFPoqzQQxLtR7hXhSYQvRDD0ZbL9j3foPFdtnkfrwiX9U0+fZo5LAwgd0UoozR1esrYD7pb7wrJRgpBlk0rgEuhalvkNjYAkwHMnJ8G3geLzCiZb4EtNIZ68IVYMHQMGaYA49iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bbcYG014; arc=fail smtp.client-ip=52.103.32.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZBjW4lMFwdKQcjyx/75eurrNeCOx28nCilV01llQ2kwp9S06EMfqqeUap1lF51P5tFYKeyeQYJinixPps+4QIkvYREgZnWC0x74Z0Hu6KbLnP9kXDo+HBPOIHKfMgyFAlyWyRxDtmPgtimAV/+c3YXQvUm1mGO7ssclV9WG8DReG4pCam98rkgXxpgm9j3JD2j8OwvEC2C7zXt5NlHfG7BQyuv4D7Vkb47XIPWM2voYQcjiruWrrFXRc6vvXf6ZGXr4lXtuvov0vt6cNcS9LWjANOlSddS1Bf8LHfXwAO0dtVRspOjZr9Zxb5miDO/RFXfB/Sh5TTAg08hKMM7poA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNEB4SdPfMM28dG6iq9JokM5c5/EEbBg7Be6lFaoJzw=;
 b=mJR+ToaTw3mVSjta3lL9NeOjYs/EcOSb2VKdxHHl50uSkvFOE9xNcH9IGdOTtMYkKmwj/7P3pBzhQIntj9fLtWj1Zx7Af7zwk/Wfk9ElAh4cHiXewTR281YfFL1hZXTEvIhnPTpf90yppaO6xfy5TcxGEw+sQ0vwpFNptdNi4DRW7bAfDPuDS0uO4ssHsno/sDbeANm01LbPHjtDI+Qaj7iZov8i5lGxnXqwPIdPO7m3yPOgVef6CTcXqbHs8VueO6UzpYvAtli63rGWNahOIVTVru1UH0axSQrjMu9X6cjEdElvS1/cNKcgdlG4qzU8YI7B7mqjGLtVDdHnCVsVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNEB4SdPfMM28dG6iq9JokM5c5/EEbBg7Be6lFaoJzw=;
 b=bbcYG014OT2CM9eRVdUuGzrpUoEVBQJ5j6GK4k6ZR1NXcit8yAsRXZoXnKnQFIRP5SO3TXDg6xSp/+Xy4Q587hh+WZyZy3Mj/TOdXUGQKlRGsj7DzpnOCQtax9nF5Yyve59t4f2AlFwflyduN1cggKZoUGkKM7cjbtGEmMak1M9dkop9e69BrCmIe2Bt+qhaDC8RW5lc4lGWg9Dgjs0X61BAAWrkQnh2dLtsdYadSg91mZa8nX+r3i0pYjkfIipszXgOQt5GRU+qBSi616F0KJ4iagxZSD/FQ/4afxzhZO5/GNan/Xp87EyIpb079uiw01cgXJ3glUW5zy09Zz1v+w==
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com (2603:10a6:208:101::17)
 by DU0PR03MB8693.eurprd03.prod.outlook.com (2603:10a6:10:3ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 00:07:36 +0000
Received: from AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590]) by AM0PR03MB5076.eurprd03.prod.outlook.com
 ([fe80::81c9:b053:75a2:2590%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 00:07:36 +0000
Message-ID:
 <AM0PR03MB5076E2748256632B7A90367F99D52@AM0PR03MB5076.eurprd03.prod.outlook.com>
Date: Fri, 7 Mar 2025 00:07:33 +0000
User-Agent: Mozilla Thunderbird
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
 <AM6PR03MB50802468907B621471E451DF99C92@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8c_xWrk-kanKgOQ@slm.duckdns.org>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <Z8c_xWrk-kanKgOQ@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0485.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::22) To AM0PR03MB5076.eurprd03.prod.outlook.com
 (2603:10a6:208:101::17)
X-Microsoft-Original-Message-ID:
 <b1f07163-206e-4b28-bbb6-349d3321c35c@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR03MB5076:EE_|DU0PR03MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b270a86-681e-472f-e511-08dd5d0c102c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|19110799003|6090799003|8060799006|5072599009|3412199025|440099028|13041999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2RJUGc1UHJrNjQzT2sxMHJSb3J4SFgrUm5PMWNiVk5hNzcyRkRQQk94RStW?=
 =?utf-8?B?UTUyN2Q1L09xYU40QnhBMUNsS1NLL0RTajJLcnRVU3FFemRPdGRaWDczYmpk?=
 =?utf-8?B?aWFqQXdQd0FvMjU2QzRPemIxK05GQ3BRY241ZlNxY0ExeWdqdzNGQ0dIQnBm?=
 =?utf-8?B?RFdxN2xQTE1EZFhpNmxIRmFyQzFhc2hCYVZKdUg4dHJ0YkNrZC9JR25MMTBG?=
 =?utf-8?B?L3VaZTVDZzRMTW1Tc1N5NzlMVGloM0xJTGk5bStUdzBZY0w1L2lTNkhYVGdz?=
 =?utf-8?B?aXJYTGVNbkRsYUFGMngzZklOaGl3b0x3Ris2bDFlWEhIWVF6WTBHNkFkdXQ1?=
 =?utf-8?B?OGxESXU3MU52TFA3RDZlUkhOdHd2RzdvRDhQWnNwdnJsZ0xzQ2RXY0NReU5Q?=
 =?utf-8?B?aytrWGtFQTVTYWZmcStvRTZHSk1MUnFwbjFSR1hBVWpYYnFLVG5RejlGQVFQ?=
 =?utf-8?B?RC9JOTV3VVFiaFM2bzJPWWxHT3hoM2tGVkhZREplb3B5VEw4WnpEbytReElV?=
 =?utf-8?B?Qk1hMmJqS0xpYlJaWkl0NjdxQ0VCeGtIVjcwVWFCZ2VFNkFZend3czd0S3pK?=
 =?utf-8?B?T1pVbHVmTExRQnM2cnJFZ3p5ei9pejVDYWJFMDQrL1hVVGMwajB4cWpVNDFy?=
 =?utf-8?B?empUckFmNkNXOW0zK25VSjRsYUcxVUxVWUtTNVhWUTBRTjZ2M1lWZy8xRklC?=
 =?utf-8?B?VnluQ1IrNllMdE5HL3g3Q21qZmVBRlF3V0J3Q1VOQ1EwSFRTSmdSQjBwVDBl?=
 =?utf-8?B?UzVhNHB0alZDWFFQWUNZcjh6dG5xQ3U3QTFIQm9GWDB4ZVA4eFdYS2Y4VUgx?=
 =?utf-8?B?VC9yM0oybTRBTnBXcEZqWEtrdVJwZUppVW9vd1ZRaDBaRlB2YTBoMGcvUG5M?=
 =?utf-8?B?TTRORlplQXk4aGsyM1ROTHVhVVNBLzJJK0lXZ0FWVUswRGc3WWJNZkxYR2px?=
 =?utf-8?B?cWgzMVNtNGZVRllkUE8wdWRYNUhKeFZmVDRQMWJIR2pOTmhtN1ZGaXc0bVE3?=
 =?utf-8?B?UWNlRzE1VTQwR0NBOWdQVXovRGx3bGgyK2pxT1l5ZDJRKzVZMmhqZE43QkJu?=
 =?utf-8?B?TDhNTjZVRU5XMlM5Zm5zeU85Z0VFUVZUd3dIYmduZzl3aTdyd2hscnAxTWlh?=
 =?utf-8?B?ekJXdi9COUdxTG1yeUkxc0RUdXNSZFI0OGtuSlh0Q1RDVjJ0REVQTTkvOXNR?=
 =?utf-8?B?WWxIaU5iZGc5RU1YcUNaTzIwRDIyZGMxWGlvNmxtUUQzd2RHWk1zS0xONWM5?=
 =?utf-8?B?U01rRDFTamtmL1Q0SFhnYks2LzNDR3BZbk5GaC9URkdVbHllTVhjbGlJbmNZ?=
 =?utf-8?B?QzdxMjN6eENIUHg0WDZSQzJOb1NJSmFXTkc0MTlObXo1Vmg4V3Q4ZWp4T1dj?=
 =?utf-8?B?dG1CNDhYVWxKQm5TT3YzN0F2Vy9PYjFENlhyVE5HNTJZRzcySUMyaklWam5h?=
 =?utf-8?B?ZFJUME1rckw3Uk81b2lzUnc2Y1lrV3hjZi9pbkZEOXdZKzlPa1Q2ZlZKZFJr?=
 =?utf-8?Q?/U48Us=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZTZlRkT2xMVVZuLzBvOWVmQi9jZlVINWJzMnl2NlpFWStMYjR5VWtyNWRr?=
 =?utf-8?B?NVM1UC9nUkRaa3dTWUZtVjZ4MzUvdDBkcEcyUUhaWkVqek1ZWUlyMXduRWQ0?=
 =?utf-8?B?MFNoeG9DL2RwQk1oemFJNkhWOHJmaXhTbVRvZ1hJZzB6K1U3bUZMYjhhMVNm?=
 =?utf-8?B?azBQQWgzemdJZFNFZmhaYUR6VFNKbWRpdEdEOWFXN1BtUW1Ga1NaUnh4WXBJ?=
 =?utf-8?B?R0ZKL2RNS2JNejA4clZaSkhsNmZFcHg4eHBwMThvaUlsZkVrek1xaTJWa1NJ?=
 =?utf-8?B?YVNGZlRKdkMzNlZtNW0vdjJVU0NNN0FzVXJEU1ZYRmhGNEptb0phNzVlQXpE?=
 =?utf-8?B?R25wc2VBbFNaMjJDZi92eWpRRUtvWEVDQXg4aDRaM0Q3Z1hPRlRVaFY4eWVW?=
 =?utf-8?B?RmlSN2c1UmRYTStodXhJaWpTbDJtQmYycVR1NGhtakV1aEFHQVk0RDZSa0sz?=
 =?utf-8?B?TGpZakpxOGpBQm1GRmRyallGdWI4bFFSU1NGVXB3QTZMSGJzeHB4SGZmL041?=
 =?utf-8?B?ZzNPRmwyVVlwZ1plOVF0K3hIQjBvdTRKcVVGRnZIYzN5OVdKQ3FEUjBPb2FC?=
 =?utf-8?B?clMzTXhLR2szUUZydndGNmliaGltclo1Q0R2UWpmUUcrNEwya3ozM08wenpM?=
 =?utf-8?B?MGY4anF1WnRYTzFqWXk3aXI5YUxiKzFHY3ZFeno3cU1uZStCczd3R1d2cXRP?=
 =?utf-8?B?dVE5eE9NS3YzcHlheFBDUDdKNjlIT3FJbEZjS0E1M1YrRUN2djAwS3V0UTFh?=
 =?utf-8?B?VjhCUmRabDhaNlhVK05lNDRSNkJmcDY5bnF1YUx3M092SXVJOFU4ci9QN0Yv?=
 =?utf-8?B?MTBXUzlxOGEzZEdjVmxsM24xblFFY2JheUkvQ2p0dE55UjRGVG9LWUxMK1BX?=
 =?utf-8?B?RjdUbVBxVUt0dWRxTGNaRFBYTGR4VE55ODNlTUxna1hwcGFSTjFOOFQ5MTVN?=
 =?utf-8?B?SUkwUjZBeUtVck1wTjMvWFhXZCtYcWthSnlLT1BzYmJBTkxCT3kzbFVjWnlB?=
 =?utf-8?B?bklFbEdtLy9acFF2Wi9KeWR4TytoNkExVkN2V1Y0UkZTU2Z2Wm15amMvTUVE?=
 =?utf-8?B?djFBQ1J2V0hsZWNSWmQ2R1V2dGFmMXM5TlE2bWVnVG5JODVjOUdaR2J3b05u?=
 =?utf-8?B?dE9ISGhmQ1FXVzBKdUM2SlFISnRwVEFsYUI2VWQyaFZrekR5YmhOYnVQYmw0?=
 =?utf-8?B?QlBvNnFMSk5qVFdBWi9ESUVSMWR0UW91S3NXVTRKak1tUVVDNlRNUXhFbzBo?=
 =?utf-8?B?eUpGdEtFQkFrQ2RDUDI3MVlqVGpOaFplQ2RSODFhRE51UlhXM25tQU9IVlps?=
 =?utf-8?B?U3BxbFp0SkZ1cWtuU2pxd1ZqbzVRWVI3QmlZV0ZuUU9QUFRuV2RzL0JQNUw4?=
 =?utf-8?B?d3B6WExTeEkyQnBVeGhGNGVGSUZYSy93NHRkVHZHeGxsODFqZE1LWXozN25a?=
 =?utf-8?B?ekVCQzlKTmJBL1N5Zm1GYmNrZDl4ZE9kUTFkSnZWR1dsLzhDbUVWbmRXa0dE?=
 =?utf-8?B?dlNzRlRuZnBQZENXZHZHcTc1YzZlcEJBR2p3NXl2Q1ZVK2NEdUhaS3lKZXhW?=
 =?utf-8?B?d0Z2NjJZcldlUTVVTTVqN3d2NE1XV0hGblgxcnNNQWNVSlE5UlF4YVhEY2RR?=
 =?utf-8?B?SGZJRXJuOTZqekpLR1dyRFRFYVAyK0k0TWtjSUtkaVM1WWpNdVFTWU1saHhp?=
 =?utf-8?Q?p7r3r5a8puX+Zos1Ffd3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b270a86-681e-472f-e511-08dd5d0c102c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5076.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 00:07:36.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8693

On 2025/3/4 18:00, Tejun Heo wrote:
> On Mon, Mar 03, 2025 at 09:12:52PM +0000, Juntong Deng wrote:
>>> Can you merge this into the next patch? I don't think separating this out
>>> helps with reviewing.
>>>
>>
>> Yes, I can merge them in the next version.
>>
>> I am not sure, but it seems to me that the two patches are doing
>> different things?
> 
> I don't know. It can be argued either way but it's more that the table added
> by the first patch is not used in the first patch and the second patch is
> difficult to review without referring to the table added in the first patch.
> It can be either way but I don't see benefits of them being separate
> patches.
> 

Yes, I agree, that is a good point.

I will merge them in the next version.

> Thanks.
> 


