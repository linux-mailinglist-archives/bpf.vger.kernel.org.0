Return-Path: <bpf+bounces-14544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0517E6208
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 03:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5EEB20F00
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C7917EB;
	Thu,  9 Nov 2023 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fK5A/Bza"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856015A1;
	Thu,  9 Nov 2023 02:11:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9848326A2;
	Wed,  8 Nov 2023 18:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf4QYVHYPDeFOZdNg66NPSnD3vA2yzrYTwvWZGx0uAVFKD3LVCL4YUaDEqC7fCTNNGTk3xMBGlhhj8XivFfoeKD5w0pclekzSew6tAZSdIZpxWkQ7zg9B1myaYruMEbOAvEnA7TG7z9LdGdpOz+twDS9IIbyOyhShZjsDDKMA8l71GvdH5whzzvhacHULfNeQVfIiiIS/CHdmq50pi5K/MZzRGXaC2twUCuX9Q782r5ZNOFrWSkMeA0+qbO95KmIC9VAnv6w4pYf//sIc9365z0Wui39SyUJkwr+z+UCgLXlXHQ77KRWKJ4Mg3XLJGy1VYFhW6369xm6QXRcCXX/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bcGRqyuaCyXgcNyzbjSlA/xfDJlYP652Lj3aUWvJSw=;
 b=d69M0ClxyZVR2eVm179hcD2nwgNeJr2B2cwdq9bkxXV4/85fLZ6dviyvnqwT0Q+VkRUifc1+2L7pfXLVP3JAtH3pFfi84ZiqDsgkwrVQiNo1Gy4vmpbtILyfArx29i/7vDGSGuz70p4eE+wtfncss0cmKuFUd5GMLQ8P6A0II6u+12H9J6lotnBg3cLHVwxCT6GHQbEY7h6QDGeUlvy26O9Y5es8pr8lpE2HYfx6v6Q53pI8DT3X8qJJBSM2RZknd1r6i3nPhW5mh1XjXsI8KXz8QEVcf1YFHf/2eEvOlzf0QQcWOHkBBgDRStWo05JSW/E3SRnR4okWr6zHBXjm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bcGRqyuaCyXgcNyzbjSlA/xfDJlYP652Lj3aUWvJSw=;
 b=fK5A/Bza86WrQZpCxsX/B9aCwoMFJb6WfWJU7RWnJyzV6jYtvG3XJM5TxIalhN14ijlpWiRMjUKH23tmJTyZjHb6f44ZKKeK6DYUzGHGVth7c4L1N+wQFPPbaLZnO4Iu0LHmzAKp7qhnS5cJjH613YFeizEzJzoFk8q84hNDfaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Thu, 9 Nov 2023 02:11:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 02:11:43 +0000
