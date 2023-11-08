Return-Path: <bpf+bounces-14526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE57E5FFB
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 22:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06A61C20C45
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8B374DF;
	Wed,  8 Nov 2023 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p/fZ4IWI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9C374CA;
	Wed,  8 Nov 2023 21:30:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18062586;
	Wed,  8 Nov 2023 13:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6xyxxqHdr3E7YYccDaeUV9JC8KdawSefrNEwUhOBjEriYhqWrhW3zXj9/8CZgxIYEWPgybHfgNiSMQ3kJZeC26mCk30OXDBbgbZ487IUWWBVl/zZ4EvPFF4zVZD0oOshL8k75/gHcCI1acfRqtxt11OnQJ47AWt4Q2K7oMdcpLp5Sn6BjXLBnTwvdN9sH0QrAL4pLlCAe2bkcmJekALBkKgs+nEbuLV98UuakeoK24D8ZbFg3LTIIJBLhol8oixKbDlGKGbciEWGR18D4HukQTUtZM/Y/4/kdx9kShoM+43lnDVH+dCT3VY1NwZGd2wuQqhqfZAgZQyIYj14dBxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQmuSYaYyrKA64sQ80nGRO+uepiz89s12SB9w0ejIYI=;
 b=U89SVz1B/l209ScSimSgr0fDPDTYxhK+1VxKuX4lOpDxndaIr3zZPbLqotuUld0YQQMLsNsmLZDBCB40NplgK5K/IU+CO09JIxTQk3AHo2bdJXeuhbksZxz0lrnxtvLBrejWKK7aTdWJywjpC2SAH/8RGVNUSpbFEsY1/DX1YOoRB0fYmdT2Sp8itcbh5UqJgwD7noDnG23n73N1rorr9lKSlzQZMpZoosI6Fzv6IViSHZhB9DJwPDZuADsDIrC30MDAu9BirBEHnD/KfJ4zG/AP2cUQ3SdjQnQS9kFUHFtu5WoFFg3O7oCBwXS73CN/1zDe1qNg6FCzYF0mWZorPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQmuSYaYyrKA64sQ80nGRO+uepiz89s12SB9w0ejIYI=;
 b=p/fZ4IWIb0kbtSDA7NX/ic21erNsKBurjowZXRi5MRCtmI2vn3Fy6cNo2PDn+eRbttfQ8LpTR6Ad3Ct+a/KCxODchQ+154Gdb3VwDzthKa2IvBSSZXy7EhP2oZM8qs/fVfW535vNMP54GOOE8LH4vI17n1V4FKwJElj7hpLUNyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 21:30:25 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::3d14:1fe0:fcb0:958c%2]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 21:30:25 +0000
