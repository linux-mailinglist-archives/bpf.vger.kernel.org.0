Return-Path: <bpf+bounces-42784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2EE9AB093
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F6C28452C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C11A00F2;
	Tue, 22 Oct 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s2afD0k2"
X-Original-To: bpf@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2108.outbound.protection.outlook.com [40.92.63.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9081E505
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606487; cv=fail; b=peLIrShD5GCVZzwd6p9RPKiI7s72+LpDCqy1lnKm+WGij3XPhRGMQjZvQJH79YrPGbXVArJX+3wk+SabL5BnHVtTPHF/4nO/CF0wn57K52XyX75I+1B41HS29kz6D0ZQa2hMnH/RLWhhhVkx/DDlkPB6H8oUfrW3C80Xfxcex8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606487; c=relaxed/simple;
	bh=EXkZ8gsdcVIhhxW7A0pzTdD7vQ1b/v9TJ0nijfeZfLA=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=XXQGLnznr1c5REFSvUyuyqkWLKTOh75PYIMop8AXMRhOg8QQPB8wZA4beOYWviC2Pa63bZVvLZeL2bXmKFc6ORi1RIQLFV9doJJ4vx+gYsTdxw2bi5ExJ0WWKha+ZhPnhtPAXlyR9dF1Uiw1GcElkDrX4Ytj5sNQ5pTRkrUlHE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s2afD0k2; arc=fail smtp.client-ip=40.92.63.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+PjJ/6Cceu7gN2Q+wLMiB5bBsNP+nN4a9/FwcoWAjSBCKg9h/vDaaA/H9805B4MyRHzhkOkngEhkkPjZmq+ZCg3GRstwNKggGeAPU8LKHCNX2rLR7PLCfLaHaIjEOdQEB5VHBrr3Mwrvm2oGFwLdTDWhBEcXyYey5O2dbtewuP86csETyaxZ+9LRTprYV8g9dEAVCx4xxnQSn8bLdl3abw80e/EQQmMMq7ji8Pw+EhLo0B+/4Q7GltkbaPcZY0ANJ/ggTmA3V5u87vereoemiaxe/Opu25iOBXOfN0HrTZ4TT+LKdMvgCXviMtkrhDAykqbY0vvpO79uA77xScuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypN7o8hBFGIegH5wBzg0H2jspRmbTXFujtq9F/OelPg=;
 b=r1PQSQqOLSb4OPpCdFAdzH/fdKF8Qr1jj2eHUDVD1W0rtYR0WKn6Vvh2x+mJyzZoNrKRBTVl59SmDwv/5tYaZRBgBE8d2iW0w16b4+iClXPpUsAuVVe+Yxe3RMKR2kXjEj6m/wnHVLv4bt90JGXMrNywyFrv8UURoc+5uXEHnMfs72rHUcWIu8KaoGjBVmke1V5HR5UyVZV/tLpm2EttWR2bzEFXP2xlrcue73D9FpQsDbDjaaTYqHU5/tHo9v57gOC7S4j6eYfSISJzzmrJuRvrgtzpHxr9ufREYCDS+rc1vBJ5hqq0nZXezCuiQ5OF44CMQuoHyU51dIAOjTGNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypN7o8hBFGIegH5wBzg0H2jspRmbTXFujtq9F/OelPg=;
 b=s2afD0k2nq+ePBn0NTd9klkSfJAUVeFoWexeTpP7YqqhmflVNd/KdE3uyR7QeLWFAlwshpwRHvN4r2yQtOW/QdOhRIZIjJnxfZBOgwROdGOmB9oZW7i5+ieKsZmq13bE4KtKtH31lPKdzPBMtsTuPQubbMonadCAzz/k9iM7Kq5F12GlwKv+TmVjTEz41OcUh3eW6Tw0lYQvVJ6Ky6PBsdJsWULjq2PPaU0K6WDAEHcjpIQ/NYYO4HUW1jJpjHiBF2BkgYO2kOvbPQWUO8NUpZnym/B8mr+4nzbwy6Z6izvgUA7Pf2SfgfstswcbA3VVRS0W5yBvviwECKEqL+Xijw==
Received: from SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:10e::10)
 by ME3P282MB1506.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 14:14:42 +0000
Received: from SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2644:2e31:fd3a:ce4d]) by SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2644:2e31:fd3a:ce4d%7]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 14:14:42 +0000
Message-ID:
 <SY4P282MB2313108B00C833317D0E5938C64C2@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 22 Oct 2024 22:14:30 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bpf@vger.kernel.org
