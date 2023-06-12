Return-Path: <bpf+bounces-2437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B072CD03
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF371C20B84
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEACF2109F;
	Mon, 12 Jun 2023 17:37:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152D1F189
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:37:39 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C35173C;
	Mon, 12 Jun 2023 10:37:11 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CGgbxr026482;
	Mon, 12 Jun 2023 10:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=8O4aYyddlkUTHaIhM0P9kCHiFDGGxtLV3BNlV3cVkWs=;
 b=mQRsKlVDqfuDvA3OLTy/RrM7SghpNze3BNPzCl4SMiwOpJZTsv3U3f4e/DiLqzGIReIx
 dwFfCh2Lhi3K34ueYe+KoA9IgIHvU8+ghV0kHTcExymiiySCICYZL4+Ry8P8+/UHuL4D
 sXPqnDH4FQYT+91kvapAqEC1CDqEbQAeLgHJ12VA6kU4jkaSyhsTueoS1+R/+qNeyiDz
 hp3jCaDOeYcBuplMRPTa4kkV/n4x9bVY0JEI9EPSrvqzqfkx3c8XleORMXYq4BrOpocr
 HiVb/ZI/fT3rT1JaMNYZjiorogLbKOk2yGmJdKswGFuWzQTqNFlskziHNBrE2z81c69l ww== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xc4kw0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jun 2023 10:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6ttZWU9CREoKXk+NOZbS4jF+LhCc1cKSC5NVTUyW/e6cMHgNVAzNm5dkaCUQHAPyVQwh/Ktx1R2oIPJCgTLYFxI83k06gzUtibFb9XQlc7P9HwviZhe8BqGKqp2CDVYpckDxzoEbg3iRU+xDdFCrSRdxoWJhE5fsVbscqGuswd21aJjsIfiOBDQuyBJtkdlGWWR2j8J44fK215wz1uj4XQyWEvJ55kOQK9JUM9X+Uf/8Ea83H7SbZOs3S3fjpjV59xNRdzer+hsFUJjsjcnrikp7tlPTcUz+DJIqZa7OKjdLcvfaCKijN5pOvtmJB+51gYggObs18/TEQVPoXafUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O4aYyddlkUTHaIhM0P9kCHiFDGGxtLV3BNlV3cVkWs=;
 b=YYzlSQp0mW9woVxXcZxHa7vH4ZcJ5QPKy7AwnxlpvpTEOFh1K4lNfcSOGryhkT9h5Mt+4dRFExbmEePtE7f7zkA6G9ESPGf2a0DIuuj9UiqmqKaywUekXHjxELKUbNgHPIbsDR+o4MkNif4i8EoL+WdUSgpKW0VNQnEGypmEiS+jtUn4WncPW6fSeaB4YYiQa8EA3vFH5O4SZAmfN+P2d4OVPWHPqJQb1zaP9Pe/0a7Kym6Qc8SpICvrVmFQcYX1eHQemOm5wc2gYW+fjbGVbnE4D0Y4T2CPc8gwHBN3uAitWmh91VAT6JqvNH7pIPGf9VZ5Ro/zpWnTFtvRz60YPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS7PR15MB5931.namprd15.prod.outlook.com (2603:10b6:8:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 17:36:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 17:36:49 +0000
Message-ID: <09da5bbd-1ef1-edd3-d83c-bba04b4f53da@meta.com>
Date: Mon, 12 Jun 2023 10:36:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for
 perf_event
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-9-laoar.shao@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230612151608.99661-9-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS7PR15MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: c76d0959-9340-40f1-9e8c-08db6b6b99e7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ECtLQf90hTkiDwH0BFssnP596GBYcsFbUWQaEWQ3AjObn5ulvshI4IuCTHIDU268Rd7A+8CyXBgbQuuAOJK5cdv+NcpmW7936CkJg3p9D0A6kkqX2vx3oHaNmC/IMRdZkbb79e0nQ9zBzeZRELTN1IUkrcDQBi+hYUQRWF5MlCJ7FEXgOqSqsQABuLsAiUpFaMk9yPRZUbPW2ydPHHypcY4L+9T/s6ZChqI1BgJqR1Breb3wmvG1qwrOxIqFMGSw3o00EKoCENmi3/58I/jSC7ErS36C3ipmjziVSMjXcYRUGe2xYFxjydw1HEV6I4boZi4GtJN6C1zCIe8aPXo2sjQgtEJsxIodIOsyZ6udAdrqS64DZb7dDwVxQqcgha2SnG1o2wb+4tYKI7pzzLH2EJqEXGVGCdmCAp75+uQoI83a2/Sl5s6dubjFcTPSRyVbBjTLXmQ1oRUdVgdlI3BHXG9tIffG1AtrQ/h1nUiGtj9+cSV47tYw9ZjGy2+257FuW9Sxx2QUGqbLIENANetWswKVecZZXSyolCVh47FNBYzUL2I6uvYqKSwnhptvIYCYNbCLegjSh9g6ovELr5ndQauylnxy7jtOCcbBgnQkbVB/PMhaR/u0CSjTv3A2HrPViyxlSbVJGpSTPgbRwLw5d5gXKbh3LUI5DVzXSTtPhU8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(316002)(41300700001)(6486002)(83380400001)(31696002)(86362001)(186003)(6512007)(7416002)(6506007)(2906002)(53546011)(2616005)(921005)(38100700002)(8936002)(5660300002)(8676002)(36756003)(31686004)(66946007)(66556008)(66476007)(478600001)(6666004)(66899021)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlJBQ1R1UXdrVXVVTHRpV0pVTFo4dWI1OTEvSE0wU0ZFS0pmWUJ3TVlSamVw?=
 =?utf-8?B?L2lFbE5rUVlCUXd1STBpR1dlZ2pyWFJnVHM0UkZwcUNMUHQ4SUZKYkkyVEM1?=
 =?utf-8?B?N0U4Ykhua0xXRHhtaG5kMjJaYXl3NWNSRUdRTThyR2NzQTdleUtJQngzSnJ1?=
 =?utf-8?B?bEhZVlFrVnpCaXNDQ0NaN3VmZHFTSnhkUmNQaU9HZi90WFVYMGR6THpRNi8v?=
 =?utf-8?B?Wjl4NHE3VllrUWtJdENCMVhsMHpCeDM5VkpZdnZsUGs4dmdvNEdDc1JGektj?=
 =?utf-8?B?K2Q4cXo0UW5WcDNyQk00ZGY1T1czSHE3c0VjU2dJQ1g4NVBzeUlSMTNwekV1?=
 =?utf-8?B?YWx5NkhNZmFXSHIzSHR5R3RoMXJjZCtnTjNReXNUdlVDS3ZpUGFPQklGdHN2?=
 =?utf-8?B?WEdmNUp4WUh3RUxla2NxRkdCWHNuT0tEUGlZK1dJM1RFbUVOdXhmZU96TDE2?=
 =?utf-8?B?RmU1OTdSZTgvMGhVcjYrQk1BQ2hDcUZ1cFZ1SDI4VjQ4UkM2M3dyTGVnSXNo?=
 =?utf-8?B?TForMUR0aXFGZWxoOGJCOTB3WHhBSTR1RFg1Y21ZU2hNMlpOK2RZajllbmIw?=
 =?utf-8?B?eUFXUnlMS3daSjRleWd1Z3lpaU9rbVFQcXJJdjZxWk9pV3NlRDhETTlpMCtD?=
 =?utf-8?B?MDVXUDZtTEtGTXR2YVhPOWdCZ2poMk1IMWIxYTd6WUdpNy9lNVg3bEo3OTh2?=
 =?utf-8?B?bFAySVIxWEVFS1BWdzNkUERqOGh4akMzSHFYd0tsVkdrR0JBbzVmTVY1OVBj?=
 =?utf-8?B?Z1M1OWp0UlNrZ2ZkVkpSR21yYWF2c0oyZlZQbEFRL0Y2cHJtVCtDRWF0bDJw?=
 =?utf-8?B?OTQ2UkRUSWpyQU5mM0c5N2hMd2hWYXhLbFpLZjZBWEpjLzZXMW9KTGh0eVNj?=
 =?utf-8?B?a0duRCs0d3RqVjJQSVM2cldUZDBPaGlhcDJjWXNzMnNOWXVpVU9FUk91a09E?=
 =?utf-8?B?WjJjUDBtSE1pa01MZTVnTGd3czJqbFRtMEtFOEVveHZ5RkE3MnFJcE9zcFZk?=
 =?utf-8?B?NVMwTkpOWTFJWmlYK0JZN3VvaW9kZkVsWUJqU0pjK3g5aVVkQU04V0lsNDB5?=
 =?utf-8?B?UzNpRlM5am5OMkxvSzYxcjhmbEE5a01vTmdueGIrZjFnaWNoU3VMR1hlSVpY?=
 =?utf-8?B?MXpmSmpmclA3WmxMQ016SnlCMGRmZ1VVTFlQSi9JNHFXTytFRytINW5UQ2RE?=
 =?utf-8?B?bHJPd0hMbFVocEpOSGNDWkN6K1E5aHpnOUtyRXpia0p3Q1Y1YnZCRHorWFlz?=
 =?utf-8?B?Y24yOWRHdnp6eFhPWVdLR3VNdU5XTjBDWXZjeENQRVhtb1hjTUduSFJZS2g1?=
 =?utf-8?B?UVIxbVNrMHZTTStlaCsxbnZsc0tWaDVuRTVXa0ZzSExZMGQ2QmNkL1dpS21O?=
 =?utf-8?B?clAvcUZMcU9aOFBUcGRhbWpVaUxlT3F6dmZrSG5XbVU2di9WSWtsNmdUeHU4?=
 =?utf-8?B?NUZXUWFkQnF1VmF6RFYyWmRuUWVEZVpIOXpnRzMycm84Ukw0Qk0wQS9ZVWtp?=
 =?utf-8?B?S3JzVjFBZTlFTktIU1B0VGNaYnZtWUUvdUoxWk50bFNsTXlJQUxKYlNwS0Yv?=
 =?utf-8?B?d3IwWE1WeWFnd2o1akNRNmp0eGFPMnB1b3VFdEMwc3BWcGxIU2RNM2NZUGxy?=
 =?utf-8?B?ckFFeFR1S3p3S2Z5QVQwY1A3M05EK0plZjRrOU43blg3NHp3ek5aOTBESlY2?=
 =?utf-8?B?eDd4UFlRTEQ5cENYSjVlUmZTQWF5Ym05Z0dEMWZ5S204dGJ1NWtCZU9SQm5h?=
 =?utf-8?B?UGZMRUxQVlFCbERJL3RIZFZ3d1dNWVI0cTN3QXFjbXN5dHBEM0tnbklITmt3?=
 =?utf-8?B?UUZCVmt0Qkptc2FtcCtUMTd2dHZnazF4YkRNUnNlelFwRU1rTU1mT1FUYytV?=
 =?utf-8?B?OGhBWlJFb3lPbUpLSHRxb3FNVEdZdDVlVFpNUW96R3F3VEc4TGtMdHpYSXVl?=
 =?utf-8?B?QWRsRHhsZzduNjNrT2FGRVJyaldFTFFxY0xMMDJUdWY2ek5Ta29peWgxREVH?=
 =?utf-8?B?Z0c2ZWIwT3lyTWRCZDg2d3dFaFpXaXJSTWVsTEtldVNnY3UrSzd2VHk5Uk1h?=
 =?utf-8?B?c1JUNE85ajI0ZjJqeEJTSDRFeGZOOS8yanhwYjNwMWx6OGFjczN5UDFPdDMv?=
 =?utf-8?B?NjJkZ013bG5DN3o1WFhEamljNlYrVlFBOHBKaEtHcGpITDFKY2NsWXVYdEZk?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d0959-9340-40f1-9e8c-08db6b6b99e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 17:36:49.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilqRUP63kKirj4G/LdFWLA33pZ4LjwMU2RwLd3XINV6ylGbZrewoCRkgdHQ2M0uH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5931
X-Proofpoint-GUID: 1hBcAWceYze78YMV9w3NfVPtAqOVh7wj
X-Proofpoint-ORIG-GUID: 1hBcAWceYze78YMV9w3NfVPtAqOVh7wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_12,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 8:16 AM, Yafang Shao wrote:
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
> A new enum bpf_link_perf_event_type is introduced to help the user
> understand which struct is relevant.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  32 +++++++++++
>   kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  32 +++++++++++
>   3 files changed, 188 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 23691ea..8d4556e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1056,6 +1056,16 @@ enum bpf_link_type {
>   	MAX_BPF_LINK_TYPE,
>   };
>   
> +enum bpf_perf_link_type {
> +	BPF_PERF_LINK_UNSPEC = 0,
> +	BPF_PERF_LINK_UPROBE = 1,
> +	BPF_PERF_LINK_KPROBE = 2,
> +	BPF_PERF_LINK_TRACEPOINT = 3,
> +	BPF_PERF_LINK_PERF_EVENT = 4,
> +
> +	MAX_BPF_LINK_PERF_EVENT_TYPE,
> +};
> +
>   /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>    *
>    * NONE(default): No further bpf programs allowed in the subtree.
> @@ -6443,7 +6453,29 @@ struct bpf_link_info {
>   			__u32 count;
>   			__u32 flags;
>   		} kprobe_multi;
> +		struct {
> +			__u64 config;
> +			__u32 type;
> +		} perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
> +		struct {
> +			__aligned_u64 file_name; /* in/out: buff ptr */
> +			__u32 name_len;
> +			__u32 offset;            /* offset from name */
> +			__u32 flags;
> +		} uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
> +		struct {
> +			__aligned_u64 func_name; /* in/out: buff ptr */
> +			__u32 name_len;
> +			__u32 offset;            /* offset from name */
> +			__u64 addr;
> +			__u32 flags;
> +		} kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
> +		struct {
> +			__aligned_u64 tp_name;   /* in/out: buff ptr */
> +			__u32 name_len;
> +		} tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
>   	};
> +	__u32 perf_link_type; /* enum bpf_perf_link_type */

I think put perf_link_type into each indivual struct is better.
It won't increase the bpf_link_info struct size. It will allow
extensions for all structs in the big union (raw_tracepoint,
tracing, cgroup, iter, ..., kprobe_multi, ...) etc.

>   } __attribute__((aligned(8)));
>   
>   /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
[...]

