Return-Path: <bpf+bounces-42888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0409ACA87
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED45E283CA9
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCB1AD3F6;
	Wed, 23 Oct 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tlBffWkM"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2011.outbound.protection.outlook.com [40.92.63.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84F1A01B0
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687594; cv=fail; b=IhJMYdA3ATlhcQ8Qr057ZUSVtHIRYUnqzhe5BwlRiLGPXelXuhNNlw0vQX1xMPzqU/qGmjVIEMPKkAOw6RY5dhj3KjvSmMjO0LdtXl2SqJqQYLlwQ35GOT9RD9dgOnRC2D8Byla/SDE3LAGBp/hLKE67xETDHgOmCIN3ikFSbCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687594; c=relaxed/simple;
	bh=aennl3VQS3lu/952etZRzIeF5Q4d9kgZC6ayEmNMTwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2TArW9o6LthCnfXHNhaebJAlHufB0zCP6ZBczIhBgbeluun8kHwsx0K9kEwyfvnCijmxjjqIWtHOjkOjPlTgD0vHqNcOpMiJ3Naw19BfP0BrXzYwumkmJEofIvq1v1ue0r5pG5VC+f0FwgrBCs6qSO8r3wmaYpJiEOihe9ILss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tlBffWkM; arc=fail smtp.client-ip=40.92.63.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIOIWkh0//ow11Y9u+i0uH5mReMNYZARWwmUDggroq+zDDtA50nX1VFgzubuVuxojkjdWgxT0Pf9C4s1XfXSgrmbEy91+BIf1DSH6uMeTZjzOzYuBpW5TGFq4IVdD/Fx9tNJvNyHrfN6TPrK3m28MjcqDQ9BS7UuBLlkPajQHX/1gIBVsdvBpWX88zXpIqs6EeCl/LFJlw8ZoYANGv6DYJarx4NatVaEEd0VZmTOnr7bLK2WhSDveQpvDmiFIq6i0hkgDJETuHzlYFG+GYjQ8TeOrgn60gczXGg5Wn2gR+ZidQydrrplxclEoyDmD3oillyk6birIcjJ4PmigV6/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m74kFr9RIlsRVPSd77/7sn1sk80SyW5Km91EjSsKqXk=;
 b=fURU86NgJXSzcevhakJPkVShf8Qp5pdceiF9Txo56l7LxDNdvYKnmSoaZrdHRb3wtE+AaDnIBugHHZZkeATnlwnfHflDLAwZdGJiYq2WMcHZc543yuzdPnA4gGviD/4VFqgVLz48eDzIql7JYJx/irYdFsPfynygoqoCvg9hyIXi9dc+tcrp7q1KayGMdbokNsJhm2t5Eutc9IXhEQ1EvJCr62/wQAuImEbRkKHGyPlHcjqTeJ+rrU2tWUNdy923YyNxsaV0MbT/OPNf8zYItGvgme0HGniCZcMuE6JPtV3sKipfcfjrlvOKyno/K8oXguPPAr7D60eRGUboGeaGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m74kFr9RIlsRVPSd77/7sn1sk80SyW5Km91EjSsKqXk=;
 b=tlBffWkMFSSBbBeVrkv+9/QkZb+SOYeg4loKHSuEhoWRQvXGJY7dHtsUl6yOr0s8riMofvxofsPWIyn4lwRAnUM6vBZImpxgx9MG5C5PMtWhGRFSRskAGeZYwx6R31WWtxehupexsQ9qsWN0ReLmcNLt9nP3kdA3FacNqxOoivXScx4tnU/9cvhCoIpnsqC/6tzLJwUuEZIFbXw74XIX6EDcvrFmtSPqWfRyMAhdj3FSGbGCga0IZZH9ukm4F0pBfzDVI6zJGkkBWrVO53vdhIcgtXGr+TufY0snLEGD47C/8EQaTmlK0E4A0NVSnUeo5v3HbISTYfwmGjr1+oO/fg==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY7P282MB4437.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:274::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 12:46:28 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 12:46:28 +0000
Message-ID:
 <MEYP282MB2312CFCE5F7712FDE313215AC64D2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Wed, 23 Oct 2024 20:46:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: How to combine bpf dynptr and bpf_probe_read_kernel
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
References: <SY4P282MB2313108B00C833317D0E5938C64C2@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
 <CAEf4BzZctXJsR+TwMhmXNWnR0_BV802-3KJw226ZZt8St4xNkw@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAEf4BzZctXJsR+TwMhmXNWnR0_BV802-3KJw226ZZt8St4xNkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <2264632c-9cb0-49b5-97fc-9c41f93aeb0b@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY7P282MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e4e1bb-d279-41e4-344c-08dcf360b66e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|6090799003|5072599009|8060799006|7092599003|15080799006|3412199025|440099028|10035399004;
