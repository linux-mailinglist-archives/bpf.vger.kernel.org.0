Return-Path: <bpf+bounces-46062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED029E33B9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 07:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C404E283E1B
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADA17BB0F;
	Wed,  4 Dec 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tBQvBW0K"
X-Original-To: bpf@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0D16F851;
	Wed,  4 Dec 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294964; cv=fail; b=Ph6PXFryuBfeayq6HEm/qEVGp7RpUGgMceOVmHo5J2joebFeSCjb7Rqo1LU/k+F28Cb7G+9rxd84jF7etVEq/gGgUyfwewIybBRVOOqI6OEJtvtt+iLz0ZMQlGCE+0PX8pcgfa89fGAXHKihBCrrMHuhsgCwuA/DsFthTLONMFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294964; c=relaxed/simple;
	bh=KW1+Ah7/x+wp/unVkb4vVV3pyUEJnxY+XozXxgS43gI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HwIVYC+knMIh8C9whgd6cHqF9iDlpsyJT9x46tluvEspJOrJ/Rz80Vqvk3VuNmFR7O5AGkRUjb1ojS3vkLfBz6BoivPv+wLB5r8O0neK3W6ixDZcDW2YBVxFocoS5PRUdxld4bKHXOS0jSNkci1E3yfiv32W/dEV5+rHee8hIwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tBQvBW0K; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9vLcg8G+0l1RrHurxYLe47pciaad+FXFthy4Q/vkp920jGKiBBO30pgklJONgusUuiO0+Ym6f97hrBTrXNoPIVLupIsPOzR0NPuAaYd2AN0Sz6EuWkojF6cwYPuVR//mD+plO8O4cG+yN51ryiQFn7z2JmkqJ/HD8QRms/YihfwqAu31amI7S+vDG1BhqyLks/x4LP+y5HB57ECiHaZeDObdlVbMnozOyXLYB6J5z7MkKv0D0ZAVDUE7nxZei86tg1RqH7IIDNLB7GuO5eBiIAXsr/WOdmmpftZT3fTR+72EmkcE4dakwgm4ameOfMzEGeN0/BcU4Zx1H4enQP+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCv48iaevrFt70+lyFxnVBqOK/keDMGBOiwV5YphSf0=;
 b=ZkJEIEYlHvnp0EMeQtVZupjGS9BraaOa/O5e/XjjhOCtFlxH2DjVAXDFxxxr4OL2hiilHtdoZmnrOFOZpd5I4vQKfM+g78+7dRrLp2iBdDfEmYICl3BjGCwm5FOJbrOr63HP4qEpGTHtDMwqrj7EzpZ/0+DpvxAKZ/aIZeVQTtwXZPyMquLb2S2RD2ALNE0tmqtjamHXjO9aje3ylOQZ0Arg6WgJivgipjvDYhNKNF79QLXOfL1vZmTescENV/XXql0oW4aHPg0QuMzr+ZSyDNwUfEs33QyCg+G9T7ZVKzTUW3dtsvq4n+Z3fFySdf5ZzQUd7yVmT7ih1hLmWd7+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCv48iaevrFt70+lyFxnVBqOK/keDMGBOiwV5YphSf0=;
 b=tBQvBW0KckmNf5NU2oDVi1RAfxjJZeCKiw+6bCDfdRf4oNbuSmW1ofYYlET4SIQ6bxxr2AGavM5URe/RhbFttXKlJ7ZYLwVYDrmj7E1zyhopCaMU13nIxkr3UrWwfSq1l/NCCq15nv5vpWVkzpqKPB+BDMe6vnjGooTEDKSdyAZalZTln+B3DSdnrGrOKFjIylNeTJmCNEVXv/x8kY4tpQzbzNjJB2hsFgQy0kNK4rrGRGNd5uYBxQNTH4dwiU1c53CtakzHsaU5HwKOoQ+HOz+BXD5loLXmyDgCkzU9hhax0S4/WnIwlggKarxdIlXKjlUc+i6slZzZhfzHekiE5w==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SYBP282MB4054.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1a5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.10; Wed, 4 Dec 2024 06:49:16 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 06:49:16 +0000
