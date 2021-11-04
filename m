Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011DD444E62
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 06:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhKDFef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 01:34:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58498 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhKDFef (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 01:34:35 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A42mJLa015416;
        Wed, 3 Nov 2021 22:31:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jq6Lu/Gc2JOiHQohR/tKBWZfbQw5NWzgErAnaI3r/TQ=;
 b=ok+Cy5PfiScjouAZkiTZ19zRSUBRZdIQ/fsbSDBHUDk7u9a3Go7cI3HbzY4M5yBGnbPZ
 1uq20/NjRxInm5TwdPGXSDsU1JI2KDmLhcF3MiNzkGd8vewogYPbbSQeLEP6zv9mce78
 AJmUUnnhuQbc6c1veWRVCQJgYErNbU44NQc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3vegdpxy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Nov 2021 22:31:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 22:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaTP7mWRLBmFkCjtJmlLCHwm/U7XBmrcZP9xcb2Q6Jz4sv9+cQb0SXCoihGjSfXa434ZGESYqn0NrI6yNvZFCnwWzE/GDf2vr4JahsFgkMDs5aYybFKgGyFKpkQ6tjUt2AqiNgx+IpxxXtMk40iw43JaJuvlowMEBKBD6sr8ZEOuh8hpaHMyoJTu01M1rXTJD3iw1WkMF+bOzWi67dCUJRtm0HbwgD45FIDVd7geNZ5fA7LoNkwk5B5OM974uc65dX5GwxmpeSKPA90XbnIhHKcTi/VIM8jIN43aERb9OHcvErzg4sHc4qKo3IMbDn5FHnOmeoGS0roX7TkEdvrpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq6Lu/Gc2JOiHQohR/tKBWZfbQw5NWzgErAnaI3r/TQ=;
 b=jMZgN8rygfEztuwpi4aQ+OGXdH3AQCDipU1iVfyGNlVjoFm4sFcS9nrhOz60AT2b1LarlFeTdpsfHBkMm7ZoRRWN/MhdjKLEg5MMIukOR7vN6YPaiKt1XdsLYu/t0k5cYrr4rtY8FjqVmprdI2/PYrs8alhxACuP3CgtwgH01NLKNQts8ct2eFXTLsckuHw8cN22XvromL8lu0sMH25SjOaxdsycpzx1g98YG1FZxQs1zLrLG8PyvgIHnXcw7DjQr5PFwRpQ2web980QUITB4Hdy75Ea2peDMt15VXeV64TTGDKMi+37MvOAiuqUKhUd/bRkmJQpEw3K5WMC5olyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2158.namprd15.prod.outlook.com (2603:10b6:805:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 05:31:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 05:31:22 +0000
Message-ID: <635d0557-a75d-0ad1-a33f-014b8cf240e5@fb.com>
Date:   Wed, 3 Nov 2021 22:31:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211104010745.1177032-1-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211104010745.1177032-1-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0038.namprd18.prod.outlook.com
 (2603:10b6:320:31::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1253] (2620:10d:c090:400::5:d1a6) by MWHPR18CA0038.namprd18.prod.outlook.com (2603:10b6:320:31::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 4 Nov 2021 05:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93f20c0b-a5f2-4a06-4dff-08d99f5455fa
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2158:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2158CE9E99E79F7EA9E2109AD38D9@SN6PR1501MB2158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqFKy7Nm79RTtEC9t/GrJKl6BxVbhc213ZigN3MWeiAsoSWolse3G2fIHU5Lz51G9/OUAYyoxODVSErLTTL7nn4g8QBhQh4r4Qi+szeT/DIwC6OeoqGCwQjuseaICBJa1IeSmaOTC9tCunjH/mfQatMZGBBokXkmZbvuc13C51t4d/aV9JGHR7tHagAcp9+IOU22/a4k8TMAMW8D6rlF1GEnscPO193gatBl8LylOLseangFdhDquonsYNanOKQBQPg8V1moGEaKGyISuq964WUuz2dTndg+TcFGXnRmz+iVjmxxm4PraTPcPKv7zpoJbzuF/h6H5s1bmGsBdvTiri7vuLlFZINEAIgqqNaVZ8FEL2alMpikO96QUjT//ImiZbD4P1mkTc6N0IIjHuKpbVo2kAPXEOQH7pZ3FnDWcpVk28sezWG45IfhgcMqwGxkjeiLh5XZHu9wdcId6VOvvsE0j5S6PLgXqrsA2utnkmO0nogg68bgPU4koVzYhnuGDfNRkv1hc3bNcjWfxa9KVwEbPn1r1j+LC6UYYKP+TeTMVvqtHEs5X7zm97ZzZch7Cs7pX80XVCUwtienSgqOuV/d7twJ3p8Fi/pzgObguHoZrqQAcXqBvBIUlulWXlPpI3T8QK8FkkRuc5Bcg0+0G1AmSyUTV4+Y05YBtBr0fFRxC00kYkjXhLJlGIwibgZrAZQ/dALyPwHCDkH5usCnIn+N54DnpUkmqj3KmS5bNA+DWfAKtEZnJ2j8asH+nGce
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(316002)(36756003)(83380400001)(921005)(31686004)(7416002)(8676002)(4326008)(2906002)(5660300002)(186003)(66946007)(38100700002)(66556008)(66476007)(2616005)(52116002)(508600001)(31696002)(6486002)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajgwKzI1VGpzVGJkckhoUllGWWZrUDFRSVNTenhpMjRyRTgzckp4U0NyNUx0?=
 =?utf-8?B?WTgwdXlDRGc4eGlWbTlVRTFYUGlXQ2RRd21xNitBSzA2d0U2UjMrZWsyRDVH?=
 =?utf-8?B?eER6VGx2cWFVWWZqczF2NFNUekpoZFlWdDhWYk5mWTBqbFhzNVFJby85NjhN?=
 =?utf-8?B?YUJJMVZ1ZW94ckhjdlc5YVVkell6WGZaeHlMRWh4QXRPcG1La1pzbG82UUtW?=
 =?utf-8?B?bzNKQjkrZGNWL3F1NTg0Qk1UL2hpMWRsaEU4czZmdXFtQXdzRU5EK3JMeGpP?=
 =?utf-8?B?bXBWMTVsbkpXNUx0c0dJTWJ0b1JTc3BOcDlSZWZ0REZqSStEMzhKSzV2TFlL?=
 =?utf-8?B?QU5WS1EzWnJmeklvWDUvZFcxdDl5bG1uMDFObmdlS29Gc0RCd0l2emNKMWFt?=
 =?utf-8?B?RUoxcjBlZmQ2K2lQK3o1VGRtYjB1M1U2dkRHbW54eUNTUS9ubU9IUUE1cWJH?=
 =?utf-8?B?OWlxV0pTQzlZa1kzNjBXTSt5dlVNY21zVWc5SWltZGdCZG9zU3ArZXZIZVBR?=
 =?utf-8?B?TXdHaXRHWE5RKzdWNUovUjQvemRpaG9MemRwQ0d5eFhrM1hkK0xzQmw5am1w?=
 =?utf-8?B?WUh4cEtrY3pSS055d2FSN0FQeVNlWjdHZng2S2ZNS2hxdGNRQVo0SUVhZHFZ?=
 =?utf-8?B?R0w0UjFRbXhHdHdXSmZLZlJhWEszOEozNEc2b25iSEJJUm9vTzhFZm1iY0lz?=
 =?utf-8?B?OHkvdzJTZDllMkw0MXpkMldEU0ZtVVlEQ044dkZWRHVoeU9qSmRLcVoyMnVh?=
 =?utf-8?B?WnFaVzRxbjJjOUZVc0Myekl1bURIUlBDTjhlb2FGcGV1dEFEam0vTklEcS9X?=
 =?utf-8?B?VkFEZ3NuV0JpaVN1RWlzSHVaa0hOT2xoUllUUlNUdW5WUkk4MllZUGI4OFFj?=
 =?utf-8?B?dWhmUGdFejJ2SGxJSHZQZUlzUSs4QStERXd4aGNOdzRrNE9STGdQM0ROMjdL?=
 =?utf-8?B?TDhLeEhETm1XUzBZbWltaENPYjRwVXRzMkxDVVlEYlVSVWE2V2lYT3VWT0tR?=
 =?utf-8?B?KzdMWldSQjhneEtVcDBZcytBcUZScFkyTm9QT1VyajRKN2cxcDVRQ0RlYTdC?=
 =?utf-8?B?Zk9WQlhDbklOZmpRSUdiQmxkWHNWM0RzRlpXK0MyS3hFSlJFeVJZa2c2MXQz?=
 =?utf-8?B?clIyTEpPUHN2bW55VDF4dTYzYTRsRHFlZEJjdURWQ3RKMU5TRitTTTBDYW00?=
 =?utf-8?B?SlNZQlhVa2M4R1dLUGxmK1ROVGtsWFVoRzl4SDVNMm8yNGkzQXlsaGYrbmY3?=
 =?utf-8?B?eVQxb28ybi9UMFJFbVB2dnltQmtsNUZNUEMrNlk4blFoQW03KzBKZHVQSXNz?=
 =?utf-8?B?L1gwMytGS1VyRmRaSmtLcDczbFhsRHkzTVFLMDNDTW1YeUxuMWMrd2VpZUFR?=
 =?utf-8?B?dUNveFlXUSs1blVZUkxHQkMyaWJiblpESm1aMHc5R29Db2phd3kxeWNhUVM1?=
 =?utf-8?B?cGRFWjhjS2k4UDlFVFQzWE8weU5mNDd1WCtGT3g3Slh1Q3p1V05NWGt5bWh3?=
 =?utf-8?B?OTMyeHdKUTVOWXhsbUQwa2hQSm5TeEhIYnkvdGJrak1rNmk5VEJVbVFDMXQy?=
 =?utf-8?B?dU0ydmY3bXplUEo4a2JnYzlBWkF5cEsvSGg5cTFubDUxWlFybHVYYXNNMVBL?=
 =?utf-8?B?elA2bnVQVXR5bzd5YjV6RndMaGtRbG8xQ2l0eEZESEhES2lIY2VEN0pMRmFF?=
 =?utf-8?B?T0RvcWhmSGdoOW5YT3gxUjVBRjhOcVpEeVN1S2RyanJOcVJXcmZ4QnRFcCtn?=
 =?utf-8?B?VnpZeU1mV1lXZndlVjA1RFl0d3paMUoza1JSL2FIaEs4TFdZNjl4clVNeTgv?=
 =?utf-8?B?bVlQZUxPY1ExcUxKekNpN1BzU1B3TEIxdHg2czZlN2hnS1NWQXpkcVhIbzFj?=
 =?utf-8?B?eWt0R0V3UXBTM3pUbHpjekVkL29jWVRWaVd0bzA4SEZNT3lvcVRYeEJ1VFcy?=
 =?utf-8?B?aXNCMW5ERkE4ak1GSUFwemxMMkdBU2NvY05XVmpHcFI5djM0UjM4Z3VwRllN?=
 =?utf-8?B?WndVSGY2aFZ1dmk3QjBXaTlldEZmbzcwMXhZZ3JLc2xWazFkVWZSZHEyUHR6?=
 =?utf-8?B?OExyNzZzd2FjNXNXenJab085ZE1HM2JMeTNBWGwzUi96MGVyckxWNTNPVUVJ?=
 =?utf-8?B?TlZicEZ2ZEEwMmpvV3hDRDY2WVBpSEloZnJna3V1R3A1MCtWaVYveGNtem9v?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f20c0b-a5f2-4a06-4dff-08d99f5455fa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 05:31:21.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5v0DwjPRzhqHHi/TzxkXvJheeA6sxZ8nWdzQ/0Qkgji9OO/ZGHazL0a9Dpmujfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2158
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: kryJPBLFiDpLrfLF_kjA43jLenVLZRd5
X-Proofpoint-ORIG-GUID: kryJPBLFiDpLrfLF_kjA43jLenVLZRd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/21 6:07 PM, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
> 
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
> /* v2 */
> - John Fastabend <john.fastabend@gmail.com>
>    - add selftest code
> 
> /* v3 */
>   - avoid sleeping caused by copy_to_user() in rcu critical zone
> 
> /* v4 */
>   - Alexei Starovoitov <alexei.starovoitov@gmail.com>
>    -split into two patches, one for core code and one for selftest.
> 
> /* v5 */
>   - Yonghong Song <yhs@fb.com>
>    -Some naming and formatting changes
> ---
>   include/linux/bpf.h  |  9 ++++++
>   kernel/bpf/syscall.c |  5 +++
>   net/core/sock_map.c  | 74 +++++++++++++++++++++++++++++++++++++++-----
>   3 files changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d604c8251d88..235ea7fc5fd8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>   int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
>   int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
>   int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +			    union bpf_attr __user *uattr);
> +
>   void sock_map_unhash(struct sock *sk);
>   void sock_map_close(struct sock *sk, long timeout);
>   #else
> @@ -2014,6 +2017,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +					  union bpf_attr __user *uattr)
> +{
> +	return -EINVAL;
> +}
>   #endif /* CONFIG_BPF_SYSCALL */
>   #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>   
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4e50c0bfdb7d..748102c3e0c9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
>   	case BPF_FLOW_DISSECTOR:
>   	case BPF_SK_LOOKUP:
>   		return netns_bpf_prog_query(attr, uattr);
> +	case BPF_SK_SKB_STREAM_PARSER:
> +	case BPF_SK_SKB_STREAM_VERDICT:
> +	case BPF_SK_MSG_VERDICT:
> +	case BPF_SK_SKB_VERDICT:
> +		return sock_map_bpf_prog_query(attr, uattr);
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index e252b8ec2b85..0320d27550fe 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1412,38 +1412,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>   	return NULL;
>   }
>   
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -				struct bpf_prog *old, u32 which)
> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
> +				u32 which)
>   {
>   	struct sk_psock_progs *progs = sock_map_progs(map);
> -	struct bpf_prog **pprog;
>   
>   	if (!progs)
>   		return -EOPNOTSUPP;
>   
>   	switch (which) {
>   	case BPF_SK_MSG_VERDICT:
> -		pprog = &progs->msg_parser;
> +		*pprog = &progs->msg_parser;
>   		break;
>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>   	case BPF_SK_SKB_STREAM_PARSER:
> -		pprog = &progs->stream_parser;
> +		*pprog = &progs->stream_parser;
>   		break;
>   #endif
>   	case BPF_SK_SKB_STREAM_VERDICT:
>   		if (progs->skb_verdict)
>   			return -EBUSY;
> -		pprog = &progs->stream_verdict;
> +		*pprog = &progs->stream_verdict;
>   		break;
>   	case BPF_SK_SKB_VERDICT:
>   		if (progs->stream_verdict)
>   			return -EBUSY;
> -		pprog = &progs->skb_verdict;
> +		*pprog = &progs->skb_verdict;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
>   
> +	return 0;
> +}
> +
> +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> +				struct bpf_prog *old, u32 which)
> +{
> +	struct bpf_prog **pprog;
> +	int ret;
> +
> +	ret = sock_map_prog_lookup(map, &pprog, which);
> +	if (ret)
> +		return ret;
> +
>   	if (old)
>   		return psock_replace_prog(pprog, prog, old);
>   
> @@ -1451,6 +1463,54 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>   	return 0;
>   }
>   
> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +			    union bpf_attr __user *uattr)
> +{
> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> +	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> +	struct bpf_prog **pprog;
> +	struct bpf_prog *prog;
> +	struct bpf_map *map;
> +	struct fd f;
> +	u32 id = 0;

There is no need to initialize 'id = 0'. id will be assigned later.

> +	int ret;
> +
> +	if (attr->query.query_flags)
> +		return -EINVAL;
> +
> +	f = fdget(ufd);
> +	map = __bpf_map_get(f);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	rcu_read_lock();
> +
> +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> +	if (ret)
> +		goto end;
> +
> +	prog = *pprog;
> +	prog_cnt = (!prog) ? 0 : 1;

(!prog) => !prog ?

> +
> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +		goto end;
> +
> +	id = prog->aux->id;
> +	if (id == 0)
> +		prog_cnt = 0;


id will never be 0, see function bpf_prog_alloc_id() is syscall.c.
So 'if (id == 0)' check is not needed.

> +
> +end:
> +	rcu_read_unlock();
> +
> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> +	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
> +	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
> +		ret = -EFAULT;
> +
> +	fdput(f);
> +	return ret;
> +}
> +
>   static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
>   {
>   	switch (link->map->map_type) {
> 