Message-ID: <f7d12021-fcdd-4b2f-83b9-76db392a2473@amd.com>
Date: Wed, 8 Nov 2023 18:11:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
 <87h6lxy3zq.fsf@toke.dk> <fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
 <20231108175215.351d22bf@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231108175215.351d22bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bc1bb1-55fe-4a43-3f2c-08dbe0c9381c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nCvjK7VG5e4SGsixczeq/O/UTx+F0JqTx7DmmhVIA9IRry2GFqyZ2C1/Pn58BfPoauCSo3e+5iFHdwH/+OW4ObiuYfq8irN5Pjk/ejhCq6TNvQbnOrBGpOZIu43gQ10c4IjZHXIfBpOFvjwpTe5tvz1Y7VYu6rrDBh2fWxe+2MxwuiHgQ8pPuvwjYX1FuX4ooNpTPCXm0IuG81SHgiUbY0THKtL18/rvcIXSpRMYWrtaPAYSB9e6PUJz4jAaecxP7mfASkOi5m1RrzL+ny5InS0PzaN4PLUKd1ck0YvK7uDFgMmSBNNLVvc0K5PRYbgzRmNTcgHoNUkP3Pk5fwsmzp0phFqobBqFZEIGDufWYVWE4GdIj+L69DrHJEmTUSeaYXYMRkGB1oEiuXPexU/f2EKzVBpTpzoyKHSpeoZseYDky1Ysu17zXuLjYEKMjBjazNsXSyzja9IrcnUXU1i0+JR4QqOCKlaZMVVKnQcRHsu24m+gwzyDSXuXYfM7tO2GF9Dc/qBMeUQ9VuybhOMrHSXwbJt+i4qiZ/QVPdVBViSIy0zSapVolb72pjIWKOlb7vJtH/YakzbzF+OcS/SftuWuEVTZCfl3OPK/U/T1scck5TM5SBog52/C7Yfz4KapMJ9Sjkjf8CbQ8e/zuGHa/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(2616005)(2906002)(6512007)(26005)(54906003)(6916009)(316002)(66476007)(6486002)(66946007)(66556008)(4326008)(5660300002)(478600001)(6506007)(8936002)(8676002)(41300700001)(31696002)(86362001)(38100700002)(53546011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFFWlNaRFZrUnR2ZU5sZXNrNzYySDRnRGFDaSt3YUxmRnovbnllQmo2d0xB?=
 =?utf-8?B?cm80NE9DNTZGZ1d6L1krNWhtNWh1TEVySTh1Q3VBVFQzQWVVUDZuT04rbFNh?=
 =?utf-8?B?bTBSUW1wcWhKTXpVNkxyTWQ3cW1oQ2l2S3lBc3VaOWlRWUJPUGxkYVFNaTBC?=
 =?utf-8?B?bjhmYituL2J3YVE1ZVJNMGYzUGNkWGZkeE1DcUs5eDBJUzVqdnhselBwSFN2?=
 =?utf-8?B?TGo3OWVSS01YRDNMMCtBNldldHZPTFVHSDMvb0k2cTNRWFduK1JxNFZLaWVi?=
 =?utf-8?B?dVZ0SEtjNkRHb2N3Wng2RGpoeHQwRjRQMktITWZGRnJQVzN1WURrbndjb1lP?=
 =?utf-8?B?MlhxUXo2ZmxrSVA2NnlRaVlKZkErWEhHNTAzaTZsRDRMc2JvcC9kRXgxNlZz?=
 =?utf-8?B?alhzZmN0c2NLQ0h1amI3UGRBY1RTZDBGYlNjRCtMbjNiUm5DOEUxNnd6V1k3?=
 =?utf-8?B?ZjE0bjdDYmhhWGFXbTJNaXV3Ui9yaytpdjlUeGRYekw2NUM2S1Frd0pWWSsz?=
 =?utf-8?B?M1Z5d0d1WGxYMmJLWmp2bWlqZU01cFhCRHUwNDl4WEdGS3NqTEpVVlluNzFO?=
 =?utf-8?B?dzY2Yk94YXdRUWFWWHhzcDRnaWxBWlR1b1VZZXIvMXpKajMrbVdDV2NLVjU5?=
 =?utf-8?B?Z1llODFMbExESXcra0h0Ynp4ZWhJNXJvRXFYUVZRNHdUbEQyalBJNnp1ZUt2?=
 =?utf-8?B?YlJYZSt1TzBxelNUOEVXa0x3R0szMEhzQi9jSUxKQmlwdFg3aFA0bjZVWDdZ?=
 =?utf-8?B?TVloYXJTaDg2OUg4bGc1Y0FtYTg1azQ5VlZHTUxmdlJCMm9kK0I3Sk91QTNL?=
 =?utf-8?B?NVVpWWhYQ1JKcUJ2Z0tXTklYVER3WDc5S2w2U0k2dUhaVWplWWYzNVM0dmpr?=
 =?utf-8?B?S29ZVFV1dHJqRWxFK0lZR1dpcjhZTE9lRm9IZm1rdXJ5Vm9oeEpWRE5TNkNZ?=
 =?utf-8?B?VFBYUFFkR0ZpM3lwREM1OXFSYmhDeWRWemNnUCtBVU5aWnR6U3lmV1RYNFVl?=
 =?utf-8?B?Nk5ybUdXQlBWVm94QVMydTBIUWkyWE8zQ3NqREUyNWxtMGVzNmFqU2RYY0s2?=
 =?utf-8?B?ejZwL1lkN2dtNCtQSEFGSndJdTVDTUV4dmI0OUxGWC9NS1NYczVaeFR4eEFm?=
 =?utf-8?B?OGN5TEEwcUYzK3BkY0cvYXAzb2YyWHJHMEgrcGNvOU16TjkxSm9pV210QVU2?=
 =?utf-8?B?UDdtUTdpVmVXK0piSldvbS9QaE52UHphV3QxSkxnaTY4MTNMZm05SzF4K0Zl?=
 =?utf-8?B?WnFkeVY2V205Q2lodHp6dTdLZ2dxR0huSzZITVVwa3FEdFNpc2N3eVlDd1hj?=
 =?utf-8?B?VE9xakhZb3gyRFBSbEUvRmhrMmc0eGJ4WFhsRkd0R0hwaGpXekNEODBYQ25z?=
 =?utf-8?B?RDlvdE9Wb1hjM1VBZDBFaExkZHVNOFhpTEM1Z1FVVjE4Z2hYZlZSSllMQ0c5?=
 =?utf-8?B?NkRmRGRlNVZRdERXTTFxYWZ1STlDTURkSm00VVF1eVB5UkV6R3ZUY2pZYk1a?=
 =?utf-8?B?MGZmL1BuczJ4OStQRWVTYU1KTGU0Sm1xZHh6amRzUktRdW1aUWtXaFBGaGZv?=
 =?utf-8?B?RDlVdGx3K1VwOFkxN2J2SlJsWmJSdmVVQUxPaTg5RnNaRjJEMXRQUjZyT3N5?=
 =?utf-8?B?aFU5b3BiZCt1WEppejNyUTlONy8rcVlUT2t0T2wyMlJFY2M4SXpSMGcwYno0?=
 =?utf-8?B?SFBSd2l3ZzRRazk2TnA1MVk0cDdBelB1TXgxYUZjT0Noakk5RXdGYVlqWjBY?=
 =?utf-8?B?S2Z4Zm5WUWZCODI3cUtITGZpaDdpeXNNd1I0N3Yrc2Zma012cGFCUHRydFBz?=
 =?utf-8?B?NmczODNMY2hKMldtS0ZGWkRyYWd1L3VWTENKT0pkNjBiSjlSemFXRTVUQ1Nz?=
 =?utf-8?B?VGZRbnNPOTlPSElzRVFLR2F4SHc4SEpKcWpOK1U4aVFMZ2tWbERubWdnS2tr?=
 =?utf-8?B?azFqRGZxME53c0VlMWQyYy93c1B6WllrVXYrU3BVVWZqN3hmRXJQL21QM0FV?=
 =?utf-8?B?UzNLdDdQL20wVVNQTmNjbkZCOU5JMS8wOEZBZ3Y4ZWlSWTR4RGJVZWFDNG9H?=
 =?utf-8?B?aTBMdzJCcVRFY0dNSURXTG5DZHUyWExsTVRaK05NT2oxOWg0TmdSYzhhTmhx?=
 =?utf-8?Q?cFLTX92R/ySBjIdi8mDqC6/sN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bc1bb1-55fe-4a43-3f2c-08dbe0c9381c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 02:11:43.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83f7OJgvewtCQo4L0gKO3a8Mxfy7kxRgfOl/Zk7CkjE7dVmsf+5AjjJpE35E3gHENJcE1dWdsjW0bpWTKV6Hfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

On 11/8/2023 5:52 PM, Jakub Kicinski wrote:
> 
> On Wed, 8 Nov 2023 13:30:21 -0800 Nelson, Shannon wrote:
>>> Another source of a bug like this could be that your driver does not in
>>> fact call xdp_do_flush() before exiting its NAPI cycle, so that there
>>> will be packets from the previous cycle in the bq queue, in which case
>>> the assumption mentioned in the linked document obviously breaks down.
>>> But that would also be a driver bug :)
>>
>> We do call the xdp_do_flush() at the end of the NAPI cycle, just before
>> calling napi_complete_done().
> 
> Just to be sure - flush has to happen on every cycle, not only
> before calling napi_complete_done().

Ah, good catch.  The notes in redirect.html say "Before exiting its NAPI 
loop" and "must be called before napi_complete_done()".  I interpreted 
those together.

We'll make sure we do the flush at the end of every budget cycle and see 
what happens.

Thanks all.  This is exactly why talking out your problems with others 
is a very good thing.  And yes, this eventually will make it into an 
upstream patch set - after we do a bunch more testing.

Cheers,
sln

