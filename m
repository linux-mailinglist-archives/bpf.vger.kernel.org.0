Return-Path: <bpf+bounces-45909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D09DF45B
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 02:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64051162E1F
	for <lists+bpf@lfdr.de>; Sun,  1 Dec 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA9AD2F;
	Sun,  1 Dec 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ko1OVvWk"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2032.outbound.protection.outlook.com [40.92.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB533F6;
	Sun,  1 Dec 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733017342; cv=fail; b=rqSYjpvdPrYHiAPRggGZWEY6VbCJr1Dmuj7DajclaNNX2ZNLyM2G5ODKeiRkhJ7uuw2/aFJpwVpckFPdzW48og793Q5P2MxLzwehlVuiq2ndnQiymtMe76hoU7Q1AJFlYUtHGXQFaJi3pAh2H0oXmVIEmzRlC1nt8Z8RmW1tPFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733017342; c=relaxed/simple;
	bh=QhTj9PT7d/uxN07PwDwtyFtPkypc2O8nIZTY4Z9hFBk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9lpVUMmBEUm6aPRc+Uj+XCiYMOwizYbv9hJVbJrL9os8aNxQ1rj6imVNgpJVaJ0VkGwwoGqg4JxwmklBGjBa5U7Z9SfCWPfSaUmKpJZ0X342GRYYNU3yPEv5f52xd7jAqUBzU/C8pDkFus7pqy3j20viky+j/SgNm3v7fIJ3CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ko1OVvWk; arc=fail smtp.client-ip=40.92.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApN3E+4exCpAxU/Gu5r2NvKAJK7WdtGn8nIIEnD4d8ud53JV+NBQ/sJfBo1Jm1sJN9OK5sNrczVKlzK/p1BKsWdXOPDd7SpqWc4vlZx+/TLgdoegO+eOw65+6jdb7YkWoU7AR2nzeUWvpKXD1SKncylsz0YO1f9eGO1pl2omze6M0n3VFXIk5GUNX8RA1HxGT5Y+MMf9CCor76zr6ha5h01IV/UpylbpNIcRIouPdhHlSYYfsKfk8BEwsplAPrjfXeGYeOLabbxIXYCy3D8SXfcxdO1MyvYO55YmOYeqvzgEu8beoKy+XQTHmyQhRQ3UlZB4odiQOL0hiGMAkKBtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL3P0Fn+qVcYYqrEkPp3qtYL6wUtkBVQVlXyvhqGI7I=;
 b=bG/eBROQ18wI2pT9x8C8UpfcwpZgxxu6VmKamr8QcVuP6p4mVsaOA61hFmb4qShYnFOL6hX3vUCxfsuwb+VKoGcpV3TCdi8pxGGxthSkIFzFP+aNdpBVB7yKqjJulmgssDCwebWfGdCJNlet9RGN9BJhFwasHlHdUM2f0vrWXQG9zJXiaYPTtCs6bTR+x4xJVAHSL48tII6ESkeN9lECFPplmoxac0ramaTe8OsYLjrl3JUtGSvdrXLvH3Pa3ch5XVmbnFQY7S9fU36WsBHj+NQQBS9aks6XuWX3IcHRyLnb32pmf5k3V7jwWb/7wWsSAg7gL5IwAvTTQ9yl7ciuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL3P0Fn+qVcYYqrEkPp3qtYL6wUtkBVQVlXyvhqGI7I=;
 b=ko1OVvWkwhU1dsED+nn9IjXzYnXID2paA3fmQrvHxz0mREIUXGmwk/D5rpG7SnK5j2Zrs04zjntS9U4zoYb3l0qUSeDIDAFAeS63cPKsbBXvS+lT0TqrtnW2pWE1CsJcrWYg3U3Udc6c/7Wg8fMr4Yf6/X3/NMIfKiQ3obaFEtPD2NWIzi97b6TX+AXlUcPNrLT9BghlpML7IHDzFPvp4V39xZmmOnvqr2HSGcmSfdm2nvwu/fiZmU6SCKRnZ//5eh2MelK/gswTFTweGpAc9yLdH63dllyKR54julVgKZcxICaaCGTCYkCSVK+GBzAywsDNvvUqzZ4xBhN1WgKxRw==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY8P282MB4353.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:25e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7; Sun, 1 Dec 2024 01:42:16 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8230.007; Sun, 1 Dec 2024
 01:42:16 +0000
