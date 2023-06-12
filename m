Return-Path: <bpf+bounces-2354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57872B4F5
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 02:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2971C20A32
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A1816;
	Mon, 12 Jun 2023 00:22:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CB179
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 00:22:48 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F8EC;
	Sun, 11 Jun 2023 17:22:47 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BABcNK005850;
	Sun, 11 Jun 2023 17:22:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=zCQ+jhdBz+WBxfqnpTQC6iZMtcqjIA4DmAWhOaXvLzU=;
 b=APIsa5epiVbsdG5NlVoHn2Aysiir2DC69JTuhLKvVXXSSYNHbe7Bgk+Dup56Ah5FYiKv
 8TjvhNOvkGu0Blj+J5OsYehqfG3xarDk2Y3Tx+6ra7vQpSJn6LNxs8d1GCIWvjjSivao
 cQvQ6M8bdMh1t4xJz+tKrEJfD79jTTrR+xa+0ViycPY/SqK9RtpopcofVLFSzhGf93Tl
 KdoHA5KN6N45B8dWlkQoQFYG5LIxw//oOqGdW/LSXsdb1vwvAlkV+WdBSWW7sRvCUbIs
 hjO2ogr3uhLOkxQZD8pjT7bGZZStCKGHBRcgpfhT1tJEXNRYSnuWquhRpRnv2mscteAl YA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r4mgm949g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jun 2023 17:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5SHOFSJDo52G1Er8AZg/S8TBa5RXaWaNOmJE/+lc9nEBZV+/BAY1Au8dNkRkMCEij6YNhzxEW6UQnnblKQBQcinpmNdyCK2qq9tdbJ+arNlno14PYN9gbDBKz0Tz+b0FF4Psm7AjFLA65/o02SaZpxrcoO3YXN/PyQWURfQXdkUcA1HZPA7oqpngGIskaABNlP61OMEqjr1YAyoXK9221KSfCsWTvrVFfBY6hKnQsIvJivbl8+ixZtF2/H51fsww2eCzoHPSxhkaRpC0aNpySgBBtJWiIlY9dhYFGMaPMT5Es1Bc7ivV5mPVULb4ntiUFWMA7/9+JaJTZkgQ/Zdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCQ+jhdBz+WBxfqnpTQC6iZMtcqjIA4DmAWhOaXvLzU=;
 b=gkY5VndJ0dlbKlRHwPOhqLzNcnEAc+PiL46mIkVxcu4ffs0t28EJtTsPmHlAvlBbIHZkQNCq6EEC++67nNV+d3y9Ft6AroV38ZtyuhhjkqCMBVC3lsgVLtKDoLcFSCOZAQTwYYjkX7WbtsPVRosIZBnD2aboSSvYVk/84OjAd2hJZ5IRIvnInx50R0ITS8J8W1oB3zxfiapf9EHdd7zdjXOt6cahcI9H+azW1w4gcW+E3OiqBFjPEeR9ZHpKajC6PIDJqtKu1ng+7FswVQLYdThyMtH6B/ZqTC+kfimJFFNIpQfZxmrZ80lumdVkgtZZzYoIuIN4mIt5xVRw8QUEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3752.namprd15.prod.outlook.com (2603:10b6:5:2b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 00:22:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 00:22:33 +0000
Message-ID: <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
Date: Sun, 11 Jun 2023 17:22:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
References: <20230611130029.1202298-1-jolsa@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230611130029.1202298-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3752:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b00d0a-b88e-4ea1-f485-08db6adb1d9e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dlt0MibMWJ7uqqUFgsVWLHS9dglXPRiMF823z6a6IA93nFOK6KK/QoN+zbftbofXGCysXvv8+EY1IDyypNDzpiGChDwNUs7c9MUXumwdC/rv+8YeU350s4kUtJ9vxwC39m77ZsJ+vv0gj46t1LDi9NGLZivwcFFfNV6r+wuTJm1fRVvVQiATHm8G1IGVPnNLSoDosnmNWUYoSILl97yZGAoBalEjEPC6D5k029K3Bsuo2MHMp9VfuRXjysCwIzS/mdMciuT+qMX4RUNxNfu0WrlshjVBS4epCYVVIPbhDJ4uiDmGE7v3GlrpyhZP5uOrvMQI3OTejfOFNE5OhUM0dKvlc4mdnL1o5GOjCiON9tfqoWq5AQ291+R8cv8Jcfkm0Hd8J8h/5qD2Er4A74rkXMGqR+wxYXnLvQ5uFT9i9y1DwhrmJncm5x2aLq1JjuVuLiLoaUp9EVD24eWVPGBeqmd8kKOCb1gTWpWzfaKplpvnyz0WOwIYSwdYPV881t7y5/AGK5PlOwfdwxG2jW4Tval3MWb9lmsXUodUIpcWCzJ8NyeBbQv3H0Gi57Uv6549aVYQ1eLy2FGUpPAnCYp8SOq4y2S3hcHYHl1zeScBxo59/jzz9gyCXCxDBbeX28bRFfs+1+0lS8I/i4uH1KmO7w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(110136005)(54906003)(5660300002)(31686004)(4326008)(66946007)(66556008)(7416002)(8936002)(8676002)(41300700001)(316002)(2906002)(186003)(478600001)(66476007)(6666004)(6486002)(6512007)(53546011)(6506007)(83380400001)(36756003)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjhFclFLM3U0Y3ZNVEg3K0hwRkNZNGo4UHllaGJPM1NmNGtHN25iSHZ5elBt?=
 =?utf-8?B?b2pJQ1VKUFN3bGNESUVPUFdOSmZpVmI5ZnVYMDV3TFBlVTZ2UE9GOWJ6OUpH?=
 =?utf-8?B?RTI5bGdRd0ZnNUEzRFJQOEQvdXp2L1NTdjl0ZXVITlg0VjNNdnhNYWdoRDlj?=
 =?utf-8?B?Z1NRUjJWSmFmWk9jWmNiY0RVY29qSm9qVy9XSE9FeGJnRWRUNjhoQXY1MXl1?=
 =?utf-8?B?TkN5c0JmK1JRcjIvZi9uYXdIcForWHJMRjVxMDNhZ1Vya2lCYUhITjVTZW0z?=
 =?utf-8?B?RkJ5dVhvU25wSXhTT2Q3ODRsREhGUng4QWxkN1o5T1RRcktYYXVVMUpySkc3?=
 =?utf-8?B?ekozQjREVXhXY3Nsb3pSNzRpZXljWldTWndJNlp3ODZXTmI3LzRMa1p4aGdm?=
 =?utf-8?B?SUNTaHc2RU1XcEIvYTVPWnVob1lyb0lpNHBSUHJKMVk4enBoNVhaWkJpbEhQ?=
 =?utf-8?B?ajNoZ2N0Nm1aWEdUSGRTYjlSL2hFY2hCbW9UOEZqbTcwU2FaYVppVWs3bHJw?=
 =?utf-8?B?SEUvazhnN3lVUjBSUWh1cDB6L1RmRm94R0Y3UkdySmhuTll2Z2lhZjRzU0dP?=
 =?utf-8?B?VWdwYnIvd2M5NW1rM3VTNnRqUlZ1TmVpNnBDbHBoTERDTFBEbWNJTkpmOS9I?=
 =?utf-8?B?Nm9zcDBpSGNtWC8yOHo1aGhjdW9EZ0kvRzR6K3ZJZFQ5dGZIWTZJL0wzT1dJ?=
 =?utf-8?B?UStacnRpaDJIWTdRSzFuTVEyd1pML2p0VERVNVRtYVNyZ3pxd2dDUzdSakYv?=
 =?utf-8?B?VmlLVnd0RVgvUHpLMjV4a3NrclY1SUl1VzlPQkhQSk1nTHN1RnAzMFFVekJV?=
 =?utf-8?B?K2ZGdTgwc1Nac3pOM0FYT0Vod3d5bzZRNzdOalNhcTlqRURTbGxRK204MlRE?=
 =?utf-8?B?UW1BemVsSWtadnd2S3Rha3J2a2ZBSG1RVm9UeDVaeHoycjhaQ29QeVFtcmNt?=
 =?utf-8?B?Q1hrWFdnZUhDVFV3S08wcmF1MnZJaHB6czhCSTFIRGg5d2dydC84TC9YcXhq?=
 =?utf-8?B?em5EK0l5NW5VRkNPREFCMTJhY1hyOWJSa3VHK0dpOWFJRUh3akhmSW1hU1VR?=
 =?utf-8?B?ZTVveVRsYXdXUzcyQm5LMys0MzdidjFLSzVIN0JYcVN0NS9hOFZlNFZWOGR4?=
 =?utf-8?B?K1drcXo1WHYwN0JMYkdtVEFBMUp2Q0lhZjc1NnEyVldnSlcyTmxKYi81cDRX?=
 =?utf-8?B?T01JUUprUlN6bk5tTUVxeGZ0SllSWmhPOWNPZXhHcERNOXdzbzhCZVEvY3lu?=
 =?utf-8?B?OVMwd2dGcDJ0ekxlTWttalNVSkVCUHJvODBtdGNia3NidFBReEVjVTBnWWg0?=
 =?utf-8?B?Z0h5UWxsaC81MEd3THljVGRiWDZUV3JlcEtOdnFkek54VXBac3lHeHlIdHNZ?=
 =?utf-8?B?OXdxQ2xJK2RieXh2dTU3blRyaEJUa1NpV21ZQkRSdzZSVWY2WU1LclJsY3d2?=
 =?utf-8?B?SWlrbWRjb21ERjdMdTNQbUg2OXplMkFaMllvNzJDcitidXV2UitrMnQrazhm?=
 =?utf-8?B?MnU5MG9LUWZqbExtUEg3YmdBbjdaTlExOVJSVVA4d3ZBWXUzNlY5RDRLSjda?=
 =?utf-8?B?TVdyeTlmZTZ2MnIzVUo3dmc1eHRNeWhCV2syZjQ1WkF3TFF2dEVPanA2OEx3?=
 =?utf-8?B?dTkrL21pL2tFSTg3VGNsQkZhNkxKaHJlTGRtdWVjb1UwMlB5bHZZNUtvY0g4?=
 =?utf-8?B?UzhqWlR0YlpFeGFBUGFaYjdJMTJnbGphR0MwOG5WaC8ya3J5TkNJYnUvOGpn?=
 =?utf-8?B?QWZJTm5ibnpmNjA2NXNMWThtRityN0YzbjE5R1VmS1o2dzFhV240N3BRb2VV?=
 =?utf-8?B?QkpxQUFEbjhXejNmWUhRa2ZBYTFaN1VxaFFPaUhSTUladGw5L2tUK28vcTdl?=
 =?utf-8?B?RTJSMkFSdHRVYVlOYXRXcmFFY2ZsTzRzRDFTK1RsRUFUVnV0SmgrV2RGR0lt?=
 =?utf-8?B?RkU4cVE5QlZwUVBGTkRCTTdjNlRXUzF3V1YvZGhyWDFnTThHNk9ybE1WS1RZ?=
 =?utf-8?B?aUpuMGE0L1hJcTEycHBHTjI5UGJtVisyUFlWblYxTHZNV0lYQUJSK3dzTUZM?=
 =?utf-8?B?NnNBdzdRbEVtTTdDY1FuSHJkOVJzS2REVmZnRTdCL1p4d2paUmdEQm85Mmor?=
 =?utf-8?B?MElhUmVtSjhvcWFTdHNma1FKcnNXazk0MzBDL1ExOTJ0aFJmUE9mOFkvWE1J?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b00d0a-b88e-4ea1-f485-08db6adb1d9e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 00:22:33.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqDs03Ek+SUD3cDXGKZNp5cRmroqzyuIyMPKDbD16Lwc0yklnbs9925a/55wvBmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3752
X-Proofpoint-GUID: FibI306WH1Gij4R7MzDdVoEPxdmM1NlZ
X-Proofpoint-ORIG-GUID: FibI306WH1Gij4R7MzDdVoEPxdmM1NlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_18,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/11/23 6:00 AM, Jiri Olsa wrote:
> Adding new available_filter_functions_addrs file that shows all available
> functions (same as available_filter_functions) together with addresses,
> like:
> 
>    # cat available_filter_functions_addrs | head
>    ffffffff81000770 __traceiter_initcall_level
>    ffffffff810007c0 __traceiter_initcall_start
>    ffffffff81000810 __traceiter_initcall_finish
>    ffffffff81000860 trace_initcall_finish_cb
>    ...
> 
> Note displayed address is the patch-site address and can differ from
> /proc/kallsyms address.

Could you explain how these addresses will be used in kernel, esp.
since these addresses are different from kallsyms addresses?

Also, if there are multiple same static functions with
different addresses, user space might need to check dwarf or
proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
to find whether entry in available_filter_functions_addrs
to be used. But addresses may not match. How this issue could
be resolved?

> 
> It's useful to have address avilable for traceable symbols, so we don't
> need to allways cross check kallsyms with available_filter_functions
> (or the other way around) and have all the data in single file.
> 
> For backwards compatibility reasons we can't change the existing
> available_filter_functions file output, but we need to add new file.
> 
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   Documentation/trace/ftrace.rst |  6 ++++++
>   include/linux/ftrace.h         |  1 +
>   kernel/trace/ftrace.c          | 37 ++++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+)
> 
> v2 changes:
>    - simplified address print [Steven]
>    - added doc entry for the new file
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 027437b745a0..e97573e3fc4a 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -324,6 +324,12 @@ of ftrace. Here is a list of some of the key files:
>   	"set_graph_function", or "set_graph_notrace".
>   	(See the section "dynamic ftrace" below for more details.)
>   
> +  available_filter_functions_addrs:
> +
> +	Similar to available_filter_functions, but with address displayed
> +	for each function. The displayed address is the patch-site address
> +	and can differ from /proc/kallsyms address.
> +
>     dyn_ftrace_total_info:
>   
>   	This file is for debugging purposes. The number of functions that
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b23bdd414394..6e372575a8e9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -633,6 +633,7 @@ enum {
>   	FTRACE_ITER_MOD		= (1 << 5),
>   	FTRACE_ITER_ENABLED	= (1 << 6),
>   	FTRACE_ITER_TOUCHED	= (1 << 7),
> +	FTRACE_ITER_ADDRS	= (1 << 8),
>   };
>   
>   void arch_ftrace_update_code(int command);
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 764668467155..b24c573934af 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3861,6 +3861,9 @@ static int t_show(struct seq_file *m, void *v)
>   	if (!rec)
>   		return 0;
>   
> +	if (iter->flags & FTRACE_ITER_ADDRS)
> +		seq_printf(m, "%lx ", rec->ip);
> +
>   	if (print_rec(m, rec->ip)) {
>   		/* This should only happen when a rec is disabled */
>   		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
> @@ -3996,6 +3999,30 @@ ftrace_touched_open(struct inode *inode, struct file *file)
>   	return 0;
>   }
>   
> +static int
> +ftrace_avail_addrs_open(struct inode *inode, struct file *file)
> +{
> +	struct ftrace_iterator *iter;
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	if (ret)
> +		return ret;
> +
> +	if (unlikely(ftrace_disabled))
> +		return -ENODEV;
> +
> +	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
> +	if (!iter)
> +		return -ENOMEM;
> +
> +	iter->pg = ftrace_pages_start;
> +	iter->flags = FTRACE_ITER_ADDRS;
> +	iter->ops = &global_ops;
> +
> +	return 0;
> +}
> +
>   /**
>    * ftrace_regex_open - initialize function tracer filter files
>    * @ops: The ftrace_ops that hold the hash filters
> @@ -5916,6 +5943,13 @@ static const struct file_operations ftrace_touched_fops = {
>   	.release = seq_release_private,
>   };
>   
> +static const struct file_operations ftrace_avail_addrs_fops = {
> +	.open = ftrace_avail_addrs_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = seq_release_private,
> +};
> +
>   static const struct file_operations ftrace_filter_fops = {
>   	.open = ftrace_filter_open,
>   	.read = seq_read,
> @@ -6377,6 +6411,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
>   	trace_create_file("available_filter_functions", TRACE_MODE_READ,
>   			d_tracer, NULL, &ftrace_avail_fops);
>   
> +	trace_create_file("available_filter_functions_addrs", TRACE_MODE_READ,
> +			d_tracer, NULL, &ftrace_avail_addrs_fops);
> +
>   	trace_create_file("enabled_functions", TRACE_MODE_READ,
>   			d_tracer, NULL, &ftrace_enabled_fops);
>   

