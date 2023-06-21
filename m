Return-Path: <bpf+bounces-3075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF67392C3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331FE1C21005
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 23:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D51D2D4;
	Wed, 21 Jun 2023 23:00:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EB1D2A1
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:00:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E119AD;
	Wed, 21 Jun 2023 16:00:55 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKm4G0019392;
	Wed, 21 Jun 2023 16:00:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=5+Lc+Y0V971AeHgje2H7DCwO6tcAmnBTsR5b8A7oxAY=;
 b=iJRDK4ffbKisY6aW6EjEncRYiRzBHFPKFPI2aIcTe5bYJSnOfgtxNj1EUZvkn4q5jOM3
 idVA79YDNOO37iahfRRCHw8bw0666s1NICgfQOrDRpfK8uTYGUbEdUOxIRqGeMZlTeHH
 1rMEuvjwZGLaEv88XenW1LLbGNI8LSoieJEUZU+AbvYmE8voRlvFDblUQz3UFIG5raC/
 JCe5Shmy2IoEJGcJpnuPH1V3iPjaOJyYVBReEOHeVOi3q4fjA7+oFr3s9akmSFeJlEoM
 rlY/WAFw8aBFgG/lyt1v21xallVrSNms8t9Lpj7vEPkYZaSTWBpIODph44x8NfOgktqn UA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rc04w5gv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jun 2023 16:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhmKCmOL8QQEyG7VS6ZUYVoIDDozmbOuG7Xzw9tZccm/pCrGlbaxJADq7hlnkWWi2TxaPQ7mh3indYeOFLUobq7whcqoq40MO3am/r4vkWktKcX/4n0YPMdbp36LCWC8i4sSiNxHLp/nwkwjGiyBejG0sOS8/xYYaai/hXBvvPCmwyR0nrMqkok/PNV0Aixx1vpmZBK3lltyMaSJzREPLqSQlRyTAacnBHgz7sJH+ohJzBrrr4tLLSCBNNlqpi5ukQ0YjW7SkmJ3phJfHEnafObjyOrL5chODootE0LBjcHaX+1rELkCG8Pvp1IKsLkoGidUmiAhsZYe6ZYWNym1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+Lc+Y0V971AeHgje2H7DCwO6tcAmnBTsR5b8A7oxAY=;
 b=HFEPncmAolyjIQbxU/1nCP3uemQAgxt5siBS/CkMNcCALs7YWP3rsQaOqcEmGiwWYwF9n1qn/5keuJ3nBTPHotHBPNRC0pWeh2yMxc6nAk42W63Vv+rLJnCeOX85c3NSPxLcvsZNyTypk2xhsHUQarJH/lxEqDuaOrFj9NND8af7n4Q35rdoEpAEiCp/ulfFkrGROJnUlw4pfWdGkzvh6EhJQ/n5NbW3Doxdk9f5wlRi3AnCgsnz6WIZuDsuCcMdo/p1AMFh/SsCGoGHIj7jRKKfPCfZz+bpLwjrO58KfKyv56bsNb/oWo/lmOpzjJ41IDYh90rJX4Jwcd53QgdvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3990.namprd15.prod.outlook.com (2603:10b6:5:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 23:00:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 23:00:31 +0000
Message-ID: <e28f69ce-e3c0-37ab-f139-7b6d73814445@meta.com>
Date: Wed, 21 Jun 2023 16:00:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 bpf-next 09/11] bpf: Support ->fill_link_info for
 perf_event
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230620163008.3718-1-laoar.shao@gmail.com>
 <20230620163008.3718-10-laoar.shao@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230620163008.3718-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf501bf-d4f8-4a0b-48d5-08db72ab5036
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U1JrjiuK1Q4NKDzCKSDOENGsX4wFos6tHq1SYpKb+poCXjP6K2uSlzz9u4cGzyvyFVxu+ySotqwADNEjM1XxD9ZYmNt2wdsqkyGfykfXif9XGIj2eYLvKeJYtTdGBj9+UdEWN8XbatFdFgrbWcLJEIRSiAuPrPs8fVj2Yglxl7nlV65/Pf+WrP0TuinTRwpDejcI1y+Vfva06hvvBJk+QfdpdiA6hP00t/c9gdFNYezZi4U0yvykOiZ0sqXdkiVlDTR9CAuhNGnn3O4/mNCrl5/q2JxWzYN15MP0en6tI2ahGsma36kkqNXdLLkUvqkKw9Gg3md1YTIfgwNGCc8wwBEyJBtFccrUqipbUhzEcVFoxWLMOD5ST3Vma3maFRgWIXObaJZyCCoupRRtsJ8ZpG2I3roNLdvVvN0E1nTFHfKHdXspWKwp2jycTmk/ZTYPGWvE3IbhgjbWSI+ydHF3q5F7J72O34mJSEo3owoUiOPTPRo82qePfJM/YMllX5Zi2hV8wuGWYYfAKXzzkn74ocYjmUHRQkAtKDuIMkNT2dl6sYSKCOt5oWNV9q8yBYtRjexVpCFGWAj9fgUQVfEK38aGV5nc6PQ7WAE/kepN+FBts5a2p4IOSm4tGivSpZb1zgzIA4Po6J4MOIwV9DMGDKoLZuHKwAIE8ED5IGndh8s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(41300700001)(5660300002)(8676002)(8936002)(316002)(4326008)(7416002)(66476007)(66946007)(66556008)(2906002)(66899021)(2616005)(6506007)(186003)(6512007)(83380400001)(53546011)(36756003)(31686004)(31696002)(86362001)(921005)(38100700002)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bU45bHEwYi91Z0pnaThLN0gya2RVR2NqYXpRQ3RjdS91N2FrMjJtNHdxSkR0?=
 =?utf-8?B?N2V1bTdKRHdTM0JtL3I4cE9ObW03aVVXck1kUjhLTkhpSkhjaW5pUU54YVFM?=
 =?utf-8?B?clRvNlhFRFRBWGZmUktYbnluS2ZGRGRxdy81NVdYbGlNZ0VmZ1FLM0o4MWFW?=
 =?utf-8?B?Wld5RFIwaDZEWHp5MG5HcUZ4THp5b0JQdnYwR2tjWFRkMGw0SXRNUGN4dWVl?=
 =?utf-8?B?MzNSNDgxMHFVcWQyM29UdEZCUTc4dHhZcWNlemNUT0FNQmJMUnlXUndRZm5X?=
 =?utf-8?B?SS8wK3M1V3VkRkF4MXUvOWgvRHErbkZwVXhWajZNRk03L2NoTFE5QmtuMjBn?=
 =?utf-8?B?NGNlUEt5QmYyTVhQSktMMU9vK3BDNDhQZ1hTcjBGZDJ3YXZQNElrMlpRUy9Y?=
 =?utf-8?B?dkRXdnMybGIwNkhKTFNIbUROR3lvTm1kK090bFhPdHcwWStpbzBuOE5YcEdr?=
 =?utf-8?B?NHZ2M2RrcE8wbFpHOXhmZXJETHVOMU5tZE96TWd0TGxMRllpbXZidjkrdFZY?=
 =?utf-8?B?Z1J4cUQwZVVsbmZXVXRBMHZWUm1vQmNRSUJyaXZMNVJhUTArS3M3WEp2QVJQ?=
 =?utf-8?B?emRYeE5yVDdRbDB3NEUxSTJJUHg4MGhRUUkzUXZlMjRnaVpVcHprdFI3UlMr?=
 =?utf-8?B?S2VCVjdNQ2dPNzF1cmpWUjJlOGpPWGZkUDR4TmQ4UCtyeGRvQ1FoMXhycXBl?=
 =?utf-8?B?dEE5OE93bm5JRHFpVWp2VHl1UUVYUzA2RXk5TjEyYlhaNXhkR0dSVk5ncFFh?=
 =?utf-8?B?a1U4VjhLdXlzSmlHSWdBN2Jrb013TWt3OVM1M3lkTnc4YzUzUGFMVTZlbjRz?=
 =?utf-8?B?NzY1eVZGMXgrMW1aZWovNEV4KzRQY1FEOXVJeDVmYXhEVGlnNFpicmNTQ3hV?=
 =?utf-8?B?WEtyMCtwZ1RqaFVoOWZQR3ZzOU50dFl1Z1RUZEhyTjhvUUxCUDZvTDFJVUJM?=
 =?utf-8?B?eCtneC94WERZakY4UlNHUVRhR3Zuckt2VlFtd2NRNjIxeDVpMCt6S0tMdStJ?=
 =?utf-8?B?Q0U5ZFErNVlvVEtDTWY3cFZFZ0JBWjZTdDNFQU1RVFRtYkZyaGt5eTU4bmd3?=
 =?utf-8?B?TStoN3ZLQ2t5dlplVWltSVVQYUtrQXMwK29wWjZwWHNUUGVGRTN5MCtSR2tQ?=
 =?utf-8?B?dXdwZE1DaGtDYm9OUWRocld5aEZ6ZWRCcFF1VXo5OEtreWRFTVVPUnc0eXhk?=
 =?utf-8?B?TDdDN2w4Rnp2SnZpUVlpTUJ6UWdYOTEzMmV6Ujh5Rnc3K3dXUHFlbGd3Zm1T?=
 =?utf-8?B?b3VJS1A4Ym94Zjd0Q0hyejhPelZ1d2R1M2cycVdoMGU3cGtDS1VtZkhJUU05?=
 =?utf-8?B?MmFma1E1VzlubENuNGpGWnZLY2dORXRDNDF3eVpxaEk2enlkU0Fha0taMDNh?=
 =?utf-8?B?VmVNd3R0cmdTZCtHN05WTVpmL2ZydTJGUWZ3aXNjMlRmV2tMQmJwTjJFSHM5?=
 =?utf-8?B?eEZ6c1F0T1JJZHQ5SVN0bFNLVHJyR3JzVjBvTlM2azgzVFFTUGFnVE9pZEZh?=
 =?utf-8?B?cEl2QldLdzNMbHZkL2RwYzNmZzhoTEtMcUg1UlMwaXoxelZHc0ZHUWQrcUh5?=
 =?utf-8?B?R0NFQi9mb2xURmw4d3FPMzJmZEIzeGdNR1dEamdGYmdPa283V2JKMkJub2s3?=
 =?utf-8?B?dURmNVczU2lHc2FpTHl0TmJkeXhUS1ZjL3kwM0k2RXZsSUFvOEpZZVA3andv?=
 =?utf-8?B?SDFiZTdJa2VxU0sxTW9rcDFpWTBxak5kYzc3L1JTaWp1bHJ3WHVDWnlpM1Rr?=
 =?utf-8?B?NHp6RnFjNHF4SjRXYWRrZnNFMmlxU3VvMkxYTEJWUDQzUlJKYlUrQktRZ1pD?=
 =?utf-8?B?RGxTeWE4OVB0S0F6Z2ZKQkFPbGRwRU9iNEozZW5kYS93bkhNeEhMUEt5NGFn?=
 =?utf-8?B?V2s4SVFVaHF6RzhIUmlETjk0NE1PWlVZWk1rYStqeFF0K0kzUXh3TlZKdFdl?=
 =?utf-8?B?d1lhYmpONnE5TzVvT010NkxtOWQxZnh1Y3ZLbFlic094UVVST0E2VitZRjdI?=
 =?utf-8?B?a0UvVnQ3TkZ2YnhHbTNtZzN5YklVTk56WXNrU3FXOU82OTRqQ3RJSGZLREdr?=
 =?utf-8?B?M0pBeFZCSVJZRk94WlppT3B1MEg3Q01kS3ZPRFRtVHBIMGtJV0ZwYlRseG1J?=
 =?utf-8?B?R29iK2ZhUVZETTBwNTJtRnYxbEg5bWgvbEVvQnU3anIvbW1pV05QRnFvNWFO?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf501bf-d4f8-4a0b-48d5-08db72ab5036
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 23:00:31.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6LDyRqrVtwuzhc85VnQ18r1qY8cyMbeBdXFBRvYBaqHee6P4N5Am6S7EwWPGl5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3990
X-Proofpoint-GUID: 0hBmCWwHOnQUtaP6DDXTHN30XTtunJlO
X-Proofpoint-ORIG-GUID: 0hBmCWwHOnQUtaP6DDXTHN30XTtunJlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/20/23 9:30 AM, Yafang Shao wrote:
> By introducing support for ->fill_link_info to the perf_event link, users
> gain the ability to inspect it using `bpftool link show`. While the current
> approach involves accessing this information via `bpftool perf show`,
> consolidating link information for all link types in one place offers
> greater convenience. Additionally, this patch extends support to the
> generic perf event, which is not currently accommodated by
> `bpftool perf show`. While only the perf type and config are exposed to
> userspace, other attributes such as sample_period and sample_freq are
> ignored. It's important to note that if kptr_restrict is not permitted, the
> probed address will not be exposed, maintaining security measures.
> 
> A new enum bpf_perf_event_type is introduced to help the user understand
> which struct is relevant.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  36 +++++++++++++
>   kernel/bpf/syscall.c           | 115 +++++++++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  36 +++++++++++++
>   3 files changed, 187 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 23691ea..56528dd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
>   	MAX_BPF_LINK_TYPE,
>   };
>   
> +enum bpf_perf_event_type {
> +	BPF_PERF_EVENT_UNSPEC = 0,
> +	BPF_PERF_EVENT_UPROBE = 1,
> +	BPF_PERF_EVENT_KPROBE = 2,
> +	BPF_PERF_EVENT_TRACEPOINT = 3,
> +	BPF_PERF_EVENT_EVENT = 4,
> +
> +	MAX_BPF_PERF_EVENT_TYPE,
> +};
> +
>   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>    *
>    * NONE(default): No further bpf programs allowed in the subtree.
> @@ -6443,6 +6453,32 @@ struct bpf_link_info {
>   			__u32 count;
>   			__u32 flags;
>   		} kprobe_multi;
> +		struct {
> +			__u32 type; /* enum bpf_perf_event_type */

Maybe add the following
			__u32 :32;
so later on this field can be reused if another u32 is needed in
the future?

> +			union {
> +				struct {
> +					__aligned_u64 file_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from file_name */
> +					__u32 flags;
> +				} uprobe; /* BPF_PERF_EVENT_UPROBE */
> +				struct {
> +					__aligned_u64 func_name; /* in/out */
> +					__u32 name_len;
> +					__u32 offset;/* offset from func_name */
> +					__u64 addr;
> +					__u32 flags;
> +				} kprobe; /* BPF_PERF_EVENT_KPROBE */
> +				struct {
> +					__aligned_u64 tp_name;   /* in/out */
> +					__u32 name_len;
> +				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
> +				struct {
> +					__u64 config;
> +					__u32 type;
> +				} event; /* BPF_PERF_EVENT_EVENT */
> +			};
> +		} perf_event;
>   	};
>   } __attribute__((aligned(8)));
>   
[...]