Message-ID:
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Sun, 1 Dec 2024 09:42:08 +0800
User-Agent: Mozilla Thunderbird
From: Levi Zim <rsworktech@outlook.com>
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
Content-Language: en-US
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <23df9a78-4b79-45a3-a914-75ec77dc1726@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY8P282MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e8c7fc-1519-49f4-b2f7-08dd11a96292
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|7092599003|19110799003|461199028|5072599009|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnIyV3p0THAwR0pOVTdhcTVLTkEwcTlLb2RReGRUWENiMDdORUZsZWZPb3ZV?=
 =?utf-8?B?dFBUWDZ6Z3hsY1FwTEYySmtxQzJ0VSt4czI1dWtrbnBhbWhHNktGM2RrSkpI?=
 =?utf-8?B?ZVVsTEE3UC9HRVNzZDU2V1Nobm5ka2dVSmgrU2dKaHJrampmem9kelp4SHF5?=
 =?utf-8?B?ZHhSdFZMU3p0UDRBQTZTWVZzMU0rRVd5UFhUY2ROWEI2Wm9lbW1MbkpBNjNo?=
 =?utf-8?B?QjRMZndXUm1EREQxUUpKdVNJZm1BNWRKZWgxbUhsejZsTjZQbXZsQTdBRTVq?=
 =?utf-8?B?RHZHbURjVVRrcER6ckkzNmE3TDVOZnZhVFJvZGJpYVBPc2hOMWg2U1JieExm?=
 =?utf-8?B?eHk2SGNPdlVPQUxWUzlhdEtBQ28rV1Rtb0JacUhFcExBMmkvVThvTG5oSlJj?=
 =?utf-8?B?UTdiZDFicFdhdmxSVmN4WGNvbEJCQUN2VEt3VEliUTBmNzJqWVJFTlo0RGJB?=
 =?utf-8?B?NVlvSWhvRThKWThEWGZETXZ3UFdDN2EreFE2UDlnY0lmYlFpK3BZUlNEL3h6?=
 =?utf-8?B?NHhibmx4bDNqUVl5TTRPRVVLUzZHOFlwSVZVQmgzM1A2SE9YeGRmdXY2QU5C?=
 =?utf-8?B?MUhtRGhnRGNLdTZiV3E1ZFppV0ZKNjhmV1ZlNUhIYUtMSUE4eEh6SVU4RVk0?=
 =?utf-8?B?SGJqdWtIdTlWbzEvMDZ6Q2ZNN0w2bXRxQjBrVHZHTWFqaHQxVDJRelpvbk04?=
 =?utf-8?B?NkZZek16bGEvanhDMkhrSUFBWHNkVHAwYnBLOTFRUUUwWWQrNVhkQ3kwcTZR?=
 =?utf-8?B?anJGcmFvc2VYaVZFTlNaZDRoQ2laTjhMdFcwci9NNDhCM0x0azduUUk3VXFm?=
 =?utf-8?B?d1QvN3dBNkxybWVmQktjbFZwbEJaSlArSnUxWWxpNTFyRkUvaGJINjE0eExE?=
 =?utf-8?B?Uko5ZUV2aUM4cHFGNVRXZ1hUcVNCSFJENXBWYTJCYndjMU9PVWV0QlMyTVNs?=
 =?utf-8?B?cytYbXZsTUxFZWg3RkhYMm9VYVVBUDJvWDllTlllZnhhOHFockpuMmFXNmhk?=
 =?utf-8?B?dmVraGdIa2lWK0I3S2NuRGdJeVZMeWZxcTdDZm9TZTRwUWV0clFKcnB2V3g5?=
 =?utf-8?B?a2NqdERnVmJEejdia2ptbEo0eU53TjViTEl4azViWE81Zm1hc1kxMU51Kzg4?=
 =?utf-8?B?ZDh0aWpvRks3YnBRUWxHUXcxMGlqcmJoeEJrZ0Q3NTg3ekxhWnVsTzUvaUlo?=
 =?utf-8?B?ZGFBQzRNOWJjNm8ybXhwamxncW13dkNqZlp2M3hJaEFHRXVaT2taTldCR2Ft?=
 =?utf-8?B?WWJVeHJ5bit6d1AvV1REdVdaSGJvcGFPT2t3VWg3bE81R2JOMnNJSllkUlF6?=
 =?utf-8?B?TU40Y0YweG9oWERrK1l4NDRpQnV0SUhJTjkxb3dJRm8yTjdZSnRKUzI2aWJt?=
 =?utf-8?B?ekxnU0kzSlB2RnhuUUQvWlBwWTlPYlBiRmJvL0VzMy90MXpkWnI3eXl0a3RX?=
 =?utf-8?Q?IXbwus/x?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxZVGo3bVZma2RIcEZ6WlNxZEJURUtmUW84ajM5aDgranNudHZ0elZoNVBP?=
 =?utf-8?B?d0VZUXhyNzRnaEdlWVk4LzR6N3Z2ZWRpOE5TVmZORVB5Q1o4bDh3djExWENF?=
 =?utf-8?B?UjA5MXZERFhkQkpEVU16aFhuWGVoVHM4SDE3bzhqN2JXN2pScVRkVXIzb0RR?=
 =?utf-8?B?TXFtWEFZS2czY0w1S2tLYVo5M0N6d041R3JuRVFoQ3NhTHRmOWtkc3lSajh6?=
 =?utf-8?B?WC9PUTg0TGFGeitVMFg4R1d0NVB1NG03QzQrYm1VczYrY1RnQ1huTmNUU0l5?=
 =?utf-8?B?YUg3ZkZtK09kQ1RKK1lZeFJMV2NYd09MeHQwUU82bWpwMnZ1Z3I4TVkrUU15?=
 =?utf-8?B?WjF0TjNYSFV0TE13a0craVlqRExFbTQ5T1dqS3FRY3FnMVhONlZEOURSeHl4?=
 =?utf-8?B?RDRHZTNFcWs0N3liRlJ1aVBFL1FYd0xKcC9mczZQQjlxODRrQ2N5MGcxeEF2?=
 =?utf-8?B?Q2xycW05anFReVZQc0ZHSWdlbU5PQUlmSGpyRjEwZHBrc0hFYTlqNlFpN0kw?=
 =?utf-8?B?eUZ6MFFJRTJyMVN2NkZkYkVvcFFzbTVpSWJWdUExSlkyeXJROU04dEt2cGdY?=
 =?utf-8?B?aDNPYjhuTUdBS3dsUmhpZEdEbXJtMVBrdkZpQ2ZXdlRWQjFhVjFZN3VzeWsx?=
 =?utf-8?B?bk9qRHZIVml5L24rQkpzSnpHMjg1UWIzOXN2L093UW52aC9LbzljM0hrYUww?=
 =?utf-8?B?c1MxZTUvOFErblhmUWVOTVJraW9UUW5xYXNrK3Z0UTNGS3RCdXRUYmRHajQy?=
 =?utf-8?B?YWhUUGZvTnBTKzYxMFdNL3Z0Tmg0Vmc1cHpXRUdZeUtPZUNUdk5Hd09LMHRx?=
 =?utf-8?B?eC9PbTZpOEEvM29pcUtwSFhycmJ4dDlMakUwWnBuM3lYOFlyVXpQc0I3Z3lH?=
 =?utf-8?B?NW9SYlhlRU9NT2hZc1lLM1lCdjMwVnB5U0N3VWJuWVJyTm55cy9hbjJVTnRG?=
 =?utf-8?B?NHFLTEtPVTJCS1NWbnFPeTc1aFBKM3NOV2kwSWdHdXYrclIzZTAzTUorRHBH?=
 =?utf-8?B?YVpOYjB5WC9Sb2UvejYvNFc2L3FDQ3dZamVwbVNIMjNEcHAzQ3lTOGVPemxQ?=
 =?utf-8?B?V20zdVJJRE9yZGovZEc4WTBWYUpOa1JtUWxUanJvbTRpc21tNnJaTFBmVWov?=
 =?utf-8?B?U2pwUHBzeGFTSnpDL3JaL3p0aGl2b2ZPcHoxOC8vbldIU01vSDBvTUc0d0Zi?=
 =?utf-8?B?UlVYbXJsV3NuNG9EbXU0d0FxWVFUR29zc29tNkxPbXdMYlcxWTlvbnZ6VDVm?=
 =?utf-8?B?UC9LYjBHeGd1ODU5cU1zandHenpwU2R6TWpvVnpFT0tEV1YyV0ovOHE0cDRm?=
 =?utf-8?B?UW0wMWJXM2lkRzJIeUU4alJsZDVuek90UEp5MXFoeTB6cGVlVEZnbFArZFVC?=
 =?utf-8?B?cFU1cHZuS1pkSFdWbFlib01WMVIwZ3J1aFc2RFl1eTRBb0FlQmF4c1MwTW5E?=
 =?utf-8?B?RlpPVU81UkoranBhWGlpN2pUNnZ0OWJKRWx1RW1sMFBya3Rpa1J1SnpqWGkw?=
 =?utf-8?B?aDljalo1VWxEREJPMi9ZaHVremFOUndWeU9nZWpwd1NERmRRTisxV3FUSjcv?=
 =?utf-8?B?djB3S2hhREU4ZkQ0ZTJtLzJEU1YrTEZwTTdrWW4vZk1peEh6ODYxZEJWalBM?=
 =?utf-8?B?TnUvZG9sNTc5NzBTSWhrenc4S3J6b1VJYURIVXpBQUhKcXp6UzFYTU94N0Qy?=
 =?utf-8?B?bjNKMmE5N2hlOERpWFpIMDY5eEVQRFZ4TzBsc29waCtjSGlodVZkalQ4bXVB?=
 =?utf-8?Q?c4I9SBrl06DihEiW06ievI/0JQvbV6kjI+NHdW6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e8c7fc-1519-49f4-b2f7-08dd11a96292
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 01:42:16.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4353

