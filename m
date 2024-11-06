Return-Path: <bpf+bounces-44158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC479BF853
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E783EB22584
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1220C489;
	Wed,  6 Nov 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qmRaz6Xh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2096.outbound.protection.outlook.com [40.92.57.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D25B1FB;
	Wed,  6 Nov 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927159; cv=fail; b=Pky6epOQcgkQQuxEtMC7D5xR4QozYwu6Xo5Da8t4gSDifzZfMHY25QU7d/rk6Go/DlcrHMBxKyMvB/AAsHdAuijVayuAgsbm04QmO46H7+lRsvk45nGpT4Jq7ZNPhHUc+C2P7WMgvkYhCfzMu/Nr/xDXu2VKSKLPoGqaNLkTxgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927159; c=relaxed/simple;
	bh=D6G8KgFxAPPx8oID7HQTCFAu8bfkEcHXuUIAB7tNRyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1nsnSL5mrsoEevDD8y6ni97h3zxKvwev1mA4+DsCD4Wrb9zJr34v7946tLAZiQd0IJstdGMG/0EJTEwmWf9agB+yDePiY6MPx95947j//i/VmtvZmb1YsHrlTyTXkDzm+xzF51Xl03qh15sptmt0t3h1b68FGpXslUrnaBbLYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qmRaz6Xh; arc=fail smtp.client-ip=40.92.57.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJSCrI5QVJywvLZjTyXN5dT2hXP8sWvz2MeK2JzPS1+98Oe11GRoiaRCcUTG2hogUsfu04UmiPw26WQ+xsAAEhNcsBo5BkmJj6y1mehff254MWS80WZvQp2xF77vdg5Q4EF8Eon3nNwEFDQ2KnDVOzpdUn7floVvvwGsm59csCsAiuiaFHNQcYufo5Xdio8lSEdSpNcn24PrCD25vJCykQp06rug+ZNHc+ZxlfhZ28Sryad8obsXgWq9E7+UlUsb4PQ5xbiPmQUy4bn2QEMypTL7dJY8STml2saWn8Snzdb1QSHvJf0c5Z7OOrgH3cEAe8ZIY8MNh2qpEM19ZV71dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn2unpiUoKQ3SWphk1hHSTaDTfBiAyNduVYvwCd/6KY=;
 b=ZSpsuGNGgsRfH3BSm1r11MsHiuJRZtsoIhl2xRyrRV6BGp1EQLFMXKrS7PQX+Q3zHnyi02b00JzBNbdOOV/t0A8ViIj4v6UXmIIHMhDqMpL7jah+k/Mdhrx2l6jE+uEjmOD5ygqxsnlooaQYxAmJP5yihI8PwckZes0RZGBorAgkekXTH+5YsAoB8IVDVKBjg53opDvnnf5ocK3XwOhd/1eDEwlsIxGq11u0E/Bf735A4oqBdn/0XckR7oh56Mg26V6B6RKy/hCqDdCfoxtZQsosIcuQIbB0tkKDV7zvfn+9IBvg3r42FOOeKJm7vSbloeXNazmqy3vo9WyPF/SOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn2unpiUoKQ3SWphk1hHSTaDTfBiAyNduVYvwCd/6KY=;
 b=qmRaz6XhlSkGlpL8DCPm/IrWedbob2rkukC72gxy83u5QXMO82nswxk/rwrth0gJZeF7nUTZw9g4fMVdHW5f9s1z2JctqRRjJa02+6vr3CSGLUxt2Jz5T4zmK7iZgYDUFEEXoexY7W+RZl+ErDV41frcBduzo9yNkfXJ1l6F6VqaMUkAF8+I7l2SlqTKN6kZSaI+G0cgK3OubfSjadebkxwi3L4waLZybxUeIZm2b+CszIl7dkRreLm+kwiTiyKijDMtb3ZB5xy4m6nihgOlhySSY9sMtKtQa2X811L7vnH6uWsheFJWF0j3VgiTe8OniPte58AlTJjUoJOMEn4k+g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DBBPR03MB6988.eurprd03.prod.outlook.com (2603:10a6:10:1f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 21:05:54 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 6 Nov 2024
 21:05:54 +0000
Message-ID:
 <AM6PR03MB584873E3A7333047E28E25B199532@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Wed, 6 Nov 2024 21:05:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584846B635B10C59EFAF596099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTeU4bj8qyTLng@mail.gmail.com>
 <AM6PR03MB584814D93FE3680635DE61A199562@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzba2N7pxPQh8_BDrVgupZdeow_3S7xSjDmsdhL19eXb3A@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAEf4Bzba2N7pxPQh8_BDrVgupZdeow_3S7xSjDmsdhL19eXb3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <21c66e7d-3c9a-4809-935e-1c6f04b55b34@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DBBPR03MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecde277-cc8b-46c7-8278-08dcfea6cd42
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|19110799003|461199028|6090799003|8060799006|3412199025|440099028|4302099013|1602099012|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlBNVnF3Ykhpa1RVWEVSeXdyYnNtcnQ3eitNSHNhVzRVSmw3RjNzYmNpOGt4?=
 =?utf-8?B?ZEJEcTIrejBvemUrdmx2VDhGbHhXZkdlWVVzSk9mVFBzZnhoYTB2bXVhbDBQ?=
 =?utf-8?B?dXFIbGZBc3RsbU5Nd3VYNzVHNHZ2SGFnbmRIYjZiWEE5aEhNcm1XR01SODQ5?=
 =?utf-8?B?YmIzL25ydWdXeWVrQURhd0tLMW90WEdRcjdUYTQrOWw5RVdpS2hWZDcrZHMw?=
 =?utf-8?B?RlBoeFMwMEp3bEFacFIwV0s1Ly9GNU5wLzFVcVd0ekcyUndCa1VEaVJXbjhD?=
 =?utf-8?B?MFV1d2I2RzJaUlc5SDZGaHZzdUJiOWU1V3FFTlgxY0hIMUFmc09kU01VWUhR?=
 =?utf-8?B?Z0hRQnJURUVab0YrMW1mSmRMOXc5T3NRL1d0ajI3VHZpTVZ1TTJUTjZkTU9o?=
 =?utf-8?B?MHVnSTYrNFI5K2dnUDlGYXgrYkVFWkVaeWMwUWdjaVc0YkZOZTJtSkZqcEYx?=
 =?utf-8?B?a1ZJOXByMVJtT2hRTVh5UXdJZFRsUnVEUGhNdFM3TWZ4bStYVVgxcXNuK0lO?=
 =?utf-8?B?WjMvVkxYOExaSFRoaG5DU2h1eUN2eElneThPcFczSFVhZjVkdnJCcVlBcVVl?=
 =?utf-8?B?cTRndFFtQ2NHMkhSMmFHU2ZDWkF3YUpnSHFiTENMRHQwSDdLNjVXWEoxN2Ey?=
 =?utf-8?B?RU5XcUxIeE1yS0FXeE5uZHdnbVpRbzBXMjZzamRwS1hhbkRXb0JkSnlydThP?=
 =?utf-8?B?QjlJTEVabHY1RUlDS3pkTVJXUnE0QTg1SjVBeHM2dENxck1qZUtOcTd4LzF3?=
 =?utf-8?B?dTJrRnRYR0Q2a080ZmJlc3grRkRnYnIyM2dpeGJUNXpSUk1XR2hPYW5aMFVC?=
 =?utf-8?B?TERzOE5KaU1DMGd6Y2VTUFM3aFM3TVdWWG9vaWVVajJnbjJGdHhZMmdmbzR1?=
 =?utf-8?B?Ylc1NWlSRGtDb1V0MTJNRy9IUXpudi95ZXhxRm9tRm5LcUFHSC92NEk4NzZs?=
 =?utf-8?B?b05Ud2FKTGJSM2tHV09NTVBDQXdtUXFGRHAwd3U0QVpXbSs2NmVxSmJQVGVr?=
 =?utf-8?B?SDRjQmNSdGNGQzRSK0dWNXllTGxZenY3Y0tVcVZ5NWNjVGFwNllCQ0Q2S2NZ?=
 =?utf-8?B?ZTZsNjcrRVBVSXE5aEMvcVJEbTRFMm52cDUvcTRxYk1VdzFzSGNDeXowME1k?=
 =?utf-8?B?R3dIUWI4ZmptUW9qVTdudTVveGFiTnhTRk9weEx2dFYrOHRIaE9hWk9yZi9O?=
 =?utf-8?B?NEl6TnluM0xBdWUrS2JNYmg0NzdFR2oyeHowaEhONUtVWTA2eTVGRDVPV2dh?=
 =?utf-8?B?UVRVV1FLMEppUlc3K0NwWEh0NUJ1eFV2bkh4dEFpVmVFWVVMVXZyRDZqbDlL?=
 =?utf-8?B?V0hNSG16TDZWd3BaOXZ3c3g5c0lpTFpsR0hhbmQ0dTE3ZTE1Tjd1SzMyeE4z?=
 =?utf-8?B?Z1JTMTFrU0FKcVhoY2pLNjZyMnIyNXlMTkJvWHgyd0VZekh2alFpazBQeTZK?=
 =?utf-8?B?Q2xZWGVCMVBZV3ZkL1dGZTdXaUUwU3pqQ005dVEzMGJSZExLdStLZzBtWG0w?=
 =?utf-8?B?YU55ZTFodVMrTDI4cy9DTGI2SzREMXhjZVVoRVhiNFpFOHhkVGZRd2ZSemNL?=
 =?utf-8?B?elRDUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUhXQndlUFZVNUV1MjR6K3duY1FLUm1NTmJRaVRSYnhEREpKbEZOWVVDTmI4?=
 =?utf-8?B?NTJzb1BTWjU4TldqdWYwVG94SnpqazFzSkNwQzYrVFdmcVNRa0FPcWRqd0ZL?=
 =?utf-8?B?ak9CZXUrZVBxTVZRTmh0UmVEUmdMRUF5em9LYVo2T0lSTWluOEU3OUxqeEJ5?=
 =?utf-8?B?Z0kxcVpyUVlKUllJL0RnTUQ0dmxEaHN0R0pRWVY4N1FBd3J6MnNPb05aUEh4?=
 =?utf-8?B?WThnTUVaUGdLY1lpK2crYmRwZmZnVnl4M2Y3QnNQTjlPbGZvN1oxSlM1aVNx?=
 =?utf-8?B?eFpoZjJIRTRSK3EzcWIyRmptUWpidWxQckR0bVNhdXlIdDNVUmxQVkRnYUdF?=
 =?utf-8?B?a2dvWU8rUDJuS1JKd1p0cWkzbk00RGU1WGtmNk9hd3lNTWJ2c0VpUmRVMHE3?=
 =?utf-8?B?N2EwOWxBYWZNUU1FOHJGSWVVb0wwaUwwYzREVFZ0QlJMbFpGZHhRZHNXTGh0?=
 =?utf-8?B?T3RIUC9sS3ZDYlIvVnhxdXBYcndiejBtRnhraUNwMlhuZUFsbEdEcW1LM3hx?=
 =?utf-8?B?MHQ0REUwalBUK3VRMTEwUXB4eHZnck9ZZlZVY3lpYnRNOG5hYXlKSTlZYWox?=
 =?utf-8?B?cWNjWHEzWVMrV3VyU09ZN3hsaFB0am90b2hMOVBBS2JCTkNUcHpkVE1TZ0NL?=
 =?utf-8?B?cWhjSmxIeW14L2ZwWUNYZjdTUVRFS0JLMG9lcGR0a1RQc3ZtZmZqcTR6c0pE?=
 =?utf-8?B?Y0F1azZ5QklYeS9sd3I2WjZGb2NlZ3NjQ1F5RTBSUjRlaW9SZzZNSThTVWJS?=
 =?utf-8?B?SnZTaGxZMmxPNVA1aUZrSjFJdGNET2R1Q3MyVHZrb2k0TzFEK2xxSkFSaHhj?=
 =?utf-8?B?VkFXbGhLSGJmWnZZdU45Rld2UmZwSnRUbFJLS3h5OThYbmhLTTY5U09ocXpP?=
 =?utf-8?B?QjFRZVRQbUFaWWdza0hUUHUzRG9CV0RRTEZsdExGN2d5V09TQUJ3L2xEQ0sz?=
 =?utf-8?B?cUx5ZFhwSFgvS2E3ZTFodU40d3F4TnYrcFZGWXJTa2Z1Q3Evcnh0V01uTGRC?=
 =?utf-8?B?ZTM2eXRGWjdaVGlqSzlQOUgwTGpTRUZsUWVWYUk4UHFPVk1EVlJ1SWpCMCtY?=
 =?utf-8?B?U2paZ3gwOEc3Sm05QVlMMDczKzgrUnRkaWV3ajRsZ1ovN2c0dm1ZTGVjZzNp?=
 =?utf-8?B?RVZHaEVpbzZZZ1h6YWlHSGtWaVhMQVpOZkVaakd2MzZIeGxnTW5xcEpWMkZJ?=
 =?utf-8?B?aXB1YUpGbFRZQVNLS08wRGlVTlBxK05UVk9PN24rbjhZRTZFZStwS1h0MlpH?=
 =?utf-8?B?bzZwN2xRdFJOTlFKVnRvRzdmZU9OYURhL0NEU3NOTkp5MDFwanJ1elAydkZR?=
 =?utf-8?B?VUIycHlzYnlXSDI5U3FCaWg4RzdObkhmWkhzM3hPSlliTGx3TTZSakpMVWR2?=
 =?utf-8?B?R29wRkprSmpIS2hJU1Z6MFNPdG5LNVBLVHJKYnRLVjQ2eEYvYTRpSE9sT0tt?=
 =?utf-8?B?UUlsRE9UUFkvbEloZUliSWxJNXUwVXZKYVp1RndGTVJZK0xyOVkzWFQxYWR4?=
 =?utf-8?B?cmprZ2JGdnc3RVl4aU45Q24rdmd5a1dFL21DTjBZSmFVZmh2RVp0UFFxTG03?=
 =?utf-8?B?QWtidGlnRVBiWGZkRXdqWllYWkd1WkNQWUF6RU92T3NiaXJWS2RSVHl4OHlo?=
 =?utf-8?B?ZE43UFNES0J0OURJN3JuQWFndjdCbzl0SlVUWngwUmM1Zlp1L2gzZlMzUisz?=
 =?utf-8?Q?mUD1ciK6B+hFuEKyAWhg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecde277-cc8b-46c7-8278-08dcfea6cd42
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 21:05:54.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6988

On 2024/11/6 20:02, Andrii Nakryiko wrote:

> On Fri, Nov 1, 2024 at 1:22 PM Juntong Deng <juntong.deng@outlook.com> wrote:

>> Yes, users can access file->f_op, but there seems to be no way for
>> users to get references to struct file_operations for the various file
>> types? For example, how does a user get a reference to socket_file_ops?
> 
> See [0]. Libbpf will find it for the BPF program from kallsyms.
> 
>    [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_ksyms.c#L13-L18
> 

Thanks for telling me this method.

Yes, then we don't need bpf_get_file_ops_type().

>>
>> Yes, I agree that it is feasible.
>>
>> But there is a question here, should we expose the internal state
>> structure of the iterator (If we want to embed) ?
>>
>> I guess that we need two versions of data structures struct bpf_iter_xxx
>> and struct bpf_iter_xxx_kern is for the purpose of encapsulation?
> 
> Yes, that's what we do for iterator state structure, and you should do
> that as well. bpf_iter_xxx one will be opaque (see other examples, we
> literally add `u64 __opaque[N];` there).
> 
> But this bpf_iter_task_file_item will be sort of internal API that is
> returned from bpf_iter_task_file_next(). So you'll have something like
> 
> struct bpf_iter_task_file {
>      .... additional state ...
>      struct bpf_iter_task_file_item item;
> };
> 
> then you have
> 
> struct bpf_iter_task_file_item bpf_iter_task_file_next(struct
> bpf_iter_task_file *it)
> {
>      struct bpf_iter_task_file_kern *kit = (void *)it;
> 
>      ...
>      kit->item.task = <sometask>;
>      kit->item.file = <file>; /* and so on */
> 
>      return &kit->item;
> }
> 
>>
>> With two versions of the data structure, users can only manipulate
>> the iterator using the iterator kfuncs, avoiding users from directly
>> accessing the internal state.
>>
>> After we decide to return struct bpf_iter_task_file_item, these members
>> will not be able to change and users can directly access/change the
>> internal state of the iterator.
> 
> Yes, you have to carefully set up bpf_iter_task_file_item, but you
> could expand it in the future without breaking any old users, because
> you only return it by pointer and with BPF CO-RE all the field shifts
> will be correctly handled.
> 

You are right, in the next patch series version I will use
struct bpf_iter_task_file_item.

Could you please also give some feedback on
"2. Where should we put CRIB related kfuncs?"
in the discussion section of the v3 patch series
cover letter [0]?

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com/T/#t

Then I can fix all the things in the v4 patch series.

Many thanks.