Message-ID: <fa95d5d0-35c0-497e-aea8-a35f9f6304f4@amd.com>
Date: Wed, 8 Nov 2023 13:30:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: BPF/XDP: kernel panic when removing an interface that is an
 xdp_redirect target
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <e3085c47-7452-4302-8401-1bda052a3714@amd.com>
 <87h6lxy3zq.fsf@toke.dk>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <87h6lxy3zq.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae2729a-fccf-4b13-28b5-08dbe0a1ebbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/NIj6BKdwHesI1Jj1QnKERQ0QGqIktg/BQcNqvz0923OfGFRPJL3w+D4ONZL49Nfd250miRvey8F9JyTc0HFyaZyNlFIKnpX3AbglNCcS7X2lB6rhrfWt2dnz0nV6kznxt4v71NNafzUSIkLrBoFhwVIcuflmG+8iuIhrdX0fQ/4FEZPBA2t+3Xr9Tvagbr9mWIGIm11Kmis0/4SSy4NEif2i6jY0WB4Kfuu3b3MS0o3cVQIGFEsOaF9mzd1TVLG3QAdFnWIfXRQEBGihYWmaGNTuhI/6guyTm7RhL+3OcoY2XBFkcQ7DPPdIM68vpeGP+T1RtyxZQqtc1g2IeeBM88KAYc1aw4z6nZJBO0Hzeu/LKbhnKh0MSkKbqyMwSwrWZ84Tb94BxHj+JHHaq3MxjlrzaKv1jvb/UTeISHRgNvvZjt2dmeBPB2eW53FbbfjtoHWa2Col/hXPxb4cTRnyfug9sKXNw5GM7HZ9q8df1F6JGPD+RIKa41zwSvmp4QqwRGFtV+IZ+HvQo/9y8AqM02oMQvQOsr2o0t8pGybp/mySdVyMbUquZKi9FkBBnBtiCp7++fR6eMY8hsgrLottTHkUtrIxkR7fCJSszIjvNAdmYByborHSqPIAHkY3D4lEV91xtM/34P6iA3A9sPP2vigOOJxfNjCSvdKjIbZiW+4ysriR2tfpXr0X+k0pjIt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(6486002)(6666004)(66574015)(6506007)(53546011)(26005)(41300700001)(2616005)(6512007)(8936002)(8676002)(966005)(83380400001)(2906002)(5660300002)(316002)(66476007)(110136005)(66946007)(66556008)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW9RNmU1ZitkYVRPQlAxQTBDSjhPb0xpSEM0MXZrMWFuZDRrNUdpeW5iSXp5?=
 =?utf-8?B?alBqV2hEbmFqaFB2dlJTKzlTa1p4QVdiVzl6Q2hlZStVMjR2NzhkRVRFZGY0?=
 =?utf-8?B?b3laU1NXQloxWkxQMjJXOStSNytsNjdpWGk5ZzZSdTN4ZmNOS0lSSDU0ZVBY?=
 =?utf-8?B?NFZPWElmSEZ4MmZ2MUhNMTQyRlNiTDRnL0RzTnNnSFNLUzJvWkdzVjFONVB0?=
 =?utf-8?B?NEZ1MVUwR1hUNUdza256U1BBcHBubVB4ckFWZHN0TkQ0bVB4MEs5aHNzby93?=
 =?utf-8?B?RGVRd0thYnF0ZnVMd3VjY21URThVdUY0alBpOEF3dUliSWlrTnZ0emxuQ1o3?=
 =?utf-8?B?MWZ0RjlZTHN3b1BaVFFxMTZ4dDJOQmdVM2ZrbjBrNkYrV1o3QTlxM1cvc20r?=
 =?utf-8?B?ZVBDZ2RaK09pcmtYSnhZdDA3eFZMQjZTdG1waWhNRFBvRUNCVmxzcGo4eUhh?=
 =?utf-8?B?dzBuak9QcWhSWGErMkJXSlhhSVFKT21qK0lnWDYzM3J4eTRRSFJDVS9OcVoz?=
 =?utf-8?B?UWY1bWNFMXR0eGdnR29OZ255RUZ3dGhEQjR4eFBydkgyY3Qrc2swWTNHbFlm?=
 =?utf-8?B?QUNMMCtsZmovT1g4aGF3VmltaDgyQ3kxVVN2Uk1DYlBCVWZVOTJHQlVsdzJs?=
 =?utf-8?B?aVVoMXFkOHRjNENVdlJRM2M0cTR6cWlMa2ZUZTFWY2RUSlhQK3pFN3hsTUpR?=
 =?utf-8?B?SHJVUS8rUm45VlJpNEw1alhzaUJsWi9YUjJuelN0TTE1Y2Y5RGFiYnlBU0pi?=
 =?utf-8?B?bm5abU9DYWhOaC93dTlDM1Z3NEs0UUd1cTdRclpqc2Q0ODVJdTc5cW5Bc0JP?=
 =?utf-8?B?RStYenNkOXpMVldrU25jZHRJTFUyUkQrNUNUdkZpc1ppbUV3UCs1UXVWTDBB?=
 =?utf-8?B?enI1Q1h3TW1ZbVRJUVVSMXFjVHZwUWxxUFZZQzFab2pmbERiRURCUHNaejVV?=
 =?utf-8?B?YnIrejZjdG5SZ00wZlRyWE85Z3RvRHpjSDlJNFJqeUExMWt0VXpFR05iLzJq?=
 =?utf-8?B?a1d2NjdtMHNscjlwY201Zkd0MlMrZ0U3OWV2RFdTdnI5dUp0M2p1VHJXb3Ev?=
 =?utf-8?B?NnV2aXJ0R1JxUTlLMDF5RW41MmZMVCt0aXJ4RVdBU0hFbk5JeTliTk9SN0x2?=
 =?utf-8?B?TkIvL28vRUhNVlF5QTVlbm5NQ2dFNzJUbVhlUGlza2FJMUJnbXJudjdHSlVh?=
 =?utf-8?B?MUdPb0kyU05VYkFqVHpiak9XaVdLVTRnTWNpbHpRVzg4TWtYSUMrNWVvWm9a?=
 =?utf-8?B?TzdYZEVGQ2VjYkFWbGdhVStlRU0yZmR4M2Y2T1hNUU94RjdKaXVWTDhTUFUr?=
 =?utf-8?B?NncvVE5EQ1Ftd3pNNTRibE9xZUlQb29SUWdWRTBlQ1J5L1k5UHJMQUdoaEht?=
 =?utf-8?B?aDNTOTlBWk9hcTBzc3dTU2pVRUNpckozdjF2L1BnYVZIb0h6MEo5cUxpaGY2?=
 =?utf-8?B?bHJiQXVxdXBVVkxaZU9vODNpOWg2NExIUlRsQjRPKzVGUVdLT3N1SU9lR2xE?=
 =?utf-8?B?WmIxVkJEaGRQdWIxSUxUNU1EOEtlWFkxeWttekZSVzROMlZseHArSjV1NkRp?=
 =?utf-8?B?RlRacUJEVlh0UnZBeCtzY2lNb3ZMbGRYcUhpZW91R0RTUEQ0ZlFpK0ZOZWV6?=
 =?utf-8?B?T0s3TFAvRGNuMGhHQ1ZsOEgyL0h1Zzh6SkxCTllTeUdURC9oS3pnUitnUU12?=
 =?utf-8?B?UTZFbW1GMFZyVXlvWHd5dnNQQ2twN01PeWJSNHVuNDQ4MWFrNDl6ck1CbHlw?=
 =?utf-8?B?bWRMQjNNWFFYYWZseW5ydFB3UExNaVk4TzMrNEh0N0VRMnBTNXYvYXhzQ2Yy?=
 =?utf-8?B?cFViSjl3OEJLQjN2bDNNYmNEOGFkUmpCUlM1N0lMN05ISGE3WDQ3TzVoQUto?=
 =?utf-8?B?U3NwQVR6WXd2MzVsaDRXQUlSOTYraXRTN0RIaHBMa0xTNlI0SkxxZTFMbUtS?=
 =?utf-8?B?VmkvRDY5NUZyWW40dTYvZDJVaHNkaCtOL0lTemVsWWhDLzJTSDBidkY4UEl0?=
 =?utf-8?B?VUQwbE1OSVIvSnhKUUdMdjFXTDU4Q3RkYktGTko4WkwzUjhmWFFVbDQ0NmNo?=
 =?utf-8?B?bzFwWVl5WVRLNWt5R0xSZmJxMEppaUlNTHpoUzdadUp1LzRLUGlkYU80QWY1?=
 =?utf-8?Q?/Q9rYYM/nZ3i/08tdxFTKEIh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2729a-fccf-4b13-28b5-08dbe0a1ebbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 21:30:25.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/FFMRVEx1tE3RBJXdGwbefIywwIsvZs6FceJTu6eh/IHGB+RRvHqUXHMraX4Y4AtHFwCTneMoYDk4Hon65kjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