On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
> test_sockmap.c triggers a kernel NULL pointer dereference:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
>   ? __die_body+0x6e/0xb0
>   ? __die+0x8b/0xa0
>   ? page_fault_oops+0x358/0x3c0
>   ? local_clock+0x19/0x30
>   ? lock_release+0x11b/0x440
>   ? kernelmode_fixup_or_oops+0x54/0x60
>   ? __bad_area_nosemaphore+0x4f/0x210
>   ? mmap_read_unlock+0x13/0x30
>   ? bad_area_nosemaphore+0x16/0x20
>   ? do_user_addr_fault+0x6fd/0x740
>   ? prb_read_valid+0x1d/0x30
>   ? exc_page_fault+0x55/0xd0
>   ? asm_exc_page_fault+0x2b/0x30
>   ? splice_to_socket+0x52e/0x630
>   ? shmem_file_splice_read+0x2b1/0x310
>   direct_splice_actor+0x47/0x70
>   splice_direct_to_actor+0x133/0x300
>   ? do_splice_direct+0x90/0x90
>   do_splice_direct+0x64/0x90
>   ? __ia32_sys_tee+0x30/0x30
>   do_sendfile+0x214/0x300
>   __se_sys_sendfile64+0x8e/0xb0
>   __x64_sys_sendfile64+0x25/0x30
>   x64_sys_call+0xb82/0x2840
>   do_syscall_64+0x75/0x110
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
> This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
> size(8192), which causes the while loop in splice_to_socket() to release
> an uninitialized pipe buf.
>
> The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
> will copy all bytes upon success but it actually might only copy part of
> it.
I am not sure what Fixes tag I should put. Git blame leads me to a 
refactor commit
and I am not familiar with this part of code base. Any suggestions?
>
> This series change sk_msg_memcopy_from_iter() to return copied bytes on
> success and tcp_bpf_sendmsg() to use the real copied bytes instead of
> assuming all bytes gets copied.
>
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
> Levi Zim (2):
>        skmsg: return copied bytes in sk_msg_memcopy_from_iter
>        tcp_bpf: fix copied value in tcp_bpf_sendmsg
>
>   net/core/skmsg.c   | 5 +++--
>   net/ipv4/tcp_bpf.c | 8 ++++----
>   2 files changed, 7 insertions(+), 6 deletions(-)
> ---
> base-commit: f1cd565ce57760923d5e0fbd9e9914b415c0620a
> change-id: 20241130-tcp-bpf-sendmsg-ff3c9d84e693
>
> Best regards,