X-Microsoft-Antispam-Message-Info:
	Aku8Xwk/TLE+GH1d/gXc+fyiM4QwdtTlcaIVc++BVAI3UFOWqDQlvgMt2yN3+jeAFIRohZXik0HTWNZBgQIQMLblXB89xT2StIjDfxuWYi/el7AE2NH/Ar5DaDi4x9ZVOCUH05MLU8m6nsCBbGpD8d784BKYv21QOiwaXkoziUac7vZCuf13Saqb4HPKu3GzBECQVNfB8aDZ1ocv1HUSn0NghfbWz863a1lhTkJhlzB7SNAMlfCNPfhNSyC00zNVVtXpKX8nIwNIiyT54MO5VLsg5zMPEtHBjXeBi6lvcWCSuEb6W1xKyxggOcDr5gxXgMKG4yuojhyxCV4xftEydnwWnfmOQik2mPtuWSTT+dwbwF8Qp1dC53JM09o4U5qKGRLOiH9Qp8UnwLVGaAAS9ebmrxXmOBDfd2+8oLryYOq6lpSKSNbqoU2tAjuU325zNMELLtznTdqna2Ji4gPdKpm52NKPayG1L4FAz0Mh+3Gf3bQGZEOSVUwf0Ux8QqX21YDzEzlAVVO5pbugJO0v+gK+8LSrlJeD0Mhb0xksWswF7Fhrja1AUnCCeAXJAGv4SWStPLp+mT1+DyhmNOkUQE+u5DVNBIZ7ka5ieCBrQrQ0PvxKXrGa5CFAAv7fQOe2WVSpN3P4XDBGCniprJFJ2CQCYRDrJxaOJnv36XvsLzbgx+juBAksOiFzklykje84QuSNSUa3DUQFfvBBJlU8I4Cr7CellUP3KLoEv2j6exdkbCWlaOaq3n4dPRzWuS2qzzqR8odoLsuReC8awwf7qNAkdkAu2F7Yo0ynNn4PoJ1Xv0rVWpaKb4AcilQM7bl/ptJ2VoNBo8IyaK2xNdhJJA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXB3QVA4K0JUSUZ0bTRiMTdyRUpCMzRXQVJ1Mk9oR2pKSTA5Vjg5MlVJTUZ0?=
 =?utf-8?B?Q01XUnRNNDI5S1NoMXlScHR2TjlNYTlXc0FxOWR6ZW5pZ2ZUYk0xR25rQzEx?=
 =?utf-8?B?WFVFazZaQlFsZHlpNVdGRldFdG9DOTAxV2dxcTVCdm44T2ZiYUNNVE1aQUlL?=
 =?utf-8?B?Wis5bHZwUWlEYWd2ZVFoL2tDaldOMVkyM2JJNWV6MjJlK2RvM2VvbkVBc2FG?=
 =?utf-8?B?SlI5T3RpRHkwenBtcGZ1M0JPWTdVQnhxWDZUZU9nWEkzMHllcGRBVXgzbERV?=
 =?utf-8?B?WjAyaThLVnBzeHpKNWFGa3RzeXZob1N4ekl1cDRGMEt4OFhQY1ZMRjNESEVk?=
 =?utf-8?B?OHQxZEZtOEJSWkdXTldjYTBxQlB0ZzJuekNpV29zZ0NqbnFabHhaQW81S2Fl?=
 =?utf-8?B?Y05mbG82bWZiT2ZEK2x0cUgxWGJtRGRtYVc1b1NlVlRWa2g3TlJ0bFBnZFkr?=
 =?utf-8?B?dVdkYU1IbzUrQzRQbXJ4SmZZM2ZNMjFkaEQ2V3JPRC93cU14ZjU4TmRBbmF2?=
 =?utf-8?B?SXd0azBMWG12RGZYK2d6VUVrSWQxbGkwQUIvSzdmN0ZuQTA1RFozdkhsbXFS?=
 =?utf-8?B?ekNpaHpWMkovSm5za1Nqd3IxTi9lOGdNMzdRd012NGVabkFXc0JGWGdUcXBh?=
 =?utf-8?B?ZEt5SXlYYW9SREtuYWpjbnhTdk1ySk1mMTNlRjFnTGhnS1lTTjJLTEEzSUdz?=
 =?utf-8?B?Y2F1L0NXdUhkbFIyZDN0b3JveDhnazVRZUJNWktTbHJLdFpRRVpTTnFRWEl3?=
 =?utf-8?B?bE5GM3ZiZm9wNVV6R2hPOWpxK1pGUStQUTJYelJFc0k0RWtOejQyTHhQamVB?=
 =?utf-8?B?OUFHRFpmWFhuNjVOVVlmK1VEUFEyV0JFZHgzRXRtVEd6MGwrbDUvRlUrdGRS?=
 =?utf-8?B?VTRydXpqalp0ZEY5R1RmaWlzSTRrbzM0bTJCekdxaVUwaUduS09TTjJDRnli?=
 =?utf-8?B?MVV3VFBtY3Q4T0h0V1pOaGo0TStTb3NFWTBqNWhHa0RQYm1XZThRenJHQnVn?=
 =?utf-8?B?cGJBMWZoUElVRGN4RDl2RGRQN1hrWklJbXZVRDYydENWaXJuK1RabVlDQ1BE?=
 =?utf-8?B?eXE4V3M3d2MzVU9uQW92M0JZaldPa3FhMW9UVG9LQ1dxUE4yWG4xWjZpdHFM?=
 =?utf-8?B?UmFFQkJlVW5Bd1VPVHJISW9SM2hCYWhGcUw1YkFqRjl1bGxmQkFteEY3cXNV?=
 =?utf-8?B?aEFGbkNUaFFhMDdXeVFkb0Y1TFlEUmMybzU5TnNNTGtyZVZmQzUxamw1NUdJ?=
 =?utf-8?B?Q0l0VzNzaGtpUlVUYkRvMTZlUTFCanJGYmVuMWdvN25ZRG5RYVk2TnZ3MHBM?=
 =?utf-8?B?R3lUQWJ2UGdyeEc2cFdvaFQ0bXVTN1Y4bHNDWlhXeUJETGgxbmI3YWl1V1p5?=
 =?utf-8?B?QjhFUmJwT3ZQN1lsUkN3a21iL2JPZWN5bTE5cTNCaUlDcWdDTzAxekYyY0xm?=
 =?utf-8?B?eFlWQVUwV0xwT3d3RVJFSHNhVkc3c1dkcGdSeDVOVjRnNW9oSEVmcjFDQjBo?=
 =?utf-8?B?VVR6eXdWRmMrdG5MMEZtTzNhUWF5eGxNZGE3UVJuZGxURTdhaExxU1dubzdv?=
 =?utf-8?B?dGVqR3dVbHJXc3QvNVArWFByQXpQb3kwTDF0SFgyZ2NCTkE4ZnRSczNjNWsv?=
 =?utf-8?B?NlBtVVh5eDZqd0h6UnFxUjlNdEEvc3ZmUUJ2QVpFQlpQWm1PZ0Y5Vzl6UGNo?=
 =?utf-8?B?NUVmN1V2MVNtZG90NHQyekM3ZlcrSE82ekZPSk5tMGMzQVhxbXo2L3JjZERF?=
 =?utf-8?Q?2VNnwCXrTZgdojM3XAADhzX43RS4wcxCJyTLNAg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e4e1bb-d279-41e4-344c-08dcf360b66e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:46:28.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4437

