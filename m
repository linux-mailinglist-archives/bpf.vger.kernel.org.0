Return-Path: <bpf+bounces-2398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140672C8F0
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9FC281039
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356D1B8E6;
	Mon, 12 Jun 2023 14:50:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022CAD38
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:50:13 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FAB2;
	Mon, 12 Jun 2023 07:50:11 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C6cNFt030663;
	Mon, 12 Jun 2023 07:49:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=wrWaTdfxqfXRlIs42cGQ1NBhSEmRQfgqK2gKGpqeG/U=;
 b=Oq8M2tAH04/zwSgyuOPofKTAzUolzYkbyfa4cjxahu3/M1n7hrJ0h/wERMXNtca3QD1h
 fkbhJ51ZqcSmzQqK96KNBlTNYHvTsmWdChoTlrWfNePypgQIYd40XHlC42hR5Irbx1Iz
 6UezTMxyPfwxqbl2ADexGOmEp3lUK1E/pemsuoKGLMlR5dpYxbguK4fm0YcDMsfNrBNv
 BZkgGD7da1J6623EzwDTafx4RCZVRq1u/3PT217Dl8mIMP7q5VwEU3QfC8YtG+ZlmkYU
 dpGVyFD4JBoZfyFk966Yt+x6OUeDGLUiS5OWElANTozCFaXhF+ldUrGhsv0OxmPbR9by +w== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5x8yjkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 07:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBJWJBXY9+LdnLTK3tYc6yJXRPjJvc+3Kcv+Oz1F5qYrZ/cQVwGgsYAOBjp/xG24aScZ7/siVJ4UdmT1yjvMTzadxd/Dy934/TaRWHA4/5oqdaX+VRxn+4bWf0kVdchjhgsiPQQ2v2WjE8awW0Z+rOPR3vdEUW1LuzNwkBsNiN7L4YcjTyt3v9EkaaVu8N+ox7IJ/DCkiSz2X44Dxp5nzsSOltlm9XWss9nN7jERf6SqjlpSnrw0w2TGxDyMAs2my4YEjYUccYZiqp+cNituawg6svrNDjLsuHQDuEK7x5pMdMoz++StDI3PivCu7KjZasMIF8G79cyO5vwdjt4nUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrWaTdfxqfXRlIs42cGQ1NBhSEmRQfgqK2gKGpqeG/U=;
 b=QkS93rdPlk2DUjzs5Bof24XAl55MrHtsDYOzEcAzIv2KfrHt9YgNUta8ykK6Ca6EEjQpdO9X0wqWP+hBGeIKycerkY+ALLoPYyyTQ8yeFALPQ0d3fV42tbnOwGMkurXGEDboUp056E+NVuti3ndnYiNjaGvQRc6EJ75rR0YXKOzId6iahhEj4MHDKERA+V3GQBGXG/mfbK5+thkMxyqqf7IFMwkv3AaUXjafPxXeaXQkKXTAyPl/zVEuBeejwqgfGk9+xSnDRXB/Rn85J0J2Lk2lSA2VG5Y55Jc/KiShjWkS+sVBJ55B330xEkaZq4bzm09cQ78g9A3QDSkBWNTYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5922.namprd15.prod.outlook.com (2603:10b6:8:f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 14:49:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 14:49:56 +0000
Message-ID: <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
Date: Mon, 12 Jun 2023 07:49:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
References: <20230611130029.1202298-1-jolsa@kernel.org>
 <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
 <20230611225407.3e9b8ad2@gandalf.local.home>
 <20230611225754.01350a50@gandalf.local.home>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230611225754.01350a50@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: e87f1a05-aac2-4e08-e80b-08db6b5449e9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/tQiIKOcApPpWgo+Ko2o5luVgzWKaPw6l5q1c8vit539SGOZTfNHon1Mew2EsSrWI5zlhzeYTy858Ab4RGF5u+AdccoJUaQyfBEKD4goiVcS9l+n+RA3jXQ4f00v4wGcgjekj7znQfOIETRKEY6JGALeztTVml2usJs5dZUmA6nh7auJhwWVlBuiZLKQvpVQuO5qhHt8RWSg0PeCuNbMRKc+D20eF0CC+POxEKOrB4Y/ODygvtxkSlwcIwXPki090j2M4q8piWH5gScSICWGQq1h9ZHyHw9no2o7lHCNSoJcst/h8SYgCk9/grkfb8lTK7zrJ2Lth19jsW0mw8/100DNScbos1IelY8HJWQ4BAJoTS3fyKZLCWvGztZ+wNhwVjqkEdu2IiY88XG2GypYbrrLApbijHVowPp0UuLZ1YLDcPINhavEDjngIcYL6wXqWt2IiioRHJIbuAWjHbCk4wOLqf7SNrId8adqblIkOVa0U6CkG7Pl+1VsXg5GN3nYqbvBdZaVk8fcXzI5PYH42J814knlffhSWZIlCpja89u7f3zsdZBHJiyUEwmwRGhLR0bnI4nLWERc58lHVhPystTxaFA1GfHpdICLCecCa7WMvxjvJbjbpXAozexrvf++2EBlfgjkOrHqeLij4e13yg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(31686004)(2616005)(54906003)(6506007)(186003)(6512007)(53546011)(478600001)(41300700001)(4326008)(36756003)(7416002)(66556008)(66476007)(2906002)(6916009)(38100700002)(66946007)(8936002)(6486002)(8676002)(316002)(6666004)(31696002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjdqM0g1czYyMEdXV29RVlVwSFdQOUE4L2FiWnQ4c09YZUtyNU5LOEJCOHU3?=
 =?utf-8?B?SEFqNjlITWo0TXlHYUM0ZjB5TjhrU1dVaG1EcTBFUm1wbG9pM0ZDTEpsZVdD?=
 =?utf-8?B?WDZwNDBIdDFibTNRNVV5TjI0UmZsbEtuYVRsK0syelYzeGNDMk02RXp6SUx2?=
 =?utf-8?B?aVlzbm1ETlRKMlVucTk1UVpiUDRxeWZRUmc1UkJFL0VMU3NaUmw2eDBJSFdp?=
 =?utf-8?B?M1VWM3VUNWU1VWEvYzR0cml3dWlXaUc3dlk4S3llOUJwMHhpVlVyN0JkbzdD?=
 =?utf-8?B?dnMwMGtqSERraHhMTC9LWEtsME9BNmFSMTNieWdoSHZicU5vSzViTUMxWVBi?=
 =?utf-8?B?a2dMcHljSnphQktjU0RuTjk1TTJqckl0Z3hmcUcrZ0k1aUFZZzFqOEFvbmQz?=
 =?utf-8?B?NXVqV3BWWmV1QXd3RFpuNXFKcTJEYmc0K21IVFl5dGx1aERreExrY3puRmth?=
 =?utf-8?B?UkFtUHQ4a0cxVlgwQ1oxeW5CandHODNPNkZoR3J1TmFLbGpNOUNCWlA3MlhY?=
 =?utf-8?B?M3JNcDl0R2pXL1RvcUpUMEtZYWhWTE5EL0hVcDhVQjNuLzQ4cDBDcHB2RGNk?=
 =?utf-8?B?ZEZ4MndsMXlPMGRCdjJVYXR2aElSNUtXSS9zUnBwV1NTRUFyN1ZzZUJ2YVJv?=
 =?utf-8?B?aVVYbFhzbjBFbDNZUGRzYjVVcWswSFVLSm9sdGJwQVhBb2JOWlh1YU5jdlh5?=
 =?utf-8?B?MXdqSHFYYVZQbk9OYzhXbHRNblpVWWtxU2l1R25QbkVCdnM3NWlPYjRWaDR2?=
 =?utf-8?B?aks3OVVHdU1MUlVQeGh2ZktwaENtTGIreExISFVzdkZvYjZuNUpQSUNsaU1M?=
 =?utf-8?B?MTNhc3AvTHlhaXo0Nkk3ems3MklGUnBreC9JMXE3MWNxOGZIY3M3NGFMTWFq?=
 =?utf-8?B?SDU3YmlkNmxTcGNuV1FVVG4xbVN2bHo3UXh4Y2Y3TTVYcW0zRHNpa0ZTU2xT?=
 =?utf-8?B?a0ZJNFl3MVo3RXp6eGlNY1RiYWpuZkR3aU1IK0pqaFdkdnljSldFZ0wvNFEx?=
 =?utf-8?B?UDlyYy9YYXJ1bGZNbVFxN3pkMStiVExwSzk3T09ScHB3LzBtbGhzZXIxZHg3?=
 =?utf-8?B?bmp4dTJWSWdWSnAxQUN5Smxiem9WK3FNUDBsNWN1SEtVRTlvTUZYYUNYTHZt?=
 =?utf-8?B?MlQzSVpzaWxUckg1RWpZZGhhWHR0d2VhZngydmZWa2VRTGdwM21UTkdFTlZ1?=
 =?utf-8?B?bHd6b0JRRHBXTE9YVVcwVUZwaTNUT2NxRVVSbXQyeEZ0Y0NxT2hPeHBJYkdE?=
 =?utf-8?B?aVQ2VE5qUDQrcTZTMUs1VDZrdFBnRUFaZFgzWFlteEl2SC8yOW5IMS9Rb2Vv?=
 =?utf-8?B?a3VGdjVjd1RHNnY3T2pSOGc0Zk5Pc2tQZC9UTVIzMnNqQ2FNTHN1cU9HZTlk?=
 =?utf-8?B?UnhXSjNrL2I5NFB6NzJhaVdTL0hxNTVyZ1lzK2JPc01wREorMkY5T2xWdlBr?=
 =?utf-8?B?Q3V6aEhINndRemxLaGl1bVFuV1NZWGkwYy8zOWNRL1FlNzZGenpsRXcyblpQ?=
 =?utf-8?B?VXVvSGlrcHUzaEJhRDllMjl2a3IwQjQyTFMwZEZLVjBvQ3o1anpkV3cwRE1O?=
 =?utf-8?B?aDhUSGFqaGphb0htWldFcE5vTWZ6Vjg2ZWVta095SGN2WDFkSUVoYjBIdWtU?=
 =?utf-8?B?RlgvdXk0a3VJSE5kZExQMUhXVWJDVk9FK25YT2JxSzVqczF2NFcrYzlvVzRx?=
 =?utf-8?B?WVp1MFh4bU5NOTlvZXozYS8venFLakx0QVlaUUhPUWtHYitFbzZ1aEtieGZK?=
 =?utf-8?B?OTVLODZGbnM2anQ0dmUzVXB3MnpoQ2JYTlpDOW9vOFQxR2N2MEJRSkhBYnRp?=
 =?utf-8?B?WGpsT0lQVVJZTUtFSXhkai9XQmh1ZDUvV1ppZEhlUmNaWVY4aW1vWElhNitK?=
 =?utf-8?B?bHRILzBiK0xvcFM0SW15L3ZwS3FxV0xVbHBBNERDVXhjaDlPd1FseGtNUjAv?=
 =?utf-8?B?T1lsdHprZXBnaW11RXVZNDNLUVdNTnV3VnA2ZWRTYXMxRHo0L2Jzd2U2THRt?=
 =?utf-8?B?MHU3c3JpZ2QwMGtrYmFkZG5Hc002RnhndUx3UEZqcmJHRkVOQ0JodndjNnhX?=
 =?utf-8?B?dW1Uakx2cHA1UlJlRGM0OU4yWmNOSmQ1VkRiUFdTUHl4WTU4cllyMkZKam55?=
 =?utf-8?B?djJ4R2xIQllpUGF6cTBQcUZzQjcrMnJMSXd4Uys5QVptVkJSRFljL0VWbnky?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f1a05-aac2-4e08-e80b-08db6b5449e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:49:56.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFsAMy4Df+iHKG+iY3yemvJ58yod9IYlmb8JxvBcQPRELVnieOWqIemONgvytRr9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5922
X-Proofpoint-GUID: pIahGWN-3FEScoBgy7dt2KywqPmG5rm_
X-Proofpoint-ORIG-GUID: pIahGWN-3FEScoBgy7dt2KywqPmG5rm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/11/23 7:57 PM, Steven Rostedt wrote:
> On Sun, 11 Jun 2023 22:54:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> Also, if there are multiple same static functions with
>>> different addresses, user space might need to check dwarf or
>>> proposed BTF_KIND_KFUNC (which encode kallsyms addresses)
>>> to find whether entry in available_filter_functions_addrs
>>> to be used. But addresses may not match. How this issue could
>>> be resolved?
>>
>> Easy, you use the address between two other addresses in kallsyms. The
>> address is still in the function. The addresses in kallsyms is the starting
>> address, but there's cases that the patch location is not at the start.
> 
> Not to mention, you can still use the kallsyms address. If you did the work
> to find it, then use it (it may not be as efficient as I mentioned before).
> That's basically what is done today (so I am told), and this patch was to
> create a file where you don't need to look up kallsyms when you know which
> function to use. The functions are sorted by address, so if you know of a
> unique function near the duplicate, you just find the duplicate that's near
> the unique function name.

Thanks for explanation. IIUC, typically with endbr enabled, the patch
address typically is the entry_addr + 4. So it is indeed easy to
correlate the entry in available_filter_functions_addrs and in
kallsyms.

I am actually interested in how available_filter_functions_addrs
will be used. For example, bpf_program__attach_kprobe_multi_opts()
can already take addresses from kallsyms. How to use
available_filter_functions_addrs to facilitate kprobe_multi?
Do we need to change kernel APIs? It would be great at least we
got a RFC patch to answer these questions.

> 
> -- Steve