Message-ID:
 <MEYP282MB2312EE60BC5A38AEB4D77BA9C6372@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Wed, 4 Dec 2024 14:49:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] Fix NPE discovered by running bpf kselftest
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <MEYP282MB23129373641D74DE831E07E9C6342@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <Z0+qA4Lym/TWOoSh@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <d31ea0ac-5e6c-4a14-9203-3440c0fafe92@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SYBP282MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3d9ef4-bbcb-43f2-ed77-08dd142fc534
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|7092599003|461199028|15080799006|5072599009|6090799003|19110799003|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3dJa1BGcnk2aVJ1OHZ3OW16K3pNRUpRclJkOXkwZkZkY2pmS2hRUyttWlRV?=
 =?utf-8?B?MHpMcFh5ZHdONGZRMGNYQmJ0QzZkQ1hCQ1ErMXlrdS8zUTBXcTBuNHZQOWox?=
 =?utf-8?B?WWZ4clRKOEFBd2lya2pCcE8zVGhZTHYxUlNPbE5SRTZjSzJiSE91b2ZKdHJx?=
 =?utf-8?B?WVVoQTR1ckNMdTR2OGFKZUZMb2NaZnhsd2hkM3ozOVVuQXJNNDJsTlBRNlVq?=
 =?utf-8?B?VXZwUWgzYzBGb09yaVYyWmZCUXZzQWswbXBlWU1pa2JBaDQwUDNOZHRHaURz?=
 =?utf-8?B?SGJQeWwrTFZ2RXEwR09sUVlRdWVLWW9QSVh2MDhXeGRTUTdodEw5Q3FIYWJC?=
 =?utf-8?B?SCtLb28vWUMwcXJkaEdzcWJuZXZTR3ViVnRrVDVVcDFpU3pmVjNJcE8ra1do?=
 =?utf-8?B?ZU1tVHU5NFVQUzFiYndhQ1BDYVN5T2xmY3RVZTdRejQ1V1ZUWVFKR3FCcTd6?=
 =?utf-8?B?dEtKYW9DWFlrZkdNTDQweVFpbWh0d1YxME1RdTdzNTBlL1gwMnBuRTA1RE55?=
 =?utf-8?B?K0VZMERIcHJMaWtpU3lFbzZCaU52cU5MRVlaMlJqRFFvREYyRGlyUjJHR09a?=
 =?utf-8?B?ZmRjTWs4ajRwKzN1VTVXc1N6T1RBM1JyY09aZjVYTE51NlM3bnkyVG1OelUv?=
 =?utf-8?B?UW93bXEzckdJbE90UVVwZHFGTWlaM3YvclZFMlZXQUsrK05xL0pjaG9VZUNh?=
 =?utf-8?B?S09RR1hlemgwTFY5ZTlzMTZMVTl4ZWxkZlFuViswS3pCNElIWFVQcTNsSnBS?=
 =?utf-8?B?RkhhUFp6M0Z6SXdJMGZNai83dUU2dm9FSHQ4Q213R3N4SDlJRWt0SjVkZGFp?=
 =?utf-8?B?azJ3cTR4VjFUQjh6MW1tdlhjZHA3dnNWT0lSSDdKQWZCeVJkOUpGS1BHS3cy?=
 =?utf-8?B?KzFzMjFiWTA0ZmsybEZoSDlvUnhmRnFiS1NBOGdGZHFra3pCUDhJUUx3Ykl4?=
 =?utf-8?B?UmRoaEZjSlFSb3pEaGZvY3hOUktLcXNOS2lNaDJLZEpJSldmSmhnWHdXbFNj?=
 =?utf-8?B?M202ZjZ4aC8xV3p6bGU0NjZqNnRIVDBhRUFQYTZwc2JLVkQ2UGVKbmtuOWJX?=
 =?utf-8?B?WnlIRGc1dG9mR3NBUC9NNWlYSThCOEQxSFZId2ZpeHFCck1JOXVqQmRQamtz?=
 =?utf-8?B?WTB5ajl4TWxMN3A3c1Q1MXArRTh5eVJ5aXpTZTZGY3d2T1Y0UHlJeVVRSlVa?=
 =?utf-8?B?TWVLZXRmQ0ZuNlQvaHhGVXRzS1hiWlpuTWFYVWF1eXJyK0hNWVV0Rnh5azFY?=
 =?utf-8?B?MGRxdDkycFhNWkppZ2ZDYVZ0Ui9VN0NvYmlpUzBFSTBrWEZoTC9zek5vaTQz?=
 =?utf-8?B?R21FcndwMyszM3NjTmZUZGRSK0Z6T2FUdmJoS1IrbnVvMDc1M3VidW9oUzQ4?=
 =?utf-8?B?QWE5clBnRzdQWXFRTlZxb2JTZzVjVnF0MWdhVndXUS9VdmlxKzN0K1ZxOG94?=
 =?utf-8?B?SWRXNFU1UzdPQnVNdTVib0RmUHBjQlk4STMwUUxnT09UWUJUT1lQQlhWb3hj?=
 =?utf-8?B?bC9VeWgwbWFvUUVsRTZtUW9OL3MrYUs3K1NEUHRLWHA4N2VkRmVWaGlrM1gv?=
 =?utf-8?B?T2lXUWd4T3ZLdzVWM0J0UWhtdTNtYlFwWSs2SEdwS05sQVBKZ1lQOEFsSkRW?=
 =?utf-8?Q?b4CvFVXsEc1a9cuK6TbMcQdoNrNRGz2lTFHpc8fA/8JM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci9DOTEyN0FRTnZQcEEwTjA2djlXakVqcjZwbkFWVHdsbFVBZUhMUnMyTll3?=
 =?utf-8?B?M1dMZlZpZzhSdHdmMEZTZUhINytLWWt2L3B5Z2pTQ3JJc3ZuWjhCTHJRb3N0?=
 =?utf-8?B?S2YyM2RqV1l3RkZIUlRMZ2VNL1lMUmsxRUkvVnI4aXBZVUU0Y3Vlby9ENjBx?=
 =?utf-8?B?OTF3Tk51eXRtbHNiMFRzWWdrSnFDZnlSQzNVVHVnUzVCTFpEb3VPM1BDZGM0?=
 =?utf-8?B?aWpHOVhEQUhDRUZUU1d2R3NsZHoyZ1d5WmpPbS9KOTNGM0w3OTN5ak9kMkFo?=
 =?utf-8?B?V0NOSXRMaUxhTkFDWDg3eXB3bVpEUGhBS3FMeDNrUWIwek9JSzl3VzRZajVV?=
 =?utf-8?B?b2pCUmhuQ0ZYY2JDTjEzYjE0TEcwY0g4MVYvVXlRVWU5OFhNbHZoUVNJMDJK?=
 =?utf-8?B?QjJHVkkzeGh6SUpaSmJROTBWVTAvZ0VCbTEyZ1lLMFkweDFyV2l3dTg1TENl?=
 =?utf-8?B?ZU1FMllUZzg0M1VNcmluTzd5Q0Iwa25yeVlaa3JQMExpcktFSFNNSmYrYnNy?=
 =?utf-8?B?SXdacmk3dlZPUWlqWVN0THRET0VtRWs4U2xQTEJ6a0FteTFjOEhUNUNmemd2?=
 =?utf-8?B?a3R6MlFCZVkxMGhUL2lCM3RXVWIwcmRZL0RCQTFUcjJ4MEVZVHNVT2ZlTEtt?=
 =?utf-8?B?cGFla0p5SmZlZ3g4dGI2T0xiWk5EbDlTY1FNMndKcWRpY29HbkNuSlowNUVu?=
 =?utf-8?B?WHlTTkVlOXhKWStqem1ia1BKTXp0U2R1eDJKaytiUWYyQkZKWllXdlpyd2N1?=
 =?utf-8?B?U3AvRmozaGNZSG1sQzhqVVRtR3BiNEIzK2EzZ21JY1V1UEdjbXA0anpIcGc4?=
 =?utf-8?B?S25JWjd6NlR1bXBFZVBrU0JtU2tLQXNNYWpNQk5KMXZjeGpEdzNXOUpXK3Y5?=
 =?utf-8?B?dWlBd09pcFMzaFFoWGZ2VWJuZ1pkeEdoVTJ4M1NDQ2tPZUJVUlY1NVAxVWNv?=
 =?utf-8?B?WStzL3o1bFlLc3ZFV0FtVzJoOHQ5SVdlTXJHcnpXcUNWWHBFQjd6UUNHTjFa?=
 =?utf-8?B?dnVDbTRMRkMwaUt6VkpNNjIyRGZKKzF3bTRHRGtMZGdpY0hZZk5pd1pLZHJo?=
 =?utf-8?B?RXlnMlBPOGc3b2JSTFJHWGNlbHgyMUV1V2ZqYlpCOHNOc0U2YkNCRnF1bUQy?=
 =?utf-8?B?VC8wWHdLZmp2blByM3pQdk02WElYODlkblNTcVo4bC9OOVRoRjBhc2ZXMlhD?=
 =?utf-8?B?d3RENmNGMXc0K2lFc241ZWYwNThVczdWbEhjc2Erczl3eFd3MGJOTWEvbkJu?=
 =?utf-8?B?MGZhQnJKc2R6NkVUWEJ2RXVBbmgyc2pPSDNBc1dISTRQNXFrZ2YxSFRvQWoy?=
 =?utf-8?B?bDRyTHY2TGgwUG5mRXQvcUM3WDk2N3hndjhXYS9sL3h1TnVJMnl1b2N4TTAx?=
 =?utf-8?B?eVg0NEpSTkJLN05sdit6VTJoVWJvZ1k3Zmp6bzdPZzlkVGs1MkRwdWV1VjVQ?=
 =?utf-8?B?Y2pDNk5nVGNLWncwK3FBTTBMWXVwNHloaUNWbHJkM2t6aSt5ZGdMZjJiMkh0?=
 =?utf-8?B?OGpaQkh4dUVTbnBrNW1STUwvZDEwS0tKOG1tQ2JsTVFIcmI5Nk11ZFBMaW9G?=
 =?utf-8?B?Z29EdDN3L28vUWN5b1F5TFJrcGlrWU9wWUNvR3VST01pY2gxanpHZ0cvWUVv?=
 =?utf-8?B?MGRUT1hiUXUrMXo4UXA3NkJhdHVHVmc1TE9mWW8vVlUvdlZJbkFzVEVMVFdm?=
 =?utf-8?Q?8KuwdXxx/r9K4UdNQV03?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d9ef4-bbcb-43f2-ed77-08dd142fc534
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 06:49:16.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB4054