From: Levi Zim <rsworktech@outlook.com>
Subject: How to combine bpf dynptr and bpf_probe_read_kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:10e::10)
X-Microsoft-Original-Message-ID:
 <aff445f5-4556-40d4-a66b-130e36c15110@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB2313:EE_|ME3P282MB1506:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d61922-dec5-4e67-24c9-08dcf2a3df16
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|6090799003|8060799006|15080799006|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	LmiI1YGrhVL18TOKcNIcpdT/npVQGvSMOIag3En1tk8Y/Vt9KobGDpwUk31Okk2nEPRZFmqlrkLuDFHEoy9KBSYq0hEyTmOPspB0WutNhUjldFfhrlSA1W55G91eKK3nKhkSmRgWVJ9Kb4S548soSFoSkeMWKGDfHTSRxdLjtpXqCgR4PUHEMNjRlQlFXpcFj17TUQknkrvm/SLUoB570PSetR5bRPKu0DfKzu9tZ7XeAkTqZ6pOcmKO4Dhp4NiClRet1Ur8wcdrXlBkMEOszwQxJ9YOI27g5f2kT72MO/vnB6WhTMacp/1d8NwlAKgSqmZTE+W+7xtGEeaZva6i3zZnFKUE5put7w/sRHAG/Mr2YjnzOU3NHbzqWjfJTCoEshFMMFa66MC0goqQgEGT150VwJNMqhPge9XNpoltf7yFbnhrtpgD14vLuRYysmrrofZM939OdhdHVE7xVCRC8xy/g6nC4HwcQlHg1GJ2SiW5t1/wzyvdPoI1h9SjQhY0HAfa0/NJeEMNKmgwC8lvsBvJozWmWoSpKXfrzz7NiQX2VXxfATh5MwjSQ2MqTYy3ciYmofLUYgnz1PXrhl1V1URjM4OtZFEgFOlfwkDDB7+pXnox01TnoT8Y9m+nJ/IOp93a8oE5G2JAELiZHk8zlVIiiULWBUXtECs6mXFA7mI+N5fmoDT4tbIx5muzjFF1ZDvmSIxw4eXtV3SBgDjlFgbF5PoZqYTtJEg1JeEoMurExkF7UhOTQJbg+j3XeN05
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFwd3UvazFhODcybkZJbm9EamZMb1UySkU0Y0FRYkNYMWJ2NE5JRU42OHJE?=
 =?utf-8?B?STFKRVFNSUY5RHVaWWVPTWpqVm5ESnY2UTZmREZZQXpkcjF3d0RFYjQzQTNk?=
 =?utf-8?B?cE9VcW9jaWdod3R5ME9UdUtBaVBZcE5vZEpMRUU3VUMveWl1SkdKNUl5Q0lE?=
 =?utf-8?B?M2FGR3Z2Q3d5YzJITmRwcVVRTlVmY0d6UFlGRU5ydm16MmUrRjJ2WGdVc2l0?=
 =?utf-8?B?MVgzclNXRUQzSit5azZ6a0Z2ME5naEdvYjhYOGlPQmlycVZLUlF3RzVpaVVp?=
 =?utf-8?B?SkthWnJsOFh4OGFnMWF3c1ZETDNrQjA5Ty9FaWRIVEpvclc2bEhib3QyQ1dK?=
 =?utf-8?B?TUQzQmVnTmRhVXhOTkFadTJmdllMejlrRFVMV2g5aGV4KzUwTHlHdHBJOEZQ?=
 =?utf-8?B?clZvTmg1bk1mQ0J3b2pFUDkyS0MyZVZ0R0tVaURIMGFiZmo2VWpBTmtiM2JC?=
 =?utf-8?B?UWFhUDNTa2FBWWN1bGVQcnRDVWxydFhLWCt4T0R6NHZqOHNyTDg1R3lXZnpl?=
 =?utf-8?B?a05PMlh1TU1TMGVEUE5JaG1SNklGd0lPTVpUL3lPanhsdU94cnczRjFKVjdr?=
 =?utf-8?B?L0xLSDFoS1IvclFvbkFvOCtOU0xRTHoyM2FObWRIbFVxeDJ6UHJGTUNDVStn?=
 =?utf-8?B?QURheGUxRFVreGx0aTh5VmxKMWE4YTRsTTdDWC90bXJhZG1YQk0xMDhEMVhz?=
 =?utf-8?B?ZU12dDhNR200bzNuaERIUGlwaFQvL1ZMb0dkTGw3WWxTdG5BRmJsUlk2RFJG?=
 =?utf-8?B?NlZZZmoxY2EyNmNIZWduQTlnMi93NTBLQzFETW1RRlQ0SjhEd1ZiazNXRTN0?=
 =?utf-8?B?eGlka0hWb2RyUVdYUHJlOW9NeURlam9RUXViUytCOFZUWUYvZjhmV3hhZk1u?=
 =?utf-8?B?Znpma0x2MHozUVIrSjFHeENRSU5KUjFSRkJPL1ZGaHQ2dHZFU1l0YUI1VWRE?=
 =?utf-8?B?ZmpDQzdxeDI1dGNndWZEYWs2TDVNR0RwdzNsSm1wREc1UnA2UVNycER1N2Vt?=
 =?utf-8?B?UlhpTG5vQjJ4ZnYrMVpWN0R0S1pOZy90ZCsrc0FBUlYzN2doS1JTQ2J1SWw3?=
 =?utf-8?B?R3N2TUMyWlJxdFp6ZXhzaXlvQzRidWo3N3BiSGFmZkd6Vzc3STRyUE1EY1Vv?=
 =?utf-8?B?K0ljRXY3VXV5czdkY0RaQlhwSkp1c0dHOW1ocXRuNEw5K3piZUpNcmtJM25Q?=
 =?utf-8?B?Vytjem4wZUdMYkcrYUxQL1BONFhGaFJ5ZmxpRzJpZHQ4T1hrTlRCd3JVMkhB?=
 =?utf-8?B?UEQ4U3pFd0hNRHNhazUrOWZsN3hHejN0K2xQaXFQK0NpQWhKbTNpNWo1NFMr?=
 =?utf-8?B?czE0dmkvdU5KUzNDWUNMVGFSdHp1SWM1bW5NK2k5ZDg3VjhQMURBS0xPNEpO?=
 =?utf-8?B?cXF6UnFYalprZkRtMlJHNTljWjh6dlR5dkVNbC8vY09CcUR2LzRMTk1PNkMz?=
 =?utf-8?B?blZTVjJmT3FTM0NQRVlqMDJTOHdLMmhFSTAvcjhiRXFlYnhkL0ZybGo5VzIx?=
 =?utf-8?B?aEkydkZFdytXUlBiQjJJd0JQbHhaRzZkcEJHVHY5VWdHTkJRbUJFSFM5VmNX?=
 =?utf-8?B?UVlXVHc3L256Mm9MRE9LclU1K0s0NHZmZk9uY3I3eWJhWXV5alF3NkJsTGVz?=
 =?utf-8?B?anU0eWYzSTcvSWFSNHZJRVluaWNFbFhPbVM2bDJpQ3BqU0VzRU1WOUxyTXBP?=
 =?utf-8?B?T0xMQnkzdjA3RXJaR2x6OGswcXU2ZGdnbVN1Q3RrbS9vU1crWk9uUi9yZTR6?=
 =?utf-8?Q?oDzEiw5/0CyyFnEVMT4SYzeadAC4qA/6uImfVZw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d61922-dec5-4e67-24c9-08dcf2a3df16
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:14:42.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1506

Hi,

I have a question about how use bpf dynptr and bpf_probe_read_kernel 
together.

Assuming we have an fexit program attached to pty_write(static ssize_t 
pty_write(struct tty_struct *tty, const u8 *buf, size_t c))

I want to send some metadata and the written bytes to the pty to user 
space via a BPF RingBuf.
While I could reserve a statistically known amount of memory on ringbuf,
it is a waste of the ringbuf's space if there are only one or two bytes 
written to pty.

So instead I tried to use bpf_ringbuf_reserve_dynptr to dynamically 
reserve the memory on the ringbuf and it works great,
until when I want to use bpf_dynptr_write to read the kernel memory at 
buf into the memory managed by dynptr:

       78: (85) call bpf_dynptr_write#202
       R3 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, 
mem, ringbuf_mem, buf, trusted_ptr_

The verifier appears to be rejecting using bpf_dynptr_write in a way 
similar to bpf_probe_read_kernel.

Is there any way to achieve this without reading the data into an 
intermediate buffer?
Or could we remove this limitation in the verifier at least for tracing 
programs that are already capable of
calling bpf_probe_read_kernel to read arbitrary kernel memory?

Best regards,
Levi