On 11/7/2023 7:31 AM, Toke Høiland-Jørgensen wrote:
> 
> "Nelson, Shannon" <shannon.nelson@amd.com> writes:
> 
>> While testing new code to support XDP in the ionic driver we found that
>> we could panic the kernel by running a bind/unbind loop on the target
>> interface of an xdp_redirect action.  Obviously this is a stress test
>> that is abusing the system, but it does point to a window of opportunity
>> in bq_enqueue() and bq_xmit_all().  I believe that while the validity of
>> the target interface has been checked in __xdp_enqueue(), the interface
>> can be unbound by the time either bq_enqueue() or bq_xmit_all() tries to
>> use the interface.  There is no locking or reference taken on the
>> interface to hold it in place before the target’s ndo_xdp_xmit() is called.
>>
>> Below is a stack trace that our tester captured while running our test
>> code on a RHEL 9.2 kernel – yes, I know, unpublished driver code on a
>> non-upstream kernel.  But if you look at the current upstream code in
>> kernel/bpf/devmap.c I think you can see what we ran into.
>>
>> Other than telling users to not abuse the system with a bind/unbind
>> loop, is there something we can do to limit the potential pain here?
>> Without knowing what interfaces might be targeted by the users’ XDP
>> programs, is there a step the originating driver can do to take
>> precautions?  Did we simply miss a step in the driver, or is this an
>> actual problem in the devmap code?
> 
> Sounds like a driver bug :)

Entirely possible, wouldn't be our first ... :-)

> 
> The XDP redirect flow guarantees that all outstanding packets are
> flushed within a single NAPI cycle, as documented here:
> https://docs.kernel.org/bpf/redirect.html
> 
> So basically, the driver should be doing a two-step teardown: remove
> global visibility of the resource in question, wait for all concurrent
> users to finish, and *then* free the data structure. This corresponds to
> the usual RCU protection: resources should be kept alive until all
> concurrent RCU critical sections have exited on all CPUs. So if your
> driver is removing an interface's data structure without waiting for
> concurrent NAPI cycles to finish, that's a bug in the driver.
> 
> This kind of thing is what the synchronize_net() function is for; for a
> usage example, see veth_napi_del_range(). My guess would be that you're
> missing this as part of your driver teardown flow?

Essentially, the first thing we do in the remove function is to call 
unregister_netdev(), which has synchronize_net() in the path, so I don't 
think this is missing from our scenario, but thanks for the hint, I'll 
keep this in mind.  I do see there are a couple of net drivers that are 
more aggressive about calling it directly in some other parts of the 
logic - I don't think that has a bearing on this issue, but I'll keep it 
in mind.

> 
> Another source of a bug like this could be that your driver does not in
> fact call xdp_do_flush() before exiting its NAPI cycle, so that there
> will be packets from the previous cycle in the bq queue, in which case
> the assumption mentioned in the linked document obviously breaks down.
> But that would also be a driver bug :)

We do call the xdp_do_flush() at the end of the NAPI cycle, just before 
calling napi_complete_done().

> 
> -Toke
> 

Thanks for the notes - I'll have our tester spend some more time with 
this using other drivers/interfaces as the targets to see if we can 
gather more information on the scenario.

sln