On 2024-12-04 09:01, Cong Wang wrote:
> On Sun, Dec 01, 2024 at 09:42:08AM +0800, Levi Zim wrote:
>> On 2024-11-30 21:38, Levi Zim via B4 Relay wrote:
>>> I found that bpf kselftest sockhash::test_txmsg_cork_hangs in
>>> test_sockmap.c triggers a kernel NULL pointer dereference:
> Interesting, I also ran this test recently and I didn't see such a
> crash.

I am also curious about why other people or the CI didn't hit such crash.

I just did a search and find only one mention of this bug:
https://lore.kernel.org/bpf/20241020110345.1468595-1-zijianzhang@bytedance.com/

Personally when trying to run test_sockmap on Arch Linux 6.12.1 kernel, 
I get rcu stall instead of this NPE:

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:         Tasks blocked on level-0 rcu_node (CPUs 0-11): P3378
rcu:         (detected by 0, t=18002 jiffies, g=9525, q=28619 ncpus=12)
task:test_sockmap    state:R  running task     stack:0 pid:3378  
tgid:3378  ppid:1168   flags:0x00004006
Call Trace:
  <TASK>
  ? __schedule+0x3b8/0x12b0
  ? get_page_from_freelist+0x366/0x1730
  ? sysvec_apic_timer_interrupt+0xe/0x90
  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
  ? bpf_msg_pop_data+0x41e/0x690
  ? mem_cgroup_charge_skmem+0x40/0x60
  ? bpf_prog_1fca1a523ce93f38_bpf_prog4+0x23d/0x248
  ? sk_psock_msg_verdict+0x99/0x1e0
  ? tcp_bpf_sendmsg+0x42d/0x9f0
  ? sock_sendmsg+0x109/0x130
  ? splice_to_socket+0x359/0x4f0
  ? shmem_file_splice_read+0x2cd/0x300
  ? direct_splice_actor+0x51/0x130
  ? splice_direct_to_actor+0xf0/0x260
  ? __pfx_direct_splice_actor+0x10/0x10
  ? do_splice_direct+0x77/0xc0
  ? __pfx_direct_file_splice_eof+0x10/0x10
  ? do_sendfile+0x382/0x440
  ? __x64_sys_sendfile64+0xb3/0xd0
  ? do_syscall_64+0x82/0x190
  ? find_next_iomem_res+0xbe/0x130
  ? __pfx_pagerange_is_ram_callback+0x10/0x10
  ? walk_system_ram_range+0xa6/0x100
  ? __pte_offset_map+0x1b/0x180
  ? __pte_offset_map_lock+0x9e/0x130
  ? set_ptes.isra.0+0x41/0x90
  ? insert_pfn+0xba/0x210
  ? vmf_insert_pfn_prot+0x85/0xd0
  ? __do_fault+0x30/0x170
  ? do_fault+0x303/0x4c0
  ? __handle_mm_fault+0x7c2/0xfa0
  ? shmem_file_write_iter+0x5b/0x90
  ? __count_memcg_events+0x53/0xf0
  ? count_memcg_events.constprop.0+0x1a/0x30
  ? handle_mm_fault+0x1bb/0x2c0
  ? do_user_addr_fault+0x17f/0x620
  ? clear_bhb_loop+0x25/0x80
  ? clear_bhb_loop+0x25/0x80
  ? clear_bhb_loop+0x25/0x80
  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