On 2024-10-23 04:12, Andrii Nakryiko wrote:
> On Tue, Oct 22, 2024 at 7:14 AM Levi Zim <rsworktech@outlook.com> wrote:
>> Hi,
>>
>> I have a question about how use bpf dynptr and bpf_probe_read_kernel
>> together.
>>
>> Assuming we have an fexit program attached to pty_write(static ssize_t
>> pty_write(struct tty_struct *tty, const u8 *buf, size_t c))
>>
>> I want to send some metadata and the written bytes to the pty to user
>> space via a BPF RingBuf.
>> While I could reserve a statistically known amount of memory on ringbuf,
>> it is a waste of the ringbuf's space if there are only one or two bytes
>> written to pty.
>>
>> So instead I tried to use bpf_ringbuf_reserve_dynptr to dynamically
>> reserve the memory on the ringbuf and it works great,
>> until when I want to use bpf_dynptr_write to read the kernel memory at
>> buf into the memory managed by dynptr:
>>
>>         78: (85) call bpf_dynptr_write#202
>>         R3 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value,
>> mem, ringbuf_mem, buf, trusted_ptr_
>>
>> The verifier appears to be rejecting using bpf_dynptr_write in a way
>> similar to bpf_probe_read_kernel.
>>
>> Is there any way to achieve this without reading the data into an
>> intermediate buffer?
> Yes, you can bpf_probe_read_kernel() into dynptr's memory chunk by
> chunk. I recently wrote an example of doing chunk-by-chunk copying of
> XDP data into ringbuf dynptr, you can find it at [0].
>
>    [0] https://github.com/libbpf/libbpf-bootstrap/commit/046fad60df3e39540937b5ec6ee86054f33d3f28

Thanks! That's really helpful.

>> Or could we remove this limitation in the verifier at least for tracing
>> programs that are already capable of
>> calling bpf_probe_read_kernel to read arbitrary kernel memory?
> This would have to be a new special API, basically a dynptr version of
> bpf_probe_read_kernel, something like:
>
> int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dst, u32 offset,
> u32 size, void *untrusted_ptr);
>
> We can probably add that, which seems like a straightforward addition
> to me. We'd probably want bpf_probe_read_user_dynptr() and
> bpf_copy_from_user_dynptr() to go in a single consistent batch.
> Implementation wise it's a super think wrapper around existing
> functionality (we are just avoiding fixed buffer size restrictions of
> existing probe/copy_from APIs)
>
> Thoughts?

Probably someone might also want bpf_probe_read_{kernel,user}_str_dynptr 
in the future.

>> Best regards,
>> Levi
>>
>>