>>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>>>    ? __die_body+0x6e/0xb0
>>>    ? __die+0x8b/0xa0
>>>    ? page_fault_oops+0x358/0x3c0
>>>    ? local_clock+0x19/0x30
>>>    ? lock_release+0x11b/0x440
>>>    ? kernelmode_fixup_or_oops+0x54/0x60
>>>    ? __bad_area_nosemaphore+0x4f/0x210
>>>    ? mmap_read_unlock+0x13/0x30
>>>    ? bad_area_nosemaphore+0x16/0x20
>>>    ? do_user_addr_fault+0x6fd/0x740
>>>    ? prb_read_valid+0x1d/0x30
>>>    ? exc_page_fault+0x55/0xd0
>>>    ? asm_exc_page_fault+0x2b/0x30
>>>    ? splice_to_socket+0x52e/0x630
>>>    ? shmem_file_splice_read+0x2b1/0x310
>>>    direct_splice_actor+0x47/0x70
>>>    splice_direct_to_actor+0x133/0x300
>>>    ? do_splice_direct+0x90/0x90
>>>    do_splice_direct+0x64/0x90
>>>    ? __ia32_sys_tee+0x30/0x30
>>>    do_sendfile+0x214/0x300
>>>    __se_sys_sendfile64+0x8e/0xb0
>>>    __x64_sys_sendfile64+0x25/0x30
>>>    x64_sys_call+0xb82/0x2840
>>>    do_syscall_64+0x75/0x110
>>>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
>>> size(8192), which causes the while loop in splice_to_socket() to release
>>> an uninitialized pipe buf.
>>>
>>> The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
>>> will copy all bytes upon success but it actually might only copy part of
>>> it.
>> I am not sure what Fixes tag I should put. Git blame leads me to a refactor
>> commit
>> and I am not familiar with this part of code base. Any suggestions?
> I think it is the following commit which introduced memcopy_from_iter()
> (which was renamed to sk_msg_memcopy_from_iter() later):
>
> commit 4f738adba30a7cfc006f605707e7aee847ffefa0
> Author: John Fastabend <john.fastabend@gmail.com>
> Date:   Sun Mar 18 12:57:10 2018 -0700
>
>      bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data
>
> Please double check.
>
> Thanks.
Thanks for your help. I will double check it.

